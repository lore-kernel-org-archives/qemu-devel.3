Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3660AC021A6
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2025 23:23:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjnyJ-0007Xv-Ig; Sun, 16 Feb 2025 18:22:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwi-0004Rc-4y
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:11 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tjnwa-0006SB-1y
 for qemu-devel@nongnu.org; Sun, 16 Feb 2025 18:21:07 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2fa8ac56891so5361240a91.2
 for <qemu-devel@nongnu.org>; Sun, 16 Feb 2025 15:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739748057; x=1740352857; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=HwRjqs5L7j883z+Y95F5PHIfn3HvtidqTFeRrcGOPZI=;
 b=hIVMRpl+hCeTQADTYbiqwYx9RK66q3edPmEGYNydUnmBLcmAXoKyQvGkGQ0Ws1dok1
 jn7ExezL+dMfCmi1JkK/t8a6rskyaOZDQIxRA64pdDomCLOTQtDDOVUng3vp/EBJIO16
 HNAALWTdSJIhFEnh4vDmjl1TZ35gJBouy8AYexe1S5m7kYEnjgJ2iyYHBUOPmrf25OB8
 6E3WpN+kDxUSrKvmENMmYIFCy+m6d7RmFhFQ7z1kX6wsnCiv0eImOEI78pefma1Jydam
 9t2ToTZQt/F6vHSSLJhSFgpEvkEwT1ENaT9oVf6qZfG2gGFC5Ie4BuWxjQtqned2DB5E
 HLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739748057; x=1740352857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HwRjqs5L7j883z+Y95F5PHIfn3HvtidqTFeRrcGOPZI=;
 b=LhutxuAW1ulOFm+Xr4Yp0h5lvGqTRiFOYGCszn4JUoX2pnveKXM3UB32ubaQ75ufid
 pzU8EWBBQ1bEJF/tL4RuP8FryO8IrS15dg1svPfnkNnwi10oNyUA8VFGXrIi74rlrK7+
 kG53S6izPmI5L+CAOR5e3pWYDjrE4KADKLslkQfayMxvtbQc82H3VAczal88lPIdle8h
 234US7D2F4M5Fk3FpGps8527UBX90M6C2cbK8guwWKREUJh1SOPp5CVjHO4KtLufPoKg
 Ev1mJmvzBjxC39lxixRxVzCqVlWPk83le6WM3unnxQJUgGVQyeeGfDtUcZFJQM3Tru+P
 Xp3g==
X-Gm-Message-State: AOJu0YxX5X3f+Hj1kYSO6SffUizkl4zDkBIWpnQWt4Sa4P7yLOEDQLTk
 /XS6/Fx45Lpz3ZUFPYM1sOsLv1Xk5N1p3PyEZO6oLofO/9pUbkY9F+/0KOSu9f6RiPZCKbPMJMi
 N
X-Gm-Gg: ASbGncuZLEUP7Da/FBu5fdC5Dl1eZ2NmqCxt9dMOI/C2mcdTBeQELTtNSu3DcdaNPYG
 vFgWLmkUoqojPffZRMfmmt0JOqM1V+cV2FcQkxNjQcYZu5EmTroyTIpukU5wcgOyjPh7euqQ06l
 ex95cJLWM5upxkyjoy6JwQCIpP9/g/P7BI0ZbgmyzsLv0NFEliftbLbW10uawDNoHtO8Qo0eSMA
 lS/YT+a/a81DfzdCcDpeSV8an69KZBVu5XhUyjfSN+HHNnX3zek7RTRJrgdj1kZC2JwYa9ib376
 A2zcHDI/HE02xBVr6kotgabaFjmYhm4ngyFs/0y/VY07IuE=
X-Google-Smtp-Source: AGHT+IHcSuUe/WKnwsgTUx+fyEg2LYCuKNgtepwnrRGdBsZUj1nD4j/YScdP76BaCr/Ep6fcT4ukRA==
X-Received: by 2002:a17:90b:3ec5:b0:2f9:cf97:56ac with SMTP id
 98e67ed59e1d1-2fc40790624mr14866438a91.0.1739748057177; 
 Sun, 16 Feb 2025 15:20:57 -0800 (PST)
Received: from stoup.. (71-212-39-66.tukw.qwest.net. [71.212.39.66])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad4391sm6783744a91.27.2025.02.16.15.20.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Feb 2025 15:20:56 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 135/162] tcg/arm: Remove support for add2/sub2
Date: Sun, 16 Feb 2025 15:09:44 -0800
Message-ID: <20250216231012.2808572-136-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250216231012.2808572-1-richard.henderson@linaro.org>
References: <20250216231012.2808572-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1033.google.com
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
index c60b7e5faa..bff7b063fc 100644
--- a/tcg/arm/tcg-target.c.inc
+++ b/tcg/arm/tcg-target.c.inc
@@ -2524,8 +2524,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
                        const TCGArg args[TCG_MAX_OP_ARGS],
                        const int const_args[TCG_MAX_OP_ARGS])
 {
-    TCGArg a0, a1, a2, a3, a4, a5;
-
     switch (opc) {
     case INDEX_op_goto_ptr:
         tcg_out_b_reg(s, COND_AL, args[0]);
@@ -2559,47 +2557,6 @@ static void tcg_out_op(TCGContext *s, TCGOpcode opc, TCGType type,
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
@@ -2645,10 +2602,6 @@ tcg_target_op_def(TCGOpcode op, TCGType type, unsigned flags)
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


