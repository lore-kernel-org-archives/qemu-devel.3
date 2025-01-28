Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E17C02192
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2025 20:19:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcry4-0002NL-O2; Tue, 28 Jan 2025 15:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxz-0002GQ-6O
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:47 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcrxx-0001du-Jw
 for qemu-devel@nongnu.org; Tue, 28 Jan 2025 15:13:46 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4361f664af5so69618355e9.1
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2025 12:13:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738095224; x=1738700024; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=semLRmSsuxV3r8VwL0CFwWbavPiGu3FvSOhrMRoqsPQ=;
 b=tzLYoFls0ErMro2aVED8J0xBUhvldwXHH6uv5aGL64z53wMTDZFPugucNoVsuZC6Fk
 kpg21EIkhsmoW17xeTZoV54iIw2a+IP3Tj7Z0FmLf2uVaHFUtZdR4iWlFNs+hCeRYIw1
 cAlxAUpabzPjwfJQWM7A7/gAhidzxHFPi9WIBOWULSU4GTASjwS2584EPhrWM6caGUmk
 /X3ZfFWtCFiRyatvEeWij+uj9ozgDbGjI2h1kdg1SBiqibtxHZbNq2TrbYTARTGAyipM
 E702MlXguY77vOq9Lw6jxaZ42DktSBCKn55dR5jYH/BqACzgmzG7+GgF3wFWqi62dBaw
 5egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738095224; x=1738700024;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=semLRmSsuxV3r8VwL0CFwWbavPiGu3FvSOhrMRoqsPQ=;
 b=BJ9R3we5/YGtMayrIY7IvlNv2c1YIuDJW4MScbXgtR5O8VrR9o1j9XmYrI8SNqJjMZ
 MPB/GmkWaBubquUdabGoxfuWvKGSTdS3Lkc9Q7LpQMMvMYAjd02WgFsLwhItKpbB0x82
 PwtcL/fYEXenJupgVLv0m48xEyhRG7QdCEaiS5aTZGvt/luaoghZJrlV8U4A2b2bcLcH
 fE2IA8SGECcfX6Of8TQMt2pf+vfQl2S7qcLtdhFXe5pMEXjlrRj9WzhdOqayc22TCLpU
 O2sVZc1b5h5phpGgjnQUSIvte1dm+j9ehi74P+utfZOv9MLsrINM1gNg0yPTEhwpcy/A
 L7rA==
X-Gm-Message-State: AOJu0Yy/WQhitxMszsKr+VzxwA9shD/axWM7gzCC6i+LCGXwgSIrpKhe
 Gf0VSNeSrs6al/Y9noPluF1kRTRskevuvFNoEuficxhp9yOTxvtcPQxwWg3hSxaQF44E1Z+DmNe
 7
X-Gm-Gg: ASbGncuqZq4CAj04Ih4yhPC/NWqqPmZ3g0lW9UITMFDVExPQTKK5Qt0akJlSBoaIYwa
 Fn2Bbk1L/GjjHzKdv+fINEKfQ1Sx+WsEDBHvs1qBU88qM6GE6oBUqU+h2CTgEibjpn116ukS+5V
 REaGtAuYm3BT+Nuf5pQNmjZz9wKNHvm9q1hGFQK1xBXcSz+rB1Xjggj9XbPgJuyx+PFqGNROzjI
 9bC4xig3E9v0OshxTAYaOwtb1ATn0BjSRmv+xJkikir52gVeSf/cyV5sduQg0Di/cGvie+hWrwk
 46OoFH26J0MQiit9Ou1zog==
X-Google-Smtp-Source: AGHT+IGQ4jFxI4t7dQgVQmsP9Zgq+0Szli/rgbAV0KAoXutKGFGs2zboDN0ZrOTH63iZhau33VQG3w==
X-Received: by 2002:a05:600c:3149:b0:434:fd15:3adc with SMTP id
 5b1f17b1804b1-438dc424f5emr1887335e9.25.1738095223952; 
 Tue, 28 Jan 2025 12:13:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd4fa3efsm182524105e9.2.2025.01.28.12.13.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2025 12:13:42 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 26/36] target/arm: Use fp_status_f16_a32 in AArch32-only helpers
Date: Tue, 28 Jan 2025 20:13:04 +0000
Message-Id: <20250128201314.44038-27-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128201314.44038-1-peter.maydell@linaro.org>
References: <20250128201314.44038-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

We directly use fp_status_f16 in a handful of helpers that
are AArch32-specific; switch to fp_status_f16_a32 for these.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250124162836.2332150-15-peter.maydell@linaro.org
---
 target/arm/tcg/vec_helper.c | 4 ++--
 target/arm/vfp_helper.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/vec_helper.c b/target/arm/tcg/vec_helper.c
index 2ba1f7cb32e..1b1deda9422 100644
--- a/target/arm/tcg/vec_helper.c
+++ b/target/arm/tcg/vec_helper.c
@@ -2060,7 +2060,7 @@ void HELPER(gvec_fmlal_a32)(void *vd, void *vn, void *vm,
                             CPUARMState *env, uint32_t desc)
 {
     do_fmlal(vd, vn, vm, &env->vfp.standard_fp_status, desc,
-             get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+             get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
 void HELPER(gvec_fmlal_a64)(void *vd, void *vn, void *vm,
@@ -2122,7 +2122,7 @@ void HELPER(gvec_fmlal_idx_a32)(void *vd, void *vn, void *vm,
                                 CPUARMState *env, uint32_t desc)
 {
     do_fmlal_idx(vd, vn, vm, &env->vfp.standard_fp_status, desc,
-                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16));
+                 get_flush_inputs_to_zero(&env->vfp.fp_status_f16_a32));
 }
 
 void HELPER(gvec_fmlal_idx_a64)(void *vd, void *vn, void *vm,
diff --git a/target/arm/vfp_helper.c b/target/arm/vfp_helper.c
index 45f9dfc8861..f3aa80bbfb6 100644
--- a/target/arm/vfp_helper.c
+++ b/target/arm/vfp_helper.c
@@ -380,7 +380,7 @@ void VFP_HELPER(cmpe, P)(ARGTYPE a, ARGTYPE b, CPUARMState *env) \
     softfloat_to_vfp_compare(env, \
         FLOATTYPE ## _compare(a, b, &env->vfp.FPST)); \
 }
-DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16)
+DO_VFP_cmp(h, float16, dh_ctype_f16, fp_status_f16_a32)
 DO_VFP_cmp(s, float32, float32, fp_status_a32)
 DO_VFP_cmp(d, float64, float64, fp_status_a32)
 #undef DO_VFP_cmp
-- 
2.34.1


