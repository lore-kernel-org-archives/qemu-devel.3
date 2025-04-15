Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 330D4C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 20:25:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4mGu-0002KO-IZ; Tue, 15 Apr 2025 15:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mCk-00039R-TV
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:32 -0400
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u4mBc-0008EA-Mg
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 15:44:14 -0400
Received: by mail-il1-x12d.google.com with SMTP id
 e9e14a558f8ab-3d46aaf36a2so47153675ab.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 12:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744746187; x=1745350987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IP3if1LJ4Icd4tDLx5AI7K61MDw/J7lfpzQFyz7fFek=;
 b=y/muX1x9+9VmOtSwqgIcRr7Uaf6Im6GVyW/GYm/5nPY41C2CBTPt/v/Cajqz4LkRo2
 1GRIep6YomR8MT7VjjDUVKx3JseRqm05Rf8q6tfnjBzKORo53SKMefYx8xRyEkw4P5Rl
 EOjnbvSrB+o4dQ6LIwqWjNVw/uXxrYUWXSVWpIZ+kqvO2vaJZtTRJTCtxl6lxLHQBwOL
 t8YB44ZpqrdDe12CRIxIS/LwMLc9Vkcb/QxK+WttP/qkcgjXjaRfRFn7M3idFQhwCS5s
 TF9MECuPDHkzBn/aIHIb4r5tYZDrcsUvsCHXQQnnmzgkNpEmA8kw+meT+ZhT3dlKzGfv
 mWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744746187; x=1745350987;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IP3if1LJ4Icd4tDLx5AI7K61MDw/J7lfpzQFyz7fFek=;
 b=gTZ+rB4Cl8xkjMbUrWgMR+nJoc6udltixWPxuCBTr7q5wN+4LZ/yeCEJKsX2+vAHUc
 fZfjbQIakAXH4aH+ZxS7NzO5nqNedxB3Ppyra1Ir/GXdp5a6mZNczOmOgaDsYo2rwdlC
 D/QXur8GWIkiH2Vn+suAXIl9ACJICsYnm2keUxqxNteNkQXfEZ7BuGUVDwfHCDEky9ds
 8TVOcz92cqEpTbmiRPqd4x2DoLR28GfTmkjXIPUHTFCauxodRHKQknX2xAi7+9ToNIdK
 K69GnKRfhNWtB2Wx8J15dWScEEM+F7VaAAUVIyd1Q7336O0kaeIwUhOPgU1K+XDQz1ID
 YDfA==
X-Gm-Message-State: AOJu0YwL1AYeEoa8h/+C+jvBSoHgGrEnAztBILDV575GF7THJ8djgN3g
 JGz1gRT161VROwP1LhMOny2ouRtH1X8PpsVyQ0mwrzCp0lhAJNSa81ZnqUQwLuuqbqUh0S2EOj/
 4
X-Gm-Gg: ASbGncuRp/OxyEO0/FSxM/g3diwvFrr87PG14ceK0w47xGDEsgWYGHBxV8Dx1NvyN+C
 KKMzYYktz0ParfSWjhN00ztDK1OCOJu43r7vQBEc4N/tmONcywlxl0mKHBi6ZNTvsw2B8l2YEMo
 r7+iUYWFfAUlKJlKcEjPAUbGVSgVW68xjxZzff6Ep6CguonEod3NOwOTI0MTQ3kTho1Ju9J8uHc
 nE3I5PiasMWxVYZ04md4LbNpGcb86nwj3DbLTbXJyXw/s0GgpivvdNXv5T2YEYMp1boQjVKaV5H
 r1JZACKu0JeUoHKT2jb8i8bFksC+YXQ2dYemRDju7RUBPdzMwYoYz4jKwWSfLySRYULW+I1PoUw
 =
X-Google-Smtp-Source: AGHT+IEBHxu/yoWe+u6Y7tp8lUV/ilkN31Vk8C9o5GfL0LmnsiEU288sRxbXfWlpRSDIFwNrY7qi+g==
X-Received: by 2002:a05:6a00:130d:b0:730:95a6:3761 with SMTP id
 d2e1a72fcca58-73c1f8c3dd0mr892689b3a.3.1744745769890; 
 Tue, 15 Apr 2025 12:36:09 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73bd230e34asm9155603b3a.137.2025.04.15.12.36.09
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 12:36:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 136/163] tcg/arm: Remove support for add2/sub2
Date: Tue, 15 Apr 2025 12:24:47 -0700
Message-ID: <20250415192515.232910-137-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250415192515.232910-1-richard.henderson@linaro.org>
References: <20250415192515.232910-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::12d;
 envelope-from=richard.henderson@linaro.org; helo=mail-il1-x12d.google.com
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
 tcg/arm/tcg-target-con-set.h |  2 --
 tcg/arm/tcg-target-has.h     |  4 +--
 tcg/arm/tcg-target.c.inc     | 47 ------------------------------------
 3 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/tcg/arm/tcg-target-con-set.h b/tcg/arm/tcg-target-con-set.h
