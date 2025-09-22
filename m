Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FB52CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lbn-0004nF-Cu; Mon, 22 Sep 2025 14:49:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbh-0004jV-7t
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:49 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbb-00046l-U6
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:49:48 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-77f3580ab80so1571324b3a.2
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566980; x=1759171780; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vHa9Qq8DX2Y49JZLrDTFTxWjUOJjulTertOrAzy3PWg=;
 b=HvtmLkLWvmNG0YwO4LpZgag5VE/bDD7xS5hcHTeF8/GdBiEtDRfCwg/+WzBus9Ckxj
 i7EdYiXETr9XsYiOP5lVUUrRdNROxiTTRqFz6jatqRQnukXhK67PcX5fruBWv5PmeCKa
 5X2YINW8AVO+1Els9BzxaLGKrfpUMYvGVAJxD3X60wRLFYD+qACEmPUz2QlMujFgDpPU
 55vAfNbekagQYsSejmlkGHD4QvJeXjgp3WA9zcT0F9faMF8sj1IrIn5Tx4wLpKWTjoT2
 OT280ldb234nOiDAFYDWW0LSKJmYjjFaE4KKRIyefz9eymx9SZ2FGmaOIkSd4ed7gmis
 xK1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566980; x=1759171780;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vHa9Qq8DX2Y49JZLrDTFTxWjUOJjulTertOrAzy3PWg=;
 b=GQVAxKi4DBGC2DsX7DYtKig91Tc+p9pQbw5dcXbFo19wllmkCs0C3ZZ+3mwPSR4yrJ
 2t5kxFzCn9wOkeeHOHfttHFgsD+8MAdoF+R8x+e6Swr2v0r4xRzh341GDVu5UPgoxQtY
 XeCsNmBuONlQriuvxWTo636EZFgFBQ1ecR7TLsv/oNsIwDmBpmFZp+rOPjsWYfc7qbq9
 a28+xV1zvS/NgpJuZmhR+hJ8rnaag57M5WHTFM2kG+xlo3XaEBvDWLqOHVzI/kIDcbgc
 CycCf8z/poX2LJqSVpDB7AAqdF/sNafT7FM2fycVHzxb/rIfVxPiZSdSNkyO00ILUDBk
 cejA==
X-Gm-Message-State: AOJu0YxGfrg7n4M1kp7ZvqG7oxWjofxwekV3qzC6kQUJ2ceRU0Jn9GwZ
 jkcDjs1n8YwR1Dz8/fbY1JDujPXqlcqPT+gCHGBXYD09zRiz9nQmPgvNOzOHGCMDRscRV49FbHh
 hx3YD
X-Gm-Gg: ASbGncvDOrokTmYu2BzQ3PBB3SEaPwU+UNrh+UueCWkCwdTzOEocYq65wrbgoX5mGoW
 T2hETaS0lFn2PUvJmr9uHoiCT8dMvPnuwlELXRMfVRjXI8iJiVCk65bruUYkQofzna8FwvNmFMa
 rvuuPwmAEJNqhKHfu+vuOPvcRsohyjXBtEaCaWy1QSWU8dFIYrISo7cSplnKPPNRs9Ubvlnkx38
 5HI88Rl0l3C0Lb+asaAl/S7S+HFo9P1aNAsld8StPuOJmfdnY/xpkAXOhx8xUQ+sXg59rNf+T67
 J6BJD0svUMnoSn5nZ/6C5f5DklVSEoJLIqVc3EgUQuGGzaxViQuKVtKuX5z7+0NESlzHkW2J0TR
 +Y/TRsC2bFLrW1pCZF8zDz5AcEBEw
X-Google-Smtp-Source: AGHT+IHJsYnNFWBXHCk/DsBbSU7srgtH22rmEctqnSWc2gel5ho+VCgBm/B1SDqENf6SFRSnvBkbLQ==
X-Received: by 2002:a05:6a20:431f:b0:2b7:949d:63da with SMTP id
 adf61e73a8af0-2cfdcfefdd7mr144350637.18.1758566980396; 
 Mon, 22 Sep 2025 11:49:40 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:39 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 11/76] target/arm: Implement dirtybit check for PIE
Date: Mon, 22 Sep 2025 11:48:19 -0700
Message-ID: <20250922184924.2754205-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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

Both S1PIE and S2PIE have a bit to make software tracking
of dirty pages easier.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h      |  1 +
 target/arm/ptw.c            | 16 ++++++++++++++++
 target/arm/tcg/tlb_helper.c | 12 +++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0ebcf566ec..a2ee5f8739 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -752,6 +752,7 @@ struct ARMMMUFaultInfo {
     bool s1ptw;
     bool s1ns;
     bool ea;
+    bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 6dcd3adbdf..be3629a745 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2311,6 +2311,22 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         goto do_fault;
     }
 
+    /* S1PIE and S2PIE both have a bit for software dirty page tracking. */
+    if (access_type == MMU_DATA_STORE && param.pie) {
+        /*
+         * For S1PIE, bit 7 is nDirty and both HA and HD are checked.
+         * For S2PIE, bit 7 is Dirty and only HD is checked.
+         */
+        bool bit7 = extract64(attrs, 7, 1);
+        if (regime_is_stage2(mmu_idx)
+            ? !bit7 && !param.hd
+            : bit7 && !(param.ha && param.hd)) {
+            fi->type = ARMFault_Permission;
+            fi->dirtybit = true;
+            goto do_fault;
+        }
+    }
+
     /* If FEAT_HAFDBS has made changes, update the PTE. */
     if (new_descriptor != descriptor) {
         new_descriptor = arm_casq_ptw(env, descriptor, new_descriptor, ptw, fi);
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index 23c72a99f5..ae2acd6727 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -24,13 +24,13 @@ bool arm_s1_regime_using_lpae_format(CPUARMState *env, ARMMMUIdx mmu_idx)
     return regime_using_lpae_format(env, mmu_idx);
 }
 
-static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
+static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
                                             ARMMMUFaultInfo *fi,
                                             unsigned int target_el,
                                             bool same_el, bool is_write,
                                             int fsc)
 {
-    uint32_t syn;
+    uint64_t syn;
 
     /*
      * ISV is only set for stage-2 data aborts routed to EL2 and
@@ -75,6 +75,10 @@ static inline uint32_t merge_syn_data_abort(uint32_t template_syn,
         /* Merge the runtime syndrome with the template syndrome.  */
         syn |= template_syn;
     }
+
+    /* Form ISS2 at the top of the syndrome. */
+    syn |= (uint64_t)fi->dirtybit << 37;
+
     return syn;
 }
 
@@ -176,7 +180,9 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr,
     int target_el = exception_target_el(env);
     int current_el = arm_current_el(env);
     bool same_el;
-    uint32_t syn, exc, fsr, fsc;
+    uint32_t exc, fsr, fsc;
+    uint64_t syn;
+
     /*
      * We know this must be a data or insn abort, and that
      * env->exception.syndrome contains the template syndrome set
-- 
2.43.0


