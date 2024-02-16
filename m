Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BB5C48BF3
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 22:42:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb6tO-0004yM-P3; Fri, 16 Feb 2024 17:41:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tM-0004v1-68
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:12 -0500
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rb6tK-0007Ia-Bu
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 17:41:11 -0500
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-4c015883a13so395642e0c.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 14:41:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1708123269; x=1708728069; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvpt2MlZ0tbwr8cgiAzgK+uI+W/ZNpZ/DpKFqWpBVDc=;
 b=JTmKksnSPm7Iqb/aBS8xgpxpZlPzVT+zNQM/OKmAQGGjJsdUIxN5xyaaiGQnexiJ7d
 ElxxlyKpy01J+JD9ZgF4STkHvNMGl9B5lblJ1haSMSIiDSAmT97FA2wy/7tvjcDWV0hC
 h2fj8+KSiZuf4JF9xrJho5LlkswSdg3Xi5pAKu9fE0Ytl6q3yjUIxCLhpfWXqI2lBNvB
 fzqlILwYf3Lve+xBo9aV8r4yMy3U7oj5WHKKMCQXNChkwwm3Yr/+2sVEWP2z4t/AtuX6
 eDyhCM0FMFhf0+imxkhRiQKO8DPCg0WSYBCap2UwEbtR06nuu1wjJH/uLqWBKO6Vuz49
 q6ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708123269; x=1708728069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fvpt2MlZ0tbwr8cgiAzgK+uI+W/ZNpZ/DpKFqWpBVDc=;
 b=uVAQafr8kuaemPc9HjwfX3X24TZvCU4qGNmkQIf77bQ3D0iUczl7krWX1yhOf/GPFd
 SbDGP4rmjZYHz5aFPyg0WMqwZYM3jiZg6tU74gJzoPRVSSVLbfr0Sdo7ZMXVnDNuoXac
 aqllV9XBI6M36fXVbh6hD8TwF0I5lA5qvb/xZq5F0rTJVT4JRhYf58BSyXEbHUGbIPd+
 4WTIrTsjp5/4FCspTdfzbrQErOgT7v9Ws1yjfb60RZAsuqXXrGFSR9qG43V2g/PO1iZT
 A5tOaoj6XXR63qGYpDfKzT5n8RJTCgnjRsQB5FrSBkMt16tLk1PoRDX4NWZPpIIFwuUz
 5TSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUuO1o6zuNyd7bhWmwPi/lp1xzNDCSY9KvXhk4bSkJ6bqQxYn4GGEA/tR/x1x6/9zwrwd5v52Fv1JeyxgJkC0sEh30i+jI=
X-Gm-Message-State: AOJu0YxIo+5TbFPQ3NuT5qEUoK7YSDTU41a/A0VJVzEzhbD2Z+7Ml8yT
 0fngRhUoN9K0CZW/BK3ulMfjM32ZhI3IRCh/GSnNnp9TJX48Hmc63RB8CV6bzRI=
X-Google-Smtp-Source: AGHT+IELGioLAf8VHpiOIIlebMrU2v8lgXxhXi3dhvFb4yrLU01i8xLFBhL6J9DXMdmzTvB992SdbQ==
X-Received: by 2002:a1f:4804:0:b0:4bd:32c9:acb with SMTP id
 v4-20020a1f4804000000b004bd32c90acbmr5291648vka.7.1708123269125; 
 Fri, 16 Feb 2024 14:41:09 -0800 (PST)
Received: from n231-230-216.byted.org ([130.44.212.104])
 by smtp.gmail.com with ESMTPSA id
 cz18-20020a056122449200b004c0a12c4d53sm120991vkb.51.2024.02.16.14.41.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 14:41:08 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, lvivier@redhat.com, qemu-devel@nongnu.org,
 jdenemar@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH v2 4/7] migration/multifd: Enable zero page checking from
 multifd threads.
Date: Fri, 16 Feb 2024 22:39:59 +0000
Message-Id: <20240216224002.1476890-5-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240216224002.1476890-1-hao.xiang@bytedance.com>
References: <20240216224002.1476890-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vk1-xa34.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This change adds a dedicated handler for MigrationOps::ram_save_target_page in
multifd live migration. Now zero page checking can be done in the multifd threads
and this becomes the default configuration. We still provide backward compatibility
where zero page checking is done from the migration main thread.

