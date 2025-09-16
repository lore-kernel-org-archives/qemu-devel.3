Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C0A3CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya4S-00032v-Dz; Tue, 16 Sep 2025 14:06:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4N-0002kf-LV
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:23 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4L-0001ZN-PM
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:23 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-46130fc5326so1142965e9.2
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758045980; x=1758650780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3Ya4qtmitYtTQF+CaFE3GTL8y89kFASJ5OIdJ+/zP9s=;
 b=VqRIAxFnIY4uNMaOHmPLK0d32b/KtfsRrgEdSQkY2sC7gO5GrIQqPEyxLW2j3FnDCI
 9G42e3unfNYGK12OO4T3q2gxCBlrP/PucvYEPNuYpspWcjoFAUHKOAB/BAsLMvp3Bw9X
 DyTiyD1/dFtk3ED2LpVU8iPjrQ0oSPTbRae6XMwr9LODu54tQEMR/ieZ7u0Vov56zNgB
 ZKs/HZRarWVKYE220vl0Ud+Wx+SLGB6jm2Q3pSEe7lkv8mTMXNxCzom/IonJSBEqNRG0
 ThLYH4TPtV1y51HpZ4vh3yMX/runED1KHqkxrgpmPV6P0aV7+uDexXvxnWlFdDm0gxXC
 Yfww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758045980; x=1758650780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Ya4qtmitYtTQF+CaFE3GTL8y89kFASJ5OIdJ+/zP9s=;
 b=M8mhjWH9H71GUcRj4u971awM47kPANZgoh6HIw6+u0VuERQZnCQtiFbqZMKOkdR04p
 6+APP5wHpCnXRpUsDqIPijpLlpVNKUY1cLrFXfD6lhMmfOfA36jRq9HKEhNQ4ifbzg53
 Jf43qAvMBKPbg+R/M7OFIEm8fLs0B1ClzXUSMVpuNfIFidtlt6cdFHxhhu0pCPkxnHtl
 d6nO8433tV/Q6dbKErpD2nxruNn/ebstKUHaFU+8VQlDpj5dExDOeDm2h6HnnzjDJjwx
 cfTMSI0fA49zha059eEND0mQLr4BOrLjbx0uRp4xXOuwzgWcqHDzRQTVcRJ4b+fCUqpI
 IV8g==
X-Gm-Message-State: AOJu0YyVtlbgMEVYfH7+569Wu+Bo+3vVUOG7LV5G5cIQ47fbbp0pIqEs
 Woe2i9Jls7Px1cdnX5PXAQQn53bZzzBrGGOgD6BMJe08jFXiWhD/tr6Qx3AKH131IpxjjcRV0UT
 J+/G8
X-Gm-Gg: ASbGncuCIa22shdb85nyFMXLDIdSxkqixcHg/bEqkuKE4McMBeCi2JIAfNKLQuG017R
 ToTXG6MjzkS+B7W9vKkL/ulBd7plhpmoQWtNtIliRclzwBLeNIexrXQDTsW8RloPviu3VNWLnls
 zzHv2/6cs24V/suHVFYuuZ++QoES3Y4pUeIG0Y7xOFvydpSlgh4mrcgR7fo4rHQhsODESXlVLMK
 OrJpuNHmUGZNY0C6IxZ8ZSO+GFujtI+n8Ns/PVenPghDUzAQBC1wI+nyvJiEDDl5q6nccWBQVrY
 Or/9JSoEaZOxvtNnG1/O+o9wLs/8iXePVvH+GIKcEacjlIKs1RTwmeGQTAkelGIApKqcIgwOvYE
 TYbKhJHiw3BfzuxOG3e+2s1KhLodi
X-Google-Smtp-Source: AGHT+IFgfEB+W0wx/tZr0egfbOStdrf3QUB9y8axOLb/lBoff6XvgbotGMWJMsgLZ9c5XoRIyPk5Fg==
X-Received: by 2002:a05:600c:6b06:b0:43c:ec4c:25b4 with SMTP id
 5b1f17b1804b1-45f211d0795mr153118475e9.10.1758045979918; 
 Tue, 16 Sep 2025 11:06:19 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/36] target/arm: Add in_prot_check to S1Translate
Date: Tue, 16 Sep 2025 19:05:40 +0100
Message-ID: <20250916180611.1481266-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Separate the access_type from the protection check.
Save the trouble of modifying all helper functions
by passing the new data in the control structure.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250830054128.448363-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/ptw.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 9652f40ff82..d37c0ce0f1d 100644
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


