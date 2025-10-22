Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E84ECCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 12:34:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBXyq-000178-4B; Wed, 22 Oct 2025 08:30:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyk-00016B-O1
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vBXyh-0008Jz-HP
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 08:30:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761136204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TEge10vV9mli/1aV/MJpt2qglZAVU9uWLxHfc1MMbFc=;
 b=dLhhIDnmQseax6+pp81DRnA0XdWK50k/GbabryXzYY1YfYOwXlr8cJmWdnouk2Zam3x3ac
 nLg3d+/DpgAWFJEQ/5B9m8VvCo3dX+Pm7jWJyWasD57Ctw/X87UImtICEwsaDq2+ugOLxS
 qMjeOyU3wa7CGhc4Zd/xwlJ95/1yVBE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-634-Gf3noQULMoKLWaloXBRd8Q-1; Wed,
 22 Oct 2025 08:30:03 -0400
X-MC-Unique: Gf3noQULMoKLWaloXBRd8Q-1
X-Mimecast-MFC-AGG-ID: Gf3noQULMoKLWaloXBRd8Q_1761136202
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 534931800673; Wed, 22 Oct 2025 12:30:02 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.12])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CEAD51800586; Wed, 22 Oct 2025 12:30:00 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/16] aspeed queue
Date: Wed, 22 Oct 2025 14:29:37 +0200
Message-ID: <20251022122953.877335-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit 3c0b42c68f98fb276fa248012642be8cbf2cab70:

  Merge tag 'pull-request-2025-10-21' of https://gitlab.com/thuth/qemu into staging (2025-10-21 08:59:35 -0500)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20251022

for you to fetch changes up to d7bd42a740d0e8887540d7b450d0bdb2d6ba31ea:

  hw/arm/aspeed: Remove ast2700fc self-aliasing (2025-10-22 08:14:09 +0200)

----------------------------------------------------------------
aspeed queue:

* Improve AST2700 co-processor models
* Add vbootrom support to the ast2700fc multi-soc machine
* Bump SDK version to v09.08 for the ast2700fc machine
* Add 32 bits property for Aspeed GPIOs
* Change ast2600-evb machine flash model to w25q512jv

----------------------------------------------------------------
Cédric Le Goater (1):
      hw/arm/aspeed: ast2600-evb: Use w25q512jv flash model

Felix Wu (2):
      hw/gpio: Add property for ASPEED GPIO in 32 bits basis
      tests/qtest: Add qtest for for ASPEED GPIO gpio-set property

Jamin Lin (12):
      hw/arm/aspeed_ast27x0-ssp: Add SDRAM region and fix naming and size to 512MB
      hw/arm/aspeed_ast27x0-tsp: Add SDRAM region and fix naming and size to 512MB
      hw/arm/ast27x0: Add SRAM link and alias mapping for SSP coprocessor
      hw/arm/ast27x0: Add SRAM link and alias mapping for TSP coprocessor
      hw/arm/ast27x0: Share single SCU instance across PSP, SSP, and TSP
      hw/arm/ast27x0: Share single UART set across PSP, SSP, and TSP
      hw/arm/aspeed_ast27x0-fc: Map FMC0 flash contents into CA35 boot ROM
      hw/arm/aspeed_ast27x0-fc: Add VBOOTROM support
      tests/functional/aarch64/ast2700fc: Update test ASPEED SDK v09.08
      tests/functional/aarch64/ast2700fc: Add eth2 network interface check in PCIe test
      tests/functional/aarch64/ast2700fc: Move coprocessor image loading to common function
      tests/functional/aarch64/ast2700fc: Add vbootrom test

Philippe Mathieu-Daudé (1):
      hw/arm/aspeed: Remove ast2700fc self-aliasing

 include/hw/arm/aspeed_coprocessor.h               |  14 +--
 include/qobject/qdict.h                           |   1 +
 hw/arm/aspeed.c                                   |   4 +-
 hw/arm/aspeed_ast27x0-fc.c                        |  56 ++++++++----
 hw/arm/aspeed_ast27x0-ssp.c                       |  69 +++++++-------
 hw/arm/aspeed_ast27x0-tsp.c                       |  69 +++++++-------
 hw/arm/aspeed_coprocessor_common.c                |   7 ++
 hw/gpio/aspeed_gpio.c                             |  57 ++++++++++++
 qobject/qdict.c                                   |  13 +++
 tests/qtest/aspeed_gpio-test.c                    | 105 ++++++++++++++++++++--
 tests/qtest/aspeed_smc-test.c                     |   4 +-
 tests/functional/aarch64/test_aspeed_ast2700fc.py |  51 +++++++----
 12 files changed, 331 insertions(+), 119 deletions(-)


