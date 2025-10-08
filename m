Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EB5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 22:11:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6c9m-00048q-9N; Wed, 08 Oct 2025 17:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c9l-00048D-Du
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:09 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6c97-0006fk-52
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:57:08 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b5579235200so154665a12.3
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:56:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759960586; x=1760565386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzsy8UIkvSbR8Kg1jCRAVhHmlPSWiDpdwP0nL6me4gI=;
 b=vNnKFEs/XFa1BXNuJremp2iymNnqSE5DPc+O+oF0284JhYg4K5ilnayZFStfEAJp4j
 EYiG2woceYfRsZQXKFaXFuK6RfWbCKZ3ujeZpb2hP8hEug6eM/GhzKRGRzpIppCG3qYw
 AMJsAoCpttpdbVbR8I0Kz2oK4YcmBAoEa1oNB/QAC1T+Ia+feHdwx6+04edHgAo3RuwZ
 idio0IBAAToHXV4bRSa9+tb/6SN3YY4UVi0BmOdBxn5D/fK4TEqcUVmjNZMGf7tRHnll
 Hz2d3HOnWhfiYr7g/8xbWYh7NvU4ouQSOiqdrrR3tbxpptglZscUhy+wIp1YIl8P97eZ
 jzVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759960586; x=1760565386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qzsy8UIkvSbR8Kg1jCRAVhHmlPSWiDpdwP0nL6me4gI=;
 b=DcWd56/YXHnRyEziGHhazqy+rLPU1kbiUMN8BtsYPbyAU1AL6c5LZamcDbmA0RzEIv
 af9gyuSjyNdTgHgjfg9GAm+K+1fnB4Z71vsmVO3w5eM3ESmsnWVm2R5Ee/cVc1Q4Y686
 1RLRncJPHCPHjfL2MiGGuD1rvEmnP5WoirJWy5Q2Hj6FeeJkdoxAjH3Uu9fJZWrN7RJy
 ie5TRGASBe4vj5o8a4yFzjuCwLtkyB5P0nMdH1DTlNYXKaFCrr6rONn1za2K9r4Xpey0
 tWJbm5ylXcu+pGZxs9O5iZayhsInPcgnU8KTxeqQrfMgvFsVEeATIKk5e06Qz7bkDHYf
 eiow==
X-Gm-Message-State: AOJu0YxjBgrdRd2takdqfUummrR/VWs18jSVeG3yEQox+ky4dmFPs27m
 WvQBQD+T7+X5BbXPAD4jhItbyG7gElL2yXG2BCp1koA/+dr0jAyLYDbep0X3zgr/nlSYZDFifUd
 +q58X/AE=
X-Gm-Gg: ASbGncvdZqg+3pe12tug1kOKao+ZHWzkjL7JdmQC8YlYGuIxP/whYaqFS6riLjiihCN
 dM5V98zqC9wNHnsmBDr13zLuSbvZodQcZ/I3sXC6AowpkYtGTVZobPUElfeBgcjODZ/1KGqblx/
 KaXrJbFn9vfB59tujEmHD6pOnBs4b7MRxbXgcbhvdaEV8D+UY1QiRNbmaoLIka2k0spmvcwXx+N
 xhSuYAajQVbDic8T6s2cT5+kF74xn/AFZZ+aoMM8OO8LdpyTAg7YNG6bQizrpeNQZnwCKP8qtBP
 v9B2luBBYWigX6rWpGswk76SMSFQ+P5rz82H68y62pk9hs/U9jslJf2WCD4G5N3tid3O+49x3J9
 vEVrLLbecSwnN59KfPhyTimLw55tEgx4wnxPq7KhZjJ/WXY3eFyBbHgqE
X-Google-Smtp-Source: AGHT+IEwlHX/8EnLdH4c85UaTvP52ALAyNoUvPA/bnHog84SQcD00uS4SICW3vp5tcTLSG2f10GJzQ==
X-Received: by 2002:a17:902:e788:b0:286:456f:8c8a with SMTP id
 d9443c01a7336-290272dfad8mr61813815ad.50.1759960586067; 
 Wed, 08 Oct 2025 14:56:26 -0700 (PDT)
Received: from stoup.. ([71.212.157.132]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29034e44ef9sm7354285ad.52.2025.10.08.14.56.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:56:25 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v7 17/73] target/arm: Convert arm_mmu_idx_to_el from switch to
 table
Date: Wed,  8 Oct 2025 14:55:17 -0700
Message-ID: <20251008215613.300150-18-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008215613.300150-1-richard.henderson@linaro.org>
References: <20251008215613.300150-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

In an effort to keep all ARMMMUIdx data in one place, begin construction
of an info table describing all of the properties of the mmu_idx.  Begin
with the access EL.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/internals.h       |  3 +--
 target/arm/mmuidx-internal.h | 29 +++++++++++++++++++++++++
 target/arm/helper.c          | 27 ------------------------
 target/arm/mmuidx.c          | 41 ++++++++++++++++++++++++++++++++++++
 target/arm/meson.build       |  7 +++++-
 5 files changed, 77 insertions(+), 30 deletions(-)
 create mode 100644 target/arm/mmuidx-internal.h
 create mode 100644 target/arm/mmuidx.c

diff --git a/target/arm/internals.h b/target/arm/internals.h
index 69eb1df617..1a234d41c2 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -34,6 +34,7 @@
 #include "system/memory.h"
 #include "syndrome.h"
 #include "cpu-features.h"
+#include "mmuidx-internal.h"
 
 /* register banks for CPU modes */
 #define BANK_USRSYS 0
