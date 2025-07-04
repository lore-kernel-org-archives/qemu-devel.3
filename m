Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD60EC83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:52:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhSy-0008QT-Mr; Fri, 04 Jul 2025 10:32:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM6-0004Yj-Ra
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:37 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM1-00087Y-Fz
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:34 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-610db3f3f90so562050eaf.2
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639128; x=1752243928; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6bLvhBwNEmDsnka8cIDU5PrrUCOcipDYGvxoPFyUBc4=;
 b=vDc2C2rMeVVG6QK5W4T8/NKnhMOFn4Rxl/rDsV7vwinOqSRNCtdIBg48OUymM2T0Ky
 A+ywlxURYwXoOGQfIa+4ZDaB83meW2LcCK46flRRqfdOtuz7jQwnkfSfs1Ot4YjFclxQ
 pscbBnPbX6Gfm+9mQ0GUfflvGTagiRca5LAD8w/fKTSW6IP2Xy8BRmm/NxcnH0Izt+gn
 TNFtvZwi+i6wA4U8QWTKf0h6PjctriI2rLvKD2tzrbAlJpF135fhlHhnFxQiyBVqMX/1
 9E1tRMdpem4+6sX60pnqcmTk3Jl+nia9ajFS2bX13rRQhFpnoyb8q+bAuZ6pRpYKye6a
 FpZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639128; x=1752243928;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6bLvhBwNEmDsnka8cIDU5PrrUCOcipDYGvxoPFyUBc4=;
 b=uHStTqMXy8hAwRYAX3CarAPT+kGyQE9YiZPZpzRdYAg5t/oAjvBsfvQ9EeVt7ckP44
 vLuYahnVQ+zKKXI8cmP1O0+plm7UbaSNCC2j2hTWEfzE0qpavn6xd4/6/5i2Ai8hBgnx
 Go8Q797qT8QPOI3eVB9yj1XLjJbchnC7rgdYzWCM7nIGAJaMJx81a/KcWnkusIWqoBPi
 jgqQmpeR2GqOxTH/m3KJkDQGE9RhS8nieeUxkUhsAqwoXnIRlCHo6TUjUoYCUSmO4Mpd
 wBh23Lk3ypCZo2df/iSe6MIq0tKWtx8Ik+195t6sLxAdPapIM+gI2lBbiizYfbVofaKL
 gPnA==
X-Gm-Message-State: AOJu0YxlkXKvLLM3vrcjgRd7WQ3TYhAmuoPnCdLqw/GkDshB+uzxtyjU
 AZoNXyZrfQirWl1MXAf1KIMyZbPMd9Giy8kAZjmj6t/Vxt8h6cj+e9fOuFDaZWgv2d43+OwKZn7
 Rgz0BpgI=
X-Gm-Gg: ASbGncvMshTC6K8xvbB+X7/YNqFf5xEF9szDB9eyQQC6rhoUXGciFZTAiVtnGHnmr1s
 kM54h0JaP8w2mvABpTgSB/s/3sLda6rAg7xS+3OLfZlJuVS9y/e8jZRZVqqDE6BOmZQ9FqopC0E
 CZdDlufSFHZLCyjpB4/Oc7ZlHs3/odu/80U64NY9ZmQlLCv8DftfkC3qdxB6TUqOn+tkdwqf/Sd
 Q/Xhz/RwGPGiwT59NC+Aki33ZQRXkBAKjibQ4ldo3vdQbbr+3yd0sog1K0yvN1BplkYtI7cqMza
 ERyAGxKvN2l4wypJsuSdDvBXtZYbKOtRhnTkW+orTeebq08ouyqRhBOqEUSKrW8w2gxrPNUKqAS
 cGvsKdLl2yLHPnf/Z687+U9eJXdytbXRS1JMrMfSE/bYiSsj213t8JpHZWU8=
X-Google-Smtp-Source: AGHT+IGuWC8AJ64+53z/i471epF/TRbJNVGXF5+VCY0rjdAFaSs0xAzUz7B2aUIrt0JSGtwLbe5dLQ==
X-Received: by 2002:a05:6820:1e88:b0:613:8456:51ac with SMTP id
 006d021491bc7-6138fe859cemr1633774eaf.0.1751639128110; 
 Fri, 04 Jul 2025 07:25:28 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 070/108] target/arm: Introduce pred_count_test
Date: Fri,  4 Jul 2025 08:20:33 -0600
Message-ID: <20250704142112.1018902-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
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

For WHILE, we have the count of enabled predicates, so we don't
need to search to compute the PredTest result.  Reuse the logic
that will shortly be required for counted predicates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 81 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0e59ad2262..5b5871ba13 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4102,30 +4102,46 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
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
+    do_zero(d, oprsz);
+    if (count) {
+        /* Set all of the requested bits.  */
+        for (i = 0; i < count / 64; ++i) {
+            d->p[i] = esz_mask;
+        }
+        if (count & 63) {
+            d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
+        }
     }
 
-    /* Set all of the requested bits.  */
-    for (i = 0; i < count / 64; ++i) {
-        d->p[i] = esz_mask;
-    }
-    if (count & 63) {
-        d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
-    }
-
-    return predtest_ones(d, oprsz, esz_mask);
+    return pred_count_test(oprbits, count, false);
 }
 
 uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
@@ -4134,34 +4150,29 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
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
 
-    bits = esz_mask;
-    if (oprbits & 63) {
-        bits &= MAKE_64BIT_MASK(0, oprbits & 63);
-    }
-
-    invcount = oprbits - count;
-    for (i = (oprsz - 1) / 8; i > invcount / 64; --i) {
-        d->p[i] = bits;
+    /* Begin with a zero predicate register.  */
+    do_zero(d, oprsz);
+    if (count) {
+        /* Set all of the requested bits.  */
         bits = esz_mask;
+        if (oprbits & 63) {
+            bits &= MAKE_64BIT_MASK(0, oprbits & 63);
+        }
+
+        invcount = oprbits - count;
+        for (i = (oprsz - 1) / 8; i > invcount / 64; --i) {
+            d->p[i] = bits;
+            bits = esz_mask;
+        }
+        d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
     }
 
-    d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
-
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


