Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C47C5CFDB
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 22:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuHXz-0001e7-Fy; Wed, 12 Aug 2026 18:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXw-0001T6-O6
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:40 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wuHXo-0001tM-Mi
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 18:35:40 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2cc61541f8cso5367735ad.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 15:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786574131; x=1787178931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2ciwEDE1B7vr1zO+iAiV9R8jG1mcR+N5Bq894xOpTCk=;
 b=ai0c0eTSylnIVZQR6Yl93JAsRd5cF8gsVOU1GgkYYNfdxVeT+iHdHP3DUeUNtspqgm
 AItJyhzNfkBQBaPwTz0ibtSFFUAz0K6ULv4QMFn6ccPuHHWsFIgb7PXDWRiC4Azmv2qu
 46AN7bdXDIcskSfg3evB7VI3knmvZLebtMr8wJ6+CNJDaGGO0WVc8WFm6DCrklUZicgo
 IuWJZNiK1o3Nm2exJCo/KVLjVNc9OMTxVYxuPo3y72fIHaOnV3zQ6zwe8OnbltzeP4Kr
 DwkVG01WeZwE+/SSRadmVGBUmvU1Hzi8hffTkBbr07C8Ux9f0P85IzRhcQaxH36fYtiP
 6PJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786574131; x=1787178931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2ciwEDE1B7vr1zO+iAiV9R8jG1mcR+N5Bq894xOpTCk=;
 b=pBULoMB3nSeSqIE1TO8F92biNmE9yGYAf0kwMqVBkn2CLWpEVH9aOqPhHADcE9CGFZ
 CQSA2AqB4jTC6FGiGuDBls7RdKKqfJUMebXzvhMnUQ4l7niRIBxtx9xgMAxpKYVZOCip
 04RWqvx/ZORx8ip/9nSzwMDd99r9OPKKiFkmgnZVxpeajzJKAniNpH2/hOi39eQNQbNJ
 wwpzjlKMkN8CRPHxAjLT3k1hsIRJmZ9aCScuQ3aNqMMFNGFBHyfk3MGQREcPc007K5eA
 xczMjkzLy9f46jKAP3jkIiLL/D40hhY2hhy4Rcqhqa2QZg0p5NXAVekb2IjiD8eCFiZ1
 nI3w==
X-Gm-Message-State: AOJu0Yy/LpvsTsD0lArrVeJDw+6GWWuax6FyOvlQ7d2a1Uy8WnsT4Mcj
 03yBa7Qbg4k/pJ9nAet/xd/A3XwsJwvZYF+18SLF1Ej0xmsxtuTE6RsgFcmKeGiTedC2CZDkNUn
 zYxqG
X-Gm-Gg: AR+sD13+dfJeQZIp/HimGsaShnfH7fof8JKDg1FjG97oJKwmcg7TnBcCGiC8FGmh713
 gCcSaV5Fpf71iZr/s+cAV+xiBB/Dk6J0VdpEIIyKv1k6Oj09dylelnhDsOlqITWh3lgZ8YYY0yl
 mdYPr+0esUvMAjdajpSaoaah04/wX60hMFmGb2ZD+Rko2OGePRiIGSneNi4tcNofWH7FSeQKhnP
 a9Mak4GtRD14jpGFNqLH8OHX3nBgLpCHg6xZP4AYcfIIks0SmdPvkQRFl86inattrGG7l59x8o4
 v5i1p7yd0A+0EzaArrGT1/9RM+zM/aT7djQDf1gMo2xZhTHmuvPaeI5aUttA0hx7dDCAqtKRRXp
 OaCCQkIsXBnGMKqoLn4CqlqIEwAzlOS+rDuO+kiTHAsJdR9kyEoRV+pUr3JK2VJdKcveJo5jOko
 cV1ZihTqHwNELZer9u/ZUPXmR8+3si2iPLt3ho647Jj04yKwJ75jA6p2UeVQJn8QKYroeryPXOq
 xUT/BSg/2Ulv2xCjgg9
X-Received: by 2002:a17:90b:2b4e:b0:38e:9ca8:e99 with SMTP id
 98e67ed59e1d1-3931f89a7b0mr401430a91.5.1786574130369; 
 Wed, 12 Aug 2026 15:35:30 -0700 (PDT)
Received: from stoup.. (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931f41cd2fsm464854a91.12.2026.08.12.15.35.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 15:35:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, Alistair.Francis@wdc.com,
 Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH v2 51/52] disas/riscv: Split rvi_opcode_data
Date: Wed, 12 Aug 2026 15:31:41 -0700
Message-ID: <20260812223142.349142-52-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812223142.349142-1-richard.henderson@linaro.org>
References: <20260812223142.349142-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Generate separate objects for OP() instead of collecting in a table.
Return pointers to objects directly.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas/riscv.c        | 1981 +++++++++++++++++++++---------------------
 disas/riscv-op.c.inc |   94 +-
 2 files changed, 1048 insertions(+), 1027 deletions(-)

diff --git a/disas/riscv.c b/disas/riscv.c
index 7ea65ba2e7..b8099cbdf8 100644
--- a/disas/riscv.c
+++ b/disas/riscv.c
@@ -28,12 +28,6 @@
 #include "disas/riscv-xventana.h"
 #include "disas/riscv-xlrbr.h"
 
