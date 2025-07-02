Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FA9C83F05
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Jul 2025 12:33:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWwdS-0005Qq-5U; Wed, 02 Jul 2025 08:32:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWwdP-0005Pc-ON; Wed, 02 Jul 2025 08:32:19 -0400
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1uWwdL-0000Ra-5R; Wed, 02 Jul 2025 08:32:19 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id B493F4756F;
 Wed,  2 Jul 2025 14:32:10 +0200 (CEST)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, armbru@redhat.com
Subject: [PATCH v3 1/2] block/qapi: include child references in block device
 info
Date: Wed,  2 Jul 2025 14:31:27 +0200
Message-ID: <20250702123204.325470-2-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250702123204.325470-1-f.ebner@proxmox.com>
References: <20250702123204.325470-1-f.ebner@proxmox.com>
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

In other scenarios, it could be useful to follow the backing chain.

Note that iotests 191 and 273 use _filter_img_info, so the 'children'
information is filtered out there.

Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
---

Changes in v3:
* Drop superfluous check for child->bs being non-NULL.
* Make @node-name non-optional and expect it to be set.
* Use 'block/qapi' rather than just 'block' as commit title prefix.

 block/qapi.c               | 10 ++++++++++
 qapi/block-core.json       | 16 ++++++++++++++++
 tests/qemu-iotests/184.out |  8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/block/qapi.c b/block/qapi.c
index 2c50a6bf3b..e08a1e970f 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -51,6 +51,8 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
     ImageInfo *backing_info;
     BlockDriverState *backing;
     BlockDeviceInfo *info;
+    BlockdevChildList **children_list_tail;
+    BdrvChild *child;
 
     if (!bs->drv) {
         error_setg(errp, "Block device %s is ejected", bs->node_name);
@@ -77,6 +79,14 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->node_name = g_strdup(bs->node_name);
     }
 
+    children_list_tail = &info->children;
+    QLIST_FOREACH(child, &bs->children, next) {
+        BlockdevChild *child_ref = g_new0(BlockdevChild, 1);
+        child_ref->child = g_strdup(child->name);
+        child_ref->node_name = g_strdup(child->bs->node_name);
+        QAPI_LIST_APPEND(children_list_tail, child_ref);
+    }
+
     backing = bdrv_cow_bs(bs);
     if (backing) {
         info->backing_file = g_strdup(backing->filename);
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1df6644f0d..3e720af5ad 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -461,6 +461,19 @@
             'direct': 'bool',
             'no-flush': 'bool' } }
 
+##
+# @BlockdevChild:
+#
+# @child: The name of the child, for example 'file' or 'backing'.
+#
+# @node-name: The name of the child's block driver node.
+#
+# Since: 10.1
+##
+{ 'struct': 'BlockdevChild',
+  'data': { 'child': 'str',
+            'node-name': 'str' } }
+
 ##
 # @BlockDeviceInfo:
 #
@@ -486,6 +499,8 @@
 # @backing_file_depth: number of files in the backing file chain
 #     (since: 1.2)
 #
+# @children: Information about child block nodes. (since: 10.1)
+#
 # @active: true if the backend is active; typical cases for inactive backends
 #     are on the migration source instance after migration completes and on the
 #     destination before it completes.  (since: 10.0)
@@ -560,6 +575,7 @@
 { 'struct': 'BlockDeviceInfo',
   'data': { 'file': 'str', '*node-name': 'str', 'ro': 'bool', 'drv': 'str',
             '*backing_file': 'str', 'backing_file_depth': 'int',
+            'children': ['BlockdevChild'],
             'active': 'bool', 'encrypted': 'bool',
             'detect_zeroes': 'BlockdevDetectZeroesOptions',
             'bps': 'int', 'bps_rd': 'int', 'bps_wr': 'int',
diff --git a/tests/qemu-iotests/184.out b/tests/qemu-iotests/184.out
index 52692b6b3b..ef99bb2e9a 100644
--- a/tests/qemu-iotests/184.out
+++ b/tests/qemu-iotests/184.out
@@ -41,6 +41,12 @@ Testing:
             },
             "iops_wr": 0,
             "ro": false,
+            "children": [
+                {
+                    "node-name": "disk0",
+                    "child": "file"
+                }
+            ],
             "node-name": "throttle0",
             "backing_file_depth": 1,
             "drv": "throttle",
@@ -69,6 +75,8 @@ Testing:
             },
             "iops_wr": 0,
             "ro": false,
+            "children": [
+            ],
             "node-name": "disk0",
             "backing_file_depth": 0,
             "drv": "null-co",
-- 
2.47.2



