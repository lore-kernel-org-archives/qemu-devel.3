Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74956F47CA4
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 17:57:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyCwv-0006xs-OE; Thu, 05 Mar 2026 12:57:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCwt-0006x0-Cy
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vyCwr-0003Tm-Mk
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 12:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772733441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=uovKF5vaz4QHDVvFZ5gJ3dpJCW5AgJmXqiiw8MMjYlc=;
 b=P5Kfm28vqvtkl3sdNUEFs4aMYj8HDzv/u5oyYr61ALmJf7xEI5VSJrME71XLzI/lJVWfcs
 Jn/iHguvG+OorSokiyeEZnOg980/rlSNescRgTb6uxopSRXTfmtIUD1BB50Ret4zUPpelk
 oJ5kwXBqEESZcS9Cmz3UaEW4dDfMKvE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-f0MTcchUOH-V_YjNLx2JgQ-1; Thu,
 05 Mar 2026 12:57:16 -0500
X-MC-Unique: f0MTcchUOH-V_YjNLx2JgQ-1
X-Mimecast-MFC-AGG-ID: f0MTcchUOH-V_YjNLx2JgQ_1772733435
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 088241956095; Thu,  5 Mar 2026 17:57:15 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.26])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A2BAB3003E9E; Thu,  5 Mar 2026 17:57:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/38] aspeed queue
Date: Thu,  5 Mar 2026 18:56:33 +0100
Message-ID: <20260305175711.1119025-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit ae6e281633769bbc7424523d0ca1163e214571ad:

  Merge tag 'pull-loongarch-20260302' of https://github.com/gaosong715/qemu into staging (2026-03-05 10:48:38 +0000)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20260305

for you to fetch changes up to ee357844b13904a826ffa77834cd08e10ba1e9ba:

  tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED OpenBMC SDK v11.01 (2026-03-05 18:47:46 +0100)

----------------------------------------------------------------
aspeed queue:

* Add I3C support to QEMU, add an dummy I3C device and extend the
  Aspeed I3C controller
* Update test ASPEED OpenBMC SDK v11.01
* Fix DMA64 address handling in Aspeed I2C model (AST2700 SoC)

----------------------------------------------------------------
Cédric Le Goater (1):
      hw/i3c: Fix array bounds and storage in i3c_addr_is_rsvd()

