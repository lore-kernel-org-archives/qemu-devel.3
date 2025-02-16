Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9A33C021A0
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 00:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjS6e-0007lI-Ex; Sat, 15 Feb 2025 19:01:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS6J-0007e9-2J
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:35 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjS68-0006H0-CR
 for qemu-devel@nongnu.org; Sat, 15 Feb 2025 19:01:27 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-220d28c215eso45246935ad.1
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2025 16:01:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739664083; x=1740268883; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8GN03SSPW+BnvgJXCFM6j1oZ9exlKICCoE1kSPFtm0A=;
 b=tXjg14Uyu56JcX8xn8ARn6yVCn9bsl3eClmzWa78+mkF1eGwhjzEXZCpk6ZqZO4SJE
 NQzyg2r2JHf+bzUqa2SpsY0M19+6omBAyPXx7o6ZzSxUUpepvN68AI5z5wGp/M3frxDB
 PdeYv+0b7CWXUj8q+hDV8pBdTxg+HTK8AUzGynJS3NM6Y78lRExVUF5+MYQFS+kG95k3
 XqbfqNzfCXmnu89g9iwHGmNeYkkVwqFBCtdUo2kJsZ8GhZCyOIJe0T+zd4+p0sXJ1lrI
 fjrFvQn7iGA3j57VQ1r0JJugtKOxRu1anusdkbuzKSGBCIgjNQyWSU3mnoPBtw+BIZ+d
 HQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739664083; x=1740268883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GN03SSPW+BnvgJXCFM6j1oZ9exlKICCoE1kSPFtm0A=;
 b=mFtz6s9qMajPZn4EWeyW6KwcwG4ZBzlpLKudu8R3EijvVutLvzPcsYMdFzTRxsgkJV
 8hXpYpNq5gZlXsOFasAmeC4rnGfBamxRFKPxaff6hxLR3jgv+BeIOSr1xi2dnihKohe9
 EXqGrjxgYReEHlloonb2O3veekkVZQIeMaa2KF8sgHnswPppnJqSKgw4HJ7w5g5brnJF
 CwA1znay9/MVynTfOLTlEYxl2NJIrM9QLLHqbYwMF+JEP1BzEipCjQeoHGl/cldbL3J6
 uhXbdcg5shMn3BIoIAlLU1m4PtWJuoU0yIdPphlfvLXiNuEs2krKOh46g4RPX7rQU/s4
 Nu5w==
X-Gm-Message-State: AOJu0Yz0BqcI32wvYSQZFlIGKGqrrgCWpI/cYC3wr3NohK6LgjXctfl9
 M0Qmva0UgMQJjNqlaDsjANkSpvbXja4/3fqJc6uuPfNSA5E1hsle7TXldHx/tkDv2tUs34Y4CCs
 W
X-Gm-Gg: ASbGncuWpN8szbEDoe/QvE/MNFo+H8U76Xt/oeFCWx49uLWcW85dSVUfldnbwkgrG9B
 dSIK++znUlANegIPA5hd+7e4v+0CF/69r6Z+mxxtrV5AKowJMEfCuMKXbAA+LUljUMSMnJIO+HG
 GdObpqX/DTrB3abtL2IE7R5bPgdopy7BLh/oDGoEFcVPc/Dm+QfrKf2Bc4iAfispv3CecrpYnOb
 P1y9Q/53G3cYNEstcw962CuUeis+P/EKj3WyxjQhX19xqgac2L4DWTjGnAfvWK0915Uslmztung
 FUKmrUcnRduAefDZztQTLds3rTB27LU9V/PgA+2PLDT3e/4=
X-Google-Smtp-Source: AGHT+IEoTDjS/YMm8fdeOx4t5U2gOq90HOcS1LMluRHqRufDknd/dPVtQCOpuCUtk0+rMSIspghKSw==
X-Received: by 2002:a17:902:f706:b0:220:c94f:eb28 with SMTP id
 d9443c01a7336-2210406ae23mr64308595ad.27.1739664082656; 
 Sat, 15 Feb 2025 16:01:22 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5366729sm48960315ad.79.2025.02.15.16.01.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 16:01:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 15/24] tcg/aarch64: Use 'z' constraint
