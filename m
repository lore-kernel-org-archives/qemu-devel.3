Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F8BFDEE47
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 19:24:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFzcb-00048P-VH; Thu, 23 Apr 2026 15:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcN-0003P8-Sy
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:45 -0400
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1wFzcJ-00027L-BG
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 15:21:43 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F6F16A8AA;
 Thu, 23 Apr 2026 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueTjPgmSW7EvLie0P/K66Rj7p5HsTRZ1DFjF4HaBNKE=;
 b=xb6yACTeFWMGD5IrtZ0Qqe2l3Y/BoZCfJzwXIRRvWtuQdkcyrnFsqxEGL38J5OZuLODZIL
 1s4ZIg2LaJfWwGLGEVP2BFaM1x8Yc+W7I+h2foBbFdvT98NBymX6u34DrfxRYPBPrcge2A
 f2b7tUP0xkJPV/Dn4jUaWjlA5fuorc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueTjPgmSW7EvLie0P/K66Rj7p5HsTRZ1DFjF4HaBNKE=;
 b=9Gw/GePneQPoIEMQTpcAh2pYt7gnW/JZ+YzMUllr6l0xEDLP+EOlII6kelY4BdS47eE4CP
 6xYDLFvWDkG1DFAA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=xb6yACTe;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="9Gw/GePn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776972029; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueTjPgmSW7EvLie0P/K66Rj7p5HsTRZ1DFjF4HaBNKE=;
 b=xb6yACTeFWMGD5IrtZ0Qqe2l3Y/BoZCfJzwXIRRvWtuQdkcyrnFsqxEGL38J5OZuLODZIL
 1s4ZIg2LaJfWwGLGEVP2BFaM1x8Yc+W7I+h2foBbFdvT98NBymX6u34DrfxRYPBPrcge2A
 f2b7tUP0xkJPV/Dn4jUaWjlA5fuorc4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776972029;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ueTjPgmSW7EvLie0P/K66Rj7p5HsTRZ1DFjF4HaBNKE=;
 b=9Gw/GePneQPoIEMQTpcAh2pYt7gnW/JZ+YzMUllr6l0xEDLP+EOlII6kelY4BdS47eE4CP
 6xYDLFvWDkG1DFAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DBEE1593A3;
 Thu, 23 Apr 2026 19:20:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AIa+Kftw6mlJCwAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 23 Apr 2026 19:20:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Eric Farman <farman@linux.ibm.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PULL 19/43] migration: drop VMStateField.err_hint
Date: Thu, 23 Apr 2026 16:19:33 -0300
Message-ID: <20260423191958.1440-20-farosas@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260423191958.1440-1-farosas@suse.de>
References: <20260423191958.1440-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: 4F6F16A8AA
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

