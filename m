Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B662CD8CA7
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSqw-0001Hw-W7; Mon, 08 Jun 2026 01:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqr-0001Gw-P4
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqp-0000M8-VE
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QXHv4UNtzreMN7j3AozVuQF7EqJkMPZ9KpvmtWjzbdc=;
 b=ZZZkmpVE+nhuQbuSY0XCLhc8z3Hvj0bMB3JI7iTmHsA4lMbandeG7Qx2NhQvZA5PlUy88w
 Y2GB6YJw8K7VXEJc/wMvF2ELIM4RRhDrFGk0lLNVZQqwQVRZAiA4WIbnonna4xgLvkpkUj
 6z0xHtNzUTHgADVKXFUis1zFv5RSW3c=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-7IKsUEPmPROHmAwxRWBZUw-1; Mon,
 08 Jun 2026 01:48:31 -0400
X-MC-Unique: 7IKsUEPmPROHmAwxRWBZUw-1
X-Mimecast-MFC-AGG-ID: 7IKsUEPmPROHmAwxRWBZUw_1780897711
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8F16318003FC; Mon,  8 Jun 2026 05:48:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0EA5227A; Mon,  8 Jun 2026 05:48:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/37] aspeed queue
Date: Mon,  8 Jun 2026 07:47:49 +0200
Message-ID: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 3390aba56c354637eccd2d5ab5fd6efc2f026f06:

  Merge tag 'qom-tests-pr-v2' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-06-06 14:47:04 -0400)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260608

for you to fetch changes up to 43cdf3d2bbe24021ac4753fbb8cfaeb90e6d86f1:

  hw/i3c: keep _bytes aliases for renamed queue-capacity properties (2026-06-07 06:41:10 +0200)

----------------------------------------------------------------
aspeed queue:

* Convert 14 Aspeed device models to DEFINE_TYPES().
* Improve Aspeed I2C: unify DMA address handling with a dma_addr_lo_mask
  field and increase the AST2700 buffer mode size.
* Add ADC, PECI, GPIO, SGPIO, I2C and watchdog support to the AST1040
  SoC model, and wire onboard I2C devices to the AST1040 EVB.
* Fix DW-I3C CMD/data FIFO reset values to match real silicon, rename
  queue capacity properties from _bytes to _words, keeping the old
  names as aliases for backward compatibility.

----------------------------------------------------------------
Jamin Lin (34):
      hw/misc/aspeed_hace: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc/aspeed_lpc: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc/aspeed_ltpi: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc/aspeed_pwm: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc/aspeed_sbc: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc/aspeed_scu: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc/aspeed_sdmc: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc:aspeed_sli: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/misc/aspeed_xdma: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/adc/aspeed_adc: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/arm/aspeed_ast1700: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/gpio/aspeed_gpio: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/gpio/aspeed_sgpio: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/intc/aspeed_intc: convert to DEFINE_TYPES() with inlined TypeInfo
      hw/intc/aspeed_vic: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/rtc/aspeed_rtc: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/watchdog/wdt_aspeed: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/nvram/aspeed_otp: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/timer/aspeed_timer: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/fsi/aspeed_apb2opb: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/pci-host/aspeed_pcie: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/i2c/aspeed_i2c: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/net/ftgmac100: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/ssi/aspeed_smc: Convert to DEFINE_TYPES() with inlined TypeInfo
      hw/i2c/aspeed_i2c: Introduce dma_addr_lo_mask to unify DMA address handling
      hw/i2c/aspeed_i2c: Increase AST2700 buffer mode size and adjust offset
      hw/arm/aspeed_ast1040: Reuse AST2700 ADC model
      hw/arm/aspeed_ast1040: Introduce PECI support
      hw/arm/aspeed_ast1040: Reuse AST2700 GPIO controller model
      hw/arm/aspeed_ast1040: Add SGPIO controller support
      hw/i2c/aspeed_i2c: Introduce AST1040 I2C model
      hw/arm/aspeed_ast1040: Introduce I2C support
      hw/arm/aspeed_ast1040_evb: Introduce onboard I2C device
      hw/arm/aspeed_ast1040: Reuse AST2700 watchdog models

Jithu Joseph (3):
      hw/i3c: fix CMD/data FIFO depth reset values to match real silicon
      hw/i3c: rename DW-I3C queue capacity fields from _bytes to _words
      hw/i3c: keep _bytes aliases for renamed queue-capacity properties

 include/hw/i2c/aspeed_i2c.h |   8 +-
 include/hw/i3c/dw-i3c.h     |   6 +-
 hw/adc/aspeed_adc.c         |  95 ++++++++----------
 hw/arm/aspeed_ast1040.c     |  97 ++++++++++++++++---
 hw/arm/aspeed_ast1040_evb.c |  15 +++
 hw/arm/aspeed_ast1700.c     |  21 ++--
 hw/fsi/aspeed_apb2opb.c     |  42 ++++----
 hw/gpio/aspeed_gpio.c       | 107 +++++++++------------
 hw/gpio/aspeed_sgpio.c      |  37 ++++---
 hw/i2c/aspeed_i2c.c         | 214 ++++++++++++++++++++++-------------------
 hw/i3c/dw-i3c.c             |  58 ++++++++---
 hw/intc/aspeed_intc.c       | 121 ++++++++++-------------
 hw/intc/aspeed_vic.c        |  19 ++--
 hw/misc/aspeed_hace.c       |  81 +++++++---------
 hw/misc/aspeed_lpc.c        |  21 ++--
 hw/misc/aspeed_ltpi.c       |  19 ++--
 hw/misc/aspeed_pwm.c        |  19 ++--
 hw/misc/aspeed_sbc.c        |  46 ++++-----
 hw/misc/aspeed_scu.c        | 107 +++++++++------------
 hw/misc/aspeed_sdmc.c       |  73 ++++++--------
 hw/misc/aspeed_sli.c        |  44 ++++-----
 hw/misc/aspeed_xdma.c       |  58 +++++------
 hw/net/ftgmac100.c          |  32 +++----
 hw/nvram/aspeed_otp.c       |  19 ++--
 hw/pci-host/aspeed_pcie.c   |  94 ++++++++----------
 hw/rtc/aspeed_rtc.c         |  19 ++--
 hw/ssi/aspeed_smc.c         | 228 +++++++++++++++++++-------------------------
 hw/timer/aspeed_timer.c     |  83 +++++++---------
 hw/watchdog/wdt_aspeed.c    |  93 ++++++++----------
 29 files changed, 897 insertions(+), 979 deletions(-)


