Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A31FC982D8
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:57:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7wV4-0007p3-4p; Sat, 19 Sep 2026 10:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUf-0007mV-6f
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:47 -0400
Received: from beige.yew.relay.mailchannels.net ([23.83.220.16])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUd-0004cv-3P
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:44 -0400
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id DBEAA160D65;
 Sat, 19 Sep 2026 14:56:40 +0000 (UTC)
Received: from sh-cp12.mia1.servername.online
 (100-100-63-42.trex-nlb.outbound.svc.cluster.local [100.100.63.42])
 (Authenticated sender: hostpapa)
 by relay.mailchannels.net (Postfix) with ESMTPA id 63D261610F9;
 Sat, 19 Sep 2026 14:56:40 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
X-MC-Relay: Good
X-MailChannels-SenderId: hostpapa|x-authuser|frode@tennebo.com
X-MailChannels-Auth-Id: hostpapa
X-Cooperative-Cooperative: 4a84ee0345d0bbf4_1789829800810_3452067029
X-MC-Loop-Signature: 1789829800810:1387936756
X-MC-Ingress-Time: 1789829800809
Received: from sh-cp12.mia1.servername.online (sh-cp12.mia1.servername.online
 [199.204.250.122]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.100.63.42 (trex/8.0.2); Sat, 19 Sep 2026 14:56:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tennebo.com
 ; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2jKqGYMQ5lWVfbxi4OAOtc7dYKXEICaqwwtDwDEvsSc=; b=M5mOK74183CMBDC8W4QeThKwEe
 ffpdK0UXrFJSuLsq/xgjduclnEOFD+uCRG0YYVyCTXc6LdW44HO4vG9/TNYlywNI/CBdSuKm7rxFd
 APCNfXsacZKnGZT0weE80IlAUd88QcJIvnJGJcH5Dn+sw5lMr5L64rLPxlCkP59GjwNPgG9Uq5W10
 RKRVQW8XZvJGHrjHxprdxY1kcNl4ki1THNtMCRiKkMKMrSKPCKXACobXK8CcnE1xWv+NO/ZCUx2w+
 79iwlzUpvCYgQ4SJH17OzRHiWw+GU5qXIz4qaozI6kx/x+ReK7dIDh1yJ+xXM9hgwQfdKGYS/VKI8
 ANtDz0XQ==;
Received: from 55a44a6c.bb.online.no ([85.164.74.108]:50478 helo=[127.0.1.1])
 by sh-cp12.mia1.servername.online with essmtpa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.100)
 (envelope-from <frode@tennebo.com>) id 1x7wUX-0000000BpqJ-0q0q;
 Sat, 19 Sep 2026 10:56:39 -0400
From: =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
Date: Sat, 19 Sep 2026 16:56:04 +0200
Subject: [PATCH 3/3] hw/sparc64: add hostid= and machineid= -machine
 sub-properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260919-add_hostid_sub-properties-v1-3-cc1667c0a8ad@tennebo.com>
References: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
In-Reply-To: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
X-Mailer: b4 0.13.0
X-AuthUser: frode@tennebo.com
Received-SPF: pass client-ip=23.83.220.16; envelope-from=frode@tennebo.com;
 helo=beige.yew.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 19 Sep 2026 10:57:06 -0400
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

This is a continuation of previous commits:  Extend the hostid=/machineid=
-machine sub-properties added for sun4m to the sun4u and sun4v machines:

    qemu-system-sparc64 -machine sun4u,hostid=0x352e09,machineid=0x72

Introduce a common sun4u-common abstract machine class
(Sun4uMachineState/TYPE_SUN4U_MACHINE) as the parent of both "sun4u"
and "sun4v", and register the properties on it once via the shared
hw/sparc/sun_hostid.c helper (also used by sun4m.c); both machines
pick them up through QOM's class-hierarchy property lookup, with no
changes needed in sun4u_class_init()/sun4v_class_init() themselves.

Document the new properties in docs/system/target-sparc64.rst.

Both properties default to the existing behaviour when unset, so
this is fully backward compatible. Note that the "niagara" machine
(hw/sparc64/niagara.c) is a separate machine family that does not
use the classic Sun NVRAM/IDPROM hostid mechanism, and is
unaffected by this commit.

