Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA5DDCA0EE6
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:04:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXK-0001K6-TC; Thu, 14 Aug 2025 08:58:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXH-0001IB-Ic
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:27 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXC-0004Ae-W7
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:58:27 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-323266cdf64so748090a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176297; x=1755781097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tT719Yr1a9uhc93zITJ7bwqOfh29BbRAnDJiR12mnEI=;
 b=wU/UF/LtqXwxLwAAdGA0hYotCBfItlXvX92se0qYn7/6Dg8wZ4sA/mDgul8U8daD1k
 Jrc9aLbD1iCowuAftWRovDeCWU+t82R+kFK8/eqZaIH8N/taJj9uUY1+Mqurx6/QUaE9
 py5hKZjHKOi0HxW34/ROyBIfR4wVQL7zFvVb9LF6RKz5DFTKBtIM5f8nJty5mkeYkoVN
 d+BCp08Nz3LLcNk8mAydbcViT1ZDkZBeq6/X1MrcWhgFh3UFij5ZPQeJ1QJLFiNN0v6H
 iLsZD2ySmHD5BoLhvPf5NSnoAFoTR/8+AN7WQXLtlEqEB/+2UB4cN1EYJLCt07O1sZgg
 aPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176297; x=1755781097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tT719Yr1a9uhc93zITJ7bwqOfh29BbRAnDJiR12mnEI=;
 b=prBSBHOmv3ukEXVwxlOPNtHuW++/trCRWMfjoPxAh7QWS1Lo/cHedKcJoBgCcSZauY
 D553mT5w7jUN4bTpXQnGaHVmxwjS8nuIbCAyUKJUnBlR+gXZeLzI0R5pfIOF3WT6r1wd
 KRig52uursXkhuWrhlQRPXTwP84H091FEs1Q+i19LYuc0fCRQHEwo/3tKTW7EaqIyxJ2
 mFG8eYTYM9z/r4/oWm7AoXs0qBbQ5X5NcCd2XFB3PAMITalNKSg7lbn4VVNhjeogQtG2
 sStkSVZ/iymynSF0MRhHq/IWAK5WOMLBC6iXMBczfI7CYq4lqSU3d+e0DkOQniN7roRl
 ZGxg==
X-Gm-Message-State: AOJu0YwTvWS5DGF5pP8fjaj/0wODk2cwVt6R/cL09NQXgg/2tW6frR2T
 +joVARgZiEIlVxpODH8lEjQ0bguZpiVLLB5J3jL3viYEa6CTkR1sKqi4ju7JfjGW7M/eaaqxHaK
 0MRRVqIY=
X-Gm-Gg: ASbGncuGxw1Ps6fNn3ceKkudzWpPz/YyUaiI1lDpMc03LFrbFXhuKI0AK7kFD14Uj8M
 +J1KnG9OJpjNjufpRteEZ2x72OtOS8uW3hXab2Diu5lGPGhcegSf63kuJwZoFu7KkD0vwcxJYtX
 lFVRUJegJ/lJKDQywRaRA1hAq2LaASJU1B9UP8M6NWN/heWZZrlKx7bJbtJov7Iu7XKTgUw3eaZ
 LsAr7+VZE3ECnrU8dvyjLlQapMzfF8K/evE4JDkHR8iQsHl9zTmzjHe4L1WOKFp74wNIebvYPBh
 rLQmScsHysxf8DIBXgdDsAyEorRF7j2BUGWWWDM2dk0EVNJSF5xB41K66fZpPzS9ucxKJw/aK8+
 0wkjDOiJaEdzTyi8cv20jB6ju3H+9JL+vVCSTCIv5hJRwjEU=
X-Google-Smtp-Source: AGHT+IEEkDVwUeo+0flKhXVYEd0xWuYXNa9nYpOvcpzops/r3tb904L+7jb+0KLEwtrcUz1vXsJBJQ==
X-Received: by 2002:a17:90b:224f:b0:31f:2bd7:a4d2 with SMTP id
 98e67ed59e1d1-32327aa7402mr4464031a91.35.1755176297217; 
 Thu, 14 Aug 2025 05:58:17 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:16 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 05/85] target/arm: Add in_prot_check to S1Translate
