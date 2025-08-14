Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CC3ACA0EE4
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 13:08:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umXZN-00041u-S4; Thu, 14 Aug 2025 09:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYm-0002fH-AG
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 09:00:00 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1umXYd-0004R5-AM
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 08:59:57 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-323266b1d1aso559582a91.0
 for <qemu-devel@nongnu.org>; Thu, 14 Aug 2025 05:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755176389; x=1755781189; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EbyUERQdqYPEwnGqMNfJLK0fIa1Qiwxd4WxE3mzFNtc=;
 b=JSxIoEUzv8ZGonhUfBd6NHUemLK2Z5TwPPCeBsb9lu8Z0DhfmtFNuCVypHwBqDp05N
 2X65KyKwL7Y6dE30px6BY1qGhlkS0KkXAWdRyfWM5rYSr+ipsa3wVEIC1425LD3Yi5Ji
 u3xRn3PhnY474MnjlmYHHR6aD2fDLlhUPIJMnC9V723ueB6BFGYVneOtDeSBxPBVgTh0
 3jVetbQsjVmLB7ksZUyTibVxXAUn5Kaw9lF2HDEQw9gv0jIHzBcjgP0YyUrQlKDtB3GR
 Hn2RdgCZMUDveIh5sAwZ7VpVTg9/LeOBpahvZAuHvKCBJydg0v3Ime9Tw0Cc/XxFWvBJ
 aBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755176389; x=1755781189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EbyUERQdqYPEwnGqMNfJLK0fIa1Qiwxd4WxE3mzFNtc=;
 b=riKm7k0b7YHe7/wZQZroAk3OUR3CxlvnKrLvFPhnwslMPVRy42anzVIk94Zjk933CL
 U35qTb10iPefbgIuaWDzMeVWWcHqNJ5z0p2eLflewTQeIKSzi4LTTqcvm0/fBuuyN8VO
 OFYrSXLoTYFSIGa1lr3uXjZEWj3ULQMJ5g965u/RWbqOEVM3S/5Zg/crsOmZAgo1PkRO
 IcpuckWrsNfb1U0FXKeAaqth/TwFvMwbnZXTgQgNGXguL7lwU85yvHnBMtycS5vkaARF
 pDjaExu84CQY2Zke9vP6eTd0Zet2r5/ydFpba46Prt06cdPcF+TnAmUbcXiLk4pk/Jc9
 Hi8g==
X-Gm-Message-State: AOJu0YwgzEjWJtrSR3y8MCPVOVylD9/0VSUcr6ILr9HvnQ+Eo5iJiCee
 Mq0gW5v2MaBNuGfaxK9BsKZPhgv+bnAbbGO28WmJPI1s5EguytynLW6M/EI1Dm/vPDVl+15KsE3
 RHVD9Si8=
X-Gm-Gg: ASbGncuaU+PKjZKn95tNrg5LXqd10TLo8Htv1GIZP8EbJ0Tzuhzdo5tIy3s5SOOhuXk
 3lKRZYYTtqTVAhQdgfCEg4IOiSmwPX2oqhZOPcHoR4826dM5BktpKJav85gsOMneC8+c1vhjIXI
 +/QalaGXFlY6r6kknA706X3XOjuMqnREdGROllsp4OsZ+p//yeCRfjlChvmz+JVTO60Qx7Rc0qh
 1csOkUcOjixoyHjkck9oCUJaLlY+VFW9uAy+7B3s2OJMtrXvROIUURGo42kGlyI6tx/9cM4vF0b
 5Kv+OHCS1Xs4gDFdWv8UCOQXYGL4uT92wUq5om5mZ58MzG6ARkuGt1W7ZS8U+q5IH0kKgBXEnev
 diPLcKDeq2kl/UDiB1gy0QgwrVwg8wpAizwBCCF7olJmce7E=
X-Google-Smtp-Source: AGHT+IFiLuG6/Oe1FbBltvAHS+HmHdriAAvjLDp8GmJWUSvEJDiNOV9W1v/9qRHo5NPCNp//w6BF5A==
X-Received: by 2002:a17:90b:4e8e:b0:31e:6f0a:6a1a with SMTP id
 98e67ed59e1d1-32327a71564mr3865759a91.3.1755176389030; 
 Thu, 14 Aug 2025 05:59:49 -0700 (PDT)
Received: from localhost.localdomain ([206.83.105.236])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3233100c994sm1766256a91.21.2025.08.14.05.59.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 05:59:48 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH v3 33/85] target/arm: Convert arm_mmu_idx_to_el from switch to
 table
Date: Thu, 14 Aug 2025 22:57:00 +1000
Message-ID: <20250814125752.164107-34-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250814125752.164107-1-richard.henderson@linaro.org>
References: <20250814125752.164107-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102c.google.com
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
index b6499683cc..2dc82330ec 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -34,6 +34,7 @@
 #include "system/memory.h"
 #include "syndrome.h"
 #include "cpu-features.h"
+#include "mmuidx-internal.h"
 
 /* register banks for CPU modes */
 #define BANK_USRSYS 0
@@ -986,8 +987,6 @@ static inline ARMMMUIdx core_to_aa64_mmu_idx(int mmu_idx)
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
index 9447d7ba59..8985ad8c8a 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -9895,33 +9895,6 @@ int fp_exception_el(CPUARMState *env, int cur_el)
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
index 07d9271aa4..91630a1f72 100644
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


