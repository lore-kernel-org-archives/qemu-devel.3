Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F0F9C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:29:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQXA-0003le-73; Wed, 13 Mar 2024 11:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQX6-0003j8-Br; Wed, 13 Mar 2024 11:28:44 -0400
Received: from forwardcorp1a.mail.yandex.net ([178.154.239.72])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQWz-0002ka-Sl; Wed, 13 Mar 2024 11:28:44 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c2a:3dc:0:640:1e66:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id A744260FFD;
 Wed, 13 Mar 2024 18:28:32 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id OSpDOX0Xl4Y0-eI0p3pkl; Wed, 13 Mar 2024 18:28:32 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710343712;
 bh=JdkO3BaRxDDY9A6KPKVow2YjnqSV0Pn9ZqlRC7UFJ2Q=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=lsaLLpX3tnKYnyualMAYmGy4+Wd0sRmAgtWneBeY/aBh6qToaD2Jo5ZvuNZ5gyYxF
 8nH9nJWojL+M3tzCh90Hyn4ZRW/l1L2iuM8jUoXt28IXJa+DE7F+2z7kYmZA7FGHAP
 8/ZNsxUTpmbLcu5NoELI3wU7RXZBzfVF5mf5P1ms=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, armbru@redhat.com, eblake@redhat.com,
 xiechanglong.d@gmail.com, wencongyang2@huawei.com, hreitz@redhat.com,
 kwolf@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 f.ebner@proxmox.com
Subject: [PATCH v4 3/5] block/copy-before-write: create block_copy bitmap in
 filter node
Date: Wed, 13 Mar 2024 18:28:20 +0300
Message-Id: <20240313152822.626493-4-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313152822.626493-1-vsementsov@yandex-team.ru>
References: <20240313152822.626493-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=178.154.239.72;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
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

Currently block_copy creates copy_bitmap in source node. But that is in
bad relation with .independent_close=true of copy-before-write filter:
source node may be detached and removed before .bdrv_close() handler
called, which should call block_copy_state_free(), which in turn should
remove copy_bitmap.

That's all not ideal: it would be better if internal bitmap of
block-copy object is not attached to any node. But that is not possible
now.

The simplest solution is just create copy_bitmap in filter node, where
anyway two other bitmaps are created.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Fiona Ebner <f.ebner@proxmox.com>
Tested-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/block-copy.c         |   3 +-
 block/copy-before-write.c  |   2 +-
 include/block/block-copy.h |   1 +
 tests/qemu-iotests/257.out | 112 ++++++++++++++++++-------------------
 4 files changed, 60 insertions(+), 58 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index 9ee3dd7ef5..8fca2c3698 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -351,6 +351,7 @@ static int64_t block_copy_calculate_cluster_size(BlockDriverState *target,
 }
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
+                                     BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      Error **errp)
 {
@@ -367,7 +368,7 @@ BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
         return NULL;
     }
 
-    copy_bitmap = bdrv_create_dirty_bitmap(source->bs, cluster_size, NULL,
+    copy_bitmap = bdrv_create_dirty_bitmap(copy_bitmap_bs, cluster_size, NULL,
                                            errp);
     if (!copy_bitmap) {
         return NULL;
diff --git a/block/copy-before-write.c b/block/copy-before-write.c
index 6d89af0b29..ed2c228da7 100644
--- a/block/copy-before-write.c
+++ b/block/copy-before-write.c
@@ -468,7 +468,7 @@ static int cbw_open(BlockDriverState *bs, QDict *options, int flags,
             ((BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK) &
              bs->file->bs->supported_zero_flags);
 
-    s->bcs = block_copy_state_new(bs->file, s->target, bitmap, errp);
+    s->bcs = block_copy_state_new(bs->file, s->target, bs, bitmap, errp);
     if (!s->bcs) {
         error_prepend(errp, "Cannot create block-copy-state: ");
         return -EINVAL;
diff --git a/include/block/block-copy.h b/include/block/block-copy.h
index 0700953ab8..8b41643bfa 100644
--- a/include/block/block-copy.h
+++ b/include/block/block-copy.h
@@ -25,6 +25,7 @@ typedef struct BlockCopyState BlockCopyState;
 typedef struct BlockCopyCallState BlockCopyCallState;
 
 BlockCopyState *block_copy_state_new(BdrvChild *source, BdrvChild *target,
+                                     BlockDriverState *copy_bitmap_bs,
                                      const BdrvDirtyBitmap *bitmap,
                                      Error **errp);
 
diff --git a/tests/qemu-iotests/257.out b/tests/qemu-iotests/257.out
index aa76131ca9..c33dd7f3a9 100644
--- a/tests/qemu-iotests/257.out
+++ b/tests/qemu-iotests/257.out
@@ -120,16 +120,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -596,16 +596,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -865,16 +865,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -1341,16 +1341,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -1610,16 +1610,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -2086,16 +2086,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -2355,16 +2355,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -2831,16 +2831,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -3100,16 +3100,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -3576,16 +3576,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -3845,16 +3845,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -4321,16 +4321,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -4590,16 +4590,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
@@ -5066,16 +5066,16 @@ write -P0x67 0x3fe0000 0x20000
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      }
-    ],
-    "drive0": [
+      },
       {
         "busy": false,
         "count": 0,
         "granularity": 65536,
         "persistent": false,
         "recording": false
-      },
+      }
+    ],
+    "drive0": [
       {
         "busy": false,
         "count": 458752,
-- 
2.34.1


