Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7123C369D8
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 19:45:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7JIZ-0002XU-1Q; Tue, 22 Apr 2025 15:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JII-0002Ss-LV
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:34 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1u7JIG-0006B0-JD
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 15:28:34 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-308702998fbso5010833a91.1
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 12:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745350109; x=1745954909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uUDSMb2yaWobcfq2T8zvFcLGEMZI8wXQ4enYzV4I/Bs=;
 b=euiKftqLZ07t+NtkP7Pdx55QJIBNhO+sEkBy/+23LiidypbkTIkqmAIpDBLyI+5G++
 xhCXH1I0GwKqRUKGYpzSFPTtCE82bQIIcR8H+fJnMih19rkn9hmVCjWxSqCZ5z6Tg0qV
 9KpQ8rDsCZV/e36uO7m351V/VOM5FCZdW/sx8QIboLdBf2oXP3c2WOp/NjbNvwwE8XW2
 B6ABFOn4iFVoayq/06+kQJabXBHS9DmCei+GmMuXzBfNorfG85kBnGeA3xJ5B2dWJD17
 Y8C8zXJ5+u/gFG8RpRPTgmdY7vWUS41uyLZbZVhTRFfRNWHtP4wEcexFZ4aVQUqQibd0
 BacQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745350109; x=1745954909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uUDSMb2yaWobcfq2T8zvFcLGEMZI8wXQ4enYzV4I/Bs=;
 b=OQgYyfx1ep2EWKF4LwFH83+fvgAltiCERt+9uUOMFyM2QTLgrhBfQ9ZYLxXMrs/9UU
 t853bUIL/Df05Fnpjouu+1tANGQRArUQ4EZpNaPLVc+lEiaIAM4m/al1lfjQf+1Gstj1
 c1sT5rUJj8sA/lhV2bJY1yMSuj74mvg/kQWnODZB8D6jkFgAvkws/ePZ89Xgi0vXmWhU
 YcyBuSsHoe2PPqI/zakzd5BTSYV9BEYg8Ovyhoz1P87W9CS80HU1vLmnrcCl53dDB15a
 s/dlCYKVaJALUsNGLq2kyCUMw57nLJVYU7f6zBbimTo8d4lxlwJO/A+zfXN9yCK+f95w
 FTFw==
X-Gm-Message-State: AOJu0Yz86GFfffI3Dr05xQYHTugjmCMAdO4YBleQ3vTtpn1lPQdB3I6I
 kmGQjx+Sh3mr8uIfv1259EzisQlC/AORuq4mfLcECmoZcut1dkFzmJUkl/GgtP4hTOKA9477ylg
 7
X-Gm-Gg: ASbGnctejfkR8m8Xuu46Qpo4JbZq6XGdl0WIEih2q1HNSueId0AgTg4GjeSKn0os0tl
 +O9PD5umgXJjHpfNRaX9n3gfgHXhk4HAzCtBtGo2IzuddXK8X80SMwEoBVLtLKEJ4rJ832vfJCH
 mWQIkekA8vJs7MJlzGYkiMJeiNQ125j668IC9OtWg4ZhhcgKKUITr6hzCY4kGQ12JE9DaFgwlzc
 UNBN2BB6wlrupjIrSYss67wV/3BCnrS6IhZ6HKBuxVWOXGNCM3yb+k8u5yZUM6SkJlrr/L0x0Cj
 MhBSWu22mc/Nf+HiiAHV9W1Y1Z2uDmfIcptapl4i/XMJ6jrw4DvL0qlEHwJExU0gYmpdGGINJ1P
 aZ+c4VgXDtQ==
X-Google-Smtp-Source: AGHT+IHz/426LNDuiMCmZd7RnzHi3ly1ulePkGLgfWOAzIdRbXwRVIXJLXMQDzMDWRr8OFTFCDCGSA==
X-Received: by 2002:a17:90b:58ec:b0:2ee:8e75:4aeb with SMTP id
 98e67ed59e1d1-3087bb69d13mr27495369a91.17.1745350108650; 
 Tue, 22 Apr 2025 12:28:28 -0700 (PDT)
Received: from stoup.. (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3087df21278sm9146865a91.29.2025.04.22.12.28.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Apr 2025 12:28:28 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Anthony PERARD <anthony.perard@vates.tech>
Subject: [PATCH 012/147] hw/xen: add stubs for various functions
Date: Tue, 22 Apr 2025 12:26:01 -0700
Message-ID: <20250422192819.302784-13-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250422192819.302784-1-richard.henderson@linaro.org>
References: <20250422192819.302784-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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


