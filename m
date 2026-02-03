Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBC6CE8783D
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 15:01:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnHtu-00070l-AY; Tue, 03 Feb 2026 10:01:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hongzhibo@bytedance.com>)
 id 1vnBfw-00072M-Vn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 03:22:21 -0500
Received: from sg-1-107.ptr.blmpb.com ([118.26.132.107])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hongzhibo@bytedance.com>)
 id 1vnBft-0004EW-Be
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 03:22:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1770106920; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=I7SOY3I0kT2JGHAjMl/y/SaarRknr6dY7aMb0GnOv/A=;
 b=g2oDhN2Z3cCV2JoGm6uEUrN0q5EB//+FoX4gwCz9oWiS9pXQ+5WIOiPDnRV6hImZ0pyGby
 kWQuq9LthyYag0vY+mq/zyeUkOwNAFANTTHEPMG8Y9y0/Shy6QPW4MshHg0FWFP8Mjujz7
 oBSUOaU3s9kbe0L/jU1v+QwFTst7TkzGFo/OZDI4rxas/Ig1AQBt2mO+F8adw4pCPm1sVW
 VNxn1dd/E0rtuW9jRRCmb/B6rKRe/AEV3donZ8CgpHREeebB4By6wQVtGYYTX3QFyE7HjV
 vEeKYWyBDgR+9OkpbYk1KaY59Gc0TwXdaQCjw11kxmf1cu1yVhQv3SM9SkEg3w==
Subject: [PATCH v1] riscv: Add support for Zibi extension
Date: Tue,  3 Feb 2026 16:21:44 +0800
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: hongzhibo@bytedance.com
X-Mailer: git-send-email 2.39.5
X-Lms-Return-Path: <lba+26981b026+08d323+nongnu.org+hongzhibo@bytedance.com>
To: <qemu-devel@nongnu.org>
Cc: <qemu-riscv@nongnu.org>, "Zhibo Hong" <hongzhibo@bytedance.com>
Content-Type: text/plain; charset=UTF-8
From: =?utf-8?q?=E6=B4=AA=E5=BF=97=E5=8D=9A?= <hongzhibo@bytedance.com>
Message-Id: <20260203082144.2183253-1-hongzhibo@bytedance.com>
Received-SPF: pass client-ip=118.26.132.107;
 envelope-from=hongzhibo@bytedance.com; helo=sg-1-107.ptr.blmpb.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 03 Feb 2026 10:01:06 -0500
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

From: Zhibo Hong <hongzhibo@bytedance.com>

Signed-off-by: Zhibo Hong <hongzhibo@bytedance.com>
---
 disas/riscv.c                              | 17 +++++++
 disas/riscv.h                              |  2 +
 target/riscv/cpu.c                         |  2 +
 target/riscv/cpu_cfg_fields.h.inc          |  1 +
 target/riscv/insn32.decode                 |  9 ++++
 target/riscv/insn_trans/trans_rvzibi.c.inc | 54 ++++++++++++++++++++++
 target/riscv/translate.c                   |  6 +++
 7 files changed, 91 insertions(+)
 create mode 100644 target/riscv/insn_trans/trans_rvzibi.c.inc

diff --git a/disas/riscv.c b/disas/riscv.c
index 85cd2a9c2a..92862835f0 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -984,6 +984,8 @@ typedef enum {
     rv_op_ssamoswap_d = 953,
     rv_op_c_sspush = 954,
     rv_op_c_sspopchk = 955,
+    rv_op_beqi      = 956,
+    rv_op_bnei      = 957,
 } rv_op;
 
 /* register names */
@@ -2254,6 +2256,8 @@ const rv_opcode_data rvi_opcode_data[] = {
       rv_op_sspush, 0 },
     { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
       rv_op_sspopchk, 0 },
+    { "beqi", rv_codec_bi, rv_fmt_rs1_imm1_offset, NULL, 0, 0, 0 },
+    { "bnei", rv_codec_bi, rv_fmt_rs1_imm1_offset, NULL, 0, 0, 0 },
 };
 
 /* CSR names */
@@ -3997,6 +4001,8 @@ static void decode_inst_opcode(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 0: op = rv_op_beq; break;
             case 1: op = rv_op_bne; break;
+            case 2: op = rv_op_beqi; break;
+            case 3: op = rv_op_bnei; break;
             case 4: op = rv_op_blt; break;
             case 5: op = rv_op_bge; break;
             case 6: op = rv_op_bltu; break;
@@ -4529,6 +4535,12 @@ static uint32_t operand_imml(rv_inst inst)
     return (inst << 38) >> 58;
 }
 
