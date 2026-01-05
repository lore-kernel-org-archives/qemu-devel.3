Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C2D0C79F87
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Jan 2026 12:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vck8M-0003ka-6b; Mon, 05 Jan 2026 07:56:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8I-0003ip-9A
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vck8E-0007Vt-7A
 for qemu-devel@nongnu.org; Mon, 05 Jan 2026 07:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767617780;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bjc2sFFSAIqs9+zFNtIGAFFECmb4vOU26rCHQa2kbNQ=;
 b=Ny+AfWGYzqbPB6IPzB81UQqrKqRlYAhBWcJI+5lYWfGWzlP+uYuiKxFwUcZYnd8jp1i6rn
 BUhX+p1oohhoNpXGAN6O8hvciOX8bcLs0aUHzlt/d0jQaTcXTtyHMZ8et2jiM3vRQHH/uA
 KuVAo4ozptyJNEYiDSWqkj/ukcBEwJg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-477-GJGnD9NLM8SYplKIMb4Bxw-1; Mon,
 05 Jan 2026 07:56:18 -0500
X-MC-Unique: GJGnD9NLM8SYplKIMb4Bxw-1
X-Mimecast-MFC-AGG-ID: GJGnD9NLM8SYplKIMb4Bxw_1767617778
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 957521956054; Mon,  5 Jan 2026 12:56:17 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.53])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0C41419560A7; Mon,  5 Jan 2026 12:56:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/36] aspeed queue
Date: Mon,  5 Jan 2026 13:55:37 +0100
Message-ID: <20260105125613.622667-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 159107e390609f71b78268a4888563dcdce6ac65:

  Merge tag 'pull-hex-20260102' of https://github.com/quic/qemu into staging (2026-01-05 07:35:40 +1100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260105

for you to fetch changes up to 9cbd8ee7f67fceee51d3c993a282e5adc397b6b9:

  hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first (2026-01-05 10:38:02 +0100)

----------------------------------------------------------------
aspeed queue:

* Removed the ast2700-a0 SoC and ast2700a0-evb machine.
* Added SGPIO support to the ast2700 SoC, including unit tests.
* Added several FRU EEPROMs to the Catalina board.
* Added support for the new AST1060 SoC and ast1060-evb machine,
  including functional tests.
* Fixed the silicon revision ID register for AST2600 and AST1030 SoCs.
* Added an SFDP table for a Winbond flash chip.
* Updated documentation for Aspeed boards.

----------------------------------------------------------------
Cédric Le Goater (1):
      tests/functional: Fix URL of gb200nvl-bmc image

Jamin Lin (18):
      hw/block/m25p80: Add SFDP table for Winbond W25Q02JVM flash
      hw/misc/aspeed_scu: Fix the revision ID cannot be set in the SOC layer for AST2600 and AST1030
      hhw/misc/aspeed_scu: Add AST1060 A2 silicon revision definition
      hw/arm/aspeed_ast10x0: Add common init function for AST10x0 SoCs
      hw/arm/aspeed_ast10x0: Add common realize function for AST10x0 SoCs
      hw/arm/aspeed_ast10x0: Pass SoC name to common init for AST10x0 family reuse
      hw/arm/aspeed_ast10x0: Add AST1060 SoC support
      hw/arm/aspeed_ast10x0_evb: Add AST1060 EVB machine support
      tests/functional/arm/test_aspeed_ast1060: Add functional tests for Aspeed AST1060 SoC
      docs/system/arm/aspeed: Update Aspeed and 2700 family boards list
      docs/system/arm/aspeed: Update Aspeed MiniBMC section to include AST1060 processor
      hw/arm: Remove ast2700a0-evb machine
      hw/arm/aspeed_ast27x0: Remove ast2700-a0 SOC
      hw/intc/aspeed: Remove GIC 128 - 136
      docs/specs/aspeed-intc: Remove GIC 128 - 136
      hw/intc/aspeed: Remove SSP 128 - 138
      hw/intc/aspeed: Remove TSP 128 - 138
      hw/i2c/aspeed: Fix wrong I2CC_DMA_LEN when I2CM_DMA_TX/RX_ADDR set first

