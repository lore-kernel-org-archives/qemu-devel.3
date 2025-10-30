Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4297CCFA03
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 20:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEZJ4-0000eG-NZ; Thu, 30 Oct 2025 16:31:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZJ1-0000dp-6R
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:35 -0400
Received: from forwardcorp1d.mail.yandex.net
 ([2a02:6b8:c41:1300:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1vEZIw-0005vM-8g
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 16:31:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:94a9:0:640:a3fa:0])
 by forwardcorp1d.mail.yandex.net (Yandex) with ESMTPS id BA91380AA6;
 Thu, 30 Oct 2025 23:31:21 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6bf:8080:861::1:2b])
 by mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id HVmKdN0F6Cg0-9a1q0RCR; Thu, 30 Oct 2025 23:31:21 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1761856281;
 bh=WL2qBDwHi63ZyswAWcDw2TfQ6wvgQUcXwyFscx5q4ms=;
 h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=VDHjp8LB7T8gdExzgiXJWFBxSMapQgfX0guH6nPQhvg84LMX2kY6bL0svX+0vmmKx
 BGcfQMf+vrazB3vZkYN9jyumiuPgR7Z3CjKsBeQFDfhW0WmmKy9Z0Zwa2/aOmZUVsc
 iVJN3r8s5o7eWzsjT7+7ZvlroYwWnYkOkvapqm1Y=
Authentication-Results: mail-nwsmtp-smtp-corp-main-68.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: mst@redhat.com,
	jasowang@redhat.com
Cc: pbonzini@redhat.com, berrange@redhat.com, eduardo@habkost.net,
 peterx@redhat.com, farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 thuth@redhat.com, philmd@linaro.org, zhao1.liu@intel.com,
 qemu-devel@nongnu.org, leiyang@redhat.com, davydov-max@yandex-team.ru,
 yc-core@yandex-team.ru, vsementsov@yandex-team.ru,
 raphael.s.norwitz@gmail.com
Subject: [PATCH v9 2/8] qapi: introduce query-backend-transfer-support
Date: Thu, 30 Oct 2025 23:31:09 +0300
Message-ID: <20251030203116.870742-3-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251030203116.870742-1-vsementsov@yandex-team.ru>
References: <20251030203116.870742-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c41:1300:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1d.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

We are going to implement backend-transfer feature: some devices
will be able to transfer their backend through migration stream
for local migration through UNIX domain socket. For example,
virtio-net will migrate its attached TAP netdev, with all its
connected file descriptors.

Let's add a command to list supporting devices (no one for now),
together with necessary infrastructure in qdev code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 include/hw/qdev-core.h |  7 +++++++
 qapi/qdev.json         | 26 +++++++++++++++++++++++++
 system/qdev-monitor.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 76 insertions(+)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2caa0cbd26..0551fbaa6c 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -96,6 +96,7 @@ typedef void (*DeviceReset)(DeviceState *dev);
 typedef void (*BusRealize)(BusState *bus, Error **errp);
 typedef void (*BusUnrealize)(BusState *bus);
 typedef int (*DeviceSyncConfig)(DeviceState *dev, Error **errp);
+typedef bool (*DeviceSupportBackendTransfer)(DeviceState *dev, Error **errp);
 
 /**
  * struct DeviceClass - The base class for all devices.
@@ -174,6 +175,12 @@ struct DeviceClass {
     DeviceUnrealize unrealize;
     DeviceSyncConfig sync_config;
 
+    /**
+     * @backend_transfer_support: reports support for backend-transfer
+     * migration of the device.
+     */
+    DeviceSupportBackendTransfer backend_transfer_support;
+
     /**
      * @vmsd: device state serialisation description for
      * migration/save/restore
diff --git a/qapi/qdev.json b/qapi/qdev.json
index e14a0c9259..d7e878d58d 100644
--- a/qapi/qdev.json
+++ b/qapi/qdev.json
@@ -188,3 +188,29 @@
 { 'command': 'device-sync-config',
   'features': [ 'unstable' ],
   'data': {'id': 'str'} }
+
+##
+# @DevPath:
+#
+# @path: the device's QOM path
+#
+# Since: 10.2
+##
+{ 'struct': 'DevPath',
+  'data': { 'path': 'str' } }
+
+##
+# @query-backend-transfer-support:
+#
+# Returns list of devices, supporting backend-transfer
+# migration.
+#
+# Features:
+#
+# @unstable: The command is experimental.
+#
+# Since: 10.2
+##
+{ 'command': 'query-backend-transfer-support',
+  'features': [ 'unstable' ],
+  'returns': [ 'DevPath' ] }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index ec4a2394ce..9d3d961c15 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -939,6 +939,49 @@ void qmp_device_del(const char *id, Error **errp)
     }
 }
 
+static bool qdev_backend_transfer_support(DeviceState *dev, Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->backend_transfer_support) {
+        error_setg(errp, "backend-transfer is not supported for '%s'",
+                   object_get_typename(OBJECT(dev)));
+        return false;
+    }
+
+    return dc->backend_transfer_support(dev, errp);
+}
+
+static int qdev_add_if_backend_transfer_supported(Object *obj, void *opaque)
+{
+    DevPathList **list = opaque;
+    DeviceState *dev = (DeviceState *)object_dynamic_cast(obj, TYPE_DEVICE);
+
+    if (dev != NULL && qdev_backend_transfer_support(dev, NULL)) {
+        DevPath *el = g_new(DevPath, 1);
+        *el = (DevPath) {
+            .path = g_strdup(dev->canonical_path),
+        };
+        QAPI_LIST_PREPEND(*list, el);
+    }
+
+    /* Recursively check all children */
+    object_child_foreach(obj, qdev_add_if_backend_transfer_supported, opaque);
+
+    return 0;
+}
+
+DevPathList *qmp_query_backend_transfer_support(Error **errp)
+{
+    DevPathList *result = NULL;
+    Object *peripheral = machine_get_container("peripheral");
+
+    object_child_foreach(peripheral, qdev_add_if_backend_transfer_supported,
+                         &result);
+
+    return result;
+}
+
 int qdev_sync_config(DeviceState *dev, Error **errp)
 {
     DeviceClass *dc = DEVICE_GET_CLASS(dev);
-- 
2.48.1


