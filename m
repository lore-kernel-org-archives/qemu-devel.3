Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54B53CCD18E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7Cok-00064y-Ni; Fri, 10 Oct 2025 09:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cof-00062x-WD
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:50 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CoX-0003lV-19
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:05:49 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e6a6a5e42so10069505e9.0
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101537; x=1760706337; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YLNaK8Bxzz1FjdeCqLMiRgOHl9BJ6T9HI3hQdq9vqtQ=;
 b=XUO41K2/ii7c5dqg4DyM8svdSaIMrPdyUjDVT8kLZu5dGDIXkegzV9PlV0NiItizeH
 NuMgeBUqdTDQo2yyLFYvzrtcK25/1sWIdR5lcTqzJiG3gvilgQL1Hmi2+dVMQ++4lLZF
 52x7QMsqxztR8KFXi9ak05OfQ5L+m8PSiaqGOhZmWf8sXGwSowv3PAxXm4T38omoTkt6
 ih9WHH7Dowk3NusFzf/AGzYZTPzB0/YigORKshPNpB3xG0fIXttwE1SX2ThjmFOjrN+h
 AO4Xu38YBVHAXl2+WTtdRAFFdIAMVa4uo6QKqth1KsbWH/KnUi8Jn5Rp42ESxt0z1LFh
 2zOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101537; x=1760706337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLNaK8Bxzz1FjdeCqLMiRgOHl9BJ6T9HI3hQdq9vqtQ=;
 b=GXk2Oob9RegZVrUXPDeqK7qJrLp3lrzUX4T+JxZacH2tYhCxMiTfhXejKsth211clG
 wdlqNt3oPT1CV5LakaSZGCl1JYOUhIVyGth/ziEHf7ysyMqkRJI9Z8QcAcvpuTqnW/DS
 7uwXAZ4CKkd2spyZ33N8wznqGzqrSAkvnjl5IaoDl1qw1k6EpXchkyXmHgcCf5j9EmVo
 XCZTk7JbMaLXQDDRbLMHnzyu1keRmPbT5IO+OmrAH6bjyIlPSBDEsRZgM6QF09HO/gK0
 mqr+5+EzUiTFat/cZJVw6EZ7t7d9d9JeEfdRxwSnyPSVXr8Fv/EZyX7P5xeelFpp7yP1
 83GA==
X-Gm-Message-State: AOJu0Yyarz87sWCSWW6R9Aj798QVUOku0HWXEUu35qt6IZ9GDLKAvkaV
 o1fDtWL/d/SOESMPXBquk855fnz9PBoiE/xudl7q48Paq5+peJU7OweTR6AtpEVvfb301HzT7bY
 qhEtC
X-Gm-Gg: ASbGncv4sHxdud67hs5F5m8ylh1JaSarwKF8dfCjEbGrdUJhO7kf1M5fyADHm62CEcS
 XTHF2XoYPjyG0AWivTi30nPng7rxF16R7XYYrxWBYc/Tsm5KEI5H363KrKc+dXJ5Ovc5HzKOXzV
 8xbXuFWF2jWdZEwxeZmir06CJ8d7z8mPCPCGP44vtXGluihfjCXxCj+qoQI2BM7/9grWluAlhWH
 WgiKFKITpGL1UBxtlMKg9JUYzK+oe3aggB+O4zC/17Fih4EGkbPXADAX68DDATiE5GXeBdgs+L+
 NA5Q1qYkbzc19xI9dWaVVWdMRrnmUzAtVE70bKItWj3wIr1n2yhdBy4YIcWpG0Dyu6c/5z3Ko7C
 J8da1SI2snNKV7B8D3oDagafFNcBf0JzBTJgpzmhEwRLWWIDbdvc=
X-Google-Smtp-Source: AGHT+IGQbZCxOiyRNI3movBRua5/hlyJbawQOx8xPA8AT8VSJMixHAoy02CVEJiOzz4hOyP05KPfuw==
X-Received: by 2002:a05:600c:45c6:b0:46d:ba6d:65bb with SMTP id
 5b1f17b1804b1-46fa9b01de9mr90074565e9.31.1760101536654; 
 Fri, 10 Oct 2025 06:05:36 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:35 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/76] target/arm: Cache NV1 early in get_phys_addr_lpae
Date: Fri, 10 Oct 2025 14:04:17 +0100
Message-ID: <20251010130527.3921602-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x331.google.com
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

We were not using the correct security space in the existing call
to nv_nv1_enabled, because it may have been modified for NSTable.

Cache it early, as we will shortly need it elsewhere as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-7-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 26570231205..e1515675eb9 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -79,6 +79,8 @@ typedef struct S1Translate {
      * may be suppressed for debug or AT insns.
      */
     uint8_t in_prot_check;
+    /* Cached EffectiveHCR_EL2_NVx() bit */
+    bool in_nv1;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -1677,12 +1679,6 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
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
@@ -1734,6 +1730,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
+        /*
+         * Cache NV1 before we adjust ptw->in_space for NSTable.
+         * Note that this is only relevant for EL1&0, and that
+         * computing it would assert for ARMSS_Root.
+         */
+        if (el == 1) {
+            uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
+            ptw->in_nv1 = (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+        }
+
         /*
          * If TxSZ is programmed to a value larger than the maximum,
          * or smaller than the effective minimum, it is IMPLEMENTATION
@@ -2109,7 +2115,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+        if (el == 1 && ptw->in_nv1) {
             /*
              * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
              * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-- 
2.43.0


