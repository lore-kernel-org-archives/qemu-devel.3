Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D65B5C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 15:23:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuvFN-00017l-Kl; Wed, 19 Mar 2025 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvEs-00011a-2S
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuvEi-0001OA-PJ
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 11:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742397697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=sI9i6BS9A/8rT/6dh0H1QHyyXfbAZK6IhDA7ZBzZlxM=;
 b=fxgLwCK3ch7xh/XMKvRWnzXw25KpG42mLqI26NrjomE0XzMbsu+hkZUAzyWlRyeOZj+Eyr
 wgIkzABJeK3kuiJBQ5P5dF1mOK3EJtPBrnEIMocB06koWykKGglqKFbBlvXotdfe/QAT9s
 Otga9Cu2smdY7TXRW4Sx1CUXC9NxbJY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-FB7WaXoJMr-tVWjSt15hvg-1; Wed,
 19 Mar 2025 11:21:35 -0400
X-MC-Unique: FB7WaXoJMr-tVWjSt15hvg-1
X-Mimecast-MFC-AGG-ID: FB7WaXoJMr-tVWjSt15hvg_1742397694
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B8CF19560B8
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:33 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 210D21828A83
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 15:21:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2131521E66C4; Wed, 19 Mar 2025 16:21:26 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/3] Cleanups around returns
Date: Wed, 19 Mar 2025 16:21:23 +0100
Message-ID: <20250319152126.3472290-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Markus Armbruster (3):
  cleanup: Re-run return_directly.cocci
  cleanup: Drop pointless return at end of function
  cleanup: Drop pointless label at end of function

 include/system/os-win32.h                     |  1 -
 target/ppc/kvm_ppc.h                          |  3 ---
 accel/tcg/cpu-exec.c                          |  1 -
 block/gluster.c                               |  4 ---
 block/rbd.c                                   |  1 -
 block/replication.c                           |  1 -
 block/throttle-groups.c                       |  1 -
 bsd-user/signal.c                             |  1 -
 dump/win_dump.c                               |  2 --
 event-loop-base.c                             |  2 --
 hw/acpi/acpi-cpu-hotplug-stub.c               |  8 ------
 hw/acpi/acpi-mem-hotplug-stub.c               |  5 ----
 hw/acpi/acpi-nvdimm-stub.c                    |  1 -
 hw/acpi/acpi-pci-hotplug-stub.c               |  6 -----
 hw/arm/exynos4210.c                           |  1 -
 hw/arm/smmu-common.c                          |  1 -
 hw/arm/xen-stubs.c                            |  1 -
 hw/audio/asc.c                                |  1 -
 hw/core/qdev-properties-system.c              |  1 -
 hw/cxl/cxl-host.c                             |  2 --
 hw/display/macfb.c                            |  1 -
 hw/display/tcx.c                              |  1 -
 hw/display/virtio-gpu-base.c                  |  1 -
 hw/dma/sifive_pdma.c                          |  1 -
 hw/gpio/aspeed_gpio.c                         |  5 ----
 hw/gpio/bcm2838_gpio.c                        |  1 -
 hw/gpio/imx_gpio.c                            |  2 --
 hw/gpio/pca9554.c                             |  5 +---
 hw/gpio/pl061.c                               |  1 -
 hw/hyperv/vmbus.c                             |  1 -
 hw/i2c/pm_smbus.c                             |  1 -
 hw/i386/intel_iommu.c                         |  2 --
 hw/i386/kvm/xen_xenstore.c                    |  4 +--
 hw/i386/nitro_enclave.c                       |  1 -
 hw/i386/xen/xen-hvm.c                         |  2 --
 hw/input/virtio-input-host.c                  |  1 -
 hw/intc/arm_gicv3_cpuif.c                     |  1 -
 hw/intc/aspeed_intc.c                         |  4 ---
 hw/intc/mips_gic.c                            |  1 -
 hw/ipmi/ipmi_bmc_extern.c                     |  6 +----
 hw/ipmi/ipmi_bmc_sim.c                        |  9 ++-----
 hw/ipmi/ipmi_bt.c                             |  8 +++---
 hw/ipmi/ipmi_kcs.c                            |  4 +--
 hw/loongarch/virt.c                           |  3 ---
 hw/m68k/next-cube.c                           |  1 -
 hw/m68k/q800.c                                |  2 --
 hw/mem/cxl_type3.c                            |  4 ---
 hw/mem/sparse-mem.c                           |  1 -
 hw/misc/i2c-echo.c                            |  2 --
 hw/misc/ivshmem-flat.c                        |  2 --
 hw/misc/mips_cpc.c                            |  2 --
 hw/net/can/ctucan_core.c                      |  2 --
 hw/net/can/xlnx-versal-canfd.c                |  2 --
 hw/net/imx_fec.c                              |  1 -
 hw/net/vmxnet3.c                              |  1 -
 hw/nvram/xlnx-versal-efuse-ctrl.c             |  1 -
 hw/ppc/mac_newworld.c                         |  2 --
 hw/ppc/pnv_occ.c                              |  1 -
 hw/ppc/spapr_hcall.c                          |  1 -
 hw/ppc/spapr_nested.c                         |  1 -
 hw/ppc/spapr_nvdimm.c                         |  2 --
 hw/riscv/virt.c                               | 25 ++++++++-----------
 hw/s390x/s390-pci-bus.c                       |  1 -
 hw/s390x/s390-pci-vfio.c                      |  2 --
 hw/scsi/esp.c                                 |  5 +---
 hw/scsi/megasas.c                             |  1 -
 hw/scsi/vhost-scsi.c                          |  1 -
 hw/ssi/ibex_spi_host.c                        |  1 -
 hw/ssi/pnv_spi.c                              |  2 --
 hw/tpm/tpm_tis_i2c.c                          |  4 ---
 hw/usb/dev-mtp.c                              |  2 --
 hw/usb/dev-serial.c                           |  2 --
 hw/usb/dev-smartcard-reader.c                 |  1 -
 hw/usb/dev-uas.c                              |  1 -
 hw/vfio/common.c                              |  7 ++----
 hw/vfio/display.c                             |  1 -
 hw/vfio/pci.c                                 |  1 -
 hw/vfio/platform.c                            |  1 -
 hw/virtio/vhost-user-fs.c                     |  1 -
 hw/virtio/vhost-user-scmi.c                   |  2 --
 hw/virtio/vhost-user-vsock.c                  |  1 -
 hw/virtio/vhost-user.c                        |  2 --
 hw/virtio/vhost-vdpa.c                        |  2 --
 hw/virtio/vhost.c                             |  1 -
 hw/virtio/virtio-nsm.c                        |  1 -
 hw/virtio/virtio.c                            |  2 --
 hw/watchdog/sbsa_gwdt.c                       |  1 -
 hw/watchdog/wdt_aspeed.c                      |  1 -
 linux-user/xtensa/signal.c                    |  1 -
 migration/multifd-nocomp.c                    |  1 -
 migration/qemu-file.c                         |  2 --
 migration/ram.c                               |  2 --
 net/colo-compare.c                            |  2 --
 plugins/api.c                                 |  4 +--
 qemu-keymap.c                                 |  1 -
 qga/commands-win32.c                          |  4 ---
 system/dirtylimit.c                           |  2 --
 target/arm/tcg/helper-a64.c                   |  2 --
 target/i386/kvm/vmsr_energy.c                 |  1 -
 target/i386/tcg/translate.c                   |  1 -
 target/i386/whpx/whpx-all.c                   | 11 --------
 target/loongarch/tcg/tlb_helper.c             |  5 ++--
 target/m68k/helper.c                          |  1 -
 target/mips/tcg/system/mips-semi.c            |  1 -
 target/ppc/kvm.c                              |  1 -
 target/ppc/translate.c                        |  1 -
 target/riscv/debug.c                          |  6 -----
 target/s390x/cpu_models.c                     |  1 -
 target/sh4/translate.c                        |  1 -
 tests/qtest/ahci-test.c                       |  1 -
 tests/qtest/cmsdk-apb-watchdog-test.c         |  6 +----
 tests/qtest/fuzz/generic_fuzz.c               |  1 -
 tests/qtest/libqos/libqos-malloc.c            |  1 -
 tests/qtest/libqtest.c                        |  1 -
 tests/qtest/pnv-host-i2c-test.c               |  4 +--
 tests/qtest/stm32l4x5_usart-test.c            |  6 +----
 tests/qtest/test-x86-cpuid-compat.c           |  1 -
 .../user/ase/msa/bit-count/test_msa_nloc_b.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nloc_d.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nloc_h.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nloc_w.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_b.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_d.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_h.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_nlzc_w.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_b.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_d.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_h.c  |  9 +++----
 .../user/ase/msa/bit-count/test_msa_pcnt_w.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_b.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_d.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_h.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsl_w.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_b.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_d.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_h.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_binsr_w.c  |  9 +++----
 .../user/ase/msa/bit-move/test_msa_bmnz_v.c   |  9 +++----
 .../user/ase/msa/bit-move/test_msa_bmz_v.c    |  9 +++----
 .../user/ase/msa/bit-move/test_msa_bsel_v.c   |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_b.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_d.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_h.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bclr_w.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_b.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_d.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_h.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bneg_w.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_b.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_d.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_h.c    |  9 +++----
 .../user/ase/msa/bit-set/test_msa_bset_w.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_madd_q_h.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_madd_q_w.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_maddr_q_h.c   |  9 +++----
 .../msa/fixed-multiply/test_msa_maddr_q_w.c   |  9 +++----
 .../msa/fixed-multiply/test_msa_msub_q_h.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_msub_q_w.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_msubr_q_h.c   |  9 +++----
 .../msa/fixed-multiply/test_msa_msubr_q_w.c   |  9 +++----
 .../ase/msa/fixed-multiply/test_msa_mul_q_h.c |  9 +++----
 .../ase/msa/fixed-multiply/test_msa_mul_q_w.c |  9 +++----
 .../msa/fixed-multiply/test_msa_mulr_q_h.c    |  9 +++----
 .../msa/fixed-multiply/test_msa_mulr_q_w.c    |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_a_d.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_a_w.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_d.c   |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmax_w.c   |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_a_d.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_a_w.c |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_d.c   |  9 +++----
 .../ase/msa/float-max-min/test_msa_fmin_w.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_b.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_d.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_h.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_add_a_w.c   |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_b.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_a_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_b.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_s_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_b.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_adds_u_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_b.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_d.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_h.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_addv_w.c    |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_s_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_s_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_s_w.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_u_d.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_u_h.c  |  9 +++----
 .../user/ase/msa/int-add/test_msa_hadd_u_w.c  |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_b.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_d.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_h.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_s_w.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_b.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_d.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_h.c    |  9 +++----
 .../ase/msa/int-average/test_msa_ave_u_w.c    |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_b.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_d.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_h.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_s_w.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_b.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_d.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_h.c   |  9 +++----
 .../ase/msa/int-average/test_msa_aver_u_w.c   |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_b.c |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_d.c |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_h.c |  9 +++----
 .../user/ase/msa/int-compare/test_msa_ceq_w.c |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_s_w.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_cle_u_w.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_s_w.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_b.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_d.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_h.c    |  9 +++----
 .../ase/msa/int-compare/test_msa_clt_u_w.c    |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_b.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_d.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_h.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_s_w.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_b.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_d.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_h.c     |  9 +++----
 .../ase/msa/int-divide/test_msa_div_u_w.c     |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_s_d.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_s_h.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_s_w.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_u_d.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_u_h.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dotp_u_w.c   |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_s_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_s_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_s_w.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_u_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_u_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpadd_u_w.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_s_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_s_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_s_w.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_u_d.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_u_h.c  |  9 +++----
 .../msa/int-dot-product/test_msa_dpsub_u_w.c  |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_a_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_s_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_max_u_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_a_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_s_w.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_b.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_d.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_h.c    |  9 +++----
 .../ase/msa/int-max-min/test_msa_min_u_w.c    |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_b.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_d.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_h.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_s_w.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_b.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_d.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_h.c     |  9 +++----
 .../ase/msa/int-modulo/test_msa_mod_u_w.c     |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_b.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_d.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_h.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_maddv_w.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_b.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_d.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_h.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_msubv_w.c   |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_b.c    |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_d.c    |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_h.c    |  9 +++----
 .../ase/msa/int-multiply/test_msa_mulv_w.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_s_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_asub_u_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_s_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_s_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_s_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_u_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_u_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_hsub_u_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_s_w.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_b.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_d.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_h.c  |  9 +++----
 .../ase/msa/int-subtract/test_msa_subs_u_w.c  |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_b.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_d.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_h.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsus_u_w.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_b.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_d.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_h.c    |  9 +++----
 .../msa/int-subtract/test_msa_subsuu_s_w.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_b.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_d.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_h.c    |  9 +++----
 .../ase/msa/int-subtract/test_msa_subv_w.c    |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_b.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_d.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_h.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvev_w.c     |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_b.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_d.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_h.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvl_w.c |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_b.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_d.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_h.c     |  9 +++----
 .../ase/msa/interleave/test_msa_ilvod_w.c     |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_b.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_d.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_h.c |  9 +++----
 .../user/ase/msa/interleave/test_msa_ilvr_w.c |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_and_v.c  |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_nor_v.c  |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_or_v.c   |  9 +++----
 .../mips/user/ase/msa/logic/test_msa_xor_v.c  |  9 +++----
 .../mips/user/ase/msa/move/test_msa_move_v.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_b.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_d.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_h.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckev_w.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_b.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_d.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_h.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_pckod_w.c |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_b.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_d.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_h.c  |  9 +++----
 .../mips/user/ase/msa/pack/test_msa_vshf_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_b.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_d.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_h.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sll_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_b.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_d.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_h.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_sra_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_b.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_d.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_h.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srar_w.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_b.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_d.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_h.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srl_w.c  |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_b.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_d.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_h.c |  9 +++----
 .../mips/user/ase/msa/shift/test_msa_srlr_w.c |  9 +++----
 .../mips64r6/bit-count/test_mips64r6_clo.c    |  7 ++----
 .../mips64r6/bit-count/test_mips64r6_clz.c    |  7 ++----
 .../mips64r6/bit-count/test_mips64r6_dclo.c   |  7 ++----
 .../mips64r6/bit-count/test_mips64r6_dclz.c   |  7 ++----
 .../mips64r6/bit-swap/test_mips64r6_bitswap.c |  7 ++----
 .../bit-swap/test_mips64r6_dbitswap.c         |  7 ++----
 .../int-multiply/test_mips64r6_dmuh.c         |  7 ++----
 .../int-multiply/test_mips64r6_dmuhu.c        |  7 ++----
 .../int-multiply/test_mips64r6_dmul.c         |  7 ++----
 .../int-multiply/test_mips64r6_dmulu.c        |  7 ++----
 .../mips64r6/int-multiply/test_mips64r6_muh.c |  7 ++----
 .../int-multiply/test_mips64r6_muhu.c         |  7 ++----
 .../mips64r6/int-multiply/test_mips64r6_mul.c |  7 ++----
 .../int-multiply/test_mips64r6_mulu.c         |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_and.c    |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_nor.c    |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_or.c     |  7 ++----
 .../isa/mips64r6/logic/test_mips64r6_xor.c    |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_dsllv.c  |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_dsrav.c  |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_dsrlv.c  |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_sllv.c   |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_srav.c   |  7 ++----
 .../isa/mips64r6/shift/test_mips64r6_srlv.c   |  7 ++----
 tests/unit/socket-helpers.c                   |  1 -
 tests/unit/test-qgraph.c                      |  1 -
 tools/i386/qemu-vmsr-helper.c                 |  5 +---
 ui/input-linux.c                              |  1 -
 ui/vnc.c                                      |  2 --
 util/main-loop.c                              |  1 -
 util/qht.c                                    |  1 -
 422 files changed, 899 insertions(+), 2029 deletions(-)

-- 
2.48.1


