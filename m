Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F602D2A543
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2024 19:32:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t19kO-0002gy-EG; Wed, 16 Oct 2024 15:31:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kK-0002db-BO
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:48 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t19kI-0003oI-3I
 for qemu-devel@nongnu.org; Wed, 16 Oct 2024 15:31:47 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20c6f492d2dso2154745ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2024 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729107105; x=1729711905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wGj9NIqRgmgSLRSzX3rBNungML5CHycRbRnnDre79Nc=;
 b=XY7Qs588gzT84j6Xu2jLLJGt4rIJldL/iflvc5z/N7WfX0bBbUp1QVvyhv08+RHAUr
 P+o5IHG+3C2hQkTgm4P6UkwtOv8Sf70UNGrdzH2L2NrTyn0pQ/4kuX14H35w0xdRB+p4
 E+bLTnzKkxp3JV+JnHiCNPqF6MhvUFKOnM0vVByx4vDSDa1DqI3W5atrdmok86iUehKX
 xdw8YEvNt9vJfuCdJf0JHveiAsUBXOlz4L7NerQpSLhopI5UE5qxvoyJPZBXz584q4Vs
 CJhtHHF4xqV1jAtN58AqqHUfyoUVfpexauP+N5ynTn636WFffJ7i1JLnF4UWMQVT4PEF
 RbaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729107105; x=1729711905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wGj9NIqRgmgSLRSzX3rBNungML5CHycRbRnnDre79Nc=;
 b=wr55r7ki76UqrKDBEC7bFcxcenIEMVGcZZTSG36TCTVRjEs7jNxNxT2+7x7ruCB6H2
 CAMu9/pgG4WCpNpzhoanm+twjL6+Dgll5CP2B89/ZaFXPcaNaR52Af1edOED0z/9Nbpt
 5uIGzaZ0y69Cp1G4napRKOmWM84nZaXImVlUXDMNown8FWqZXJv7RuFNJfos+eDZ9WYn
 yJeh8Oq1eD6N6QtJUowlLZgeLbhrz1CJkN3yUTiga994/qDbh+9jylpfaDj/A5V4wQmk
 6hKhakoSaydVtndONjKrVCnLlje6WwsvCVGM9l6L0bZT1xoBodbO7Dalow7IpaZo5AuO
 ecfQ==
X-Gm-Message-State: AOJu0YyySjW7prti5zlXjV2MyvHke6Vm3LzLGmwd7zpdtMdg68Jn9VuA
 9Lwry5hruplXZgtb+XNOxpo/B5X5Lu9TWEAWPyviu+koKQovtSLSMkRysPp1DKizTxPyQh3kioE
 p
X-Google-Smtp-Source: AGHT+IEWGNXuGC60Hbf9m5x90VR8bED+hATAeOcDUuP+Ggv6/LV+VnfbDJEFDHnQDgb1ennMXinX/Q==
X-Received: by 2002:a17:902:e887:b0:20b:b40b:3454 with SMTP id
 d9443c01a7336-20cba9ebb29mr224011425ad.0.1729107104743; 
 Wed, 16 Oct 2024 12:31:44 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20d1804b6b1sm32323945ad.189.2024.10.16.12.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Oct 2024 12:31:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 zhiwei_liu@linux.alibaba.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Subject: [PATCH v6 05/14] tcg/riscv: Implement vector mov/dup{m/i}
Date: Wed, 16 Oct 2024 12:31:31 -0700
Message-ID: <20241016193140.2206352-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016193140.2206352-1-richard.henderson@linaro.org>
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20241007025700.47259-5-zhiwei_liu@linux.alibaba.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target.c.inc | 76 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 2 deletions(-)

diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index 38d71111c9..17fcc21b0e 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -309,6 +309,12 @@ typedef enum {
     OPC_VS2R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(1),
     OPC_VS4R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(3),
     OPC_VS8R_V = 0x2000027 | V_UNIT_STRIDE_WHOLE_REG | V_NF(7),
+
+    OPC_VMV_V_V = 0x5e000057 | V_OPIVV,
+    OPC_VMV_V_I = 0x5e000057 | V_OPIVI,
+    OPC_VMV_V_X = 0x5e000057 | V_OPIVX,
+
+    OPC_VMVNR_V = 0x9e000057 | V_OPIVI,
 } RISCVInsn;
 
 /*
@@ -401,6 +407,16 @@ static int32_t encode_uj(RISCVInsn opc, TCGReg rd, uint32_t imm)
     return opc | (rd & 0x1f) << 7 | encode_ujimm20(imm);
 }
 
+
+/* Type-OPIVI */
+
+static int32_t encode_vi(RISCVInsn opc, TCGReg rd, int32_t imm,
+                         TCGReg vs2, bool vm)
+{
+    return opc | (rd & 0x1f) << 7 | (imm & 0x1f) << 15 |
+           (vs2 & 0x1f) << 20 | (vm << 25);
+}
+
 /* Type-OPIVV/OPMVV/OPIVX/OPMVX, Vector load and store */
 
 static int32_t encode_v(RISCVInsn opc, TCGReg d, TCGReg s1,
@@ -546,6 +562,24 @@ static bool patch_reloc(tcg_insn_unit *code_ptr, int type,
  * RISC-V vector instruction emitters
  */
 
+/*
+ * Vector registers uses the same 5 lower bits as GPR registers,
+ * and vm=0 (vm = false) means vector masking ENABLED.
+ * With RVV 1.0, vs2 is the first operand, while rs1/imm is the
+ * second operand.
+ */
+static void tcg_out_opc_vx(TCGContext *s, RISCVInsn opc,
+                           TCGReg vd, TCGReg vs2, TCGReg rs1)
+{
+    tcg_out32(s, encode_v(opc, vd, rs1, vs2, true));
+}
+
+static void tcg_out_opc_vi(TCGContext *s, RISCVInsn opc,
+                           TCGReg vd, TCGReg vs2, int32_t imm)
+{
+    tcg_out32(s, encode_vi(opc, vd, imm, vs2, true));
+}
+
 typedef struct VsetCache {
     uint32_t movi_insn;
     uint32_t vset_insn;
@@ -574,6 +608,13 @@ static MemOp set_vtype_len(TCGContext *s, TCGType type)
     return s->riscv_cur_vsew;
 }
 
+static void set_vtype_len_sew(TCGContext *s, TCGType type, MemOp vsew)
+{
+    if (type != s->riscv_cur_type || vsew != s->riscv_cur_vsew) {
+        set_vtype(s, type, vsew);
+    }
+}
+
 /*
  * TCG intrinsics
  */
@@ -588,6 +629,15 @@ static bool tcg_out_mov(TCGContext *s, TCGType type, TCGReg ret, TCGReg arg)
     case TCG_TYPE_I64:
         tcg_out_opc_imm(s, OPC_ADDI, ret, arg, 0);
         break;
+    case TCG_TYPE_V64:
+    case TCG_TYPE_V128:
+    case TCG_TYPE_V256:
+        {
+            int lmul = type - riscv_lg2_vlenb;
+            int nf = 1 << MAX(lmul, 0);
+            tcg_out_opc_vi(s, OPC_VMVNR_V, ret, arg, nf - 1);
+        }
+        break;
     default:
         g_assert_not_reached();
     }
@@ -951,18 +1001,35 @@ static void tcg_out_addsub2(TCGContext *s,
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                                    TCGReg dst, TCGReg src)
 {
-    return false;
+    set_vtype_len_sew(s, type, vece);
+    tcg_out_opc_vx(s, OPC_VMV_V_X, dst, 0, src);
+    return true;
 }
 
 static bool tcg_out_dupm_vec(TCGContext *s, TCGType type, unsigned vece,
                                     TCGReg dst, TCGReg base, intptr_t offset)
 {
-    return false;
+    tcg_out_ld(s, TCG_TYPE_REG, TCG_REG_TMP0, base, offset);
+    return tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static void tcg_out_dupi_vec(TCGContext *s, TCGType type, unsigned vece,
                                     TCGReg dst, int64_t arg)
 {
+    /* Arg is replicated by VECE; extract the highest element. */
+    arg >>= (-8 << vece) & 63;
+
+    if (arg >= -16 && arg < 16) {
+        if (arg == 0 || arg == -1) {
+            set_vtype_len(s, type);
+        } else {
+            set_vtype_len_sew(s, type, vece);
+        }
+        tcg_out_opc_vi(s, OPC_VMV_V_I, dst, 0, arg);
+        return;
+    }
+    tcg_out_movi(s, TCG_TYPE_I64, TCG_REG_TMP0, arg);
+    tcg_out_dup_vec(s, type, vece, dst, TCG_REG_TMP0);
 }
 
 static const struct {
@@ -2104,6 +2171,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
     a2 = args[2];
 
     switch (opc) {
+    case INDEX_op_dupm_vec:
+        tcg_out_dupm_vec(s, type, vece, a0, a1, a2);
+        break;
     case INDEX_op_ld_vec:
         tcg_out_ld(s, type, a0, a1, a2);
         break;
@@ -2272,6 +2342,8 @@ static TCGConstraintSetIndex tcg_target_op_def(TCGOpcode op)
 
     case INDEX_op_st_vec:
         return C_O0_I2(v, r);
+    case INDEX_op_dup_vec:
+    case INDEX_op_dupm_vec:
     case INDEX_op_ld_vec:
         return C_O1_I1(v, r);
     default:
-- 
2.43.0


