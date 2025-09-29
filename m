Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67854CAC5B0
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 16:53:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3H7S-0002ou-59; Mon, 29 Sep 2025 12:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7J-0002mE-FO
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1v3H7E-0002jK-Ia
 for qemu-devel@nongnu.org; Mon, 29 Sep 2025 12:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759164758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d/iGbdmlBZNiyz9t8R0hAS7z1l94a0lmE+dkEeEMxjs=;
 b=I7gp3Qo954RAT0obL2F5QxKmo9FqnTXIp+ARUPZa6Lg5qQmA60Rm1t59Q1wADGrwwYyOlC
 ACmdKLaDPhiV/RhG7NdCbD45YU/ob9ZqxUS8jV49DYgztQvHvmRuaj8QZomUdDPPW0MIZj
 vWw0ENNtSowLI9BRQ7VKYFcLNLuHUW4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-LLjkQu-xNMK1IRMXc0v77Q-1; Mon,
 29 Sep 2025 12:52:35 -0400
X-MC-Unique: LLjkQu-xNMK1IRMXc0v77Q-1
X-Mimecast-MFC-AGG-ID: LLjkQu-xNMK1IRMXc0v77Q_1759164754
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 12ACC180047F; Mon, 29 Sep 2025 16:52:34 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.27])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 911AF1800452; Mon, 29 Sep 2025 16:52:32 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/32] aspeed queue
Date: Mon, 29 Sep 2025 18:51:58 +0200
Message-ID: <20250929165230.797471-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.513,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The following changes since commit 4975b64efb5aa4248cbc3760312bbe08d6e71638:

  Merge tag 'pull-loongarch-20250928' of https://github.com/bibo-mao/qemu into staging (2025-09-28 09:01:35 -0700)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20250929

for you to fetch changes up to 9ec30a07483640ecb8417fce3dfa9273f7a036c9:

  hw/arm/aspeed_ast27x0-fc: Make sub-init functions return bool with errp (2025-09-29 18:00:20 +0200)

----------------------------------------------------------------
aspeed queue:

* Introduce a new ASPEED OTP memory device model integrated with the
  Secure Boot Controller. It includes a new block device backend
  ('drive' property), is enabled for AST2600 SoCs and AST1030 SoCs.
  Functional tests are included
* Changed "ast2700-evb" alias to point to the "ast2700a1-evb" machine
* Introduce support for Aspeed PCIe host controller, including models
  for the PCIe Root Complex, Root Port, and PHY. Enabled for the
  AST2600 and AST2700 SoCs, and functional tests are included
* Refactor Boot ROM support to improve code reuse across the different
  Aspeed machine. This is in preparation of vbootrom support in the
  ast2700fc machine
* Improved Error Handling in the AST27x0-fc machine init functions

----------------------------------------------------------------
Jamin Lin (20):
      hw/arm/aspeed Move ast2700-evb alias to ast2700a1-evb
      hw/pci/pci_ids: Add PCI vendor ID for ASPEED
      hw/pci-host/aspeed: Add AST2600 PCIe PHY model
      hw/pci-host/aspeed: Add AST2600 PCIe config space and host bridge
      hw/pci-host/aspeed: Add AST2600 PCIe Root Device support
      hw/pci-host/aspeed: Add AST2600 PCIe Root Port and make address configurable
      hw/pci-host/aspeed: Add MSI support and per-RC IOMMU address space
      hw/arm/aspeed: Wire up PCIe devices in SoC model
      hw/arm/aspeed_ast2600: Add PCIe RC support (RC_H only)
      hw/pci-host/aspeed: Add AST2700 PCIe PHY
      hw/pci-host/aspeed: Add AST2700 PCIe config with dedicated H2X blocks
      hw/pci-host/aspeed: Disable Root Device and place Root Port at 00:00.0 to AST2700
      hw/arm/aspeed_ast27x0: Introduce 3 PCIe RCs for AST2700
      tests/functional/arm/test_aspeed_ast2600: Add PCIe and network test
      hw/arm/aspeed: Move aspeed_board_init_flashes() to common SoC code
      hw/arm/aspeed: Move write_boot_rom to common SoC code
      hw/arm/aspeed: Move aspeed_install_boot_rom to common SoC code
      hw/arm/aspeed: Move aspeed_load_vbootrom to common SoC code
      hw/arm/aspeed_ast27x0-fc: Drop dead return checks
      hw/arm/aspeed_ast27x0-fc: Make sub-init functions return bool with errp

Kane-Chen-AS (12):
      hw/nvram/aspeed_otp: Add ASPEED OTP memory device model
      hw/misc/aspeed_sbc: Connect ASPEED OTP memory device to SBC
      hw/arm: Integrate ASPEED OTP memory support into AST2600 SoCs
      hw/nvram/aspeed_otp: Add 'drive' property to support block backend
      hw/nvram/aspeed_otp: Add OTP programming semantics and tracing
      hw/arm: Integrate ASPEED OTP memory support into AST1030 SoCs
      hw/misc/aspeed_sbc: Add CAMP2 support for OTP data reads
      hw/misc/aspeed_sbc: Handle OTP write command for voltage mode registers
      docs/system/arm/aspeed: Document OTP memory options
      tests/functional/arm: Add helper to generate OTP images
      tests/functional/arm: Add AST1030 boot test with generated OTP image
      tests/functional/arm: Add AST2600 boot test with generated OTP image

 docs/system/arm/aspeed.rst                      |   31 +
 include/hw/arm/aspeed_soc.h                     |   23 +
 include/hw/misc/aspeed_sbc.h                    |    6 +
 include/hw/nvram/aspeed_otp.h                   |   33 +
 include/hw/pci-host/aspeed_pcie.h               |  137 +++
 include/hw/pci/pci_ids.h                        |    2 +
 hw/arm/aspeed.c                                 |  107 +--
 hw/arm/aspeed_ast10x0.c                         |    2 +-
 hw/arm/aspeed_ast2600.c                         |   76 +-
 hw/arm/aspeed_ast27x0-fc.c                      |   77 +-
 hw/arm/aspeed_ast27x0.c                         |   74 ++
 hw/arm/aspeed_soc_common.c                      |   96 +++
 hw/misc/aspeed_sbc.c                            |  197 +++++
 hw/nvram/aspeed_otp.c                           |  190 +++++
 hw/pci-host/aspeed_pcie.c                       | 1015 +++++++++++++++++++++++
 hw/arm/Kconfig                                  |    3 +
 hw/misc/trace-events                            |    6 +
 hw/nvram/meson.build                            |    4 +
 hw/nvram/trace-events                           |    5 +
 hw/pci-host/Kconfig                             |    4 +
 hw/pci-host/meson.build                         |    1 +
 hw/pci-host/trace-events                        |   11 +
 tests/functional/aarch64/test_aspeed_ast2700.py |    4 +-
 tests/functional/arm/test_aspeed_ast1030.py     |   24 +-
 tests/functional/arm/test_aspeed_ast2600.py     |   36 +
 tests/functional/aspeed.py                      |    8 +
 26 files changed, 2019 insertions(+), 153 deletions(-)
 create mode 100644 include/hw/nvram/aspeed_otp.h
 create mode 100644 include/hw/pci-host/aspeed_pcie.h
 create mode 100644 hw/nvram/aspeed_otp.c
 create mode 100644 hw/pci-host/aspeed_pcie.c


