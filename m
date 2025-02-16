Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C29EC02198
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:24:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnxC-0005hc-0G; Sun, 16 Feb 2025 18:21:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwf-0004OP-T0
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:08 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwb-0006SS-PL
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:04 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2fc737aeeb1so494036a91.3
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748059; x=1740352859; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LqmYFS+mKTMDWnN+D+k8G+NOtETf6n0r4FRDF3yV52U=;
 b=mju1/b+nByUdSfZeMEo2lEQMjkIlySv//yVkKAUTasBYOEEi3z+XoKjalbPWYIJ06/
 THCJXpZGhJxhClAuDgzlqXm2wmiBPdf+e+FYJS8rGdy8OhTiTAlA9SXTnsnnYtmgwZLp
 6/ukmPMW9vPWqHqJk4xMuMFwDMD2ccby52BDJvclnxz3sgiy7VfwP76pIMp90mMFeq95
 FQIakfBXRIpr+dnkn9pVGG45HH81bceFRjPL4xC2LyVu5UBmxtZMoUZrwE+yIqdr+rYu
 sB3cZCnWLvyqbalaKZtJbWjxPZN2aElxcQnV8HMVuLt37Du2kzM70xym3zvi3WD880JQ
 UtGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748059; x=1740352859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LqmYFS+mKTMDWnN+D+k8G+NOtETf6n0r4FRDF3yV52U=;
 b=sU3nOORvTCme7z95LpobEsOi85DVRI0wppAdaYkb/rfMCE9OrWLpOXs0AQR55FE3o3
 uBiZUwC825JcT1javrV/XhOS9L8aBmJ7tGk4eCsoZBUJVZW3+Ev2ILGfF3QCk7sBSBOg
 cWmliX4ROerGMhiU9OINWbyoh0wgqvJ5Xrs8roNPkEccv/jSwRkQ1j0MHov/Zz2tdBeW
 M7/FzRlFbkGbdG4RTla02Wtcn6RUOlAEZIZjwaax8aJFdILarpg67f+rIsJQUy8MSLM3
 T8Jgx+tu5dk/QwSIz0f4Rv2o9nx4RkwbcUXb1pSFchGv3A3XhK3oXHMk2YNDMfVaUEgx
 kLGA==
X-Gm-Message-State: AOJu0YzQi83VhuQkVRqULxrI8Vq0RcIgyocFQDx4sJ0X9Hf/j+V9HNXr
 VzR7tH+VTUyz+gQ13R4UfDhSqD3QwYRliGwv7OXw/KzClMc4WvN5AKBr06fLZeRbItTSrsZiKjr
 6
X-Gm-Gg: ASbGnctSGuf7GT/rs62WgM0W3V3GyzNhHUX6m0M9fMRSn99k+gRhbSkjYJC71WgorcA
 +9je4Yqk1jiZC5TCkdNw4DhmKu8xrXPSXCn27rcdqAPdGdaWtpUNTkh8alUwKlG9X42MlEbER3D
 +8d7CJhq1X099unA8KJvrmwjqY8nEG0J1fNjlnh9BvOZTRc8hyUd04l0mk771bGIrHyTox7/6DD
 w5LTfjh8j3+PzOcxsOCjtHG3mMPpIsmu1ozPsLFcXxqbA1CpUtXc9rVN4lS3Ol36uQp6BpLprqO
 q4myDkXPVz5f5GPtRikzcgwmqLkGN/WsREKZYehVEkijV6Y=
X-Google-Smtp-Source: AGHT+IEu2a+QWVjF8UKXgDSXw6nwl/dIhz2OHSFOezChs18crFqiV59tIKGavr/Ig6cbC1cGRHn0og==
X-Received: by 2002:a17:90a:e7d1:b0:2f2:ab09:c256 with SMTP id
 98e67ed59e1d1-2fc41153ec4mr12669336a91.33.1739748058817; 
 Sun, 16 Feb 2025 15:20:58 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:58 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 137/162] tcg/ppc: Remove support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:46 -0800
Message-ID: <20250216231012.2808572-138-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

We have replaced this with support for add/sub carry.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/ppc/tcg-target-con-set.h |  2 --
 tcg/ppc/tcg-target-has.h     | 11 +++----
 tcg/ppc/tcg-target.c.inc     | 60 ------------------------------------
 3 files changed, 4 insertions(+), 69 deletions(-)