Patrick Williams (11):
      hw/arm/aspeed: catalina: add BSM FRU EEPROM
      hw/arm/aspeed: catalina: add DC-SCM FRU EEPROM
      hw/arm/aspeed: catalina: add PDB FRU EEPROM
      hw/arm/aspeed: catalina: add OSFP FRU EEPROM
      hw/arm/aspeed: catalina: add FIO FRU EEPROM
      hw/arm/aspeed: catalina: add HDD FRU EEPROM
      hw/arm/aspeed: catalina: add GB200 FRU EEPROM
      hw/arm/aspeed: catalina: add GB200-IO FRU EEPROM
      hw/arm/aspeed: catalina: add HMC FRU EEPROM
      hw/arm/aspeed: catalina: add NIC FRU EEPROM
      hw/arm/aspeed: catalina: add Cable Cartridge FRU EEPROM

Yubin Zou (6):
      hw/gpio/aspeed_sgpio: Add basic device model for Aspeed SGPIO
      hw/gpio/aspeed_sgpio: Add QOM property accessors for SGPIO pins
      hw/gpio/aspeed_sgpio: Implement SGPIO interrupt handling
      hw/arm/aspeed_soc: Update Aspeed SoC to support two SGPIO controllers
      hw/arm/aspeed_ast27x0: Wire SGPIO controller to AST2700 SoC
      test/qtest: Add Unit test for Aspeed SGPIO

 docs/about/deprecated.rst                        |   8 -
 docs/about/removed-features.rst                  |   8 +
 docs/specs/aspeed-intc.rst                       |  92 ++---
 docs/system/arm/aspeed.rst                       |  27 +-
 hw/block/m25p80_sfdp.h                           |   1 +
 include/hw/arm/aspeed_soc.h                      |   8 +-
 include/hw/gpio/aspeed_sgpio.h                   |  68 ++++
 include/hw/misc/aspeed_scu.h                     |   1 +
 hw/arm/aspeed_ast10x0.c                          | 213 ++++++----
 hw/arm/aspeed_ast10x0_evb.c                      |  23 ++
 hw/arm/aspeed_ast2600_catalina.c                 | 473 ++++++++++++++++++++++-
 hw/arm/aspeed_ast27x0-ssp.c                      |  13 +-
 hw/arm/aspeed_ast27x0-tsp.c                      |  13 +-
 hw/arm/aspeed_ast27x0.c                          | 151 ++------
 hw/arm/aspeed_ast27x0_evb.c                      |  26 --
 hw/block/m25p80.c                                |   2 +
 hw/block/m25p80_sfdp.c                           |  36 ++
 hw/gpio/aspeed_sgpio.c                           | 346 +++++++++++++++++
 hw/i2c/aspeed_i2c.c                              |  10 +-
 hw/intc/aspeed_intc.c                            | 161 +-------
 hw/misc/aspeed_scu.c                             |   5 +-
 tests/qtest/ast2700-sgpio-test.c                 | 165 ++++++++
 hw/gpio/meson.build                              |   1 +
 tests/functional/arm/meson.build                 |   1 +
 tests/functional/arm/test_aspeed_ast1060.py      |  52 +++
 tests/functional/arm/test_aspeed_gb200nvl_bmc.py |   2 +-
 tests/qtest/meson.build                          |   1 +
 27 files changed, 1403 insertions(+), 504 deletions(-)
 create mode 100644 include/hw/gpio/aspeed_sgpio.h
 create mode 100644 hw/gpio/aspeed_sgpio.c
 create mode 100644 tests/qtest/ast2700-sgpio-test.c
 create mode 100644 tests/functional/arm/test_aspeed_ast1060.py


