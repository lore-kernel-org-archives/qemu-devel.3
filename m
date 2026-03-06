Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A15F513ED
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 01:42:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyKBb-0008Jr-UO; Thu, 05 Mar 2026 20:41:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBa-0008In-90
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:41:02 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vyKBY-0006Eg-Ro
 for qemu-devel@nongnu.org; Thu, 05 Mar 2026 20:41:02 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id B208C596D9B;
 Fri, 06 Mar 2026 02:40:58 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id tYFkCoQqAWoI; Fri,  6 Mar 2026 02:40:56 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id B39A9596DA2; Fri, 06 Mar 2026 02:40:56 +0100 (CET)
Message-ID: <ab3d9d449484c4597e9548bb8ffc4c30f3808f12.1772760714.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772760714.git.balaton@eik.bme.hu>
References: <cover.1772760714.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v8 4/8] hw/xtensa/xtfpga:  Do not use
 memory_region_init_ram_nomigrate()
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
Date: Fri, 06 Mar 2026 02:40:56 +0100 (CET)
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

Convert to use memory_region_init_ram() instead. This breaks migration
but the machines using this device have no migration compatibility
guarantee.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/xtensa/xtfpga.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d427d68e50..d40fccf9e5 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -163,9 +163,8 @@ static void xtfpga_net_init(MemoryRegion *address_space,
             sysbus_mmio_get_region(s, 1));
 
     ram = g_malloc(sizeof(*ram));
-    memory_region_init_ram_nomigrate(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
+    memory_region_init_ram(ram, OBJECT(s), "open_eth.ram", 16 * KiB,
                            &error_fatal);
-    vmstate_register_ram_global(ram);
     memory_region_add_subregion(address_space, buffers, ram);
 }
 
-- 
2.41.3


