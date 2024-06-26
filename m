Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A7FC30659
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:55:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMREK-0006Na-Or; Wed, 26 Jun 2024 07:54:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMREI-0006N5-Lw; Wed, 26 Jun 2024 07:54:26 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1sMRE5-0007Hn-Ar; Wed, 26 Jun 2024 07:54:26 -0400
Received: from mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c1f:6401:0:640:7e6f:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id 13CAB60E30;
 Wed, 26 Jun 2024 14:54:11 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:b645::1:29])
 by mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id prOe6Z0rMmI0-0kNMdzqs; Wed, 26 Jun 2024 14:54:10 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1719402850;
 bh=mAvKysM9hVI3qWf9FNyafptShcrEuJSSk1u+6XLCCAA=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UobI6RmXiJ4FugewmggHVszZRS5RYCVLwKNO8IqoO+Xu2oiCRJ4/+JuH8CSv3b63M
 lCd91voPHTXluRLvvcFgRHnHpIvTMKK2ArxFwqP+01ZW+TedY5X4LrxzosGuCICqVf
 z6mqBpIfdv+5fzlFGLXJfF66uW4m6D5Ex6GnVvRA=
Authentication-Results: mail-nwsmtp-smtp-corp-main-69.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, armbru@redhat.com,
 eblake@redhat.com, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v9 4/7] qapi: add blockdev-replace command
Date: Wed, 26 Jun 2024 14:53:47 +0300
Message-Id: <20240626115350.405778-5-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240626115350.405778-1-vsementsov@yandex-team.ru>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add a command that can replace bs in following BdrvChild structures:

 - qdev blk root child
 - block-export blk root child
 - any child of BlockDriverState selected by child-name

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 blockdev.c             | 56 +++++++++++++++++++++++++++
 qapi/block-core.json   | 88 ++++++++++++++++++++++++++++++++++++++++++
 stubs/blk-by-qdev-id.c | 13 +++++++
 stubs/meson.build      |  1 +
 4 files changed, 158 insertions(+)
 create mode 100644 stubs/blk-by-qdev-id.c

diff --git a/blockdev.c b/blockdev.c
index ba7e90b06e..2190467022 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3559,6 +3559,62 @@ void qmp_x_blockdev_set_iothread(const char *node_name, StrOrNull *iothread,
     bdrv_try_change_aio_context(bs, new_context, NULL, errp);
 }
 
+void qmp_blockdev_replace(BlockdevReplace *repl, Error **errp)
+{
+    BdrvChild *child = NULL;
+    BlockDriverState *new_child_bs;
+
+    if (repl->parent_type == BLOCK_PARENT_TYPE_DRIVER) {
+        BlockDriverState *parent_bs;
+
+        parent_bs = bdrv_find_node(repl->u.driver.node_name);
+        if (!parent_bs) {
+            error_setg(errp, "Block driver node with node-name '%s' not "
+                       "found", repl->u.driver.node_name);
+            return;
+        }
+
+        child = bdrv_find_child(parent_bs, repl->u.driver.child);
+        if (!child) {
+            error_setg(errp, "Block driver node '%s' doesn't have child "
+                       "named '%s'", repl->u.driver.node_name,
+                       repl->u.driver.child);
+            return;
+        }
+    } else {
+        /* Other types are similar, they work through blk */
+        BlockBackend *blk;
+        bool is_qdev = repl->parent_type == BLOCK_PARENT_TYPE_QDEV;
+        const char *id =
+            is_qdev ? repl->u.qdev.qdev_id : repl->u.export.export_id;
+
+        assert(is_qdev || repl->parent_type == BLOCK_PARENT_TYPE_EXPORT);
+
+        blk = is_qdev ? blk_by_qdev_id(id, errp) : blk_by_export_id(id, errp);
+        if (!blk) {
+            return;
+        }
+
+        child = blk_root(blk);
+        if (!child) {
+            error_setg(errp, "%s '%s' is empty, nothing to replace",
+                       is_qdev ? "Device" : "Export", id);
+            return;
+        }
+    }
+
+    assert(child);
+    assert(child->bs);
+
+    new_child_bs = bdrv_find_node(repl->new_child);
+    if (!new_child_bs) {
+        error_setg(errp, "Node '%s' not found", repl->new_child);
+        return;
+    }
+
+    bdrv_replace_child_bs(child, new_child_bs, errp);
+}
+
 QemuOptsList qemu_common_drive_opts = {
     .name = "drive",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_common_drive_opts.head),
