Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C82C36010
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 22:37:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0pe2-0000pi-JL; Fri, 04 Apr 2025 18:36:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdw-0000nm-NR
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:36:08 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u0pdt-00082L-V8
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 18:36:07 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-43cf06eabdaso22468975e9.2
 for <qemu-devel@nongnu.org>; Fri, 04 Apr 2025 15:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743806163; x=1744410963; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UbtmmP0oOdI2W/ScvwaiV+7++EOQsRdn8KA47Nc8msw=;
 b=FbOens4URUP31f2nBEPg3R8QhyAIXt8GXDOYAr93p9TEJKzRXBv8loODM5YRf+pXhj
 BlJ58GdQchgR/y3ltw5i35fVTHu4IOyi90gNwt9CspajxuAKqcC4Z/u6tt07o55xtBFP
 ltns7AqOUODivyiAo0gedCVmTIiiZzVQsUeqndYIsxEGWrI3t6CgIqYLSGi762oucWn5
 btPbcgpPDCHbPleCccU2CR8aqV0TM9QAbI+XTqWWigNGw9pa69VNFx4evs4nGhDo4OnK
 Tq2XL5GNehRIeFw8YovZhtkWWuopx0xAfsT2KfsIaG5QQE7cMupDVzEbTdBYfy5chm6R
 kRVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743806163; x=1744410963;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UbtmmP0oOdI2W/ScvwaiV+7++EOQsRdn8KA47Nc8msw=;
 b=lnCnJUaaac4omj1v54f5Z4D9668Ck9SRVLnocc6pCIuMxcfiaKdhSB41+AyhkJt22e
 OgpH+S4KJY/EkatCFv+AywujsXho/zHaKYL7sx+t3g2Y7qdtH056DbrxVoBdqVWEEK2L
 JA26dmC69cWmqkox2Q78wWvT7cXIrljiwvmHjvl23hoIPKM6DmKY2rPj+9+LRX5s7l+3
 pExbB37HYWDWA7U6wDt3DUV7cZEUBMc13kuX9N1KpygOJByLZFiYC+oQAB3dgzw86vu6
 CN/xE2vDZYhpXysMDAqH68kzWfJHqs8H8wxvbbdBOojuFEbaEK/GrTiW4xHXJTeXxHJt
 rjvA==
X-Gm-Message-State: AOJu0Yy1A9zUbL/7OLObzeSlYhGZoxivd8lk5h7f4QOauZsfRXj3biIj
 OOjhqv+i2hTAZ/i2gavqk6SRSIP3WRt6hBvMd8/W5+O8ATVOJvdyqhU5tEP3VvVwqOO2O4yzpZI
 b
X-Gm-Gg: ASbGncuYp+da996aiVwwKcfovLzlYEQU/5Wj6mqfNjRRwLUJFO+V74Q8Jz/uRdZk2Ec
 R/lrzRHt9iJ4VWLBzLUzkCHOlfyB1DNL3tku2dGeXUCSXMA0R9L7znbIn7cuGsRMGIj1iKk4rV2
 oockIolipdmYfuDIEcKeYyPLLpHs1zk0LclNf0dNd3/KmriV8+fmYRRfpAiLgmvM5+ENi77F0vL
 O9R1Xk/WgAWdFGg7Zq9KLUAfGtYsH1EE/OzK8r6IaMhPlcUaCHImEp0J576EBcbAtRVBE3631AJ
 bBP6KRJVCUvvmoRu/O2NYc/PTT/EP8c71HKX88w5tAwWNS70+8Mji5L1zPvB2hBy5sHrdlEtLlQ
 zfZM/K9hgpyqPb/V8bchF69S5
X-Google-Smtp-Source: AGHT+IGSdr7DxbVwhuVhiX68wKER9VgzAYsNnLkEibQmdNkzqlLvtbByQegi0We/lY/E/p0KaHYHdw==
X-Received: by 2002:a05:600c:1e03:b0:43d:683:8cb2 with SMTP id
 5b1f17b1804b1-43ecf8ceb2dmr46985395e9.14.1743806163033; 
 Fri, 04 Apr 2025 15:36:03 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec342a3dfsm57630445e9.4.2025.04.04.15.36.02
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 04 Apr 2025 15:36:02 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH-for-10.1 8/9] linux-user/arm: Implement MTE stubs for 32-bit
 user emulation
Date: Sat,  5 Apr 2025 00:35:20 +0200
Message-ID: <20250404223521.38781-9-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250404223521.38781-1-philmd@linaro.org>
References: <20250404223521.38781-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

