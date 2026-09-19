Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A910FC982E9
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2026 14:57:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7wV1-0007ob-Ry; Sat, 19 Sep 2026 10:57:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUZ-0007mB-4W
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:39 -0400
Received: from bisque.pear.relay.mailchannels.net ([23.83.216.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <frode@tennebo.com>) id 1x7wUW-0004cj-FZ
 for qemu-devel@nongnu.org; Sat, 19 Sep 2026 10:56:38 -0400
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id 97E3E94083E;
 Sat, 19 Sep 2026 14:56:34 +0000 (UTC)
Received: from sh-cp12.mia1.servername.online
 (100-99-48-45.trex-nlb.outbound.svc.cluster.local [100.99.48.45])
 (Authenticated sender: hostpapa)
 by relay.mailchannels.net (Postfix) with ESMTPA id 288009415DF;
 Sat, 19 Sep 2026 14:56:34 +0000 (UTC)
X-Sender-Id: hostpapa|x-authuser|frode@tennebo.com
X-MC-Relay: Good
X-MailChannels-SenderId: hostpapa|x-authuser|frode@tennebo.com
X-MailChannels-Auth-Id: hostpapa
X-Well-Made-Belong: 685f15162c8c39a3_1789829794569_1398387228
X-MC-Loop-Signature: 1789829794569:3607864318
X-MC-Ingress-Time: 1789829794569
Received: from sh-cp12.mia1.servername.online (sh-cp12.mia1.servername.online
 [199.204.250.122]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.99.48.45 (trex/8.0.2); Sat, 19 Sep 2026 14:56:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tennebo.com
 ; s=default; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WnkoRUFN8Qb+qmnkOqVdY7PDrUUla+Ddg8rfv9MHVxQ=; b=SZSfuCunPU5FR6wbNkjOmSjBQe
 bLdG9z2HckqKtRX/bbRugWvJQ1bXoWbLoiu60QF/Dbxm+B9OpOV2tExDHcDCEvw2W/VfVXxpl/8sH
 vIK5IRA4QhbqroxVHDLcc900gc/44Emk5qt+OliIFkqACLio2RgebBDn6/BdL5b0RH7U53PG9ZB5c
 lHNldBQatUw20EpIG9iwtxJ0LiVu06xFE2nbrciVbbxleFbvSl3dIqmoGIn/El7mJUZ3+z4+BRuUv
 /4ItHe9AoP+MEjLNHACxmCS1izuvUrkSK5oHoaxb32bHz3JYnrY12cjZ+kKxReg2J04986buhB8AZ
 u0/wudHA==;
Received: from 55a44a6c.bb.online.no ([85.164.74.108]:50478 helo=[127.0.1.1])
 by sh-cp12.mia1.servername.online with essmtpa (TLS1.3) tls
 TLS_AES_256_GCM_SHA384 (Exim 4.100)
 (envelope-from <frode@tennebo.com>) id 1x7wUQ-0000000BpqJ-433i;
 Sat, 19 Sep 2026 10:56:33 -0400
From: =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
Date: Sat, 19 Sep 2026 16:56:03 +0200
Subject: [PATCH 2/3] hw/sparc: add hostid= and machineid= -machine
 sub-properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260919-add_hostid_sub-properties-v1-2-cc1667c0a8ad@tennebo.com>
References: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
In-Reply-To: <20260919-add_hostid_sub-properties-v1-0-cc1667c0a8ad@tennebo.com>
To: qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, 
 Artyom Tarasenko <atar4qemu@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Frode_Tenneb=C3=B8?= <frode@tennebo.com>
X-Mailer: b4 0.13.0
X-AuthUser: frode@tennebo.com
Received-SPF: pass client-ip=23.83.216.18; envelope-from=frode@tennebo.com;
 helo=bisque.pear.relay.mailchannels.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Sun sun4m hardware reports a 32-bit "hostid" (as read by the guest's
hostid(1), and historically used by some software for license checks)
built from two independent pieces stored in the NVRAM/IDPROM:

  * a fixed per-model machine-type byte (bits 31:24), e.g. 0x80 for
    a SPARCstation-5, 0x72 for a SPARCstation-20
  * the low 3 bytes (24 bits) of the machine's Ethernet MAC address
    (bits 23:0)

QEMU already reproduces this in nvram_init()/Sun_init_header(), but
until now both halves were fixed: the machine-type byte came from
sun4m_hwdef::nvram_machine_id, and the low 24 bits were copied
from whatever MAC address ended up on the emulated NIC.

Add "hostid" and "machineid" -machine sub-properties, shared across
every sun4m board via the sun4m-common abstract class, so both
halves can be set explicitly and independently of the emulated
NIC's MAC address:

    qemu-system-sparc -machine SS-20,hostid=0x352e09,machineid=0x80

Extend Sun_init_header() to take an optional hostid override,
falling back to its previous macaddr-derived behaviour if NULL,
and use the hw/sparc/sun_hostid.c helper (added in a previous
commit) for the property implementation itself. Document the new
properties in docs/system/target-sparc.rst.

hw/sparc64/sun4u.c is updated to pass NULL for the new hostid
parameter at its own Sun_init_header() call site, keeping its
existing behaviour unchanged; this is required for sun4u.c to
still build against the new prototype, sun4u/sun4v do not yet
expose hostid=/machineid= of their own (will be added in the next
commit).

Both properties default to the existing behaviour when unset, so
this is fully backward compatible.

Signed-off-by: Frode Tennebø <frode@tennebo.com>
---
 docs/system/target-sparc.rst | 23 ++++++++++++++++++
 hw/sparc/meson.build         |  1 +
 hw/sparc/sun4m.c             | 55 ++++++++++++++++++++++++++++++++++++++------
 hw/sparc64/sun4u.c           |  3 ++-
 include/hw/nvram/sun_nvram.h | 11 ++++++---
 5 files changed, 82 insertions(+), 11 deletions(-)

diff --git a/docs/system/target-sparc.rst b/docs/system/target-sparc.rst
index 4116cac493..82cfe9dd58 100644
--- a/docs/system/target-sparc.rst
+++ b/docs/system/target-sparc.rst
@@ -55,6 +55,29 @@ The number of peripherals is fixed in the architecture. Maximum memory
 size depends on the machine type, for SS-5 it is 256MB and for others
 2047MB.
 
+Every sun4[cdm] machine reports a classic Sun "hostid" to the guest OS,
+historically used by ``hostid(1)``, that some software use for license
+checks. Normally it is built from a fixed per-model machine-type byte
+plus the low 3 bytes of the machine's Ethernet MAC address. However,
+these values can be overridden in the host's NVRAM. Since the current
+emulated NVRAM isn't persistent, both halves can be overridden
+independently using the ``hostid`` and ``machineid`` -machine
+sub-properties::
+
+    qemu-system-sparc -machine SS-20,hostid=0x352e09,machineid=0x80
+
+``hostid=VALUE``
+  Override the low 24 bits of the NVRAM/IDPROM hostid (accepts
+  0x000000-0xffffff). Does not affect the emulated Lance NIC's MAC
+  address, which is still set independently via ``-nic``/``-net``.
+
+``machineid=VALUE``
+  Override the machine-type byte (bits 31:24 of the hostid) normally
+  fixed per machine model, e.g. 0x80 for SS-5, 0x72 for SS-20 (accepts
+  0x00-0xff).
+
+If neither property is given, the behaviour is unchanged.
+
 Since version 0.8.2, QEMU uses OpenBIOS https://www.openbios.org/.
 OpenBIOS is a free (GPL v2) portable firmware implementation. The goal
 is to implement a 100% IEEE 1275-1994 (referred to as Open Firmware)
diff --git a/hw/sparc/meson.build b/hw/sparc/meson.build
index 19c442c90d..bc8f226b4a 100644
--- a/hw/sparc/meson.build
+++ b/hw/sparc/meson.build
@@ -2,5 +2,6 @@ sparc_ss = ss.source_set()
 sparc_ss.add(when: 'CONFIG_LEON3', if_true: files('leon3.c'))
 sparc_ss.add(when: 'CONFIG_SUN4M', if_true: files('sun4m.c'))
 sparc_ss.add(when: 'CONFIG_SUN4M', if_true: files('sun4m_iommu.c'))
+sparc_ss.add(when: 'CONFIG_SUN4M', if_true: files('sun_hostid.c'))
 
 hw_arch += {'sparc': sparc_ss}
diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
index 550acdff6d..d86fb5c119 100644
--- a/hw/sparc/sun4m.c
+++ b/hw/sparc/sun4m.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qapi/error.h"
+#include "hw/sparc/sun_hostid.h"
 #include "qemu/datadir.h"
 #include "target/sparc/cpu.h"
 #include "exec/target_page.h"
@@ -107,6 +108,14 @@ struct sun4m_hwdef {
     uint8_t nvram_machine_id;
 };
 
+/* hostid_props carries the optional "hostid"/"machineid" overrides;
+ * see include/hw/sparc/sun_hostid.h. */
+struct Sun4mMachineState {
+    MachineState parent_obj;
+    SunHostIDProps hostid_props;
+};
+typedef struct Sun4mMachineState Sun4mMachineState;
+
 struct Sun4mMachineClass {
     /*< private >*/
     MachineClass parent_obj;
@@ -116,7 +125,13 @@ struct Sun4mMachineClass {
 typedef struct Sun4mMachineClass Sun4mMachineClass;
 
 #define TYPE_SUN4M_MACHINE MACHINE_TYPE_NAME("sun4m-common")
-DECLARE_CLASS_CHECKERS(Sun4mMachineClass, SUN4M_MACHINE, TYPE_SUN4M_MACHINE)
+OBJECT_DECLARE_TYPE(Sun4mMachineState, Sun4mMachineClass, SUN4M_MACHINE)
+
+static void sun4m_machine_instance_init(Object *obj)
+{
+    sun_hostid_instance_init(obj, offsetof(Sun4mMachineState,
+                                           hostid_props));
+}
 
 const char *fw_cfg_arch_key_name(uint16_t key)
 {
@@ -147,7 +162,8 @@ static void nvram_init(Nvram *nvram, uint8_t *macaddr,
                        const char *cmdline, const char *boot_devices,
                        ram_addr_t RAM_size, uint32_t kernel_size,
                        int width, int height, int depth,
-                       int nvram_machine_id, const char *arch)
+                       int machine_id, const uint8_t *hostid,
+                       const char *arch)
 {
     unsigned int i;
     int sysp_end;
@@ -163,7 +179,7 @@ static void nvram_init(Nvram *nvram, uint8_t *macaddr,
     chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);
 
     Sun_init_header((struct Sun_nvram *)&image[0x1fd8], macaddr,
-                    nvram_machine_id);
+                    machine_id, hostid);
 
     for (i = 0; i < sizeof(image); i++) {
         (k->write)(nvram, i, image[i]);
@@ -805,6 +821,7 @@ static void dummy_fdc_tc(void *opaque, int irq, int level)
 static void sun4m_hw_init(MachineState *machine)
 {
     const struct sun4m_hwdef *hwdef = SUN4M_MACHINE_GET_CLASS(machine)->hwdef;
+    Sun4mMachineState *sms = SUN4M_MACHINE(machine);
     DeviceState *slavio_intctl;
     unsigned int i;
     Nvram *nvram;
@@ -820,7 +837,9 @@ static void sun4m_hw_init(MachineState *machine)
     unsigned int smp_cpus = machine->smp.cpus;
     unsigned int max_cpus = machine->smp.max_cpus;
     HostMemoryBackend *ram_memdev = machine->memdev;
-    MACAddr hostid;
+    MACAddr MACid;
+    uint8_t nvram_machine_id = hwdef->nvram_machine_id;
+    uint8_t nvram_hostid[3];
 
     if (machine->ram_size > hwdef->max_mem) {
         error_report("Too much memory for this machine: %" PRId64 ","
@@ -881,7 +900,24 @@ static void sun4m_hw_init(MachineState *machine)
 
     sparc32_dma_init(hwdef->dma_base,
                      hwdef->esp_base, slavio_irq[18],
-                     hwdef->le_base, slavio_irq[16], &hostid);
+                     hwdef->le_base, slavio_irq[16], &MACid);
+
+    /*
+     * sparc32_dma_init() has already programmed the emulated lance
+     * NIC's MAC property from `MACid` above (either the user's
+     * -nic mac=, or an auto-generated one). Overriding hostid here,
+     * *after* that call, only changes what gets written into the
+     * NVRAM/IDPROM hostid field below - it deliberately does not
+     * change the NIC's actual MAC address.
+     */
+    if (sms->hostid_props.hostid_set) {
+        nvram_hostid[0] = (sms->hostid_props.hostid >> 16) & 0xff;
+        nvram_hostid[1] = (sms->hostid_props.hostid >> 8) & 0xff;
+        nvram_hostid[2] = sms->hostid_props.hostid & 0xff;
+    }
+    if (sms->hostid_props.machineid_set) {
+        nvram_machine_id = sms->hostid_props.machineid;
+    }
 
     if (!graphic_width) {
         graphic_width = 1024;
@@ -1042,10 +1078,11 @@ static void sun4m_hw_init(MachineState *machine)
                                     machine->initrd_filename,
                                     machine->ram_size, &initrd_size);
 
-    nvram_init(nvram, hostid.a, machine->kernel_cmdline,
+    nvram_init(nvram, MACid.a, machine->kernel_cmdline,
                machine->boot_config.order, machine->ram_size, kernel_size,
                graphic_width, graphic_height, graphic_depth,
-               hwdef->nvram_machine_id, "Sun4m");
+               nvram_machine_id,
+               sms->hostid_props.hostid_set ? nvram_hostid : NULL, "Sun4m");
 
     if (hwdef->ecc_base)
         ecc_init(hwdef->ecc_base, slavio_irq[28],
@@ -1109,6 +1146,8 @@ static void sun4m_machine_class_init(ObjectClass *oc, const void *data)
     mc->default_boot_order = "c";
     mc->default_display = "tcx";
     mc->default_ram_id = "sun4m.ram";
+
+    sun_hostid_class_init(oc, offsetof(Sun4mMachineState, hostid_props));
 }
 
 static void ss5_class_init(ObjectClass *oc, const void *data)
@@ -1471,6 +1510,8 @@ static const TypeInfo sun4m_machine_types[] = {
         .parent         = TYPE_MACHINE,
         .class_size     = sizeof(Sun4mMachineClass),
         .class_init     = sun4m_machine_class_init,
+        .instance_size  = sizeof(Sun4mMachineState),
+        .instance_init  = sun4m_machine_instance_init,
         .abstract       = true,
     }
 };
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index a348096aee..e677daaf97 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -144,7 +144,8 @@ static int sun4u_NVRAM_set_params(Nvram *nvram, uint16_t NVRAM_size,
     /* Free space partition */
     chrp_nvram_create_free_partition(&image[sysp_end], 0x1fd0 - sysp_end);
 
-    Sun_init_header((struct Sun_nvram *)&image[0x1fd8], macaddr, 0x80);
+    Sun_init_header((struct Sun_nvram *)&image[0x1fd8], macaddr,
+                    0x80, NULL);
 
     for (i = 0; i < sizeof(image); i++) {
         (k->write)(nvram, i, image[i]);
diff --git a/include/hw/nvram/sun_nvram.h b/include/hw/nvram/sun_nvram.h
index 68eaa60308..b07359cac4 100644
--- a/include/hw/nvram/sun_nvram.h
+++ b/include/hw/nvram/sun_nvram.h
@@ -2,7 +2,7 @@
 #define SUN_NVRAM_H
 
 /* Sun IDPROM structure at the end of NVRAM */
-/* from http://www.squirrel.com/squirrel/sun-nvram-hostid.faq.html */
+/* from https://www.sun3arc.org/FAQ/sun-nvram-hostid.faq.phtml */
 struct Sun_nvram {
     uint8_t type;       /* always 01 */
     uint8_t machine_id; /* first byte of host id (machine type) */
@@ -13,7 +13,8 @@ struct Sun_nvram {
 };
 
 static inline void
-Sun_init_header(struct Sun_nvram *header, const uint8_t *macaddr, int machine_id)
+Sun_init_header(struct Sun_nvram *header, const uint8_t *macaddr,
+                int machine_id, const uint8_t *hostid)
 {
     uint8_t tmp, *tmpptr;
     unsigned int i;
@@ -21,7 +22,11 @@ Sun_init_header(struct Sun_nvram *header, const uint8_t *macaddr, int machine_id
     header->type = 1;
     header->machine_id = machine_id & 0xff;
     memcpy(&header->macaddr, macaddr, 6);
-    memcpy(&header->hostid , &macaddr[3], 3);
+    if (hostid) {
+        memcpy(&header->hostid, hostid, sizeof(header->hostid));
+    } else {
+        memcpy(&header->hostid, &macaddr[3], sizeof(header->hostid));
+    }
 
     /* Calculate checksum */
     tmp = 0;

-- 
2.43.0


