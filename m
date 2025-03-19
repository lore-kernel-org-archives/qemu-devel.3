Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 298C9C35FFC
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvFQ-0001Ax-Lo; Wed, 19 Mar 2025 11:22:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvEr-00011X-4f
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvEj-0001OK-MB
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742397698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SGu2ytFgg3fuowhy4PeseUC0DJrGePKjMbacA7Q0MQ0=;
 b=iECIq0UQsingPSR+6FS4cPuqSNoh5zCKZ8ojlckcygTKBVWAzLruBpDec5URDehWio8Dzq
 9Cp/ft5U6cgIQylwIY1VWkybpjbIbUYI6ItmYpi+8URMpr7H7BhAvEgW6ZRq4KGHWo6bM5
 aRZbpUZVH4NoTJHWlK/NdimMm3STu+k=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-169-czKc3wzPPni6UlajI0h4Sw-1; Wed,
 19 Mar 2025 11:21:35 -0400
X-MC-Unique: czKc3wzPPni6UlajI0h4Sw-1
X-Mimecast-MFC-AGG-ID: czKc3wzPPni6UlajI0h4Sw_1742397694
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F309519560B6
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8BE9A1800268
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2CD6021E6682; Wed, 19 Mar 2025 16:21:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/3] cleanup: Drop pointless return at end of function
Date: Wed, 19 Mar 2025 16:21:25 +0100
Message-ID: <20250319152126.3472290-3-armbru@redhat.com>
In-Reply-To: <20250319152126.3472290-1-armbru@redhat.com>
References: <20250319152126.3472290-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A few functions now end with a label.  The next commit will clean them
up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/system/os-win32.h           |  1 -
 target/ppc/kvm_ppc.h                |  3 ---
 accel/tcg/cpu-exec.c                |  1 -
 block/gluster.c                     |  4 ----
 block/rbd.c                         |  1 -
 block/replication.c                 |  1 -
 block/throttle-groups.c             |  1 -
 bsd-user/signal.c                   |  1 -
 dump/win_dump.c                     |  2 --
 event-loop-base.c                   |  2 --
 hw/acpi/acpi-cpu-hotplug-stub.c     |  8 --------
 hw/acpi/acpi-mem-hotplug-stub.c     |  5 -----
 hw/acpi/acpi-nvdimm-stub.c          |  1 -
 hw/acpi/acpi-pci-hotplug-stub.c     |  6 ------
 hw/arm/exynos4210.c                 |  1 -
 hw/arm/smmu-common.c                |  1 -
 hw/arm/xen-stubs.c                  |  1 -
 hw/audio/asc.c                      |  1 -
 hw/core/qdev-properties-system.c    |  1 -
 hw/cxl/cxl-host.c                   |  2 --
 hw/display/macfb.c                  |  1 -
 hw/display/tcx.c                    |  1 -
 hw/display/virtio-gpu-base.c        |  1 -
 hw/dma/sifive_pdma.c                |  1 -
 hw/gpio/aspeed_gpio.c               |  5 -----
 hw/gpio/bcm2838_gpio.c              |  1 -
 hw/gpio/imx_gpio.c                  |  2 --
 hw/gpio/pl061.c                     |  1 -
 hw/hyperv/vmbus.c                   |  1 -
 hw/i2c/pm_smbus.c                   |  1 -
 hw/i386/intel_iommu.c               |  2 --
 hw/i386/nitro_enclave.c             |  1 -
 hw/i386/xen/xen-hvm.c               |  2 --
 hw/input/virtio-input-host.c        |  1 -
 hw/intc/arm_gicv3_cpuif.c           |  1 -
 hw/intc/aspeed_intc.c               |  4 ----
 hw/intc/mips_gic.c                  |  1 -
 hw/ipmi/ipmi_bmc_extern.c           |  2 --
 hw/ipmi/ipmi_bmc_sim.c              |  2 --
 hw/ipmi/ipmi_bt.c                   |  1 -
 hw/ipmi/ipmi_kcs.c                  |  1 -
 hw/loongarch/virt.c                 |  3 ---
 hw/m68k/next-cube.c                 |  1 -
 hw/m68k/q800.c                      |  2 --
 hw/mem/cxl_type3.c                  |  4 ----
 hw/mem/sparse-mem.c                 |  1 -
 hw/misc/i2c-echo.c                  |  2 --
 hw/misc/ivshmem-flat.c              |  2 --
 hw/misc/mips_cpc.c                  |  2 --
 hw/net/can/ctucan_core.c            |  2 --
 hw/net/can/xlnx-versal-canfd.c      |  2 --
 hw/net/imx_fec.c                    |  1 -
 hw/net/vmxnet3.c                    |  1 -
 hw/nvram/xlnx-versal-efuse-ctrl.c   |  1 -
 hw/ppc/mac_newworld.c               |  2 --
 hw/ppc/pnv_occ.c                    |  1 -
 hw/ppc/spapr_hcall.c                |  1 -
 hw/ppc/spapr_nested.c               |  1 -
 hw/ppc/spapr_nvdimm.c               |  2 --
 hw/s390x/s390-pci-bus.c             |  1 -
 hw/s390x/s390-pci-vfio.c            |  2 --
 hw/scsi/megasas.c                   |  1 -
 hw/scsi/vhost-scsi.c                |  1 -
 hw/ssi/ibex_spi_host.c              |  1 -
 hw/ssi/pnv_spi.c                    |  2 --
 hw/tpm/tpm_tis_i2c.c                |  4 ----
 hw/usb/dev-mtp.c                    |  2 --
 hw/usb/dev-serial.c                 |  2 --
 hw/usb/dev-smartcard-reader.c       |  1 -
 hw/usb/dev-uas.c                    |  1 -
 hw/vfio/display.c                   |  1 -
 hw/vfio/pci.c                       |  1 -
 hw/vfio/platform.c                  |  1 -
 hw/virtio/vhost-user-fs.c           |  1 -
 hw/virtio/vhost-user-scmi.c         |  2 --
 hw/virtio/vhost-user-vsock.c        |  1 -
 hw/virtio/vhost-user.c              |  2 --
 hw/virtio/vhost-vdpa.c              |  2 --
 hw/virtio/vhost.c                   |  1 -
 hw/virtio/virtio-nsm.c              |  1 -
 hw/virtio/virtio.c                  |  2 --
 hw/watchdog/sbsa_gwdt.c             |  1 -
 hw/watchdog/wdt_aspeed.c            |  1 -
 linux-user/xtensa/signal.c          |  1 -
 migration/multifd-nocomp.c          |  1 -
 migration/qemu-file.c               |  2 --
 migration/ram.c                     |  2 --
 net/colo-compare.c                  |  2 --
 qemu-keymap.c                       |  1 -
 qga/commands-win32.c                |  4 ----
 system/dirtylimit.c                 |  2 --
 target/arm/tcg/helper-a64.c         |  2 --
 target/i386/kvm/vmsr_energy.c       |  1 -
 target/i386/tcg/translate.c         |  1 -
 target/i386/whpx/whpx-all.c         | 11 -----------
 target/m68k/helper.c                |  1 -
 target/mips/tcg/system/mips-semi.c  |  1 -
 target/ppc/kvm.c                    |  1 -
 target/ppc/translate.c              |  1 -
 target/riscv/debug.c                |  6 ------
 target/s390x/cpu_models.c           |  1 -
 target/sh4/translate.c              |  1 -
 tests/qtest/ahci-test.c             |  1 -
 tests/qtest/fuzz/generic_fuzz.c     |  1 -
 tests/qtest/libqos/libqos-malloc.c  |  1 -
 tests/qtest/libqtest.c              |  1 -
 tests/qtest/test-x86-cpuid-compat.c |  1 -
 tests/unit/socket-helpers.c         |  1 -
 tests/unit/test-qgraph.c            |  1 -
 ui/input-linux.c                    |  1 -
 ui/vnc.c                            |  2 --
 util/main-loop.c                    |  1 -
 util/qht.c                          |  1 -
 113 files changed, 197 deletions(-)

diff --git a/include/system/os-win32.h b/include/system/os-win32.h
index bc623061d8..3aa6cee4c2 100644
--- a/include/system/os-win32.h
+++ b/include/system/os-win32.h
@@ -130,7 +130,6 @@ static inline int os_mlock(bool on_fault G_GNUC_UNUSED)
 
 static inline void os_setup_limits(void)
 {
-    return;
 }
 
 #define fsync _commit
