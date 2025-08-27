Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAA7CA0FF6
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Aug 2025 07:56:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urAzr-00058W-Eh; Wed, 27 Aug 2025 03:55:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urAzp-000589-8b
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urAzj-0001hs-1d
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281294;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6mrGWLORdsHm0UvZI037ZS4U5gfb7DYYHfKaX7tajbo=;
 b=MZBHOFN3GguruImgW+i46coW7YpScVPmvioAvDX0JsN/A3OgliowNkeAwf520t5OyiFbhe
 J0Q3RVHGjPJ0kSPB/jzGXS2jrYBjOc60NSK3Up3AmhRg9I9vPvWu01hRGtBvkU8nW+2Ump
 CZEjQgv0PWZsJ9krdeeTo/HO5b94nrM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-637-I9EaovwfM62C2oc-GQ2nrw-1; Wed,
 27 Aug 2025 03:54:49 -0400
X-MC-Unique: I9EaovwfM62C2oc-GQ2nrw-1
X-Mimecast-MFC-AGG-ID: I9EaovwfM62C2oc-GQ2nrw_1756281288
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F2421800352; Wed, 27 Aug 2025 07:54:48 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C72C11955F24; Wed, 27 Aug 2025 07:54:45 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/31] First pull request with functional tests patches for
 QEMU 10.2
Date: Wed, 27 Aug 2025 09:54:10 +0200
Message-ID: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
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

 Hi!

