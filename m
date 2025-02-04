Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F3FFC02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:18:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQFq-0005Fa-Bl; Tue, 04 Feb 2025 16:14:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFb-0005B0-DD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFY-0005e6-Gg
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738703667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjUxuBTJRP2OANE3OiNZFoKxd5jaZ2AyNyh655bAtSA=;
 b=IdprXH6JhqdEucZT7s0OD5iN4bEoXHiX7/2jgTURlwIzRnUL2lowb5G9QT/7b8GH+gH9ja
 Xx0y8Rb6Zmr96My1UjkuI+ie6hvAgPf10OkWllQNaViGjju4SoxBXNgwcWa4XVypKp8xDS
 r/s7HC9QzavR7oddT5+GkdtkN58ojQk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-B73BV_nPNCG-D0U2fDKB2w-1; Tue,
 04 Feb 2025 16:14:24 -0500
X-MC-Unique: B73BV_nPNCG-D0U2fDKB2w-1
X-Mimecast-MFC-AGG-ID: B73BV_nPNCG-D0U2fDKB2w
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79D8D19560B0; Tue,  4 Feb 2025 21:14:23 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88AB11800268; Tue,  4 Feb 2025 21:14:19 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v3 01/16] block: Add 'active' field to BlockDeviceInfo
Date: Tue,  4 Feb 2025 22:13:52 +0100
Message-ID: <20250204211407.381505-2-kwolf@redhat.com>
In-Reply-To: <20250204211407.381505-1-kwolf@redhat.com>
References: <20250204211407.381505-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This allows querying from QMP (and also HMP) whether an image is
currently active or inactive (in the sense of BDRV_O_INACTIVE).

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json               |  6 +++++-
 include/block/block-global-state.h |  3 +++
 block.c                            |  4 ++++
 block/monitor/block-hmp-cmds.c     |  5 +++--
 block/qapi.c                       |  1 +
 tests/qemu-iotests/184.out         |  2 ++
 tests/qemu-iotests/191.out         | 16 ++++++++++++++++
 tests/qemu-iotests/273.out         |  5 +++++
 8 files changed, 39 insertions(+), 3 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index fd3bcc1c17..1296ca8ae2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -486,6 +486,10 @@
 # @backing_file_depth: number of files in the backing file chain
 #     (since: 1.2)
 #
+# @active: true if the backend is active; typical cases for inactive backends
+#     are on the migration source instance after migration completes and on the
+#     destination before it completes. (since: 10.0)
+#
 # @encrypted: true if the backing device is encrypted
 #
 # @detect_zeroes: detect and optimize zero writes (Since 2.1)
@@ -556,7 +560,7 @@
 { 'struct': 'BlockDeviceInfo',
   'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str',
             '*backing_file': 'str', 'backing_file_depth': 'int',
-            'encrypted': 'bool',
+            'active': 'bool', 'encrypted': 'bool',
             'detect_zeroes': 'BlockdevDetectZeroesOptions',
             'bps': 'int', 'bps_rd': 'int', 'bps_wr': 'int',
             'iops': 'int', 'iops_rd': 'int', 'iops_wr': 'int',
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index bd7cecd1cf..a826bf5f78 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -175,6 +175,9 @@ BlockDriverState * GRAPH_RDLOCK
 check_to_replace_node(BlockDriverState *parent_bs, const char *node_name,
                       Error **errp);
 
+
+bool GRAPH_RDLOCK bdrv_is_inactive(BlockDriverState *bs);
+
 int no_coroutine_fn GRAPH_RDLOCK
 bdrv_activate(BlockDriverState *bs, Error **errp);
 
diff --git a/block.c b/block.c
index f60606f242..9aad958269 100644
--- a/block.c
+++ b/block.c
@@ -6824,6 +6824,10 @@ void bdrv_init_with_whitelist(void)
     bdrv_init();
 }
 
+bool bdrv_is_inactive(BlockDriverState *bs) {
+    return bs->open_flags & BDRV_O_INACTIVE;
+}
+
 int bdrv_activate(BlockDriverState *bs, Error **errp)
 {
     BdrvChild *child, *parent;
diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 1d312513fc..e84ff6ab16 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -630,11 +630,12 @@ static void print_block_info(Monitor *mon, BlockInfo *info,
     }
 
     if (inserted) {
-        monitor_printf(mon, ": %s (%s%s%s)\n",
+        monitor_printf(mon, ": %s (%s%s%s%s)\n",
                        inserted->file,
                        inserted->drv,
                        inserted->ro ? ", read-only" : "",
-                       inserted->encrypted ? ", encrypted" : "");
+                       inserted->encrypted ? ", encrypted" : "",
+                       inserted->active ? "" : ", inactive");
     } else {
         monitor_printf(mon, ": [not inserted]\n");
     }
diff --git a/block/qapi.c b/block/qapi.c
index 902ecb08e0..63604dc6d3 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -63,6 +63,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
     info->file                   = g_strdup(bs->filename);
     info->ro                     = bdrv_is_read_only(bs);
     info->drv                    = g_strdup(bs->drv->format_name);
+    info->active                 = !bdrv_is_inactive(bs);
     info->encrypted              = bs->encrypted;
 
     info->cache = g_new(BlockdevCacheInfo, 1);
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index e8f631f853..52692b6b3b 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -26,6 +26,7 @@ Testing:
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "virtual-size": 1073741824,
@@ -59,6 +60,7 @@ Testing:
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 1073741824,
                 "filename": "null-co://",
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index c3309e4bc6..2a72ca7106 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -114,6 +114,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
@@ -155,6 +156,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.ovl2",
@@ -183,6 +185,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
@@ -224,6 +227,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT",
@@ -252,6 +256,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
@@ -293,6 +298,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 393216,
                 "filename": "TEST_DIR/t.IMGFMT.mid",
@@ -321,6 +327,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.base",
@@ -350,6 +357,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 393216,
                 "filename": "TEST_DIR/t.IMGFMT.base",
@@ -521,6 +529,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
@@ -562,6 +571,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.ovl2",
@@ -590,6 +600,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "backing-image": {
@@ -642,6 +653,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.ovl3",
@@ -670,6 +682,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.base",
@@ -699,6 +712,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 393216,
                 "filename": "TEST_DIR/t.IMGFMT.base",
@@ -727,6 +741,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "virtual-size": 67108864,
@@ -768,6 +783,7 @@ wrote 65536/65536 bytes at offset 1048576
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT",
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
index 71843f02de..c19753c685 100644
--- a/tests/qemu-iotests/273.out
+++ b/tests/qemu-iotests/273.out
@@ -23,6 +23,7 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "backing-image": {
@@ -74,6 +75,7 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT",
@@ -102,6 +104,7 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "backing-image": {
                     "virtual-size": 197120,
@@ -142,6 +145,7 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.mid",
@@ -170,6 +174,7 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
         {
             "iops_rd": 0,
             "detect_zeroes": "off",
+            "active": true,
             "image": {
                 "virtual-size": 197120,
                 "filename": "TEST_DIR/t.IMGFMT.base",
-- 
2.48.1