Signed-off-by: Frode Tennebø <frode@tennebo.com>
---
 docs/system/target-sparc64.rst | 22 +++++++++++++
 hw/sparc64/meson.build         |  1 +
 hw/sparc64/sun4u.c             | 73 ++++++++++++++++++++++++++++++++++++++----
 3 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/docs/system/target-sparc64.rst b/docs/system/target-sparc64.rst
index 97e334b930..545bc3fc65 100644
--- a/docs/system/target-sparc64.rst
+++ b/docs/system/target-sparc64.rst
@@ -35,3 +35,25 @@ QEMU emulates the following peripherals:
 -  2 PCI IDE interfaces with hard disk and CD-ROM support
 
 -  Floppy disk
+
+Every sun4[uv] machine reports a classic Sun "hostid" to the guest OS,
+historically used by ``hostid(1)``, that some software use for license
+checks. Normally it is built from a fixed machine id (defaults to 0x80)
+byte plus the low 3 bytes of the machine's Ethernet MAC address. However,
+these values can be overridden in the host's NVRAM. Since the current
+emulated NVRAM isn't persistent, both halves can be overridden
+independently using the ``hostid`` and ``machineid`` -machine
+sub-properties::
+
+    qemu-system-sparc64 -machine sun4u,hostid=0x352e09,machineid=0x72
+
+``hostid=VALUE``
+  Override the low 24 bits of the NVRAM/IDPROM hostid (accepts
+  0x000000-0xffffff). Does not affect the emulated Lance NIC's MAC
+  address, which is still set independently via ``-nic``/``-net``.
+
+``machineid=VALUE``
+  Override the machine-type byte (bits 31:24 of the hostid) normally
+  fixed per machine model, e.g. 0x80 for sun4u (accepts 0x00-0xff).
+
+If neither property is given, the behaviour is unchanged.
diff --git a/hw/sparc64/meson.build b/hw/sparc64/meson.build
index 58b5504651..66f7e9a9fb 100644
--- a/hw/sparc64/meson.build
+++ b/hw/sparc64/meson.build
@@ -2,5 +2,6 @@ sparc64_ss = ss.source_set()
 sparc64_ss.add(files('sparc64.c'))
 sparc64_ss.add(when: 'CONFIG_NIAGARA', if_true: files('niagara.c'))
 sparc64_ss.add(when: 'CONFIG_SUN4U', if_true: files('sun4u.c', 'sun4u_iommu.c'))
+sparc64_ss.add(when: 'CONFIG_SUN4U', if_true: files('../sparc/sun_hostid.c'))
 
 hw_arch += {'sparc64': sparc64_ss}
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index e677daaf97..a8538ba313 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -26,6 +26,7 @@
 #include "qemu/units.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
+#include "hw/sparc/sun_hostid.h"
 #include "qemu/datadir.h"
 #include "target/sparc/cpu.h"
 #include "exec/target_page.h"
