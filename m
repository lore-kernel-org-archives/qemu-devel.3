Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 673DECCA476
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Oct 2025 12:45:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8Hus-0004QM-Ea; Mon, 13 Oct 2025 08:44:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Hul-0004PQ-MK
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v8Huh-0007sE-OA
 for qemu-devel@nongnu.org; Mon, 13 Oct 2025 08:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760359466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KwS1s6BweObhq51LZdXVO6paV/VKh606Qo+phZxDgaA=;
 b=hyA5smnzKWKNzHtlmh/I3f+bQmALnP7dD5jo+K23Mahk57aIbRYRdFH8EgewwS9qCIaAos
 a/nlHVFxkJlRi68omjSJmJuSu6pNtRDOVFU1953X+MZgm+MqAXE0lAQXDR4/HJhO6fmN3n
 6kmJUccmU7OsS3CRDWXioZVTFSVJ11U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-xRm_90NHOpyRDBPbVpeRLw-1; Mon,
 13 Oct 2025 08:44:25 -0400
X-MC-Unique: xRm_90NHOpyRDBPbVpeRLw-1
X-Mimecast-MFC-AGG-ID: xRm_90NHOpyRDBPbVpeRLw_1760359464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F5C51800372; Mon, 13 Oct 2025 12:44:24 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.225.105])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EEF6E1800446; Mon, 13 Oct 2025 12:44:22 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/29] aspeed queue
Date: Mon, 13 Oct 2025 14:43:51 +0200
Message-ID: <20251013124421.71977-1-clg@redhat.com>
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

The following changes since commit f3f2ad119347e8c086b72282febcaac5d731b343:

  Merge tag 'pull-target-arm-20251010' of https://gitlab.com/pm215/qemu into staging (2025-10-10 08:26:09 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20251013

for you to fetch changes up to 0cf9761b0ae6dd04815b54eb785301f35015246d:

  hw/arm/aspeed_ast27x0-{ssp,tsp}: Fix coding style (2025-10-13 14:37:55 +0200)

----------------------------------------------------------------
aspeed queue:

* Introduce AspeedCoprocessor class and base implementation
* Remove redudant functional tests to optimize for CI resources
* Deprecate fp5280g2-bmc, qcom-dc-scm-v1-bmc, qcom-firework-bmc and
  sonorapass-bmc machines
* Bump ASPEED SDK to v09.08
* Add PCIe and network tests

----------------------------------------------------------------
Cédric Le Goater (7):
      aspeed: Don't set 'auto_create_sdcard'
      tests/functional/arm: Split the ast2600 tests in two files
      aspeed: Deprecate the sonorapass-bmc machine
      aspeed: Deprecate the qcom-dc-scm-v1-bmc and qcom-firework-bmc machines
      aspeed: Deprecate the fp5280g2-bmc machine
      test/functional/aarch64: Remove test for the ast2700a0-evb machine
      test/functional/aarch64: Split the ast2700a1-evb OpenBMC boot test

Jamin Lin (22):
      tests/functional/aarch64/aspeed_ast2700: Add PCIe and network tests
      tests/functional/arm/test_aspeed_ast1030: Update test ASPEED SDK v03.03
      tests/functional/arm/test_aspeed_ast2500: Update test ASPEED SDK v09.08
      tests/functional/arm/test_aspeed_ast2600: Update test ASPEED SDK v09.08
      tests/functional/aarch64/test_aspeed_ast2700: Update test ASPEED SDK v09.08 for A1
      tests/functional/aarch64/test_aspeed_ast2700: Move eth2 IP check into common function
      hw/arm/aspeed: Remove AspeedSoCState dependency from aspeed_uart_first() API
      hw/arm/aspeed: Remove AspeedSoCClass dependency from aspeed_uart_last() API
      hw/arm/aspeed: Remove AspeedSoCState dependency from aspeed_soc_uart_set_chr() API
      hw/arm/aspeed: Remove AspeedSoCClass dependency from aspeed_soc_cpu_type() API
      hw/arm/aspeed: Remove AspeedSoCState dependency from aspeed_mmio_map() API
      hw/arm/aspeed: Remove AspeedSoCState dependency from aspeed_mmio_map_unimplemented() API
      hw/arm/aspeed: Remove AspeedSoCState dependency from aspeed_soc_uart_realize() API
      hw/arm/aspeed: Remove the aspeed_soc_get_irq and class get_irq hook
      hw/arm/aspeed: Introduce AspeedCoprocessor class and base implementation
      hw/arm/aspeed_ast27x0-ssp: Make AST27x0 SSP inherit from AspeedCoprocessor instead of AspeedSoC
      hw/arm/aspeed_ast27x0-tsp: Make AST27x0 TSP inherit from AspeedCoprocessor instead of AspeedSoC
      hw/arm/aspeed_ast27x0-ssp: Change to use Aspeed27x0CoprocessorState
      hw/arm/aspeed_ast27x0-tsp: Change to use Aspeed27x0CoprocessorState
      hw/arm/aspeed_ast27x0-ssp: Rename type to TYPE_ASPEED27X0SSP_COPROCESSOR
      hw/arm/aspeed_ast27x0-tsp: Rename type to TYPE_ASPEED27X0TSP_COPROCESSOR
      hw/arm/aspeed_ast27x0-{ssp,tsp}: Fix coding style

 docs/about/deprecated.rst                          |  27 +++++
 include/hw/arm/aspeed_coprocessor.h                |  61 +++++++++++
 include/hw/arm/aspeed_soc.h                        |  48 ++------
 hw/arm/aspeed.c                                    |  36 ++----
 hw/arm/aspeed_ast10x0.c                            |  89 +++++++++------
 hw/arm/aspeed_ast2400.c                            |  94 +++++++++-------
 hw/arm/aspeed_ast2600.c                            | 121 ++++++++++++---------
 hw/arm/aspeed_ast27x0-fc.c                         |  33 ++++--
 hw/arm/aspeed_ast27x0-ssp.c                        |  74 +++++++------
 hw/arm/aspeed_ast27x0-tsp.c                        |  74 +++++++------
 hw/arm/aspeed_ast27x0.c                            | 107 ++++++++++--------
 hw/arm/aspeed_coprocessor_common.c                 |  49 +++++++++
 hw/arm/aspeed_soc_common.c                         |  63 +++++------
 hw/arm/fby35.c                                     |  10 +-
 hw/arm/meson.build                                 |   7 +-
 tests/functional/aarch64/test_aspeed_ast2700.py    |  60 +++++-----
 tests/functional/aarch64/test_aspeed_ast2700fc.py  |  13 +++
 tests/functional/arm/meson.build                   |   6 +-
 tests/functional/arm/test_aspeed_ast1030.py        |  17 +--
 tests/functional/arm/test_aspeed_ast2500.py        |   8 +-
 ...ast2600.py => test_aspeed_ast2600_buildroot.py} |  74 -------------
 tests/functional/arm/test_aspeed_ast2600_sdk.py    |  94 ++++++++++++++++
 22 files changed, 690 insertions(+), 475 deletions(-)
 create mode 100644 include/hw/arm/aspeed_coprocessor.h
 create mode 100644 hw/arm/aspeed_coprocessor_common.c
 rename tests/functional/arm/{test_aspeed_ast2600.py => test_aspeed_ast2600_buildroot.py} (57%)
 create mode 100755 tests/functional/arm/test_aspeed_ast2600_sdk.py


