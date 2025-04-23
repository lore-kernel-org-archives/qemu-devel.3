Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69108C369D3
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 07:42:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Uf0-0003A8-Ih; Wed, 23 Apr 2025 03:36:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uee-00031f-AJ
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u7Uea-0003A6-Uq
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 03:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745393779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fYQoN3SBlcP+Go0v5gdZyv/xbSdnuuoT5KgVlz9CSsw=;
 b=LwUP5/j5aQN/Vt6/OzvQlaNPgoAFah7LuO6/Oif8FtaMoqCMkobqYa4jWjMUEFwjUiRvbA
 RtRyyPIatm1Wz7b/hM4xPVqqaOoY/fQdMLLD0RHVT7/8191XJpgKXxgfNRGmm2yQVxmWFn
 f9hiIIoVMnykqh6gENkkllSdqcwdqVI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-403-c-w5aLIDPhW357qqXMz3CA-1; Wed,
 23 Apr 2025 03:36:14 -0400
X-MC-Unique: c-w5aLIDPhW357qqXMz3CA-1
X-Mimecast-MFC-AGG-ID: c-w5aLIDPhW357qqXMz3CA_1745393773
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5658B1801A11; Wed, 23 Apr 2025 07:36:13 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-219.str.redhat.com
 [10.33.192.219])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A97E619560A3; Wed, 23 Apr 2025 07:36:11 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 00/29] Machine types, s390x,
 functional tests and Avocado removal
Date: Wed, 23 Apr 2025 09:35:40 +0200
Message-ID: <20250423073610.271585-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

 Hi!

The following changes since commit 1da8f3a3c53b604edfe0d55e475102640490549e:

  Open 10.1 development tree (2025-04-22 15:09:23 -0400)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2025-04-23

for you to fetch changes up to 12c6b6153063aafcdbadca8fee7eac793ef85e4b:

  MAINTAINERS: Add functional tests that are not covered yet (2025-04-23 07:51:25 +0200)

----------------------------------------------------------------
* Remove the obsolete s390-ccw-virtio-2.9 machine type
* Prepare the dump-skeys QMP command for the universal binary project
* Add compat machine types for 10.1
* Convert the remaining Avocado tests to the functional framework
* Some more small fixes for the functional tests

----------------------------------------------------------------
Cornelia Huck (2):
      hw: add compat machines for 10.1
      tests/functional/test_vnc: skip test if no crypto backend available

Philippe Mathieu-Daudé (4):
      hw/s390x/skeys: Declare QOM types using DEFINE_TYPES() macro
      hw/s390x/skeys: Introduce TYPE_DUMP_SKEYS_INTERFACE
      hw/s390x/ccw: Have CCW machine implement a qmp_dump_skeys() callback
      qapi/machine: Make @dump-skeys command generic

