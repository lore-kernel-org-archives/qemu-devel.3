Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA3CE77184
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2024 16:00:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNZza-00049y-VW; Tue, 17 Dec 2024 11:00:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzY-00047h-Jq
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tNZzT-0001t2-I2
 for qemu-devel@nongnu.org; Tue, 17 Dec 2024 11:00:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734451205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tjqpfIdI9CfO0v7ldM8PG9XhuKTwfq7VED69Wr9Vhpc=;
 b=Zu3ztpBqxmGz2fuhVzjTJGsTOpyXWOIXOF4t/trqhM8Wo8xy9uyorWiDdl9M97nH8Kp5f1
 k8X5ikFVQzUEyL1xYHNsRKaMief+IUEHVNln0N8EIIGyI4vNPQ07PgqOXU1lqf9Q7FQ0Jo
 inlIRnPr7L2Rnj48bKrAoxi3uudm45s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-385-SeHsJ3l3Nwu1mI-htjqN0w-1; Tue,
 17 Dec 2024 10:59:59 -0500
X-MC-Unique: SeHsJ3l3Nwu1mI-htjqN0w-1
X-Mimecast-MFC-AGG-ID: SeHsJ3l3Nwu1mI-htjqN0w
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DA318195608C; Tue, 17 Dec 2024 15:59:57 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.136])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1C4930044C1; Tue, 17 Dec 2024 15:59:55 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 00/32] tests/functional: various improvements wrt
 assets/scratch files
Date: Tue, 17 Dec 2024 15:59:21 +0000
Message-ID: <20241217155953.3950506-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series is an attempt to bring a little more guaranteed order
to asset and scratch file handling in the functional tests. The
main highlights are:

 * Add custom @skipXXXXX decorators for common scenarios
   present in QEMU tests

 * Add helpers for creating file paths for various well
   known types of data, or well known locations, to avoid
   adhoc path manipulation

 * Add helpers to simplify uncompressing and extracting
   archives, from files downloaded as assets

The series overall has a neutral diffstat, but if you look at
just test files,  as opposed to the shared infra, you'll see
a significant reduction of lines of code in the tests, and I
believe its easier to read them with less boilerplate.

This is based on:

     https://gitlab.com/thuth/qemu.git tags/pull-request-2024-12-11

Changes in v3:

 * Rebase and update for recently changed/added tests
 * Drop mistaken submodule update
 * Fix syntax error with has_cmd usage
 * Fix undefined variable error in virtio gpu tests
 * Fix whitespace issues
 * Fix typos
 * Add patch to fix execute perms on some recent tests

Changes in v2:

 * Put archive & uncompress helpers in their own files
 * Have archive_extract & uncompress directly handle
   assets and format detection
 * Drop has_cmd/has_cmds helpers in favour of 'which'
 * Drop obsolete tessract version check
 * Simplify 'which' impl
 * Replace 'run_cmd' with direct use of subprocess
 * Remove even more unused imports
 * Gracefully handle asset download failure by skipping tests
 * Drop redundant hardcoded ./contrib path in virtio GPU test
 * Various docs improvements to decorators
 * Drop formatting change to import statements

