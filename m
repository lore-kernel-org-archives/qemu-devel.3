Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB567C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:40:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx3C-00010s-Nc; Tue, 28 Jan 2025 20:39:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx34-0000xN-V2
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:22 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx33-0003bL-5D
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:22 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-21669fd5c7cso112548345ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114760; x=1738719560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HYl4PCTFZMV0eYLHMXpsl9mxtIOIi9P6hK3LvJJsFQ8=;
 b=Vztsb0sfpaA1e+hIGwBC4c4OJATh2qmGOJkxdgk/+glzzasorDrGPGWG5syVKUxs0k
 hkS4ZVyHD8g91rOm4vtFgoarOOLaokcJ5ydnmF/q4eaMbiWTplEm/TNjBg26ppf+CCLb
 zLNbrW5CPRuaKeuppaRUmBzacwX7fROeIRcgGHmj1IDffLaLTbq2T4jNtb+EITkU5sDO
 A1rvPMTruCAwdCO9CvzuaZKAOMWBeREs+cyh63H/7uw/qoedt8eb6JrLd8HT5cdeov3l
 T0/QqxE0reuaGerTk0Ux564ZnbxWwd3jQKhiOZ1wmxc0NGpI7jviNvy1pZ21+U7W0Qbf
 WOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114760; x=1738719560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=HYl4PCTFZMV0eYLHMXpsl9mxtIOIi9P6hK3LvJJsFQ8=;
 b=eLh2bTOlZHS3kLPNdzP6PWWf1gJVGqvR14HnUXXuYlr00a2mp0UI8pd3o/DMARZ1/E
 a0QM4j0lN8qd/14KWasby2hBovQ/OpzQniqw+2fPF+Hrg4x4YZztIzwIjoLGkJCTSmh8
 /6KLyrgrs6Js8OF7SSwYSTditF0GUNZJEvgyQ7F2RGkeWW6rWnFKE1qI/xQOAfthkcta
 9bPIkMs+eA9WZBCdvaqh0BcDC+VTRh004T0YCztV6rC+EF8e+eQ1AD36n9aA0LXexM7f
 N4hS45FBI7Tyh5HF6ZhLhnG8xDwHOmzbbPw2oQ6IiRJdky4xpekWWMB1cwZOGQheF+Iw
 ULTQ==
X-Gm-Message-State: AOJu0YwWttD8UpXKAmMrkJHzIdrlJs/mqGYhvK4NKmEMYLoSO5yZXgpR
 hGIohUBTS4rtgvwH+C5S5rfosqfvWlsuBdR7a5bZCd5zhSsIwScWsc3zqFjICP6gFrZNKjHW+cF
 K
X-Gm-Gg: ASbGncsiosTgVWZ/L8YOdkEEp1ccDIGz0WSsaII8RTEQL6HeZi5jfEwze5L6PpkXB9p
 tQ3Oksiv/Z0F4LKMxMpUeE7+TXmcVyx22qB4gD20tfLoxrNJswU31jVRwcvDgHTdHg8dzxANdLk
 kgzZ6zocXLUkBGKtgozMgYixjKKYTSNtTJSNceJuMErqASi+sWZ1LXTFxvY41ZpxxWUzCYz5iLv
 +SnCdPH36mpaHG94XdpVttJ+OknpctTVUnfjiCeRowlZqe9fEhGAAMZOzhND4RKW5eu9WtAt27W
 L+EExp2Aj8evu+GtwdsH7ntzoqqHFaaWwJAOKzRWgP/aEwDbEw==
X-Google-Smtp-Source: AGHT+IHE7+Sgjq3k6s5TvGGTonU4ukpF/BjSxEmU4iJ/MMHjPGkV6yXPRVlgRktHgGgjspEbXsWhBA==
X-Received: by 2002:a17:902:d54d:b0:215:e98c:c5b5 with SMTP id
 d9443c01a7336-21dd7c356d3mr23463675ad.1.1738114759883; 
 Tue, 28 Jan 2025 17:39:19 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:19 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 31/34] target/arm: Handle FPCR.AH in sve2_fmlal_zzxw_s
Date: Tue, 28 Jan 2025 17:38:54 -0800
Message-ID: <20250129013857.135256-32-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
 target/arm/tcg/vec_helper.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 9b14885ef2..c716bd774a 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2252,23 +2252,32 @@ void HELPER(sve2_fmlal_zzxw_s)(void *vd, void *vn, void *vm, void *va,
                                CPUARMState *env, uint32_t desc)
 {
     intptr_t i, j, oprsz = simd_oprsz(desc);
-    uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
     intptr_t idx = extract32(desc, SIMD_DATA_SHIFT + 2, 3) * sizeof(float16);
     float_status *status = &env->vfp.fp_status[FPST_A64];
     bool fz16 = get_flush_inputs_to_zero(&env->vfp.fp_status[FPST_A64_F16]);
+    int negx = 0, negf = 0;
+
+    if (is_s) {
+        if (env->vfp.fpcr & FPCR_AH) {
+            negf = float_muladd_negate_product;
+        } else {
+            negx = 0x8000;
+        }
+    }
 
     for (i = 0; i < oprsz; i += 16) {
         float16 mm_16 = *(float16 *)(vm + i + idx);
         float32 mm = float16_to_float32_by_bits(mm_16, fz16);
 
         for (j = 0; j < 16; j += sizeof(float32)) {
-            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel)) ^ negn;
+            float16 nn_16 = *(float16 *)(vn + H1_2(i + j + sel)) ^ negx;
             float32 nn = float16_to_float32_by_bits(nn_16, fz16);
             float32 aa = *(float32 *)(va + H1_4(i + j));
 
             *(float32 *)(vd + H1_4(i + j)) =
-                float32_muladd(nn, mm, aa, 0, status);
+                float32_muladd(nn, mm, aa, negf, status);
         }
     }
 }
-- 
2.43.0


