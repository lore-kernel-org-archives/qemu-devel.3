Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42743C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 20:00:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucrDj-0004sz-H8; Fri, 18 Jul 2025 15:58:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ucqzz-0006V3-VK
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:44:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1ucqzw-0000Im-C2
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 15:44:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752867838;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OGr6PxHpLP3qnExVQb0ysE5TxQ9YrF84ID3Kvi0mh1s=;
 b=dWAyLWAnwIC9ZXnNiuBG0/FG2rda4SwK6Mr8wMRBvB+mlK7YinJFKlCqIIxU4X7fN8sptr
 YB3Z7l5nyJ5I8hAL0PB7IkaATzigsxhRFs4dZrGRuTNSmB5eVAKm5ElTJ3J6fPu3bbCzMR
 LzOu1DRAj9xwvxQFoie5MGqcwNKzOkk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-3aLRbRJEOrmMoD5q4yfvbQ-1; Fri,
 18 Jul 2025 15:43:54 -0400
X-MC-Unique: 3aLRbRJEOrmMoD5q4yfvbQ-1
X-Mimecast-MFC-AGG-ID: 3aLRbRJEOrmMoD5q4yfvbQ_1752867833
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67028180029E; Fri, 18 Jul 2025 19:43:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.32.25])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 957A61800D82; Fri, 18 Jul 2025 19:43:51 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 85E27180060B; Fri, 18 Jul 2025 21:43:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Yanan Wang <wangyanan55@huawei.com>,
 Shaoqin Huang <shahuang@redhat.com>, Eric Auger <eric.auger@redhat.com>
Subject: [PULL 1/3] ramfb: Add property to control if load the romfile
Date: Fri, 18 Jul 2025 21:43:47 +0200
Message-ID: <20250718194349.65771-2-kraxel@redhat.com>
In-Reply-To: <20250718194349.65771-1-kraxel@redhat.com>
References: <20250718194349.65771-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Shaoqin Huang <shahuang@redhat.com>

Currently the ramfb device loads the vgabios-ramfb.bin unconditionally,
but only the x86 need the vgabios-ramfb.bin, this can cause that when
use the release package on arm64 it can't find the vgabios-ramfb.bin.

Because only seabios will use the vgabios-ramfb.bin, load the rom logic
is x86-specific. For other !x86 platforms, the edk2 ships an EFI driver
for ramfb, so they don't need to load the romfile.

So add a new property use-legacy-x86-rom in both ramfb and vfio_pci
device, because the vfio display also use the ramfb_setup() to load
the vgabios-ramfb.bin file.

After have this property, the machine type can set the compatibility to
not load the vgabios-ramfb.bin if the arch doesn't need it.

For now the default value is true but it will be turned off by default
in subsequent patch when compats get properly handled.

Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shaoqin Huang <shahuang@redhat.com>
Message-ID: <20250717100941.2230408-2-shahuang@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/vfio/pci.h                 | 1 +
 include/hw/display/ramfb.h    | 2 +-
 hw/display/ramfb-standalone.c | 5 ++++-
 hw/display/ramfb-stubs.c      | 2 +-
 hw/display/ramfb.c            | 6 ++++--
 hw/vfio/display.c             | 4 ++--
 hw/vfio/pci.c                 | 2 ++
 7 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index 495fae737d3a..826db8c1319b 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -188,6 +188,7 @@ struct VFIOPCIDevice {
     bool no_kvm_ioeventfd;
     bool no_vfio_ioeventfd;
     bool enable_ramfb;
+    bool use_legacy_x86_rom;
     OnOffAuto ramfb_migrate;
     bool defer_kvm_irq_routing;
     bool clear_parent_atomics_on_exit;
diff --git a/include/hw/display/ramfb.h b/include/hw/display/ramfb.h
index a7e00191445e..172aa6dc89e8 100644
--- a/include/hw/display/ramfb.h
+++ b/include/hw/display/ramfb.h
@@ -6,7 +6,7 @@
 /* ramfb.c */
 typedef struct RAMFBState RAMFBState;
 void ramfb_display_update(QemuConsole *con, RAMFBState *s);
-RAMFBState *ramfb_setup(Error **errp);
+RAMFBState *ramfb_setup(bool romfile, Error **errp);
 
 extern const VMStateDescription ramfb_vmstate;
 
diff --git a/hw/display/ramfb-standalone.c b/hw/display/ramfb-standalone.c
index 08f2d5db4eca..82d8c69f8903 100644
--- a/hw/display/ramfb-standalone.c
+++ b/hw/display/ramfb-standalone.c
@@ -17,6 +17,7 @@ struct RAMFBStandaloneState {
     QemuConsole *con;
     RAMFBState *state;
     bool migrate;
+    bool use_legacy_x86_rom;
 };
 
 static void display_update_wrapper(void *dev)
@@ -39,7 +40,7 @@ static void ramfb_realizefn(DeviceState *dev, Error **errp)
     RAMFBStandaloneState *ramfb = RAMFB(dev);
 
     ramfb->con = graphic_console_init(dev, 0, &wrapper_ops, dev);
-    ramfb->state = ramfb_setup(errp);
+    ramfb->state = ramfb_setup(ramfb->use_legacy_x86_rom, errp);
 }
 
 static bool migrate_needed(void *opaque)
