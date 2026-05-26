Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0787CD5BC8
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmd-0000cG-Om; Tue, 26 May 2026 10:29:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmU-0008T6-Gs
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:20 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmR-0001JG-Rd
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:29:17 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso9069865f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805754; x=1780410554; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=cUCTR/Tsp12ZlbyQAljlDsV5vOZPXSGWqMvCJY1Cuxo=;
 b=JyGXLCRcPt9skVzRyllfVjRFxEHKSzC1Pp9TwMC+ygg8gZGxJJVkaa3CP24dp6q2Zn
 SAWrBJoBFHc+3+IYuSJXcxlotFPLMSgQak4W6YOTCR0Bf9SW1Giz8MeIny21WHWJilah
 dm6Rfpp5t2UfNA5z3tXqkkJKhMYSjEyA9Z6JgTf2YG6pTP4Vul9J3wc3x5GuenWSWONB
 pAFw3oWhDWzfId6+gRrr5iwQ2STV4FzYVNlb8sX/Bhmi/vUseZTNhFa4AbGbd4uAjvYD
 LieyCmsHAKGQhQAsN1dgzcb7KF75jS6Ex9jdp8WIBiS1qAU7pH+OtZXLZJzr5uMl/+F3
 peLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805754; x=1780410554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cUCTR/Tsp12ZlbyQAljlDsV5vOZPXSGWqMvCJY1Cuxo=;
 b=TqJ138/G+KwcJoS8qyNDKOgp/A0u4qYl4M+5qd3pPabQS4YrIRV+CHbbqexgLVj+zB
 BFy4a0kfYLQiIZHGEoxMLt8X7ZsQcaQ5NTqhwa8asiVccI2gwN0DchmD5jUfyXwcdsuu
 z6PlClQOUSgz54HBZ0sxegYLxQFhoeOSGwrgrcFgxL15hOyKnfmn5x6jGdLWCc/9eE9l
 dFxO18WbPdAhGUjMwylRVbxHny3QeHMm3w6mhI6f+jGo+bMCDUecTmCfE3LdYPggPY3C
 k1H/JYjBIsOhYwRUPAX9f3XfE1/haxzr0TkVmGaths1tJo3ZVKTEHIxfsnoLlWLLOrI/
 FXkw==
X-Gm-Message-State: AOJu0YyanXv+ZeYEqjIEmeWRhpqN1Hznq0kFRENXnaK3Di8RcHraREHz
 9rlV2BiUKIRYJJpUDhXbaS2aEAzWX1nizixhYp5RrZi05PHxWhMp/OGOeCqHIurOFM0TB5rmZS2
 JPrYQ
X-Gm-Gg: Acq92OHp2t+p62jUG2AcMHwiv0e3wjdAFUxFvbTImp7jhU6qggJ2iqxw6TNinCaiZa+
 iSWo0CmVFAULW7Pxrl9cUfS4yLMxFvMqkNvEfIYsLa6+Us0wyfU/PIY7vvah/8olL/9u/VOxjDH
 vcrG/gG9lPZZSUgr0G5UQKfyVDZRhmWOhtmf5Nl432WgrGs7wzX6kPhr0+OEnTfgpxrFBNbY4lS
 mNZLGP1Bf1KZdjeTd9K8WZQNSNLEP3lj3I4uhj+0culuDOngSqX5tIU+mw8m7+9khHAgr0OBJ0S
 PSwlYmCrq8S1NB6zw7dZTdmjK/zFxHymvv2ABpo2usNGbDKgEaTBlYKy9RZeGwIGVt/XpP87zcy
 voLHGPx/y8MObC/8DeKHP8U1fVY/zEr9Rxlw8fWM9GQHhFaSQ5Kd7/kmvXTZyajP5IQu75Cg0pp
 qXW+B8shHHah6CQ/utTJ5Sl7rS8Vgtdn6cxJ/mHCQQ6M5yoETX0hzKsr85d6X+RYBQwdQjE+lJk
 ZErP9XMEDUOKgvdaFgssXCPcqbEfQA=
X-Received: by 2002:a05:6000:480e:b0:45e:a314:ce0c with SMTP id
 ffacd0b85a97d-45eb369cf74mr28083254f8f.1.1779805754171; 
 Tue, 26 May 2026 07:29:14 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.29.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:29:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/54] target/arm/ptw: Flip sense of get_phys_addr_nogpc return
 value
Date: Tue, 26 May 2026 15:28:19 +0100
Message-ID: <20260526142850.2326589-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260515142541.571911-11-peter.maydell@linaro.org
---
 target/arm/ptw.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index fec24f08fd..4538ffeb10 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -3570,8 +3570,8 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
                               memop, result, fi);
 
     /* If S1 fails, return early.  */
