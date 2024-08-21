Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 037FAC52D7C
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2024 08:31:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sgghS-0005RF-Ka; Wed, 21 Aug 2024 04:28:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgghQ-0005JW-2O
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:28:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sgghJ-0004Ep-KK
 for qemu-devel@nongnu.org; Wed, 21 Aug 2024 04:28:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1724228881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qpAh3texOuC/sA7VeEsoJpjOXu/2Jhg17cHfX0OTxfM=;
 b=NlrcsmIQewMot6JpdN7k6LyTstBRsa+Fhh9iXUElTzCmOvl+Eml2sb38Co9jUomJuflKBr
 qQA0ZGDIASS27Nx517PkgAwB4qyKcjPChNtbmR2dfPqP82OExOCfKEGB93Bd+9ytGSWfTH
 WTgKvcyy0r24yEfeAuUUMOK3Wrau/Us=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-199-s5K6A-GhOc2UENeOL5cFXA-1; Wed,
 21 Aug 2024 04:27:56 -0400
X-MC-Unique: s5K6A-GhOc2UENeOL5cFXA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C10E19792E6; Wed, 21 Aug 2024 08:27:53 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-191.str.redhat.com
 [10.33.192.191])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7C8C41955F1B; Wed, 21 Aug 2024 08:27:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Daniel P . Berrange" <berrange@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v4 00/35] Convert avocado tests to normal Python unittests
Date: Wed, 21 Aug 2024 10:27:01 +0200
Message-ID: <20240821082748.65853-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The Avocado v88 that we use in QEMU is already on a life support
system: It is not supported by upstream anymore, and with the latest
versions of Python, it won't work anymore since it depends on the
"imp" module that has been removed in Python 3.12.

There have been several attempts to update the test suite in QEMU
to a newer version of Avocado, but so far no attempt has successfully
been merged yet. There's now a new attempt available (I've included
the relevant patches from Cleber at the beginning of this series now),
but still, it would be nicer to finally get away from the Avocado test
runner nowadays: The whole "make check" test suite in QEMU is using the
meson test runner nowadays, so running the python-based tests via the
Avocodo test runner looks and feels quite like an oddball, requiring
the users to deal with the knowledge of multiple test runners in
parallel (e.g. the timeout settings work completely differently).

So this series now starts integrating the python-based tests with the
test runner of meson instead. Indeed most tests work quite nicely
without the Avocado framework already. It does not convert all tests,
just a subset so far, but this already proves that many tests only need
small modifi- cations to work without Avocado.

Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
classes (e.g. based on cloud-init images or using SSH) really depend
on the Avocado framework, so we'd need a solution for those if we
want to continue using them. One solution might be to simply use the
required functions from avocado.utils for these tests, and still run
them via the meson test runner instead, but that needs some further
investigation that will be done later.

Now if you want to try out these patches: Apply the patches, then
recompile and then run:

 make check-functional

You can also run single targets e.g. with:

 make check-functional-ppc

You can also run the tests without any test runner now by
setting the PYTHONPATH environment variable to the "python" folder
of your source tree, and by specifying the build directory via
QEMU_BUILD_ROOT (if autodetection fails) and by specifying the
QEMU binary via QEMU_TEST_QEMU_BINARY. For example:

 export PYTHONPATH=$HOME/qemu/python
 export QEMU_TEST_QEMU_BINARY=qemu-system-x86_64
 export QEMU_BUILD_ROOT=$HOME/qemu/build
 ~/qemu/tests/functional/test_virtio_version.py

The logs of the tests can be found in the build directory under
tests/functional/<arch>/<testname> - console log and general logs will
be put in separate files there.

*** Note: The naming in the cache changed since v3 of this patch series.
*** If you already used v3 of this patch series and want to avoid
*** re-downloading all assets, you should rename the files in the cache
*** like this before running the tests again:

    cd ~/.cache/qemu/download/
    for i in * ; do mv -v $i $(sha256sum $i | cut -d " " -f 1);  done

New patches that should get reviewed:
- tests/avocado/avocado_qemu: Fix the "from" statements in linuxtest.py
- tests/avocado/boot_linux_console: Remove the s390x subtest
- tests/functional: Convert the linux_initrd avocado test into a standalone test
- The documentation patches at the end of this series

v4:
- Addressed review comments from v3 (e.g. update to MAINTAINERS file)
- Included Cleber's patches to update Avocado tests (to avoid conflicts)
- Drop sha1 support, use sha256 in all tests instead
- The files in the cache are now named after the sha256 of the file
  contents instead of the sha256 of the URL (to avoid redownloading
  if just the URL changed)
- Allow to set the cache location via environment variable and make
  sure that the cache gets saved in the gitlab-CI
- Run pre-caching as a separate command in the gitlab-CI since Ninja
  is disabled during "make check-*" in the functional-* CI jobs
