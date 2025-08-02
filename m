Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA110C87FC9
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Aug 2025 23:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uiLlR-0000qv-DR; Sat, 02 Aug 2025 19:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLid-0001vS-Ns
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:52 -0400
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uiLib-0005G9-SJ
 for qemu-devel@nongnu.org; Sat, 02 Aug 2025 19:32:51 -0400
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-741a6272c8fso140929a34.3
 for <qemu-devel@nongnu.org>; Sat, 02 Aug 2025 16:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754177569; x=1754782369; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nK/orVpSsRC7EeosV5+++ApHwhVQ4D3Ng52cDHWLf6A=;
 b=oWwU4vX5SzeQwuyv8wi8rfzh/UDilIWoQtDGLgW9EgRgP/Q9wlrRswu6YATXBs1tsb
 CLs7guQUG7t3KSoeWog6yz9K5yu12I6ALqzRYaxYkgnvRrXpcepi+Go5AAaLAMTFk40q
 aB3a7ACw1rAwC3kbarNTNKB4U5INCa7ruNRwMBJWVaxeBkSGx3bBd2H+Edy+Od5VfSt0
 JDkMYVAySiWv9ZqWFkbcGZz63TfSJRRLfqGMjWlwmIEk2IMfgjj+BkxV7PnMxhonJ9Fy
 hSL1lQJSj4VQBEx6iDhn1dm70uQt89SZyLB86UVCq0EE0W2ZNkeCFGHx+LGmEEsKmyvX
 GsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754177569; x=1754782369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nK/orVpSsRC7EeosV5+++ApHwhVQ4D3Ng52cDHWLf6A=;
 b=DWb0+C/b/rOy0WjnHW/4zsbE6vfFPt4swbUUzmz+K8rII2657OPqEg8jAqY5X1H1aw
 LqFbS569EYNSVTqEQkbVbJmlBKA1/XSVBmfmLolYzq8kF0grm1mzSw2cdHpwu6ud2Bj5
 ykTBZvZ4qEo0zBjI8wp9rIJjh7uNNRTTFxGfttjRuvtNMX6qJSi8cd8cYKA66AW/5K/E
 TQwbQFO3CLbgF5pNzXsCEx5u2ocoeOLQxqmrxXTLkHAZ6BLe82gu0uanqeFt/EBiWgG5
 e7ASkRaiPRFW1HEc2skWgpR9Pjdzpua0x/FGEBUDYAlTBvEzcWfV9PLKLbT69G/Ayek/
 O5Gw==
X-Gm-Message-State: AOJu0YyGNLNyHc1WLDe0ZEAgavP3Kz8sbNiqgIYu6XWd/tvBSk3+rXO7
 D2OwOkPFm+pdK3azmRs5D2e2k/CEkT/VLCiFLx9/QWNctMtUdSBq5FbPG7eM6f8EV3PFzkve3ip
 0Y33KipI=
X-Gm-Gg: ASbGnctLmBM/3Yxm/MqCbNPOFA3PDP4hhx561CzvkKUHNw3qw6khiJp7ylV1xGvKG2r
 Buu8zSf7FtIm5F+1qIUukqhk4ZY21Vp8mQdOMxjJe3syQmvzTuW4nNjrbk/feGzlkTHaqnCJ0Un
 bPVs+BVi1GEPLXD2+oeGbaPe3UpM8KQfjC8hGTw5u7xybZj5CKm5nRm7CDzEytXEQsGe6IMLyKi
 7gwKatcQnTWB47NONG5Nzo85x6ykm8giiKWETlDIJJYI9mRWQbLYdQIkLU3uyQKohPRp8/HRknF
 BTgdY0f0gyk8vcl3kb9NpPywjjL8JrPcJx6yqoQQvjkfVYgJyeBdIYPan4lwG96Gg2nS7dotgq8
 nWFiDk/0uhxNl5fo1pcrnDbc6WIoikGifRDHUWyUL21A3+ffpgDKm
X-Google-Smtp-Source: AGHT+IFX76f0aSyMvDRAlSIoQP8JPAR9tzVIC1cs8Whme00eEYgKP5mNKaOExbq+2Et+/DuOnkkC3A==
X-Received: by 2002:a05:6871:708:b0:2f7:840d:fe9 with SMTP id
 586e51a60fabf-30b6780dbf1mr2619969fac.22.1754177568612; 
 Sat, 02 Aug 2025 16:32:48 -0700 (PDT)
Received: from stoup.. ([172.58.111.133]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-30b8e3c9b32sm71031fac.24.2025.08.02.16.32.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 16:32:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
	Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v2 35/85] target/arm: Convert regime_el from switch to table
Date: Sun,  3 Aug 2025 09:29:03 +1000
Message-ID: <20250802232953.413294-36-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250802232953.413294-1-richard.henderson@linaro.org>
References: <20250802232953.413294-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32a.google.com
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
 target/arm/internals.h       | 35 ----------------------------
 target/arm/mmuidx-internal.h | 13 +++++++++++
 target/arm/mmuidx.c          | 44 +++++++++++++++++++++---------------
 3 files changed, 39 insertions(+), 53 deletions(-)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 4991d6ab7f..3b730a5d81 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -1075,41 +1075,6 @@ static inline bool regime_is_stage2(ARMMMUIdx mmu_idx)
     return mmu_idx == ARMMMUIdx_Stage2 || mmu_idx == ARMMMUIdx_Stage2_S;
 }
 