The field is unused, all users of VMSTATE_*_EQUAL pass _err_hint=NULL.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Acked-by: Eric Farman <farman@linux.ibm.com>  # s390
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Reviewed-by: Peter Xu <peterx@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260304212303.667141-18-vsementsov@yandex-team.ru
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 hw/block/fdc.c              |  2 +-
 hw/display/qxl.c            |  4 ++--
 hw/display/vga.c            |  2 +-
 hw/display/virtio-gpu.c     |  2 +-
 hw/display/vmware_vga.c     |  2 +-
 hw/i386/vmmouse.c           |  2 +-
 hw/ide/ahci.c               |  2 +-
 hw/intc/openpic.c           |  2 +-
 hw/intc/spapr_xive.c        |  2 +-
 hw/intc/xics.c              |  2 +-
 hw/intc/xive.c              |  2 +-
 hw/nvram/eeprom93xx.c       |  2 +-
 hw/pci/pci.c                |  2 +-
 hw/pci/pcie_aer.c           |  2 +-
 hw/ppc/spapr_iommu.c        |  2 +-
 hw/ppc/spapr_pci.c          |  4 ++--
 hw/ppc/spapr_vio.c          |  4 ++--
 hw/s390x/css.c              |  6 +++---
 hw/usb/hcd-uhci.c           |  2 +-
 include/migration/vmstate.h | 36 +++++++++++++++++-------------------
 migration/vmstate-types.c   | 15 ---------------
 target/ppc/machine.c        |  6 +++---
 22 files changed, 44 insertions(+), 61 deletions(-)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 4585640af9..2c1681b7d0 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -1051,7 +1051,7 @@ const VMStateDescription vmstate_fdc = {
         VMSTATE_UINT8(config, FDCtrl),
         VMSTATE_UINT8(lock, FDCtrl),
         VMSTATE_UINT8(pwrd, FDCtrl),
-        VMSTATE_UINT8_EQUAL(num_floppies, FDCtrl, NULL),
+        VMSTATE_UINT8_EQUAL(num_floppies, FDCtrl),
         VMSTATE_STRUCT_ARRAY(drives, FDCtrl, MAX_FD, 1,
                              vmstate_fdrive, FDrive),
         VMSTATE_END_OF_LIST()
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 3d4b563556..f8fd7ee069 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2442,12 +2442,12 @@ static const VMStateDescription qxl_vmstate = {
         VMSTATE_UINT32(last_release_offset, PCIQXLDevice),
         VMSTATE_UINT32(mode, PCIQXLDevice),
         VMSTATE_UINT32(ssd.unique, PCIQXLDevice),
-        VMSTATE_INT32_EQUAL(num_memslots, PCIQXLDevice, NULL),
+        VMSTATE_INT32_EQUAL(num_memslots, PCIQXLDevice),
         VMSTATE_STRUCT_ARRAY(guest_slots, PCIQXLDevice, NUM_MEMSLOTS, 0,
                              qxl_memslot, struct guest_slots),
         VMSTATE_STRUCT(guest_primary.surface, PCIQXLDevice, 0,
                        qxl_surface, QXLSurfaceCreate),
-        VMSTATE_INT32_EQUAL(ssd.num_surfaces, PCIQXLDevice, NULL),
+        VMSTATE_INT32_EQUAL(ssd.num_surfaces, PCIQXLDevice),
         VMSTATE_VARRAY_INT32(guest_surfaces.cmds, PCIQXLDevice,
                              ssd.num_surfaces, 0,
                              vmstate_info_uint64, uint64_t),
diff --git a/hw/display/vga.c b/hw/display/vga.c
index ee7d97b5c2..0d69a53f27 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -2160,7 +2160,7 @@ const VMStateDescription vmstate_vga_common = {
         VMSTATE_BUFFER(palette, VGACommonState),
 
         VMSTATE_INT32(bank_offset, VGACommonState),
-        VMSTATE_UINT8_EQUAL(is_vbe_vmstate, VGACommonState, NULL),
+        VMSTATE_UINT8_EQUAL(is_vbe_vmstate, VGACommonState),
         VMSTATE_UINT16(vbe_index, VGACommonState),
         VMSTATE_UINT16_ARRAY(vbe_regs, VGACommonState, VBE_DISPI_INDEX_NB),
         VMSTATE_UINT32(vbe_start_addr, VGACommonState),
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index b998ce8324..dbb72bbb22 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -1223,7 +1223,7 @@ static const VMStateDescription vmstate_virtio_gpu_scanouts = {
     .fields = (const VMStateField[]) {
         VMSTATE_INT32(parent_obj.enable, struct VirtIOGPU),
         VMSTATE_UINT32_EQUAL(parent_obj.conf.max_outputs,
-                             struct VirtIOGPU, NULL),
+                             struct VirtIOGPU),
         VMSTATE_STRUCT_VARRAY_UINT32(parent_obj.scanout, struct VirtIOGPU,
                                      parent_obj.conf.max_outputs, 1,
                                      vmstate_virtio_gpu_scanout,
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index c2c6bc76e9..2b95787ddf 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1209,7 +1209,7 @@ static const VMStateDescription vmstate_vmware_vga_internal = {
     .minimum_version_id = 0,
     .post_load = vmsvga_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32_EQUAL(new_depth, struct vmsvga_state_s, NULL),
+        VMSTATE_INT32_EQUAL(new_depth, struct vmsvga_state_s),
         VMSTATE_INT32(enable, struct vmsvga_state_s),
         VMSTATE_INT32(config, struct vmsvga_state_s),
         VMSTATE_INT32(cursor.id, struct vmsvga_state_s),
diff --git a/hw/i386/vmmouse.c b/hw/i386/vmmouse.c
index c1aeeca0c9..417c3aecb9 100644
--- a/hw/i386/vmmouse.c
+++ b/hw/i386/vmmouse.c
@@ -278,7 +278,7 @@ static const VMStateDescription vmstate_vmmouse = {
     .minimum_version_id = 0,
     .post_load = vmmouse_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32_EQUAL(queue_size, VMMouseState, NULL),
+        VMSTATE_INT32_EQUAL(queue_size, VMMouseState),
         VMSTATE_UINT32_ARRAY(queue, VMMouseState, VMMOUSE_QUEUE_SIZE),
         VMSTATE_UINT16(nb_queue, VMMouseState),
         VMSTATE_UINT16(status, VMMouseState),
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 08f51c8e36..c2b4432b94 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1795,7 +1795,7 @@ const VMStateDescription vmstate_ahci = {
         VMSTATE_UINT32(control_regs.impl, AHCIState),
         VMSTATE_UINT32(control_regs.version, AHCIState),
         VMSTATE_UINT32(idp_index, AHCIState),
-        VMSTATE_UINT32_EQUAL(ports, AHCIState, NULL),
+        VMSTATE_UINT32_EQUAL(ports, AHCIState),
         VMSTATE_END_OF_LIST()
     },
 };
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index cd353a04f5..99d2a1e65e 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1477,7 +1477,7 @@ static const VMStateDescription vmstate_openpic = {
         VMSTATE_UINT32(max_irq, OpenPICState),
         VMSTATE_STRUCT_VARRAY_UINT32(src, OpenPICState, max_irq, 0,
                                      vmstate_openpic_irqsource, IRQSource),
-        VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState, NULL),
+        VMSTATE_UINT32_EQUAL(nb_cpus, OpenPICState),
         VMSTATE_STRUCT_VARRAY_UINT32(dst, OpenPICState, nb_cpus, 0,
                                      vmstate_openpic_irqdest, IRQDest),
         VMSTATE_STRUCT_ARRAY(timers, OpenPICState, OPENPIC_MAX_TMR, 0,
diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
index 76ab476f59..c30dace4e2 100644
--- a/hw/intc/spapr_xive.c
+++ b/hw/intc/spapr_xive.c
@@ -578,7 +578,7 @@ static const VMStateDescription vmstate_spapr_xive = {
     .pre_save = vmstate_spapr_xive_pre_save,
     .post_load = NULL, /* handled at the machine level */
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(nr_irqs, SpaprXive, NULL),
+        VMSTATE_UINT32_EQUAL(nr_irqs, SpaprXive),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(eat, SpaprXive, nr_irqs,
                                      vmstate_spapr_xive_eas, XiveEAS),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(endt, SpaprXive, nr_ends,
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 1d40c4386d..c0a252d051 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -668,7 +668,7 @@ static const VMStateDescription vmstate_ics = {
     .post_load = ics_post_load,
     .fields = (const VMStateField[]) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
+        VMSTATE_UINT32_EQUAL(nr_irqs, ICSState),
 
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
                                              vmstate_ics_irq,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index d702b58bd0..f473e6ac77 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -1565,7 +1565,7 @@ static const VMStateDescription vmstate_xive_source = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource, NULL),
+        VMSTATE_UINT32_EQUAL(nr_irqs, XiveSource),
         VMSTATE_VBUFFER_UINT32(status, XiveSource, 1, NULL, nr_irqs),
         VMSTATE_END_OF_LIST()
     },
diff --git a/hw/nvram/eeprom93xx.c b/hw/nvram/eeprom93xx.c
index a8fd60a8fb..73b3d248d4 100644
--- a/hw/nvram/eeprom93xx.c
+++ b/hw/nvram/eeprom93xx.c
@@ -144,7 +144,7 @@ static const VMStateDescription vmstate_eeprom = {
         VMSTATE_UINT8(addrbits, eeprom_t),
         VMSTATE_UINT16_HACK_TEST(size, eeprom_t, is_old_eeprom_version),
         VMSTATE_UNUSED_TEST(is_old_eeprom_version, 1),
-        VMSTATE_UINT16_EQUAL_V(size, eeprom_t, EEPROM_VERSION, NULL),
+        VMSTATE_UINT16_EQUAL_V(size, eeprom_t, EEPROM_VERSION),
         VMSTATE_UINT16(data, eeprom_t),
         VMSTATE_VARRAY_UINT16_UNSAFE(contents, eeprom_t, size, 0,
                                      vmstate_info_uint16, uint16_t),
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 2c3657d00d..a0dbb81fd9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -105,7 +105,7 @@ static const VMStateDescription vmstate_pcibus = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32_EQUAL(nirq, PCIBus, NULL),
+        VMSTATE_INT32_EQUAL(nirq, PCIBus),
         VMSTATE_VARRAY_INT32(irq_count, PCIBus,
                              nirq, 0, vmstate_info_int32,
                              int32_t),
diff --git a/hw/pci/pcie_aer.c b/hw/pci/pcie_aer.c
index 2c85a78fcd..22497b1fd6 100644
--- a/hw/pci/pcie_aer.c
+++ b/hw/pci/pcie_aer.c
@@ -820,7 +820,7 @@ const VMStateDescription vmstate_pcie_aer_log = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT16(log_num, PCIEAERLog),
-        VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog, NULL),
+        VMSTATE_UINT16_EQUAL(log_max, PCIEAERLog),
         VMSTATE_VALIDATE("log_num <= log_max", pcie_aer_state_log_num_valid),
         VMSTATE_STRUCT_VARRAY_POINTER_UINT16(log, PCIEAERLog, log_num,
                               vmstate_pcie_aer_err, PCIEAERErr),
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index c2432a0c00..e6264b0785 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -285,7 +285,7 @@ static const VMStateDescription vmstate_spapr_tce_table = {
     .post_load = spapr_tce_table_post_load,
     .fields = (const VMStateField []) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(liobn, SpaprTceTable, NULL),
+        VMSTATE_UINT32_EQUAL(liobn, SpaprTceTable),
 
         /* IOMMU state */
         VMSTATE_UINT32(mig_nb_table, SpaprTceTable),
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 1dc3b02659..c1d4b7806e 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -2051,7 +2051,7 @@ static const VMStateDescription vmstate_spapr_pci_lsi = {
     .version_id = 1,
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT32_EQUAL(irq, SpaprPciLsi, NULL),
+        VMSTATE_UINT32_EQUAL(irq, SpaprPciLsi),
 
         VMSTATE_END_OF_LIST()
     },
@@ -2129,7 +2129,7 @@ static const VMStateDescription vmstate_spapr_pci = {
     .post_save = spapr_pci_post_save,
     .post_load = spapr_pci_post_load,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT64_EQUAL(buid, SpaprPhbState, NULL),
+        VMSTATE_UINT64_EQUAL(buid, SpaprPhbState),
         VMSTATE_STRUCT_ARRAY(lsi_table, SpaprPhbState, PCI_NUM_PINS, 0,
                              vmstate_spapr_pci_lsi, SpaprPciLsi),
         VMSTATE_INT32(msi_devs_num, SpaprPhbState),
diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 501e82a766..3f05081bad 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -609,8 +609,8 @@ const VMStateDescription vmstate_spapr_vio = {
     .minimum_version_id = 1,
     .fields = (const VMStateField[]) {
         /* Sanity check */
-        VMSTATE_UINT32_EQUAL(reg, SpaprVioDevice, NULL),
-        VMSTATE_UINT32_EQUAL(irq, SpaprVioDevice, NULL),
+        VMSTATE_UINT32_EQUAL(reg, SpaprVioDevice),
+        VMSTATE_UINT32_EQUAL(irq, SpaprVioDevice),
 
         /* General VIO device state */
         VMSTATE_UINT64(signal_state, SpaprVioDevice),
diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index df5f0bc27f..ecd28fed5c 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -199,15 +199,15 @@ const VMStateDescription vmstate_subch_dev = {
     .post_load = subch_dev_post_load,
     .pre_save = subch_dev_pre_save,
     .fields = (const VMStateField[]) {
-        VMSTATE_UINT8_EQUAL(cssid, SubchDev, NULL),
-        VMSTATE_UINT8_EQUAL(ssid, SubchDev, NULL),
+        VMSTATE_UINT8_EQUAL(cssid, SubchDev),
+        VMSTATE_UINT8_EQUAL(ssid, SubchDev),
         VMSTATE_UINT16(migrated_schid, SubchDev),
         /*
          * If devno mismatch on target, it may be due to some
          * sequences of plug and unplug breaks migration for
          * machine versions prior to 2.7 (known design flaw).
          */
-        VMSTATE_UINT16_EQUAL(devno, SubchDev, NULL),
+        VMSTATE_UINT16_EQUAL(devno, SubchDev),
         VMSTATE_BOOL(thinint_active, SubchDev),
         VMSTATE_STRUCT(curr_status, SubchDev, 0, vmstate_schib, SCHIB),
         VMSTATE_UINT8_ARRAY(sense_data, SubchDev, 32),
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index b2224c7f76..a7b9fe1317 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -364,7 +364,7 @@ static const VMStateDescription vmstate_uhci = {
     .post_load = uhci_post_load,
     .fields = (const VMStateField[]) {
         VMSTATE_PCI_DEVICE(dev, UHCIState),
-        VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState, NULL),
+        VMSTATE_UINT8_EQUAL(num_ports_vmstate, UHCIState),
         VMSTATE_STRUCT_ARRAY(ports, UHCIState, UHCI_PORTS, 1,
                              vmstate_uhci_port, UHCIPort),
         VMSTATE_UINT16(cmd, UHCIState),
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 66c2e87bd3..d4a39aa794 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -182,7 +182,6 @@ typedef enum {
 
 struct VMStateField {
     const char *name;
-    const char *err_hint;
     size_t offset;
     size_t size;
     size_t start;
@@ -358,9 +357,8 @@ extern const VMStateInfo vmstate_info_qlist;
 }
 
 #define VMSTATE_SINGLE_FULL(_field, _state, _test, _version, _info,  \
-                            _type, _err_hint) {                      \
+                            _type) {                      \
     .name         = (stringify(_field)),                             \
-    .err_hint     = (_err_hint),                                     \
     .version_id   = (_version),                                      \
     .field_exists = (_test),                                         \
     .size         = sizeof(_type),                                   \
@@ -1022,35 +1020,35 @@ extern const VMStateInfo vmstate_info_qlist;
 
 #endif
 
-#define VMSTATE_UINT8_EQUAL(_f, _s, _err_hint)                        \
+#define VMSTATE_UINT8_EQUAL(_f, _s)                                   \
     VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
-                        vmstate_info_uint8_equal, uint8_t, _err_hint)
+                        vmstate_info_uint8_equal, uint8_t)
 
-#define VMSTATE_UINT16_EQUAL(_f, _s, _err_hint)                       \
+#define VMSTATE_UINT16_EQUAL(_f, _s)                                  \
     VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
-                        vmstate_info_uint16_equal, uint16_t, _err_hint)
+                        vmstate_info_uint16_equal, uint16_t)
 
-#define VMSTATE_UINT16_EQUAL_V(_f, _s, _v, _err_hint)                 \
+#define VMSTATE_UINT16_EQUAL_V(_f, _s, _v)                            \
     VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
-                        vmstate_info_uint16_equal, uint16_t, _err_hint)
+                        vmstate_info_uint16_equal, uint16_t)
 
-#define VMSTATE_INT32_EQUAL(_f, _s, _err_hint)                        \
+#define VMSTATE_INT32_EQUAL(_f, _s)                                   \
     VMSTATE_SINGLE_FULL(_f, _s, 0, 0,                                 \
-                        vmstate_info_int32_equal, int32_t, _err_hint)
+                        vmstate_info_int32_equal, int32_t)
 
-#define VMSTATE_UINT32_EQUAL_V(_f, _s, _v, _err_hint)                 \
+#define VMSTATE_UINT32_EQUAL_V(_f, _s, _v)                            \
     VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
-                        vmstate_info_uint32_equal, uint32_t, _err_hint)
+                        vmstate_info_uint32_equal, uint32_t)
 
-#define VMSTATE_UINT32_EQUAL(_f, _s, _err_hint)                       \
-    VMSTATE_UINT32_EQUAL_V(_f, _s, 0, _err_hint)
+#define VMSTATE_UINT32_EQUAL(_f, _s)                                  \
+    VMSTATE_UINT32_EQUAL_V(_f, _s, 0)
 
-#define VMSTATE_UINT64_EQUAL_V(_f, _s, _v, _err_hint)                 \
+#define VMSTATE_UINT64_EQUAL_V(_f, _s, _v)                            \
     VMSTATE_SINGLE_FULL(_f, _s, 0,  _v,                               \
-                        vmstate_info_uint64_equal, uint64_t, _err_hint)
+                        vmstate_info_uint64_equal, uint64_t)
 
-#define VMSTATE_UINT64_EQUAL(_f, _s, _err_hint)                       \
-    VMSTATE_UINT64_EQUAL_V(_f, _s, 0, _err_hint)
+#define VMSTATE_UINT64_EQUAL(_f, _s)                                  \
+    VMSTATE_UINT64_EQUAL_V(_f, _s, 0)
 
 #define VMSTATE_INT32_POSITIVE_LE(_f, _s)                             \
     VMSTATE_SINGLE(_f, _s, 0, vmstate_info_int32_le, int32_t)
diff --git a/migration/vmstate-types.c b/migration/vmstate-types.c
index 89cb211472..033a2685c8 100644
--- a/migration/vmstate-types.c
+++ b/migration/vmstate-types.c
@@ -131,9 +131,6 @@ static int get_int32_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%" PRIx32 " != %" PRIx32, *v, v2);
-    if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
-    }
     return -EINVAL;
 }
 
@@ -280,9 +277,6 @@ static int get_uint32_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%" PRIx32 " != %" PRIx32, *v, v2);
-    if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
-    }
     return -EINVAL;
 }
 
@@ -391,9 +385,6 @@ static int get_uint64_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%" PRIx64 " != %" PRIx64, *v, v2);
-    if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
-    }
     return -EINVAL;
 }
 
