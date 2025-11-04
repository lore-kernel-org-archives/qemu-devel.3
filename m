Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C1D7CCFA00
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 08:32:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGCSN-0000H0-39; Tue, 04 Nov 2025 03:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSL-0000Fw-Cm
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vGCSI-0003OP-DN
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 03:31:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762245113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Swd1O68GyBddhiY3gOAJBYm7+QWL5XItAHPH67PsRYk=;
 b=MEPUal9OyptxWNaFilZDQOVdbKHRQbas8VMiZig6O0Rmd+GJXes3CrOojpACjvt5pcgzn0
 Q97XJGsbt4KTv4O1w76ERrQW/Z/GYeqPBNFdVHdJcb3x09Mx6A0nbxPXIW47N3LesAf4YS
 DxCz4Y5SAhXPsvSkqnxEMS4bc61tZlI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-0yksE5WQPSCKo0_zXUgBZA-1; Tue,
 04 Nov 2025 03:31:50 -0500
X-MC-Unique: 0yksE5WQPSCKo0_zXUgBZA-1
X-Mimecast-MFC-AGG-ID: 0yksE5WQPSCKo0_zXUgBZA_1762245109
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E0D6180057A; Tue,  4 Nov 2025 08:31:49 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.33.250])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 57C4D19560A2; Tue,  4 Nov 2025 08:31:46 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 00/30] aspeed queue
Date: Tue,  4 Nov 2025 09:31:14 +0100
Message-ID: <20251104083144.187806-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:

  Merge tag 'igvm-20251103--pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)

are available in the Git repository at:

  https://github.com/legoater/qemu/ tags/pull-aspeed-20251104

for you to fetch changes up to 1d2a5f8f5d6478504e80be0fcee5ca88adac5921:

  hw/arm/aspeed: Split AST1030 EVB machine into a separate source file for maintainability (2025-11-04 09:27:59 +0100)

----------------------------------------------------------------
aspeed queue:

* Move Aspeed machine models in separate source files to ease maintenance

