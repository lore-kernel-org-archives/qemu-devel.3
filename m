Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3F57D132C0
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 13:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7x4Q-0000zw-32; Mon, 04 Nov 2024 08:24:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7x4P-0000zM-6N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:24:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1t7x4M-0000Da-OZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 08:24:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730726672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6uN1sjVzKOJrMi/6kQaAPlZfGnXltZM56dgIRXxvSHM=;
 b=eC66pJQtH6jjeD9A9Uji/cbAGF1PkHccGpIa+Kz4FyJnR22Ik5ErUtRnJ8D8i2z7UJWLux
 dg1ttfRy5Zm/xbioLXtS1R9fiPdanXPuug30LOD0J9KXGiJk3vadSoU9U1oWK7DffCtmFb
 x0TRFRKj746NGYs48GOgzxhkhV584hg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-593-1Jjp9wr_MLmnEb1Hg0P0kQ-1; Mon,
 04 Nov 2024 08:24:29 -0500
X-MC-Unique: 1Jjp9wr_MLmnEb1Hg0P0kQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5A9EE1955F43; Mon,  4 Nov 2024 13:24:28 +0000 (UTC)
Received: from thuth-p1g4.str.redhat.com (dhcp-192-239.str.redhat.com
 [10.33.192.239])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 620C91956052; Mon,  4 Nov 2024 13:24:26 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 00/13] Misc patches (functional tests, next-cube machine,
 ...)
Date: Mon,  4 Nov 2024 14:24:25 +0100
Message-ID: <20241104132425.284772-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

The following changes since commit c94bee4cd6693c1c65ba43bb8970cf909dec378b:

  Merge tag 'for-upstream-i386' of https://gitlab.com/bonzini/qemu into staging (2024-11-02 16:21:38 +0000)

are available in the Git repository at:

  https://gitlab.com/thuth/qemu.git tags/pull-request-2024-11-04

for you to fetch changes up to 380f7268b7ba4a6db73bfcde53082b70add45caa:

  tests/functional: Convert the OrangePi tests to the functional framework (2024-11-04 14:16:12 +0100)

----------------------------------------------------------------
* Remove the redundant macOS-15 CI job
* Various fixes, improvements and additions for the functional test suite
* Restore the sh4eb target
* Fix the OpenBSD VM test
* Re-enable the pci-bridge device on s390x
* Minor clean-ups / fixes for the next-cube machine

v2: Dropped the problematic "Convert the riscv_opensbi avocado test" patch

----------------------------------------------------------------
Daniel P. Berrangé (2):
      tests/functional: make tuxrun disk images writable
      tests/functional: make cached asset files read-only

Mark Cave-Ayland (2):
      next-cube: fix up compilation when DEBUG_NEXT is enabled
      next-cube: remove cpu parameter from next_scsi_init()

Thomas Huth (9):
      .gitlab-ci.d/cirrus: Remove the macos-15 job
      Revert "Remove the unused sh4eb target"
      tests/functional: Add a test for sh4eb
      tests/vm/openbsd: Remove the "Time appears wrong" workaround
      tests/functional: Fix the s390x and ppc64 tuxrun tests
      hw/s390x: Re-enable the pci-bridge device on s390x
      tests/functional: Convert the tcg_plugins test
      tests/functional: Convert BananaPi tests to the functional framework
      tests/functional: Convert the OrangePi tests to the functional framework

 MAINTAINERS                                        |   3 +-
 configs/devices/sh4eb-softmmu/default.mak          |   3 +
 configs/targets/sh4eb-softmmu.mak                  |   2 +
 qapi/machine.json                                  |   2 +-
 hw/m68k/next-cube.c                                |  14 +-
 tests/qtest/endianness-test.c                      |   1 +
 tests/qtest/machine-none-test.c                    |   1 +
 .gitlab-ci.d/buildtest.yml                         |   2 +-
 .gitlab-ci.d/cirrus.yml                            |  22 +-
 .gitlab-ci.d/cirrus/macos-15.vars                  |  16 -
 .gitlab-ci.d/crossbuilds.yml                       |   2 +-
 .travis.yml                                        |   2 +-
 hw/s390x/Kconfig                                   |   1 +
 tests/avocado/boot_linux_console.py                | 411 ---------------------
 tests/functional/meson.build                       |  10 +
 tests/functional/qemu_test/asset.py                |   3 +
 tests/functional/qemu_test/tuxruntest.py           |  10 +-
 tests/functional/qemu_test/utils.py                |  21 ++
 .../test_aarch64_tcg_plugins.py}                   |  37 +-
 tests/functional/test_arm_bpim2u.py                | 206 +++++++++++
 tests/functional/test_arm_orangepi.py              | 270 ++++++++++++++
 tests/functional/test_ppc64_tuxrun.py              |   4 +-
 tests/functional/test_sh4eb_r2d.py                 |  33 ++
 tests/lcitool/refresh                              |   1 -
 tests/qemu-iotests/testenv.py                      |   1 +
 tests/qtest/meson.build                            |   1 +
 tests/vm/openbsd                                   |   1 -
 27 files changed, 594 insertions(+), 486 deletions(-)
 create mode 100644 configs/devices/sh4eb-softmmu/default.mak
 create mode 100644 configs/targets/sh4eb-softmmu.mak
 delete mode 100644 .gitlab-ci.d/cirrus/macos-15.vars
 rename tests/{avocado/tcg_plugins.py => functional/test_aarch64_tcg_plugins.py} (78%)
 mode change 100644 => 100755
 create mode 100755 tests/functional/test_arm_bpim2u.py
 create mode 100755 tests/functional/test_arm_orangepi.py
 create mode 100755 tests/functional/test_sh4eb_r2d.py


