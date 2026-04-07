Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B712510F996A
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:49:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXvl-0002tJ-Il; Wed, 08 Apr 2026 14:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1wAXvj-0002mq-Pz
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:47:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1wAE6a-0001Hh-Cv
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 17:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775597823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lLHbJbpbVpCc7ZPDfJzkupfRH4+Vp1i+3Y5xDT7n2Qg=;
 b=IvPpCY7o2L29JddYotS2sBYW1zLml9YlReuTuURY8b6tKdOFGAGTfB9D/WSTpX6JkUZ/Z6
 IYdBSbC9Syj54gtUmMaC2p+tIzHM/H6pooetsdtNpRZEC4jTClBsx2id0UlcK1YD1U7biQ
 rFxiybk8xmj7+4AaqJgpPhADUmrUkKY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-479-lF6QmrMJM8CPq5-BLHxq3A-1; Tue,
 07 Apr 2026 17:37:00 -0400
X-MC-Unique: lF6QmrMJM8CPq5-BLHxq3A-1
X-Mimecast-MFC-AGG-ID: lF6QmrMJM8CPq5-BLHxq3A_1775597819
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4569F1956053; Tue,  7 Apr 2026 21:36:58 +0000 (UTC)
Received: from green.redhat.com (unknown [10.2.16.159])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 774A619560A6; Tue,  7 Apr 2026 21:36:56 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org (open list:Network Block Dev...)
Subject: [PATCH] qemu-nbd: Support -s and -l at the same time
Date: Tue,  7 Apr 2026 16:36:17 -0500
Message-ID: <20260407213652.769100-2-eblake@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

qemu-nbd already has the ability to wrap a read-write layer on top of
the export of a read-only image (-s) and the ability to export an
internal snapshot rather than the main image in a qcow2 file (-l
SNAPID).  But it gave a confusing error message when trying to mix the
two, because the snapshot overlay created first no longer has access
to the internal snapshots of the image being wrapped.

WIth a bit of finesse, this useful scenario is now supported.

https://gitlab.com/qemu-project/qemu/-/work_items/159

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/tools/qemu-nbd.rst                       |  7 +-
 qemu-nbd.c                                    | 20 ++++-
 tests/qemu-iotests/tests/qemu-nbd-snapshots   | 79 +++++++++++++++++++
 .../qemu-iotests/tests/qemu-nbd-snapshots.out | 34 ++++++++
 4 files changed, 134 insertions(+), 6 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/qemu-nbd-snapshots
 create mode 100644 tests/qemu-iotests/tests/qemu-nbd-snapshots.out

diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
index f82ea5fd77b..336b4aa46e7 100644
--- a/docs/tools/qemu-nbd.rst
+++ b/docs/tools/qemu-nbd.rst
@@ -95,9 +95,10 @@ driver options if :option:`--image-opts` is specified.

 .. option:: -l, --load-snapshot=SNAPSHOT_PARAM

-  Load an internal snapshot inside *filename* and export it
-  as an read-only device, SNAPSHOT_PARAM format is
-  ``snapshot.id=[ID],snapshot.name=[NAME]`` or ``[ID_OR_NAME]``
+  Load an internal snapshot inside *filename* and export it.
+  SNAPSHOT_PARAM format is ``snapshot.id=[ID],snapshot.name=[NAME]``
+  or ``[ID_OR_NAME]``. The export is read-only unless ``-s`` is also
+  in use.

 .. option:: --cache=CACHE

diff --git a/qemu-nbd.c b/qemu-nbd.c
index ed5895861bb..128486a0ec2 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -534,6 +534,7 @@ int main(int argc, char **argv)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
+    BlockDriverState *orig_bs;
     uint64_t dev_offset = 0;
     bool readonly = false;
     bool disconnect = false;
@@ -716,7 +717,7 @@ int main(int argc, char **argv)
             } else {
                 sn_id_or_name = optarg;
             }
-            /* fall through */
+            break;
         case 'r':
             readonly = true;
             flags &= ~BDRV_O_RDWR;
@@ -1110,6 +1111,15 @@ int main(int argc, char **argv)
     bdrv_init();
     atexit(qemu_nbd_shutdown);