-typedef enum {
-#define OP(N, ...) rv_op_##N,
-#include "riscv-op.c.inc"
-#undef OP
-} rv_op;
-
 /* register names */
 
 static const char rv_ireg_name_sym[32][5] = {
@@ -113,140 +107,143 @@ static const rvc_constraint rvcc_true[] = { rvc_end };
 
 /* pseudo-instruction metadata */
 
-static const rv_opcode_data rvi_opcode_data[];
+/* Forward declare the all the opcodes so that we may link them. */
+#define OP(N, ...) static const rv_opcode_data op_##N;
+#include "riscv-op.c.inc"
+#undef OP
 
 static const rv_comp_data rvcp_jal[] = {
-    { &rvi_opcode_data[rv_op_j], rvcc_j },
-    { &rvi_opcode_data[rv_op_jal_ra], rvcc_jal_ra },
+    { &op_j, rvcc_j },
+    { &op_jal_ra, rvcc_jal_ra },
     { },
 };
 
 static const rv_comp_data rvcp_jalr[] = {
-    { &rvi_opcode_data[rv_op_jr], rvcc_jr },
-    { &rvi_opcode_data[rv_op_jalr_ra], rvcc_jalr_ra },
+    { &op_jr, rvcc_jr },
+    { &op_jalr_ra, rvcc_jalr_ra },
     { },
 };
 
 static const rv_comp_data rvcp_jr[] = {
-    { &rvi_opcode_data[rv_op_ret], rvcc_ret },
+    { &op_ret, rvcc_ret },
     { },
 };
 
 static const rv_comp_data rvcp_beq[] = {
-    { &rvi_opcode_data[rv_op_beqz], rvcc_beqz },
+    { &op_beqz, rvcc_beqz },
     { },
 };
 
 static const rv_comp_data rvcp_bne[] = {
-    { &rvi_opcode_data[rv_op_bnez], rvcc_bnez },
+    { &op_bnez, rvcc_bnez },
     { },
 };
 
 static const rv_comp_data rvcp_blt[] = {
-    { &rvi_opcode_data[rv_op_bltz], rvcc_bltz },
-    { &rvi_opcode_data[rv_op_bgtz], rvcc_bgtz },
+    { &op_bltz, rvcc_bltz },
+    { &op_bgtz, rvcc_bgtz },
     { },
 };
 
 static const rv_comp_data rvcp_bge[] = {
-    { &rvi_opcode_data[rv_op_blez], rvcc_blez },
-    { &rvi_opcode_data[rv_op_bgez], rvcc_bgez },
+    { &op_blez, rvcc_blez },
+    { &op_bgez, rvcc_bgez },
     { },
 };
 
 static const rv_comp_data rvcp_addi[] = {
-    { &rvi_opcode_data[rv_op_mv], rvcc_mv },
+    { &op_mv, rvcc_mv },
     { },
 };
 
 static const rv_comp_data rvcp_mv[] = {
-    { &rvi_opcode_data[rv_op_nop], rvcc_nop },
+    { &op_nop, rvcc_nop },
     { },
 };
 
 static const rv_comp_data rvcp_sltiu[] = {
-    { &rvi_opcode_data[rv_op_seqz], rvcc_seqz },
+    { &op_seqz, rvcc_seqz },
     { },
 };
 
 static const rv_comp_data rvcp_xori[] = {
-    { &rvi_opcode_data[rv_op_not], rvcc_not },
+    { &op_not, rvcc_not },
     { },
 };
 
 static const rv_comp_data rvcp_sub[] = {
-    { &rvi_opcode_data[rv_op_neg], rvcc_neg },
+    { &op_neg, rvcc_neg },
     { },
 };
 
 static const rv_comp_data rvcp_slt[] = {
-    { &rvi_opcode_data[rv_op_sltz], rvcc_sltz },
-    { &rvi_opcode_data[rv_op_sgtz], rvcc_sgtz },
+    { &op_sltz, rvcc_sltz },
+    { &op_sgtz, rvcc_sgtz },
     { },
 };
 
 static const rv_comp_data rvcp_sltu[] = {
-    { &rvi_opcode_data[rv_op_snez], rvcc_snez },
+    { &op_snez, rvcc_snez },
     { },
 };
 
 static const rv_comp_data rvcp_addiw[] = {
-    { &rvi_opcode_data[rv_op_sext_w], rvcc_sext_w },
+    { &op_sext_w, rvcc_sext_w },
     { },
 };
 
 static const rv_comp_data rvcp_subw[] = {
-    { &rvi_opcode_data[rv_op_negw], rvcc_negw },
+    { &op_negw, rvcc_negw },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_s[] = {
-    { &rvi_opcode_data[rv_op_fmv_s], rvcc_fmv_s },
+    { &op_fmv_s, rvcc_fmv_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_s[] = {
-    { &rvi_opcode_data[rv_op_fneg_s], rvcc_fneg_s },
+    { &op_fneg_s, rvcc_fneg_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_s[] = {
-    { &rvi_opcode_data[rv_op_fabs_s], rvcc_fabs_s },
+    { &op_fabs_s, rvcc_fabs_s },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_d[] = {
-    { &rvi_opcode_data[rv_op_fmv_d], rvcc_fmv_d },
+    { &op_fmv_d, rvcc_fmv_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_d[] = {
-    { &rvi_opcode_data[rv_op_fneg_d], rvcc_fneg_d },
+    { &op_fneg_d, rvcc_fneg_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_d[] = {
-    { &rvi_opcode_data[rv_op_fabs_d], rvcc_fabs_d },
+    { &op_fabs_d, rvcc_fabs_d },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnj_q[] = {
-    { &rvi_opcode_data[rv_op_fmv_q], rvcc_fmv_q },
+    { &op_fmv_q, rvcc_fmv_q },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjn_q[] = {
-    { &rvi_opcode_data[rv_op_fneg_q], rvcc_fneg_q },
+    { &op_fneg_q, rvcc_fneg_q },
     { },
 };
 
 static const rv_comp_data rvcp_fsgnjx_q[] = {
-    { &rvi_opcode_data[rv_op_fabs_q], rvcc_fabs_q },
+    { &op_fabs_q, rvcc_fabs_q },
     { },
 };
 
 /* Convert compressed insns into normal insns via pseudo expansion. */
-#define DECOMP(X)  &(const rv_comp_data){ &rvi_opcode_data[X], rvcc_true }
+#define DECOMP(X)  &(const rv_comp_data){ &X, rvcc_true }
 
 /* operand extractors */
 
@@ -662,11 +659,9 @@ static uint32_t operand_mop_rr_imm(rv_inst inst)
 
 /* instruction metadata */
 
-static const rv_opcode_data rvi_opcode_data[] = {
-#define OP(N, ...) { __VA_ARGS__ },
+#define OP(N, ...) static const rv_opcode_data op_##N = { __VA_ARGS__ };
 #include "riscv-op.c.inc"
 #undef OP
-};
 
 /* CSR names */
 
@@ -953,79 +948,65 @@ static const char *csr_name(int csrno)
 static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
 {
     rv_inst inst = dec->inst;
-    rv_opcode op = rv_op_illegal;
 
     switch ((inst >> 0) & 0b11) {
     case 0:
         switch ((inst >> 13) & 0b111) {
         case 0:
             if ((inst >> 5) & 0xff) {
-                op = rv_op_c_addi4spn;
+                return &op_c_addi4spn;
             }
             break;
         case 1:
             if (isa == rv128) {
-                op = rv_op_c_lq;
-            } else {
-                op = rv_op_c_fld;
+                return &op_c_lq;
             }
-            break;
-        case 2: op = rv_op_c_lw; break;
+            return &op_c_fld;
+        case 2: return &op_c_lw;
         case 3:
             if (isa == rv32) {
-                op = rv_op_c_flw;
-            } else {
-                op = rv_op_c_ld;
+                return &op_c_flw;
             }
-            break;
+            return &op_c_ld;
         case 4:
             switch ((inst >> 10) & 0b111) {
-            case 0: op = rv_op_c_lbu; break;
+            case 0: return &op_c_lbu;
             case 1:
                 if (((inst >> 6) & 1) == 0) {
-                    op = rv_op_c_lhu;
-                } else {
-                    op = rv_op_c_lh;
+                    return &op_c_lhu;
                 }
-                break;
-            case 2: op = rv_op_c_sb; break;
+                return &op_c_lh;
+            case 2: return &op_c_sb;
             case 3:
                 if (((inst >> 6) & 1) == 0) {
-                    op = rv_op_c_sh;
+                    return &op_c_sh;
                 }
                 break;
             }
             break;
         case 5:
             if (isa == rv128) {
-                op = rv_op_c_sq;
-            } else {
-                op = rv_op_c_fsd;
+                return &op_c_sq;
             }
-            break;
-        case 6: op = rv_op_c_sw; break;
+            return &op_c_fsd;
+        case 6: return &op_c_sw;
         case 7:
             if (isa == rv32) {
-                op = rv_op_c_fsw;
-            } else {
-                op = rv_op_c_sd;
+                return &op_c_fsw;
             }
-            break;
+            return &op_c_sd;
         }
         break;
     case 1:
         switch ((inst >> 13) & 0b111) {
         case 0:
-            op = rv_op_c_addi; /* or unspecified HINT */
-            break;
+            return &op_c_addi; /* or unspecified HINT */
         case 1:
             if (isa == rv32) {
-                op = rv_op_c_jal;
-            } else {
-                op = rv_op_c_addiw;
+                return &op_c_jal;
             }
-            break;
-        case 2: op = rv_op_c_li; break;
+            return &op_c_addiw;
+        case 2: return &op_c_li;
         case 3:
             if (dec->cfg
                 && dec->cfg->ext_zcmop
@@ -1033,16 +1014,16 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 && ((inst >> 11) & 0b11) == 0) {
                 if (dec->cfg->ext_zicfiss) {
                     switch (operand_cmop_imm(inst)) {
-                    case 1: return &rvi_opcode_data[rv_op_c_sspush];
-                    case 5: return &rvi_opcode_data[rv_op_c_sspopchk];
+                    case 1: return &op_c_sspush;
+                    case 5: return &op_c_sspopchk;
                     }
                 }
-                return &rvi_opcode_data[rv_op_c_mop];
+                return &op_c_mop;
             }
             if (inst & ((1 << 12) | (0x1f << 2))) {
                 switch ((inst >> 7) & 0b11111) {
-                case 2: op = rv_op_c_addi16sp; break;
-                default: op = rv_op_c_lui; break;
+                case 2: return &op_c_addi16sp;
+                default: return &op_c_lui;
                 }
             }
             break;
@@ -1051,261 +1032,252 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             case 0:
                 /* For rv32, shamt[5]=1 is designated for custom extensions. */
                 if (isa != rv32 || (inst & 0x1000) == 0) {
-                    op = rv_op_c_srli; /* or unspecified HINT */
+                    return &op_c_srli; /* or unspecified HINT */
                 }
                 break;
             case 1:
                 /* For rv32, shamt[5]=1 is designated for custom extensions. */
                 if (isa != rv32 || (inst & 0x1000) == 0) {
-                    op = rv_op_c_srai; /* or unspecified HINT */
+                    return &op_c_srai; /* or unspecified HINT */
                 }
                 break;
-            case 2: op = rv_op_c_andi; break;
+            case 2: return &op_c_andi;
             case 3:
                 switch (((inst >> 10) & 0b100) | ((inst >> 5) & 0b011)) {
-                case 0: op = rv_op_c_sub; break;
-                case 1: op = rv_op_c_xor; break;
-                case 2: op = rv_op_c_or; break;
-                case 3: op = rv_op_c_and; break;
+                case 0: return &op_c_sub;
+                case 1: return &op_c_xor;
+                case 2: return &op_c_or;
+                case 3: return &op_c_and;
                 case 4:
                     if (isa != rv32) {
-                        op = rv_op_c_subw;
+                        return &op_c_subw;
                     }
                     break;
                 case 5:
                     if (isa != rv32) {
-                        op = rv_op_c_addw;
+                        return &op_c_addw;
                     }
                     break;
-                case 6: op = rv_op_c_mul; break;
+                case 6: return &op_c_mul;
                 case 7:
                     switch ((inst >> 2) & 0b111) {
-                    case 0: op = rv_op_c_zext_b; break;
-                    case 1: op = rv_op_c_sext_b; break;
-                    case 2: op = rv_op_c_zext_h; break;
-                    case 3: op = rv_op_c_sext_h; break;
-                    case 4: op = rv_op_c_zext_w; break;
-                    case 5: op = rv_op_c_not; break;
+                    case 0: return &op_c_zext_b;
+                    case 1: return &op_c_sext_b;
+                    case 2: return &op_c_zext_h;
+                    case 3: return &op_c_sext_h;
+                    case 4: return &op_c_zext_w;
+                    case 5: return &op_c_not;
                     }
                     break;
                 }
                 break;
             }
             break;
-        case 5: op = rv_op_c_j; break;
-        case 6: op = rv_op_c_beqz; break;
-        case 7: op = rv_op_c_bnez; break;
+        case 5: return &op_c_j;
+        case 6: return &op_c_beqz;
+        case 7: return &op_c_bnez;
         }
         break;
     case 2:
         switch ((inst >> 13) & 0b111) {
         case 0:
             if (isa != rv32 || (inst & 0x1000) == 0) {
-                op = rv_op_c_slli; /* or unspecified HINT */
+                return &op_c_slli; /* or unspecified HINT */
             }
             break;
         case 1:
             if (isa == rv128) {
-                op = rv_op_c_lqsp;
-            } else {
-                op = rv_op_c_fldsp;
+                return &op_c_lqsp;
             }
-            break;
-        case 2: op = rv_op_c_lwsp; break;
+            return &op_c_fldsp;
+        case 2: return &op_c_lwsp;
         case 3:
             if (isa == rv32) {
-                op = rv_op_c_flwsp;
-            } else {
-                op = rv_op_c_ldsp;
+                return &op_c_flwsp;
             }
-            break;
+            return &op_c_ldsp;
         case 4:
             switch ((inst >> 12) & 0b1) {
             case 0:
                 switch ((inst >> 2) & 0b11111) {
-                case 0: op = rv_op_c_jr; break;
-                default: op = rv_op_c_mv; break;
+                case 0: return &op_c_jr;
+                default: return &op_c_mv;
                 }
                 break;
             case 1:
                 switch ((inst >> 2) & 0b11111) {
                 case 0:
                     switch ((inst >> 7) & 0b11111) {
-                    case 0: op = rv_op_c_ebreak; break;
-                    default: op = rv_op_c_jalr; break;
+                    case 0: return &op_c_ebreak;
+                    default: return &op_c_jalr;
                     }
                     break;
-                default: op = rv_op_c_add; break;
+                default: return &op_c_add;
                 }
                 break;
             }
             break;
         case 5:
             if (isa == rv128) {
-                op = rv_op_c_sqsp;
-            } else {
-                op = rv_op_c_fsdsp;
-                if (dec->cfg && dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
+                return &op_c_sqsp;
+            }
+            if (dec->cfg) {
+                if (dec->cfg->ext_zcmp && ((inst >> 12) & 0b01)) {
                     switch ((inst >> 8) & 0b01111) {
                     case 8:
                         if (((inst >> 4) & 0b01111) >= 4) {
-                            op = rv_op_cm_push;
+                            return &op_cm_push;
                         }
                         break;
                     case 10:
                         if (((inst >> 4) & 0b01111) >= 4) {
-                            op = rv_op_cm_pop;
+                            return &op_cm_pop;
                         }
                         break;
                     case 12:
                         if (((inst >> 4) & 0b01111) >= 4) {
-                            op = rv_op_cm_popretz;
+                            return &op_cm_popretz;
                         }
                         break;
                     case 14:
                         if (((inst >> 4) & 0b01111) >= 4) {
-                            op = rv_op_cm_popret;
-                        }
-                        break;
-                    }
-                } else {
-                    switch ((inst >> 10) & 0b011) {
-                    case 0:
-                        if (dec->cfg && !dec->cfg->ext_zcmt) {
-                            break;
-                        }
-                        if (((inst >> 2) & 0xFF) >= 32) {
-                            op = rv_op_cm_jalt;
-                        } else {
-                            op = rv_op_cm_jt;
-                        }
-                        break;
-                    case 3:
-                        if (dec->cfg && !dec->cfg->ext_zcmp) {
-                            break;
-                        }
-                        switch ((inst >> 5) & 0b011) {
-                        case 1: op = rv_op_cm_mvsa01; break;
-                        case 3: op = rv_op_cm_mva01s; break;
+                            return &op_cm_popret;
                         }
                         break;
                     }
                 }
+                switch ((inst >> 10) & 0b011) {
+                case 0:
+                    if (!dec->cfg->ext_zcmt) {
+                        break;
+                    }
+                    if (((inst >> 2) & 0xFF) >= 32) {
+                        return &op_cm_jalt;
+                    }
+                    return &op_cm_jt;
+                case 3:
+                    if (!dec->cfg->ext_zcmp) {
+                        break;
+                    }
+                    switch ((inst >> 5) & 0b011) {
+                    case 1: return &op_cm_mvsa01;
+                    case 3: return &op_cm_mva01s;
+                    }
+                    break;
+                }
             }
-            break;
-        case 6: op = rv_op_c_swsp; break;
+            return &op_c_fsdsp;
+        case 6: return &op_c_swsp;
         case 7:
             if (isa == rv32) {
-                op = rv_op_c_fswsp;
-            } else {
-                op = rv_op_c_sdsp;
+                return &op_c_fswsp;
             }
-            break;
+            return &op_c_sdsp;
         }
         break;
     case 3:
         switch ((inst >> 2) & 0b11111) {
         case 0:
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_lb; break;
-            case 1: op = rv_op_lh; break;
-            case 2: op = rv_op_lw; break;
-            case 3: op = rv_op_ld; break;
-            case 4: op = rv_op_lbu; break;
-            case 5: op = rv_op_lhu; break;
-            case 6: op = rv_op_lwu; break;
-            case 7: op = rv_op_ldu; break;
+            case 0: return &op_lb;
+            case 1: return &op_lh;
+            case 2: return &op_lw;
+            case 3: return &op_ld;
+            case 4: return &op_lbu;
+            case 5: return &op_lhu;
+            case 6: return &op_lwu;
+            case 7: return &op_ldu;
             }
             break;
         case 1:
             switch ((inst >> 12) & 0b111) {
             case 0:
                 switch ((inst >> 20) & 0b111111111111) {
-                case 40: op = rv_op_vl1re8_v; break;
-                case 552: op = rv_op_vl2re8_v; break;
-                case 1576: op = rv_op_vl4re8_v; break;
-                case 3624: op = rv_op_vl8re8_v; break;
+                case 40: return &op_vl1re8_v;
+                case 552: return &op_vl2re8_v;
+                case 1576: return &op_vl4re8_v;
+                case 3624: return &op_vl8re8_v;
                 }
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vle8_v; break;
-                    case 11: op = rv_op_vlm_v; break;
-                    case 16: op = rv_op_vle8ff_v; break;
+                    case 0: return &op_vle8_v;
+                    case 11: return &op_vlm_v;
+                    case 16: return &op_vle8ff_v;
                     }
                     break;
-                case 1: op = rv_op_vluxei8_v; break;
-                case 2: op = rv_op_vlse8_v; break;
-                case 3: op = rv_op_vloxei8_v; break;
+                case 1: return &op_vluxei8_v;
+                case 2: return &op_vlse8_v;
+                case 3: return &op_vloxei8_v;
                 }
                 break;
-            case 1: op = rv_op_flh; break;
-            case 2: op = rv_op_flw; break;
-            case 3: op = rv_op_fld; break;
-            case 4: op = rv_op_flq; break;
+            case 1: return &op_flh;
+            case 2: return &op_flw;
+            case 3: return &op_fld;
+            case 4: return &op_flq;
             case 5:
                 switch ((inst >> 20) & 0b111111111111) {
-                case 40: op = rv_op_vl1re16_v; break;
-                case 552: op = rv_op_vl2re16_v; break;
-                case 1576: op = rv_op_vl4re16_v; break;
-                case 3624: op = rv_op_vl8re16_v; break;
+                case 40: return &op_vl1re16_v;
+                case 552: return &op_vl2re16_v;
+                case 1576: return &op_vl4re16_v;
+                case 3624: return &op_vl8re16_v;
                 }
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vle16_v; break;
-                    case 16: op = rv_op_vle16ff_v; break;
+                    case 0: return &op_vle16_v;
+                    case 16: return &op_vle16ff_v;
                     }
                     break;
-                case 1: op = rv_op_vluxei16_v; break;
-                case 2: op = rv_op_vlse16_v; break;
-                case 3: op = rv_op_vloxei16_v; break;
+                case 1: return &op_vluxei16_v;
+                case 2: return &op_vlse16_v;
+                case 3: return &op_vloxei16_v;
                 }
                 break;
             case 6:
                 switch ((inst >> 20) & 0b111111111111) {
-                case 40: op = rv_op_vl1re32_v; break;
-                case 552: op = rv_op_vl2re32_v; break;
-                case 1576: op = rv_op_vl4re32_v; break;
-                case 3624: op = rv_op_vl8re32_v; break;
+                case 40: return &op_vl1re32_v;
+                case 552: return &op_vl2re32_v;
+                case 1576: return &op_vl4re32_v;
+                case 3624: return &op_vl8re32_v;
                 }
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vle32_v; break;
-                    case 16: op = rv_op_vle32ff_v; break;
+                    case 0: return &op_vle32_v;
+                    case 16: return &op_vle32ff_v;
                     }
                     break;
-                case 1: op = rv_op_vluxei32_v; break;
-                case 2: op = rv_op_vlse32_v; break;
-                case 3: op = rv_op_vloxei32_v; break;
+                case 1: return &op_vluxei32_v;
+                case 2: return &op_vlse32_v;
+                case 3: return &op_vloxei32_v;
                 }
                 break;
             case 7:
                 switch ((inst >> 20) & 0b111111111111) {
-                case 40: op = rv_op_vl1re64_v; break;
-                case 552: op = rv_op_vl2re64_v; break;
-                case 1576: op = rv_op_vl4re64_v; break;
-                case 3624: op = rv_op_vl8re64_v; break;
+                case 40: return &op_vl1re64_v;
+                case 552: return &op_vl2re64_v;
+                case 1576: return &op_vl4re64_v;
+                case 3624: return &op_vl8re64_v;
                 }
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vle64_v; break;
-                    case 16: op = rv_op_vle64ff_v; break;
+                    case 0: return &op_vle64_v;
+                    case 16: return &op_vle64ff_v;
                     }
                     break;
-                case 1: op = rv_op_vluxei64_v; break;
-                case 2: op = rv_op_vlse64_v; break;
-                case 3: op = rv_op_vloxei64_v; break;
+                case 1: return &op_vluxei64_v;
+                case 2: return &op_vlse64_v;
+                case 3: return &op_vloxei64_v;
                 }
                 break;
             }
             break;
         case 3:
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_fence; break;
-            case 1: op = rv_op_fence_i; break;
+            case 0: return &op_fence;
+            case 1: return &op_fence_i;
             case 2:
                /*
                 * 'lq' shares the "(...) 010 ..... 0001111" opcode space
@@ -1320,204 +1292,203 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                 * Anything that doesn't match these will default to 'lq'.
                 */
                switch ((inst >> 17) & 0b11111) {
-               case 0: op = rv_op_cbo_inval; break;
-               case 1: op = rv_op_cbo_clean; break;
-               case 2: op = rv_op_cbo_flush; break;
-               case 4: op = rv_op_cbo_zero; break;
-               default: op = rv_op_lq; break;
+               case 0: return &op_cbo_inval;
+               case 1: return &op_cbo_clean;
+               case 2: return &op_cbo_flush;
+               case 4: return &op_cbo_zero;
+               default: return &op_lq;
                }
             }
             break;
         case 4:
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_addi; break;
+            case 0: return &op_addi;
             case 1:
                 switch ((inst >> 27) & 0b11111) {
-                case 0b00000: op = rv_op_slli; break;
+                case 0b00000: return &op_slli;
                 case 0b00001:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0001111: op = rv_op_zip; break;
+                    case 0b0001111: return &op_zip;
                     }
                     break;
                 case 0b00010:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0000000: op = rv_op_sha256sum0; break;
-                    case 0b0000001: op = rv_op_sha256sum1; break;
-                    case 0b0000010: op = rv_op_sha256sig0; break;
-                    case 0b0000011: op = rv_op_sha256sig1; break;
-                    case 0b0000100: op = rv_op_sha512sum0; break;
-                    case 0b0000101: op = rv_op_sha512sum1; break;
-                    case 0b0000110: op = rv_op_sha512sig0; break;
-                    case 0b0000111: op = rv_op_sha512sig1; break;
-                    case 0b0001000: op = rv_op_sm3p0; break;
-                    case 0b0001001: op = rv_op_sm3p1; break;
+                    case 0b0000000: return &op_sha256sum0;
+                    case 0b0000001: return &op_sha256sum1;
+                    case 0b0000010: return &op_sha256sig0;
+                    case 0b0000011: return &op_sha256sig1;
+                    case 0b0000100: return &op_sha512sum0;
+                    case 0b0000101: return &op_sha512sum1;
+                    case 0b0000110: return &op_sha512sig0;
+                    case 0b0000111: return &op_sha512sig1;
+                    case 0b0001000: return &op_sm3p0;
+                    case 0b0001001: return &op_sm3p1;
                     }
                     break;
-                case 0b00101: op = rv_op_bseti; break;
+                case 0b00101: return &op_bseti;
                 case 0b00110:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0000000: op = rv_op_aes64im; break;
+                    case 0b0000000: return &op_aes64im;
                     default:
                         if (((inst >> 24) & 0b0111) == 0b001) {
-                            op = rv_op_aes64ks1i;
+                            return &op_aes64ks1i;
                         }
                         break;
                      }
                      break;
-                case 0b01001: op = rv_op_bclri; break;
-                case 0b01101: op = rv_op_binvi; break;
+                case 0b01001: return &op_bclri;
+                case 0b01101: return &op_binvi;
                 case 0b01100:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0000000: op = rv_op_clz; break;
-                    case 0b0000001: op = rv_op_ctz; break;
-                    case 0b0000010: op = rv_op_cpop; break;
+                    case 0b0000000: return &op_clz;
+                    case 0b0000001: return &op_ctz;
+                    case 0b0000010: return &op_cpop;
                       /* 0b0000011 */
-                    case 0b0000100: op = rv_op_sext_b; break;
-                    case 0b0000101: op = rv_op_sext_h; break;
+                    case 0b0000100: return &op_sext_b;
+                    case 0b0000101: return &op_sext_h;
                     }
                     break;
                 }
                 break;
-            case 2: op = rv_op_slti; break;
-            case 3: op = rv_op_sltiu; break;
-            case 4: op = rv_op_xori; break;
+            case 2: return &op_slti;
+            case 3: return &op_sltiu;
+            case 4: return &op_xori;
             case 5:
                 switch ((inst >> 27) & 0b11111) {
-                case 0b00000: op = rv_op_srli; break;
+                case 0b00000: return &op_srli;
                 case 0b00001:
                     switch ((inst >> 20) & 0b1111111) {
-                    case 0b0001111: op = rv_op_unzip; break;
+                    case 0b0001111: return &op_unzip;
                     }
                     break;
-                case 0b00101: op = rv_op_orc_b; break;
-                case 0b01000: op = rv_op_srai; break;
-                case 0b01001: op = rv_op_bexti; break;
-                case 0b01100: op = rv_op_rori; break;
+                case 0b00101: return &op_orc_b;
+                case 0b01000: return &op_srai;
+                case 0b01001: return &op_bexti;
+                case 0b01100: return &op_rori;
                 case 0b01101:
                     switch ((inst >> 20) & 0b1111111) {
                     case 0b0011000:
                         if (isa == rv32) {
-                            op = rv_op_rev8;
+                            return &op_rev8;
                         }
                         break;
                     case 0b0111000:
                         if (isa == rv64) {
-                            op = rv_op_rev8;
+                            return &op_rev8;
                         }
                         break;
-                    case 0b0000111: op = rv_op_brev8; break;
+                    case 0b0000111: return &op_brev8;
                     }
                     break;
                 }
                 break;
-            case 6: op = rv_op_ori; break;
-            case 7: op = rv_op_andi; break;
+            case 6: return &op_ori;
+            case 7: return &op_andi;
             }
             break;
         case 5:
-            op = rv_op_auipc;
             if (dec->cfg && dec->cfg->ext_zicfilp &&
                 (((inst >> 7) & 0b11111) == 0b00000)) {
-                op = rv_op_lpad;
+                return &op_lpad;
             }
-            break;
+            return &op_auipc;
         case 6:
             /* OP-IMM-32 */
             if (isa == rv32) {
                 break;
             }
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_addiw; break;
+            case 0: return &op_addiw;
             case 1:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_slliw; break;
-                case 2: op = rv_op_slli_uw; break;
+                case 0: return &op_slliw;
+                case 2: return &op_slli_uw;
                 case 24:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0b00000: op = rv_op_clzw; break;
-                    case 0b00001: op = rv_op_ctzw; break;
-                    case 0b00010: op = rv_op_cpopw; break;
+                    case 0b00000: return &op_clzw;
+                    case 0b00001: return &op_ctzw;
+                    case 0b00010: return &op_cpopw;
                     }
                     break;
                 }
                 break;
             case 5:
                 switch ((inst >> 25) & 0b1111111) {
-                case 0: op = rv_op_srliw; break;
-                case 32: op = rv_op_sraiw; break;
-                case 48: op = rv_op_roriw; break;
+                case 0: return &op_srliw;
+                case 32: return &op_sraiw;
+                case 48: return &op_roriw;
                 }
                 break;
             }
             break;
         case 8:
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_sb; break;
-            case 1: op = rv_op_sh; break;
-            case 2: op = rv_op_sw; break;
-            case 3: op = rv_op_sd; break;
-            case 4: op = rv_op_sq; break;
+            case 0: return &op_sb;
+            case 1: return &op_sh;
+            case 2: return &op_sw;
+            case 3: return &op_sd;
+            case 4: return &op_sq;
             }
             break;
         case 9:
             switch ((inst >> 12) & 0b111) {
             case 0:
                 switch ((inst >> 20) & 0b111111111111) {
-                case 40: op = rv_op_vs1r_v; break;
-                case 552: op = rv_op_vs2r_v; break;
-                case 1576: op = rv_op_vs4r_v; break;
-                case 3624: op = rv_op_vs8r_v; break;
+                case 40: return &op_vs1r_v;
+                case 552: return &op_vs2r_v;
+                case 1576: return &op_vs4r_v;
+                case 3624: return &op_vs8r_v;
                 }
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vse8_v; break;
-                    case 11: op = rv_op_vsm_v; break;
+                    case 0: return &op_vse8_v;
+                    case 11: return &op_vsm_v;
                     }
                     break;
