Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E29AEFED9F1
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 17:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Y5I-0001zV-9E; Tue, 17 Mar 2026 13:20:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y5A-0001y1-Os
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w2Y59-0005LY-57
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 13:19:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773767987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d2oa4jNZrM8nxVU60xxjphplTABbIomDVBGu/FAbo40=;
 b=aqP5hPl2achjGCveQA0/3264oZSijZs6DZPCVx1p60w/j2OnXcthvIB280tHDjk1Dz26bT
 8dY0WkvWvLK1hhZg4946IMcLU4vasJSKRxETC+qEYF2qllIyg/V0YHOp1yclM7Ipwu2/eH
 vyRzfBXhhpepMTBtaiYrGowRqQLpN4I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-168-PY3LEd9IMpmzPbuOeaL1xw-1; Tue,
 17 Mar 2026 13:19:46 -0400
X-MC-Unique: PY3LEd9IMpmzPbuOeaL1xw-1
X-Mimecast-MFC-AGG-ID: PY3LEd9IMpmzPbuOeaL1xw_1773767984
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2B57F1956089; Tue, 17 Mar 2026 17:19:44 +0000 (UTC)
Received: from localhost (unknown [10.44.22.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 70F3530002C3; Tue, 17 Mar 2026 17:19:41 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Fiona Ebner <f.ebner@proxmox.com>, qemu-stable@nongnu.org
Subject: [PULL 03/16] ui/vdagent: add migration blocker when machine version <
 10.1
Date: Tue, 17 Mar 2026 21:19:03 +0400
Message-ID: <20260317171916.438575-4-marcandre.lureau@redhat.com>
In-Reply-To: <20260317171916.438575-1-marcandre.lureau@redhat.com>
References: <20260317171916.438575-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Fiona Ebner <f.ebner@proxmox.com>

In QEMU 10.1, commit 5d56bff11e ("ui/vdagent: add migration support")
added migration support for the vdagent chardev and commit 42000e0013
("ui/vdagent: remove migration blocker") removed the migration
blocker. No compat for older machine versions was added, so migration
with pre-10.1 machine version, from a 10.1 binary to a pre-10.1 binary
will result in a failure when loading the VM state in the target
instance:

> Unknown savevm section or instance 'vdagent' 0. Make sure that your
> current VM setup matches your saved VM setup, including any
> hotplugged devices

Add a compat flag to block migration when the machine version is less
than 10.1 to avoid this.

Cc: qemu-stable@nongnu.org
Fixes: 42000e0013 ("ui/vdagent: remove migration blocker")
Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-Id: <20260310142552.240877-1-f.ebner@proxmox.com>
---
 hw/core/machine.c |  1 +
 ui/vdagent.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index a14ad05b9a6..6cf0e2f404e 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -57,6 +57,7 @@ GlobalProperty hw_compat_10_0[] = {
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
     { "ramfb", "use-legacy-x86-rom", "true"},
     { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
+    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 5a5e4bf6818..bb0c4aa14ca 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -6,6 +6,8 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "hw/core/qdev.h"
+#include "hw/core/qdev-properties.h"
+#include "migration/blocker.h"
 #include "ui/clipboard.h"
 #include "ui/console.h"
 #include "ui/input.h"
@@ -24,6 +26,10 @@
 struct VDAgentChardev {
     Chardev parent;
 
+    /* needed for machine versions < 10.1 when migration was not supported */
+    Error *migration_blocker;
+    bool migration_blocked;
+
     /* config */
     bool mouse;
     bool clipboard;
@@ -657,6 +663,12 @@ static bool vdagent_chr_open(Chardev *chr, ChardevBackend *backend,
     return false;
 #endif
 
+    if (vd->migration_blocked) {
+        if (migrate_add_blocker(&vd->migration_blocker, errp) != 0) {
+            return false;
+        }
+    }
+
     vd->mouse = VDAGENT_MOUSE_DEFAULT;
     if (cfg->has_mouse) {
         vd->mouse = cfg->mouse;
@@ -901,6 +913,19 @@ static void vdagent_chr_parse(QemuOpts *opts, ChardevBackend *backend,
 
 /* ------------------------------------------------------------------ */
 
+static bool get_migration_blocked(Object *o, Error **errp)
+{
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(o);
+    return vd->migration_blocked;
+}
+
+static void set_migration_blocked(Object *o, bool migration_blocked,
+                                   Error **errp)
+{
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(o);
+    vd->migration_blocked = migration_blocked;
+}
+
 static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
 {
     ChardevClass *cc = CHARDEV_CLASS(oc);
@@ -910,6 +935,10 @@ static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
     cc->chr_write        = vdagent_chr_write;
     cc->chr_set_fe_open  = vdagent_chr_set_fe_open;
     cc->chr_accept_input = vdagent_chr_accept_input;
+
+    object_class_property_add_bool(oc, "x-migration-blocked",
+                                   get_migration_blocked,
+                                   set_migration_blocked);
 }
 
 static int post_load(void *opaque, int version_id)
@@ -1064,10 +1093,26 @@ static void vdagent_chr_instance_init(Object *obj)
     vmstate_register_any(NULL, &vmstate_vdagent, vd);
 }
 
+static void vdagent_post_init(Object *obj)
+{
+    VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
+
+    object_apply_compat_props(obj);
+
+    if (vd->migration_blocked) {
+        error_setg(&vd->migration_blocker,
+                   "The vdagent chardev doesn't support migration with machine"
+                   " version less than 10.1");
+    }
+}
+
 static void vdagent_chr_fini(Object *obj)
 {
     VDAgentChardev *vd = QEMU_VDAGENT_CHARDEV(obj);
 
+    if (vd->migration_blocked) {
+        migrate_del_blocker(&vd->migration_blocker);
+    }
     vdagent_disconnect(vd);
     if (vd->mouse_hs) {
         qemu_input_handler_unregister(vd->mouse_hs);
@@ -1080,6 +1125,7 @@ static const TypeInfo vdagent_chr_type_info = {
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VDAgentChardev),
     .instance_init = vdagent_chr_instance_init,
+    .instance_post_init = vdagent_post_init,
     .instance_finalize = vdagent_chr_fini,
     .class_init = vdagent_chr_class_init,
 };
-- 
2.53.0


