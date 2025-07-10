Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 147B4C83F1D
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Jul 2025 09:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uZnvZ-0002lD-OD; Thu, 10 Jul 2025 05:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZnoJ-0005V3-S4
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:43:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uZno3-0001sE-Ri
 for qemu-devel@nongnu.org; Thu, 10 Jul 2025 05:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752140584;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LNyR61F6Aut4jcR+5rr4SB/mTDCOpkJXBLAWpLV3gsY=;
 b=QOxCnqXAUGBFyEYxSgmnRXmd17xwQBgGEWAaMAxs8QJixy+sNoXk9lc9l8KgLDJgbVFSG4
 y6b1cIzMFzswv8+BeTTtytcEXZNQ6wgpRLeXS1I4gU0u4MNLjCqODaFFPxLAXfPulEdRFE
 IMmZXZpMWy0lHrSd14fz6urWtMFdnFY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-DKqnqrsRM-uTDCGQ7vENww-1; Thu,
 10 Jul 2025 05:43:00 -0400
X-MC-Unique: DKqnqrsRM-uTDCGQ7vENww-1
X-Mimecast-MFC-AGG-ID: DKqnqrsRM-uTDCGQ7vENww_1752140579
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8D5119560B3; Thu, 10 Jul 2025 09:42:58 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.72])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE24819373D8; Thu, 10 Jul 2025 09:42:53 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 qemu-riscv@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [RFC PATCH] tests/functional: Move tests into architecture specific
 folders
Date: Thu, 10 Jul 2025 11:42:51 +0200
Message-ID: <20250710094251.139514-1-thuth@redhat.com>
MIME-Version: 1.0
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch tackles two issues. First, the tests/functional folder has
become quite crowded already, some restructuring would be helpful here.
Second, we currently encode the target architecture twice in the test
names since a lot of the test file names contain the target, too.
This contributes to the very long output lines when running "make
check-functional".