-                case 1: op = rv_op_vsuxei8_v; break;
-                case 2: op = rv_op_vsse8_v; break;
-                case 3: op = rv_op_vsoxei8_v; break;
+                case 1: return &op_vsuxei8_v;
+                case 2: return &op_vsse8_v;
+                case 3: return &op_vsoxei8_v;
                 }
                 break;
-            case 1: op = rv_op_fsh; break;
-            case 2: op = rv_op_fsw; break;
-            case 3: op = rv_op_fsd; break;
-            case 4: op = rv_op_fsq; break;
+            case 1: return &op_fsh;
+            case 2: return &op_fsw;
+            case 3: return &op_fsd;
+            case 4: return &op_fsq;
             case 5:
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vse16_v; break;
+                    case 0: return &op_vse16_v;
                     }
                     break;
-                case 1: op = rv_op_vsuxei16_v; break;
-                case 2: op = rv_op_vsse16_v; break;
-                case 3: op = rv_op_vsoxei16_v; break;
+                case 1: return &op_vsuxei16_v;
+                case 2: return &op_vsse16_v;
+                case 3: return &op_vsoxei16_v;
                 }
                 break;
             case 6:
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vse32_v; break;
+                    case 0: return &op_vse32_v;
                     }
                     break;
-                case 1: op = rv_op_vsuxei32_v; break;
-                case 2: op = rv_op_vsse32_v; break;
-                case 3: op = rv_op_vsoxei32_v; break;
+                case 1: return &op_vsuxei32_v;
+                case 2: return &op_vsse32_v;
+                case 3: return &op_vsoxei32_v;
                 }
                 break;
             case 7:
                 switch ((inst >> 26) & 0b111) {
                 case 0:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: op = rv_op_vse64_v; break;
+                    case 0: return &op_vse64_v;
                     }
                     break;
-                case 1: op = rv_op_vsuxei64_v; break;
-                case 2: op = rv_op_vsse64_v; break;
-                case 3: op = rv_op_vsoxei64_v; break;
+                case 1: return &op_vsuxei64_v;
+                case 2: return &op_vsse64_v;
+                case 3: return &op_vsoxei64_v;
                 }
                 break;
             }
@@ -1525,153 +1496,150 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
         case 11:
             switch (((inst >> 24) & 0b11111000) |
                     ((inst >> 12) & 0b00000111)) {
-            case 0: op = rv_op_amoadd_b; break;
-            case 1: op = rv_op_amoadd_h; break;
-            case 2: op = rv_op_amoadd_w; break;
-            case 3: op = rv_op_amoadd_d; break;
-            case 4: op = rv_op_amoadd_q; break;
-            case 8: op = rv_op_amoswap_b; break;
-            case 9: op = rv_op_amoswap_h; break;
-            case 10: op = rv_op_amoswap_w; break;
-            case 11: op = rv_op_amoswap_d; break;
-            case 12: op = rv_op_amoswap_q; break;
+            case 0: return &op_amoadd_b;
+            case 1: return &op_amoadd_h;
+            case 2: return &op_amoadd_w;
+            case 3: return &op_amoadd_d;
+            case 4: return &op_amoadd_q;
+            case 8: return &op_amoswap_b;
+            case 9: return &op_amoswap_h;
+            case 10: return &op_amoswap_w;
+            case 11: return &op_amoswap_d;
+            case 12: return &op_amoswap_q;
             case 18:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_lr_w; break;
+                case 0: return &op_lr_w;
                 }
                 break;
             case 19:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_lr_d; break;
+                case 0: return &op_lr_d;
                 }
                 break;
             case 20:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_lr_q; break;
+                case 0: return &op_lr_q;
                 }
                 break;
-            case 26: op = rv_op_sc_w; break;
-            case 27: op = rv_op_sc_d; break;
-            case 28: op = rv_op_sc_q; break;
-            case 32: op = rv_op_amoxor_b; break;
-            case 33: op = rv_op_amoxor_h; break;
-            case 34: op = rv_op_amoxor_w; break;
-            case 35: op = rv_op_amoxor_d; break;
-            case 36: op = rv_op_amoxor_q; break;
-            case 40: op = rv_op_amocas_b; break;
-            case 41: op = rv_op_amocas_h; break;
-            case 42: op = rv_op_amocas_w; break;
-            case 43: op = rv_op_amocas_d; break;
-            case 44: op = rv_op_amocas_q; break;
-            case 64: op = rv_op_amoor_b; break;
-            case 65: op = rv_op_amoor_h; break;
-            case 66: op = rv_op_amoor_w; break;
-            case 67: op = rv_op_amoor_d; break;
-            case 68: op = rv_op_amoor_q; break;
-            case 74: op = rv_op_ssamoswap_w; break;
-            case 75: op = rv_op_ssamoswap_d; break;
-            case 96: op = rv_op_amoand_b; break;
-            case 97: op = rv_op_amoand_h; break;
-            case 98: op = rv_op_amoand_w; break;
-            case 99: op = rv_op_amoand_d; break;
-            case 100: op = rv_op_amoand_q; break;
-            case 128: op = rv_op_amomin_b; break;
-            case 129: op = rv_op_amomin_h; break;
-            case 130: op = rv_op_amomin_w; break;
-            case 131: op = rv_op_amomin_d; break;
-            case 132: op = rv_op_amomin_q; break;
-            case 160: op = rv_op_amomax_b; break;
-            case 161: op = rv_op_amomax_h; break;
-            case 162: op = rv_op_amomax_w; break;
-            case 163: op = rv_op_amomax_d; break;
-            case 164: op = rv_op_amomax_q; break;
-            case 192: op = rv_op_amominu_b; break;
-            case 193: op = rv_op_amominu_h; break;
-            case 194: op = rv_op_amominu_w; break;
-            case 195: op = rv_op_amominu_d; break;
-            case 196: op = rv_op_amominu_q; break;
-            case 224: op = rv_op_amomaxu_b; break;
-            case 225: op = rv_op_amomaxu_h; break;
-            case 226: op = rv_op_amomaxu_w; break;
-            case 227: op = rv_op_amomaxu_d; break;
-            case 228: op = rv_op_amomaxu_q; break;
+            case 26: return &op_sc_w;
+            case 27: return &op_sc_d;
+            case 28: return &op_sc_q;
+            case 32: return &op_amoxor_b;
+            case 33: return &op_amoxor_h;
+            case 34: return &op_amoxor_w;
+            case 35: return &op_amoxor_d;
+            case 36: return &op_amoxor_q;
+            case 40: return &op_amocas_b;
+            case 41: return &op_amocas_h;
+            case 42: return &op_amocas_w;
+            case 43: return &op_amocas_d;
+            case 44: return &op_amocas_q;
+            case 64: return &op_amoor_b;
+            case 65: return &op_amoor_h;
+            case 66: return &op_amoor_w;
+            case 67: return &op_amoor_d;
+            case 68: return &op_amoor_q;
+            case 74: return &op_ssamoswap_w;
+            case 75: return &op_ssamoswap_d;
+            case 96: return &op_amoand_b;
+            case 97: return &op_amoand_h;
+            case 98: return &op_amoand_w;
+            case 99: return &op_amoand_d;
+            case 100: return &op_amoand_q;
+            case 128: return &op_amomin_b;
+            case 129: return &op_amomin_h;
+            case 130: return &op_amomin_w;
+            case 131: return &op_amomin_d;
+            case 132: return &op_amomin_q;
+            case 160: return &op_amomax_b;
+            case 161: return &op_amomax_h;
+            case 162: return &op_amomax_w;
+            case 163: return &op_amomax_d;
+            case 164: return &op_amomax_q;
+            case 192: return &op_amominu_b;
+            case 193: return &op_amominu_h;
+            case 194: return &op_amominu_w;
+            case 195: return &op_amominu_d;
+            case 196: return &op_amominu_q;
+            case 224: return &op_amomaxu_b;
+            case 225: return &op_amomaxu_h;
+            case 226: return &op_amomaxu_w;
+            case 227: return &op_amomaxu_d;
+            case 228: return &op_amomaxu_q;
             }
             break;
         case 12:
             switch (((inst >> 22) & 0b1111111000) |
                     ((inst >> 12) & 0b0000000111)) {
-            case 0: op = rv_op_add; break;
-            case 1: op = rv_op_sll; break;
-            case 2: op = rv_op_slt; break;
-            case 3: op = rv_op_sltu; break;
-            case 4: op = rv_op_xor; break;
-            case 5: op = rv_op_srl; break;
-            case 6: op = rv_op_or; break;
-            case 7: op = rv_op_and; break;
-            case 8: op = rv_op_mul; break;
-            case 9: op = rv_op_mulh; break;
-            case 10: op = rv_op_mulhsu; break;
-            case 11: op = rv_op_mulhu; break;
-            case 12: op = rv_op_div; break;
-            case 13: op = rv_op_divu; break;
-            case 14: op = rv_op_rem; break;
-            case 15: op = rv_op_remu; break;
+            case 0: return &op_add;
+            case 1: return &op_sll;
+            case 2: return &op_slt;
+            case 3: return &op_sltu;
+            case 4: return &op_xor;
+            case 5: return &op_srl;
+            case 6: return &op_or;
+            case 7: return &op_and;
+            case 8: return &op_mul;
+            case 9: return &op_mulh;
+            case 10: return &op_mulhsu;
+            case 11: return &op_mulhu;
+            case 12: return &op_div;
+            case 13: return &op_divu;
+            case 14: return &op_rem;
+            case 15: return &op_remu;
             case 36:
                 if (isa == rv32 && !((inst >> 20) & 0b11111)) {
-                    op = rv_op_zext_h;
-                } else {
-                    op = rv_op_pack;
+                    return &op_zext_h;
                 }
-                break;
-            case 39: op = rv_op_packh; break;
-
-            case 41: op = rv_op_clmul; break;
-            case 42: op = rv_op_clmulr; break;
-            case 43: op = rv_op_clmulh; break;
-            case 44: op = rv_op_min; break;
-            case 45: op = rv_op_minu; break;
-            case 46: op = rv_op_max; break;
-            case 47: op = rv_op_maxu; break;
-            case 075: op = rv_op_czero_eqz; break;
-            case 077: op = rv_op_czero_nez; break;
-            case 130: op = rv_op_sh1add; break;
-            case 132: op = rv_op_sh2add; break;
-            case 134: op = rv_op_sh3add; break;
-            case 161: op = rv_op_bset; break;
-            case 162: op = rv_op_xperm4; break;
-            case 164: op = rv_op_xperm8; break;
-            case 200: op = rv_op_aes64es; break;
-            case 216: op = rv_op_aes64esm; break;
-            case 232: op = rv_op_aes64ds; break;
-            case 248: op = rv_op_aes64dsm; break;
-            case 256: op = rv_op_sub; break;
-            case 260: op = rv_op_xnor; break;
-            case 261: op = rv_op_sra; break;
-            case 262: op = rv_op_orn; break;
-            case 263: op = rv_op_andn; break;
-            case 289: op = rv_op_bclr; break;
-            case 293: op = rv_op_bext; break;
-            case 320: op = rv_op_sha512sum0r; break;
-            case 328: op = rv_op_sha512sum1r; break;
-            case 336: op = rv_op_sha512sig0l; break;
-            case 344: op = rv_op_sha512sig1l; break;
-            case 368: op = rv_op_sha512sig0h; break;
-            case 376: op = rv_op_sha512sig1h; break;
-            case 385: op = rv_op_rol; break;
-            case 389: op = rv_op_ror; break;
-            case 417: op = rv_op_binv; break;
-            case 504: op = rv_op_aes64ks2; break;
+                return &op_pack;
+            case 39: return &op_packh;
+            case 41: return &op_clmul;
+            case 42: return &op_clmulr;
+            case 43: return &op_clmulh;
+            case 44: return &op_min;
+            case 45: return &op_minu;
+            case 46: return &op_max;
+            case 47: return &op_maxu;
+            case 075: return &op_czero_eqz;
+            case 077: return &op_czero_nez;
+            case 130: return &op_sh1add;
+            case 132: return &op_sh2add;
+            case 134: return &op_sh3add;
+            case 161: return &op_bset;
+            case 162: return &op_xperm4;
+            case 164: return &op_xperm8;
+            case 200: return &op_aes64es;
+            case 216: return &op_aes64esm;
+            case 232: return &op_aes64ds;
+            case 248: return &op_aes64dsm;
+            case 256: return &op_sub;
+            case 260: return &op_xnor;
+            case 261: return &op_sra;
+            case 262: return &op_orn;
+            case 263: return &op_andn;
+            case 289: return &op_bclr;
+            case 293: return &op_bext;
+            case 320: return &op_sha512sum0r;
+            case 328: return &op_sha512sum1r;
+            case 336: return &op_sha512sig0l;
+            case 344: return &op_sha512sig1l;
+            case 368: return &op_sha512sig0h;
+            case 376: return &op_sha512sig1h;
+            case 385: return &op_rol;
+            case 389: return &op_ror;
+            case 417: return &op_binv;
+            case 504: return &op_aes64ks2;
             }
             switch ((inst >> 25) & 0b0011111) {
-            case 17: op = rv_op_aes32esi; break;
-            case 19: op = rv_op_aes32esmi; break;
-            case 21: op = rv_op_aes32dsi; break;
-            case 23: op = rv_op_aes32dsmi; break;
-            case 24: op = rv_op_sm4ed; break;
-            case 26: op = rv_op_sm4ks; break;
+            case 17: return &op_aes32esi;
+            case 19: return &op_aes32esmi;
+            case 21: return &op_aes32dsi;
+            case 23: return &op_aes32dsmi;
+            case 24: return &op_sm4ed;
+            case 26: return &op_sm4ks;
             }
             break;
