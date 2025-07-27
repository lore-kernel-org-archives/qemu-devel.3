Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B05C87FCE
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 08:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufwPh-0003Ey-0k; Sun, 27 Jul 2025 04:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPF-0000X5-DR
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:53 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ufwPD-0004hc-CK
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 04:06:53 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-23ffa7b3b30so3151675ad.1
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 01:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753603610; x=1754208410; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+NPgwsTSCva71w86Z5YnXEZFZNtXQypOh1AcbEhfj9s=;
 b=ug68Ad4mVlmKi9kWsIl4V2VEPXDvgb0YpkW0+GnBJ1yB6WCx05B3KvOaM40cvkae1Q
 7dXQDX7SENUNgzSMZ8ahj/QAytmSquTZ/i0uSObMKjbUlGxh8ubUfjWtyzG5dpr1W0ZG
 TTxy2GDAatwK+xUgO1yJHWaiMhDCbuxORCEGxfr4fHdNidw4iRJRS5G5FsrepmAvPNSR
 FVEs6j3kiM4B9HI7HQSfTPIb7zQPKnEDcykU2/SB/h0R/AgZA0tSkm1nKdGlUmDglZx2
 gTeMNd2dJNELkvhTKF/8d8DspACYTH3AWBQRjh8oHu83moata3ZR/lTOsaGco1GixZoW
 q6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753603610; x=1754208410;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+NPgwsTSCva71w86Z5YnXEZFZNtXQypOh1AcbEhfj9s=;
 b=WnNNIl0dCH4St4umqIZ+WqzUFB3YdsA0HGNZz0RtYa/mjmw8e3rRWAZolY856XkLfh
 sjcQfEdL8aEZzOrlEaaAkUNbC/3Ok27Mqzt1yPE+eXOssykhhVy5ZzXpREscwlNtbKeC
 M7LvBzXPUZpWp52nyY7K9bI5SsHBVRK+K/1ow3cBaUhT3ZPR7fb60dp8o/Ld69bnvrhT
 prMJ0wHDOPpQixGeL4LSX00oFoZdQO37Ep6J6GogIjV79mrWXeb+Uyvng6KSNf0s/vqr
 mgS9NQd31pCJbMhTWu2+2D72iQ3iDtRmPTZyluMvk77AzMuLb7rTjAEqEOTVa10GYNl5
 +ytg==
X-Gm-Message-State: AOJu0Yyl2UbI4ykX2Oz1dbHfrM1xaD6uSLZ3tWD2eYbyMTX8jZVZnKo8
 ASssKKCzV/P5kuZ2O5nRZuGXxxczcD1cKLnhov1ip4vQTQYa3uqkkOy4saDqVMn6GlVD7DNBIi8
 rXVeW
X-Gm-Gg: ASbGncvpgUshl8xy37jMiIU5JTr8t9xJ61qCpKaNVUqccGpOAlXaJkKNAmUDNCK9rAf
 fbfbE1jhZBy2zcG07aOQPERV/Ylxvyy7pDCC134wQLneG6TMNkPQ/HpKTi84W6PPnw6lFd9DLmJ
 r6p7L0nEHVkexX9Pz4MGAOwnfRhLrdhUvZkH11kWsWbDtjBpCjjOESARU0/SJTdPHPncRvWhzqS
 9EylIBC3NqUmDM8gqdjGTYL2YiIEW7k19kN+HlT96XCwCf/8pdH9Chl+vvAEO85oWGoa2jysiRV
 YSMhzAMEMbfckt5A5OChwZfqOk3Lh90nVyCc38zUSugOTTvGLcOFk76DfkLkjSZ37gutWBmRKfw
 SfhxjEjXHRJnC415aWEXDjrOOAtPpgbiQG1PGhuRKotdDSypDVDNZ2wCAkw3QrIGjSokwy1a5u7
 U6dKgDp+zXSg==
X-Google-Smtp-Source: AGHT+IH2L8R/p7KXz2bqy+DWrzlFTVJp4BuheM0T+jF8uWaVXvL+N7x6wWZACMISCsUdrIgSJgrk7w==
X-Received: by 2002:a17:902:c602:b0:240:84b:a11a with SMTP id
 d9443c01a7336-240084ba2ddmr14898605ad.17.1753603609941; 
 Sun, 27 Jul 2025 01:06:49 -0700 (PDT)
Received: from localhost.localdomain (syn-098-150-199-049.res.spectrum.com.
 [98.150.199.49]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24011d5bcbesm3908065ad.10.2025.07.27.01.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Jul 2025 01:06:49 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH 43/82] target/arm: Implement gcs bit for data abort
Date: Sat, 26 Jul 2025 22:02:15 -1000
Message-ID: <20250727080254.83840-44-richard.henderson@linaro.org>
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
 target/arm/internals.h      | 1 +
 target/arm/ptw.c            | 1 +
 target/arm/tcg/tlb_helper.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 805f4a1876..7a42f8be0b 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -756,6 +756,7 @@ struct ARMMMUFaultInfo {
     bool s1ns;
     bool ea;
     bool dirtybit;  /* FEAT_S1PIE, FEAT_S2PIE */
+    bool gcs;
 };
 
 /**
diff --git a/target/arm/ptw.c b/target/arm/ptw.c
index 3c84f0f024..ce9626b627 100644
--- a/target/arm/ptw.c
+++ b/target/arm/ptw.c
@@ -2393,6 +2393,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, S1Translate *ptw,
         fi->stage2 = regime_is_stage2(mmu_idx);
     }
     fi->s1ns = fault_s1ns(ptw->in_space, mmu_idx);
+    fi->gcs = regime_is_gcs(mmu_idx);
     return true;
 }
 
diff --git a/target/arm/tcg/tlb_helper.c b/target/arm/tcg/tlb_helper.c
index ae2acd6727..37c7651799 100644
--- a/target/arm/tcg/tlb_helper.c
+++ b/target/arm/tcg/tlb_helper.c
@@ -78,6 +78,7 @@ static inline uint64_t merge_syn_data_abort(uint32_t template_syn,
 
     /* Form ISS2 at the top of the syndrome. */
     syn |= (uint64_t)fi->dirtybit << 37;
+    syn |= (uint64_t)fi->gcs << 40;
 
     return syn;
 }
-- 
2.43.0


