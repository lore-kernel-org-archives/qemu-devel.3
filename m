Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6CB3CD37AF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 02:55:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLBM4-00079M-M0; Thu, 07 May 2026 22:54:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1wLBM2-00078e-Pp
 for qemu-devel@nongnu.org; Thu, 07 May 2026 22:54:18 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1wLBLz-0003rJ-S2
 for qemu-devel@nongnu.org; Thu, 07 May 2026 22:54:18 -0400
Received: from loongson.cn (unknown [10.2.5.185])
 by gateway (Coremail) with SMTP id _____8DxrOlVUP1pKMEHAA--.23102S3;
 Fri, 08 May 2026 10:54:13 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.185])
 by front1 (Coremail) with SMTP id qMiowJBx68FEUP1p3qd8AA--.38421S5;
 Fri, 08 May 2026 10:54:12 +0800 (CST)
From: Song Gao <gaosong@loongson.cn>
To: qemu-devel@nongnu.org
Cc: Bibo Mao <maobibo@loongson.cn>
Subject: [PULL 3/3] target/loongarch: Add support for dbar hint variants
Date: Fri,  8 May 2026 10:28:01 +0800
Message-Id: <20260508022801.2637558-4-gaosong@loongson.cn>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20260508022801.2637558-1-gaosong@loongson.cn>
References: <20260508022801.2637558-1-gaosong@loongson.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: qMiowJBx68FEUP1p3qd8AA--.38421S5
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
 ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
 nUUI43ZEXa7xR_UUUUUUUUU==
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

LoongArch architecture (since LA664) introduces fine-grained dbar
hints that allow controlling which memory accesses are ordered by
the barrier. Previously, all dbar instructions were treated as a
full barrier (TCG_MO_ALL | TCG_BAR_SC).

This patch adds support for decoding dbar hints and emitting the
appropriate TCG memory barrier flags. For CPUs that do not advertise
the DBAR_HINTS feature (cpucfg3.DBAR_HINTS = 0), all dbar hints
fall back to a full barrier, preserving compatibility.

The hint encoding follows the LoongArch v1.10 specification:
The hint is a 5-bit field (bits 4-0). Bit4 is reserved and currently
ignored/discarded. Only bits 3-0 are used for ordering control.
 * Bit3: barrier for previous read (0: true, 1: false)
 * Bit2: barrier for previous write (0: true, 1: false)
 * Bit1: barrier for succeeding read (0: true, 1: false)
 * Bit0: barrier for succeeding write (0: true, 1: false)

The mapping to TCG memory order flags is as follows:
  TCG_BAR_SC |TCG_MO_LD_LD | TCG_MO_LD_ST;
  TCG_BAR_SC |TCG_MO_ST_LD | TCG_MO_ST_ST;
  TCG_BAR_SC |TCG_MO_LD_LD | TCG_MO_ST_LD;
  TCG_BAR_SC |TCG_MO_ST_ST | TCG_MO_LD_ST;

Special hint handling:
- hint 0x700: LL/SC loop barrier, treated as a full barrier as recommended.
- hint 0xf and 0x1f: reserved/no-op, treated as no operation

Signed-off-by: Song Gao <gaosong@loongson.cn>
Reviewed-by: Bibo Mao <maobibo@loongson.cn>
---
 target/loongarch/cpu.c                        |  4 ++
 .../tcg/insn_trans/trans_memory.c.inc         | 63 ++++++++++++++++++-
 target/loongarch/tcg/translate.c              |  1 +
 target/loongarch/translate.h                  |  3 +
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/target/loongarch/cpu.c b/target/loongarch/cpu.c
index e22568c84a..d8d106b07e 100644
--- a/target/loongarch/cpu.c
+++ b/target/loongarch/cpu.c
@@ -455,6 +455,10 @@ static void loongarch_max_initfn(Object *obj)
         data = FIELD_DP32(data, CPUCFG2, LLACQ_SCREL, 1);
         data = FIELD_DP32(data, CPUCFG2, SCQ, 1);
         cpu->env.cpucfg[2] = data;
+
+        data = cpu->env.cpucfg[3];
+        data = FIELD_DP32(data, CPUCFG3, DBAR_HINTS, 1);
+        cpu->env.cpucfg[3] = data;
     }
 }
 
diff --git a/target/loongarch/tcg/insn_trans/trans_memory.c.inc b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
index e287d46363..dcecf02e54 100644
--- a/target/loongarch/tcg/insn_trans/trans_memory.c.inc
+++ b/target/loongarch/tcg/insn_trans/trans_memory.c.inc
@@ -137,11 +137,70 @@ static bool trans_preldx(DisasContext *ctx, arg_preldx * a)
     return true;
 }
 
