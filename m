Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44252CCD1BE
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Oct 2025 00:07:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBiqn-0007mh-OP; Wed, 22 Oct 2025 20:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqT-0007bV-9n; Wed, 22 Oct 2025 20:06:22 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vBiqK-0004Y0-IT; Wed, 22 Oct 2025 20:06:20 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 00E3F5972EF;
 Thu, 23 Oct 2025 02:06:09 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id 84lVZbgtFuqn; Thu, 23 Oct 2025 02:06:06 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B39F05972E5; Thu, 23 Oct 2025 02:06:06 +0200 (CEST)
Message-ID: <cover.1761176219.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 00/12] Pegasos2 clean up and pegasos1 emulation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Thu, 23 Oct 2025 02:06:06 +0200 (CEST)
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series changes how the fdt for VOF is generated in pegasos2 by
moving the static parts to a dtb and only generate the changing parts
such as memory size and PCI devices programmatically. This simplifies
the code and allows simply adding emulation of Pegasos I which has a
different north bridge and slightly different memory map but otherwise
very similar and can be emulated by reusing parts from the amigaone
machine. The machine was tested with a Pegasos I ROM image and MorphOS.

The first VOF patch (submitted separetely before, the reviewed v3 is
included here) fixes handling the name property in VOF that cannot be
represented in a dts as that always takes the path as the name and
cannot accept an explicit name property but we need the name property
to appear when guest queries properties which previously was worked
around by adding it to every node.

Regards,
BALATON Zoltan

Link to previous version:
https://patchew.org/QEMU/cover.1760798392.git.balaton@eik.bme.hu/

v4:
- rebase on master
- added some R-b tags from and changes suggested by Philippe
- reworded commit message of patch 8 trying to clarify it

v3:
- rebase on master

v2:
- rebase on master
- added some R-b tags from Philippe
- move first patch later (was first to allow merging separately)
- clarify blurb above

BALATON Zoltan (12):
  ppc/vof: Make nextprop behave more like Open Firmware
  hw/ppc/pegasos2: Remove explicit name properties from device tree
  hw/ppc/pegasos2: Change device tree generation
  hw/ppc/pegasos2: Remove fdt pointer from machine state
  hw/ppc/pegasos2: Rename mv field in machine state
  hw/ppc/pegasos2: Add south bridge pointer in the machine state
  hw/ppc/pegasos2: Move PCI IRQ routing setup to a function
  hw/ppc/pegasos2: Move hardware specific parts out of machine reset
  hw/ppc/pegasos2: Introduce abstract superclass
  hw/ppc/pegasos2: Add bus frequency to machine state
  hw/ppc/pegasos2: Add Pegasos I emulation
  hw/ppc/pegasos2: Add VOF support for pegasos1

 MAINTAINERS              |   1 +
 hw/ppc/pegasos2.c        | 769 +++++++++++++++++++--------------------
 hw/ppc/vof.c             |  50 ++-
 pc-bios/dtb/meson.build  |   2 +
 pc-bios/dtb/pegasos1.dtb | Bin 0 -> 857 bytes
 pc-bios/dtb/pegasos1.dts | 125 +++++++
 pc-bios/dtb/pegasos2.dtb | Bin 0 -> 1701 bytes
 pc-bios/dtb/pegasos2.dts | 167 +++++++++
 8 files changed, 703 insertions(+), 411 deletions(-)
 create mode 100644 pc-bios/dtb/pegasos1.dtb
 create mode 100644 pc-bios/dtb/pegasos1.dts
 create mode 100644 pc-bios/dtb/pegasos2.dtb
 create mode 100644 pc-bios/dtb/pegasos2.dts

-- 
2.41.3