@@ -62,6 +63,8 @@ static const VMStateDescription ramfb_dev_vmstate = {
 
 static const Property ramfb_properties[] = {
     DEFINE_PROP_BOOL("x-migrate", RAMFBStandaloneState, migrate,  true),
+    DEFINE_PROP_BOOL("use-legacy-x86-rom", RAMFBStandaloneState,
+                     use_legacy_x86_rom, true),
 };
 
 static void ramfb_class_initfn(ObjectClass *klass, const void *data)
diff --git a/hw/display/ramfb-stubs.c b/hw/display/ramfb-stubs.c
index cf64733b10cd..b83551357bb3 100644
--- a/hw/display/ramfb-stubs.c
+++ b/hw/display/ramfb-stubs.c
@@ -8,7 +8,7 @@ void ramfb_display_update(QemuConsole *con, RAMFBState *s)
 {
 }
 
-RAMFBState *ramfb_setup(Error **errp)
+RAMFBState *ramfb_setup(bool romfile, Error **errp)
 {
     error_setg(errp, "ramfb support not available");
     return NULL;
diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
index 8c0f907673da..9a17d97d076f 100644
--- a/hw/display/ramfb.c
+++ b/hw/display/ramfb.c
@@ -135,7 +135,7 @@ const VMStateDescription ramfb_vmstate = {
     }
 };
 
-RAMFBState *ramfb_setup(Error **errp)
+RAMFBState *ramfb_setup(bool romfile, Error **errp)
 {
     FWCfgState *fw_cfg = fw_cfg_find();
     RAMFBState *s;
@@ -147,7 +147,9 @@ RAMFBState *ramfb_setup(Error **errp)
 
     s = g_new0(RAMFBState, 1);
 
-    rom_add_vga("vgabios-ramfb.bin");
+    if (romfile) {
+        rom_add_vga("vgabios-ramfb.bin");
+    }
     fw_cfg_add_file_callback(fw_cfg, "etc/ramfb",
                              NULL, ramfb_fw_cfg_write, s,
                              &s->cfg, sizeof(s->cfg), false);
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index 9c6f5aa265dd..faacd9019a55 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -365,7 +365,7 @@ static bool vfio_display_dmabuf_init(VFIOPCIDevice *vdev, Error **errp)
                                           &vfio_display_dmabuf_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(errp);
+        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
         if (!vdev->dpy->ramfb) {
             return false;
         }
@@ -494,7 +494,7 @@ static bool vfio_display_region_init(VFIOPCIDevice *vdev, Error **errp)
                                           &vfio_display_region_ops,
                                           vdev);
     if (vdev->enable_ramfb) {
-        vdev->dpy->ramfb = ramfb_setup(errp);
+        vdev->dpy->ramfb = ramfb_setup(vdev->use_legacy_x86_rom, errp);
         if (!vdev->dpy->ramfb) {
             return false;
         }
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 1093b28df7c3..0b969b3359db 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3809,6 +3809,8 @@ static const TypeInfo vfio_pci_dev_info = {
 
 static const Property vfio_pci_dev_nohotplug_properties[] = {
     DEFINE_PROP_BOOL("ramfb", VFIOPCIDevice, enable_ramfb, false),
+    DEFINE_PROP_BOOL("use-legacy-x86-rom", VFIOPCIDevice,
+                     use_legacy_x86_rom, true),
     DEFINE_PROP_ON_OFF_AUTO("x-ramfb-migrate", VFIOPCIDevice, ramfb_migrate,
                             ON_OFF_AUTO_AUTO),
 };
-- 
2.50.1


