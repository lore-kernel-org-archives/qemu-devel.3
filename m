Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80AE9CAC5B0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 00:13:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1w4A-0002IE-FU; Thu, 25 Sep 2025 20:12:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w49-0002H5-4W
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:12:01 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v1w3t-0005EA-IV
 for qemu-devel@nongnu.org; Thu, 25 Sep 2025 20:11:59 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-77f169d8153so1733376b3a.3
 for <qemu-devel@nongnu.org>; Thu, 25 Sep 2025 17:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758845498; x=1759450298; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eYnftHW1Ls4w3e04vsyEzSpq9klvXAp2CYI/RMc0+3o=;
 b=iQ+9XslVBDuNheoEYTDfDyAlIPa9wNDzV2hCQUbK7VKPr8/UuT1LTYk1HMDO2DuHOf
 /e2KtCmyAA1zdMDr8bM9MhJWUw4g6yNLTZrSAfOxu7aGHchsp9xAHuxH+TbRY5+1kKcw
 O5rUXyjdA1DitcLy+023rwSX1cvdLWdIMrl3ECd9rNP+Ym65TEbvb2uX3MmWypr1xeEA
 8C+4Qtt8OxHgIOzYK+kfe6wSk6fEXOHq6hVCuV/Q6N3Hz7wvGgjZE0IfJjjVbplcGdHO
 LoX7rbZubF3lEA7NbX7Xu8VLE4eJeg7wyaKohUt+/zQjOs2rssJa1q4IdvEjAO1JAztm
 4ePg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758845498; x=1759450298;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eYnftHW1Ls4w3e04vsyEzSpq9klvXAp2CYI/RMc0+3o=;
 b=XfbFAgzIdpkwECvKomillXYx/7c7XLg3ORzmcO2coJ0U5Vph3521tZW22dvEmeKSsN
 AyoRoC5WEzFMB65WbgvgWkJ/hIVo2Ig5EK/q4GXJmf4SV1UhwSGeEMMLHdj2jtrBjABS
 WecYCE4112F9AhsgvkITgTgUdaFyEeeo9P8AQsTqnD2ApIKBorF2KEI5SIgPE45wo4IM
 wCEgiV+maviH5XEpoJhDElV8dJYR4h7Bhk3hkYQwesJHXvyQ2cP7A5CLo7ScIk83+cdH
 gWcEf6ZqSuDYB4jQ/vlGIL7sDIgxxh28USJy8dJ4XrOXGJQQ4/Gge1Nn6D/RrqMfQyvi
 1qyw==
X-Gm-Message-State: AOJu0YzBxxHB5YAamzh96Y8UUdPalh3SgZQfUE2R/s93ln/IL5mGnjBO
 YHf3KiWj2z63f62G6Cm8SQZScOzNx/LrVqj5PZck8rNkLf3ed6DihalPYdsmcR382BAIHWtA4y3
 5qVMX
X-Gm-Gg: ASbGncuugs3urUAWRudNZSCCvi6L5Ivo1hGwco168CILQeIttEEFryNVQ0IA5AA7sV4
 E4CaG70B1sW6qK41rJ29FFekqtBcyfEfY4zvKsOfcu7y2Q2u3dh7iZh/wLO0ytCaQMo8UZNJgK0
 sqtqZpBtEFgrp/OorObLl/rqaJZRAdwR42WcqxfGSbecFHJQBH//56H/WyIFFYek8nt0WCy4I5U
 fCOLXi0eEUaF+guikK+OgzYCLafVUdHBZ20Ze3yl+YhHXmlPH/0g3rfzZctEwIgJdKv6Nxy4vB2
 uG1tC2hJPwYFikIOZ79ltDV/I4N9OOfndIG9kRTM5aAK6j1AohH9kk4WVVzDjGMVz/3b2oX54xj
 K7nhtlVfTamSooIdgZdoDi85C8gsY
X-Google-Smtp-Source: AGHT+IFiQNvVqZN5bODojKemhRXAqXBpbHIhTR+XD/3j+as/g9di5GTd0zV7xwRR0s7QG/JhLyxh8g==
X-Received: by 2002:a17:902:da47:b0:250:643e:c947 with SMTP id
 d9443c01a7336-27ed4a91a3emr51408355ad.28.1758845498532; 
 Thu, 25 Sep 2025 17:11:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27ed6ac37efsm35829425ad.137.2025.09.25.17.11.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Sep 2025 17:11:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 04/10] target/arm: Add cur_space to S1Translate
Date: Thu, 25 Sep 2025 17:11:28 -0700
Message-ID: <20250926001134.295547-5-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250926001134.295547-1-richard.henderson@linaro.org>
References: <20250926001134.295547-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

