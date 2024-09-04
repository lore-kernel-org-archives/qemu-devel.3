Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07BEFCD484C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2024 10:40:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slnQG-0000MM-V7; Wed, 04 Sep 2024 06:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQE-0000LG-D9
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1slnQA-0007Y5-JQ
 for qemu-devel@nongnu.org; Wed, 04 Sep 2024 06:39:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725446369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NqPZXSFO/HfLS+133y8ZnSDNvTNwjpt7XEALwFR65KY=;
 b=L9v/N41hTd1+dlANjuDykjlGozEhG1NHr11/fGaFljV+6sGeBnIMkhIJD3yWaBkK1CgobF
 vh8Btpj2EIya3ZHNimKCHyKq0mbymMLH3oQm09eK6JkIma/6/h3Xb3iyGlm6jDfgJ5SxdE
 qJZl0z3KmY+InH5ND++AWAjxvnx9GpY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-dJi3h_7VPYqlvZ1fhgMnQg-1; Wed,
 04 Sep 2024 06:39:28 -0400
X-MC-Unique: dJi3h_7VPYqlvZ1fhgMnQg-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 856341955F45; Wed,  4 Sep 2024 10:39:27 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.48])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0DD73195605A; Wed,  4 Sep 2024 10:39:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 00/42] Introduce new functional test framework
Date: Wed,  4 Sep 2024 12:38:35 +0200
Message-ID: <20240904103923.451847-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

The following changes since commit e638d685ec2a0700fb9529cbd1b2823ac4120c53:

  Open 9.2 development tree (2024-09-03 09:18:43 -0700)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-09-04

for you to fetch changes up to c3e24cff2b27d63ac4b56ac6d38ef1ae3a27d92f:

  docs/devel/testing: Add documentation for functional tests (2024-09-04 12:28:00 +0200)

----------------------------------------------------------------
* Bump Avocado to version 103
* Introduce new functional test framework for Python-based tests
* Convert many Avocado tests to the new functional test framework

----------------------------------------------------------------
Cleber Rosa (4):
      tests/avocado: machine aarch64: standardize location and RO access
      tests/avocado/boot_xen.py: fetch kernel during test setUp()
      tests/avocado/machine_aarch64_sbsaref.py: allow for rw usage of image
      Bump avocado to 103.0

Daniel P. Berrangé (2):
      tests/functional: add a module for handling asset download & caching
      tests/functional: enable pre-emptive caching of assets

Philippe Mathieu-Daudé (7):
      tests/functional: Convert ARM Integrator/CP avocado tests
      tests/functional: Convert Aarch64 SBSA-Ref avocado tests
      tests/functional: Convert Aarch64 Virt machine avocado tests
      tests/functional: Convert mips64el Fuloong2e avocado test (1/2)
      tests/functional: Add QemuUserTest class
      tests/functional: Convert ARM bFLT linux-user avocado test
      tests/avocado: Remove unused QemuUserTest class

