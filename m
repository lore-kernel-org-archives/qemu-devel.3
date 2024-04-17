Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F68CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 18:29:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxA1U-0007fG-AM; Wed, 17 Apr 2024 14:28:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1S-0007eD-KZ
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:42 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rxA1Q-0003Jw-Na
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 14:28:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-418db9aa891so312215e9.0
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 11:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713378518; x=1713983318; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rI+phs//gjZco0fvuUEX1KPF7mTDgm4gz1xheV8LKk0=;
 b=Zwg14XFahuzecCyN8f6uSyWtRSbf+Ugd4qs0L+9Uxhg5m5TQfzL9D/LjLzLr6u804Y
 ArVu+UAEgtBafdh9Qgrz3uVhYpZDNfgQBLruTCZuCWtvh5uUhHSr0Cl2OxMMuVWEpbDG
 Bn9zdk9c49QG8sGaDoQJ3YulF2SRXLkFp9DUDmfznGSSKDsH9I/dkC7j9s9IfOWqm+RD
 tVUbbgNjNKowP+obgAxUIETOK8qupGuZ0mEj4iEbEJU7mkfPP5tsigFo/KArO0A9mAHO
 AASGMJSIKdn0VP185RJRQ601rO4FIiBLUf69TQp8zmg7wuTDVVhiuUSbKsFthfS9di7F
 oHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713378518; x=1713983318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rI+phs//gjZco0fvuUEX1KPF7mTDgm4gz1xheV8LKk0=;
 b=B0sV72HWmDvYrDrwM0vb1aKthSFrSQ3ZjvMPtSyxmtuGluhYG9vm+/kB5T45xOIbFO
 ZfJ0ueQqy8TtbETL8s4Qt/BjnK/iVFE0s4hrxDdOJg4Pdl8iNt7QzjedB4QiGqL1q591
 TFZ8PkDIOI66JfdXu25kCJIDIuGZf+PlVJtOCJxEfKaCzBZ0E49zYWkd+xI960HUQ/Og
 pzgImtP/TqPPDm4eoJSTJ0DDW89BRUWP9P4uYnmoLandyUH629f9XGJ6Si+EC5l2Nh/2
 +BcX83tcXx1+C+Sxy/dOnM5MhOCsGGQbircw8DKxi8Qqm9u6CNKSa8o3lkX9INTEdHy4
 6rVg==
X-Gm-Message-State: AOJu0Yw/VWSUga1Vu5z8VEmUg9OUzxIMM5QDvH+9Kn723C8hf8QIsGin
 vRW5Hw6TTbLmkxAYE1Cv1L3eVy9I7rZl5GzT8Avg1PD1iWabM8d0OhDd7xvfz3Nr0lQcIuh35ex
 k
X-Google-Smtp-Source: AGHT+IHGIEMORXo/HW5Je/5hc+rGEhIaeHwmnNpC5ocMuVVhQnNDxttfuPgCNe6MOdJ7OVWUHL+3Hw==
X-Received: by 2002:a05:600c:4591:b0:416:8efd:1645 with SMTP id
 r17-20020a05600c459100b004168efd1645mr406430wmo.7.1713378518617; 
 Wed, 17 Apr 2024 11:28:38 -0700 (PDT)
Received: from m1x-phil.lan ([176.187.201.23])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a05600c19cc00b004182cd07133sm3716196wmq.3.2024.04.17.11.28.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 17 Apr 2024 11:28:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Warner Losh <imp@bsdimp.com>
Subject: [PATCH 05/21] exec: Expose 'target_page.h' API to user emulation
Date: Wed, 17 Apr 2024 20:27:50 +0200
Message-ID: <20240417182806.69446-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240417182806.69446-1-philmd@linaro.org>
References: <20240417182806.69446-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

User-only objects might benefit from the "exec/target_page.h"
API, which allows to build some objects once for all targets.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Warner Losh <imp@bsdimp.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20231211212003.21686-3-philmd@linaro.org>
---
 meson.build            |  2 +-
 page-target.c          | 44 ++++++++++++++++++++++++++++++++++++++++++
 system/physmem.c       | 30 ----------------------------
 target/target-common.c | 10 ----------
 target/meson.build     |  2 --
 5 files changed, 45 insertions(+), 43 deletions(-)
 create mode 100644 page-target.c
 delete mode 100644 target/target-common.c

