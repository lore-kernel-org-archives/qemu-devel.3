Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5659D29C2E
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 14:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhqa4-0008M8-AV; Mon, 19 Jan 2026 09:50:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZo-0008D1-UC; Mon, 19 Jan 2026 09:49:58 -0500
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vhqZk-0008OP-D3; Mon, 19 Jan 2026 09:49:55 -0500
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5a81:0:640:624e:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTPS id D1D6AC015D;
 Mon, 19 Jan 2026 17:49:50 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:934::1:38])
 by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id gnaGbV0CCKo0-Tme69IbB; Mon, 19 Jan 2026 17:49:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1768834190;
 bh=gj6BWqpIIeyPn+JIEMMDww7yxiIxHS9HjNX3kbpOKHw=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=nWF1xIWot31eWzfxR17nutGbWUMT1Axl+7wQ6U5KUgC0/VOLhxPZpaM+lcdVmv6eV
 z6jeFO8g01rSY4uT3W3IxxU5HE21aM+bvBgngsPnuMThkwlJw2R5tleUKqV+WgEVIp
 7kxXE0qUG2qjzXVrMti3Dd3Tgg4POKBIZKMdOsR4=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v10 8/8] deprecate names duplication between qdev,
 block-node and block-export
Date: Mon, 19 Jan 2026 17:49:41 +0300
Message-ID: <20260119144941.87936-9-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119144941.87936-1-vsementsov@yandex-team.ru>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

Now we have blockdev-replace QMP command, which depend on a possibility
to select any block parent (block node, block export, or qdev) by one
unique name. The command fails, if name is ambiguous (i.e., match
several parents of different types). In future we want to rid of this
ambiguity.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 block.c                                     | 12 ++++++++++++
 block/export/export.c                       | 13 +++++++++++++
 docs/about/deprecated.rst                   | 10 ++++++++++
 include/block/block-global-state.h          |  1 +
 include/system/block-backend-global-state.h |  2 ++
 stubs/blk-by-qdev-id.c                      |  5 +++++
 stubs/blk-exp-find-by-blk.c                 |  4 ++++
 system/qdev-monitor.c                       | 16 ++++++++++++++++
 8 files changed, 63 insertions(+)

diff --git a/block.c b/block.c
index 8254d57212..5eae8b8623 100644
--- a/block.c
+++ b/block.c
@@ -1649,6 +1649,9 @@ static void bdrv_assign_node_name(BlockDriverState *bs,
         goto out;
     }
 
+    warn_device_exists(node_name);
+    warn_block_export_exists(node_name);
+
     /* copy node name into the bs and insert it into the graph list */
     pstrcpy(bs->node_name, sizeof(bs->node_name), node_name);
     QTAILQ_INSERT_TAIL(&graph_bdrv_states, bs, node_list);
@@ -6233,6 +6236,15 @@ BlockDriverState *bdrv_find_node(const char *node_name)
     return NULL;
 }
 
+void warn_block_node_exists(const char *node_name)
+{
+    if (bdrv_find_node(node_name)) {
+        warn_report("block node already exist with name '%s'. "
+                    "Ambigous identifiers are deprecated. "
+                    "In future that would be an error.", node_name);
+    }
+}
+
 /* Put this QMP function here so it can access the static graph_bdrv_states. */
 BlockDeviceInfoList *bdrv_named_nodes_list(bool flat,
                                            Error **errp)
diff --git a/block/export/export.c b/block/export/export.c
index 9169b43e13..e65d1bec8e 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -23,6 +23,7 @@
 #include "qapi/qapi-commands-block-export.h"
 #include "qapi/qapi-events-block-export.h"
 #include "qemu/id.h"
+#include "qemu/error-report.h"
 #ifdef CONFIG_VHOST_USER_BLK_SERVER
 #include "vhost-user-blk-server.h"
 #endif
@@ -108,6 +109,9 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         return NULL;
     }
 
+    warn_device_exists(export->id);
+    warn_block_node_exists(export->id);
+
     drv = blk_exp_find_driver(export->type);
     if (!drv) {
         error_setg(errp, "No driver found for the requested export type");
@@ -384,6 +388,15 @@ BlockExportInfoList *qmp_query_block_exports(Error **errp)
     return head;
 }
 
