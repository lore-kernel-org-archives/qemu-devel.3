Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07567C54F54
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 17:41:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wolkx-0007tq-JD; Tue, 28 Jul 2026 13:38:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolks-0007j4-3Y
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1wolkn-0005wQ-43
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 13:38:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785260284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FkgB/lfetYOAjuo99Q9suYGhJFjx2DNE8Y3ECDTUeYk=;
 b=NE/k2mKsLKGd3xrQATkI9vhtWke+wrmfmMnea5yI17U83b5nr+73I0I7JWFSTsV2kvc5Pw
 lA8Z/tGCy2JSITd4sLI6QSfJXcMAKM1w58PnU0Pofh4533NTsJ+h9nPBYCwLjCAN+5dRmy
 MrkpdPdMhfRn/639iPii63Uv3b05qLM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-631--GxJ8BLUNDqHyaqeKkeaog-1; Tue,
 28 Jul 2026 13:38:00 -0400
X-MC-Unique: -GxJ8BLUNDqHyaqeKkeaog-1
X-Mimecast-MFC-AGG-ID: -GxJ8BLUNDqHyaqeKkeaog_1785260279
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7B1718002C3; Tue, 28 Jul 2026 17:37:59 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.49.201])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0F0A219560AB; Tue, 28 Jul 2026 17:37:57 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 08/17] qcow2: do not try to clear the dirty bit on a read-only
 node
Date: Tue, 28 Jul 2026 19:37:30 +0200
Message-ID: <20260728173739.352078-9-kwolf@redhat.com>
In-Reply-To: <20260728173739.352078-1-kwolf@redhat.com>
References: <20260728173739.352078-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

From: "Denis V. Lunev" <den@openvz.org>

qcow2_do_close() -> qcow2_inactivate() clears the dirty bit with a
plain write to bs->file, unconditionally. A read-only node can still
be dirty, inherited from an earlier writable session, and that write
then hits a missing BLK_PERM_WRITE and asserts in
bdrv_co_write_req_prepare() (block/io.c) on an entirely ordinary
close -- closing is expected, the dirty bit on a read-only node
is not.

Skip the clear for read-only nodes, same as read access already does.
Any other still-dirty node keeps the unguarded write: it is expected
to hold write permission, and a missing one there is a bug worth
seeing.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Hanna Reitz <hreitz@redhat.com>
Message-ID: <20260716153552.3376009-1-den@openvz.org>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c              |  6 +++++-
 tests/qemu-iotests/039     | 11 +++++++++++
 tests/qemu-iotests/039.out |  3 +++
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 19271b10a49..7292dd036c9 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2870,7 +2870,11 @@ static int GRAPH_RDLOCK qcow2_inactivate(BlockDriverState *bs)
                      strerror(-ret));
     }
 
-    if (result == 0) {
+    /*
+     * A read-only node cannot resolve an inherited dirty bit here;
+     * leave it dirty, same as plain read access already does.
+     */
+    if (result == 0 && !bdrv_is_read_only(bs)) {
         qcow2_mark_clean(bs);
     }
 
diff --git a/tests/qemu-iotests/039 b/tests/qemu-iotests/039
index e43e7026ce3..94a8bfe754e 100755
--- a/tests/qemu-iotests/039
+++ b/tests/qemu-iotests/039
@@ -84,6 +84,17 @@ $QEMU_IO -r -c "read -P 0x5a 0 512" "$TEST_IMG" | _filter_qemu_io
 # The dirty bit must be set
 _qcow2_dump_header | grep incompatible_features
 
+echo
+echo "== Read-only open must not crash on close =="
+
+# We must not try to write the QCOW2 header to a read-only image.
+$QEMU_IMG info --image-opts \
+    "driver=$IMGFMT,read-only=on,file.driver=file,file.filename=$TEST_IMG,file.read-only=off" \
+    > /dev/null
+
+# The dirty bit must still be set: this open never wrote any guest data
+_qcow2_dump_header | grep incompatible_features
+
 echo
 echo "== Repairing the image file must succeed =="
 
diff --git a/tests/qemu-iotests/039.out b/tests/qemu-iotests/039.out
index 8fdbcc528aa..c66361128f6 100644
--- a/tests/qemu-iotests/039.out
+++ b/tests/qemu-iotests/039.out
@@ -24,6 +24,9 @@ read 512/512 bytes at offset 0
 512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 incompatible_features     [0]
 
+== Read-only open must not crash on close ==
+incompatible_features     [0]
+
 == Repairing the image file must succeed ==
 ERROR cluster 5 refcount=0 reference=1
 Rebuilding refcount structure
-- 
2.55.0


