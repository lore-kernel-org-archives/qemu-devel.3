Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0DBC3DA49
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 17:05:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYqGw-0007nA-VQ; Tue, 30 Jul 2024 13:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGp-0007cx-5j
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sYqGj-0002H9-TD
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 13:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722359050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0xDnJrdOJfTFX+NXouX4JdI9gc+HQvbK7DRgNBdMJsw=;
 b=NdGW/Db0t8cBr598484mrYdwlRpprz/44iFRwpMkjAzzNSG1CSGiNKnQf4LnxwSw5Kl1lJ
 mrAqO/o/WibG9IFYiTlc9tWTslS340QyN6DLJ63BuNQoYIlkT26Cz3sz4CBXbl7uZBnAVO
 VvvgJk9OqL/L3/NyrBcamug3W8SV+AU=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-346-mariU4NkOgyG0OFfC-wz0A-1; Tue,
 30 Jul 2024 13:03:55 -0400
X-MC-Unique: mariU4NkOgyG0OFfC-wz0A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DD8A619560B0; Tue, 30 Jul 2024 17:03:52 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.108])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3933E300018D; Tue, 30 Jul 2024 17:03:48 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 00/24] Convert avocado tests to normal Python unittests
Date: Tue, 30 Jul 2024 18:03:20 +0100
Message-ID: <20240730170347.4103919-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This series is an update to Thomas' v2:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg05805.html

wherein Thomas suggested someone could do the asset caching updates
while he is on vacation:

  https://lists.nongnu.org/archive/html/qemu-devel/2024-07/msg06228.html

hence this posting what I'm calling a v3.

The Avocado v88 that we use in QEMU is already on a life support
system: It is not supported by upstream anymore, and with the latest
versions of Python, it won't work anymore since it depends on the
"imp" module that has been removed in Python 3.12.

There have been several attempts to update the test suite in QEMU
to a newer version of Avocado, but so far no attempt has successfully
been merged yet.

Additionally, the whole "make check" test suite in QEMU is using the
meson test runner nowadays, so running the python-based tests via the
Avocodo test runner looks and feels quite like an oddball, requiring
the users to deal with the knowledge of multiple test runners in
parallel (e.g. the timeout settings work completely differently).

So instead of trying to update the python-based test suite in QEMU
to a newer version of Avocado, we should try to better integrate
it with the meson test runner instead. Indeed most tests work quite
nicely without the Avocado framework already, as you can see with
this patch series - it does not convert all tests, just a subset so
far, but this already proves that many tests only need small modifi-
cations to work without Avocado.

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

Still to be done: Update the documentation for this new test framework.

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

Daniel P. Berrangé (2):
  tests/functional: add a module for handling asset download & caching
  tests/functional: enable pre-emptive caching of assets

