Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00D4606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:33:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVl0d-0005Jv-Bf; Tue, 24 Nov 2026 02:32:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <maobibo@loongson.cn>)
 id 1xVl0b-0005JH-OA
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:09 -0500
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <maobibo@loongson.cn>) id 1xVl0Z-000090-K3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 02:32:09 -0500
Received: from loongson.cn (unknown [10.40.46.54])
 by gateway (Coremail) with SMTP id _____8CxBbVqPQVr13wiAA--.4695S3;
 Tue, 24 Nov 2026 15:31:54 +0800 (CST)
Received: from fedora.loongson.cn (unknown [10.40.46.54])
 by front2 (Coremail) with SMTP id qciowJAxjn9oPQVrMaYNAA--.317S2;
 Tue, 24 Nov 2026 15:31:52 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Song Gao <17746591750@163.com>
Cc: Xianglai Li <lixianglai@loongson.cn>,
	qemu-devel@nongnu.org
Subject: [PATCH 4/6] target/loongarch: Add exception structure to
 CPULoongArchState
Date: Tue, 24 Nov 2026 15:33:19 +0800
Message-ID: <20261124073321.3015041-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261124073321.3015041-1-maobibo@loongson.cn>
References: <20261124073321.3015041-1-maobibo@loongson.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qciowJAxjn9oPQVrMaYNAA--.317S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Ww1DtryUKrW5ZFWUKryrXwc_yoW7Gw48pr
 y7uryUKF4rGFZrZ3s5X3yYgrn8Zr48Gw42v3WftryFkr43Xr1Ivr1kta9FgF1UGa1UXr1j
 vF1Syw1j9FyrZagCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
 1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv
 67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
 Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
 6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0x
 vE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
 42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
 kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UiVysUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=maobibo@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Exception information is currently represented by exception_index in the
generic CPUState. However for an MMU exception, badv also needs to be
written to CSR_BADV.

Add an exception structure to CPULoongArchState with badv and flags
fields, and introduce raise_exception_full() which takes badv and
flags as input parameters when raising an exception.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.h               | 13 +++++++++++++
 target/loongarch/internals.h         |  4 ----
 target/loongarch/tcg/fpu_helper.c    |  1 +
 target/loongarch/tcg/op_helper.c     |  1 +
 target/loongarch/tcg/tcg_cpu.c       | 10 +++++++---
 target/loongarch/tcg/tcg_loongarch.h |  9 +++++++++
 target/loongarch/tcg/vec_helper.c    |  1 +
 7 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/target/loongarch/cpu.h b/target/loongarch/cpu.h
