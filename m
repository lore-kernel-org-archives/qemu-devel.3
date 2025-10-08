Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E77E3CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:16:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6cBs-0006VD-2e; Wed, 08 Oct 2025 17:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6cAU-0004Ss-Ak
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:57 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9J-0006lL-St
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:53 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-32eb45ab7a0so414589a91.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960599; x=1760565399; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nTaRNAIlXRr2HluCRjHCnfauBYxq1TF1ZqwOTN4Ef3Q=;
 b=LAMmgUUOF3wBrdogFHqJIiDQ6ocAO/tR6ro9hZ74Clq1CtVgiVmagq9xz860HLlHn+
 YPcmWTtZfdfk6mpuEYIlG6MwCuEMMmJq9V1/EzjWvH1i1jRtq9ba2Z7kEMnCVtzSRhZc
 wR7gBvRyXQUXUne54AUmJD048/fND5u+5YCYUg65QHYluNDfhwFyoo2MbD/aFawqiFpm
 53+ouV9UgHJHe1hrJPIXQlOA++glgkNpgVvnPkxL1rvEZ6TXC4YYYOv0MeqMlmcnGcj3
 3WClaIMxXKkEaRgdYLN/RYVwNvh6ydyToEsCVjmKeA/dDiHfogcWKn7t09vQLNWa+why
 iKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960599; x=1760565399;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nTaRNAIlXRr2HluCRjHCnfauBYxq1TF1ZqwOTN4Ef3Q=;
 b=Xy+S+/u8h2lQM1HVK2+77CiYcKhTF3JKvSS6uGpf6sSB6fErpCUDTu65XkFMMHlsmS
 anawMMrIFoiawTi1oFcZr9wPvaDuWytUJ5jbZb+GRVLZ56pn3fQZbrd2pk5hDiRt3YUO
 VT9WzgSbvLMD8tUV0QpGKMj0oKtdTdly+qeg77bkJ/Dk5LGWJHVwfWs/ixR7AmXMHBl/
 tTpr/Q7neXy3id+DzJa+BtRGHDilS7Q5o3b83fTFEwhkTe0MUcTROL8O+8goWtpU2Veg
 yaJdOwn0FFxnZdhSVJLT7IaPGnQQd3W1gf2BeWBPPvo+TL+j+DvclutNwowB2VLxTya6
 qZGw==
X-Gm-Message-State: AOJu0YynBCMUC1C/U4vKDPVkNu2fxHRkcj2RtWXl1rwEzuOBEGHB1A3B
 oyOY/mTjm2yXpAyaUBbHebulv5BjkxC3sENI5pfswvZ6/PV0rJZUJ4D1hSan/0/gvNfgLp6sfdE
 H1jhTp9k=
X-Gm-Gg: ASbGncszFd1zrzyspSBIgYAnyKO/7SI1eshudFK83tlJy9MToKMJBWFcIqM0VNToRUC
 AEuTtjRk2yEdTbGILi77MN/CTNFPbQdwhEFJuLfN/fmRSiC/R58nDxgCcakKxr6Zs+KglhXPo/i
 51+pUUboA6zHJfMVRh6LcS1+tFMIaaNwpNCzWTFdtyAFQH0GyDNINNQcAA4vlK6vCR7rPVAEuSb
 Pc+td3SClSWXOkyTXDKeKL+lCjSRAX607K2fwnYV/eqdnIEmviiS/NQ2c8i/EQ64sLxWpethBLw
 jjbD2oiVnH+84pJBlBpZ9vftsG2CS8h4nixbwK2vq7S9PwGzdgN6AX5N+h7H8Rhb1qJhhJUBQ4k
 cmKPu3fMrRWb8lfTmwnptR+6Yi6f49nP6v7YkVVYG0N1C2hV6EkOwgX8i
X-Google-Smtp-Source: AGHT+IHD30H7NAd4Iavvdc6fAU+cbyY3BfUsDvN0RrCXC+qFGoVu2Cmvk2m8e+OpaIJWw2nf6s+tJw==
X-Received: by 2002:a17:902:e54a:b0:269:8f0c:4d86 with SMTP id
 d9443c01a7336-2902741e857mr62959885ad.53.1759960598924; 
 Wed, 08 Oct 2025 14:56:38 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:38 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PATCH v7 38/73] target/arm: Add arm_hcr_el2_nvx_eff
Date: Wed,  8 Oct 2025 14:55:38 -0700
Message-ID: <20251008215613.300150-39-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1032.google.com
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

Implement the pseudocode function EffectiveHCR_EL2_NVx.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h    |  1 +
 target/arm/helper.c | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b8abfd8276..54f3d7b1cc 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2235,6 +2235,7 @@ static inline bool arm_is_el2_enabled(CPUARMState *env)
  */
 uint64_t arm_hcr_el2_eff_secstate(CPUARMState *env, ARMSecuritySpace space);
 uint64_t arm_hcr_el2_eff(CPUARMState *env);
+uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env);
 uint64_t arm_hcrx_el2_eff(CPUARMState *env);
 
 /*
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8e342b0811..e397fe75bd 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3904,6 +3904,16 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
     return arm_hcr_el2_eff_secstate(env, arm_security_space_below_el3(env));
 }
 
+uint64_t arm_hcr_el2_nvx_eff(CPUARMState *env)
+{
+    uint64_t hcr = arm_hcr_el2_eff(env);
+
+    if (!(hcr & HCR_NV)) {
+        return 0; /* CONSTRAINED UNPREDICTABLE wrt NV1 */
+    }
+    return hcr & (HCR_NV2 | HCR_NV1 | HCR_NV);
+}
+
 /*
  * Corresponds to ARM pseudocode function ELIsInHost().
  */
-- 
2.43.0


