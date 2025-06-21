Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED98C71157
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Jun 2025 00:00:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT830-0004WM-VZ; Sat, 21 Jun 2025 19:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82U-0002Sq-R0
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:26 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82T-0005C2-0q
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso3410424b3a.2
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550064; x=1751154864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PUsGQeaVWdzEfLA4ZPf0L7EaF69nxGnusl9ChC//h68=;
 b=S9CcQRArHthPSzuw45vKnARCXq1XDF0IWrK20PtT6NCsCPGPo519WW8TJmbO31xfq8
 8PW9sfQfsYszn8oOKnabbQObl6rFDNjBfAAsMQChWQUqkwJmvTtZH52UzhQAlAx156kx
 Z/1jKQpk5aWtnP0dCac/0ERwY6uj/dVG9IiUDuRX+ovl7++dGKihDZrwIn77lPZP0K3v
 +eobSDcva4/xSFkWLBOoWzS89sza4mQmprCt0PwPXERmlvrngHSHcB8eXBgURvDi56B4
 ttXZi6/u96i+r7XA7p4fGFdoUoa4ZOhGV8JzjYAF85SVnS7avNZdmouSZYV6dihstzPB
 k5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550064; x=1751154864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUsGQeaVWdzEfLA4ZPf0L7EaF69nxGnusl9ChC//h68=;
 b=pso4nuOTtOGVX7XKgUQ+PfTWut9LyclN5Yz+ruo7L+XioEcdNHNy3fRqXroA/u3rM8
 F4q3YLg6iWyEcWjoZ0A0P/qFsG6wXTew++ZwHyJpt0q3VDulPIfoMEJRx2SdbYdV90kv
 oEAwfCmvBSMGxXqihqaF30v381wy1htEgZTZs0ZaMFI4SpbWwWsFSynJPxQ0kxKYwNFo
 ErGYrRv9SS5Ntgx4Z4AOkDH1azJ0fR6SYab04TOoc/NAf5K1hFob973ek7FvxmNnMtBB
 3j/PWIWLsPwfVWEpPRbhaLPqcmriX8iFN/FE7HQS1PEYvwfzPGy3T8TAAit902fx6xTA
 H2EQ==
X-Gm-Message-State: AOJu0Yz5FhFi5igH0eKRL8AQ4LxuIZXxMQ0kpixVzhI3n8mpqzAh5rGv
 HukbdyeAq+E6EbQTTVI8WmtNCfFSkjbkD+bJJGqFhRoy+M+uL4emZSLyR/7aQk67y6p/J4TyAVn
 6z0hpm+0=
X-Gm-Gg: ASbGnctYziK79aRlki9dncZGGTb9S7wv9cKE6oSkBK3xfHTH2nPmVDSKujGjCwEbsvR
 ujBXEycyMR1ZLvtpisTdH53MKDTyTrsd+wmqDTCfDgEm7vuVGLR9dsWwsUrrBqgT7sXkWBpWi4J
 UIpHJTeGytabp8H/EWhLRgPVR+pGV3uZOcwV/N1yVPjzjlF38Swm4hQ/O2ZsmZ52maF4pFIjWxg
 YQa9AQFGg91HgVJsKj32C2JaWfYOh9EYdosveNFu5ZsMNw61o84gqxsdiavKU3vi1NNoYwW5L2I
 Zhgk8ezEdE2J8aV3R3JT2LuOhJGUDNsrMZsDVn/eWh5tAq2w8GSP/4fTZNZPRcL6RMra+kfwS4i
 3I5JGFTWgL8mg4zifgdrj
X-Google-Smtp-Source: AGHT+IHLhU+rmoZu2xe6Vc2GxktmzTzA1YPANbQKcbsaiIbH/GHlmlyinqRj3ERrWjU1OuJ2YnYPyg==
X-Received: by 2002:a05:6a00:2e95:b0:746:3200:620 with SMTP id
 d2e1a72fcca58-7490d6a9d84mr10732227b3a.9.1750550063658; 
 Sat, 21 Jun 2025 16:54:23 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 070/101] target/arm: Introduce pred_count_test
Date: Sat, 21 Jun 2025 16:50:06 -0700
Message-ID: <20250621235037.74091-71-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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
 target/arm/tcg/sve_helper.c | 62 +++++++++++++++++++++++++------------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index e78d807ce1..df2cbf9b6e 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4102,20 +4102,50 @@ uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
     return sum;
 }
 
+/* C.f. Arm pseudocode PredCountTest */
+static uint32_t pred_count_test(uint32_t elements, uint32_t count, bool invert)
+{
+    uint32_t flags;
+
+    if (count == 0) {
+        /*
+         * N = 0  !(first active)
+         * Z = 1  (none active)
+         * C = 1  !(not last active)
+         */
+        flags = 1;
+    } else if (!invert) {
+        /*
+         * N = 1  (first active)
+         * Z = 0  !(none active)
+         * C = ?  (not last active)
+         */
+        flags = (1u << 31) | 2;      /* N, Z */
+        flags |= count == elements;  /* C */
+    } else {
+        /*
+         * N = ?  (first active)
+         * Z = 0  !(none active)
+         * C = 0  !(not last active)
+         */
+        flags = 2;  /* Z, C */
+        flags |= (count == elements) << 31;  /* N */
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
@@ -4125,7 +4155,7 @@ uint32_t HELPER(sve_whilel)(void *vd, uint32_t count, uint32_t pred_desc)
         d->p[i] = MAKE_64BIT_MASK(0, count & 63) & esz_mask;
     }
 
-    return predtest_ones(d, oprsz, esz_mask);
+    return pred_count_test(oprbits, count, false);
 }
 
 uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
@@ -4134,16 +4164,15 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
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
@@ -4154,14 +4183,9 @@ uint32_t HELPER(sve_whileg)(void *vd, uint32_t count, uint32_t pred_desc)
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


