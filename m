Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E31C87FCF
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:18:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwOL-0005l7-NE; Sun, 27 Jul 2025 04:05:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwMB-0006ZM-5h
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:44 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwM7-0004CD-SJ
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:03:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-234b9dfb842so30466645ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603418; x=1754208218; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHjiVrtyGk+joVx6C/qMYRoqGTR+w3gl7nkjiPlPhGo=;
 b=GAT9jsDjYUxjhlNzx+Deqs++GNAD83dRqqFmwusSI7fn2ITpQZJZdgyrObifhumJmy
 1pHaCIjIEeN6bTmZzuMBorMHOyYMHD+JuXEEjnqhCYzxc++GZcoTxmGf/3gg8NM1Sd2R
 DodqFIgiNR7+y4bwoYPnr4DD71LaO+mXO2RfcBDiq5VamNxRmmOutcYV3eAWcpUDxDUG
 qFoOIhi6SLC8BcEcZfW0acsCabgwK0OiPVJvP/RtOPd07JFgQ2wP9cdiLB3b059hpLtp
 yIUaamzaBjabvZ1ctzDtu01CdcdttDldg0xGTSe1ndhscnhe6k/kyqpPUDQM8SO4t1YE
 17tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603418; x=1754208218;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FHjiVrtyGk+joVx6C/qMYRoqGTR+w3gl7nkjiPlPhGo=;
 b=kJu8mmWV+PTwmfVQPuca5m6Outvbq/enJLTy32UVOahZbyy5DmxLWpEUxpCMNBMZEN
 6NYTBHY6cbHPHq8YPfE3V8X7lD5IbVT17AWR/NrfCLt1xMH/Kb3TG/djluPR3VjgVqh5
 SfkKI106E1HwfnZ3otfLwGKJVYZfOwsiOGK2jl/LXEtbbCwYR4M8mpwo4tLTLTGSJSvB
 ABPHnbOxlLhHyMbpOvMmTs5tz8GDAvoud0gOzwrCWXGYVEeNuuv7EtXZRfIDbBUiNj+F
 fvn3nxsgC5WDOp3DZgts0ZkLl0/tm2ULgH2vRh0lTa6KF9wd8bEwyeWIh1VE0Tqx3QAR
 efaQ==
X-Gm-Message-State: AOJu0YzpM1tSNRKn2AS/v2g+tTqRyj5URba9Zq9a+LrXarwvVru3iNro
 48J7nidoKPBOiJYLe1xfUgt4zrvNx8Hf0lvjLrPTZeANvYaLW/pXgHgeVoJqZCzdJQetVAoyDdH
 BzQ7W
X-Gm-Gg: ASbGnctRXq3rKvuATHjRUNgrmq4MDW1Yta+zeGfogafeUeTVH1mB3IdMThek9mS+Wzk
 OzMHP4A9MgWTx6pNfrprOHn+G6CKMT8ly6kXiwCe7YR3d3LnEsJ1aKZW/G9RHvzYr97WZ8A8G3K
 +4W7ZriNEFES3zgj/eV+I8ITF0oRtn5w0dX00IWfCOyCJ86arnEjrpp/UI/e+nlytfuUGWAIYTT
 otgMvLdimpXcgfi0bfhb6DqufbEVA8BfqYb1Epmk58lXI1z3CCj51itfPYW9voVT8hdZOuDvbxN
 73Xc/KxrBv4HS2UJxLXkY8R71m30W9WPqw3nWapaK6fOSCXsu9/njsmKkH1r4wicf89zQiu7pVP
 AjIhcUuCfHOvtFwUjxijtCbmkW8F4clo/P8LUniuXX44CptB0a07huH2U6UHPCL3pAnMbhbh/nE
 KMSrRYdCX1qA==
X-Google-Smtp-Source: AGHT+IFI+VMdb3I1r+njjq4NDcntqyF/lQV/iglQN6oRXq7iB633oxpAICLiZKLNe4xChMKhr8X8QA==
X-Received: by 2002:a17:903:986:b0:240:9cf:99a8 with SMTP id
 d9443c01a7336-24009cf9b76mr13579885ad.11.1753603417996; 
 Sun, 27 Jul 2025 01:03:37 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23fbe333efesm30016415ad.65.2025.07.27.01.03.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:03:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 34/82] target/arm: Remove unused env argument from
 regime_is_pan
Date: Sat, 26 Jul 2025 22:02:06 -1000
Message-ID: <20250727080254.83840-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250727080254.83840-1-richard.henderson@linaro.org>
References: <20250727080254.83840-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h | 2 +-
 target/arm/ptw.c       | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 0322646753..962fc423a6 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1029,7 +1029,7 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(CPUARMState *env, ARMMMUIdx mmu_idx)
+static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
     case ARMMMUIdx_Stage1_E1_PAN:
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 30c83334b6..c75b15b263 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -1394,10 +1394,10 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
          * We make the IMPDEF choices that SCR_EL3.SIF and Realm EL2&0
          * do not affect EPAN.
          */
-        if (user_rw && regime_is_pan(env, mmu_idx)) {
+        if (user_rw && regime_is_pan(mmu_idx)) {
             prot_rw = 0;
         } else if (cpu_isar_feature(aa64_pan3, cpu) && is_aa64 &&
-                   regime_is_pan(env, mmu_idx) &&
+                   regime_is_pan(mmu_idx) &&
                    (regime_sctlr(env, mmu_idx) & SCTLR_EPAN) && !xn) {
             prot_rw = 0;
         }
@@ -1536,7 +1536,7 @@ static int get_S1prot_indirect(CPUARMState *env, S1Translate *ptw,
             p_perm &= ~(PAGE_RWX | PAGE_GCS);
             u_perm &= ~(PAGE_RWX | PAGE_GCS);
         }
-        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(env, mmu_idx)) {
+        if ((u_perm & (PAGE_RWX | PAGE_GCS)) && regime_is_pan(mmu_idx)) {
             p_perm &= ~(PAGE_READ | PAGE_WRITE);
         }
         perm = regime_is_user(env, mmu_idx) ? u_perm : p_perm;
-- 
2.43.0


