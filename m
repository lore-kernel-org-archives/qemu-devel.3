Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C12A4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 18:52:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lcD-000584-7o; Mon, 22 Sep 2025 14:50:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbz-0004xp-LC
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:08 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lbt-0004Cn-Al
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:50:07 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-77f1f8a114bso1622328b3a.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758566998; x=1759171798; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lT8XgyL4GSdlSJQGrgvUQ4oFKNcHSEZIN97989Gt4ug=;
 b=Cx6mjwK3cPmNL72rlG01EB7kCv34zMItztQklxxAJoU7tcrTgCHY16JTIlzDROr9I2
 TmF6m7NWcR+RYZnQO57j/aslxRp+hYg62KInWhdR/kY1voMFXSMydoWyU12i1L35gD0C
 DdHOMAgDjZwvDYeLQtUOM6wyCJYWaDY9zm+RfStzS6xBlUkyugG9L5wrHdBRvsLSvbVl
 i6lgjLScTLTxDCjM8M49xLrtGMiPxQtxdfVFHo73tuVTuQ+myK+1RrziIwt6N7OhiwUN
 3m1P4YjhHooc/H5hU56a9lpiOk78mznx9aKhZTLhzduBKEBHBKwyqh1XsR8TP+I/X/XD
 nDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758566998; x=1759171798;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lT8XgyL4GSdlSJQGrgvUQ4oFKNcHSEZIN97989Gt4ug=;
 b=YhR3kMIEbfLChjUHdKl7TQjYEG3pOc157ZRW+zi3m1GldtFouZTslzQ59QRalKIJWD
 OguUKnIrb4xdYdkfoyh0/vSNF+l9yFbb1VH5Kx+Aro/zVlJoOl9+d+QldpmPIaJEMAhn
 pklTohh1np76tyhfd6lFJXUQb17fEjinLQukD8C81/4CCGEhX4biMEZ1n76YzrHnXgmH
 rlKJ4nL5ERu+qym0AeVYHvrLnK+qGlqxbjLgYlBTcuEC+QfMKgc4Z/sv//GeLB5y+LWV
 z4IC6MuS9VhjV88F/iAW0b359fKNKPXfFjMeJASJ4B+RAap5VvfzJCt5vpVQSiPgbGaQ
 ZYlA==
X-Gm-Message-State: AOJu0Yzo2LjutY7GtyRfBwBxsjommmhKQ4t1p/Ad7cM9scoe+QxDcQpS
 l5BmDbbaPJ8bX34ZNqDlVMs/bJfBNExAiGAVFrM+jRHYepBl7kbW5IOwocsZRAOiz6scy/FNRVX
 H92rG
X-Gm-Gg: ASbGncusGDh/3mRr8RNtxh9jPK73Fg22kN5bb3JHlf1uJd/4MJ/rm4wMFB0y5sHH675
 jcKzTYWrgSTk27XKgQ0CkWT97T/snOO0mpx8iNwrSWklbvwfwRhna7qcYF+kXc5eT2uX6fb01Tx
 ZMyJ3jR9zbTHIawNqQy2TxrR4IcJw8IFmmfk5U2HvcCCwxQwZAFJgMguZGl2LOF7IsmhJHyjVJe
 aRZPl1dHjBwknk9agVGVdpVyaCuqmaUkuC2BIt55m9pAGeuGbX4BwQMTQbna+VtnI/pHJve3Y3n
 1LIK+t7eyIw1Rs1wsuy7HJRGstecHP9pSruFSDGFfHWTgY6TOyCdUvHFjQ0UCGZvbxCpog33Cig
 6FP7BlzLlsXTEZbpOy93cgRj5oMDc
X-Google-Smtp-Source: AGHT+IFtxXNINP7CtMAHgButhBt7P/V76JLRl77TBx3ZlG1lDCFb8oj/ZU7+zuk/bEcRRc4lauhijA==
X-Received: by 2002:a05:6a00:1a0a:b0:77f:43e6:ce65 with SMTP id
 d2e1a72fcca58-77f43e6d795mr3069704b3a.0.1758566998555; 
 Mon, 22 Sep 2025 11:49:58 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-77e5fe6de75sm10583861b3a.19.2025.09.22.11.49.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:49:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v5 25/76] target/arm: Convert regime_is_pan from switch to
 table
Date: Mon, 22 Sep 2025 11:48:33 -0700
Message-ID: <20250922184924.2754205-26-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       | 13 -------------
 target/arm/mmuidx-internal.h |  8 ++++++++
 target/arm/mmuidx.c          |  9 +++++----
 3 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index b32c31779c..b180499ecf 100644
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


