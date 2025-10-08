Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A40CCD187
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cAw-0004qb-Su; Wed, 08 Oct 2025 17:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cA9-0004K1-Sv
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:37 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9B-0006hT-Ub
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:28 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b631b435d59so185461a12.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960590; x=1760565390; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iq3OAeD6sXFj+ZhBz9kaPvsScw2upOaorX+smCRSY5s=;
 b=fWhiObXJRLZlUg/SHwCrFsNJKFuNqx0D5z4vEpiMOOcVXsRRN0im9B2vlDxiZgiZjW
 /HZGqt3txbfy0i2Swy+wao4pNxYUkjqjt9+CjnxawuYBuASV+/ThiaoDEdrFz64mat6+
 kHJXNBjCdtyArkBgdCR+P96iaHoW1UDq502km2gXM2iBETyHLHUKcQ+y6btP63gAb6im
 ec2yg9K1AKMuRq3+VAUImc/ojutF9eaxfoj/rVm091W0e6rD+JwohW1JR44/ldsoxFZC
 O9UiCEc/WCQG+JH8agAekYchjn1+orXihOMfeHFgmNIO7QAif1OcpK+I3YiKtWD1XU86
 nx4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960590; x=1760565390;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iq3OAeD6sXFj+ZhBz9kaPvsScw2upOaorX+smCRSY5s=;
 b=Wl6ScPR+oJBcODPLz0hA07fYaYXzokp2/bWYu8dfPLjPWWt/HXyhOBdmOkR4f8+JbJ
 cMEG8b1SLZmLEVMHkJzaYjtW7WEGuoVcREfAu/P29Pk+dBuSdYF7rei6yNRI16yCHSe3
 R3neHQZvGTs9K6vQsV+ZD2X6g2nFJUFLsMoDz3fYQTfOU4sSkK7jqCPqESElmMQM/h+9
 h0hfmQw7R+aj+z7jpm1dbcr6dubvB/B/hfPkAn1qB9mIW63CA4Xlaevskibv6+xJMar8
 h7ilZkBEXRpzTJnyU+zif+X2GnfP7+zX7rHlXHlL4HUV0M8xdsI0ZV4ePC3goWvW61UN
 wjFA==
X-Gm-Message-State: AOJu0YyJqFwugk8hva3eMM5rsY2UyAaXIleTWup/HaI6NAjf4zsj0Mpu
 VXb5fGOaNR/hQfcAibAEv3GRdd8q+lGvqeKgwsguVtI6zDke8zi8L/2z1oN26NQ7w5ci+CpFmOc
 Kba+Sv3Y=
X-Gm-Gg: ASbGncvvMhpaqxlnmceyWkunhlE7H1CIZ0kHY9Cj5XQ4lL3nDFTpdifc490CntDTfLI
 gACFxEDB6oU6vu2ZuFl9qscOlTyRE3OR7Um/XENj2mxW2Yfo4JmaeOlNiZTq6QtoMNzVsrDd9cF
 RCu6Emh1SRuHjkL6DthpaCMMI/2VR1i7r5392CEemSCuzomEzSyJdlvA1BWqYBiZ4AmR5uzoR+G
 PQO6yaIQuRJN+AUPpMiyqfRWpwppoq51oNB8gqjaYRybu9LJNF21+cmJNK09lmnBV83ZWBTi6Ja
 kAzBpuJbRdunysef9B4UVgnJmcFbEYZ7z25sGfElBym5wfLjPkolv9SoUXP98DzRR/1QAX7RkMf
 1bhQgOlRop5gvkte6YPoW85A2PJecxj/5Kw/33ahE2d6DLlyCQfJKCt4CluaqV1Mct9U=
X-Google-Smtp-Source: AGHT+IHiWq7ojIoncac74qyk3rJbfyFXSIajI4PZhcy/fJGiHEVqC7FhuHLuzEXYI+t8kHHFY8Y8Lw==
X-Received: by 2002:a17:902:f641:b0:27e:edd9:576e with SMTP id
 d9443c01a7336-290273ef199mr57700945ad.30.1759960589722; 
 Wed, 08 Oct 2025 14:56:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:29 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 23/73] target/arm: Remove unused env argument from
 regime_is_user
Date: Wed,  8 Oct 2025 14:55:23 -0700
Message-ID: <20251008215613.300150-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  2 +-
 target/arm/helper.c    |  2 +-
 target/arm/ptw.c       | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 819ada7a5d..d0d976cbb0 100644
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
index a55161ef40..aed245fd86 100644
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
index 1080b6d69d..d6d4bf3b23 100644
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