So let's move the individual test files to target specific folders now.
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
test) are now handled via symlinks in the target folders.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Note: Marked as RFC since I'm not that happy about the symlinks yet ...
       if someone has a better idea, please let me know!
       Also the update to the MAINTAINERS file is still missing - I'll add
       that once we agreed on whether this patch is a good idea or not.

 tests/functional/aarch64/meson.build          |  47 +++
 .../test_aspeed_ast2700.py}                   |   0
 .../test_aspeed_ast2700fc.py}                 |   0
 .../test_device_passthrough.py}               |   0
 .../test_hotplug_pci.py}                      |   0
 .../test_imx8mp_evk.py}                       |   0
 tests/functional/aarch64/test_migration.py    |   1 +
 tests/functional/aarch64/test_multiprocess.py |   1 +
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
 tests/functional/alpha/meson.build            |   9 +
 .../test_clipper.py}                          |   0
 tests/functional/alpha/test_migration.py      |   1 +
 .../test_replay.py}                           |   0
 tests/functional/arm/meson.build              |  61 +++
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
 .../test_microbit.py}                         |   0
 tests/functional/arm/test_migration.py        |   1 +
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
 tests/functional/avr/meson.build              |   5 +
 .../test_mega2560.py}                         |   0
 .../{test_avr_uno.py => avr/test_uno.py}      |   0
 .../{ => generic}/test_empty_cpu_model.py     |   0
 .../{ => generic}/test_info_usernet.py        |   0
 .../{ => generic}/test_migration.py           |   0
 .../functional/{ => generic}/test_version.py  |   0
 tests/functional/hppa/meson.build             |   4 +
 .../test_seabios.py}                          |   0
 tests/functional/i386/meson.build             |   9 +
 tests/functional/i386/test_migration.py       |   1 +
 .../test_replay.py}                           |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/loongarch64/meson.build      |   4 +
 .../test_virt.py}                             |   0
 tests/functional/m68k/meson.build             |   8 +
 .../test_mcf5208evb.py}                       |   0
 .../test_nextcube.py}                         |   0
 .../{test_m68k_q800.py => m68k/test_q800.py}  |   0
 .../test_replay.py}                           |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/meson.build                  | 364 ++----------------
 tests/functional/microblaze/meson.build       |   5 +
 .../test_replay.py}                           |   0
 .../test_s3adsp1800.py}                       |   0
 tests/functional/microblazeel/meson.build     |   4 +
 .../test_s3adsp1800.py}                       |   2 +-
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
 tests/functional/or1k/meson.build             |   5 +
 .../test_replay.py}                           |   0
 .../{test_or1k_sim.py => or1k/test_sim.py}    |   0
 tests/functional/ppc/meson.build              |  22 ++
 .../{test_ppc_40p.py => ppc/test_40p.py}      |   0
 .../{test_ppc_74xx.py => ppc/test_74xx.py}    |   0
 .../{test_ppc_amiga.py => ppc/test_amiga.py}  |   0
 .../test_bamboo.py}                           |   0
 .../{test_ppc_mac.py => ppc/test_mac.py}      |   0
 tests/functional/ppc/test_migration.py        |   1 +
 .../test_mpc8544ds.py}                        |   0
 .../test_replay.py}                           |   0
 .../test_sam460ex.py}                         |   0
 .../test_tuxrun.py}                           |   0
 .../test_virtex_ml507.py}                     |   0
 tests/functional/ppc64/meson.build            |  25 ++
 .../test_e500.py}                             |   0
 .../{test_ppc64_hv.py => ppc64/test_hv.py}    |   0
 .../test_mac99.py}                            |   0
 tests/functional/ppc64/test_migration.py      |   1 +
 .../test_powernv.py}                          |   0
 .../test_pseries.py}                          |   0
 .../test_replay.py}                           |   0
 .../test_reverse_debug.py}                    |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/riscv32/meson.build          |   9 +
 tests/functional/riscv32/test_migration.py    |   1 +
 tests/functional/riscv32/test_opensbi.py      |   1 +
 .../test_tuxrun.py}                           |   0
 tests/functional/riscv64/meson.build          |  13 +
 .../test_opensbi.py}                          |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/rx/meson.build               |   4 +
 .../{test_rx_gdbsim.py => rx/test_gdbsim.py}  |   0
 tests/functional/s390x/meson.build            |  12 +
 .../test_ccw_virtio.py}                       |   0
 .../test_replay.py}                           |   0
 .../test_topology.py}                         |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/sh4/meson.build              |  10 +
 .../{test_sh4_r2d.py => sh4/test_r2d.py}      |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/sh4eb/meson.build            |   4 +
 .../{test_sh4eb_r2d.py => sh4eb/test_r2d.py}  |   0
 tests/functional/sparc/meson.build            |   9 +
 tests/functional/sparc/test_migration.py      |   1 +
 .../test_replay.py}                           |   0
 .../test_sun4m.py}                            |   0
 tests/functional/sparc64/meson.build          |   9 +
 tests/functional/sparc64/test_migration.py    |   1 +
 .../test_sun4u.py}                            |   0
 .../test_tuxrun.py}                           |   0
 tests/functional/x86_64/meson.build           |  37 ++
 .../functional/{ => x86_64}/test_acpi_bits.py |   0
 .../{ => x86_64}/test_cpu_queries.py          |   0
 .../test_hotplug_blk.py}                      |   0
 .../test_hotplug_cpu.py}                      |   0
 .../{ => x86_64}/test_intel_iommu.py          |   0
 .../test_kvm_xen.py}                          |   0
 .../{ => x86_64}/test_linux_initrd.py         |   0
 .../{ => x86_64}/test_mem_addr_space.py       |   0
 tests/functional/{ => x86_64}/test_memlock.py |   0
 tests/functional/x86_64/test_migration.py     |   1 +
 .../{ => x86_64}/test_multiprocess.py         |   0
 .../{ => x86_64}/test_netdev_ethtool.py       |   0
 .../{ => x86_64}/test_pc_cpu_hotplug_props.py |   0
 .../test_replay.py}                           |   0
 .../test_reverse_debug.py}                    |   0
 .../test_tuxrun.py}                           |   0
 .../{ => x86_64}/test_virtio_balloon.py       |   0
 .../{ => x86_64}/test_virtio_gpu.py           |   0
 .../{ => x86_64}/test_virtio_version.py       |   0
 tests/functional/{ => x86_64}/test_vnc.py     |   0
 .../test_x86_cpu_model_versions.py            |   0
 tests/functional/xtensa/meson.build           |   5 +
 .../test_lx60.py}                             |   0
 .../test_replay.py}                           |   0
 180 files changed, 426 insertions(+), 333 deletions(-)
 create mode 100644 tests/functional/aarch64/meson.build
 rename tests/functional/{test_aarch64_aspeed_ast2700.py => aarch64/test_aspeed_ast2700.py} (100%)
 rename tests/functional/{test_aarch64_aspeed_ast2700fc.py => aarch64/test_aspeed_ast2700fc.py} (100%)
 rename tests/functional/{test_aarch64_device_passthrough.py => aarch64/test_device_passthrough.py} (100%)
 rename tests/functional/{test_aarch64_hotplug_pci.py => aarch64/test_hotplug_pci.py} (100%)
 rename tests/functional/{test_aarch64_imx8mp_evk.py => aarch64/test_imx8mp_evk.py} (100%)
 create mode 120000 tests/functional/aarch64/test_migration.py
 create mode 120000 tests/functional/aarch64/test_multiprocess.py
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
 create mode 120000 tests/functional/alpha/test_migration.py
 rename tests/functional/{test_alpha_replay.py => alpha/test_replay.py} (100%)
 create mode 100644 tests/functional/arm/meson.build
 rename tests/functional/{test_arm_aspeed_ast1030.py => arm/test_aspeed_ast1030.py} (100%)
 rename tests/functional/{test_arm_aspeed_ast2500.py => arm/test_aspeed_ast2500.py} (100%)
 rename tests/functional/{test_arm_aspeed_ast2600.py => arm/test_aspeed_ast2600.py} (100%)
 rename tests/functional/{test_arm_aspeed_bletchley.py => arm/test_aspeed_bletchley.py} (100%)
 rename tests/functional/{test_arm_aspeed_catalina.py => arm/test_aspeed_catalina.py} (100%)
 rename tests/functional/{test_arm_aspeed_gb200nvl_bmc.py => arm/test_aspeed_gb200nvl_bmc.py} (100%)
 mode change 100644 => 100755
 rename tests/functional/{test_arm_aspeed_palmetto.py => arm/test_aspeed_palmetto.py} (100%)
 rename tests/functional/{test_arm_aspeed_rainier.py => arm/test_aspeed_rainier.py} (100%)
 rename tests/functional/{test_arm_aspeed_romulus.py => arm/test_aspeed_romulus.py} (100%)
 rename tests/functional/{test_arm_aspeed_witherspoon.py => arm/test_aspeed_witherspoon.py} (100%)
 rename tests/functional/{test_arm_bflt.py => arm/test_bflt.py} (100%)
 rename tests/functional/{test_arm_bpim2u.py => arm/test_bpim2u.py} (100%)
 rename tests/functional/{test_arm_canona1100.py => arm/test_canona1100.py} (100%)
 rename tests/functional/{test_arm_collie.py => arm/test_collie.py} (100%)
 rename tests/functional/{test_arm_cubieboard.py => arm/test_cubieboard.py} (100%)
 rename tests/functional/{test_arm_emcraft_sf2.py => arm/test_emcraft_sf2.py} (100%)
 rename tests/functional/{test_arm_integratorcp.py => arm/test_integratorcp.py} (100%)
 rename tests/functional/{test_arm_microbit.py => arm/test_microbit.py} (100%)
 create mode 120000 tests/functional/arm/test_migration.py
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
 rename tests/functional/{ => generic}/test_empty_cpu_model.py (100%)
 rename tests/functional/{ => generic}/test_info_usernet.py (100%)
 rename tests/functional/{ => generic}/test_migration.py (100%)
 rename tests/functional/{ => generic}/test_version.py (100%)
 create mode 100644 tests/functional/hppa/meson.build
 rename tests/functional/{test_hppa_seabios.py => hppa/test_seabios.py} (100%)
 create mode 100644 tests/functional/i386/meson.build
 create mode 120000 tests/functional/i386/test_migration.py
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
 rename tests/functional/{test_mipsel_tuxrun.py => mipsel/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/or1k/meson.build
 rename tests/functional/{test_or1k_replay.py => or1k/test_replay.py} (100%)
 rename tests/functional/{test_or1k_sim.py => or1k/test_sim.py} (100%)
 create mode 100644 tests/functional/ppc/meson.build
 rename tests/functional/{test_ppc_40p.py => ppc/test_40p.py} (100%)
 rename tests/functional/{test_ppc_74xx.py => ppc/test_74xx.py} (100%)
 rename tests/functional/{test_ppc_amiga.py => ppc/test_amiga.py} (100%)
 rename tests/functional/{test_ppc_bamboo.py => ppc/test_bamboo.py} (100%)
 rename tests/functional/{test_ppc_mac.py => ppc/test_mac.py} (100%)
 create mode 120000 tests/functional/ppc/test_migration.py
 rename tests/functional/{test_ppc_mpc8544ds.py => ppc/test_mpc8544ds.py} (100%)
 rename tests/functional/{test_ppc_replay.py => ppc/test_replay.py} (100%)
 rename tests/functional/{test_ppc_sam460ex.py => ppc/test_sam460ex.py} (100%)
 rename tests/functional/{test_ppc_tuxrun.py => ppc/test_tuxrun.py} (100%)
 rename tests/functional/{test_ppc_virtex_ml507.py => ppc/test_virtex_ml507.py} (100%)
 create mode 100644 tests/functional/ppc64/meson.build
 rename tests/functional/{test_ppc64_e500.py => ppc64/test_e500.py} (100%)
 rename tests/functional/{test_ppc64_hv.py => ppc64/test_hv.py} (100%)
 rename tests/functional/{test_ppc64_mac99.py => ppc64/test_mac99.py} (100%)
 create mode 120000 tests/functional/ppc64/test_migration.py
 rename tests/functional/{test_ppc64_powernv.py => ppc64/test_powernv.py} (100%)
 rename tests/functional/{test_ppc64_pseries.py => ppc64/test_pseries.py} (100%)
 rename tests/functional/{test_ppc64_replay.py => ppc64/test_replay.py} (100%)
 rename tests/functional/{test_ppc64_reverse_debug.py => ppc64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_ppc64_tuxrun.py => ppc64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/riscv32/meson.build
 create mode 120000 tests/functional/riscv32/test_migration.py
 create mode 120000 tests/functional/riscv32/test_opensbi.py
 rename tests/functional/{test_riscv32_tuxrun.py => riscv32/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/riscv64/meson.build
 rename tests/functional/{test_riscv_opensbi.py => riscv64/test_opensbi.py} (100%)
 rename tests/functional/{test_riscv64_tuxrun.py => riscv64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/rx/meson.build
 rename tests/functional/{test_rx_gdbsim.py => rx/test_gdbsim.py} (100%)
 create mode 100644 tests/functional/s390x/meson.build
 rename tests/functional/{test_s390x_ccw_virtio.py => s390x/test_ccw_virtio.py} (100%)
 rename tests/functional/{test_s390x_replay.py => s390x/test_replay.py} (100%)
 rename tests/functional/{test_s390x_topology.py => s390x/test_topology.py} (100%)
 rename tests/functional/{test_s390x_tuxrun.py => s390x/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/sh4/meson.build
 rename tests/functional/{test_sh4_r2d.py => sh4/test_r2d.py} (100%)
 rename tests/functional/{test_sh4_tuxrun.py => sh4/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/sh4eb/meson.build
 rename tests/functional/{test_sh4eb_r2d.py => sh4eb/test_r2d.py} (100%)
 create mode 100644 tests/functional/sparc/meson.build
 create mode 120000 tests/functional/sparc/test_migration.py
 rename tests/functional/{test_sparc_replay.py => sparc/test_replay.py} (100%)
 rename tests/functional/{test_sparc_sun4m.py => sparc/test_sun4m.py} (100%)
 create mode 100644 tests/functional/sparc64/meson.build
 create mode 120000 tests/functional/sparc64/test_migration.py
 rename tests/functional/{test_sparc64_sun4u.py => sparc64/test_sun4u.py} (100%)
 rename tests/functional/{test_sparc64_tuxrun.py => sparc64/test_tuxrun.py} (100%)
 create mode 100644 tests/functional/x86_64/meson.build
 rename tests/functional/{ => x86_64}/test_acpi_bits.py (100%)
 rename tests/functional/{ => x86_64}/test_cpu_queries.py (100%)
 rename tests/functional/{test_x86_64_hotplug_blk.py => x86_64/test_hotplug_blk.py} (100%)
 rename tests/functional/{test_x86_64_hotplug_cpu.py => x86_64/test_hotplug_cpu.py} (100%)
 rename tests/functional/{ => x86_64}/test_intel_iommu.py (100%)
 rename tests/functional/{test_x86_64_kvm_xen.py => x86_64/test_kvm_xen.py} (100%)
 rename tests/functional/{ => x86_64}/test_linux_initrd.py (100%)
 rename tests/functional/{ => x86_64}/test_mem_addr_space.py (100%)
 rename tests/functional/{ => x86_64}/test_memlock.py (100%)
 create mode 120000 tests/functional/x86_64/test_migration.py
 rename tests/functional/{ => x86_64}/test_multiprocess.py (100%)
 rename tests/functional/{ => x86_64}/test_netdev_ethtool.py (100%)
 rename tests/functional/{ => x86_64}/test_pc_cpu_hotplug_props.py (100%)
 rename tests/functional/{test_x86_64_replay.py => x86_64/test_replay.py} (100%)
 rename tests/functional/{test_x86_64_reverse_debug.py => x86_64/test_reverse_debug.py} (100%)
 rename tests/functional/{test_x86_64_tuxrun.py => x86_64/test_tuxrun.py} (100%)
 rename tests/functional/{ => x86_64}/test_virtio_balloon.py (100%)
 rename tests/functional/{ => x86_64}/test_virtio_gpu.py (100%)
 rename tests/functional/{ => x86_64}/test_virtio_version.py (100%)
 rename tests/functional/{ => x86_64}/test_vnc.py (100%)
 rename tests/functional/{ => x86_64}/test_x86_cpu_model_versions.py (100%)
 create mode 100644 tests/functional/xtensa/meson.build
 rename tests/functional/{test_xtensa_lx60.py => xtensa/test_lx60.py} (100%)
 rename tests/functional/{test_xtensa_replay.py => xtensa/test_replay.py} (100%)

diff --git a/tests/functional/aarch64/meson.build b/tests/functional/aarch64/meson.build
new file mode 100644
index 00000000000..ebb16282692
--- /dev/null
+++ b/tests/functional/aarch64/meson.build
@@ -0,0 +1,47 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_aarch64_timeouts = {
+  'aspeed_ast2700' : 600,
+  'aspeed_ast2700fc' : 600,
+  'device_passthrough' : 720,
+  'imx8mp_evk' : 240,
+  'raspi4' : 480,
+  'reverse_debug' : 180,
+  'rme_virt' : 1200,
+  'rme_sbsaref' : 1200,
+  'sbsaref_alpine' : 1200,
+  'sbsaref_freebsd' : 720,
+  'smmu' : 720,
+  'tuxrun' : 240,
+  'virt' : 360,
+  'virt_gpu' : 480,
+}
+
+tests_aarch64_system_quick = [
+  'migration',
+]
+
+tests_aarch64_system_thorough = [
+  'aspeed_ast2700',
+  'aspeed_ast2700fc',
+  'device_passthrough',
+  'hotplug_pci',
+  'imx8mp_evk',
+  'raspi3',
+  'raspi4',
+  'replay',
+  'reverse_debug',
+  'rme_virt',
+  'rme_sbsaref',
+  'sbsaref',
+  'sbsaref_alpine',
+  'sbsaref_freebsd',
+  'smmu',
+  'tcg_plugins',
+  'tuxrun',
+  'virt',
+  'virt_gpu',
+  'xen',
+  'xlnx_versal',
+  'multiprocess',
+]
diff --git a/tests/functional/test_aarch64_aspeed_ast2700.py b/tests/functional/aarch64/test_aspeed_ast2700.py
similarity index 100%
rename from tests/functional/test_aarch64_aspeed_ast2700.py
rename to tests/functional/aarch64/test_aspeed_ast2700.py
diff --git a/tests/functional/test_aarch64_aspeed_ast2700fc.py b/tests/functional/aarch64/test_aspeed_ast2700fc.py
similarity index 100%
rename from tests/functional/test_aarch64_aspeed_ast2700fc.py
rename to tests/functional/aarch64/test_aspeed_ast2700fc.py
diff --git a/tests/functional/test_aarch64_device_passthrough.py b/tests/functional/aarch64/test_device_passthrough.py
similarity index 100%
rename from tests/functional/test_aarch64_device_passthrough.py
rename to tests/functional/aarch64/test_device_passthrough.py
diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/aarch64/test_hotplug_pci.py
similarity index 100%
rename from tests/functional/test_aarch64_hotplug_pci.py
rename to tests/functional/aarch64/test_hotplug_pci.py
diff --git a/tests/functional/test_aarch64_imx8mp_evk.py b/tests/functional/aarch64/test_imx8mp_evk.py
similarity index 100%
rename from tests/functional/test_aarch64_imx8mp_evk.py
rename to tests/functional/aarch64/test_imx8mp_evk.py
diff --git a/tests/functional/aarch64/test_migration.py b/tests/functional/aarch64/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/aarch64/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/aarch64/test_multiprocess.py b/tests/functional/aarch64/test_multiprocess.py
new file mode 120000
index 00000000000..ff4ff5314a7
--- /dev/null
+++ b/tests/functional/aarch64/test_multiprocess.py
@@ -0,0 +1 @@
+../x86_64/test_multiprocess.py
\ No newline at end of file
diff --git a/tests/functional/test_aarch64_raspi3.py b/tests/functional/aarch64/test_raspi3.py
similarity index 100%
rename from tests/functional/test_aarch64_raspi3.py
rename to tests/functional/aarch64/test_raspi3.py
diff --git a/tests/functional/test_aarch64_raspi4.py b/tests/functional/aarch64/test_raspi4.py
similarity index 100%
rename from tests/functional/test_aarch64_raspi4.py
rename to tests/functional/aarch64/test_raspi4.py
diff --git a/tests/functional/test_aarch64_replay.py b/tests/functional/aarch64/test_replay.py
similarity index 100%
rename from tests/functional/test_aarch64_replay.py
rename to tests/functional/aarch64/test_replay.py
diff --git a/tests/functional/test_aarch64_reverse_debug.py b/tests/functional/aarch64/test_reverse_debug.py
similarity index 100%
rename from tests/functional/test_aarch64_reverse_debug.py
rename to tests/functional/aarch64/test_reverse_debug.py
diff --git a/tests/functional/test_aarch64_rme_sbsaref.py b/tests/functional/aarch64/test_rme_sbsaref.py
similarity index 98%
rename from tests/functional/test_aarch64_rme_sbsaref.py
rename to tests/functional/aarch64/test_rme_sbsaref.py
index 746770e776d..100f1c7738b 100755
--- a/tests/functional/test_aarch64_rme_sbsaref.py
+++ b/tests/functional/aarch64/test_rme_sbsaref.py
@@ -13,7 +13,7 @@
 
 from qemu_test import QemuSystemTest, Asset, wait_for_console_pattern
 from qemu_test import exec_command_and_wait_for_pattern
-from test_aarch64_rme_virt import test_realms_guest
+from test_rme_virt import test_realms_guest
 
 
 class Aarch64RMESbsaRefMachine(QemuSystemTest):
diff --git a/tests/functional/test_aarch64_rme_virt.py b/tests/functional/aarch64/test_rme_virt.py
similarity index 100%
rename from tests/functional/test_aarch64_rme_virt.py
rename to tests/functional/aarch64/test_rme_virt.py
diff --git a/tests/functional/test_aarch64_sbsaref.py b/tests/functional/aarch64/test_sbsaref.py
similarity index 100%
rename from tests/functional/test_aarch64_sbsaref.py
rename to tests/functional/aarch64/test_sbsaref.py
diff --git a/tests/functional/test_aarch64_sbsaref_alpine.py b/tests/functional/aarch64/test_sbsaref_alpine.py
similarity index 97%
rename from tests/functional/test_aarch64_sbsaref_alpine.py
rename to tests/functional/aarch64/test_sbsaref_alpine.py
index 87769993831..abb8f5114bd 100755
--- a/tests/functional/test_aarch64_sbsaref_alpine.py
+++ b/tests/functional/aarch64/test_sbsaref_alpine.py
@@ -12,7 +12,7 @@
 
 from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
-from test_aarch64_sbsaref import fetch_firmware
+from test_sbsaref import fetch_firmware
 
 
 class Aarch64SbsarefAlpine(QemuSystemTest):
diff --git a/tests/functional/test_aarch64_sbsaref_freebsd.py b/tests/functional/aarch64/test_sbsaref_freebsd.py
similarity index 97%
rename from tests/functional/test_aarch64_sbsaref_freebsd.py
rename to tests/functional/aarch64/test_sbsaref_freebsd.py
index 7ef016fba62..3b942f7795c 100755
--- a/tests/functional/test_aarch64_sbsaref_freebsd.py
+++ b/tests/functional/aarch64/test_sbsaref_freebsd.py
@@ -12,7 +12,7 @@
 
 from qemu_test import QemuSystemTest, Asset, skipSlowTest
 from qemu_test import wait_for_console_pattern
-from test_aarch64_sbsaref import fetch_firmware
+from test_sbsaref import fetch_firmware
 
 
 class Aarch64SbsarefFreeBSD(QemuSystemTest):
diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/aarch64/test_smmu.py
similarity index 100%
rename from tests/functional/test_aarch64_smmu.py
rename to tests/functional/aarch64/test_smmu.py
diff --git a/tests/functional/test_aarch64_tcg_plugins.py b/tests/functional/aarch64/test_tcg_plugins.py
similarity index 100%
rename from tests/functional/test_aarch64_tcg_plugins.py
rename to tests/functional/aarch64/test_tcg_plugins.py
diff --git a/tests/functional/test_aarch64_tuxrun.py b/tests/functional/aarch64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_aarch64_tuxrun.py
rename to tests/functional/aarch64/test_tuxrun.py
diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/aarch64/test_virt.py
similarity index 100%
rename from tests/functional/test_aarch64_virt.py
rename to tests/functional/aarch64/test_virt.py
diff --git a/tests/functional/test_aarch64_virt_gpu.py b/tests/functional/aarch64/test_virt_gpu.py
similarity index 100%
rename from tests/functional/test_aarch64_virt_gpu.py
rename to tests/functional/aarch64/test_virt_gpu.py
diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/aarch64/test_xen.py
similarity index 100%
rename from tests/functional/test_aarch64_xen.py
rename to tests/functional/aarch64/test_xen.py
diff --git a/tests/functional/test_aarch64_xlnx_versal.py b/tests/functional/aarch64/test_xlnx_versal.py
similarity index 100%
rename from tests/functional/test_aarch64_xlnx_versal.py
rename to tests/functional/aarch64/test_xlnx_versal.py
diff --git a/tests/functional/alpha/meson.build b/tests/functional/alpha/meson.build
new file mode 100644
index 00000000000..a69ac82dd2c
--- /dev/null
+++ b/tests/functional/alpha/meson.build
@@ -0,0 +1,9 @@
+
+tests_alpha_system_quick = [
+  'migration',
+]
+
+tests_alpha_system_thorough = [
+  'clipper',
+  'replay',
+]
diff --git a/tests/functional/test_alpha_clipper.py b/tests/functional/alpha/test_clipper.py
similarity index 100%
rename from tests/functional/test_alpha_clipper.py
rename to tests/functional/alpha/test_clipper.py
diff --git a/tests/functional/alpha/test_migration.py b/tests/functional/alpha/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/alpha/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_alpha_replay.py b/tests/functional/alpha/test_replay.py
similarity index 100%
rename from tests/functional/test_alpha_replay.py
rename to tests/functional/alpha/test_replay.py
diff --git a/tests/functional/arm/meson.build b/tests/functional/arm/meson.build
new file mode 100644
index 00000000000..59acfb10f1e
--- /dev/null
+++ b/tests/functional/arm/meson.build
@@ -0,0 +1,61 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_arm_timeouts = {
+  'aspeed_palmetto' : 120,
+  'aspeed_romulus' : 120,
+  'aspeed_witherspoon' : 120,
+  'aspeed_ast2500' : 720,
+  'aspeed_ast2600' : 1200,
+  'aspeed_bletchley' : 480,
+  'aspeed_catalina' : 480,
+  'aspeed_gb200nvl_bmc' : 480,
+  'aspeed_rainier' : 480,
+  'bpim2u' : 500,
+  'collie' : 180,
+  'cubieboard' : 360,
+  'orangepi' : 540,
+  'quanta_gsj' : 240,
+  'raspi2' : 120,
+  'replay' : 240,
+  'tuxrun' : 240,
+  'sx1' : 360,
+}
+
+tests_arm_system_quick = [
+  'migration',
+]
+
+tests_arm_system_thorough = [
+  'aspeed_ast1030',
+  'aspeed_palmetto',
+  'aspeed_romulus',
+  'aspeed_witherspoon',
+  'aspeed_ast2500',
+  'aspeed_ast2600',
+  'aspeed_bletchley',
+  'aspeed_catalina',
+  'aspeed_gb200nvl_bmc',
+  'aspeed_rainier',
+  'bpim2u',
+  'canona1100',
+  'collie',
+  'cubieboard',
+  'emcraft_sf2',
+  'integratorcp',
+  'microbit',
+  'orangepi',
+  'quanta_gsj',
+  'raspi2',
+  'realview',
+  'replay',
+  'smdkc210',
+  'stellaris',
+  'sx1',
+  'vexpress',
+  'virt',
+  'tuxrun',
+]
+
+tests_arm_linuxuser_thorough = [
+  'bflt',
+]
diff --git a/tests/functional/test_arm_aspeed_ast1030.py b/tests/functional/arm/test_aspeed_ast1030.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_ast1030.py
rename to tests/functional/arm/test_aspeed_ast1030.py
diff --git a/tests/functional/test_arm_aspeed_ast2500.py b/tests/functional/arm/test_aspeed_ast2500.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_ast2500.py
rename to tests/functional/arm/test_aspeed_ast2500.py
diff --git a/tests/functional/test_arm_aspeed_ast2600.py b/tests/functional/arm/test_aspeed_ast2600.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_ast2600.py
rename to tests/functional/arm/test_aspeed_ast2600.py
diff --git a/tests/functional/test_arm_aspeed_bletchley.py b/tests/functional/arm/test_aspeed_bletchley.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_bletchley.py
rename to tests/functional/arm/test_aspeed_bletchley.py
diff --git a/tests/functional/test_arm_aspeed_catalina.py b/tests/functional/arm/test_aspeed_catalina.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_catalina.py
rename to tests/functional/arm/test_aspeed_catalina.py
diff --git a/tests/functional/test_arm_aspeed_gb200nvl_bmc.py b/tests/functional/arm/test_aspeed_gb200nvl_bmc.py
old mode 100644
new mode 100755
similarity index 100%
rename from tests/functional/test_arm_aspeed_gb200nvl_bmc.py
rename to tests/functional/arm/test_aspeed_gb200nvl_bmc.py
diff --git a/tests/functional/test_arm_aspeed_palmetto.py b/tests/functional/arm/test_aspeed_palmetto.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_palmetto.py
rename to tests/functional/arm/test_aspeed_palmetto.py
diff --git a/tests/functional/test_arm_aspeed_rainier.py b/tests/functional/arm/test_aspeed_rainier.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_rainier.py
rename to tests/functional/arm/test_aspeed_rainier.py
diff --git a/tests/functional/test_arm_aspeed_romulus.py b/tests/functional/arm/test_aspeed_romulus.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_romulus.py
rename to tests/functional/arm/test_aspeed_romulus.py
diff --git a/tests/functional/test_arm_aspeed_witherspoon.py b/tests/functional/arm/test_aspeed_witherspoon.py
similarity index 100%
rename from tests/functional/test_arm_aspeed_witherspoon.py
rename to tests/functional/arm/test_aspeed_witherspoon.py
diff --git a/tests/functional/test_arm_bflt.py b/tests/functional/arm/test_bflt.py
similarity index 100%
rename from tests/functional/test_arm_bflt.py
rename to tests/functional/arm/test_bflt.py
diff --git a/tests/functional/test_arm_bpim2u.py b/tests/functional/arm/test_bpim2u.py
similarity index 100%
rename from tests/functional/test_arm_bpim2u.py
rename to tests/functional/arm/test_bpim2u.py
diff --git a/tests/functional/test_arm_canona1100.py b/tests/functional/arm/test_canona1100.py
similarity index 100%
rename from tests/functional/test_arm_canona1100.py
rename to tests/functional/arm/test_canona1100.py
diff --git a/tests/functional/test_arm_collie.py b/tests/functional/arm/test_collie.py
similarity index 100%
rename from tests/functional/test_arm_collie.py
rename to tests/functional/arm/test_collie.py
diff --git a/tests/functional/test_arm_cubieboard.py b/tests/functional/arm/test_cubieboard.py
similarity index 100%
rename from tests/functional/test_arm_cubieboard.py
rename to tests/functional/arm/test_cubieboard.py
diff --git a/tests/functional/test_arm_emcraft_sf2.py b/tests/functional/arm/test_emcraft_sf2.py
similarity index 100%
rename from tests/functional/test_arm_emcraft_sf2.py
rename to tests/functional/arm/test_emcraft_sf2.py
diff --git a/tests/functional/test_arm_integratorcp.py b/tests/functional/arm/test_integratorcp.py
similarity index 100%
rename from tests/functional/test_arm_integratorcp.py
rename to tests/functional/arm/test_integratorcp.py
diff --git a/tests/functional/test_arm_microbit.py b/tests/functional/arm/test_microbit.py
similarity index 100%
rename from tests/functional/test_arm_microbit.py
rename to tests/functional/arm/test_microbit.py
diff --git a/tests/functional/arm/test_migration.py b/tests/functional/arm/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/arm/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_arm_orangepi.py b/tests/functional/arm/test_orangepi.py
similarity index 100%
rename from tests/functional/test_arm_orangepi.py
rename to tests/functional/arm/test_orangepi.py
diff --git a/tests/functional/test_arm_quanta_gsj.py b/tests/functional/arm/test_quanta_gsj.py
similarity index 100%
rename from tests/functional/test_arm_quanta_gsj.py
rename to tests/functional/arm/test_quanta_gsj.py
diff --git a/tests/functional/test_arm_raspi2.py b/tests/functional/arm/test_raspi2.py
similarity index 100%
rename from tests/functional/test_arm_raspi2.py
rename to tests/functional/arm/test_raspi2.py
diff --git a/tests/functional/test_arm_realview.py b/tests/functional/arm/test_realview.py
similarity index 100%
rename from tests/functional/test_arm_realview.py
rename to tests/functional/arm/test_realview.py
diff --git a/tests/functional/test_arm_replay.py b/tests/functional/arm/test_replay.py
similarity index 100%
rename from tests/functional/test_arm_replay.py
rename to tests/functional/arm/test_replay.py
diff --git a/tests/functional/test_arm_smdkc210.py b/tests/functional/arm/test_smdkc210.py
similarity index 100%
rename from tests/functional/test_arm_smdkc210.py
rename to tests/functional/arm/test_smdkc210.py
diff --git a/tests/functional/test_arm_stellaris.py b/tests/functional/arm/test_stellaris.py
similarity index 100%
rename from tests/functional/test_arm_stellaris.py
rename to tests/functional/arm/test_stellaris.py
diff --git a/tests/functional/test_arm_sx1.py b/tests/functional/arm/test_sx1.py
similarity index 100%
rename from tests/functional/test_arm_sx1.py
rename to tests/functional/arm/test_sx1.py
diff --git a/tests/functional/test_arm_tuxrun.py b/tests/functional/arm/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_arm_tuxrun.py
rename to tests/functional/arm/test_tuxrun.py
diff --git a/tests/functional/test_arm_vexpress.py b/tests/functional/arm/test_vexpress.py
similarity index 100%
rename from tests/functional/test_arm_vexpress.py
rename to tests/functional/arm/test_vexpress.py
diff --git a/tests/functional/test_arm_virt.py b/tests/functional/arm/test_virt.py
similarity index 100%
rename from tests/functional/test_arm_virt.py
rename to tests/functional/arm/test_virt.py
diff --git a/tests/functional/avr/meson.build b/tests/functional/avr/meson.build
new file mode 100644
index 00000000000..b311ee89dc8
--- /dev/null
+++ b/tests/functional/avr/meson.build
@@ -0,0 +1,5 @@
+
+tests_avr_system_thorough = [
+  'mega2560',
+  'uno',
+]
diff --git a/tests/functional/test_avr_mega2560.py b/tests/functional/avr/test_mega2560.py
similarity index 100%
rename from tests/functional/test_avr_mega2560.py
rename to tests/functional/avr/test_mega2560.py
diff --git a/tests/functional/test_avr_uno.py b/tests/functional/avr/test_uno.py
similarity index 100%
rename from tests/functional/test_avr_uno.py
rename to tests/functional/avr/test_uno.py
diff --git a/tests/functional/test_empty_cpu_model.py b/tests/functional/generic/test_empty_cpu_model.py
similarity index 100%
rename from tests/functional/test_empty_cpu_model.py
rename to tests/functional/generic/test_empty_cpu_model.py
diff --git a/tests/functional/test_info_usernet.py b/tests/functional/generic/test_info_usernet.py
similarity index 100%
rename from tests/functional/test_info_usernet.py
rename to tests/functional/generic/test_info_usernet.py
diff --git a/tests/functional/test_migration.py b/tests/functional/generic/test_migration.py
similarity index 100%
rename from tests/functional/test_migration.py
rename to tests/functional/generic/test_migration.py
diff --git a/tests/functional/test_version.py b/tests/functional/generic/test_version.py
similarity index 100%
rename from tests/functional/test_version.py
rename to tests/functional/generic/test_version.py
diff --git a/tests/functional/hppa/meson.build b/tests/functional/hppa/meson.build
new file mode 100644
index 00000000000..046241562cb
--- /dev/null
+++ b/tests/functional/hppa/meson.build
@@ -0,0 +1,4 @@
+
+tests_hppa_system_quick = [
+  'seabios',
+]
diff --git a/tests/functional/test_hppa_seabios.py b/tests/functional/hppa/test_seabios.py
similarity index 100%
rename from tests/functional/test_hppa_seabios.py
rename to tests/functional/hppa/test_seabios.py
diff --git a/tests/functional/i386/meson.build b/tests/functional/i386/meson.build
new file mode 100644
index 00000000000..90bed3cbc35
--- /dev/null
+++ b/tests/functional/i386/meson.build
@@ -0,0 +1,9 @@
+
+tests_i386_system_quick = [
+  'migration',
+]
+
+tests_i386_system_thorough = [
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/i386/test_migration.py b/tests/functional/i386/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/i386/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_i386_replay.py b/tests/functional/i386/test_replay.py
similarity index 100%
rename from tests/functional/test_i386_replay.py
rename to tests/functional/i386/test_replay.py
diff --git a/tests/functional/test_i386_tuxrun.py b/tests/functional/i386/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_i386_tuxrun.py
rename to tests/functional/i386/test_tuxrun.py
diff --git a/tests/functional/loongarch64/meson.build b/tests/functional/loongarch64/meson.build
new file mode 100644
index 00000000000..90f2e4056f4
--- /dev/null
+++ b/tests/functional/loongarch64/meson.build
@@ -0,0 +1,4 @@
+
+tests_loongarch64_system_thorough = [
+  'virt',
+]
diff --git a/tests/functional/test_loongarch64_virt.py b/tests/functional/loongarch64/test_virt.py
similarity index 100%
rename from tests/functional/test_loongarch64_virt.py
rename to tests/functional/loongarch64/test_virt.py
diff --git a/tests/functional/m68k/meson.build b/tests/functional/m68k/meson.build
new file mode 100644
index 00000000000..c499fecb3cf
--- /dev/null
+++ b/tests/functional/m68k/meson.build
@@ -0,0 +1,8 @@
+
+tests_m68k_system_thorough = [
+  'mcf5208evb',
+  'nextcube',
+  'replay',
+  'q800',
+  'tuxrun',
+]
diff --git a/tests/functional/test_m68k_mcf5208evb.py b/tests/functional/m68k/test_mcf5208evb.py
similarity index 100%
rename from tests/functional/test_m68k_mcf5208evb.py
rename to tests/functional/m68k/test_mcf5208evb.py
diff --git a/tests/functional/test_m68k_nextcube.py b/tests/functional/m68k/test_nextcube.py
similarity index 100%
rename from tests/functional/test_m68k_nextcube.py
rename to tests/functional/m68k/test_nextcube.py
diff --git a/tests/functional/test_m68k_q800.py b/tests/functional/m68k/test_q800.py
similarity index 100%
rename from tests/functional/test_m68k_q800.py
rename to tests/functional/m68k/test_q800.py
diff --git a/tests/functional/test_m68k_replay.py b/tests/functional/m68k/test_replay.py
similarity index 100%
rename from tests/functional/test_m68k_replay.py
rename to tests/functional/m68k/test_replay.py
diff --git a/tests/functional/test_m68k_tuxrun.py b/tests/functional/m68k/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_m68k_tuxrun.py
rename to tests/functional/m68k/test_tuxrun.py
diff --git a/tests/functional/meson.build b/tests/functional/meson.build
index 050c9000b95..c7ee4b1f172 100644
--- a/tests/functional/meson.build
+++ b/tests/functional/meson.build
@@ -9,63 +9,33 @@ if get_option('tcg_interpreter')
   subdir_done()
 endif
 
-# Timeouts for individual tests that can be slow e.g. with debugging enabled
-test_timeouts = {
-  'aarch64_aspeed_ast2700' : 600,
-  'aarch64_aspeed_ast2700fc' : 600,
-  'aarch64_device_passthrough' : 720,
-  'aarch64_imx8mp_evk' : 240,
-  'aarch64_raspi4' : 480,
-  'aarch64_reverse_debug' : 180,
-  'aarch64_rme_virt' : 1200,
-  'aarch64_rme_sbsaref' : 1200,
-  'aarch64_sbsaref_alpine' : 1200,
-  'aarch64_sbsaref_freebsd' : 720,
-  'aarch64_smmu' : 720,
-  'aarch64_tuxrun' : 240,
-  'aarch64_virt' : 360,
-  'aarch64_virt_gpu' : 480,
-  'acpi_bits' : 420,
-  'arm_aspeed_palmetto' : 120,
-  'arm_aspeed_romulus' : 120,
-  'arm_aspeed_witherspoon' : 120,
-  'arm_aspeed_ast2500' : 720,
-  'arm_aspeed_ast2600' : 1200,
-  'arm_aspeed_bletchley' : 480,
-  'arm_aspeed_catalina' : 480,
-  'arm_aspeed_gb200nvl_bmc' : 480,
-  'arm_aspeed_rainier' : 480,
-  'arm_bpim2u' : 500,
-  'arm_collie' : 180,
-  'arm_cubieboard' : 360,
-  'arm_orangepi' : 540,
-  'arm_quanta_gsj' : 240,
-  'arm_raspi2' : 120,
-  'arm_replay' : 240,
-  'arm_tuxrun' : 240,
-  'arm_sx1' : 360,
-  'intel_iommu': 300,
-  'mips_malta' : 480,
-  'mipsel_malta' : 420,
-  'mipsel_replay' : 480,
-  'mips64_malta' : 240,
-  'mips64el_malta' : 420,
-  'mips64el_replay' : 180,
-  'netdev_ethtool' : 180,
-  'ppc_40p' : 240,
-  'ppc64_hv' : 1000,
-  'ppc64_powernv' : 480,
-  'ppc64_pseries' : 480,
-  'ppc64_replay' : 210,
-  'ppc64_tuxrun' : 420,
-  'ppc64_mac99' : 120,
-  'riscv64_tuxrun' : 120,
-  's390x_ccw_virtio' : 420,
-  'sh4_tuxrun' : 240,
-  'virtio_balloon': 120,
-  'x86_64_kvm_xen' : 180,
-  'x86_64_replay' : 480,
-}
+subdir('aarch64')
+subdir('alpha')
+subdir('arm')
+subdir('avr')
+subdir('hppa')
+subdir('i386')
+subdir('loongarch64')
+subdir('m68k')
+subdir('microblaze')
+subdir('microblazeel')
+subdir('mips')
+subdir('mips64')
+subdir('mips64el')
+subdir('mipsel')
+subdir('or1k')
+subdir('ppc')
+subdir('ppc64')
+subdir('riscv32')
+subdir('riscv64')
+subdir('rx')
+subdir('s390x')
+subdir('sh4')
+subdir('sh4eb')
+subdir('sparc')
+subdir('sparc64')
+subdir('x86_64')
+subdir('xtensa')
 
 tests_generic_system = [
   'empty_cpu_model',
@@ -79,271 +49,6 @@ tests_generic_linuxuser = [
 tests_generic_bsduser = [
 ]
 
-tests_aarch64_system_quick = [
-  'migration',
-]
-
-tests_aarch64_system_thorough = [
-  'aarch64_aspeed_ast2700',
-  'aarch64_aspeed_ast2700fc',
-  'aarch64_device_passthrough',
-  'aarch64_hotplug_pci',
-  'aarch64_imx8mp_evk',
-  'aarch64_raspi3',
-  'aarch64_raspi4',
-  'aarch64_replay',
-  'aarch64_reverse_debug',
-  'aarch64_rme_virt',
-  'aarch64_rme_sbsaref',
-  'aarch64_sbsaref',
-  'aarch64_sbsaref_alpine',
-  'aarch64_sbsaref_freebsd',
-  'aarch64_smmu',
-  'aarch64_tcg_plugins',
-  'aarch64_tuxrun',
-  'aarch64_virt',
-  'aarch64_virt_gpu',
-  'aarch64_xen',
-  'aarch64_xlnx_versal',
-  'multiprocess',
-]
-
-tests_alpha_system_quick = [
-  'migration',
-]
-
-tests_alpha_system_thorough = [
-  'alpha_clipper',
-  'alpha_replay',
-]
-
-tests_arm_system_quick = [
-  'migration',
-]
-
-tests_arm_system_thorough = [
-  'arm_aspeed_ast1030',
-  'arm_aspeed_palmetto',
-  'arm_aspeed_romulus',
-  'arm_aspeed_witherspoon',
-  'arm_aspeed_ast2500',
-  'arm_aspeed_ast2600',
-  'arm_aspeed_bletchley',
-  'arm_aspeed_catalina',
-  'arm_aspeed_gb200nvl_bmc',
-  'arm_aspeed_rainier',
-  'arm_bpim2u',
-  'arm_canona1100',
-  'arm_collie',
-  'arm_cubieboard',
-  'arm_emcraft_sf2',
-  'arm_integratorcp',
-  'arm_microbit',
-  'arm_orangepi',
-  'arm_quanta_gsj',
-  'arm_raspi2',
-  'arm_realview',
-  'arm_replay',
-  'arm_smdkc210',
-  'arm_stellaris',
-  'arm_sx1',
-  'arm_vexpress',
-  'arm_virt',
-  'arm_tuxrun',
-]
-
-tests_arm_linuxuser_thorough = [
-  'arm_bflt',
-]
-
-tests_avr_system_thorough = [
-  'avr_mega2560',
-  'avr_uno',
-]
-
-tests_hppa_system_quick = [
-  'hppa_seabios',
-]
-
-tests_i386_system_quick = [
-  'migration',
-]
-
-tests_i386_system_thorough = [
-  'i386_replay',
-  'i386_tuxrun',
-]
-
-tests_loongarch64_system_thorough = [
-  'loongarch64_virt',
-]
-
-tests_m68k_system_thorough = [
-  'm68k_mcf5208evb',
-  'm68k_nextcube',
-  'm68k_replay',
-  'm68k_q800',
-  'm68k_tuxrun',
-]
-
-tests_microblaze_system_thorough = [
-  'microblaze_replay',
-  'microblaze_s3adsp1800'
-]
-
-tests_microblazeel_system_thorough = [
-  'microblazeel_s3adsp1800'
-]
-
-tests_mips_system_thorough = [
-  'mips_malta',
-  'mips_replay',
-  'mips_tuxrun',
-]
-
-tests_mipsel_system_thorough = [
-  'mipsel_malta',
-  'mipsel_replay',
-  'mipsel_tuxrun',
-]
-
-tests_mips64_system_thorough = [
-  'mips64_malta',
-  'mips64_tuxrun',
-]
-
-tests_mips64el_system_thorough = [
-  'mips64el_fuloong2e',
-  'mips64el_loongson3v',
-  'mips64el_malta',
-  'mips64el_replay',
-  'mips64el_tuxrun',
-]
-
-tests_or1k_system_thorough = [
-  'or1k_replay',
-  'or1k_sim',
-]
-
-tests_ppc_system_quick = [
-  'migration',
-  'ppc_74xx',
-]
-
-tests_ppc_system_thorough = [
-  'ppc_40p',
-  'ppc_amiga',
-  'ppc_bamboo',
-  'ppc_mac',
-  'ppc_mpc8544ds',
-  'ppc_replay',
-  'ppc_sam460ex',
-  'ppc_tuxrun',
-  'ppc_virtex_ml507',
-]
-
-tests_ppc64_system_quick = [
-  'migration',
-]
-
-tests_ppc64_system_thorough = [
-  'ppc64_e500',
-  'ppc64_hv',
-  'ppc64_powernv',
-  'ppc64_pseries',
-  'ppc64_replay',
-  'ppc64_reverse_debug',
-  'ppc64_tuxrun',
-  'ppc64_mac99',
-]
-
-tests_riscv32_system_quick = [
-  'migration',
-  'riscv_opensbi',
-]
-
-tests_riscv32_system_thorough = [
-  'riscv32_tuxrun',
-]
-
-tests_riscv64_system_quick = [
-  'migration',
-  'riscv_opensbi',
-]
-
-tests_riscv64_system_thorough = [
-  'riscv64_tuxrun',
-]
-
-tests_rx_system_thorough = [
-  'rx_gdbsim',
-]
-
-tests_s390x_system_thorough = [
-  's390x_ccw_virtio',
-  's390x_replay',
-  's390x_topology',
-  's390x_tuxrun',
-]
-
-tests_sh4_system_thorough = [
-  'sh4_r2d',
-  'sh4_tuxrun',
-]
-
-tests_sh4eb_system_thorough = [
-  'sh4eb_r2d',
-]
-
-tests_sparc_system_quick = [
-  'migration',
-]
-
-tests_sparc_system_thorough = [
-  'sparc_replay',
-  'sparc_sun4m',
-]
-
-tests_sparc64_system_quick = [
-  'migration',
-]
-
-tests_sparc64_system_thorough = [
-  'sparc64_sun4u',
-  'sparc64_tuxrun',
-]
-
-tests_x86_64_system_quick = [
-  'cpu_queries',
-  'mem_addr_space',
-  'migration',
-  'pc_cpu_hotplug_props',
-  'virtio_version',
-  'x86_cpu_model_versions',
-  'vnc',
-  'memlock',
-]
-
-tests_x86_64_system_thorough = [
-  'acpi_bits',
-  'intel_iommu',
-  'linux_initrd',
-  'multiprocess',
-  'netdev_ethtool',
-  'virtio_balloon',
-  'virtio_gpu',
-  'x86_64_hotplug_blk',
-  'x86_64_hotplug_cpu',
-  'x86_64_kvm_xen',
-  'x86_64_replay',
-  'x86_64_reverse_debug',
-  'x86_64_tuxrun',
-]
-
-tests_xtensa_system_thorough = [
-  'xtensa_lx60',
-  'xtensa_replay',
-]
 
 precache_all = []
 foreach speed : ['quick', 'thorough']
@@ -386,7 +91,11 @@ foreach speed : ['quick', 'thorough']
 
     foreach test : target_tests
       testname = '@0@-@1@'.format(target_base, test)
-      testfile = 'test_' + test + '.py'
+      if fs.exists('generic' / 'test_' + test + '.py')
+        testfile = 'generic' / 'test_' + test + '.py'
+      else
+        testfile = target_base / 'test_' + test + '.py'
+      endif
       testpath = meson.current_source_dir() / testfile
       teststamp = testname + '.tstamp'
       test_precache_env = environment()
@@ -400,6 +109,11 @@ foreach speed : ['quick', 'thorough']
                                build_by_default: false,
                                env: test_precache_env)
       precache_all += precache
+      if is_variable('test_' + target_base + '_timeouts')
+        time_out = get_variable('test_' + target_base + '_timeouts').get(test, 90)
+      else
+        time_out = 90
+      endif
 
       # Ideally we would add 'precache' to 'depends' here, such that
       # 'build_by_default: false' lets the pre-caching automatically
@@ -415,8 +129,8 @@ foreach speed : ['quick', 'thorough']
            env: test_env,
            args: [testpath],
            protocol: 'tap',
-           timeout: test_timeouts.get(test, 90),
-           priority: test_timeouts.get(test, 90),
+           timeout:  time_out,
+           priority: time_out,
            suite: suites)
     endforeach
   endforeach
diff --git a/tests/functional/microblaze/meson.build b/tests/functional/microblaze/meson.build
new file mode 100644
index 00000000000..a067393acdc
--- /dev/null
+++ b/tests/functional/microblaze/meson.build
@@ -0,0 +1,5 @@
+
+tests_microblaze_system_thorough = [
+  'replay',
+  's3adsp1800'
+]
diff --git a/tests/functional/test_microblaze_replay.py b/tests/functional/microblaze/test_replay.py
similarity index 100%
rename from tests/functional/test_microblaze_replay.py
rename to tests/functional/microblaze/test_replay.py
diff --git a/tests/functional/test_microblaze_s3adsp1800.py b/tests/functional/microblaze/test_s3adsp1800.py
similarity index 100%
rename from tests/functional/test_microblaze_s3adsp1800.py
rename to tests/functional/microblaze/test_s3adsp1800.py
diff --git a/tests/functional/microblazeel/meson.build b/tests/functional/microblazeel/meson.build
new file mode 100644
index 00000000000..69e3f58dd81
--- /dev/null
+++ b/tests/functional/microblazeel/meson.build
@@ -0,0 +1,4 @@
+
+tests_microblazeel_system_thorough = [
+  's3adsp1800'
+]
diff --git a/tests/functional/test_microblazeel_s3adsp1800.py b/tests/functional/microblazeel/test_s3adsp1800.py
similarity index 92%
rename from tests/functional/test_microblazeel_s3adsp1800.py
rename to tests/functional/microblazeel/test_s3adsp1800.py
index 915902d48bd..75ce8856ed1 100755
--- a/tests/functional/test_microblazeel_s3adsp1800.py
+++ b/tests/functional/microblazeel/test_s3adsp1800.py
@@ -7,7 +7,7 @@
 # This work is licensed under the terms of the GNU GPL, version 2 or
 # later. See the COPYING file in the top-level directory.
 
-from test_microblaze_s3adsp1800 import MicroblazeMachine
+from microblaze.test_s3adsp1800 import MicroblazeMachine
 
 
 class MicroblazeLittleEndianMachine(MicroblazeMachine):
diff --git a/tests/functional/mips/meson.build b/tests/functional/mips/meson.build
new file mode 100644
index 00000000000..3c09f461770
--- /dev/null
+++ b/tests/functional/mips/meson.build
@@ -0,0 +1,11 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_mips_timeouts = {
+  'malta' : 480,
+}
+
+tests_mips_system_thorough = [
+  'malta',
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mips_malta.py b/tests/functional/mips/test_malta.py
similarity index 100%
rename from tests/functional/test_mips_malta.py
rename to tests/functional/mips/test_malta.py
diff --git a/tests/functional/test_mips_replay.py b/tests/functional/mips/test_replay.py
similarity index 100%
rename from tests/functional/test_mips_replay.py
rename to tests/functional/mips/test_replay.py
diff --git a/tests/functional/test_mips_tuxrun.py b/tests/functional/mips/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mips_tuxrun.py
rename to tests/functional/mips/test_tuxrun.py
diff --git a/tests/functional/mips64/meson.build b/tests/functional/mips64/meson.build
new file mode 100644
index 00000000000..65166fc1a45
--- /dev/null
+++ b/tests/functional/mips64/meson.build
@@ -0,0 +1,10 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_mips64_timeouts = {
+  'malta' : 240,
+}
+
+tests_mips64_system_thorough = [
+  'malta',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mips64_malta.py b/tests/functional/mips64/test_malta.py
similarity index 96%
rename from tests/functional/test_mips64_malta.py
rename to tests/functional/mips64/test_malta.py
index 53c3e0c1221..a553d3c5bc7 100755
--- a/tests/functional/test_mips64_malta.py
+++ b/tests/functional/mips64/test_malta.py
@@ -5,7 +5,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 
 from qemu_test import LinuxKernelTest, Asset
-from test_mips_malta import mips_check_wheezy
+from mips.test_malta import mips_check_wheezy
 
 
 class MaltaMachineConsole(LinuxKernelTest):
diff --git a/tests/functional/test_mips64_tuxrun.py b/tests/functional/mips64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mips64_tuxrun.py
rename to tests/functional/mips64/test_tuxrun.py
diff --git a/tests/functional/mips64el/meson.build b/tests/functional/mips64el/meson.build
new file mode 100644
index 00000000000..096b12dc607
--- /dev/null
+++ b/tests/functional/mips64el/meson.build
@@ -0,0 +1,14 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_mips64el_timeouts = {
+  'malta' : 420,
+  'replay' : 180,
+}
+
+tests_mips64el_system_thorough = [
+  'fuloong2e',
+  'loongson3v',
+  'malta',
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mips64el_fuloong2e.py b/tests/functional/mips64el/test_fuloong2e.py
similarity index 100%
rename from tests/functional/test_mips64el_fuloong2e.py
rename to tests/functional/mips64el/test_fuloong2e.py
diff --git a/tests/functional/test_mips64el_loongson3v.py b/tests/functional/mips64el/test_loongson3v.py
similarity index 100%
rename from tests/functional/test_mips64el_loongson3v.py
rename to tests/functional/mips64el/test_loongson3v.py
diff --git a/tests/functional/test_mips64el_malta.py b/tests/functional/mips64el/test_malta.py
similarity index 98%
rename from tests/functional/test_mips64el_malta.py
rename to tests/functional/mips64el/test_malta.py
index 3cc79b74c18..8fdc49b3005 100755
--- a/tests/functional/test_mips64el_malta.py
+++ b/tests/functional/mips64el/test_malta.py
@@ -16,7 +16,7 @@
 from qemu_test import exec_command_and_wait_for_pattern
 from qemu_test import skipIfMissingImports, skipFlakyTest, skipUntrustedTest
 
-from test_mips_malta import mips_check_wheezy
+from mips.test_malta import mips_check_wheezy
 
 
 class MaltaMachineConsole(LinuxKernelTest):
@@ -191,7 +191,7 @@ def test_mips_malta_i6400_framebuffer_logo_8cores(self):
         self.do_test_i6400_framebuffer_logo(8)
 
 
-from test_mipsel_malta import MaltaMachineYAMON
+from mipsel.test_malta import MaltaMachineYAMON
 
 if __name__ == '__main__':
     LinuxKernelTest.main()
diff --git a/tests/functional/test_mips64el_replay.py b/tests/functional/mips64el/test_replay.py
similarity index 100%
rename from tests/functional/test_mips64el_replay.py
rename to tests/functional/mips64el/test_replay.py
diff --git a/tests/functional/test_mips64el_tuxrun.py b/tests/functional/mips64el/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mips64el_tuxrun.py
rename to tests/functional/mips64el/test_tuxrun.py
diff --git a/tests/functional/mipsel/meson.build b/tests/functional/mipsel/meson.build
new file mode 100644
index 00000000000..f719f03e1a3
--- /dev/null
+++ b/tests/functional/mipsel/meson.build
@@ -0,0 +1,12 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_mipsel_timeouts = {
+  'malta' : 420,
+  'replay' : 480,
+}
+
+tests_mipsel_system_thorough = [
+  'malta',
+  'replay',
+  'tuxrun',
+]
diff --git a/tests/functional/test_mipsel_malta.py b/tests/functional/mipsel/test_malta.py
similarity index 98%
rename from tests/functional/test_mipsel_malta.py
rename to tests/functional/mipsel/test_malta.py
index 9ee2884da8e..427e163d19d 100755
--- a/tests/functional/test_mipsel_malta.py
+++ b/tests/functional/mipsel/test_malta.py
@@ -13,7 +13,7 @@
 from qemu_test import interrupt_interactive_console_until_pattern
 from qemu_test import wait_for_console_pattern
 
-from test_mips_malta import mips_check_wheezy
+from mips.test_malta import mips_check_wheezy
 
 
 class MaltaMachineConsole(LinuxKernelTest):
diff --git a/tests/functional/test_mipsel_replay.py b/tests/functional/mipsel/test_replay.py
similarity index 100%
rename from tests/functional/test_mipsel_replay.py
rename to tests/functional/mipsel/test_replay.py
diff --git a/tests/functional/test_mipsel_tuxrun.py b/tests/functional/mipsel/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_mipsel_tuxrun.py
rename to tests/functional/mipsel/test_tuxrun.py
diff --git a/tests/functional/or1k/meson.build b/tests/functional/or1k/meson.build
new file mode 100644
index 00000000000..e439087d938
--- /dev/null
+++ b/tests/functional/or1k/meson.build
@@ -0,0 +1,5 @@
+
+tests_or1k_system_thorough = [
+  'replay',
+  'sim',
+]
diff --git a/tests/functional/test_or1k_replay.py b/tests/functional/or1k/test_replay.py
similarity index 100%
rename from tests/functional/test_or1k_replay.py
rename to tests/functional/or1k/test_replay.py
diff --git a/tests/functional/test_or1k_sim.py b/tests/functional/or1k/test_sim.py
similarity index 100%
rename from tests/functional/test_or1k_sim.py
rename to tests/functional/or1k/test_sim.py
diff --git a/tests/functional/ppc/meson.build b/tests/functional/ppc/meson.build
new file mode 100644
index 00000000000..81f73a44417
--- /dev/null
+++ b/tests/functional/ppc/meson.build
@@ -0,0 +1,22 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_ppc_timeouts = {
+  '40p' : 240,
+}
+
+tests_ppc_system_quick = [
+  'migration',
+  '74xx',
+]
+
+tests_ppc_system_thorough = [
+  '40p',
+  'amiga',
+  'bamboo',
+  'mac',
+  'mpc8544ds',
+  'replay',
+  'sam460ex',
+  'tuxrun',
+  'virtex_ml507',
+]
diff --git a/tests/functional/test_ppc_40p.py b/tests/functional/ppc/test_40p.py
similarity index 100%
rename from tests/functional/test_ppc_40p.py
rename to tests/functional/ppc/test_40p.py
diff --git a/tests/functional/test_ppc_74xx.py b/tests/functional/ppc/test_74xx.py
similarity index 100%
rename from tests/functional/test_ppc_74xx.py
rename to tests/functional/ppc/test_74xx.py
diff --git a/tests/functional/test_ppc_amiga.py b/tests/functional/ppc/test_amiga.py
similarity index 100%
rename from tests/functional/test_ppc_amiga.py
rename to tests/functional/ppc/test_amiga.py
diff --git a/tests/functional/test_ppc_bamboo.py b/tests/functional/ppc/test_bamboo.py
similarity index 100%
rename from tests/functional/test_ppc_bamboo.py
rename to tests/functional/ppc/test_bamboo.py
diff --git a/tests/functional/test_ppc_mac.py b/tests/functional/ppc/test_mac.py
similarity index 100%
rename from tests/functional/test_ppc_mac.py
rename to tests/functional/ppc/test_mac.py
diff --git a/tests/functional/ppc/test_migration.py b/tests/functional/ppc/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/ppc/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_ppc_mpc8544ds.py b/tests/functional/ppc/test_mpc8544ds.py
similarity index 100%
rename from tests/functional/test_ppc_mpc8544ds.py
rename to tests/functional/ppc/test_mpc8544ds.py
diff --git a/tests/functional/test_ppc_replay.py b/tests/functional/ppc/test_replay.py
similarity index 100%
rename from tests/functional/test_ppc_replay.py
rename to tests/functional/ppc/test_replay.py
diff --git a/tests/functional/test_ppc_sam460ex.py b/tests/functional/ppc/test_sam460ex.py
similarity index 100%
rename from tests/functional/test_ppc_sam460ex.py
rename to tests/functional/ppc/test_sam460ex.py
diff --git a/tests/functional/test_ppc_tuxrun.py b/tests/functional/ppc/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_ppc_tuxrun.py
rename to tests/functional/ppc/test_tuxrun.py
diff --git a/tests/functional/test_ppc_virtex_ml507.py b/tests/functional/ppc/test_virtex_ml507.py
similarity index 100%
rename from tests/functional/test_ppc_virtex_ml507.py
rename to tests/functional/ppc/test_virtex_ml507.py
diff --git a/tests/functional/ppc64/meson.build b/tests/functional/ppc64/meson.build
new file mode 100644
index 00000000000..58867c3b5b6
--- /dev/null
+++ b/tests/functional/ppc64/meson.build
@@ -0,0 +1,25 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_ppc64_timeouts = {
+  'hv' : 1000,
+  'powernv' : 480,
+  'pseries' : 480,
+  'replay' : 210,
+  'tuxrun' : 420,
+  'mac99' : 120,
+}
+
+tests_ppc64_system_quick = [
+  'migration',
+]
+
+tests_ppc64_system_thorough = [
+  'e500',
+  'hv',
+  'powernv',
+  'pseries',
+  'replay',
+  'reverse_debug',
+  'tuxrun',
+  'mac99',
+]
diff --git a/tests/functional/test_ppc64_e500.py b/tests/functional/ppc64/test_e500.py
similarity index 100%
rename from tests/functional/test_ppc64_e500.py
rename to tests/functional/ppc64/test_e500.py
diff --git a/tests/functional/test_ppc64_hv.py b/tests/functional/ppc64/test_hv.py
similarity index 100%
rename from tests/functional/test_ppc64_hv.py
rename to tests/functional/ppc64/test_hv.py
diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/ppc64/test_mac99.py
similarity index 100%
rename from tests/functional/test_ppc64_mac99.py
rename to tests/functional/ppc64/test_mac99.py
diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/ppc64/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_ppc64_powernv.py b/tests/functional/ppc64/test_powernv.py
similarity index 100%
rename from tests/functional/test_ppc64_powernv.py
rename to tests/functional/ppc64/test_powernv.py
diff --git a/tests/functional/test_ppc64_pseries.py b/tests/functional/ppc64/test_pseries.py
similarity index 100%
rename from tests/functional/test_ppc64_pseries.py
rename to tests/functional/ppc64/test_pseries.py
diff --git a/tests/functional/test_ppc64_replay.py b/tests/functional/ppc64/test_replay.py
similarity index 100%
rename from tests/functional/test_ppc64_replay.py
rename to tests/functional/ppc64/test_replay.py
diff --git a/tests/functional/test_ppc64_reverse_debug.py b/tests/functional/ppc64/test_reverse_debug.py
similarity index 100%
rename from tests/functional/test_ppc64_reverse_debug.py
rename to tests/functional/ppc64/test_reverse_debug.py
diff --git a/tests/functional/test_ppc64_tuxrun.py b/tests/functional/ppc64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_ppc64_tuxrun.py
rename to tests/functional/ppc64/test_tuxrun.py
diff --git a/tests/functional/riscv32/meson.build b/tests/functional/riscv32/meson.build
new file mode 100644
index 00000000000..19298b564fe
--- /dev/null
+++ b/tests/functional/riscv32/meson.build
@@ -0,0 +1,9 @@
+
+tests_riscv32_system_quick = [
+  'migration',
+  'opensbi',
+]
+
+tests_riscv32_system_thorough = [
+  'tuxrun',
+]
diff --git a/tests/functional/riscv32/test_migration.py b/tests/functional/riscv32/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/riscv32/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/riscv32/test_opensbi.py b/tests/functional/riscv32/test_opensbi.py
new file mode 120000
index 00000000000..67763bc7829
--- /dev/null
+++ b/tests/functional/riscv32/test_opensbi.py
@@ -0,0 +1 @@
+../riscv64/test_opensbi.py
\ No newline at end of file
diff --git a/tests/functional/test_riscv32_tuxrun.py b/tests/functional/riscv32/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_riscv32_tuxrun.py
rename to tests/functional/riscv32/test_tuxrun.py
diff --git a/tests/functional/riscv64/meson.build b/tests/functional/riscv64/meson.build
new file mode 100644
index 00000000000..c03772882cb
--- /dev/null
+++ b/tests/functional/riscv64/meson.build
@@ -0,0 +1,13 @@
+
+test_riscv64_timeouts = {
+  'tuxrun' : 120,
+}
+
+tests_riscv64_system_quick = [
+  'migration',
+  'opensbi',
+]
+
+tests_riscv64_system_thorough = [
+  'tuxrun',
+]
diff --git a/tests/functional/test_riscv_opensbi.py b/tests/functional/riscv64/test_opensbi.py
similarity index 100%
rename from tests/functional/test_riscv_opensbi.py
rename to tests/functional/riscv64/test_opensbi.py
diff --git a/tests/functional/test_riscv64_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_riscv64_tuxrun.py
rename to tests/functional/riscv64/test_tuxrun.py
diff --git a/tests/functional/rx/meson.build b/tests/functional/rx/meson.build
new file mode 100644
index 00000000000..da311c169e8
--- /dev/null
+++ b/tests/functional/rx/meson.build
@@ -0,0 +1,4 @@
+
+tests_rx_system_thorough = [
+  'gdbsim',
+]
diff --git a/tests/functional/test_rx_gdbsim.py b/tests/functional/rx/test_gdbsim.py
similarity index 100%
rename from tests/functional/test_rx_gdbsim.py
rename to tests/functional/rx/test_gdbsim.py
diff --git a/tests/functional/s390x/meson.build b/tests/functional/s390x/meson.build
new file mode 100644
index 00000000000..892e7d6dd52
--- /dev/null
+++ b/tests/functional/s390x/meson.build
@@ -0,0 +1,12 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_s390x_timeouts = {
+  'ccw_virtio' : 420,
+}
+
+tests_s390x_system_thorough = [
+  'ccw_virtio',
+  'replay',
+  'topology',
+  'tuxrun',
+]
diff --git a/tests/functional/test_s390x_ccw_virtio.py b/tests/functional/s390x/test_ccw_virtio.py
similarity index 100%
rename from tests/functional/test_s390x_ccw_virtio.py
rename to tests/functional/s390x/test_ccw_virtio.py
diff --git a/tests/functional/test_s390x_replay.py b/tests/functional/s390x/test_replay.py
similarity index 100%
rename from tests/functional/test_s390x_replay.py
rename to tests/functional/s390x/test_replay.py
diff --git a/tests/functional/test_s390x_topology.py b/tests/functional/s390x/test_topology.py
similarity index 100%
rename from tests/functional/test_s390x_topology.py
rename to tests/functional/s390x/test_topology.py
diff --git a/tests/functional/test_s390x_tuxrun.py b/tests/functional/s390x/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_s390x_tuxrun.py
rename to tests/functional/s390x/test_tuxrun.py
diff --git a/tests/functional/sh4/meson.build b/tests/functional/sh4/meson.build
new file mode 100644
index 00000000000..d731581048a
--- /dev/null
+++ b/tests/functional/sh4/meson.build
@@ -0,0 +1,10 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_sh4_timeouts = {
+  'tuxrun' : 240,
+}
+
+tests_sh4_system_thorough = [
+  'r2d',
+  'tuxrun',
+]
diff --git a/tests/functional/test_sh4_r2d.py b/tests/functional/sh4/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4_r2d.py
rename to tests/functional/sh4/test_r2d.py
diff --git a/tests/functional/test_sh4_tuxrun.py b/tests/functional/sh4/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_sh4_tuxrun.py
rename to tests/functional/sh4/test_tuxrun.py
diff --git a/tests/functional/sh4eb/meson.build b/tests/functional/sh4eb/meson.build
new file mode 100644
index 00000000000..5575e235776
--- /dev/null
+++ b/tests/functional/sh4eb/meson.build
@@ -0,0 +1,4 @@
+
+tests_sh4eb_system_thorough = [
+  'r2d',
+]
diff --git a/tests/functional/test_sh4eb_r2d.py b/tests/functional/sh4eb/test_r2d.py
similarity index 100%
rename from tests/functional/test_sh4eb_r2d.py
rename to tests/functional/sh4eb/test_r2d.py
diff --git a/tests/functional/sparc/meson.build b/tests/functional/sparc/meson.build
new file mode 100644
index 00000000000..18d9c75c23a
--- /dev/null
+++ b/tests/functional/sparc/meson.build
@@ -0,0 +1,9 @@
+
+tests_sparc_system_quick = [
+  'migration',
+]
+
+tests_sparc_system_thorough = [
+  'replay',
+  'sun4m',
+]
diff --git a/tests/functional/sparc/test_migration.py b/tests/functional/sparc/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/sparc/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_sparc_replay.py b/tests/functional/sparc/test_replay.py
similarity index 100%
rename from tests/functional/test_sparc_replay.py
rename to tests/functional/sparc/test_replay.py
diff --git a/tests/functional/test_sparc_sun4m.py b/tests/functional/sparc/test_sun4m.py
similarity index 100%
rename from tests/functional/test_sparc_sun4m.py
rename to tests/functional/sparc/test_sun4m.py
diff --git a/tests/functional/sparc64/meson.build b/tests/functional/sparc64/meson.build
new file mode 100644
index 00000000000..4a5a65defd3
--- /dev/null
+++ b/tests/functional/sparc64/meson.build
@@ -0,0 +1,9 @@
+
+tests_sparc64_system_quick = [
+  'migration',
+]
+
+tests_sparc64_system_thorough = [
+  'sun4u',
+  'tuxrun',
+]
diff --git a/tests/functional/sparc64/test_migration.py b/tests/functional/sparc64/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/sparc64/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_sparc64_sun4u.py b/tests/functional/sparc64/test_sun4u.py
similarity index 100%
rename from tests/functional/test_sparc64_sun4u.py
rename to tests/functional/sparc64/test_sun4u.py
diff --git a/tests/functional/test_sparc64_tuxrun.py b/tests/functional/sparc64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_sparc64_tuxrun.py
rename to tests/functional/sparc64/test_tuxrun.py
diff --git a/tests/functional/x86_64/meson.build b/tests/functional/x86_64/meson.build
new file mode 100644
index 00000000000..49b05a8a170
--- /dev/null
+++ b/tests/functional/x86_64/meson.build
@@ -0,0 +1,37 @@
+
+# Timeouts for individual tests that can be slow e.g. with debugging enabled
+test_x86_64_timeouts = {
+  'acpi_bits' : 420,
+  'intel_iommu': 300,
+  'netdev_ethtool' : 180,
+  'kvm_xen' : 180,
+  'replay' : 480,
+  'virtio_balloon': 120,
+}
+
+tests_x86_64_system_quick = [
+  'cpu_queries',
+  'mem_addr_space',
+  'migration',
+  'pc_cpu_hotplug_props',
+  'virtio_version',
+  'x86_cpu_model_versions',
+  'vnc',
+  'memlock',
+]
+
+tests_x86_64_system_thorough = [
+  'acpi_bits',
+  'intel_iommu',
+  'linux_initrd',
+  'multiprocess',
+  'netdev_ethtool',
+  'virtio_balloon',
+  'virtio_gpu',
+  'hotplug_blk',
+  'hotplug_cpu',
+  'kvm_xen',
+  'replay',
+  'reverse_debug',
+  'tuxrun',
+]
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/x86_64/test_acpi_bits.py
similarity index 100%
rename from tests/functional/test_acpi_bits.py
rename to tests/functional/x86_64/test_acpi_bits.py
diff --git a/tests/functional/test_cpu_queries.py b/tests/functional/x86_64/test_cpu_queries.py
similarity index 100%
rename from tests/functional/test_cpu_queries.py
rename to tests/functional/x86_64/test_cpu_queries.py
diff --git a/tests/functional/test_x86_64_hotplug_blk.py b/tests/functional/x86_64/test_hotplug_blk.py
similarity index 100%
rename from tests/functional/test_x86_64_hotplug_blk.py
rename to tests/functional/x86_64/test_hotplug_blk.py
diff --git a/tests/functional/test_x86_64_hotplug_cpu.py b/tests/functional/x86_64/test_hotplug_cpu.py
similarity index 100%
rename from tests/functional/test_x86_64_hotplug_cpu.py
rename to tests/functional/x86_64/test_hotplug_cpu.py
diff --git a/tests/functional/test_intel_iommu.py b/tests/functional/x86_64/test_intel_iommu.py
similarity index 100%
rename from tests/functional/test_intel_iommu.py
rename to tests/functional/x86_64/test_intel_iommu.py
diff --git a/tests/functional/test_x86_64_kvm_xen.py b/tests/functional/x86_64/test_kvm_xen.py
similarity index 100%
rename from tests/functional/test_x86_64_kvm_xen.py
rename to tests/functional/x86_64/test_kvm_xen.py
diff --git a/tests/functional/test_linux_initrd.py b/tests/functional/x86_64/test_linux_initrd.py
similarity index 100%
rename from tests/functional/test_linux_initrd.py
rename to tests/functional/x86_64/test_linux_initrd.py
diff --git a/tests/functional/test_mem_addr_space.py b/tests/functional/x86_64/test_mem_addr_space.py
similarity index 100%
rename from tests/functional/test_mem_addr_space.py
rename to tests/functional/x86_64/test_mem_addr_space.py
diff --git a/tests/functional/test_memlock.py b/tests/functional/x86_64/test_memlock.py
similarity index 100%
rename from tests/functional/test_memlock.py
rename to tests/functional/x86_64/test_memlock.py
diff --git a/tests/functional/x86_64/test_migration.py b/tests/functional/x86_64/test_migration.py
new file mode 120000
index 00000000000..3933b7f3345
--- /dev/null
+++ b/tests/functional/x86_64/test_migration.py
@@ -0,0 +1 @@
+../generic/test_migration.py
\ No newline at end of file
diff --git a/tests/functional/test_multiprocess.py b/tests/functional/x86_64/test_multiprocess.py
similarity index 100%
rename from tests/functional/test_multiprocess.py
rename to tests/functional/x86_64/test_multiprocess.py
diff --git a/tests/functional/test_netdev_ethtool.py b/tests/functional/x86_64/test_netdev_ethtool.py
similarity index 100%
rename from tests/functional/test_netdev_ethtool.py
rename to tests/functional/x86_64/test_netdev_ethtool.py
diff --git a/tests/functional/test_pc_cpu_hotplug_props.py b/tests/functional/x86_64/test_pc_cpu_hotplug_props.py
similarity index 100%
rename from tests/functional/test_pc_cpu_hotplug_props.py
rename to tests/functional/x86_64/test_pc_cpu_hotplug_props.py
diff --git a/tests/functional/test_x86_64_replay.py b/tests/functional/x86_64/test_replay.py
similarity index 100%
rename from tests/functional/test_x86_64_replay.py
rename to tests/functional/x86_64/test_replay.py
diff --git a/tests/functional/test_x86_64_reverse_debug.py b/tests/functional/x86_64/test_reverse_debug.py
similarity index 100%
rename from tests/functional/test_x86_64_reverse_debug.py
rename to tests/functional/x86_64/test_reverse_debug.py
diff --git a/tests/functional/test_x86_64_tuxrun.py b/tests/functional/x86_64/test_tuxrun.py
similarity index 100%
rename from tests/functional/test_x86_64_tuxrun.py
rename to tests/functional/x86_64/test_tuxrun.py
diff --git a/tests/functional/test_virtio_balloon.py b/tests/functional/x86_64/test_virtio_balloon.py
similarity index 100%
rename from tests/functional/test_virtio_balloon.py
rename to tests/functional/x86_64/test_virtio_balloon.py
diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/x86_64/test_virtio_gpu.py
similarity index 100%
rename from tests/functional/test_virtio_gpu.py
rename to tests/functional/x86_64/test_virtio_gpu.py
diff --git a/tests/functional/test_virtio_version.py b/tests/functional/x86_64/test_virtio_version.py
similarity index 100%
rename from tests/functional/test_virtio_version.py
rename to tests/functional/x86_64/test_virtio_version.py
diff --git a/tests/functional/test_vnc.py b/tests/functional/x86_64/test_vnc.py
similarity index 100%
rename from tests/functional/test_vnc.py
rename to tests/functional/x86_64/test_vnc.py
diff --git a/tests/functional/test_x86_cpu_model_versions.py b/tests/functional/x86_64/test_x86_cpu_model_versions.py
similarity index 100%
rename from tests/functional/test_x86_cpu_model_versions.py
rename to tests/functional/x86_64/test_x86_cpu_model_versions.py
diff --git a/tests/functional/xtensa/meson.build b/tests/functional/xtensa/meson.build
new file mode 100644
index 00000000000..ca1b6e943b4
--- /dev/null
+++ b/tests/functional/xtensa/meson.build
@@ -0,0 +1,5 @@
+
+tests_xtensa_system_thorough = [
+  'lx60',
+  'replay',
+]
diff --git a/tests/functional/test_xtensa_lx60.py b/tests/functional/xtensa/test_lx60.py
similarity index 100%
rename from tests/functional/test_xtensa_lx60.py
rename to tests/functional/xtensa/test_lx60.py
diff --git a/tests/functional/test_xtensa_replay.py b/tests/functional/xtensa/test_replay.py
similarity index 100%
rename from tests/functional/test_xtensa_replay.py
rename to tests/functional/xtensa/test_replay.py
-- 
2.50.0


