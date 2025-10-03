Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70F96CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Oct 2025 17:12:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4jGz-0001a0-Vl; Fri, 03 Oct 2025 13:08:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGv-0001Wf-EJ
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:46 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v4jGR-0006F3-5i
 for qemu-devel@nongnu.org; Fri, 03 Oct 2025 13:08:44 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-28e8c5d64d8so24202445ad.1
 for <qemu-devel@nongnu.org>; Fri, 03 Oct 2025 10:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759511288; x=1760116088; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VuiQL7LRyA5U3n1ikOnovxnUWcpAWxmhlkEQq/p9QIs=;
 b=KAR3aeo7k2isp85BM/jZF4Ej3AaeSF0BhDSyzqANBq3ljbWgfWd5DffsJkIxi4olzu
 o8n2IWGhkAK0Y07VCEW2TwOvp+obK+IjPPpXzaTg8X9txAV51EESi2GKzjSZlfZVxuCi
 yGr5ZtjERlm6CqJTA29KCzvyBYI9DKdO/FwZyJYctOXr7NWEzWcI8oeq6YPDNsR8G8Jq
 NzsZuih4Mcg2xYoBYswybYViqGMoFs/XjFTXgasyhI9LhJqf7buBUxgqBCm+h0y/9inS
 usTEmobNXjEIiYb6gCeuXR3S8NPHeT7lSVi8uVrEO9c8ocD+bavCIxXbGkS20Q9/mB6f
 QuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759511288; x=1760116088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VuiQL7LRyA5U3n1ikOnovxnUWcpAWxmhlkEQq/p9QIs=;
 b=uKCcedruOqrVH5HBkkzQORAmC1HzppjwewIRNDdwKnfZ/Cc+hEW5UDVUGZuNwOaLP7
 JMzIXsG1nzN4be/Xyg8afsKyf+kuRoacT7Y5MK/n1i0Ko7mf0psMgZMInEYV8CaHcLK7
 a5IeSKU48fKL5A42F2kG8Y5usK7glp9FGYF6G5Nie9f2QgYGvZqQf9UVRTPPQTZoihTH
 +UK4euAYnbXRgJAd3KL1flJO/LqR6Rzhcq/NjSbAUeOunHkF8N06VZ5XleYfL9zo+Fk3
 ITzIpmuvL9xWIywL7/TZq6wEkYkJZdfZDKxqtJ/zU455BY+gNVKJRMc/VgGEIbXHQBcI
 bypw==
X-Gm-Message-State: AOJu0YzoZBlpNGtsGIWFxS6mD5TwAopZmAsdBaQXsHa3QhPaagX0spMW
 +gdM2c44H8RfGKOVQWcSrM8K7SzhPtGreJ6mnrvAjMhxNuqK09EGvKEp5dvlorhBZcLPh69O4HR
 wSf79lk4=
X-Gm-Gg: ASbGnctLoUzhfN7ThvZ1t/ZGrWi1BAvaLEk+OhSuhkacy7wuHvL6xyEOZmEsXvoNvR3
 gUsdyQL/Vuyi5iRA17CtnF8X85hl6N8BXnap1cRnsp6Wfjwc00PZTavnfuOCdEongcAmFM6fvD1
 NCZdBtn6lbCVYycVNzw2lDrLs+WiZjZR8ctS3jELY/q9o4BlEpGLD2is1NEsVqYqBzhhYiSEo5J
 ILa/K2ycv9Fbxe0Xz70/50TfgTcyvaxHUdN+1Vz0HGqnIIuvSKfBpCZJNbaNJ/5KpPYU1p5DwJk
 nvjej3Tg57qoUP96vQQRYTy0fX3CB+pPcwgUlRAzEBRbqppZKLoOQcaD+XQbEM4v5OoDTdGYzvE
 s8zDnlxhtPG9tf4rK3q5QDaJBS1j1XcIpTo7Q9KwrapVqWEoF7NHhZcQmCY1GequNztg=
X-Google-Smtp-Source: AGHT+IEWUF3+eSYDnnqmCblM2H7pgaBGTrLv+1qHXcUsICNayLjPbbJTXczq5RCVxxzT69ki8p6RIg==
X-Received: by 2002:a17:903:3c4e:b0:269:9e4d:4c8b with SMTP id
 d9443c01a7336-28e9a548e86mr51520625ad.21.1759511288174; 
 Fri, 03 Oct 2025 10:08:08 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-28e8d110d86sm55327115ad.6.2025.10.03.10.08.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Oct 2025 10:08:07 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v6 07/73] target/arm: Populate PIE in aa64_va_parameters
Date: Fri,  3 Oct 2025 10:06:54 -0700
Message-ID: <20251003170800.997167-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251003170800.997167-1-richard.henderson@linaro.org>
References: <20251003170800.997167-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

Select the PIE bit for the translation regime.
With PIE, the PTE layout changes, forcing HPD.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  3 ++-
 target/arm/helper.c    | 19 ++++++++++++++++++-
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1d958dbf68..face1019f5 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1491,7 +1491,7 @@ static inline int arm_granule_bits(ARMGranuleSize gran)
 
 /*
  * Parameters of a given virtual address, as extracted from the
- * translation control register (TCR) for a given regime.
+ * translation controls for a given regime.
  */
 typedef struct ARMVAParameters {
     unsigned tsz    : 8;
@@ -1506,6 +1506,7 @@ typedef struct ARMVAParameters {
     bool ha         : 1;
     bool hd         : 1;
     ARMGranuleSize gran : 2;
+    bool pie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index c19345dec8..ae8948d410 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9380,11 +9380,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
@@ -9396,8 +9397,17 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
+            }
         }
         epd = false;
         sh = extract32(tcr, 12, 2);
@@ -9437,7 +9447,13 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
             regime_is_user(env, mmu_idx)) {
             epd = true;
         }
+
+        pie = ((env->cp15.tcr2_el[r_el] & TCR2_PIE)
+               && (!arm_feature(env, ARM_FEATURE_EL3)
+                   || (env->cp15.scr_el3 & SCR_TCR2EN))
+               && (r_el == 2 || (arm_hcrx_el2_eff(env) & HCRX_TCR2EN)));
     }
+    hpd |= pie;
 
     gran = sanitize_gran_size(cpu, gran, stage2);
 
@@ -9516,6 +9532,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .ha = ha,
         .hd = ha && hd,
         .gran = gran,
+        .pie = pie,
     };
 }
 
-- 
2.43.0


