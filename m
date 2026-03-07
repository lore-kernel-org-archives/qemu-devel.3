Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F6DF55121
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 23:06:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vz0iq-0006a4-Su; Sat, 07 Mar 2026 18:06:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz0im-0006ZK-Nq
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:06:08 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1vz0ij-0002wy-SG
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 18:06:08 -0500
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id C285E596DA2;
 Sun, 08 Mar 2026 00:06:04 +0100 (CET)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id GVAjvmGkOJOU; Sun,  8 Mar 2026 00:06:02 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id BAB65596DA3; Sun, 08 Mar 2026 00:06:02 +0100 (CET)
Message-ID: <0a57625ac909c2b005302b9136920cb917427a8b.1772924151.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1772924151.git.balaton@eik.bme.hu>
References: <cover.1772924151.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v10 4/9] hw/xtensa/xtfpga:  Do not use
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
Date: Sun, 08 Mar 2026 00:06:02 +0100 (CET)
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
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
 hw/xtensa/xtfpga.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/hw/xtensa/xtfpga.c b/hw/xtensa/xtfpga.c
index d427d68e50..ed24720f94 100644
--- a/hw/xtensa/xtfpga.c
+++ b/hw/xtensa/xtfpga.c
@@ -50,7 +50,6 @@
 #include "xtensa_memory.h"
 #include "hw/xtensa/mx_pic.h"
 #include "exec/cpu-common.h"
-#include "migration/vmstate.h"
 
 typedef struct XtfpgaFlashDesc {
     hwaddr base;
@@ -163,9 +162,8 @@ static void xtfpga_net_init(MemoryRegion *address_space,
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


