Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F339D3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SM7-0006fh-OH; Tue, 05 Nov 2024 17:49:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLk-0006FE-U3
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:42 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SLi-0004Fn-Op
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:48:36 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4314b316495so51656505e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:48:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846913; x=1731451713; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sb6wknvdalZooi5r58QzzfllNGZIAFmsE3UyhIspyAY=;
 b=lccgXJr+bAUMUOtlCs8wd0f+WfabSLSgn34vke0dT85At+PgfRnSaWvJEVTakQnrDG
 b0UDdPbvGbaaXTMIxJ9eTzPR2EHSly4V0elihCcqy8LMQPj52NHI3I4utsFyMcrWiF/J
 nZ0IZaSZvTLzEcvBPudbb78F2TpSZA/Ib9exkHi6nNQT8B0GeObmoMSCEc/lX5Ys/t6Q
 eNf1Fjb885HLuDMFjw1QGFLul1t++Z96dfC1ycX9DJdmOJoV5JANR/pfq6oD62P+2Xxc
 WkmaBfm1pym6/+WifDpp0O1x3tyI7SDBJ9T3/ujIqGn2H38n+BG3yTuFTp7wisRQveh4
 hCSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846913; x=1731451713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sb6wknvdalZooi5r58QzzfllNGZIAFmsE3UyhIspyAY=;
 b=e7Z1eob5GufxGb6Gs/MZO9cNOt4GwFXlpq0ohiWUOkA5ciTkuR+7yB6PPWT5W18swY
 slyJ7VvdzdK8CL7utCqdAJ8xG/G6AEQPCC8QxG35TfIUxSNSf2tehUWCOY0IrCYesev/
 ghScWt+I1XJRRh2Q7MqCoaOoUGGQWQ/jIaJ+laaPgRPNr4IIJO2r+gA89ROmlAlHofD6
 AwXMlKcXhdQlJBaO8WHIVbK0MvbMjoIBgCPlGA+oHzsZgsoWu0J2RVfNlZaX5oJjcENf
 q1nvrIaLI1qKiGgwCYle3yu6U3IcHuxVIW21BJVJCSInuPBdcnga42cE7E2AkzNc0EaU
 JA/A==
X-Gm-Message-State: AOJu0Yz8vJ0dM9IUY8LxrV/fsQrwimSv5wgjrKgbWzpfLNZithZkIH/b
 gOH+Pia190JrxFnHck9HtNoQ9njzqGSN60js32Frn5xXoGmXOtp0iJ9PJ+/awWOOMdZSC3lxVAP
 NzsIHZA==
X-Google-Smtp-Source: AGHT+IEvMtZX1wFUZtLYSd7x3M27zz66vss8w9nfWRUag5nM7qfUErgFs7oBn6pHvco2VhAqV7Czvg==
X-Received: by 2002:a05:600c:3507:b0:431:4e3f:9dee with SMTP id
 5b1f17b1804b1-4327b6f46d3mr180920095e9.4.1730846913090; 
 Tue, 05 Nov 2024 14:48:33 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6ae5dasm1089445e9.4.2024.11.05.14.48.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 12/29] hw/ppc/e500: Prefer QOM cast
Date: Tue,  5 Nov 2024 22:47:10 +0000
Message-ID: <20241105224727.53059-13-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-4-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ppc/e500.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 6433348072c..060db36dbcb 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -1021,7 +1021,7 @@ void ppce500_init(MachineState *machine)
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ));
     memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
-    i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
+    i2c = I2C_BUS(qdev_get_child_bus(dev, "i2c"));
     i2c_slave_create_simple(i2c, "ds1338", RTC_REGS_OFFSET);
 
     /* eSDHC */
@@ -1070,7 +1070,7 @@ void ppce500_init(MachineState *machine)
     memory_region_add_subregion(ccsr_addr_space, MPC8544_PCI_REGS_OFFSET,
                                 sysbus_mmio_get_region(s, 0));
 
-    pci_bus = (PCIBus *)qdev_get_child_bus(dev, "pci.0");
+    pci_bus = PCI_BUS(qdev_get_child_bus(dev, "pci.0"));
     if (!pci_bus)
         printf("couldn't create PCI controller!\n");
 
-- 
2.45.2


