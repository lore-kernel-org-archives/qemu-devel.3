Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF077E7DEEE
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 14:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmuv0-0003GM-Nz; Mon, 02 Feb 2026 09:28:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vmuub-0003En-2s
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:26 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vmuuY-0006QQ-Iy
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 09:28:19 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 22302596E8E;
 Mon, 02 Feb 2026 15:28:13 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id C3gWxZ1N-7ee; Mon,  2 Feb 2026 15:28:11 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 20D20596E8D; Mon, 02 Feb 2026 15:28:11 +0100 (CET)
Message-ID: <cover.1770042013.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 0/7] memory: Remove most _nomigrate variants
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Gerd Hoffmann <kraxel@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Date: Mon, 02 Feb 2026 15:28:11 +0100 (CET)
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

v2 of the memory region API clean ups. The _nomigrate variants are
rarely needed, some of them are already unused so remove them
standardising on memory_region_init_ram_flags_nomigrate() for the few
cases where this is really needed. The Sun machines are kept to use
global vmstate and added a few more clean up patches from my previous
series.

BALATON Zoltan (7):
  memory: Remove memory_region_init_rom_device_nomigrate()
  hw/display/{cg3,tcx}: Do not use memory_region_init_rom_nomigrate()
  memory: Remove memory_region_init_rom_nomigrate()
  memory: Remove memory_region_init_ram_nomigrate()
  memory: Add internal memory_region_set_ops helper function
  memory: Factor out common ram region initialization
  memory: Add internal memory_region_register_ram function

 docs/devel/memory.rst                         |  10 +-
 hw/display/cg3.c                              |   6 +-
 hw/display/tcx.c                              |  11 +-
 hw/display/vga.c                              |   4 +-
 hw/sparc/sun4m.c                              |  15 +-
 hw/sparc64/sun4u.c                            |   9 +-
 hw/xtensa/xtfpga.c                            |   4 +-
 include/system/memory.h                       |  76 -----
 .../memory-region-housekeeping.cocci          |  42 +--
 system/memory.c                               | 271 ++++++------------
 10 files changed, 114 insertions(+), 334 deletions(-)

-- 
2.41.3


