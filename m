Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40730D2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:01:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDz-0001gi-RW; Wed, 23 Oct 2024 05:00:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDu-0001Y3-5l
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDs-0000N6-AZ
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 05:00:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=62yV6jFw3OK6jnsA0lQzJsjXvP3TJGM1iHN4+6yoExE=; b=cd1aPNmfGD6+ZrnKGED+C3ZCnD
 N7sQGLtpB97BPYOJAlEl+Rbv0cCa4V1zO6mwbUkfAefBiv5LibqW20pQ89KqNcgTEJZjvZk//aCnE
 jivF5992cHoKj+D+P8MT8ZIgTLJMtG6nUB+lJYE5bk3akc+K3l/EB+pkA0pmM7o5y0itDETY6dNBo
 OtWXEl8nDbIG1+Fz03kxIZf72XGZDnJeov6aaKWSEl7iMfALcaY3CQmwAWBIO6GVzxD49+D/3O5Ht
 j/BPTfuo5oniPwjbh72VGqjgQBdxpSkcSZb01dJp3addMhwwm1UNaA0MG42aukYzyTuMEfh44Ryvq
 RbRqURNCf8DB2rPBP4JlokTjXaU5kdyc2kUyw1tvvzhsG1eNRzsxZUmToZ0aWHGkNKORqxe29wOpq
 UxY4OPvVRNwr8z/l+R+6t3BAZzWrBhJ5XzF7O+uEZvV5mzopG4wZhaQJ4iZwhe4dpacS8RDx2Qm4B
 f8w+Ma30W6tqQPxQOrsXMQM8Znl8DiZ9veghsn8ZNeXnjWhLBGfpcXvb/1bGMAJjDgO7D++Kq226o
 V9L5pVjyz/V9ntu7Rtj6P4s6qQ+tJzs7CVim0/Ijyx9ySCFXZNf3ymrNsTgcJuzvUxJbiiSEsJcEN
 yH7Q6C7f4lgL9SpNNsp14UlZ3JivPODsyCN6hfBMA=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDO-0008EL-2U; Wed, 23 Oct 2024 09:59:42 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:32 +0100
Message-Id: <20241023085852.1061031-17-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 16/36] next-cube: add empty slots for unknown accesses to
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
---
 hw/m68k/Kconfig     | 1 +
 hw/m68k/next-cube.c | 6 ++++++
 2 files changed, 7 insertions(+)

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
index 3278970890..ac6d3cb634 100644
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
@@ -1239,6 +1240,11 @@ static void next_cube_init(MachineState *machine)
     /* BMAP IO - acts as a catch-all for now */
     sysbus_mmio_map(SYS_BUS_DEVICE(pcdev), 1, 0x02100000);
 
+    /* unknown */
+    empty_slot_init("next.unknown", 0x02110000, 0x10);
+    empty_slot_init("next.unknown", 0x02112000, 0x10);
+    empty_slot_init("next.unknown", 0x02118004, 0x10);
+
     /* BMAP memory */
     memory_region_init_ram_flags_nomigrate(&m->bmapm1, NULL, "next.bmapmem",
                                            64, RAM_SHARED, &error_fatal);
-- 
2.39.5


