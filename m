Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7FECF2592
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 22:20:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t06q4-0007JD-PB; Sun, 13 Oct 2024 18:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pl-0007Da-21
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:06 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t06pj-0000xv-4M
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 18:13:04 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2e2e2d09decso2023061a91.1
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728857582; x=1729462382; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2SEeBS4yBn5Ue1nQmA6MrWE5kNjL002NNNwwbKYNls=;
 b=r/EMBe5sOSc6hzF57LU7ISDDP5djrRFTqJiikhAFegYM+4TDDx9LHTkUNv9Jth07Sg
 Ff9ZqERL4RrjK2VKKtbk1htWhC/zLGbWLbUkZFFHJwMk4RnACYH+hzjLuX6ZjagAlQ9R
 Pd/LmwfnjriG7e+2GxH1VcYD5fmcitOySDshVK3f8KMIJ6BfsRk7b3v5rbX5MwonLNPp
 dDaDHbot8wxzARtPbW4VWX5ZTKlsiZAd9NnO4QDzmRhcZuRR8/+/AZndCF9FRlegUOaO
 2spasXPNbg2X9Ky4+4COuuFKrQWu0MMJnglhDvFxC8J4HXJE1GPjCrBQrgT2EuA/kh35
 samw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728857582; x=1729462382;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2SEeBS4yBn5Ue1nQmA6MrWE5kNjL002NNNwwbKYNls=;
 b=vLr9XYnzMFtWVtIE+okFrbYvOUX6KYL/G4+zkCjcxa1Kj25w1fhMPnaMqT0twlV4xF
 4pwma1psVtN8DGLIBzW6u/DG/a2lUuWDvxNj85UA5E9V+S4oxJDq2VHbi4pnEi7c9KjA
 FN4NFrS9Qa0tzRSgx51LYrRjYBwwz3/87scLKsNaBlwC45m6LL2E1j62JwP2tTk0pHfl
 kLcs8p9OPKkIFHsYSj7TWqJs4E63l2nGDENjBsuqY7L2Mm/wRSG3rQXWA+p2AOWnht9W
 bGLuXH+MBHP3l8krip4mmeUiciRNVubaKPZypmUN5a0H48GRrY6/KS+D/p49xWWEnfhf
 BX/A==
X-Gm-Message-State: AOJu0YxZmOi/2cWkzbZkm7U1OuqQil+BEMGRT09gDMtBvXBOqb6kExZ2
 vzyXOvmikruzeZ0sdjpWdmensQyr70F8+2YtXNTBEKwLZHwAKzY0nTLQb4zVXopmXwnED4OrVi8
 6
X-Google-Smtp-Source: AGHT+IHDC4ts9ocHqy6SAH35JDroJhuKCs3Id7MttegPHlnoQZYJRRstopLO4gX+bU1U9JKIMGhs0Q==
X-Received: by 2002:a17:90a:c2c6:b0:2e2:a5fd:7e4c with SMTP id
 98e67ed59e1d1-2e2f0aa8b36mr14247839a91.8.1728857581678; 
 Sun, 13 Oct 2024 15:13:01 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5df1eebsm7271958a91.17.2024.10.13.15.13.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2024 15:13:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 27/27] target/arm: Fix alignment fault priority in
 get_phys_addr_lpae
Date: Sun, 13 Oct 2024 15:12:35 -0700
Message-ID: <20241013221235.1585193-28-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241013221235.1585193-1-richard.henderson@linaro.org>
References: <20241013221235.1585193-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

Now that we have the MemOp for the access, we can order
the alignment fault caused by memory type before the
permission fault for the page.

For subsequent page hits, permission and stage 2 checks
are known to pass, and so the TLB_CHECK_ALIGNED fault
raised in generic code is not mis-ordered.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 51 ++++++++++++++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 21 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 0a1a820362..dd40268397 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2129,6 +2129,36 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         device = S1_attrs_are_device(result->cacheattrs.attrs);
     }
 
+    /*
+     * Enable alignment checks on Device memory.
+     *
+     * Per R_XCHFJ, the correct ordering for alignment, permission,
+     * and stage 2 faults is:
+     *    - Alignment fault caused by the memory type
+     *    - Permission fault
+     *    - A stage 2 fault on the memory access
+     * Perform the alignment check now, so that we recognize it in
+     * the correct order.  Set TLB_CHECK_ALIGNED so that any subsequent
+     * softmmu tlb hit will also check the alignment; clear along the
+     * non-device path so that tlb_fill_flags is consistent in the
+     * event of restart_atomic_update.
+     *
+     * In v7, for a CPU without the Virtualization Extensions this
+     * access is UNPREDICTABLE; we choose to make it take the alignment
+     * fault as is required for a v7VE CPU. (QEMU doesn't emulate any
+     * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
+     */
+    if (device) {
+        unsigned a_bits = memop_atomicity_bits(memop);
+        if (address & ((1 << a_bits) - 1)) {
+            fi->type = ARMFault_Alignment;
+            goto do_fault;
+        }
+        result->f.tlb_fill_flags = TLB_CHECK_ALIGNED;
+    } else {
+        result->f.tlb_fill_flags = 0;
+    }
+
     if (!(result->f.prot & (1 << access_type))) {
         fi->type = ARMFault_Permission;
         goto do_fault;
@@ -2156,27 +2186,6 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
     result->f.attrs.space = out_space;
     result->f.attrs.secure = arm_space_is_secure(out_space);
 
-    /*
-     * Enable alignment checks on Device memory.
-     *
-     * Per R_XCHFJ, this check is mis-ordered. The correct ordering
-     * for alignment, permission, and stage 2 faults should be:
-     *    - Alignment fault caused by the memory type
-     *    - Permission fault
-     *    - A stage 2 fault on the memory access
-     * but due to the way the TCG softmmu TLB operates, we will have
-     * implicitly done the permission check and the stage2 lookup in
-     * finding the TLB entry, so the alignment check cannot be done sooner.
-     *
-     * In v7, for a CPU without the Virtualization Extensions this
-     * access is UNPREDICTABLE; we choose to make it take the alignment
-     * fault as is required for a v7VE CPU. (QEMU doesn't emulate any
-     * CPUs with ARM_FEATURE_LPAE but not ARM_FEATURE_V7VE anyway.)
-     */
-    if (device) {
-        result->f.tlb_fill_flags |= TLB_CHECK_ALIGNED;
-    }
-
     /*
      * For FEAT_LPA2 and effective DS, the SH field in the attributes
      * was re-purposed for output address bits.  The SH attribute in
-- 
2.43.0