diff --git a/meson.build b/meson.build
index da8295b405..44d337f67b 100644
--- a/meson.build
+++ b/meson.build
@@ -3554,7 +3554,7 @@ if get_option('b_lto')
   pagevary = declare_dependency(link_with: pagevary)
 endif
 common_ss.add(pagevary)
-specific_ss.add(files('page-vary-target.c'))
+specific_ss.add(files('page-target.c', 'page-vary-target.c'))
 
 subdir('backends')
 subdir('disas')
diff --git a/page-target.c b/page-target.c
new file mode 100644
index 0000000000..82211c8593
--- /dev/null
+++ b/page-target.c
@@ -0,0 +1,44 @@
+/*
+ * QEMU page values getters (target independent)
+ *
+ *  Copyright (c) 2003 Fabrice Bellard
+ *
+ * SPDX-License-Identifier: LGPL-2.1-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "exec/target_page.h"
+#include "exec/cpu-defs.h"
+#include "cpu.h"
+#include "exec/cpu-all.h"
+
+size_t qemu_target_page_size(void)
+{
+    return TARGET_PAGE_SIZE;
+}
+
+int qemu_target_page_mask(void)
+{
+    return TARGET_PAGE_MASK;
+}
+
+int qemu_target_page_bits(void)
+{
+    return TARGET_PAGE_BITS;
+}
+
+int qemu_target_page_bits_min(void)
+{
+    return TARGET_PAGE_BITS_MIN;
+}
+
+/* Convert target pages to MiB (2**20). */
+size_t qemu_target_pages_to_MiB(size_t pages)
+{
+    int page_bits = TARGET_PAGE_BITS;
+
+    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
+    g_assert(page_bits < 20);
+
+    return pages >> (20 - page_bits);
+}
diff --git a/system/physmem.c b/system/physmem.c
index a4fe3d2bf8..dd7b222942 100644
--- a/system/physmem.c
+++ b/system/physmem.c
@@ -3504,36 +3504,6 @@ int cpu_memory_rw_debug(CPUState *cpu, vaddr addr,
     return 0;
 }
 
-/*
- * Allows code that needs to deal with migration bitmaps etc to still be built
- * target independent.
- */
-size_t qemu_target_page_size(void)
-{
-    return TARGET_PAGE_SIZE;
-}
-
-int qemu_target_page_bits(void)
-{
-    return TARGET_PAGE_BITS;
-}
-
-int qemu_target_page_bits_min(void)
-{
-    return TARGET_PAGE_BITS_MIN;
-}
-
-/* Convert target pages to MiB (2**20). */
-size_t qemu_target_pages_to_MiB(size_t pages)
-{
-    int page_bits = TARGET_PAGE_BITS;
-
-    /* So far, the largest (non-huge) page size is 64k, i.e. 16 bits. */
-    g_assert(page_bits < 20);
-
-    return pages >> (20 - page_bits);
-}
-
 bool cpu_physical_memory_is_io(hwaddr phys_addr)
 {
     MemoryRegion*mr;
diff --git a/target/target-common.c b/target/target-common.c
deleted file mode 100644
index 903b10cfe4..0000000000
--- a/target/target-common.c
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-#include "qemu/osdep.h"
-
-#include "cpu.h"
-#include "exec/target_page.h"
-
-int qemu_target_page_mask(void)
-{
-    return TARGET_PAGE_MASK;
-}
diff --git a/target/meson.build b/target/meson.build
index dee2ac47e0..a53a60486f 100644
--- a/target/meson.build
+++ b/target/meson.build
@@ -19,5 +19,3 @@ subdir('sh4')
 subdir('sparc')
 subdir('tricore')
 subdir('xtensa')
-
-specific_ss.add(files('target-common.c'))
-- 
2.41.0


