Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D303DCA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 16:36:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEUcp-0004xr-UQ; Wed, 07 Oct 2026 12:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbX-00030V-3q
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1xEUbT-0006Nr-MB
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 12:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791390889;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QGsZ5bbOV1gR0rGL3bdM0NNsq7wL7ymKlhbdLdCIB5M=;
 b=FEoXTwm5JM5OV+bo1LOTVccGm/1JXTar9m5JSbCyKe6Ha6DMa1ZvBehy9WaoDKkdJc/1cg
 +6yQY5W9ONziOz/DPd8ucxSY4qa+25pNO9hfn4LNZgEX7NQAH33qX+A/9hj+V/KQM3EWL/
 fV2xKKU62MZVBHQh7UsjvpedVWVJG1M=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-251-ThguH2GcM8qhoS6tC97nFA-1; Wed,
 07 Oct 2026 12:34:47 -0400
X-MC-Unique: ThguH2GcM8qhoS6tC97nFA-1
X-Mimecast-MFC-AGG-ID: ThguH2GcM8qhoS6tC97nFA_1791390886
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D5891977010; Wed,  7 Oct 2026 16:34:46 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.32.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 753831956087; Wed,  7 Oct 2026 16:34:44 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	richard.henderson@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 18/21] qcow2: do not clear the dirty bit when reopening a
 read-only node
Date: Wed,  7 Oct 2026 18:32:59 +0200
Message-ID: <20261007163302.332250-19-kwolf@redhat.com>
In-Reply-To: <20261007163302.332250-1-kwolf@redhat.com>
References: <20261007163302.332250-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 block/qcow2.c              |  8 +++---
 tests/qemu-iotests/039     | 50 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/039.out | 20 +++++++++++++++
 3 files changed, 75 insertions(+), 3 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7292dd036c9..1543255eba8 100644
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
index 8fe677ce731..686c6da50fd 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -93,6 +93,40 @@ $QEMU_IMG info --image-opts \
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
 
@@ -106,6 +140,22 @@ echo "== Data should still be accessible after repair =="
 
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
index c66361128f6..ce8ee577216 100644
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
2.56.0