Thomas Huth (29):
      tests/avocado/avocado_qemu: Fix the "from" statements in linuxtest.py
      tests/avocado/boot_linux_console: Remove the s390x subtest
      python: Install pycotap in our venv if necessary
      tests/functional: Add base classes for the upcoming pytest-based tests
      tests/functional: Set up logging
      tests/Makefile.include: Increase the level of indentation in the help text
      tests/functional: Prepare the meson build system for the functional tests
      tests/functional: Convert simple avocado tests into standalone python tests
      tests/functional: Convert avocado tests that just need a small adjustment
      tests/functional: Allow asset downloading with concurrent threads
      tests/functional: Convert some tests that download files via fetch_asset()
      tests/functional: Add a function for extracting files from an archive
      tests/functional: Convert some avocado tests that needed avocado.utils.archive
      tests/functional: Convert the s390x avocado tests into standalone tests
      tests/functional: Convert the x86_cpu_model_versions test
      tests/functional: Convert the microblaze avocado tests into standalone tests
      tests/functional: Convert the virtio_gpu avocado test into a standalone test
      tests/functional: Convert most ppc avocado tests into standalone tests
      tests/functional: Convert the ppc_amiga avocado test into a standalone test
      tests/functional: Convert the ppc_hv avocado test into a standalone test
      tests/functional: Convert the m68k nextcube test with tesseract
      tests/functional: Convert the acpi-bits test into a standalone test
      tests/functional: Convert the rx_gdbsim avocado test into a standalone test
      tests/functional: Convert the linux_initrd avocado test into a standalone test
      gitlab-ci: Add "check-functional" to the build tests
      docs/devel: Split testing docs from the build docs and move to separate folder
      docs/devel/testing: Split the Avocado documentation into a separate file
      docs/devel/testing: Rename avocado_qemu.Test class
      docs/devel/testing: Add documentation for functional tests

 MAINTAINERS                                        |  63 ++-
 docs/devel/index-build.rst                         |  14 +-
 docs/devel/index.rst                               |   1 +
 docs/devel/{ => testing}/acpi-bits.rst             |  62 +--
 docs/devel/testing/avocado.rst                     | 581 +++++++++++++++++++++
 docs/devel/{ => testing}/ci-definitions.rst.inc    |   0
 docs/devel/{ => testing}/ci-jobs.rst.inc           |   0
 docs/devel/{ => testing}/ci-runners.rst.inc        |   0
 docs/devel/{ => testing}/ci.rst                    |   0
 docs/devel/testing/functional.rst                  | 338 ++++++++++++
 docs/devel/{ => testing}/fuzzing.rst               |   0
 docs/devel/testing/index.rst                       |  16 +
 docs/devel/{testing.rst => testing/main.rst}       | 577 +-------------------
 docs/devel/{ => testing}/qgraph.rst                |   0
 docs/devel/{ => testing}/qtest.rst                 |   0
 .gitlab-ci.d/buildtest-template.yml                |  14 +-
 .gitlab-ci.d/buildtest.yml                         |  60 +--
 python/wheels/pycotap-1.3.1-py3-none-any.whl       | Bin 0 -> 5119 bytes
 pythondeps.toml                                    |   3 +-
 tests/Makefile.include                             |  44 +-
 tests/avocado/avocado_qemu/__init__.py             |  17 -
 tests/avocado/avocado_qemu/linuxtest.py            |   4 +-
 tests/avocado/boot_linux_console.py                |  20 -
 tests/avocado/boot_xen.py                          |  13 +-
 tests/avocado/load_bflt.py                         |  54 --
 tests/avocado/machine_arm_n8x0.py                  |   0
 tests/avocado/machine_microblaze.py                |  61 ---
 tests/avocado/machine_mips_loongson3v.py           |  39 --
 tests/avocado/machine_sparc64_sun4u.py             |  36 --
 tests/avocado/ppc_amiga.py                         |  38 --
 tests/avocado/tesseract_utils.py                   |  46 --
 .../acpi-bits/bits-config/bits-cfg.txt             |   0
 .../acpi-bits/bits-tests/smbios.py2                |   0
 .../acpi-bits/bits-tests/smilatency.py2            |   0
 .../acpi-bits/bits-tests/testacpi.py2              |   0
 .../acpi-bits/bits-tests/testcpuid.py2             |   0
 tests/functional/meson.build                       | 205 ++++++++
 tests/functional/qemu_test/__init__.py             |  14 +
 tests/functional/qemu_test/asset.py                | 171 ++++++
 tests/functional/qemu_test/cmd.py                  | 193 +++++++
 tests/functional/qemu_test/config.py               |  36 ++
 tests/functional/qemu_test/tesseract.py            |  35 ++
 tests/functional/qemu_test/testcase.py             | 202 +++++++
 tests/functional/qemu_test/utils.py                |  56 ++
 .../test_aarch64_sbsaref.py}                       | 148 ++----
 .../test_aarch64_virt.py}                          |  71 +--
 .../acpi-bits.py => functional/test_acpi_bits.py}  |  83 +--
 tests/functional/test_arm_bflt.py                  |  44 ++
 .../test_arm_canona1100.py}                        |  30 +-
 .../test_arm_integratorcp.py}                      |  56 +-
 .../test_avr_mega2560.py}                          |  22 +-
 .../test_cpu_queries.py}                           |  12 +-
 .../test_empty_cpu_model.py}                       |   7 +-
 .../test_info_usernet.py}                          |  11 +-
 .../test_linux_initrd.py}                          |  37 +-
 .../test_loongarch64_virt.py}                      |  46 +-
 .../test_m68k_nextcube.py}                         |  29 +-
 .../test_mem_addr_space.py}                        |  52 +-
 tests/functional/test_microblaze_s3adsp1800.py     |  40 ++
 tests/functional/test_microblazeel_s3adsp1800.py   |  42 ++
 .../test_mips64el_fuloong2e.py}                    |  33 +-
 tests/functional/test_mips64el_loongson3v.py       |  39 ++
 .../test_netdev_ethtool.py}                        |  51 +-
 .../test_pc_cpu_hotplug_props.py}                  |  11 +-
 .../test_ppc64_hv.py}                              |  52 +-
 .../test_ppc64_powernv.py}                         |  56 +-
 .../test_ppc64_pseries.py}                         |  56 +-
 .../ppc_405.py => functional/test_ppc_405.py}      |  29 +-
 .../ppc_prep_40p.py => functional/test_ppc_40p.py} |  65 +--
 .../ppc_74xx.py => functional/test_ppc_74xx.py}    |  74 ++-
 tests/functional/test_ppc_amiga.py                 |  43 ++
 .../test_ppc_bamboo.py}                            |  33 +-
 .../test_ppc_mpc8544ds.py}                         |  29 +-
 .../test_ppc_virtex_ml507.py}                      |  29 +-
 .../test_rx_gdbsim.py}                             |  54 +-
 .../test_s390x_ccw_virtio.py}                      |  81 ++-
 .../test_s390x_topology.py}                        |  86 ++-
 tests/functional/test_sparc64_sun4u.py             |  41 ++
 .../version.py => functional/test_version.py}      |  13 +-
 .../test_virtio_gpu.py}                            |  64 +--
 .../test_virtio_version.py}                        |   8 +-
 .../test_x86_cpu_model_versions.py}                |  65 +--
 tests/meson.build                                  |   1 +
 83 files changed, 2915 insertions(+), 1841 deletions(-)
 rename docs/devel/{ => testing}/acpi-bits.rst (78%)
 create mode 100644 docs/devel/testing/avocado.rst
 rename docs/devel/{ => testing}/ci-definitions.rst.inc (100%)
 rename docs/devel/{ => testing}/ci-jobs.rst.inc (100%)
 rename docs/devel/{ => testing}/ci-runners.rst.inc (100%)
 rename docs/devel/{ => testing}/ci.rst (100%)
 create mode 100644 docs/devel/testing/functional.rst
 rename docs/devel/{ => testing}/fuzzing.rst (100%)
 create mode 100644 docs/devel/testing/index.rst
 rename docs/devel/{testing.rst => testing/main.rst} (67%)
 rename docs/devel/{ => testing}/qgraph.rst (100%)
 rename docs/devel/{ => testing}/qtest.rst (100%)
 create mode 100644 python/wheels/pycotap-1.3.1-py3-none-any.whl
 delete mode 100644 tests/avocado/load_bflt.py
 mode change 100644 => 100755 tests/avocado/machine_arm_n8x0.py
 delete mode 100644 tests/avocado/machine_microblaze.py
 delete mode 100644 tests/avocado/machine_mips_loongson3v.py
 delete mode 100644 tests/avocado/machine_sparc64_sun4u.py
 delete mode 100644 tests/avocado/ppc_amiga.py
 delete mode 100644 tests/avocado/tesseract_utils.py
 rename tests/{avocado => functional}/acpi-bits/bits-config/bits-cfg.txt (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smbios.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/smilatency.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testacpi.py2 (100%)
 rename tests/{avocado => functional}/acpi-bits/bits-tests/testcpuid.py2 (100%)
 create mode 100644 tests/functional/meson.build
 create mode 100644 tests/functional/qemu_test/__init__.py
 create mode 100644 tests/functional/qemu_test/asset.py
 create mode 100644 tests/functional/qemu_test/cmd.py
 create mode 100644 tests/functional/qemu_test/config.py
 create mode 100644 tests/functional/qemu_test/tesseract.py
 create mode 100644 tests/functional/qemu_test/testcase.py
 create mode 100644 tests/functional/qemu_test/utils.py
 rename tests/{avocado/machine_aarch64_sbsaref.py => functional/test_aarch64_sbsaref.py} (55%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_aarch64_virt.py => functional/test_aarch64_virt.py} (68%)
 mode change 100644 => 100755
 rename tests/{avocado/acpi-bits.py => functional/test_acpi_bits.py} (86%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_arm_bflt.py
 rename tests/{avocado/machine_arm_canona1100.py => functional/test_arm_canona1100.py} (51%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_arm_integratorcp.py => functional/test_arm_integratorcp.py} (63%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py} (72%)
 mode change 100644 => 100755
 rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (85%)
 mode change 100644 => 100755
 rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
 mode change 100644 => 100755
 rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
 mode change 100644 => 100755
 rename tests/{avocado/linux_initrd.py => functional/test_linux_initrd.py} (76%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_loongarch.py => functional/test_loongarch64_virt.py} (54%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_m68k_nextcube.py => functional/test_m68k_nextcube.py} (75%)
 mode change 100644 => 100755
 rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (93%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_microblaze_s3adsp1800.py
 create mode 100755 tests/functional/test_microblazeel_s3adsp1800.py
 rename tests/{avocado/machine_mips_fuloong2e.py => functional/test_mips64el_fuloong2e.py} (58%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_mips64el_loongson3v.py
 rename tests/{avocado/netdev-ethtool.py => functional/test_netdev_ethtool.py} (66%)
 mode change 100644 => 100755
 rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (85%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_powernv.py => functional/test_ppc64_powernv.py} (71%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_pseries.py => functional/test_ppc64_pseries.py} (76%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (53%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_prep_40p.py => functional/test_ppc_40p.py} (51%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_ppc_amiga.py
 rename tests/{avocado/ppc_bamboo.py => functional/test_ppc_bamboo.py} (60%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_mpc8544ds.py => functional/test_ppc_mpc8544ds.py} (55%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_virtex_ml507.py => functional/test_ppc_virtex_ml507.py} (60%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_rx_gdbsim.py => functional/test_rx_gdbsim.py} (58%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (85%)
 mode change 100644 => 100755
 rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (88%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_sparc64_sun4u.py
 rename tests/{avocado/version.py => functional/test_version.py} (78%)
 mode change 100644 => 100755
 rename tests/{avocado/virtio-gpu.py => functional/test_virtio_gpu.py} (73%)
 mode change 100644 => 100755
 rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
 mode change 100644 => 100755
 rename tests/{avocado/x86_cpu_model_versions.py => functional/test_x86_cpu_model_versions.py} (92%)
 mode change 100644 => 100755


