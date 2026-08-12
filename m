Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08484C5CFCF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:08:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAT8-0004ej-Co; Wed, 12 Aug 2026 11:02:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARc-0003vw-KP; Wed, 12 Aug 2026 11:00:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuARY-00028H-VN; Wed, 12 Aug 2026 11:00:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546233; bh=nplslQjoaiinuOQ62NDt6V4KoXLecatbvBDFFefFCXs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=hHSuE/RGQ8k6qpf1SIu1sdRPOBoyFHaitv85qt0cu/GXKJjy4CgqXf7g6JSU//Esc
 LlLtePEVdBMpAPoA0J6uG+dULlFIh3WicBWwfVTJs+k44YDP4iGzCLlyqmPwe1a75Q
 LwDvMHKkV2OeIy7CoizgUt49vtW+UJl1grDSm674lCVAwpaoNu/D8XEC1Mdnraow9O
 TrxcIX616eyIDd2fmCMtb0XKe0Ck954f8mur4ZLE4OqFhiwlnY/tajkIeeFw/zhqtN
 ssJkO7H+czpywXd2hYBrKsFKAbuRJr5QltdleEpEo7NgtK9A8z+ZQgUCT+1d5Q/Y+t
 vV7ZLRwAJyArw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8AF461CA667;
 Wed, 12 Aug 2026 17:50:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id E5E1C409DA9;
 Wed, 12 Aug 2026 17:50:44 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4F4112FA29; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 099/120] qcow2: do not try to clear the dirty bit on a
 read-only node
Date: Wed, 12 Aug 2026 17:49:22 +0300
Message-ID: <20260812144955.649205-99-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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
(cherry picked from commit fe0f9e3ab2a8112dd9671bbb91365feba683f755)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

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
2.47.3