-/* Return the exception level which controls this address translation regime */
-static inline uint32_t regime_el(ARMMMUIdx mmu_idx)
-{
-    switch (mmu_idx) {
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-    case ARMMMUIdx_Stage2:
-    case ARMMMUIdx_Stage2_S:
-    case ARMMMUIdx_E2:
-        return 2;
-    case ARMMMUIdx_E3:
-    case ARMMMUIdx_E30_0:
-    case ARMMMUIdx_E30_3_PAN:
-        return 3;
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_Stage1_E0:
-    case ARMMMUIdx_Stage1_E1:
-    case ARMMMUIdx_Stage1_E1_PAN:
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-    case ARMMMUIdx_MPrivNegPri:
-    case ARMMMUIdx_MUserNegPri:
-    case ARMMMUIdx_MPriv:
-    case ARMMMUIdx_MUser:
-    case ARMMMUIdx_MSPrivNegPri:
-    case ARMMMUIdx_MSUserNegPri:
-    case ARMMMUIdx_MSPriv:
-    case ARMMMUIdx_MSUser:
-        return 1;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 static inline bool regime_is_user(CPUARMState *env, ARMMMUIdx mmu_idx)
 {
     switch (mmu_idx) {
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
index 29bba4ecb5..d8d64a14d6 100644
--- a/target/arm/mmuidx-internal.h
+++ b/target/arm/mmuidx-internal.h
@@ -13,6 +13,8 @@
 
 FIELD(MMUIDXINFO, EL, 0, 2)
 FIELD(MMUIDXINFO, ELVALID, 2, 1)
+FIELD(MMUIDXINFO, REL, 3, 2)
+FIELD(MMUIDXINFO, RELVALID, 5, 1)
 
 extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
 
@@ -26,4 +28,15 @@ static inline int arm_mmu_idx_to_el(ARMMMUIdx idx)
     return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, EL);
 }
 
+/*
+ * Return the exception level for the address translation regime
+ * associated with this mmu index.
+ */
+static inline uint32_t regime_el(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    tcg_debug_assert(FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, RELVALID));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, REL);
+}
+
 #endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
index 309b1d68df..6dfefa56c2 100644
--- a/target/arm/mmuidx.c
+++ b/target/arm/mmuidx.c
@@ -8,34 +8,42 @@
 
 
 #define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
+#define REL(X) ((X << R_MMUIDXINFO_REL_SHIFT) | R_MMUIDXINFO_RELVALID_MASK)
 
 const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
     /*
      * A-profile.
      */
-    [ARMMMUIdx_E10_0]           = EL(0),
-    [ARMMMUIdx_E10_1]           = EL(1),
-    [ARMMMUIdx_E10_1_PAN]       = EL(1),
+    [ARMMMUIdx_E10_0]           = EL(0) | REL(1),
+    [ARMMMUIdx_E10_1]           = EL(1) | REL(1),
+    [ARMMMUIdx_E10_1_PAN]       = EL(1) | REL(1),
 
-    [ARMMMUIdx_E20_0]           = EL(0),
-    [ARMMMUIdx_E20_2]           = EL(2),
-    [ARMMMUIdx_E20_2_PAN]       = EL(2),
+    [ARMMMUIdx_E20_0]           = EL(0) | REL(2),
+    [ARMMMUIdx_E20_2]           = EL(2) | REL(2),
+    [ARMMMUIdx_E20_2_PAN]       = EL(2) | REL(2),
 
-    [ARMMMUIdx_E2]              = EL(2),
+    [ARMMMUIdx_E2]              = EL(2) | REL(2),
 
-    [ARMMMUIdx_E3]              = EL(3),
-    [ARMMMUIdx_E30_0]           = EL(0),
-    [ARMMMUIdx_E30_3_PAN]       = EL(3),
+    [ARMMMUIdx_E3]              = EL(3) | REL(3),
+    [ARMMMUIdx_E30_0]           = EL(0) | REL(3),
+    [ARMMMUIdx_E30_3_PAN]       = EL(3) | REL(3),
+
+    [ARMMMUIdx_Stage2_S]        = REL(2),
+    [ARMMMUIdx_Stage2]          = REL(2),
+
+    [ARMMMUIdx_Stage1_E0]       = REL(1),
+    [ARMMMUIdx_Stage1_E1]       = REL(1),
+    [ARMMMUIdx_Stage1_E1_PAN]   = REL(1),
 
     /*
      * M-profile.
      */
-    [ARMMMUIdx_MUser]           = EL(0),
-    [ARMMMUIdx_MPriv]           = EL(1),
-    [ARMMMUIdx_MUserNegPri]     = EL(0),
-    [ARMMMUIdx_MPrivNegPri]     = EL(1),
-    [ARMMMUIdx_MSUser]          = EL(0),
-    [ARMMMUIdx_MSPriv]          = EL(1),
-    [ARMMMUIdx_MSUserNegPri]    = EL(0),
-    [ARMMMUIdx_MSPrivNegPri]    = EL(1),
+    [ARMMMUIdx_MUser]           = EL(0) | REL(1),
+    [ARMMMUIdx_MPriv]           = EL(1) | REL(1),
+    [ARMMMUIdx_MUserNegPri]     = EL(0) | REL(1),
+    [ARMMMUIdx_MPrivNegPri]     = EL(1) | REL(1),
+    [ARMMMUIdx_MSUser]          = EL(0) | REL(1),
+    [ARMMMUIdx_MSPriv]          = EL(1) | REL(1),
+    [ARMMMUIdx_MSUserNegPri]    = EL(0) | REL(1),
+    [ARMMMUIdx_MSPrivNegPri]    = EL(1) | REL(1),
 };
-- 
2.43.0


