Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67C14CCA470
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:05:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cBK-0005Gf-2k; Wed, 08 Oct 2025 17:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cA9-0004K2-Su
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:37 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9A-0006h8-N4
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:27 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-269639879c3so2687665ad.2
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960589; x=1760565389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OOmjEL78vAj/qpk42Yir5qx6ESIUS3UfNsoScCN3OOA=;
 b=qB3k+e2qY5DDcrCBBjVTrMNkvm+dfKz+bNHLmdd53/wv1en8s8LunTYnfVzuQRasxM
 cv0Z7aoGu2EqgupgSVwFMLPYY2xrBgX7rMehqBtUsNmfnT5rCV7tFKHRK7UZDTomoojC
 bsun1nbZy8sJ9vCv+D8zxcwXCjwAWcI4AiZ1aaX/omWN2Pxv+53nf87aIcaYwT6L1Hz0
 5lIJzJ6Kr6l7lDSKlxhR60wQMcPRAgaaCn07I/yKpan4400fXnBagQaVTrRUM4g+ETKw
 XC7pYIDy1ubVBt8hIHTtSg41D/siaWhDWKUAh7Y1pgZffrOJTcwZZrbRBGvRA3m+9JeU
 yRGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960589; x=1760565389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OOmjEL78vAj/qpk42Yir5qx6ESIUS3UfNsoScCN3OOA=;
 b=d0DL/4Gd6xQG1BiRTNFG7q1QDgInI/InHAOnxm7j4zE3r0grqbW8avwTL7UUSNhLAu
 WHkrtIl6C1K39bD6AR4f3XbUFfuOgzQtZb7l03z9y8b2zMgob/weYgp3RkJkhMxuJL3w
 RtaLGq8t3tsJJBtz3ARWWcPjEs2t6cai9NH9HeIzFIsddO+ft8DKSgzqNVGl4LJ8p3Tk
 LdLRnbpq9PszmXuXkLNfjeWuNKbirarwh+X/770yP/WsmFAdKczj24RrJ/MF+TAatFdZ
 DDFu35RZGdGNiT26257uwUaKtDCfXbDajrs3LxBWYITooG5fE1FAUzm+8kjsyaAUyfv4
 bnjQ==
X-Gm-Message-State: AOJu0YxEPfP6AzxXy4I1N39vi1kKuhgr7hp6ecTr7OvsHjpOvu/NMqdx
 QB7dBTrOppaywpf524AykzM+GEmpvWGPlfYpj0ZfLXWpuQEbqtKTLIA13GeNOandVD41lVPjCj1
 72n2s5bc=
X-Gm-Gg: ASbGncvjF5XuxA7ybHtOUgq5OTBQyqVhHzYIXB2s8gjtpSAv824jMpmwB8h2o+0jT+5
 s3QJgp2ffnpa7o5w/CLHy/t33EtKBCzxoSInEn7km8flWI0sF4xkcUSK5ZKvJgNBo4/g9pjgvU8
 QtG2EuAaHul29UlCd/zE2HKDgQ7+fVNHYI0LDbcRIqaT4v2UXfIpN+Nk+dDW5QX7aEWWlDBwYtj
 yWqhx82h65UbvqFgqb3eH81wQM60whDEWNaco7uQg64Gxho2eUiAT2Y77FyBN7AFFXndIGk1GtM
 5mt1Y+xoVVFaG5fOxDMzmx+qFz5U6aHQhjWVMliXPRBnIr1xjno1Bcm0lYjAOBMUXeesqQ9QHHI
 GALDJKUsobtee0kaNKYgBgmIqLee7Bz+eQI83cNhtBO0cmU9L3HVeqJOU
X-Google-Smtp-Source: AGHT+IEX9zCHIOODwKK4zXLuwqQkzxW6f4aaGaxGulDjbkx2OlHZsHu5AjjIETTJVbv96X/OJiECmg==
X-Received: by 2002:a17:902:f641:b0:28e:cc41:b0e1 with SMTP id
 d9443c01a7336-290273ef139mr59739075ad.36.1759960589104; 
 Wed, 08 Oct 2025 14:56:29 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 22/73] target/arm: Convert regime_is_pan from switch to
 table
Date: Wed,  8 Oct 2025 14:55:22 -0700
Message-ID: <20251008215613.300150-23-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 13 -------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  9 +++++----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index cb2ffeff59..819ada7a5d 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1027,19 +1027,6 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
     }
 }
 
-static inline bool regime_is_pan(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_E30_3_PAN:
-        return true;
-    default:
-        return false;
-    }
-}
-
 static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
 {
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index f03a2ab94c..41baf1a003 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -16,6 +16,7 @@ FIELD(MMUIDXINFO, ELVALID, 2, 1)
 FIELD(MMUIDXINFO, REL, 3, 2)
 FIELD(MMUIDXINFO, RELVALID, 5, 1)
 FIELD(MMUIDXINFO, 2RANGES, 6, 1)
+FIELD(MMUIDXINFO, PAN, 7, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -56,4 +57,11 @@ static inline bool regime_has_2_ranges(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, 2RANGES);
 }
 
+/* Return true if Privileged Access Never is enabled for this mmu index. */
+static inline bool regime_is_pan(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, PAN);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index f880d21606..98db02b8e5 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -10,6 +10,7 @@
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
 #define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 #define R2     R_MMUIDXINFO_2RANGES_MASK
+#define PAN    R_MMUIDXINFO_PAN_MASK
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
@@ -17,24 +18,24 @@ const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
      */
     [ARMMMUIdx_E10_0]           = EL(0) | REL(1) | R2,
     [ARMMMUIdx_E10_1]           = EL(1) | REL(1) | R2,
-    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2,
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1) | R2 | PAN,
 
     [ARMMMUIdx_E20_0]           = EL(0) | REL(2) | R2,
     [ARMMMUIdx_E20_2]           = EL(2) | REL(2) | R2,
-    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2,
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2) | R2 | PAN,
 
     [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
     [ARMMMUIdx_E3]              = EL(3) | REL(3),
     [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
-    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3),
+    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3) | PAN,
 
     [ARMMMUIdx_Stage2_S]        = REL(2),
     [ARMMMUIdx_Stage2]          = REL(2),
 
     [ARMMMUIdx_Stage1_E0]       = REL(1) | R2,
     [ARMMMUIdx_Stage1_E1]       = REL(1) | R2,
-    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2,
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1) | R2 | PAN,
 
     /*
      * M-profile.
-- 
2.43.0


