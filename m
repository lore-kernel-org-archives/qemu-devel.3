Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2844FCCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:57:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9D-0003sd-KC; Wed, 08 Oct 2025 17:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9A-0003s3-To
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:32 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c8z-0006d6-Lw
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:56:32 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-27edcbbe7bfso3903505ad.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960579; x=1760565379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mMlnh8zeYNwcYH9t58MHsQn/aIeWjLHUQw8sUnZOUp0=;
 b=DI1u872UZ3KGvyYmp1kdBz8bWAQ2eGbbZ7l3LH/yPZXDqXwKMSF3Lp0djN/DVs2M/A
 tXKoicIg533zAZCHVOzMvznwkuMylsXHpIFLmcLcq1TrGOohS21l5zdfWRYugM4rN/Tf
 UcyELHaI57t5dTbIJmf+S/+aZSIeqtKc/5AsiHVPPN7MUGdGvsDZ0+k+yX4UFBQwech2
 80Db1NE1sLMr8nkC0jc4PRQWUQTueLOLYIMV9AMDsmhOrN+7Kx3fBwF8jKpFd+XRHicA
 OC65meieJ11gQ1M6vi+dPbPhpY/SvFbV9/Ui2dvMcm3Wqw/5h0TTI+rCroE7UF6dsn7C
 58BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960579; x=1760565379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMlnh8zeYNwcYH9t58MHsQn/aIeWjLHUQw8sUnZOUp0=;
 b=IpYF+6kahR8filymsbnB3JNzudxjhP98qARw0MlI8beLjosmZHHfUQaRycwEN2lmMS
 fzjuYjPuBJL9FlqaBuX1rcNsNeoGAjPylq7yTwkwnjlmj8Pk6zueFqFA+JHZlpVjpyYL
 6EGF9maFJa91A1HEu0JOiUPDSlXhR5LVFVYtqo6S6GHGUU6eM1bOGPieFrwiPkcloMg9
 Cxu+iusLMaxPBcoeq0Bom7Tea1R694W4hukqMCEWrz4tJPBuJCJMcEWhhjOVWJYO9jIP
 2NmMLB4LjD+1AC/nk5VbyBUYGA56+QVyLyoyK1CDqqKLrZKhunA5RNJB0IvwPk/nTiL0
 1rxw==
X-Gm-Message-State: AOJu0YwLD70YPAccWCXXmt/Y6OF9zbUM1HQ12yzGJnd3Cw8zTkrFZUQu
 bf22GFK4av/pNfU8O+GJmpESV39UOvIUfmqlz4oJT8X0BH89bQ5Qy6gNN9JMduStan2FztdOnyS
 n+UELKlM=
X-Gm-Gg: ASbGnctSqkCWdASPNUTVIb792XRWxO2USEUt6uMHMf+GlmgqPaP/mhnMUnNez6Ah60q
 LO05QnRgkGk3eqvLwiSMm9zHykINtbIcXDG4AFkA06NFnBjD0D3Wf0BiZbzYfEI8FAOW9qDQqkl
 98uIlHj4XGkg3/3FjDOh5euGelvIe3XR7qf9rsfM4LGiW6+h0hblalBxasVmVVJSNVh76VRRgqG
 ueGdfhR1SM3RDRC0XYDn40RKjDt+L1ru7jVdGBltUs0RlXMBZBXLfkKLAGQOuP5t50/0zSI/ft3
 Aih43q1IVPiIwZpGyxoHtvv9XV7Zn7LkslKn3ydlXD6C5oF0xdejno+0fSvRhakvNImjbUy9jKo
 GY41cdrK0YmG9EAILOsA9mr1ZAUkGpVcQ36d+S0psoNArNjp/+B0HUZUn3KFV9lFyOOg=
X-Google-Smtp-Source: AGHT+IGKUJMgtTlHWw2o2IM+XK9NJdl39lmRv4DQjNRNl4uCeuXQSyhzPVZnqCh5rAYVcLLn91if7w==
X-Received: by 2002:a17:903:a90:b0:27e:f201:ec90 with SMTP id
 d9443c01a7336-29027264d78mr66582075ad.25.1759960578669; 
 Wed, 08 Oct 2025 14:56:18 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 06/73] target/arm: Cache NV1 early in get_phys_addr_lpae
Date: Wed,  8 Oct 2025 14:55:06 -0700
Message-ID: <20251008215613.300150-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

We were not using the correct security space in the existing call
to nv_nv1_enabled, because it may have been modified for NSTable.

Cache it early, as we will shortly need it elsewhere as well.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/ptw.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 2657023120..e1515675eb 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -79,6 +79,8 @@ typedef struct S1Translate {
      * may be suppressed for debug or AT insns.
      */
     uint8_t in_prot_check;
+    /* Cached EffectiveHCR_EL2_NVx() bit */
+    bool in_nv1;
     bool out_rw;
     bool out_be;
     ARMSecuritySpace out_space;
@@ -1677,12 +1679,6 @@ static bool lpae_block_desc_valid(ARMCPU *cpu, bool ds,
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
@@ -1734,6 +1730,16 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
                                    !arm_el_is_aa64(env, 1));
         level = 0;
 
+        /*
+         * Cache NV1 before we adjust ptw->in_space for NSTable.
+         * Note that this is only relevant for EL1&0, and that
+         * computing it would assert for ARMSS_Root.
+         */
+        if (el == 1) {
+            uint64_t hcr = arm_hcr_el2_eff_secstate(env, ptw->in_space);
+            ptw->in_nv1 = (hcr & (HCR_NV | HCR_NV1)) == (HCR_NV | HCR_NV1);
+        }
+
         /*
          * If TxSZ is programmed to a value larger than the maximum,
          * or smaller than the effective minimum, it is IMPLEMENTATION
@@ -2109,7 +2115,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         xn = extract64(attrs, 54, 1);
         pxn = extract64(attrs, 53, 1);
 
-        if (el == 1 && nv_nv1_enabled(env, ptw)) {
+        if (el == 1 && ptw->in_nv1) {
             /*
              * With FEAT_NV, when HCR_EL2.{NV,NV1} == {1,1}, the block/page
              * descriptor bit 54 holds PXN, 53 is RES0, and the effective value
-- 
2.43.0


