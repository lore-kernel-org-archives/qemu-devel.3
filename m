Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A35606A324
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xTwpD-000729-Fw; Thu, 19 Nov 2026 02:44:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoZ-0006vO-A9; Thu, 19 Nov 2026 02:44:17 -0500
Received: from smtp25.cstnet.cn ([159.226.251.25] helo=cstnet.cn)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <xiaoou@iscas.ac.cn>)
 id 1xTwoS-0001it-NE; Thu, 19 Nov 2026 02:44:14 -0500
Received: from xiaoou-ubuntu-01 (unknown [36.110.52.2])
 by APP-05 (Coremail) with SMTP id zQCowABX8LW1qP5qLIlyAQ--.23889S5;
 Thu, 19 Nov 2026 15:44:02 +0800 (CST)
From: Molly Chen <xiaoou@iscas.ac.cn>
To: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, Chao Liu <chao.liu@processmission.com>
Cc: nutty.liu@hotmail.com, max.chou@sifive.com, xiaoou@iscas.ac.cn,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Subject: [PATCH v4 03/20] target/riscv: Add packed SIMD arithmetic instructions
Date: Thu, 19 Nov 2026 07:43:23 +0000
Message-ID: <20261119074345.866125-4-xiaoou@iscas.ac.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
References: <20261119074345.866125-1-xiaoou@iscas.ac.cn>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zQCowABX8LW1qP5qLIlyAQ--.23889S5
X-Coremail-Antispam: 1UD129KBjvAXoWfXFW8Gr48Cr1xGFy7Jry3twb_yoW5ZF1UGo
 WfKr45Cr1xt343ZwnxCw4xX3srAF97uwn7WrWUXw4UuasxJr12krnrJw18Z3WxAry5KrWf
 Ga93Wrn8tFn3WFnrn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUOI7AC8VAFwI0_Wr0E3s1l1xkIjI8I6I8E6xAIw20EY4v20xva
 j40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l82xGYIkIc2x26280x7IE14v26r1rM28IrcIa0x
 kI8VCY1x0267AKxVW5JVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84AC
 jcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr
 1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
 M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
 v20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8
 JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
 ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
 z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
 AF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Xr0_Ar1l
 IxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
 4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsG
 vfC2KfnxnUUI43ZEXa7VUbZ2-5UUUUU==
X-CM-SenderInfo: 50ld003x6l2u1dvotugofq/
Received-SPF: pass client-ip=159.226.251.25; envelope-from=xiaoou@iscas.ac.cn;
 helo=cstnet.cn
X-Spam_score_int: 1
X-Spam_score: 0.1
X-Spam_bar: /
X-Spam_report: (0.1 / 5.0 requ) BAYES_00=-1.9, HK_RANDOM_ENVFROM=0.993,
 HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Implement addition, subtraction, shift-and-add, and
saturation/clipping operations.  Cover signed and unsigned,
saturating and non-saturating variants across the supported element
widths.

The implementation includes four components: instruction decodings,
translation functions, helper declarations and helper implementations.

Create trans_rvp.c.inc and define the GEN_SIMD_TRANS_* macros used by
the P extension instruction groups added in this and subsequent
patches. These macros provide common translation paths for checking
P extension availability and invoking helpers.

Update vxsat when a saturating operation overflows.

Signed-off-by: Molly Chen <xiaoou@iscas.ac.cn>
---
 target/riscv/helper.h                       |  41 ++
 target/riscv/insn32.decode                  |  63 +++
 target/riscv/tcg/insn_trans/trans_rvp.c.inc | 553 ++++++++++++++++++++
 target/riscv/tcg/psimd_helper.c             | 116 ++++
 target/riscv/tcg/translate.c                |   4 +
 5 files changed, 777 insertions(+)
 create mode 100644 target/riscv/tcg/insn_trans/trans_rvp.c.inc

diff --git a/target/riscv/helper.h b/target/riscv/helper.h
index 1cffcad580..a5c7459aa5 100644
--- a/target/riscv/helper.h
+++ b/target/riscv/helper.h
@@ -1396,3 +1396,44 @@ DEF_HELPER_5(sf_vqmaccu_2x8x2, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmacc_2x8x2, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmaccus_2x8x2, void, ptr, ptr, ptr, env, i32)
 DEF_HELPER_5(sf_vqmaccsu_2x8x2, void, ptr, ptr, ptr, env, i32)