@@ -96,6 +97,39 @@ struct EbusState {
 #define TYPE_EBUS "ebus"
 OBJECT_DECLARE_SIMPLE_TYPE(EbusState, EBUS)
 
+/*
+ * Sun4uMachineState/TYPE_SUN4U_MACHINE: common abstract instance/class
+ * pair shared by "sun4u" and "sun4v", giving both the hostid=/
+ * machineid= -machine properties via one sun_hostid_class_init()
+ * (from hw/sparc/sun_hostid.c) call here (property lookup walks up
+ * the class hierarchy, so sun4u_class_init()/sun4v_class_init()
+ * don't need to call it too).
+ */
+struct Sun4uMachineState {
+    MachineState parent_obj;
+    SunHostIDProps hostid_props;
+};
+typedef struct Sun4uMachineState Sun4uMachineState;
+
+struct Sun4uMachineClass {
+    MachineClass parent_obj;
+};
+typedef struct Sun4uMachineClass Sun4uMachineClass;
+
+#define TYPE_SUN4U_MACHINE MACHINE_TYPE_NAME("sun4u-common")
+OBJECT_DECLARE_TYPE(Sun4uMachineState, Sun4uMachineClass, SUN4U_MACHINE)
+
+static void sun4u_machine_instance_init(Object *obj)
+{
+    sun_hostid_instance_init(obj, offsetof(Sun4uMachineState,
+                                            hostid_props));
+}
+
+static void sun4u_common_class_init(ObjectClass *oc, const void *data)
+{
+    sun_hostid_class_init(oc, offsetof(Sun4uMachineState, hostid_props));
+}
+
 const char *fw_cfg_arch_key_name(uint16_t key)
 {
     static const struct {
@@ -129,7 +163,9 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
                                   uint32_t initrd_image, uint32_t initrd_size,
                                   uint32_t NVRAM_image,
                                   int width, int height, int depth,
-                                  const uint8_t *macaddr)
+                                  const uint8_t *macaddr,
+                                  uint8_t machine_id,
+                                  const uint8_t *hostid)
 {
     unsigned int i;
     int sysp_end;
@@ -145,7 +181,7 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
     chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);
 
     Sun_init_header((struct Sun_nvram *)&image[0x1fd8], macaddr,
-                    0x80, NULL);
+                    machine_id, hostid);
 
     for (i = 0; i < sizeof(image); i++) {
         (k->write)(nvram, i, image[i]);
@@ -680,6 +716,19 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                                     machine->ram_size, &initrd_size, &initrd_addr,
                                     &kernel_addr, &kernel_entry);
 
+    Sun4uMachineState *sms = SUN4U_MACHINE(machine);
+    uint8_t nvram_machine_id = 0x80;
+    uint8_t nvram_hostid[3];
+
+    if (sms->hostid_props.machineid_set) {
+        nvram_machine_id = sms->hostid_props.machineid;
+    }
+    if (sms->hostid_props.hostid_set) {
+        nvram_hostid[0] = (sms->hostid_props.hostid >> 16) & 0xff;
+        nvram_hostid[1] = (sms->hostid_props.hostid >> 8) & 0xff;
+        nvram_hostid[2] = sms->hostid_props.hostid & 0xff;
+    }
+
     sun4u_NVRAM_set_params(nvram, NVRAM_SIZE, "Sun4u", machine->ram_size,
                            machine->boot_config.order,
                            kernel_addr, kernel_size,
@@ -688,7 +737,9 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
                            /* XXX: need an option to load a NVRAM image */
                            0,
                            graphic_width, graphic_height, graphic_depth,
-                           (uint8_t *)&macaddr);
+                           (uint8_t *)&macaddr,
+                           nvram_machine_id,
+                           sms->hostid_props.hostid_set ? nvram_hostid : NULL);
 
     dev = qdev_new(TYPE_FW_CFG_IO);
     qdev_prop_set_bit(dev, "dma_enabled", false);
@@ -824,7 +875,7 @@ static void sun4u_class_init(ObjectClass *oc, const void *data)
 
 static const TypeInfo sun4u_type = {
     .name = MACHINE_TYPE_NAME("sun4u"),
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_SUN4U_MACHINE,
     .class_init = sun4u_class_init,
     .interfaces = (const InterfaceInfo[]) {
         { TYPE_FW_PATH_PROVIDER },
@@ -849,17 +900,25 @@ static void sun4v_class_init(ObjectClass *oc, const void *data)
 
 static const TypeInfo sun4v_type = {
     .name = MACHINE_TYPE_NAME("sun4v"),
-    .parent = TYPE_MACHINE,
+    .parent = TYPE_SUN4U_MACHINE,
     .class_init = sun4v_class_init,
 };
-
+static const TypeInfo sun4u_common_type = {
+    .name          = TYPE_SUN4U_MACHINE,
+    .parent        = TYPE_MACHINE,
+    .abstract      = true,
+    .instance_size = sizeof(Sun4uMachineState),
+    .instance_init = sun4u_machine_instance_init,
+    .class_size    = sizeof(Sun4uMachineClass),
+    .class_init    = sun4u_common_class_init,
+};
 static void sun4u_register_types(void)
 {
     type_register_static(&power_info);
     type_register_static(&ebus_info);
     type_register_static(&prom_info);
     type_register_static(&ram_info);
-
+    type_register_static(&sun4u_common_type);
     type_register_static(&sun4u_type);
     type_register_static(&sun4v_type);
 }

-- 
2.43.0