The following changes since commit 88f72048d2f5835a1b9eaba690c7861393aef283:

  Update version for the v10.1.0-rc4 release (2025-08-19 14:05:56 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-08-27

for you to fetch changes up to 0ac3c314130eff8e3ea9860fe3202908a7746225:

  tests/functional: Mark main in QemuBaseTest class as a static method (2025-08-27 09:46:55 +0200)

----------------------------------------------------------------
* Add v10.2 compat machines
* Move functional tests to target specific subfolders
* Fix some issues in functional tests

----------------------------------------------------------------
Cornelia Huck (1):
      hw: add compat machines for 10.2

Gustavo Romero (2):
      tests/functional: Fix reverse_debugging asset precaching
      tests/functional: Mark main in QemuBaseTest class as a static method

Peter Maydell (1):
      tests/functional/test_aarch64_virt_gpu: Skip test if EGL won't initialize

Stefan Weil (1):
      CI: Use mingw-w64-x86_64-curl-winssl instead of mingw-w64-x86_64-curl for Windows build

Thomas Huth (26):
      tests/functional: Use more fine-grained locking when looking for free ports
      tests/functional: Rework the migration test to have target-specific files
      tests/functional: Rework the multiprocess test to have target-specific files
      tests/functional/meson.build: Split timeout settings by target
      tests/functional/meson.build: Allow tests to reside in subfolders
      tests/functional: Move aarch64 tests into architecture specific folder
      tests/functional: Move alpha tests into architecture specific folder
      tests/functional: Move arm tests into architecture specific folder
      tests/functional: Move avr tests into architecture specific folder
      tests/functional: Move hppa tests into architecture specific folder
      tests/functional: Move i386 tests into architecture specific folder
      tests/functional: Move loongarch64 tests into architecture specific folder
      tests/functional: Move m68k tests into architecture specific folder
      tests/functional: Move microblaze tests into architecture specific folder
      tests/functional: Move mips tests into target-specific folders
      tests/functional: Move or1k tests into target-specific folders
      tests/functional: Move ppc/ppc64 tests into target-specific folders
      tests/functional: Move riscv32/riscv64 tests into target-specific folders
      tests/functional: Move rx test into target-specific folders
      tests/functional: Move s390x tests into target-specific folders
      tests/functional: Move sh4/sh4eb tests into target-specific folders
      tests/functional: Move sparc/sparc64 tests into target-specific folders
      tests/functional: Move x86_64 tests into target-specific folder
      tests/functional: Move xtensa tests into target-specific folder
      tests/functional: Move the generic tests to a subfolder
      MAINTAINERS: Adjust wildcards for the migration, multiprocess and replay tests

 MAINTAINERS                                        | 203 +++++------
 include/hw/boards.h                                |   3 +
 include/hw/i386/pc.h                               |   3 +
 hw/arm/virt.c                                      |   9 +-
 hw/core/machine.c                                  |   3 +
 hw/i386/pc.c                                       |   3 +
 hw/i386/pc_piix.c                                  |  13 +-
 hw/i386/pc_q35.c                                   |  13 +-
 hw/m68k/virt.c                                     |   9 +-
 hw/ppc/spapr.c                                     |  15 +-
 hw/s390x/s390-virtio-ccw.c                         |  14 +-
 .gitlab-ci.d/windows.yml                           |   2 +-
 tests/functional/aarch64/meson.build               |  48 +++
 .../test_aspeed_ast2700.py}                        |   0
 .../test_aspeed_ast2700fc.py}                      |   0
 .../test_device_passthrough.py}                    |   0
 .../test_hotplug_pci.py}                           |   0
 .../test_imx8mp_evk.py}                            |   0
 .../{test_aarch64_kvm.py => aarch64/test_kvm.py}   |   0
 tests/functional/aarch64/test_migration.py         |  26 ++
 tests/functional/aarch64/test_multiprocess.py      |  31 ++
 .../test_raspi3.py}                                |   0
 .../test_raspi4.py}                                |   0
 .../test_replay.py}                                |   0
 .../test_reverse_debug.py}                         |   4 +-
 .../test_rme_sbsaref.py}                           |   2 +-
 .../test_rme_virt.py}                              |   0
 .../test_sbsaref.py}                               |   0
 .../test_sbsaref_alpine.py}                        |   2 +-
 .../test_sbsaref_freebsd.py}                       |   2 +-
 .../{test_aarch64_smmu.py => aarch64/test_smmu.py} |   0
 .../test_tcg_plugins.py}                           |   0
 .../test_tuxrun.py}                                |   0
 .../{test_aarch64_virt.py => aarch64/test_virt.py} |   0
 .../test_virt_gpu.py}                              |   2 +
 .../{test_aarch64_xen.py => aarch64/test_xen.py}   |   0
 .../test_xlnx_versal.py}                           |   0
 tests/functional/alpha/meson.build                 |  10 +
 .../test_clipper.py}                               |   0
 tests/functional/alpha/test_migration.py           |  26 ++
 .../{test_alpha_replay.py => alpha/test_replay.py} |   0
 tests/functional/arm/meson.build                   |  62 ++++
 .../test_aspeed_ast1030.py}                        |   0
 .../test_aspeed_ast2500.py}                        |   0
 .../test_aspeed_ast2600.py}                        |   0
 .../test_aspeed_bletchley.py}                      |   0
 .../test_aspeed_catalina.py}                       |   0
 .../test_aspeed_gb200nvl_bmc.py}                   |   0
 .../test_aspeed_palmetto.py}                       |   0
 .../test_aspeed_rainier.py}                        |   0
 .../test_aspeed_romulus.py}                        |   0
 .../test_aspeed_witherspoon.py}                    |   0
 .../{test_arm_bflt.py => arm/test_bflt.py}         |   0
 .../{test_arm_bpim2u.py => arm/test_bpim2u.py}     |   0
 .../test_canona1100.py}                            |   0
 .../{test_arm_collie.py => arm/test_collie.py}     |   0
 .../test_cubieboard.py}                            |   0
 .../test_emcraft_sf2.py}                           |   0
 .../test_integratorcp.py}                          |   0
 .../test_max78000fthr.py}                          |   0
 .../{test_arm_microbit.py => arm/test_microbit.py} |   0
 tests/functional/arm/test_migration.py             |  26 ++
 .../{test_arm_orangepi.py => arm/test_orangepi.py} |   0
 .../test_quanta_gsj.py}                            |   0
 .../{test_arm_raspi2.py => arm/test_raspi2.py}     |   0
 .../{test_arm_realview.py => arm/test_realview.py} |   0
 .../{test_arm_replay.py => arm/test_replay.py}     |   0
 .../{test_arm_smdkc210.py => arm/test_smdkc210.py} |   0
 .../test_stellaris.py}                             |   0
 .../{test_arm_sx1.py => arm/test_sx1.py}           |   0
 .../{test_arm_tuxrun.py => arm/test_tuxrun.py}     |   0
 .../{test_arm_vexpress.py => arm/test_vexpress.py} |   0
 .../{test_arm_virt.py => arm/test_virt.py}         |   0
 tests/functional/avr/meson.build                   |   6 +
 .../{test_avr_mega2560.py => avr/test_mega2560.py} |   0
 .../{test_avr_uno.py => avr/test_uno.py}           |   0
 tests/functional/generic/meson.build               |  14 +
 .../{ => generic}/test_empty_cpu_model.py          |   0
 .../functional/{ => generic}/test_info_usernet.py  |   0
 tests/functional/{ => generic}/test_version.py     |   0
 tests/functional/{ => generic}/test_vnc.py         |   0
 tests/functional/hppa/meson.build                  |   5 +
 .../{test_hppa_seabios.py => hppa/test_seabios.py} |   0
 tests/functional/i386/meson.build                  |  10 +
 tests/functional/i386/test_migration.py            |  26 ++
 .../{test_i386_replay.py => i386/test_replay.py}   |   0
 .../{test_i386_tuxrun.py => i386/test_tuxrun.py}   |   0
 tests/functional/loongarch64/meson.build           |   5 +
 .../test_virt.py}                                  |   0
 tests/functional/m68k/meson.build                  |   9 +
 .../test_mcf5208evb.py}                            |   0
 .../test_nextcube.py}                              |   0
 .../{test_m68k_q800.py => m68k/test_q800.py}       |   0
 .../{test_m68k_replay.py => m68k/test_replay.py}   |   0
 .../{test_m68k_tuxrun.py => m68k/test_tuxrun.py}   |   0
 tests/functional/meson.build                       | 382 +++------------------
 tests/functional/microblaze/meson.build            |   6 +
 .../test_replay.py}                                |   0
 .../test_s3adsp1800.py}                            |   0
 tests/functional/microblazeel/meson.build          |   5 +
 .../test_s3adsp1800.py}                            |   2 +-
 .../functional/{test_migration.py => migration.py} |  35 +-
 tests/functional/mips/meson.build                  |  11 +
 .../{test_mips_malta.py => mips/test_malta.py}     |   0
 .../{test_mips_replay.py => mips/test_replay.py}   |   0
 .../{test_mips_tuxrun.py => mips/test_tuxrun.py}   |   0
 tests/functional/mips64/meson.build                |  10 +
 .../{test_mips64_malta.py => mips64/test_malta.py} |   2 +-
 .../test_tuxrun.py}                                |   0
 tests/functional/mips64el/meson.build              |  14 +
 .../test_fuloong2e.py}                             |   0
 .../test_loongson3v.py}                            |   0
 .../test_malta.py}                                 |   4 +-
 .../test_replay.py}                                |   0
 .../test_tuxrun.py}                                |   0
 tests/functional/mipsel/meson.build                |  12 +
 .../{test_mipsel_malta.py => mipsel/test_malta.py} |   2 +-
 .../test_replay.py}                                |   0
 .../test_tuxrun.py}                                |   0
 .../{test_multiprocess.py => multiprocess.py}      |  40 +--
 tests/functional/or1k/meson.build                  |   6 +
 .../{test_or1k_replay.py => or1k/test_replay.py}   |   0
 .../{test_or1k_sim.py => or1k/test_sim.py}         |   0
 tests/functional/ppc/meson.build                   |  22 ++
 .../{test_ppc_40p.py => ppc/test_40p.py}           |   0
 .../{test_ppc_74xx.py => ppc/test_74xx.py}         |   0
 .../{test_ppc_amiga.py => ppc/test_amiga.py}       |   0
 .../{test_ppc_bamboo.py => ppc/test_bamboo.py}     |   0
 .../{test_ppc_mac.py => ppc/test_mac.py}           |   0
 tests/functional/ppc/test_migration.py             |  26 ++
 .../test_mpc8544ds.py}                             |   0
 .../{test_ppc_replay.py => ppc/test_replay.py}     |   0
 .../{test_ppc_sam460ex.py => ppc/test_sam460ex.py} |   0
 .../{test_ppc_tuxrun.py => ppc/test_tuxrun.py}     |   0
 .../test_virtex_ml507.py}                          |   0
 tests/functional/ppc64/meson.build                 |  25 ++
 .../{test_ppc64_e500.py => ppc64/test_e500.py}     |   0
 .../{test_ppc64_hv.py => ppc64/test_hv.py}         |   0
 .../{test_ppc64_mac99.py => ppc64/test_mac99.py}   |   0
 tests/functional/ppc64/test_migration.py           |  26 ++
 .../test_powernv.py}                               |   0
 .../test_pseries.py}                               |   0
 .../{test_ppc64_replay.py => ppc64/test_replay.py} |   0
 .../test_reverse_debug.py}                         |   0
 .../{test_ppc64_tuxrun.py => ppc64/test_tuxrun.py} |   0
 tests/functional/qemu_test/ports.py                |   5 +-
 tests/functional/qemu_test/testcase.py             |   1 +
 tests/functional/riscv32/meson.build               |  10 +
 tests/functional/riscv32/test_migration.py         |  26 ++
 tests/functional/riscv32/test_opensbi.py           |  10 +
 .../test_tuxrun.py}                                |   0
 tests/functional/riscv64/meson.build               |  15 +
 tests/functional/riscv64/test_migration.py         |  26 ++
 .../test_opensbi.py}                               |   0
 .../test_sifive_u.py}                              |   0
 .../test_tuxrun.py}                                |   0
 tests/functional/rx/meson.build                    |   5 +
 .../{test_rx_gdbsim.py => rx/test_gdbsim.py}       |   0
 tests/functional/s390x/meson.build                 |  13 +
 .../test_ccw_virtio.py}                            |   0
 .../test_pxelinux.py}                              |   0
 .../{test_s390x_replay.py => s390x/test_replay.py} |   0
 .../test_topology.py}                              |   0
 .../{test_s390x_tuxrun.py => s390x/test_tuxrun.py} |   0
 tests/functional/sh4/meson.build                   |  10 +
 .../{test_sh4_r2d.py => sh4/test_r2d.py}           |   0
 .../{test_sh4_tuxrun.py => sh4/test_tuxrun.py}     |   0
 tests/functional/sh4eb/meson.build                 |   5 +
 .../{test_sh4eb_r2d.py => sh4eb/test_r2d.py}       |   0
 tests/functional/sparc/meson.build                 |  10 +
 tests/functional/sparc/test_migration.py           |  26 ++
 .../{test_sparc_replay.py => sparc/test_replay.py} |   0
 .../{test_sparc_sun4m.py => sparc/test_sun4m.py}   |   0
 tests/functional/sparc64/meson.build               |  10 +
 tests/functional/sparc64/test_migration.py         |  26 ++
 .../test_sun4u.py}                                 |   0
 .../test_tuxrun.py}                                |   0
 tests/functional/x86_64/meson.build                |  36 ++
 tests/functional/{ => x86_64}/test_acpi_bits.py    |   0
 .../test_cpu_model_versions.py}                    |   0
 tests/functional/{ => x86_64}/test_cpu_queries.py  |   0
 .../test_hotplug_blk.py}                           |   0
 .../test_hotplug_cpu.py}                           |   0
 tests/functional/{ => x86_64}/test_intel_iommu.py  |   0
 .../test_kvm_xen.py}                               |   0
 tests/functional/{ => x86_64}/test_linux_initrd.py |   0
 .../functional/{ => x86_64}/test_mem_addr_space.py |   0
 tests/functional/{ => x86_64}/test_memlock.py      |   0
 tests/functional/x86_64/test_migration.py          |  26 ++
 tests/functional/x86_64/test_multiprocess.py       |  31 ++
 .../functional/{ => x86_64}/test_netdev_ethtool.py |   0
 .../{ => x86_64}/test_pc_cpu_hotplug_props.py      |   0
 .../test_replay.py}                                |   0
 .../test_reverse_debug.py}                         |   0
 .../test_tuxrun.py}                                |   0
 .../functional/{ => x86_64}/test_virtio_balloon.py |   0
 tests/functional/{ => x86_64}/test_virtio_gpu.py   |   0
 .../functional/{ => x86_64}/test_virtio_version.py |   0
 tests/functional/xtensa/meson.build                |   6 +
 .../{test_xtensa_lx60.py => xtensa/test_lx60.py}   |   0
 .../test_replay.py}                                |   0
 201 files changed, 1008 insertions(+), 525 deletions(-)
 create mode 100644 tests/functional/aarch64/meson.build
 rename tests/functional/{test_aarch64_aspeed_ast2700.py => aarch64/test_aspeed_ast2700.py} (100%)
 rename tests/functional/{test_aarch64_aspeed_ast2700fc.py => aarch64/test_aspeed_ast2700fc.py} (100%)
 rename tests/functional/{test_aarch64_device_passthrough.py => aarch64/test_device_passthrough.py} (100%)
 rename tests/functional/{test_aarch64_hotplug_pci.py => aarch64/test_hotplug_pci.py} (100%)
 rename tests/functional/{test_aarch64_imx8mp_evk.py => aarch64/test_imx8mp_evk.py} (100%)
 rename tests/functional/{test_aarch64_kvm.py => aarch64/test_kvm.py} (100%)
 create mode 100755 tests/functional/aarch64/test_migration.py
 create mode 100755 tests/functional/aarch64/test_multiprocess.py
 rename tests/functional/{test_aarch64_raspi3.py => aarch64/test_raspi3.py} (100%)
 rename tests/functional/{test_aarch64_raspi4.py => aarch64/test_raspi4.py} (100%)
 rename tests/functional/{test_aarch64_replay.py => aarch64/test_replay.py} (100%)
 rename tests/functional/{test_aarch64_reverse_debug.py => aarch64/test_reverse_debug.py} (93%)
 rename tests/functional/{test_aarch64_rme_sbsaref.py => aarch64/test_rme_sbsaref.py} (98%)
 rename tests/functional/{test_aarch64_rme_virt.py => aarch64/test_rme_virt.py} (100%)
 rename tests/functional/{test_aarch64_sbsaref.py => aarch64/test_sbsaref.py} (100%)
 rename tests/functional/{test_aarch64_sbsaref_alpine.py => aarch64/test_sbsaref_alpine.py} (97%)
 rename tests/functional/{test_aarch64_sbsaref_freebsd.py => aarch64/test_sbsaref_freebsd.py} (97%)
 rename tests/functional/{test_aarch64_smmu.py => aarch64/test_smmu.py} (100%)
 rename tests/functional/{test_aarch64_tcg_plugins.py => aarch64/test_tcg_plugins.py} (100%)
 rename tests/functional/{test_aarch64_tuxrun.py => aarch64/test_tuxrun.py} (100%)
 rename tests/functional/{test_aarch64_virt.py => aarch64/test_virt.py} (100%)
 rename tests/functional/{test_aarch64_virt_gpu.py => aarch64/test_virt_gpu.py} (97%)
 rename tests/functional/{test_aarch64_xen.py => aarch64/test_xen.py} (100%)
 rename tests/functional/{test_aarch64_xlnx_versal.py => aarch64/test_xlnx_versal.py} (100%)
 create mode 100644 tests/functional/alpha/meson.build
 rename tests/functional/{test_alpha_clipper.py => alpha/test_clipper.py} (100%)
 create mode 100755 tests/functional/alpha/test_migration.py
 rename tests/functional/{test_alpha_replay.py => alpha/test_replay.py} (100%)
 create mode 100644 tests/functional/arm/meson.build
 rename tests/functional/{test_arm_aspeed_ast1030.py => arm/test_aspeed_ast1030.py} (100%)
 rename tests/functional/{test_arm_aspeed_ast2500.py => arm/test_aspeed_ast2500.py} (100%)
 rename tests/functional/{test_arm_aspeed_ast2600.py => arm/test_aspeed_ast2600.py} (100%)
 rename tests/functional/{test_arm_aspeed_bletchley.py => arm/test_aspeed_bletchley.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_arm_aspeed_catalina.py => arm/test_aspeed_catalina.py} (100%)
 rename tests/functional/{test_arm_aspeed_gb200nvl_bmc.py => arm/test_aspeed_gb200nvl_bmc.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_arm_aspeed_palmetto.py => arm/test_aspeed_palmetto.py} (100%)
 rename tests/functional/{test_arm_aspeed_rainier.py => arm/test_aspeed_rainier.py} (100%)
 rename tests/functional/{test_arm_aspeed_romulus.py => arm/test_aspeed_romulus.py} (100%)
 rename tests/functional/{test_arm_aspeed_witherspoon.py => arm/test_aspeed_witherspoon.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_arm_bflt.py => arm/test_bflt.py} (100%)
 rename tests/functional/{test_arm_bpim2u.py => arm/test_bpim2u.py} (100%)
 rename tests/functional/{test_arm_canona1100.py => arm/test_canona1100.py} (100%)
 rename tests/functional/{test_arm_collie.py => arm/test_collie.py} (100%)
 rename tests/functional/{test_arm_cubieboard.py => arm/test_cubieboard.py} (100%)
 rename tests/functional/{test_arm_emcraft_sf2.py => arm/test_emcraft_sf2.py} (100%)
 rename tests/functional/{test_arm_integratorcp.py => arm/test_integratorcp.py} (100%)
 rename tests/functional/{test_arm_max78000fthr.py => arm/test_max78000fthr.py} (100%)
 rename tests/functional/{test_arm_microbit.py => arm/test_microbit.py} (100%)
 create mode 100755 tests/functional/arm/test_migration.py
 rename tests/functional/{test_arm_orangepi.py => arm/test_orangepi.py} (100%)
 rename tests/functional/{test_arm_quanta_gsj.py => arm/test_quanta_gsj.py} (100%)
 rename tests/functional/{test_arm_raspi2.py => arm/test_raspi2.py} (100%)
 rename tests/functional/{test_arm_realview.py => arm/test_realview.py} (100%)
 rename tests/functional/{test_arm_replay.py => arm/test_replay.py} (100%)
 rename tests/functional/{test_arm_smdkc210.py => arm/test_smdkc210.py} (100%)
 rename tests/functional/{test_arm_stellaris.py => arm/test_stellaris.py} (100%)
 rename tests/functional/{test_arm_sx1.py => arm/test_sx1.py} (100%)
 rename tests/functional/{test_arm_tuxrun.py => arm/test_tuxrun.py} (100%)
 rename tests/functional/{test_arm_vexpress.py => arm/test_vexpress.py} (100%)
 rename tests/functional/{test_arm_virt.py => arm/test_virt.py} (100%)
 create mode 100644 tests/functional/avr/meson.build
 rename tests/functional/{test_avr_mega2560.py => avr/test_mega2560.py} (100%)
 rename tests/functional/{test_avr_uno.py => avr/test_uno.py} (100%)
 create mode 100644 tests/functional/generic/meson.build
 rename tests/functional/{ => generic}/test_empty_cpu_model.py (100%)
 rename tests/functional/{ => generic}/test_info_usernet.py (100%)
 rename tests/functional/{ => generic}/test_version.py (100%)
 rename tests/functional/{ => generic}/test_vnc.py (100%)
 create mode 100644 tests/functional/hppa/meson.build
 rename tests/functional/{test_hppa_seabios.py => hppa/test_seabios.py} (100%)
 create mode 100644 tests/functional/i386/meson.build
 create mode 100755 tests/functional/i386/test_migration.py
 rename tests/functional/{test_i386_replay.py => i386/test_replay.py} (100%)
 rename tests/functional/{test_i386_tuxrun.py => i386/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/loongarch64/meson.build
 rename tests/functional/{test_loongarch64_virt.py => loongarch64/test_virt.py} (100%)
 create mode 100644 tests/functional/m68k/meson.build
 rename tests/functional/{test_m68k_mcf5208evb.py => m68k/test_mcf5208evb.py} (100%)
 rename tests/functional/{test_m68k_nextcube.py => m68k/test_nextcube.py} (100%)
 rename tests/functional/{test_m68k_q800.py => m68k/test_q800.py} (100%)
 rename tests/functional/{test_m68k_replay.py => m68k/test_replay.py} (100%)
 rename tests/functional/{test_m68k_tuxrun.py => m68k/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/microblaze/meson.build
 rename tests/functional/{test_microblaze_replay.py => microblaze/test_replay.py} (100%)
 rename tests/functional/{test_microblaze_s3adsp1800.py => microblaze/test_s3adsp1800.py} (100%)
 create mode 100644 tests/functional/microblazeel/meson.build
 rename tests/functional/{test_microblazeel_s3adsp1800.py => microblazeel/test_s3adsp1800.py} (92%)
 rename tests/functional/{test_migration.py => migration.py} (74%)
 mode change 100755 => 100644
 create mode 100644 tests/functional/mips/meson.build
 rename tests/functional/{test_mips_malta.py => mips/test_malta.py} (100%)
 rename tests/functional/{test_mips_replay.py => mips/test_replay.py} (100%)
 rename tests/functional/{test_mips_tuxrun.py => mips/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/mips64/meson.build
 rename tests/functional/{test_mips64_malta.py => mips64/test_malta.py} (96%)
 rename tests/functional/{test_mips64_tuxrun.py => mips64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/mips64el/meson.build
 rename tests/functional/{test_mips64el_fuloong2e.py => mips64el/test_fuloong2e.py} (100%)
 rename tests/functional/{test_mips64el_loongson3v.py => mips64el/test_loongson3v.py} (100%)
 rename tests/functional/{test_mips64el_malta.py => mips64el/test_malta.py} (98%)
 rename tests/functional/{test_mips64el_replay.py => mips64el/test_replay.py} (100%)
 rename tests/functional/{test_mips64el_tuxrun.py => mips64el/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/mipsel/meson.build
 rename tests/functional/{test_mipsel_malta.py => mipsel/test_malta.py} (98%)
 rename tests/functional/{test_mipsel_replay.py => mipsel/test_replay.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_mipsel_tuxrun.py => mipsel/test_tuxrun.py} (100%)
 rename tests/functional/{test_multiprocess.py => multiprocess.py} (58%)
 mode change 100755 => 100644
 create mode 100644 tests/functional/or1k/meson.build
 rename tests/functional/{test_or1k_replay.py => or1k/test_replay.py} (100%)
 rename tests/functional/{test_or1k_sim.py => or1k/test_sim.py} (100%)
 create mode 100644 tests/functional/ppc/meson.build
 rename tests/functional/{test_ppc_40p.py => ppc/test_40p.py} (100%)
 rename tests/functional/{test_ppc_74xx.py => ppc/test_74xx.py} (100%)
 rename tests/functional/{test_ppc_amiga.py => ppc/test_amiga.py} (100%)
 rename tests/functional/{test_ppc_bamboo.py => ppc/test_bamboo.py} (100%)
 rename tests/functional/{test_ppc_mac.py => ppc/test_mac.py} (100%)
 create mode 100755 tests/functional/ppc/test_migration.py
 rename tests/functional/{test_ppc_mpc8544ds.py => ppc/test_mpc8544ds.py} (100%)
 rename tests/functional/{test_ppc_replay.py => ppc/test_replay.py} (100%)
 rename tests/functional/{test_ppc_sam460ex.py => ppc/test_sam460ex.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_ppc_tuxrun.py => ppc/test_tuxrun.py} (100%)
 rename tests/functional/{test_ppc_virtex_ml507.py => ppc/test_virtex_ml507.py} (100%)
 create mode 100644 tests/functional/ppc64/meson.build
 rename tests/functional/{test_ppc64_e500.py => ppc64/test_e500.py} (100%)
 rename tests/functional/{test_ppc64_hv.py => ppc64/test_hv.py} (100%)
 rename tests/functional/{test_ppc64_mac99.py => ppc64/test_mac99.py} (100%)
 create mode 100755 tests/functional/ppc64/test_migration.py
 rename tests/functional/{test_ppc64_powernv.py => ppc64/test_powernv.py} (100%)
 rename tests/functional/{test_ppc64_pseries.py => ppc64/test_pseries.py} (100%)
 rename tests/functional/{test_ppc64_replay.py => ppc64/test_replay.py} (100%)
 rename tests/functional/{test_ppc64_reverse_debug.py => ppc64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_ppc64_tuxrun.py => ppc64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/riscv32/meson.build
 create mode 100755 tests/functional/riscv32/test_migration.py
 create mode 100755 tests/functional/riscv32/test_opensbi.py
 rename tests/functional/{test_riscv32_tuxrun.py => riscv32/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/riscv64/meson.build
 create mode 100755 tests/functional/riscv64/test_migration.py
 rename tests/functional/{test_riscv_opensbi.py => riscv64/test_opensbi.py} (100%)
 rename tests/functional/{test_riscv64_sifive_u.py => riscv64/test_sifive_u.py} (100%)
 rename tests/functional/{test_riscv64_tuxrun.py => riscv64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/rx/meson.build
 rename tests/functional/{test_rx_gdbsim.py => rx/test_gdbsim.py} (100%)
 create mode 100644 tests/functional/s390x/meson.build
 rename tests/functional/{test_s390x_ccw_virtio.py => s390x/test_ccw_virtio.py} (100%)
 rename tests/functional/{test_s390x_pxelinux.py => s390x/test_pxelinux.py} (100%)
 rename tests/functional/{test_s390x_replay.py => s390x/test_replay.py} (100%)
 rename tests/functional/{test_s390x_topology.py => s390x/test_topology.py} (100%)
 rename tests/functional/{test_s390x_tuxrun.py => s390x/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/sh4/meson.build
 rename tests/functional/{test_sh4_r2d.py => sh4/test_r2d.py} (100%)
 rename tests/functional/{test_sh4_tuxrun.py => sh4/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/sh4eb/meson.build
 rename tests/functional/{test_sh4eb_r2d.py => sh4eb/test_r2d.py} (100%)
 create mode 100644 tests/functional/sparc/meson.build
 create mode 100755 tests/functional/sparc/test_migration.py
 rename tests/functional/{test_sparc_replay.py => sparc/test_replay.py} (100%)
 rename tests/functional/{test_sparc_sun4m.py => sparc/test_sun4m.py} (100%)
 create mode 100644 tests/functional/sparc64/meson.build
 create mode 100755 tests/functional/sparc64/test_migration.py
 rename tests/functional/{test_sparc64_sun4u.py => sparc64/test_sun4u.py} (100%)
 rename tests/functional/{test_sparc64_tuxrun.py => sparc64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/x86_64/meson.build
 rename tests/functional/{ => x86_64}/test_acpi_bits.py (100%)
 rename tests/functional/{test_x86_cpu_model_versions.py => x86_64/test_cpu_model_versions.py} (100%)
 rename tests/functional/{ => x86_64}/test_cpu_queries.py (100%)
 rename tests/functional/{test_x86_64_hotplug_blk.py => x86_64/test_hotplug_blk.py} (100%)
 rename tests/functional/{test_x86_64_hotplug_cpu.py => x86_64/test_hotplug_cpu.py} (100%)
 rename tests/functional/{ => x86_64}/test_intel_iommu.py (100%)
 rename tests/functional/{test_x86_64_kvm_xen.py => x86_64/test_kvm_xen.py} (100%)
 rename tests/functional/{ => x86_64}/test_linux_initrd.py (100%)
 rename tests/functional/{ => x86_64}/test_mem_addr_space.py (100%)
 rename tests/functional/{ => x86_64}/test_memlock.py (100%)
 create mode 100755 tests/functional/x86_64/test_migration.py
 create mode 100755 tests/functional/x86_64/test_multiprocess.py
 rename tests/functional/{ => x86_64}/test_netdev_ethtool.py (100%)
 rename tests/functional/{ => x86_64}/test_pc_cpu_hotplug_props.py (100%)
 rename tests/functional/{test_x86_64_replay.py => x86_64/test_replay.py} (100%)
 rename tests/functional/{test_x86_64_reverse_debug.py => x86_64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_x86_64_tuxrun.py => x86_64/test_tuxrun.py} (100%)
 rename tests/functional/{ => x86_64}/test_virtio_balloon.py (100%)
 rename tests/functional/{ => x86_64}/test_virtio_gpu.py (100%)
 rename tests/functional/{ => x86_64}/test_virtio_version.py (100%)
 create mode 100644 tests/functional/xtensa/meson.build
 rename tests/functional/{test_xtensa_lx60.py => xtensa/test_lx60.py} (100%)
 rename tests/functional/{test_xtensa_replay.py => xtensa/test_replay.py} (100%)