Date: Thu, 14 Aug 2025 22:56:32 +1000
Message-ID: <20250814125752.164107-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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

Separate the access_type from the protection check.
Save the trouble of modifying all helper functions
by passing the new data in the control structure.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index a914e7e23c..1b90e33f52 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -64,6 +64,12 @@ typedef struct S1Translate {
      * Stage 2 is indicated by in_mmu_idx set to ARMMMUIdx_Stage2{,_S}.
      */
     bool in_s1_is_el0;
+    /*
+     * The set of PAGE_* bits to be use in the permission check.
+     * This is normally directly related to the access_type, but
+     * may be suppressed for debug or AT insns.
+     */
+    uint8_t in_prot_check;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -581,6 +587,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
             .in_space = s2_space,
             .in_debug = true,
+            .in_prot_check = PAGE_READ,
         };
         GetPhysAddrResult s2 = { };
 
@@ -1089,7 +1096,7 @@ static bool get_phys_addr_v5(CPUARMState *env, S1Translate *ptw,
     }
     result->f.prot = ap_to_rw_prot(env, ptw->in_mmu_idx, ap, domain_prot);
     result->f.prot |= result->f.prot ? PAGE_EXEC : 0;
-    if (!(result->f.prot & (1 << access_type))) {
+    if (ptw->in_prot_check & ~result->f.prot) {
         /* Access permission fault.  */
         fi->type = ARMFault_Permission;
         goto do_fault;
@@ -1243,7 +1250,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
 
         result->f.prot = get_S1prot(env, mmu_idx, false, user_rw, prot_rw,
                                     xn, pxn, result->f.attrs.space, out_space);
-        if (!(result->f.prot & (1 << access_type))) {
+        if (ptw->in_prot_check & ~result->f.prot) {
             /* Access permission fault.  */
             fi->type = ARMFault_Permission;
             goto do_fault;
@@ -2123,7 +2130,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         result->f.tlb_fill_flags = 0;
     }
 
-    if (!(result->f.prot & (1 << access_type))) {
+    if (ptw->in_prot_check & ~result->f.prot) {
         fi->type = ARMFault_Permission;
         goto do_fault;
     }
@@ -2537,7 +2544,7 @@ static bool get_phys_addr_pmsav7(CPUARMState *env,
 
     fi->type = ARMFault_Permission;
     fi->level = 1;
-    return !(result->f.prot & (1 << access_type));
+    return (ptw->in_prot_check & ~result->f.prot) != 0;
 }
 
 static uint32_t *regime_rbar(CPUARMState *env, ARMMMUIdx mmu_idx,
@@ -2953,7 +2960,7 @@ static bool get_phys_addr_pmsav8(CPUARMState *env,
         }
     }
 
-    ret = pmsav8_mpu_lookup(env, address, access_type, 1 << access_type,
+    ret = pmsav8_mpu_lookup(env, address, access_type, ptw->in_prot_check,
                             mmu_idx, secure, result, fi, NULL);
     if (sattrs.subpage) {
         result->f.lg_page_size = 0;
@@ -3625,6 +3632,7 @@ bool get_phys_addr(CPUARMState *env, vaddr address,
     S1Translate ptw = {
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
+        .in_prot_check = 1 << access_type,
     };
 
     return get_phys_addr_gpc(env, &ptw, address, access_type,
@@ -3638,6 +3646,7 @@ static hwaddr arm_cpu_get_phys_page(CPUARMState *env, vaddr addr,
         .in_mmu_idx = mmu_idx,
         .in_space = arm_mmu_idx_to_security_space(env, mmu_idx),
         .in_debug = true,
+        .in_prot_check = PAGE_READ,
     };
     GetPhysAddrResult res = {};
     ARMMMUFaultInfo fi = {};
-- 
2.43.0


