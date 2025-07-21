Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC770C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 13:28:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udqYs-00076B-46; Mon, 21 Jul 2025 09:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYO-0000on-2L
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:43 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1udqYL-0005LL-H8
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 09:27:39 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3ab112dea41so2543102f8f.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 06:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753104455; x=1753709255; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=EEVcSDg3gALoDZbpqHs85N5oeeT+sebr+UPZ9srLl5s=;
 b=Lplb+pgu5vvLOvdXOuhvt1NMQlaWVU/IXLbbGNGxZcO9ejV6N/LJwm38WUN4n5izpn
 EnnPhO9S67NxwfOOLY0P5PPbf9tXo5HS1gFI+iQ8B+0syVRrAG8eg+Ww8C/j3N2HVn1t
 TI2H4oAdObvUHt7BK8/XtRQI0N5RKMn3nt5iTbwhmE23RH/MYWTDBZspHpq5ars5PXOn
 jr9wcONuBk8LLr7UCkS7LJljAgktZ4gmCNhezfBPYkiHFCfTT9Pd6Epirf+7hFwjsSU9
 CCa9KVL9JgrpVRxAyT63sMtWq9esZlQlJaQsoZ2pIXDM1ilcKbqihhJd4zN3QNaBp8CA
 czjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753104455; x=1753709255;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EEVcSDg3gALoDZbpqHs85N5oeeT+sebr+UPZ9srLl5s=;
 b=M0aC5hVpdWog6hyJHPXUMi20AxIRfmXhlMgt3uitTv5Qe2eZCWFcwANc6Jrffg5KAM
 3XyVry2xtEBxX4GN5Bqv7zkMxEWmPEMrZe7KogIiBNr0n3FNtKcGiuY6yoIhQ+Ml5pwb
 Y2lqxNYBKstqVA99+nNEVntx3+MMd/kEs/EQGOCyIrCTLWjWOLQuIjyllY7/cS3FOmJU
 HrUd1n0smeEgjrKxlqX8rNQ+A8aL9fWX3KIQ84JVI3EhlvZC/97vkaLfv2qHOWQ9nn8G
 5I1bmij8uC9uMgvfgBHkkPVixe6mQLsFLC4vgSK4Kxe/Cmw2TEy6sihiGe2b+l24sPHB
 Rcuw==
X-Gm-Message-State: AOJu0Yy9n1Ruci8gGeMoFpwLSI+v8SpWUhl3vMCwP57UW2AQZyZm4oqt
 srnfqaNXQOoQLcRp64RvEwos/UnFJcFo/GhAthdaiHaKHDcsKbMtx/N0V2XvKl5mOS2HlY0+Kvm
 lUy2J
X-Gm-Gg: ASbGncugTEBF58AXill5GSgrx8GGC4OiKmRHUAlnGPG44/Jsj30QCcUMCPShmmt8PZW
 wT9bU76DsZzs1E01VUb5j3VQqGRulZg9tbJ/D1AtOvgeov6BS8YAVvw/Yf9eyFqA5roe3oi2YiO
 I15GlQqDtpvHEN5zY2kdz85KnMWPTHOHKBjQ4U9XF4BrAjis+i0OrHjQvu3PMwvBfjYLwEYIOPF
 Pm4hjtPznKdnbvonvHCl9JaL0oUCxO7d5h3hamHxmc2paOngHNec9vjirdTawAkrOvuq2eywTLi
 HNRQG5INbJhjliFnpY6ZtFAAeI3/3fwRRpqJZHEJhM7MteVaMrmLVXSQvBX8sxc7+f9e086eW5Q
 ZJiGmb47HveuGQATLK/qXldl+TG57
X-Google-Smtp-Source: AGHT+IGCzeCery40cNPRmpfTPcfHSD/FuOFIHkmpBNvHpXJ2rayez9JcA8c1T3JspIlsnUNO6BIL5A==
X-Received: by 2002:a5d:64e8:0:b0:3a0:7d27:f076 with SMTP id
 ffacd0b85a97d-3b60dd651d2mr15633219f8f.2.1753104454942; 
 Mon, 21 Jul 2025 06:27:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4c754sm10487946f8f.59.2025.07.21.06.27.34
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Jul 2025 06:27:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 16/20] target/arm: Honour FPCR.AH=1 default NaN value in
 FMAXNMQV, FMINNMQV
Date: Mon, 21 Jul 2025 14:27:13 +0100
Message-ID: <20250721132718.2835729-17-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721132718.2835729-1-peter.maydell@linaro.org>
References: <20250721132718.2835729-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42d.google.com
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

The FMAXNMQV and FMINNMQV insns use the default NaN as their identity
value for inactive source vector elements. We open-coded this in
sve_helper.c, hoping to avoid a function call. However, this fails
to account for FPCR.AH=1 changing the default NaN value to set the
sign bit. Use a call to floatN_default_nan() to obtain this value.