-    if (ret) {
-        return !ret;
+    if (!ret) {
+        return ret;
     }
 
     ipa = result->f.phys_addr;
@@ -3601,8 +3601,8 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
     result->f.prot = s1_prot & result->s2prot;
 
     /* If S2 fails, return early.  */
-    if (ret) {
-        return !ret;
+    if (!ret) {
+        return ret;
     }
 
     /*
@@ -3683,7 +3683,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     case ARMMMUIdx_Phys_Root:
     case ARMMMUIdx_Phys_Realm:
         /* Checking Phys early avoids special casing later vs regime_el. */
-        return !get_phys_addr_disabled(env, ptw, address, access_type,
+        return get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
 
     case ARMMMUIdx_Stage1_E0:
@@ -3724,7 +3724,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
         ptw->in_mmu_idx = mmu_idx = s1_mmu_idx;
         if (arm_feature(env, ARM_FEATURE_EL2) &&
             !regime_translation_disabled(env, ARMMMUIdx_Stage2, ptw->in_space)) {
-            return !get_phys_addr_twostage(env, ptw, address, access_type,
+            return get_phys_addr_twostage(env, ptw, address, access_type,
                                           memop, result, fi);
         }
         /* fall through */
@@ -3756,15 +3756,15 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
 
         if (arm_feature(env, ARM_FEATURE_V8)) {
             /* PMSAv8 */
-            ret = !get_phys_addr_pmsav8(env, ptw, address, access_type,
+            ret = get_phys_addr_pmsav8(env, ptw, address, access_type,
                                        result, fi);
         } else if (arm_feature(env, ARM_FEATURE_V7)) {
             /* PMSAv7 */
-            ret = !get_phys_addr_pmsav7(env, ptw, address, access_type,
+            ret = get_phys_addr_pmsav7(env, ptw, address, access_type,
                                        result, fi);
         } else {
             /* Pre-v7 MPU */
-            ret = !get_phys_addr_pmsav5(env, ptw, address, access_type,
+            ret = get_phys_addr_pmsav5(env, ptw, address, access_type,
                                        result, fi);
         }
         qemu_log_mask(CPU_LOG_MMU, "PMSA MPU lookup for %s at 0x%08" PRIx32
@@ -3772,7 +3772,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
                       access_type == MMU_DATA_LOAD ? "reading" :
                       (access_type == MMU_DATA_STORE ? "writing" : "execute"),
                       (uint32_t)address, mmu_idx,
-                      ret ? "Miss" : "Hit",
+                      ret ? "Hit" : "Miss",
                       result->f.prot & PAGE_READ ? 'r' : '-',
                       result->f.prot & PAGE_WRITE ? 'w' : '-',
                       result->f.prot & PAGE_EXEC ? 'x' : '-');
@@ -3783,18 +3783,18 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
     /* Definitely a real MMU, not an MPU */
 
     if (regime_translation_disabled(env, mmu_idx, ptw->in_space)) {
-        return !get_phys_addr_disabled(env, ptw, address, access_type,
+        return get_phys_addr_disabled(env, ptw, address, access_type,
                                       result, fi);
     }
 
     if (regime_using_lpae_format(env, mmu_idx)) {
-        return !get_phys_addr_lpae(env, ptw, address, access_type,
+        return get_phys_addr_lpae(env, ptw, address, access_type,
                                   memop, result, fi);
     } else if (arm_feature(env, ARM_FEATURE_V7) ||
                regime_sctlr(env, mmu_idx) & SCTLR_XP) {
-        return !get_phys_addr_v6(env, ptw, address, access_type, result, fi);
+        return get_phys_addr_v6(env, ptw, address, access_type, result, fi);
     } else {
-        return !get_phys_addr_v5(env, ptw, address, access_type, result, fi);
+        return get_phys_addr_v5(env, ptw, address, access_type, result, fi);
     }
 }
 
@@ -3804,7 +3804,7 @@ static bool get_phys_addr_gpc(CPUARMState *env, S1Translate *ptw,
                               GetPhysAddrResult *result,
                               ARMMMUFaultInfo *fi)
 {
-    if (get_phys_addr_nogpc(env, ptw, address, access_type,
+    if (!get_phys_addr_nogpc(env, ptw, address, access_type,
                             memop, result, fi)) {
         return true;
     }
@@ -3851,7 +3851,7 @@ bool get_phys_addr_for_at(CPUARMState *env, vaddr address,
      * check is handled or bypassed by .in_prot_check) and "memop = MO_8"
      * bypasses any alignment check.
      */
-    return get_phys_addr_nogpc(env, &ptw, address,
+    return !get_phys_addr_nogpc(env, &ptw, address,
                                MMU_DATA_LOAD, MO_8, result, fi);
 }
 
-- 
2.43.0


