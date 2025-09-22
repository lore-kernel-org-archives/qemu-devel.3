Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED5B7CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lcD-00057k-8v; Mon, 22 Sep 2025 14:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lc1-0004yZ-CK
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:10 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbt-0004DO-Eu
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:09 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-77f3405c38aso1263865b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566999; x=1759171799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KAb6+Aq27R5lfF6i22+yMOePpYluMFIXVFkejY5YFmQ=;
 b=K+xcvytt/v/pB3ZjTCpUCYX8FUjhKbeLN/801RXn/qlcwsTe0TVcaWdmKn+I9JyLR0
 kyzmb+/VrePCaaUGCbZEFjNJ/h4TdfNHNpEQUrYJBOVG3l975YZ6nTTy4jsxQVEcQBpK
 rXmSWg9LjWvjlyqKz9fYUzNnMbDxVnN2u0pH3TGAjiRSNzkaoFW2MzuHNZtmgci/h8lS
 vNOwPHvYIsTORjVX/GcNaBs0ehsD4q2vlBAsGoESS38oBft2Dygs2sagyguCDtiXksHD
 lnR0rXLPIa0ry63p5n4BxoZsYoqgEpE+EV38dx+xvcMus1dg5XajmGntFav7Yw/FR1KJ
 Msow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566999; x=1759171799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KAb6+Aq27R5lfF6i22+yMOePpYluMFIXVFkejY5YFmQ=;
 b=l0cZ6QZucUuPFUymWNUakDGdB9YvTvEmyPcdYz/8Bwa3xaLOtgpq+78DPbetVTIHCK
 cpm6dhUjM2H6rOc9fjhx7SGdQ9Y2Jh0JX2yzxES73A5nRyaz5zbbB/WbKp23S+0s1kCu
 izpBCK46XcEX9LU1MAdo86tlxDXs0E1YISS/Kg50BymTOsWRl3RjMHj9owsG5VfnrRdJ
 tCORY02GnjoIHjuhIL6DhrZYCweON1yR1XcJA9bCRZZxRc2LGaC9G61OjwTpZvjMlj5h
 v7tLW7tsW7VGt2HKn3KMScxksAR3Fdy84+8H1Zub2XDimvG8RAOjEdjaybZ4IgxJ25x/
 iyKQ==
X-Gm-Message-State: AOJu0YzIGLm3l2ENaEB5JYpuJVh0zo3FOUvBxRWQVAG1ttEbICsSkOHs
 35LBVg0+OiUgY8nGUw4ToWfCtNz909aN8ZPUQrwwZVxo4iDzbIlFPQCxYlETe3PPyVL1ZzfeSkZ
 3ScUc
X-Gm-Gg: ASbGncvkQaeSjUo2jC2wgIrvC8KxrcnQgm0yEk1OThtnhSUpgsOR5+PG9y+nCRmYBgL
 LVtOUuVhzbZrVSZptPkLjp0ZI2L0ySMQ/fYn4XMldycq/eLjq3FinspHLM8fpNwMcJt6a2iJV3S
 AXR5V0VrDMA+I6bYW3WkoFgiVOf49Mvim6YvvVejlo5us3HQ46oYayHs2Ol9XtLCj3D/LoRmZme
 ZxNb592r4PW4mEyBxvldAHdK32ctYByK0F3hsHvUxLYfuKfn9hh/wD3cjGsPNBqFIzY0CIIQ8ci
 5sRtioKkfvUC2Qx79JlH3j2QFvRnkNYAg8JzXpv43da4P5v5rrz1ffvr8VGHdHE5jZ2bl4qVUs7
 BxKxfqs8xVLh17+zMJFMkppV8kb4N
X-Google-Smtp-Source: AGHT+IHpJHbqUdgQDdsEHYZFOdXkyIpiKSDebNTtcNRNzsU4VJVecd0cHhW/l49fX8k7ZvV9el8vZg==
X-Received: by 2002:a05:6a00:4fc9:b0:772:4319:e7df with SMTP id
 d2e1a72fcca58-77e4f9b4bb7mr14653248b3a.30.1758566999571; 
 Mon, 22 Sep 2025 11:49:59 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 26/76] target/arm: Remove unused env argument from
 regime_is_user
Date: Mon, 22 Sep 2025 11:48:34 -0700
Message-ID: <20250922184924.2754205-27-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h |  2 +-
 target/arm/helper.c    |  2 +-
 target/arm/ptw.c       | 16 ++++++++--------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b180499ecf..ad5584eb0b 100644
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
index 83a675cc22..c0e808a9e8 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9436,7 +9436,7 @@ ARMVAParameters aa64_va_parameters(CPUARMState *env, uint64_t va,
         ds = extract64(tcr, 59, 1);
 
         if (e0pd && cpu_isar_feature(aa64_e0pd, cpu) &&
-            regime_is_user(env, mmu_idx)) {
+            regime_is_user(mmu_idx)) {
             epd = true;
         }
 
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index db51e55cd2..b72c1fc348 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -964,7 +964,7 @@ static int ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx,
                          int ap, int domain_prot)
 {
    return ap_to_rw_prot_is_user(env, mmu_idx, ap, domain_prot,
-                                regime_is_user(env, mmu_idx));
+                                regime_is_user(mmu_idx));
 }
 
 /*
@@ -990,7 +990,7 @@ static int simple_ap_to_rw_prot_is_user(int ap, bool is_user)
 
 static int simple_ap_to_rw_prot(CPUARMState *env, ARMMMUIdx mmu_idx, int ap)
 {
-    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(env, mmu_idx));
+    return simple_ap_to_rw_prot_is_user(ap, regime_is_user(mmu_idx));
 }
 
 static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
@@ -1376,7 +1376,7 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
                       ARMSecuritySpace in_pa, ARMSecuritySpace out_pa)
 {
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool have_wxn;
     int wxn = 0;
 
@@ -1538,7 +1538,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
         if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
-        perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
+        perm = regime_is_user(mmu_idx) ? u_perm : p_perm;
     }
 
     if (in_pa != out_pa) {
@@ -2389,7 +2389,7 @@ static bool get_phys_addr_pmsav5(CPUARMState *env,
     uint32_t mask;
     uint32_t base;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
         /* MPU disabled.  */
@@ -2556,7 +2556,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
     ARMCPU *cpu = env_archcpu(env);
     int n;
     ARMMMUIdx mmu_idx = ptw->in_mmu_idx;
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     bool secure = arm_space_is_secure(ptw->in_space);
 
     result->f.phys_addr = address;
@@ -2776,7 +2776,7 @@ bool pmsav8_mpu_lookup(CPUARMState *env, uint32_t address,
      * memory system to use a subpage.
      */
     ARMCPU *cpu = env_archcpu(env);
-    bool is_user = regime_is_user(env, mmu_idx);
+    bool is_user = regime_is_user(mmu_idx);
     int n;
     int matchregion = -1;
     bool hit = false;
@@ -3656,7 +3656,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         break;
     }
 
-    result->f.attrs.user = regime_is_user(env, mmu_idx);
+    result->f.attrs.user = regime_is_user(mmu_idx);
 
     /*
      * Fast Context Switch Extension. This doesn't exist at all in v8.
-- 
2.43.0


