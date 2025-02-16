Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FEA3C02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:34:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnuf-0005Br-2P; Sun, 16 Feb 2025 18:19:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntN-0002wv-02
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:42 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjntJ-00064Y-VU
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:17:40 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-220ca204d04so49351495ad.0
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:17:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739747856; x=1740352656; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=nI/M/IwczebCOlajrhzp8aQhsqTUe7nxt6KRZlFvdew=;
 b=MyFhcNYdV88+BcMqoluVr3l+FlB6FMwuN/5Cq5QY89y4EaESYKcE9E7ohrEGO2Ib90
 8/JRmRVEDLB9Oh7p17aEgHMr4TQTd1hLKR5MgBlZpxXcx+H7W0pOQHiXzJ/5fg3fcitX
 WVta9lqHEijeywFuvudes47OhT6YH565sf0rHqxItqju6vPR+/mbrmlKMfEhZD9XmS4q
 BefU63C4ZuKGBiKdDh2m9WrrcqPpI3O+2eNNSpvr5M8QRV9J083RzGWKBrGxVnkQ25pw
 nFp38f3Myyg+ejJ+2bQjGT74ZiW/e5qkIpOCpO+hmUqks9IvrCnB6LZtuDUevKGak/GC
 gm5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739747856; x=1740352656;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nI/M/IwczebCOlajrhzp8aQhsqTUe7nxt6KRZlFvdew=;
 b=H2hjIP0mAGz0Ba9K1Fcdy/kLITHv1bk+nKgO8eqQPUzehJA6n3hV2xFcy4hXzdsBz2
 AcekYYDFVW3i5YDAEXiZc6SqNXEctufQCDA3yeCdL3hh/WcVpQsdZ+K+MPMK8kuhb0PV
 7mrQy/f3aug2ZDpHoKx/69DLlv9LM8MiEB57OjYwUOYGCtIasty66HvX217iT67B+4BT
 TJC58MErO8RUNF1bCD8/vsYzjwSFGX7C2W0NKZkngWcjuT9HEW+74RGQ7UuBK9E9ZLLZ
 TIzDqcMh4o95AyaB/wbsZ1Vv6nWcwgi/kFRh1ofFKOKQG65kzJv0nLNNNQXNSKd0g/jJ
 jRTw==
X-Gm-Message-State: AOJu0YyzSzdp/5cAwP6jKewwxVA0WTUi0N6l4/Ai1fLB+Bk6wpGOHgER
 Nw+Xmokw3ioJ8jT6pABRP0FxPDuhL4KnvYQAPrjGeYDKbKmBCnBoAEpCAOIvkrQGInvSPqjLqLJ
 x
X-Gm-Gg: ASbGncv0jDWzn+qiBAIKkOuAxWBio693mb9ybLl8nH4OkELS6SWftu4Y2BvDYHw0hTv
 VJx+5OQHT0/8QqDl55mDYY388Cl230gVAmDJqyOLo5kQxl9GwBaHm9v0zsV6kNQkB3BvA7rloD2
 NNH1/nSptFM3n9dCk2uoAiWUErOpOZRWUZAO4K0bii+TCTcpSFjwt7JFh52AJDDt0cIPz9K0sso
 R509+5ZlhNcoqN3wgh5n29O1K/G+e/LNAqAZxNfx9sBDT4UgM9frq3ySKhq3YhiXzopH9JVIyLd
 Xq90cMXuQg8LA19LsGlSuo3FJT8uycRNZYQ1t4cz7XfiZS4=
X-Google-Smtp-Source: AGHT+IGeA5bfUgLggXxDm+Z0u7b5DQiouLS1aaMqgvNWclvBwrdU6MQMJtD41e5pd05m2iyhlp7IVw==
X-Received: by 2002:a17:903:2b07:b0:21c:1140:136c with SMTP id
 d9443c01a7336-22103ef2e81mr122107485ad.3.1739747856206; 
 Sun, 16 Feb 2025 15:17:36 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2213394d6c8sm5449885ad.181.2025.02.16.15.17.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:17:35 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 109/162] tcg/riscv: Drop support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:18 -0800
Message-ID: <20250216231012.2808572-110-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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