We want to build MTE code once, but on linux-user it calls
arm_set_mte_tcf0() which is only defined for Aarch64.
Expose the declaration on 32-bit ARM by renaming
aarch64/mte_user_helper.h -> arm/mte_user_helper.h, then
add a stub in arm/mte_user_helper.c.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 linux-user/aarch64/mte_user_helper.h | 27 +---------------------
 linux-user/arm/mte_user_helper.h     | 34 ++++++++++++++++++++++++++++
 linux-user/arm/mte_user_helper.c     | 13 +++++++++++
 linux-user/arm/meson.build           |  2 ++
 4 files changed, 50 insertions(+), 26 deletions(-)
 create mode 100644 linux-user/arm/mte_user_helper.h
 create mode 100644 linux-user/arm/mte_user_helper.c

diff --git a/linux-user/aarch64/mte_user_helper.h b/linux-user/aarch64/mte_user_helper.h
index 0c53abda222..63f63abff62 100644
--- a/linux-user/aarch64/mte_user_helper.h
+++ b/linux-user/aarch64/mte_user_helper.h
@@ -6,29 +6,4 @@
  * SPDX-License-Identifier: LGPL-2.1-or-later
  */
 
-#ifndef AARCH64_MTE_USER_HELPER_H
-#define AARCH64_MTE USER_HELPER_H
-
-#include "user/abitypes.h"
-
-#ifndef PR_MTE_TCF_SHIFT
-# define PR_MTE_TCF_SHIFT       1
-# define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
-# define PR_MTE_TAG_SHIFT       3
-# define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
-#endif
-
-/**
- * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
- * @env: The CPU environment
- * @value: The value to be set for the Tag Check Fault in EL0 field.
- *
- * Only SYNC and ASYNC modes can be selected. If ASYMM mode is given, the SYNC
- * mode is selected instead. So, there is no way to set the ASYMM mode.
- */
-void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
-
-#endif /* AARCH64_MTE_USER_HELPER_H */
+#include "../arm/mte_user_helper.h"
diff --git a/linux-user/arm/mte_user_helper.h b/linux-user/arm/mte_user_helper.h
new file mode 100644
index 00000000000..0c53abda222
--- /dev/null
+++ b/linux-user/arm/mte_user_helper.h
@@ -0,0 +1,34 @@
+/*
+ * ARM MemTag convenience functions.
+ *
+ * This code is licensed under the GNU GPL v2 or later.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#ifndef AARCH64_MTE_USER_HELPER_H
+#define AARCH64_MTE USER_HELPER_H
+
+#include "user/abitypes.h"
+
+#ifndef PR_MTE_TCF_SHIFT
+# define PR_MTE_TCF_SHIFT       1
+# define PR_MTE_TCF_NONE        (0UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_SYNC        (1UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_ASYNC       (2UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TCF_MASK        (3UL << PR_MTE_TCF_SHIFT)
+# define PR_MTE_TAG_SHIFT       3
+# define PR_MTE_TAG_MASK        (0xffffUL << PR_MTE_TAG_SHIFT)
+#endif
+
+/**
+ * arm_set_mte_tcf0 - Set TCF0 field in SCTLR_EL1 register
+ * @env: The CPU environment
+ * @value: The value to be set for the Tag Check Fault in EL0 field.
+ *
+ * Only SYNC and ASYNC modes can be selected. If ASYMM mode is given, the SYNC
+ * mode is selected instead. So, there is no way to set the ASYMM mode.
+ */
+void arm_set_mte_tcf0(CPUArchState *env, abi_long value);
+
+#endif /* AARCH64_MTE_USER_HELPER_H */
diff --git a/linux-user/arm/mte_user_helper.c b/linux-user/arm/mte_user_helper.c
new file mode 100644
index 00000000000..6fd19dc1073
--- /dev/null
+++ b/linux-user/arm/mte_user_helper.c
@@ -0,0 +1,13 @@
+/*
+ * ARM ARM MemTag user emulation stubs.
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "mte_user_helper.h"
+
+void arm_set_mte_tcf0(CPUArchState *env, abi_long value)
+{
+    g_assert_not_reached();
+}
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index 348ffb810d7..95e8c078e29 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -24,3 +24,5 @@ vdso_le_inc = gen_vdso.process('vdso-le.so',
 linux_user_ss.add(when: 'TARGET_ARM', if_true: [
     vdso_be8_inc, vdso_be32_inc, vdso_le_inc
 ])
+
+linux_user_ss.add(when: 'TARGET_ARM', if_true: [files('mte_user_helper.c')])
-- 
2.47.1


