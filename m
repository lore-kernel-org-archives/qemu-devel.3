Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70BF1C369D1
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 22:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8R5U-0005aP-SV; Fri, 25 Apr 2025 18:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4W-0002QP-1w
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:59:00 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u8R4R-0000tR-JH
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 17:58:59 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-224341bbc1dso33525465ad.3
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 14:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745618334; x=1746223134; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eC6xqqV0FQ0CBqnBi13JgP3ygCud6YQnxjk8uFLhe1g=;
 b=E9Xp0+I9apvCyAnlsLG9aQdP9VmZFLnc23w691U50/OI3uOOFnCupweClynVU8fYBp
 ziz92+g0CgUZ0RUCPe10w9dDdaKdMoy8oq4UmdtAdUuKwvqDEdCLcerW/O93ipyViDez
 zb38BMf2d2sPDuWdzyQ4G8WzYdvn4R1fnkFzCS34BJNDwzMGu7m4TbzM0+pKpDIuSoiu
 zDtBtoVl6CKnvP66PdhKUb6+GNYmEol7df0iojADtpcc15XHmd/xfmdHGGA+Ymw/xsmy
 Oqu5MukEp9ObLoDtm1I4wO7K/++PcMlMqJr7p3DOb+KxgDMRzxDBBQLSZs+EW3LYQX6S
 9fog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745618334; x=1746223134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eC6xqqV0FQ0CBqnBi13JgP3ygCud6YQnxjk8uFLhe1g=;
 b=vRd3UnSa8YpX1ShtpqMSQN+ySSVV/7VJpcN0OHJ4Pq6THV5zdXQPibyERRSKswNDdr
 vBXUcE01frjI9ydlEvru3fiyE3/lSNSDYmT247dys4DKR/TgapTtS9AqwA6y8QPjQa3j
 XYGbFEUzFESLAWPjr2bdqP6Tazcp9HVreJtrV+17TE48/wMpIC3sdIy5fRXo5twn3sbY
 dLfH9OfL7MWpTcfGEUgjdL5J3fHw2KBOUpGTl40iLw80e0gBV9VpCQR5L/20yLSmIsm8
 MYIaihsF90pnUMcYvBYU2QBYrh+5J8SeqoX58XdPMbeFJXfEUqiZxA/qJ/oU9GrxKabE
 R5SA==
X-Gm-Message-State: AOJu0YzLe6lJzuPIXBbbfBFBy1l5MUmRkzz+zsZFnNPhByccGtt6VzpU
 xFtUlZ1zO7801hk+2ANgclq3SUhXZvEAeA3hIw8d0xKtM3KPIWTSQPX4xN1u0lKVs/zxoagcgFs
 E
X-Gm-Gg: ASbGncvlnTk0hx5zjd+TY7lpY7JndKaKej3yyxdqQ8+u5ofiuAEDDidCdWcTdHnZsRk
 r6Qxg1+CxxtFbU9nwGJCY326QN2RJkPgMt3Bj4W++uAEgnmP4dG5wlz1qKWzDQlQzM3e3W9woqw
 VhoimVxI4ghwkxLxOHWolBCAuAG10cA6h5mrKmrR6S/hP+X8robRuU1LX6KPxM5iP3zhNywaLMk
 6ToPkOwaqQQYDDAlB27yR4q9hsVp+pEV+2smgBtc6IsFb0pedXuw+b8UF2fLhaqy8S11/jrhFDJ
 sXlm0N0u2sHVtp7AoMsqg4r4hvb3sLJCyyx+DPCnUhnNBLlkpRVIZ7GgGldRE+F4MVFQQIxQ/mI
 =
X-Google-Smtp-Source: AGHT+IFrlvXnQtXzCebHJRp6JYHQFzJGgt5NuNOH6AaQ2zF+G1PbSZEVrg28CVfRolS+7J0X/p+qfg==
X-Received: by 2002:a17:903:2987:b0:223:f408:c3cf with SMTP id
 d9443c01a7336-22dbf5eaa52mr57737615ad.21.1745618333960; 
 Fri, 25 Apr 2025 14:58:53 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4d770d6sm37749595ad.17.2025.04.25.14.58.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Apr 2025 14:58:53 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 076/159] tcg/loongarch64: Support negsetcond
Date: Fri, 25 Apr 2025 14:53:30 -0700
Message-ID: <20250425215454.886111-77-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250425215454.886111-1-richard.henderson@linaro.org>
References: <20250425215454.886111-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/loongarch64/tcg-target-con-set.h |  2 --
 tcg/loongarch64/tcg-target-has.h     |  4 ++--
 tcg/loongarch64/tcg-target.c.inc     | 34 ++++++++++++++++++++++------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/tcg/loongarch64/tcg-target-con-set.h b/tcg/loongarch64/tcg-target-con-set.h
