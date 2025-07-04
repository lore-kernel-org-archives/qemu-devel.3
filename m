Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E04BC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:34:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhRT-0006lm-TV; Fri, 04 Jul 2025 10:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM9-0004jp-JN
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:41 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM3-00089S-Tr
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:36 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-610d86b3da9so260860eaf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639130; x=1752243930; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/H2t34ohcFGW/1kwGrNHnmjU3igen0lRkevftL37hWY=;
 b=irOo/OS35S8wEnwo+dcMKEHnZVUNuLZrECG4y++cNGBbKX0HO8kZFS3vmf3F0MIKhe
 /rFaD3oW6B1DQCH1WFAFORUrefxl6uDhV2+AUJ1cKTKfXR3xFEkA+jOJL0uIeKPpyNLl
 +PCnJDKz4VVZ117GD3XZNSb6yoiBCCLDzNQaXmT9rADPcjbx0Q3gWlC8e/xgzNnO4E/F
 N0VAFh+cWW4CwKHVtWz2RjtgyMYARV9T9FNA8C/sbWu6UXakriEp+YYkFUbsMoSH9mAt
 +EDuIP9PbKH5R16z4xV8Qni0vZt0f2kQtpnMShaIP/hWt4XK8QDLEHpJHvFhALaZJVHC
 dHOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639130; x=1752243930;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/H2t34ohcFGW/1kwGrNHnmjU3igen0lRkevftL37hWY=;
 b=ndjTXc4/H+k9jEC3pA7wKSv/IFsbz8PQjdPDgCMPyJCvanIHXPDNh5X0MU6EAZgQkU
 ofCjEJbXhXdzx2kfAvumYI6vhgmP5ls852cTx+sn4Im4a2GzXxVZ5T3CX6+HUV+Ki8sF
 rtnhoZ8ow+sjqOh2TVoh+dbm/raBGcuyt9eMWETwjAi4mHpngHSoYd9/LVR7+yjMtFN1
 H/32KtYnQB4baEd+QsgMDC8GgF96gW0p94a+GBMcfXIMNdrZ9FZ+Lk0lbU50M2qeoDkH
 gch2zfPZwO55hv4fAv4dT5BZ0Fiwg1cVh731XmSsyQuQN8TGKGnvdN/snzKthK53B785
 +RjQ==
X-Gm-Message-State: AOJu0YzRbgNDHbl16ZsIg8Hdrdy69Z/v7U/bH2i907fpRgdYvTpWVM2I
 6ACUHnnCtzQ/J3oKKTspkedfrZVKk8SpuS0+RHmV/yqB8rLOBXEJrGrmGwzoY8xHMjD5cUUCgEM
 YfyP/VhY=
X-Gm-Gg: ASbGncspavaVEvAYZvMu6CvVLeeWdlvpotvWVK8Mdx/SKgnLidoB9QICQSGmZfgadVS
 7+kkT5SJ8sBYP7Ck8Md2hSr9B2fiz3RW6Oy1rNqJRx0DJQ/zskRKrn2nnP1WEHXW+94LK8IHCTY
 60g5CRWCQOmvlwl1i25dhpPFWFhG32fq5ousaoohZYNtOoH/3glmfWxaM5OPxF6BuKT0XlgSdhi
 HxqsjIrx43kMBNKCHvcftBkaB4+NRFzuY3evTecRpn7TohvRTaxDSkCmGFUCj9UNTwqboNuvQAw
 t+pVIG+Uvmw5rvZaH1jNKaZPj9aDTUSsrCFPVa+yErZi21hOpSRosvbsF2IuDg00qbnIVV3IVzQ
 3U0oV3ijxfqWzB3qmPY1NwkWkePQNyJ1XoCDSRWsjB37nCvXDvO4eDYfOrSE=
X-Google-Smtp-Source: AGHT+IEPb0l3DoHIRB8uVGLjMHDqjE5z1nJQkJcLAtF0z+I1YFTtqoW6raKkcntkFxIaQlO7JN76kA==
X-Received: by 2002:a4a:ee98:0:b0:611:cab3:5822 with SMTP id
 006d021491bc7-6138ffbca7cmr2137580eaf.2.1751639130128; 
 Fri, 04 Jul 2025 07:25:30 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 072/108] target/arm: Expand do_zero inline
Date: Fri,  4 Jul 2025 08:20:35 -0600
Message-ID: <20250704142112.1018902-73-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

Expand to memset plus the return value, when used.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 492e42acc8..a62a647f3a 100644
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


