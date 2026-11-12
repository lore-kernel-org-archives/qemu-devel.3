Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EAFF606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:51:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRX50-0007Jz-TK; Thu, 12 Nov 2026 10:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKh-0005hO-Eq; Thu, 12 Nov 2026 10:03:30 -0500
Received: from mail-a.sr.ht ([46.23.81.152])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <outgoing@sr.ht>)
 id 1xRWKb-0004Le-B4; Thu, 12 Nov 2026 10:03:21 -0500
DKIM-Signature: a=rsa-sha256; bh=O/nkSh+NON99nXg4hfH0LZO2BaJbAJX3TGy+mLeJ6TI=; 
 c=simple/simple; d=git.sr.ht;
 h=From:Date:Subject:Reply-to:To:Cc; 
 q=dns/txt; s=20240113; t=1794495789; v=1;
 b=rFShEpbdDwsgdCSQhd3717IUNk/RRGKwy+nm5lB8B4m8XTduLUbrfmBoD2aLhhhW8uA7fH9j
 6v4Fo/WynKHCBhYgZzCWRaN0aJ9OeQ1apbOvGBj8bJgBLbtmc6JA+zPw1y83Z2flo4QgOqaMg4d
 dFGPB4EaS0TyXSn/0JpBijnkCwMgj3ojPtfRTt468VdowUP0D/uYw2UiGUMSCs/00gENN9nbxAH
 hN7j42z4eaLROTCGBfUDjiN3vxTioLkfQR5ww3A90fQlflvLefVFCB40p2u6+YEyJqY36TWBlB/
 ERL2f6EncmAq9nH/aOAC49bzyJOiXucPrWtM9tH2SJ79Q==
Received: from git.sr.ht (unknown [46.23.81.155])
 by mail-a.sr.ht (Postfix) with ESMTPSA id 92FDB22F0B;
 Thu, 12 Nov 2026 15:03:09 +0000 (UTC)
From: ~mohammadodeh <mohammadodeh@git.sr.ht>
Date: Thu, 12 Nov 2026 15:03:09 +0000
Subject: [PATCH qemu 0/3] hw/arm: Add STM32L496G-DISCO QuadSPI support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-ID: <179449578952.8382.2790865629085512841-0@git.sr.ht>
X-Mailer: git.sr.ht
To: qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Samuel Tardieu <sam@rfc1149.net>, Alistair Francis <alistair@alistair23.me>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?utf-8?q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>, Gaurav Sharma <gaurav.sharma_7@nxp.com>, 
 Jan Kiszka <jan.kiszka@web.de>, Bin Meng <bin.meng@processmission.com>,
 Shameer Kolothum <skolothumtho@nvidia.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, qemu-block@nongnu.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=46.23.81.152; envelope-from=outgoing@sr.ht;
 helo=mail-a.sr.ht
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 12 Nov 2026 10:51:09 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: ~mohammadodeh <Mohammad.Odeh@exalt.ps>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add initial QEMU support for the STM32L496G-DISCO Discovery kit and
its MX25R6435F QuadSPI flash.

The series adds the flash model, the shared STM32L4x5 QuadSPI
controller, and the STM32L496xG SoC and board definitions.

The controller supports indirect reads and writes with a 16-byte FIFO,
enable and abort handling, address bounds checks, undefined-length
transfers, partial register accesses, and migration state restoration.

The board qtest has 21 passing cases covering identification, SFDP,
program/read transfers, FIFO behavior, single/dual/quad read frames,
error handling, and migration.

Transfer timing, automatic polling, memory-mapped mode, DMA, DDR,
SIOO, and dual-flash operation are not implemented.

Mohammad Odeh (3):
  hw/block: Add Macronix MX25R6435F flash
  hw/ssi: Add STM32L4x5 QuadSPI controller
  hw/arm: Add STM32L496G-DISCO machine

 MAINTAINERS                          |   9 +
 docs/system/arm/stm32.rst            |   1 +
 docs/system/arm/stm32l496g-disco.rst |  43 ++
 docs/system/target-arm.rst           |   1 +
 hw/arm/Kconfig                       |   8 +
 hw/arm/meson.build                   |   1 +
 hw/arm/stm32l496g-disco.c            |  95 ++++
 hw/arm/stm32l4x5_soc.c               |  42 +-
 hw/block/m25p80.c                    |   5 +
 hw/block/m25p80_sfdp.c               |  20 +
 hw/block/m25p80_sfdp.h               |   1 +
 hw/ssi/Kconfig                       |   4 +
 hw/ssi/meson.build                   |   1 +
 hw/ssi/stm32l4x5_quadspi.c           | 680 ++++++++++++++++++++++++++
 include/hw/arm/stm32l4x5_soc.h       |   5 +
 include/hw/ssi/stm32l4x5_quadspi.h   |  51 ++
 tests/qtest/meson.build              |   1 +
 tests/qtest/stm32l496g-disco-test.c  | 693 +++++++++++++++++++++++++++
 18 files changed, 1657 insertions(+), 4 deletions(-)
 create mode 100644 docs/system/arm/stm32l496g-disco.rst
 create mode 100644 hw/arm/stm32l496g-disco.c
 create mode 100644 hw/ssi/stm32l4x5_quadspi.c
 create mode 100644 include/hw/ssi/stm32l4x5_quadspi.h
 create mode 100644 tests/qtest/stm32l496g-disco-test.c

-- 
2.49.1

