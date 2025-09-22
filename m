Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 871F6CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 19:07:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0lfX-000402-E9; Mon, 22 Sep 2025 14:53:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lfG-0003eG-1d
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:33 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v0lf7-0004wc-Nv
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 14:53:28 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-26a0a694ea8so29187835ad.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 11:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758567195; x=1759171995; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u3lppChNLDhQriahywEGch8lhsfYgg6UozfYzfSbm90=;
 b=CwCFgxFbrrRNLRbCi2GspvL5Rivxi+8e50PT1Y4UFZidTEzoVdKmDCTCZaTo295Phn
 m8dXMZrDArrIi27M5XwxJjToPfG3a7MjCBAs30U68lspgGmR4U3p7HCZP2SpoLO9Xg/J
 kpH0bOO5WanBnCqqKNLJZdKliF4XnLgKP9wCgEHd8qyATWnLSPFXPXeyPxjRqLICIiFc
 rwhkMCOBKAxGMon+T0orQ+eWz5z3wiFq7EgdQRy/SHEpJ16N7ParqZdAS6zLEhq89ber
 cHT7zztQe4nCsxhKaLTmFOThAApmFQlH73J7Jr8nSp/W+XdWBimrQU2OcAvEyggl/D3/
 yKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758567195; x=1759171995;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u3lppChNLDhQriahywEGch8lhsfYgg6UozfYzfSbm90=;
 b=n1USvB5VtIy2w7ivRrZs/iFsMCugfMewp2SqAlerlhknpxYTROKyvBOPJfXf2q1Xug
 zmVVD/5DaTVNq4zH1f2g32u7fD8/fS5iCtYUDG6uk6VydwKLhSSibvJxaox45mO7tzoD
 rnL7UQdgoQCP5+IGZiE1n5CTiSTjrYCsNaip9yqKunlIp1qFIJb62INSZn0cnpO9A2cX
 UQvaTpGJ7H0QjK+o5AU7eDJ03lMdaHJygE/3GDXn6IKgY85A+AMiwCbXbPMGXyS5V67R
 e/pG68kHm4Py9T08ugLhVZqF2ZXq0ZHwoEq4qQ3SPHQeVWqZkTB18SXggeIQ6CgDP8y+
 M5FA==
X-Gm-Message-State: AOJu0YxAju7IBlHO6AjmB5hizlOtcriFGj3KkI6BmUCUYITwq8MTynCc
 k/ZZV19939xq4aC2BFiL1ayc5HRqKgA9b8vyowehmwmfmWu1vSSgePjtfjQ5F/nP2BADsCkP3/o
 R04OF
X-Gm-Gg: ASbGncsddYWg2/JQsEnIyR0eGlsE/WbrTMIPAlJbUSEWQUs2k8rN5HQxBqQrp9CkBeI
 KigBXRwl0qUntdbeNVAMUdYOhL4C9YHt9RdvFjfoisKU/b474V59yxVo1DeQlgdtkpEkhOroSSA
 vzYuBo4FZwjUGuWKelsiE5gU1uJgiPyzjSVcAe1QmuPaLo/vzVyoB2Zp5/3M0XnsmFmQXhb7DWL
 XMqeCcv8GGVOEtJlrAo37AMPQkgI0snn0aisENEM2McNqyCi9RkxqW1/1N3US5MxUCzVKHK9sVZ
 0cSk642QcAtjDg26S2CugT5eI7WvN1QRBPhk/amj3HQMMgVBCSnUmyFNqzI8WET/uheSRu+t+4B
 bdOIfrRQ5t19yMM57S0FHwAwaR+2E
X-Google-Smtp-Source: AGHT+IF5f23Xjj5Et5bObngPcLqjWFuArJxPciSo1NR3ZyuUf2vxBEuGkqWStZo1Y3YVfmfM6Hja1A==
X-Received: by 2002:a17:902:f645:b0:269:b2e5:ee48 with SMTP id
 d9443c01a7336-269ba52e56emr198628995ad.52.1758567195640; 
 Mon, 22 Sep 2025 11:53:15 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2698018a472sm138554795ad.58.2025.09.22.11.53.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 11:53:15 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
Subject: [PATCH v5 43/76] target/arm: Split out access_nv1_with_nvx
Date: Mon, 22 Sep 2025 11:48:51 -0700
Message-ID: <20250922184924.2754205-44-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250922184924.2754205-1-richard.henderson@linaro.org>
References: <20250922184924.2754205-1-richard.henderson@linaro.org>
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 8b5ae0c543..5519484186 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -3419,15 +3419,16 @@ static void mdcr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 }
 
+static CPAccessResult access_nv1_with_nvx(uint64_t hcr_nv)
+{
+    return hcr_nv == (HCR_NV | HCR_NV1) ? CP_ACCESS_TRAP_EL2 : CP_ACCESS_OK;
+}
+
 static CPAccessResult access_nv1(CPUARMState *env, const ARMCPRegInfo *ri,
                                  bool isread)
 {
     if (arm_current_el(env) == 1) {
-        uint64_t hcr_nv = arm_hcr_el2_nvx_eff(env);
-
-        if (hcr_nv == (HCR_NV | HCR_NV1)) {
-            return CP_ACCESS_TRAP_EL2;
-        }
+        return access_nv1_with_nvx(arm_hcr_el2_nvx_eff(env));
     }
     return CP_ACCESS_OK;
 }
-- 
2.43.0


