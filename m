Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0017BD3EE86
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 16:03:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vix7l-0003dp-5c; Thu, 22 Jan 2026 11:01:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vix7e-0003WQ-TO; Thu, 22 Jan 2026 11:01:27 -0500
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vix7b-0001MG-Ie; Thu, 22 Jan 2026 11:01:26 -0500
Received: from mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net
 [IPv6:2a02:6b8:c0c:5c05:0:640:ff67:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 79B66808D9;
 Thu, 22 Jan 2026 19:01:17 +0300 (MSK)
Received: from vsementsov-lin (unknown [2a02:6bf:8080:d28::1:34])
 by mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id F1fhdk2BPuQ0-JcHXz3a4; Thu, 22 Jan 2026 19:01:16 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1769097676;
 bh=EqZTO2opfswjr10U++lMVydcx+uDmaCEDlgZuqsfjsc=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=OMhQBmznbnHf0ZLy+g5d+DNcdZ8CNraH6412+zL1j8KvGU/w1fhRrJFzEgSdWtlsq
 cSpRfHpDwbzPfFCXS0DEKvySyaQwq6xO0PYn1PpqWlub7nOf3b0O+zEle0HUBq3jd8
 OaXV+mgL47Pid2ClHkQQKiopH9AJ6Gu/2ekoiSQo=
Authentication-Results: mail-nwsmtp-smtp-corp-main-80.iva.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, eduardo@habkost.net, berrange@redhat.com,
 pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org, hreitz@redhat.com, kwolf@redhat.com,
 vsementsov@yandex-team.ru
Subject: [PATCH v11 8/8] deprecate names duplication between qdev,
 block-node and block-export
Date: Thu, 22 Jan 2026 19:01:13 +0300
Message-ID: <20260122160113.1147745-1-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260119144941.87936-1-vsementsov@yandex-team.ru>
References: <20260119144941.87936-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
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

v11: rework separate warn_s into one common function
     check_existing_parent_id().

 block.c                            |  6 ++++++
 block/export/export.c              |  6 ++++++
 blockdev.c                         | 21 +++++++++++++++++++++
 docs/about/deprecated.rst          | 10 ++++++++++
 include/block/block-global-state.h |  2 ++
 stubs/check-existing-parent-id.c   |  6 ++++++
 stubs/meson.build                  |  1 +
 system/qdev-monitor.c              | 20 ++++++++++++++++++++
 8 files changed, 72 insertions(+)
 create mode 100644 stubs/check-existing-parent-id.c

diff --git a/block.c b/block.c
index 8254d57212..69674ad4ed 100644
--- a/block.c
+++ b/block.c
@@ -1618,6 +1618,7 @@ static void bdrv_assign_node_name(BlockDriverState *bs,
 {
     char *gen_node_name = NULL;
     GLOBAL_STATE_CODE();
+    Error *local_err;
 
     if (!node_name) {
         node_name = gen_node_name = id_generate(ID_BLOCK);
@@ -1649,6 +1650,11 @@ static void bdrv_assign_node_name(BlockDriverState *bs,
         goto out;
     }
 
+    if (!check_existing_parent_id(node_name, &local_err)) {
+        error_report_err(local_err);
+        local_err = NULL;
+    }
+
     /* copy node name into the bs and insert it into the graph list */
     pstrcpy(bs->node_name, sizeof(bs->node_name), node_name);
     QTAILQ_INSERT_TAIL(&graph_bdrv_states, bs, node_list);
diff --git a/block/export/export.c b/block/export/export.c
index 9169b43e13..174c86b4d2 100644
--- a/block/export/export.c
+++ b/block/export/export.c
@@ -96,6 +96,7 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
     AioContext *ctx;
     uint64_t perm;
     int ret;
+    Error *local_err = NULL;
 
     GLOBAL_STATE_CODE();
 
@@ -108,6 +109,11 @@ BlockExport *blk_exp_add(BlockExportOptions *export, Error **errp)
         return NULL;
     }
 
+    if (!check_existing_parent_id(export->id, &local_err)) {
+        error_report_err(local_err);
+        local_err = NULL;
+    }
+
     drv = blk_exp_find_driver(export->type);
     if (!drv) {
         error_setg(errp, "No driver found for the requested export type");
diff --git a/blockdev.c b/blockdev.c
index 3082a5763c..643b2132c9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3681,6 +3681,27 @@ out:
     bdrv_drain_all_end();
 }
 
+
+bool check_existing_parent_id(const char *id, Error **errp)
+{
+    if (bdrv_find_node(id)) {
+        error_setg(errp, "block node with id '%s' already exist", id);
+        return false;
+    }
+
+    if (blk_by_qdev_id(id, NULL)) {
+        error_setg(errp, "block device with id '%s' already exist", id);
+        return false;
+    }
+
+    if (blk_by_export_id(id, NULL)) {
+        error_setg(errp, "block export with id '%s' already exist", id);
+        return false;
+    }
+
+    return true;
+}
+
 void qmp_blockdev_replace(const char *parent, const char *child,
                           const char *new_child, Error **errp)
 {
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
index ed89999f0f..5014324241 100644
--- a/include/block/block-global-state.h
+++ b/include/block/block-global-state.h
@@ -318,4 +318,6 @@ void bdrv_unregister_buf(BlockDriverState *bs, void *host, size_t size);
 
 void bdrv_cancel_in_flight(BlockDriverState *bs);
 
+bool check_existing_parent_id(const char *id, Error **errp);
+
 #endif /* BLOCK_GLOBAL_STATE_H */
diff --git a/stubs/check-existing-parent-id.c b/stubs/check-existing-parent-id.c
new file mode 100644
index 0000000000..ef5ea3f26d
--- /dev/null
+++ b/stubs/check-existing-parent-id.c
@@ -0,0 +1,6 @@
+#include "qemu/osdep.h"
+#include "block/block-global-state.h"
+
+bool check_existing_parent_id(const char *id, Error **errp) {
+    return true;
+}
diff --git a/stubs/meson.build b/stubs/meson.build
index 30536ec8fa..3bd8649bd1 100644
--- a/stubs/meson.build
+++ b/stubs/meson.build
@@ -16,6 +16,7 @@ if have_block
   stub_ss.add(files('blk-commit-all.c'))
   stub_ss.add(files('blk-exp-close-all.c'))
   stub_ss.add(files('blk-by-qdev-id.c'))
+  stub_ss.add(files('check-existing-parent-id.c'))
   stub_ss.add(files('blk-exp-find-by-blk.c'))
   stub_ss.add(files('blockdev-close-all-bdrv-states.c'))
   stub_ss.add(files('change-state-handler.c'))
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index be18902bb2..ca14135191 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -593,6 +593,7 @@ static BusState *qbus_find(const char *path, Error **errp)
 const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
 {
     ObjectProperty *prop;
+    Error *local_err = NULL;
 
     assert(!dev->id && !dev->realized);
 
@@ -601,6 +602,18 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
      * has no parent
      */
     if (id) {
+        g_autofree char *fullpath = g_strdup_printf("/peripheral/%s", id);
+
+        if (!check_existing_parent_id(id, &local_err)) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+
+        if (!check_existing_parent_id(fullpath, &local_err)) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+
         prop = object_property_try_add_child(qdev_get_peripheral(), id,
                                              OBJECT(dev), NULL);
         if (prop) {
@@ -613,6 +626,13 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
     } else {
         static int anon_count;
         gchar *name = g_strdup_printf("device[%d]", anon_count++);
+        g_autofree char *fullpath = g_strdup_printf("/peripheral-anon/%s", id);
+
+        if (!check_existing_parent_id(fullpath, &local_err)) {
+            error_report_err(local_err);
+            local_err = NULL;
+        }
+
         prop = object_property_add_child(qdev_get_peripheral_anon(), name,
                                          OBJECT(dev));
         g_free(name);
-- 
2.52.0