index 8dae4e12cf..99c73680a2 100644
--- a/target/loongarch/cpu.h
+++ b/target/loongarch/cpu.h
@@ -424,6 +424,19 @@ typedef struct CPUArchState {
 #ifndef CONFIG_USER_ONLY
     LoongArchTLB  tlb[LOONGARCH_TLB_MAX];
 #endif
+
+    /*
+     * Information associated with an exception about to be taken:
+     * code which raises an exception must set cs->exception_index and
+     * the relevant parts of this structure
+     */
+#define LOONGARCH_EXCEPTION_MM                0x1
+#define LOONGARCH_EXCEPTION_TLB               0x2
+#define LOONGARCH_EXCEPTION_REFILL            0x4
+    struct {
+        uint64_t badv;
+        uint32_t flags;
+    } exception;
 #endif
 
     /* Fields up to this point are cleared by a CPU reset */
diff --git a/target/loongarch/internals.h b/target/loongarch/internals.h
index bc32bba7f7..91611cd200 100644
--- a/target/loongarch/internals.h
+++ b/target/loongarch/internals.h
@@ -19,10 +19,6 @@ void loongarch_translate_init(void);
 void loongarch_translate_code(CPUState *cs, TranslationBlock *tb,
                               int *max_insns, vaddr pc, void *host_pc);
 
-void G_NORETURN do_raise_exception(CPULoongArchState *env,
-                                   uint32_t exception,
-                                   uintptr_t pc);
-
 #ifdef CONFIG_TCG
 int ieee_ex_to_loongarch(int xcpt);
 void restore_fp_status(CPULoongArchState *env);
diff --git a/target/loongarch/tcg/fpu_helper.c b/target/loongarch/tcg/fpu_helper.c
index cf7c77b1b0..1cbb92c436 100644
--- a/target/loongarch/tcg/fpu_helper.c
+++ b/target/loongarch/tcg/fpu_helper.c
@@ -11,6 +11,7 @@
 #include "accel/tcg/cpu-ldst.h"
 #include "fpu/softfloat.h"
 #include "internals.h"
+#include "tcg/tcg_loongarch.h"
 
 static inline uint64_t nanbox_s(float32 fp)
 {
diff --git a/target/loongarch/tcg/op_helper.c b/target/loongarch/tcg/op_helper.c
index f8a91bed5d..18994f5dc0 100644
--- a/target/loongarch/tcg/op_helper.c
+++ b/target/loongarch/tcg/op_helper.c
@@ -15,6 +15,7 @@
 #include "qemu/crc32c.h"
 #include <zlib.h> /* for crc32 */
 #include "cpu-csr.h"
+#include "tcg/tcg_loongarch.h"
 
 /* Exceptions helpers */
 void HELPER(raise_exception)(CPULoongArchState *env, uint32_t exception)
diff --git a/target/loongarch/tcg/tcg_cpu.c b/target/loongarch/tcg/tcg_cpu.c
index 0549506035..ac56f4ccf4 100644
--- a/target/loongarch/tcg/tcg_cpu.c
+++ b/target/loongarch/tcg/tcg_cpu.c
@@ -18,9 +18,11 @@
 #include "tcg_loongarch.h"
 #include "internals.h"
 
-void G_NORETURN do_raise_exception(CPULoongArchState *env,
-                                   uint32_t exception,
-                                   uintptr_t pc)
+void G_NORETURN raise_exception_full(CPULoongArchState *env,
+                                     uint32_t exception,
+                                     uintptr_t pc,
+                                     uint32_t flags,
+                                     uint64_t badv)
 {
     CPUState *cs = env_cpu(env);
 
@@ -28,6 +30,8 @@ void G_NORETURN do_raise_exception(CPULoongArchState *env,
                   __func__,
                   exception,
                   loongarch_exception_name(exception));
+    env->exception.flags = flags;
+    env->exception.badv = badv;
     cs->exception_index = exception;
 
     cpu_loop_exit_restore(cs, pc);
diff --git a/target/loongarch/tcg/tcg_loongarch.h b/target/loongarch/tcg/tcg_loongarch.h
index 9c8627972f..6cfca6e47b 100644
--- a/target/loongarch/tcg/tcg_loongarch.h
+++ b/target/loongarch/tcg/tcg_loongarch.h
@@ -24,4 +24,13 @@ TLBRet loongarch_get_addr_from_tlb(CPULoongArchState *env,
                                    MMUContext *context,
                                    MMUAccessType access_type, int mmu_idx);
 
+void G_NORETURN raise_exception_full(CPULoongArchState *env,
+                                     uint32_t exception,
+                                     uintptr_t pc,
+                                     uint32_t flags,
+                                     uint64_t badv);
+
+#define do_raise_exception(env, exception, pc)             \
+                           raise_exception_full(env, exception, pc, 0, 0)
+
 #endif  /* TARGET_LOONGARCH_TCG_LOONGARCH_H */
diff --git a/target/loongarch/tcg/vec_helper.c b/target/loongarch/tcg/vec_helper.c
index 3ada636cd9..1b104c8920 100644
--- a/target/loongarch/tcg/vec_helper.c
+++ b/target/loongarch/tcg/vec_helper.c
@@ -13,6 +13,7 @@
 #include "tcg/tcg.h"
 #include "vec.h"
 #include "tcg/tcg-gvec-desc.h"
+#include "tcg/tcg_loongarch.h"
 
 #define DO_ODD_EVEN(NAME, BIT, E1, E2, DO_OP)                        \
 void HELPER(NAME)(void *vd, void *vj, void *vk, uint32_t desc)       \
-- 
2.54.0


