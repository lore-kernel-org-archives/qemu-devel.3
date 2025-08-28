Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3AF8CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 11:39:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uratz-0003Ge-FZ; Thu, 28 Aug 2025 07:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratp-0003BO-VB
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:39 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uratn-0005bW-L1
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 07:34:37 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-45a1b066b5eso4390635e9.1
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 04:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756380874; x=1756985674; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5NYkoNij4e1g8y7W2fjcFu3t+VJEH8mC1LfM/lquNuQ=;
 b=ZNEhQp7HsTjcUVE1yzF0pPWeV6PW6W1Ku+1OZR3uuntRigR71C7zAYWi8/RCGNfRnW
 RHXCPFWVHRShgRwD3sngqcFDvpdxpWMr0u/uQ4NOYIfIX18npxf9kazT/hUKynDi8pMQ
 tyoCzuC5xOxIkPAikJYwMo5bkYNfQbaiOA9Sn19oYq14+2gzY9hiiNshmf5RH9iUZBxf
 XwLgfJeUZHXdXhfPapbaac0LYa76tRG0m2q/NFzMgvDn5o4mloS7ISZvrwxISLxs6Zhz
 vTk0TsCaUXR4k+/UsXzidVEw0bw3j9S4YZN7O2zPGzAQXbCURX19k+hKmvBIHB/0S2Yt
 QWhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756380874; x=1756985674;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5NYkoNij4e1g8y7W2fjcFu3t+VJEH8mC1LfM/lquNuQ=;
 b=BGNWsmnI2aDwBaPiXHe314iX7AbtoEdkvY8qXbvGnlItpxyzLRuNbojIZ0A67EMod5
 TK6jcUU/HnHUHTtaqjNQO99y60Gy59Be7QV4DDMBsGgM+0VYf5JVUiQBIN4jT5SOMjRI
 qm1574Q4mNAncvgzfmvuZ98D3ld2leWZjORy31DhSNaSSGTZ+H/I77x8fpF1Hppi/mX+
 /MhFizlGdbUXWbG7K2/Rcqa+9Up85/JXzTjGhCfJdr4TmeL7dkFGYMx1k0ifOvoYAYjg
 q7U9pa8qY5EYo75pK/H3UBGandXw6azo9k1gL5NsOQ2y/0y+ZZIHCyaScyaEXy7gRzic
 T3kw==
X-Gm-Message-State: AOJu0Yz0w7LyqT3Wa6JxTTHSqLPGTFb8sSxGKrnRUakU59gFvl9e/4VD
 7au7mlXYg2zogSTLnTg56uXFY96Fn28iY6Rt9tuEMOH+aqyjPSXzwarwo1r5Og17tbO5mSxoyzo
 nYsNN
X-Gm-Gg: ASbGncs78pegISWxJf5OgIjrLMnVB3Nr2eUR09Skq8WuM/O6nc32+WkxY5Z+zNFWjZx
 ngFerbQzkAAlK5LsgOMp0RePt5EJDPTUsqRF/vO5YmUEOGp43nvd5ag7RFC/ElkH9Z5RrGezRJL
 XfN0G1zyL318uyYtLn1uO5lPe9Ut0PLr6mxAvEgelaUdBOa9gO6g9tu9eOjb8i+lW8gHOwZpzwf
 kjMzmnUrQw0Wt+l1lZe1RcVGATEp12bsDwRIxNRUH4xYrBw06LEXv+xKwAR2eRRh97Ed9WoIBHO
 bk4vlCfhcJGchj0c9NeGnPf89ssjN5xaxTu/i1qIn+ENfpeN/0FBlfep9r4kScrMRGpf/8lgxV+
 0c9No+6p1uwpNcPftoeoNoARkJpbNloYghWrJJE4=