diff --git a/target/ppc/kvm_ppc.h b/target/ppc/kvm_ppc.h
index a8768c1dfd..a1d9ce9f9a 100644
--- a/target/ppc/kvm_ppc.h
+++ b/target/ppc/kvm_ppc.h
@@ -221,7 +221,6 @@ static inline int kvmppc_smt_threads(void)
 
 static inline void kvmppc_error_append_smt_possible_hint(Error *const *errp)
 {
-    return;
 }
 
 static inline int kvmppc_set_smt_threads(int smt)
@@ -259,7 +258,6 @@ static inline target_ulong kvmppc_configure_v3_mmu(PowerPCCPU *cpu,
 static inline void kvmppc_set_reg_ppc_online(PowerPCCPU *cpu,
                                              unsigned int online)
 {
-    return;
 }
 
 static inline void kvmppc_set_reg_tb_offset(PowerPCCPU *cpu, int64_t tb_offset)
@@ -456,7 +454,6 @@ static inline PowerPCCPUClass *kvm_ppc_get_host_cpu_class(void)
 
 static inline void kvmppc_check_papr_resize_hpt(Error **errp)
 {
-    return;
 }
 
 static inline int kvmppc_resize_hpt_prepare(PowerPCCPU *cpu,
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index ef3d967e3a..8e28136392 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -665,7 +665,6 @@ static inline void tb_add_jump(TranslationBlock *tb, int n,
 
  out_unlock_next:
     qemu_spin_unlock(&tb_next->jmp_lock);
-    return;
 }
 
 static inline bool cpu_handle_halt(CPUState *cpu)
diff --git a/block/gluster.c b/block/gluster.c
index c6d25ae733..8712aa606a 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -972,8 +972,6 @@ static void qemu_gluster_reopen_commit(BDRVReopenState *state)
 
     g_free(state->opaque);
     state->opaque = NULL;
-
-    return;
 }
 
 
@@ -993,8 +991,6 @@ static void qemu_gluster_reopen_abort(BDRVReopenState *state)
 
     g_free(state->opaque);
     state->opaque = NULL;
-
-    return;
 }
 
 #ifdef CONFIG_GLUSTERFS_ZEROFILL
diff --git a/block/rbd.c b/block/rbd.c
index af984fb7db..7446e66659 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -254,7 +254,6 @@ static void qemu_rbd_parse_filename(const char *filename, QDict *options,
 done:
     g_free(buf);
     qobject_unref(keypairs);
-    return;
 }
 
 static int qemu_rbd_set_auth(rados_t cluster, BlockdevOptionsRbd *opts,
diff --git a/block/replication.c b/block/replication.c
index 0020f33843..d6625c51fe 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -176,7 +176,6 @@ static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
     *nshared = BLK_PERM_CONSISTENT_READ
                | BLK_PERM_WRITE
                | BLK_PERM_WRITE_UNCHANGED;
-    return;
 }
 
 static int64_t coroutine_fn GRAPH_RDLOCK
diff --git a/block/throttle-groups.c b/block/throttle-groups.c
index 32553b39e3..9f4d252c74 100644
--- a/block/throttle-groups.c
+++ b/block/throttle-groups.c
@@ -908,7 +908,6 @@ unlock:
     qemu_mutex_unlock(&tg->lock);
     qapi_free_ThrottleLimits(argp);
     error_propagate(errp, local_err);
-    return;
 }
 
 static void throttle_group_get_limits(Object *obj, Visitor *v,
diff --git a/bsd-user/signal.c b/bsd-user/signal.c
index a8cfcca130..1aa0fd79d6 100644
--- a/bsd-user/signal.c
+++ b/bsd-user/signal.c
@@ -441,7 +441,6 @@ void queue_signal(CPUArchState *env, int sig, int si_type,
     ts->sync_signal.pending = sig;
     /* Signal that a new signal is pending. */
     qatomic_set(&ts->signal_pending, 1);
-    return;
 }
 
 static int fatal_signal(int sig)
diff --git a/dump/win_dump.c b/dump/win_dump.c
index 2c2576672a..3162e8bd48 100644
--- a/dump/win_dump.c
+++ b/dump/win_dump.c
@@ -476,8 +476,6 @@ out_free:
     g_free(saved_ctx);
 out_cr3:
     first_x86_cpu->env.cr[3] = saved_cr3;
-
-    return;
 }
 
 #else /* !TARGET_X86_64 */
diff --git a/event-loop-base.c b/event-loop-base.c
index 0cfb1c9496..ddf8400a6b 100644
--- a/event-loop-base.c
+++ b/event-loop-base.c
@@ -73,8 +73,6 @@ static void event_loop_base_set_param(Object *obj, Visitor *v,
     if (bc->update_params) {
         bc->update_params(base, errp);
     }
-
-    return;
 }
 
 static void event_loop_base_complete(UserCreatable *uc, Error **errp)
diff --git a/hw/acpi/acpi-cpu-hotplug-stub.c b/hw/acpi/acpi-cpu-hotplug-stub.c
index c6c61bb9cd..9872dd55e4 100644
--- a/hw/acpi/acpi-cpu-hotplug-stub.c
+++ b/hw/acpi/acpi-cpu-hotplug-stub.c
@@ -10,47 +10,39 @@ void acpi_switch_to_modern_cphp(AcpiCpuHotplug *gpe_cpu,
                                 CPUHotplugState *cpuhp_state,
                                 uint16_t io_port)
 {
-    return;
 }
 
 void legacy_acpi_cpu_hotplug_init(MemoryRegion *parent, Object *owner,
                                   AcpiCpuHotplug *gpe_cpu, uint16_t base)
 {
-    return;
 }
 
 void cpu_hotplug_hw_init(MemoryRegion *as, Object *owner,
                          CPUHotplugState *state, hwaddr base_addr)
 {
-    return;
 }
 
 void acpi_cpu_ospm_status(CPUHotplugState *cpu_st, ACPIOSTInfoList ***list)
 {
-    return;
 }
 
 void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void legacy_acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
                              AcpiCpuHotplug *g, DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void acpi_cpu_unplug_cb(CPUHotplugState *cpu_st,
                         DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp)
 {
-    return;
 }