Thomas Huth (23):
      hw/s390x/s390-virtio-ccw: Remove the deprecated 2.9 machine type
      hw/s390x/css: Remove the obsolete "css_migration_enabled" variable
      hw/s390x/s390-stattrib: Remove the old migration_enabled flag
      hw/intc/s390_flic: Remove the obsolete migration_enabled flag
      gitlab-ci: Remove the avocado tests from the CI pipelines
      tests/functional: Move the check for the parameters from avocado to functional
      tests/functional: Convert reverse_debugging tests to the functional framework
      tests/functional: Convert the i386 replay avocado test
      tests/avocado: Remove the LinuxKernelTest class
      tests/functional: Convert the 32-bit big endian Wheezy mips test
      tests/functional: Convert the 32-bit little endian Wheezy mips test
      tests/functional: Convert the 64-bit little endian Wheezy mips test
      tests/functional: Convert the 64-bit big endian Wheezy mips test
      tests/avocado: Remove the boot_linux.py tests
      tests/functional: Use the tuxrun kernel for the x86 replay test
      tests/functional: Use the tuxrun kernel for the aarch64 replay test
      tests/functional: Convert the SMMU test to the functional framework
      gitlab-ci: Update QEMU_JOB_AVOCADO and QEMU_CI_AVOCADO_TESTING
      docs/devel/testing: Dissolve the ci-definitions.rst.inc file
      Remove the remainders of the Avocado tests
      tests/functional: Remove semicolons at the end of lines
      tests/functional: Remove unnecessary import statements
      MAINTAINERS: Add functional tests that are not covered yet

 MAINTAINERS                                        |  28 +-
 docs/about/build-platforms.rst                     |  10 +-
 docs/devel/build-system.rst                        |  11 +-
 docs/devel/codebase.rst                            |   5 -
 docs/devel/testing/avocado.rst                     | 581 ---------------------
 docs/devel/testing/ci-definitions.rst.inc          | 121 -----
 docs/devel/testing/ci-jobs.rst.inc                 |  19 +-
 docs/devel/testing/ci.rst                          |  28 +-
 docs/devel/testing/functional.rst                  |   3 -
 docs/devel/testing/index.rst                       |   1 -
 docs/devel/testing/main.rst                        |  80 ++-
 tests/avocado/README.rst                           |  10 -
 configure                                          |   2 +-
 qapi/machine.json                                  |  18 +
 qapi/misc-target.json                              |  19 -
 include/hw/boards.h                                |   3 +
 include/hw/i386/pc.h                               |   3 +
 include/hw/s390x/css.h                             |   6 -
 include/hw/s390x/s390_flic.h                       |   1 -
 include/hw/s390x/storage-attributes.h              |   1 -
 include/hw/s390x/storage-keys.h                    |  16 +
 hw/arm/virt.c                                      |   9 +-
 hw/core/machine-qmp-cmds.c                         |  14 +
 hw/core/machine.c                                  |   3 +
 hw/i386/pc.c                                       |   3 +
 hw/i386/pc_piix.c                                  |  13 +-
 hw/i386/pc_q35.c                                   |  13 +-
 hw/intc/s390_flic.c                                |  14 -
 hw/m68k/virt.c                                     |   9 +-
 hw/ppc/spapr.c                                     |  15 +-
 hw/s390x/css.c                                     |  31 +-
 hw/s390x/s390-skeys.c                              |  47 +-
 hw/s390x/s390-stattrib-kvm.c                       |   2 +-
 hw/s390x/s390-stattrib.c                           |   7 +-
 hw/s390x/s390-virtio-ccw.c                         |  41 +-
 .gitlab-ci.d/base.yml                              |   8 +-
 .gitlab-ci.d/buildtest-template.yml                |  13 +-
 .gitlab-ci.d/buildtest.yml                         |  33 +-
 pythondeps.toml                                    |   8 +-
 tests/Makefile.include                             |  60 +--
 tests/avocado/avocado_qemu/__init__.py             | 424 ---------------
 tests/avocado/avocado_qemu/linuxtest.py            | 253 ---------
 tests/avocado/boot_linux.py                        | 132 -----
 tests/avocado/boot_linux_console.py                |  96 ----
 tests/avocado/linux_ssh_mips_malta.py              | 205 --------
 tests/avocado/replay_kernel.py                     | 110 ----
 tests/avocado/replay_linux.py                      | 206 --------
 tests/avocado/smmu.py                              | 139 -----
 tests/functional/aspeed.py                         |   2 +-
 tests/functional/meson.build                       |  13 +-
 tests/functional/qemu_test/ports.py                |   3 +-
 tests/functional/qemu_test/tuxruntest.py           |  11 +-
 tests/functional/qemu_test/uncompress.py           |   2 +-
 tests/{avocado => functional}/reverse_debugging.py | 114 +---
 tests/functional/test_aarch64_aspeed.py            |   2 +-
 tests/functional/test_aarch64_replay.py            |  37 +-
 tests/functional/test_aarch64_reverse_debug.py     |  38 ++
 tests/functional/test_aarch64_rme_sbsaref.py       |   6 +-
 tests/functional/test_aarch64_rme_virt.py          |   2 -
 tests/functional/test_aarch64_sbsaref_alpine.py    |   3 -
 tests/functional/test_aarch64_sbsaref_freebsd.py   |   2 -
 tests/functional/test_aarch64_smmu.py              | 205 ++++++++
 tests/functional/test_aarch64_tcg_plugins.py       |   1 -
 tests/functional/test_aarch64_virt.py              |   8 +-
 tests/functional/test_arm_aspeed_ast2500.py        |   9 +-
 tests/functional/test_arm_aspeed_ast2600.py        |  36 +-
 tests/functional/test_arm_aspeed_bletchley.py      |   4 +-
 tests/functional/test_arm_aspeed_palmetto.py       |   4 +-
 tests/functional/test_arm_aspeed_romulus.py        |   4 +-
 tests/functional/test_arm_aspeed_witherspoon.py    |   4 +-
 tests/functional/test_arm_bpim2u.py                |   2 +-
 tests/functional/test_arm_cubieboard.py            |   4 +-
 tests/functional/test_arm_orangepi.py              |   2 +-
 tests/functional/test_arm_quanta_gsj.py            |   2 -
 tests/functional/test_arm_smdkc210.py              |   2 -
 tests/functional/test_i386_replay.py               |  28 +
 tests/functional/test_migration.py                 |   3 +-
 tests/functional/test_mips64_malta.py              |  35 ++
 tests/functional/test_mips64el_malta.py            |  22 +
 tests/functional/test_mips64el_replay.py           |   6 +-
 tests/functional/test_mips_malta.py                | 108 +++-
 tests/functional/test_mips_replay.py               |   2 +-
 tests/functional/test_mipsel_malta.py              |  22 +
 tests/functional/test_mipsel_replay.py             |   2 +-
 tests/functional/test_ppc64_hv.py                  |   8 +-
 tests/functional/test_ppc64_reverse_debug.py       |  41 ++
 tests/functional/test_s390x_topology.py            |  12 +-
 tests/functional/test_vnc.py                       |   6 +-
 tests/functional/test_x86_64_kvm_xen.py            |   2 -
 tests/functional/test_x86_64_replay.py             |  43 +-
 tests/functional/test_x86_64_reverse_debug.py      |  36 ++
 91 files changed, 978 insertions(+), 2794 deletions(-)
 delete mode 100644 docs/devel/testing/avocado.rst
 delete mode 100644 docs/devel/testing/ci-definitions.rst.inc
 delete mode 100644 tests/avocado/README.rst
 delete mode 100644 tests/avocado/avocado_qemu/__init__.py
 delete mode 100644 tests/avocado/avocado_qemu/linuxtest.py
 delete mode 100644 tests/avocado/boot_linux.py
 delete mode 100644 tests/avocado/boot_linux_console.py
 delete mode 100644 tests/avocado/linux_ssh_mips_malta.py
 delete mode 100644 tests/avocado/replay_kernel.py
 delete mode 100644 tests/avocado/replay_linux.py
 delete mode 100644 tests/avocado/smmu.py
 rename tests/{avocado => functional}/reverse_debugging.py (66%)
 create mode 100755 tests/functional/test_aarch64_reverse_debug.py
 create mode 100755 tests/functional/test_aarch64_smmu.py
 create mode 100755 tests/functional/test_i386_replay.py
 create mode 100755 tests/functional/test_mips64_malta.py
 create mode 100755 tests/functional/test_ppc64_reverse_debug.py
 create mode 100755 tests/functional/test_x86_64_reverse_debug.py


