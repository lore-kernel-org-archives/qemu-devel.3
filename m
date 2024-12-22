Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F00CE77188
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Dec 2024 13:02:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tPLaZ-0005oM-VN; Sun, 22 Dec 2024 08:01:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZc-00054o-Kq
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:46 -0500
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLZb-0000dc-1D
 for qemu-devel@nongnu.org; Sun, 22 Dec 2024 08:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
 bh=TBc++wYpm4YjZE7yp6N0zmWXTAemjkJV0HLiNd3ZbAc=; b=cv4OipEVpVkXfYTGUWuT9zZeLY
 Y1RsYAk8gi6+ezMEdW88EuPs2gTUOVx5VjXE1u4o1g45sAKjDhcf1KqS9MG14PLP5XD8SmGZnEZP3
 j5uNteAVKSnfc2HoKeX3X/2awHg189Gy0qwXYSuM7fjpkrT3R7kXfp37R1pCfTSJKGWQX0nNddZBY
 Cp0sHJyRrLWRLk8ntWai7yjq9AZocxmWikdH7fBvZ/zOxvqxLi9ec0ZASK/4iiU1Uch4cW+GPpXVX
 y1/WLpGzSN3qMiieQM5SMmlgLNu3SZsfCUk8Z4CMkps+dXraKD+62wIUdQX5bdNpURh0g4oBoYY3b
 u0lbvBTaqG/3DcG5vT9mkHfkinPeS5pIMkuLjcOyAhlu6omYWSlNQSQz42P4g0cGQZz+AqMByTkfG
 tcCLKch84I0sWV+QqDI5vZgMIOws0eOg50j02NTtpAMuElba7ELK3zidYxBpLCN3pdaUQ65d1F03o
 ELtqIVWVA8BH8PLdKA5cJH2kxf7JFZWvsYTU0reZUXQ5sAhb0QoU7OacR4BjqswlDuQlI6R+vxVki
 mPKP/nyGqHCUCRfMORFnBjv1MqBW6VXU4da/SQmJJrZgMRZ1mHYJwkUcX9tE2pFy2Oqh1dnwqj3z7
 pmmfBZCSc/UKsarefFCihgc29W2XotXGbhjCzhZMU=;
Received: from [2a02:8012:2f01:0:33a9:475d:1cd9:884]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1tPLYx-0002L7-8u; Sun, 22 Dec 2024 13:00:07 +0000
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: huth@tuxfamily.org,
	qemu-devel@nongnu.org
Date: Sun, 22 Dec 2024 12:59:44 +0000
Message-Id: <20241222130012.1013374-6-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
References: <20241222130012.1013374-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a02:8012:2f01:0:33a9:475d:1cd9:884
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 05/33] next-cube: introduce next_pc_init() object init
 function
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

Move initialisation of the memory regions and GPIOs from next_pc_realize() to
the new next_pc_init() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index e023ca757c..75fc9724cd 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -897,20 +897,24 @@ static void next_pc_reset(DeviceState *dev)
 
 static void next_pc_realize(DeviceState *dev, Error **errp)
 {
-    NeXTPC *s = NEXT_PC(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    /* SCSI */
+    next_scsi_init(dev);
+}
+
+static void next_pc_init(Object *obj)
+{
+    NeXTPC *s = NEXT_PC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
+    qdev_init_gpio_in(DEVICE(obj), next_irq, NEXT_NUM_IRQS);
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
                           "next.mmio", 0x9000);
     memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
                           "next.scr", 0x20000);
+
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
-
-    /* SCSI */
-    next_scsi_init(dev);
 }
 
 /*
@@ -971,6 +975,7 @@ static void next_pc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo next_pc_info = {
     .name = TYPE_NEXT_PC,
     .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = next_pc_init,
     .instance_size = sizeof(NeXTPC),
     .class_init = next_pc_class_init,
 };
-- 
2.39.5