Signed-off-by: Hao Xiang <hao.xiang@bytedance.com>
---
 migration/multifd.c |  1 +
 migration/options.c |  2 +-
 migration/ram.c     | 53 ++++++++++++++++++++++++++++++++++-----------
 3 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index fbb40ea10b..ef5dad1019 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "qemu/cutils.h"
 #include "qemu/rcu.h"
+#include "qemu/cutils.h"
 #include "exec/target_page.h"
 #include "sysemu/sysemu.h"
 #include "exec/ramblock.h"
diff --git a/migration/options.c b/migration/options.c
index 3c603391b0..3c79b6ccd4 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -181,7 +181,7 @@ Property migration_properties[] = {
                       MIG_MODE_NORMAL),
     DEFINE_PROP_ZERO_PAGE_DETECTION("zero-page-detection", MigrationState,
                        parameters.zero_page_detection,
-                       ZERO_PAGE_DETECTION_LEGACY),
+                       ZERO_PAGE_DETECTION_MULTIFD),
 
     /* Migration capabilities */
     DEFINE_PROP_MIG_CAP("x-xbzrle", MIGRATION_CAPABILITY_XBZRLE),
diff --git a/migration/ram.c b/migration/ram.c
index 5ece9f042e..b088c5a98c 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1123,10 +1123,6 @@ static int save_zero_page(RAMState *rs, PageSearchStatus *pss,
     QEMUFile *file = pss->pss_channel;
     int len = 0;
 
-    if (migrate_zero_page_detection() != ZERO_PAGE_DETECTION_LEGACY) {
-        return 0;
-    }
-
     if (!buffer_is_zero(p, TARGET_PAGE_SIZE)) {
         return 0;
     }
@@ -1256,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
 
 static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
 {
+    assert(migrate_multifd());
+    assert(!migrate_compress());
+    assert(!migration_in_postcopy());
+
     if (!multifd_queue_page(block, offset)) {
         return -1;
     }
@@ -2046,7 +2046,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
  */
 static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
 {
-    RAMBlock *block = pss->block;
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
@@ -2062,17 +2061,40 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
         return 1;
     }
 
+    return ram_save_page(rs, pss);
+}
+
+/**
+ * ram_save_target_page_multifd: save one target page
+ *
+ * Returns the number of pages written
+ *
+ * @rs: current RAM state
+ * @pss: data about the page we want to send
+ */
+static int ram_save_target_page_multifd(RAMState *rs, PageSearchStatus *pss)
+{
+    RAMBlock *block = pss->block;
+    ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
+
+    /* Multifd is not compatible with old compression. */
+    assert(!migrate_compress());
+
+    /* Multifd is not compabible with postcopy. */
+    assert(!migration_in_postcopy());
+
     /*
-     * Do not use multifd in postcopy as one whole host page should be
-     * placed.  Meanwhile postcopy requires atomic update of pages, so even
-     * if host page size == guest page size the dest guest during run may
-     * still see partially copied pages which is data corruption.
+     * Backward compatibility support. While using multifd live
+     * migration, we still need to handle zero page checking on the
+     * migration main thread.
      */
-    if (migrate_multifd() && !migration_in_postcopy()) {
-        return ram_save_multifd_page(block, offset);
+    if (migrate_zero_page_detection() == ZERO_PAGE_DETECTION_LEGACY) {
+        if (save_zero_page(rs, pss, offset)) {
+            return 1;
+        }
     }
 
-    return ram_save_page(rs, pss);
+    return ram_save_multifd_page(block, offset);
 }
 
 /* Should be called before sending a host page */
@@ -2984,7 +3006,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
     }
 
     migration_ops = g_malloc0(sizeof(MigrationOps));
-    migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+
+    if (migrate_multifd()) {
+        migration_ops->ram_save_target_page = ram_save_target_page_multifd;
+    } else {
+        migration_ops->ram_save_target_page = ram_save_target_page_legacy;
+    }
 
     bql_unlock();
     ret = multifd_send_sync_main();
-- 
2.30.2


