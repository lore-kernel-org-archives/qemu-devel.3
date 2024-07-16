Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D961C3DA60
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 11:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTgKI-0008K3-Vp; Tue, 16 Jul 2024 07:26:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKH-0008JS-8z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1sTgKE-0003dF-4G
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 07:26:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721129188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=C2NtiMdUDU8O1ji3B/Ts/+/4JAn9++G4TPFLaHbBtew=;
 b=PzR6ktZo7QQJEwPQQx/jX6mF4PNpZOpnY4DIusrgr6Lqw9MAVXj5pm6gyn3LZkqJn1EWOR
 r23NFuB+8RwyFDl7jlbkS6dRZD9zkrL2aWKdNDt1hxk+IzFLQ7ZQAQW8RfxtYZG/ezWNtw
 ZOgjeDlFZycnobC/nj71CQ6bb4sztog=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-636-FXIrBKIdNSKoo09s4TrRnA-1; Tue,
 16 Jul 2024 07:26:26 -0400
X-MC-Unique: FXIrBKIdNSKoo09s4TrRnA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9ED691944AA6; Tue, 16 Jul 2024 11:26:25 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.154])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE6411955E7F; Tue, 16 Jul 2024 11:26:15 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
Date: Tue, 16 Jul 2024 13:26:03 +0200
Message-ID: <20240716112614.1755692-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
been merged yet.

Additionally, the whole "make check" test suite in QEMU is using the
meson test runner nowadays, so running the python-based tests via the
Avocodo test runner looks and feels quite like an oddball, requiring
the users to deal with the knowledge of multiple test runners in
parallel (e.g. the timeout settings work completely differently).

So instead of trying to update the python-based test suite in QEMU
to a newer version of Avocado, we should maybe try to better integrate
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
 export PYTHONPATH=$HOME/qemu/build
 ~/qemu/tests/functional/test_virtio_version.py

The logs of the tests can be found in the build directory under
tests/functional/<testname> - console log and general logs will
be put in separate files there.

Still to be done: Update the documentation for this new test framework.

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

Thomas Huth (11):
  tests/functional: Add base classes for the upcoming pytest-based tests
  tests/functional: Convert simple avocado tests into standalone python
    tests
  tests/functional: Convert avocado tests that just need a small
    adjustment
  tests/functional: Add python-based tests to the meson build system
  tests/functional: Implement fetch_asset() method for downloading
    assets
  tests/functional: Convert some tests that download files via
    fetch_asset()
  tests/functional: Add a function for extracting files from an archive
  tests/functional: Convert some avocado tests that needed
    avocado.utils.archive
  tests/functional: Set up logging
  tests/functional: Convert the s390x avocado tests into standalone
    tests
  gitlab-ci: Add "check-functional" to the build tests

 MAINTAINERS                                   |  22 +-
 .gitlab-ci.d/buildtest-template.yml           |   3 +-
 .gitlab-ci.d/buildtest.yml                    |  60 +--
 pythondeps.toml                               |   3 +-
 tests/Makefile.include                        |  18 +-
 tests/functional/meson.build                  | 112 +++++
 tests/functional/qemu_test/__init__.py        | 384 ++++++++++++++++++
 tests/functional/qemu_test/utils.py           |  28 ++
 .../test_arm_canona1100.py}                   |  21 +-
 .../test_arm_n8x0.py}                         |  25 +-
 .../test_avr_mega2560.py}                     |  11 +-
 .../test_cpu_queries.py}                      |   7 +-
 .../test_empty_cpu_model.py}                  |   7 +-
 .../test_info_usernet.py}                     |  11 +-
 .../test_loongarch64_virt.py}                 |  16 +-
 .../test_mem_addr_space.py}                   |  53 +--
 .../test_mips64el_loongson3v.py}              |  26 +-
 .../test_netdev_ethtool.py}                   |  32 +-
 .../test_pc_cpu_hotplug_props.py}             |  11 +-
 .../ppc_405.py => functional/test_ppc_405.py} |  19 +-
 .../test_ppc_74xx.py}                         |  74 ++--
 .../test_ppc_bamboo.py}                       |  23 +-
 .../test_s390x_ccw_virtio.py}                 |  32 +-
 .../test_s390x_topology.py}                   |  70 ++--
 .../test_sparc64_sun4u.py}                    |  25 +-
 .../version.py => functional/test_version.py} |  13 +-
 .../test_virtio_version.py}                   |   8 +-
 tests/meson.build                             |   1 +
 28 files changed, 795 insertions(+), 320 deletions(-)
 create mode 100644 tests/functional/meson.build
 create mode 100644 tests/functional/qemu_test/__init__.py
 create mode 100644 tests/functional/qemu_test/utils.py
 rename tests/{avocado/machine_arm_canona1100.py => functional/test_arm_canona1100.py} (71%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_arm_n8x0.py => functional/test_arm_n8x0.py} (71%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_avr6.py => functional/test_avr_mega2560.py} (90%)
 mode change 100644 => 100755
 rename tests/{avocado/cpu_queries.py => functional/test_cpu_queries.py} (89%)
 mode change 100644 => 100755
 rename tests/{avocado/empty_cpu_model.py => functional/test_empty_cpu_model.py} (84%)
 mode change 100644 => 100755
 rename tests/{avocado/info_usernet.py => functional/test_info_usernet.py} (87%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_loongarch.py => functional/test_loongarch64_virt.py} (89%)
 mode change 100644 => 100755
 rename tests/{avocado/mem-addr-space-check.py => functional/test_mem_addr_space.py} (92%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_mips_loongson3v.py => functional/test_mips64el_loongson3v.py} (55%)
 mode change 100644 => 100755
 rename tests/{avocado/netdev-ethtool.py => functional/test_netdev_ethtool.py} (81%)
 mode change 100644 => 100755
 rename tests/{avocado/pc_cpu_hotplug_props.py => functional/test_pc_cpu_hotplug_props.py} (90%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_405.py => functional/test_ppc_405.py} (73%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_74xx.py => functional/test_ppc_74xx.py} (74%)
 mode change 100644 => 100755
 rename tests/{avocado/ppc_bamboo.py => functional/test_ppc_bamboo.py} (75%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_s390_ccw_virtio.py => functional/test_s390x_ccw_virtio.py} (95%)
 mode change 100644 => 100755
 rename tests/{avocado/s390_topology.py => functional/test_s390x_topology.py} (90%)
 mode change 100644 => 100755
 rename tests/{avocado/machine_sparc64_sun4u.py => functional/test_sparc64_sun4u.py} (60%)
 mode change 100644 => 100755
 rename tests/{avocado/version.py => functional/test_version.py} (78%)
 mode change 100644 => 100755
 rename tests/{avocado/virtio_version.py => functional/test_virtio_version.py} (98%)
 mode change 100644 => 100755

-- 
2.45.2


