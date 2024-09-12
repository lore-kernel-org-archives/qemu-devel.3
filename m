Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52080EE6421
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:45:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZm0-00033P-LW; Wed, 11 Sep 2024 22:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlr-0002TR-R1
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:24 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlp-000483-RK
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:23 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-205909afad3so5585285ad.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108880; x=1726713680; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d3AYwzPdHoHu5Aos81gdCbKTZ5PvIr4Bh9qOHvqoApc=;
 b=Rd8TeEjWqzwKADlbshioFVUe2NjnKi/9TItdr67iKodPhsAHjAwGR+aRBVBRZelHiA
 CiGcrDLp3g33nbX/Lptd2mp9UWRDl6u/Tzr3UR/WndO9hwYSQ5w1xrjQ52kDUVU8JtlW
 2byd6XmF++NJZ0FrYBiRdF0VIKyF7xIrQwhg0FZbi0XkDr4uAaD5kM+BJdL7FV/+EfnV
 U3+8As4aN4SRY+S8Rm+jMOp+Cm0YcdrwER0lzGPqhIR5oTqL9KHy7fLSokkdYURL+nqT
 XPm1iHitZidbzIvRGhqNwMIceySQ1cTA/Hg7rzyyEVBmpQMdkTYSeV2wFsbuPWxyqiyV
 yxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108880; x=1726713680;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=d3AYwzPdHoHu5Aos81gdCbKTZ5PvIr4Bh9qOHvqoApc=;
 b=CtLptHNkxr2kq+ovn6vhvtQR5uIZG9FiE2gyaRKCFJ2TKoCWXoH2P3HR4POvc79NUV
 uDQr7zfrWgWeXX3D4NkkiACN9LBUHiyOk5IWZS11RPOvCHSO1Cd72XQL1uEt+6oS5ulT
 Al2KT1GSNVgMcb5r7j9+H1lAcZjRJZAuZRDS/lNWvFYezHs4kx79pf1wn9/e1fMHbO33
 hwS7D/dRZOMJCmyZ0ShFcDChgZnCi0AkSvAUX5IL6WBQIZZLjtgWLYA5W4Wwgi2edcGJ
 tBil0yflDaT8AqljFtTiKjkKz9NkiGVt/y/i6jxb4wnupua49myW2SE7eRP0jzNCqsYd
 w9Lg==
X-Gm-Message-State: AOJu0Ywg/p6IqHvPItDQyRpI5xo5qVW/WkCE6DrZNf9emGsMShn41TOC
 JHl9RheZ9Ym2y1mZb0UDL1trRFEMCzTXZag+rr+LA7F2NUfRwC8elZ4/v1YiKI5gLcRCCKa9MAg
 c
X-Google-Smtp-Source: AGHT+IGpAslnmdfyBv4B2dXg7q51gDKgk891akWC7lkjFjMeRfKCA6yLmdGBOCQGgMPZr8O+8fM+gA==
X-Received: by 2002:a17:903:1c6:b0:207:7537:c651 with SMTP id
 d9443c01a7336-2077537c765mr9232715ad.45.1726108880473; 
 Wed, 11 Sep 2024 19:41:20 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 04/29] target/arm: Use cmpsel in gen_sshl_vec
Date: Wed, 11 Sep 2024 19:40:49 -0700
Message-ID: <20240912024114.1097832-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Instead of cmp+and or cmp+andc, use cmpsel.  This will
be better for hosts that use predicate registers for cmp.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 3edbf3a262..c5fc1b6cfb 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1160,7 +1160,6 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec rval = tcg_temp_new_vec_matching(dst);
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec tmp = tcg_temp_new_vec_matching(dst);
     TCGv_vec max, zero;
 
     /*
@@ -1180,16 +1179,15 @@ static void gen_sshl_vec(unsigned vece, TCGv_vec dst,
     /* Bound rsh so out of bound right shift gets -1.  */
     max = tcg_constant_vec_matching(dst, vece, (8 << vece) - 1);
     tcg_gen_umin_vec(vece, rsh, rsh, max);
-    tcg_gen_cmp_vec(TCG_COND_GT, vece, tmp, lsh, max);
 
     tcg_gen_shlv_vec(vece, lval, src, lsh);
     tcg_gen_sarv_vec(vece, rval, src, rsh);
 
     /* Select in-bound left shift.  */
-    tcg_gen_andc_vec(vece, lval, lval, tmp);
+    zero = tcg_constant_vec_matching(dst, vece, 0);
+    tcg_gen_cmpsel_vec(TCG_COND_GT, vece, lval, lsh, max, zero, lval);
 
     /* Select between left and right shift.  */
-    zero = tcg_constant_vec_matching(dst, vece, 0);
     if (vece == MO_8) {
         tcg_gen_cmpsel_vec(TCG_COND_LT, vece, dst, lsh, zero, rval, lval);
     } else {
@@ -1203,7 +1201,7 @@ void gen_gvec_sshl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 {
     static const TCGOpcode vecop_list[] = {
         INDEX_op_neg_vec, INDEX_op_umin_vec, INDEX_op_shlv_vec,
-        INDEX_op_sarv_vec, INDEX_op_cmp_vec, INDEX_op_cmpsel_vec, 0
+        INDEX_op_sarv_vec, INDEX_op_cmpsel_vec, 0
     };
     static const GVecGen3 ops[4] = {
         { .fniv = gen_sshl_vec,
-- 
2.43.0