@@ -984,8 +985,6 @@ static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
     return mmu_idx | ARM_MMU_IDX_A;
 }
 
-int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx);
-
 /* Return the MMU index for a v7M CPU in the specified security state */
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate);
 
diff --git a/target/arm/mmuidx-internal.h b/target/arm/mmuidx-internal.h
new file mode 100644
index 0000000000..29bba4ecb5
--- /dev/null
+++ b/target/arm/mmuidx-internal.h
@@ -0,0 +1,29 @@
+/*
+ * QEMU Arm software mmu index internal definitions
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef TARGET_ARM_MMUIDX_INTERNAL_H
+#define TARGET_ARM_MMUIDX_INTERNAL_H
+
+#include "mmuidx.h"
+#include "tcg/debug-assert.h"
+#include "hw/registerfields.h"
+
+
+FIELD(MMUIDXINFO, EL, 0, 2)
+FIELD(MMUIDXINFO, ELVALID, 2, 1)
+
+extern const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8];
+
+#define arm_mmuidx_is_valid(x)  ((unsigned)(x) < ARRAY_SIZE(arm_mmuidx_table))
+
+/* Return the exception level associated with this mmu index. */
+static inline int arm_mmu_idx_to_el(ARMMMUIdx idx)
+{
+    tcg_debug_assert(arm_mmuidx_is_valid(idx));
+    tcg_debug_assert(FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, ELVALID));
+    return FIELD_EX32(arm_mmuidx_table[idx], MMUIDXINFO, EL);
+}
+
+#endif /* TARGET_ARM_MMUIDX_INTERNAL_H */
diff --git a/target/arm/helper.c b/target/arm/helper.c
index bd5321348a..b1d68da133 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9653,33 +9653,6 @@ int fp_exception_el(CPUARMState *env, int cur_el)
     return 0;
 }
 
-/* Return the exception level we're running at if this is our mmu_idx */
-int arm_mmu_idx_to_el(ARMMMUIdx mmu_idx)
-{
-    if (mmu_idx & ARM_MMU_IDX_M) {
-        return mmu_idx & ARM_MMU_IDX_M_PRIV;
-    }
-
-    switch (mmu_idx) {
-    case ARMMMUIdx_E10_0:
-    case ARMMMUIdx_E20_0:
-    case ARMMMUIdx_E30_0:
-        return 0;
-    case ARMMMUIdx_E10_1:
-    case ARMMMUIdx_E10_1_PAN:
-        return 1;
-    case ARMMMUIdx_E2:
-    case ARMMMUIdx_E20_2:
-    case ARMMMUIdx_E20_2_PAN:
-        return 2;
-    case ARMMMUIdx_E3:
-    case ARMMMUIdx_E30_3_PAN:
-        return 3;
-    default:
-        g_assert_not_reached();
-    }
-}
-
 #ifndef CONFIG_TCG
 ARMMMUIdx arm_v7m_mmu_idx_for_secstate(CPUARMState *env, bool secstate)
 {
diff --git a/target/arm/mmuidx.c b/target/arm/mmuidx.c
new file mode 100644
index 0000000000..309b1d68df
--- /dev/null
+++ b/target/arm/mmuidx.c
@@ -0,0 +1,41 @@
+/*
+ * QEMU Arm software mmu index definitions
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "mmuidx-internal.h"
+
+
+#define EL(X)  ((X << R_MMUIDXINFO_EL_SHIFT) | R_MMUIDXINFO_ELVALID_MASK)
+
+const uint32_t arm_mmuidx_table[ARM_MMU_IDX_M + 8] = {
+    /*
+     * A-profile.
+     */
+    [ARMMMUIdx_E10_0]           = EL(0),
+    [ARMMMUIdx_E10_1]           = EL(1),
+    [ARMMMUIdx_E10_1_PAN]       = EL(1),
+
+    [ARMMMUIdx_E20_0]           = EL(0),
+    [ARMMMUIdx_E20_2]           = EL(2),
+    [ARMMMUIdx_E20_2_PAN]       = EL(2),
+
+    [ARMMMUIdx_E2]              = EL(2),
+
+    [ARMMMUIdx_E3]              = EL(3),
+    [ARMMMUIdx_E30_0]           = EL(0),
+    [ARMMMUIdx_E30_3_PAN]       = EL(3),
+
+    /*
+     * M-profile.
+     */
+    [ARMMMUIdx_MUser]           = EL(0),
+    [ARMMMUIdx_MPriv]           = EL(1),
+    [ARMMMUIdx_MUserNegPri]     = EL(0),
+    [ARMMMUIdx_MPrivNegPri]     = EL(1),
+    [ARMMMUIdx_MSUser]          = EL(0),
+    [ARMMMUIdx_MSPriv]          = EL(1),
+    [ARMMMUIdx_MSUserNegPri]    = EL(0),
+    [ARMMMUIdx_MSPrivNegPri]    = EL(1),
+};
diff --git a/target/arm/meson.build b/target/arm/meson.build
index 638ee62525..f9f0beef05 100644
--- a/target/arm/meson.build
+++ b/target/arm/meson.build
@@ -6,7 +6,12 @@ arm_ss.add(files(
 
 arm_ss.add(when: 'TARGET_AARCH64', if_true: files(
   'cpu64.c',
-  'gdbstub64.c'))
+  'gdbstub64.c'
+))
+
+arm_common_ss.add(files(
+  'mmuidx.c',
+))
 
 arm_system_ss = ss.source_set()
 arm_common_system_ss = ss.source_set()
-- 
2.43.0


