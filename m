Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1B98C369D1
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2024 11:14:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1stPv2-0006eL-Tg; Wed, 25 Sep 2024 07:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPv1-0006dR-5D
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1stPuz-0003Ts-6w
 for qemu-devel@nongnu.org; Wed, 25 Sep 2024 07:10:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727262648;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=1AfZmwu5X3//Ua0dr5ejW3eyiRNtFXNT7N1Uas9ZK1s=;
 b=D1WRXyyxWq2WfNApyRPbt/zHlUgvoBGtojbNO9rJupmSOEPFkusunh8KNawx/uPg+6SjLe
 YyFwNcn76WqSZUomcOxG/D0UFHnlcq7ZdkHtogW8EU0IJNY5SQHwcgedPLK/jteFuyDL5y
 dKSI4qS5DcsmN2aMc/Bk4dSdTP6rJ7o=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-vjCDR4myP0m9OANjCCfSSQ-1; Wed,
 25 Sep 2024 07:10:39 -0400
X-MC-Unique: vjCDR4myP0m9OANjCCfSSQ-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (unknown
 [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 79E4C196CE3F; Wed, 25 Sep 2024 11:10:38 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.193.206])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6803B1956094; Wed, 25 Sep 2024 11:10:35 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 00/44] Functional test conversion, and assert(0) cleanup
Date: Wed, 25 Sep 2024 13:09:41 +0200
Message-ID: <20240925111029.24082-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.108,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 01dc65a3bc262ab1bec8fe89775e9bbfa627becb:

  Merge tag 'pull-target-arm-20240919' of https://git.linaro.org/people/pmaydell/qemu-arm into staging (2024-09-19 14:15:15 +0100)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-25

for you to fetch changes up to dc05b2628e3913e668590ba66d9c618382d351ae:

  .gitlab-ci.d: Make separate collapsible log sections for build and test (2024-09-25 09:42:06 +0200)

----------------------------------------------------------------
* Convert more Avocado tests to the new functional test framework
* Clean up assert() statements, use g_assert_not_reached() when possible
* Improve output of the gitlab CI jobs

----------------------------------------------------------------
Peter Maydell (2):
      .gitlab-ci.d: Split build and test in cross build job templates
      .gitlab-ci.d: Make separate collapsible log sections for build and test

Pierrick Bouvier (34):
      hw/acpi: replace assert(0) with g_assert_not_reached()
      hw/arm: replace assert(0) with g_assert_not_reached()
      hw/net: replace assert(0) with g_assert_not_reached()
      migration: replace assert(0) with g_assert_not_reached()
      qobject: replace assert(0) with g_assert_not_reached()
      target/ppc: replace assert(0) with g_assert_not_reached()
      block: replace assert(false) with g_assert_not_reached()
      hw/hyperv: replace assert(false) with g_assert_not_reached()
      hw/net: replace assert(false) with g_assert_not_reached()
      hw/nvme: replace assert(false) with g_assert_not_reached()
      hw/pci: replace assert(false) with g_assert_not_reached()
      hw/ppc: replace assert(false) with g_assert_not_reached()
      migration: replace assert(false) with g_assert_not_reached()
      target/i386/kvm: replace assert(false) with g_assert_not_reached()
      accel/tcg: remove break after g_assert_not_reached()
      block: remove break after g_assert_not_reached()
      hw/acpi: remove break after g_assert_not_reached()
      hw/net: remove break after g_assert_not_reached()
      hw/scsi: remove break after g_assert_not_reached()
      hw/tpm: remove break after g_assert_not_reached()
      target/arm: remove break after g_assert_not_reached()
      target/riscv: remove break after g_assert_not_reached()
      fpu: remove break after g_assert_not_reached()
      tcg/loongarch64: remove break after g_assert_not_reached()
      include/qemu: remove return after g_assert_not_reached()
      hw/hyperv: remove return after g_assert_not_reached()
      hw/net: remove return after g_assert_not_reached()
      hw/pci: remove return after g_assert_not_reached()
      hw/ppc: remove return after g_assert_not_reached()
      migration: remove return after g_assert_not_reached()
      qobject: remove return after g_assert_not_reached()
      qom: remove return after g_assert_not_reached()
      tests/qtest: remove return after g_assert_not_reached()
      scripts/checkpatch.pl: emit error when using assert(false)

