Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C3F3C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:40:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8RBu-00074V-It; Fri, 25 Apr 2025 18:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7q-0005lW-IN
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:27 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R7m-0001Ox-PJ
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 18:02:25 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-736bfa487c3so2338786b3a.1
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 15:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618541; x=1746223341; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HyPAj1Lo2yDGpLL0UHWpek9MimVvaKLtRxWmazcOcbM=;
 b=gRULmPapnUlTDChAmBe0M7QJYyangfFl1qTXEC6fM8tOrYyZ66wkot4YFf6PhZh+Iz
 TOvFYoceIdwCu4sLeIt7hEnOGMmavyghvL3cOpCIZwHEpNc4DfjwqCadD9/W1tXCkA0y
 pEMs3b9xriKXUReUGoMlTwCKhukrCxs3RKXNVrBMWmhHWafotLhGpLXwZQ/agfgu0PAo
 zLDRd/4AvRoJesH3ta84v4p8vKcpp/ovx1aMuynmE8PhzLqstPD8qM4JOuEqCerXwC/y
 lfyGa08ZPdo1LDIV8FQuEkWCkW//eqn/d489/b5yHPyTZpXMdt5LzhRVf3qse5TvhwEY
 ujTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618541; x=1746223341;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HyPAj1Lo2yDGpLL0UHWpek9MimVvaKLtRxWmazcOcbM=;
 b=ccTXYn3yGtQ2Ac6gOyO1EpuAtt7EK8re7orx/aLSMydIg+k0l0MS07JOyX63Hsilcx
 dNbW+BD3d1Y3OIjMIZJ5D+F/YkZzpf4oyN9aNtZUGcQQ8jsDdkHDSWvL6uCTBvC4Qype
 Jcnh4S7aMeDJplKua+Gpt1DWyi2pDmCZR7vx57IKd7hnpriaxbEfM2s5hN19EFScMhZ/
 qy5NvK0lislj4ehof0UE9dp3eQFg5rTV1qhoncUB8fEx1SEAljQuTznELN/JkVU2Nrv1
 1UPnbqP7xZLdJQf/7XaG6EVGyJM1pPxveCVJn4OPOjvxAdUXlLWmyaXSDGEP/R8/ECeT
 wwOA==
X-Gm-Message-State: AOJu0Yw88+4YBALCraZrT+gvtKGHe75jP4xK0SNqQnpb0S9TUtyzTP66
 MR+BSdaoagybmzhhsu0mBL2bStlwL21NCbzD7m51E7hZUHlagt7hp3GBQf5qCKhy/3ezxPWn4+S
 s
X-Gm-Gg: ASbGncvHyuEYmFtwL6JLlWJ5LjEKfhDHEC/st/Z7HQE3Fh/D8kUAOupEe/WII84kVEA
 HYB0EqKr/yz+JabxRLKZVxuY8LVqEKX3S6frulhSfmLYP6Qep+XLJajqKUC+J56mp/OoNRO5ly4
 uv2x1zWL832KeR+rbv0m81440pzBXY0Y1vPvMLM/Fx7CTy6CenfZwU+pUssR3ww3Sif4ri+knMt
 x/oMqrQMuc5BSR+FntlMY5q3YLt1FUHUlOq5WXitnrpDy4+6O5EH0Fn65ewxIacuF9nP9YeATto
 GB1YXKl6Wfn6TA9zpRf/6cBFkW90fBv5eAxFy5ehg6C1Gj/V5dIGnCrW7kE6gxDmMBAsSRFcBqY
 =
X-Google-Smtp-Source: AGHT+IH7mS3+CGSWrJAV5pU5oxe0c7h1akpPttgqAEuRsX24J2pOFoLkdfEwD51/MpG0QIN6GeHgbw==
X-Received: by 2002:a17:90b:5407:b0:2ff:64a0:4a57 with SMTP id
 98e67ed59e1d1-30a01398791mr1304734a91.26.1745618540795; 
 Fri, 25 Apr 2025 15:02:20 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309f7765c88sm2212961a91.28.2025.04.25.15.02.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 15:02:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 114/159] tcg/riscv: Drop support for add2/sub2
Date: Fri, 25 Apr 2025 14:54:08 -0700
Message-ID: <20250425215454.886111-115-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

We now produce exactly the same code via generic expansion.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/riscv/tcg-target-con-set.h |  1 -
 tcg/riscv/tcg-target-has.h     |  6 +--
 tcg/riscv/tcg-target.c.inc     | 86 +---------------------------------
 3 files changed, 3 insertions(+), 90 deletions(-)

diff --git a/tcg/riscv/tcg-target-con-set.h b/tcg/riscv/tcg-target-con-set.h
index 5ff2c2db60..0fc26d3f98 100644
--- a/tcg/riscv/tcg-target-con-set.h
+++ b/tcg/riscv/tcg-target-con-set.h
@@ -18,7 +18,6 @@ C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rI)
 C_N1_I2(r, r, rM)
 C_O1_I4(r, r, rI, rM, rM)
-C_O2_I4(r, r, rz, rz, rM, rM)
 C_O0_I2(v, r)
 C_O1_I1(v, r)
 C_O1_I1(v, v)