Daniel P. Berrangé (32):
  tests/functional: add execute permission to aspeed tests
  tests/functional: remove many unused imports
  tests/functional: resolve str(Asset) to cache file path
  tests/functional: remove duplicated 'which' function impl
  tests/functional: simplify 'which' implementation
  tests/functional: drop 'tesseract_available' helper
  tests/functional: introduce some helpful decorators
  tests/functional: switch to new test skip decorators
  tests/functional: drop 'has_cmd' and 'has_cmds' helpers
  tests/functional: add helpers for building file paths
  tests/functional: switch over to using self.log_file(...)
  tests/functional: switch over to using self.build_file(...)
  tests/functional: switch over to using self.data_file(...)
  tests/functional: switch over to using self.scratch_file()
  tests/functional: remove redundant 'rmtree' call
  tests/functional: move archive handling into new archive.py file
  tests/functional: move uncompress handling into new uncompress.py file
  tests/functional: add common zip_extract helper
  tests/functional: add common deb_extract helper
  tests/functional: let cpio_extract accept filenames
  tests/functional: add a generalized archive_extract
  tests/functional: add 'archive_extract' to QemuBaseTest
  tests/functional: convert tests to new archive_extract helper
  tests/functional: add a generalized uncompress helper
  tests/functional: add 'uncompress' to QemuBaseTest
  tests/functional: convert tests to new uncompress helper
  tests/functional: drop back compat imports from utils.py
  tests/functional: replace 'run_cmd' with subprocess helpers
  tests/functional: remove now unused 'run_cmd' helper
  tests/functional: skip tests if assets are not available
  tests/functional: ignore errors when caching assets, except for 404
  MAINTAINERS: add myself as reviewer for functional test suite

 MAINTAINERS                                   |   1 +
 tests/functional/qemu_test/__init__.py        |   9 +-
 tests/functional/qemu_test/archive.py         | 117 ++++++++++
 tests/functional/qemu_test/asset.py           |  26 ++-
 tests/functional/qemu_test/cmd.py             |  76 ++-----
 tests/functional/qemu_test/decorators.py      | 107 +++++++++
 tests/functional/qemu_test/linuxkernel.py     |  29 +--
 tests/functional/qemu_test/tesseract.py       |  21 +-
 tests/functional/qemu_test/testcase.py        | 205 ++++++++++++++++--
 tests/functional/qemu_test/tuxruntest.py      |  19 +-
 tests/functional/qemu_test/uncompress.py      |  83 +++++++
 tests/functional/qemu_test/utils.py           |  45 ----
 tests/functional/test_aarch64_aspeed.py       |  23 +-
 tests/functional/test_aarch64_raspi3.py       |   9 +-
 tests/functional/test_aarch64_raspi4.py       |  21 +-
 tests/functional/test_aarch64_sbsaref.py      |  12 +-
 .../functional/test_aarch64_sbsaref_alpine.py |   1 -
 .../test_aarch64_sbsaref_freebsd.py           |   1 -
 tests/functional/test_aarch64_virt.py         |  14 +-
 tests/functional/test_acpi_bits.py            | 124 ++++-------
 tests/functional/test_alpha_clipper.py        |   6 +-
 tests/functional/test_arm_aspeed_ast1030.py   |  18 +-
 tests/functional/test_arm_aspeed_ast2500.py   |   8 +-
 tests/functional/test_arm_aspeed_ast2600.py   |  14 +-
 tests/functional/test_arm_aspeed_palmetto.py  |   0
 tests/functional/test_arm_aspeed_rainier.py   |  11 +-
 tests/functional/test_arm_aspeed_romulus.py   |   0
 tests/functional/test_arm_bflt.py             |  13 +-
 tests/functional/test_arm_bpim2u.py           |  44 ++--
 tests/functional/test_arm_canona1100.py       |  10 +-
 tests/functional/test_arm_collie.py           |   2 +-
 tests/functional/test_arm_cubieboard.py       |  40 ++--
 tests/functional/test_arm_emcraft_sf2.py      |   2 +-
 tests/functional/test_arm_integratorcp.py     |  28 +--
 tests/functional/test_arm_orangepi.py         |  60 +++--
 tests/functional/test_arm_raspi2.py           |  21 +-
 tests/functional/test_arm_smdkc210.py         |  18 +-
 tests/functional/test_arm_sx1.py              |   2 +-
 tests/functional/test_arm_vexpress.py         |  10 +-
 tests/functional/test_linux_initrd.py         |   7 +-
 tests/functional/test_m68k_mcf5208evb.py      |   8 +-
 tests/functional/test_m68k_nextcube.py        |  24 +-
 tests/functional/test_m68k_q800.py            |   5 +-
 .../functional/test_microblaze_s3adsp1800.py  |   9 +-
 .../test_microblazeel_s3adsp1800.py           |  10 +-
 tests/functional/test_mips64el_fuloong2e.py   |  10 +-
 tests/functional/test_mips64el_loongson3v.py  |   8 +-
 tests/functional/test_mips64el_malta.py       |  45 ++--
 tests/functional/test_mips_malta.py           |  19 +-
 tests/functional/test_mipsel_malta.py         |  24 +-
 tests/functional/test_or1k_sim.py             |   7 +-
 tests/functional/test_ppc64_e500.py           |   7 +-
 tests/functional/test_ppc64_hv.py             |  39 +---
 tests/functional/test_ppc64_tuxrun.py         |   7 +-
 tests/functional/test_ppc_40p.py              |   7 +-
 tests/functional/test_ppc_amiga.py            |  20 +-
 tests/functional/test_ppc_bamboo.py           |  15 +-
 tests/functional/test_ppc_mac.py              |   8 +-
 tests/functional/test_ppc_mpc8544ds.py        |   8 +-
 tests/functional/test_ppc_virtex_ml507.py     |  10 +-
 tests/functional/test_rx_gdbsim.py            |  13 +-
 tests/functional/test_s390x_ccw_virtio.py     |   6 +-
 tests/functional/test_s390x_topology.py       |   7 +-
 tests/functional/test_sh4_r2d.py              |  14 +-
 tests/functional/test_sh4eb_r2d.py            |  14 +-
 tests/functional/test_sparc64_sun4u.py        |  11 +-
 tests/functional/test_sparc_sun4m.py          |   7 +-
 tests/functional/test_virtio_gpu.py           |  16 +-
 tests/functional/test_xtensa_lx60.py          |   8 +-
 69 files changed, 887 insertions(+), 756 deletions(-)
 create mode 100644 tests/functional/qemu_test/archive.py
 create mode 100644 tests/functional/qemu_test/decorators.py
 create mode 100644 tests/functional/qemu_test/uncompress.py
 mode change 100644 => 100755 tests/functional/test_aarch64_aspeed.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast1030.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast2500.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_ast2600.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_palmetto.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_rainier.py
 mode change 100644 => 100755 tests/functional/test_arm_aspeed_romulus.py

-- 
2.46.0


