Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676ADD2E027
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2024 09:01:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3XDb-0000cI-86; Wed, 23 Oct 2024 04:59:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDZ-0000Vr-4B
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:49 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDX-0000MN-Q1
 for qemu-devel@nongnu.org; Wed, 23 Oct 2024 04:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=EoTiya6VZ0j7GKq46XagFLfXrslNtHrc3JXeyQosHJA=; b=KJ1vGpKCpYJHIm+Mdo3zoV8WRi
 vRG+ByWUyBTBdv3XATlgjdm97d8Fjoge0B75PnLRdf8DbrrdLiNdfwmJMo7rei7fs7iCwtuHdKZat
 +/T6cF60/SRE6Y2ANM73C5BYbtENO/a7zNOzV/M7mESeu+scCuG9koDKFaKnllX4UD1Am7myVOZwx
 mTeotEIw7E0N+Cqn5F61NJKUfXSsS6ME8PkmIemrokYwE1jzY7CXvyYJSdLjjeivviLvZgiXJTKtC
 H730V8k1AEGs21FM+FNMcAURj5fOGXIOQBpne2+VHXwXEhIyN4Z3odJlpK6WMEHAoRaoBcTCTwk0T
 wrznrU2cJXqjcHzQyGlv5ck28f+/7GSibG9hTnhGX/D8rstpzFsJD+VnzYZjUHGFzugve+SW7Ph9J
 SlLlGZipxtgX0Qaxrp6q3ahmTtJKZ2ysTNBaTi+TAGC60tDMJoeH+jrvsRhCQUgg2t61fwRV0TY3O
 isBQw4GDiwIWopBBMZoLPc0CtLpurzXquPpJLGqiR60Er5aiKlKwCCVsh/BFtieNLd22WCPasRQ6i
 Xngp8DhVAN2fyaoskBIsvvRGRuZXs65fTzinOi0H2iFiQIKlfbHiig1VP1Ac1iE0NLQoJjDHx0psw
 ch8+zy0Ie6EJDtAwbmavceRdWCBKPj13vtEgHcOSE=;
Received: from [2a02:8012:c93d:0:260e:bf57:a4e9:8142]
 (helo=cheesecake.fritz.box)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1t3XDD-0008EL-Lg; Wed, 23 Oct 2024 09:59:31 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Wed, 23 Oct 2024 09:58:28 +0100
Message-Id: <20241023085852.1061031-13-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
References: <20241023085852.1061031-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:c93d:0:260e:bf57:a4e9:8142
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 12/36] next-cube: map ESCC registers as a subregion of the
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

Since the ESCC device exists within the memory range of the next.scr memory region, map
the ESCC device registers as a subregion of the next.scr memory region instead of
directly to the system address space.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/next-cube.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index f1a50ec737..7f714640da 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -980,6 +980,7 @@ static const MemoryRegionOps next_floppy_ops = {
 
 static void next_escc_init(DeviceState *pcdev)
 {
+    NeXTPC *next_pc = NEXT_PC(pcdev);
     DeviceState *dev;
     SysBusDevice *s;
 
@@ -997,7 +998,9 @@ static void next_escc_init(DeviceState *pcdev)
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
     sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
-    sysbus_mmio_map(s, 0, 0x2118000);
+
+    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
+                                sysbus_mmio_get_region(s, 0));
 }
 
 static void next_pc_reset(DeviceState *dev)
-- 
2.39.5


