Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDDF8CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:31:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEMvR-0002tv-01; Wed, 07 Oct 2026 04:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEGwR-00088x-H0
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 22:00:01 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1xEGw7-0003c5-BN
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 21:59:21 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-5bcb4f23ddeso2376688e87.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 18:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1791338131; x=1791942931; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2/rjn73u5CZ6muuxZmMgEQ6ISO1owLFLaPcFwvySHXk=;
 b=p8raicHUw429Y8VlY0dW4ashP4eS55z1vRcdgk6yK55w3VKE9gRyqC1ZmvEOuY3qtW
 YwZL52rYW8xUOtXoBEBZb6BmFwvkvyZW6UB5DLOnV1W9w8Y4xrmTtY1b2BsfnFsKqiC5
 62r4ki9p9i1sd7kNvT0Sdnl/ZB+gDOr6mB4Vcgwh2h/cyJcdnfij8JbF5OcFHSvp6DhW
 634kw7yfQvUadT7uzYMWl2uQJW/hUCce3ZK3DPb8FuylQbbfJnFzoNhBKyNUWs+aaw/u
 gbcMDqDq48J3+5jP48wO+bwHAXhZ69v3+LAN9WK2Oqkcj2Mn/y6wGsBoPbAR+pk8zI59
 akhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791338131; x=1791942931;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2/rjn73u5CZ6muuxZmMgEQ6ISO1owLFLaPcFwvySHXk=;
 b=mJGdu6ZDtq3f1NNpYIZQLv1ryTkWWfJhFKyXJVVdwckeyd70J7S/LeJEVujgA0ZPQa
 ZdlVNEN7ehUaM47nYfywEvn9oEROH4EDUTYRthC7R7g2EIEXKDJ2YcUhN0LkMCw2osph
 +ytErYVU1i6fh2bfwKMEAiSukZ/5lMyHAcdV6mcZeUXOk7DBvpdynfHKiDXphoK+SEDA
 VS2fOCiCu16dbczLOOVGHmifed7XHGvpANbKDyCnzjwpgcXvnkY87kPrriFTbgpe5RYb
 +xv+XinOwhfwUl5e6xMH3no0IlVx66MFUnHOGnm+e+qx5fHPuGqp7lMsl348LFYD9svF
 uvgQ==
X-Gm-Message-State: AFq9FYIpvB1zQBL7J8TZYQGmgYL058jhOVJXfniqIIQIj/pwO4HzPHVG
 UCOepu2yg1ILxKind7mhgtReoq3dCblX7lpvM9T2Nhw619kyzI+EjfDkDbbH7O5dSJDTC7Cjs3+
 QK/hv
X-Gm-Gg: AYBFou0WacXN78luPCA6mhufkFojclzJrMhIC4KobRAU4o4QHpHSQlK61qR5zCrohht
 3VDzDj/VPvu/6PPd3r++gb85WWApi3gkvYESbdcY/UYv2Mo+5Os1cRACXGjMVzUXlFIeWmudH3I
 ZvPYlZ4i2moUdTOCDpSmqgZ2KyYDG9trZ25emJ1YQEXIms4u6x29B+E5lA7KgfG5EXHN23KCMJu
 ky2MNNFwVxSUyWWvZj+xonuBrmnsZbHbXhixDakWytHwYktj+BbpujZWOHRF43A314MefiDQiCV
 CXkUtoy+wAT7gAfz2o/9JqadgppwjZlHU0gdiTVJnL3Kin5EZLmjxkEt4vQTAifUgk6sM/VuYMX
 WeHIo1+jnkZqLWExeBxmN1xOJn46pmjd7ChGt3SH8MG7vl5oN3c2LhCfvpcZ12ZdqQj//uwB6Lu
 J6bNXmQi375E0VieVPpkneU6v/Kq2g6CuaAi/IP9hGYf22R1sMCsmTMwiXRdRY/WfO8L4=
X-Received: by 2002:a05:600c:3556:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1680f7447mr191817285e9.20.1791306465294; 
 Tue, 06 Oct 2026 10:07:45 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:a39a:8667:da6e:b69f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a178c5b9d6sm76254095e9.13.2026.10.06.10.07.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 10:07:44 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 2/3] migration/block-dirty-bitmap: fix postcopy abort with
 bitmaps on several nodes
Date: Tue,  6 Oct 2026 19:07:37 +0200
Message-ID: <20261006170738.453977-3-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261006170738.453977-1-den@openvz.org>
References: <20261006170738.453977-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=den@openvz.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Denis V. Lunev <den@openvz.org>