diff --git a/hw/acpi/acpi-mem-hotplug-stub.c b/hw/acpi/acpi-mem-hotplug-stub.c
index 73a076a265..7ad0fdcdf2 100644
--- a/hw/acpi/acpi-mem-hotplug-stub.c
+++ b/hw/acpi/acpi-mem-hotplug-stub.c
@@ -7,29 +7,24 @@ const VMStateDescription vmstate_memory_hotplug;
 void acpi_memory_hotplug_init(MemoryRegion *as, Object *owner,
                               MemHotplugState *state, hwaddr io_base)
 {
-    return;
 }
 
 void acpi_memory_ospm_status(MemHotplugState *mem_st, ACPIOSTInfoList ***list)
 {
-    return;
 }
 
 void acpi_memory_plug_cb(HotplugHandler *hotplug_dev, MemHotplugState *mem_st,
                          DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void acpi_memory_unplug_cb(MemHotplugState *mem_st,
                            DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void acpi_memory_unplug_request_cb(HotplugHandler *hotplug_dev,
                                    MemHotplugState *mem_st,
                                    DeviceState *dev, Error **errp)
 {
-    return;
 }
diff --git a/hw/acpi/acpi-nvdimm-stub.c b/hw/acpi/acpi-nvdimm-stub.c
index 8baff9be6f..65f491d653 100644
--- a/hw/acpi/acpi-nvdimm-stub.c
+++ b/hw/acpi/acpi-nvdimm-stub.c
@@ -4,5 +4,4 @@
 
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
-    return;
 }
diff --git a/hw/acpi/acpi-pci-hotplug-stub.c b/hw/acpi/acpi-pci-hotplug-stub.c
index dcee3ad7a1..b67b4a92da 100644
--- a/hw/acpi/acpi-pci-hotplug-stub.c
+++ b/hw/acpi/acpi-pci-hotplug-stub.c
@@ -7,37 +7,31 @@ const VMStateDescription vmstate_acpi_pcihp_pci_status;
 void acpi_pcihp_init(Object *owner, AcpiPciHpState *s, PCIBus *root_bus,
                      MemoryRegion *address_space_io, uint16_t io_base)
 {
-    return;
 }
 
 void acpi_pcihp_device_plug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void acpi_pcihp_device_pre_plug_cb(HotplugHandler *hotplug_dev,
                                    DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void acpi_pcihp_device_unplug_cb(HotplugHandler *hotplug_dev, AcpiPciHpState *s,
                                  DeviceState *dev, Error **errp)
 {
-    return;
 }
 
 void acpi_pcihp_device_unplug_request_cb(HotplugHandler *hotplug_dev,
                                          AcpiPciHpState *s, DeviceState *dev,
                                          Error **errp)
 {
-    return;
 }
 
 void acpi_pcihp_reset(AcpiPciHpState *s)
 {
-    return;
 }
 
 bool acpi_pcihp_is_hotpluggbale_bus(AcpiPciHpState *s, BusState *bus)
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index b452470598..0c27588116 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -462,7 +462,6 @@ static uint64_t exynos4210_chipid_and_omr_read(void *opaque, hwaddr offset,
 static void exynos4210_chipid_and_omr_write(void *opaque, hwaddr offset,
                                             uint64_t value, unsigned size)
 {
-    return;
 }
 
 static const MemoryRegionOps exynos4210_chipid_and_omr_ops = {
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 6e720e1b9a..1aa2eabfbd 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -712,7 +712,6 @@ static void combine_tlb(SMMUTLBEntry *tlbe, SMMUTLBEntry *tlbe_s2,
     tlbe->entry.iova = iova & ~tlbe->entry.addr_mask;
     /* parent_perm has s2 perm while perm keeps s1 perm. */
     tlbe->parent_perm = tlbe_s2->entry.perm;
-    return;
 }
 
 /**
diff --git a/hw/arm/xen-stubs.c b/hw/arm/xen-stubs.c
index 5551584dc2..6a83043553 100644
--- a/hw/arm/xen-stubs.c
+++ b/hw/arm/xen-stubs.c
@@ -14,7 +14,6 @@
 void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
 {
     hw_error("Invalid ioreq type 0x%x\n", req->type);
-    return;
 }
 
 void arch_xen_set_memory(XenIOState *state, MemoryRegionSection *section,
diff --git a/hw/audio/asc.c b/hw/audio/asc.c
index cc205bf063..cea7a1c053 100644
--- a/hw/audio/asc.c
+++ b/hw/audio/asc.c
@@ -406,7 +406,6 @@ static void asc_fifo_write(void *opaque, hwaddr addr, uint64_t value,
     } else {
         fs->fifo[addr] = value;
     }
-    return;
 }
 
 static const MemoryRegionOps asc_fifo_ops = {
diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index a7dde73c29..8e11e6388b 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -793,7 +793,6 @@ separator_error:
     error_setg(errp, "reserved region fields must be separated with ':'");
 out:
     g_free(str);
-    return;
 }
 
 const PropertyInfo qdev_prop_reserved_region = {
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 2c6b43cd0d..e010163174 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -67,8 +67,6 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
 
     cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
                                              g_steal_pointer(&fw));
-
-    return;
 }
 
 void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
diff --git a/hw/display/macfb.c b/hw/display/macfb.c
index e83fc863be..b08eb06cbd 100644
--- a/hw/display/macfb.c
+++ b/hw/display/macfb.c
@@ -383,7 +383,6 @@ static void macfb_sense_write(MacfbState *s, uint32_t val)
     s->regs[DAFB_MODE_SENSE >> 2] = val;
 
     trace_macfb_sense_write(val);
-    return;
 }
 
 static void macfb_update_mode(MacfbState *s)
diff --git a/hw/display/tcx.c b/hw/display/tcx.c
index 2cfc1e8f01..5968d33e48 100644
--- a/hw/display/tcx.c
+++ b/hw/display/tcx.c
@@ -729,7 +729,6 @@ static uint64_t tcx_dummy_readl(void *opaque, hwaddr addr,
 static void tcx_dummy_writel(void *opaque, hwaddr addr,
                          uint64_t val, unsigned size)
 {
-    return;
 }
 
 static const MemoryRegionOps tcx_dummy_ops = {
diff --git a/hw/display/virtio-gpu-base.c b/hw/display/virtio-gpu-base.c
index 7827536ac4..321a6f4998 100644
--- a/hw/display/virtio-gpu-base.c
+++ b/hw/display/virtio-gpu-base.c
@@ -110,7 +110,6 @@ static void virtio_gpu_ui_info(void *opaque, uint32_t idx, QemuUIInfo *info)
 
     /* send event to guest */
     virtio_gpu_notify_event(g, VIRTIO_GPU_EVENT_DISPLAY);
-    return;
 }
 
 static void
diff --git a/hw/dma/sifive_pdma.c b/hw/dma/sifive_pdma.c
index 25b3d6a155..a115af8d60 100644
--- a/hw/dma/sifive_pdma.c
+++ b/hw/dma/sifive_pdma.c
@@ -152,7 +152,6 @@ done:
 error:
     s->chan[ch].state = DMA_CHAN_STATE_ERROR;
     s->chan[ch].control |= CONTROL_ERR;
-    return;
 }
 
 static inline void sifive_pdma_update_irq(SiFivePDMAState *s, int ch)
diff --git a/hw/gpio/aspeed_gpio.c b/hw/gpio/aspeed_gpio.c
index a5b3f454e8..aedaf5238b 100644
--- a/hw/gpio/aspeed_gpio.c
+++ b/hw/gpio/aspeed_gpio.c
@@ -800,7 +800,6 @@ static void aspeed_gpio_write_index_mode(void *opaque, hwaddr offset,
         return;
     }
     aspeed_gpio_update(s, set, set->data_value, UINT32_MAX);
-    return;
 }
 
 static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
@@ -928,7 +927,6 @@ static void aspeed_gpio_write(void *opaque, hwaddr offset, uint64_t data,
         return;
     }
     aspeed_gpio_update(s, set, set->data_value, UINT32_MAX);
-    return;
 }
 
 static int get_set_idx(AspeedGPIOState *s, const char *group, int *group_idx)
@@ -1183,7 +1181,6 @@ static void aspeed_gpio_2700_write_control_reg(AspeedGPIOState *s,
     }
 
     aspeed_gpio_update(s, set, set->data_value, UINT32_MAX);
-    return;
 }
 
 static uint64_t aspeed_gpio_2700_read(void *opaque, hwaddr offset,
@@ -1308,8 +1305,6 @@ static void aspeed_gpio_2700_write(void *opaque, hwaddr offset,
                       PRIx64"\n", __func__, offset);
         break;
     }
-
-    return;
 }
 
 /* Setup functions */
diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index 0a1739fc46..53be8f2d23 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -293,7 +293,6 @@ static void bcm2838_gpio_write(void *opaque, hwaddr offset, uint64_t value,
         qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: bad offset %"HWADDR_PRIx"\n",
                   TYPE_BCM2838_GPIO, __func__, offset);
     }
-    return;
 }
 
 static void bcm2838_gpio_reset(DeviceState *dev)
diff --git a/hw/gpio/imx_gpio.c b/hw/gpio/imx_gpio.c
index 549a281ed7..8c8299c4c4 100644
--- a/hw/gpio/imx_gpio.c
+++ b/hw/gpio/imx_gpio.c
@@ -257,8 +257,6 @@ static void imx_gpio_write(void *opaque, hwaddr offset, uint64_t value,
                       HWADDR_PRIx "\n", TYPE_IMX_GPIO, __func__, offset);
         break;
     }
-
-    return;
 }
 
 static const MemoryRegionOps imx_gpio_ops = {
diff --git a/hw/gpio/pl061.c b/hw/gpio/pl061.c
index 60ce4a7f62..2e69785f2a 100644
--- a/hw/gpio/pl061.c
+++ b/hw/gpio/pl061.c
@@ -443,7 +443,6 @@ static void pl061_write(void *opaque, hwaddr offset,
         return;
     }
     pl061_update(s);
-    return;
 }
 
 static void pl061_enter_reset(Object *obj, ResetType type)
diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index 12a7dc4312..f195e56c83 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -2073,7 +2073,6 @@ static void send_unload(VMBus *vmbus)
     qemu_mutex_unlock(&vmbus->rx_queue_lock);
 
     post_msg(vmbus, &msg, sizeof(msg));
-    return;
 }
 
 static bool complete_unload(VMBus *vmbus)
diff --git a/hw/i2c/pm_smbus.c b/hw/i2c/pm_smbus.c
index 3eed8110b9..4e685fd26e 100644
--- a/hw/i2c/pm_smbus.c
+++ b/hw/i2c/pm_smbus.c
@@ -205,7 +205,6 @@ out:
 
 error:
     s->smb_stat |= STS_DEV_ERR;
-    return;
 }
 
 static void smb_transaction_start(PMSMBus *s)
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index dffd7ee885..0608aec8c5 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -4515,8 +4515,6 @@ static void vtd_iommu_replay(IOMMUMemoryRegion *iommu_mr, IOMMUNotifier *n)
         trace_vtd_replay_ce_invalid(bus_n, PCI_SLOT(vtd_as->devfn),
                                     PCI_FUNC(vtd_as->devfn));
     }