We've been updating in_space and then using hacks to access
the original space.  Instead, update cur_space and leave
in_space unchanged.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6344971fa6..1cafe8f4f7 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -36,8 +36,6 @@ typedef struct S1Translate {
     /*
      * in_space: the security space for this walk. This plus
      * the in_mmu_idx specify the architectural translation regime.
-     * If a Secure ptw is "downgraded" to NonSecure by an NSTable bit,
-     * this field is updated accordingly.
      *
      * Note that the security space for the in_ptw_idx may be different
      * from that for the in_mmu_idx. We do not need to explicitly track
@@ -52,6 +50,11 @@ typedef struct S1Translate {
      *    value being Stage2 vs Stage2_S distinguishes those.
      */
     ARMSecuritySpace in_space;
+    /*
+     * Like in_space, except this may be "downgraded" to NonSecure
+     * by an NSTable bit.
+     */
+    ARMSecuritySpace cur_space;
     /*
      * in_debug: is this a QEMU debug access (gdbstub, etc)? Debug
      * accesses will not update the guest page table access flags
@@ -587,7 +590,8 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
          * From gdbstub, do not use softmmu so that we don't modify the
          * state of the cpu at all, including softmmu tlb contents.
          */
-        ARMSecuritySpace s2_space = S2_security_space(ptw->in_space, s2_mmu_idx);
+        ARMSecuritySpace s2_space
+            = S2_security_space(ptw->cur_space, s2_mmu_idx);
         S1Translate s2ptw = {
             .in_mmu_idx = s2_mmu_idx,
             .in_ptw_idx = ptw_idx_for_stage_2(env, s2_mmu_idx),
@@ -630,7 +634,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
     }
 
     if (regime_is_stage2(s2_mmu_idx)) {
-        uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
+        uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->cur_space);
 
         if ((hcr & HCR_PTW) && S2_attrs_are_device(hcr, pte_attrs)) {
             /*
@@ -641,7 +645,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
             fi->s2addr = addr;
             fi->stage2 = true;
             fi->s1ptw = true;
-            fi->s1ns = fault_s1ns(ptw->in_space, s2_mmu_idx);
+            fi->s1ns = fault_s1ns(ptw->cur_space, s2_mmu_idx);
             return false;
         }
     }
@@ -657,7 +661,7 @@ static bool S1_ptw_translate(CPUARMState *env, S1Translate *ptw,
     fi->s2addr = addr;
     fi->stage2 = regime_is_stage2(s2_mmu_idx);
     fi->s1ptw = fi->stage2;
-    fi->s1ns = fault_s1ns(ptw->in_space, s2_mmu_idx);
+    fi->s1ns = fault_s1ns(ptw->cur_space, s2_mmu_idx);
     return false;
 }
 
@@ -844,7 +848,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
             fi->s2addr = ptw->out_virt;
             fi->stage2 = true;
             fi->s1ptw = true;
-            fi->s1ns = fault_s1ns(ptw->in_space, ptw->in_ptw_idx);
+            fi->s1ns = fault_s1ns(ptw->cur_space, ptw->in_ptw_idx);
             return 0;
         }
 
@@ -1224,7 +1228,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
             g_assert_not_reached();
         }
     }
-    out_space = ptw->in_space;
+    out_space = ptw->cur_space;
     if (ns) {
         /*
          * The NS bit will (as required by the architecture) have no effect if
@@ -1254,7 +1258,7 @@ static bool get_phys_addr_v6(CPUARMState *env, S1Translate *ptw,
         }
 
         result->f.prot = get_S1prot(env, mmu_idx, false, user_rw, prot_rw,
-                                    xn, pxn, result->f.attrs.space, out_space);
+                                    xn, pxn, ptw->in_space, out_space);
         if (ptw->in_prot_check & ~result->f.prot) {
             /* Access permission fault.  */
             fi->type = ARMFault_Permission;
@@ -1857,7 +1861,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
      * NonSecure.  With RME, the EL3 translation regime does not change
      * from Root to NonSecure.
      */
-    if (ptw->in_space == ARMSS_Secure
+    if (ptw->cur_space == ARMSS_Secure
         && !regime_is_stage2(mmu_idx)
         && extract32(tableattrs, 4, 1)) {
         /*
@@ -1867,7 +1871,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Phys_S + 1 != ARMMMUIdx_Phys_NS);
         QEMU_BUILD_BUG_ON(ARMMMUIdx_Stage2_S + 1 != ARMMMUIdx_Stage2);
         ptw->in_ptw_idx += 1;
-        ptw->in_space = ARMSS_NonSecure;
+        ptw->cur_space = ARMSS_NonSecure;
     }
 
     if (!S1_ptw_translate(env, ptw, descaddr, fi)) {
@@ -1991,7 +1995,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     }
 
     ap = extract32(attrs, 6, 2);
-    out_space = ptw->in_space;
+    out_space = ptw->cur_space;
     if (regime_is_stage2(mmu_idx)) {
         /*
          * R_GYNXY: For stage2 in Realm security state, bit 55 is NS.
@@ -2089,12 +2093,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
 
         user_rw = simple_ap_to_rw_prot_is_user(ap, true);
         prot_rw = simple_ap_to_rw_prot_is_user(ap, false);
-        /*
-         * Note that we modified ptw->in_space earlier for NSTable, but
-         * result->f.attrs retains a copy of the original security space.
-         */
         result->f.prot = get_S1prot(env, mmu_idx, aarch64, user_rw, prot_rw,
-                                    xn, pxn, result->f.attrs.space, out_space);
+                                    xn, pxn, ptw->in_space, out_space);
 
         /* Index into MAIR registers for cache attributes */
         attrindx = extract32(attrs, 2, 3);
@@ -2192,7 +2192,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         fi->level = level;
         fi->stage2 = regime_is_stage2(mmu_idx);
     }
-    fi->s1ns = fault_s1ns(ptw->in_space, mmu_idx);
+    fi->s1ns = fault_s1ns(ptw->cur_space, mmu_idx);
     return true;
 }
 
@@ -3413,6 +3413,7 @@ static bool get_phys_addr_nogpc(CPUARMState *env, S1Translate *ptw,
      * cannot upgrade a NonSecure translation regime's attributes
      * to Secure or Realm.
      */
+    ptw->cur_space = ptw->in_space;
     result->f.attrs.space = ptw->in_space;
     result->f.attrs.secure = arm_space_is_secure(ptw->in_space);
 
-- 
2.43.0


