Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81F06C8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 16:35:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXjFf-0006JB-V5; Fri, 04 Jul 2025 12:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF3-0002B8-2R
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:26 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXjF1-0006pL-3n
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 12:26:24 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4538a2fc7ffso15602295e9.0
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 09:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751646381; x=1752251181; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=B5CANpDPQWpyeOcAzPhRg6M8ZmHELAiHl2F8gI+LHZk=;
 b=LQgj2my3gu84UXza3pqgryCJLPsvf/cPqDyfTDASVQvp0rHk34EwBNbDuRq0tLcJS1
 uwZVuuPiC9B7dweiVElyHWPh56zsCQ7eK8Q0plBxu5elzcpSYZSDUKzKDWYAyPzheSDI
 3CONpbSDX9YA+AZarWpbwGclRVRcU8pIi2M8lJBwk1AoXelCNF3dsbuSgUWOh+n8mdpf
 DsvLiox839LaiJLWHP71c/uosdzzagjCfZhT2THkVIhXve4Xref3HF2cMzY0L0XHEMA5
 NXfRPH5KNd/4SSCDzrYgUoJzROZ5QLH/K9i7DZfbBLA6JysnDu7RvAfjJIDfFSdNCkiZ
 hbXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751646381; x=1752251181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B5CANpDPQWpyeOcAzPhRg6M8ZmHELAiHl2F8gI+LHZk=;
 b=iIXQX/0t/qiIfJSjz222rp+hGeKP4YZ8RqMDbdbKlzU8WdU+zRJwxwvq5MBYiNuBxK
 j1xMzn+TqsdHLrDlyZMpUTTFVKqYmbQhlUDBqW0hdrPi0UvWoctTcVKlYY1Azt/nsyaM
 CAVDCzJ/qbosulPOfOstq+EnX7k3MJSg+L6wVvkOJFJp0knf42snngjMcqiJRsjlq/+W
 h1/MGmHbi/tmAv1jLa1L4XBqZeqWe1leeDNc8RqPcGPjGjCfaBdyP6E2z7BQHO5lJ0R8
 J6g4nru/hvm4ezpeWAq8flMuq33YjqkHNIHhtghfbuyuepZra8XMZ4yXj8nex+THB1+t
 ok4Q==
X-Gm-Message-State: AOJu0YzGdm5hzXbXWXAvBqXRVtk5hd27Pxb22Jr2pCkkdaWqjExWt5ax
 kDS2CWjAhUZ8t4MQHAIj1abXqcf6i3Fzdo86x+hLhnw4CQxsy1NmEFS1neFFQAWISoNugBX4p4d
 se+68
X-Gm-Gg: ASbGncvhIj4yDcG+YYEqtuYMm0Ef8cG0bdC2/ZXfyYsv9tmlivBkL4NC/65DQMMFUYj
 /wd3om+ebdLa0wVwGzVONduIHT0O20HL97o/ful/qGz51GX+zu6PDHTPF8WajQ3iCwZZ0CWpvEr
 54uWP2FpTng3KfUhLYum/e039cZ9qRwcVQnroXuqEhFDMvniWWqQNrSVpnO0zsNwA7FfWWHQb3k
 eaMfpX5vPwc8d7mv4AOFwTQy1bJ8BBNW/fjLYUv907fNSw136MNSdPftmV0d+lf9ZPgUaYBhxXy
 hlJF/u+q5j8SKtmgFYa5wCSHKcXv6IcJlS2k2HH8L7pMdmL/IqszBcFeYLI/tDyagaXR
X-Google-Smtp-Source: AGHT+IFODmfwX70NNIHnw3UunoToh1RubFYqPKcgPwM0cJdrseAn41wHH+CGTCPDjLhVDLe4lGCyzQ==
X-Received: by 2002:a5d:5f08:0:b0:3a4:f70e:bc25 with SMTP id
 ffacd0b85a97d-3b495ccb8efmr3156051f8f.27.1751646381319; 
 Fri, 04 Jul 2025 09:26:21 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b471b96534sm2816857f8f.48.2025.07.04.09.26.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 09:26:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 082/119] target/arm: Introduce pred_count_test
Date: Fri,  4 Jul 2025 17:24:22 +0100
Message-ID: <20250704162501.249138-83-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250704162501.249138-1-peter.maydell@linaro.org>
References: <20250704162501.249138-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

For WHILE, we have the count of enabled predicates, so we don't
need to search to compute the PredTest result.  Reuse the logic
that will shortly be required for counted predicates.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20250704142112.1018902-71-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/sve_helper.c | 81 +++++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 35 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 0e59ad22624..5b5871ba138 100644
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