-        case 13: op = rv_op_lui; break;
+        case 13: return &op_lui;
         case 14:
             /* OP-32 */
             if (isa == rv32) {
@@ -1679,317 +1647,317 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             }
             switch (((inst >> 22) & 0b1111111000) |
                     ((inst >> 12) & 0b0000000111)) {
-            case 0: op = rv_op_addw; break;
-            case 1: op = rv_op_sllw; break;
-            case 5: op = rv_op_srlw; break;
-            case 8: op = rv_op_mulw; break;
-            case 12: op = rv_op_divw; break;
-            case 13: op = rv_op_divuw; break;
-            case 14: op = rv_op_remw; break;
-            case 15: op = rv_op_remuw; break;
-            case 32: op = rv_op_add_uw; break;
+            case 0: return &op_addw;
+            case 1: return &op_sllw;
+            case 5: return &op_srlw;
+            case 8: return &op_mulw;
+            case 12: return &op_divw;
+            case 13: return &op_divuw;
+            case 14: return &op_remw;
+            case 15: return &op_remuw;
+            case 32: return &op_add_uw;
             case 36:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_zext_h; break;
-                default: op = rv_op_packw; break;
+                case 0: return &op_zext_h;
+                default: return &op_packw;
                 }
                 break;
-            case 130: op = rv_op_sh1add_uw; break;
-            case 132: op = rv_op_sh2add_uw; break;
-            case 134: op = rv_op_sh3add_uw; break;
-            case 256: op = rv_op_subw; break;
-            case 261: op = rv_op_sraw; break;
-            case 385: op = rv_op_rolw; break;
-            case 389: op = rv_op_rorw; break;
+            case 130: return &op_sh1add_uw;
+            case 132: return &op_sh2add_uw;
+            case 134: return &op_sh3add_uw;
+            case 256: return &op_subw;
+            case 261: return &op_sraw;
+            case 385: return &op_rolw;
+            case 389: return &op_rorw;
             }
             break;
         case 16:
             switch ((inst >> 25) & 0b11) {
-            case 0: op = rv_op_fmadd_s; break;
-            case 1: op = rv_op_fmadd_d; break;
-            case 3: op = rv_op_fmadd_q; break;
+            case 0: return &op_fmadd_s;
+            case 1: return &op_fmadd_d;
+            case 3: return &op_fmadd_q;
             }
             break;
         case 17:
             switch ((inst >> 25) & 0b11) {
-            case 0: op = rv_op_fmsub_s; break;
-            case 1: op = rv_op_fmsub_d; break;
-            case 3: op = rv_op_fmsub_q; break;
+            case 0: return &op_fmsub_s;
+            case 1: return &op_fmsub_d;
+            case 3: return &op_fmsub_q;
             }
             break;
         case 18:
             switch ((inst >> 25) & 0b11) {
-            case 0: op = rv_op_fnmsub_s; break;
-            case 1: op = rv_op_fnmsub_d; break;
-            case 3: op = rv_op_fnmsub_q; break;
+            case 0: return &op_fnmsub_s;
+            case 1: return &op_fnmsub_d;
+            case 3: return &op_fnmsub_q;
             }
             break;
         case 19:
             switch ((inst >> 25) & 0b11) {
-            case 0: op = rv_op_fnmadd_s; break;
-            case 1: op = rv_op_fnmadd_d; break;
-            case 3: op = rv_op_fnmadd_q; break;
+            case 0: return &op_fnmadd_s;
+            case 1: return &op_fnmadd_d;
+            case 3: return &op_fnmadd_q;
             }
             break;
         case 20:
             switch ((inst >> 25) & 0b1111111) {
-            case 0: op = rv_op_fadd_s; break;
-            case 1: op = rv_op_fadd_d; break;
-            case 3: op = rv_op_fadd_q; break;
-            case 4: op = rv_op_fsub_s; break;
-            case 5: op = rv_op_fsub_d; break;
-            case 7: op = rv_op_fsub_q; break;
-            case 8: op = rv_op_fmul_s; break;
-            case 9: op = rv_op_fmul_d; break;
-            case 11: op = rv_op_fmul_q; break;
-            case 12: op = rv_op_fdiv_s; break;
-            case 13: op = rv_op_fdiv_d; break;
-            case 15: op = rv_op_fdiv_q; break;
+            case 0: return &op_fadd_s;
+            case 1: return &op_fadd_d;
+            case 3: return &op_fadd_q;
+            case 4: return &op_fsub_s;
+            case 5: return &op_fsub_d;
+            case 7: return &op_fsub_q;
+            case 8: return &op_fmul_s;
+            case 9: return &op_fmul_d;
+            case 11: return &op_fmul_q;
+            case 12: return &op_fdiv_s;
+            case 13: return &op_fdiv_d;
+            case 15: return &op_fdiv_q;
             case 16:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fsgnj_s; break;
-                case 1: op = rv_op_fsgnjn_s; break;
-                case 2: op = rv_op_fsgnjx_s; break;
+                case 0: return &op_fsgnj_s;
+                case 1: return &op_fsgnjn_s;
+                case 2: return &op_fsgnjx_s;
                 }
                 break;
             case 17:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fsgnj_d; break;
-                case 1: op = rv_op_fsgnjn_d; break;
-                case 2: op = rv_op_fsgnjx_d; break;
+                case 0: return &op_fsgnj_d;
+                case 1: return &op_fsgnjn_d;
+                case 2: return &op_fsgnjx_d;
                 }
                 break;
             case 19:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fsgnj_q; break;
-                case 1: op = rv_op_fsgnjn_q; break;
-                case 2: op = rv_op_fsgnjx_q; break;
+                case 0: return &op_fsgnj_q;
+                case 1: return &op_fsgnjn_q;
+                case 2: return &op_fsgnjx_q;
                 }
                 break;
             case 20:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fmin_s; break;
-                case 1: op = rv_op_fmax_s; break;
-                case 2: op = rv_op_fminm_s; break;
-                case 3: op = rv_op_fmaxm_s; break;
+                case 0: return &op_fmin_s;
+                case 1: return &op_fmax_s;
+                case 2: return &op_fminm_s;
+                case 3: return &op_fmaxm_s;
                 }
                 break;
             case 21:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fmin_d; break;
-                case 1: op = rv_op_fmax_d; break;
-                case 2: op = rv_op_fminm_d; break;
-                case 3: op = rv_op_fmaxm_d; break;
+                case 0: return &op_fmin_d;
+                case 1: return &op_fmax_d;
+                case 2: return &op_fminm_d;
+                case 3: return &op_fmaxm_d;
                 }
                 break;
             case 22:
                 switch (((inst >> 12) & 0b111)) {
-                case 2: op = rv_op_fminm_h; break;
-                case 3: op = rv_op_fmaxm_h; break;
+                case 2: return &op_fminm_h;
+                case 3: return &op_fmaxm_h;
                 }
                 break;
             case 23:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fmin_q; break;
-                case 1: op = rv_op_fmax_q; break;
-                case 2: op = rv_op_fminm_q; break;
-                case 3: op = rv_op_fmaxm_q; break;
+                case 0: return &op_fmin_q;
+                case 1: return &op_fmax_q;
+                case 2: return &op_fminm_q;
+                case 3: return &op_fmaxm_q;
                 }
                 break;
             case 32:
                 switch ((inst >> 20) & 0b11111) {
-                case 1: op = rv_op_fcvt_s_d; break;
-                case 3: op = rv_op_fcvt_s_q; break;
-                case 4: op = rv_op_fround_s; break;
-                case 5: op = rv_op_froundnx_s; break;
-                case 6: op = rv_op_fcvt_s_bf16; break;
+                case 1: return &op_fcvt_s_d;
+                case 3: return &op_fcvt_s_q;
+                case 4: return &op_fround_s;
+                case 5: return &op_froundnx_s;
+                case 6: return &op_fcvt_s_bf16;
                 }
                 break;
             case 33:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_d_s; break;
-                case 3: op = rv_op_fcvt_d_q; break;
-                case 4: op = rv_op_fround_d; break;
-                case 5: op = rv_op_froundnx_d; break;
+                case 0: return &op_fcvt_d_s;
+                case 3: return &op_fcvt_d_q;
+                case 4: return &op_fround_d;
+                case 5: return &op_froundnx_d;
                 }
                 break;
             case 34:
                 switch (((inst >> 20) & 0b11111)) {
-                case 4: op = rv_op_fround_h; break;
-                case 5: op = rv_op_froundnx_h; break;
-                case 8: op = rv_op_fcvt_bf16_s; break;
+                case 4: return &op_fround_h;
+                case 5: return &op_froundnx_h;
+                case 8: return &op_fcvt_bf16_s;
                 }
                 break;
             case 35:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_q_s; break;
-                case 1: op = rv_op_fcvt_q_d; break;
-                case 4: op = rv_op_fround_q; break;
-                case 5: op = rv_op_froundnx_q; break;
+                case 0: return &op_fcvt_q_s;
+                case 1: return &op_fcvt_q_d;
+                case 4: return &op_fround_q;
+                case 5: return &op_froundnx_q;
                 }
                 break;
             case 44:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fsqrt_s; break;
+                case 0: return &op_fsqrt_s;
                 }
                 break;
             case 45:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fsqrt_d; break;
+                case 0: return &op_fsqrt_d;
                 }
                 break;
             case 47:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fsqrt_q; break;
+                case 0: return &op_fsqrt_q;
                 }
                 break;
             case 80:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fle_s; break;
-                case 1: op = rv_op_flt_s; break;
-                case 2: op = rv_op_feq_s; break;
-                case 4: op = rv_op_fleq_s; break;
-                case 5: op = rv_op_fltq_s; break;
+                case 0: return &op_fle_s;
+                case 1: return &op_flt_s;
+                case 2: return &op_feq_s;
+                case 4: return &op_fleq_s;
+                case 5: return &op_fltq_s;
                 }
                 break;
             case 81:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fle_d; break;
-                case 1: op = rv_op_flt_d; break;
-                case 2: op = rv_op_feq_d; break;
-                case 4: op = rv_op_fleq_d; break;
-                case 5: op = rv_op_fltq_d; break;
+                case 0: return &op_fle_d;
+                case 1: return &op_flt_d;
+                case 2: return &op_feq_d;
+                case 4: return &op_fleq_d;
+                case 5: return &op_fltq_d;
                 }
                 break;
             case 82:
                 switch (((inst >> 12) & 0b111)) {
-                case 4: op = rv_op_fleq_h; break;
-                case 5: op = rv_op_fltq_h; break;
+                case 4: return &op_fleq_h;
+                case 5: return &op_fltq_h;
                 }
                 break;
             case 83:
                 switch ((inst >> 12) & 0b111) {
-                case 0: op = rv_op_fle_q; break;
-                case 1: op = rv_op_flt_q; break;
-                case 2: op = rv_op_feq_q; break;
-                case 4: op = rv_op_fleq_q; break;
-                case 5: op = rv_op_fltq_q; break;
+                case 0: return &op_fle_q;
+                case 1: return &op_flt_q;
+                case 2: return &op_feq_q;
+                case 4: return &op_fleq_q;
+                case 5: return &op_fltq_q;
                 }
                 break;
             case 89:
                 switch (((inst >> 12) & 0b111)) {
-                case 0: op = rv_op_fmvp_d_x; break;
+                case 0: return &op_fmvp_d_x;
                 }
                 break;
             case 91:
                 switch (((inst >> 12) & 0b111)) {
-                case 0: op = rv_op_fmvp_q_x; break;
+                case 0: return &op_fmvp_q_x;
                 }
                 break;
             case 96:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_w_s; break;
-                case 1: op = rv_op_fcvt_wu_s; break;
-                case 2: op = rv_op_fcvt_l_s; break;
-                case 3: op = rv_op_fcvt_lu_s; break;
+                case 0: return &op_fcvt_w_s;
+                case 1: return &op_fcvt_wu_s;
+                case 2: return &op_fcvt_l_s;
+                case 3: return &op_fcvt_lu_s;
                 }
                 break;
             case 97:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_w_d; break;
-                case 1: op = rv_op_fcvt_wu_d; break;
-                case 2: op = rv_op_fcvt_l_d; break;
-                case 3: op = rv_op_fcvt_lu_d; break;
-                case 8: op = rv_op_fcvtmod_w_d; break;
+                case 0: return &op_fcvt_w_d;
+                case 1: return &op_fcvt_wu_d;
+                case 2: return &op_fcvt_l_d;
+                case 3: return &op_fcvt_lu_d;
+                case 8: return &op_fcvtmod_w_d;
                 }
                 break;
             case 99:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_w_q; break;
-                case 1: op = rv_op_fcvt_wu_q; break;
-                case 2: op = rv_op_fcvt_l_q; break;
-                case 3: op = rv_op_fcvt_lu_q; break;
+                case 0: return &op_fcvt_w_q;
+                case 1: return &op_fcvt_wu_q;
+                case 2: return &op_fcvt_l_q;
+                case 3: return &op_fcvt_lu_q;
                 }
                 break;
             case 104:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_s_w; break;
-                case 1: op = rv_op_fcvt_s_wu; break;
-                case 2: op = rv_op_fcvt_s_l; break;
-                case 3: op = rv_op_fcvt_s_lu; break;
+                case 0: return &op_fcvt_s_w;
+                case 1: return &op_fcvt_s_wu;
+                case 2: return &op_fcvt_s_l;
+                case 3: return &op_fcvt_s_lu;
                 }
                 break;
             case 105:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_d_w; break;
-                case 1: op = rv_op_fcvt_d_wu; break;
-                case 2: op = rv_op_fcvt_d_l; break;
-                case 3: op = rv_op_fcvt_d_lu; break;
+                case 0: return &op_fcvt_d_w;
+                case 1: return &op_fcvt_d_wu;
+                case 2: return &op_fcvt_d_l;
+                case 3: return &op_fcvt_d_lu;
                 }
                 break;
             case 107:
                 switch ((inst >> 20) & 0b11111) {
-                case 0: op = rv_op_fcvt_q_w; break;
-                case 1: op = rv_op_fcvt_q_wu; break;
-                case 2: op = rv_op_fcvt_q_l; break;
-                case 3: op = rv_op_fcvt_q_lu; break;
+                case 0: return &op_fcvt_q_w;
+                case 1: return &op_fcvt_q_wu;
+                case 2: return &op_fcvt_q_l;
+                case 3: return &op_fcvt_q_lu;
                 }
                 break;
             case 112:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_x_s; break;
-                case 1: op = rv_op_fclass_s; break;
+                case 0: return &op_fmv_x_s;
+                case 1: return &op_fclass_s;
                 }
                 break;
             case 113:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_x_d; break;