+
+/* Packed SIMD */
+/* Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating) */
+DEF_HELPER_3(padd_b, tl, env, tl, tl)
+DEF_HELPER_3(padd_h, tl, env, tl, tl)
+DEF_HELPER_3(padd_w, i64, env, i64, i64)
+DEF_HELPER_3(padd_bs, tl, env, tl, tl)
+DEF_HELPER_3(padd_hs, tl, env, tl, tl)
+DEF_HELPER_3(padd_ws, i64, env, i64, i64)
+DEF_HELPER_3(psub_b, tl, env, tl, tl)
+DEF_HELPER_3(psub_h, tl, env, tl, tl)
+DEF_HELPER_3(psub_w, i64, env, i64, i64)
+DEF_HELPER_3(psh1add_h, tl, env, tl, tl)
+DEF_HELPER_3(psh1add_w, i64, env, i64, i64)
+DEF_HELPER_3(pssh1sadd_h, tl, env, tl, tl)
+DEF_HELPER_3(pssh1sadd_w, i64, env, i64, i64)
+DEF_HELPER_3(ssh1sadd, i32, env, i32, i32)
+DEF_HELPER_3(psadd_b, tl, env, tl, tl)
+DEF_HELPER_3(psadd_h, tl, env, tl, tl)
+DEF_HELPER_3(psadd_w, i64, env, i64, i64)
+DEF_HELPER_3(psaddu_b, tl, env, tl, tl)
+DEF_HELPER_3(psaddu_h, tl, env, tl, tl)
+DEF_HELPER_3(psaddu_w, i64, env, i64, i64)
+DEF_HELPER_3(sadd, i32, env, i32, i32)
+DEF_HELPER_3(saddu, i32, env, i32, i32)
+DEF_HELPER_3(pssub_b, tl, env, tl, tl)
+DEF_HELPER_3(pssub_h, tl, env, tl, tl)
+DEF_HELPER_3(pssub_w, i64, env, i64, i64)
+DEF_HELPER_3(pssubu_b, tl, env, tl, tl)
+DEF_HELPER_3(pssubu_h, tl, env, tl, tl)
+DEF_HELPER_3(pssubu_w, i64, env, i64, i64)
+DEF_HELPER_3(ssub, i32, env, i32, i32)
+DEF_HELPER_3(ssubu, i32, env, i32, i32)
+DEF_HELPER_3(psati_h, tl, env, tl, tl)
+DEF_HELPER_3(pusati_h, tl, env, tl, tl)
+DEF_HELPER_3(psati_w, i64, env, i64, i64)
+DEF_HELPER_3(pusati_w, i64, env, i64, i64)
+DEF_HELPER_3(sati_32, i32, env, i32, i32)
+DEF_HELPER_3(usati_32, i32, env, i32, i32)
+DEF_HELPER_3(sati_64, i64, env, i64, i64)
+DEF_HELPER_3(usati_64, i64, env, i64, i64)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 795badc8a7..ea130e9790 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -40,6 +40,9 @@
 %imm_z6   26:1 15:5
 %imm_mop5 30:1 26:2 20:2
 %imm_mop3 30:1 26:2
+%imm_p_ui16 20:4
+%imm_p_ui32 20:5
+%imm_p_ui64 20:6
 
 # Argument sets:
 &empty
@@ -60,6 +63,7 @@
 &k_aes     shamt rs2 rs1 rd
 &mop5 imm rd rs1
 &mop3 imm rd rs1 rs2
+&p_ui imm rs1 rd
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -105,6 +109,10 @@
 @mop5 . . .. .. .... .. ..... ... ..... ....... &mop5 imm=%imm_mop5 %rd %rs1
 @mop3 . . .. .. . ..... ..... ... ..... ....... &mop3 imm=%imm_mop3 %rd %rs1 %rs2
 
+@p_ui16 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui16 %rs1 %rd
+@p_ui32 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui32 %rs1 %rd
+@p_ui64 ..... .... ... ..... ... ..... ....... &i imm=%imm_p_ui64 %rs1 %rd
+
 # Formats 64:
 @sh5     .......  ..... .....  ... ..... ....... &shift  shamt=%sh5      %rs1 %rd
 
@@ -1097,3 +1105,58 @@ vwabda_vv     111101 . ..... ..... 000 ..... 1010111 @r_vm
 vwabda_vx     111101 . ..... ..... 100 ..... 1010111 @r_vm
 vwabdau_vv    111110 . ..... ..... 000 ..... 1010111 @r_vm
 vwabdau_vx    111110 . ..... ..... 100 ..... 1010111 @r_vm
