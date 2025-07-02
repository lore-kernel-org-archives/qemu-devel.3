Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A5BC83F04
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 13:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwpT-0004kQ-2r; Wed, 02 Jul 2025 08:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwjs-0004hp-7u
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:39:02 -0400
Received: from mail-oa1-x34.google.com ([2001:4860:4864:20::34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uWwja-0002Ar-9M
 for qemu-devel@nongnu.org; Wed, 02 Jul 2025 08:38:59 -0400
Received: by mail-oa1-x34.google.com with SMTP id
 586e51a60fabf-2eb6c422828so3965287fac.1
 for <qemu-devel@nongnu.org>; Wed, 02 Jul 2025 05:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751459914; x=1752064714; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaZSG0e0yH3RxbDkM+zi9AN63MfHmwbxA5iySJBgmaA=;
 b=C5VD2dWTG6ESnQWaUe4kgnI7LNNSJzYdpyJrAy/lsSO+Go4ZPOONEyGhzm3kQDDGAn
 rK13donTpVQtrrNa9dl+25wz18DP7PRn6wIfe+yy+vCOMfLquCr1siZOmsbxto17gMDd
 FAp82kVhrYhCzO2SVDtLCve7+/v3T1XCIeuOfwnaT4GZzjW3rWtW1cKS+kbU/nEQNyq1
 TDwaY/KW5NYFoaZrXlmgrScJkRbjqJAexuQJIebeP6VdU46EIk0ZTX8+vB6wfd+7Ax1D
 TNoo5bHLKD11M49rDPYNIDYBeyvOjP4FtRuz34kAcXmwL17MxzZ9FJjWgYEiPFuowUpO
 nE8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751459914; x=1752064714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YaZSG0e0yH3RxbDkM+zi9AN63MfHmwbxA5iySJBgmaA=;
 b=NTdn+jmFJH2bRpc/Ctn3fQ1Debyja+s5hr6zZS0J/qnV3l1u+Igv3Rdd5LuGZSODHD
 gIuV6BLEhmyoyAZuKQz8CoNAfN/QOig8fh6VR+2kC9u2Df+nXchZpiEJvDtQ+/tOiB4d
 Y9mMYBiCFU4MS8RG7+nFscFvOlBLvIF9sZ8b4U52vtZKY8lGCwzNoYUyuHgHuCRKrIGL
 FeVDYnYk0Xy/3P635kyjTdnMKamX5CJpx9wQKEvVJifJ9Bv6XUYge29A7ftW7RlXMWyG
 k3UNAn5VUck163IVnErkc7wzp0Lp/Jkg5IyFMKJVcI2Q2n0RgOXhfM2x9WTHqiqcAKOy
 I34A==
X-Gm-Message-State: AOJu0YzM5GYJn4GveKgeo3kpOPL5HzBYzcnhILbuAsLMdpjFljKdr4M+
 rQtcFeXW7yl2SHGn3svvek2pq1QsodQ8vs8sKgrCX+f6jWk6nh7rg8I5ri8I8Dxl7BtiXQivJ/2
 UXpLGqqo=
X-Gm-Gg: ASbGncsJJYZYC3mNlc9gBges/dC5831Da16bqzkI8ipFhscARIaZ2iLGJQBSt/YFmyp
 t+/jA8FOonjzFv+bE+EDm+9sI10GqrstExZ41saiX46g6u+CYU1Qo5pc0Uq5mYhyE/H8DnC0ImX
 oMpZLbzsXpSyqNE8/Iaw/WsMnhsazYSnkSDlXQ3CLJ1BwkRXxhvmuxFqsC/bmC9FbfBostPzUq6
 Rg0hxFCZkUY00DtdvViFi2DoVBbUjHUxa5QmyfpjXVazOaq7J28tG5HMrIy0bUtpdb9766S8lfh
 fg/XZwtgFr8Y8J1VzC9hjTKzC2HKoWTxSbGos6S+XgoumTEL96Lg/o5RZgWVL6d4rB2sbQhS8Kg
 XLKWn
X-Google-Smtp-Source: AGHT+IH/SiZCi5qXDlyx39nUFHroOEGoSKcxmK5VgwRqZ8nbZIU3F5NIc1bmvqvjz6rrtGuYfehb7Q==
X-Received: by 2002:a05:6870:11c4:b0:2f7:64f7:8d40 with SMTP id
 586e51a60fabf-2f764f78dedmr325588fac.9.1751459914025; 
 Wed, 02 Jul 2025 05:38:34 -0700 (PDT)
Received: from stoup.. ([187.210.107.185]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2efd4ea5d9fsm3843451fac.10.2025.07.02.05.38.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Jul 2025 05:38:33 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v3 63/97] target/arm: Split out do_whileg from
 helper_sve_whileg
Date: Wed,  2 Jul 2025 06:33:36 -0600
Message-ID: <20250702123410.761208-64-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250702123410.761208-1-richard.henderson@linaro.org>
References: <20250702123410.761208-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::34;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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
 target/arm/tcg/sve_helper.c | 41 +++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index 4497e9107b..ba5ab6b513 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4141,32 +4141,33 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
     return pred_count_test(oprbits, count, false);
 }
 
-uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+static void do_whileg(uint64_t *d, uint64_t esz_mask,
+                      uint32_t count, uint32_t oprbits)
 {
-    intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
-    intptr_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
-    uint64_t esz_mask = pred_esz_masks[esz];
-    ARMPredicateReg *d = vd;
-    intptr_t i, invcount, oprbits = oprsz * 8;
-    uint64_t bits;
+    uint32_t invcount = oprbits - count;
+    uint32_t i = invcount / 64;
+    uint64_t bits = esz_mask & MAKE_64BIT_MASK(invcount & 63, 64);
 
     tcg_debug_assert(count <= oprbits);
 
-    /* Begin with a zero predicate register.  */
-    do_zero(d, oprsz);
-
-    /* Set all of the requested bits.  */
-    bits = esz_mask;
-    if (oprbits & 63) {
-        bits &= MAKE_64BIT_MASK(0, oprbits & 63);
-    }
-
-    invcount = oprbits - count;
-    for (i = (oprsz - 1) / 8; i > invcount / 64; --i) {
-        d->p[i] = bits;
+    for (; i < oprbits / 64; ++i) {
+        d[i] = bits;
         bits = esz_mask;
     }
-    d->p[i] = bits & MAKE_64BIT_MASK(invcount & 63, 64);
+    if (oprbits & 63) {
+        d[i] = MAKE_64BIT_MASK(0, oprbits & 63) & bits;
+    }
+}
+
+uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
+{
+    uint32_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
+    uint32_t esz = FIELD_EX32(pred_desc, PREDDESC, ESZ);
+    uint32_t oprbits = oprsz * 8;
+    uint64_t esz_mask = pred_esz_masks[esz];
+
+    do_zero(vd, oprsz);
+    do_whileg(vd, esz_mask, count, oprbits);
 
     return pred_count_test(oprbits, count, true);
 }
-- 
2.43.0


