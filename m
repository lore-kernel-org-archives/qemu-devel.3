Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 013FCC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:41:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFP-0004J8-8r; Fri, 04 Jul 2025 12:26:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF5-0002R6-R1
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:28 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF2-0006pq-TY
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-3a536ecbf6fso620914f8f.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646383; x=1752251183; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qfab+mF4jX/IBKhtqhTVoSV8zixm+glo9EFYwjvuj2w=;
 b=IBwsdrgrSfP2+B1fNd99tufy7X2atLUudTxQWp508oQjw/XiaPNzjGOfFvlM7Febd9
 d6L4+Ll+svOau65X3bYmg4MPTaOEE3TBB/eSgMrjhP0aG7HcvCn43PjAvCWGP/IPZ1FW
 bSmDjwpu3zH7//zSuAcIF1jAGQNk4Kpu/7mGlHy1zEMxC5IOdxwPzXLLtTwt/MEbY7Nr
 fpPHAPIzRW53kW3dY4ijLgq2xFmKaEeWmPdCszli1WntGEsmMDXknv7z4Uho9T1pMnbr
 j0pIJjiOlZkT7kCNWvr1ofTvlHqmycwXhD6d3Yw+vqkwx3WpW7Q+A+yCRvYeD2Ob/OBt
 LjfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646383; x=1752251183;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Qfab+mF4jX/IBKhtqhTVoSV8zixm+glo9EFYwjvuj2w=;
 b=pV2TuEAwGK7zPZ7IpyNG8+/N70mtd3FomdXkmuZxsmdwItEiPbqBmU7rQQgOu2koiq
 txGd/A4JCcrDEsVfy1w+SezAlSxbO4RDB4In8N+xoCrNrxZsdDhmjBG+G5GxliamhFO3
 SqM5VT3So9ckcW+v1wh4blWVbGnSO10VSI+80+L5fUAnUeym/PLBL1oq10dj3WY3x9QG
 io+KNYyAaQUBjD7Oy9z22mgG4lPLsJpTQJtzECAIwpQrdKNOo9udD2qjZbD542XxCEwZ
 ZZp05CeWGkQ/1KAGFRtAZyd81LDF96UPqQmJL7tx5VccoTin+8YQnYG8qm552j74YPJM
 Al5A==
X-Gm-Message-State: AOJu0YxQo88VvH/LrnIpQjCtdxBNMsH4WNVdR2evTD406ZLBz5M6f5y/
 uZLF2oBDFcDwLvTwKfUtGzf8ByWWHwtGO0fexCpC0XWVYkwOp6pmshhiB48dvxIyiccwr9l3U9D
 BTou8
X-Gm-Gg: ASbGncsaZ+PX6+R9hsYOx78iSD82X00GzSN//YlkOkEXmZSChLJHtILuugQWrYSPWDO
 YkR8L8ByzOkynGb5kf/FHUSzu0Yit5Ha7NzdKkt8d90993H/2I3SV6juu7l+9obYpWRTuHRvSNV
 uorB4/RdIZ6oTIXS++RAJN1oiRNXhKqVUeMxZgQ/ZiO/8ct2kb/ph4lEznsgqhvC96MW/8BAgtq
 te6NHMI8+fdVQfqBKjjF+37/nBBXM7mFRg1NDtc4d2I9+AkrCC9ulsOMMD3Kh5fPWEqoyhJdReN
 NpnZOALFvSNZFIxO4rlzJsEc21iHC+dHgjCPelqJ6clkOFEVnUpvVT+Lq5jBi/LdIKxX
X-Google-Smtp-Source: AGHT+IGczMqg2B/QglvCqCRy/lTAi6veLU8POiE05/p+80rPdhK1cpWbdfjIJEfWv0ZcaWB4r+hZEg==
X-Received: by 2002:a5d:64cd:0:b0:3a5:39bb:3d61 with SMTP id
 ffacd0b85a97d-3b4964f1dfcmr2814717f8f.27.1751646383364; 
 Fri, 04 Jul 2025 09:26:23 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:22 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 084/119] target/arm: Expand do_zero inline
