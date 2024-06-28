Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C636EC2BBCA
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2024 10:55:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN9Fm-00072E-Aa; Fri, 28 Jun 2024 06:54:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN9Fh-00071x-Fy; Fri, 28 Jun 2024 06:54:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN9Ff-0005uG-Vl; Fri, 28 Jun 2024 06:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References;
 bh=kVXhtFyhJrNRrD4tql75VP5OGfFfqIT0QqfJX3olO6I=; b=zqo6jeA4nllblFdzhi9JOB1c9t
 Imeb2fBYMEbKq5VKL6YbhamB4Wr3DuZXO5Rn9SI4wylWZ6KM8Cku28k4rOVDBHPz6VGUOtfy3w8gE
 syYwq2wUtox0y08MUvpCvrq9ODsDMY+b7c70oSQHYoq0viTciX8Xkd5uSnm8TXDsVW20ffUlHXr+u
 BlaHSoo2zEsxv5hrQdGWEK/MCVRhpwCwLdHBCuUbnuU2AEIYJNfGY1KHXZ8Mu2Wd8XVANezytM501
 La4dIaYH1lRxCUHGuYkMoDVKIxoL5votCLmc9bH/7km6Pc4ss8vT/Ki56Z+E1NSKX6zJYIsDaNHSW
 fDa9YP3Ittn/1gMZAXyzE8W7HDYTarn79MTEY5Tch84zlJQ1urlX33mv6+4DMzgxebZpHP3DbO1ZZ
 Pb28Bx41AJT2DE5axTf3oUzUcAzCq4EEpfSSAj44W/5b0alHUdWL8fy+fjNQCPlE25XF6JSwV3mCs
 avRSDymPopZTfbtERBngoZZ8p7+6NfdsCyaOnrtaG5YwBy1FCFl6lnV6XafJK3/rU8U6aruRWfV5Y
 4pNbvaYqQjzZoY7gvmfss5BTbxk0IOKT8F50DmvgghpIleA59d8wtWymj3hIw09Cq6c1Py5xNEcd9
 MzjNUZUvO/nYrOTW9LMMBDT0cSJRgK0c4DIOEjYc4=;
Received: from [2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf]
 (helo=localhost.localdomain)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1sN9EE-000ARC-9L; Fri, 28 Jun 2024 11:53:22 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 akihiko.odaki@daynix.com
Date: Fri, 28 Jun 2024 11:54:37 +0100
Message-Id: <20240628105437.635079-1-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bb4:4000:71e:fc91:de8e:dcdf
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH] hw/ide/macio.c: switch from using qemu_allocate_irq() to qdev
 input GPIOs
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

This prevents the IRQs from being leaked when the macio IDE device is used.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/macio.c                | 10 ++++++----
 include/hw/misc/macio/macio.h |  5 +++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index aca90d04f0..e84bf2c9f6 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -420,7 +420,8 @@ static void macio_ide_realizefn(DeviceState *dev, Error **errp)
 {
     MACIOIDEState *s = MACIO_IDE(dev);
 
-    ide_bus_init_output_irq(&s->bus, s->ide_irq);
+    ide_bus_init_output_irq(&s->bus,
+                            qdev_get_gpio_in(dev, MACIO_IDE_PMAC_IDE_IRQ));
 
     /* Register DMA callbacks */
     s->dma.ops = &dbdma_ops;
@@ -456,8 +457,8 @@ static void macio_ide_initfn(Object *obj)
     sysbus_init_mmio(d, &s->mem);
     sysbus_init_irq(d, &s->real_ide_irq);
     sysbus_init_irq(d, &s->real_dma_irq);
-    s->dma_irq = qemu_allocate_irq(pmac_ide_irq, s, 0);
-    s->ide_irq = qemu_allocate_irq(pmac_ide_irq, s, 1);
+
+    qdev_init_gpio_in(DEVICE(obj), pmac_ide_irq, MACIO_IDE_PMAC_NIRQS);
 
     object_property_add_link(obj, "dbdma", TYPE_MAC_DBDMA,
                              (Object **) &s->dbdma,
@@ -508,7 +509,8 @@ void macio_ide_init_drives(MACIOIDEState *s, DriveInfo **hd_table)
 
 void macio_ide_register_dma(MACIOIDEState *s)
 {
-    DBDMA_register_channel(s->dbdma, s->channel, s->dma_irq,
+    DBDMA_register_channel(s->dbdma, s->channel,
+                           qdev_get_gpio_in(DEVICE(s), MACIO_IDE_PMAC_DMA_IRQ),
                            pmac_ide_transfer, pmac_ide_flush, s);
 }
 
diff --git a/include/hw/misc/macio/macio.h b/include/hw/misc/macio/macio.h
index 2b54da6b31..869b66055b 100644
--- a/include/hw/misc/macio/macio.h
+++ b/include/hw/misc/macio/macio.h
@@ -92,6 +92,11 @@ struct MACIOIDEState {
     uint32_t irq_reg;
 };
 
+#define MACIO_IDE_PMAC_NIRQS 2
+
+#define MACIO_IDE_PMAC_DMA_IRQ 0
+#define MACIO_IDE_PMAC_IDE_IRQ 1
+
 void macio_ide_init_drives(MACIOIDEState *ide, DriveInfo **hd_table);
 void macio_ide_register_dma(MACIOIDEState *ide);
 
-- 
2.39.2


