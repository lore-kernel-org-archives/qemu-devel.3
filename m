Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F4A1F33A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2026 14:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vy9Wi-00083x-C3; Thu, 05 Mar 2026 09:18:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vy9Wd-00083B-0E
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:18:03 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vy9Wa-0000ss-8L
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 09:18:02 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 347DA596D9A;
 Thu, 05 Mar 2026 15:17:57 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id q2H66-Ls7Zva; Thu,  5 Mar 2026 15:17:55 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 365B2596D9B; Thu, 05 Mar 2026 15:17:55 +0100 (CET)
Message-ID: <cover.1772719690.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v7 0/9] memory: Remove most _nomigrate variants
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
Date: Thu, 05 Mar 2026 15:17:55 +0100 (CET)
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.892, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.622,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

BALATON Zoltan (9):
  hw/display/{cg3.tcx}: Do not use memory_region_init_rom_nomigrate()
  memory: Remove memory_region_init_rom_nomigrate()
  sun4m,sun4u,tcx: Do not use memory_region_init_ram_nomigrate()
  hw/xtensa/xtfpga:  Do not use memory_region_init_ram_nomigrate()
  memory: Remove memory_region_init_ram_nomigrate()
  memory: Factor out common ram region initialization
  memory: Add internal memory_region_register_ram function
  memory: Shorten memory_region_init_ram_device_ptr and
    memory_region_init_rom_device
  memory: Factor out more common ram region initialization

 docs/devel/memory.rst                         |   9 +-
 hw/display/cg3.c                              |   5 +-
 hw/display/tcx.c                              |   8 +-
 hw/display/vga.c                              |   4 +-
 hw/sparc/sun4m.c                              |  19 +-
 hw/sparc64/sun4u.c                            |  10 +-
 hw/xtensa/xtfpga.c                            |   3 +-
 include/system/memory.h                       |  49 ----
 .../memory-region-housekeeping.cocci          |  47 ----
 system/memory.c                               | 224 ++++++------------
 10 files changed, 92 insertions(+), 286 deletions(-)

-- 
2.41.3


