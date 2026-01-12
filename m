Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1351C9EC66
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 10:46:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfFQa-0003A1-0c; Mon, 12 Jan 2026 05:45:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vfFQW-00038l-0j; Mon, 12 Jan 2026 05:45:36 -0500
Received: from proxmox-new.maurer-it.com ([94.136.29.106])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <f.ebner@proxmox.com>)
 id 1vfFQU-0003jt-3j; Mon, 12 Jan 2026 05:45:35 -0500
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id EAFD745F1E;
 Mon, 12 Jan 2026 11:45:23 +0100 (CET)
From: Fiona Ebner <f.ebner@proxmox.com>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 philmd@linaro.org, wangyanan55@huawei.com, zhao1.liu@intel.com,
 marcandre.lureau@redhat.com, peterx@redhat.com, farosas@suse.de
Subject: [PATCH] ui/vdagent: add migration blocker when machine version < 10.1
Date: Mon, 12 Jan 2026 11:39:20 +0100
Message-ID: <20260112104454.54225-1-f.ebner@proxmox.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1768214679844
Received-SPF: pass client-ip=94.136.29.106; envelope-from=f.ebner@proxmox.com;
 helo=proxmox-new.maurer-it.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
---
 hw/core/machine.c |  1 +
 ui/vdagent.c      | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 6411e68856..9a5241ce17 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -55,6 +55,7 @@ GlobalProperty hw_compat_10_0[] = {
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
     { "ramfb", "use-legacy-x86-rom", "true"},
     { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
+    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 142a3691ac..15ecabb402 100644
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
@@ -32,6 +34,10 @@
 struct VDAgentChardev {
     Chardev parent;
 
+    /* needed for machine versions < 10.1 when migration was not supported */
+    Error *migration_blocker;
+    bool migration_blocked;
+
     /* config */
     bool mouse;
     bool clipboard;
@@ -677,6 +683,12 @@ static void vdagent_chr_open(Chardev *chr,
     return;
 #endif
 
+    if (vd->migration_blocked) {
+        if (migrate_add_blocker(&vd->migration_blocker, errp) != 0) {
+            return;
+        }
+    }
+
     vd->mouse = VDAGENT_MOUSE_DEFAULT;
     if (cfg->has_mouse) {
         vd->mouse = cfg->mouse;
@@ -920,6 +932,19 @@ static void vdagent_chr_parse(QemuOpts *opts, ChardevBackend *backend,
 
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
@@ -929,6 +954,10 @@ static void vdagent_chr_class_init(ObjectClass *oc, const void *data)
     cc->chr_write        = vdagent_chr_write;
     cc->chr_set_fe_open  = vdagent_chr_set_fe_open;
     cc->chr_accept_input = vdagent_chr_accept_input;
+
+    object_class_property_add_bool(oc, "x-migration-blocked",
+                                   get_migration_blocked,
+                                   set_migration_blocked);
 }
 
 static int post_load(void *opaque, int version_id)
@@ -1083,10 +1112,26 @@ static void vdagent_chr_init(Object *obj)
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
@@ -1099,6 +1144,7 @@ static const TypeInfo vdagent_chr_type_info = {
     .parent = TYPE_CHARDEV,
     .instance_size = sizeof(VDAgentChardev),
     .instance_init = vdagent_chr_init,
+    .instance_post_init = vdagent_post_init,
     .instance_finalize = vdagent_chr_fini,
     .class_init = vdagent_chr_class_init,
 };
-- 
2.47.3