-
-    return;
 }
 
 static void vtd_cap_init(IntelIOMMUState *s)
diff --git a/hw/i386/nitro_enclave.c b/hw/i386/nitro_enclave.c
index a058608afc..4b69f265cc 100644
--- a/hw/i386/nitro_enclave.c
+++ b/hw/i386/nitro_enclave.c
@@ -203,7 +203,6 @@ static void x86_load_eif(X86MachineState *x86ms, FWCfgState *fw_cfg,
 
     unlink(machine->kernel_filename);
     unlink(machine->initrd_filename);
-    return;
 }
 
 static bool create_memfd_backend(MachineState *ms, const char *path,
diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index d4516acec6..ceb2242aa7 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -758,6 +758,4 @@ void arch_handle_ioreq(XenIOState *state, ioreq_t *req)
     default:
         hw_error("Invalid ioreq type 0x%x\n", req->type);
     }
-
-    return;
 }
diff --git a/hw/input/virtio-input-host.c b/hw/input/virtio-input-host.c
index 8bfb17f3c4..b21a79046e 100644
--- a/hw/input/virtio-input-host.c
+++ b/hw/input/virtio-input-host.c
@@ -178,7 +178,6 @@ static void virtio_input_host_realize(DeviceState *dev, Error **errp)
 err_close:
     close(vih->fd);
     vih->fd = -1;
-    return;
 }
 
 static void virtio_input_host_unrealize(DeviceState *dev)
diff --git a/hw/intc/arm_gicv3_cpuif.c b/hw/intc/arm_gicv3_cpuif.c
index de37465bc8..4b4cf09157 100644
--- a/hw/intc/arm_gicv3_cpuif.c
+++ b/hw/intc/arm_gicv3_cpuif.c
@@ -584,7 +584,6 @@ static void icv_ap_write(CPUARMState *env, const ARMCPRegInfo *ri,
     }
 
     gicv3_cpuif_virt_irq_fiq_update(cs);
-    return;
 }
 
 static uint64_t icv_bpr_read(CPUARMState *env, const ARMCPRegInfo *ri)
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 3fd417084f..9d2e33226d 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -448,8 +448,6 @@ static void aspeed_intc_write(void *opaque, hwaddr offset, uint64_t data,
         s->regs[reg] = data;
         break;
     }
-
-    return;
 }
 
 static uint64_t aspeed_intcio_read(void *opaque, hwaddr offset,
@@ -496,8 +494,6 @@ static void aspeed_intcio_write(void *opaque, hwaddr offset, uint64_t data,
         s->regs[reg] = data;
         break;
     }
-
-    return;
 }
 
 
diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 5e3cbeabec..bd1dedd4b9 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -255,7 +255,6 @@ static void gic_write_vp(MIPSGICState *gic, uint32_t vp_index, hwaddr addr,
     return;
 bad_offset:
     qemu_log_mask(LOG_GUEST_ERROR, "Wrong GIC offset at 0x%" PRIx64 "\n", addr);
-    return;
 }
 
 static void gic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
diff --git a/hw/ipmi/ipmi_bmc_extern.c b/hw/ipmi/ipmi_bmc_extern.c
index d015500254..73b249fb60 100644
--- a/hw/ipmi/ipmi_bmc_extern.c
+++ b/hw/ipmi/ipmi_bmc_extern.c
@@ -142,7 +142,6 @@ static void continue_send(IPMIBmcExtern *ibe)
                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 4000000000ULL);
         }
     }
-    return;
 }
 
 static void extern_timeout(void *opaque)
@@ -231,7 +230,6 @@ static void ipmi_bmc_extern_handle_command(IPMIBmc *b,
     continue_send(ibe);
 
  out:
-    return;
 }
 
 static void handle_hw_op(IPMIBmcExtern *ibe, unsigned char hw_op)
diff --git a/hw/ipmi/ipmi_bmc_sim.c b/hw/ipmi/ipmi_bmc_sim.c
index 6157ac7120..faec6fefb3 100644
--- a/hw/ipmi/ipmi_bmc_sim.c
+++ b/hw/ipmi/ipmi_bmc_sim.c
@@ -470,7 +470,6 @@ void ipmi_bmc_gen_event(IPMIBmc *b, uint8_t *evt, bool log)
     ibs->msg_flags |= IPMI_BMC_MSG_FLAG_EVT_BUF_FULL;
     k->set_atn(s, 1, attn_irq_enabled(ibs));
  out:
-    return;
 }
 static void gen_event(IPMIBmcSim *ibs, unsigned int sens_num, uint8_t deassert,
                       uint8_t evd1, uint8_t evd2, uint8_t evd3)
@@ -997,7 +996,6 @@ static void get_msg(IPMIBmcSim *ibs,
     }
 
 out:
-    return;
 }
 
 static unsigned char
diff --git a/hw/ipmi/ipmi_bt.c b/hw/ipmi/ipmi_bt.c
index 583fc64730..3ef1f435e7 100644
--- a/hw/ipmi/ipmi_bt.c
+++ b/hw/ipmi/ipmi_bt.c
@@ -146,7 +146,6 @@ static void ipmi_bt_handle_event(IPMIInterface *ii)
                            sizeof(ib->inmsg), ib->waiting_rsp);
     }
  out:
-    return;
 }
 
 static void ipmi_bt_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
diff --git a/hw/ipmi/ipmi_kcs.c b/hw/ipmi/ipmi_kcs.c
index c15977cab4..f4f1523d6b 100644
--- a/hw/ipmi/ipmi_kcs.c
+++ b/hw/ipmi/ipmi_kcs.c
@@ -198,7 +198,6 @@ static void ipmi_kcs_handle_event(IPMIInterface *ii)
     ik->data_in_reg = -1;
     IPMI_KCS_SET_IBF(ik->status_reg, 0);
  out_noibf:
-    return;
 }
 
 static void ipmi_kcs_handle_rsp(IPMIInterface *ii, uint8_t msg_id,
diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
index a5840ff968..91c851bd54 100644
--- a/hw/loongarch/virt.c
+++ b/hw/loongarch/virt.c
@@ -970,7 +970,6 @@ static void virt_cpu_unplug(HotplugHandler *hotplug_dev,
 
     cpu_slot = virt_find_cpu_slot(MACHINE(lvms), cpu->phy_id);
     cpu_slot->cpu = NULL;
-    return;
 }
 
 static void virt_cpu_plug(HotplugHandler *hotplug_dev,
@@ -1005,8 +1004,6 @@ static void virt_cpu_plug(HotplugHandler *hotplug_dev,
             error_propagate(errp, err);
         }
     }
-
-    return;
 }
 
 static bool memhp_type_supported(DeviceState *dev)
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 0570e4a76f..7ea7e91032 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -899,7 +899,6 @@ static void next_dummy_en_write(void *opaque, hwaddr addr, uint64_t val,
                                 unsigned size)
 {
     /* Do nothing */
-    return;
 }
 
 static uint64_t next_dummy_en_read(void *opaque, hwaddr addr, unsigned size)
diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index aeed4c8ddb..1e5b0e21df 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -210,7 +210,6 @@ static uint64_t machine_id_read(void *opaque, hwaddr addr, unsigned size)
 static void machine_id_write(void *opaque, hwaddr addr, uint64_t val,
                              unsigned size)
 {
-    return;
 }
 
 static const MemoryRegionOps machine_id_ops = {
@@ -231,7 +230,6 @@ static uint64_t ramio_read(void *opaque, hwaddr addr, unsigned size)
 static void ramio_write(void *opaque, hwaddr addr, uint64_t val,
                         unsigned size)
 {
-    return;
 }
 
 static const MemoryRegionOps ramio_ops = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6fffa21ead..43aa02ab2a 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -957,7 +957,6 @@ err_free_special_ops:
     if (ct3d->hostvmem) {
         address_space_destroy(&ct3d->hostvmem_as);
     }
-    return;
 }
 
 static void ct3_exit(PCIDevice *pci_dev)
@@ -1511,8 +1510,6 @@ void qmp_cxl_inject_uncorrectable_errors(const char *path,
 
     stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, unc_err);
     pcie_aer_inject_error(PCI_DEVICE(obj), &err);
-
-    return;
 }
 
 void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
@@ -1788,7 +1785,6 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint8_t flags,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
         cxl_event_irq_assert(ct3d);
     }
-    return;
 }
 
 void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
