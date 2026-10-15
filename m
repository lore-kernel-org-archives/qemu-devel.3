Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 261A0CC6B34
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 12:19:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHKQg-00021c-WE; Thu, 15 Oct 2026 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xHKQa-00020a-LB
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:19:22 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xHKQY-0004u6-PY
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 08:19:20 -0400
Received: from DESKTOP-TUU1E5L.localdomain (unknown [167.220.208.79])
 by linux.microsoft.com (Postfix) with ESMTPSA id 603E120B7166;
 Thu, 15 Oct 2026 05:19:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 603E120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1792066751;
 bh=rd9gswxwnBAs0JOrlNb83sBtN0BQsFy29vi+l+Usd08=;
 h=From:To:Cc:Subject:Date:From;
 b=RU3AGWB/nzp2IWCJnaGTWUGC22o2oxnzNOuzeztNrgsNpRXJyFBy4sVGxf8ggwrdL
 uDYRAfcE90lV+f8lewQh7Z0DpLYEesCcqHAZvYPnBd6oepurtz+iaRTAqiOTm8sG1W
 xm1+90ylYNusarRKHFOtZ4HovvvJGlasu64Gv8Tc=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>
Subject: [PATCH] target/i386/mshv: fix vCPU run result contract
Date: Thu, 15 Oct 2026 14:19:11 +0200
Message-Id: <20261015121911.279817-1-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Currently the return semantics of mshv_run_vcpu() are broken. They
return a mix of int and exit_reason, ignoring the out param *exit.

This change propagates errno's to the call site and sets the *exit value
accordingly. We also consider the case when an ioctl has return due to a
qemu-requested interruption of the call, this is a legitimate condition
that should not produce an error.

Fixes: 6dec60528c4 (target/i386/mshv: Implement mshv_vcpu_run())
Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
---
 target/i386/mshv/mshv-cpu.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/i386/mshv/mshv-cpu.c b/target/i386/mshv/mshv-cpu.c
index 4df73bb497..e3c155da2e 100644
--- a/target/i386/mshv/mshv-cpu.c
+++ b/target/i386/mshv/mshv-cpu.c
@@ -2124,7 +2124,6 @@ static int arch_set_single_step(CPUState *cpu, bool enable)
 int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 {
     int ret;
-    enum MshvVmExit exit_reason;
     int cpu_fd = mshv_vcpufd(cpu);
     bool single_step;
 
@@ -2142,7 +2141,12 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
     ret = ioctl(cpu_fd, MSHV_RUN_VP, msg);
     if (ret < 0) {
-        return MshvVmExitShutdown;
+        if (errno == EINTR) {
+            *exit = MshvVmExitSpecial;
+            return 0;
+        }
+        error_report("failed to run vCPU: %s", strerror(errno));
+        return -errno;
     }
 
     /* disable single stepping by flipping RFLAGS.TF */
@@ -2154,31 +2158,33 @@ int mshv_run_vcpu(int vm_fd, CPUState *cpu, hv_message *msg, MshvVmExit *exit)
 
     switch (msg->header.message_type) {
     case HVMSG_UNRECOVERABLE_EXCEPTION:
-        return MshvVmExitShutdown;
+        *exit = MshvVmExitShutdown;
+        return 0;
     case HVMSG_UNMAPPED_GPA:
     case HVMSG_GPA_INTERCEPT:
-        ret = handle_mmio(cpu, msg, &exit_reason);
+        ret = handle_mmio(cpu, msg, exit);
         if (ret < 0) {
             error_report("failed to handle mmio");
-            return -1;
+            return ret;
         }
-        return exit_reason;
+        return 0;
     case HVMSG_X64_IO_PORT_INTERCEPT:
         ret = handle_pio(cpu, msg);
         if (ret < 0) {
-            return MshvVmExitSpecial;
+            error_report("failed to handle PIO");
+            return ret;
         }
-        return MshvVmExitIgnore;
+        *exit = MshvVmExitIgnore;
+        return 0;
     case HVMSG_X64_EXCEPTION_INTERCEPT:
         bql_lock();
-        ret = handle_exception_interrupt(cpu, msg, &exit_reason);
+        ret = handle_exception_interrupt(cpu, msg, exit);
         bql_unlock();
         if (ret < 0) {
             error_report("failed to handle exception intercept");
             return -1;
         }
-        *exit = exit_reason;
-        return exit_reason;
+        return 0;
     default:
         break;
     }
-- 
2.34.1