- Convert the linux_initrd test to the new framework, too
- Fix documentation of the acpi-bits test
- Add documentation for the functional testing framework

v3:
- Split tests/functional/__init__.py into multiple files
- Introduce an 'Asset' class to handle downloading & caching
- Convert all tests to use new Asset class instead of 'fetch_asset'
- Ensure 'make check-functional' pre-caches all assets before
  running the tests, to avoid meson test timeouts due to slow
  downloads
- Fix bios bits test logging in verbose mode to not print subprocess
  output to stdout, since it confuses TAP parsing

v2:
- Addressed review feedback from v1
- Add pycotap as a wheel instead of trying to install it on demand
  when running "make check-functional" (works much better now!)
- Converted much more tests
- Lots of other small improvements here and there

RFC -> v1:
- Now using pycotap for running the tests instead of "pytest"
- Change the name from "tests/pytest" to "tests/functional" accordingly
- Make it possible to run the tests directly
- Use Python's urllib instead of wget for downloading
- Lots of makefile / meson integration improvements
- Converted more tests
- Update MAINTAINERS file accordingly
- Added a patch to run check-functional in the gitlab-CI
- ... lots of other changes I forgot about ... in fact, I changed so
  many things that I also did not dare to pick up the Reviewed-bys
  from the RFC

Cleber Rosa (4):
  tests/avocado: machine aarch64: standardize location and RO access
  tests/avocado/boot_xen.py: fetch kernel during test setUp()
  tests/avocado/machine_aarch64_sbsaref.py: allow for rw usage of image
  Bump avocado to 103.0

Daniel P. Berrangé (2):
  tests/functional: add a module for handling asset download & caching
  tests/functional: enable pre-emptive caching of assets

