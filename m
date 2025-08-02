Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF76C87FD2
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLhU-0007sC-3V; Sat, 02 Aug 2025 19:31:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgM-0006RY-Hs
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:37 -0400
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLgI-0004qi-GV
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:30:28 -0400
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-306db05b292so945652fac.1
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177425; x=1754782225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tT719Yr1a9uhc93zITJ7bwqOfh29BbRAnDJiR12mnEI=;
 b=CZZMT2Bii3tkQYS/dNdfjUGFzQZUyrJYUO0yLa6Fvy+NqWFrfCO/hJxi+1w/pkVQ7z
 I/9s2kx8dUbcPEUG87xEx3L1GDJIZGi5lX7ZaWEPS968KyBPKKXRiRmMnTUuJzu89q/o
 u6dIhS4ffXF4+/0Xko7EqW5ssXnTjaNTGSQmOODny6oYSnr/TY4IKTIletj1tVJVVj6+
 0Eurf/FNCX3r0orqgNv40HOGCRzStp4iDEnOSx/rdhQVd5SyscaJlv1QThRfw7wgmHRP
 G97ZAK+hkdD1gqOjJ/nZN/cyYozHaIKFbrWkGK1PFq/BTz1JXyrAkOJmFEp0KUjr7uXx
 WGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177425; x=1754782225;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tT719Yr1a9uhc93zITJ7bwqOfh29BbRAnDJiR12mnEI=;
 b=c0Z+p1k4kp8cHTlj+KC99CMbdgDUhNvTefsd4Upam5S1VCGb+acowHGG2zA/QZhihf
 RyY7Zc7kKxelVay/DIMbPcMYM1kl8Embx9AnQqzLXiEsgzf6O6sbfceSrF+veYwU8dIu
 dnfo64WpAmKZrf72YtFszwg50sXk46rt195rSsx838h3468uY1q1aSWa9SgwksSgBQEz
 rlKFf/VsUFKMk3QnSnIc7OfT32TODze1rRcooQRVy27m/F8mNci47pVvnjfWqSy2XXeC
 dw6q82F1VVCmcqzohcKyE0+n+cmCfohaUke09XvV1/UPH6exOToG9Usa8uv4mF9JYQeN
 nhRw==
X-Gm-Message-State: AOJu0YwXkv7ZvjbVOcgv713EIsIV6xXQVBSggHktmnNwen0iPbNMHRJ4
 Hv28XFSLscyVVB/fXTy38Qbz6ukK0zofTFivVlJXuyFMXkbpSV/1DDZMZn6sxyp/U6qPy2aAqeB
 rFGWMTys=
X-Gm-Gg: ASbGncvSPulgaugRMeS1O3jEmk2h4FBnBGMrzQkfJERT4kktJYSKCoBbtE7ND72t1nn
 KwEd7fjWSWGRi6miiSggW9uLYvwRZy0GD1/Wiri+gbNy2P2WSygZSHny5yoZf3a3TmFMJFdecv1
 7Z0WPy/ado8nl4p6t/00yPV21YRhXZ5/mAUpLzvYifqEU7DZnm1W3tT6cOmvojm47SUlCL8pt1P
 ecj9MGHvfdbmg4dI7TBy9v4ojxEwI5DTePRMTGaCA1RDDAgzJDsoJpnHwecQwSx/BAN//KiyvxW
 VMldzdMazakk157T2FKLDx+hz3nJgYwP2oI4seDRpXkvlZ+9MyD44NmIn8wFvc1vOLl/fSCXjGj
 SMeCxEIECusLeGVf3rzM2nWW2TzE2wqJ4h0cpExivtx2OLhroWegq
X-Google-Smtp-Source: AGHT+IEDXLFDyQ4k6217Nm3UDaXWKgFJEESyRkjATNdGQtW9oJValm//703Cn/O+71alyPVx9UuO5g==
X-Received: by 2002:a05:6870:705c:10b0:2ff:a1b9:881d with SMTP id
 586e51a60fabf-30b67bb0849mr1718214fac.36.1754177425398; 
 Sat, 02 Aug 2025 16:30:25 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.30.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:30:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 05/85] target/arm: Add in_prot_check to S1Translate
Date: Sun,  3 Aug 2025 09:28:33 +1000
Message-ID: <20250802232953.413294-6-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
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


