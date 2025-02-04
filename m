Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6510C02193
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 21:17:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfQG2-0005LU-Ph; Tue, 04 Feb 2025 16:14:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFw-0005Ib-Nh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:53 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tfQFu-0005iL-Rs
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 16:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738703690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pT1O8tDOEaWjyTPNy8GKrPXIVJIbcvYFCQw8vIynjPY=;
 b=VLRJMumnsPBfdsf/RotEXctrg5v88fAhTutxZJH+07yF7PHUJBX8g0W9EDazYJtkod0Ay7
 8layAS9NkCO3fhFtsWWwmKFfjhVKphbWKUMo5poaEFPAQbkvG4TpXp+T9Zayyc/ybFxZXr
 /EneuR+kzCSnJfCEqJnndbtVqBa/uig=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-yI6YOj3PPOmnuu6n0O-SNA-1; Tue,
 04 Feb 2025 16:14:46 -0500
X-MC-Unique: yI6YOj3PPOmnuu6n0O-SNA-1
X-Mimecast-MFC-AGG-ID: yI6YOj3PPOmnuu6n0O-SNA
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BD9981955DCF; Tue,  4 Feb 2025 21:14:45 +0000 (UTC)
Received: from merkur.redhat.com (unknown [10.39.194.100])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 75C1D1800268; Tue,  4 Feb 2025 21:14:43 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, hreitz@redhat.com, stefanha@redhat.com,
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de,
 qemu-devel@nongnu.org
Subject: [PATCH v3 08/16] block: Add blockdev-set-active QMP command
Date: Tue,  4 Feb 2025 22:13:59 +0100
Message-ID: <20250204211407.381505-9-kwolf@redhat.com>
In-Reply-To: <20250204211407.381505-1-kwolf@redhat.com>
References: <20250204211407.381505-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The system emulator tries to automatically activate and inactivate block
nodes at the right point during migration. However, there are still
cases where it's necessary that the user can do this manually.

Images are only activated on the destination VM of a migration when the
VM is actually resumed. If the VM was paused, this doesn't happen
automatically. The user may want to perform some operation on a block
device (e.g. taking a snapshot or starting a block job) without also
resuming the VM yet. This is an example where a manual command is
necessary.

Another example is VM migration when the image files are opened by an
external qemu-storage-daemon instance on each side. In this case, the
process that needs to hand over the images isn't even part of the
migration and can't know when the migration completes. Management tools
need a way to explicitly inactivate images on the source and activate
them on the destination.

This adds a new blockdev-set-active QMP command that lets the user
change the status of individual nodes (this is necessary in
qemu-storage-daemon because it could be serving multiple VMs and only
one of them migrates at a time). For convenience, operating on all
devices (like QEMU does automatically during migration) is offered as an
option, too, and can be used in the context of single VM.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qapi/block-core.json               | 32 ++++++++++++++++++++++++++++++
 include/block/block-global-state.h |  3 +++
 block.c                            | 21 ++++++++++++++++++++
 blockdev.c                         | 32 ++++++++++++++++++++++++++++++
 4 files changed, 88 insertions(+)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 6029e54889..ee6eccc68c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4945,6 +4945,38 @@
 { 'command': 'blockdev-del', 'data': { 'node-name': 'str' },
   'allow-preconfig': true }
 
+##
+# @blockdev-set-active:
+#
+# Activate or inactivate a block device. Use this to manage the handover of
+# block devices on migration with qemu-storage-daemon.
+#
+# Activating a node automatically activates all of its child nodes first.
+# Inactivating a node automatically inactivates any of its child nodes that are
+# not in use by a still active node.
+#
+# @node-name: Name of the graph node to activate or inactivate. By default, all
+#     nodes are affected by the operation.
+#
+# @active: true if the nodes should be active when the command returns success,
+#     false if they should be inactive.
+#
+# Since: 10.0
+#
+# .. qmp-example::
+#
+#     -> { "execute": "blockdev-set-active",
+#          "arguments": {
+#               "node-name": "node0",
+#               "active": false
+#          }
+#        }
+#     <- { "return": {} }
+##
+{ 'command': 'blockdev-set-active',
+  'data': { '*node-name': 'str', 'active': 'bool' },
+  'allow-preconfig': true }
+
 ##
 # @BlockdevCreateOptionsFile:
 #
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index a826bf5f78..9be34b3c99 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -184,6 +184,9 @@ bdrv_activate(BlockDriverState *bs, Error **errp);
 int coroutine_fn no_co_wrapper_bdrv_rdlock
 bdrv_co_activate(BlockDriverState *bs, Error **errp);
 
+int no_coroutine_fn
+bdrv_inactivate(BlockDriverState *bs, Error **errp);
+
 void bdrv_activate_all(Error **errp);
 int bdrv_inactivate_all(void);
 
diff --git a/block.c b/block.c
index 7f6eca392f..7eeb8d076e 100644
--- a/block.c
+++ b/block.c
@@ -7052,6 +7052,27 @@ bdrv_inactivate_recurse(BlockDriverState *bs, bool top_level)
     return 0;
 }
 
+int bdrv_inactivate(BlockDriverState *bs, Error **errp)
+{
+    int ret;
+
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    if (bdrv_has_bds_parent(bs, true)) {
+        error_setg(errp, "Node has active parent node");
+        return -EPERM;
+    }
+
+    ret = bdrv_inactivate_recurse(bs, true);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to inactivate node");
+        return ret;
+    }
+
+    return 0;
+}
+
 int bdrv_inactivate_all(void)
 {
     BlockDriverState *bs = NULL;
diff --git a/blockdev.c b/blockdev.c
index eb2517f1dd..7e0d433712 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3471,6 +3471,38 @@ void qmp_blockdev_del(const char *node_name, Error **errp)
     bdrv_unref(bs);
 }
 
+void qmp_blockdev_set_active(const char *node_name, bool active, Error **errp)
+{
+    int ret;
+
+    GLOBAL_STATE_CODE();
+    GRAPH_RDLOCK_GUARD_MAINLOOP();
+
+    if (!node_name) {
+        if (active) {
+            bdrv_activate_all(errp);
+        } else {
+            ret = bdrv_inactivate_all();
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "Failed to inactivate all nodes");
+            }
+        }
+    } else {
+        BlockDriverState *bs = bdrv_find_node(node_name);
+        if (!bs) {
+            error_setg(errp, "Failed to find node with node-name='%s'",
+                       node_name);
+            return;
+        }
+
+        if (active) {
+            bdrv_activate(bs, errp);
+        } else {
+            bdrv_inactivate(bs, errp);
+        }
+    }
+}
+
 static BdrvChild * GRAPH_RDLOCK
 bdrv_find_child(BlockDriverState *parent_bs, const char *child_name)
 {
-- 
2.48.1


