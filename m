Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3DFBCA0FF7
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 23:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urPRd-0001Sw-2q; Wed, 27 Aug 2025 19:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRa-0001Qd-5M
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:42 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1urPRX-00047W-SM
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 19:20:41 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-76e2ea933b7so343287b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Aug 2025 16:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756336838; x=1756941638; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=espLsLzFTU7cxFqyARSOxDSFafcxC054iwCcq6d9G2Y=;
 b=vXS2hIvIdJPBUTl/+y1i7yoG9tXUjNYv/+0JmCOX2BxKoYMRMOfRkf0FxK3zpRBNCE
 MdC1eNtr1nCxlEMTFAUo0QtzFfdu30gGHEAOO7Z6NVg0/IC+rPIcpuJUs8Rmq7of3tA7
 5+lODLXtu7yGvgX8Uq1LvDnX2ogwVxZKyaWMe08zD3yYatNeJvN+rDz6nUAEOANzZOCN
 D/TFtiTghVNiPWq82ridVIMVFYrcrbdkDtr3pxgGE4UynyZ0yXAjabjzWs+3VdU9geSF
 jhZbiBA297XuG14CYVlIF5Jpb7C+ui9K82b7H/AzNfhwD6HSAr+wYgL5OsjYVFviNEEn
 kaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756336838; x=1756941638;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=espLsLzFTU7cxFqyARSOxDSFafcxC054iwCcq6d9G2Y=;
 b=dLf6o91F+PhwVghwObXi777TFR0NzW+RtlFJ489in0mWjo3KiNM9n4N2VM1bKpI4K9
 QqGWYNCI2xZ4hPESP5NjmRYo7LtNfHgG5XR4Df/R5+laXAe2x119wMa6D4O6DRNxA74Z
 HsR/sfcgn7RBW0VvtmMMZhayypiSGhpNAU8gDmzpDkkYBl1UDyn35hZuQHGWWBdbGbFq
 nO1XqYGyQkHcsGtg/5/CmAPZkexNv3I1fVvmiDKdpF6Axmsxj4gDoNvPxK3xGd5MzH1V
 IZtYewuGjzX+IJRoEPr+/qIv8jCR4MFqlwnwb3qyEhUgxUmNByYXvamEXBLZcPZYVnb1
 E0vQ==
X-Gm-Message-State: AOJu0Yx3rKS7+JP6e4x2VLldvZk2qtHX37rswfCUQ21wGC6i079HfqOn
 gsUimo1PNFv8iZgAUP0qDGw9TjchuTV7z/zJlGGMqnB8WshduWwSZgt2ADQkKxwWAdC+9pKKskt
 qSdJTgoM=
X-Gm-Gg: ASbGncu/5pL4I4PG3GFQAuZ1EM9V9rp6j2qQnz8kSqC8K7GStLbljpMz/G4qMBpeV85
 Bkf2i5hFG1uBi2sx/5wFyNwnQG+ROnhVyjotAhHhA4+IKLJmimIicUgFf/qvEbOp72FQ1D4dRj9
 P8YrUQt+RVTmGLS0BhcH9AzAKimhTaOTLZuyDjfcLIwseQvaLRSpJ+NEbt/ULD9/77ZFbHl/umc
 9RDraXW+7F4TK2Tim756Qg2yiRrzgfYNpQg6VjPosPL4mIVHtGk5E2zDZYmyWwv1JX0fIUKx3Xa
 DZoNw4yzPj+G0bXnMDYuDV9l8S/qeTzvCQymHrPfws+pteUva0y+gnuGJ1WgFMQLlTwo0+7ib9M
 b5GbBsXgP5a+cSTjZGFUJi5yt8bYeV3eFeSpr
X-Google-Smtp-Source: AGHT+IEsaZ4N+EhvxW0C8i3dLxmjtnYgrtSpDraXzhnwkClGtuBteqWHrAPkVJ19XaJpPMAOv9eLmA==
X-Received: by 2002:a05:6a00:bd92:b0:736:4e14:8ec5 with SMTP id
 d2e1a72fcca58-771fc2942e2mr8142525b3a.11.1756336838009; 
 Wed, 27 Aug 2025 16:20:38 -0700 (PDT)
