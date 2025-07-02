Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF99C83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 14:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwps-0005ld-4Y; Wed, 02 Jul 2025 08:45:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjb-0004QP-CL
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:45 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjR-00029L-C2
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:42 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-60402c94319so3919077eaf.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459910; x=1752064710; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xbpKY4w+Y2nS3xulbi2ps1vjI+IV1lSD7HJlNH9G7dI=;
 b=KG7WPiBYJRrZ1k+WCIt5ENQi4QolrULPyX0AyT39fAA1x5VpJveHauxUfw+ESFP/Fe
 qnGwbd3CYtx9cUefy0DOU+hNogm224VQ3qwKwenYPCbqFpo7DSrXZ/Tr66VCJVK/iFOT
 Hwi92PSLpUelpVGHA0AgY4GoN4NJz5k2GTCPECZY8NVvakK0UwfOr0btx2zbi0RESY9n
 53qCV79lb55hVblf8p/lrcmeMgSfh8ET6ytKTZMm49JrpRgepCu8mYW/mBEpq8GRmdzw
 9uoRSCu5ReP2/v2JWY+BmU+irZSfTk2X6Ra7dS5bYBWcXuXH9ldY6xNvVX9yBKoO56bX
 u8Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459910; x=1752064710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xbpKY4w+Y2nS3xulbi2ps1vjI+IV1lSD7HJlNH9G7dI=;
 b=LNCIx1PdAg6bl1UOfPJd3twV4LtWwAqf+2nzSKJnpjHzVhAf+n7KFwDwfV6oOjqTDb
 xdwMQ9uRRqz99VziflFH22O6yJYo31qEm4yBVIAFdDStmsjiC9bHQ8Oe/dHSSAMPCS7r
 T+3FB947y1zOnKGolxoUyK+xYmErfWphv2Bw+FlU7OrjMk9/tRVKxuqVWikYELziSLsY
 IfaBprUHlUVKMJjAuhGBvJW+t74yfbXI7h8PUJqTrwA+3/guFGyPwMHZ1gm1CCAu+K8I
 RlTz8jXp1iPmWad+4I0Z0th/zrkj7ZVovcM8hw7lJLinwtDPMXRXwk8BqfWXSwek83lF
 sexw==
X-Gm-Message-State: AOJu0YwHfmo4tA98uNwYt4MbOy6lcY/WqYMalsZbEYEsdlgodZ7ynnIy
 y/p1kk/TQYZ57grYg/s2qf8OC6ljVigOwmMiOPqxWpOVKIGzYnCRb39tPdSgC8RpsbSALpNuqBb
 +ANpuFSM=
X-Gm-Gg: ASbGncuWoA9WQaWE9b84tM1kILFkrsFKEvJxzuC5HvUxkIo7ikRNksB9AoO/FFyuEty
 oN9E41y3IebZXpxOAr9/fqPUyWOmCcJil4RzwhCWaN/+WN9PCKiGYbcDgS+623x4jgAgM7PT0VQ
 MzfXE7XMVBNiYjmPQRndmOwBoa9aRxniTqbG/crjj4krD+i77WInB616uSx3KPtlWJrPvlokwWi
 CC4UAXrIh8ePlXCXMAkozkCDVRk+TMSKdHV/cxwWmY0KIbbcViPap6vsDDKmZ9ZYdKrgVMx+9hM
 9+e0i+YyeGBRsiWjlcf2uV5nZolku2sSvQBfn51sPmsrAp0ahiqvKlcpJXOj/A5UI7iliA==
X-Google-Smtp-Source: AGHT+IGncyXOGMnbjF/fFvgvSY8h3/cUzGnAbJrTkjFrdOoF+oZkNB3RA+xmFukRx81cPR7d0CoaYQ==
X-Received: by 2002:a05:6870:d0ce:b0:2ea:1e55:a596 with SMTP id
 586e51a60fabf-2f5c7b59d7fmr2207278fac.30.1751459909780; 
 Wed, 02 Jul 2025 05:38:29 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 60/97] target/arm: Introduce pred_count_test
Date: Wed,  2 Jul 2025 06:33:33 -0600
Message-ID: <20250702123410.761208-61-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

For WHILE, we have the count of enabled predicates, so we don't
need to search to compute the PredTest result.  Reuse the logic
that will shortly be required for counted predicates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 47 ++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0e59ad2262..8fb9d0241d 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4102,20 +4102,35 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
     return sum;
 }
 
+/* C.f. Arm pseudocode PredCountTest */
+static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
+{
+    uint32_t flags;
+
+    if (count == 0) {
+        flags = 1;                              /* !N, Z, C */
+    } else if (!invert) {
+        flags = (1u << 31) | 2;                 /* N, !Z */
+        flags |= count != elements;             /* C */
+    } else {
+        flags = 2;                              /* !Z, !C */
+        flags |= (count == elements) << 31;     /* N */
+    }
+    return flags;
+}
+
 uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
 {
     intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
     intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
     uint64_t esz_mask = pred_esz_masks[esz];
     ARMPredicateReg *d = vd;
-    uint32_t flags;
-    intptr_t i;
+    intptr_t i, oprbits = oprsz * 8;
+
+    tcg_debug_assert(count <= oprbits);
 
     /* Begin with a zero predicate register.  */
-    flags = do_zero(d, oprsz);
-    if (count == 0) {
-        return flags;
-    }
+    do_zero(d, oprsz);
 
     /* Set all of the requested bits.  */
     for (i = 0; i < count / 64; ++i) {
@@ -4125,7 +4140,7 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
         d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
     }
 
-    return predtest_ones(d, oprsz, esz_mask);
+    return pred_count_test(oprbits, count, false);
 }
 
 uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
@@ -4134,16 +4149,15 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
     intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
     uint64_t esz_mask = pred_esz_masks[esz];
     ARMPredicateReg *d = vd;
-    intptr_t i, invcount, oprbits;
+    intptr_t i, invcount, oprbits = oprsz * 8;
     uint64_t bits;
 
-    if (count == 0) {
-        return do_zero(d, oprsz);
-    }
-
-    oprbits = oprsz * 8;
     tcg_debug_assert(count <= oprbits);
 
+    /* Begin with a zero predicate register.  */
+    do_zero(d, oprsz);
+
+    /* Set all of the requested bits.  */
     bits = esz_mask;
     if (oprbits & 63) {
         bits &= MAKE_64BIT_MASK(0, oprbits & 63);
@@ -4154,14 +4168,9 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
         d->p[i] = bits;
         bits = esz_mask;
     }
-
     d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
 
-    while (--i >= 0) {
-        d->p[i] = 0;
-    }
-
-    return predtest_ones(d, oprsz, esz_mask);
+    return pred_count_test(oprbits, count, true);
 }
 
 /* Recursive reduction on a function;
-- 
2.43.0