+/*
+ * Decode dbar hint and emit appropriate TCG memory barrier.
+ *
+ * The hint is a 5-bit field (0-31) encoded in the instruction.
+ * For hint 0x700 (special LL/SC loop barrier), treat as full barrier.
+ *
+ * See LoongArch Reference Manual v1.10, Section 4.2.2 for details.
+ */
 static bool trans_dbar(DisasContext *ctx, arg_dbar * a)
 {
-    tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
+    int hint = a->imm;
+    TCGBar bar_flags = 0;
+
+    /* Reserved/no-op hints: 0xf and 0x1f */
+    if (hint == 0xf || hint == 0x1f) {
+        return true;
+    }
+
+    /* If the CPU does not support fine-grained hints,or for the special LL/SC
+     * loop barrier (0x700), emit a full barrier.
+     */
+    if (!avail_DBAR_HINT(ctx) || hint == 0x700) {
+        tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
+        return true;
+    }
+
+    /*
+     * Fine-grained hint decoding:
+     * The hint is a 5-bit field (bits 4-0). Bit4 is reserved and currently
+     * ignored/discarded. Only bits 3-0 are used for ordering control.
+     * Bit3: barrier for previous read (0: true, 1: false)
+     * Bit2: barrier for previous write (0: true, 1: false)
+     * Bit1: barrier for succeeding read (0: true, 1: false)
+     * Bit0: barrier for succeeding write (0: true, 1: false)
+     *
+     * For each combination, we set the corresponding TCG_MO_* flag if both
+     * sides of the barrier require ordering.
+     */
+
+    bool prev_rd = !(hint & 0x08); /* bit3 */
+    bool prev_wr = !(hint & 0x04); /* bit2 */
+    bool succ_rd = !(hint & 0x02); /* bit1 */
+    bool succ_wr = !(hint & 0x01); /* bit0 */
+
+    if (prev_rd) {
+        bar_flags |= TCG_MO_LD_LD | TCG_MO_LD_ST;
+    }
+    if (prev_wr) {
+        bar_flags |= TCG_MO_ST_LD | TCG_MO_ST_ST;
+    }
+    if (succ_rd) {
+        bar_flags |= TCG_MO_LD_LD | TCG_MO_ST_LD;
+    }
+    if (succ_wr) {
+        bar_flags |= TCG_MO_ST_ST | TCG_MO_LD_ST;
+    }
+
+    if (bar_flags == 0) {
+        bar_flags = TCG_MO_ALL;
+    }
+
+    tcg_gen_mb(bar_flags | TCG_BAR_SC);
     return true;
-}
+ }
 
 static bool trans_ibar(DisasContext *ctx, arg_ibar *a)
 {
diff --git a/target/loongarch/tcg/translate.c b/target/loongarch/tcg/translate.c
index 202b80e047..124dce6269 100644
--- a/target/loongarch/tcg/translate.c
+++ b/target/loongarch/tcg/translate.c
@@ -149,6 +149,7 @@ static void loongarch_tr_init_disas_context(DisasContextBase *dcbase,
 
     ctx->cpucfg1 = env->cpucfg[1];
     ctx->cpucfg2 = env->cpucfg[2];
+    ctx->cpucfg3 = env->cpucfg[3];
 }
 
 static void loongarch_tr_tb_start(DisasContextBase *dcbase, CPUState *cs)
diff --git a/target/loongarch/translate.h b/target/loongarch/translate.h
index ba1c89e57b..8aa8325dc6 100644
--- a/target/loongarch/translate.h
+++ b/target/loongarch/translate.h
@@ -43,6 +43,8 @@
 #define avail_LLACQ_SCREL(C)    (FIELD_EX32((C)->cpucfg2, CPUCFG2, LLACQ_SCREL))
 #define avail_LLACQ_SCREL_64(C) (avail_64(C) && avail_LLACQ_SCREL(C))
 
+#define avail_DBAR_HINT(C) (FIELD_EX32((C)->cpucfg3, CPUCFG3, DBAR_HINTS))
+
 /*
  * If an operation is being performed on less than TARGET_LONG_BITS,
  * it may require the inputs to be sign- or zero-extended; which will
@@ -66,6 +68,7 @@ typedef struct DisasContext {
     bool va32; /* 32-bit virtual address */
     uint32_t cpucfg1;
     uint32_t cpucfg2;
+    uint32_t cpucfg3;
 } DisasContext;
 
 void generate_exception(DisasContext *ctx, int excp);
-- 
2.54.0


