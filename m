Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 273ABF4368F
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 10:59:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDgtI-0001j1-Vk; Fri, 17 Apr 2026 06:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wDgtA-0001MC-5t
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:57:32 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wDgt8-0001bW-GP
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 06:57:31 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p5086d620.dip0.t-ipconnect.de
 [80.134.214.32])
 by linux.microsoft.com (Postfix) with ESMTPSA id 9A93520B7128;
 Fri, 17 Apr 2026 03:57:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A93520B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1776423439;
 bh=4/dGjUSqCuffa4776aRoVC+jjvuxIlehRsFhT8amsVo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZxqR/aTjwlgbpwdxaY5Nt0HyvpuzI3Z8Xqr9QpvFZ83qguRiiPmDWyjUfZTKdeM7+
 QyQS7f1lC/42te9qLjh9hEn5BhHh8lbsdoGPvdipzQPPiqXCaBmBNgNoLnwA3DAxSj
 ZhRt92S+VD8II9aB3vAFVkKYicWuZjxPNZq34aDI=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: kvm@vger.kernel.org, Magnus Kulke <magnuskulke@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: [PATCH 15/34] target/i386/mshv: remove redundant apic helpers
Date: Fri, 17 Apr 2026 12:55:59 +0200
Message-Id: <20260417105618.3621-16-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
References: <20260417105618.3621-1-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This change remove the now redundant apic helpers in mshv-cpu.c

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 88 ++-----------------------------------
 1 file changed, 3 insertions(+), 85 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 56656ac0b0..12343acb01 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -919,101 +919,19 @@ static int set_xc_reg(const CPUState *cpu)
     return 0;
 }
 
-static int get_vp_state(int cpu_fd, struct mshv_get_set_vp_state *state)
-{
-    int ret;
-
-    ret = ioctl(cpu_fd, MSHV_GET_VP_STATE, state);
-    if (ret < 0) {
-        error_report("failed to get partition state: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int get_lapic(const CPUState *cpu,
-                     struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = get_vp_state(cpu_fd, &mshv_state);
-    if (ret == 0) {
-        memcpy(state, buffer, sizeof(*state));
-    }
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to get lapic");
-        return -1;
-    }
-
-    return 0;
-}
-
 static uint32_t set_apic_delivery_mode(uint32_t reg, uint32_t mode)
 {
     return ((reg) & ~0x700) | ((mode) << 8);
 }
 
-static int set_vp_state(int cpu_fd, const struct mshv_get_set_vp_state *state)
-{
-    int ret;
-
-    ret = ioctl(cpu_fd, MSHV_SET_VP_STATE, state);
-    if (ret < 0) {
-        error_report("failed to set partition state: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
-static int set_lapic(const CPUState *cpu,
-                     const struct hv_local_interrupt_controller_state *state)
-{
-    int ret;
-    size_t size = 4096;
-    /* buffer aligned to 4k, as *state requires that */
-    void *buffer = qemu_memalign(size, size);
-    struct mshv_get_set_vp_state mshv_state = { 0 };
-    int cpu_fd = mshv_vcpufd(cpu);
-
-    if (!state) {
-        error_report("lapic state is NULL");
-        return -1;
-    }
-    memcpy(buffer, state, sizeof(*state));
-
-    mshv_state.buf_ptr = (uint64_t) buffer;
-    mshv_state.buf_sz = size;
-    mshv_state.type = MSHV_VP_STATE_LAPIC;
-
-    ret = set_vp_state(cpu_fd, &mshv_state);
-    qemu_vfree(buffer);
-    if (ret < 0) {
-        error_report("failed to set lapic: %s", strerror(errno));
-        return -1;
-    }
-
-    return 0;
-}
-
 static int init_lint(const CPUState *cpu)
 {
     int ret;
     uint32_t *lvt_lint0, *lvt_lint1;
+    int cpu_fd = mshv_vcpufd(cpu);
 
     struct hv_local_interrupt_controller_state lapic_state = { 0 };
-    ret = get_lapic(cpu, &lapic_state);
+    ret = mshv_get_lapic(cpu_fd, &lapic_state);
     if (ret < 0) {
         return ret;
     }
@@ -1026,7 +944,7 @@ static int init_lint(const CPUState *cpu)
 
     /* TODO: should we skip setting lapic if the values are the same? */
 
-    return set_lapic(cpu, &lapic_state);
+    return mshv_set_lapic(cpu_fd, &lapic_state);
 }
 
 int mshv_arch_store_vcpu_state(const CPUState *cpu)
-- 
2.34.1


