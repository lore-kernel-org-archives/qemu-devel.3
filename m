Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2415CA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 17:48:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNvp-0007Dn-R5; Sat, 30 Aug 2025 11:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEM9-0005yZ-82
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usEM7-0004B8-7r
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 01:42:29 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-770530175b2so2181824b3a.3
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 22:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756532545; x=1757137345; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nj96dS+M8kKPovZfBVhDgSl+RUPXB/i0J54XfFQ1BNQ=;
 b=fPlADP1EMvKqdqrD4Wedl4mr5XBZh7BHQxCzDw8L2U0vdb66W19SEOPDZ6UfVE8ex7
 vx8VwDi09Zw4j9I5JadYcFi3GWuN2Nd+89abEL3p9TdjeqTOgpTAPAzvRJLBeV3sNUKz
 siA3gLDvrQnwdHRUcngmA9B2a5Lyd62nHTgsLNNC6bm5+w81R4kx/M+3LMLNiJwnl/ZV
 SaoYGjY1G7kNrsb2rDUE3XKg8o4Us5OsKdY4jEpgZnIepqZ949fIu8FoZdrIqLcA0MJz
 scGP68pY7VDXPl8IuXjoIAJJYmukXvBEwoaU3zsI964Trso4WGXEvlYA/3ViIcy4oHxe
 jY5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756532545; x=1757137345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nj96dS+M8kKPovZfBVhDgSl+RUPXB/i0J54XfFQ1BNQ=;
 b=ZftQ9aseaweAaX0GfwqPaKuyKoNER7lynfp3Py1sftGvj/o/EqF2hJiJPk4qwVYR01
 oF15gcjYnVyoN99zSrsf93hXJRBMpVCXEqFiaCeJcA27BphqsIQahStAS+fn8fgWjFO/
 kNLkJMQrYAc0An1Zr1RpfRpizSdFME/Ws87tBfbWQf1RVd4hMb7VzjvydwsWsqyozHZF
 iZB6lG20qY3rwn/ZMvclPrHt+ixGFQQRTEEUb8TAW0ReTM8McNFBhqPiz1gjVAvYHaAp
 XguM9QTse2emUcFzm298w7HxsxERohlYrEgo9D5+8DVXGnYkWbOHGrG2X4PN4awbTf5d
 hQaw==
X-Gm-Message-State: AOJu0YztnqKtQ9TjqIZiwnQv03x4XeyATIbtq1y6dmQc2/2HF4MPzPpy
 ZaWTspiYiz7V3vUB1G80R3RvWd4D68Q3luFEjImP0J1mllujzQ1HXflHyDvnFug+nhCf0sU9Wjf
 GXg9VQCc=
X-Gm-Gg: ASbGncsUdD+KRSGLnaVg5vk1YJ7G6EU/GewI388YgxN1suL4s9rTJWD1I6O3naKJj1e
 RhFhg8JcX4WN//mqzzoZh5UoiMU9sKvoiMuekMsgh0gGa8A+ZrUmmrNSyJERXcGH/TWTkKra79Z
 T0PrifxLjNDs5IZ6/HouPZ3E7R9foC7oIBXU4BlzmQd36cCt0kSNxYvVfZWTZTFv04IHx2DFDtB
 LfFktYZa0zzrWj4Gdm3T5fMFoyC9RovLH30krXTzMvcWTVerW4mhcGu0G2x3zmzpCSiHO2R3aqK
 eaPjzVhNr8GaIQl5Ebq+1r8qakMQmZ9P3Q7loRJXFI9uNdEp+EGJCyTXYnZcezA6w5EXNGF2WSE
 ppl5yLZqXMRd7nOG+8jzxoOiSSngU3w3U10ZphaCqnifzSuP+EmjCBiKZ7cvQQIdZ0n1Ew1M=
X-Google-Smtp-Source: AGHT+IFGZg81tf2TxyJK+2L5CzgRw5/mnxW7PvwyJLVQpqBD8P90o6lqgghdVoSXAZ96NR3Q5r2qjw==
X-Received: by 2002:a05:6300:210d:b0:243:966e:21a with SMTP id
 adf61e73a8af0-243d6f0b8a2mr1744116637.36.1756532545614; 
 Fri, 29 Aug 2025 22:42:25 -0700 (PDT)
Received: from stoup.. (122-150-204-48.dyn.ip.vocus.au. [122.150.204.48])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b4d96829a66sm2435905a12.6.2025.08.29.22.42.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 22:42:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v4 18/84] target/arm: Populate PIE in aa64_va_parameters
Date: Sat, 30 Aug 2025 15:40:22 +1000
Message-ID: <20250830054128.448363-19-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250830054128.448363-1-richard.henderson@linaro.org>
References: <20250830054128.448363-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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
index 8782594b77..e1f0ec2b7f 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1486,7 +1486,7 @@ static inline int arm_granule_bits(ARMGranuleSize gran)
 
 /*
  * Parameters of a given virtual address, as extracted from the
- * translation control register (TCR) for a given regime.
+ * translation controls for a given regime.
  */
 typedef struct ARMVAParameters {
     unsigned tsz    : 8;
@@ -1501,6 +1501,7 @@ typedef struct ARMVAParameters {
     bool ha         : 1;
     bool hd         : 1;
     ARMGranuleSize gran : 2;
+    bool pie        : 1;
 } ARMVAParameters;
 
 /**
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 91d6a7a5ae..ab801e2704 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9522,11 +9522,12 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
@@ -9538,8 +9539,17 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
@@ -9579,7 +9589,13 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
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
 
@@ -9658,6 +9674,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         .ha = ha,
         .hd = ha && hd,
         .gran = gran,
+        .pie = pie,
     };
 }
 
-- 
2.43.0


