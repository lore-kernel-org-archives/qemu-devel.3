Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A93FCAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 18:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzJi4-0001rd-V9; Thu, 18 Sep 2025 14:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJi3-0001qa-FG; Thu, 18 Sep 2025 14:50:23 -0400
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1uzJhp-0003F4-Ra; Thu, 18 Sep 2025 14:50:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5086056F30D;
 Thu, 18 Sep 2025 20:50:06 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id hX23Mv9mT3G8; Thu, 18 Sep 2025 20:50:04 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 4D6EE56F30C; Thu, 18 Sep 2025 20:50:04 +0200 (CEST)
Message-ID: <cover.1758219840.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 00/14] hw/pci-host/raven clean ups
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Nicholas Piggin <npiggin@gmail.com>
Date: Thu, 18 Sep 2025 20:50:04 +0200 (CEST)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Hello,

This series cleans up and simplifies the raven model which does some
strange stuff that no other pci-host is doing and does it in a
convoluted way and also has some legacy bits that can be removed.
Apart from making the model much more readable this also fixes the
non-contiguous IO control bit which was there but did not work as it
was not connected but apparently it's not really used by any guest so
that wasn't noticed.

Regards,
BALATON Zoltan

V3:
- rebase on master
- Fix issue with device-crash-test reported by Akihiko Odaki: make
sure device is correctly used by adding assert and making it not user
creatable in patch 14.

v2:
- rebase on master
- add R-b tags from Philippe

BALATON Zoltan (14):
  hw/pci-host/raven: Simplify PCI facing part
  hw/pci-host/raven: Simplify host bridge type declaration
  hw/pci-host/raven: Use DEFINE_TYPES macro
  hw/pci-host/raven: Simplify PCI bus creation
  hw/pci-host/raven: Simplify PCI interrupt routing
  hw/pci-host/raven: Simplify direct config access address decoding
  hw/pci-host/raven: Rename direct config access ops
  hw/pci-host/raven: Use correct parameter in direct access ops
  hw/pci-host/raven: Do not use parent object for mmcfg region
  hw/pci-host/raven: Fix PCI config direct access region
  hw/pci-host/raven: Simpify discontiguous IO access
  hw/pci-host/raven: Move bus master address space creation to one place
  hw/pci-host/raven: Do not map regions in init method
  hw/ppc/prep: Fix non-contiguous IO control bit

 hw/pci-host/raven.c       | 328 ++++++++++++--------------------------
 hw/ppc/prep.c             |  19 ++-
 hw/ppc/prep_systemio.c    |  17 +-
 include/hw/pci/pci_host.h |   1 -
 4 files changed, 130 insertions(+), 235 deletions(-)

-- 
2.41.3


