Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5532C71157
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Jun 2025 23:58:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uT83k-0007No-1T; Sat, 21 Jun 2025 19:55:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82V-0002Y3-AE
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:27 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uT82T-0005CH-JW
 for qemu-devel@nongnu.org; Sat, 21 Jun 2025 19:54:26 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-7426c44e014so2636406b3a.3
 for <qemu-devel@nongnu.org>; Sat, 21 Jun 2025 16:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750550064; x=1751154864; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=bliHKIgRmdX1Tt6AaEJ0otMgHYMH/b7BJuaKSgZpNx8=;
 b=zDaE6eGZjsTW0jnyfV7poRwDvuYbxJdI+laXp0BXOtgMDXAy8FxlBsr2pJCgwCqht6
 5GOgUH4nthFVayIrXWZfCxPwQXHW23aVwXowiep4zbecOZgUoZld8Bxt3JjZzaK55lC1
 7y4QRSUOYfdITXfTu14/RBcOUZ4WjBTME9uwcAKDLQQ7FytSnmzdWjwz/LsAlS86q6/B
 Q7Ie3iGhkcPsP4OqBlk//7tk+UyFLBhxthWHd7i5jZ4V3xOO/TQKOIEEp4D4jM06ZCf4
 EbbLE9PK5witEd9ipoWwQR3fgEduf27Pd05rWZfZCrZ82kY3/oW1kF9l5Ej8lL3x7YF+
 Z/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750550064; x=1751154864;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bliHKIgRmdX1Tt6AaEJ0otMgHYMH/b7BJuaKSgZpNx8=;
 b=Jjx/Aj1y1ayP+JHihSWv1ixfLpL5zRiK1vjCSSQIPzHiprVRe+6GVKzRo2WRm8nT4t
 xh9xVWQFCzlVCESpF32Ci77CeQAd6V4AxxGgc4zqHik6iEyu6tUL3iBehD7jH1WFi3zt
 bBieSXDVmKt1u+0CNdMDU1PZblrDa3F42gSEvjQKe+VPi+lDW8YZc7TO17oZdOxBR/qP
 qx+QQTAVI6VHgj8MJKerP21Dy84aODqs6h/ZrRzPPJkf0/QudOSIUAqC2s2XDeIKUX7H
 Zqzqpj8Qt0fyah6UYJY+OLsfMmfIfFVrHfNn/HtivJpbSvwWDKfZrOdAZIDY4ZDjgJsP
 g1+g==
X-Gm-Message-State: AOJu0Ywu24hP4a83INJECBKc8aKt3QEF7W0IwJpVQixzzw3GQ/kmHCIV
 S+6skudpKYd1ezF3ZIC/VmYC7PyoCLWdsax/5pk3DA4hmc4RJBLK0en0GVaMBiyNOO4ogzkusq5
 NbYxFK5Q=
X-Gm-Gg: ASbGncuyRbMh4x7l23npm6OkzYamgdxGIJfbhM6wkN7R6wdYSfsILiAyXvqkV63zc5Z
 CRsl/yTx79uQT9nCjFLuEpZEjdKH9Tlk5YSlvm2o0XGODH7CwHYj3+7lXkcXoTLtcwEoLurRLN9
 BIu4GfhQEXBQIRz4Rb/Z3uJg/CMFGVozXsyz6T9mwfqAmeh1nschAz6w5L7IFCsgpSXr7RFRqXK
 3mCq5mEbVMVTA9n1jV9q/Szq3W5Oj67KzfsNyxjyeD6At/kLbioKMCDxvFjT6qzEzVAPBXG2oPW
 vzuqmXWGUOkCg4DtLhDSL5eSvFtQbkMZDj75GTgoqE5cf8YFGQjH+K0c9fkebDpR3Dfh/B/GaEe
 sC9cq/1YQvSGg6bOzWoXK
X-Google-Smtp-Source: AGHT+IH5MDD38Z6kyMY6DrPm6T6oFYF8Jqz6Dli+K7vY0psIF2I0/kSLNO3W6JLkWOFDs01Kk8oeDw==
X-Received: by 2002:a05:6300:6404:b0:220:2caa:3018 with SMTP id
 adf61e73a8af0-2202caa3065mr8833017637.24.1750550064255; 
 Sat, 21 Jun 2025 16:54:24 -0700 (PDT)
Received: from stoup.. (174-21-67-243.tukw.qwest.net. [174.21.67.243])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7490a46b590sm4970051b3a.27.2025.06.21.16.54.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Jun 2025 16:54:23 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 071/101] target/arm: Fold predtest_ones into
 helper_sve_brkns
Date: Sat, 21 Jun 2025 16:50:07 -0700
Message-ID: <20250621235037.74091-72-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250621235037.74091-1-richard.henderson@linaro.org>
References: <20250621235037.74091-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

Merge predtest_ones into its only caller.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/tcg/sve_helper.c | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index df2cbf9b6e..789c9ce3a5 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4061,31 +4061,25 @@ void HELPER(sve_brkn)(void *vd, void *vn, void *vg, uint32_t pred_desc)
     }
 }
 
-/* As if PredTest(Ones(PL), D, esz).  */
-static uint32_t predtest_ones(ARMPredicateReg *d, intptr_t oprsz,
-                              uint64_t esz_mask)
-{
-    uint32_t flags = PREDTEST_INIT;
-    intptr_t i;
-
-    for (i = 0; i < oprsz / 8; i++) {
-        flags = iter_predtest_fwd(d->p[i], esz_mask, flags);
-    }
-    if (oprsz & 7) {
-        uint64_t mask = ~(-1ULL << (8 * (oprsz & 7)));
-        flags = iter_predtest_fwd(d->p[i], esz_mask & mask, flags);
-    }
-    return flags;
-}
-
 uint32_t HELPER(sve_brkns)(void *vd, void *vn, void *vg, uint32_t pred_desc)
 {
     intptr_t oprsz = FIELD_EX32(pred_desc, PREDDESC, OPRSZ);
     if (last_active_pred(vn, vg, oprsz)) {
-        return predtest_ones(vd, oprsz, -1);
-    } else {
-        return do_zero(vd, oprsz);
+        ARMPredicateReg *d = vd;
+        uint32_t flags = PREDTEST_INIT;
+        intptr_t i;
+
+        /* As if PredTest(Ones(PL), D, MO_8).  */
+        for (i = 0; i < oprsz / 8; i++) {
+            flags = iter_predtest_fwd(d->p[i], -1, flags);
+        }
+        if (oprsz & 7) {
+            uint64_t mask = ~(-1ULL << (8 * (oprsz & 7)));
+            flags = iter_predtest_fwd(d->p[i], mask, flags);
+        }
+        return flags;
     }
+    return do_zero(vd, oprsz);
 }
 
 uint64_t HELPER(sve_cntp)(void *vn, void *vg, uint32_t pred_desc)
-- 
2.43.0


