Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5B48CAC599
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 16:51:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uyYtj-0002xE-QE; Tue, 16 Sep 2025 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uyYtK-0002Bw-9V
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:57 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uyYtG-0006qF-CF
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 12:50:53 -0400
Received: from localhost.localdomain (unknown [167.220.208.43])
 by linux.microsoft.com (Postfix) with ESMTPSA id 8C8D0201551B;
 Tue, 16 Sep 2025 09:50:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C8D0201551B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1758041448;
 bh=ki76MW4dVuJUE+a9UcyLBsbo2CBRhMu99AqINiBRaD4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=dp6pqMr5sXWNRgiZlgI4V4FV6mhGgFSCwkmS6o80Mt8flRwIqIAocLmLHKMoBWcnO
 wu3DUP7FxXUqbpx8tgw5tD67Tg93Kwz305OZe63rDoWp1RHXkPWYvjai5Gvne+Cpwi
 JLsCKePLV5SVRC9Dbd8nqFr1/NRKRIOeaFAslD1g=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Wei Liu <liuwe@microsoft.com>, Cornelia Huck <cohuck@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Eric Blake <eblake@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v4 17/27] target/i386/mshv: Set local interrupt controller
 state
Date: Tue, 16 Sep 2025 18:48:37 +0200
Message-Id: <20250916164847.77883-18-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
References: <20250916164847.77883-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

To set the local interrupt controller state, perform hv calls retrieving
partition state from the hypervisor.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 117 ++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 98715621ba..daa41b92c9 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -12,6 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/memalign.h"
 #include "qemu/typedefs.h"
 
 #include "system/mshv.h"
@@ -20,6 +21,7 @@
 #include "hw/hyperv/hvgdk.h"
 #include "hw/hyperv/hvgdk_mini.h"
 #include "hw/hyperv/hvhdk_mini.h"
+#include "hw/i386/apic_internal.h"
 
 #include "cpu.h"
 #include "emulate/x86_decode.h"
@@ -561,6 +563,114 @@ static int set_cpu_state(const CPUState *cpu, const MshvFPU *fpu_regs,
     return 0;
 }
 
+static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to get partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int get_lapic(int cpu_fd,
+                     struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = get_vp_state(cpu_fd, &mshv_state);
+    if (ret == 0) {
+        memcpy(state, buffer, sizeof(*state));
+    }
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to get lapic");
+        return -1;
+    }
+
+    return 0;
+}
+
+static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
+{
+    return ((reg) & ~0x700) | ((mode) << 8);
+}
+
+static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
+{
+    int ret;
+
+    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
+    if (ret < 0) {
+        error_report("failed to set partition state: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_lapic(int cpu_fd,
+                     const struct hv_local_interrupt_controller_state *state)
+{
+    int ret;
+    size_t size = 4096;
+    /* buffer aligned to 4k, as *state requires that */
+    void *buffer = qemu_memalign(size, size);
+    struct mshv_get_set_vp_state mshv_state = { 0 };
+
+    if (!state) {
+        error_report("lapic state is NULL");
+        return -1;
+    }
+    memcpy(buffer, state, sizeof(*state));
+
+    mshv_state.buf_ptr = (uint64_t) buffer;
+    mshv_state.buf_sz = size;
+    mshv_state.type = MSHV_VP_STATE_LAPIC;
+
+    ret = set_vp_state(cpu_fd, &mshv_state);
+    qemu_vfree(buffer);
+    if (ret < 0) {
+        error_report("failed to set lapic: %s", strerror(errno));
+        return -1;
+    }
+
+    return 0;
+}
+
+static int set_lint(int cpu_fd)
+{
+    int ret;
+    uint32_t *lvt_lint0, *lvt_lint1;
+
+    struct hv_local_interrupt_controller_state lapic_state = { 0 };
+    ret = get_lapic(cpu_fd, &lapic_state);
+    if (ret < 0) {
+        return ret;
+    }
+
+    lvt_lint0 = &lapic_state.apic_lvt_lint0;
+    *lvt_lint0 = set_apic_delivery_mode(*lvt_lint0, APIC_DM_EXTINT);
+
+    lvt_lint1 = &lapic_state.apic_lvt_lint1;
+    *lvt_lint1 = set_apic_delivery_mode(*lvt_lint1, APIC_DM_NMI);
+
+    /* TODO: should we skip setting lapic if the values are the same? */
+
+    return set_lapic(cpu_fd, &lapic_state);
+}
+
 /*
  * TODO: populate topology info:
  *
@@ -572,6 +682,7 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
                         uint64_t xcr0)
 {
     int ret;
+    int cpu_fd = mshv_vcpufd(cpu);
 
     ret = set_cpu_state(cpu, fpu, xcr0);
     if (ret < 0) {
@@ -579,6 +690,12 @@ int mshv_configure_vcpu(const CPUState *cpu, const struct MshvFPU *fpu,
         return -1;
     }
 
+    ret = set_lint(cpu_fd);
+    if (ret < 0) {
+        error_report("failed to set lpic int");
+        return -1;
+    }
+
     return 0;
 }
 
-- 
2.34.1


