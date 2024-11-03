Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1A5BE6F09F
	for <qemu-devel@archiver.kernel.org>; Sun,  3 Nov 2024 13:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7ako-0006Af-QP; Sun, 03 Nov 2024 08:34:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akj-00067c-QG; Sun, 03 Nov 2024 08:34:50 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7akh-0001DI-7B; Sun, 03 Nov 2024 08:34:49 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a99ebb390a5so807653966b.1; 
 Sun, 03 Nov 2024 05:34:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730640885; x=1731245685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfVJw2OTp+OS1+DvQbkRZgABrzKigE/SljuSUg2aBz4=;
 b=JNdxFE6FS1oI7/GgVhiZg8wg9cJ9pfMt6eTc8uSAMUeh87sNpIg1FsMSrzCF1MYwyi
 AiBqmLfiaG8lcdG0lLDmEiUsGZ64bDj0EYSgDo/TUVvNTYfjJ8a+ThW5hr+C45QNKNE+
 rb/MSBYyYYPWe8rcOkjrrdBbNH0fWMjT3ngmbYyUYO3Lw8RW/akbjbxHOVqVfuvhEGxP
 ORBXUhsVXKsAuMuqaosVfpTL0TjSkGfSPnePYhfBAEE2eTkcX5skW9yozailxJC0tIVv
 cmudQl4krq1ceF9A92TPppjy9VcR8F1Lt46kaprHr25lVpXuMlP+QGBbDXdLfzBT4b8S
 +VCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730640885; x=1731245685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfVJw2OTp+OS1+DvQbkRZgABrzKigE/SljuSUg2aBz4=;
 b=m4FGCAUIQU9YIAIXtmLoc2K3nC0h062TBTF/kHN1AW5ml7mkpAKdpttXaXUtaWb504
 /8DKePhBNFrBOS5ZMKlduwnwdmM0ywca7hXD6Sb3zMbQtHdk58036vskA1G6axpkXaQY
 pEZf8SZ+taJcVkC8t2igK9WlYtepzUE+tnV01ZQ57ykq9U4wqNX7bUeMQpMB0LLILrds
 cFiMK7qg3iPvYrWjmSgIOuCBZ67WxV7VTvcZ/RUOslFUiFR2ltMxM9twLr0ZBVnbDMv/
 S3hfPRrvHEtaXaZ4SP1CTXC0PiT8kiLixnm3AFLKcRcQbOhITyvlOEBqn9UoaGc3tE7a
 u98Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUy0uG/2sISGAPnoZmYrE9vSbWcFidR6/pxZ7kjICdwLIcGxgNilZyvCv2m2m7YTuKX0kYR7S+9x2VP@nongnu.org,
 AJvYcCV/xhHX2Tj4CXh7gIj6vAw+ZjLrdGMRWPOu7q+qJs2ZC5SYfUgIFJBX1sGKZVz4/kBpOrcBP34Pufk=@nongnu.org
X-Gm-Message-State: AOJu0Yx4EvA+Nbq3+AoBUFueQo+EdJNTuo1PB2DZ0PmEbtW5HgLIn6QO
 YjZ2KmX9PAck53YNhCvxC0m4JEMokt1pGE1mZSggho/5b9S3AHsuHnaLHg==
X-Google-Smtp-Source: AGHT+IFvTXV0EwHb4m6teKcmqQtNjmvUTA5vih6cGGIDbVNCE6KjCTB5izxfXaLpqP8Q9feG66VAGw==
X-Received: by 2002:a17:907:3f87:b0:a9a:cea7:1294 with SMTP id
 a640c23a62f3a-a9e65436316mr813080866b.21.1730640884521; 
 Sun, 03 Nov 2024 05:34:44 -0800 (PST)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm424328866b.159.2024.11.03.05.34.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Nov 2024 05:34:44 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, Corey Minyard <cminyard@mvista.com>,
 Kevin Wolf <kwolf@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, qemu-block@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v4 03/26] hw/ppc/e500: Prefer QOM cast
Date: Sun,  3 Nov 2024 14:33:49 +0100
Message-ID: <20241103133412.73536-4-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103133412.73536-1-shentey@gmail.com>
References: <20241103133412.73536-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 0683629ac0..964a22c5b7 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1008,7 +1008,7 @@ void ppce500_init(MachineState *machine)
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ));
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
-    i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
+    i2c = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
     i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
 
     /* eSDHC */
@@ -1057,7 +1057,7 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(ccsr_addr_space, MPC8544_PCI_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
 
-    pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
+    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
     if (!pci_bus)
         printf("couldn't create PCI controller!\n");
 
-- 
2.47.0