-                case 1: op = rv_op_fclass_d; break;
-                case 8: op = rv_op_fmvh_x_d; break;
+                case 0: return &op_fmv_x_d;
+                case 1: return &op_fclass_d;
+                case 8: return &op_fmvh_x_d;
                 }
                 break;
             case 114:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_x_h; break;
+                case 0: return &op_fmv_x_h;
                 }
                 break;
             case 115:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_x_q; break;
-                case 1: op = rv_op_fclass_q; break;
-                case 8: op = rv_op_fmvh_x_q; break;
+                case 0: return &op_fmv_x_q;
+                case 1: return &op_fclass_q;
+                case 8: return &op_fmvh_x_q;
                 }
                 break;
             case 120:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_s_x; break;
-                case 8: op = rv_op_fli_s; break;
+                case 0: return &op_fmv_s_x;
+                case 8: return &op_fli_s;
                 }
                 break;
             case 121:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_d_x; break;
-                case 8: op = rv_op_fli_d; break;
+                case 0: return &op_fmv_d_x;
+                case 8: return &op_fli_d;
                 }
                 break;
             case 122:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_h_x; break;
-                case 8: op = rv_op_fli_h; break;
+                case 0: return &op_fmv_h_x;
+                case 8: return &op_fli_h;
                 }
                 break;
             case 123:
                 switch (((inst >> 17) & 0b11111000) |
                         ((inst >> 12) & 0b00000111)) {
-                case 0: op = rv_op_fmv_q_x; break;
-                case 8: op = rv_op_fli_q; break;
+                case 0: return &op_fmv_q_x;
+                case 8: return &op_fli_q;
                 }
                 break;
             }
@@ -1998,484 +1966,537 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
             switch ((inst >> 12) & 0b111) {
             case 0:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_vadd_vv; break;
-                case 1: op = rv_op_vandn_vv; break;
-                case 2: op = rv_op_vsub_vv; break;
-                case 4: op = rv_op_vminu_vv; break;
-                case 5: op = rv_op_vmin_vv; break;
-                case 6: op = rv_op_vmaxu_vv; break;
-                case 7: op = rv_op_vmax_vv; break;
-                case 9: op = rv_op_vand_vv; break;
-                case 10: op = rv_op_vor_vv; break;
-                case 11: op = rv_op_vxor_vv; break;
-                case 12: op = rv_op_vrgather_vv; break;
-                case 14: op = rv_op_vrgatherei16_vv; break;
+                case 0: return &op_vadd_vv;
+                case 1: return &op_vandn_vv;
+                case 2: return &op_vsub_vv;
+                case 4: return &op_vminu_vv;
+                case 5: return &op_vmin_vv;
+                case 6: return &op_vmaxu_vv;
+                case 7: return &op_vmax_vv;
+                case 9: return &op_vand_vv;
+                case 10: return &op_vor_vv;
+                case 11: return &op_vxor_vv;
+                case 12: return &op_vrgather_vv;
+                case 14: return &op_vrgatherei16_vv;
                 case 16:
                     if (((inst >> 25) & 1) == 0) {
-                        op = rv_op_vadc_vvm;
+                        return &op_vadc_vvm;
                     }
                     break;
-                case 17: op = rv_op_vmadc_vvm; break;
+                case 17: return &op_vmadc_vvm;
                 case 18:
                     if (((inst >> 25) & 1) == 0) {
-                        op = rv_op_vsbc_vvm;
+                        return &op_vsbc_vvm;
                     }
                     break;
-                case 19: op = rv_op_vmsbc_vvm; break;
-                case 20: op = rv_op_vror_vv; break;
-                case 21: op = rv_op_vrol_vv; break;
+                case 19: return &op_vmsbc_vvm;
+                case 20: return &op_vror_vv;
+                case 21: return &op_vrol_vv;
                 case 23:
-                    if (((inst >> 20) & 0b111111) == 32)
-                        op = rv_op_vmv_v_v;
-                    else if (((inst >> 25) & 1) == 0)
-                        op = rv_op_vmerge_vvm;
+                    if (((inst >> 20) & 0b111111) == 32) {
+                        return &op_vmv_v_v;
+                    } else if (((inst >> 25) & 1) == 0) {
+                        return &op_vmerge_vvm;
+                    }
                     break;
-                case 24: op = rv_op_vmseq_vv; break;
-                case 25: op = rv_op_vmsne_vv; break;
-                case 26: op = rv_op_vmsltu_vv; break;
-                case 27: op = rv_op_vmslt_vv; break;
-                case 28: op = rv_op_vmsleu_vv; break;
-                case 29: op = rv_op_vmsle_vv; break;
-                case 32: op = rv_op_vsaddu_vv; break;
-                case 33: op = rv_op_vsadd_vv; break;
-                case 34: op = rv_op_vssubu_vv; break;
-                case 35: op = rv_op_vssub_vv; break;
-                case 37: op = rv_op_vsll_vv; break;
-                case 39: op = rv_op_vsmul_vv; break;
-                case 40: op = rv_op_vsrl_vv; break;
-                case 41: op = rv_op_vsra_vv; break;
-                case 42: op = rv_op_vssrl_vv; break;
-                case 43: op = rv_op_vssra_vv; break;
-                case 44: op = rv_op_vnsrl_wv; break;
-                case 45: op = rv_op_vnsra_wv; break;
-                case 46: op = rv_op_vnclipu_wv; break;
-                case 47: op = rv_op_vnclip_wv; break;
-                case 48: op = rv_op_vwredsumu_vs; break;
-                case 49: op = rv_op_vwredsum_vs; break;
-                case 53: op = rv_op_vwsll_vv; break;
+                case 24: return &op_vmseq_vv;
+                case 25: return &op_vmsne_vv;
+                case 26: return &op_vmsltu_vv;
+                case 27: return &op_vmslt_vv;
+                case 28: return &op_vmsleu_vv;
+                case 29: return &op_vmsle_vv;
+                case 32: return &op_vsaddu_vv;
+                case 33: return &op_vsadd_vv;
+                case 34: return &op_vssubu_vv;
+                case 35: return &op_vssub_vv;
+                case 37: return &op_vsll_vv;
+                case 39: return &op_vsmul_vv;
+                case 40: return &op_vsrl_vv;
+                case 41: return &op_vsra_vv;
+                case 42: return &op_vssrl_vv;
+                case 43: return &op_vssra_vv;
+                case 44: return &op_vnsrl_wv;
+                case 45: return &op_vnsra_wv;
+                case 46: return &op_vnclipu_wv;
+                case 47: return &op_vnclip_wv;
+                case 48: return &op_vwredsumu_vs;
+                case 49: return &op_vwredsum_vs;
+                case 53: return &op_vwsll_vv;
                 }
                 break;
             case 1:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_vfadd_vv; break;
-                case 1: op = rv_op_vfredusum_vs; break;
-                case 2: op = rv_op_vfsub_vv; break;
-                case 3: op = rv_op_vfredosum_vs; break;
-                case 4: op = rv_op_vfmin_vv; break;
-                case 5: op = rv_op_vfredmin_vs; break;
-                case 6: op = rv_op_vfmax_vv; break;
-                case 7: op = rv_op_vfredmax_vs; break;
-                case 8: op = rv_op_vfsgnj_vv; break;
-                case 9: op = rv_op_vfsgnjn_vv; break;
-                case 10: op = rv_op_vfsgnjx_vv; break;
+                case 0: return &op_vfadd_vv;
+                case 1: return &op_vfredusum_vs;
+                case 2: return &op_vfsub_vv;
+                case 3: return &op_vfredosum_vs;
+                case 4: return &op_vfmin_vv;
+                case 5: return &op_vfredmin_vs;
+                case 6: return &op_vfmax_vv;
+                case 7: return &op_vfredmax_vs;
+                case 8: return &op_vfsgnj_vv;
+                case 9: return &op_vfsgnjn_vv;
+                case 10: return &op_vfsgnjx_vv;
                 case 16:
                     switch ((inst >> 15) & 0b11111) {
-                    case 0: if ((inst >> 25) & 1) op = rv_op_vfmv_f_s; break;
+                    case 0:
+                        if ((inst >> 25) & 1) {
+                            return &op_vfmv_f_s;
+                        }
                     }
                     break;
                 case 18:
                     switch ((inst >> 15) & 0b11111) {
-                    case 0: op = rv_op_vfcvt_xu_f_v; break;
-                    case 1: op = rv_op_vfcvt_x_f_v; break;
-                    case 2: op = rv_op_vfcvt_f_xu_v; break;
-                    case 3: op = rv_op_vfcvt_f_x_v; break;
-                    case 6: op = rv_op_vfcvt_rtz_xu_f_v; break;
-                    case 7: op = rv_op_vfcvt_rtz_x_f_v; break;
-                    case 8: op = rv_op_vfwcvt_xu_f_v; break;
-                    case 9: op = rv_op_vfwcvt_x_f_v; break;
-                    case 10: op = rv_op_vfwcvt_f_xu_v; break;
-                    case 11: op = rv_op_vfwcvt_f_x_v; break;
-                    case 12: op = rv_op_vfwcvt_f_f_v; break;
-                    case 13: op = rv_op_vfwcvtbf16_f_f_v; break;
-                    case 14: op = rv_op_vfwcvt_rtz_xu_f_v; break;
-                    case 15: op = rv_op_vfwcvt_rtz_x_f_v; break;
-                    case 16: op = rv_op_vfncvt_xu_f_w; break;
-                    case 17: op = rv_op_vfncvt_x_f_w; break;
-                    case 18: op = rv_op_vfncvt_f_xu_w; break;
-                    case 19: op = rv_op_vfncvt_f_x_w; break;
-                    case 20: op = rv_op_vfncvt_f_f_w; break;
-                    case 21: op = rv_op_vfncvt_rod_f_f_w; break;
-                    case 22: op = rv_op_vfncvt_rtz_xu_f_w; break;
-                    case 23: op = rv_op_vfncvt_rtz_x_f_w; break;
-                    case 29: op = rv_op_vfncvtbf16_f_f_w; break;
+                    case 0: return &op_vfcvt_xu_f_v;
+                    case 1: return &op_vfcvt_x_f_v;
+                    case 2: return &op_vfcvt_f_xu_v;
+                    case 3: return &op_vfcvt_f_x_v;
+                    case 6: return &op_vfcvt_rtz_xu_f_v;
+                    case 7: return &op_vfcvt_rtz_x_f_v;
+                    case 8: return &op_vfwcvt_xu_f_v;
+                    case 9: return &op_vfwcvt_x_f_v;
+                    case 10: return &op_vfwcvt_f_xu_v;
+                    case 11: return &op_vfwcvt_f_x_v;
+                    case 12: return &op_vfwcvt_f_f_v;
+                    case 13: return &op_vfwcvtbf16_f_f_v;
+                    case 14: return &op_vfwcvt_rtz_xu_f_v;
+                    case 15: return &op_vfwcvt_rtz_x_f_v;
+                    case 16: return &op_vfncvt_xu_f_w;
+                    case 17: return &op_vfncvt_x_f_w;
+                    case 18: return &op_vfncvt_f_xu_w;
+                    case 19: return &op_vfncvt_f_x_w;
+                    case 20: return &op_vfncvt_f_f_w;
+                    case 21: return &op_vfncvt_rod_f_f_w;
+                    case 22: return &op_vfncvt_rtz_xu_f_w;
+                    case 23: return &op_vfncvt_rtz_x_f_w;
+                    case 29: return &op_vfncvtbf16_f_f_w;
                     }
                     break;
                 case 19:
                     switch ((inst >> 15) & 0b11111) {
-                    case 0: op = rv_op_vfsqrt_v; break;
-                    case 4: op = rv_op_vfrsqrt7_v; break;
-                    case 5: op = rv_op_vfrec7_v; break;
-                    case 16: op = rv_op_vfclass_v; break;
+                    case 0: return &op_vfsqrt_v;
+                    case 4: return &op_vfrsqrt7_v;
+                    case 5: return &op_vfrec7_v;
+                    case 16: return &op_vfclass_v;
                     }
                     break;
-                case 24: op = rv_op_vmfeq_vv; break;
-                case 25: op = rv_op_vmfle_vv; break;
-                case 27: op = rv_op_vmflt_vv; break;
-                case 28: op = rv_op_vmfne_vv; break;
-                case 32: op = rv_op_vfdiv_vv; break;
-                case 36: op = rv_op_vfmul_vv; break;
-                case 40: op = rv_op_vfmadd_vv; break;
-                case 41: op = rv_op_vfnmadd_vv; break;
-                case 42: op = rv_op_vfmsub_vv; break;
-                case 43: op = rv_op_vfnmsub_vv; break;
-                case 44: op = rv_op_vfmacc_vv; break;
-                case 45: op = rv_op_vfnmacc_vv; break;
-                case 46: op = rv_op_vfmsac_vv; break;
-                case 47: op = rv_op_vfnmsac_vv; break;
-                case 48: op = rv_op_vfwadd_vv; break;
-                case 49: op = rv_op_vfwredusum_vs; break;
-                case 50: op = rv_op_vfwsub_vv; break;
-                case 51: op = rv_op_vfwredosum_vs; break;
-                case 52: op = rv_op_vfwadd_wv; break;
-                case 54: op = rv_op_vfwsub_wv; break;
-                case 56: op = rv_op_vfwmul_vv; break;
-                case 59: op = rv_op_vfwmaccbf16_vv; break;
-                case 60: op = rv_op_vfwmacc_vv; break;
-                case 61: op = rv_op_vfwnmacc_vv; break;
-                case 62: op = rv_op_vfwmsac_vv; break;
-                case 63: op = rv_op_vfwnmsac_vv; break;
+                case 24: return &op_vmfeq_vv;
+                case 25: return &op_vmfle_vv;
+                case 27: return &op_vmflt_vv;
+                case 28: return &op_vmfne_vv;
+                case 32: return &op_vfdiv_vv;
+                case 36: return &op_vfmul_vv;
+                case 40: return &op_vfmadd_vv;
+                case 41: return &op_vfnmadd_vv;
+                case 42: return &op_vfmsub_vv;
+                case 43: return &op_vfnmsub_vv;
+                case 44: return &op_vfmacc_vv;
+                case 45: return &op_vfnmacc_vv;
+                case 46: return &op_vfmsac_vv;
+                case 47: return &op_vfnmsac_vv;
+                case 48: return &op_vfwadd_vv;
+                case 49: return &op_vfwredusum_vs;
+                case 50: return &op_vfwsub_vv;
+                case 51: return &op_vfwredosum_vs;
+                case 52: return &op_vfwadd_wv;
+                case 54: return &op_vfwsub_wv;
+                case 56: return &op_vfwmul_vv;
+                case 59: return &op_vfwmaccbf16_vv;
+                case 60: return &op_vfwmacc_vv;
+                case 61: return &op_vfwnmacc_vv;
+                case 62: return &op_vfwmsac_vv;
+                case 63: return &op_vfwnmsac_vv;
                 }
                 break;
             case 2:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_vredsum_vs; break;