Date: Fri,  4 Jul 2025 17:24:24 +0100
Message-ID: <20250704162501.249138-85-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

From: Richard Henderson <richard.henderson@linaro.org>

Expand to memset plus the return value, when used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704142112.1018902-73-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 492e42acc84..a62a647f3ae 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -3952,15 +3952,6 @@ static uint32_t compute_brks_m(uint64_t *d, uint64_t *n, uint64_t *g,
     return flags;
 }
 
-static uint32_t do_zero(ARMPredicateReg *d, intptr_t oprsz)
-{
-    /* It is quicker to zero the whole predicate than loop on OPRSZ.
-     * The compiler should turn this into 4 64-bit integer stores.
-     */
-    memset(d, 0, sizeof(ARMPredicateReg));
-    return PREDTEST_INIT;
-}
-
 void HELPER(sve_brkpa)(void *vd, void *vn, void *vm, void *vg,
                        uint32_t pred_desc)
 {
@@ -3968,7 +3959,7 @@ void HELPER(sve_brkpa)(void *vd, void *vn, void *vm, void *vg,
     if (last_active_pred(vn, vg, oprsz)) {
         compute_brk_z(vd, vm, vg, oprsz, true);
     } else {
-        do_zero(vd, oprsz);
+        memset(vd, 0, sizeof(ARMPredicateReg));
     }
 }
 
@@ -3979,7 +3970,8 @@ uint32_t HELPER(sve_brkpas)(void *vd, void *vn, void *vm, void *vg,
     if (last_active_pred(vn, vg, oprsz)) {
         return compute_brks_z(vd, vm, vg, oprsz, true);
     } else {
-        return do_zero(vd, oprsz);
+        memset(vd, 0, sizeof(ARMPredicateReg));
+        return PREDTEST_INIT;
     }
 }
 
@@ -3990,7 +3982,7 @@ void HELPER(sve_brkpb)(void *vd, void *vn, void *vm, void *vg,
     if (last_active_pred(vn, vg, oprsz)) {
         compute_brk_z(vd, vm, vg, oprsz, false);
     } else {
-        do_zero(vd, oprsz);
+        memset(vd, 0, sizeof(ARMPredicateReg));
     }
 }
 
@@ -4001,7 +3993,8 @@ uint32_t HELPER(sve_brkpbs)(void *vd, void *vn, void *vm, void *vg,
     if (last_active_pred(vn, vg, oprsz)) {
         return compute_brks_z(vd, vm, vg, oprsz, false);
     } else {
-        return do_zero(vd, oprsz);
+        memset(vd, 0, sizeof(ARMPredicateReg));
+        return PREDTEST_INIT;
     }
 }
 
@@ -4057,7 +4050,7 @@ void HELPER(sve_brkn)(void *vd, void *vn, void *vg, uint32_t pred_desc)
 {
     intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
     if (!last_active_pred(vn, vg, oprsz)) {
-        do_zero(vd, oprsz);
+        memset(vd, 0, sizeof(ARMPredicateReg));
     }
 }
 
@@ -4079,7 +4072,8 @@ uint32_t HELPER(sve_brkns)(void *vd, void *vn, void *vg, uint32_t pred_desc)
         }
         return flags;
     }
-    return do_zero(vd, oprsz);
+    memset(vd, 0, sizeof(ARMPredicateReg));
+    return PREDTEST_INIT;
 }
 
 uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
@@ -4124,7 +4118,7 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     tcg_debug_assert(count <= oprbits);
 
     /* Begin with a zero predicate register.  */
-    do_zero(d, oprsz);
+    memset(d, 0, sizeof(*d));
     if (count) {
         /* Set all of the requested bits.  */
         for (i = 0; i < count / 64; ++i) {
@@ -4150,7 +4144,7 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     tcg_debug_assert(count <= oprbits);
 
     /* Begin with a zero predicate register.  */
-    do_zero(d, oprsz);
+    memset(d, 0, sizeof(*d));
     if (count) {
         /* Set all of the requested bits.  */
         bits = esz_mask;
-- 
2.43.0


