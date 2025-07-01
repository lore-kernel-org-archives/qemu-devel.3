Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A11C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:30:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeoM-00052u-Bs; Tue, 01 Jul 2025 13:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1uWenx-0004OF-IG
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:07 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1uWenv-0006xf-Rs
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:30:01 -0400
Received: from localhost.localdomain (unknown [167.220.208.67])
 by linux.microsoft.com (Postfix) with ESMTPSA id 63C2D2112238;
 Tue,  1 Jul 2025 10:29:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 63C2D2112238
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1751390998;
 bh=Nt4UBWXes3AxB90SryE8zirrNwQ3P5gh+k2XSafdH4c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jE4X1C5OZB2A60Iyva1AwZaDd2FnsRZvqOs53OEToOEv/3nbat3dbeZRXxigxURLJ
 jP4nv/baG82dEqCwxYz61UwbCOTQg8vZPWxozCQ8k0BMC6194pspwSH1iQd0/kbvMy
 v85xI/StrYGtT/4JR7A28SUnCYzVCfsxIlq+g3WQ=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Cameron Esfahani <dirty@apple.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <rbolshakov@ddn.com>, Thomas Huth <thuth@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Wei Liu <wei.liu@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Wei Liu <liuwe@microsoft.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH v2 14/27] target/i386/mshv: Add CPU create and remove logic
Date: Tue,  1 Jul 2025 19:28:21 +0200
Message-Id: <20250701172834.44849-15-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
References: <20250701172834.44849-1-magnuskulke@linux.microsoft.com>
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

Implement MSHV-specific hooks for vCPU creation and teardown in the
i386 target.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 2fe5319201..7a6965d7fb 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -28,6 +28,8 @@
 #include "trace-accel_mshv.h"
 #include "trace.h"
 
+#include <sys/ioctl.h>
+
 int mshv_store_regs(CPUState *cpu)
 {
     error_report("unimplemented");
@@ -60,20 +62,29 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
 void mshv_remove_vcpu(int vm_fd, int cpu_fd)
 {
-    error_report("unimplemented");
-    abort();
+    close(cpu_fd);
 }
 
+
 int mshv_create_vcpu(int vm_fd, uint8_t vp_index, int *cpu_fd)
 {
-    error_report("unimplemented");
-    abort();
+    int ret;
+    struct mshv_create_vp vp_arg = {
+        .vp_index = vp_index,
+    };
+    ret = ioctl(vm_fd, MSHV_CREATE_VP, &vp_arg);
+    if (ret < 0) {
+        error_report("failed to create mshv vcpu: %s", strerror(errno));
+        return -1;
+    }
+
+    *cpu_fd = ret;
+
+    return 0;
 }
 
 void mshv_init_cpu_logic(void)
 {
-    error_report("unimplemented");
-    abort();
 }
 
 void mshv_arch_init_vcpu(CPUState *cpu)
-- 
2.34.1


