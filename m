Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3D68EE57FD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 02:41:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soZlz-0002zG-Py; Wed, 11 Sep 2024 22:41:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlq-0002My-Dj
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soZlo-00047h-O4
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 22:41:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-206bd1c6ccdso5034145ad.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 19:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726108879; x=1726713679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9bC2pdgCZhVH53QkJRlqyhl6QihYCpdmu7xOBS4i9k0=;
 b=cq+f0a82nCQzp2+BORa1OUtfwFFj/zFsu1Rg9UNt1kZkyhCC2FEWxxHIjpCf761xPB
 0hA2+4vZ/sRKTLwFhPEYjUWAiU4BzcKDtnamZ6BMOTJltKOhal/zZla5fpJ/zGt/R3l7
 GjFkaQziJqx3iVsBNiCT6fN2azYi0BnSFtGKMKJXJOJhbs4iekMiFhAmx3GbCQpLSDre
 yT+7jgKWW2XUPbN6NfNiDaBZMfjpS34Ka4JQ3RmZEOV84Xfd0nqkI2nRcNNIOemteoVo
 msCckXNRBX/Hprc007hyKGrCAj6cxnBoUCjSAKszBaYlaU06DnXyjFZEN+FHllHYu0qn
 5t5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726108879; x=1726713679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9bC2pdgCZhVH53QkJRlqyhl6QihYCpdmu7xOBS4i9k0=;
 b=IBeSwdXgXsxVoelUPiugqR8Xj7lhMDVgHispsh8BtzuIDEULENMYvuyEE4YgqoodKC
 RbG3XFMsTrrFBvGoqcRtVetSDl9WDZ5iO1D3KdMhZfJGH52ezR2eBAZZn2ty64lFbUNt
 CJexL1bEMHr1R4rcnJU+jHMSd9xOzuWee+0GCgfWeeifOKocTdHccFos4sSdhCp58B5v
 vYYZKiy1g7CefvVeaM6RLgSdXMvPg487c680A6u66/dDjHQ7fZitWfT8q7LjpAr0ierQ
 rEbJ2SZZ96/gA/zvlHubCy8d0t2rvogY37CEWjlvNsKekrOo6jf9bDjsG7eQJslo0/3r
 tuLA==
X-Gm-Message-State: AOJu0YxvlHu0otWIR1nuxGQQLQ5UC8EQ0bUueOHWvVzmbc5+IUPBEHHQ
 dwlGT9FzRj0T8qTAgdqxXTU8BgNtmcaPl+CVsMPciJ3fUGvMkLvC2FgnjGg2xu7o6KZWBP1LiFX
 Z
X-Google-Smtp-Source: AGHT+IHBC3qMCoGyvsKYyAFCOBf83Esal77HSba8NJ5nlRcffgKDCpZJIdm7Z42m5+YfFKULuxVd6Q==
X-Received: by 2002:a17:903:190:b0:206:cbf0:3089 with SMTP id
 d9443c01a7336-2076e44e010mr17777605ad.54.1726108879377; 
 Wed, 11 Sep 2024 19:41:19 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2076afe9c61sm5635915ad.231.2024.09.11.19.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Sep 2024 19:41:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v3 03/29] target/arm: Use cmpsel in gen_ushl_vec
Date: Wed, 11 Sep 2024 19:40:48 -0700
Message-ID: <20240912024114.1097832-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240912024114.1097832-1-richard.henderson@linaro.org>
References: <20240912024114.1097832-1-richard.henderson@linaro.org>
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

Instead of cmp+and or cmp+andc, use cmpsel.  This will
be better for hosts that use predicate registers for cmp.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/gengvec.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/target/arm/tcg/gengvec.c b/target/arm/tcg/gengvec.c
index 726a1383ae..3edbf3a262 100644
--- a/target/arm/tcg/gengvec.c
+++ b/target/arm/tcg/gengvec.c
@@ -1041,7 +1041,7 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     TCGv_vec rval = tcg_temp_new_vec_matching(dst);
     TCGv_vec lsh = tcg_temp_new_vec_matching(dst);
     TCGv_vec rsh = tcg_temp_new_vec_matching(dst);
-    TCGv_vec max;
+    TCGv_vec max, zero;
 
     tcg_gen_neg_vec(vece, rsh, shift);
     if (vece == MO_8) {
@@ -1061,23 +1061,20 @@ static void gen_ushl_vec(unsigned vece, TCGv_vec dst,
     tcg_gen_shrv_vec(vece, rval, src, rsh);
 
     /*
-     * The choice of LT (signed) and GEU (unsigned) are biased toward
+     * The choice of GE (signed) and GEU (unsigned) are biased toward
      * the instructions of the x86_64 host.  For MO_8, the whole byte
      * is significant so we must use an unsigned compare; otherwise we
      * have already masked to a byte and so a signed compare works.
      * Other tcg hosts have a full set of comparisons and do not care.
      */
+    zero = tcg_constant_vec_matching(dst, vece, 0);
     max = tcg_constant_vec_matching(dst, vece, 8 << vece);
     if (vece == MO_8) {
-        tcg_gen_cmp_vec(TCG_COND_GEU, vece, lsh, lsh, max);
-        tcg_gen_cmp_vec(TCG_COND_GEU, vece, rsh, rsh, max);
-        tcg_gen_andc_vec(vece, lval, lval, lsh);
-        tcg_gen_andc_vec(vece, rval, rval, rsh);
+        tcg_gen_cmpsel_vec(TCG_COND_GEU, vece, lval, lsh, max, zero, lval);
+        tcg_gen_cmpsel_vec(TCG_COND_GEU, vece, rval, rsh, max, zero, rval);
     } else {
-        tcg_gen_cmp_vec(TCG_COND_LT, vece, lsh, lsh, max);
-        tcg_gen_cmp_vec(TCG_COND_LT, vece, rsh, rsh, max);
-        tcg_gen_and_vec(vece, lval, lval, lsh);
-        tcg_gen_and_vec(vece, rval, rval, rsh);
+        tcg_gen_cmpsel_vec(TCG_COND_GE, vece, lval, lsh, max, zero, lval);
+        tcg_gen_cmpsel_vec(TCG_COND_GE, vece, rval, rsh, max, zero, rval);
     }
     tcg_gen_or_vec(vece, dst, lval, rval);
 }
@@ -1087,7 +1084,7 @@ void gen_gvec_ushl(unsigned vece, uint32_t rd_ofs, uint32_t rn_ofs,
 {
     static const TCGOpcode vecop_list[] = {
         INDEX_op_neg_vec, INDEX_op_shlv_vec,
-        INDEX_op_shrv_vec, INDEX_op_cmp_vec, 0
+        INDEX_op_shrv_vec, INDEX_op_cmpsel_vec, 0
     };
     static const GVecGen3 ops[4] = {
         { .fniv = gen_ushl_vec,
-- 
2.43.0


