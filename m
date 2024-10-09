Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3E1CF042D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2024 00:07:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1syKCi-0004Y1-8q; Tue, 08 Oct 2024 20:05:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCb-0004Tu-TS
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:18 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1syKCZ-0002wv-TL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2024 20:05:17 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-20b5affde14so45287395ad.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2024 17:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728432314; x=1729037114; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G2SEeBS4yBn5Ue1nQmA6MrWE5kNjL002NNNwwbKYNls=;
 b=nyHqqErlHFWGeF3OTMPKHNnTLBYpT0gqymAgIym+zh+g0cf4yo1tfdNkczWpJWT7o2
 uGVqoWRAiwItJjt7tDoETyRyXjE7/yMggihV1w4C1pY2AL4E3Nlca7hentoSfgU2HcVn
 Jby+Yq35tTuPY8Zk1NDbckEP8VcYbbqM9QWJRFnKnEjMVNtw1DXGPSBpcw4T2ZBOvvR6
 DR62s6lp9QbMOjFQiK8eFOxqErW30qVgIwEGzs70vTjFXg3aYMWu1Lxq6WVjkoUBtSSd
 GeyC/Atpvjqgi3ELMXQ1V5x9YhRXtqCJIfRT4jNkqXF5rT8eBQw9H/iGrUSsnfwsb7r+
 ZPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728432314; x=1729037114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G2SEeBS4yBn5Ue1nQmA6MrWE5kNjL002NNNwwbKYNls=;
 b=ZJudyl19112scXkuZ9aUy00ILY0SN2nZFNyAnSy+3IcNTrTe9HpksLfmZ+njW8G0lb
 O4Gb2F9olS7Eeft9y3OM949RACcZ1homl/M8rtg32KHu68IMhUYVZhUEppuz55vVd8+Q
 Bmy3sT7Qk4xlP4I73mZ4f/UCYoGyBae8EZ/bAq5G+fGpequpHmIlL38lKxBsOQgxt0tv
 RizjShSnDlhJPGGc5fwrpoGbc3u9ZO41OAtQwdixEeqaIWStCKBLrNWBW320Z1jqbkJE
 Gz4dggb8RqG76a5rIUNm1nPZCvOYTtCZP4+DYXI5wHVmYiVFtznomgGBdvQrhigiHbG3
 3O5Q==
X-Gm-Message-State: AOJu0YwcEwtxAprvBmeWvC3bQ08i9enHSgjgfrKDGxoCS+6Y0ev8IWyW
 f4RD6QgcoAm2un8i5tIRkLuYd24uGcIreD1COTajP3v7SJZo+TnvclK8cSGXbJPTln4+z8JJMfa
 b
X-Google-Smtp-Source: AGHT+IEIyXlGp9GlJJjjmIJWjUJQUjNDGcChOdkRVTwHuAzsY/hOJnshLN76/ClOQ0ILuClUnw979g==
X-Received: by 2002:a17:903:22ce:b0:20b:a5b5:b89 with SMTP id
 d9443c01a7336-20c63751f24mr14941525ad.35.1728432314287; 
 Tue, 08 Oct 2024 17:05:14 -0700 (PDT)
Received: from stoup.. (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c138cecf2sm60705105ad.104.2024.10.08.17.05.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2024 17:05:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: deller@kernel.org, peter.maydell@linaro.org, alex.bennee@linaro.org,
 linux-parisc@vger.kernel.org, qemu-arm@nongnu.org
Subject: [PATCH v3 20/20] target/arm: Fix alignment fault priority in
 get_phys_addr_lpae
Date: Tue,  8 Oct 2024 17:04:53 -0700
Message-ID: <20241009000453.315652-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241009000453.315652-1-richard.henderson@linaro.org>
References: <20241009000453.315652-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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