index a44625ba63..16b1193228 100644
--- a/tcg/arm/tcg-target-con-set.h
+++ b/tcg/arm/tcg-target-con-set.h
@@ -45,5 +45,3 @@ C_O1_I4(r, r, rIN, rIK, 0)
 C_O2_I1(e, p, q)
 C_O2_I2(e, p, q, q)
 C_O2_I2(r, r, r, r)
-C_O2_I4(r, r, r, r, rIN, rIK)
-C_O2_I4(r, r, rI, rI, rIN, rIK)
diff --git a/tcg/arm/tcg-target-has.h b/tcg/arm/tcg-target-has.h
index 3973df1f12..f4bd15c68a 100644
--- a/tcg/arm/tcg-target-has.h
+++ b/tcg/arm/tcg-target-has.h
@@ -24,8 +24,8 @@ extern bool use_neon_instructions;
 #endif
 
 /* optional instructions */
-#define TCG_TARGET_HAS_add2_i32         1
-#define TCG_TARGET_HAS_sub2_i32         1
+#define TCG_TARGET_HAS_add2_i32         0
+#define TCG_TARGET_HAS_sub2_i32         0
 #define TCG_TARGET_HAS_qemu_st8_i32     0
 
 #define TCG_TARGET_HAS_qemu_ldst_i128   0
diff --git a/tcg/arm/tcg-target.c.inc b/tcg/arm/tcg-target.c.inc
index c464c54ffd..3c9042ebfa 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2518,8 +2518,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2, a3, a4, a5;
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out_b_reg(s, COND_AL, args[0]);
@@ -2553,47 +2551,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
         tcg_out_st32(s, COND_AL, args[0], args[1], args[2]);
         break;
 
-    case INDEX_op_add2_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        a3 = args[3], a4 = args[4], a5 = args[5];
-        if (a0 == a3 || (a0 == a5 && !const_args[5])) {
-            a0 = TCG_REG_TMP;
-        }
-        tcg_out_dat_rIN(s, COND_AL, ARITH_ADD | TO_CPSR, ARITH_SUB | TO_CPSR,
-                        a0, a2, a4, const_args[4]);
-        tcg_out_dat_rIK(s, COND_AL, ARITH_ADC, ARITH_SBC,
-                        a1, a3, a5, const_args[5]);
-        tcg_out_mov_reg(s, COND_AL, args[0], a0);
-        break;
-    case INDEX_op_sub2_i32:
-        a0 = args[0], a1 = args[1], a2 = args[2];
-        a3 = args[3], a4 = args[4], a5 = args[5];
-        if ((a0 == a3 && !const_args[3]) || (a0 == a5 && !const_args[5])) {
-            a0 = TCG_REG_TMP;
-        }
-        if (const_args[2]) {
-            if (const_args[4]) {
-                tcg_out_movi32(s, COND_AL, a0, a4);
-                a4 = a0;
-            }
-            tcg_out_dat_rI(s, COND_AL, ARITH_RSB | TO_CPSR, a0, a4, a2, 1);
-        } else {
-            tcg_out_dat_rIN(s, COND_AL, ARITH_SUB | TO_CPSR,
-                            ARITH_ADD | TO_CPSR, a0, a2, a4, const_args[4]);
-        }
-        if (const_args[3]) {
-            if (const_args[5]) {
-                tcg_out_movi32(s, COND_AL, a1, a5);
-                a5 = a1;
-            }
-            tcg_out_dat_rI(s, COND_AL, ARITH_RSC, a1, a5, a3, 1);
-        } else {
-            tcg_out_dat_rIK(s, COND_AL, ARITH_SBC, ARITH_ADC,
-                            a1, a3, a5, const_args[5]);
-        }
-        tcg_out_mov_reg(s, COND_AL, args[0], a0);
-        break;
-
     case INDEX_op_qemu_ld_i32:
         tcg_out_qemu_ld(s, args[0], -1, args[1], args[2], TCG_TYPE_I32);
         break;
@@ -2639,10 +2596,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
     case INDEX_op_st_i32:
         return C_O0_I2(r, r);
 
-    case INDEX_op_add2_i32:
-        return C_O2_I4(r, r, r, r, rIN, rIK);
-    case INDEX_op_sub2_i32:
-        return C_O2_I4(r, r, rI, rI, rIN, rIK);
     case INDEX_op_qemu_ld_i32:
         return C_O1_I1(r, q);
     case INDEX_op_qemu_ld_i64:
-- 
2.43.0