+    /*
+     * -s and -l can be used together to create read-write wrapper
+     * around an internal snapshot. Otherwise, -l in isolation implies
+     * read-only.
+     */
+    if ((sn_opts || sn_id_or_name) && (flags & BDRV_O_SNAPSHOT) == 0) {
+        readonly = true;
+        flags &= ~BDRV_O_RDWR;
+    }
     opts.srcpath = argv[optind];
     if (imageOpts) {
         QemuOpts *o;
@@ -1155,13 +1165,17 @@ int main(int argc, char **argv)

     blk_set_enable_write_cache(blk, !writethrough);

+    orig_bs = bs;
+    if (flags & BDRV_O_SNAPSHOT) {
+        orig_bs = bs->backing->bs;
+    }
     if (sn_opts) {
-        ret = bdrv_snapshot_load_tmp(bs,
+        ret = bdrv_snapshot_load_tmp(orig_bs,
                                      qemu_opt_get(sn_opts, SNAPSHOT_OPT_ID),
                                      qemu_opt_get(sn_opts, SNAPSHOT_OPT_NAME),
                                      &local_err);
     } else if (sn_id_or_name) {
-        ret = bdrv_snapshot_load_tmp_by_id_or_name(bs, sn_id_or_name,
+        ret = bdrv_snapshot_load_tmp_by_id_or_name(orig_bs, sn_id_or_name,
                                                    &local_err);
     }
     if (ret < 0) {
diff --git a/tests/qemu-iotests/tests/qemu-nbd-snapshots b/tests/qemu-iotests/tests/qemu-nbd-snapshots
new file mode 100755
index 00000000000..de405e43720
--- /dev/null
+++ b/tests/qemu-iotests/tests/qemu-nbd-snapshots
@@ -0,0 +1,79 @@
+#!/usr/bin/env bash
+# group: rw quick
+#
+# Test qemu-nbd snapshot handling
+#
+# Copyright (C) Red Hat, Inc.
+#
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+seq="$(basename $0)"
+echo "QA output created by $seq"
+
+status=1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    nbd_server_stop
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+cd ..
+. ./common.rc
+. ./common.filter
+. ./common.nbd
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+_require_command QEMU_NBD
+
+echo
+echo "=== Initial image setup ==="
+echo
+
+# Create qcow2 image with one internal snapshot
+_make_test_img 10M
+$QEMU_IO -c 'w -P 1 3M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+$QEMU_IMG snapshot -c snap -f $IMGFMT "$TEST_IMG" | _filter_qemu_img
+$QEMU_IO -c 'w -P 2 3M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+
+echo
+echo "=== Main image in snapshot mode ==="
+echo
+
+nbd_server_start_unix_socket -s -f qcow2 "$TEST_IMG"
+$QEMU_IO -c 'r -P 2 3M 1M' -c 'w -P 3 3M 1M' -f raw \
+  nbd:unix:$nbd_unix_socket | _filter_qemu_io
+nbd_server_stop
+
+echo
+echo "=== Read-only snapshot access ==="
+echo
+
+nbd_server_start_unix_socket -l snap -f qcow2 "$TEST_IMG"
+$QEMU_IO -r -c 'r -P 1 3M 1M' -f raw \
+  nbd:unix:$nbd_unix_socket | _filter_qemu_io
+nbd_server_stop
+
+echo
+echo "=== Combine -s and -l for read-write internal snapshot access ==="
+echo
+
+nbd_server_start_unix_socket -s -l snap -f qcow2 "$TEST_IMG"
+$QEMU_IO -c 'r -P 1 3M 1M' -c 'w -P 3 3M 1M' -f raw \
+  nbd:unix:$nbd_unix_socket | _filter_qemu_io
+nbd_server_stop
+
+echo
+echo "=== Check that original image is unchanged ==="
+echo
+
+$QEMU_IO -c 'r -P 2 3M 1M' -f $IMGFMT "$TEST_IMG" | _filter_qemu_io
+
+# success, all done
+echo '*** done'
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/tests/qemu-nbd-snapshots.out b/tests/qemu-iotests/tests/qemu-nbd-snapshots.out
new file mode 100644
index 00000000000..6bce9d90253
--- /dev/null
+++ b/tests/qemu-iotests/tests/qemu-nbd-snapshots.out
@@ -0,0 +1,34 @@
+QA output created by qemu-nbd-snapshots
+
+=== Initial image setup ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=10485760
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Main image in snapshot mode ===
+
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Read-only snapshot access ===
+
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Combine -s and -l for read-write internal snapshot access ===
+
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+wrote 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+=== Check that original image is unchanged ===
+
+read 1048576/1048576 bytes at offset 3145728
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
-- 
2.53.0


