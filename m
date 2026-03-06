Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED5AF01835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 13:20:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyV5n-0005H0-F5; Fri, 06 Mar 2026 08:19:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyV5m-0005Gl-7O
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:19:46 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyV5k-000266-Dr
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 08:19:45 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5B8AF596D9A;
 Fri, 06 Mar 2026 14:19:41 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id DkrOlbY_jzbX; Fri,  6 Mar 2026 14:19:39 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5A7B75969F6; Fri, 06 Mar 2026 14:19:39 +0100 (CET)
Message-ID: <cover.1772802886.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v9 0/8] memory: Remove most _nomigrate variants
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
Date: Fri, 06 Mar 2026 14:19:39 +0100 (CET)
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

v9:
- call qemu_ram_alloc after memory_region_init (Akihiko)
- add R-b tag to xtfpga patch

v8:
- reorganise patches to move simpler ones earlier
- drop error_propagate as suggested by Akihiko Odaki to follow current
  recommendations and so we don't need local err and don't have to
  pass errp to helper function

v7:
- convert xtfpga from global vmstate; this leaves just the vga usage
  of memory_region_init_ram_nomigrate so the >1 use is not anymore an
  argument therefore remove memory_region_init_ram_nomigrate too
- drop memory_region_error_propagate() until we can agree on what to
  do with it

v6:
- keep the last two uses of memory_region_init_ram_nomigrate in vga and xtfpga for now
- added R-b tags

v5:
- convert Sun machines and their display devices from global vmstate

v4:
- separate patch converting Sun machines from memory_region_init_ram_nomigrate
- split helper to init ram into two functions: setup and error_propagate
- also use memory_region_init_io in memory_region_init_ram_device_ptr

v3:
- rebased on master after some patches were merged
- drop some more line from memory-region-housekeeping.cocci
- added comment to explain what factored out helper does
- some more clean ups included

BALATON Zoltan (8):
  hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
  memory: Remove memory_region_init_rom_nomigrate()
  sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
  hw/xtensa/xtfpga:  Do not use memory_region_init_ram_nomigrate()
  memory: Remove memory_region_init_ram_nomigrate()
  memory: Shorten memory_region_init_ram_device_ptr and
    memory_region_init_rom_device
  memory: Add internal memory_region_register_ram function
  memory: Factor out common ram region initialization

 docs/devel/memory.rst                         |   9 +-
 hw/display/cg3.c                              |   5 +-
 hw/display/tcx.c                              |   8 +-
 hw/display/vga.c                              |   4 +-
 hw/sparc/sun4m.c                              |  19 +-
 hw/sparc64/sun4u.c                            |  10 +-
 hw/xtensa/xtfpga.c                            |   3 +-
 include/system/memory.h                       |  49 ----
 .../memory-region-housekeeping.cocci          |  47 ---
 system/memory.c                               | 275 ++++++------------
 10 files changed, 105 insertions(+), 324 deletions(-)

-- 
2.41.3