Fixes: 1de7ecfc12d05 ("target/arm: Implement FADDQV, F{MIN, MAX}{NM}QV for SVE2p1")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20250718173032.2498900-10-peter.maydell@linaro.org
---
 target/arm/tcg/sve_helper.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/target/arm/tcg/sve_helper.c b/target/arm/tcg/sve_helper.c
index bf894f0bf13..803f0a094dc 100644
--- a/target/arm/tcg/sve_helper.c
+++ b/target/arm/tcg/sve_helper.c
@@ -4484,33 +4484,35 @@ static TYPE FUNC##_reduce(TYPE *data, float_status *status, uintptr_t n) \
     }                                                                 \
 }                                                                     \
 uint64_t helper_sve_##NAME##v_##SUF(void *vn, void *vg,               \
-                                    float_status *s, uint32_t desc)   \
+                                    float_status *status, uint32_t desc) \
 {                                                                     \
     uintptr_t i, oprsz = simd_oprsz(desc), maxsz = simd_data(desc);   \
     TYPE data[sizeof(ARMVectorReg) / sizeof(TYPE)];                   \
+    TYPE ident = IDENT;                                               \
     for (i = 0; i < oprsz; ) {                                        \
         uint16_t pg = *(uint16_t *)(vg + H1_2(i >> 3));               \
         do {                                                          \
             TYPE nn = *(TYPE *)(vn + H(i));                           \
-            *(TYPE *)((void *)data + i) = (pg & 1 ? nn : IDENT);      \
+            *(TYPE *)((void *)data + i) = (pg & 1 ? nn : ident);      \
             i += sizeof(TYPE), pg >>= sizeof(TYPE);                   \
         } while (i & 15);                                             \
     }                                                                 \
     for (; i < maxsz; i += sizeof(TYPE)) {                            \
-        *(TYPE *)((void *)data + i) = IDENT;                          \
+        *(TYPE *)((void *)data + i) = ident;                          \
     }                                                                 \
-    return FUNC##_reduce(data, s, maxsz / sizeof(TYPE));              \
+    return FUNC##_reduce(data, status, maxsz / sizeof(TYPE));         \
 }                                                                     \
 void helper_sve2p1_##NAME##qv_##SUF(void *vd, void *vn, void *vg,     \
                                     float_status *status, uint32_t desc) \
 {                                                                     \
     unsigned oprsz = simd_oprsz(desc), segments = oprsz / 16;         \
+    TYPE ident = IDENT;                                               \
     for (unsigned e = 0; e < 16; e += sizeof(TYPE)) {                 \
         TYPE data[ARM_MAX_VQ];                                        \
         for (unsigned s = 0; s < segments; s++) {                     \
             uint16_t pg = *(uint16_t *)(vg + H1_2(s * 2));            \
             TYPE nn = *(TYPE *)(vn + (s * 16 + H(e)));                \
-            data[s] = (pg >> e) & 1 ? nn : IDENT;                     \
+            data[s] = (pg >> e) & 1 ? nn : ident;                     \
         }                                                             \
         *(TYPE *)(vd + H(e)) = FUNC##_reduce(data, status, segments); \
     }                                                                 \
@@ -4521,14 +4523,17 @@ DO_REDUCE(fadd,h, float16, H1_2, float16_add, float16_zero)
 DO_REDUCE(fadd,s, float32, H1_4, float32_add, float32_zero)
 DO_REDUCE(fadd,d, float64, H1_8, float64_add, float64_zero)
 
-/* Identity is floatN_default_nan, without the function call.  */
-DO_REDUCE(fminnm,h, float16, H1_2, float16_minnum, 0x7E00)
-DO_REDUCE(fminnm,s, float32, H1_4, float32_minnum, 0x7FC00000)
-DO_REDUCE(fminnm,d, float64, H1_8, float64_minnum, 0x7FF8000000000000ULL)
+/*
+ * We can't avoid the function call for the default NaN value, because
+ * it changes when FPCR.AH is set.
+ */
+DO_REDUCE(fminnm,h, float16, H1_2, float16_minnum, float16_default_nan(status))
+DO_REDUCE(fminnm,s, float32, H1_4, float32_minnum, float32_default_nan(status))
+DO_REDUCE(fminnm,d, float64, H1_8, float64_minnum, float64_default_nan(status))
 
-DO_REDUCE(fmaxnm,h, float16, H1_2, float16_maxnum, 0x7E00)
-DO_REDUCE(fmaxnm,s, float32, H1_4, float32_maxnum, 0x7FC00000)
-DO_REDUCE(fmaxnm,d, float64, H1_8, float64_maxnum, 0x7FF8000000000000ULL)
+DO_REDUCE(fmaxnm,h, float16, H1_2, float16_maxnum, float16_default_nan(status))
+DO_REDUCE(fmaxnm,s, float32, H1_4, float32_maxnum, float32_default_nan(status))
+DO_REDUCE(fmaxnm,d, float64, H1_8, float64_maxnum, float64_default_nan(status))
 
 DO_REDUCE(fmin,h, float16, H1_2, float16_min, float16_infinity)
 DO_REDUCE(fmin,s, float32, H1_4, float32_min, float32_infinity)
-- 
2.43.0


