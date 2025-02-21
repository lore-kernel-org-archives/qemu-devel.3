Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF0FC021B3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 14:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlTbN-00008P-FP; Fri, 21 Feb 2025 09:02:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liuwe@linux.microsoft.com>)
 id 1tlOWf-0006Pv-CK
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:49 -0500
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liuwe@linux.microsoft.com>) id 1tlOWc-00014w-VE
 for qemu-devel@nongnu.org; Fri, 21 Feb 2025 03:36:49 -0500
Received: by linux.microsoft.com (Postfix, from userid 1031)
 id 54EE3204E5B5; Fri, 21 Feb 2025 00:36:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54EE3204E5B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1740126989;
 bh=pUwZ/dSr5gGrdQZ84seWR6a6C8sHhqS7bmH4ZAYmDHU=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=BqqD964wwMtTwbsqgUH7HpiUp6NzgWd+UawlSLcbTMHy5jW1GRKkHH6+yXZK+SGx4
 F9uhe0AUKOkQmMaOJNDaDngmtN+DoUGcpGLysE6136RkLFd4Ngu/iJBkB2BwPXL6nV
 czUtWPWjUySH1bSWW7kHOW/+53hZC7cKTth1ZDx8=
From: Wei Liu <liuwe@linux.microsoft.com>
To: qemu-devel@nongnu.org
Cc: wei.liu@kernel.org, dirty@apple.com, rbolshakov@ddn.com,
 phil@philjordan.eu, jinankjain@linux.microsoft.com, liuwe@microsoft.com,
 muislam@microsoft.com, ziqiaozhou@microsoft.com,
 mukeshrathor@microsoft.com, magnuskulke@microsoft.com,
 prapal@microsoft.com, jpiotrowski@microsoft.com, deviv@microsoft.com,
 Wei Liu <liuwe@linux.microsoft.com>
Subject: [RFC PATCH v1 02/19] target/i386/hvf: fix the declaration of
 hvf_handle_io
Date: Fri, 21 Feb 2025 00:36:10 -0800
Message-Id: <1740126987-8483-3-git-send-email-liuwe@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
References: <1740126987-8483-1-git-send-email-liuwe@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=liuwe@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 21 Feb 2025 09:00:51 -0500
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

There is a conflicting declaration for hvf_handle_io in x86_emu.c.  The type of
the first argument is wrong.  There has never been a problem because the first
argument is not used in hvf_handle_io.

That being said, the code shouldn't contain such an error. Use the proper
declaration from hvf-i386.h.

Take the chance to change the first argument's type to be CPUState.

Signed-off-by: Wei Liu <liuwe@linux.microsoft.com>
---
 target/i386/hvf/hvf-i386.h | 2 +-
 target/i386/hvf/hvf.c      | 6 +++---
 target/i386/hvf/x86_emu.c  | 4 +---
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/hvf/hvf-i386.h b/target/i386/hvf/hvf-i386.h
index e99c02cd4b..046b681d13 100644
--- a/target/i386/hvf/hvf-i386.h
+++ b/target/i386/hvf/hvf-i386.h
@@ -18,7 +18,7 @@
 
 uint32_t hvf_get_supported_cpuid(uint32_t func, uint32_t idx, int reg);
 
-void hvf_handle_io(CPUArchState *, uint16_t, void *, int, int, int);
+void hvf_handle_io(CPUState *, uint16_t, void *, int, int, int);
 
 /* Host specific functions */
 int hvf_inject_interrupt(CPUArchState *env, int vector);
diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 353549fa77..1ecb6993ba 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -103,7 +103,7 @@ static void update_apic_tpr(CPUState *cpu)
 
 #define VECTORING_INFO_VECTOR_MASK     0xff
 
-void hvf_handle_io(CPUArchState *env, uint16_t port, void *buffer,
+void hvf_handle_io(CPUState *env, uint16_t port, void *buffer,
                   int direction, int size, int count)
 {
     int i;
@@ -536,7 +536,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             if (!string && in) {
                 uint64_t val = 0;
                 load_regs(cpu);
-                hvf_handle_io(env, port, &val, 0, size, 1);
+                hvf_handle_io(env_cpu(env), port, &val, 0, size, 1);
                 if (size == 1) {
                     AL(env) = val;
                 } else if (size == 2) {
@@ -551,7 +551,7 @@ int hvf_vcpu_exec(CPUState *cpu)
                 break;
             } else if (!string && !in) {
                 RAX(env) = rreg(cpu->accel->fd, HV_X86_RAX);
-                hvf_handle_io(env, port, &RAX(env), 1, size, 1);
+                hvf_handle_io(env_cpu(env), port, &RAX(env), 1, size, 1);
                 macvm_set_rip(cpu, rip + ins_len);
                 break;
             }
diff --git a/target/i386/hvf/x86_emu.c b/target/i386/hvf/x86_emu.c
index 69c61c9c07..2c7da10c1d 100644
--- a/target/i386/hvf/x86_emu.c
+++ b/target/i386/hvf/x86_emu.c
@@ -44,9 +44,7 @@
 #include "x86_flags.h"
 #include "vmcs.h"
 #include "vmx.h"
-
-void hvf_handle_io(CPUState *cs, uint16_t port, void *data,
-                   int direction, int size, uint32_t count);
+#include "hvf-i386.h"
 
 #define EXEC_2OP_FLAGS_CMD(env, decode, cmd, FLAGS_FUNC, save_res) \
 {                                                       \
-- 
2.39.5 (Apple Git-154)


