Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DBCFD73E81
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 17:39:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlVyV-0004tQ-GA; Thu, 29 Jan 2026 12:38:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyS-0004ob-49
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:32 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vlVyQ-0000ft-6p
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 12:38:31 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-81f47610542so751511b3a.0
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 09:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769708309; x=1770313109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=InBZElLJ2/mcvIPaOt6RbJMQf2ySklUloiFPz1R6SEY=;
 b=XdYNlvkYsZldrstq6d2cP23uGgNHAKtkoGRchfV4aPci1lUSmFmG1cQwba5XEK78qq
 cLe//U98eNziGUdW1DYhK9UdN+4WckzyHvSd4xB55Dm9dMRu2xymtmBNjgwi31GQ4wuz
 mAb8c8rwgWaTMXBLpe1n4CSpQzHZ9xhuVtInK+caU41lzlUwGjWpSvxCyBITubuAly9G
 Fp5bQN9jfrvGP8/d07vuy1pgcHu74gDy3q2I5mDfmmS08qxErL5tmZkoZT7sSQZ78BK1
 /cnbZvoHQZNNS3P+h4GT3JM5evSQFM0/IgTOhipgKHYAubPOtzZ734+bdZhWK12jDk8m
 hUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769708309; x=1770313109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=InBZElLJ2/mcvIPaOt6RbJMQf2ySklUloiFPz1R6SEY=;
 b=XOoTv0rpXo60doYe7lkQO/keWWG/4txoKE0Jr17z8K+rNaV8e+jJVIjyZhSaPJJIqp
 pNWyfDSqi2dPJSsjlpaSjak3fp1UuexIoWanUp4JggBCZCCL8dcpjbxZmph7CXrRY4Oh
 PBWvdTzslhxbOfZ8gH4t5qQQ325rOc26LiOxGbMBOHUKjJdBqkmQoFtfyl1gclfWdk07
 XWYBuWuz6WR+YUXHhPs9YRUJA86HJ6bmfmIbz7SE+Si+ja6JTbuxn/6ojmDC6+Uguu1g
 QXrvA5Ad1Ou67sjLpyz6cYWjKh4BtP8Ca7HVzfQq9nmT4ip08+DLufb6aNQBH6UOmFwh
 XS5A==
X-Gm-Message-State: AOJu0YyAIs2w1Xkw/zBqAjCYTYZA5LcwYeAVtiH/ZL0PfzVpAUs0iEy2
 HDIePi0kh6SaDKFGhqX2j4ogQnciez6Ab1FvHXeoQnZj4U5jPcSa2qwruC4mMUoh6aFVybiMeGT
 /hLb0
X-Gm-Gg: AZuq6aLU3ZenN9m5b9cPj/YXQpr+61ca59Rp/FRs6A0BvtPRn3iCVU65gbH380haGQr
 Xwj1uFDnsIwfsLv2uygjKsaDGwfOH3XeMtx4Fdft/F7YK0IBIX8d/ik3hiuwIxALvqWgaDT5Rxl
 XKXByWZtDY+q9CSh0nABqXpW2aDV6orVBoRJhazLzGUTGktb7fJS0ngqLP2eDXeywN75/eIEbCz
 gUiC1L5RtAyC02PsJioMAXwp6dpUW8+fk6evYwfgdcSlr+HNjwn7skL7Hh8mcWuz6QD3/iJqemw
 /eSxH5l4fons2U6wPmUgMzK7sCHiNVKgjY2nBVoSeuVpQwADviIeMYcfmNK8l+XjTKwFqh0bDyE
 C87rzKSZ75ZtUb6UHLADX5iytxqOkY2KADiiSoq3EA76e4GWKtBArGHM6KVv9v9PgRznMRoH7z3
 IvKvtWkiyIlDRw13jXpDYih+XNyHS55T9U6NJcdWrmr4mcukaYsNzGG7/fDC6W6RUb
X-Received: by 2002:a05:6a00:114f:b0:823:172f:f0c with SMTP id
 d2e1a72fcca58-823692922c4mr9112043b3a.45.1769708308556; 
 Thu, 29 Jan 2026 09:38:28 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82379b222f1sm6706246b3a.7.2026.01.29.09.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 09:38:28 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 14/21] tests/tcg/plugins/mem.c: remove dependency on qemu
 headers
