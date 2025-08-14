Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD59ECA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXXw-0001aa-Ib; Thu, 14 Aug 2025 08:59:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXq-0001Yb-Rr
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:03 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXXo-0004I5-2J
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:02 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2445818eb6eso6365415ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176336; x=1755781136; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E7hKQRMRTXCmigZqJckaUTqAy652f0/yVmAQHFcYbaY=;
 b=Uftm2kTVMo19R7eQg3KDzpGt3M55Pf1h77SHXIBFqUuk73OTdbsXSquN1cqbmQuFVQ
 uKPTIos9gx9K0T5AX5l/4M1GitursXessLFpJKj/b7zGwBht+wu07aWhQvWtJtLbIaYU
 ay8IhDMUzBuvNVWH4GLl9iGk1t/yBhrHe2YfSsAi1LOfQbmcbu/ASD11WRAXj30bIhQO
 z4eJXlH4xShiwjW+/kP+jT1zB54kjsBFHfLhXOazHnEFOawCJj0DIVsrHXqn22/zkzrE
 U5maoULqtg7L+YC1blY7E5OsJeoWAETOd7ZY1M6ilNfkd8GRtLvS1S1EBvFKVb2c2Rol
 3PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176336; x=1755781136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E7hKQRMRTXCmigZqJckaUTqAy652f0/yVmAQHFcYbaY=;
 b=XhnO0C38bYQaLDW8wg1LfGTBtgq75hNRwL7/T/xDAG8NMc80+MYvs49wWAr0KFZ8SX
 mtPItBO0o0G67iyExe8hjAXIILfxoewIcJcmJXWMo82SIrAYvdBU6/ljMSuR00ZvkPDk
 DKu4gNJPhr10qqdpSw5FnX1YaOKnOKYHmwp4vlL27h+qSqJ8PCFEogtJPGRLfHd4Ianq
 xmuUFmSGUOhAzgC+IBOal5DG0tqdYHcQEUqK7GdKFX8W9Wr9R4I0zw2nYbchdNukygpt
 wzaPhivLFuMWutFDQx1ya89psYMsr6aj9Ru/AAAs8w/zujuMyD9+TlFsOXpf8RpNzyOm
 XSBQ==
X-Gm-Message-State: AOJu0YwH7n4OXeTsAsr9TA6/5mhLJGHQSkQQxEhBG2B4BZARKQF68Dd2
 jBv0YAXEtwbl8G6U2RD0vWsaTZLFfUcoXyzYdsu1NxJHPOq1Ak8xE8xmF3ThpeHqH1p56viAQ/H
 lqQv/ECs=
X-Gm-Gg: ASbGncuacpZmUqF6EbnO28Uve+l0iKNjqaCaJwSjMsEDk4TS7tWIugzmVBf1+WJrbZp
 PDPd+PyrtXSGUNHlDdwvwteu8n1uqNvCOnHKyth8vOXiCKVCm6+LPvrpL1rXTUX5XSZ9NZ1VmkD
 UaW6EKjpWoOuf7WTzpRZNMvnyDfKvNNX8dBJcmLTwBPYwfgAUVvFhbjPavekh6jboX1oxLMDYZV
 FJv3b8EbZUJSg0FFZZcThgNPh52+BaiRqy1mEwofBq67HNM1M02EAp6unL4vyDkIj9z4AqNEkNZ
 yLzhxG5xMCxSErSoFvmejP5xLh7Y4mOgSw9nI+fiDNlFYivwaRnx9hfFw4qmX1x6KuQF2Ou//ns
 ZUVoglPB0Y9+/qxj0ROm+Cq5T2gKeNhqERZ5B4mcnhwmB3zM=
X-Google-Smtp-Source: AGHT+IHnamsCCV0tsjR9bpb7rjKBGfm/yptYw6KeVHE0W3ybUYieVbp1FphFsMyRFNCw5qhagGwBWg==
X-Received: by 2002:a17:902:f548:b0:23f:f983:5ca1 with SMTP id
 d9443c01a7336-244584af3f9mr46825365ad.12.1755176335800; 
 Thu, 14 Aug 2025 05:58:55 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:58:55 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 17/85] target/arm: Cache NV1 early in get_phys_addr_lpae
Date: Thu, 14 Aug 2025 22:56:44 +1000
Message-ID: <20250814125752.164107-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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

We were not using the correct security space in the existing call
to nv_nv1_enabled, because it may have been modified for NSTable.

Cache it early, as we will shortly need it elsewhere as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2eb2041edb..a5a3c03a4c 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -76,6 +76,8 @@ typedef struct S1Translate {
      * may be suppressed for debug or AT insns.
      */
     uint8_t in_prot_check;
+    /* Cached EffectiveHCR_EL2_NVx() bit */
+    bool in_nv1;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -1642,12 +1644,6 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
     }
 }
 
-static bool nv_nv1_enabled(CPUARMState *env, S1Translate *ptw)
-{
-    uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
-    return (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
-}
-
 /**
  * get_phys_addr_lpae: perform one stage of page table walk, LPAE format
  *
@@ -1699,6 +1695,10 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
+        /* Cache NV1 before we adjust ptw->in_space for NSTable. */
+        ptw->in_nv1 = (arm_hcr_el2_eff_secstate(env, ptw->in_space)
+                       & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+
         /*
          * If TxSZ is programmed to a value larger than the maximum,
          * or smaller than the effective minimum, it is IMPLEMENTATION
@@ -2074,7 +2074,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+        if (el == 1 && ptw->in_nv1) {
             /*
              * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
              * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-- 
2.43.0


