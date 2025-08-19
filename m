Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66F94CA0EE6
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 11:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoKRx-0003DH-8G; Tue, 19 Aug 2025 07:24:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKRv-0003Cp-F3
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uoKRr-00079x-4q
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 07:24:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755602651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aObpwOBhqk8nYRCpL8aZYQwNc/qThG8lx1wL3d7UXFs=;
 b=PQAjFLQWv/BrF1Rbnbsj9JtML41ktQwNFAtR4m6zF5ktieVhCS7Kn+tLkSXVg6QZCxxXlI
 iX/foHCQF2kD8M6nNzJpzYXPhGKEIoDmlbzibqlFKzH2j2c1OPBga3FdF4R2/mUP9wLSfL
 6pWyWbbYjA9VEK2EgLpINbsEv5RlGmU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-AJ1jPkFGMhWoJg1ufYikvg-1; Tue,
 19 Aug 2025 07:24:09 -0400
X-MC-Unique: AJ1jPkFGMhWoJg1ufYikvg-1
X-Mimecast-MFC-AGG-ID: AJ1jPkFGMhWoJg1ufYikvg_1755602648
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B25C41944E40; Tue, 19 Aug 2025 11:24:08 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.251])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7A1E30001A8; Tue, 19 Aug 2025 11:24:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 00/25] tests/functional: Move tests into architecture
 specific folders
Date: Tue, 19 Aug 2025 13:23:37 +0200
Message-ID: <20250819112403.432587-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This patch series tackles two issues. First, the tests/functional folder
has become quite crowded already, some restructuring would be helpful here.
Second, we currently encode the target architecture twice in the test names
since a lot of the test file names contain the target, too. This contributes
to the very long output lines when running "make check-functional".

So let's move the individual test files to target specific folders.
Then we can drop the target from the file name (and thus from the test
name).

Before the change, the output looked like this:

 ...
 195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-microblazeel-microblazeel_s3adsp1800          OK                2.00s   2 subtests passed
 196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-microblaze_replay                    OK                2.78s   1 subtests passed
 197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-microblaze_s3adsp1800                OK                2.02s   2 subtests passed
 198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_fuloong2e                       OK                1.95s   1 subtests passed
 199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_loongson3v                      SKIP              0.07s   0 subtests passed
 200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-mips64el_tuxrun                          OK                8.52s   1 subtests passed
 ...

After this change, it gets a little bit shorter:

 ...
 195/236 qemu:func-thorough+func-microblazeel-thorough+thorough / func-microblazeel-s3adsp1800          OK                2.12s   2 subtests passed
 196/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-replay                  OK                2.90s   1 subtests passed
 197/236 qemu:func-thorough+func-microblaze-thorough+thorough / func-microblaze-s3adsp1800              OK                2.07s   2 subtests passed
 198/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-fuloong2e                   OK                2.05s   1 subtests passed
 199/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-loongson3v                  SKIP              0.07s   0 subtests passed
 200/236 qemu:func-thorough+func-mips64el-thorough+thorough / func-mips64el-tuxrun                      OK                8.84s   1 subtests passed
 ...

Tests that can be used for multiple but not all targets (like the "migration"
test) are now handled via wrapper files in the target folders.

v2:
- Rebase patches to current master branch (some new tests had been added)
- Improved the updates to the MAINTAINERS file to make sure that we really
  cover the locations of the moved files