diff --git a/hw/mem/sparse-mem.c b/hw/mem/sparse-mem.c
index 6a9a591370..8bed5dbe16 100644
--- a/hw/mem/sparse-mem.c
+++ b/hw/mem/sparse-mem.c
@@ -82,7 +82,6 @@ static void sparse_mem_enter_reset(Object *obj, ResetType type)
 {
     SparseMemState *s = SPARSE_MEM(obj);
     g_hash_table_remove_all(s->mapped);
-    return;
 }
 
 static const MemoryRegionOps sparse_mem_ops = {
diff --git a/hw/misc/i2c-echo.c b/hw/misc/i2c-echo.c
index 65d10029dc..fcd407dfc6 100644
--- a/hw/misc/i2c-echo.c
+++ b/hw/misc/i2c-echo.c
@@ -143,8 +143,6 @@ static void i2c_echo_realize(DeviceState *dev, Error **errp)
 
     state->bus = I2C_BUS(bus);
     state->bh = qemu_bh_new(i2c_echo_bh, state);
-
-    return;
 }
 
 static void i2c_echo_class_init(ObjectClass *oc, void *data)
diff --git a/hw/misc/ivshmem-flat.c b/hw/misc/ivshmem-flat.c
index 40309a8ff3..a0ac7543a2 100644
--- a/hw/misc/ivshmem-flat.c
+++ b/hw/misc/ivshmem-flat.c
@@ -289,8 +289,6 @@ static void ivshmem_flat_iomem_write(void *opaque, hwaddr offset,
         trace_ivshmem_flat_read_write_mmr_invalid(offset);
         break;
     }
-
-    return;
 }
 
 static const MemoryRegionOps ivshmem_flat_ops = {
diff --git a/hw/misc/mips_cpc.c b/hw/misc/mips_cpc.c
index 772b8c0017..b7a13d1afb 100644
--- a/hw/misc/mips_cpc.c
+++ b/hw/misc/mips_cpc.c
@@ -92,8 +92,6 @@ static void cpc_write(void *opaque, hwaddr offset, uint64_t data,
                       "%s: Bad offset 0x%x\n",  __func__, (int)offset);
         break;
     }
-
-    return;
 }
 
 static uint64_t cpc_read(void *opaque, hwaddr offset, unsigned size)
diff --git a/hw/net/can/ctucan_core.c b/hw/net/can/ctucan_core.c
index 4402d4cb1f..17131a4e18 100644
--- a/hw/net/can/ctucan_core.c
+++ b/hw/net/can/ctucan_core.c
@@ -400,8 +400,6 @@ void ctucan_mem_write(CtuCanCoreState *s, hwaddr addr, uint64_t val,
 
         ctucan_update_irq(s);
     }
-
-    return;
 }
 
 uint64_t ctucan_mem_read(CtuCanCoreState *s, hwaddr addr, unsigned size)
diff --git a/hw/net/can/xlnx-versal-canfd.c b/hw/net/can/xlnx-versal-canfd.c
index dc242e9215..b5a4a4af7e 100644
--- a/hw/net/can/xlnx-versal-canfd.c
+++ b/hw/net/can/xlnx-versal-canfd.c
@@ -1298,8 +1298,6 @@ static void free_list(GSList *list)
     }
 
     g_slist_free(list);
-
-    return;
 }
 
 static GSList *prepare_tx_data(XlnxVersalCANFDState *s)
diff --git a/hw/net/imx_fec.c b/hw/net/imx_fec.c
index 0f0afda58a..b7c9ee0b9a 100644
--- a/hw/net/imx_fec.c
+++ b/hw/net/imx_fec.c
@@ -668,7 +668,6 @@ static void imx_default_write(IMXFECState *s, uint32_t index, uint32_t value)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "[%s]%s: Bad address at offset 0x%"
                   PRIx32 "\n", TYPE_IMX_FEC, __func__, index * 4);
-    return;
 }
 
 static void imx_fec_write(IMXFECState *s, uint32_t index, uint32_t value)
diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 7abed66469..f370d4a2ec 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -932,7 +932,6 @@ static void vmxnet3_rx_update_descr(struct NetRxPkt *pkt,
 
 nocsum:
     rxcd->cnc = 1;
-    return;
 }
 
 static void
diff --git a/hw/nvram/xlnx-versal-efuse-ctrl.c b/hw/nvram/xlnx-versal-efuse-ctrl.c
index 3246eb3ca6..ff4d544ad6 100644
--- a/hw/nvram/xlnx-versal-efuse-ctrl.c
+++ b/hw/nvram/xlnx-versal-efuse-ctrl.c
@@ -494,7 +494,6 @@ static void efuse_rd_addr_postw(RegisterInfo *reg, uint64_t val64)
 
     ARRAY_FIELD_DP32(s->regs, EFUSE_ISR, RD_DONE, 1);
     efuse_imr_update_irq(s);
-    return;
 }
 
 static uint64_t efuse_cache_load_prew(RegisterInfo *reg, uint64_t val64)
diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
index cb3dc3ab48..1c41012887 100644
--- a/hw/ppc/mac_newworld.c
+++ b/hw/ppc/mac_newworld.c
@@ -635,8 +635,6 @@ static void core99_instance_init(Object *obj)
     object_property_set_description(obj, "via",
                                     "Set VIA configuration. "
                                     "Valid values are cuda, pmu and pmu-adb");
-
-    return;
 }
 
 static const TypeInfo core99_machine_info = {
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index bda6b23ad3..c25a8f7258 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -150,7 +150,6 @@ static void pnv_occ_common_area_write(void *opaque, hwaddr addr,
                                              uint64_t val, unsigned width)
 {
     /* callback function defined to occ common area write */
-    return;
 }
 
 static const MemoryRegionOps pnv_occ_power8_xscom_ops = {
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 406aea4ecb..29453a880e 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -981,7 +981,6 @@ static void spapr_check_setup_free_hpt(SpaprMachineState *spapr,
         /* RADIX->HASH || NOTHING->HASH : Allocate HPT */
         spapr_setup_hpt(spapr);
     }
-    return;
 }
 
 #define FLAGS_MASK              0x01FULL
diff --git a/hw/ppc/spapr_nested.c b/hw/ppc/spapr_nested.c
index 201f629203..3797220a29 100644
--- a/hw/ppc/spapr_nested.c
+++ b/hw/ppc/spapr_nested.c
@@ -1735,7 +1735,6 @@ static void exit_process_output_buffer(SpaprMachineState *spapr,
     getset_state(spapr, guest, vcpuid, &gsr);
 
     address_space_unmap(CPU(cpu)->as, gsb, len, true, len);
-    return;
 }
 
 static
diff --git a/hw/ppc/spapr_nvdimm.c b/hw/ppc/spapr_nvdimm.c
index 6f875d73b2..6e93ff9b33 100644
--- a/hw/ppc/spapr_nvdimm.c
+++ b/hw/ppc/spapr_nvdimm.c
@@ -235,8 +235,6 @@ void spapr_dt_persistent_memory(SpaprMachineState *spapr, void *fdt)
         spapr_dt_nvdimm(spapr, fdt, offset, nvdimm);
     }
     g_slist_free(nvdimms);
