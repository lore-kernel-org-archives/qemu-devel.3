Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37FC9C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 14:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXhTZ-00019c-32; Fri, 04 Jul 2025 10:33:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM9-0004k4-Tf
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:41 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uXhM5-0008Ax-C5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 10:25:37 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-735a8be4ea9so242228a34.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751639132; x=1752243932; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BEQcB1/UqEbBB8OYjKzTOMJUu4ZO4MlGo9qVante+Ao=;
 b=q5c5kDqs7FP2TkfuRA7Or/rYB4UM49aheV2n55sUuw9FpMeTB7E7kxHqJjLgTOL+cY
 IxC1cVQ/WmKE7FXywUwRYOKfKuplW1EORanzZXbHeLLIjPNCv5LRpuTeOf7P7JX+ojTV
 RI5mO8IOoxKsLhJhbraxujRclng2K3nUFLCOJozKHoUvgjlaNlNVEIB0ZF3NPuy1vJfC
 sI7+IH0r++hdQpsW7F9yTVKvDVW5qGxyS7VPXgY1VjeD3P7ha9b4XlLCnLUKmipOLB0t
 IEBv/xZpebtMVBodHKZXsJNP7wpugDTp0uNlYq1UxK1P2SWymcnIny6RbrOMPxzHNG/J
 ZNvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751639132; x=1752243932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BEQcB1/UqEbBB8OYjKzTOMJUu4ZO4MlGo9qVante+Ao=;
 b=AVpuBL09N6NtcqezMf5Q9yIgq7gZdY1Wmw0zovfulZ/hIgh+r9QVMEu97DdRGJQdht
 keXgiLG+oVhjU06/SuKrWBlc3G58kBxobc+6aHOLjeTkxeBce6iZ+jSjmAFBYkmXCykn
 0XrHFB4FiBLEMtwimkVYttaxNlAagkDP/BaC9RtDQrzAkeeG+8JFq4wW7C1zNSY38Acf
 tmGCTJ0N0v+Bj0OrSJ4JMxqrFKZ5YqEoDCAgHgWEWnETv2F7T1DyM493LV1xSpf21FJo
 9df0mASzRKnRmwHOho43TL384r74xxyJMehQD2OlHoZXyCjbSXLVm+aVAjE1TAlXy+mT
 mEiw==
X-Gm-Message-State: AOJu0YzLfeUUxyAH8I0DgXNqpC8pfU8caSS5+14YOZZElXm1i8QHYuDb
 CVfLHenz/T8BwulFwteP6GHAHZ+hOqqaNiZEd/rxbXxysBWq2fisdH1m1gfxzYU+DfN/o0/k2kb
 51GDibC4=
X-Gm-Gg: ASbGnctanfUyScItBtH3jhnt7Fwb2+8lBHpj2tq1j2AEX4kpTDOPIWDrNRfIiT8mG3Q
 rFqhpAdksGk464tOf/3FbzKcL5EPKYE07cUT6UmLXx/Po4ZLqLY27MWMcUCYRCQk9/0NvbsCfH0
 OZWLwupDBPXkESt8on5dFrPuH4uB9aY6IjLPBh7vws1d1j27R9zhLI0Yp8zP2lmGtHKOLRCYcnT
 yUqF9LXA2lJ8m+Ka7D3M/SPykvFL0f2EtjHbXcFePkWtXV0QJMYGtf6F6dHlNWrOuHNST8phlQk
 nRqJrwxOmo1t3AFcZEjnT42k4a4Crvi2N1ZqJZ/TPeVYokW6g+C8Za9JsBWmT8fiaiWJITRjdkz
 hVmIcObTYcEhT/rnjdTzPfyVcRKJVqkM5YpfErjjGWUMzdIew
X-Google-Smtp-Source: AGHT+IEQFeyvEF0LGOOD1QdtPhdFsvaO/T1sqTybhYh2WMgI9NQfx7d2/jFMDNJ9d2dYG14bPeQ90w==
X-Received: by 2002:a05:6808:3090:b0:408:fbb6:f4cb with SMTP id
 5614622812f47-40d04198e5bmr1962397b6e.6.1751639131908; 
 Fri, 04 Jul 2025 07:25:31 -0700 (PDT)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6138e5ac5eesm310233eaf.29.2025.07.04.07.25.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 07:25:31 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v4 074/108] target/arm: Split out do_whileg from
 helper_sve_whileg
Date: Fri,  4 Jul 2025 08:20:37 -0600
Message-ID: <20250704142112.1018902-75-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704142112.1018902-1-richard.henderson@linaro.org>
References: <20250704142112.1018902-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 39 +++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 741d04309c..5e11e86e5e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4138,34 +4138,35 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, false);
 }
 
-uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+/* D must be cleared on entry. */
+static void do_whileg(ARMPredicateReg *d, uint64_t esz_mask,
+                      uint32_t count, uint32_t oprbits)
 {
-    intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
-    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
-    uint64_t esz_mask = pred_esz_masks[esz];
-    ARMPredicateReg *d = vd;
-    intptr_t i, invcount, oprbits = oprsz * 8;
-    uint64_t bits;
-
     tcg_debug_assert(count <= oprbits);
-
-    /* Begin with a zero predicate register.  */
-    memset(d, 0, sizeof(*d));
     if (count) {
-        /* Set all of the requested bits.  */
-        bits = esz_mask;
-        if (oprbits & 63) {
-            bits &= MAKE_64BIT_MASK(0, oprbits & 63);
-        }
+        uint32_t i, invcount = oprbits - count;
+        uint64_t bits = esz_mask & MAKE_64BIT_MASK(invcount & 63, 64);
 
-        invcount = oprbits - count;
-        for (i = (oprsz - 1) / 8; i > invcount / 64; --i) {
+        for (i = invcount / 64; i < oprbits / 64; ++i) {
             d->p[i] = bits;
             bits = esz_mask;
         }
-        d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
+        if (oprbits & 63) {
+            d->p[i] = bits & MAKE_64BIT_MASK(0, oprbits & 63);
+        }
     }
+}
 
+uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+    ARMPredicateReg *d = vd;
+
+    memset(d, 0, sizeof(*d));
+    do_whileg(d, esz_mask, count, oprbits);
     return pred_count_test(oprbits, count, true);
 }
 
-- 
2.43.0