+
+# *** P Experimental Extension Version v020 ***
+# Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating)
+padd_b     1000010 ..... ..... 000 ..... 0111011 @r
+padd_h     1000000 ..... ..... 000 ..... 0111011 @r
+padd_w     1000001 ..... ..... 000 ..... 0111011 @r
+padd_bs    1001110 ..... ..... 010 ..... 0011011 @r
+padd_hs    1001100 ..... ..... 010 ..... 0011011 @r
+padd_ws    1001101 ..... ..... 010 ..... 0011011 @r
+psub_b     1100010 ..... ..... 000 ..... 0111011 @r
+psub_h     1100000 ..... ..... 000 ..... 0111011 @r
+psub_w     1100001 ..... ..... 000 ..... 0111011 @r
+psh1add_h  1010000 ..... ..... 010 ..... 0111011 @r
+psh1add_w  1010001 ..... ..... 010 ..... 0111011 @r
+pssh1sadd_h   1011000 ..... ..... 010 ..... 0111011 @r
+{
+  ssh1sadd    1011001 ..... ..... 010 ..... 0111011 @r
+  pssh1sadd_w 1011001 ..... ..... 010 ..... 0111011 @r
+}
+psadd_b    1001010 ..... ..... 000 ..... 0111011 @r
+psadd_h    1001000 ..... ..... 000 ..... 0111011 @r
+{
+  sadd     1001001 ..... ..... 000 ..... 0111011 @r
+  psadd_w  1001001 ..... ..... 000 ..... 0111011 @r
+}
+psaddu_b   1011010 ..... ..... 000 ..... 0111011 @r
+psaddu_h   1011000 ..... ..... 000 ..... 0111011 @r
+{
+  saddu    1011001 ..... ..... 000 ..... 0111011 @r
+  psaddu_w 1011001 ..... ..... 000 ..... 0111011 @r
+}
+pssub_b    1101010 ..... ..... 000 ..... 0111011 @r
+pssub_h    1101000 ..... ..... 000 ..... 0111011 @r
+{
+  ssub     1101001 ..... ..... 000 ..... 0111011 @r
+  pssub_w  1101001 ..... ..... 000 ..... 0111011 @r
+}
+pssubu_b   1111010 ..... ..... 000 ..... 0111011 @r
+pssubu_h   1111000 ..... ..... 000 ..... 0111011 @r
+{
+  ssubu      1111001 ..... ..... 000 ..... 0111011 @r
+  pssubu_w   1111001 ..... ..... 000 ..... 0111011 @r
+}
+psati_h    11100 001.... ..... 100 ..... 0011011 @p_ui16
+pusati_h   10100 001.... ..... 100 ..... 0011011 @p_ui16
+{
+  sati_32  11100 01..... ..... 100 ..... 0011011 @p_ui32
+  psati_w  11100 01..... ..... 100 ..... 0011011 @p_ui32
+}
+{
+  usati_32 10100 01..... ..... 100 ..... 0011011 @p_ui32
+  pusati_w 10100 01..... ..... 100 ..... 0011011 @p_ui32
+}
+sati_64    111001 ...... ..... 100 ..... 0011011 @p_ui64
+usati_64   101001 ...... ..... 100 ..... 0011011 @p_ui64
diff --git a/target/riscv/tcg/insn_trans/trans_rvp.c.inc b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
new file mode 100644
index 0000000000..0c91aac506
--- /dev/null
+++ b/target/riscv/tcg/insn_trans/trans_rvp.c.inc
@@ -0,0 +1,553 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* RISC-V translation routines for the P Standard Extensions. */
+/* Copyright (c) 2026 ISRC ISCAS. */
+
+static bool require_rvp(DisasContext *ctx)
+{
+    uint32_t opcode = ctx->opcode & 0x7f;
+
+    if (!has_ext(ctx, RVP)) {
+        return false;
+    }
+
+    /*
+     * P_VXSAT_EXCP is encoded in the TB flags only when P is implemented
+     * without Zve*, where stateen0.VXSAT controls the whole OP-32 and
+     * OP-IMM-32 P instruction spaces.  When Zve* is present, this field
+     * remains NONE and vxsat access is checked by the VS path instead.
+     */
+    if ((opcode == 0x3b || opcode == 0x1b) &&
+        ctx->p_vxsat_excp != P_VXSAT_EXCP_NONE) {
+        ctx->virt_inst_excp =
+            ctx->p_vxsat_excp == P_VXSAT_EXCP_VIRTUAL;
+        return false;
+    }
+
+    return true;
+}
+
+static bool prepare_rvp_vxsat(DisasContext *ctx)
+{
+    if (!ctx->cfg_ptr->ext_zve32x) {
+        return true;
+    }
+
+    if (ctx->mstatus_vs == EXT_STATUS_DISABLED) {
+        return false;
+    }
+
+    mark_vs_dirty(ctx);
+    return true;
+}
+
+#define REQUIRE_RVP(ctx) do {             \
+    if (!require_rvp(ctx)) {              \
+        return false;                     \
+    }                                     \
+} while (0)
+
+#define GEN_SIMD_TRANS_BODY(NAME, VXSAT)                    \
+do {                                                        \
+    REQUIRE_RVP(ctx);                                       \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
+        return false;                                       \
+    }                                                       \
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
+    TCGv dest = dest_gpr(ctx, a->rd);                       \
+    gen_helper_##NAME(dest, tcg_env, src1, src2);           \
+    gen_set_gpr(ctx, a->rd, dest);                          \
+    return true;                                            \
+} while (0)
+
+#define GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)                 \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    return false;                                           \
+}
+
+#define GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)                 \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    return false;                                           \
+}
+
+#define GEN_SIMD_TRANS(NAME)                                \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_BODY(NAME, false);                       \
+}
+
+#define GEN_SIMD_TRANS_VXSAT(NAME)                          \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_BODY(NAME, true);                        \
+}
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_32(NAME)                             \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    GEN_SIMD_TRANS_BODY(NAME, false);                       \
+}
+#define GEN_SIMD_TRANS_32_VXSAT(NAME)                       \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    GEN_SIMD_TRANS_BODY(NAME, true);                        \
+}
+#else
+#define GEN_SIMD_TRANS_32(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#define GEN_SIMD_TRANS_32_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
+#define GEN_SIMD_TRANS_64_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
+#else
+#define GEN_SIMD_TRANS_64(NAME)                             \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    GEN_SIMD_TRANS_BODY(NAME, false);                       \
+}
+#define GEN_SIMD_TRANS_64_VXSAT(NAME)                       \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    GEN_SIMD_TRANS_BODY(NAME, true);                        \
+}
+#endif
+
+#define GEN_SIMD_TRANS_ACC_BODY(NAME, VXSAT)                \
+do {                                                        \
+    REQUIRE_RVP(ctx);                                       \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
+        return false;                                       \
+    }                                                       \
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
+    TCGv acc = get_gpr(ctx, a->rd, EXT_NONE);               \
+    TCGv t = tcg_temp_new();                                \
+    gen_helper_##NAME(t, tcg_env, src1, src2, acc);         \
+    gen_set_gpr(ctx, a->rd, t);                             \
+    return true;                                            \
+} while (0)
+
+#define GEN_SIMD_TRANS_ACC(NAME)                            \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_ACC_BODY(NAME, false);                   \
+}
+
+#define GEN_SIMD_TRANS_ACC_VXSAT(NAME)                      \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_ACC_BODY(NAME, true);                    \
+}
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_ACC_32(NAME)                         \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    GEN_SIMD_TRANS_ACC_BODY(NAME, false);                   \
+}
+#else
+#define GEN_SIMD_TRANS_ACC_32(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_ACC_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
+#else
+#define GEN_SIMD_TRANS_ACC_64(NAME)                         \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    GEN_SIMD_TRANS_ACC_BODY(NAME, false);                   \
+}
+#endif
+
+#define GEN_SIMD_TRANS_R1_BODY(NAME, VXSAT)                 \
+do {                                                        \
+    REQUIRE_RVP(ctx);                                       \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
+        return false;                                       \
+    }                                                       \
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
+    TCGv dest = dest_gpr(ctx, a->rd);                       \
+    gen_helper_##NAME(dest, tcg_env, src1);                 \
+    gen_set_gpr(ctx, a->rd, dest);                          \
+    return true;                                            \
+} while (0)
+
+#define GEN_SIMD_TRANS_R1(NAME)                             \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_R1_BODY(NAME, false);                    \
+}
+
+#define GEN_SIMD_TRANS_R1_VXSAT(NAME)                       \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_R1_BODY(NAME, true);                     \
+}
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_R1_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
+#define GEN_SIMD_TRANS_R1_64_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
+#else
+#define GEN_SIMD_TRANS_R1_64(NAME)                          \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    GEN_SIMD_TRANS_R1_BODY(NAME, false);                    \
+}
+#define GEN_SIMD_TRANS_R1_64_VXSAT(NAME)                    \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    GEN_SIMD_TRANS_R1_BODY(NAME, true);                     \
+}
+#endif
+
+#define GEN_SIMD_TRANS_IMM_BODY(NAME, VXSAT)                \
+do {                                                        \
+    REQUIRE_RVP(ctx);                                       \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
+        return false;                                       \
+    }                                                       \
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
+    TCGv imm = tcg_constant_tl(a->imm);                     \
+    TCGv dest = dest_gpr(ctx, a->rd);                       \
+    gen_helper_##NAME(dest, tcg_env, src1, imm);            \
+    gen_set_gpr(ctx, a->rd, dest);                          \
+    return true;                                            \
+} while (0)
+
+#define GEN_SIMD_TRANS_IMM(NAME)                            \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_IMM_BODY(NAME, false);                   \
+}
+
+#define GEN_SIMD_TRANS_IMM_VXSAT(NAME)                      \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    GEN_SIMD_TRANS_IMM_BODY(NAME, true);                    \
+}
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_IMM_32(NAME)                         \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    GEN_SIMD_TRANS_IMM_BODY(NAME, false);                   \
+}
+#define GEN_SIMD_TRANS_IMM_32_VXSAT(NAME)                   \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    GEN_SIMD_TRANS_IMM_BODY(NAME, true);                    \
+}
+#else
+#define GEN_SIMD_TRANS_IMM_32(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#define GEN_SIMD_TRANS_IMM_32_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_IMM_64(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
+#define GEN_SIMD_TRANS_IMM_64_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_64(NAME)
+#else
+#define GEN_SIMD_TRANS_IMM_64(NAME)                         \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    GEN_SIMD_TRANS_IMM_BODY(NAME, false);                   \
+}
+#define GEN_SIMD_TRANS_IMM_64_VXSAT(NAME)                   \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_64BIT(ctx);                                     \
+    GEN_SIMD_TRANS_IMM_BODY(NAME, true);                    \
+}
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_REG_PAIR_SCALAR_OP(NAME, SRC2)       \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    REQUIRE_RVP(ctx);                                       \
+    TCGv_i32 src1 = get_gpr(ctx, a->rs1, EXT_NONE);         \
+    TCGv_i32 src2 = SRC2;                                   \
+    TCGv_i64 t = tcg_temp_new_i64();                        \
+    gen_helper_##NAME(t, tcg_env, src1, src2);              \
+    set_pair_regs(ctx, a->rd, t);                           \
+    return true;                                            \
+}
+
+#define GEN_SIMD_TRANS_REG_PAIR_SCALAR(NAME) \
+    GEN_SIMD_TRANS_REG_PAIR_SCALAR_OP(NAME, get_gpr(ctx, a->rs2, EXT_NONE))
+
+#define GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(NAME) \
+    GEN_SIMD_TRANS_REG_PAIR_SCALAR_OP(NAME, tcg_constant_i32(a->imm))
+#else
+#define GEN_SIMD_TRANS_REG_PAIR_SCALAR(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#define GEN_SIMD_TRANS_REG_PAIR_SCALAR_IMM(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER, SRC2_0, SRC2_1, VXSAT) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)             \
+{                                                                       \
+    REQUIRE_32BIT(ctx);                                                 \
+    REQUIRE_RVP(ctx);                                                   \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                             \
+        return false;                                                   \
+    }                                                                   \
+    TCGv src1_0 = get_gpr(ctx, pair_reg(a->rs1, false), EXT_NONE);      \
+    TCGv src2_0 = SRC2_0;                                               \
+    TCGv dest_0 = dest_gpr(ctx, pair_reg(a->rd, false));                \
+    TCGv src1_1 = get_gpr(ctx, pair_reg(a->rs1, true), EXT_NONE);       \
+    TCGv src2_1 = SRC2_1;                                               \
+    TCGv dest_1 = dest_gpr(ctx, pair_reg(a->rd, true));                 \
+    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2_0);               \
+    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2_1);               \
+    gen_set_gpr(ctx, pair_reg(a->rd, false), dest_0);                   \
+    gen_set_gpr(ctx, pair_reg(a->rd, true), dest_1);                    \
+    return true;                                                        \
+}
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE(INSN, HELPER)                \
+    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                      \
+        get_gpr(ctx, pair_reg(a->rs2, false), EXT_NONE),          \
+        get_gpr(ctx, pair_reg(a->rs2, true), EXT_NONE), false)
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(INSN, HELPER)          \
+    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                      \
+        get_gpr(ctx, pair_reg(a->rs2, false), EXT_NONE),          \
+        get_gpr(ctx, pair_reg(a->rs2, true), EXT_NONE), true)
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(INSN, HELPER)             \
+    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                       \
+        tcg_constant_tl(a->imm), tcg_constant_tl(a->imm), false)
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(INSN, HELPER)       \
+    GEN_SIMD_TRANS_REG_PAIR_OP(INSN, HELPER,                       \
+        tcg_constant_tl(a->imm), tcg_constant_tl(a->imm), true)
+#else
+#define GEN_SIMD_TRANS_REG_PAIR_LANE(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_VXSAT(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_IMM_VXSAT(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, VXSAT) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)         \
+{                                                                   \
+    REQUIRE_32BIT(ctx);                                             \
+    REQUIRE_RVP(ctx);                                               \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                         \
+        return false;                                               \
+    }                                                               \
+    TCGv src1_0;                                                    \
+    TCGv src1_1;                                                    \
+    if (a->rs1 == 0) {                                              \
+        src1_0 = tcg_constant_tl(0);                                \
+        src1_1 = tcg_constant_tl(0);                                \
+    } else {                                                        \
+        src1_0 = get_gpr(ctx, pair_reg(a->rs1, false), EXT_NONE);   \
+        src1_1 = get_gpr(ctx, pair_reg(a->rs1, true), EXT_NONE);    \
+    }                                                               \
+    TCGv dest_0 = tcg_temp_new();                                   \
+    TCGv dest_1 = tcg_temp_new();                                   \
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);                     \
+    gen_helper_##HELPER(dest_0, tcg_env, src1_0, src2);             \
+    gen_helper_##HELPER(dest_1, tcg_env, src1_1, src2);             \
+    if (a->rd != 0) {                                               \
+        gen_set_gpr(ctx, pair_reg(a->rd, false), dest_0);           \
+        gen_set_gpr(ctx, pair_reg(a->rd, true), dest_1);            \
+    }                                                               \
+    return true;                                                    \
+}
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(INSN, HELPER)              \
+    GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, false)
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(INSN, HELPER)       \
+    GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_OP(INSN, HELPER, true)
+#else
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_SCALAR_VXSAT(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_OP(INSN, HELPER, VXSAT) \
+static bool trans_##INSN(DisasContext *ctx, arg_##INSN * a)        \
+{                                                                  \
+    REQUIRE_RVP(ctx);                                              \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                        \
+        return false;                                              \
+    }                                                              \
+    TCGv src1_0 = get_gpr(ctx, pair_reg(a->rs1, false), EXT_NONE); \
+    TCGv dest_0 = dest_gpr(ctx, pair_reg(a->rd, false));           \
+    TCGv src1_1 = get_gpr(ctx, pair_reg(a->rs1, true), EXT_NONE);  \
+    TCGv dest_1 = dest_gpr(ctx, pair_reg(a->rd, true));            \
+    gen_helper_##HELPER(dest_0, tcg_env, src1_0);                  \
+    gen_helper_##HELPER(dest_1, tcg_env, src1_1);                  \
+    gen_set_gpr(ctx, pair_reg(a->rd, false), dest_0);              \
+    gen_set_gpr(ctx, pair_reg(a->rd, true), dest_1);               \
+    return true;                                                   \
+}
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY(INSN, HELPER)              \
+    GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_OP(INSN, HELPER, false)
+
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_VXSAT(INSN, HELPER)        \
+    GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_OP(INSN, HELPER, true)
+#else
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#define GEN_SIMD_TRANS_REG_PAIR_LANE_UNARY_VXSAT(INSN, HELPER) \
+    GEN_SIMD_TRANS_UNAVAILABLE_32(INSN)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_REG_PAIR_ACC(NAME)                   \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    REQUIRE_RVP(ctx);                                       \
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_NONE);             \
+    TCGv src2 = get_gpr(ctx, a->rs2, EXT_NONE);             \
+    TCGv_i64 t = tcg_temp_new_i64();                        \
+    if (a->rd == 0) {                                       \
+        tcg_gen_movi_i64(t, 0);                             \
+    } else {                                                \
+        get_pair_regs(ctx, t, a->rd);                       \
+    }                                                       \
+    gen_helper_##NAME(t, tcg_env, src1, src2, t);           \
+    set_pair_regs(ctx, a->rd, t);                           \
+    return true;                                            \
+}
+#else
+#define GEN_SIMD_TRANS_REG_PAIR_ACC(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_REG_PAIR_PREDSUM(NAME)                     \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a)       \
+{                                                                 \
+    REQUIRE_32BIT(ctx);                                           \
+    REQUIRE_RVP(ctx);                                             \
+    TCGv_i32 src1_l;                                              \
+    TCGv_i32 src1_h;                                              \
+    TCGv_i32 src2 = get_gpr(ctx, a->rs2, EXT_NONE);               \
+    TCGv_i32 dest = dest_gpr(ctx, a->rd);                         \
+    if (a->rs1 == 0) {                                            \
+        src1_l = tcg_temp_new_i32();                              \
+        src1_h = tcg_temp_new_i32();                              \
+        tcg_gen_movi_i32(src1_l, 0);                              \
+        tcg_gen_movi_i32(src1_h, 0);                              \
+    } else {                                                      \
+        src1_l = get_gpr(ctx, pair_reg(a->rs1, false), EXT_NONE); \
+        src1_h = get_gpr(ctx, pair_reg(a->rs1, true), EXT_NONE);  \
+    }                                                             \
+    gen_helper_##NAME(dest, tcg_env, src1_l, src1_h, src2);       \
+    gen_set_gpr(ctx, a->rd, dest);                                \
+    return true;                                                  \
+}
+#else
+#define GEN_SIMD_TRANS_REG_PAIR_PREDSUM(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#endif
+
+#if defined(TARGET_RISCV32)
+#define GEN_SIMD_TRANS_PN_OP(NAME, SRC2, VXSAT)             \
+static bool trans_##NAME(DisasContext *ctx, arg_##NAME * a) \
+{                                                           \
+    REQUIRE_32BIT(ctx);                                     \
+    REQUIRE_RVP(ctx);                                       \
+    if (VXSAT && !prepare_rvp_vxsat(ctx)) {                 \
+        return false;                                       \
+    }                                                       \
+    TCGv_i64 s1 = tcg_temp_new_i64();                       \
+    if (a->rs1 == 0) {                                      \
+        tcg_gen_movi_i64(s1, 0);                            \
+    } else {                                                \
+        get_pair_regs(ctx, s1, a->rs1);                     \
+    }                                                       \
+    TCGv src2 = SRC2;                                       \
+    TCGv dest = dest_gpr(ctx, a->rd);                       \
+    gen_helper_##NAME(dest, tcg_env, s1, src2);             \
+    gen_set_gpr(ctx, a->rd, dest);                          \
+    return true;                                            \
+}
+
+#define GEN_SIMD_TRANS_PN_OP_IMM(NAME) \
+    GEN_SIMD_TRANS_PN_OP(NAME, tcg_constant_tl(a->imm), false)
+
+#define GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(NAME) \
+    GEN_SIMD_TRANS_PN_OP(NAME, tcg_constant_tl(a->imm), true)
+
+#define GEN_SIMD_TRANS_PN_OP_REG(NAME) \
+    GEN_SIMD_TRANS_PN_OP(NAME, get_gpr(ctx, a->rs2, EXT_NONE), false)
+
+#define GEN_SIMD_TRANS_PN_OP_REG_VXSAT(NAME) \
+    GEN_SIMD_TRANS_PN_OP(NAME, get_gpr(ctx, a->rs2, EXT_NONE), true)
+#else
+#define GEN_SIMD_TRANS_PN_OP_IMM(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#define GEN_SIMD_TRANS_PN_OP_IMM_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#define GEN_SIMD_TRANS_PN_OP_REG(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#define GEN_SIMD_TRANS_PN_OP_REG_VXSAT(NAME) GEN_SIMD_TRANS_UNAVAILABLE_32(NAME)
+#endif
+
+/* Packed SIMD - Arithmetic Operations(Non-Saturating and Saturating) */
+GEN_SIMD_TRANS(padd_b)
+GEN_SIMD_TRANS(padd_h)
+GEN_SIMD_TRANS_64(padd_w)
+GEN_SIMD_TRANS(padd_bs)
+GEN_SIMD_TRANS(padd_hs)
+GEN_SIMD_TRANS_64(padd_ws)
+GEN_SIMD_TRANS(psub_b)
+GEN_SIMD_TRANS(psub_h)
+GEN_SIMD_TRANS_64(psub_w)
+GEN_SIMD_TRANS(psh1add_h)
+GEN_SIMD_TRANS_64(psh1add_w)
+GEN_SIMD_TRANS_VXSAT(pssh1sadd_h)
+GEN_SIMD_TRANS_64_VXSAT(pssh1sadd_w)
+GEN_SIMD_TRANS_32_VXSAT(ssh1sadd)
+GEN_SIMD_TRANS_VXSAT(psadd_b)
+GEN_SIMD_TRANS_VXSAT(psadd_h)
+GEN_SIMD_TRANS_64_VXSAT(psadd_w)
+GEN_SIMD_TRANS_VXSAT(psaddu_b)
+GEN_SIMD_TRANS_VXSAT(psaddu_h)
+GEN_SIMD_TRANS_64_VXSAT(psaddu_w)
+GEN_SIMD_TRANS_32_VXSAT(sadd)
+GEN_SIMD_TRANS_32_VXSAT(saddu)
+GEN_SIMD_TRANS_VXSAT(pssub_b)
+GEN_SIMD_TRANS_VXSAT(pssub_h)
+GEN_SIMD_TRANS_64_VXSAT(pssub_w)
+GEN_SIMD_TRANS_VXSAT(pssubu_b)
+GEN_SIMD_TRANS_VXSAT(pssubu_h)
+GEN_SIMD_TRANS_64_VXSAT(pssubu_w)
+GEN_SIMD_TRANS_32_VXSAT(ssub)
+GEN_SIMD_TRANS_32_VXSAT(ssubu)
+GEN_SIMD_TRANS_IMM_VXSAT(psati_h)
+GEN_SIMD_TRANS_IMM_VXSAT(pusati_h)
+GEN_SIMD_TRANS_IMM_64_VXSAT(psati_w)
+GEN_SIMD_TRANS_IMM_64_VXSAT(pusati_w)
+GEN_SIMD_TRANS_IMM_32_VXSAT(sati_32)
+GEN_SIMD_TRANS_IMM_32_VXSAT(usati_32)
+GEN_SIMD_TRANS_IMM_64_VXSAT(sati_64)
+GEN_SIMD_TRANS_IMM_64_VXSAT(usati_64)
diff --git a/target/riscv/tcg/psimd_helper.c b/target/riscv/tcg/psimd_helper.c
index 54ef8acf07..328dfc3adb 100644
--- a/target/riscv/tcg/psimd_helper.c
+++ b/target/riscv/tcg/psimd_helper.c
@@ -2039,3 +2039,119 @@ uint32_t HELPER(NAME)(CPURISCVState *env, uint64_t s1, uint32_t shamt)    \
         return (uint32_t)(round_shx & 0xFFFFFFFF);                        \
     }                                                                     \
 }