+static int32_t operand_bi(rv_inst inst)
+{
+    uint32_t cimm = (inst << 39) >> 59;
+    return cimm == 0 ? -1 : cimm;
+}
+
 static uint32_t calculate_stack_adj(rv_isa isa, uint32_t rlist, uint32_t spimm)
 {
     int xlen_bytes_log2 = isa == rv64 ? 3 : 2;
@@ -4948,6 +4960,11 @@ static void decode_inst_operands(rv_decode *dec, rv_isa isa)
         dec->rs1 = dec->rs2 = operand_crs1(inst);
         dec->imm = 0;
         break;
+    case rv_codec_bi:
+        dec->rs1 = operand_rs1(inst);
+        dec->imm = operand_sbimm12(inst);
+        dec->imm1 = operand_bi(inst);
+        break;
     };
 }
 
diff --git a/disas/riscv.h b/disas/riscv.h
index d211700cb2..452c788278 100644
--- a/disas/riscv.h
+++ b/disas/riscv.h
@@ -168,6 +168,7 @@ typedef enum {
     rv_codec_fli,
     rv_codec_lp,
     rv_codec_cmop_ss,
+    rv_codec_bi,
 } rv_codec;
 
 /* structures */
@@ -305,5 +306,6 @@ enum {
 #define rv_fmt_rd_rs1_immh_imml_addr  "O\t0,(1),i,j"
 #define rv_fmt_rd2_imm                "O\t0,2,(1),i"
 #define rv_fmt_fli                    "O\t3,h"
+#define rv_fmt_rs1_imm1_offset        "O\t1,j,o"
 
 #endif /* DISAS_RISCV_H */
diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index e95eea0249..0a1cb41c96 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -120,6 +120,7 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, const RISCVCPUConfig *src)
  * instead.
  */
 const RISCVIsaExtData isa_edata_arr[] = {
+    ISA_EXT_DATA_ENTRY(zibi, PRIV_VERSION_1_13_0, ext_zibi),
     ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
     ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
     ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
@@ -1238,6 +1239,7 @@ const RISCVCPUMultiExtConfig riscv_cpu_extensions[] = {
     MULTI_EXT_CFG_BOOL("ssccfg", ext_ssccfg, false),
     MULTI_EXT_CFG_BOOL("smctr", ext_smctr, false),
     MULTI_EXT_CFG_BOOL("ssctr", ext_ssctr, false),
+    MULTI_EXT_CFG_BOOL("zibi", ext_zibi, false),
     MULTI_EXT_CFG_BOOL("zifencei", ext_zifencei, true),
     MULTI_EXT_CFG_BOOL("zicfilp", ext_zicfilp, false),
     MULTI_EXT_CFG_BOOL("zicfiss", ext_zicfiss, false),
diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
index 70ec650abf..046c656bd9 100644
--- a/target/riscv/cpu_cfg_fields.h.inc
+++ b/target/riscv/cpu_cfg_fields.h.inc
@@ -30,6 +30,7 @@ BOOL_FIELD(ext_zks)
 BOOL_FIELD(ext_zksed)
 BOOL_FIELD(ext_zksh)
 BOOL_FIELD(ext_zkt)
+BOOL_FIELD(ext_zibi)
 BOOL_FIELD(ext_zifencei)
 BOOL_FIELD(ext_zicntr)
 BOOL_FIELD(ext_zicsr)
diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
index 6e35c4b1e6..0a92e79508 100644
--- a/target/riscv/insn32.decode
+++ b/target/riscv/insn32.decode
@@ -20,6 +20,7 @@
 %rs3       27:5
 %rs2       20:5
 %rs1       15:5
+%rs1_3     17:3                  !function=ex_rvc_register
 %rd        7:5
 %sh5       20:5
 %sh6       20:6
@@ -40,6 +41,7 @@
 %imm_z6   26:1 15:5
 %imm_mop5 30:1 26:2 20:2
 %imm_mop3 30:1 26:2
+%imm_bi   20:5                   !function=ex_bi
 
 # Argument sets:
 &empty
@@ -60,6 +62,7 @@
 &k_aes     shamt rs2 rs1 rd
 &mop5 imm rd rs1
 &mop3 imm rd rs1 rs2
+&bi   imm imm2 rs1
 
 # Formats 32:
 @r       .......   ..... ..... ... ..... ....... &r                %rs2 %rs1 %rd
@@ -111,6 +114,8 @@
 # Formats 128:
 @sh6       ...... ...... ..... ... ..... ....... &shift shamt=%sh6 %rs1 %rd
 
+@bi      ....... ..... ... .. ... ..... ....... &bi imm=%imm_b imm2=%imm_bi rs1=%rs1
+
 # *** Privileged Instructions ***
 ecall       000000000000     00000 000 00000 1110011
 ebreak      000000000001     00000 000 00000 1110011
@@ -1084,3 +1089,7 @@ sb_aqrl  00111 . . ..... ..... 000 ..... 0101111 @atom_st
 sh_aqrl  00111 . . ..... ..... 001 ..... 0101111 @atom_st
 sw_aqrl  00111 . . ..... ..... 010 ..... 0101111 @atom_st
 sd_aqrl  00111 . . ..... ..... 011 ..... 0101111 @atom_st
+
+# *** Zibi Extension ***
+beqi       ....... ..... ..... 010 ..... 1100011 @bi
+bnei       ....... ..... ..... 011 ..... 1100011 @bi
\ No newline at end of file
diff --git a/target/riscv/insn_trans/trans_rvzibi.c.inc b/target/riscv/insn_trans/trans_rvzibi.c.inc
new file mode 100644
index 0000000000..24bc0806aa
--- /dev/null
+++ b/target/riscv/insn_trans/trans_rvzibi.c.inc
@@ -0,0 +1,54 @@
+#define REQUIRE_ZIBI(ctx) do {                  \
+    if (!ctx->cfg_ptr->ext_zibi) {              \
+        return false;                           \
+    }                                           \
+} while (0)
+
+static bool gen_immediate_branch(DisasContext *ctx, arg_bi *a, TCGCond cond)
+{
+    TCGLabel *l = gen_new_label();
+    TCGv src1 = get_gpr(ctx, a->rs1, EXT_SIGN);
+    TCGv imm2 = tcg_constant_tl(a->imm2);
+    target_ulong orig_pc_save = ctx->pc_save;
+
+    if (get_xl(ctx) == MXL_RV128) {
+        TCGv src1h = get_gprh(ctx, a->rs1);
+        TCGv imm2h = tcg_constant_tl(a->imm2 >= 0 ? 0 : -1);
+        TCGv tmp = tcg_temp_new();
+
+        cond = gen_compare_i128(false, tmp, src1, src1h, imm2, imm2h, cond);
+        tcg_gen_brcondi_tl(cond, tmp, 0, l);
+    } else {
+        tcg_gen_brcond_tl(cond, src1, imm2, l);
+    }
+    gen_goto_tb(ctx, 1, ctx->cur_insn_len);
+    ctx->pc_save = orig_pc_save;
+
+    gen_set_label(l); /* branch taken */
+
+    if (!has_ext(ctx, RVC) && !ctx->cfg_ptr->ext_zca &&
+        (a->imm & 0x3)) {
+        /* misaligned */
+        TCGv target_pc = tcg_temp_new();
+        gen_pc_plus_diff(target_pc, ctx, a->imm);
+        gen_exception_inst_addr_mis(ctx, target_pc);
+    } else {
+        gen_goto_tb(ctx, 0, a->imm);
+    }
+    ctx->pc_save = -1;
+    ctx->base.is_jmp = DISAS_NORETURN;
+
+    return true;
+}
+
+static bool trans_beqi(DisasContext *ctx, arg_beqi *a)
+{
+    REQUIRE_ZIBI(ctx);
+    return gen_immediate_branch(ctx, a, TCG_COND_EQ);
+}
+
+static bool trans_bnei(DisasContext *ctx, arg_bnei *a)
+{
+    REQUIRE_ZIBI(ctx);
+    return gen_immediate_branch(ctx, a, TCG_COND_NE);
+}
diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index f687c75fe4..d0b83ebe01 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -858,6 +858,11 @@ static int ex_rvc_shiftri(DisasContext *ctx, int imm)
     return imm;
 }
 
+static int ex_bi(DisasContext *ctx, int imm)
+{
+    return imm == 0 ? -1 : imm;
+}
+
 /* Include the auto-generated decoder for 32 bit insn */
 #include "decode-insn32.c.inc"
 
@@ -1215,6 +1220,7 @@ static uint32_t opcode_at(DisasContextBase *dcbase, target_ulong pc)
 #include "insn_trans/trans_xthead.c.inc"
 #include "insn_trans/trans_xventanacondops.c.inc"
 #include "insn_trans/trans_xmips.c.inc"
+#include "insn_trans/trans_rvzibi.c.inc"
 
 /* Include the auto-generated decoder for 16 bit insn */
 #include "decode-insn16.c.inc"
-- 
2.39.5