Date: Sat, 15 Feb 2025 16:00:59 -0800
Message-ID: <20250216000109.2606518-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216000109.2606518-1-richard.henderson@linaro.org>
References: <20250216000109.2606518-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Note that 'Z' is still used for addsub2.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/aarch64/tcg-target-con-set.h | 12 ++++-----
 tcg/aarch64/tcg-target.c.inc     | 46 ++++++++++++++------------------
 2 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/tcg/aarch64/tcg-target-con-set.h b/tcg/aarch64/tcg-target-con-set.h
index 44fcc1206e..1281e5efc0 100644
--- a/tcg/aarch64/tcg-target-con-set.h
+++ b/tcg/aarch64/tcg-target-con-set.h
@@ -11,27 +11,27 @@
  */
 C_O0_I1(r)
 C_O0_I2(r, rC)
-C_O0_I2(rZ, r)
+C_O0_I2(rz, r)
 C_O0_I2(w, r)
-C_O0_I3(rZ, rZ, r)
+C_O0_I3(rz, rz, r)
 C_O1_I1(r, r)
 C_O1_I1(w, r)
 C_O1_I1(w, w)
 C_O1_I1(w, wr)
-C_O1_I2(r, 0, rZ)
+C_O1_I2(r, 0, rz)
 C_O1_I2(r, r, r)
 C_O1_I2(r, r, rA)
 C_O1_I2(r, r, rAL)
 C_O1_I2(r, r, rC)
 C_O1_I2(r, r, ri)
 C_O1_I2(r, r, rL)
-C_O1_I2(r, rZ, rZ)
+C_O1_I2(r, rz, rz)
 C_O1_I2(w, 0, w)
 C_O1_I2(w, w, w)
 C_O1_I2(w, w, wN)
 C_O1_I2(w, w, wO)
 C_O1_I2(w, w, wZ)
 C_O1_I3(w, w, w, w)
-C_O1_I4(r, r, rC, rZ, rZ)
+C_O1_I4(r, r, rC, rz, rz)
 C_O2_I1(r, r, r)
-C_O2_I4(r, r, rZ, rZ, rA, rMZ)
+C_O2_I4(r, r, rz, rz, rA, rMZ)
diff --git a/tcg/aarch64/tcg-target.c.inc b/tcg/aarch64/tcg-target.c.inc
index 6f383c1592..4645242d85 100644
--- a/tcg/aarch64/tcg-target.c.inc
+++ b/tcg/aarch64/tcg-target.c.inc
@@ -2125,10 +2125,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     TCGArg a2 = args[2];
     int c2 = const_args[2];
 
-    /* Some operands are defined with "rZ" constraint, a register or
-       the zero register.  These need not actually test args[I] == 0.  */
-#define REG0(I)  (const_args[I] ? TCG_REG_XZR : (TCGReg)args[I])
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out_insn(s, 3207, BR, a0);
@@ -2171,18 +2167,18 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
 
     case INDEX_op_st8_i32:
     case INDEX_op_st8_i64:
-        tcg_out_ldst(s, I3312_STRB, REG0(0), a1, a2, 0);
+        tcg_out_ldst(s, I3312_STRB, a0, a1, a2, 0);
         break;
     case INDEX_op_st16_i32:
     case INDEX_op_st16_i64:
-        tcg_out_ldst(s, I3312_STRH, REG0(0), a1, a2, 1);
+        tcg_out_ldst(s, I3312_STRH, a0, a1, a2, 1);
         break;
     case INDEX_op_st_i32:
     case INDEX_op_st32_i64:
-        tcg_out_ldst(s, I3312_STRW, REG0(0), a1, a2, 2);
+        tcg_out_ldst(s, I3312_STRW, a0, a1, a2, 2);
         break;
     case INDEX_op_st_i64:
-        tcg_out_ldst(s, I3312_STRX, REG0(0), a1, a2, 3);
+        tcg_out_ldst(s, I3312_STRX, a0, a1, a2, 3);
         break;
 
     case INDEX_op_add_i32:
@@ -2395,7 +2391,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         /* FALLTHRU */
     case INDEX_op_movcond_i64:
         tcg_out_cmp(s, ext, args[5], a1, a2, c2);
