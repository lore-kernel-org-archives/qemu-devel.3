Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EA5DC54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 12:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk1VR-00054E-Mb; Tue, 12 Mar 2024 08:45:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1VA-0004S8-EC
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rk1V3-0000Wh-Lq
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 08:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710247495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fVeQ/voPOLaHDifKQwHSPz/5PRJECd4+4KbN1orGcY0=;
 b=UPUIYInUbfngIOaMmOTRI3bplqmUkUUrLxWB01ehjG+/sChv1z+3nlyrn9sJxYZmY4jbEQ
 sTyeymrEI1b3B3+kur07WE16pWhziVsiS9eSw097fJJ8+0SqMqammm+A86tVTnBDpI4Su6
 opPWEs51mwVzl9okwEWKgotfvaTHWC8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-uAfL0bO8OqiZ0GRkWU1U3g-1; Tue,
 12 Mar 2024 08:44:50 -0400
X-MC-Unique: uAfL0bO8OqiZ0GRkWU1U3g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 213011C41A19;
 Tue, 12 Mar 2024 12:44:50 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.69])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 638C0492BC4;
 Tue, 12 Mar 2024 12:44:48 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Fabiano Rosas <farosas@suse.de>,
 Anthony PERARD <anthony.perard@citrix.com>
Subject: [PULL 34/55] bulk: Access existing variables initialized to &S->F
 when available
Date: Tue, 12 Mar 2024 13:43:18 +0100
Message-ID: <20240312124339.761630-35-thuth@redhat.com>
In-Reply-To: <20240312124339.761630-1-thuth@redhat.com>
References: <20240312124339.761630-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

When a variable is initialized to &struct->field, use it
in place. Rationale: while this makes the code more concise,
this also helps static analyzers.

Mechanical change using the following Coccinelle spatch script:

 @@
 type S, F;
 identifier s, m, v;
 @@
      S *s;
      ...
      F *v = &s->m;
      <+...
 -    &s->m
 +    v
      ...+>

Inspired-by: Zhao Liu <zhao1.liu@intel.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240129164514.73104-2-philmd@linaro.org>
Acked-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>
[thuth: Dropped hunks that need a rebase, and fixed sizeof() in pmu_realize()]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/display/ati.c              |  2 +-
 hw/misc/macio/pmu.c           |  3 +--
 hw/misc/pvpanic-pci.c         |  2 +-
 hw/pci-bridge/cxl_root_port.c |  2 +-
 hw/ppc/pnv.c                  | 20 ++++++++++----------
 hw/virtio/vhost-user-scmi.c   |  6 +++---
 hw/virtio/virtio-pci.c        |  2 +-
 hw/xen/xen_pt.c               |  6 +++---
 migration/multifd-zlib.c      |  2 +-
 target/arm/cpu.c              |  4 ++--
 target/arm/kvm.c              |  2 +-
 target/arm/machine.c          |  6 +++---
 target/i386/hvf/x86hvf.c      |  2 +-
 target/m68k/helper.c          |  2 +-
 target/ppc/kvm.c              |  8 ++++----
 15 files changed, 34 insertions(+), 35 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 569b8f6165..8d2501bd82 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -991,7 +991,7 @@ static void ati_vga_realize(PCIDevice *dev, Error **errp)
     }
     vga_init(vga, OBJECT(s), pci_address_space(dev),
              pci_address_space_io(dev), true);
-    vga->con = graphic_console_init(DEVICE(s), 0, s->vga.hw_ops, &s->vga);
+    vga->con = graphic_console_init(DEVICE(s), 0, s->vga.hw_ops, vga);
     if (s->cursor_guest_mode) {
         vga->cursor_invalidate = ati_cursor_invalidate;
         vga->cursor_draw_line = ati_cursor_draw_line;
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index e9a90da88f..e40c51bf52 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -737,8 +737,7 @@ static void pmu_realize(DeviceState *dev, Error **errp)
     timer_mod(s->one_sec_timer, s->one_sec_target);
 
     if (s->has_adb) {
-        qbus_init(&s->adb_bus, sizeof(s->adb_bus), TYPE_ADB_BUS,
-                  dev, "adb.0");
+        qbus_init(adb_bus, sizeof(*adb_bus), TYPE_ADB_BUS, dev, "adb.0");
         adb_register_autopoll_callback(adb_bus, pmu_adb_poll, s);
     }
 }