Received: from stoup.. ([144.6.121.55]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7703ffebd33sm13986886b3a.29.2025.08.27.16.20.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 16:20:37 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/46] linux-user: Create target/elfload.c files
Date: Thu, 28 Aug 2025 09:19:40 +1000
Message-ID: <20250827232023.50398-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827232023.50398-1-richard.henderson@linaro.org>
References: <20250827232023.50398-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Prepare to split the main linux-user/elfload.c.
Create empty files for each target, and add the common build rule.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/aarch64/elfload.c     | 1 +
 linux-user/alpha/elfload.c       | 1 +
 linux-user/arm/elfload.c         | 1 +
 linux-user/hexagon/elfload.c     | 1 +
 linux-user/hppa/elfload.c        | 1 +
 linux-user/i386/elfload.c        | 1 +
 linux-user/loongarch64/elfload.c | 1 +
 linux-user/m68k/elfload.c        | 1 +
 linux-user/microblaze/elfload.c  | 1 +
 linux-user/mips/elfload.c        | 1 +
 linux-user/mips64/elfload.c      | 1 +
 linux-user/openrisc/elfload.c    | 1 +
 linux-user/ppc/elfload.c         | 1 +
 linux-user/riscv/elfload.c       | 1 +
 linux-user/s390x/elfload.c       | 1 +
 linux-user/sh4/elfload.c         | 1 +
 linux-user/sparc/elfload.c       | 1 +
 linux-user/x86_64/elfload.c      | 1 +
 linux-user/xtensa/elfload.c      | 1 +
 meson.build                      | 6 +++++-
 20 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 linux-user/aarch64/elfload.c
 create mode 100644 linux-user/alpha/elfload.c
 create mode 100644 linux-user/arm/elfload.c
 create mode 100644 linux-user/hexagon/elfload.c
 create mode 100644 linux-user/hppa/elfload.c
 create mode 100644 linux-user/i386/elfload.c
 create mode 100644 linux-user/loongarch64/elfload.c
 create mode 100644 linux-user/m68k/elfload.c
 create mode 100644 linux-user/microblaze/elfload.c
 create mode 100644 linux-user/mips/elfload.c
 create mode 100644 linux-user/mips64/elfload.c
 create mode 100644 linux-user/openrisc/elfload.c
 create mode 100644 linux-user/ppc/elfload.c
 create mode 100644 linux-user/riscv/elfload.c
 create mode 100644 linux-user/s390x/elfload.c
 create mode 100644 linux-user/sh4/elfload.c
 create mode 100644 linux-user/sparc/elfload.c
 create mode 100644 linux-user/x86_64/elfload.c
 create mode 100644 linux-user/xtensa/elfload.c

diff --git a/linux-user/aarch64/elfload.c b/linux-user/aarch64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/aarch64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/alpha/elfload.c b/linux-user/alpha/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/alpha/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/arm/elfload.c b/linux-user/arm/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/arm/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/hexagon/elfload.c b/linux-user/hexagon/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/hexagon/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/hppa/elfload.c b/linux-user/hppa/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/hppa/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/i386/elfload.c b/linux-user/i386/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/i386/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/loongarch64/elfload.c b/linux-user/loongarch64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/loongarch64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/m68k/elfload.c b/linux-user/m68k/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/m68k/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/microblaze/elfload.c b/linux-user/microblaze/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/microblaze/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/mips/elfload.c b/linux-user/mips/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/mips/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/mips64/elfload.c b/linux-user/mips64/elfload.c
new file mode 100644
index 0000000000..b719555e65
--- /dev/null
+++ b/linux-user/mips64/elfload.c
@@ -0,0 +1 @@
+#include "../mips/elfload.c"
diff --git a/linux-user/openrisc/elfload.c b/linux-user/openrisc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/openrisc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/ppc/elfload.c b/linux-user/ppc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/ppc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/riscv/elfload.c b/linux-user/riscv/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/riscv/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/s390x/elfload.c b/linux-user/s390x/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/s390x/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/sh4/elfload.c b/linux-user/sh4/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/sh4/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/sparc/elfload.c b/linux-user/sparc/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/sparc/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/x86_64/elfload.c b/linux-user/x86_64/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/x86_64/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/linux-user/xtensa/elfload.c b/linux-user/xtensa/elfload.c
new file mode 100644
index 0000000000..73fa78ef14
--- /dev/null
+++ b/linux-user/xtensa/elfload.c
@@ -0,0 +1 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
diff --git a/meson.build b/meson.build
index 50c774a195..0d42de61ae 100644
--- a/meson.build
+++ b/meson.build
@@ -4327,7 +4327,11 @@ foreach target : target_dirs
     )
     if 'CONFIG_LINUX_USER' in config_target
       dir = base_dir / abi
-      arch_srcs += files(dir / 'signal.c', dir / 'cpu_loop.c')
+      arch_srcs += files(
+        dir / 'cpu_loop.c',
+        dir / 'elfload.c',
+        dir / 'signal.c',
+      )
       if config_target.has_key('TARGET_SYSTBL_ABI')
         arch_srcs += \
           syscall_nr_generators[abi].process(base_dir / abi / config_target['TARGET_SYSTBL'],
-- 
2.43.0