diff --git a/tcg/ppc/tcg-target-con-set.h b/tcg/ppc/tcg-target-con-set.h
index 9ea26c40ae..da7a383bff 100644
--- a/tcg/ppc/tcg-target-con-set.h
+++ b/tcg/ppc/tcg-target-con-set.h
@@ -41,5 +41,3 @@ C_O1_I4(r, r, r, rU, rC)
 C_O2_I1(r, r, r)
 C_N1O1_I1(o, m, r)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, rI, rZM, r, r)
-C_O2_I4(r, r, r, r, rI, rZM)
diff --git a/tcg/ppc/tcg-target-has.h b/tcg/ppc/tcg-target-has.h
index 8d832ce99c..4dda668706 100644
--- a/tcg/ppc/tcg-target-has.h
+++ b/tcg/ppc/tcg-target-has.h
@@ -18,16 +18,13 @@
 
 /* optional instructions */
 #define TCG_TARGET_HAS_qemu_st8_i32     0
-
-#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_add2_i32         0
 #define TCG_TARGET_HAS_sub2_i32         0
+
+#if TCG_TARGET_REG_BITS == 64
 #define TCG_TARGET_HAS_extr_i64_i32     0
-#define TCG_TARGET_HAS_add2_i64         1
-#define TCG_TARGET_HAS_sub2_i64         1
-#else
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i64         0
+#define TCG_TARGET_HAS_sub2_i64         0
 #endif
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   \
diff --git a/tcg/ppc/tcg-target.c.inc b/tcg/ppc/tcg-target.c.inc
index 0b151db0e4..91df9610ec 100644
--- a/tcg/ppc/tcg-target.c.inc
+++ b/tcg/ppc/tcg-target.c.inc
@@ -3663,8 +3663,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1;
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out32(s, MTSPR | RS(args[0]) | CTR);
@@ -3760,57 +3758,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_qemu_ldst_i128(s, args[0], args[1], args[2], args[3], false);
         break;
 
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_add2_i64:
-#else
-    case INDEX_op_add2_i32:
-#endif
-        /* Note that the CA bit is defined based on the word size of the
-           environment.  So in 64-bit mode it's always carry-out of bit 63.
-           The fallback code using deposit works just as well for 32-bit.  */
-        a0 = args[0], a1 = args[1];
-        if (a0 == args[3] || (!const_args[5] && a0 == args[5])) {
-            a0 = TCG_REG_R0;
-        }
-        if (const_args[4]) {
-            tcg_out32(s, ADDIC | TAI(a0, args[2], args[4]));
-        } else {
-            tcg_out32(s, ADDC | TAB(a0, args[2], args[4]));
-        }
-        if (const_args[5]) {
-            tcg_out32(s, (args[5] ? ADDME : ADDZE) | RT(a1) | RA(args[3]));
-        } else {
-            tcg_out32(s, ADDE | TAB(a1, args[3], args[5]));
-        }
-        if (a0 != args[0]) {
-            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
-        }
-        break;
-
-#if TCG_TARGET_REG_BITS == 64
-    case INDEX_op_sub2_i64:
-#else
-    case INDEX_op_sub2_i32:
-#endif
-        a0 = args[0], a1 = args[1];
-        if (a0 == args[5] || (!const_args[3] && a0 == args[3])) {
-            a0 = TCG_REG_R0;
-        }
-        if (const_args[2]) {
-            tcg_out32(s, SUBFIC | TAI(a0, args[4], args[2]));
-        } else {
-            tcg_out32(s, SUBFC | TAB(a0, args[4], args[2]));
-        }
-        if (const_args[3]) {
-            tcg_out32(s, (args[3] ? SUBFME : SUBFZE) | RT(a1) | RA(args[5]));
-        } else {
-            tcg_out32(s, SUBFE | TAB(a1, args[5], args[3]));
-        }
-        if (a0 != args[0]) {
-            tcg_out_mov(s, TCG_TYPE_REG, args[0], a0);
-        }
-        break;
-
     case INDEX_op_mb:
         tcg_out_mb(s, args[0]);
         break;
@@ -4456,13 +4403,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i64:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i64:
-    case INDEX_op_add2_i32:
-        return C_O2_I4(r, r, r, r, rI, rZM);
-    case INDEX_op_sub2_i64:
-    case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rI, rZM, r, r);
-
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, r);
     case INDEX_op_qemu_ld_i64:
-- 
2.43.0


