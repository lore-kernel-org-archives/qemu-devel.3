Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 020D5C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwNj-0003uk-Li; Sun, 27 Jul 2025 04:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLl-0005Ff-RG
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:20 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLj-000452-HD
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:17 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-234c5b57557so28979175ad.3
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603394; x=1754208194; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x1wBSdpzr7dO5TzmGChoFiy9bL+r/HGBv+nchEC/hvA=;
 b=SM3JxG+ygp768HSWCLw3St1X81q/90xBgxeHU8D/ENIB33Tq9KuYFok1I7IQHt15Sf
 49GbGxyHiXdfbXWi0EI15pG3KhnF8FNX7VCWUlOCZt9a7of+T1Y3lrG4id3vkpRY4Npi
 VU13D8XsT8FAl8CrFfpZNrs0l4CXHEvPtz3n0ZX55I4jcjNOssUpc+xXUl8a1mrj8h+6
 hs2x46whHAegm41LvUgiz/9sonI+jkWXK21Q8Zqk9I90bPn0p7J9Z4iNPXuyZR3lu4PH
 DXT2zIZ6UYZKrB4nZghW+ijpvCwTnPN7abuvg9JyCHmKUC+9wUBk3ZU/Q0+R9l3c1D3Y
 +8tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603394; x=1754208194;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x1wBSdpzr7dO5TzmGChoFiy9bL+r/HGBv+nchEC/hvA=;
 b=jcwR7qJOItZfwejwnneGyfCDZ9hpOwxfH9Ui2h7WOhcxPPtirOWIIYsw8wWWlGf0M9
 KrwriiJmZ+y4V+FILIthF/qirQKWqS6BDrAfieGEn1bBlnNYfiyFFBU20Ja1cADVvxY0
 RGLPC1KnLCG2zEGIfkdC3IwwgWdRkAGEIXHyhzOXZOGfC9VI3Pnq+Gd3fHaThnwtJLg0
 HheAmhtK/lDm7oKzyMS45TY0uWhdZQ4Fqqsm4jhg7Dl/vuUGKQsQdGl5gWjTNh2/FgyO
 xEUlZg7iaHutWI0Q6crtiskw8n2SlwxGzPxECn7rjMprcfgwL2iMG4Dh8FWPfwhPGCQa
 s9ag==
X-Gm-Message-State: AOJu0YzDtucD6lFk/4ZkXAEWVygBBpytujrRKbM43NIql8v5S0t6CveM
 gotFGQm6pnTVBj+MmMPxEXNvyu+p32Ckd/61sCAWbu7WlIWFrs+hstdwJjTPlgkqSe/VAxamE00
 fbQdX
X-Gm-Gg: ASbGncs3R5HH+CRwvYWvm3qX8Au2UAo8Zw6JSHeLlRCrI8lhnS6iv1qIg+uVW0I14Xe
 5mJvcLuhmC1AA92qNHnMP/qEOduJlFgzQuAtU31GyFAvdE1lLQq7s16O64uc18D5UhESYsIu8dM
 iX3G1h4o6AhIvB3NfY7MgEzMk1nOVbs+q7w6AClzBeRi/WTCtmEvgMau9vQhRGdm1qVBt+4H/0d
 n0u0d1mJuxwHLy/ojpIeufw02ldCXO/yBv46u5pOlBZVhMw53LyR9eVYyi0LhJpowHBGP/bQN+k
 PAv54GYUddxJ2orJF3GdCr207QTnB29VmWqIUCxS17dQpVMSKbclqT8fGDyMJAjAy35GJ/NDCFF
 3G2bNMSL5kzhzvd3U56X3BAAvKFPuvHMsVqt5ljdGaVY1bq5eXmQhWItHiwfYAW58+QXN+hqm/B
 Krae0jZJelIw==
X-Google-Smtp-Source: AGHT+IGrJgro1MHVvAGPsm3lCGhD0+0mdcX7boiHCLcajNdaBNT4flTXjmo0GufvABkmlIkQJR9Eew==
X-Received: by 2002:a17:902:e887:b0:234:bfcb:5bfa with SMTP id
 d9443c01a7336-23fb302a71amr110099605ad.15.1753603394134; 
 Sun, 27 Jul 2025 01:03:14 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 14/82] target/arm: Cache NV1 early in get_phys_addr_lpae
Date: Sat, 26 Jul 2025 22:01:46 -1000
Message-ID: <20250727080254.83840-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

We were not using the correct security space in the existing call
to nv_nv1_enabled, because it may have been modified for NSTable.

Cache it early, as we will shortly need it elsewhere as well.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2eb2041edb..a5a3c03a4c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -76,6 +76,8 @@ typedef struct S1Translate {
      * may be suppressed for debug or AT insns.
      */
     uint8_t in_prot_check;
+    /* Cached EffectiveHCR_EL2_NVx() bit */
+    bool in_nv1;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -1642,12 +1644,6 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
     }
 }
 
-static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
-{
-    uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
-    return (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
-}
-
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1699,6 +1695,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
+        /* Cache NV1 before we adjust ptw->in_space for NSTable. */
+        ptw->in_nv1 = (arm_hcr_el2_eff_secstate(env, ptw->in_space)
+                       & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+
         /*
          * If TxSZ is programmed to a value larger than the maximum,
          * or smaller than the effective minimum, it is IMPLEMENTATION
@@ -2074,7 +2074,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+        if (el == 1 && ptw->in_nv1) {
             /*
              * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
              * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-- 
2.43.0