-                case 1: op = rv_op_vredand_vs; break;
-                case 2: op = rv_op_vredor_vs; break;
-                case 3: op = rv_op_vredxor_vs; break;
-                case 4: op = rv_op_vredminu_vs; break;
-                case 5: op = rv_op_vredmin_vs; break;
-                case 6: op = rv_op_vredmaxu_vs; break;
-                case 7: op = rv_op_vredmax_vs; break;
-                case 8: op = rv_op_vaaddu_vv; break;
-                case 9: op = rv_op_vaadd_vv; break;
-                case 10: op = rv_op_vasubu_vv; break;
-                case 11: op = rv_op_vasub_vv; break;
-                case 12: op = rv_op_vclmul_vv; break;
-                case 13: op = rv_op_vclmulh_vv; break;
+                case 0: return &op_vredsum_vs;
+                case 1: return &op_vredand_vs;
+                case 2: return &op_vredor_vs;
+                case 3: return &op_vredxor_vs;
+                case 4: return &op_vredminu_vs;
+                case 5: return &op_vredmin_vs;
+                case 6: return &op_vredmaxu_vs;
+                case 7: return &op_vredmax_vs;
+                case 8: return &op_vaaddu_vv;
+                case 9: return &op_vaadd_vv;
+                case 10: return &op_vasubu_vv;
+                case 11: return &op_vasub_vv;
+                case 12: return &op_vclmul_vv;
+                case 13: return &op_vclmulh_vv;
                 case 16:
                     switch ((inst >> 15) & 0b11111) {
-                    case 0: if ((inst >> 25) & 1) op = rv_op_vmv_x_s; break;
-                    case 16: op = rv_op_vcpop_m; break;
-                    case 17: op = rv_op_vfirst_m; break;
+                    case 0:
+                        if ((inst >> 25) & 1) {
+                            return &op_vmv_x_s;
+                        }
+                        break;
+                    case 16: return &op_vcpop_m;
+                    case 17: return &op_vfirst_m;
                     }
                     break;
                 case 18:
                     switch ((inst >> 15) & 0b11111) {
-                    case 2: op = rv_op_vzext_vf8; break;
-                    case 3: op = rv_op_vsext_vf8; break;
-                    case 4: op = rv_op_vzext_vf4; break;
-                    case 5: op = rv_op_vsext_vf4; break;
-                    case 6: op = rv_op_vzext_vf2; break;
-                    case 7: op = rv_op_vsext_vf2; break;
-                    case 8: op = rv_op_vbrev8_v; break;
-                    case 9: op = rv_op_vrev8_v; break;
-                    case 10: op = rv_op_vbrev_v; break;
-                    case 12: op = rv_op_vclz_v; break;
-                    case 13: op = rv_op_vctz_v; break;
-                    case 14: op = rv_op_vcpop_v; break;
+                    case 2: return &op_vzext_vf8;
+                    case 3: return &op_vsext_vf8;
+                    case 4: return &op_vzext_vf4;
+                    case 5: return &op_vsext_vf4;
+                    case 6: return &op_vzext_vf2;
+                    case 7: return &op_vsext_vf2;
+                    case 8: return &op_vbrev8_v;
+                    case 9: return &op_vrev8_v;
+                    case 10: return &op_vbrev_v;
+                    case 12: return &op_vclz_v;
+                    case 13: return &op_vctz_v;
+                    case 14: return &op_vcpop_v;
                     }
                     break;
                 case 20:
                     switch ((inst >> 15) & 0b11111) {
-                    case 1: op = rv_op_vmsbf_m;  break;
-                    case 2: op = rv_op_vmsof_m; break;
-                    case 3: op = rv_op_vmsif_m; break;
-                    case 16: op = rv_op_viota_m; break;
+                    case 1: return &op_vmsbf_m;  break;
+                    case 2: return &op_vmsof_m;
+                    case 3: return &op_vmsif_m;
+                    case 16: return &op_viota_m;
                     case 17:
                         if (((inst >> 20) & 0b11111) == 0) {
-                            op = rv_op_vid_v;
+                            return &op_vid_v;
                         }
                         break;
                     }
                     break;
-                case 23: if ((inst >> 25) & 1) op = rv_op_vcompress_vm; break;
-                case 24: if ((inst >> 25) & 1) op = rv_op_vmandn_mm; break;
-                case 25: if ((inst >> 25) & 1) op = rv_op_vmand_mm; break;
-                case 26: if ((inst >> 25) & 1) op = rv_op_vmor_mm; break;
-                case 27: if ((inst >> 25) & 1) op = rv_op_vmxor_mm; break;
-                case 28: if ((inst >> 25) & 1) op = rv_op_vmorn_mm; break;
-                case 29: if ((inst >> 25) & 1) op = rv_op_vmnand_mm; break;
-                case 30: if ((inst >> 25) & 1) op = rv_op_vmnor_mm; break;
-                case 31: if ((inst >> 25) & 1) op = rv_op_vmxnor_mm; break;
-                case 32: op = rv_op_vdivu_vv; break;
-                case 33: op = rv_op_vdiv_vv; break;
-                case 34: op = rv_op_vremu_vv; break;
-                case 35: op = rv_op_vrem_vv; break;
-                case 36: op = rv_op_vmulhu_vv; break;
-                case 37: op = rv_op_vmul_vv; break;
-                case 38: op = rv_op_vmulhsu_vv; break;
-                case 39: op = rv_op_vmulh_vv; break;
-                case 41: op = rv_op_vmadd_vv; break;
-                case 43: op = rv_op_vnmsub_vv; break;
-                case 45: op = rv_op_vmacc_vv; break;
-                case 47: op = rv_op_vnmsac_vv; break;
-                case 48: op = rv_op_vwaddu_vv; break;
-                case 49: op = rv_op_vwadd_vv; break;
-                case 50: op = rv_op_vwsubu_vv; break;
-                case 51: op = rv_op_vwsub_vv; break;
-                case 52: op = rv_op_vwaddu_wv; break;
-                case 53: op = rv_op_vwadd_wv; break;
-                case 54: op = rv_op_vwsubu_wv; break;
-                case 55: op = rv_op_vwsub_wv; break;
-                case 56: op = rv_op_vwmulu_vv; break;
-                case 58: op = rv_op_vwmulsu_vv; break;
-                case 59: op = rv_op_vwmul_vv; break;
-                case 60: op = rv_op_vwmaccu_vv; break;
-                case 61: op = rv_op_vwmacc_vv; break;
-                case 63: op = rv_op_vwmaccsu_vv; break;
+                case 23:
+                    if ((inst >> 25) & 1) {
+                        return &op_vcompress_vm;
+                    }
+                    break;
+                case 24:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmandn_mm;
+                    }
+                    break;
+                case 25:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmand_mm;
+                    }
+                    break;
+                case 26:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmor_mm;
+                    }
+                    break;
+                case 27:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmxor_mm;
+                    }
+                    break;
+                case 28:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmorn_mm;
+                    }
+                    break;
+                case 29:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmnand_mm;
+                    }
+                    break;
+                case 30:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmnor_mm;
+                    }
+                    break;
+                case 31:
+                    if ((inst >> 25) & 1) {
+                        return &op_vmxnor_mm;
+                    }
+                    break;
+                case 32: return &op_vdivu_vv;
+                case 33: return &op_vdiv_vv;
+                case 34: return &op_vremu_vv;
+                case 35: return &op_vrem_vv;
+                case 36: return &op_vmulhu_vv;
+                case 37: return &op_vmul_vv;
+                case 38: return &op_vmulhsu_vv;
+                case 39: return &op_vmulh_vv;
+                case 41: return &op_vmadd_vv;
+                case 43: return &op_vnmsub_vv;
+                case 45: return &op_vmacc_vv;
+                case 47: return &op_vnmsac_vv;
+                case 48: return &op_vwaddu_vv;
+                case 49: return &op_vwadd_vv;
+                case 50: return &op_vwsubu_vv;
+                case 51: return &op_vwsub_vv;
+                case 52: return &op_vwaddu_wv;
+                case 53: return &op_vwadd_wv;
+                case 54: return &op_vwsubu_wv;
+                case 55: return &op_vwsub_wv;
+                case 56: return &op_vwmulu_vv;
+                case 58: return &op_vwmulsu_vv;
+                case 59: return &op_vwmul_vv;
+                case 60: return &op_vwmaccu_vv;
+                case 61: return &op_vwmacc_vv;
+                case 63: return &op_vwmaccsu_vv;
                 }
                 break;
             case 3:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_vadd_vi; break;
-                case 3: op = rv_op_vrsub_vi; break;
-                case 9: op = rv_op_vand_vi; break;
-                case 10: op = rv_op_vor_vi; break;
-                case 11: op = rv_op_vxor_vi; break;
-                case 12: op = rv_op_vrgather_vi; break;
-                case 14: op = rv_op_vslideup_vi; break;
-                case 15: op = rv_op_vslidedown_vi; break;
+                case 0: return &op_vadd_vi;
+                case 3: return &op_vrsub_vi;
+                case 9: return &op_vand_vi;
+                case 10: return &op_vor_vi;
+                case 11: return &op_vxor_vi;
+                case 12: return &op_vrgather_vi;
+                case 14: return &op_vslideup_vi;
+                case 15: return &op_vslidedown_vi;
                 case 16:
                     if (((inst >> 25) & 1) == 0) {
-                        op = rv_op_vadc_vim;
+                        return &op_vadc_vim;
                     }
                     break;
-                case 17: op = rv_op_vmadc_vim; break;
-                case 20: case 21: op = rv_op_vror_vi; break;
+                case 17: return &op_vmadc_vim;
+                case 20: case 21: return &op_vror_vi;
                 case 23:
-                    if (((inst >> 20) & 0b111111) == 32)
-                        op = rv_op_vmv_v_i;
-                    else if (((inst >> 25) & 1) == 0)
-                        op = rv_op_vmerge_vim;
+                    if (((inst >> 20) & 0b111111) == 32) {
+                        return &op_vmv_v_i;
+                    } else if (((inst >> 25) & 1) == 0) {
+                        return &op_vmerge_vim;
+                    }
                     break;
-                case 24: op = rv_op_vmseq_vi; break;
-                case 25: op = rv_op_vmsne_vi; break;
-                case 28: op = rv_op_vmsleu_vi; break;
-                case 29: op = rv_op_vmsle_vi; break;
-                case 30: op = rv_op_vmsgtu_vi; break;
-                case 31: op = rv_op_vmsgt_vi; break;
-                case 32: op = rv_op_vsaddu_vi; break;
-                case 33: op = rv_op_vsadd_vi; break;
-                case 37: op = rv_op_vsll_vi; break;
+                case 24: return &op_vmseq_vi;
+                case 25: return &op_vmsne_vi;
+                case 28: return &op_vmsleu_vi;
+                case 29: return &op_vmsle_vi;
+                case 30: return &op_vmsgtu_vi;
+                case 31: return &op_vmsgt_vi;
+                case 32: return &op_vsaddu_vi;
+                case 33: return &op_vsadd_vi;
+                case 37: return &op_vsll_vi;
                 case 39:
                     switch ((inst >> 15) & 0b11111) {
-                    case 0: op = rv_op_vmv1r_v; break;
-                    case 1: op = rv_op_vmv2r_v; break;
-                    case 3: op = rv_op_vmv4r_v; break;
-                    case 7: op = rv_op_vmv8r_v; break;
+                    case 0: return &op_vmv1r_v;
+                    case 1: return &op_vmv2r_v;
+                    case 3: return &op_vmv4r_v;
+                    case 7: return &op_vmv8r_v;
                     }
                     break;
-                case 40: op = rv_op_vsrl_vi; break;
-                case 41: op = rv_op_vsra_vi; break;
-                case 42: op = rv_op_vssrl_vi; break;
-                case 43: op = rv_op_vssra_vi; break;
-                case 44: op = rv_op_vnsrl_wi; break;
-                case 45: op = rv_op_vnsra_wi; break;
-                case 46: op = rv_op_vnclipu_wi; break;
-                case 47: op = rv_op_vnclip_wi; break;
-                case 53: op = rv_op_vwsll_vi; break;
+                case 40: return &op_vsrl_vi;
+                case 41: return &op_vsra_vi;
+                case 42: return &op_vssrl_vi;
+                case 43: return &op_vssra_vi;
+                case 44: return &op_vnsrl_wi;
+                case 45: return &op_vnsra_wi;
+                case 46: return &op_vnclipu_wi;
+                case 47: return &op_vnclip_wi;
+                case 53: return &op_vwsll_vi;
                 }
                 break;
             case 4:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_vadd_vx; break;
-                case 1: op = rv_op_vandn_vx; break;
-                case 2: op = rv_op_vsub_vx; break;
-                case 3: op = rv_op_vrsub_vx; break;
-                case 4: op = rv_op_vminu_vx; break;
-                case 5: op = rv_op_vmin_vx; break;
-                case 6: op = rv_op_vmaxu_vx; break;
-                case 7: op = rv_op_vmax_vx; break;
-                case 9: op = rv_op_vand_vx; break;
-                case 10: op = rv_op_vor_vx; break;
-                case 11: op = rv_op_vxor_vx; break;
-                case 12: op = rv_op_vrgather_vx; break;
-                case 14: op = rv_op_vslideup_vx; break;
-                case 15: op = rv_op_vslidedown_vx; break;
+                case 0: return &op_vadd_vx;
+                case 1: return &op_vandn_vx;
+                case 2: return &op_vsub_vx;
+                case 3: return &op_vrsub_vx;
+                case 4: return &op_vminu_vx;
+                case 5: return &op_vmin_vx;
+                case 6: return &op_vmaxu_vx;
+                case 7: return &op_vmax_vx;
+                case 9: return &op_vand_vx;
+                case 10: return &op_vor_vx;
+                case 11: return &op_vxor_vx;
+                case 12: return &op_vrgather_vx;
+                case 14: return &op_vslideup_vx;
+                case 15: return &op_vslidedown_vx;
                 case 16:
                     if (((inst >> 25) & 1) == 0) {
-                        op = rv_op_vadc_vxm;
+                        return &op_vadc_vxm;
                     }
                     break;
-                case 17: op = rv_op_vmadc_vxm; break;
+                case 17: return &op_vmadc_vxm;
                 case 18:
                     if (((inst >> 25) & 1) == 0) {
-                        op = rv_op_vsbc_vxm;
+                        return &op_vsbc_vxm;
                     }
                     break;
-                case 19: op = rv_op_vmsbc_vxm; break;
-                case 20: op = rv_op_vror_vx; break;
-                case 21: op = rv_op_vrol_vx; break;
+                case 19: return &op_vmsbc_vxm;
+                case 20: return &op_vror_vx;
+                case 21: return &op_vrol_vx;
                 case 23:
-                    if (((inst >> 20) & 0b111111) == 32)
-                        op = rv_op_vmv_v_x;
-                    else if (((inst >> 25) & 1) == 0)
-                        op = rv_op_vmerge_vxm;
+                    if (((inst >> 20) & 0b111111) == 32) {
+                        return &op_vmv_v_x;
+                    } else if (((inst >> 25) & 1) == 0) {
+                        return &op_vmerge_vxm;
+                    }
                     break;
-                case 24: op = rv_op_vmseq_vx; break;
-                case 25: op = rv_op_vmsne_vx; break;
-                case 26: op = rv_op_vmsltu_vx; break;
-                case 27: op = rv_op_vmslt_vx; break;
-                case 28: op = rv_op_vmsleu_vx; break;
-                case 29: op = rv_op_vmsle_vx; break;
-                case 30: op = rv_op_vmsgtu_vx; break;
-                case 31: op = rv_op_vmsgt_vx; break;
-                case 32: op = rv_op_vsaddu_vx; break;
-                case 33: op = rv_op_vsadd_vx; break;
-                case 34: op = rv_op_vssubu_vx; break;
-                case 35: op = rv_op_vssub_vx; break;
-                case 37: op = rv_op_vsll_vx; break;
-                case 39: op = rv_op_vsmul_vx; break;
-                case 40: op = rv_op_vsrl_vx; break;
-                case 41: op = rv_op_vsra_vx; break;
-                case 42: op = rv_op_vssrl_vx; break;
-                case 43: op = rv_op_vssra_vx; break;
-                case 44: op = rv_op_vnsrl_wx; break;
-                case 45: op = rv_op_vnsra_wx; break;
-                case 46: op = rv_op_vnclipu_wx; break;
-                case 47: op = rv_op_vnclip_wx; break;
-                case 53: op = rv_op_vwsll_vx; break;
+                case 24: return &op_vmseq_vx;
+                case 25: return &op_vmsne_vx;
+                case 26: return &op_vmsltu_vx;
+                case 27: return &op_vmslt_vx;
+                case 28: return &op_vmsleu_vx;
+                case 29: return &op_vmsle_vx;
+                case 30: return &op_vmsgtu_vx;
+                case 31: return &op_vmsgt_vx;
+                case 32: return &op_vsaddu_vx;
+                case 33: return &op_vsadd_vx;
+                case 34: return &op_vssubu_vx;
+                case 35: return &op_vssub_vx;
+                case 37: return &op_vsll_vx;
+                case 39: return &op_vsmul_vx;
+                case 40: return &op_vsrl_vx;
+                case 41: return &op_vsra_vx;
+                case 42: return &op_vssrl_vx;
+                case 43: return &op_vssra_vx;
+                case 44: return &op_vnsrl_wx;
+                case 45: return &op_vnsra_wx;
+                case 46: return &op_vnclipu_wx;
+                case 47: return &op_vnclip_wx;
+                case 53: return &op_vwsll_vx;
                 }
                 break;
             case 5:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_vfadd_vf; break;
