Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1159ACD5BD5
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 08:23:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRn0D-0005BF-FG; Tue, 26 May 2026 04:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn0A-0005Ad-46
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wRn06-0007PR-28
 for qemu-devel@nongnu.org; Tue, 26 May 2026 04:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779783536;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=DRssd+xzYGjl3Xip1S86X8jDxenYYzrdFjyBMGDGk6g=;
 b=SwwhtOnuzLr8qEtwkL8Olr8AFdF7ixSj92Q/U+NT9iGoUqlgZ34Jz+xE7lPz75Ozv7P9vT
 aNkhRB/nrmlmfrV8sgQdjzSIdvuC/W0T0oXAdSvM52RIG7aun34/Q/c8EXstXHXwxW7UVx
 kR/vvh2sZ7Qt3gr2jM5zHwmZiRBsMpI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-647-gk2YpbejPMedHLZ0RnW1TQ-1; Tue,
 26 May 2026 04:18:53 -0400
X-MC-Unique: gk2YpbejPMedHLZ0RnW1TQ-1
X-Mimecast-MFC-AGG-ID: gk2YpbejPMedHLZ0RnW1TQ_1779783533
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AF33E195608F; Tue, 26 May 2026 08:18:52 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3D3FB1800357; Tue, 26 May 2026 08:18:50 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/37] aspeed queue
Date: Tue, 26 May 2026 10:18:11 +0200
Message-ID: <20260526081848.651835-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit cbf877d67a812be17a9ce404a589e1bdf722c1f6:

  Merge tag 'pbouvier/pr/docs-20260522' of https://gitlab.com/p-b-o/qemu into staging (2026-05-24 07:45:19 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260526

for you to fetch changes up to da8c8eb4664b995f82fc8c2ce3c0406be08cd63b:

  hw/i2c/aspeed_i2c: convert to use Resettable interface (2026-05-26 08:56:48 +0200)

----------------------------------------------------------------
aspeed queue:

* Fix AST2600 RNG register definitions
* Add a USB EHCI functional test to the AST2600 SDK machine test
* Add a new anacapa-bmc machine (Meta/Facebook AST2600)
* Refactor SRAM to support AST1040 memory layout
* Add a new AST1040 Bridge IC SoC model and EVB machine
* Convert all Aspeed device models to use the Resettable
  interface

----------------------------------------------------------------
Cédric Le Goater (1):
      hw/misc/aspeed_scu: Fix AST2600_RNG definitions

Jamin Lin (10):
      tests/functional/arm/test_aspeed_ast2600_sdk: Add USB EHCI test for AST2600 SDK
      hw/arm/aspeed: Convert SRAM MemoryRegion to array type
      hw/arm/aspeed: Convert SRAM size definition to array type
      hw/arm/aspeed: Rename SRAM memmap entry for multi-SRAM support
      hw/arm/aspeed: Consolidate secure SRAM into SRAM array
      hw/misc/aspeed_scu: Add AST1040 A0 silicon revision ID
      hw/arm/aspeed: Introduce AST1040 A0 SoC model
      hw/arm/aspeed: Add AST1040 EVB machine model
      tests/function/aspeed: Add AST1040 functional test
      docs/system/arm/aspeed: Add AST1040 Bridge IC evaluation board

Kane Chen (23):
      hw/misc/aspeed_pwm: convert to use Resettable interface
      hw/misc/aspeed_peci: convert to use Resettable interface
      hw/misc/aspeed_hace: convert to use Resettable interface
      hw/misc/aspeed_sbc: convert to use Resettable interface
      hw/misc/aspeed_xdma: convert to use Resettable interface
      hw/misc/aspeed_lpc: convert to use Resettable interface
      hw/misc/aspeed_sdmc: convert to use Resettable interface
      hw/misc/aspeed_scu: convert to use Resettable interface
      hw/misc/aspeed_ltpi: convert to use Resettable interface
      hw/pci-host/aspeed_pcie: convert to use Resettable interface
      hw/timer/aspeed_timer: convert to use Resettable interface
      hw/gpio/aspeed_gpio: convert to use Resettable interface
      hw/sd/aspeed_sdhci: convert to use Resettable interface
      hw/ssi/aspeed_smc: convert to use Resettable interface
      hw/intc/aspeed_vic: convert to use Resettable interface
      hw/intc/aspeed_intc: convert to use Resettable interface
      hw/i3c/aspeed_i3c: convert to use Resettable interface
      hw/watchdog/wdt_aspeed: convert to use Resettable interface
      hw/net/ftgmac100: convert to use Resettable interface
      hw/fsi/aspeed_apb2opb: convert to use Resettable interface
      hw/rtc/aspeed_rtc: convert to use Resettable interface
      hw/adc/aspeed_adc: convert to use Resettable interface
      hw/i2c/aspeed_i2c: convert to use Resettable interface