index da84e4d49c..c145d4ab66 100644
--- a/tcg/loongarch64/tcg-target-con-set.h
+++ b/tcg/loongarch64/tcg-target-con-set.h
@@ -29,8 +29,6 @@ C_O1_I2(r, r, rJ)
 C_O1_I2(r, r, rU)
 C_O1_I2(r, r, rW)
 C_O1_I2(r, 0, rz)
-C_O1_I2(r, rz, ri)
-C_O1_I2(r, rz, rJ)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wM)
 C_O1_I2(w, w, wA)
diff --git a/tcg/loongarch64/tcg-target-has.h b/tcg/loongarch64/tcg-target-has.h
index 12a721b4da..e9bb913961 100644
--- a/tcg/loongarch64/tcg-target-has.h
+++ b/tcg/loongarch64/tcg-target-has.h
@@ -10,7 +10,7 @@
 #include "host/cpuinfo.h"
 
 /* optional instructions */
-#define TCG_TARGET_HAS_negsetcond_i32   0
+#define TCG_TARGET_HAS_negsetcond_i32   1
 #define TCG_TARGET_HAS_extract2_i32     0
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
@@ -19,7 +19,7 @@
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 /* 64-bit operations */
-#define TCG_TARGET_HAS_negsetcond_i64   0
+#define TCG_TARGET_HAS_negsetcond_i64   1
 #define TCG_TARGET_HAS_extract2_i64     0
 #define TCG_TARGET_HAS_extr_i64_i32     1
 #define TCG_TARGET_HAS_bswap16_i64      1
diff --git a/tcg/loongarch64/tcg-target.c.inc b/tcg/loongarch64/tcg-target.c.inc
index fa9da82df8..e7f97aaa5e 100644
--- a/tcg/loongarch64/tcg-target.c.inc
+++ b/tcg/loongarch64/tcg-target.c.inc
@@ -646,14 +646,29 @@ static int tcg_out_setcond_int(TCGContext *s, TCGCond cond, TCGReg ret,
 }
 
 static void tcg_out_setcond(TCGContext *s, TCGCond cond, TCGReg ret,
-                            TCGReg arg1, tcg_target_long arg2, bool c2)
+                            TCGReg arg1, tcg_target_long arg2,
+                            bool c2, bool neg)
 {
     int tmpflags = tcg_out_setcond_int(s, cond, ret, arg1, arg2, c2);
+    TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
 
-    if (tmpflags != ret) {
-        TCGReg tmp = tmpflags & ~SETCOND_FLAGS;
-
+    if (neg) {
+        /* If intermediate result is zero/non-zero: test != 0. */
+        if (tmpflags & SETCOND_NEZ) {
+            tcg_out_opc_sltu(s, ret, TCG_REG_ZERO, tmp);
+            tmp = ret;
+        }
+        /* Produce the 0/-1 result. */
+        if (tmpflags & SETCOND_INV) {
+            tcg_out_opc_addi_d(s, ret, tmp, -1);
+        } else {
+            tcg_out_opc_sub_d(s, ret, TCG_REG_ZERO, tmp);
+        }
+    } else {
         switch (tmpflags & SETCOND_FLAGS) {
+        case 0:
+            tcg_debug_assert(tmp == ret);
+            break;
         case SETCOND_INV:
             /* Intermediate result is boolean: simply invert. */
             tcg_out_opc_xori(s, ret, tmp, 1);
@@ -1800,7 +1815,11 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
 
     case INDEX_op_setcond_i32:
     case INDEX_op_setcond_i64:
-        tcg_out_setcond(s, args[3], a0, a1, a2, c2);
+        tcg_out_setcond(s, args[3], a0, a1, a2, c2, false);
+        break;
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        tcg_out_setcond(s, args[3], a0, a1, a2, c2, true);
         break;
 
     case INDEX_op_movcond_i32:
@@ -2434,9 +2453,10 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O1_I2(r, 0, rz);
 
     case INDEX_op_setcond_i32:
-        return C_O1_I2(r, rz, ri);
     case INDEX_op_setcond_i64:
-        return C_O1_I2(r, rz, rJ);
+    case INDEX_op_negsetcond_i32:
+    case INDEX_op_negsetcond_i64:
+        return C_O1_I2(r, r, rJ);
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-- 
2.43.0