diff --git a/tcg/riscv/tcg-target-has.h b/tcg/riscv/tcg-target-has.h
index b2814f8ef9..c95dc1921e 100644
--- a/tcg/riscv/tcg-target-has.h
+++ b/tcg/riscv/tcg-target-has.h
@@ -10,13 +10,11 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_extr_i64_i32     1
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
 
diff --git a/tcg/riscv/tcg-target.c.inc b/tcg/riscv/tcg-target.c.inc
index d74ac7587a..dce46dcba6 100644
--- a/tcg/riscv/tcg-target.c.inc
+++ b/tcg/riscv/tcg-target.c.inc
@@ -401,7 +401,7 @@ static bool tcg_target_const_match(int64_t val, int ct,
     }
     /*
      * Sign extended from 12 bits, +/- matching: [-0x7ff, 0x7ff].
-     * Used by addsub2 and movcond, which may need the negative value,
+     * Used by movcond, which may need the negative value,
      * and requires the modified constant to be representable.
      */
     if ((ct & TCG_CT_CONST_M12) && val >= -0x7ff && val <= 0x7ff) {
@@ -1073,67 +1073,6 @@ static bool tcg_out_sti(TCGContext *s, TCGType type, TCGArg val,
     return false;
 }
 
-static void tcg_out_addsub2(TCGContext *s,
-                            TCGReg rl, TCGReg rh,
-                            TCGReg al, TCGReg ah,
-                            TCGArg bl, TCGArg bh,
-                            bool cbl, bool cbh, bool is_sub, bool is32bit)
-{
-    const RISCVInsn opc_add = is32bit ? OPC_ADDW : OPC_ADD;
-    const RISCVInsn opc_addi = is32bit ? OPC_ADDIW : OPC_ADDI;
-    const RISCVInsn opc_sub = is32bit ? OPC_SUBW : OPC_SUB;
-    TCGReg th = TCG_REG_TMP1;
-
-    /* If we have a negative constant such that negating it would
-       make the high part zero, we can (usually) eliminate one insn.  */
-    if (cbl && cbh && bh == -1 && bl != 0) {
-        bl = -bl;
-        bh = 0;
-        is_sub = !is_sub;
-    }
-
-    /* By operating on the high part first, we get to use the final
-       carry operation to move back from the temporary.  */
-    if (!cbh) {
-        tcg_out_opc_reg(s, (is_sub ? opc_sub : opc_add), th, ah, bh);
-    } else if (bh != 0 || ah == rl) {
-        tcg_out_opc_imm(s, opc_addi, th, ah, (is_sub ? -bh : bh));
-    } else {
-        th = ah;
-    }
-
-    /* Note that tcg optimization should eliminate the bl == 0 case.  */
-    if (is_sub) {
-        if (cbl) {
-            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, al, bl);
-            tcg_out_opc_imm(s, opc_addi, rl, al, -bl);
-        } else {
-            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0, al, bl);
-            tcg_out_opc_reg(s, opc_sub, rl, al, bl);
-        }
-        tcg_out_opc_reg(s, opc_sub, rh, th, TCG_REG_TMP0);
-    } else {
-        if (cbl) {
-            tcg_out_opc_imm(s, opc_addi, rl, al, bl);
-            tcg_out_opc_imm(s, OPC_SLTIU, TCG_REG_TMP0, rl, bl);
-        } else if (al == bl) {
-            /*
-             * If the input regs overlap, this is a simple doubling
-             * and carry-out is the input msb.  This special case is
-             * required when the output reg overlaps the input,
-             * but we might as well use it always.
-             */
-            tcg_out_opc_imm(s, OPC_SLTI, TCG_REG_TMP0, al, 0);
-            tcg_out_opc_reg(s, opc_add, rl, al, al);
-        } else {
-            tcg_out_opc_reg(s, opc_add, rl, al, bl);
-            tcg_out_opc_reg(s, OPC_SLTU, TCG_REG_TMP0,
-                            rl, (rl == bl ? al : bl));
-        }
-        tcg_out_opc_reg(s, opc_add, rh, th, TCG_REG_TMP0);
-    }
-}
-
 static bool tcg_out_dup_vec(TCGContext *s, TCGType type, unsigned vece,
                                    TCGReg dst, TCGReg src)
 {
@@ -2608,23 +2547,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_ldst(s, OPC_SD, a0, a1, a2);
         break;
 
-    case INDEX_op_add2_i32:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], false, true);
-        break;
-    case INDEX_op_add2_i64:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], false, false);
-        break;
-    case INDEX_op_sub2_i32:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], true, true);
-        break;
-    case INDEX_op_sub2_i64:
-        tcg_out_addsub2(s, a0, a1, a2, args[3], args[4], args[5],
-                        const_args[4], const_args[5], true, false);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, a0, a1, a2, TCG_TYPE_I32);
         break;
@@ -2897,12 +2819,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(rz, r);
 
-    case INDEX_op_add2_i32:
-    case INDEX_op_add2_i64:
-    case INDEX_op_sub2_i32:
-    case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rz, rz, rM, rM);
-
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
         return C_O1_I1(r, r);
-- 
2.43.0


