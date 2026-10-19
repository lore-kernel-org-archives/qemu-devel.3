Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD00606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zu82JK5M
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIvkR-0006XS-5D; Mon, 19 Oct 2026 18:22:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xIvkK-0006Wm-NF
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:22:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xIvkI-0002dF-1N
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792448536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NCLKv2BsLYlcX/FXyeFkwcGP6bbOB6YxyUcsq9rNsk4=;
 b=Zu82JK5MjkDhegjU/E3jzhOt1+KCFAB4FmWH5JMYhrKTZVOs2fQ25t9eyQta8pCIlR2nFO
 DHSVN652PkxJzQK62VOkcbWgs8e32G6nSLHk/IypZjwJYJhR8QfopkvOqyzBR67Y6pXcbW
 MzVF+3nE/gohE1rFA78lQryujXTS1wQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-575-67F3mwX9Ml6WnlLkDwhXJw-1; Mon,
 19 Oct 2026 22:22:15 +0000
X-MC-Unique: 67F3mwX9Ml6WnlLkDwhXJw-1
X-Mimecast-MFC-AGG-ID: 67F3mwX9Ml6WnlLkDwhXJw_1792448534
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A69CA19540EF; Mon, 19 Oct 2026 22:22:13 +0000 (UTC)
Received: from eblake.csb (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E072618005B7; Mon, 19 Oct 2026 22:22:11 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: [PATCH] qemu-nbd: Add --all-bitmaps option
Date: Mon, 19 Oct 2026 17:22:02 -0500
Message-ID: <20261019222205.2028202-2-eblake@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When exporting bitmaps over NBD, we previously required a user to pass
one '-B name' per bitmap, which they would have to use 'qemu-img info'
to learn the list of names to pass.  More convenient is an option to
export all possible bitmaps at once, as discussed here [1].

Implementation-wise, mixing --all-bitmaps and -B is harmless (grabbing
all bitmap names already requires crawling the backing chain and
deduplicating, so either the -B name is already detected as a
duplicate from adding the name again, or it is an invalid name that
will still cause a later error about bitmap not found). I also tested
that mixing -s and --all-bitmaps still works (the temporary overlay
image to make -s work has no bitmaps of its own, so starting the crawl
for bitmap names at the original bs is just fine).

Also, now that parallels can have bitmaps (and not just qcow2), a
slight doc wording change for -B is warranted.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2026-10/msg01234.html

Signed-off-by: Eric Blake <eblake@redhat.com>
CC: Denis V. Lunev <den@openvz.org>
---
 docs/tools/qemu-nbd.rst                       | 12 +++-
 qemu-nbd.c                                    | 57 ++++++++++++++++++-
 tests/qemu-iotests/tests/qemu-img-bitmaps     | 13 +++++
 tests/qemu-iotests/tests/qemu-img-bitmaps.out | 12 ++++
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index 336b4aa46e7..a966c282be2 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -83,9 +83,15 @@ driver options if :option:`--image-opts` is specified.

 .. option:: -B, --bitmap=NAME

-  If *filename* has a qcow2 persistent bitmap *NAME*, expose
-  that bitmap via the ``qemu:dirty-bitmap:NAME`` metadata context
-  accessible through NBD_OPT_SET_META_CONTEXT.
+  If *filename* has a persistent bitmap *NAME* (possibly via a backing
+  chain), expose that bitmap via the ``qemu:dirty-bitmap:NAME`` metadata
+  context accessible through NBD_OPT_SET_META_CONTEXT.
+
+.. option:: --all-bitmaps
+
+  If *filename* has any persistent bitmaps (possibly via a backing
+  chain), expose one ``qemu:dirty-bitmap:NAME`` metadata context per
+  bitmap, accessible through NBD_OPT_SET_META_CONTEXT.

 .. option:: -s, --snapshot

diff --git a/qemu-nbd.c b/qemu-nbd.c
index fcca88932a3..fa28609d7dc 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -28,6 +28,7 @@
 #include "system/runstate.h" /* for qemu_system_killed() prototype */
 #include "block/block_int.h"
 #include "block/nbd.h"
+#include "block/dirty-bitmap.h"
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
@@ -71,6 +72,7 @@
 #define QEMU_NBD_OPT_SELINUX_LABEL   266
 #define QEMU_NBD_OPT_TLSHOSTNAME     267
 #define QEMU_NBD_OPT_HANDSHAKE_LIMIT 268
+#define QEMU_NBD_OPT_ALL_BITMAPS     269

 #define MBR_SIZE 512

@@ -109,6 +111,7 @@ static void usage(const char *name)
 "  -o, --offset=OFFSET       offset into the image\n"
 "  -A, --allocation-depth    expose the allocation depth\n"
 "  -B, --bitmap=NAME         expose a persistent dirty bitmap\n"
+"      --all-bitmaps         expose all persistent dirty bitmaps\n"
 "\n"
 "General purpose options:\n"
 "  -L, --list                list exports available from another NBD server\n"
@@ -530,6 +533,48 @@ static void qemu_nbd_shutdown(void)
     bdrv_close_all();
 }

