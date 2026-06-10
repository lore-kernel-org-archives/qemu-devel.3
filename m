Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667BECD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:13:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXLXo-00083W-DR; Wed, 10 Jun 2026 12:12:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXV-0007iE-DW
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:27 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wXLXT-0005VJ-P0
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 12:12:25 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-490aaeabdb4so45681165e9.1
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 09:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781107942; x=1781712742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=y9bfY6SZ7Mqytp3KNtRVErbMA8CaOzHhsEk9wJ/yFSQ=;
 b=d/Adjsy48LTqwkrli7FVK+CNOKyDuMI/g5/BfoxzA6pQus4wie1t9uqzlzUic2qRaC
 CrFnyk3IScEucWjOEQrxhvxFCGWT7KA+QN6DomTYD7dHH+AqRwvg/px13x7ECcDMZweV
 QOhJObtlwvJWDi9woK/M+YBvAMrWQ1zTynt/sPoTK97QgPbcUvf0MsY3iTckulcmVZ/u
 iV4WM4cWnvsyjlz1BGlB/KLy+1D1E040TUQ/z2mHYr/3ZJzGrNwZlMKCDPnz6qxsxFnd
 cOn39v2r2FfDdLxOM9Z6qd153AJpBIySpB+GA/0wefizUp9ljVUtoUAyzhdh+4e5ZIoY
 AXeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781107942; x=1781712742;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=y9bfY6SZ7Mqytp3KNtRVErbMA8CaOzHhsEk9wJ/yFSQ=;
 b=Gi08aczM+S+xB2fIMQlrbdzK5bIQWB7CMLz85ZTjKfHPFLBY4QbcQt76GPODJuxqG8
 8HsB3UBVdKcgvPgIDnOhNplz3fR1VBP0U4srBdcVpAEjFfQaR367QjmbOWkInjO0Yu33
 965+r7/PrXZKkbR2/+G3yW6xs4t9P+IyzdJJJcJttnQs/0nRjiIokoGijPV1cEQnzSVS
 lYFeZ2Xddqgz/9U35BLbxIo+zBRgEOINf9+n6yNJg60QUGxA31m7zIInxLLHhSayhj67
 rs0eq+HvwT0+LFD/eFxniZTzyVXiwdr4S9xyfqoh1VNNtsxi2zsvU1Rj7pF2fxhIObEM
 e/aA==
X-Gm-Message-State: AOJu0YxXErA2rGKrohiT5pd937uzP1gWVLVoJKKsWtv/cGhvroYifRiv
 ddzpz+BdTv/ZFhQnwgokxUQ+eJSWz1ruNyZ5125Q8wgj1ja0ImNzFrfYS4DK9tJnEPuDY3mvEET
 ynCyH
X-Gm-Gg: Acq92OGprsiC7ImfbeL7BddPF1oXW0fs7wXDrPJA9WW9sLrR7SgHh+b35vdSUTjCYQI
 ehsFq2J4uJa/yP/jNCtWxtK+tsv7oOHdOyqaJmadetU+EwzwFtJajPG+yMJdjbU65sMF+VcfZea
 HvibZ56/Zkv5KpLgZMpesuAgemlXxaEgaofJ07h58klioYihH6bdOe+8XoY/jD0ymz5MxeDPJDQ
 BDeDODARCel5XUUCUQ8/ABlDGz+SRDA0EAwHy2iN20VzOVg3mOJB/Y9tLsgis3S/XmQE1GVZ/Jf
 js+O5IMgEwYF6lKlWvPg+NZvaMPD2FK4GKwcEslC1wYZjp6lPpd0HhZ/g3LIP1nG8GvotXR8tYh
 RoQ7C2R+09g4QK7io6Vz+KrGTW+y96gytV066Cq7pFm8fjHUwUiUc81o4/YEWmCrjX9YRCCzPrU
 l6zmHmkdutYai7E3Mq6m5HQtA7zUjkyihIXchRwqixgdBoom11URJH7xmR2/wkVgssDNNBhRdKf
 fS1V7tF4xCXWfXFy/7HotLwvSTANucPVPJAwCUu328=