diff --git a/hw/misc/pvpanic-pci.c b/hw/misc/pvpanic-pci.c
index c01e4ce864..83be95d0d2 100644
--- a/hw/misc/pvpanic-pci.c
+++ b/hw/misc/pvpanic-pci.c
@@ -48,7 +48,7 @@ static void pvpanic_pci_realizefn(PCIDevice *dev, Error **errp)
     PVPanicPCIState *s = PVPANIC_PCI_DEVICE(dev);
     PVPanicState *ps = &s->pvpanic;
 
-    pvpanic_setup_io(&s->pvpanic, DEVICE(s), 2);
+    pvpanic_setup_io(ps, DEVICE(s), 2);
 
     pci_register_bar(dev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &ps->mr);
 }
diff --git a/hw/pci-bridge/cxl_root_port.c b/hw/pci-bridge/cxl_root_port.c
index 62f96994eb..8a30da602c 100644
--- a/hw/pci-bridge/cxl_root_port.c
+++ b/hw/pci-bridge/cxl_root_port.c
@@ -175,7 +175,7 @@ static void cxl_rp_realize(DeviceState *dev, Error **errp)
 
     cxl_cstate->dvsec_offset = CXL_ROOT_PORT_DVSEC_OFFSET;
     cxl_cstate->pdev = pci_dev;
-    build_dvsecs(&crp->cxl_cstate);
+    build_dvsecs(cxl_cstate);
 
     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
                                       TYPE_CXL_ROOT_PORT);
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 0b47b92baa..93d550988f 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -1265,11 +1265,11 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     }
 
     /* Processor Service Interface (PSI) Host Bridge */
-    object_property_set_int(OBJECT(&chip8->psi), "bar", PNV_PSIHB_BASE(chip),
+    object_property_set_int(OBJECT(psi8), "bar", PNV_PSIHB_BASE(chip),
                             &error_fatal);
-    object_property_set_link(OBJECT(&chip8->psi), ICS_PROP_XICS,
+    object_property_set_link(OBJECT(psi8), ICS_PROP_XICS,
                              OBJECT(chip8->xics), &error_abort);
-    if (!qdev_realize(DEVICE(&chip8->psi), NULL, errp)) {
+    if (!qdev_realize(DEVICE(psi8), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE,
@@ -1300,7 +1300,7 @@ static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
     }
     pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_regs);
     qdev_connect_gpio_out(DEVICE(&chip8->occ), 0,
-                          qdev_get_gpio_in(DEVICE(&chip8->psi), PSIHB_IRQ_OCC));
+                          qdev_get_gpio_in(DEVICE(psi8), PSIHB_IRQ_OCC));
 
     /* OCC SRAM model */
     memory_region_add_subregion(get_system_memory(), PNV_OCC_SENSOR_BASE(chip),
@@ -1553,12 +1553,12 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                             &chip9->xive.xscom_regs);
 
     /* Processor Service Interface (PSI) Host Bridge */
-    object_property_set_int(OBJECT(&chip9->psi), "bar", PNV9_PSIHB_BASE(chip),
+    object_property_set_int(OBJECT(psi9), "bar", PNV9_PSIHB_BASE(chip),
                             &error_fatal);
     /* This is the only device with 4k ESB pages */
-    object_property_set_int(OBJECT(&chip9->psi), "shift", XIVE_ESB_4K,
+    object_property_set_int(OBJECT(psi9), "shift", XIVE_ESB_4K,
                             &error_fatal);
-    if (!qdev_realize(DEVICE(&chip9->psi), NULL, errp)) {
+    if (!qdev_realize(DEVICE(psi9), NULL, errp)) {
         return;
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_PSIHB_BASE,
@@ -1594,7 +1594,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom_regs);
     qdev_connect_gpio_out(DEVICE(&chip9->occ), 0, qdev_get_gpio_in(
-                              DEVICE(&chip9->psi), PSIHB9_IRQ_OCC));
+                              DEVICE(psi9), PSIHB9_IRQ_OCC));
 
     /* OCC SRAM model */
     memory_region_add_subregion(get_system_memory(), PNV9_OCC_SENSOR_BASE(chip),
@@ -1609,7 +1609,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_SBE_MBOX_BASE,
                             &chip9->sbe.xscom_mbox_regs);
     qdev_connect_gpio_out(DEVICE(&chip9->sbe), 0, qdev_get_gpio_in(
-                              DEVICE(&chip9->psi), PSIHB9_IRQ_PSU));
+                              DEVICE(psi9), PSIHB9_IRQ_PSU));
 
     /* HOMER */
     object_property_set_link(OBJECT(&chip9->homer), "chip", OBJECT(chip),
@@ -1650,7 +1650,7 @@ static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
                                         PNV9_XSCOM_I2CM_SIZE,
                                 &chip9->i2c[i].xscom_regs);
         qdev_connect_gpio_out(DEVICE(&chip9->i2c[i]), 0,
-                              qdev_get_gpio_in(DEVICE(&chip9->psi),
+                              qdev_get_gpio_in(DEVICE(psi9),
                                                PSIHB9_IRQ_SBE_I2C));
     }
 }
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 918bb7dcf7..300847e672 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -56,9 +56,9 @@ static int vu_scmi_start(VirtIODevice *vdev)
         goto err_host_notifiers;
     }
 