-
-    return;
 }
 
 static target_ulong h_scm_read_metadata(PowerPCCPU *cpu,
diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 2591ee49c1..d96819f1a4 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -597,7 +597,6 @@ static void s390_pci_iommu_replay(IOMMUMemoryRegion *iommu,
      * zpci device" construct. But when we support migration of vfio-pci
      * devices in future, we need to revisit this.
      */
-    return;
 }
 
 static S390PCIIOMMU *s390_pci_get_iommu(S390pciState *s, PCIBus *bus,
diff --git a/hw/s390x/s390-pci-vfio.c b/hw/s390x/s390-pci-vfio.c
index 6236ac7f1e..db152a6252 100644
--- a/hw/s390x/s390-pci-vfio.c
+++ b/hw/s390x/s390-pci-vfio.c
@@ -367,6 +367,4 @@ void s390_pci_get_clp_info(S390PCIBusDevice *pbdev)
     s390_pci_read_group(pbdev, info);
     s390_pci_read_util(pbdev, info);
     s390_pci_read_pfip(pbdev, info);
-
-    return;
 }
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 9f3b30e6ce..d56bfc711d 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2226,7 +2226,6 @@ static uint64_t megasas_queue_read(void *opaque, hwaddr addr,
 static void megasas_queue_write(void *opaque, hwaddr addr,
                                uint64_t val, unsigned size)
 {
-    return;
 }
 
 static const MemoryRegionOps megasas_queue_ops = {
diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 8039d13fd9..66e0c21c22 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -314,7 +314,6 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
     if (vhostfd >= 0) {
         close(vhostfd);
     }
-    return;
 }
 
 static void vhost_scsi_unrealize(DeviceState *dev)
diff --git a/hw/ssi/ibex_spi_host.c b/hw/ssi/ibex_spi_host.c
index 46c7b633c2..6b28cda200 100644
--- a/hw/ssi/ibex_spi_host.c
+++ b/hw/ssi/ibex_spi_host.c
@@ -154,7 +154,6 @@ static void ibex_spi_host_reset(DeviceState *dev)
     ibex_spi_txfifo_reset(s);
 
     s->init_status = true;
-    return;
 }
 
 /*
diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
index 126070393e..367a2ff3bb 100644
--- a/hw/ssi/pnv_spi.c
+++ b/hw/ssi/pnv_spi.c
@@ -996,7 +996,6 @@ static void operation_sequencer(PnvSpi *s)
     } /* end of while */
     /* Update sequencer index field in status.*/
     s->status = SETFIELD(SPI_STS_SEQ_INDEX, s->status, seq_index);
-    return;
 } /* end of operation_sequencer() */
 
 /*
@@ -1142,7 +1141,6 @@ static void pnv_spi_xscom_write(void *opaque, hwaddr addr,
         qemu_log_mask(LOG_GUEST_ERROR, "pnv_spi_regs: Invalid xscom "
                  "write at 0x%" PRIx32 "\n", reg);
     }
-    return;
 }
 
 static const MemoryRegionOps pnv_spi_xscom_ops = {
diff --git a/hw/tpm/tpm_tis_i2c.c b/hw/tpm/tpm_tis_i2c.c
index 504328e3b0..92d3de1ea3 100644
--- a/hw/tpm/tpm_tis_i2c.c
+++ b/hw/tpm/tpm_tis_i2c.c
@@ -211,8 +211,6 @@ static inline void tpm_tis_i2c_clear_data(TPMStateI2C *i2cst)
     i2cst->tis_addr = 0xffffffff;
     i2cst->reg_name = NULL;
     memset(i2cst->data, 0, sizeof(i2cst->data));
-
-    return;
 }
 
 /* Send data to TPM */
@@ -281,8 +279,6 @@ static inline void tpm_tis_i2c_tpm_send(TPMStateI2C *i2cst)
 
         tpm_tis_i2c_clear_data(i2cst);
     }
-
-    return;
 }
 
 /* Callback from TPM to indicate that response is copied */
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 326c92a43d..4cd14c3df4 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1234,8 +1234,6 @@ static void usb_mtp_object_delete(MTPState *s, uint32_t handle,
     default:
         g_assert_not_reached();
     }
-
-    return;
 }
 
 static void usb_mtp_command(MTPState *s, MTPControl *c)
diff --git a/hw/usb/dev-serial.c b/hw/usb/dev-serial.c
index aa50a92e26..31f6cf5b31 100644
--- a/hw/usb/dev-serial.c
+++ b/hw/usb/dev-serial.c
@@ -472,8 +472,6 @@ static void usb_serial_token_in(USBSerialState *s, USBPacket *p)
         s->recv_ptr = (s->recv_ptr + len) % RECV_BUF;
         packet_len -= len + 2;
     }
-
-    return;
 }
 
 static void usb_serial_handle_data(USBDevice *dev, USBPacket *p)
diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 73deb3ce83..84ca8c48e2 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1069,7 +1069,6 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
 err:
     p->status = USB_RET_STALL;
     s->bulk_out_pos = 0;
-    return;
 }
 
 static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p,
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 44e30013d7..b1d6b6ecc3 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -914,7 +914,6 @@ static void usb_uas_handle_data(USBDevice *dev, USBPacket *p)
 err_stream:
     error_report("%s: invalid stream %d", __func__, p->stream);
     p->status = USB_RET_STALL;
-    return;
 }
 
 static void usb_uas_unrealize(USBDevice *dev)
diff --git a/hw/vfio/display.c b/hw/vfio/display.c
index ea87830fe0..4fdcef505d 100644
--- a/hw/vfio/display.c
+++ b/hw/vfio/display.c
@@ -104,7 +104,6 @@ static void vfio_display_edid_update(VFIOPCIDevice *vdev, bool enabled,
 
 err:
     trace_vfio_display_edid_write_error();
-    return;
 }
 
 static void vfio_display_edid_ui_info(void *opaque, uint32_t idx,
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 7f1532fbed..f87f3ccbe1 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2383,7 +2383,6 @@ static void vfio_add_ext_cap(VFIOPCIDevice *vdev)
     }
 
     g_free(config);
-    return;
 }
 
 static bool vfio_add_capabilities(VFIOPCIDevice *vdev, Error **errp)
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index 67bc57409c..7b4e100e27 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -418,7 +418,6 @@ fail_vfio:
     abort();
 fail_irqfd:
     vfio_start_eventfd_injection(sbdev, irq);
-    return;
 }
 
 /* VFIO skeleton */
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 3f00d79ed0..0e8d4b3823 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -267,7 +267,6 @@ err_virtio:
     g_free(fs->req_vqs);
     virtio_cleanup(vdev);
     g_free(fs->vhost_dev.vqs);
-    return;
 }
 
 static void vuf_device_unrealize(DeviceState *dev)
diff --git a/hw/virtio/vhost-user-scmi.c b/hw/virtio/vhost-user-scmi.c
index 410a936ca7..04cd36dd2e 100644
--- a/hw/virtio/vhost-user-scmi.c
+++ b/hw/virtio/vhost-user-scmi.c
@@ -258,8 +258,6 @@ static void vu_scmi_device_realize(DeviceState *dev, Error **errp)
 
     qemu_chr_fe_set_handlers(&scmi->chardev, NULL, NULL, vu_scmi_event, NULL,
                              dev, NULL, true);
-
-    return;
 }
 
 static void vu_scmi_device_unrealize(DeviceState *dev)
diff --git a/hw/virtio/vhost-user-vsock.c b/hw/virtio/vhost-user-vsock.c
index 293273080b..d21cd4b516 100644
--- a/hw/virtio/vhost-user-vsock.c
+++ b/hw/virtio/vhost-user-vsock.c
@@ -128,7 +128,6 @@ err_vhost_dev:
 err_virtio:
     vhost_vsock_common_unrealize(vdev);
     vhost_user_cleanup(&vsock->vhost_user);
-    return;
 }
 
 static void vuv_device_unrealize(DeviceState *dev)
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 267b612587..fdc01ab99e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -654,8 +654,6 @@ static void scrub_shadow_regions(struct vhost_dev *dev,
     }
     *nr_rem_reg = rm_idx;
     *nr_add_reg = add_idx;
-
-    return;
 }
 
 static int send_remove_regions(struct vhost_dev *dev,
diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 7efbde3d4c..8b45756ae7 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -288,8 +288,6 @@ static void vhost_vdpa_iommu_region_add(MemoryListener *listener,
 
     QLIST_INSERT_HEAD(&s->iommu_list, iommu, iommu_next);
     memory_region_iommu_replay(iommu->iommu_mr, &iommu->n);
-
-    return;
 }
 
 static void vhost_vdpa_iommu_region_del(MemoryListener *listener,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 6aa72fd434..4cae7c1664 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -732,7 +732,6 @@ out:
         memory_region_unref(old_sections[n_old_sections].mr);
     }
     g_free(old_sections);
-    return;
 }
 
 /* Adds the section data to the tmp_section structure.
diff --git a/hw/virtio/virtio-nsm.c b/hw/virtio/virtio-nsm.c
index b22aa74e34..accf7334e3 100644
--- a/hw/virtio/virtio-nsm.c
+++ b/hw/virtio/virtio-nsm.c
@@ -1609,7 +1609,6 @@ static void handle_input(VirtIODevice *vdev, VirtQueue *vq)
     if (in_elem) {
         virtqueue_detach_element(vq, in_elem, 0);
     }
-    return;
 }
 
 static uint64_t get_features(VirtIODevice *vdev, uint64_t f, Error **errp)
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 85110bce37..ffc12635ae 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3648,7 +3648,6 @@ static void virtio_queue_packed_restore_last_avail_idx(VirtIODevice *vdev,
                                                        int n)
 {
     /* We don't have a reference like avail idx in shared memory */
