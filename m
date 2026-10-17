Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A0BFCCF2C4
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Oct 2026 20:34:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIB5S-0005LJ-5Q; Sat, 17 Oct 2026 16:33:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3b-0003RW-Q5; Sat, 17 Oct 2026 16:31:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xIB3Z-0004VM-Ns; Sat, 17 Oct 2026 16:31:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1792268872; bh=Ty0WGoM3aAosY55JIlBDUv6MO9fpFcFW0udf45XpbJA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=vcLV7NWHRpzOTaIcEp4C9OX6DwwhD5xtxVK7UT6QK/xJEzmSUQivR4cpJK058kAti
 JMkQhagbvnkB7Epw/i/VP92De+avw01624mBvQWsX894c8ZiUlHUPHJaZC9An4ezal
 5lE+yOCpUwbbcZNPYD/RftU07i6Vc8gbEFxW7QcQdy1DszeMuVv8MCoLutWBSfCgzb
 AAYCL7jxzBryocioNeO2lXC6plKLoFOS42ARmhkXvlMzsQ51Pcq+RyBwEYXTxG/yk1
 cytwI8m2K/cYVjaXwTAZ+XWwR3AstKlvib4w454eszvkXMryNzlZNK6I+JlN5qhyKI
 OV/sxjXIi+f8w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id B05351DE76B;
 Sat, 17 Oct 2026 23:27:52 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2EA744343F;
 Sat, 17 Oct 2026 23:27:51 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.1.3 45/73] qcow2: do not clear the dirty bit when
 reopening a read-only node
Date: Sat, 17 Oct 2026 23:26:03 +0300
Message-ID: <20261017202638.728621-45-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
References: <qemu-stable-11.1.3-20261017220607@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

qcow2_reopen_prepare() clears the dirty bit whenever the node is
reopened read-only, with an unguarded header write. A read-only node
can still be dirty, inherited from an earlier writable session, and it
holds no BLK_PERM_WRITE to resolve that. A read-only to read-only
reopen of a dirty image therefore fails outright:

  $ qemu-io -r -f qcow2 dirty.qcow2 <<< $'reopen -r\nquit'
  qemu-io: failed while preparing to reopen image 'dirty.qcow2'

Where the file node below is writable the write is not refused early,
and bdrv_co_write_req_prepare() aborts on its BLK_PERM_WRITE assertion
instead.

Clear it only for a node that is writable now, the predicate
qcow2_do_open() already uses for the repair. bdrv_is_writable() also
excludes an inactive node, whose header must not be touched either.

Signed-off-by: Denis V. Lunev <den@openvz.org>
Reviewed-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-stable@nongnu.org
Message-ID: <20260824133729.1141990-2-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit af28b65fae6fcbc22efdbcd4d71b37fd0c8adf89)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/block/qcow2.c b/block/qcow2.c
index 7292dd036c..1543255eba 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2102,9 +2102,11 @@ qcow2_reopen_prepare(BDRVReopenState *state,BlockReopenQueue *queue,
             goto fail;
         }
 
-        ret = qcow2_mark_clean(state->bs);
-        if (ret < 0) {
-            goto fail;
+        if (bdrv_is_writable(state->bs)) {
+            ret = qcow2_mark_clean(state->bs);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
 
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index 94a8bfe754..3d0c073d65 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -95,6 +95,40 @@ $QEMU_IMG info --image-opts \
 # The dirty bit must still be set: this open never wrote any guest data
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Read-only reopen must not clear the dirty bit =="
+
+# A read-only node cannot write the header, and must keep the dirty bit
+$QEMU_IO -r -c "reopen -r" -c "read -P 0x5a 0 512" "$TEST_IMG" \
+    | _filter_qemu_io
+
+# The dirty bit must still be set
+_qcow2_dump_header | grep incompatible_features
+
+echo
+echo "== Read-only reopen must not write through a writable file node =="
+
+# The write the header update needs is refused by the permission system
+echo "{'execute': 'qmp_capabilities'}
+      {'execute': 'blockdev-reopen',
+       'arguments': {'options': [{'node-name': 'drive',
+                                  'driver': 'qcow2',
+                                  'read-only': true,
+                                  'file': 'prot'}]}}
+      {'execute': 'quit'}" \
+    | $QEMU -qmp stdio -nographic -nodefaults \
+            -blockdev "{'node-name': 'prot',
+                        'driver': 'file',
+                        'filename': '$TEST_IMG'}" \
+            -blockdev "{'node-name': 'drive',
+                        'driver': 'qcow2',
+                        'file': 'prot',
+                        'read-only': true}" \
+    | _filter_qmp
+
+# The dirty bit must still be set
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Repairing the image file must succeed =="
 
@@ -108,6 +142,22 @@ echo "== Data should still be accessible after repair =="
 
 $QEMU_IO -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
 
+echo
+echo "== A read-write to read-only reopen must clear the dirty bit =="
+
+_make_test_img -o "compat=1.1,lazy_refcounts=on" $size
+
+# The kill keeps the close from clearing the bit, so the header shows what
+# the reopen did with it
+_NO_VALGRIND \
+$QEMU_IO -c "write -P 0x5a 0 512" \
+         -c "reopen -r" \
+         -c "sigraise $(kill -l KILL)" "$TEST_IMG" 2>&1 \
+    | _filter_qemu_io
+
+# The dirty bit must not be set
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Opening a dirty image read/write should repair it =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index c66361128f..ce8ee57721 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -27,6 +27,19 @@ incompatible_features     [0]
 == Read-only open must not crash on close ==
 incompatible_features     [0]
 
+== Read-only reopen must not clear the dirty bit ==
+read 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+incompatible_features     [0]
+
+== Read-only reopen must not write through a writable file node ==
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"return": {}}
+incompatible_features     [0]
+
 == Repairing the image file must succeed ==
 ERROR cluster 5 refcount=0 reference=1
 Rebuilding refcount structure
@@ -45,6 +58,13 @@ incompatible_features     []
 read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
+== A read-write to read-only reopen must clear the dirty bit ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+wrote 512/512 bytes at offset 0
+512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+./common.rc: Killed ( VALGRIND_QEMU="${VALGRIND_QEMU_IO}" _qemu_proc_exec "${VALGRIND_LOGFILE}" "$QEMU_IO_PROG" $QEMU_IO_ARGS "$@" )
+incompatible_features     []
+
 == Opening a dirty image read/write should repair it ==
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 wrote 512/512 bytes at offset 0
-- 
2.47.3


