Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A751B606A324
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 12:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Ow+t051+
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM39e-0001Ct-Tf; Wed, 28 Oct 2026 08:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1xM39c-0001B2-Q5
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:20 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1xM39a-0003LE-T9
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 08:53:20 -0400
Received: from DESKTOP-TUU1E5L.fritz.box (p3e9c09f4.dip0.t-ipconnect.de
 [62.156.9.244])
 by linux.microsoft.com (Postfix) with ESMTPSA id 43B3520B7167;
 Wed, 28 Oct 2026 05:53:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 43B3520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1793191985;
 bh=rd9gswxwnBAs0JOrlNb83sBtN0BQsFy29vi+l+Usd08=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Ow+t051+naD6wd4acZXMjYGgx1JAXVE7ZyJip76LdKkv3Rc7k4UWkFNhhf3nD9zx5
 0MpkG+xUxTHCXwrrZdwX/piIclC0fdYxFCl17uUASdVR4zuvaGIA64w2AHuaTzrPjB
 quGlOJUHvuCFQJsh1UdevSICrwGYzCMfqu8etj6U=
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 =?UTF-8?q?Doru=20Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Wei Liu <liuwe@microsoft.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/4] target/i386/mshv: fix vCPU run result contract
Date: Wed, 28 Oct 2026 13:53:05 +0100
Message-Id: <20261028125308.147630-2-magnuskulke@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
References: <20261028125308.147630-1-magnuskulke@linux.microsoft.com>
X-Archived-By: <archiver.kernel.org>
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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


