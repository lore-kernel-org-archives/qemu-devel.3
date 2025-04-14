Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3241BC369B4
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 07:49:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4EYs-00008k-Kg; Mon, 14 Apr 2025 03:48:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wangrui@loongson.cn>)
 id 1u4EYp-00008Q-Mj
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:48:55 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <wangrui@loongson.cn>) id 1u4EYm-0007Dv-JY
 for qemu-devel@nongnu.org; Mon, 14 Apr 2025 03:48:55 -0400
Received: from loongson.cn (unknown [223.64.120.81])
 by gateway (Coremail) with SMTP id _____8BxlmnRvfxnXbS8AA--.50569S3;
 Mon, 14 Apr 2025 15:48:33 +0800 (CST)
Received: from lvm.. (unknown [223.64.120.81])
 by front1 (Coremail) with SMTP id qMiowMAxj8XGvfxnsL6AAA--.55749S2;
 Mon, 14 Apr 2025 15:48:27 +0800 (CST)
From: WANG Rui <wangrui@loongson.cn>
To: Gao Song <gaosong@loongson.cn>
Cc: qemu-devel@nongnu.org,
	qemu@hev.cc,
	WANG Rui <wangrui@loongson.cn>
Subject: [PATCH] linux-user/loongarch64: Decode BRK break codes for FPE signals
Date: Mon, 14 Apr 2025 15:49:52 +0800
Message-ID: <20250414074952.6253-1-wangrui@loongson.cn>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowMAxj8XGvfxnsL6AAA--.55749S2
X-CM-SenderInfo: pzdqw2txl6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoWxJr43uF45Gw1rCrWrur4fCrX_yoW8AFWfpF
 ykur1xCryUGry7twnxJ34kZF45uFs29r47Gryaka18J3yxJr1Uuw1q9Fsxua45JrW7ury7
 ZryUJwnruF1UAagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v2
 6F4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
 02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAF
 wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7V
 AKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCj
 r7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6x
 IIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAI
 w20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x
 0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUrNtxDUUUU
Received-SPF: pass client-ip=114.242.206.163; envelope-from=wangrui@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Handle specific LoongArch BRK break codes in user-mode emulation
to deliver accurate floating-point exception signals. Specifically,
BRK_OVERFLOW (6) triggers TARGET_FPE_INTOVF, and BRK_DIVZERO (7)
triggers TARGET_FPE_INTDIV. Other BRK codes fall back to a generic
SIGTRAP.

This improves correctness for programs that rely on BRK to signal
overflow or divide-by-zero conditions.

Signed-off-by: WANG Rui <wangrui@loongson.cn>
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
2.49.0