+
+/* Basic addition operations (non-saturating) */
+
+GEN_PSIMD_BINOP(padd_b, target_ulong, uint8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
+GEN_PSIMD_BINOP(padd_h, target_ulong, uint16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
+GEN_PSIMD_BINOP(padd_w, uint64_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+GEN_PSIMD_BINOP_SCALAR(padd_bs, target_ulong, uint8_t,
+                       EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD)
+GEN_PSIMD_BINOP_SCALAR(padd_hs, target_ulong, uint16_t,
+                       EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD)
+GEN_PSIMD_BINOP_SCALAR(padd_ws, uint64_t, uint32_t,
+                       EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD)
+
+/* Basic subtraction operations (non-saturating) */
+
+GEN_PSIMD_BINOP(psub_b, target_ulong, uint8_t, uint8_t,
+                EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB)
+GEN_PSIMD_BINOP(psub_h, target_ulong, uint16_t, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB)
+GEN_PSIMD_BINOP(psub_w, uint64_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB)
+
+/* Shift-left-by-one and add operations */
+
+GEN_PSIMD_SHADD(psh1add_h, target_ulong, uint16_t,
+                EXTRACT16, INSERT16, ELEMS_H, 1)
+GEN_PSIMD_SHADD(psh1add_w, uint64_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, 1)
+
+GEN_PSIMD_SAT_SHADD(pssh1sadd_h, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, 1, -0x4000, 0x3fff,
+                    SAT_MIN_H, SAT_MAX_H, signed_saturate_h)
+GEN_PSIMD_SAT_SHADD(pssh1sadd_w, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 1, -0x40000000,
+                    0x3fffffff, SAT_MIN_W, SAT_MAX_W, signed_saturate_w)
+
+GEN_PSIMD_SAT_SHADD(ssh1sadd, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, 1, -0x40000000,
+                    0x3fffffff, SAT_MIN_W, SAT_MAX_W, signed_saturate_w)
+
+/* Saturating addition operations */
+
+GEN_PSIMD_SAT_BINOP(psadd_b, target_ulong, int8_t, int32_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD,
+                    signed_saturate_b)
+GEN_PSIMD_SAT_BINOP(psadd_h, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD,
+                    signed_saturate_h)
+GEN_PSIMD_SAT_BINOP(psadd_w, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
+                    signed_saturate_w)
+
+GEN_PSIMD_SAT_BINOP(psaddu_b, target_ulong, uint8_t, uint32_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_ADD,
+                    unsigned_saturate_b)
+GEN_PSIMD_SAT_BINOP(psaddu_h, target_ulong, uint16_t, uint32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_ADD,
+                    unsigned_saturate_h)
+GEN_PSIMD_SAT_BINOP(psaddu_w, uint64_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
+                    unsigned_saturate_w)
+
+GEN_PSIMD_SAT_BINOP(sadd, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
+                    signed_saturate_w)
+GEN_PSIMD_SAT_BINOP(saddu, uint32_t, uint32_t, uint64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_ADD,
+                    unsigned_saturate_w)
+
+/* Saturating subtraction operations */
+
+GEN_PSIMD_SAT_BINOP(pssub_b, target_ulong, int8_t, int32_t,
+                    EXTRACT8, INSERT8, ELEMS_B, PSIMD_DO_SUB,
+                    signed_saturate_b)
+GEN_PSIMD_SAT_BINOP(pssub_h, target_ulong, int16_t, int32_t,
+                    EXTRACT16, INSERT16, ELEMS_H, PSIMD_DO_SUB,
+                    signed_saturate_h)
+GEN_PSIMD_SAT_BINOP(pssub_w, uint64_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB,
+                    signed_saturate_w)
+
+GEN_PSIMD_SAT_USUB(pssubu_b, target_ulong, uint8_t,
+                   EXTRACT8, INSERT8, ELEMS_B)
+GEN_PSIMD_SAT_USUB(pssubu_h, target_ulong, uint16_t,
+                   EXTRACT16, INSERT16, ELEMS_H)
+GEN_PSIMD_SAT_USUB(pssubu_w, uint64_t, uint32_t,
+                   EXTRACT32, INSERT32, ELEMS_W)
+
+GEN_PSIMD_SAT_BINOP(ssub, uint32_t, int32_t, int64_t,
+                    EXTRACT32, INSERT32, ELEMS_W, PSIMD_DO_SUB,
+                    signed_saturate_w)
+GEN_PSIMD_SAT_USUB(ssubu, uint32_t, uint32_t,
+                   EXTRACT32, INSERT32, ELEMS_W)
+
+/* Saturation instructions (SAT, USAT) */
+
+GEN_PSIMD_SATI(psati_h, target_ulong, int16_t, int64_t,
+               EXTRACT16, INSERT16, ELEMS_H, 0x0f)
+GEN_PSIMD_USATI(pusati_h, target_ulong, int16_t, uint16_t, uint32_t,
+                EXTRACT16, INSERT16, ELEMS_H, 1U)
+GEN_PSIMD_SATI(psati_w, uint64_t, int32_t, int64_t,
+               EXTRACT32, INSERT32, ELEMS_W, 0x1f)
+GEN_PSIMD_USATI(pusati_w, uint64_t, int32_t, uint32_t, uint64_t,
+                EXTRACT32, INSERT32, ELEMS_W, 1ULL)
+GEN_PSIMD_SATI(sati_32, uint32_t, int32_t, int64_t,
+               EXTRACT32, INSERT32, ELEMS_W, 0x1f)
+GEN_PSIMD_USATI(usati_32, uint32_t, int32_t, uint32_t, uint32_t,
+                EXTRACT32, INSERT32, ELEMS_W, 1U)
+GEN_PSIMD_SATI(sati_64, uint64_t, int64_t, int64_t,
+               EXTRACT64, INSERT64, ELEMS_D, 0x3f)
+GEN_PSIMD_USATI(usati_64, uint64_t, int64_t, uint64_t, uint64_t,
+                EXTRACT64, INSERT64, ELEMS_D, 1ULL)
diff --git a/target/riscv/tcg/translate.c b/target/riscv/tcg/translate.c
index 79b0f444ef..6db8004aff 100644
--- a/target/riscv/tcg/translate.c
+++ b/target/riscv/tcg/translate.c
@@ -103,6 +103,7 @@ typedef struct DisasContext {
     bool vstart_eq_zero;
     bool vl_eq_vlmax;
     bool altfmt;
+    uint8_t p_vxsat_excp;
     CPUState *cs;
     TCGv zero;
     /* actual address width */
@@ -1208,6 +1209,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_rvh.c.inc"
 #include "insn_trans/trans_rvv.c.inc"
 #include "insn_trans/trans_rvb.c.inc"
+#include "insn_trans/trans_rvp.c.inc"
 #include "insn_trans/trans_rvzicond.c.inc"
 #include "insn_trans/trans_rvzacas.c.inc"
 #include "insn_trans/trans_rvzabha.c.inc"
@@ -1345,6 +1347,8 @@ static void riscv_tr_init_disas_context(DisasContextBase *dcbase, CPUState *cs)
     ctx->vstart_eq_zero = FIELD_EX32(tb_flags, TB_FLAGS, VSTART_EQ_ZERO);
     ctx->vl_eq_vlmax = FIELD_EX32(tb_flags, TB_FLAGS, VL_EQ_VLMAX);
     ctx->altfmt = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS, ALTFMT);
+    ctx->p_vxsat_excp = FIELD_EX64(ext_tb_flags, EXT_TB_FLAGS,
+                                   P_VXSAT_EXCP);
     ctx->misa_mxl_max = mcc->def->misa_mxl_max;
     ctx->xl = FIELD_EX32(tb_flags, TB_FLAGS, XL);
     ctx->address_xl = FIELD_EX32(tb_flags, TB_FLAGS, AXL);
-- 
2.53.0


