Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C18DC369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 09:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7tFo-0002Vh-PX; Thu, 24 Apr 2025 05:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1u7tFl-0002HD-6Q
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:52:21 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1u7tFi-000316-T5
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 05:52:20 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8BxIK99CQpoWjzFAA--.62412S3;
 Thu, 24 Apr 2025 17:50:53 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowMCx_cZ8CQpoIFeTAA--.43713S3;
 Thu, 24 Apr 2025 17:50:52 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, peter.maydell@linaro.org,
 --cc=richard.henderson@linaro.org, WANG Rui <wangrui@loongson.cn>
Subject: [PULL 11/13] linux-user/loongarch64: Decode BRK break codes for FPE
 signals
Date: Thu, 24 Apr 2025 17:28:47 +0800
Message-Id: <20250424092849.3985437-2-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20250424092849.3985437-1-gaosong@loongson.cn>
References: <20250424023317.3980755-1-gaosong@loongson.cn>
 <20250424092849.3985437-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMCx_cZ8CQpoIFeTAA--.43713S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: WANG Rui <wangrui@loongson.cn>

Handle specific LoongArch BRK break codes in user-mode emulation
to deliver accurate floating-point exception signals. Specifically,
BRK_OVERFLOW (6) triggers TARGET_FPE_INTOVF, and BRK_DIVZERO (7)
triggers TARGET_FPE_INTDIV. Other BRK codes fall back to a generic
SIGTRAP.

This improves correctness for programs that rely on BRK to signal
overflow or divide-by-zero conditions.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
Acked-by: Song Gao <gaosong@loongson.cn>
Message-Id: <20250414074952.6253-1-wangrui@loongson.cn>
Signed-off-by: Song Gao <gaosong@loongson.cn>
---
 linux-user/loongarch64/cpu_loop.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/linux-user/loongarch64/cpu_loop.c b/linux-user/loongarch64/cpu_loop.c
index 0614d3de22..ec8a06c88c 100644
--- a/linux-user/loongarch64/cpu_loop.c
+++ b/linux-user/loongarch64/cpu_loop.c
@@ -11,6 +11,12 @@
 #include "user/cpu_loop.h"
 #include "signal-common.h"
 
+/* Break codes */
+enum {
+    BRK_OVERFLOW = 6,
+    BRK_DIVZERO = 7
+};
+
 void cpu_loop(CPULoongArchState *env)
 {
     CPUState *cs = env_cpu(env);
@@ -66,9 +72,26 @@ void cpu_loop(CPULoongArchState *env)
             force_sig_fault(TARGET_SIGFPE, si_code, env->pc);
             break;
         case EXCP_DEBUG:
-        case EXCCODE_BRK:
             force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->pc);
             break;
+        case EXCCODE_BRK:
+            {
+                unsigned int opcode;
+
+                get_user_u32(opcode, env->pc);
+
+                switch (opcode & 0x7fff) {
+                case BRK_OVERFLOW:
+                    force_sig_fault(TARGET_SIGFPE, TARGET_FPE_INTOVF, env->pc);
+                    break;
+                case BRK_DIVZERO:
+                    force_sig_fault(TARGET_SIGFPE, TARGET_FPE_INTDIV, env->pc);
+                    break;
+                default:
+                    force_sig_fault(TARGET_SIGTRAP, TARGET_TRAP_BRKPT, env->pc);
+                }
+            }
+            break;
         case EXCCODE_BCE:
             force_sig_fault(TARGET_SIGSYS, TARGET_SI_KERNEL, env->pc);
             break;
-- 
2.34.1


