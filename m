Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DBF8CF9C5B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPT-0001vH-Kk; Mon, 23 Sep 2024 05:31:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPR-0001lk-1a; Mon, 23 Sep 2024 05:31:09 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPP-0006x3-9k; Mon, 23 Sep 2024 05:31:08 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5c42e7adbe0so4713528a12.2; 
 Mon, 23 Sep 2024 02:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083864; x=1727688664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y0cE0YFArCBzwLd1JwfRPTOm56ohUC4IOprmiVi2Nc4=;
 b=U2WSo1sxiQv21OI3Q6KNyACnRavsyRE0I6hRsb4Uxo8b/xw2gO+1sMi0N/16wwD9y8
 E6EWhClx0apUIV4S2iznNbdzSQVQLG04ZEdADyDdksEt3/Swey7F7I9BUQJfn/Qc+TMY
 6zZecRltV5xqYAFXGdc59oHGmny8TNBRiUkL5drlHJ182jJUEqcqlJbfA+SGuqwB473q
 dBzlUDssSTeD5N2M8Cpp6m2Qfpoi4/r6y3spfZVqeYrYg5Uvl4r2BR/Xs9uUOCnKbmxN
 mqBN3bEzZBtzSKTwl7up+R1gwzrMdH3RvKqOiiaAOJa7k0gpHf9Sc/41hwj0PAhc5uXf
 fwGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083864; x=1727688664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y0cE0YFArCBzwLd1JwfRPTOm56ohUC4IOprmiVi2Nc4=;
 b=FeT9Z3ckgUk01n1UmeoYWL4RfzlvKkXlSSMyvd1M1LcAi92Hc7T/g4QbDWlTgK92IX
 Xl2oLYBEpY6cUMhMDDIoPsJ8MkTXRY2OpXcetBJiBKTFiCFi43SyJXTHXDiP1PgeTRe3
 KiJDAH2Y2XtniESxhYELmbauZjKAC1sqds0Dh72dEKt98NDMW2cHF5iqvbmYLFiHBi/7
 eI1OigK8UVO7lr5vhCw27Y6A1XsekmfckGxmjscQU6aUWi5Cik17iC2ie+hDHRsyyV06
 sa77Hv4kelCYKnNL8bXx30tBJrisGXM+/XQAe4fvyO7xsGMUoUSoiEbHH0K1sdfCYSpp
 tWNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsyTK+8VsLqp7yFUqucg7WG2SGy1FZ9hP0mfASDBkm84EodT4F/lq+gKYNrpVULJ6eeuFvHA0bOnSF@nongnu.org,
 AJvYcCX75EM6pM+VOkGE8l7qQfZBKZMqPw/YmtjAKNKayVXJ3/ZZ+7JssX7eGOr4Frx/AnilnvpErLYGCVs=@nongnu.org
X-Gm-Message-State: AOJu0Yy3a5nIlxpeNoMt3y9OLXiwm8WOGBTFwsS2gLEHEAbN+IqISnsm
 GyYAlpirpOIbFH0HZc1QHQEbyOSx7TSoK+ew0fnj7FuTT6NpEvN5f3k1Vg==
X-Google-Smtp-Source: AGHT+IGHMW9H011FvW9gPouGu3vNVkb9qXZqbDxVmp6W7xZBs3Z9KnuendsEMBoJjyT630FEivBQsw==
X-Received: by 2002:a17:907:25c2:b0:a8a:780f:4faf with SMTP id
 a640c23a62f3a-a90d5925392mr946568966b.47.1727083863792; 
 Mon, 23 Sep 2024 02:31:03 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:03 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 03/23] hw/ppc/e500: Prefer QOM cast
Date: Mon, 23 Sep 2024 11:29:56 +0200
Message-ID: <20240923093016.66437-4-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x529.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index f68779a1ea..32996c188e 100644
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
2.46.1