With dirty bitmaps on more than one node, the source switches nodes
during the postcopy bulk phase and sends the node name again. The
destination reads those chunks in the postcopy listen thread, which does
not hold the BQL, and resolves the name through bdrv_lookup_bs():

  qemu-system-x86_64: ../block.c:6400: bdrv_lookup_bs: Assertion
  `qemu_in_main_thread()' failed.

The bdrv_find_dirty_bitmap() call right after it needs the BQL or the
dirty bitmap lock as well. Taking the BQL there would deadlock: the
listen thread holds s->lock, and dirty_bitmap_mig_before_vm_start()
takes s->lock with the BQL held.

Every node and bitmap that a non-START chunk refers to was set up by a
START chunk, and those are loaded under the BQL during setup. Record the
node alias there, and resolve all other chunks against s->bitmaps
instead of the block graph.

Bitmaps on a single node never resend the node name after setup, which
is why migrate-bitmaps-postcopy-test does not catch this.

Fixes: f791bf7f93f2 ("assertions for block global state API")
Signed-off-by: Denis V. Lunev <den@openvz.org>
Cc: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>
Cc: Eric Blake <eblake@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-stable@nongnu.org
---
 migration/block-dirty-bitmap.c | 58 +++++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1386f43635..35623379eb 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -140,6 +140,7 @@ typedef struct LoadBitmapState {
     BdrvDirtyBitmap *bitmap;
     bool migrated;
     bool enabled;
+    char node_alias[QEMU_COUNTED_STRING_SIZE];
 } LoadBitmapState;
 
 /* State of the dirty bitmap migration (DBM) during load process */
@@ -859,6 +860,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
     }
 
     b = g_new(LoadBitmapState, 1);
+    g_strlcpy(b->node_alias, s->node_alias, sizeof(b->node_alias));
     b->bs = s->bs;
     b->bitmap = s->bitmap;
     b->migrated = false;
@@ -1056,6 +1058,53 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
     return 0;
 }
 
+/*
+ * Only START chunks are guaranteed to be loaded under the BQL; the rest may
+ * come from the postcopy listen thread and must not touch the block graph.
+ */
+static BlockDriverState *dirty_bitmap_load_find_bs(DBMLoadState *s,
+                                                   const char *device,
+                                                   const char *node_name,
+                                                   Error **errp)
+{
+    GSList *item;
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        return bdrv_lookup_bs(device, node_name, errp);
+    }
+
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
+        LoadBitmapState *b = item->data;
+
+        if (!strcmp(b->node_alias, s->node_alias)) {
+            return b->bs;
+        }
+    }
+
+    error_setg(errp, "no migrated bitmaps on node alias '%s'", s->node_alias);
+    return NULL;
+}
+
+static BdrvDirtyBitmap *dirty_bitmap_load_find_bitmap(DBMLoadState *s)
+{
+    GSList *item;
+
+    if (s->flags & DIRTY_BITMAP_MIG_FLAG_START) {
+        return bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+    }
+
+    for (item = s->bitmaps; item; item = g_slist_next(item)) {
+        LoadBitmapState *b = item->data;
+
+        if (b->bs == s->bs &&
+            !strcmp(bdrv_dirty_bitmap_name(b->bitmap), s->bitmap_name)) {
+            return b->bitmap;
+        }
+    }
+
+    return NULL;
+}
+
 static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
                                     GHashTable *alias_map)
 {
@@ -1084,11 +1133,12 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
                     s->bs = NULL;
                 } else {
                     bitmap_alias_map = amin->subtree;
-                    s->bs = bdrv_lookup_bs(NULL, amin->string, &local_err);
+                    s->bs = dirty_bitmap_load_find_bs(s, NULL, amin->string,
+                                                      &local_err);
                 }
             } else {
-                s->bs = bdrv_lookup_bs(s->node_alias, s->node_alias,
-                                       &local_err);
+                s->bs = dirty_bitmap_load_find_bs(s, s->node_alias,
+                                                  s->node_alias, &local_err);
             }
             if (!s->bs) {
                 error_report_err(local_err);
@@ -1139,7 +1189,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
 
         if (!s->cancelled) {
             g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
-            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+            s->bitmap = dirty_bitmap_load_find_bitmap(s);
 
             /*
              * bitmap may be NULL here, it wouldn't be an error if it is the
-- 
2.53.0