+/* Helpers to implement --all-bitmaps option. */
+static bool is_duplicate_bitmap(BlockDirtyBitmapOrStrList *bitmaps,
+                                const char *name)
+{
+    /* Treat an anonymous bitmap as a duplicate. */
+    if (!name) {
+        return true;
+    }
+    for (; bitmaps; bitmaps = bitmaps->next) {
+        if (bitmaps->value->type == QTYPE_QSTRING &&
+            strcmp(bitmaps->value->u.local, name) == 0) {
+            return true;
+        }
+    }
+    return false;
+}
+
+static void collect_all_bitmaps(BlockDriverState *bs,
+                                BlockDirtyBitmapOrStrList **bitmaps)
+{
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    for (; bs; bs = bdrv_filter_or_cow_bs(bs)) {
+        for (BdrvDirtyBitmap *bm = bdrv_dirty_bitmap_first(bs); bm;
+             bm = bdrv_dirty_bitmap_next(bm)) {
+            const char *name = bdrv_dirty_bitmap_name(bm);
+            BlockDirtyBitmapOrStr *el;
+
+            if (is_duplicate_bitmap(*bitmaps, name)) {
+                continue;
+            }
+            el = g_new(BlockDirtyBitmapOrStr, 1);
+            *el = (BlockDirtyBitmapOrStr) {
+                .type = QTYPE_QSTRING,
+                .u.local = g_strdup(name),
+            };
+            QAPI_LIST_PREPEND(*bitmaps, el);
+        }
+    }
+}
+
 int main(int argc, char **argv)
 {
     BlockBackend *blk;
@@ -553,6 +598,7 @@ int main(int argc, char **argv)
         { "offset", required_argument, NULL, 'o' },
         { "read-only", no_argument, NULL, 'r' },
         { "allocation-depth", no_argument, NULL, 'A' },
+        { "all-bitmaps", no_argument, NULL, QEMU_NBD_OPT_ALL_BITMAPS },
         { "bitmap", required_argument, NULL, 'B' },
         { "connect", required_argument, NULL, 'c' },
         { "disconnect", no_argument, NULL, 'd' },
@@ -602,6 +648,7 @@ int main(int argc, char **argv)
     const char *export_description = NULL;
     BlockDirtyBitmapOrStrList *bitmaps = NULL;
     bool alloc_depth = false;
+    bool all_bitmaps = false;
     const char *tlscredsid = NULL;
     const char *tlshostname = NULL;
     bool imageOpts = false;
@@ -725,6 +772,9 @@ int main(int argc, char **argv)
         case 'A':
             alloc_depth = true;
             break;
+        case QEMU_NBD_OPT_ALL_BITMAPS:
+            all_bitmaps = true;
+            break;
         case 'B':
             {
                 BlockDirtyBitmapOrStr *el = g_new(BlockDirtyBitmapOrStr, 1);
@@ -837,7 +887,8 @@ int main(int argc, char **argv)
         }
         if (export_name || export_description || dev_offset ||
             opts.device || disconnect || fmt || sn_id_or_name || bitmaps ||
-            alloc_depth || seen_aio || seen_discard || seen_cache) {
+            all_bitmaps || alloc_depth || seen_aio || seen_discard ||
+            seen_cache) {
             error_report("List mode is incompatible with per-device settings");
             exit(EXIT_FAILURE);
         }
@@ -1185,6 +1236,10 @@ int main(int argc, char **argv)
         exit(EXIT_FAILURE);
     }

+    if (all_bitmaps) {
+        collect_all_bitmaps(orig_bs, &bitmaps);
+    }
+
     bs->detect_zeroes = detect_zeroes;

     nbd_server_is_qemu_nbd(shared);
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps b/tests/qemu-iotests/tests/qemu-img-bitmaps
index 979bc0d6c9c..5484fe6f424 100755
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps
@@ -131,6 +131,19 @@ $QEMU_IMG map --output=json --image-opts \

 nbd_server_stop

+# Repeat with the --all-bitmaps option
+nbd_server_start_unix_socket -r -f qcow2 --all-bitmaps "$TEST_IMG"
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b0" | _filter_qemu_img_map
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b1" | _filter_qemu_img_map
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b2" | _filter_qemu_img_map
+$QEMU_IMG map --output=json --image-opts \
+    "$IMG,x-dirty-bitmap=qemu:dirty-bitmap:b3" | _filter_qemu_img_map
+
+nbd_server_stop
+
 echo
 echo "=== Check handling of inconsistent bitmap ==="
 echo
diff --git a/tests/qemu-iotests/tests/qemu-img-bitmaps.out b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
index 99290d3ba5e..f2e97a090b0 100644
--- a/tests/qemu-iotests/tests/qemu-img-bitmaps.out
+++ b/tests/qemu-iotests/tests/qemu-img-bitmaps.out
@@ -103,6 +103,18 @@ Format specific information:

 === Check bitmap contents ===

+[{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 3145728, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 4194304, "length": 6291456, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 1048576, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 1048576, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 2097152, "length": 8388608, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
+[{ "start": 0, "length": 2097152, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
+{ "start": 2097152, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
+{ "start": 3145728, "length": 7340032, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
 [{ "start": 0, "length": 3145728, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET},
 { "start": 3145728, "length": 1048576, "depth": 0, "present": false, "zero": false, "data": false, "compressed": false},
 { "start": 4194304, "length": 6291456, "depth": 0, "present": true, "zero": false, "data": true, "compressed": false, "offset": OFFSET}]
-- 
2.56.0


