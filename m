Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04D66C83F05
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 08:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXbvN-0006VY-6l; Fri, 04 Jul 2025 04:37:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvL-0006V3-0Y
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:37:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uXbvJ-0004KN-7c
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 04:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751618252;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yxaQ+EcmWinLO/Ba1OIN+3Db80U4EeXXX7CeZzYnTRc=;
 b=e004DMFii+aT+/AQ8bBbibCDBoJzQKgX/w0+XpVqW9uOWDVdrmbDSbjGrZmYAhqU0bP/ot
 KE+oX6prGxxvyq1O9qcNQWNxdq5t2Su7gcKlX9pQOOJkHRK5hKo+MC8MoTM+boz8QbbjmW
 ylnGcd3SsSzQIr30lHPfv/Z/Gy5YZKc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-JxGyCDwIOx2sGYpCoJzwHA-1; Fri,
 04 Jul 2025 04:37:28 -0400
X-MC-Unique: JxGyCDwIOx2sGYpCoJzwHA-1
X-Mimecast-MFC-AGG-ID: JxGyCDwIOx2sGYpCoJzwHA_1751618248
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC4461954215; Fri,  4 Jul 2025 08:37:27 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.43])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 233F8180045B; Fri,  4 Jul 2025 08:37:25 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/11] aspeed queue
Date: Fri,  4 Jul 2025 10:37:12 +0200
Message-ID: <20250704083723.1410455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The following changes since commit c77283dd5d79149f4e7e9edd00f65416c648ee59:

  Merge tag 'pull-request-2025-07-02' of https://gitlab.com/thuth/qemu into staging (2025-07-03 06:01:41 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250704

for you to fetch changes up to 3a34dad2c0d25cebafed40696bbbdeb7ff4b9c7d:

  tests/functional: Add gb200 tests (2025-07-03 17:36:45 +0200)

----------------------------------------------------------------
aspeed queue:

* Improved AST2700 SoC modeling (SDMC, SCU)
* Fixed hardware strapping of 'bletchley-bmc' machine
* Added new Meta 'catalina-bmc' machine and functional test using OpenBMC
* Improved AST2600 SCU protection key modeling
* Introduced AST2600 SCU unit tests
* Deprecated 'ast2700a0-evb' machine
* Added new NVIDIA 'gb200-bmc' machine and functional test using OpenBMC

----------------------------------------------------------------
Ed Tanous (4):
      hw/arm/aspeed: Add second SPI chip to Aspeed model
      docs: add support for gb200-bmc
      hw/arm/aspeed: Add GB200 BMC target
      tests/functional: Add gb200 tests

Jamin Lin (3):
      hw/misc/aspeed_sdmc: Skipping dram_init in u-boot for AST2700
      hw/misc/aspeed_scu: Support the Frequency Counter Control register for AST2700
      aspeed: Deprecate the ast2700a0-evb machine

Patrick Williams (2):
      hw/arm/aspeed: bletchley: update hw strap values
      hw/arm/aspeed: add Catalina machine type

Tan Siewert (2):
      hw/misc/aspeed_scu: Handle AST2600 protection key registers correctly
      tests/qtest: Add test for ASPEED SCU

 docs/about/deprecated.rst                        |   8 +
 docs/system/arm/aspeed.rst                       |   4 +-
 hw/arm/aspeed_eeprom.h                           |   3 +
 include/hw/arm/aspeed.h                          |   2 +
 hw/arm/aspeed.c                                  | 285 ++++++++++++++++++++++-
 hw/arm/aspeed_eeprom.c                           |  21 ++
 hw/misc/aspeed_scu.c                             |  22 +-
 hw/misc/aspeed_sdmc.c                            |   3 +
 tests/qtest/aspeed_scu-test.c                    | 231 ++++++++++++++++++
 hw/arm/Kconfig                                   |   1 +
 tests/functional/aspeed.py                       |   9 +-
 tests/functional/meson.build                     |   4 +
 tests/functional/test_arm_aspeed_catalina.py     |  25 ++
 tests/functional/test_arm_aspeed_gb200nvl_bmc.py |  26 +++
 tests/qtest/meson.build                          |   1 +
 15 files changed, 636 insertions(+), 9 deletions(-)
 create mode 100644 tests/qtest/aspeed_scu-test.c
 create mode 100755 tests/functional/test_arm_aspeed_catalina.py
 create mode 100644 tests/functional/test_arm_aspeed_gb200nvl_bmc.py


