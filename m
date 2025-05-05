Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC90C3ABB9
	for <qemu-devel@archiver.kernel.org>; Mon,  5 May 2025 09:13:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBrmx-00069c-1z; Mon, 05 May 2025 05:07:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrmh-0005te-9P
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:06:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1uBrmd-0006B9-JB
 for qemu-devel@nongnu.org; Mon, 05 May 2025 05:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746436002;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VCWvBzr0qKl7YiCXoP9jLX4Trdzp/81+Yq7mX33KfDo=;
 b=enDvvwx3rPR5LfGJpgvbWV2SSYpGF62KO/gBr/7u4BBZlUeo+/GP5kLNaJBEVpgI90eXtG
 7ADlPL48pG9WTbgJ49khSOIxB8+FbwF0sLEGVWNr7aia/M4jLYxWjkJAlhAKNEM1bmaLYr
 HmOSENbNipnAkB1wAIuVSvij1PMd9A4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-683-g9Y4MgxfPM2cwPZoXfkjwQ-1; Mon,
 05 May 2025 05:06:41 -0400
X-MC-Unique: g9Y4MgxfPM2cwPZoXfkjwQ-1
X-Mimecast-MFC-AGG-ID: g9Y4MgxfPM2cwPZoXfkjwQ_1746436000
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1194B1800992; Mon,  5 May 2025 09:06:40 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.38])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6366C30001A2; Mon,  5 May 2025 09:06:38 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/23] aspeed queue
Date: Mon,  5 May 2025 11:06:12 +0200
Message-ID: <20250505090635.778785-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.411,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

The following changes since commit e578dcc7e1590b20a84036afe5bdfa8d23a6048e:

  pc-bios: Add AST27x0 vBootrom (2025-05-02 09:47:14 +0200)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250505

for you to fetch changes up to f32ef57f7de98ec36da52b0a13bd5d18ac4bd583:

  docs: Add support for ast2700fc machine (2025-05-05 09:42:16 +0200)

----------------------------------------------------------------
aspeed queue:

* Fixed AST2700 SPI model issues
* Updated SDK images
* Added FW support to the AST2700 EVB machines
* Introduced an AST27x0 multi-SoC machine

----------------------------------------------------------------
Jamin Lin (12):
      tests/functional/aspeed: Update test ASPEED SDK v09.06 for AST2500
      tests/functional/aspeed: Update test ASPEED SDK v09.06 for AST2600
      tests/functional/aspeed: Update test ASPEED SDK v03.00 for AST1030
      hw/arm/aspeed_ast27x0: Rename variable sram_name to name in ast2700 realize
      tests/functional/aspeed: Move I2C test into shared helper for AST2700 reuse
      tests/functional/aspeed: Update test ASPEED SDK v09.06
      tests/functional/aspeed: extract boot and login sequence into helper function
      hw/arm/aspeed_ast27x0 Introduce vbootrom memory region
      hw/arm/aspeed: Add support for loading vbootrom image via "-bios"
      tests/functional/aspeed: Add to test vbootrom for AST2700
      docs/system/arm/aspeed: move AST2700 content to new section
      docs/system/arm/aspeed: Support vbootrom for AST2700

Joe Komlodi (1):
      hw/ssi/aspeed_smc: Allow 64-bit wide flash accesses

Steven Lee (9):
      aspeed: ast27x0: Map unimplemented devices in SoC memory
      aspeed: ast27x0: Correct hex notation for device addresses
      hw/intc/aspeed: Add support for AST2700 SSP INTC
      hw/intc/aspeed: Add support for AST2700 TSP INTC
      hw/arm/aspeed_ast27x0-ssp: Introduce AST27x0 A1 SSP SoC
      hw/arm/aspeed_ast27x0-tsp: Introduce AST27x0 A1 TSP SoC
      hw/arm: Introduce ASPEED AST2700 A1 full core machine
      tests/function/aspeed: Add functional test for ast2700fc
      docs: Add support for ast2700fc machine

Troy Lee (1):
      hw/arm: ast27x0: Wire up EHCI controllers

 docs/system/arm/aspeed.rst                         | 164 +++++++-
 include/hw/arm/aspeed.h                            |   1 +
 include/hw/arm/aspeed_soc.h                        |  38 +-
 include/hw/intc/aspeed_intc.h                      |   5 +
 hw/arm/aspeed.c                                    |  36 ++
 hw/arm/aspeed_ast27x0-fc.c                         | 192 ++++++++++
 hw/arm/aspeed_ast27x0-ssp.c                        | 294 +++++++++++++++
 hw/arm/aspeed_ast27x0-tsp.c                        | 294 +++++++++++++++
 hw/arm/aspeed_ast27x0.c                            | 125 +++++--
 hw/intc/aspeed_intc.c                              | 416 +++++++++++++++++++++
 hw/ssi/aspeed_smc.c                                |   4 +-
 hw/arm/meson.build                                 |   6 +-
 tests/functional/meson.build                       |   6 +-
 ...64_aspeed.py => test_aarch64_aspeed_ast2700.py} |  82 ++--
 tests/functional/test_aarch64_aspeed_ast2700fc.py  | 135 +++++++
 tests/functional/test_arm_aspeed_ast1030.py        |  10 +-
 tests/functional/test_arm_aspeed_ast2500.py        |   8 +-
 tests/functional/test_arm_aspeed_ast2600.py        |  15 +-
 18 files changed, 1749 insertions(+), 82 deletions(-)
 create mode 100644 hw/arm/aspeed_ast27x0-fc.c
 create mode 100644 hw/arm/aspeed_ast27x0-ssp.c
 create mode 100644 hw/arm/aspeed_ast27x0-tsp.c
 rename tests/functional/{test_aarch64_aspeed.py => test_aarch64_aspeed_ast2700.py} (64%)
 create mode 100755 tests/functional/test_aarch64_aspeed_ast2700fc.py


