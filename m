Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562F4C4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 17:05:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1quv-0007Fm-56; Tue, 30 Apr 2024 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1s1quq-0007Em-1S; Tue, 30 Apr 2024 13:05:16 -0400
Received: from relay.virtuozzo.com ([130.117.225.111])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <den@openvz.org>)
 id 1s1qun-0000KZ-VY; Tue, 30 Apr 2024 13:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=virtuozzo.com; s=relay; h=MIME-Version:Message-Id:Date:Subject:From:
 Content-Type; bh=5/BneL5evxaFu8vnJNayxymlseYFnPNU1TvUICNE1Sk=; b=M9wnP3HpjZcw
 EHLIEWaafbazwyW6kmQAb3YTYgZepxhJlkJSCaCCRBXQwy2cPQgLWGpmD1QU2f9ghcFM3NQ6K5/+9
 hp/lqoQHH48XXuFLkGafnEjMX75VVm5xZxI7mINW/p/2xbCAaHVH2yDIufyswEop+CSwECoD/Y0Qi
 uVGegNJQ/tpnxQW/DDPuWlhXYJ6B42nYTK6ytmO3Cxsfg9otII5jiGGOtrwTjJW5+3JiyUpbucWjn
 HEOTxYs+6ghHZ8ny3zfNeF5OMNrJDWKyzLIcTvS26nB62PJYr0/y+M7DAdeQntXb6WQ3Cn1m26M5c
 uc23u+ltRhZdNDJ6QC/CDA==;
Received: from ch-vpn.virtuozzo.com ([130.117.225.6] helo=iris.sw.ru)
 by relay.virtuozzo.com with esmtp (Exim 4.96)
 (envelope-from <den@openvz.org>) id 1s1qrN-00G7ab-0u;
 Tue, 30 Apr 2024 19:04:59 +0200
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Cc: den@openvz.org, Alexander Ivanov <alexander.ivanov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PATCH 1/1] prealloc: add truncate mode for prealloc filter
Date: Tue, 30 Apr 2024 19:05:10 +0200
Message-Id: <20240430170510.148812-1-den@openvz.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=130.117.225.111; envelope-from=den@openvz.org;
 helo=relay.virtuozzo.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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
Reply-to:  "Denis V. Lunev" <den@openvz.org>
From:  "Denis V. Lunev" via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Preallocate filter allows to implement really interesting setups.

Assume that we have
* shared block device, f.e. iSCSI LUN, implemented with some HW device
* clustered LVM on top of it
* QCOW2 image stored inside LVM volume

This allows very cheap clustered setups with all QCOW2 features intact.
Currently supported setups using QCOW2 with data_file option are not
so cool as snapshots are not allowed, QCOW2 should be placed into some
additional distributed storage and so on.

Though QCOW2 inside LVM volume has a drawback. The image is growing and
in order to accomodate that image LVM volume is to be resized. This
could be done externally using ENOSPACE event/condition but this is
cumbersome.

This patch introduces native implementation for such a setup. We should
just put prealloc filter in between QCOW2 format and file nodes. In that
case LVM will be resized at proper moment and that is done effectively
as resizing is done in chinks.

The patch adds allocation mode for this purpose in order to distinguish
'fallocate' for ordinary file system and 'truncate'.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Alexander Ivanov <alexander.ivanov@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block/preallocate.c | 50 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/block/preallocate.c b/block/preallocate.c
index 4d82125036..6d31627325 100644
--- a/block/preallocate.c
+++ b/block/preallocate.c
@@ -33,10 +33,24 @@
 #include "block/block-io.h"
 #include "block/block_int.h"
 
+typedef enum PreallocateMode {
+    PREALLOCATE_MODE_FALLOCATE = 0,
+    PREALLOCATE_MODE_TRUNCATE = 1,
+    PREALLOCATE_MODE__MAX = 2,
+} PreallocateMode;
+
+static QEnumLookup prealloc_mode_lookup = {
+    .array = (const char *const[]) {
+        "falloc",
+        "truncate",
+    },
+    .size = PREALLOCATE_MODE__MAX,
+};
 
 typedef struct PreallocateOpts {
     int64_t prealloc_size;
     int64_t prealloc_align;
+    PreallocateMode prealloc_mode;
 } PreallocateOpts;
 
 typedef struct BDRVPreallocateState {
@@ -79,6 +93,7 @@ typedef struct BDRVPreallocateState {
 
 #define PREALLOCATE_OPT_PREALLOC_ALIGN "prealloc-align"
 #define PREALLOCATE_OPT_PREALLOC_SIZE "prealloc-size"
+#define PREALLOCATE_OPT_MODE "mode"
 static QemuOptsList runtime_opts = {
     .name = "preallocate",
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
@@ -94,7 +109,14 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_SIZE,
             .help = "how much to preallocate, default 128M",
         },
-        { /* end of list */ }
+        {
+            .name = PREALLOCATE_OPT_MODE,
+            .type = QEMU_OPT_STRING,
+            .help = "Preallocation mode on image expansion "
+                    "(allowed values: falloc, truncate)",
+            .def_value_str = "falloc",
+        },
+        { /* end of list */ },
     },
 };
 
@@ -102,6 +124,8 @@ static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
                                     BlockDriverState *child_bs, Error **errp)
 {
     QemuOpts *opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
+    Error *local_err = NULL;
+    char *buf;
 
     if (!qemu_opts_absorb_qdict(opts, options, errp)) {
         return false;
@@ -112,6 +136,17 @@ static bool preallocate_absorb_opts(PreallocateOpts *dest, QDict *options,
     dest->prealloc_size =
         qemu_opt_get_size(opts, PREALLOCATE_OPT_PREALLOC_SIZE, 128 * MiB);
 
+    buf = qemu_opt_get_del(opts, PREALLOCATE_OPT_MODE);
+    /* prealloc_mode can be downgraded later during allocate_clusters */
+    dest->prealloc_mode = qapi_enum_parse(&prealloc_mode_lookup, buf,
+                                          PREALLOCATE_MODE_FALLOCATE,
+                                          &local_err);
+    g_free(buf);
+    if (local_err != NULL) {
+        error_propagate(errp, local_err);
+        return false;
+    }
+
     qemu_opts_del(opts);
 
     if (!QEMU_IS_ALIGNED(dest->prealloc_align, BDRV_SECTOR_SIZE)) {
@@ -335,9 +370,20 @@ handle_write(BlockDriverState *bs, int64_t offset, int64_t bytes,
 
     want_merge_zero = want_merge_zero && (prealloc_start <= offset);
 
-    ret = bdrv_co_pwrite_zeroes(
+    switch (s->opts.prealloc_mode) {
+    case PREALLOCATE_MODE_FALLOCATE:
+        ret = bdrv_co_pwrite_zeroes(
             bs->file, prealloc_start, prealloc_end - prealloc_start,
             BDRV_REQ_NO_FALLBACK | BDRV_REQ_SERIALISING | BDRV_REQ_NO_WAIT);
+        break;
+    case PREALLOCATE_MODE_TRUNCATE:
+        ret = bdrv_co_truncate(bs->file, prealloc_end, false,
+                               PREALLOC_MODE_OFF, 0, NULL);
+        break;
+    default:
+        return false;
+    }
+
     if (ret < 0) {
         s->file_end = ret;
         return false;
-- 
2.39.3