diff --git a/qapi/block-core.json b/qapi/block-core.json
index df5e07debd..0a6f08a6e0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -6148,3 +6148,91 @@
 ##
 { 'struct': 'DummyBlockCoreForceArrays',
   'data': { 'unused-block-graph-info': ['BlockGraphInfo'] } }
+
+##
+# @BlockParentType:
+#
+# @qdev: block device, such as created by device_add, and denoted by
+#     qdev-id
+#
+# @driver: block driver node, such as created by blockdev-add, and
+#     denoted by node-name
+#
+# @export: block export, such created by block-export-add, and
+#     denoted by export-id
+#
+# Since 9.1
+##
+{ 'enum': 'BlockParentType',
+  'data': ['qdev', 'driver', 'export'] }
+
+##
+# @BdrvChildRefQdev:
+#
+# @qdev-id: the device's ID or QOM path
+#
+# Since 9.1
+##
+{ 'struct': 'BdrvChildRefQdev',
+  'data': { 'qdev-id': 'str' } }
+
+##
+# @BdrvChildRefExport:
+#
+# @export-id: block export identifier
+#
+# Since 9.1
+##
+{ 'struct': 'BdrvChildRefExport',
+  'data': { 'export-id': 'str' } }
+
+##
+# @BdrvChildRefDriver:
+#
+# @node-name: the node name of the parent block node
+#
+# @child: name of the child to be replaced, like "file" or "backing"
+#
+# Since 9.1
+##
+{ 'struct': 'BdrvChildRefDriver',
+  'data': { 'node-name': 'str', 'child': 'str' } }
+
+##
+# @BlockdevReplace:
+#
+# @parent-type: type of the parent, which child is to be replaced
+#
+# @new-child: new child for replacement
+#
+# Since 9.1
+##
+{ 'union': 'BlockdevReplace',
+  'base': {
+      'parent-type': 'BlockParentType',
+      'new-child': 'str'
+  },
+  'discriminator': 'parent-type',
+  'data': {
+      'qdev': 'BdrvChildRefQdev',
+      'export': 'BdrvChildRefExport',
+      'driver': 'BdrvChildRefDriver'
+  } }
+
+##
+# @blockdev-replace:
+#
+# Replace a block-node associated with device (selected by
+# @qdev-id) or with block-export (selected by @export-id) or
+# any child of block-node (selected by @node-name and @child)
+# with @new-child block-node.
+#
+# Features:
+#
+# @unstable: This command is experimental.
+#
+# Since 9.1
+##
+{ 'command': 'blockdev-replace', 'boxed': true,
+  'features': [ 'unstable' ],
+  'data': 'BlockdevReplace' }
diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
new file mode 100644
index 0000000000..5ec9f755ee
--- /dev/null
+++ b/stubs/blk-by-qdev-id.c
@@ -0,0 +1,13 @@
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "sysemu/block-backend.h"
+
+BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
+{
+    /*
+     * We expect this when blockdev-change is called with parent-type=qdev,
+     * but qdev-monitor is not linked in. So no blk_ API is not available.
+     */
+    error_setg(errp, "Parameter 'parent-type' does not accept value 'qdev'");
+    return NULL;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 772a3e817d..068998c1a5 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -15,6 +15,7 @@ if have_block
   stub_ss.add(files('bdrv-next-monitor-owned.c'))
   stub_ss.add(files('blk-commit-all.c'))
   stub_ss.add(files('blk-exp-close-all.c'))
+  stub_ss.add(files('blk-by-qdev-id.c'))
   stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
   stub_ss.add(files('change-state-handler.c'))
   stub_ss.add(files('get-vm-name.c'))
-- 
2.34.1