----------------------------------------------------------------
Jamin Lin (30):
      hw/arm/aspeed: Move AspeedMachineState definition to common header for reuse
      hw/arm/aspeed: Make aspeed_machine_class_init_cpus_defaults() globally accessible
      hw/arm/aspeed: Export and rename create_pca9552() for reuse
      hw/arm/aspeed: Rename and export create_pca9554() as aspeed_create_pca9554()
      hw/arm/aspeed: Split FP5280G2 machine into a separate source file for maintenance
      hw/arm/aspeed: Split G220A machine into a separate source file for better maintenance
      hw/arm/aspeed: Split Tiogapass machine into a separate source file for cleanup
      hw/arm/aspeed: Split YosemiteV2 machine into a separate source file for maintainability
      hw/arm/aspeed: Split Witherspoon machine into a separate source file for maintainability
      hw/arm/aspeed: Split Sonorapass machine into a separate source file for maintainability
      hw/arm/aspeed: Split Romulus machine into a separate source file for maintainability
      hw/arm/aspeed: Split Supermicro X11SPI machine into a separate file for maintainability
      hw/arm/aspeed: Split AST2500 EVB machine into a separate source file for maintainability
      hw/arm/aspeed: Split Quanta-Q71L machine into a separate source file for maintainability
      hw/arm/aspeed: Split Supermicro X11 machine into a separate source file for maintainability
      hw/arm/aspeed: Split Palmetto machine into a separate source file for maintainability
      hw/arm/aspeed: Move ASPEED_RAM_SIZE() macro to common header for reuse
      hw/arm/aspeed: Split Bletchley machine into a separate source file for maintainability
      hw/arm/aspeed: Split FBY35 BMC machine into a separate source file for maintainability
      hw/arm/aspeed: Split Fuji machine into a separate source file for maintainability
      hw/arm/aspeed: Split QCOM Firework machine into a separate source file for maintainability
      hw/arm/aspeed: Split QCOM DC-SCM V1 machine into a separate source file for maintainability
      hw/arm/aspeed: Make aspeed_machine_ast2600_class_emmc_init() a common API for eMMC boot setup
      hw/arm/aspeed: Split GB200NVL machine into a separate source file for maintainability
      hw/arm/aspeed: Split Rainier machine into a separate source file for maintainability
      hw/arm/aspeed: Split Catalina machine into a separate source file for maintainability
      hw/arm/aspeed: Split AST2600 EVB machine into a separate source file for maintainability
      hw/arm/aspeed: Split AST2700 EVB machine into a separate source file for maintainability
      hw/arm/aspeed: Rename and export connect_serial_hds_to_uarts() as aspeed_connect_serial_hds_to_uarts()
      hw/arm/aspeed: Split AST1030 EVB machine into a separate source file for maintainability

 hw/arm/aspeed_eeprom.h                    |   32 -
 include/hw/arm/aspeed.h                   |   79 ++
 hw/arm/aspeed.c                           | 1678 +----------------------------
 hw/arm/aspeed_ast10x0_evb.c               |  108 ++
 hw/arm/aspeed_ast2400_palmetto.c          |   80 ++
 hw/arm/aspeed_ast2400_quanta-q71l.c       |   86 ++
 hw/arm/aspeed_ast2400_supermicrox11.c     |   81 ++
 hw/arm/aspeed_ast2500_evb.c               |   67 ++
 hw/arm/aspeed_ast2500_fp5280g2.c          |   88 ++
 hw/arm/aspeed_ast2500_g220a.c             |   92 ++
 hw/arm/aspeed_ast2500_romulus.c           |   62 ++
 hw/arm/aspeed_ast2500_sonorapass.c        |  102 ++
 hw/arm/aspeed_ast2500_supermicro-x11spi.c |   77 ++
 hw/arm/aspeed_ast2500_tiogapass.c         |   90 ++
 hw/arm/aspeed_ast2500_witherspoon.c       |  112 ++
 hw/arm/aspeed_ast2500_yosemitev2.c        |   91 ++
 hw/arm/aspeed_ast2600_bletchley.c         |   97 ++
 hw/arm/aspeed_ast2600_catalina.c          |  225 ++++
 hw/arm/aspeed_ast2600_evb.c               |   65 ++
 hw/arm/aspeed_ast2600_fby35.c             |  178 +++
 hw/arm/aspeed_ast2600_fuji.c              |  140 +++
 hw/arm/aspeed_ast2600_gb200nvl.c          |  111 ++
 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c    |   55 +
 hw/arm/aspeed_ast2600_qcom-firework.c     |   91 ++
 hw/arm/aspeed_ast2600_rainier.c           |  198 ++++
 hw/arm/aspeed_ast27x0_evb.c               |   88 ++
 hw/arm/aspeed_eeprom.c                    |  192 ----
 hw/arm/meson.build                        |   24 +-
 28 files changed, 2492 insertions(+), 1897 deletions(-)
 delete mode 100644 hw/arm/aspeed_eeprom.h
 create mode 100644 hw/arm/aspeed_ast10x0_evb.c
 create mode 100644 hw/arm/aspeed_ast2400_palmetto.c
 create mode 100644 hw/arm/aspeed_ast2400_quanta-q71l.c
 create mode 100644 hw/arm/aspeed_ast2400_supermicrox11.c
 create mode 100644 hw/arm/aspeed_ast2500_evb.c
 create mode 100644 hw/arm/aspeed_ast2500_fp5280g2.c
 create mode 100644 hw/arm/aspeed_ast2500_g220a.c
 create mode 100644 hw/arm/aspeed_ast2500_romulus.c
 create mode 100644 hw/arm/aspeed_ast2500_sonorapass.c
 create mode 100644 hw/arm/aspeed_ast2500_supermicro-x11spi.c
 create mode 100644 hw/arm/aspeed_ast2500_tiogapass.c
 create mode 100644 hw/arm/aspeed_ast2500_witherspoon.c
 create mode 100644 hw/arm/aspeed_ast2500_yosemitev2.c
 create mode 100644 hw/arm/aspeed_ast2600_bletchley.c
 create mode 100644 hw/arm/aspeed_ast2600_catalina.c
 create mode 100644 hw/arm/aspeed_ast2600_evb.c
 create mode 100644 hw/arm/aspeed_ast2600_fby35.c
 create mode 100644 hw/arm/aspeed_ast2600_fuji.c
 create mode 100644 hw/arm/aspeed_ast2600_gb200nvl.c
 create mode 100644 hw/arm/aspeed_ast2600_qcom-dc-scm-v1.c
 create mode 100644 hw/arm/aspeed_ast2600_qcom-firework.c
 create mode 100644 hw/arm/aspeed_ast2600_rainier.c
 create mode 100644 hw/arm/aspeed_ast27x0_evb.c
 delete mode 100644 hw/arm/aspeed_eeprom.c