-    vhost_ack_features(&scmi->vhost_dev, feature_bits, vdev->guest_features);
+    vhost_ack_features(vhost_dev, feature_bits, vdev->guest_features);
 
-    ret = vhost_dev_start(&scmi->vhost_dev, vdev, true);
+    ret = vhost_dev_start(vhost_dev, vdev, true);
     if (ret < 0) {
         error_report("Error starting vhost-user-scmi: %d", ret);
         goto err_guest_notifiers;
@@ -71,7 +71,7 @@ static int vu_scmi_start(VirtIODevice *vdev)
      * enabling/disabling irqfd.
      */
     for (i = 0; i < scmi->vhost_dev.nvqs; i++) {
-        vhost_virtqueue_mask(&scmi->vhost_dev, vdev, i, false);
+        vhost_virtqueue_mask(vhost_dev, vdev, i, false);
     }
     return 0;
 
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 1a7039fb0c..cb6940fc0e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1929,7 +1929,7 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
     bool modern_pio = proxy->flags & VIRTIO_PCI_FLAG_MODERN_PIO_NOTIFY;
     uint8_t *config;
     uint32_t size;
-    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+    VirtIODevice *vdev = virtio_bus_get_device(bus);
 
     /*
      * Virtio capabilities present without
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index a8edabdabc..3635d1b39f 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -711,7 +711,7 @@ static void xen_pt_destroy(PCIDevice *d) {
     uint8_t intx;
     int rc;
 
-    if (machine_irq && !xen_host_pci_device_closed(&s->real_device)) {
+    if (machine_irq && !xen_host_pci_device_closed(host_dev)) {
         intx = xen_pt_pci_intx(s);
         rc = xc_domain_unbind_pt_irq(xen_xc, xen_domid, machine_irq,
                                      PT_IRQ_TYPE_PCI,
@@ -760,8 +760,8 @@ static void xen_pt_destroy(PCIDevice *d) {
         memory_listener_unregister(&s->io_listener);
         s->listener_set = false;
     }
-    if (!xen_host_pci_device_closed(&s->real_device)) {
-        xen_host_pci_device_put(&s->real_device);
+    if (!xen_host_pci_device_closed(host_dev)) {
+        xen_host_pci_device_put(host_dev);
     }
 }
 /* init */
diff --git a/migration/multifd-zlib.c b/migration/multifd-zlib.c
index 6120faad65..9a3a7adb54 100644
--- a/migration/multifd-zlib.c
+++ b/migration/multifd-zlib.c
@@ -75,7 +75,7 @@ static int zlib_send_setup(MultiFDSendParams *p, Error **errp)
 err_free_zbuff:
     g_free(z->zbuff);
 err_deflate_end:
-    deflateEnd(&z->zs);
+    deflateEnd(zs);
 err_free_z:
     g_free(z);
     error_setg(errp, "multifd %u: %s", p->id, err_msg);
diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f3ed79cef2..02fc0adb65 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -2095,7 +2095,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
      * We rely on no XScale CPU having VFP so we can use the same bits in the
      * TB flags field for VECSTRIDE and XSCALE_CPAR.
      */
-    assert(arm_feature(&cpu->env, ARM_FEATURE_AARCH64) ||
+    assert(arm_feature(env, ARM_FEATURE_AARCH64) ||
            !cpu_isar_feature(aa32_vfp_simd, cpu) ||
            !arm_feature(env, ARM_FEATURE_XSCALE));
 
@@ -2145,7 +2145,7 @@ static void arm_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     if (cpu->cfgend) {
-        if (arm_feature(&cpu->env, ARM_FEATURE_V7)) {
+        if (arm_feature(env, ARM_FEATURE_V7)) {
             cpu->reset_sctlr |= SCTLR_EE;
         } else {
             cpu->reset_sctlr |= SCTLR_B;
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 81813030a5..ab85d628a8 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -1888,7 +1888,7 @@ int kvm_arch_init_vcpu(CPUState *cs)
         cpu->psci_version = QEMU_PSCI_VERSION_0_2;
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_PSCI_0_2;
     }
-    if (!arm_feature(&cpu->env, ARM_FEATURE_AARCH64)) {
+    if (!arm_feature(env, ARM_FEATURE_AARCH64)) {
         cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_EL1_32BIT;
     }
     if (!kvm_check_extension(cs->kvm_state, KVM_CAP_ARM_PMU_V3)) {
diff --git a/target/arm/machine.c b/target/arm/machine.c
index 9d7dbaea54..b2b39b2475 100644
--- a/target/arm/machine.c
+++ b/target/arm/machine.c
@@ -773,7 +773,7 @@ static int cpu_pre_load(void *opaque)
     env->irq_line_state = UINT32_MAX;
 
     if (!kvm_enabled()) {
-        pmu_op_start(&cpu->env);
+        pmu_op_start(env);
     }
 
     return 0;
@@ -871,11 +871,11 @@ static int cpu_post_load(void *opaque, int version_id)
     }
 
     if (!kvm_enabled()) {
-        pmu_op_finish(&cpu->env);
+        pmu_op_finish(env);
     }
 
     if (tcg_enabled()) {
-        arm_rebuild_hflags(&cpu->env);
+        arm_rebuild_hflags(env);
     }
 
     return 0;
diff --git a/target/i386/hvf/x86hvf.c b/target/i386/hvf/x86hvf.c
index 3b1ef5f49a..be2c46246e 100644
--- a/target/i386/hvf/x86hvf.c
+++ b/target/i386/hvf/x86hvf.c
@@ -408,7 +408,7 @@ bool hvf_inject_interrupts(CPUState *cs)
     if (!(env->hflags & HF_INHIBIT_IRQ_MASK) &&
         (cs->interrupt_request & CPU_INTERRUPT_HARD) &&
         (env->eflags & IF_MASK) && !(info & VMCS_INTR_VALID)) {
-        int line = cpu_get_pic_interrupt(&x86cpu->env);
+        int line = cpu_get_pic_interrupt(env);
         cs->interrupt_request &= ~CPU_INTERRUPT_HARD;
         if (line >= 0) {
             wvmcs(cs->accel->fd, VMCS_ENTRY_INTR_INFO, line |
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 1c33995e5d..44b245884e 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -984,7 +984,7 @@ bool m68k_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
         access_type |= ACCESS_SUPER;
     }
 
-    ret = get_physical_address(&cpu->env, &physical, &prot,
+    ret = get_physical_address(env, &physical, &prot,
                                address, access_type, &page_size);
     if (likely(ret == 0)) {
         tlb_set_page(cs, address & TARGET_PAGE_MASK,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index bcf30a5400..9f5a890655 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -635,8 +635,8 @@ static int kvm_put_fp(CPUState *cs)
 
         for (i = 0; i < 32; i++) {
             uint64_t vsr[2];
-            uint64_t *fpr = cpu_fpr_ptr(&cpu->env, i);
-            uint64_t *vsrl = cpu_vsrl_ptr(&cpu->env, i);
+            uint64_t *fpr = cpu_fpr_ptr(env, i);
+            uint64_t *vsrl = cpu_vsrl_ptr(env, i);
 
 #if HOST_BIG_ENDIAN
             vsr[0] = float64_val(*fpr);
@@ -704,8 +704,8 @@ static int kvm_get_fp(CPUState *cs)
 
         for (i = 0; i < 32; i++) {
             uint64_t vsr[2];
-            uint64_t *fpr = cpu_fpr_ptr(&cpu->env, i);
-            uint64_t *vsrl = cpu_vsrl_ptr(&cpu->env, i);
+            uint64_t *fpr = cpu_fpr_ptr(env, i);
+            uint64_t *vsrl = cpu_vsrl_ptr(env, i);
 
             reg.addr = (uintptr_t) &vsr;
             reg.id = vsx ? KVM_REG_PPC_VSR(i) : KVM_REG_PPC_FPR(i);
-- 
2.44.0


