Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 445D2CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuLF-0001WN-K3; Tue, 12 May 2026 17:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJh-0008BM-Mb; Tue, 12 May 2026 17:07:02 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuJf-00028O-Qv; Tue, 12 May 2026 17:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=fujevpJL0px7HAaT3KQH46PQF8625qYraEH2pbFeLU4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ddty8hM63dtarF4r0lFPmFgs3jyucWJ1XGytVZwc552HezwAujfMR4pU9M3BKiWMG
 JojL+0j7m2xAhDcZdTA9sr2CWnWqVvjp7nnVBTDGURT8dnOy1ZJos5l+y+FLGI6dDz
 G8U/Ug4HxSCEhMs5PpViZJzYyrQ09pKPX1lgdtqYliz9q8LPsF3uwfXakeNkq3J0NG
 bSVT8Q3Y0R9PzDvfuvNpXlEt47xAkjuVmTx6pHTQZFYr3DTEf6B9mBQKRzECBuGV96
 r7ZxSm0WfXPYHPgppaF2cXVf7Rq7HI1R547c9bH7yk4a7Cbwixqom6NVToB13oO4YX
 iOQ8l0vx5e7qQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB72D1AA34A;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B54993ABCBB;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Fiona Ebner <f.ebner@proxmox.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 014/117] ui/vdagent: add migration blocker when
 machine version < 10.1
Date: Tue, 12 May 2026 23:53:16 +0300
Message-ID: <20260512205503.361097-14-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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
(cherry picked from commit 6f23dde620efa2de1cf3c56dfb474a20d9ce876d)
(Mjt: backport to 10.2.x: qdev-properties.h path and vdagent_chr_open return)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 27372bb01e..53c41b1ebe 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -52,6 +52,7 @@ GlobalProperty hw_compat_10_0[] = {
     { "vfio-pci", "x-migration-load-config-after-iter", "off" },
     { "ramfb", "use-legacy-x86-rom", "true"},
     { "vfio-pci-nohotplug", "use-legacy-x86-rom", "true" },
+    { "chardev-qemu-vdagent", "x-migration-blocked", "true" },
 };
 const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
 
diff --git a/ui/vdagent.c b/ui/vdagent.c
index 660686c9c0..1ca90c70df 100644
--- a/ui/vdagent.c
+++ b/ui/vdagent.c
@@ -6,6 +6,8 @@
 #include "qemu/option.h"
 #include "qemu/units.h"
 #include "hw/qdev-core.h"
+#include "hw/qdev-properties.h"
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