Thomas Huth (25):
  tests/functional: Rework the migration test to have target-specific
    files
  tests/functional: Rework the multiprocess test to have target-specific
    files
  tests/functional/meson.build: Split timeout settings by target
  tests/functional/meson.build: Allow tests to reside in subfolders
  tests/functional: Move aarch64 tests into architecture specific folder
  tests/functional: Move alpha tests into architecture specific folder
  tests/functional: Move arm tests into architecture specific folder
  tests/functional: Move avr tests into architecture specific folder
  tests/functional: Move hppa tests into architecture specific folder
  tests/functional: Move i386 tests into architecture specific folder
  tests/functional: Move loongarch64 tests into architecture specific
    folder
  tests/functional: Move m68k tests into architecture specific folder
  tests/functional: Move microblaze tests into architecture specific
    folder
  tests/functional: Move mips tests into target-specific folders
  tests/functional: Move or1k tests into target-specific folders
  tests/functional: Move ppc/ppc64 tests into target-specific folders
  tests/functional: Move riscv32/riscv64 tests into target-specific
    folders
  tests/functional: Move rx test into target-specific folders
  tests/functional: Move s390x tests into target-specific folders
  tests/functional: Move sh4/sh4eb tests into target-specific folders
  tests/functional: Move sparc/sparc64 tests into target-specific
    folders
  tests/functional: Move x86_64 tests into target-specific folder
  tests/functional: Move xtensa tests into target-specific folder
  tests/functional: Move the generic tests to a subfolder
  MAINTAINERS: Adjust wildcards for the migration, multiprocess and
    replay tests

 MAINTAINERS                                   | 203 +++++-----
 tests/functional/aarch64/meson.build          |  48 +++
 .../test_aspeed_ast2700.py}                   |   0
 .../test_aspeed_ast2700fc.py}                 |   0
 .../test_device_passthrough.py}               |   0
 .../test_hotplug_pci.py}                      |   0
 .../test_imx8mp_evk.py}                       |   0
 .../test_kvm.py}                              |   0
 tests/functional/aarch64/test_migration.py    |  26 ++
 tests/functional/aarch64/test_multiprocess.py |  31 ++
 .../test_raspi3.py}                           |   0
 .../test_raspi4.py}                           |   0
 .../test_replay.py}                           |   0
 .../test_reverse_debug.py}                    |   0
 .../test_rme_sbsaref.py}                      |   2 +-
 .../test_rme_virt.py}                         |   0
 .../test_sbsaref.py}                          |   0
 .../test_sbsaref_alpine.py}                   |   2 +-
 .../test_sbsaref_freebsd.py}                  |   2 +-
 .../test_smmu.py}                             |   0
 .../test_tcg_plugins.py}                      |   0
 .../test_tuxrun.py}                           |   0
 .../test_virt.py}                             |   0
 .../test_virt_gpu.py}                         |   0
 .../test_xen.py}                              |   0
 .../test_xlnx_versal.py}                      |   0
 tests/functional/alpha/meson.build            |  10 +
 .../test_clipper.py}                          |   0
 tests/functional/alpha/test_migration.py      |  26 ++
 .../test_replay.py}                           |   0
 tests/functional/arm/meson.build              |  62 +++
 .../test_aspeed_ast1030.py}                   |   0
 .../test_aspeed_ast2500.py}                   |   0
 .../test_aspeed_ast2600.py}                   |   0
 .../test_aspeed_bletchley.py}                 |   0
 .../test_aspeed_catalina.py}                  |   0
 .../test_aspeed_gb200nvl_bmc.py}              |   0
 .../test_aspeed_palmetto.py}                  |   0
 .../test_aspeed_rainier.py}                   |   0
 .../test_aspeed_romulus.py}                   |   0
 .../test_aspeed_witherspoon.py}               |   0
 .../{test_arm_bflt.py => arm/test_bflt.py}    |   0
 .../test_bpim2u.py}                           |   0
 .../test_canona1100.py}                       |   0
 .../test_collie.py}                           |   0
 .../test_cubieboard.py}                       |   0
 .../test_emcraft_sf2.py}                      |   0
 .../test_integratorcp.py}                     |   0
 .../test_max78000fthr.py}                     |   0
 .../test_microbit.py}                         |   0
 tests/functional/arm/test_migration.py        |  26 ++
 .../test_orangepi.py}                         |   0
 .../test_quanta_gsj.py}                       |   0
 .../test_raspi2.py}                           |   0
 .../test_realview.py}                         |   0
 .../test_replay.py}                           |   0
 .../test_smdkc210.py}                         |   0
 .../test_stellaris.py}                        |   0
 .../{test_arm_sx1.py => arm/test_sx1.py}      |   0
 .../test_tuxrun.py}                           |   0
 .../test_vexpress.py}                         |   0
 .../{test_arm_virt.py => arm/test_virt.py}    |   0
 tests/functional/avr/meson.build              |   6 +
 .../test_mega2560.py}                         |   0
 .../{test_avr_uno.py => avr/test_uno.py}      |   0
 tests/functional/generic/meson.build          |  14 +
 .../{ => generic}/test_empty_cpu_model.py     |   0
 .../{ => generic}/test_info_usernet.py        |   0
 .../functional/{ => generic}/test_version.py  |   0
 tests/functional/{ => generic}/test_vnc.py    |   0
 tests/functional/hppa/meson.build             |   5 +
 .../test_seabios.py}                          |   0
 tests/functional/i386/meson.build             |  10 +
 tests/functional/i386/test_migration.py       |  26 ++
 .../test_replay.py}                           |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/loongarch64/meson.build      |   5 +
 .../test_virt.py}                             |   0
 tests/functional/m68k/meson.build             |   9 +
 .../test_mcf5208evb.py}                       |   0
 .../test_nextcube.py}                         |   0
 .../{test_m68k_q800.py => m68k/test_q800.py}  |   0
 .../test_replay.py}                           |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/meson.build                  | 382 ++----------------
 tests/functional/microblaze/meson.build       |   6 +
 .../test_replay.py}                           |   0
 .../test_s3adsp1800.py}                       |   0
 tests/functional/microblazeel/meson.build     |   5 +
 .../test_s3adsp1800.py}                       |   2 +-
 .../{test_migration.py => migration.py}       |  35 +-
 tests/functional/mips/meson.build             |  11 +
 .../test_malta.py}                            |   0
 .../test_replay.py}                           |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/mips64/meson.build           |  10 +
 .../test_malta.py}                            |   2 +-
 .../test_tuxrun.py}                           |   0
 tests/functional/mips64el/meson.build         |  14 +
 .../test_fuloong2e.py}                        |   0
 .../test_loongson3v.py}                       |   0
 .../test_malta.py}                            |   4 +-
 .../test_replay.py}                           |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/mipsel/meson.build           |  12 +
 .../test_malta.py}                            |   2 +-
 .../test_replay.py}                           |   0
 .../test_tuxrun.py}                           |   0
 .../{test_multiprocess.py => multiprocess.py} |  40 +-
 tests/functional/or1k/meson.build             |   6 +
 .../test_replay.py}                           |   0
 .../{test_or1k_sim.py => or1k/test_sim.py}    |   0
 tests/functional/ppc/meson.build              |  22 +
 .../{test_ppc_40p.py => ppc/test_40p.py}      |   0
 .../{test_ppc_74xx.py => ppc/test_74xx.py}    |   0
 .../{test_ppc_amiga.py => ppc/test_amiga.py}  |   0
 .../test_bamboo.py}                           |   0
 .../{test_ppc_mac.py => ppc/test_mac.py}      |   0
 tests/functional/ppc/test_migration.py        |  26 ++
 .../test_mpc8544ds.py}                        |   0
 .../test_replay.py}                           |   0
 .../test_sam460ex.py}                         |   0
 .../test_tuxrun.py}                           |   0
 .../test_virtex_ml507.py}                     |   0
 tests/functional/ppc64/meson.build            |  25 ++
 .../test_e500.py}                             |   0
 .../{test_ppc64_hv.py => ppc64/test_hv.py}    |   0
 .../test_mac99.py}                            |   0
 tests/functional/ppc64/test_migration.py      |  26 ++
 .../test_powernv.py}                          |   0
 .../test_pseries.py}                          |   0
 .../test_replay.py}                           |   0
 .../test_reverse_debug.py}                    |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/riscv32/meson.build          |  10 +
 tests/functional/riscv32/test_migration.py    |  26 ++
 tests/functional/riscv32/test_opensbi.py      |  10 +
 .../test_tuxrun.py}                           |   0
 tests/functional/riscv64/meson.build          |  15 +
 tests/functional/riscv64/test_migration.py    |  26 ++
 .../test_opensbi.py}                          |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/rx/meson.build               |   5 +
 .../{test_rx_gdbsim.py => rx/test_gdbsim.py}  |   0
 tests/functional/s390x/meson.build            |  13 +
 .../test_ccw_virtio.py}                       |   0
 .../test_pxelinux.py}                         |   0
 .../test_replay.py}                           |   0
 .../test_topology.py}                         |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/sh4/meson.build              |  10 +
 .../{test_sh4_r2d.py => sh4/test_r2d.py}      |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/sh4eb/meson.build            |   5 +
 .../{test_sh4eb_r2d.py => sh4eb/test_r2d.py}  |   0
 tests/functional/sparc/meson.build            |  10 +
 tests/functional/sparc/test_migration.py      |  26 ++
 .../test_replay.py}                           |   0
 .../test_sun4m.py}                            |   0
 tests/functional/sparc64/meson.build          |  10 +
 tests/functional/sparc64/test_migration.py    |  26 ++
 .../test_sun4u.py}                            |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/x86_64/meson.build           |  36 ++
 .../functional/{ => x86_64}/test_acpi_bits.py |   0
 .../test_cpu_model_versions.py}               |   0
 .../{ => x86_64}/test_cpu_queries.py          |   0
 .../test_hotplug_blk.py}                      |   0
 .../test_hotplug_cpu.py}                      |   0
 .../{ => x86_64}/test_intel_iommu.py          |   0
 .../test_kvm_xen.py}                          |   0
 .../{ => x86_64}/test_linux_initrd.py         |   0
 .../{ => x86_64}/test_mem_addr_space.py       |   0
 tests/functional/{ => x86_64}/test_memlock.py |   0
 tests/functional/x86_64/test_migration.py     |  26 ++
 tests/functional/x86_64/test_multiprocess.py  |  31 ++
 .../{ => x86_64}/test_netdev_ethtool.py       |   0
 .../{ => x86_64}/test_pc_cpu_hotplug_props.py |   0
 .../test_replay.py}                           |   0
 .../test_reverse_debug.py}                    |   0
 .../test_tuxrun.py}                           |   0
 .../{ => x86_64}/test_virtio_balloon.py       |   0
 .../{ => x86_64}/test_virtio_gpu.py           |   0
 .../{ => x86_64}/test_virtio_version.py       |   0
 tests/functional/xtensa/meson.build           |   6 +
 .../test_lx60.py}                             |   0
 .../test_replay.py}                           |   0
 187 files changed, 923 insertions(+), 511 deletions(-)
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
 rename tests/functional/{test_aarch64_reverse_debug.py => aarch64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_aarch64_rme_sbsaref.py => aarch64/test_rme_sbsaref.py} (98%)
 rename tests/functional/{test_aarch64_rme_virt.py => aarch64/test_rme_virt.py} (100%)
 rename tests/functional/{test_aarch64_sbsaref.py => aarch64/test_sbsaref.py} (100%)
 rename tests/functional/{test_aarch64_sbsaref_alpine.py => aarch64/test_sbsaref_alpine.py} (97%)
 rename tests/functional/{test_aarch64_sbsaref_freebsd.py => aarch64/test_sbsaref_freebsd.py} (97%)
 rename tests/functional/{test_aarch64_smmu.py => aarch64/test_smmu.py} (100%)
 rename tests/functional/{test_aarch64_tcg_plugins.py => aarch64/test_tcg_plugins.py} (100%)
 rename tests/functional/{test_aarch64_tuxrun.py => aarch64/test_tuxrun.py} (100%)
 rename tests/functional/{test_aarch64_virt.py => aarch64/test_virt.py} (100%)
 rename tests/functional/{test_aarch64_virt_gpu.py => aarch64/test_virt_gpu.py} (100%)
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

-- 
2.50.1