X-Google-Smtp-Source: AGHT+IFHeICz5Ipcyh6m2s5kfYPyoZ3DWx8Dr0vpfoFKBwHEKcTKybSqPzBfR3V3+Qpf4Qbw4SnAuw==
X-Received: by 2002:a05:600c:1d26:b0:45b:7c20:5709 with SMTP id
 5b1f17b1804b1-45b7c205c14mr14202225e9.12.1756380873937; 
 Thu, 28 Aug 2025 04:34:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b79799c33sm28691015e9.5.2025.08.28.04.34.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 04:34:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/32] target/arm: Clean up of register field definitions
Date: Thu, 28 Aug 2025 12:33:58 +0100
Message-ID: <20250828113430.3214314-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250828113430.3214314-1-peter.maydell@linaro.org>
References: <20250828113430.3214314-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Gustavo Romero <gustavo.romero@linaro.org>

Clean up the definitions of NSW and NSA fields in the VTCR register.
These two fields are already defined properly using FIELD() so they are
actually duplications. Also, define the NSW and NSA fields in the
VSTCR register using FIELD() and remove their definitions based on VTCR
fields.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20250725014755.2122579-1-gustavo.romero@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 8 +++-----
 target/arm/ptw.c       | 8 ++++----
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 1b3d0244fd6..3f86b070447 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -113,11 +113,6 @@ FIELD(DBGWCR, WT, 20, 1)
 FIELD(DBGWCR, MASK, 24, 5)
 FIELD(DBGWCR, SSCE, 29, 1)
 
-#define VTCR_NSW (1u << 29)
-#define VTCR_NSA (1u << 30)
-#define VSTCR_SW VTCR_NSW
-#define VSTCR_SA VTCR_NSA
-
 /* Bit definitions for CPACR (AArch32 only) */
 FIELD(CPACR, CP10, 20, 2)
 FIELD(CPACR, CP11, 22, 2)
@@ -220,6 +215,9 @@ FIELD(VTCR, NSA, 30, 1)
 FIELD(VTCR, DS, 32, 1)
 FIELD(VTCR, SL2, 33, 1)
 
+FIELD(VSTCR, SW, 29, 1)
+FIELD(VSTCR, SA, 30, 1)
+
 #define HCRX_ENAS0    (1ULL << 0)
 #define HCRX_ENALS    (1ULL << 1)
 #define HCRX_ENASR    (1ULL << 2)
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 561bf2678e5..ed5c728eab6 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -193,9 +193,9 @@ static ARMMMUIdx ptw_idx_for_stage_2(CPUARMState *env, ARMMMUIdx stage2idx)
         return ARMMMUIdx_Phys_Realm;
     case ARMSS_Secure:
         if (stage2idx == ARMMMUIdx_Stage2_S) {
-            s2walk_secure = !(env->cp15.vstcr_el2 & VSTCR_SW);
+            s2walk_secure = !(env->cp15.vstcr_el2 & R_VSTCR_SW_MASK);
         } else {
-            s2walk_secure = !(env->cp15.vtcr_el2 & VTCR_NSW);
+            s2walk_secure = !(env->cp15.vtcr_el2 & R_VTCR_NSW_MASK);
         }
         return s2walk_secure ? ARMMMUIdx_Phys_S : ARMMMUIdx_Phys_NS;
     default:
@@ -3372,9 +3372,9 @@ static bool get_phys_addr_twostage(CPUARMState *env, S1Translate *ptw,
      */
     if (in_space == ARMSS_Secure) {
         result->f.attrs.secure =
-            !(env->cp15.vstcr_el2 & (VSTCR_SA | VSTCR_SW))
+            !(env->cp15.vstcr_el2 & (R_VSTCR_SA_MASK | R_VSTCR_SW_MASK))
             && (ipa_secure
-                || !(env->cp15.vtcr_el2 & (VTCR_NSA | VTCR_NSW)));
+                || !(env->cp15.vtcr_el2 & (R_VTCR_NSA_MASK | R_VTCR_NSW_MASK)));
         result->f.attrs.space = arm_secure_to_space(result->f.attrs.secure);
     }
 
-- 
2.43.0