Thomas Huth (8):
      tests/functional/qemu_test: Add a function for launching kernels more easily
      tests/functional: Convert the vexpressa9 Avocado test
      tests/functional: Convert the xtensa lx60 Avocado test
      tests/functional: Convert the SPARCStation Avocado test
      tests/functional: Convert the e500 ppc64 Avocado test
      tests/functional: Convert the mac ppc Avocado tests
      tests/functional: Convert the r2d sh4 Avocado test
      tests/functional: Convert the powernv tests from boot_linux_console.py

 MAINTAINERS                               |   7 ++
 include/qemu/pmem.h                       |   1 -
 accel/tcg/plugin-gen.c                    |   1 -
 block/qcow2.c                             |   2 +-
 block/ssh.c                               |   1 -
 hw/acpi/aml-build.c                       |   3 +-
 hw/arm/highbank.c                         |   2 +-
 hw/hyperv/hyperv_testdev.c                |   7 +-
 hw/hyperv/vmbus.c                         |  15 ++--
 hw/net/e1000e_core.c                      |   4 +-
 hw/net/i82596.c                           |   2 +-
 hw/net/igb_core.c                         |   4 +-
 hw/net/net_rx_pkt.c                       |   3 +-
 hw/net/vmxnet3.c                          |   1 -
 hw/nvme/ctrl.c                            |   8 +-
 hw/pci/pci-stub.c                         |   6 +-
 hw/ppc/ppc.c                              |   1 -
 hw/ppc/spapr_events.c                     |   3 +-
 hw/scsi/virtio-scsi.c                     |   1 -
 hw/tpm/tpm_spapr.c                        |   1 -
 migration/dirtyrate.c                     |   3 +-
 migration/migration-hmp-cmds.c            |   2 +-
 migration/postcopy-ram.c                  |  21 ++---
 migration/ram.c                           |   8 +-
 qobject/qlit.c                            |   2 +-
 qobject/qnum.c                            |  12 +--
 qom/object.c                              |   1 -
 target/arm/hyp_gdbstub.c                  |   1 -
 target/i386/kvm/kvm.c                     |   4 +-
 target/ppc/dfp_helper.c                   |   8 +-
 target/ppc/mmu_helper.c                   |   2 +-
 target/riscv/monitor.c                    |   1 -
 tests/qtest/acpi-utils.c                  |   1 -
 fpu/softfloat-parts.c.inc                 |   2 -
 target/riscv/insn_trans/trans_rvv.c.inc   |   2 -
 tcg/loongarch64/tcg-target.c.inc          |   1 -
 .gitlab-ci.d/buildtest-template.yml       |  14 +++
 .gitlab-ci.d/buildtest.yml                |   1 +
 .gitlab-ci.d/crossbuild-template.yml      |  48 ++++++++++-
 scripts/checkpatch.pl                     |   4 +
 scripts/ci/gitlab-ci-section              |  29 +++++++
 tests/avocado/boot_linux_console.py       | 138 ------------------------------
 tests/functional/meson.build              |  15 ++++
 tests/functional/qemu_test/linuxkernel.py |  12 +++
 tests/functional/test_arm_vexpress.py     |  26 ++++++
 tests/functional/test_ppc64_e500.py       |  25 ++++++
 tests/functional/test_ppc64_powernv.py    |  42 ++++++++-
 tests/functional/test_ppc_mac.py          |  38 ++++++++
 tests/functional/test_sh4_r2d.py          |  31 +++++++
 tests/functional/test_sparc_sun4m.py      |  25 ++++++
 tests/functional/test_xtensa_lx60.py      |  26 ++++++
 51 files changed, 384 insertions(+), 234 deletions(-)
 create mode 100644 scripts/ci/gitlab-ci-section
 create mode 100755 tests/functional/test_arm_vexpress.py
 create mode 100755 tests/functional/test_ppc64_e500.py
 create mode 100755 tests/functional/test_ppc_mac.py
 create mode 100755 tests/functional/test_sh4_r2d.py
 create mode 100755 tests/functional/test_sparc_sun4m.py
 create mode 100755 tests/functional/test_xtensa_lx60.py


