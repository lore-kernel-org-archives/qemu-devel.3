Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26499CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 13:17:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7CpS-0006Nl-BE; Fri, 10 Oct 2025 09:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7CpN-0006MM-5R
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v7Cos-0003sr-M4
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 09:06:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-4257aafab98so1792587f8f.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760101556; x=1760706356; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5ea7zwkpxAfZI0yrGmiDGMtnDe3MhZXY+7jpLKebbvc=;
 b=RNXVsV+qiq4ziyWiOA0KpZA8ZN69j33WMH+J4RAVA7FDj5kf7yPFAMEUI0vhovpP34
 vGiLADbV6HifgBgucz32Lu+IyZii96DF8d7LKXrGuopttCYxsr+qVGkuAmsYphgf1vQ5
 kBAUS2gRLii2L4902UIGa04UR8ButlLXssQYXAzm11Ur8GStIt0IWx5u5WOheo2tHWPK
 D5kS72QTB5UjXf9Dre/RQE6nzEELDj8ORMvNxKY4aNepbgMnTGicyrjtkFhypHOo7vd4
 oEIIC7VUVzghNg5B/kMN/a+qLieaMrBGv/VmOkCjlwFVxrPGfT3e2Km/6Mi6cyG9cy8w
 IGTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760101556; x=1760706356;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5ea7zwkpxAfZI0yrGmiDGMtnDe3MhZXY+7jpLKebbvc=;
 b=drmH7gMj+j7ZkeqV1oh8Zd7n1fKwOb417sHgZo39gpw7OeORjOtlPR3uSS6Uhe21Tv
 RTOnzeXow6nEDCcrzptNIqELFyC/J00FqsBK6k2UndRreaAwpadcZGcLe3tb9XnYTZFT
 qNdotQwpyGx82/z97PMjc+ktXe/wXi67aXFsTQTVbiOMBZAzVSxLji/2VrJhapNWIjQR
 47/RU2Fk13xt3/1ByjchaNbrmNdZdnW/CWiY9X6O5A0hFg1REJqJ3H9B95b3eX+XVaua
 NIQy4upbYS3p2wZfc4HYHf3TWCrfkFc19+8fqGJvpyuRjyCrgL491az7BLSzR3th2lyR
 crBQ==
X-Gm-Message-State: AOJu0YyZNx2oGiDep2vhUZhFwwxO9HiZCR6U92mDBekb0Fpy4CYnq2Al
 ftw+6lzLWo6crd8PH4Ew0YdU8/rqF5kYd8H3qr0Dcorm8D8CIzOhGAYNxGclAHwB/NI/ZEUOSvS
 9boNE
X-Gm-Gg: ASbGncvbhSV9ZYSVEocD8K0fJQTQ7TAtqHDEshr2EwFD9eDEvw0n2qYRC7fIr0lgRLI
 sNnNk4PteLipwajpkmJWVpWCvRM/8PqXxe41nhibrY/fSdjB5FCVLxdA25LLhTTK1231be0ilpA
 ty3hwKSocNrO0PSywPbCerIZQY3Lp0mqs6bCSYcm7/MbYGeW2EJ67/W+U/JKhHyh3Ns9cAZEgkG
 g+Ubxb2u1LAwK9s/A+EpXMrj24Sq3jem5uW6CNuKSPih+QbbQLEdnILlyaaK/YCPl9NiwLvqNJy
 auSM+IC8bnvlit8bx36BHe1rLmr/stX84RzGEwcjQcHnMHT9UcMZ4eE5Bm7JWvgau1W2YTMkloG
 DLEvQNLN6fepsnCcKOA5vcY68izyJfUpoSfQitTVqVaOjHYHg+8s=
X-Google-Smtp-Source: AGHT+IGaODIBS5qMHW3YkL1JLnbf13eX0YHX1FYwYBywZF0XZOSsQ7SeVheiU9Yis5HNjbaMwqXD2w==
X-Received: by 2002:a5d:64c5:0:b0:3d2:9cbf:5b73 with SMTP id
 ffacd0b85a97d-42666ab9929mr5781240f8f.6.1760101556371; 
 Fri, 10 Oct 2025 06:05:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce583316sm4221657f8f.20.2025.10.10.06.05.55
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Oct 2025 06:05:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/76] target/arm: Remove unused env argument from
 regime_is_user
Date: Fri, 10 Oct 2025 14:04:34 +0100
Message-ID: <20251010130527.3921602-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251010130527.3921602-1-peter.maydell@linaro.org>
References: <20251010130527.3921602-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42e.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20251008215613.300150-24-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h |  2 +-
 target/arm/helper.c    |  2 +-
 target/arm/ptw.c       | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 819ada7a5dd..d0d976cbb08 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1032,7 +1032,7 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_user(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_E10_0:
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a55161ef40e..aed245fd868 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9450,7 +9450,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ds = extract64(tcr, 59, 1);
 
         if (e0pd && cpu_isar_feature(aa64_e0pd, cpu) &&
-            regime_is_user(env, mmu_idx)) {
+            regime_is_user(mmu_idx)) {
             epd = true;
         }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 1080b6d69d4..d6d4bf3b23b 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1000,7 +1000,7 @@ static int ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx,
                          int ap, int domain_prot)
 {
    return ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot,
-                                regime_is_user(env, mmu_idx));
+                                regime_is_user(mmu_idx));
 }
 
 /*
@@ -1026,7 +1026,7 @@ static int simple_ap_to_rw_prot_is_user(int ap, bool is_user)
 
 static int simple_ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx, int ap)
 {
-    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(env, mmu_idx));
+    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(mmu_idx));
 }
 
 static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
@@ -1412,7 +1412,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
                       ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool have_wxn;
     int wxn = 0;
 
@@ -1574,7 +1574,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
-        perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
+        perm = regime_is_user(mmu_idx) ? u_perm : p_perm;
     }
 
     if (in_pa != out_pa) {
@@ -2421,7 +2421,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     uint32_t mask;
     uint32_t base;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         /* MPU disabled.  */
@@ -2588,7 +2588,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     ARMCPU *cpu = env_archcpu(env);
     int n;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
 
     result->f.phys_addr = address;
@@ -2808,7 +2808,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * memory system to use a subpage.
      */
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     int n;
     int matchregion = -1;
     bool hit = false;
@@ -3689,7 +3689,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         break;
     }
 
-    result->f.attrs.user = regime_is_user(env, mmu_idx);
+    result->f.attrs.user = regime_is_user(mmu_idx);
 
     /*
      * Fast Context Switch Extension. This doesn't exist at all in v8.
-- 
2.43.0