-    return;
 }
 
 static void virtio_queue_split_restore_last_avail_idx(VirtIODevice *vdev,
@@ -3673,7 +3672,6 @@ void virtio_queue_restore_last_avail_idx(VirtIODevice *vdev, int n)
 static void virtio_queue_packed_update_used_idx(VirtIODevice *vdev, int n)
 {
     /* used idx was updated through set_last_avail_idx() */
-    return;
 }
 
 static void virtio_queue_split_update_used_idx(VirtIODevice *vdev, int n)
diff --git a/hw/watchdog/sbsa_gwdt.c b/hw/watchdog/sbsa_gwdt.c
index 65ac42a187..1dd21392a9 100644
--- a/hw/watchdog/sbsa_gwdt.c
+++ b/hw/watchdog/sbsa_gwdt.c
@@ -174,7 +174,6 @@ static void sbsa_gwdt_write(void *opaque, hwaddr offset, uint64_t data,
         qemu_log_mask(LOG_GUEST_ERROR, "bad address in control frame write :"
                 " 0x%x\n", (int)offset);
     }
-    return;
 }
 
 static void wdt_sbsa_gwdt_reset(DeviceState *dev)
diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
index d94b83c109..a503b2aea7 100644
--- a/hw/watchdog/wdt_aspeed.c
+++ b/hw/watchdog/wdt_aspeed.c
@@ -225,7 +225,6 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
                       "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
     }
-    return;
 }
 
 static const VMStateDescription vmstate_aspeed_wdt = {
diff --git a/linux-user/xtensa/signal.c b/linux-user/xtensa/signal.c
index 6514b8dd57..ef8b0c3a27 100644
--- a/linux-user/xtensa/signal.c
+++ b/linux-user/xtensa/signal.c
@@ -241,7 +241,6 @@ void setup_rt_frame(int sig, struct target_sigaction *ka,
 
 give_sigsegv:
     force_sigsegv(sig);
-    return;
 }
 
 static void restore_sigcontext(CPUXtensaState *env,
diff --git a/migration/multifd-nocomp.c b/migration/multifd-nocomp.c
index ffe75256c9..d0f38b410c 100644
--- a/migration/multifd-nocomp.c
+++ b/migration/multifd-nocomp.c
@@ -82,7 +82,6 @@ static void multifd_nocomp_send_cleanup(MultiFDSendParams *p, Error **errp)
 {
     g_free(p->iov);
     p->iov = NULL;
-    return;
 }
 
 static void multifd_ram_prepare_header(MultiFDSendParams *p)
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 1303a5bf58..b6ac190034 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -561,8 +561,6 @@ void qemu_put_buffer_at(QEMUFile *f, const uint8_t *buf, size_t buflen,
     }
 
     stat64_add(&mig_stats.qemu_file_transferred, buflen);
-
-    return;
 }
 
 
diff --git a/migration/ram.c b/migration/ram.c
index 424df6d9f1..dc909f5eef 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3963,8 +3963,6 @@ static void parse_ramblock_mapped_ram(QEMUFile *f, RAMBlock *block,
 
     /* Skip pages array */
     qemu_set_offset(f, block->pages_offset + length, SEEK_SET);
-
-    return;
 }
 
 static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
diff --git a/net/colo-compare.c b/net/colo-compare.c
index 165610bfe2..893beed528 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -1328,8 +1328,6 @@ static void colo_compare_complete(UserCreatable *uc, Error **errp)
     }
     QTAILQ_INSERT_TAIL(&net_compares, s, next);
     qemu_mutex_unlock(&colo_compare_mutex);
-
-    return;
 }
 
 static void colo_flush_packets(void *opaque, void *user_data)
diff --git a/qemu-keymap.c b/qemu-keymap.c
index 6707067fea..1c081db287 100644
--- a/qemu-keymap.c
+++ b/qemu-keymap.c
@@ -116,7 +116,6 @@ static void walk_map(struct xkb_keymap *map, xkb_keycode_t code, void *data)
     if (kshift != kaltgrshift && kaltgr != kaltgrshift) {
         print_sym(kaltgrshift, qcode, " shift altgr");
     }
-    return;
 }
 
 static void usage(FILE *out)
diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 749fdf8895..d4482538ec 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -826,8 +826,6 @@ static void get_disk_properties(HANDLE vol_h, GuestDiskAddress *disk,
     }
 out_free:
     g_free(dev_desc);
-
-    return;
 }
 
 static void get_single_disk_info(int disk_number,
@@ -891,7 +889,6 @@ static void get_single_disk_info(int disk_number,
 
 err_close:
     CloseHandle(disk_h);
-    return;
 }
 
 /* VSS provider works with volumes, thus there is no difference if
@@ -2117,7 +2114,6 @@ static void ga_get_win_version(RTL_OSVERSIONINFOEXW *info, Error **errp)
 
     rtl_get_version_t rtl_get_version = (rtl_get_version_t)fun;
     rtl_get_version(info);
-    return;
 }
 
 static char *ga_get_win_name(const OSVERSIONINFOEXW *os_version, bool id)
diff --git a/system/dirtylimit.c b/system/dirtylimit.c
index 7dedef8dd4..1626fa5617 100644
--- a/system/dirtylimit.c
+++ b/system/dirtylimit.c
@@ -337,8 +337,6 @@ static void dirtylimit_adjust_throttle(CPUState *cpu)
     if (!dirtylimit_done(quota, current)) {
         dirtylimit_set_throttle(cpu, quota, current);
     }
-
-    return;
 }
 
 void dirtylimit_process(void)
diff --git a/target/arm/tcg/helper-a64.c b/target/arm/tcg/helper-a64.c
index 9244848efe..ad3c4f38a1 100644
--- a/target/arm/tcg/helper-a64.c
+++ b/target/arm/tcg/helper-a64.c
@@ -1147,7 +1147,6 @@ static void do_setp(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc,
     env->ZF = 1; /* our env->ZF encoding is inverted */
     env->CF = 0;
     env->VF = 0;
-    return;
 }
 
 void HELPER(setp)(CPUARMState *env, uint32_t syndrome, uint32_t mtedesc)
@@ -1547,7 +1546,6 @@ static void do_cpyp(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
     env->ZF = 1; /* our env->ZF encoding is inverted */
     env->CF = 0;
     env->VF = 0;
-    return;
 }
 
 void HELPER(cpyp)(CPUARMState *env, uint32_t syndrome, uint32_t wdesc,
diff --git a/target/i386/kvm/vmsr_energy.c b/target/i386/kvm/vmsr_energy.c
index 31508d4e77..4cd2dcfcf0 100644
--- a/target/i386/kvm/vmsr_energy.c
+++ b/target/i386/kvm/vmsr_energy.c
@@ -285,7 +285,6 @@ void vmsr_read_thread_stat(pid_t pid,
     }
 
     fclose(file);
-    return;
 }
 
 /* Read QEMU stat task folder to retrieve all QEMU threads ID */
diff --git a/target/i386/tcg/translate.c b/target/i386/tcg/translate.c
index a8935f487a..c777629a9d 100644
--- a/target/i386/tcg/translate.c
+++ b/target/i386/tcg/translate.c
@@ -3601,7 +3601,6 @@ static void gen_multi0F(DisasContext *s, X86DecodedInsn *decode)
     return;
  illegal_op:
     gen_illegal_opcode(s);
-    return;
 }
 
 #include "decode-new.c.inc"
diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 41fb8c5a4e..e44d044ecb 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -549,8 +549,6 @@ static void whpx_set_registers(CPUState *cpu, int level)
         error_report("WHPX: Failed to set virtual processor context, hr=%08lx",
                      hr);
     }
-
-    return;
 }
 
 static int whpx_get_tsc(CPUState *cpu)
@@ -771,8 +769,6 @@ static void whpx_get_registers(CPUState *cpu)
     }
 
     x86_update_hflags(env);
-
-    return;
 }
 
 static HRESULT CALLBACK whpx_emu_ioport_callback(
@@ -1570,8 +1566,6 @@ static void whpx_vcpu_pre_run(CPUState *cpu)
                          " hr=%08lx", hr);
         }
     }
-
-    return;
 }
 
 static void whpx_vcpu_post_run(CPUState *cpu)
@@ -1595,8 +1589,6 @@ static void whpx_vcpu_post_run(CPUState *cpu)
 
     vcpu->interruptable =
         !vcpu->exit_ctx.VpContext.ExecutionState.InterruptShadow;
-
-    return;
 }
 
 static void whpx_vcpu_process_async_events(CPUState *cpu)
@@ -1634,8 +1626,6 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
         apic_handle_tpr_access_report(x86_cpu->apic_state, env->eip,
                                       env->tpr_access_type);
     }
-
-    return;
 }
 
 static int whpx_vcpu_run(CPUState *cpu)
@@ -2280,7 +2270,6 @@ void whpx_destroy_vcpu(CPUState *cpu)
     whp_dispatch.WHvDeleteVirtualProcessor(whpx->partition, cpu->cpu_index);
     whp_dispatch.WHvEmulatorDestroyEmulator(vcpu->emulator);
     g_free(cpu->accel);
