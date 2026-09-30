Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE16CA5FC5
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:24:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBuGa-0006kE-Vq; Wed, 30 Sep 2026 09:22:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xBuG3-0006h4-7p; Wed, 30 Sep 2026 09:22:05 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1xBuFx-0004IB-W6; Wed, 30 Sep 2026 09:22:00 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 673F9455BE;
 Wed, 30 Sep 2026 15:21:46 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, hreitz@redhat.com, kwolf@redhat.com,
 qemu-stable@nongnu.org
Subject: [PATCH qemu 1/4] iotests: add test cases for failing flush after
 qemu-img convert
Date: Wed, 30 Sep 2026 15:19:22 +0200
Message-ID: <20260930132140.2342574-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260930132140.2342574-1-f.ebner@proxmox.com>
References: <20260930132140.2342574-1-f.ebner@proxmox.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1790774505317
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

In preparation to add more checks in the following commits and show
how the behavior changes.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 tests/qemu-iotests/122     | 33 +++++++++++++++++++++++++++++++++
 tests/qemu-iotests/122.out | 14 ++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
index be0f6b79e5..488649f1bd 100755
--- a/tests/qemu-iotests/122
+++ b/tests/qemu-iotests/122
@@ -334,6 +334,39 @@ echo
 $QEMU_IMG convert -O $IMGFMT -o preallocation=metadata -n \
 	  "$TEST_IMG" "$TEST_IMG".orig && echo "unexpected success"
 
+echo
+echo "=== failing flush after convert with default ('unsafe') cache mode ==="
+echo
+
+TEST_IMG="$TEST_IMG".orig _make_test_img 1M
+TEST_IMG="$TEST_IMG" _make_test_img 1M
+
+$QEMU_IO -c "write -P 42 0 1M" "$TEST_IMG".orig | _filter_qemu_io
+
+target_fails_flush="json:{
+    'driver': '$IMGFMT',
+    'file': {
+        'driver': 'blkdebug',
+        'inject-error': [{
+            'event': 'flush_to_disk'
+        }],
+        'image': {
+            'driver': 'file',
+            'filename': '$TEST_IMG'
+        }
+    }
+}"
+
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush"
+echo "qemu-img convert exited with status $?"
+
+echo
+echo "=== failing flush after convert with 'writeback' cache mode ==="
+echo
+
+$QEMU_IMG convert -t writeback -f $IMGFMT -O $IMGFMT -n "$TEST_IMG".orig "$target_fails_flush"
+echo "qemu-img convert exited with status $?"
+
 # success, all done
 echo '*** done'
 rm -f $seq.full
diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
index 6a1aa3fe2b..f3e28f33bc 100644
--- a/tests/qemu-iotests/122.out
+++ b/tests/qemu-iotests/122.out
@@ -256,4 +256,18 @@ Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=67108864
 === -n incompatible with -o ===
 
 qemu-img: -o has no effect when skipping image creation
+
+=== failing flush after convert with default ('unsafe') cache mode ===
+
+Formatting 'TEST_DIR/t.IMGFMT.orig', fmt=IMGFMT size=1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576
+wrote 1048576/1048576 bytes at offset 0
+1 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qemu-img convert exited with status 0
+
+=== failing flush after convert with 'writeback' cache mode ===
+
+qemu-img: Failed to flush the L2 table cache: Input/output error
+qemu-img: Failed to flush the refcount block cache: Input/output error
+qemu-img convert exited with status 0
 *** done
-- 
2.47.3