@@ -417,9 +408,6 @@ static int get_uint8_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%x != %x", *v, v2);
-    if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
-    }
     return -EINVAL;
 }
 
@@ -443,9 +431,6 @@ static int get_uint16_equal(QEMUFile *f, void *pv, size_t size,
         return 0;
     }
     error_report("%x != %x", *v, v2);
-    if (field->err_hint) {
-        error_printf("%s\n", field->err_hint);
-    }
     return -EINVAL;
 }
 
diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index 49cfdc6d67..9eae0ff647 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -564,7 +564,7 @@ static const VMStateDescription vmstate_tlb6xx = {
     .minimum_version_id = 1,
     .needed = tlb6xx_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
+        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlb6, PowerPCCPU,
                                             env.nb_tlb,
                                             vmstate_tlb6xx_entry,
@@ -603,7 +603,7 @@ static const VMStateDescription vmstate_tlbemb = {
     .minimum_version_id = 1,
     .needed = tlbemb_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
+        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbe, PowerPCCPU,
                                             env.nb_tlb,
                                             vmstate_tlbemb_entry,
@@ -639,7 +639,7 @@ static const VMStateDescription vmstate_tlbmas = {
     .minimum_version_id = 1,
     .needed = tlbmas_needed,
     .fields = (const VMStateField[]) {
-        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU, NULL),
+        VMSTATE_INT32_EQUAL(env.nb_tlb, PowerPCCPU),
         VMSTATE_STRUCT_VARRAY_POINTER_INT32(env.tlb.tlbm, PowerPCCPU,
                                             env.nb_tlb,
                                             vmstate_tlbmas_entry,
-- 
2.51.0