-                case 2: op = rv_op_vfsub_vf; break;
-                case 4: op = rv_op_vfmin_vf; break;
-                case 6: op = rv_op_vfmax_vf; break;
-                case 8: op = rv_op_vfsgnj_vf; break;
-                case 9: op = rv_op_vfsgnjn_vf; break;
-                case 10: op = rv_op_vfsgnjx_vf; break;
-                case 14: op = rv_op_vfslide1up_vf; break;
-                case 15: op = rv_op_vfslide1down_vf; break;
+                case 0: return &op_vfadd_vf;
+                case 2: return &op_vfsub_vf;
+                case 4: return &op_vfmin_vf;
+                case 6: return &op_vfmax_vf;
+                case 8: return &op_vfsgnj_vf;
+                case 9: return &op_vfsgnjn_vf;
+                case 10: return &op_vfsgnjx_vf;
+                case 14: return &op_vfslide1up_vf;
+                case 15: return &op_vfslide1down_vf;
                 case 16:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: if ((inst >> 25) & 1) op = rv_op_vfmv_s_f; break;
+                    case 0:
+                        if ((inst >> 25) & 1) {
+                            return &op_vfmv_s_f;
+                        }
                     }
                     break;
                 case 23:
-                    if (((inst >> 25) & 1) == 0)
-                        op = rv_op_vfmerge_vfm;
-                    else if (((inst >> 20) & 0b111111) == 32)
-                        op = rv_op_vfmv_v_f;
+                    if (((inst >> 25) & 1) == 0) {
+                        return &op_vfmerge_vfm;
+                    } else if (((inst >> 20) & 0b111111) == 32) {
+                        return &op_vfmv_v_f;
+                    }
                     break;
-                case 24: op = rv_op_vmfeq_vf; break;
-                case 25: op = rv_op_vmfle_vf; break;
-                case 27: op = rv_op_vmflt_vf; break;
-                case 28: op = rv_op_vmfne_vf; break;
-                case 29: op = rv_op_vmfgt_vf; break;
-                case 31: op = rv_op_vmfge_vf; break;
-                case 32: op = rv_op_vfdiv_vf; break;
-                case 33: op = rv_op_vfrdiv_vf; break;
-                case 36: op = rv_op_vfmul_vf; break;
-                case 39: op = rv_op_vfrsub_vf; break;
-                case 40: op = rv_op_vfmadd_vf; break;
-                case 41: op = rv_op_vfnmadd_vf; break;
-                case 42: op = rv_op_vfmsub_vf; break;
-                case 43: op = rv_op_vfnmsub_vf; break;
-                case 44: op = rv_op_vfmacc_vf; break;
-                case 45: op = rv_op_vfnmacc_vf; break;
-                case 46: op = rv_op_vfmsac_vf; break;
-                case 47: op = rv_op_vfnmsac_vf; break;
-                case 48: op = rv_op_vfwadd_vf; break;
-                case 50: op = rv_op_vfwsub_vf; break;
-                case 52: op = rv_op_vfwadd_wf; break;
-                case 54: op = rv_op_vfwsub_wf; break;
-                case 56: op = rv_op_vfwmul_vf; break;
-                case 59: op = rv_op_vfwmaccbf16_vf; break;
-                case 60: op = rv_op_vfwmacc_vf; break;
-                case 61: op = rv_op_vfwnmacc_vf; break;
-                case 62: op = rv_op_vfwmsac_vf; break;
-                case 63: op = rv_op_vfwnmsac_vf; break;
+                case 24: return &op_vmfeq_vf;
+                case 25: return &op_vmfle_vf;
+                case 27: return &op_vmflt_vf;
+                case 28: return &op_vmfne_vf;
+                case 29: return &op_vmfgt_vf;
+                case 31: return &op_vmfge_vf;
+                case 32: return &op_vfdiv_vf;
+                case 33: return &op_vfrdiv_vf;
+                case 36: return &op_vfmul_vf;
+                case 39: return &op_vfrsub_vf;
+                case 40: return &op_vfmadd_vf;
+                case 41: return &op_vfnmadd_vf;
+                case 42: return &op_vfmsub_vf;
+                case 43: return &op_vfnmsub_vf;
+                case 44: return &op_vfmacc_vf;
+                case 45: return &op_vfnmacc_vf;
+                case 46: return &op_vfmsac_vf;
+                case 47: return &op_vfnmsac_vf;
+                case 48: return &op_vfwadd_vf;
+                case 50: return &op_vfwsub_vf;
+                case 52: return &op_vfwadd_wf;
+                case 54: return &op_vfwsub_wf;
+                case 56: return &op_vfwmul_vf;
+                case 59: return &op_vfwmaccbf16_vf;
+                case 60: return &op_vfwmacc_vf;
+                case 61: return &op_vfwnmacc_vf;
+                case 62: return &op_vfwmsac_vf;
+                case 63: return &op_vfwnmsac_vf;
                 }
                 break;
             case 6:
                 switch ((inst >> 26) & 0b111111) {
-                case 8: op = rv_op_vaaddu_vx; break;
-                case 9: op = rv_op_vaadd_vx; break;
-                case 10: op = rv_op_vasubu_vx; break;
-                case 11: op = rv_op_vasub_vx; break;
-                case 12: op = rv_op_vclmul_vx; break;
-                case 13: op = rv_op_vclmulh_vx; break;
-                case 14: op = rv_op_vslide1up_vx; break;
-                case 15: op = rv_op_vslide1down_vx; break;
+                case 8: return &op_vaaddu_vx;
+                case 9: return &op_vaadd_vx;
+                case 10: return &op_vasubu_vx;
+                case 11: return &op_vasub_vx;
+                case 12: return &op_vclmul_vx;
+                case 13: return &op_vclmulh_vx;
+                case 14: return &op_vslide1up_vx;
+                case 15: return &op_vslide1down_vx;
                 case 16:
                     switch ((inst >> 20) & 0b11111) {
-                    case 0: if ((inst >> 25) & 1) op = rv_op_vmv_s_x; break;
+                    case 0:
+                        if ((inst >> 25) & 1) {
+                            return &op_vmv_s_x;
+                        }
                     }
                     break;
-                case 32: op = rv_op_vdivu_vx; break;
-                case 33: op = rv_op_vdiv_vx; break;
-                case 34: op = rv_op_vremu_vx; break;
-                case 35: op = rv_op_vrem_vx; break;
-                case 36: op = rv_op_vmulhu_vx; break;
-                case 37: op = rv_op_vmul_vx; break;
-                case 38: op = rv_op_vmulhsu_vx; break;
-                case 39: op = rv_op_vmulh_vx; break;
-                case 41: op = rv_op_vmadd_vx; break;
-                case 43: op = rv_op_vnmsub_vx; break;
-                case 45: op = rv_op_vmacc_vx; break;
-                case 47: op = rv_op_vnmsac_vx; break;
-                case 48: op = rv_op_vwaddu_vx; break;
-                case 49: op = rv_op_vwadd_vx; break;
-                case 50: op = rv_op_vwsubu_vx; break;
-                case 51: op = rv_op_vwsub_vx; break;
-                case 52: op = rv_op_vwaddu_wx; break;
-                case 53: op = rv_op_vwadd_wx; break;
-                case 54: op = rv_op_vwsubu_wx; break;
-                case 55: op = rv_op_vwsub_wx; break;
-                case 56: op = rv_op_vwmulu_vx; break;
-                case 58: op = rv_op_vwmulsu_vx; break;
-                case 59: op = rv_op_vwmul_vx; break;
-                case 60: op = rv_op_vwmaccu_vx; break;
-                case 61: op = rv_op_vwmacc_vx; break;
-                case 62: op = rv_op_vwmaccus_vx; break;
-                case 63: op = rv_op_vwmaccsu_vx; break;
+                case 32: return &op_vdivu_vx;
+                case 33: return &op_vdiv_vx;
+                case 34: return &op_vremu_vx;
+                case 35: return &op_vrem_vx;
+                case 36: return &op_vmulhu_vx;
+                case 37: return &op_vmul_vx;
+                case 38: return &op_vmulhsu_vx;
+                case 39: return &op_vmulh_vx;
+                case 41: return &op_vmadd_vx;
+                case 43: return &op_vnmsub_vx;
+                case 45: return &op_vmacc_vx;
+                case 47: return &op_vnmsac_vx;
+                case 48: return &op_vwaddu_vx;
+                case 49: return &op_vwadd_vx;
+                case 50: return &op_vwsubu_vx;
+                case 51: return &op_vwsub_vx;
+                case 52: return &op_vwaddu_wx;
+                case 53: return &op_vwadd_wx;
+                case 54: return &op_vwsubu_wx;
+                case 55: return &op_vwsub_wx;
+                case 56: return &op_vwmulu_vx;
+                case 58: return &op_vwmulsu_vx;
+                case 59: return &op_vwmul_vx;
+                case 60: return &op_vwmaccu_vx;
+                case 61: return &op_vwmacc_vx;
+                case 62: return &op_vwmaccus_vx;
+                case 63: return &op_vwmaccsu_vx;
                 }
                 break;
             case 7:
                 if (((inst >> 31) & 1) == 0) {
-                    op = rv_op_vsetvli;
+                    return &op_vsetvli;
                 } else if ((inst >> 30) & 1) {
-                    op = rv_op_vsetivli;
+                    return &op_vsetivli;
                 } else if (((inst >> 25) & 0b11111) == 0) {
-                    op = rv_op_vsetvl;
+                    return &op_vsetvl;
                 }
                 break;
             }
             break;
         case 22:
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_addid; break;
+            case 0: return &op_addid;
             case 1:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_sllid; break;
+                case 0: return &op_sllid;
                 }
                 break;
             case 5:
                 switch ((inst >> 26) & 0b111111) {
-                case 0: op = rv_op_srlid; break;
-                case 16: op = rv_op_sraid; break;
+                case 0: return &op_srlid;
+                case 16: return &op_sraid;
                 }
                 break;
             }
             break;
         case 24:
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_beq; break;
-            case 1: op = rv_op_bne; break;
-            case 4: op = rv_op_blt; break;
-            case 5: op = rv_op_bge; break;
-            case 6: op = rv_op_bltu; break;
-            case 7: op = rv_op_bgeu; break;
+            case 0: return &op_beq;
+            case 1: return &op_bne;
+            case 4: return &op_blt;
+            case 5: return &op_bge;
+            case 6: return &op_bltu;
+            case 7: return &op_bgeu;
             }
             break;
         case 25:
             switch ((inst >> 12) & 0b111) {
-            case 0: op = rv_op_jalr; break;
+            case 0: return &op_jalr;
             }
             break;
-        case 27: op = rv_op_jal; break;
+        case 27: return &op_jal;
         case 28:
             switch ((inst >> 12) & 0b111) {
             case 0:
@@ -2483,76 +2504,76 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                         ((inst >> 7) & 0b000000011111)) {
                 case 0:
                     switch ((inst >> 15) & 0b1111111111) {
-                    case 0: op = rv_op_ecall; break;
-                    case 32: op = rv_op_ebreak; break;
-                    case 64: op = rv_op_uret; break;
-                    case 416: op = rv_op_wrs_nto; break;
-                    case 928: op = rv_op_wrs_sto; break;
+                    case 0: return &op_ecall;
+                    case 32: return &op_ebreak;
+                    case 64: return &op_uret;
+                    case 416: return &op_wrs_nto;
+                    case 928: return &op_wrs_sto;
                     }
                     break;
                 case 256:
                     switch ((inst >> 20) & 0b11111) {
                     case 2:
                         switch ((inst >> 15) & 0b11111) {
-                        case 0: op = rv_op_sret; break;
+                        case 0: return &op_sret;
                         }
                         break;
-                    case 4: op = rv_op_sfence_vm; break;
+                    case 4: return &op_sfence_vm;
                     case 5:
                         switch ((inst >> 15) & 0b11111) {
-                        case 0: op = rv_op_wfi; break;
+                        case 0: return &op_wfi;
                         }
                         break;
                     }
                     break;
-                case 288: op = rv_op_sfence_vma; break;
+                case 288: return &op_sfence_vma;
                 case 512:
                     switch ((inst >> 15) & 0b1111111111) {
-                    case 64: op = rv_op_hret; break;
+                    case 64: return &op_hret;
                     }
                     break;
                 case 768:
                     switch ((inst >> 15) & 0b1111111111) {
-                    case 64: op = rv_op_mret; break;
+                    case 64: return &op_mret;
                     }
                     break;
                 case 1792:
                     switch ((inst >> 15) & 0b1111111111) {
-                    case 64: op = rv_op_mnret; break;
+                    case 64: return &op_mnret;
                     }
                     break;
                 case 1952:
                     switch ((inst >> 15) & 0b1111111111) {
-                    case 576: op = rv_op_dret; break;
+                    case 576: return &op_dret;
                     }
                     break;
                 }
                 break;
             case 1:
                 switch (operand_csr12(inst)) {
-                case 1: op = rv_op_fsflags; break;
-                case 2: op = rv_op_fsrm; break;
-                case 3: op = rv_op_fscsr; break;
-                default: op = rv_op_csrrw; break;
+                case 1: return &op_fsflags;
+                case 2: return &op_fsrm;
+                case 3: return &op_fscsr;
+                default: return &op_csrrw;
                 }
                 break;
             case 2:
-                op = rv_op_csrrs;
+                return &op_csrrs;
                 if (operand_rs1(inst) == 0) {
                     switch (operand_csr12(inst)) {
-                    case 0x001: op = rv_op_frflags; break;
-                    case 0x002: op = rv_op_frrm; break;
-                    case 0x003: op = rv_op_frcsr; break;
-                    case 0xc00: op = rv_op_rdcycle; break;
-                    case 0xc01: op = rv_op_rdtime; break;
-                    case 0xc02: op = rv_op_rdinstret; break;
-                    case 0xc80: op = rv_op_rdcycleh; break;
-                    case 0xc81: op = rv_op_rdtimeh; break;
-                    case 0xc82: op = rv_op_rdinstreth; break;
+                    case 0x001: return &op_frflags;
+                    case 0x002: return &op_frrm;
+                    case 0x003: return &op_frcsr;
+                    case 0xc00: return &op_rdcycle;
+                    case 0xc01: return &op_rdtime;
+                    case 0xc02: return &op_rdinstret;
+                    case 0xc80: return &op_rdcycleh;
+                    case 0xc81: return &op_rdtimeh;
+                    case 0xc82: return &op_rdinstreth;
                     }
                 }
                 break;
-            case 3: op = rv_op_csrrc; break;
+            case 3: return &op_csrrc;
             case 4:
                 if (dec->cfg && dec->cfg->ext_zimop) {
                     if (((inst >> 22) & 0b1011001111) == 0b1000000111) {
@@ -2560,15 +2581,15 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                             && operand_mop_r_imm(inst) == 28) {
                             switch (operand_rs1(inst)) {
                             case 0:
-                                return &rvi_opcode_data[rv_op_ssrdp];
+                                return &op_ssrdp;
                             case 1:
                             case 5:
                                 if (operand_rd(inst) == 0) {
-                                    return &rvi_opcode_data[rv_op_sspopchk];
+                                    return &op_sspopchk;
                                 }
                             }
                         }
-                        return &rvi_opcode_data[rv_op_mop_r];
+                        return &op_mop_r;
                     }
                     if (((inst >> 25) & 0b1011001) == 0b1000001) {
                         if (dec->cfg->ext_zicfiss
@@ -2578,79 +2599,79 @@ static const rv_opcode_data *decode_inst_opcode(rv_decode *dec, rv_isa isa)
                             switch (operand_rs2(inst)) {
                             case 1:
                             case 5:
-                                return &rvi_opcode_data[rv_op_sspush];
+                                return &op_sspush;
                             }
                         }
-                        return &rvi_opcode_data[rv_op_mop_rr];
+                        return &op_mop_rr;
                     }
                 }
                 break;
             case 5:
                 switch (operand_csr12(inst)) {
-                case 1: op = rv_op_fsflagsi; break;
-                case 2: op = rv_op_fsrmi; break;
-                default: op = rv_op_csrrwi; break;
+                case 1: return &op_fsflagsi;
+                case 2: return &op_fsrmi;
+                default: return &op_csrrwi;
                 }
                 break;
