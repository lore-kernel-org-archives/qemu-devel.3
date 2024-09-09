Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0656CECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 13:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snel1-0008W6-8i; Mon, 09 Sep 2024 09:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1sneky-0008UX-Me
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:48:40 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1snekx-00009S-3J
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 09:48:40 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d1daa2577bso3139699a91.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 06:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1725889717; x=1726494517;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=368uvjWdieiurybOR+FslAHDldotj//VpXJQhIwe/k0=;
 b=gbZ6tFsKi2wecGVTXfj+9vxRuypWZIGvlfWXuJnB5e8MCG0rydgtykbiEaaIC1nJvx
 HCH9rRmHcLXBpkItogCqbdEh23dlk3r1kgmO5LmZzUMfT9fdNijE3I9FbnU9RRNd+yQz
 9g+XHNugO95e0teqIIYRsGM8KF+SjgyS7Q2ad4tNDcBWOLtwNX4oxOMMatP0iQhGRJJs
 pyykoMHTdFgjPtbL1YhCTmQGS5Dn+u4ndh3+xuXKZx46VEhFsHUKulFN0/MFR0gyRMDz
 yzd84EM8MZLmVktsHEev6Ste+/wavkTZinKA1+lSsBgAqGYl4HULxm8Ud40PzgIU0QYT
 Sc6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725889717; x=1726494517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=368uvjWdieiurybOR+FslAHDldotj//VpXJQhIwe/k0=;
 b=fUcWC1DjgxbzwSzlPrOFrIxoch6BxA16F2v+wggwG9jkQu3u4jbFlX8AjDCfNrDxNF
 YWOJ1u9XLU2dMSSPgpPhDXCDX78Htqu/y4qCzeDa/irymkbprkNWr63KHiBMQWaRGUVF
 q/mG2XSws0Jy1zavW/TGZgctc3UUs3hrtkqtaVTCZDacbmUWwPVkqBghqOmp6+MXicfn
 SZIVtiC7rjmNppkY6yKa0urDrOfHjMR7dpHBPjls0D5JjojoMH9Ii+0l3p3CyR5YImeT
 n5eNWsgSwdL2J1sXYFAUAdj+D4y093Kud/mdXwhEV2EWfD1zPAdmqcTGoVbi/YFReefy
 1LPA==
X-Gm-Message-State: AOJu0YzrzqH8PSee9mjdfJKUaVXAVOHmXCL2ec8791hP/Q/roTcQSY6X
 Ff9Alka5H4fNJCe8lJrWZ2lF4w1EEcf5383jR01mInDJha3bAE43MXWtYHG5fhq5cnTJZ3NSpIY
 NdsD8fQ==
X-Google-Smtp-Source: AGHT+IGLPCD4koe9ZC8XLlKtT7Nj5CTHsx1eG5yOTBdRvi0jGrA3J48HvG0MdDwcrBmftu7L6PphQQ==
X-Received: by 2002:a17:90a:ec87:b0:2da:802d:1f95 with SMTP id
 98e67ed59e1d1-2dafcef4703mr8423218a91.5.1725889716826; 
 Mon, 09 Sep 2024 06:48:36 -0700 (PDT)
Received: from localhost.localdomain ([118.114.94.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dab2c6b0b9sm7841031a91.0.2024.09.09.06.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 06:48:36 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, yong.huang@smartx.com
Subject: [PATCH RFC 01/10] migration: Introduce structs for periodic CPU
 throttle
Date: Mon,  9 Sep 2024 21:47:13 +0800
Message-Id: <f318fd75af3d137a795c699d25dec7e21d756095.1725889277.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1725889277.git.yong.huang@smartx.com>
References: <cover.1725889277.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1036.google.com
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


