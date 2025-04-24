Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9C37C369CB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 00:55:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7kmj-0005C5-4s; Wed, 23 Apr 2025 20:49:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kmg-0005Aj-JF
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:46 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7kme-0004Ji-Qk
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 20:49:46 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-736c1138ae5so361876b3a.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 17:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745455783; x=1746060583; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUDSMb2yaWobcfq2T8zvFcLGEMZI8wXQ4enYzV4I/Bs=;
 b=RsW6m8eiHa9yphOoJpYM5MMgp5JLZInXR9QEJ8awQxdJJy2/elAGd0MFIla3bje7vN
 HXaeiQsfxgrjYzVsQc5+4u+LMEJgmzQxuBKtczhzZ9CcmiOjcLclfTUwCKRh/uNma0qB
 dR9v8CH0/jfYSBMFNdCgI2ISeE3UFTkOrvyVK91htC6mOzRIZXd1X3i8zFzDu51ggg3Y
 iBAt97GRdm1Lk8VZszoP7P+KefQgmWq+QII65ABpF/2z6An53EIbgZNyZn4KvkCljyKK
 jVl2N1wEOwI20cBojc8/Gp8Za1MrL7wNi/H0229uqft2FBMiUBurkWiXGeGSZMh3l04X
 JTfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745455783; x=1746060583;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUDSMb2yaWobcfq2T8zvFcLGEMZI8wXQ4enYzV4I/Bs=;
 b=nOh/QxGjzwPSCgmkQ80ri4ZIS3BooFZmyvzKGRCr6STepWhUwSslmSiDYGM13Vl2ZF
 OO4Nyk9MD/nR5PcEyBzb3P2yeZTsafy3Z+Z6F1v6rorN2vGV7iEnfCi/xXbc7G4gIgj9
 oXLxWQ3mzVamYskY2aQeFjOqvoAfaiPOXN3mPDFXx+3XNYEZEAUPTa31+RwHwk6s9FR2
 hzNrid8h5YFWPwd6ZZA+xRAhZLfYRXHqEOynPivPRZUyq3q4M6hye9BOnXIWSXS0Oc33
 2eZnYXb0wE7CzCpgF2rswFqeH0BMjk26zU6wTL2FMs/aS5kl1AHq9e5f/eNjJ2J89glJ
 qXQQ==
X-Gm-Message-State: AOJu0YzQbt9MniCwXwNn5aAwm0imVDDqIoQPQ5XX7Yzx8ChLFsqqb8TB
 QVIAguyBHxnotC9RjfHmBKa8o2u1Zee2sS112qsJJw9yW4a1sgdHeIHXRIIAk7N4fDpWqSXQZl/
 h
X-Gm-Gg: ASbGncspO1q1kJEs9tsUDqFQE87T3LiM2QdnYuurx8Ii4EHlk3tOlYO4Wd6HDHpPRCH
 7YFFJBljgZmYKS3mS5dZfKH73zBYKNqHt2Ip5LoEN2FxMoJbIeJKPKZid2GCoIf6gv10uyIuJSs
 H+KN6zslAx/EsL+7HwD0m5sD2Fd7oGDYNXeALvnqE44O2yST/GS8jptAHSiMdMuNUtxK+a+uW1V
 DmL5tKHoXYD8lVWllSIXr+vZntHdbHOAttmYvDkq22OaPhJT+oKwNu2i2IXh+NRgJ0W+kXp4chM
 Ci0iYrx0hwyJ4uPxi1zuyrMdf9yg7RUmz/F/PY9apZGd6wxgQfzw4XqP9g2hZlyRkJiVgNAK+ta
 bre8TMOepGA==
X-Google-Smtp-Source: AGHT+IFrUEQ6DzSkqFbzPYC5iR3gk/FKLaH4Q8oUtDoj8aIAo7MV4bw49sYnvmpihjAVTq5YsH8/+A==
X-Received: by 2002:a05:6a20:7350:b0:1fe:61a4:71d8 with SMTP id
 adf61e73a8af0-20444f2b284mr844607637.22.1745455783436; 
 Wed, 23 Apr 2025 17:49:43 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73e25a9a0f1sm207344b3a.137.2025.04.23.17.49.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 17:49:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PULL 012/148] hw/xen: add stubs for various functions
Date: Wed, 23 Apr 2025 17:47:17 -0700
Message-ID: <20250424004934.598783-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250424004934.598783-1-richard.henderson@linaro.org>
References: <20250424004934.598783-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Those symbols are used by system/physmem.c, and are called only if
xen_enabled() (which happens only if CONFIG_XEN is set and xen is
available).

So we can crash the stubs in case those are called, as they are linked
only when CONFIG_XEN is not set.

Acked-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20250317183417.285700-13-pierrick.bouvier@linaro.org>
---
 hw/xen/xen_stubs.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 hw/xen/meson.build |  3 +++
 2 files changed, 54 insertions(+)
 create mode 100644 hw/xen/xen_stubs.c

diff --git a/hw/xen/xen_stubs.c b/hw/xen/xen_stubs.c
new file mode 100644
index 0000000000..5e565df392
--- /dev/null
+++ b/hw/xen/xen_stubs.c
@@ -0,0 +1,51 @@
+/*
+ * Various stubs for xen functions
+ *
+ * Those functions are used only if xen_enabled(). This file is linked only if
+ * CONFIG_XEN is not set, so they should never be called.
+ *
+ * Copyright (c) 2025 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "system/xen.h"
+#include "system/xen-mapcache.h"
+
+void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length)
+{
+    g_assert_not_reached();
+}
+
+void xen_ram_alloc(ram_addr_t ram_addr, ram_addr_t size,
+                   struct MemoryRegion *mr, Error **errp)
+{
+    g_assert_not_reached();
+}
+
+bool xen_mr_is_memory(MemoryRegion *mr)
+{
+    g_assert_not_reached();
+}
+
+void xen_invalidate_map_cache_entry(uint8_t *buffer)
+{
+    g_assert_not_reached();
+}
+
+ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
+{
+    g_assert_not_reached();
+}
+
+uint8_t *xen_map_cache(MemoryRegion *mr,
+                       hwaddr phys_addr,
+                       hwaddr size,
+                       ram_addr_t ram_addr_offset,
+                       uint8_t lock,
+                       bool dma,
+                       bool is_write)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/xen/meson.build b/hw/xen/meson.build
index 4a486e3673..a1850e7698 100644
--- a/hw/xen/meson.build
+++ b/hw/xen/meson.build
@@ -9,6 +9,9 @@ system_ss.add(when: ['CONFIG_XEN_BUS'], if_true: files(
 
 system_ss.add(when: ['CONFIG_XEN', xen], if_true: files(
   'xen-operations.c',
+),
+if_false: files(
+  'xen_stubs.c',
 ))
 
 xen_specific_ss = ss.source_set()
-- 
2.43.0