Thomas Huth (29):
  tests/avocado/avocado_qemu: Fix the "from" statements in linuxtest.py
  tests/avocado/boot_linux_console: Remove the s390x subtest
  python: Install pycotap in our venv if necessary
  tests/functional: Add base classes for the upcoming pytest-based tests
  tests/functional: Set up logging
  tests/Makefile.include: Increase the level of indentation in the help
    text
  tests/functional: Prepare the meson build system for the functional
    tests
  tests/functional: Convert simple avocado tests into standalone python
    tests
  tests/functional: Convert avocado tests that just need a small
    adjustment
  tests/functional: Convert some tests that download files via
    fetch_asset()
  tests/functional: Add a function for extracting files from an archive
  tests/functional: Convert some avocado tests that needed
    avocado.utils.archive
  tests/functional: Convert the s390x avocado tests into standalone
    tests
  tests/functional: Convert the x86_cpu_model_versions test
  tests/functional: Convert the microblaze avocado tests into standalone
    tests
  tests/functional: Convert the riscv_opensbi avocado test into a
    standalone test
  tests/functional: Convert the virtio_gpu avocado test into a
    standalone test
  tests/functional: Convert most ppc avocado tests into standalone tests
  tests/functional: Convert the ppc_amiga avocado test into a standalone
    test
  tests/functional: Convert the ppc_hv avocado test into a standalone
    test
  tests/functional: Convert the m68k nextcube test with tesseract
  tests/functional: Convert the acpi-bits test into a standalone test
  tests/functional: Convert the rx_gdbsim avocado test into a standalone
    test
  tests/functional: Convert the linux_initrd avocado test into a
    standalone test
  gitlab-ci: Add "check-functional" to the build tests
  docs/devel: Split testing docs from the build docs and move to
    separate folder
  docs/devel/testing: Split the Avocado documentation into a separate
    file
  docs/devel/testing: Rename avocado_qemu.Test class
  docs/devel/testing: Add documentation for functional tests

 MAINTAINERS                                   |  58 +-
 docs/devel/index-build.rst                    |  14 +-
 docs/devel/index.rst                          |   1 +
 docs/devel/{ => testing}/acpi-bits.rst        |  62 +-
 docs/devel/testing/avocado.rst                | 581 ++++++++++++++++++
 .../{ => testing}/ci-definitions.rst.inc      |   0
 docs/devel/{ => testing}/ci-jobs.rst.inc      |   0
 docs/devel/{ => testing}/ci-runners.rst.inc   |   0
 docs/devel/{ => testing}/ci.rst               |   0
 docs/devel/testing/functional.rst             | 269 ++++++++
 docs/devel/{ => testing}/fuzzing.rst          |   0
 docs/devel/testing/index.rst                  |  16 +
 docs/devel/{testing.rst => testing/main.rst}  | 577 +----------------
 docs/devel/{ => testing}/qgraph.rst           |   0
 docs/devel/{ => testing}/qtest.rst            |   0
 .gitlab-ci.d/buildtest-template.yml           |  14 +-
 .gitlab-ci.d/buildtest.yml                    |  60 +-
 python/wheels/pycotap-1.3.1-py3-none-any.whl  | Bin 0 -> 5119 bytes
 pythondeps.toml                               |   3 +-
 tests/Makefile.include                        |  44 +-
 tests/avocado/avocado_qemu/linuxtest.py       |   4 +-
 tests/avocado/boot_linux_console.py           |  20 -
 tests/avocado/boot_xen.py                     |  13 +-
 tests/avocado/machine_aarch64_sbsaref.py      |   4 +-
 tests/avocado/machine_aarch64_virt.py         |  14 +-
 tests/avocado/machine_microblaze.py           |  61 --
 tests/avocado/machine_mips_loongson3v.py      |  39 --
 tests/avocado/machine_sparc64_sun4u.py        |  36 --
 tests/avocado/ppc_amiga.py                    |  38 --
 tests/avocado/riscv_opensbi.py                |  63 --
 tests/avocado/tesseract_utils.py              |  46 --
 .../acpi-bits/bits-config/bits-cfg.txt        |   0
 .../acpi-bits/bits-tests/smbios.py2           |   0
 .../acpi-bits/bits-tests/smilatency.py2       |   0
 .../acpi-bits/bits-tests/testacpi.py2         |   0
 .../acpi-bits/bits-tests/testcpuid.py2        |   0
 tests/functional/meson.build                  | 183 ++++++
 tests/functional/qemu_test/__init__.py        |  14 +
 tests/functional/qemu_test/asset.py           | 131 ++++
 tests/functional/qemu_test/cmd.py             | 178 ++++++
 tests/functional/qemu_test/config.py          |  36 ++
 tests/functional/qemu_test/tesseract.py       |  35 ++
 tests/functional/qemu_test/testcase.py        | 185 ++++++
 tests/functional/qemu_test/utils.py           |  47 ++
 .../test_acpi_bits.py}                        |  83 +--
 .../test_arm_canona1100.py}                   |  30 +-
 .../test_arm_n8x0.py}                         |  36 +-
 .../test_avr_mega2560.py}                     |  22 +-
 .../test_cpu_queries.py}                      |  12 +-
 .../test_empty_cpu_model.py}                  |   7 +-
 .../test_info_usernet.py}                     |  11 +-
 .../test_linux_initrd.py}                     |  37 +-
 .../test_loongarch64_virt.py}                 |  46 +-
 .../test_m68k_nextcube.py}                    |  29 +-
 .../test_mem_addr_space.py}                   |  52 +-
 .../functional/test_microblaze_s3adsp1800.py  |  40 ++
 .../test_microblazeel_s3adsp1800.py           |  42 ++
 tests/functional/test_mips64el_loongson3v.py  |  39 ++
 .../test_netdev_ethtool.py}                   |  51 +-
 .../test_pc_cpu_hotplug_props.py}             |  11 +-
 .../test_ppc64_hv.py}                         |  53 +-
 .../test_ppc64_powernv.py}                    |  56 +-
 .../test_ppc64_pseries.py}                    |  56 +-
 .../ppc_405.py => functional/test_ppc_405.py} |  29 +-
 .../test_ppc_40p.py}                          |  65 +-
 .../test_ppc_74xx.py}                         |  74 +--
 tests/functional/test_ppc_amiga.py            |  43 ++
 .../test_ppc_bamboo.py}                       |  33 +-
 .../test_ppc_mpc8544ds.py}                    |  29 +-
 .../test_ppc_virtex_ml507.py}                 |  29 +-
 tests/functional/test_riscv_opensbi.py        |  36 ++
 .../test_rx_gdbsim.py}                        |  54 +-
 .../test_s390x_ccw_virtio.py}                 |  81 ++-
 .../test_s390x_topology.py}                   |  86 +--
 tests/functional/test_sparc64_sun4u.py        |  41 ++
 .../version.py => functional/test_version.py} |  13 +-
 .../test_virtio_gpu.py}                       |  64 +-
 .../test_virtio_version.py}                   |   8 +-
 .../test_x86_cpu_model_versions.py}           |  65 +-
 tests/meson.build                             |   1 +
 80 files changed, 2635 insertions(+), 1675 deletions(-)
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
 delete mode 100644 tests/avocado/machine_microblaze.py
 delete mode 100644 tests/avocado/machine_mips_loongson3v.py
 delete mode 100644 tests/avocado/machine_sparc64_sun4u.py
 delete mode 100644 tests/avocado/ppc_amiga.py
 delete mode 100644 tests/avocado/riscv_opensbi.py
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
 rename tests/{avocado/acpi-bits.py => functional/test_acpi_bits.py} (86%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_arm_canona1100.py => functional/test_arm_canona1100.py} (51%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py} (51%)
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
 create mode 100755 tests/functional/test_riscv_opensbi.py
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

-- 
2.46.0