William de Abreu Pinho (3):
      tests/functional/aspeed: introduce FacebookAspeedTest
      hw/arm/aspeed: add anacapa-bmc machine
      hw/arm/aspeed: anacapa: add FRU EEPROM data

 docs/system/arm/aspeed.rst                      |  23 +-
 include/hw/arm/aspeed_soc.h                     |  11 +-
 include/hw/misc/aspeed_scu.h                    |   1 +
 hw/adc/aspeed_adc.c                             |   7 +-
 hw/arm/aspeed_ast1040.c                         | 254 +++++++++++++++++
 hw/arm/aspeed_ast1040_evb.c                     |  73 +++++
 hw/arm/aspeed_ast10x0.c                         |  29 +-
 hw/arm/aspeed_ast2400.c                         |  14 +-
 hw/arm/aspeed_ast2600.c                         |  10 +-
 hw/arm/aspeed_ast2600_anacapa.c                 | 362 ++++++++++++++++++++++++
 hw/arm/aspeed_ast27x0-ssp.c                     |   4 +-
 hw/arm/aspeed_ast27x0-tsp.c                     |   4 +-
 hw/arm/aspeed_ast27x0.c                         |  12 +-
 hw/fsi/aspeed_apb2opb.c                         |   7 +-
 hw/gpio/aspeed_gpio.c                           |   7 +-
 hw/i2c/aspeed_i2c.c                             |  14 +-
 hw/i3c/aspeed_i3c.c                             |   7 +-
 hw/intc/aspeed_intc.c                           |   7 +-
 hw/intc/aspeed_vic.c                            |   7 +-
 hw/misc/aspeed_hace.c                           |   7 +-
 hw/misc/aspeed_lpc.c                            |   7 +-
 hw/misc/aspeed_ltpi.c                           |   7 +-
 hw/misc/aspeed_peci.c                           |   7 +-
 hw/misc/aspeed_pwm.c                            |   7 +-
 hw/misc/aspeed_sbc.c                            |   7 +-
 hw/misc/aspeed_scu.c                            |  44 +--
 hw/misc/aspeed_sdmc.c                           |  14 +-
 hw/misc/aspeed_xdma.c                           |   7 +-
 hw/net/ftgmac100.c                              |  14 +-
 hw/pci-host/aspeed_pcie.c                       |  21 +-
 hw/rtc/aspeed_rtc.c                             |   7 +-
 hw/sd/aspeed_sdhci.c                            |   7 +-
 hw/ssi/aspeed_smc.c                             |   7 +-
 hw/timer/aspeed_timer.c                         |   7 +-
 hw/watchdog/wdt_aspeed.c                        |   7 +-
 hw/arm/meson.build                              |   5 +-
 tests/functional/arm/meson.build                |   3 +
 tests/functional/arm/test_aspeed_anacapa.py     |  25 ++
 tests/functional/arm/test_aspeed_ast1040.py     |  35 +++
 tests/functional/arm/test_aspeed_ast2600_sdk.py |   7 +
 tests/functional/arm/test_aspeed_bletchley.py   |   6 +-
 tests/functional/arm/test_aspeed_catalina.py    |   6 +-
 tests/functional/aspeed.py                      |   8 +
 43 files changed, 970 insertions(+), 155 deletions(-)
 create mode 100644 hw/arm/aspeed_ast1040.c
 create mode 100644 hw/arm/aspeed_ast1040_evb.c
 create mode 100644 hw/arm/aspeed_ast2600_anacapa.c
 create mode 100644 tests/functional/arm/test_aspeed_anacapa.py
 create mode 100644 tests/functional/arm/test_aspeed_ast1040.py


