Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18473C4829A
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 23:21:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXUk2-0006Ec-2A; Tue, 06 Feb 2024 18:20:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjz-0006EF-U0
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:35 -0500
Received: from mail-vs1-xe2d.google.com ([2607:f8b0:4864:20::e2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <hao.xiang@bytedance.com>)
 id 1rXUjk-0005n5-Sc
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 18:20:35 -0500
Received: by mail-vs1-xe2d.google.com with SMTP id
 ada2fe7eead31-46d49b31e76so330025137.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 15:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1707261619; x=1707866419; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlfCHJI8BMYL5xByh2htwg446RRZbeVbn6VxSty6oBo=;
 b=EY/lQetEeYfkoO6PrHKm+JJkmpv7HQ46F/X4Jtf0e3SRWv00MLlE122QbmfGnvVUPP
 1g4nucOVTHHMYOg172AJnuOIABlhCkgS3vEs6q4CeHFqHLUhN06P2M4i6OJhZLg65Zw6
 dWRepjF01CVnSxZi2EQYFNQ1FdgVfXrjYR0XFaUcQmnWXGoU7eXVT36L6oOalG27k4r9
 42hn+BujkmWd3z8yFtN8hHhztC7KaVaUdvA6LtbI/eFjL3g5RpDSgMw/2AscYPQVgYrJ
 r60YMZ/KkbDyVTLAe2TQuaL+UlUgXDQgFS4vDND3OPJ7Cmvq63Fq6beMlJhhS24Yut95
 p/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707261619; x=1707866419;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RlfCHJI8BMYL5xByh2htwg446RRZbeVbn6VxSty6oBo=;
 b=qGHFkx9t0nVNZj1t5BnLuWNuiCx9WvDD3cU3sfRV9FsAK/XzF9zMthtZpNZwpKhIfk
 SC52K7xIQ6yCGdaV0zgNr0Xg22C2/spXhCojOAFHCC+7smwnEZHspzsPKw35rNRzc5QS
 ZWqtdrGqF6UvqwpPeGAGqJv6nii331PMGAHqcHJNcmp76zxf+JdUnZLcmBNtasZqZWwj
 AdUftDf+iPQyGRf/SgvCXiWfcy84VczZq/d1YxMeClcwYvmchXqBf9uDVuMMzbzgNJHT
 p7FBcBKq5359onaTle/aiJMRBxiJ70en8SVUGv00nZhURWFkb/1ln/dIFjL2izK7pOiI
 rwpA==
X-Gm-Message-State: AOJu0YztXAbby2auAAImMC4w96VKWLVXwGEDosshrhbWYyzvtxdkzMo1
 +QIngkgD/Wj9T26vjvHOcNw5lYPTncbUsIsIE9ERprBO7OV+rtGndKsfO6GnDFqgb96BcY10hoO
 5oHs=
X-Google-Smtp-Source: AGHT+IGgnPZosJsxkryP7wd6hhRRfBOsvVRx0ahS3t6fNKP3NUw7efGHioXEx/i6cy0Ids1IjhOgAA==
X-Received: by 2002:a05:6102:21ba:b0:46d:372a:d114 with SMTP id
 i26-20020a05610221ba00b0046d372ad114mr683387vsb.16.1707261619181; 
 Tue, 06 Feb 2024 15:20:19 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXnZ8LT2OnrNb13AB1D0zIynOW9qnioXJFSJT76IUOjlxBnPXn/NvL1FVyd66yZpoe5+pGoGOH+p/JsLCcc4LI4xgmvcD3tZycVEx/wAKl8dDOg
Received: from n231-230-216.byted.org ([130.44.215.112])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a67b60b000000b0046d20ce8886sm2352vsm.1.2024.02.06.15.20.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Feb 2024 15:20:18 -0800 (PST)
From: Hao Xiang <hao.xiang@bytedance.com>
To: qemu-devel@nongnu.org,
	farosas@suse.de,
	peterx@redhat.com
Cc: Hao Xiang <hao.xiang@bytedance.com>
Subject: [PATCH 5/6] migration/multifd: Enable zero page checking from multifd
 threads.
Date: Tue,  6 Feb 2024 23:19:07 +0000
Message-Id: <20240206231908.1792529-6-hao.xiang@bytedance.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240206231908.1792529-1-hao.xiang@bytedance.com>
References: <20240206231908.1792529-1-hao.xiang@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2d;
 envelope-from=hao.xiang@bytedance.com; helo=mail-vs1-xe2d.google.com
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
 migration/multifd.c |  3 ++-
 migration/ram.c     | 49 ++++++++++++++++++++++++++++++++++++---------
 2 files changed, 42 insertions(+), 10 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index c031f947c7..c6833ccb07 100644
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
@@ -458,7 +459,6 @@ static int multifd_send_pages(void)
     p->packet_num = multifd_send_state->packet_num++;
     multifd_send_state->pages = p->pages;
     p->pages = pages;
-
     qemu_mutex_unlock(&p->mutex);
     qemu_sem_post(&p->sem);
 
@@ -733,6 +733,7 @@ static void *multifd_send_thread(void *opaque)
         if (p->pending_job) {
             uint64_t packet_num = p->packet_num;
             uint32_t flags;
+
             p->normal_num = 0;
             p->zero_num = 0;
 
diff --git a/migration/ram.c b/migration/ram.c
index d5b7cd5ac2..e6742c9593 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1252,6 +1252,10 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
 
 static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
 {
+    assert(migrate_multifd());
+    assert(!migrate_compress());
+    assert(!migration_in_postcopy());
+
     if (multifd_queue_page(block, offset) < 0) {
         return -1;
     }
@@ -2043,7 +2047,6 @@ static bool save_compress_page(RAMState *rs, PageSearchStatus *pss,
  */
 static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
 {
-    RAMBlock *block = pss->block;
     ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
     int res;
 
@@ -2059,17 +2062,40 @@ static int ram_save_target_page_legacy(RAMState *rs, PageSearchStatus *pss)
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
+    if (!migrate_multifd_zero_page()) {
+        if (save_zero_page(rs, pss, offset)) {
+            return 1;
+        }
     }
 
-    return ram_save_page(rs, pss);
+    return ram_save_multifd_page(block, offset);
 }
 
 /* Should be called before sending a host page */
@@ -2981,7 +3007,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
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


