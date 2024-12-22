Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D944E7718E
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:04:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLc0-0007IW-95; Sun, 22 Dec 2024 08:03:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaJ-0005U2-JU
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:30 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLaI-0000is-1x
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:01:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=9Whh7SYR2uu5b16XADIR680LIFmUJJNFCkhVG3BnC/Q=; b=x8KsmTDAtMGk2waG1Tkfbd+TSU
 CcUBSy2TkbC1wvmqz8qq8sF6gCnrROCqWOlZKOnMk9BBzXDqHI/cs8P3FgRITvfK/V+FH5hld57wz
 IU/b7kb1iefbbKjLZJfj/FsZ9TzaXzsBVYG6ACvVLGmP/fT5KB1ozjesAgedVImwU9pgSSt3thpUh
 fIJL92OODWDCB7WjJNUIq8BpOBvDaAkVqfVHvWkPE2CrU13DS1gacSDnWxRF6rzMYNDDfHiyb1AQc
 n7IjLZUA5qx25lkzLpFdfc3t0094ke0OcvdkMTqxMJAvL3X053pOvKxXHxhkLXn/2d/j476/0LhUk
 H0PkML4QCq0TnjcWVOEGKLbTI18XRYVAxUkycBCh+PfLxXrOp2d3vZu/4FnGGSK3oFzaUQj5X1aVN
 hWJyHh/YMcEEkMQSwlaDoHr2anGBzx/SwGd7yOifGcBheZuGrilSJ6+FeHRfynLxM1vTL5Q7p1P6u
 u3pyTvfA4gQfPrIL8AMokwHEWgtyvZC2D1ieyg5ZfW4Of0FGussHOtk7MDJwcrPBtZR6mOqGwUu9k
 ttxzLklB7hSKuxoifJJdyAxjU14GZNNEOWy306CYU3/IwVXl2RWCY1H4uctbIlD4Zc2uMVvoSHSmc
 rPzMQ8gocPUjLrHlewUOO8hlQG2/H8IajzpMYRp4Q=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZV-0002L7-Ly; Sun, 22 Dec 2024 13:00:41 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:53 +0000
Message-Id: <20241222130012.1013374-15-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 14/33] next-cube: add empty slots for unknown accesses to
 next.scr memory region
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

The next.scr memory is now effectively unused, however there are 3 separate region
accesses still logged that occur when booting a NeXTStep disk image. Use the
empty_slot device to capture and ignore memory accesses to these 3 memory regions.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/Kconfig     | 1 +
 hw/m68k/next-cube.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/hw/m68k/Kconfig b/hw/m68k/Kconfig
index 0092cda4e9..aff769b30f 100644
--- a/hw/m68k/Kconfig
+++ b/hw/m68k/Kconfig
@@ -18,6 +18,7 @@ config NEXTCUBE
     depends on M68K
     select FRAMEBUFFER
     select ESCC
+    select EMPTY_SLOT
 
 config Q800
     bool
diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 32d1108b2a..67432801a3 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -22,6 +22,7 @@
 #include "qom/object.h"
 #include "hw/char/escc.h" /* ZILOG 8530 Serial Emulation */
 #include "hw/block/fdc.h"
+#include "hw/misc/empty_slot.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -1238,6 +1239,13 @@ static void next_cube_init(MachineState *machine)
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
+    /* unknown: Brightness control register? */
+    empty_slot_init("next.unknown.0", 0x02110000, 0x10);
+    /* unknown: Magneto-Optical drive controller? */
+    empty_slot_init("next.unknown.1", 0x02112000, 0x10);
+    /* unknown: Serial clock configuration register? */
+    empty_slot_init("next.unknown.2", 0x02118004, 0x10);
+
     /* BMAP memory */
     memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
                                            64, RAM_SHARED, &error_fatal);
-- 
2.39.5


