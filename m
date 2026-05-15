Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D0B7CD4F47
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 14:26:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNtUh-0006OR-Og; Fri, 15 May 2026 10:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUH-0005tZ-HW
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:26:02 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wNtUA-0000yu-KS
 for qemu-devel@nongnu.org; Fri, 15 May 2026 10:25:58 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-453903ee4adso7967096f8f.3
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 07:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778855153; x=1779459953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TydCV87eriJQbdUNFILWluMIKkiaW+xceKfCgA5Uw1s=;
 b=MDXKpYexTLeyhmI9cy7nfhH0uYJ0g5p7h1hw9DL7Sz+DO1kBmu1i5VaQ4P61kfS7nm
 muKBKEBzokavr8e7M2GqDLnsW50Nj9V70qYGSLUzRvf8QcbUceeb4u4MILmMG9yRF+9b
 biQFXjyFeG03c9E4kP00kT/uAVRKj0A3HKjcsRdnzRXtljRpaAAM5GGIbeCSqHptB9Zk
 JXYeTlDErPzBlNu0m+4JWEIT/3xY+rR4Z/i223zT9NtyU2Tq0mETEYfMdwyXTaLflbSM
 LU9UPTpqKxQVilITtp6isgNquGT3EESuaMT7ZprmxpnJDxQesUQdIKANcydHDJjuxWEV
 nrMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778855153; x=1779459953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TydCV87eriJQbdUNFILWluMIKkiaW+xceKfCgA5Uw1s=;
 b=K5MSuVqssIZ64kw1Px3wH056jyrvhOi7fAN6tm0B4B2hZDVbB90w1dxU7Umo+HeXrk
 cjeA/WtvIopCxUUQJOwFxNbfBK3C57HiZLQC1XcX05+l6HdYXDK/VP1rYLXaTIRUI37+
 X3VLv9c3UQzQAOYuS/Jut8qhrda/DstFbyd57qgVyfkI8GETgXsvg4c98Eneh8LPic3R
 iSfOCrJmQUdcWctHppsUXSlbEtho8UFEEZzZqREBY9fJMOS7lET2YY5/+MNetHiM245R
 +911lld9xuNneBNYe/vCdNt1mI4+lHrwLnV8cBELfn+EUR0Jzl8O3iysnY1rX/06KF8f
 gzBg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8fqcZj2U1e+upzvr3HoD7DO0Lx5kPxVPJcYuTc/qzNHzubxm01t62mEstl1YugGNbw7UABKEM2TKy+@nongnu.org
X-Gm-Message-State: AOJu0YwDMzXzOKOc7tPz1yL39C3b4NtNuxd6nT8q2zqsCHV/yQG1jLE1
 YYyERXBg+YKgOuNnj0CEDoet8XSkJsyR9xSEIPPbCcGQWZI0PfHzfRFo3X10+5dtliXXdyrCnNL
 4PXwK
X-Gm-Gg: Acq92OFOfSrgb9EHB9y+4xK0FhvAkD+kBidRGn/UOMRGccFCCN2WEci5idZaE6mdUTY
 XIBF0jNXH7l+3ZVFjbHQAcQzf2rAOZvdz5WQGikPMWqZI7uMWgdb4zyZRFYh2Jej+xDoSrSfGnh
 Ebj6yxUH9cJng6HqRQiladlz+WUtF+yeeVFAcyguqQsl5IGc8o2P9Rfw+afbh3cog5c2uY7Yf5x
 Mpf9v8berd6hiob/QBy6n9nprbJ3t1cHtqQYvjF5LDxZyNB2/u/+aDStyuiNHyy4zvPu0jAXmOA
 G5NSZYf4/+WWFOgSwo+mg5tyS6qMV4zb9FVQXiwmWNXHX95t9asnwWrQP8TkWMMZkvk00Xs5gtV
 qarCvS2XM768mjYTCSa5Ckw5QVEbbph/rpDyHpefBvoXsQP6sMaw/vFdZ56cGFfk8ng7+vNZ2jh
 2FrJf7TE3+ByOQTELF58HGscreunRFaDXwh5rSYhk/0zX9uPuYaqG2eCB9Y/AaDGv0eoUJMeN1G
 pOcTnyUoEIs/Mazrb5wd4dvIVQa7h8=
X-Received: by 2002:a05:6000:2485:b0:44f:da08:18f2 with SMTP id
 ffacd0b85a97d-45e5c3673d9mr5972601f8f.12.1778855153093; 
 Fri, 15 May 2026 07:25:53 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a666fsm13560603f8f.36.2026.05.15.07.25.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 May 2026 07:25:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC PATCH 10/14] target/arm/ptw: Flip sense of get_phys_addr_nogpc
 return value
Date: Fri, 15 May 2026 15:25:37 +0100
Message-ID: <20260515142541.571911-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260515142541.571911-1-peter.maydell@linaro.org>
References: <20260515142541.571911-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42b.google.com
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
---
 target/arm/ptw.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 545138464d..9ecb6238a7 100644
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


