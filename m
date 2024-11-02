Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8161FE677F5
	for <qemu-devel@archiver.kernel.org>; Sat,  2 Nov 2024 13:19:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7E0l-00036a-VO; Sat, 02 Nov 2024 09:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0Y-00032W-PG; Sat, 02 Nov 2024 09:17:39 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1t7E0W-0001w8-Ka; Sat, 02 Nov 2024 09:17:37 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a9e44654ae3so335513266b.1; 
 Sat, 02 Nov 2024 06:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730553454; x=1731158254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tfVJw2OTp+OS1+DvQbkRZgABrzKigE/SljuSUg2aBz4=;
 b=SgPeZdzvlPmTQoGIKuGTazf0O4cw5UxEYzdQVfRlYFkKTkpHjAfr4uxzBLSNyjjqdC
 lnRHqk2pfV9iJGF1XKda0/gDyJ3CK7Q16egcTbP3LzT9lo0++ZVb+Liz1yUx7i0HuAaM
 vIzPXeisxDTGMGF2IGcZq/j0EDNJU19xYUd/Z1YYG7S3Gxeq6C2UT65OLtDJRG2A85a0
 KaKHIXsw6GGkc2OtFA9kYdtAvczvAGq+l/yPkCLPJ8xOUjhnmNd58gF8AVrMvzIlXkwR
 D1knR45+Z2TcxRDsQZNTwyKa22/9SVZOjy/W67+JKB9GMRFL+q9aX53CnSK01+zNjlYC
 8f2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730553454; x=1731158254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tfVJw2OTp+OS1+DvQbkRZgABrzKigE/SljuSUg2aBz4=;
 b=qX1OVoX04YUxdQSWq6trnkqpRQD9eWRCVa/DYy58kIBbnDLo0T51Ic3DhBoXjJ9RYQ
 LUW9CdAuT4urJmEBvqNtCSZMU/ICd29zLUEVuX0504nbMd0gPg3HbMfYNc1t87N6AM/a
 2onEnrF7Kf/057k06ucnJHPngbcOp8v7wH5F6EhKTDFYZIUYE+aadbYidNPWBivuXBSy
 Ta4oQQmp1hYo6BZ2nDiey5nLm8WbF9lXsBpgPL0VSpzxwY+tCtCU7ooSZkPnsJIYTRdO
 01w+NsVEeERSM4GRbwb70m4o2YzhbXHuLSgLfc+gQpXzOq8s3Z9QOztpytAiAODfdhWK
 TcKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgl2ij/q/jsPn8Pgj3ITPzsjKhi8wvVYvXfN17lwJbD3c5a0Q/vN1q78xkmj9F/ZbwFYRWjXhmwpBa@nongnu.org,
 AJvYcCVxuofdi5A2nU4KGLTdtQHd5FmLZ3BkJIhcI1/et4w/Iuyarbgf9wEYma9MPy69tLkIUcAV8PuXuxk=@nongnu.org
X-Gm-Message-State: AOJu0YzlMNUQz6OQ77CEJjweR7wzGrRjhvA6oLBqS4alMYlKZhBkJTAC
 o4xBJWseg81haylAzzitABEeBOaJFcM4+UqexcKb91yx8WDgEax0L91YqQ==
X-Google-Smtp-Source: AGHT+IEY0YtyH2q+SUklW2f073sIE4tcLpdwFgdSDVVDP3MvB/PF+a5hSHmVJc3sfd/xnScpg9HFzw==
X-Received: by 2002:a17:907:7208:b0:a9a:15fb:727a with SMTP id
 a640c23a62f3a-a9e508ac2dcmr1014763466b.13.1730553453917; 
 Sat, 02 Nov 2024 06:17:33 -0700 (PDT)
Received: from archlinux.. (pd9ed7f6d.dip0.t-ipconnect.de. [217.237.127.109])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9e5664350esm307859066b.159.2024.11.02.06.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Nov 2024 06:17:33 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, qemu-block@nongnu.org,
 Bin Meng <bmeng.cn@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org,
 Corey Minyard <cminyard@mvista.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 03/26] hw/ppc/e500: Prefer QOM cast
Date: Sat,  2 Nov 2024 14:16:52 +0100
Message-ID: <20241102131715.548849-4-shentey@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241102131715.548849-1-shentey@gmail.com>
References: <20241102131715.548849-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x633.google.com
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