Thomas Huth (22):
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
  gitlab-ci: Add "check-functional" to the build tests

 .gitlab-ci.d/buildtest-template.yml           |   3 +-
 .gitlab-ci.d/buildtest.yml                    |  60 +++---
 MAINTAINERS                                   |  32 +--
 python/wheels/pycotap-1.3.1-py3-none-any.whl  | Bin 0 -> 5119 bytes
 pythondeps.toml                               |   1 +
 tests/Makefile.include                        |  42 ++--
 tests/avocado/machine_microblaze.py           |  61 ------
 tests/avocado/machine_mips_loongson3v.py      |  39 ----
 tests/avocado/machine_sparc64_sun4u.py        |  36 ----
 tests/avocado/ppc_amiga.py                    |  38 ----
 tests/avocado/riscv_opensbi.py                |  63 ------
 tests/avocado/tesseract_utils.py              |  46 -----
 .../acpi-bits/bits-config/bits-cfg.txt        |   0
 .../acpi-bits/bits-tests/smbios.py2           |   0
 .../acpi-bits/bits-tests/smilatency.py2       |   0
 .../acpi-bits/bits-tests/testacpi.py2         |   0
 .../acpi-bits/bits-tests/testcpuid.py2        |   0
 tests/functional/meson.build                  | 180 +++++++++++++++++
 tests/functional/qemu_test/__init__.py        |  14 ++
 tests/functional/qemu_test/asset.py           | 130 ++++++++++++
 tests/functional/qemu_test/cmd.py             | 171 ++++++++++++++++
 tests/functional/qemu_test/config.py          |  36 ++++
 tests/functional/qemu_test/tesseract.py       |  35 ++++
 tests/functional/qemu_test/testcase.py        | 187 ++++++++++++++++++
 tests/functional/qemu_test/utils.py           |  47 +++++
 .../test_acpi_bits.py}                        |  81 ++++----
 .../test_arm_canona1100.py}                   |  30 +--
 .../test_arm_n8x0.py}                         |  36 ++--
 .../test_avr_mega2560.py}                     |  22 ++-
 .../test_cpu_queries.py}                      |   7 +-
 .../test_empty_cpu_model.py}                  |   7 +-
 .../test_info_usernet.py}                     |  11 +-
 .../test_loongarch64_virt.py}                 |  46 +++--
 .../test_m68k_nextcube.py}                    |  29 +--
 .../test_mem_addr_space.py}                   |  52 +----
 .../functional/test_microblaze_s3adsp1800.py  |  39 ++++
 .../test_microblazeel_s3adsp1800.py           |  42 ++++
 tests/functional/test_mips64el_loongson3v.py  |  39 ++++
 .../test_netdev_ethtool.py}                   |  50 ++---
 .../test_pc_cpu_hotplug_props.py}             |  11 +-
 .../test_ppc64_hv.py}                         |  48 ++---
 .../test_ppc64_powernv.py}                    |  56 ++----
 .../test_ppc64_pseries.py}                    |  56 ++----
 .../ppc_405.py => functional/test_ppc_405.py} |  28 +--
 .../test_ppc_40p.py}                          |  63 +++---
 .../test_ppc_74xx.py}                         |  74 +++----
 tests/functional/test_ppc_amiga.py            |  42 ++++
 .../test_ppc_bamboo.py}                       |  32 +--
 .../test_ppc_mpc8544ds.py}                    |  28 +--
 .../test_ppc_virtex_ml507.py}                 |  28 +--
 tests/functional/test_riscv_opensbi.py        |  36 ++++
 .../test_rx_gdbsim.py}                        |  57 +++---
 .../test_s390x_ccw_virtio.py}                 |  79 ++++----
 .../test_s390x_topology.py}                   |  86 ++++----
 tests/functional/test_sparc64_sun4u.py        |  40 ++++
 .../version.py => functional/test_version.py} |  13 +-
 .../test_virtio_gpu.py}                       |  64 +++---
 .../test_virtio_version.py}                   |   8 +-
 .../test_x86_cpu_model_versions.py}           |  63 ++----
 tests/meson.build                             |   1 +
 60 files changed, 1631 insertions(+), 994 deletions(-)
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
 rename tests/{avocado/machine_arm_canona1100.py => functional/test_arm_canona1100.py} (52%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py} (51%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py} (73%)
 mode change 100644 => 100755
 rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (89%)
 mode change 100644 => 100755
 rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
 mode change 100644 => 100755
 rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_loongarch.py => functional/test_loongarch64_virt.py} (54%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_m68k_nextcube.py => functional/test_m68k_nextcube.py} (76%)
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
 rename tests/{avocado/ppc_hv_tests.py => functional/test_ppc64_hv.py} (88%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_powernv.py => functional/test_ppc64_powernv.py} (71%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_pseries.py => functional/test_ppc64_pseries.py} (76%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (53%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_prep_40p.py => functional/test_ppc_40p.py} (54%)
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
 rename tests/{avocado/machine_rx_gdbsim.py => functional/test_rx_gdbsim.py} (54%)
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
2.45.2


