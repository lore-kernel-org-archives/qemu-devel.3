Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26259D5AE7C
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 09:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8zGJ-00080H-3u; Thu, 07 Nov 2024 04:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t8zGG-0007zm-8R
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:57:08 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1t8zGD-0005EH-Sl
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 04:57:08 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2e2a999b287so626752a91.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 01:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1730973423; x=1731578223;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EoaV+03QvTu6WP8sJ+9r3MumZMCi97oZx93fGFaJShw=;
 b=1AUiaDs/tQAJ8Son0JkL9DYhfWhUKNtDN5OrGlVheSfP4+GbxdqDQDHjI1b2xarQ57
 25Fb8Q4pn3cpTv9ND+yZ+V3E0anz8YXHGF7L4oApY9H7wFRmM8zTYdpnYGgnX0JAJOle
 eN0K+XXNg6I4j96ssVfJY8m7MayJLinEVetGGc6d67eh94AEGxVkh55qlb1mzIprzMXt
 G/VrNWYO+QTwCxw4SqSbJC4NSP1l6pLwv+jwgJHM/PVslwZBWK6wdeMhY31U6FyaDwAM
 0IT6huvFAlTkkIgH3lg8Cd1SoEVDrPRCO+aWC3a/cohSaqwPtZRLeUp6y7+HCnWizYHU
 3DTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730973423; x=1731578223;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EoaV+03QvTu6WP8sJ+9r3MumZMCi97oZx93fGFaJShw=;
 b=n3bkgV84Rth/714hLR1RIIc26BOt+338RJxjkcJM7RPpJLJnPcl5Dvmb6W9lCzBuHf
 6shd0f+XC4Po8Wabwjl4mmrerq5prxH9bqy0slH25Xn5Gl5Ymxij+rH807uBbNRtRJKL
 C3nqV97k4iQRvpz3VypmeKqviYYJr2rwpyN3DH8UvY76rTF+TQSF1kRlRYsjbvYVQBSV
 OGgl+KlrLM1iiCVw6LRvI9bIUSlpRZz1D/4jsde3io7a1DnR0phLvcEA/wFbvAK+XqGc
 M9F7feR8vBLIajsPgl5a4aZ0IMkDfpw4rIRYYt8+jjeo3xmLN0nWY00S3WyXfzrUrC1m
 iUDA==
X-Gm-Message-State: AOJu0YxNaNR9jc8e5X/RCZkhmfmvbqbieYpDy9JGLPjsuphN/eNFDprt
 r25ZOe/faH3V3ocF1AKGqkcaIsROGnoSaN4ZBKFN/NdNvoRwAIf4HMb+fll6FXhCw+kpy5f1Myo
 4BrA4lw==
X-Google-Smtp-Source: AGHT+IFnPCZO6vrC51dB1DA6HPA/QkpcwZ6sjGT93+j3ZIva4m6euqSQqdZhMyVBO58iCFp1m4Y7+Q==
X-Received: by 2002:a17:90b:5444:b0:2e2:8995:dd1b with SMTP id
 98e67ed59e1d1-2e9aaff9a68mr529532a91.3.1730973422311; 
 Thu, 07 Nov 2024 01:57:02 -0800 (PST)
Received: from Hyman-Dev-Euler.zelin.local ([103.172.41.205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e9a5f90ce5sm1149970a91.31.2024.11.07.01.57.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Nov 2024 01:57:01 -0800 (PST)
From: yong.huang@smartx.com
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 yong.huang@smartx.com
Subject: [PATCH] migration: Do not perform RAMBlock dirty sync during the
 first iteration
Date: Thu,  7 Nov 2024 17:56:50 +0800
Message-Id: <ad543bac0eb9e7113eaec266add58c19f9f6eda0.1730973055.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.27.0
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

From: Hyman Huang <yong.huang@smartx.com>

The first iteration's RAMBlock dirty sync can be omitted because QEMU
always initializes the RAMBlock's bmap to all 1s by default.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 migration/cpu-throttle.c |  2 +-
 migration/ram.c          | 19 ++++++++++++++++---
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/migration/cpu-throttle.c b/migration/cpu-throttle.c
index 5179019e33..674dc2004e 100644
--- a/migration/cpu-throttle.c
+++ b/migration/cpu-throttle.c
@@ -141,7 +141,7 @@ void cpu_throttle_dirty_sync_timer_tick(void *opaque)
      * effect on guest performance, therefore omit it to avoid
      * paying extra for the sync penalty.
      */
-    if (sync_cnt <= 1) {
+    if (!sync_cnt) {
         goto end;
     }
 
diff --git a/migration/ram.c b/migration/ram.c
index 05ff9eb328..a0123eb93e 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -2718,7 +2718,7 @@ static void ram_list_init_bitmaps(void)
 {
     MigrationState *ms = migrate_get_current();
     RAMBlock *block;
-    unsigned long pages;
+    unsigned long pages, clear_bmap_pages;
     uint8_t shift;
 
     /* Skip setting bitmap if there is no RAM */
@@ -2736,6 +2736,7 @@ static void ram_list_init_bitmaps(void)
 
         RAMBLOCK_FOREACH_NOT_IGNORED(block) {
             pages = block->max_length >> TARGET_PAGE_BITS;
+            clear_bmap_pages = clear_bmap_size(pages, shift);
             /*
              * The initial dirty bitmap for migration must be set with all
              * ones to make sure we'll migrate every guest RAM page to
@@ -2751,7 +2752,12 @@ static void ram_list_init_bitmaps(void)
                 block->file_bmap = bitmap_new(pages);
             }
             block->clear_bmap_shift = shift;
-            block->clear_bmap = bitmap_new(clear_bmap_size(pages, shift));
+            block->clear_bmap = bitmap_new(clear_bmap_pages);
+            /*
+             * Set clear_bmap to 1 unconditionally, as we always set bmap
+             * to all 1s by default.
+             */
+            bitmap_set(block->clear_bmap, 0, clear_bmap_pages);
         }
     }
 }
@@ -2771,6 +2777,7 @@ static void migration_bitmap_clear_discarded_pages(RAMState *rs)
 
 static bool ram_init_bitmaps(RAMState *rs, Error **errp)
 {
+    Error *local_err = NULL;
     bool ret = true;
 
     qemu_mutex_lock_ramlist();
@@ -2783,7 +2790,13 @@ static bool ram_init_bitmaps(RAMState *rs, Error **errp)
             if (!ret) {
                 goto out_unlock;
             }
-            migration_bitmap_sync_precopy(false);
+            /*
+             * Bypass the RAMBlock dirty sync and still publish the
+             * notification.
+             */
+            if (precopy_notify(PRECOPY_NOTIFY_AFTER_BITMAP_SYNC, &local_err)) {
+                error_report_err(local_err);
+            }
         }
     }
 out_unlock:
-- 
2.27.0


