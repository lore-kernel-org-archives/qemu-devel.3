Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA33C8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 14:16:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWFHX-0006cj-CD; Mon, 30 Jun 2025 10:14:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWFHU-0006cW-6V; Mon, 30 Jun 2025 10:14:48 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWFHR-0006qi-MX; Mon, 30 Jun 2025 10:14:47 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 7F9D14422D;
 Mon, 30 Jun 2025 16:14:41 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH] block: include 'file' child node name in block device info
Date: Mon, 30 Jun 2025 16:06:26 +0200
Message-ID: <20250630141421.1558724-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

In combination with using a throttle filter to enforce IO limits for
a guest device, knowing the 'file' child of a block device can be
useful. If the throttle filter is only intended for guest IO, block
jobs should not also be limited by the throttle filter, so the
block operations need to be done with the 'file' child of the top
throttle node as the target. In combination with mirroring, the name
of that child is not fixed.

Another scenario is when unplugging a guest device after mirroring
below a top throttle node, where the mirror target is added explicitly
via blockdev-add. After mirroring, the target becomes the new 'file'
child of the throttle node. For unplugging, both the top throttle node
and the mirror target need to be deleted, because only implicitly
added child nodes are deleted automatically, and the current 'file'
child of the throttle node was explicitly added (as the mirror
target).

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---
 block/qapi.c               | 4 ++++
 qapi/block-core.json       | 4 ++++
 tests/qemu-iotests/184.out | 1 +
 tests/qemu-iotests/191.out | 8 ++++++++
 tests/qemu-iotests/273.out | 2 ++
 5 files changed, 19 insertions(+)

diff --git a/block/qapi.c b/block/qapi.c
index 2c50a6bf3b..bbca042baf 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -77,6 +77,10 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->node_name = g_strdup(bs->node_name);
     }
 
+    if (bs->file && bs->file->bs && bs->file->bs->node_name[0]) {
+        info->file_child_node_name = g_strdup(bs->file->bs->node_name);
+    }
+
     backing = bdrv_cow_bs(bs);
     if (backing) {
         info->backing_file = g_strdup(backing->filename);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1df6644f0d..74d049606b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -481,6 +481,9 @@
 #     2.5: 'host_floppy' dropped 2.6: 'luks' added 2.8: 'replication'
 #     added, 'tftp' dropped 2.9: 'archipelago' dropped
 #
+# @file-child-node-name: the name of the 'file' child block driver node.
+#     (since: 10.1)
+#
 # @backing_file: the name of the backing file (for copy-on-write)
 #
 # @backing_file_depth: number of files in the backing file chain
@@ -559,6 +562,7 @@
 ##
 { 'struct': 'BlockDeviceInfo',
   'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str',
+            '*file-child-node-name': 'str',
             '*backing_file': 'str', 'backing_file_depth': 'int',
             'active': 'bool', 'encrypted': 'bool',
             'detect_zeroes': 'BlockdevDetectZeroesOptions',
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 52692b6b3b..aa02df950b 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -47,6 +47,7 @@ Testing:
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
+            "file-child-node-name": "disk0",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 2a72ca7106..f29e1b5209 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -143,6 +143,7 @@ wrote 65536/65536 bytes at offset 1048576
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -214,6 +215,7 @@ wrote 65536/65536 bytes at offset 1048576
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -285,6 +287,7 @@ wrote 65536/65536 bytes at offset 1048576
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -344,6 +347,7 @@ wrote 65536/65536 bytes at offset 1048576
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -558,6 +562,7 @@ wrote 65536/65536 bytes at offset 1048576
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -640,6 +645,7 @@ wrote 65536/65536 bytes at offset 1048576
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.ovl2",
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -699,6 +705,7 @@ wrote 65536/65536 bytes at offset 1048576
             "iops": 0,
             "bps_wr": 0,
             "write_threshold": 0,
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -770,6 +777,7 @@ wrote 65536/65536 bytes at offset 1048576
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "file-child-node-name": "NODE_NAME",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
diff --git a/tests/qemu-iotests/273.out b/tests/qemu-iotests/273.out
index c19753c685..eabe95c1a0 100644
--- a/tests/qemu-iotests/273.out
+++ b/tests/qemu-iotests/273.out
@@ -62,6 +62,7 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.mid",
+            "file-child-node-name": "topf",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
@@ -132,6 +133,7 @@ Testing: -blockdev file,node-name=base,filename=TEST_DIR/t.IMGFMT.base -blockdev
             "bps_wr": 0,
             "write_threshold": 0,
             "backing_file": "TEST_DIR/t.IMGFMT.base",
+            "file-child-node-name": "midf",
             "encrypted": false,
             "bps": 0,
             "bps_rd": 0,
-- 
2.47.2



