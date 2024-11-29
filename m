Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07422D729EC
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 17:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH4q6-0003Us-I6; Fri, 29 Nov 2024 12:31:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4q4-0003Ua-D7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tH4q2-0000mb-8v
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 12:31:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732901488;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+iiRMg92nK9K8GAH+/oD5ArbocF+VqxtIY1Ga4iU5is=;
 b=SypxFzv5LTNe+AbrL5J98ApoYRoVb67XTBF5cSVXWO6WO3Bu1wwOd3Lzqr0tpDpNUYSTeW
 roLwDrpS+bYSdc3v3F0gEM5fJzjo4LqKzx3BFIKuJalyHMv99vo9OEgY20rHwQvgk52S2x
 oumEw0f+1qXEgK10nnFBksGYFpG20NM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-391-uxc5jacmNFeMzBCtqnsLyw-1; Fri,
 29 Nov 2024 12:31:25 -0500
X-MC-Unique: uxc5jacmNFeMzBCtqnsLyw-1
X-Mimecast-MFC-AGG-ID: uxc5jacmNFeMzBCtqnsLyw
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1BCA01954AEE; Fri, 29 Nov 2024 17:31:24 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2E96A1955F41; Fri, 29 Nov 2024 17:31:21 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 00/22 for 10.0] tests/functional: various improvements wrt
 assets/scratch files
Date: Fri, 29 Nov 2024 17:30:58 +0000
Message-ID: <20241129173120.761728-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.93,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrangé (22):
  tests/functional: increase timeouts for arm sx1 test
  tests/functional: remove unused system imports
  tests/functional: remove duplicated 'qemu_test' import statements
  tests/functional: remove pointless with statement
  tests/functional: remove duplicated 'which' function impl
  tests/functional: introduce some helpful decorators
  tests/functional: switch to new test skip decorators
  tests/functional: add helpers for building file paths
  tests/functional: switch over to using self.log_file(...)
  tests/functional: switch over to using self.build_file(...)
  tests/functional: switch over to using self.data_file(...)
  tests/functional: switch over to using self.scratch_file()
  tests/functional: switch over to using self.socket_dir(...)
  tests/functional: remove redundant 'rmtree' call
  tests/functional: add common zip_extract helper
  tests/functional: add common deb_extract helper
  tests/functional: generalize archive_extract
  tests/functional: add 'archive_extract' to QemuBaseTest
  tests/functional: convert tests to new archive_extract helper
  tests/functional: generalize uncompress
  tests/functional: add 'uncompress' to QemuBaseTest
  tests/functional: convert tests to new uncompress helper

 tests/functional/qemu_test/__init__.py        |   5 +-
 tests/functional/qemu_test/cmd.py             |  10 ++
 tests/functional/qemu_test/decorators.py      | 105 ++++++++++++
 tests/functional/qemu_test/linuxkernel.py     |  27 +---
 tests/functional/qemu_test/testcase.py        | 149 +++++++++++++++++-
 tests/functional/qemu_test/tuxruntest.py      |  11 +-
 tests/functional/qemu_test/utils.py           |  66 +++++++-
 tests/functional/test_aarch64_aspeed.py       |  21 +--
 tests/functional/test_aarch64_raspi3.py       |   9 +-
 tests/functional/test_aarch64_raspi4.py       |  25 ++-
 tests/functional/test_aarch64_sbsaref.py      |  16 +-
 .../functional/test_aarch64_sbsaref_alpine.py |   5 +-
 .../test_aarch64_sbsaref_freebsd.py           |   5 +-
 tests/functional/test_aarch64_virt.py         |  12 +-
 tests/functional/test_acpi_bits.py            | 121 +++++---------
 tests/functional/test_alpha_clipper.py        |   6 +-
 tests/functional/test_arm_aspeed.py           |  52 +++---
 tests/functional/test_arm_bflt.py             |  16 +-
 tests/functional/test_arm_bpim2u.py           |  44 +++---
 tests/functional/test_arm_canona1100.py       |  12 +-
 tests/functional/test_arm_collie.py           |   1 -
 tests/functional/test_arm_integratorcp.py     |  31 ++--
 tests/functional/test_arm_orangepi.py         |  53 +++----
 tests/functional/test_arm_raspi2.py           |  25 ++-
 tests/functional/test_arm_sx1.py              |   7 +-
 tests/functional/test_arm_vexpress.py         |   9 +-
 tests/functional/test_linux_initrd.py         |   7 +-
 tests/functional/test_loongarch64_virt.py     |   6 +-
 tests/functional/test_m68k_mcf5208evb.py      |   9 +-
 tests/functional/test_m68k_nextcube.py        |  19 +--
 tests/functional/test_m68k_q800.py            |   5 +-
 .../functional/test_microblaze_s3adsp1800.py  |  13 +-
 .../test_microblazeel_s3adsp1800.py           |  14 +-
 tests/functional/test_mips64el_fuloong2e.py   |  13 +-
 tests/functional/test_mips64el_loongson3v.py  |  10 +-
 tests/functional/test_mips64el_malta.py       |  49 +++---
 tests/functional/test_mips_malta.py           |  19 +--
 tests/functional/test_mipsel_malta.py         |  28 ++--
 tests/functional/test_multiprocess.py         |   4 +-
 tests/functional/test_netdev_ethtool.py       |   3 +-
 tests/functional/test_or1k_sim.py             |   8 +-
 tests/functional/test_ppc64_e500.py           |   6 +-
 tests/functional/test_ppc64_hv.py             |  49 ++----
 tests/functional/test_ppc64_powernv.py        |   3 +-
 tests/functional/test_ppc64_pseries.py        |   3 +-
 tests/functional/test_ppc_405.py              |   6 +-
 tests/functional/test_ppc_40p.py              |   9 +-
 tests/functional/test_ppc_74xx.py             |   3 +-
 tests/functional/test_ppc_amiga.py            |  20 ++-
 tests/functional/test_ppc_bamboo.py           |  20 +--
 tests/functional/test_ppc_mac.py              |   7 +-
 tests/functional/test_ppc_mpc8544ds.py        |  10 +-
 tests/functional/test_ppc_virtex_ml507.py     |  12 +-
 tests/functional/test_riscv_opensbi.py        |   4 +-
 tests/functional/test_rx_gdbsim.py            |  17 +-
 tests/functional/test_s390x_ccw_virtio.py     |  12 +-
 tests/functional/test_s390x_topology.py       |  15 +-
 tests/functional/test_sh4_r2d.py              |  14 +-
 tests/functional/test_sh4_tuxrun.py           |   4 -
 tests/functional/test_sh4eb_r2d.py            |  16 +-
 tests/functional/test_sparc64_sun4u.py        |  12 +-
 tests/functional/test_sparc_sun4m.py          |   6 +-
 tests/functional/test_virtio_gpu.py           |  19 +--
 tests/functional/test_virtio_version.py       |   2 -
 tests/functional/test_xtensa_lx60.py          |   7 +-
 65 files changed, 677 insertions(+), 649 deletions(-)
 create mode 100644 tests/functional/qemu_test/decorators.py

-- 
2.46.0


