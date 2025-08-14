Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E297ECA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:17:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXY2-0001dG-W6; Thu, 14 Aug 2025 08:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXt-0001a6-OX
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:06 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXr-0004Ie-5u
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:05 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-24456f3f669so9876725ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176339; x=1755781139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qRRS/gV/szOXu7puF9a2nCAqRylQ06iARqw+VOh+yuA=;
 b=vHDy5ow/CC+HMQjhna1u4+gZgzwxnZs6a4Yoz1tqP+qleVduYkxL3H5sG/6pHdvJtQ
 pU/Tm2sfxBGvav7sybGgaP+kVNKu279KbZLjaZBzgCD3eMhEZqEB1xYvxWvXjngidvZb
 GvyWWYFGXVMwbaLtXefh4CisMosXkrt+v0NJxDgJliNcCdwe7nkZRjbaLVHEakGNi9kr
 DolY9oMJSrKIiDfG5LmfIHmM4QRAwYwGlfXT54QOc2oRmndLFJIosrhDQXO9ZJvDyeqv
 cEyNiOuO+Y8mw+NyZywmBnVQ8mfCSqSu1p5SAI8NLi3O9GlxR2ev1NGLQivP/EkT760l
 k1UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176339; x=1755781139;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qRRS/gV/szOXu7puF9a2nCAqRylQ06iARqw+VOh+yuA=;
 b=E7UUSiDZ9R5g853OlaC7edLU9bmhJJFC21GsFAdbLm2mDE+7ynRAeJYOVqBYkarNTv
 x+pi4cA8Yq7pSNJ/U/ge9LtiyFoAluukR21SFYXaFWxqqpnKC6hor50q3Q5xLMa0IQHV
 N8J+pDW62UuoKEkQJZz3U6wWMoPV6sLb/JStEb4PCWVysVDfR2YRkpgxGRm1VUAFWKQS
 T1W1vpDUpsioHUZBQSvFM+aOG8cVN1ZPu3hkZeXrgYlMiCAEZUQrp+0XsYK8vpEPYb6Y
 5Oy/XOohJ8l3RLpkulRcYxCXTyd0L5fmwOXtVxdjAAd7C64PXYMaTNfpFg36qCqUMZIm
 075A==
X-Gm-Message-State: AOJu0YyBillMbxhIAJTZIaOBp+Fkd3bDvIy1489Jo6tEYdnihQDo5oFn
 BEOhePYFj8uL6KF4A6SfzakTCY/BKCGo9oGfsh/FyzOaU1vxjfRRPMH818p9BEahvYAu3+YDvBD
 6GRWfxq8=
X-Gm-Gg: ASbGnct9bhp3R58SAWz5/0kZPIeY4M/9g+Cy0mNez+C5ciH0TubFH6mWaKT+n+Hx3KI
 xXkejlwNfsckorH5HPSz9sYOi7c3mtv+9/KFB5hETGoK5cV0ykg5XBQB7hQMYxF6WFWeTp6KcLO
 Wg7MBCbtih3QBZnHDuR5clrd1yynrBdqNR36iK5GzLn3dN6fFGK9RAsHqYm8jIjPG4JR5vfMjci
 d0qqi2tfhmd76Zkw7dj76u3wWC+E9ee14t3LlsLfXo7P9dP6Y05GEH3wWR1QNgg4ckwdtphisy7
 TY1DoZ2vcE9mZpeXTt+v/t9hUJI4+/+gzNwnSC3EtZ+ZkwGw91sJdMuJkIHvu5z/duUir+1GXGf
 Tkr6WC3GlbWn+r3U+ZBtvHPXpveqejAjQof5BL7PrIJTGG7I=
X-Google-Smtp-Source: AGHT+IH/+tUVIaRxwAwWnYd269nYTRMP6TwFO0dpa4n+F/O0bDEX9Cg2IYQRZU0PJ/WQXdwEnqeaEA==
X-Received: by 2002:a17:902:ecd2:b0:23f:fa47:f933 with SMTP id
 d9443c01a7336-244594c7a4amr40027455ad.8.1755176339131; 
 Thu, 14 Aug 2025 05:58:59 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 18/85] target/arm: Populate PIE in aa64_va_parameters
Date: Thu, 14 Aug 2025 22:56:45 +1000
Message-ID: <20250814125752.164107-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
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

Select the PIE bit for the translation regime.
With PIE, the PTE layout changes, forcing HPD.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
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
index a6130f7dcd..168557b08f 100644
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
+            }
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
+               && (r_el == 2 || (arm_hcrx_el2_eff(env) & HCRX_TCR2EN)));
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


