Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EE45C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 19:49:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ublZ4-0004WY-Jn; Tue, 15 Jul 2025 15:43:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxF-00049D-Gb
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1ubkxD-0001PQ-LB
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 15:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752606278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RKUdoz6mS/MZpsOs9CYOwTTbuQUWMaH4GdV7/2+2JT0=;
 b=At82nx/8EvyJ1gn04qq1Dk/rlyKgpG40sgJYLhjfO9RR0LJ7Ji0EgOpxVv5XPosWPeIU5u
 meJjKTA0JvoMj5ncLP7CiI57TSTTpWUPcJj++cg/1Wjeky/TWdsnmMzTlPdPdhUJTRazri
 mk/FXmLq0Pd6hezf/h9F2V8DzpAUv2g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-299-NUZYEn5eOPSIOknUwPYm7g-1; Tue,
 15 Jul 2025 15:04:35 -0400
X-MC-Unique: NUZYEn5eOPSIOknUwPYm7g-1
X-Mimecast-MFC-AGG-ID: NUZYEn5eOPSIOknUwPYm7g_1752606274
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B204818001E2; Tue, 15 Jul 2025 19:04:34 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.44.34.84])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 327B6197702B; Tue, 15 Jul 2025 19:04:32 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com,
	stefanha@redhat.com,
	qemu-devel@nongnu.org
Subject: [PULL 27/57] block/qapi: include child references in block device info
Date: Tue, 15 Jul 2025 21:03:00 +0200
Message-ID: <20250715190330.378764-28-kwolf@redhat.com>
In-Reply-To: <20250715190330.378764-1-kwolf@redhat.com>
References: <20250715190330.378764-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

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
Message-ID: <20250702123204.325470-2-f.ebner@proxmox.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json       | 16 ++++++++++++++++
 block/qapi.c               | 10 ++++++++++
 tests/qemu-iotests/184.out |  8 ++++++++
 3 files changed, 34 insertions(+)

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
2.50.1