-            case 6: op = rv_op_csrrsi; break;
-            case 7: op = rv_op_csrrci; break;
+            case 6: return &op_csrrsi;
+            case 7: return &op_csrrci;
             }
             break;
         case 29:
             if (((inst >> 25) & 1) == 1 && ((inst >> 12) & 0b111) == 2) {
                 switch ((inst >> 26) & 0b111111) {
-                case 32: op = rv_op_vsm3me_vv; break;
-                case 33: op = rv_op_vsm4k_vi; break;
-                case 34: op = rv_op_vaeskf1_vi; break;
+                case 32: return &op_vsm3me_vv;
+                case 33: return &op_vsm4k_vi;
+                case 34: return &op_vaeskf1_vi;
                 case 40:
                     switch ((inst >> 15) & 0b11111) {
-                    case 0: op = rv_op_vaesdm_vv; break;
-                    case 1: op = rv_op_vaesdf_vv; break;
-                    case 2: op = rv_op_vaesem_vv; break;
-                    case 3: op = rv_op_vaesef_vv; break;
-                    case 16: op = rv_op_vsm4r_vv; break;
-                    case 17: op = rv_op_vgmul_vv; break;
+                    case 0: return &op_vaesdm_vv;
+                    case 1: return &op_vaesdf_vv;
+                    case 2: return &op_vaesem_vv;
+                    case 3: return &op_vaesef_vv;
+                    case 16: return &op_vsm4r_vv;
+                    case 17: return &op_vgmul_vv;
                     }
                     break;
                 case 41:
                     switch ((inst >> 15) & 0b11111) {
-                    case 0: op = rv_op_vaesdm_vs; break;
-                    case 1: op = rv_op_vaesdf_vs; break;
-                    case 2: op = rv_op_vaesem_vs; break;
-                    case 3: op = rv_op_vaesef_vs; break;
-                    case 7: op = rv_op_vaesz_vs; break;
-                    case 16: op = rv_op_vsm4r_vs; break;
+                    case 0: return &op_vaesdm_vs;
+                    case 1: return &op_vaesdf_vs;
+                    case 2: return &op_vaesem_vs;
+                    case 3: return &op_vaesef_vs;
+                    case 7: return &op_vaesz_vs;
+                    case 16: return &op_vsm4r_vs;
                     }
                     break;
-                case 42: op = rv_op_vaeskf2_vi; break;
-                case 43: op = rv_op_vsm3c_vi; break;
-                case 44: op = rv_op_vghsh_vv; break;
-                case 45: op = rv_op_vsha2ms_vv; break;
-                case 46: op = rv_op_vsha2ch_vv; break;
-                case 47: op = rv_op_vsha2cl_vv; break;
+                case 42: return &op_vaeskf2_vi;
+                case 43: return &op_vsm3c_vi;
+                case 44: return &op_vghsh_vv;
+                case 45: return &op_vsha2ms_vv;
+                case 46: return &op_vsha2ch_vv;
+                case 47: return &op_vsha2cl_vv;
                 }
             }
             break;
         case 30:
             switch (((inst >> 22) & 0b1111111000) |
                     ((inst >> 12) & 0b0000000111)) {
-            case 0: op = rv_op_addd; break;
-            case 1: op = rv_op_slld; break;
-            case 5: op = rv_op_srld; break;
-            case 8: op = rv_op_muld; break;
-            case 12: op = rv_op_divd; break;
-            case 13: op = rv_op_divud; break;
-            case 14: op = rv_op_remd; break;
-            case 15: op = rv_op_remud; break;
-            case 256: op = rv_op_subd; break;
-            case 261: op = rv_op_srad; break;
+            case 0: return &op_addd;
+            case 1: return &op_slld;
+            case 5: return &op_srld;
+            case 8: return &op_muld;
+            case 12: return &op_divd;
+            case 13: return &op_divud;
+            case 14: return &op_remd;
+            case 15: return &op_remud;
+            case 256: return &op_subd;
+            case 261: return &op_srad;
             }
             break;
         }
         break;
     }
 
-    return op == rv_op_illegal ? NULL : &rvi_opcode_data[op];
+    return NULL;
 }
 
 /* decode operands */
@@ -3450,7 +3471,7 @@ static GString *disasm_inst(rv_isa isa, uint64_t pc, rv_inst inst,
         decode_inst_operands(&dec, isa, op);
         op = decode_inst_lift_pseudo(&dec, op);
     } else {
-        op = &rvi_opcode_data[rv_op_illegal];
+        op = &op_illegal;
     }
 
     return format_inst(24, &dec, op);
diff --git a/disas/riscv-op.c.inc b/disas/riscv-op.c.inc
index 802a521bca..cc939f557f 100644
--- a/disas/riscv-op.c.inc
+++ b/disas/riscv-op.c.inc
@@ -225,51 +225,51 @@ OP(fcvt_q_l, "fcvt.q.l", rv_codec_r_m, rv_fmt_rm_frd_rs1)
 OP(fcvt_q_lu, "fcvt.q.lu", rv_codec_r_m, rv_fmt_rm_frd_rs1)
 OP(fmv_x_q, "fmv.x.q", rv_codec_r, rv_fmt_rd_frs1)
 OP(fmv_q_x, "fmv.q.x", rv_codec_r, rv_fmt_frd_rs1)
-OP(c_addi4spn, "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(rv_op_addi))
-OP(c_fld, "c.fld", rv_codec_cl_ld, NULL, DECOMP(rv_op_fld))
-OP(c_lw, "c.lw", rv_codec_cl_lw, NULL, DECOMP(rv_op_lw))
-OP(c_flw, "c.flw", rv_codec_cl_lw, NULL, DECOMP(rv_op_flw))
-OP(c_fsd, "c.fsd", rv_codec_cs_sd, NULL, DECOMP(rv_op_fsd))
-OP(c_sw, "c.sw", rv_codec_cs_sw, NULL, DECOMP(rv_op_sw))
-OP(c_fsw, "c.fsw", rv_codec_cs_sw, NULL, DECOMP(rv_op_fsw))
-OP(c_addi, "c.addi", rv_codec_ci, NULL, DECOMP(rv_op_addi))
-OP(c_jal, "c.jal", rv_codec_cj_jal, NULL, DECOMP(rv_op_jal))
-OP(c_li, "c.li", rv_codec_ci_li, NULL, DECOMP(rv_op_addi))
-OP(c_addi16sp, "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(rv_op_addi))
-OP(c_lui, "c.lui", rv_codec_ci_lui, NULL, DECOMP(rv_op_lui))
-OP(c_srli, "c.srli", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srli))
-OP(c_srai, "c.srai", rv_codec_cb_sh6, NULL, DECOMP(rv_op_srai))
-OP(c_andi, "c.andi", rv_codec_cb_imm, NULL, DECOMP(rv_op_andi))
-OP(c_sub, "c.sub", rv_codec_cs, NULL, DECOMP(rv_op_sub))
-OP(c_xor, "c.xor", rv_codec_cs, NULL, DECOMP(rv_op_xor))
-OP(c_or, "c.or", rv_codec_cs, NULL, DECOMP(rv_op_or))
-OP(c_and, "c.and", rv_codec_cs, NULL, DECOMP(rv_op_and))
-OP(c_subw, "c.subw", rv_codec_cs, NULL, DECOMP(rv_op_subw))
-OP(c_addw, "c.addw", rv_codec_cs, NULL, DECOMP(rv_op_addw))
-OP(c_j, "c.j", rv_codec_cj, NULL, DECOMP(rv_op_j))
-OP(c_beqz, "c.beqz", rv_codec_cb, NULL, DECOMP(rv_op_beqz))
-OP(c_bnez, "c.bnez", rv_codec_cb, NULL, DECOMP(rv_op_bnez))
-OP(c_slli, "c.slli", rv_codec_ci_sh6, NULL, DECOMP(rv_op_slli))
-OP(c_fldsp, "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_fld))
-OP(c_lwsp, "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_lw))
-OP(c_flwsp, "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(rv_op_flw))
-OP(c_jr, "c.jr", rv_codec_cr_jr, NULL, DECOMP(rv_op_jr))
-OP(c_mv, "c.mv", rv_codec_cr_mv, NULL, DECOMP(rv_op_mv))
-OP(c_ebreak, "c.ebreak", rv_codec_ci_none, NULL, DECOMP(rv_op_ebreak))
-OP(c_jalr, "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(rv_op_jalr))
-OP(c_add, "c.add", rv_codec_cr, NULL, DECOMP(rv_op_add))
-OP(c_fsdsp, "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_fsd))
-OP(c_swsp, "c.swsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_sw))
-OP(c_fswsp, "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(rv_op_fsw))
-OP(c_ld, "c.ld", rv_codec_cl_ld, NULL, DECOMP(rv_op_ld))
-OP(c_sd, "c.sd", rv_codec_cs_sd, NULL, DECOMP(rv_op_sd))
-OP(c_addiw, "c.addiw", rv_codec_ci, NULL, DECOMP(rv_op_addiw))
-OP(c_ldsp, "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(rv_op_ld))
-OP(c_sdsp, "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(rv_op_sd))
-OP(c_lq, "c.lq", rv_codec_cl_lq, NULL, DECOMP(rv_op_lq))
-OP(c_sq, "c.sq", rv_codec_cs_sq, NULL, DECOMP(rv_op_sq))
-OP(c_lqsp, "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(rv_op_lq))
-OP(c_sqsp, "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(rv_op_sq))
+OP(c_addi4spn, "c.addi4spn", rv_codec_ciw_4spn, NULL, DECOMP(op_addi))
+OP(c_fld, "c.fld", rv_codec_cl_ld, NULL, DECOMP(op_fld))
+OP(c_lw, "c.lw", rv_codec_cl_lw, NULL, DECOMP(op_lw))
+OP(c_flw, "c.flw", rv_codec_cl_lw, NULL, DECOMP(op_flw))
+OP(c_fsd, "c.fsd", rv_codec_cs_sd, NULL, DECOMP(op_fsd))
+OP(c_sw, "c.sw", rv_codec_cs_sw, NULL, DECOMP(op_sw))
+OP(c_fsw, "c.fsw", rv_codec_cs_sw, NULL, DECOMP(op_fsw))
+OP(c_addi, "c.addi", rv_codec_ci, NULL, DECOMP(op_addi))
+OP(c_jal, "c.jal", rv_codec_cj_jal, NULL, DECOMP(op_jal))
+OP(c_li, "c.li", rv_codec_ci_li, NULL, DECOMP(op_addi))
+OP(c_addi16sp, "c.addi16sp", rv_codec_ci_16sp, NULL, DECOMP(op_addi))
+OP(c_lui, "c.lui", rv_codec_ci_lui, NULL, DECOMP(op_lui))
+OP(c_srli, "c.srli", rv_codec_cb_sh6, NULL, DECOMP(op_srli))
+OP(c_srai, "c.srai", rv_codec_cb_sh6, NULL, DECOMP(op_srai))
+OP(c_andi, "c.andi", rv_codec_cb_imm, NULL, DECOMP(op_andi))
+OP(c_sub, "c.sub", rv_codec_cs, NULL, DECOMP(op_sub))
+OP(c_xor, "c.xor", rv_codec_cs, NULL, DECOMP(op_xor))
+OP(c_or, "c.or", rv_codec_cs, NULL, DECOMP(op_or))
+OP(c_and, "c.and", rv_codec_cs, NULL, DECOMP(op_and))
+OP(c_subw, "c.subw", rv_codec_cs, NULL, DECOMP(op_subw))
+OP(c_addw, "c.addw", rv_codec_cs, NULL, DECOMP(op_addw))
+OP(c_j, "c.j", rv_codec_cj, NULL, DECOMP(op_j))
+OP(c_beqz, "c.beqz", rv_codec_cb, NULL, DECOMP(op_beqz))
+OP(c_bnez, "c.bnez", rv_codec_cb, NULL, DECOMP(op_bnez))
+OP(c_slli, "c.slli", rv_codec_ci_sh6, NULL, DECOMP(op_slli))
+OP(c_fldsp, "c.fldsp", rv_codec_ci_ldsp, NULL, DECOMP(op_fld))
+OP(c_lwsp, "c.lwsp", rv_codec_ci_lwsp, NULL, DECOMP(op_lw))
+OP(c_flwsp, "c.flwsp", rv_codec_ci_lwsp, NULL, DECOMP(op_flw))
+OP(c_jr, "c.jr", rv_codec_cr_jr, NULL, DECOMP(op_jr))
+OP(c_mv, "c.mv", rv_codec_cr_mv, NULL, DECOMP(op_mv))
+OP(c_ebreak, "c.ebreak", rv_codec_ci_none, NULL, DECOMP(op_ebreak))
+OP(c_jalr, "c.jalr", rv_codec_cr_jalr, NULL, DECOMP(op_jalr))
+OP(c_add, "c.add", rv_codec_cr, NULL, DECOMP(op_add))
+OP(c_fsdsp, "c.fsdsp", rv_codec_css_sdsp, NULL, DECOMP(op_fsd))
+OP(c_swsp, "c.swsp", rv_codec_css_swsp, NULL, DECOMP(op_sw))
+OP(c_fswsp, "c.fswsp", rv_codec_css_swsp, NULL, DECOMP(op_fsw))
+OP(c_ld, "c.ld", rv_codec_cl_ld, NULL, DECOMP(op_ld))
+OP(c_sd, "c.sd", rv_codec_cs_sd, NULL, DECOMP(op_sd))
+OP(c_addiw, "c.addiw", rv_codec_ci, NULL, DECOMP(op_addiw))
+OP(c_ldsp, "c.ldsp", rv_codec_ci_ldsp, NULL, DECOMP(op_ld))
+OP(c_sdsp, "c.sdsp", rv_codec_css_sdsp, NULL, DECOMP(op_sd))
+OP(c_lq, "c.lq", rv_codec_cl_lq, NULL, DECOMP(op_lq))
+OP(c_sq, "c.sq", rv_codec_cs_sq, NULL, DECOMP(op_sq))
+OP(c_lqsp, "c.lqsp", rv_codec_ci_lqsp, NULL, DECOMP(op_lq))
+OP(c_sqsp, "c.sqsp", rv_codec_css_sqsp, NULL, DECOMP(op_sq))
 OP(nop, "nop", rv_codec_illegal, rv_fmt_none)
 OP(mv, "mv", rv_codec_illegal, rv_fmt_rd_rs1, rvcp_mv)
 OP(not, "not", rv_codec_illegal, rv_fmt_rd_rs1)
@@ -904,8 +904,8 @@ OP(sspopchk, "sspopchk", rv_codec_r, rv_fmt_rs1)
 OP(ssrdp, "ssrdp", rv_codec_r, rv_fmt_rd)
 OP(ssamoswap_w, "ssamoswap.w", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
 OP(ssamoswap_d, "ssamoswap.d", rv_codec_r_a, rv_fmt_aqrl_rd_rs2_rs1)
-OP(c_sspush, "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspush))
-OP(c_sspopchk, "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(rv_op_sspopchk))
+OP(c_sspush, "c.sspush", rv_codec_cmop_ss, NULL, DECOMP(op_sspush))
+OP(c_sspopchk, "c.sspopchk", rv_codec_cmop_ss, NULL, DECOMP(op_sspopchk))
 OP(cbo_inval, "cbo.inval", rv_codec_r, rv_fmt_rs1)
 OP(cbo_clean, "cbo.clean", rv_codec_r, rv_fmt_rs1)
 OP(cbo_flush, "cbo.flush", rv_codec_r, rv_fmt_rs1)
-- 
2.43.0


