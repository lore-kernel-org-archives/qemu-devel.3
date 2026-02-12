Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DDF3EEA855
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 21:40:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqePz-00085i-6U; Thu, 12 Feb 2026 16:40:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqePv-00084q-ST
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vqePt-00063j-Hq
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 16:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770932404;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=NjuOCJkRmcPBtUsbYSidFXeBIl2aE4XuKi+9rAlTYK8=;
 b=KyW7+XY8P4HZk+33zcfamizl/hjjopFpCTaP2zWJ4oAMVSanNm5+dSzNeGpH1yE5gfWl7e
 2vp6ggCXJrdr0N0Ijqstr3mMR03DK9LoE94J9ICcol1DFidKJwcN+ldsdyGUnNKSWaLFyx
 qAvzfWqO7S0qNzybbvVv1ECzU0XYrcg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-613-tVDiIjPgObu8sPtuoJUOyQ-1; Thu,
 12 Feb 2026 16:40:00 -0500
X-MC-Unique: tVDiIjPgObu8sPtuoJUOyQ-1
X-Mimecast-MFC-AGG-ID: tVDiIjPgObu8sPtuoJUOyQ_1770932399
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76FCE18004BB; Thu, 12 Feb 2026 21:39:59 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.55])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 03C081800669; Thu, 12 Feb 2026 21:39:57 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/16] aspeed queue
Date: Thu, 12 Feb 2026 22:39:39 +0100
Message-ID: <20260212213955.2225662-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

The following changes since commit 039fae56bb79af1124619daae60e01c257fcb2ee:

  Merge tag 'pull-request-2026-02-12v2' of https://gitlab.com/thuth/qemu into staging (2026-02-12 11:52:31 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260212

for you to fetch changes up to 1b662879513fa9823a887cac9cfc3d91b9d3f616:

  tests/functional/aarch64/test_aspeed_ast2700fc: Use AST2700 A2 SDK image for FC tests (2026-02-12 16:06:55 +0100)

----------------------------------------------------------------
aspeed-next queue:

* Adds support for the AST2700 A2 SoC, including a new machine and
  a functional test
* Enhances AST2600 OTP functional test
* Restructures Aspeed ARM tests into separate files for better
  parallelism.
* Includes new SDK tests with Linux 5.15.
* Fixes Aspeed I2C models

----------------------------------------------------------------
Cédric Le Goater (2):
      tests/functional: Split Aspeed ARM tests into separate files
      tests/functional: Add SDK tests with Linux 5.15

Jamin Lin (13):
      hw/i2c/aspeed_i2c: Fix out-of-bounds read in I2C MMIO handlers
      hw/i2c/aspeed_i2c: Increase I2C device register size to 0xA0
      hw/misc/aspeed_scu: Remove unused SoC silicon revision definitions
      hw/misc/aspeed_scu: Add AST2700 A2 silicon revisions
      hw/arm/aspeed_ast27x0: Add AST2700 A2 SoC support
      hw/arm/aspeed_ast27x0_evb: Add AST2700 A2 EVB machine
      hw/arm/aspeed_ast27x0_evb: Move ast2700-evb alias to AST2700 A2 EVB
      tests/qtest/ast2700-hace-test: Use ast2700-evb alias for AST2700 HACE tests
      tests/functional/aarch64/test_aspeed_ast2700: Rename AST2700 A1 test to reduce test runtime
      tests/functional/aarch64/test_aspeed_ast2700a2: Add AST2700 A2 EVB functional tests
      hw/arm/aspeed_ast27x0-fc: Switch AST2700 FC machine to A2 SoC
      hw/arm/aspeed_ast27x0-fc: Increase BMC DRAM size to 2GB for AST2700 A2
      tests/functional/aarch64/test_aspeed_ast2700fc: Use AST2700 A2 SDK image for FC tests

Kane Chen (1):
      tests/functional/arm/aspeed_ast2600: Enhance OTP test with functional validation

 include/hw/i2c/aspeed_i2c.h                        |   3 +-
 include/hw/misc/aspeed_scu.h                       |  11 +-
 hw/arm/aspeed_ast27x0-fc.c                         |  15 +-
 hw/arm/aspeed_ast27x0.c                            |  36 ++++
 hw/arm/aspeed_ast27x0_evb.c                        |  29 +++-
 hw/i2c/aspeed_i2c.c                                |  58 +++----
 hw/misc/aspeed_scu.c                               |  11 +-
 tests/qtest/ast2700-hace-test.c                    |  22 +--
 tests/functional/aarch64/meson.build               |   6 +-
 ..._aspeed_ast2700.py => test_aspeed_ast2700a1.py} |   0
 tests/functional/aarch64/test_aspeed_ast2700a2.py  | 190 +++++++++++++++++++++
 tests/functional/aarch64/test_aspeed_ast2700fc.py  |  16 +-
 tests/functional/arm/meson.build                   |  18 +-
 tests/functional/arm/test_aspeed_ast1060.py        |   0
 ...ast2500.py => test_aspeed_ast2500_buildroot.py} |  14 --
 tests/functional/arm/test_aspeed_ast2500_sdk.py    |  29 ++++
 .../functional/arm/test_aspeed_ast2500_sdk_515.py  |  29 ++++
 .../arm/test_aspeed_ast2600_buildroot.py           |  41 +----
 .../arm/test_aspeed_ast2600_buildroot_tpm.py       |  60 +++++++
 tests/functional/arm/test_aspeed_ast2600_sdk.py    |  15 --
 .../functional/arm/test_aspeed_ast2600_sdk_515.py  |  29 ++++
 .../functional/arm/test_aspeed_ast2600_sdk_otp.py  |  62 +++++++
 22 files changed, 539 insertions(+), 155 deletions(-)
 rename tests/functional/aarch64/{test_aspeed_ast2700.py => test_aspeed_ast2700a1.py} (100%)
 create mode 100755 tests/functional/aarch64/test_aspeed_ast2700a2.py
 mode change 100644 => 100755 tests/functional/arm/test_aspeed_ast1060.py
 rename tests/functional/arm/{test_aspeed_ast2500.py => test_aspeed_ast2500_buildroot.py} (74%)
 create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2500_sdk_515.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_buildroot_tpm.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_515.py
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk_otp.py


