Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 001A0C9830E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:57:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9i3r-00029h-Vr; Thu, 24 Sep 2026 07:56:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9i3o-000276-4p
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:56:20 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <den@openvz.org>) id 1x9i3l-0003NT-NL
 for qemu-devel@nongnu.org; Thu, 24 Sep 2026 07:56:19 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49cd38e0e5dso24801955e9.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2026 04:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=openvz.org; s=google; t=1790250976; x=1790855776; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ju/weBv0BliSm1Ra/ckEb/qWEoMCPQnAz2B35BNNLE=;
 b=l9FNI0K0wsqq83GUNxMmRvWogN8HYwelTkF9T0Eu9tzLfzDVbxuLlBOZiAUjCgMY37
 tlrA5XWiyANYLUOAJ5MovMdGy7R9ri64BScdB5AYh2Ht1Lx1THddSn+zZU2DzvGaWlME
 +ceR3FS7cyV9vj2YA4Pd4BRzSCMTsZfki3vKM1o2nC3nB+cXJtrwpa/RKDo1N8mdwpVB
 f3EXvSe4LBIEDcLsOAyjbqhGkWQH9Zrd2cEOBZWSwZosCKYFCO7RlTSG3I/hkCBKVzUy
 Vzzcsm8SXHEI/Y/tMb8H1QWUYMMy38yl+9yeQP66C5IdgFO7UkY5DEH8MpcMspwnQ47o
 HxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790250976; x=1790855776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ju/weBv0BliSm1Ra/ckEb/qWEoMCPQnAz2B35BNNLE=;
 b=TO8jpbvKWEKIUBnakCwKJtTdXzA/pqKM5W5IYEN/ksaD4NPagNrGjMjiN6PHZ68+Tn
 fu6pdRLlRdtYRRHUUiUriHy3nJg3PgotX92slMST83Q6rtw+eJ8v+7DyLxbdKinuUWVK
 l5GQkuwvGgYOrJyZr6mt5jaGCBSzh88PWomxQJB8hdVILcO/LvpASPJNbRAhvz4poXwN
 YDY0Dkb25QK4mS7aBC3m6ptLcUloLKwGNhz+fljgHgObW+pEjnHCg8tWgFvWndHXyFsB
 /raIoZKZ6D1F/dxzGdVM1vRRlUnAj9KjFlhh2PbMqXdYB1uHLsGAt/G+Y93/U1BTPahR
 OoCQ==
X-Gm-Message-State: AFuF++mRT8geJGtQAFJYPMTr38Bqk2zrxvismU1MutLS/lABq8MGV6DP
 Ykb8GKVrJBC6N6LfWGPUA20nzQka7dbS8zUHXMp58iNs8cFeJUCOisXmy0YbPaO5rMrxJmRIGb4
 AMeGt
X-Gm-Gg: AYBFou0fZESHe+UiUFG75r/9joAKD6LBlmWUH6wHLRPIMnkMGk3ytyjKDCBLZewmJWU
 ETQ0K0hwLSPsfzYWrfShJAHmmnJB7oPXQ13lopy1RYZS1N4P33h650edhNWLTVz0/4ZrE1D68fB
 +Fxqgee8RvTV57F9Bx8xbdxWDZgIPzEwd92D6bZnTAb6/GDAoToKS74zd+RnPJvXlrjT7m6AAjN
 lxuGsBFsQ17+nGZMI6TyEXjuXccUbteyACk1u9pTUT0cAyoLT/VHBdFdA6lkKP6g549tjzAyit6
 eykVZHkEhqJVlxeBg+pVZOYSFEJ4eiL9/ZX2xFPSt/HRghy03Brvj5+B7Bf9Egadz/eGGXXhyTp
 CuzlVYCRdjQD/OJTiZ6huiUkYsgmmX2Xf6doWl/7txktNSP+LxZKaVuHyvzx2ArjF9bpssAGUDa
 QQbZiEglIoXlvArRuAHfZKbbFDQDB9ijpg+Rqz21FHQI8bhR+CkfX3qqHIwLNS4sDI+no=
X-Received: by 2002:a05:600c:8b4c:b0:49f:bd3c:bc16 with SMTP id
 5b1f17b1804b1-49fe66f4c16mr35263685e9.17.1790250976300; 
 Thu, 24 Sep 2026 04:56:16 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:f9ec:9c2f:7d67:4ad8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fe5cca160sm58870135e9.12.2026.09.24.04.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 04:56:15 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-stable@nongnu.org
Subject: [PATCH 1/2] migration/block-dirty-bitmap: fix postcopy abort with
 bitmaps on several nodes
Date: Thu, 24 Sep 2026 13:56:10 +0200
Message-ID: <20260924115611.4098417-2-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924115611.4098417-1-den@openvz.org>
References: <20260924115611.4098417-1-den@openvz.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=den@openvz.org; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
 migration/block-dirty-bitmap.c | 59 +++++++++++++++++++++++++++++++---
 1 file changed, 55 insertions(+), 4 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 1b8f39c12b..61691ee4cc 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -136,6 +136,7 @@ typedef struct DBMSaveState {
 } DBMSaveState;
 
 typedef struct LoadBitmapState {
+    char node_alias[256];
     BlockDriverState *bs;
     BdrvDirtyBitmap *bitmap;
     bool migrated;
@@ -859,6 +860,7 @@ static int dirty_bitmap_load_start(QEMUFile *f, DBMLoadState *s)
     }
 
     b = g_new(LoadBitmapState, 1);
+    g_strlcpy(b->node_alias, s->node_alias, sizeof(b->node_alias));
     b->bs = s->bs;
     b->bitmap = s->bitmap;
     b->migrated = false;
@@ -1056,6 +1058,54 @@ static int dirty_bitmap_load_bits(QEMUFile *f, DBMLoadState *s)
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
+    error_setg(errp, "Error: no migrated bitmaps on node alias '%s'",
+               s->node_alias);
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
@@ -1084,11 +1134,12 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
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
@@ -1139,7 +1190,7 @@ static int dirty_bitmap_load_header(QEMUFile *f, DBMLoadState *s,
 
         if (!s->cancelled) {
             g_strlcpy(s->bitmap_name, bitmap_name, sizeof(s->bitmap_name));
-            s->bitmap = bdrv_find_dirty_bitmap(s->bs, s->bitmap_name);
+            s->bitmap = dirty_bitmap_load_find_bitmap(s);
 
             /*
              * bitmap may be NULL here, it wouldn't be an error if it is the
-- 
2.53.0


