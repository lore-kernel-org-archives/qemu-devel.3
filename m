Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1796DC021AA
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 19:35:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tk6pj-0002bG-18; Mon, 17 Feb 2025 14:31:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p6-0001yS-IA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:34 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tk6p2-0008PV-6V
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 14:30:31 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-22101839807so53312415ad.3
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 11:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739820623; x=1740425423; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8GN03SSPW+BnvgJXCFM6j1oZ9exlKICCoE1kSPFtm0A=;
 b=hevKij/yi+eZiOc+85OWZQcpra63JW1bLW4f491Rg1uRjfNa71/EV/D2OqgmvfkHyN
 d2jt48LrDcl0eNTXifbALe4Hb5C749Qhcz9PX9KxudpBrVgI0mWcFemq678+cRGq22aT
 xJqN3mZhTlGr9HA9XueANzAN2EqKZ/gz1s0dWCa5gDIO7rV0GnakPhltqaEh50kSQDO/
 mZ2+sHUZeFx+tTZzi30lM1wWBUw3gqmjEbZnISdFtDV/cppmfx86xw3Rxtq/JctoTTgt
 Q/G1m3nn1dXcQjLll39f8LiNJDbbo/0TICSwdvcHm2Dkn3rLm6gvHONj4XbQbwWrs5XU
 rYbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739820623; x=1740425423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8GN03SSPW+BnvgJXCFM6j1oZ9exlKICCoE1kSPFtm0A=;
 b=QbH1htkcf5e8pVvwB23I11gQ6QX0xv8DQ1RVsv1KFlobU47sE+6VisdrnL8UeLPPfN
 WYA9dJVV5Emt/0xoeooNeXHNn2ML9Xcu6cP8Ne6pH2oT85sTohXA7+ooK9M52L1CIjfu
 kknETI0zlAucGdHrsPaqdvx5w6e7codUik4KtuB4MNHLHaG+xlC0qAocPcTQthxVI8Eo
 o73BBM9e0nUFPfb7VziG7g/G143Ws1elE2ff4WLMdxhciuPLGqiDI0AXH3MFLOVUXzlZ
 aXxBFBalfpM8S7hOVNc2d+X9JqMDzAkP3OuH3Y+N1RW0Ij6WQV2iR1jKD7oy9WmXnJ6v
 cDsQ==
X-Gm-Message-State: AOJu0YzyBkR2b0p6DMw44fM7CJkMlMwumCc7sqPwmboS85XPC9EiWn42
 Ce4GDOLT2AA1U3EUt7bzdNiJdXvdsqqKaIDtWnaHosZ7K3ISY9ZxLMu4vWmRi5SO/e3CPhgLcEB
 m
X-Gm-Gg: ASbGncvnkm2R3XHuQFuJDo7e5HMzLDdrRBLRia0Jvm3BIB7sUvK3P3PoT+9+VRDWsG8
 SHKtv2zJ3GrGXBo99VwONn+OjGiRR/gW2rHNKD493H4OW6HbhM2+RrWQL0714ALLEJWZfEAOsWa
 YSCnBMAC9ynwjzEsQDRTHYQMOeXjvYXMXZ0lPfLk4Hn2TlSCFTc4UU6z856mY6Nlb/3XAyAKH6e
 TYOVSTqbCM/OPiruTA9Jv182a27Op99sOOLmcAEvqDlOGDq1DCUrVrq58rPF6/mYESEa3Cm+hLh
 1xiFbNsw0Rr/zkzL9lJAvM8wJEADPplsr/wbues2Yzgxc1A=
X-Google-Smtp-Source: AGHT+IGcyo0pkztmlvk4ruEd7qlZSrPDHuwZalhEU7dvRIOLHn9m8axmCIbCChvuG+5sXrBwA9xiAg==
X-Received: by 2002:a05:6a21:33a9:b0:1ee:7c01:d16 with SMTP id
 adf61e73a8af0-1ee8cbbccf0mr22016113637.30.1739820623421; 
 Mon, 17 Feb 2025 11:30:23 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326a38ff76sm4347164b3a.160.2025.02.17.11.30.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Feb 2025 11:30:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL v2 16/27] tcg/aarch64: Use 'z' constraint
Date: Mon, 17 Feb 2025 11:29:57 -0800
Message-ID: <20250217193009.2873875-17-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250217193009.2873875-1-richard.henderson@linaro.org>
References: <20250217193009.2873875-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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


