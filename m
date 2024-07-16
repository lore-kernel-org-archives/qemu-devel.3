Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73148C3DA59
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2024 18:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sTmcj-0006UP-ME; Tue, 16 Jul 2024 14:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmch-0006Jm-5u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:09:59 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sTmcf-0000uA-0l
 for qemu-devel@nongnu.org; Tue, 16 Jul 2024 14:09:58 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-427aeebaecdso16860645e9.1
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2024 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721153395; x=1721758195; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sasciBya2HV1iigybBBfHdwHjguksb3KeHQbVPO+dbY=;
 b=foVM5Fb6P/vCLvrpC461DSE9E+gXEVZirL+ZC8I528nRwtIa0El1fslKMt6qnLlSD0
 3/Zys9tUIokhxJj77PB+QtF7MkScROmhy9W5/1nTu04UGB2dJgmpJPVOinvN6mgptBRE
 Z+I2YcGFekHAnD/eAD09hFEwkdUQIQP6G7/ZNJUnBWBAHfZT4xUSqOeeEwgRpUEHG5CU
 9u14TMgsyEE64ZRNazVU4KGJ7lZg2wedlgUKPp6A4DcYOoG14bMXR5Pfe14fZG8qsGT0
 hrEm3vfRlWtA/swC7g/3lGxbfGH3unFy5xr/SgwdYzRReZNIMEtlM/G+0HFaXfXAWc2S
 5OSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721153395; x=1721758195;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sasciBya2HV1iigybBBfHdwHjguksb3KeHQbVPO+dbY=;
 b=sIZA8yT/IpjLwnKvGZt/qczdhMDamqKgk4N5Jws9ee38XKiZJmcOLBSoQHPl83+q4H
 P5AdfeaR35HrcoYKuiNadtB6eovwo5r0/X0d88CKRZfpdgfjS9mlsOc82uFDx0NEZoJ8
 e1+mKiwlwLWUwZfoTFPSc4sURH8qRohqomxQHjHrfhk3xN54v8nxkxeH69Qv1Iqz6tCh
 Ar/wBTZmYn3iVimPgr2oMC5lxJmNAJOghA3DTnao/GC2VlaPv3jB2PklnuF747Qc6Gqt
 CG8sWRS/mgI3sk2X0jmIDCCHVObBP32W3aPAFacOAHfPdvo8CYwYvSySG1ksCI90DXBT
 Gf2Q==
X-Gm-Message-State: AOJu0YzvxAn6+sHhZ1W4lqdiaFcR7ZLl8NMmNZy0tR4cX4m5KdKBu3aW
 UV3hy71nCYHWjp6R5VngflvBXylZkJgjOTfFKIhKbOwr9PDUSx4nzpEgf7G24dY7v8uVFpiQaiR
 sMDhJfg==
X-Google-Smtp-Source: AGHT+IHeY//i6i+4+LVB7X+fP70swhnOlP7YBFgtHGFe24micFKjeRpqhDhL3Lrije1qB/czoa14QQ==
X-Received: by 2002:a05:6000:2c6:b0:367:9903:a81 with SMTP id
 ffacd0b85a97d-368261df9fcmr2732143f8f.43.1721153395073; 
 Tue, 16 Jul 2024 11:09:55 -0700 (PDT)
Received: from localhost.localdomain ([176.187.209.82])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3680dafbea9sm9777803f8f.82.2024.07.16.11.09.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 16 Jul 2024 11:09:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 02/13] hw/isa/vt82c686: Turn "intr" irq into a named gpio
Date: Tue, 16 Jul 2024 20:09:29 +0200
Message-ID: <20240716180941.40211-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240716180941.40211-1-philmd@linaro.org>
References: <20240716180941.40211-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

Makes the code more comprehensible, matches the datasheet and
the piix4 device model.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20240704205854.18537-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/isa/vt82c686.c   | 2 +-
 hw/mips/fuloong2e.c | 2 +-
 hw/ppc/amigaone.c   | 5 +++--
 hw/ppc/pegasos2.c   | 4 ++--
 4 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 8582ac0322..505b44c4e6 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -719,7 +719,7 @@ static void via_isa_realize(PCIDevice *d, Error **errp)
     ISABus *isa_bus;
     int i;
 
-    qdev_init_gpio_out(dev, &s->cpu_intr, 1);
+    qdev_init_gpio_out_named(dev, &s->cpu_intr, "intr", 1);
     qdev_init_gpio_in_named(dev, via_isa_pirq, "pirq", PCI_NUM_PINS);
     isa_irq = qemu_allocate_irqs(via_isa_request_i8259_irq, s, 1);
     isa_bus = isa_bus_new(dev, pci_address_space(d), pci_address_space_io(d),
diff --git a/hw/mips/fuloong2e.c b/hw/mips/fuloong2e.c
index a45aac368c..6e4303ba47 100644
--- a/hw/mips/fuloong2e.c
+++ b/hw/mips/fuloong2e.c
@@ -299,7 +299,7 @@ static void mips_fuloong2e_init(MachineState *machine)
                               object_resolve_path_component(OBJECT(pci_dev),
                                                             "rtc"),
                               "date");
-    qdev_connect_gpio_out(DEVICE(pci_dev), 0, env->irq[5]);
+    qdev_connect_gpio_out_named(DEVICE(pci_dev), "intr", 0, env->irq[5]);
 
     dev = DEVICE(object_resolve_path_component(OBJECT(pci_dev), "ide"));
     pci_ide_create_devs(PCI_DEVICE(dev));
diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
index ddfa09457a..900f93c15e 100644
--- a/hw/ppc/amigaone.c
+++ b/hw/ppc/amigaone.c
@@ -153,8 +153,9 @@ static void amigaone_init(MachineState *machine)
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out(DEVICE(via), 0,
-                          qdev_get_gpio_in(DEVICE(cpu), PPC6xx_INPUT_INT));
+    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
+                                qdev_get_gpio_in(DEVICE(cpu),
+                                PPC6xx_INPUT_INT));
     for (i = 0; i < PCI_NUM_PINS; i++) {
         qdev_connect_gpio_out(dev, i, qdev_get_gpio_in_named(DEVICE(via),
                                                              "pirq", i));
diff --git a/hw/ppc/pegasos2.c b/hw/ppc/pegasos2.c
index c1bd8dfa21..9b0a6b70ab 100644
--- a/hw/ppc/pegasos2.c
+++ b/hw/ppc/pegasos2.c
@@ -195,8 +195,8 @@ static void pegasos2_init(MachineState *machine)
     object_property_add_alias(OBJECT(machine), "rtc-time",
                               object_resolve_path_component(via, "rtc"),
                               "date");
-    qdev_connect_gpio_out(DEVICE(via), 0,
-                          qdev_get_gpio_in_named(pm->mv, "gpp", 31));
+    qdev_connect_gpio_out_named(DEVICE(via), "intr", 0,
+                                qdev_get_gpio_in_named(pm->mv, "gpp", 31));
 
     dev = PCI_DEVICE(object_resolve_path_component(via, "ide"));
     pci_ide_create_devs(dev);
-- 
2.41.0