Date: Thu, 29 Jan 2026 09:38:00 -0800
Message-ID: <20260129173811.138036-15-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x435.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This plugin uses endianness conversion primitives from QEMU headers. As
next commit will strongly isolate plugins code from those headers, those
primitives can't be used anymore.

glib.h provides such primitives:
https://docs.gtk.org/glib/conversion-macros.html#byte-order-conversion

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/qemu-devel/20260124182921.531562-6-pierrick.bouvier@linaro.org
Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 tests/tcg/plugins/mem.c | 59 ++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 36 deletions(-)

diff --git a/tests/tcg/plugins/mem.c b/tests/tcg/plugins/mem.c
index 9649bce99ca..7d64e7018f2 100644
--- a/tests/tcg/plugins/mem.c
+++ b/tests/tcg/plugins/mem.c
@@ -12,16 +12,7 @@
 #include <stdio.h>
 #include <glib.h>
 
-/*
- * plugins should not include anything from QEMU aside from the
- * API header. However as this is a test plugin to exercise the
- * internals of QEMU and we want to avoid needless code duplication we
- * do so here. bswap.h is pretty self-contained although it needs a
- * few things provided by compiler.h.
- */
-#include <compiler.h>
 #include <stdbool.h>
-#include <bswap.h>
 #include <qemu-plugin.h>
 
 QEMU_PLUGIN_EXPORT int qemu_plugin_version = QEMU_PLUGIN_VERSION;
@@ -152,56 +143,52 @@ static void update_region_info(uint64_t region, uint64_t offset,
         ri->reads++;
     }
 
+    void *ri_data = &ri->data[offset];
     switch (value.type) {
     case QEMU_PLUGIN_MEM_VALUE_U8:
+    {
+        uint8_t val = value.data.u8;
+        uint8_t *p = ri_data;
         if (is_store) {
-            ri->data[offset] = value.data.u8;
-        } else if (ri->data[offset] != value.data.u8) {
-            unseen_data = true;
+            *p = val;
+        } else {
+            unseen_data = *p != val;
         }
         break;
+    }
     case QEMU_PLUGIN_MEM_VALUE_U16:
     {
-        uint16_t *p = (uint16_t *) &ri->data[offset];
+        uint16_t val = be ? GUINT16_FROM_BE(value.data.u16) :
+                            GUINT16_FROM_LE(value.data.u16);
+        uint16_t *p = ri_data;
         if (is_store) {
-            if (be) {
-                stw_be_p(p, value.data.u16);
-            } else {
-                stw_le_p(p, value.data.u16);
-            }
+            *p = val;
         } else {
-            uint16_t val = be ? lduw_be_p(p) : lduw_le_p(p);
-            unseen_data = val != value.data.u16;
+            unseen_data = *p != val;
         }
         break;
     }
     case QEMU_PLUGIN_MEM_VALUE_U32:
     {
-        uint32_t *p = (uint32_t *) &ri->data[offset];
+        uint32_t val = be ? GUINT32_FROM_BE(value.data.u32) :
+                            GUINT32_FROM_LE(value.data.u32);
+        uint32_t *p = ri_data;
         if (is_store) {
-            if (be) {
-                stl_be_p(p, value.data.u32);
-            } else {
-                stl_le_p(p, value.data.u32);
-            }
+            *p = val;
         } else {
-            uint32_t val = be ? ldl_be_p(p) : ldl_le_p(p);
-            unseen_data = val != value.data.u32;
+            unseen_data = *p != val;
         }
         break;
     }
     case QEMU_PLUGIN_MEM_VALUE_U64:
     {
-        uint64_t *p = (uint64_t *) &ri->data[offset];
+        uint64_t val = be ? GUINT64_FROM_BE(value.data.u64) :
+                            GUINT64_FROM_LE(value.data.u64);
+        uint64_t *p = ri_data;
         if (is_store) {
-            if (be) {
-                stq_be_p(p, value.data.u64);
-            } else {
-                stq_le_p(p, value.data.u64);
-            }
+            *p = val;
         } else {
-            uint64_t val = be ? ldq_be_p(p) : ldq_le_p(p);
-            unseen_data = val != value.data.u64;
+            unseen_data = *p != val;
         }
         break;
     }
-- 
2.47.3


