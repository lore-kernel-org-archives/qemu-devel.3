Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC009C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:16:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwLd-00052n-AG; Sun, 27 Jul 2025 04:03:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLY-0004lw-Kj
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:04 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwLV-000400-RO
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:04 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23ffdea3575so2210755ad.2
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603380; x=1754208180; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ytRuA3L88Bv4lWdDsxQUFk0uzi+wgTB6xmr4FnWYbaQ=;
 b=OhEs7GVykrmOYpvV55+GxpJwA5B7sjGkV+CffwL5+mujhPoWtmVD1zh37Ft8nseq47
 l3a/T68mfECoABDHlDbhl1er5+X/+t0mh3s8G1iUSP007rUR2aoeWa25Xtm+HfJb1j+/
 yS3ix+u/w5gDG0m3MRO8ba2HnSR6gGwugx/uTn+cgXJknvSiN4XGFVaYKv13kDpWqfS7
 DO30CF142bDGd2P++Pbctss2qXb84CpeKFLzPzLHE5MhvPJFtA5plY92Ed3/lxx4QjoA
 xtt7Pd9Crd/dEU/2T3ecvSQrlvAo7/Jy3Ca4uREJ0zWQwyaCIsoTNJ4Ra+gsN8T6scVc
 LAGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603380; x=1754208180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ytRuA3L88Bv4lWdDsxQUFk0uzi+wgTB6xmr4FnWYbaQ=;
 b=iJda7J4IJV/Tsrcp3pV0ZoYZwZ6fFJ1hi9KIZKoZhEVCj0l+WTSHQJJYMBskR/+gsz
 B9FKCbKZwSSkK+Iob5OInHbJLcZXD6jI0Blat6lJBWNXxpy03QRXYVUmlLlRYt7FIeV3
 M/riz/QEcwRU26mufJT0yhxCs7W3JhCPrq8cEuZTYUP5ccQLaVCrDobaaJilXrF2nWr9
 N2RWKhNx/d5kwKsCPTOb50nMRGB/LTlovfccnXNAUGjnsyi10rW2ywWvcMZMw4MCfCVz
 cq05ttTJb/2JMyuLjBRanqnOGc9Gy4BonTVA7PlTNUIGIJL/gUO3Apkw8IlMfY/0vRGa
 oKcA==
X-Gm-Message-State: AOJu0YwtzpOObF6Em0Y1Wnw3XJ3mrEmBBZFV3dcUkycr5lnTBI9GTTGK
 FMN+Yfe6EFUNPg8rQmtJJyitfrpaAZBPageF7i2h0SuilttufscozesSL03bOlHLQ075lbdeHF5
 fiL5t
X-Gm-Gg: ASbGncvPVma6ajFiyjAS8dxC2aIgZUvOK77b6nCiTMHX5iMDY/JAlh2UZcGwFBjZyMu
 fNJBDG5wgedZjuTxe7yCvKkqpJSmK0K0GWQuknDz3JqTq75XgBozrSi+UC66OeO9xkLZ6VZDgYQ
 EuRK44WzvJIEZvLNK1Iahu9/708QKoPEGfKVfCFJR67VtsXoziJ7scvm4a7kb7CUdKbrgUdthrW
 3I7X/wBFphpK/PYLoT4I9IHMlBmPPrc0xVLNlX9RjMf/Ct2V9ZFJY7qSTgAAYrGHS3NpHdXvdlX
 /+a82IjmoAXxgJZa7SvvZzPoLcQK91xecChrU4CN5ETayBbXnAbtw+s8WwgLCQzwGZxcPq6/Ukd
 DjKKJnag2vAxzAyJdEyy1sFdVRHNKmVl8FFmrCwc/vxlPEKBetCoFc9Wnhd0HL5H+9DoCzfQhCF
 QAHk3ag7dGrA==
X-Google-Smtp-Source: AGHT+IHlk4NM/IkaSqqZei2Yo4X6NV4bCNrnxKGNP/UHAifw/peVYY7O86RQzHj16pbaqmKL+7ulIw==
X-Received: by 2002:a17:902:da48:b0:237:ec18:ead7 with SMTP id
 d9443c01a7336-23fb31252c5mr138196085ad.24.1753603380329; 
 Sun, 27 Jul 2025 01:03:00 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:02:59 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 02/82] target/arm: Add in_prot_check to S1Translate
Date: Sat, 26 Jul 2025 22:01:34 -1000
Message-ID: <20250727080254.83840-3-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

Separate the access_type from the protection check.
Save the trouble of modifying all helper functions
by passing the new data in the control structure.

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


