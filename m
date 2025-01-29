Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3395EC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:42:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcx36-0000xv-7n; Tue, 28 Jan 2025 20:39:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx35-0000xm-KK
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:23 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tcx34-0003bx-2z
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 20:39:23 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21ddab8800bso242675ad.3
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 17:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738114761; x=1738719561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bPg7XQstbWLd15qpMfyArO4C0fv07hyiVAMvAWNffqs=;
 b=bCrUiXC2e5ZBb30QesZO5eW/oEKGbUGbOj/pj5qZQo+pKFw2XUhtZPACtNhCBS60Qg
 aOzoqvHDSOdNDmN2a31W/oyH9N1SAzEdBD80Lt2L4udn1C+/vChqL5FAnzKFqW26XO7M
 0IbTXqZcUDcf8URozF6ZX4/JGBbbyhX5REk4b43ZdISXP5L588xvgMWI+7LRxGBezF4o
 DFmVhrWh38Iie5Taf07TI5BLpGWY6aOdDC+WHVkfcFhvPKuGXtXvoEgvlZazMr7Wi89u
 upX7+4RYRjOJPnQ2rckrEYOL0WjX9aylJusVEJepivl1ZqEVZUVSrFDQFNNl3P1LUpFe
 e1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114761; x=1738719561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bPg7XQstbWLd15qpMfyArO4C0fv07hyiVAMvAWNffqs=;
 b=f8WNBMUgj3jd/P6zX4XP7mmfYZP0knxf69TdyBik1yoEcNf7h5OWB1u07MB9dJdP6J
 EbIKzoY0o0FEO9Mc/RAEOCzdUsWBdd3cyi7hE2bCipNgwuJOqtCBC/lkjZpeFHT35BF6
 OJnUdnWdSO9pdNqTPjFHoDjfhQXVCj6cd8g3soz4IxQ29Qt87Suw8estfHQaCRecFx+i
 iGm1dI8th7+9tn3XoDXgrtJo+JTZ1SHuc0lu36gSzyDMrHFLcY9qO9mpfXtvqBeUsmQ6
 sxLt/8JEqfmCmKF5BwWx9znTg6VF3iL/tyuw6iPWl27Qd3IOWMWM9JbxlcrFXhE5FCdY
 Xrlg==
X-Gm-Message-State: AOJu0YxIdTEa9Ko2ust4DYAHwH3heDQB1UOS6TRvANBAGSQb73BZLSNt
 Zu+y48fuCrOzR3s8WjsV0cSzweSUXCxhjLVxVdQH1yI1aNjCzNOvR3wUyutQB6yat1K+CjDB/yD
 t
X-Gm-Gg: ASbGnctHUMeELAHdEw/L7X22HblRQ8rMlkfRmSkH90JGvuVL0vOY3p+zhfoKUWLhGoE
 OoZUhhGUaDC9seknovOmyJfJpmjZDkNQdFW93ciA9sPTB0EARFpi7DS6ZuKmzff4A2L+Nv6poIf
 bVO0NOb/T5xRGpHBA9ohIEZfn0ZAe6WfM4hnIhdxpDO3lRZckB6dTbypbMKscwLMRQs3mOq1QTs
 J2hekcWpKJO3rKk28nZ25qMjHyNuEFwC8VYjqr9nQEJL56a8c9NbJIOGoG5w+xP/gaZqxOu9As8
 VYbRUC2qbdkKxy8dGOT9XDIiUyBec4khV5yZ7X8PGFXux+MfEw==
X-Google-Smtp-Source: AGHT+IEAiWeroLeOm9n/7qUie0IsZgrMJx1XGOTs4BvXLhVGmgwDFoOqbplejAQTaCiHMLJwslZIQw==
X-Received: by 2002:a17:903:244b:b0:212:67a5:ab2d with SMTP id
 d9443c01a7336-21dd7df2d21mr20060485ad.44.1738114760702; 
 Tue, 28 Jan 2025 17:39:20 -0800 (PST)
Received: from stoup.. (71-212-32-190.tukw.qwest.net. [71.212.32.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21da3ea4200sm89341745ad.88.2025.01.28.17.39.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 17:39:20 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PATCH v2 32/34] target/arm: Handle FPCR.AH in sve2_fmlal_zzzw_s
Date: Tue, 28 Jan 2025 17:38:55 -0800
Message-ID: <20250129013857.135256-33-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250129013857.135256-1-richard.henderson@linaro.org>
References: <20250129013857.135256-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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
index c716bd774a..bae98a34b8 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2180,19 +2180,28 @@ void HELPER(sve2_fmlal_zzzw_s)(void *vd, void *vn, void *vm, void *va,
                                CPUARMState *env, uint32_t desc)
 {
     intptr_t i, oprsz = simd_oprsz(desc);
-    uint16_t negn = extract32(desc, SIMD_DATA_SHIFT, 1) << 15;
+    bool is_s = extract32(desc, SIMD_DATA_SHIFT, 1);
     intptr_t sel = extract32(desc, SIMD_DATA_SHIFT + 1, 1) * sizeof(float16);
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
 
     for (i = 0; i < oprsz; i += sizeof(float32)) {
-        float16 nn_16 = *(float16 *)(vn + H1_2(i + sel)) ^ negn;
+        float16 nn_16 = *(float16 *)(vn + H1_2(i + sel)) ^ negx;
         float16 mm_16 = *(float16 *)(vm + H1_2(i + sel));
         float32 nn = float16_to_float32_by_bits(nn_16, fz16);
         float32 mm = float16_to_float32_by_bits(mm_16, fz16);
         float32 aa = *(float32 *)(va + H1_4(i));
 
-        *(float32 *)(vd + H1_4(i)) = float32_muladd(nn, mm, aa, 0, status);
+        *(float32 *)(vd + H1_4(i)) = float32_muladd(nn, mm, aa, negf, status);
     }
 }
 
-- 
2.43.0