+void warn_block_export_exists(const char *id)
+{
+    if (blk_exp_find(id)) {
+        warn_report("block-export already exist with name '%s'. "
+                    "Ambigous identifiers are deprecated. "
+                    "In future that would be an error.", id);
+    }
+}
+
 BlockBackend *blk_by_export_id(const char *id, Error **errp)
 {
     BlockExport *exp;
diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
index 88efa3aa80..18bb1eeafc 100644
--- a/docs/about/deprecated.rst
+++ b/docs/about/deprecated.rst
@@ -551,3 +551,13 @@ command documentation for details on the ``fdset`` usage.
 
 The ``zero-blocks`` capability was part of the block migration which
 doesn't exist anymore since it was removed in QEMU v9.1.
+
+Identifiers
+-----------
+
+Possibility to intersect qdev ids/paths, block node names, and block
+export names namespaces is deprecated. In future that would be
+abandoned and all block exports, block nodes and devices will have
+unique names. Now, reusing the name for another type of object (for
+example, creating block-node with node-name equal to existing qdev
+id) produce a warning.
diff --git a/include/block/block-global-state.h b/include/block/block-global-state.h
index ed89999f0f..ea50478fc4 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -207,6 +207,7 @@ void bdrv_aio_cancel(BlockAIOCB *acb);
 int bdrv_has_zero_init_1(BlockDriverState *bs);
 int coroutine_mixed_fn GRAPH_RDLOCK bdrv_has_zero_init(BlockDriverState *bs);
 BlockDriverState *bdrv_find_node(const char *node_name);
+void warn_block_node_exists(const char *node_name);
 BlockDeviceInfoList *bdrv_named_nodes_list(bool flat, Error **errp);
 XDbgBlockGraph * GRAPH_RDLOCK bdrv_get_xdbg_block_graph(Error **errp);
 BlockDriverState *bdrv_lookup_bs(const char *device,
diff --git a/include/system/block-backend-global-state.h b/include/system/block-backend-global-state.h
index f23b9f1518..69e6aee618 100644
--- a/include/system/block-backend-global-state.h
+++ b/include/system/block-backend-global-state.h
@@ -73,6 +73,8 @@ DeviceState *blk_get_attached_dev(BlockBackend *blk);
 BlockBackend *blk_by_dev(void *dev);
 BlockBackend *blk_by_qdev_id(const char *id, Error **errp);
 BlockBackend *blk_by_export_id(const char *id, Error **errp);
+void warn_block_export_exists(const char *id);
+void warn_device_exists(const char *id);
 void blk_set_dev_ops(BlockBackend *blk, const BlockDevOps *ops, void *opaque);
 
 int blk_make_zero(BlockBackend *blk, BdrvRequestFlags flags);
diff --git a/stubs/blk-by-qdev-id.c b/stubs/blk-by-qdev-id.c
index 66ead77f4d..c83a2dde0d 100644
--- a/stubs/blk-by-qdev-id.c
+++ b/stubs/blk-by-qdev-id.c
@@ -11,3 +11,8 @@ BlockBackend *blk_by_qdev_id(const char *id, Error **errp)
     error_setg(errp, "Parameter 'parent-type' does not accept value 'qdev'");
     return NULL;
 }
+
+void warn_device_exists(const char *id)
+{
+    /* do nothing */
+}
diff --git a/stubs/blk-exp-find-by-blk.c b/stubs/blk-exp-find-by-blk.c
index 20f7ff1bdd..a98c4572fc 100644
--- a/stubs/blk-exp-find-by-blk.c
+++ b/stubs/blk-exp-find-by-blk.c
@@ -7,3 +7,7 @@ BlockExport *blk_exp_find_by_blk(BlockBackend *blk)
     return NULL;
 }
 
+void warn_block_export_exists(const char *id)
+{
+    /* do nothing */
+}
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index be18902bb2..67b9da952d 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -605,6 +605,8 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
                                              OBJECT(dev), NULL);
         if (prop) {
             dev->id = id;
+            warn_block_export_exists(id);
+            warn_block_node_exists(id);
         } else {
             error_setg(errp, "Duplicate device ID '%s'", id);
             g_free(id);
@@ -903,6 +905,20 @@ static DeviceState *find_device_state(const char *id, bool use_generic_error,
     return dev;
 }
 
+void warn_device_exists(const char *id)
+{
+    Object *obj = object_resolve_path_at(qdev_get_peripheral(), id);
+
+    if (obj) {
+        DeviceState *dev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
+
+        warn_report("%s '%s' already exist. "
+                    "Ambigous identifiers are deprecated. "
+                    "In future that would be an error.",
+                    dev ? "Device" : "Object", id);
+    }
+}
+
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
     HotplugHandler *hotplug_ctrl;
-- 
2.52.0


