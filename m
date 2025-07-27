Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF3AC87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwNM-00030e-DL; Sun, 27 Jul 2025 04:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLn-0005G8-0Y
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLk-00045P-HY
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:18 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24003ed822cso1915325ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603395; x=1754208195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLtDIjPQLDZompmk/Ugn11Kk3KXRHr/yrDqwQ7AVJX4=;
 b=L8SLf3uQ1WIN7VqZQsI5YDrp7VK/Xuv8GZfk7ceC8amLA3aSqEFq0ODj2N9MPkvXcQ
 fJrkMmEMmjOXrIg0qSy1ToGrwqiWIa1XyBwTwiRENzHSXUUS6tVBztJWkiLx+iMKFFpx
 DBFZfAUZAoanjszrooZ++1pJt0CRyPnuD6igbK46DAv1SQQO2wWISn2AwCSS5Phenn8f
 Y8ofivuWLUsv9F2a/0YoN413GtnVIMsaSBjz7Kx4EqdEIaRi1fesvRn1tVx6px/nyW+o
 cRkMqbwhGNo7COFIQbeXXZiQNsmzB4N1CmRFsHnAtEQ75Mq4mxwHbq30Tlzk31W0DtcA
 j1Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603395; x=1754208195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iLtDIjPQLDZompmk/Ugn11Kk3KXRHr/yrDqwQ7AVJX4=;
 b=Gaf5e2luBxOUN8BATJtPwHXr5y4dTmJG+SALNrERSWSEeOp4QV3+FVxMvb4+OXZpW3
 9o8CE/Dmw2n0gBITRO5aNS8OWPxM9FjDgNr1rqBHFw7vt7JjaxKZRgUcM6tfzHh/9cjM
 iJX//G5ngnwgJtcOkl12K9Nxt3xyJoghgbWfmdpYvEeydwNQpuwJM4B3TuqqDwy1K1HM
 G4UON4pFUSLthb9JxyT+uSVegOb2psqZVxFR64GfIhGN/xdom+UWdMsXlrHTb2vJicaj
 SWi8zrZYDHPZZwS+oHdmnhHABWaxdgN3JMvpvSnDOrodKV+VZsfXCMV4nPm+kwXp0dCk
 AXbw==
X-Gm-Message-State: AOJu0Yw30ip2oU3TazqbVEHOLw1DG977ZLaQ57jwclft4OgkaMiRqCPB
 e+XOe+WKDyHugK7fX7TEaDQaIuqSWe+CRkjvT9VNKetRmob9R5IWMJNm6RyoMm/0IPaLliedWmz
 764mr
X-Gm-Gg: ASbGncunyyNdjx8jhvJfKt3kFb+iXZG/DmmQp+Tnh8WwgCg5XYQUSFUsYW1MOAIb4Co
 G7eWLurKxbitrrRCWnNUZvyys/ay2Ho32GHdusXfpClLy/Qg1IhaxQJ4MWdhk/uhyXOrW4lsZ8u
 ti3ac6ecW7EUcHXzBEX1xoad+bXPSLLfrMz8TQX+RL7CpUPf8NogArGZjqP1WPy45+19J/OuOd+
 tgsAE8B4gScIXsNKs8KVbQfuyVhxgX48Bdon96VGPM7tjlDJmzE6oWWOPnxckqWxJPSR0tXmEVM
 ZXLKtndOmuyJHEwcRk9vQv2kbJmeJ/mU5dVNcchpAdoaRRfC3jNZd5MwlPJCexokZj5XqZ1EGe2
 DEV7+KV1b/tNkL9wOg2iawE/+c5Uhu+Sdkp0uOiEvBEfO/bo9cOr1mNnUBH2lC4mydnYRY0lK7e
 h8fMfm3/+Onw==
X-Google-Smtp-Source: AGHT+IHUzhaK5+Wrx07Y+uyJBuZ19no1gmSavZADSHHojq2Mt4rkaYYvgDW63hOSLFOJVvW2zFfhjA==
X-Received: by 2002:a17:902:c94f:b0:23f:f6e0:b3c7 with SMTP id
 d9443c01a7336-23ff6e0b6a4mr40035955ad.45.1753603395214; 
 Sun, 27 Jul 2025 01:03:15 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:14 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 15/82] target/arm: Populate PIE in aa64_va_parameters
Date: Sat, 26 Jul 2025 22:01:47 -1000
Message-ID: <20250727080254.83840-16-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

Select the PIE bit for the translation regime.
With PIE, the PTE layout changes, forcing HPD.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 ++-
 target/arm/helper.c    | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0dd1b214c8..d5f501bb30 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1488,7 +1488,7 @@ static inline int arm_granule_bits(ARMGranuleSize gran)
 
 /*
  * Parameters of a given virtual address, as extracted from the
- * translation control register (TCR) for a given regime.
+ * translation controls for a given regime.
  */
 typedef struct ARMVAParameters {
     unsigned tsz    : 8;
@@ -1503,6 +1503,7 @@ typedef struct ARMVAParameters {
     bool ha         : 1;
     bool hd         : 1;
     ARMGranuleSize gran : 2;
+    bool pie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a6130f7dcd..ecce93fb97 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9628,11 +9628,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
                                    bool el1_is_aa32)
 {
     uint64_t tcr = regime_tcr(env, mmu_idx);
-    bool epd, hpd, tsz_oob, ds, ha, hd;
+    bool epd, hpd, tsz_oob, ds, ha, hd, pie = false;
     int select, tsz, tbi, max_tsz, min_tsz, ps, sh;
     ARMGranuleSize gran;
     ARMCPU *cpu = env_archcpu(env);
     bool stage2 = regime_is_stage2(mmu_idx);
+    int r_el = regime_el(env, mmu_idx);
 
     if (!regime_has_2_ranges(mmu_idx)) {
         select = 0;
@@ -9644,8 +9645,17 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
              * Thus disabling them makes things easier during ptw.
              */
             hpd = true;
+            pie = extract64(tcr, 36, 1) && cpu_isar_feature(aa64_s2pie, cpu);
         } else {
             hpd = extract32(tcr, 24, 1);
+            if (r_el == 3) {
+                pie = (extract64(tcr, 35, 1)
+                       && cpu_isar_feature(aa64_s1pie, cpu));
+            } else {
+                pie = ((env->cp15.tcr2_el[2] & TCR2_PIE)
+                       && (!arm_feature(env, ARM_FEATURE_EL3)
+                           || (env->cp15.scr_el3 & SCR_TCR2EN)));
+        }
         }
         epd = false;
         sh = extract32(tcr, 12, 2);
@@ -9685,7 +9695,13 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             regime_is_user(env, mmu_idx)) {
             epd = true;
         }
+
+        pie = ((env->cp15.tcr2_el[r_el] & TCR2_PIE)
+               && (!arm_feature(env, ARM_FEATURE_EL3)
+                   || (env->cp15.scr_el3 & SCR_TCR2EN))
+               && (r_el == 2 || arm_hcrx_el2_eff(env) & HCRX_TCR2EN));
     }
+    hpd |= pie;
 
     gran = sanitize_gran_size(cpu, gran, stage2);
 
@@ -9764,6 +9780,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .ha = ha,
         .hd = ha && hd,
         .gran = gran,
+        .pie = pie,
     };
 }
 
-- 
2.43.0


