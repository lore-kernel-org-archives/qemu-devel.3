Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C244DCFB42C
	for <qemu-devel@archiver.kernel.org>; Sat,  5 Oct 2024 19:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxAk2-0005Hc-LB; Sat, 05 Oct 2024 15:47:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAk1-0005G3-CT; Sat, 05 Oct 2024 15:47:01 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1sxAjz-0007cy-Uu; Sat, 05 Oct 2024 15:47:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-42cb5b3c57eso30828505e9.2; 
 Sat, 05 Oct 2024 12:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728157617; x=1728762417; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VyriMu6tk8vkCkzFH+eBMAjfV7kMksyL3Wc2FsaHuQg=;
 b=RMmImgulBCrDrwRSPrinbhI+UqDf/z7Dk9KC9BZ2bO3llG4rJ9zXGyDzj2VdzRMJHR
 7AV6eac4izyjLp5Smb2rxYvhjFzi5vmiZgui+k6x3LoBN8wzt7tSeaJFvdI7L3s51XIa
 ttW55wXTmX/jBI9POHUnWISEaK+wztUjNy78n/o7USpZgrwzORsC5BMAEKKTpS0fg/ox
 MWdwS8FjH41xCAYL3tCA2JgkECKT9yBhD0/xSlWa91uDv8l+FqA6AQpzYafhJgGU7900
 QkHzGF2FLocx4L4yMlbt70iwBn4v8TWI4d0DGFWrwHIE8pAWV4WFDThT1vTBd7J+PQdc
 7Kog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728157617; x=1728762417;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VyriMu6tk8vkCkzFH+eBMAjfV7kMksyL3Wc2FsaHuQg=;
 b=KwH17WmA0450lEY5DZ4Dl7BftElw8tm79+guhENuE584CaVv0XcJdmBr1dARwmSnp+
 clUPDu84U2NOdpw2puHY+ow8w4fKgI6ysRWlABg2PV1oiO/ACpMrcaEsYCcyNVZXITVt
 YMrBduZk6yYrjAvRNu+buKm6/uqXVgKG1kfaxxSdCfOLUfXZfMuLbIVLB4ArnaJcF4U3
 FueRjWkx3YInPErBfRJZJagq6zW8O03CY9VrWU86althMGY4EzI92kKTBsr3LKxv7C9e
 sbm1msXKu+lLzcFbK/YXTrCdGZ5KEGAuk52vPOx9BylVbGbjYKB5RUHeclqfH1EaV2Ur
 +Kag==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIeBUmxCELHwfhQf10/empTsZ6Gb1uVAnk54gYKQX/WdwScA6BF3T5Hb83Cmvt03SVSxa9E/vKAik=@nongnu.org,
 AJvYcCVeu3XLysQT3ryRxlj0GWCxJSXSnRNGw4lQcEPJoBNgr20Yjm60s5t6Yby7UE7zwFUqzwPjyX/y/zLp@nongnu.org
X-Gm-Message-State: AOJu0Yz5yHlzVkPLDn/dFbPO51ZWl5aKLvizEHVgISkMs104rwx+DekX
 0G4d7GCNh9d13iMLcSth3Hv4GpEakbGkwbytxPUhkxiqh/sJOR65yYKMGg==
X-Google-Smtp-Source: AGHT+IF11CXS2ICc87/lZ/U1mSLMH66t9V1ov5J3O4CZ+TF4jCUHhF89AOL5N4MPbCw9I38U3L4d4Q==
X-Received: by 2002:a05:600c:49a5:b0:42c:bf79:78f7 with SMTP id
 5b1f17b1804b1-42f89f7b8a4mr22210755e9.32.1728157617245; 
 Sat, 05 Oct 2024 12:46:57 -0700 (PDT)
Received: from archlinux.. (pd95ed790.dip0.t-ipconnect.de. [217.94.215.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42f86a0afc1sm47506775e9.1.2024.10.05.12.46.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 05 Oct 2024 12:46:56 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 Corey Minyard <cminyard@mvista.com>, Bernhard Beschow <shentey@gmail.com>,
 qemu-ppc@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v2 03/23] hw/ppc/e500: Prefer QOM cast
Date: Sat,  5 Oct 2024 21:45:43 +0200
Message-ID: <20241005194603.23139-4-shentey@gmail.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241005194603.23139-1-shentey@gmail.com>
References: <20241005194603.23139-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32d.google.com
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
2.46.2