-        tcg_out_insn(s, 3506, CSEL, ext, a0, REG0(3), REG0(4), args[5]);
+        tcg_out_insn(s, 3506, CSEL, ext, a0, args[3], args[4], args[5]);
         break;
 
     case INDEX_op_qemu_ld_i32:
@@ -2404,13 +2400,13 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
         break;
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        tcg_out_qemu_st(s, REG0(0), a1, a2, ext);
+        tcg_out_qemu_st(s, a0, a1, a2, ext);
         break;
     case INDEX_op_qemu_ld_i128:
         tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], true);
         break;
     case INDEX_op_qemu_st_i128:
-        tcg_out_qemu_ldst_i128(s, REG0(0), REG0(1), a2, args[3], false);
+        tcg_out_qemu_ldst_i128(s, a0, a1, a2, args[3], false);
         break;
 
     case INDEX_op_bswap64_i64:
@@ -2439,7 +2435,7 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
 
     case INDEX_op_deposit_i64:
     case INDEX_op_deposit_i32:
-        tcg_out_dep(s, ext, a0, REG0(2), args[3], args[4]);
+        tcg_out_dep(s, ext, a0, a2, args[3], args[4]);
         break;
 
     case INDEX_op_extract_i64:
@@ -2459,25 +2455,25 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
 
     case INDEX_op_extract2_i64:
     case INDEX_op_extract2_i32:
-        tcg_out_extr(s, ext, a0, REG0(2), REG0(1), args[3]);
+        tcg_out_extr(s, ext, a0, a2, a1, args[3]);
         break;
 
     case INDEX_op_add2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
+        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
                         (int32_t)args[4], args[5], const_args[4],
                         const_args[5], false);
         break;
     case INDEX_op_add2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, REG0(2), REG0(3), args[4],
+        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
                         args[5], const_args[4], const_args[5], false);
         break;
     case INDEX_op_sub2_i32:
-        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, REG0(2), REG0(3),
+        tcg_out_addsub2(s, TCG_TYPE_I32, a0, a1, a2, args[3],
                         (int32_t)args[4], args[5], const_args[4],
                         const_args[5], true);
         break;
     case INDEX_op_sub2_i64:
-        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, REG0(2), REG0(3), args[4],
+        tcg_out_addsub2(s, TCG_TYPE_I64, a0, a1, a2, args[3], args[4],
                         args[5], const_args[4], const_args[5], true);
         break;
 
@@ -2513,8 +2509,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType ext,
     default:
         g_assert_not_reached();
     }
-
-#undef REG0
 }
 
 static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
@@ -3010,7 +3004,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st16_i64:
     case INDEX_op_st32_i64:
     case INDEX_op_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
 
     case INDEX_op_add_i32:
     case INDEX_op_add_i64:
@@ -3076,7 +3070,7 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
 
     case INDEX_op_movcond_i32:
     case INDEX_op_movcond_i64:
-        return C_O1_I4(r, r, rC, rZ, rZ);
+        return C_O1_I4(r, r, rC, rz, rz);
 
     case INDEX_op_qemu_ld_i32:
     case INDEX_op_qemu_ld_i64:
@@ -3085,23 +3079,23 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
         return C_O2_I1(r, r, r);
     case INDEX_op_qemu_st_i32:
     case INDEX_op_qemu_st_i64:
-        return C_O0_I2(rZ, r);
+        return C_O0_I2(rz, r);
     case INDEX_op_qemu_st_i128:
-        return C_O0_I3(rZ, rZ, r);
+        return C_O0_I3(rz, rz, r);
 
     case INDEX_op_deposit_i32:
     case INDEX_op_deposit_i64:
-        return C_O1_I2(r, 0, rZ);
+        return C_O1_I2(r, 0, rz);
 
     case INDEX_op_extract2_i32:
     case INDEX_op_extract2_i64:
-        return C_O1_I2(r, rZ, rZ);
+        return C_O1_I2(r, rz, rz);
 
     case INDEX_op_add2_i32:
     case INDEX_op_add2_i64:
     case INDEX_op_sub2_i32:
     case INDEX_op_sub2_i64:
-        return C_O2_I4(r, r, rZ, rZ, rA, rMZ);
+        return C_O2_I4(r, r, rz, rz, rA, rMZ);
 
     case INDEX_op_add_vec:
     case INDEX_op_sub_vec:
-- 
2.43.0