-    return;
 }
 
 void whpx_vcpu_kick(CPUState *cpu)
diff --git a/target/m68k/helper.c b/target/m68k/helper.c
index 0bf574830f..a37d3f6a96 100644
--- a/target/m68k/helper.c
+++ b/target/m68k/helper.c
@@ -290,7 +290,6 @@ void HELPER(m68k_movec_to)(CPUM68KState *env, uint32_t reg, uint32_t val)
 
     /* Invalid control registers will generate an exception. */
     raise_exception_ra(env, EXCP_ILLEGAL, 0);
-    return;
 }
 
 uint32_t HELPER(m68k_movec_from)(CPUM68KState *env, uint32_t reg)
diff --git a/target/mips/tcg/system/mips-semi.c b/target/mips/tcg/system/mips-semi.c
index df0c3256d9..e822a42614 100644
--- a/target/mips/tcg/system/mips-semi.c
+++ b/target/mips/tcg/system/mips-semi.c
@@ -374,5 +374,4 @@ void mips_semihosting(CPUMIPSState *env)
         error_report("Unknown UHI operation %d", op);
         abort();
     }
-    return;
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 992356cb75..80f6c185bc 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -1332,7 +1332,6 @@ int kvmppc_set_interrupt(PowerPCCPU *cpu, int irq, int level)
 
 void kvm_arch_pre_run(CPUState *cs, struct kvm_run *run)
 {
-    return;
 }
 
 MemTxAttrs kvm_arch_post_run(CPUState *cs, struct kvm_run *run)
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a52cbc869a..a9ff5020a2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -3627,7 +3627,6 @@ static void pmu_count_insns(DisasContext *ctx)
 #else
 static void pmu_count_insns(DisasContext *ctx)
 {
-    return;
 }
 #endif /* #if defined(TARGET_PPC64) */
 
diff --git a/target/riscv/debug.c b/target/riscv/debug.c
index 9db4048523..198d051521 100644
--- a/target/riscv/debug.c
+++ b/target/riscv/debug.c
@@ -551,8 +551,6 @@ static void type2_reg_write(CPURISCVState *env, target_ulong index,
     default:
         g_assert_not_reached();
     }
-
-    return;
 }
 
 /* type 6 trigger */
@@ -667,8 +665,6 @@ static void type6_reg_write(CPURISCVState *env, target_ulong index,
     default:
         g_assert_not_reached();
     }
-
-    return;
 }
 
 /* icount trigger type */
@@ -849,8 +845,6 @@ static void itrigger_reg_write(CPURISCVState *env, target_ulong index,
     default:
         g_assert_not_reached();
     }
-
-    return;
 }
 
 static int itrigger_get_adjust_count(CPURISCVState *env)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 93a05e43d7..8e0b01dc65 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -578,7 +578,6 @@ static void check_compat_model_failed(Error **errp,
     error_setg(errp, "%s. Maximum supported model in the current configuration: \'%s\'",
                msg, max_model->def->name);
     error_append_hint(errp, "Consider a different accelerator, try \"-accel help\"\n");
-    return;
 }
 
 static bool check_compatibility(const S390CPUModel *max_model,
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index bcdd558818..57b972e14f 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -1792,7 +1792,6 @@ static void _decode_opc(DisasContext * ctx)
         gen_helper_raise_fpu_disable(tcg_env);
     }
     ctx->base.is_jmp = DISAS_NORETURN;
-    return;
 }
 
 static void decode_opc(DisasContext * ctx)
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 88ac6c66ce..e8aabfc13f 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1881,7 +1881,6 @@ static void test_io_interface(gconstpointer opaque)
     sector = offset_sector(opts->offset, opts->address_type, bufsize);
     test_io_rw_interface(opts->address_type, opts->io_type, bufsize, sector);
     g_free(opts);
-    return;
 }
 
 static void create_ahci_io_test(enum IOMode type, enum AddrMode addr,
diff --git a/tests/qtest/fuzz/generic_fuzz.c b/tests/qtest/fuzz/generic_fuzz.c
index d107a496da..b42473d1ce 100644
--- a/tests/qtest/fuzz/generic_fuzz.c
+++ b/tests/qtest/fuzz/generic_fuzz.c
@@ -572,7 +572,6 @@ static void op_add_dma_pattern(QTestState *s,
     pattern p = {a.index, a.stride, len - sizeof(a), data + sizeof(a)};
     p.index = a.index % p.len;
     g_array_append_val(dma_patterns, p);
-    return;
 }
 
 static void op_clear_dma_patterns(QTestState *s,
diff --git a/tests/qtest/libqos/libqos-malloc.c b/tests/qtest/libqos/libqos-malloc.c
index d7566972c4..c90f8f03f4 100644
--- a/tests/qtest/libqos/libqos-malloc.c
+++ b/tests/qtest/libqos/libqos-malloc.c
@@ -342,5 +342,4 @@ void migrate_allocator(QGuestAllocator *src,
     QTAILQ_INIT(src->free);
     node = mlist_new(src->start, src->end - src->start);
     QTAILQ_INSERT_HEAD(src->free, node, MLIST_ENTNAME);
-    return;
 }
diff --git a/tests/qtest/libqtest.c b/tests/qtest/libqtest.c
index 2750067861..155250b8a2 100644
--- a/tests/qtest/libqtest.c
+++ b/tests/qtest/libqtest.c
@@ -2021,7 +2021,6 @@ void qtest_client_inproc_recv(void *opaque, const char *str)
         qts->rx = g_string_new(NULL);
     }
     g_string_append(qts->rx, str);
-    return;
 }
 
 void qtest_qom_set_bool(QTestState *s, const char *path, const char *property,
diff --git a/tests/qtest/test-x86-cpuid-compat.c b/tests/qtest/test-x86-cpuid-compat.c
index b9603d46fa..c9de47bb26 100644
--- a/tests/qtest/test-x86-cpuid-compat.c
+++ b/tests/qtest/test-x86-cpuid-compat.c
@@ -193,7 +193,6 @@ static void add_feature_test(const char *name, const char *cpu,
     args->bitnr = bitnr;
     args->expected_value = expected_value;
     qtest_add_data_func(name, args, test_feature_flag);
-    return;
 }
 
 static void test_plus_minus_subprocess(void)
diff --git a/tests/unit/socket-helpers.c b/tests/unit/socket-helpers.c
index f3439cc4e5..37db24f72a 100644
--- a/tests/unit/socket-helpers.c
+++ b/tests/unit/socket-helpers.c
@@ -170,5 +170,4 @@ void socket_check_afunix_support(bool *has_afunix)
     if (*has_afunix) {
         close(fd);
     }
-    return;
 }
diff --git a/tests/unit/test-qgraph.c b/tests/unit/test-qgraph.c
index 334c76c8e7..ca1d60fc18 100644
--- a/tests/unit/test-qgraph.c
+++ b/tests/unit/test-qgraph.c
@@ -44,7 +44,6 @@ static void *driverfunct(void *obj, QGuestAllocator *machine, void *arg)
 
 static void testfunct(void *obj, void *arg, QGuestAllocator *alloc)
 {
-    return;
 }
 
 static void check_interface(const char *interface)
diff --git a/ui/input-linux.c b/ui/input-linux.c
index 381148ea99..203e264212 100644
--- a/ui/input-linux.c
+++ b/ui/input-linux.c
@@ -412,7 +412,6 @@ err_read_event_bits:
 
 err_close:
     close(il->fd);
-    return;
 }
 
 static void input_linux_instance_finalize(Object *obj)
diff --git a/ui/vnc.c b/ui/vnc.c
index 9241caaad9..9e097dc4b4 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -146,8 +146,6 @@ static void vnc_init_basic_info(SocketAddress *addr,
     default:
         abort();
     }
-
-    return;
 }
 
 static void vnc_init_basic_info_from_server_addr(QIOChannelSocket *ioc,
diff --git a/util/main-loop.c b/util/main-loop.c
index acad8c2e6c..979db51a1f 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -212,7 +212,6 @@ static void main_loop_init(EventLoopBase *base, Error **errp)
     main_loop_update_params(base, errp);
 
     mloop = m;
-    return;
 }
 
 static bool main_loop_can_be_deleted(EventLoopBase *base)
diff --git a/util/qht.c b/util/qht.c
index 92c6b78759..208c2f4b32 100644
--- a/util/qht.c
+++ b/util/qht.c
@@ -367,7 +367,6 @@ void qht_map_lock_buckets__no_stale(struct qht *ht, struct qht_map **pmap)
     qht_map_lock_buckets(map);
     qht_unlock(ht);
     *pmap = map;
-    return;
 }
 
 /*
-- 
2.48.1


