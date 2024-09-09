Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E658ECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:26:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfL6-0000XU-4v; Mon, 09 Sep 2024 10:26:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfL4-0000Qj-H4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:25:58 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snfL2-0004Sn-9R
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:25:58 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-717929b671eso3436447b3a.0
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725891955; x=1726496755;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=368uvjWdieiurybOR+FslAHDldotj//VpXJQhIwe/k0=;
 b=2Qt13YCtr1mKLVLc7RBBP2dRtInfUur6QbFCTLpWqraaUI9mCDwE3W9AijLEbgdF0t
 PeIkMgId1kO9WkohLU/xX9EnERJpOZrsqpdLdhAwo0aNpUMpC04rOHAHK+nijbrrY02M
 tsVvuZoVtsn6vYsJ+4DdIRiKdqSssAlP+jMAnKgkoAT6UglTKJecfZp/kSUF1BZptAc3
 8K5m1xBbxq26u8PruJAxUbBv90i5p00ScNpDB53OU3rysqKkI/8aj2Krf4TfGcwbI/Ua
 z1lDtSQGND2xb4cegsgWN8epQC2dwkOfFYOknJTX5oNQfA9zP/+Hy/groG6Wg8rhDcsW
 DJfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725891955; x=1726496755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=368uvjWdieiurybOR+FslAHDldotj//VpXJQhIwe/k0=;
 b=TpyupWjcKsJ5aTHUe7KBqBSgCwhREqtRGXrZjsROUatiYvhdK7zuVXM8RhIDDe9+VS
 r2bnkQJY6FfQfg7+FFZd1hpVcir+uLVdxDvBlsfNKL5QS/CduMa4KZHEXkm+du8a0ZBq
 n15cK66xmbQALcFXnxag9UCG5jKOmH97Q3ioBY49UF6lpgjaEqPO6X+MDkwkDH+YCsjW
 7G6RCDk75rY7McxIupQB0EoGWUQuI7KUX5S5nz7BpxIl+OiUzxW6XJmz9UNjFks+h5Ht
 Ef33wIlBZAvDQwxG7l6m9YADRb8smMyzS3oGvQDh4D//JejWAm7h8gGLl9Xo6KAP/prJ
 kNzw==
X-Gm-Message-State: AOJu0Yw5jpQn4YQ95yP8yCVDsVGzNWlqeN0GgEny3mqwksaksMOShj59
 LUoLHDdcm36C+C5agO05TaLxFkUwxYnaGfnxuDyPlygywYhmQxoSjPf+zTpPdmh40Os+Os38Eoe
 A71JYYw==
X-Google-Smtp-Source: AGHT+IEtWOPpUJwtoPHbtmpNCecPdBne9wxuYxVuf9EjOqqzJPihVoNrW7Xp7CisLEgoaba63/bOyA==
X-Received: by 2002:a05:6a00:179a:b0:706:5dab:83c4 with SMTP id
 d2e1a72fcca58-718d5e5c728mr11910498b3a.14.1725891954142; 
 Mon, 09 Sep 2024 07:25:54 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-718e58b2a88sm3561164b3a.46.2024.09.09.07.25.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:25:53 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RESEND RFC 01/10] migration: Introduce structs for periodic
 CPU throttle
Date: Mon,  9 Sep 2024 22:25:34 +0800
Message-Id: <f318fd75af3d137a795c699d25dec7e21d756095.1725891841.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725891841.git.yong.huang@smartx.com>
References: <cover.1725891841.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

shadow_bmap, iter_bmap, iter_dirty_pages and
periodic_sync_shown_up are introduced to satisfy the need
for periodic CPU throttle.

Meanwhile, introduce enumeration of dirty bitmap sync method.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 include/exec/ramblock.h | 45 +++++++++++++++++++++++++++++++++++++++++
 migration/ram.c         |  6 ++++++
 2 files changed, 51 insertions(+)

diff --git a/include/exec/ramblock.h b/include/exec/ramblock.h
index 0babd105c0..619c52885a 100644
--- a/include/exec/ramblock.h
+++ b/include/exec/ramblock.h
@@ -24,6 +24,30 @@
 #include "qemu/rcu.h"
 #include "exec/ramlist.h"
 
+/* Possible bits for migration_bitmap_sync */
+
+/*
+ * The old-fashioned sync method, which is, in turn, used for CPU
+ * throttle and memory transfer.
+ */
+#define RAMBLOCK_SYN_LEGACY_ITER    (1U << 0)
+
+/*
+ * The modern sync method, which is, in turn, used for CPU throttle
+ * and memory transfer.
+ */
+#define RAMBLOCK_SYN_MODERN_ITER    (1U << 1)
+
+/* The modern sync method, which is used for CPU throttle only */
+#define RAMBLOCK_SYN_MODERN_PERIOD  (1U << 2)
+
+#define RAMBLOCK_SYN_MASK   (0x7)
+
+typedef enum RAMBlockSynMode {
+    RAMBLOCK_SYN_LEGACY,    /* Old-fashined mode */
+    RAMBLOCK_SYN_MODERN,
+} RAMBlockSynMode;
+
 struct RAMBlock {
     struct rcu_head rcu;
     struct MemoryRegion *mr;
@@ -89,6 +113,27 @@ struct RAMBlock {
      * could not have been valid on the source.
      */
     ram_addr_t postcopy_length;
+
+    /*
+     * Used to backup the bmap during periodic sync to see whether any dirty
+     * pages were sent during that time.
+     */
+    unsigned long *shadow_bmap;
+
+    /*
+     * The bitmap "bmap," which was initially used for both sync and memory
+     * transfer, will be replaced by two bitmaps: the previously used "bmap"
+     * and the recently added "iter_bmap." Only the memory transfer is
+     * conducted with the previously used "bmap"; the recently added
+     * "iter_bmap" is utilized for sync.
+     */
+    unsigned long *iter_bmap;
+
+    /* Number of new dirty pages during iteration */
+    uint64_t iter_dirty_pages;
+
+    /* If periodic sync has shown up during iteration */
+    bool periodic_sync_shown_up;
 };
 #endif
 #endif
diff --git a/migration/ram.c b/migration/ram.c
index 67ca3d5d51..f29faa82d6 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2362,6 +2362,10 @@ static void ram_bitmaps_destroy(void)
         block->bmap = NULL;
         g_free(block->file_bmap);
         block->file_bmap = NULL;
+        g_free(block->shadow_bmap);
+        block->shadow_bmap = NULL;
+        g_free(block->iter_bmap);
+        block->iter_bmap = NULL;
     }
 }
 
@@ -2753,6 +2757,8 @@ static void ram_list_init_bitmaps(void)
             }
             block->clear_bmap_shift = shift;
             block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
+            block->shadow_bmap = bitmap_new(pages);
+            block->iter_bmap = bitmap_new(pages);
         }
     }
 }
-- 
2.39.1