Jamin Lin (37):
      hw/i2c/aspeed_i2c: Fix DMA64 address handling
      hw/misc/aspeed_i3c: Move to i3c directory
      hw/i3c/aspeed_i3c: Switch to DEFINE_TYPES() and align parent_obj naming
      hw/i3c: Add bus support
      hw/i3c: Split DesignWare I3C out of Aspeed I3C
      hw/i3c/dw-i3c: Add more register fields
      hw/i3c/aspeed_i3c: Add more register fields
      hw/i3c/dw-i3c: Add more reset values
      hw/i3c/aspeed_i3c: Add register RO field masks
      hw/i3c/dw-i3c: Add register RO field masks
      hw/i3c/dw-i3c: Treat more registers as read-as-zero
      hw/i3c/dw-i3c: Use 32 bits on MMIO writes
      hw/i3c/dw-i3c: Add IRQ MMIO behavior
      hw/i3c/dw-i3c: Add data TX and RX
      hw/i3c/dw-i3c: Add IBI handling
      hw/i3c/dw-i3c: Add ctrl MMIO handling
      hw/i3c/dw-i3c: Add controller resets
      hw/i3c/aspeed: Add I3C bus get function
      hw/i3c: Add Mock target
      hw/arm/aspeed: Build with I3C_DEVICES
      hw/i3c: Add hotplug support
      tests/functional/arm/test_aspeed_ast2600_sdk: Add i3c functional test
      MAINTAINERS: Add I3C maintainers and reviewer
      hw/i3c/dw-i3c: Use ROUND_UP() for RX buffer allocation alignment
      hw/i3c/mock-i3c-target: Set num_sent in TX callback to fix trace reporting
      hw/i3c/core: Initialize num_sent in i3c_send_byte()
      hw/i3c/mock-i3c-target: Simplify GETMRL byte extraction logic
      tests/functional/arm/test_aspeed_ast1030: Update test ASPEED Zephyr SDK v03.06
      tests/functional/arm/test_aspeed_ast1060: Update test aspeed-zephyr-project v03.05
      tests/functional/arm/test_aspeed_ast2500_sdk: Update test ASPEED OpenBMC SDK v11.01
      tests/functional/arm/test_aspeed_ast2500_sdk_515: Update test ASPEED OpenBMC SDK v11.01
      tests/functional/arm/test_aspeed_ast2600_sdk: Update test ASPEED OpenBMC SDK v11.01
      tests/functional/arm/test_aspeed_ast2600_sdk_otp: Update test ASPEED OpenBMC SDK v11.01
      tests/functional/arm/test_aspeed_ast2600_sdk_515: Update test ASPEED OpenBMC SDK v11.01
      tests/functional/aarch64/test_aspeed_ast2700a1: Update test ASPEED OpenBMC SDK v11.01
      tests/functional/aarch64/test_aspeed_ast2700a2: Update test ASPEED OpenBMC SDK v11.01
      tests/functional/aarch64/test_aspeed_ast2700fc: Update test ASPEED OpenBMC SDK v11.01

 MAINTAINERS                                        |   13 +
 meson.build                                        |    1 +
 hw/i3c/trace.h                                     |    2 +
 include/hw/arm/aspeed_soc.h                        |    2 +-
 include/hw/{misc => i3c}/aspeed_i3c.h              |   31 +-
 include/hw/i3c/dw-i3c.h                            |  199 +++
 include/hw/i3c/i3c.h                               |  277 +++
 include/hw/i3c/mock-i3c-target.h                   |   52 +
 hw/i2c/aspeed_i2c.c                                |    4 +-
 hw/i3c/aspeed_i3c.c                                |  258 +++
 hw/i3c/core.c                                      |  664 +++++++
 hw/i3c/dw-i3c.c                                    | 1862 ++++++++++++++++++++
 hw/i3c/mock-i3c-target.c                           |  303 ++++
 hw/misc/aspeed_i3c.c                               |  383 ----
 hw/Kconfig                                         |    1 +
 hw/arm/Kconfig                                     |    3 +
 hw/i3c/Kconfig                                     |   15 +
 hw/i3c/meson.build                                 |    6 +
 hw/i3c/trace-events                                |   48 +
 hw/meson.build                                     |    1 +
 hw/misc/meson.build                                |    1 -
 hw/misc/trace-events                               |    6 -
 tests/functional/aarch64/test_aspeed_ast2700a1.py  |   30 +-
 tests/functional/aarch64/test_aspeed_ast2700a2.py  |   30 +-
 tests/functional/aarch64/test_aspeed_ast2700fc.py  |   18 +-
 tests/functional/arm/test_aspeed_ast1030.py        |   12 +-
 tests/functional/arm/test_aspeed_ast1060.py        |   14 +-
 tests/functional/arm/test_aspeed_ast2500_sdk.py    |    8 +-
 .../functional/arm/test_aspeed_ast2500_sdk_515.py  |    8 +-
 tests/functional/arm/test_aspeed_ast2600_sdk.py    |   22 +-
 .../functional/arm/test_aspeed_ast2600_sdk_515.py  |   10 +-
 .../functional/arm/test_aspeed_ast2600_sdk_otp.py  |   10 +-
 32 files changed, 3805 insertions(+), 489 deletions(-)
 create mode 100644 hw/i3c/trace.h
 rename include/hw/{misc => i3c}/aspeed_i3c.h (53%)
 create mode 100644 include/hw/i3c/dw-i3c.h
 create mode 100644 include/hw/i3c/i3c.h
 create mode 100644 include/hw/i3c/mock-i3c-target.h
 create mode 100644 hw/i3c/aspeed_i3c.c
 create mode 100644 hw/i3c/core.c
 create mode 100644 hw/i3c/dw-i3c.c
 create mode 100644 hw/i3c/mock-i3c-target.c
 delete mode 100644 hw/misc/aspeed_i3c.c
 create mode 100644 hw/i3c/Kconfig
 create mode 100644 hw/i3c/meson.build
 create mode 100644 hw/i3c/trace-events