X-Received: by 2002:a05:600c:1d27:b0:490:add9:7f88 with SMTP id
 5b1f17b1804b1-490c25dd709mr444817285e9.21.1781107942067; 
 Wed, 10 Jun 2026 09:12:22 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dcbe3sm67911360f8f.8.2026.06.10.09.12.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 09:12:20 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/71] target/arm: tag is not a part of PAuth with MTX
Date: Wed, 10 Jun 2026 17:11:04 +0100
Message-ID: <20260610161202.2235298-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260610161202.2235298-1-peter.maydell@linaro.org>
References: <20260610161202.2235298-1-peter.maydell@linaro.org>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Gabriel Brookman <brookmangabriel@gmail.com>

As described in the section on MTX, tag bits should not be used to store
or compute the PAC when MTX is set. See also Authenticate(),
InsertPAC(), and Strip().

Signed-off-by: Gabriel Brookman <brookmangabriel@gmail.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260529-feat-mte4-v7-12-ccbd3c14eb3c@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h        | 12 +++++++++++-
 target/arm/tcg/pauth_helper.c | 18 +++++++++++++++++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index cd93499307..21cbd2b1db 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1840,7 +1840,17 @@ static inline uint64_t pauth_ptr_mask(ARMVAParameters param)
     int bot_pac_bit = 64 - param.tsz;
     int top_pac_bit = 64 - 8 * param.tbi;
 
-    return MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
+    uint64_t mask = MAKE_64BIT_MASK(bot_pac_bit, top_pac_bit - bot_pac_bit);
+
+    /*
+     * If mtx is enabled, second nibble is not part of PAC. See
+     * InsertPAC().
+     */
+    if (param.mtx) {
+        mask &= ~MAKE_64BIT_MASK(56, 4);
+    }
+
+    return mask;
 }
 
 /* Add the cpreg definitions for debug related system registers */
diff --git a/target/arm/tcg/pauth_helper.c b/target/arm/tcg/pauth_helper.c
index 67c0d59d9e..3d83ca4c3c 100644
--- a/target/arm/tcg/pauth_helper.c
+++ b/target/arm/tcg/pauth_helper.c
@@ -342,9 +342,16 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     }
 
     /* Build a pointer with known good extension bits.  */
-    top_bit = 64 - 8 * param.tbi;
+    top_bit = 64 - 8 * (param.tbi || param.mtx);
     bot_bit = 64 - param.tsz;
     ext_ptr = deposit64(ptr, bot_bit, top_bit - bot_bit, ext);
+    /*
+     * If mtx is active but not tbi, then the top 4 bits are replaced with the
+     * ext bit, while leaving bits 56-59 alone. See InsertPAC().
+     */
+    if (param.mtx && !param.tbi) {
+        ext_ptr = deposit64(ext_ptr, 60, 4, ext);
+    }
 
     pac = pauth_computepac(env, ext_ptr, modifier, *key);
 
@@ -377,6 +384,11 @@ static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     if (param.tbi) {
         ptr &= ~MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1);
         pac &= MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
+    } else if (param.mtx) {
+        ptr &= ~(MAKE_64BIT_MASK(60, 4) |
+                 MAKE_64BIT_MASK(bot_bit, 55 - bot_bit + 1));
+        pac &= MAKE_64BIT_MASK(60, 4) |
+               MAKE_64BIT_MASK(bot_bit, 54 - bot_bit + 1);
     } else {
         ptr &= MAKE_64BIT_MASK(0, bot_bit);
         pac &= ~(MAKE_64BIT_MASK(55, 1) | MAKE_64BIT_MASK(0, bot_bit));
@@ -424,6 +436,10 @@ static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
     cmp_mask = MAKE_64BIT_MASK(bot_bit, top_bit - bot_bit);
     cmp_mask &= ~MAKE_64BIT_MASK(55, 1);
 
+    if (param.mtx) {
+        cmp_mask &= ~MAKE_64BIT_MASK(56, 4);
+    }
+
     if (pauth_feature >= PauthFeat_2) {
         ARMPauthFeature fault_feature =
             is_combined ? PauthFeat_FPACCOMBINED : PauthFeat_FPAC;
-- 
2.43.0


