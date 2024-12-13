Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B809E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 19:15:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMB3v-0006OX-Jz; Fri, 13 Dec 2024 14:10:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3W-0005d2-Dg
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:31 -0500
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMB3T-00072O-7D
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 14:10:30 -0500
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-71e2bc5b90fso1010400a34.0
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 11:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734117026; x=1734721826; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z+mms+h6mMl8LvMiwooLKz6H/+GF1JGIljwNgmRuw7A=;
 b=jMAnYe53Pf8ZBN4kx+VQlfqfURiLI9kjQg/+KqHYDzFZs9WNVaNp4eE2rTJLU4z+qF
 h1JWz45jgKGL1o5dx3zLKu/37soEsPcobpyDCeV9pocOnc0I6iff4NITYs00Epy8w6zW
 0Cw2+lgMU3WgDFu5HUppK7NMoBfEi/O8t60+142xBrY0cxeEPoIkeTp5MJZLKSbm8OEC
 r03hV9hKSHV4+Qpjk3fRLv7iD1oZ6HYnOzFOUXGZhlv2PQn3SceEWBkoEtP8EQanDp3r
 EBQXc6zhK/CkwRfZX61/g34gJ3424ha7QvjSZkl5VBAFq1Vti9r88W2e+aFy8lbY/f2+
 yr7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734117026; x=1734721826;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z+mms+h6mMl8LvMiwooLKz6H/+GF1JGIljwNgmRuw7A=;
 b=Ki6EllSW4hsGANyQUW1en1KkQmWrGg+xxmbAnsxcta2HFbhUGQnzEST794MaCwp85I
 0QoBz5Wasll3SuGjYSKK0JJuiuiS5bQ6DJPx7uTfz98+2kYhVA7J3kq1YDGWOVXxUWag
 NaIsdF+eMtk7KDNdUsZGGGioYpb5JBf9j9E1JB08Pdnn/4hPgGJQwp9NVMrxfZg1MwnP
 1dFPILa6rS2wx/zTV99blgTRtUaYQjpk9/PRY0X6zdj16qSBxc4uTBxH3+GujklciuE4
 rsmWoIC4LI7nyS5K9wiZKwzoEwWvxfSLDM4MG4j8+/27j4a/EWfAR2twBLBMahZizjdF
 LYzg==
X-Gm-Message-State: AOJu0YzaBCHAvlaBteJIYQLlqRF/to7wgUPShaAhFoPRv6IVfTIUkXXG
 x4qo0S4OvYPaHagNfqOvT62+VwoBulTSylav7QGgdpWjxOGTFDz/DdSvUljDvqVvc0rtBoK5X95
 NKaey9lVk
X-Gm-Gg: ASbGnctKazGjyqh1TMXZ5FIgIqma5YEaTOA326qyUm2FqDxladaaHEp0qj+Nbm+zkKS
 YzlOH2/mMxwgmBEMH525qdCsD3FuTeICWFCJVACoPzPUumpRL9TpIq7r89rO6VpYrQUtwGFByF+
 dTdmb+7UU/Yd2BV8+ylnUD4PonX6vbqFmdJ2IDD0/topWnUOiMMzN4Mm0teoxfeaaV13NyhQMdL
 EmGYFlQ7yQldx0T32dtEyJ2XlsMj23w7zIJJ5uNX3UOkKgApju+IqVz82RzNCzP
X-Google-Smtp-Source: AGHT+IH8LQupniG0lBrJVEJq+PlIFhkzxizjlqiAyqdx4iisAll7tItiH7jAkcSRHp0d6760YGUkXg==
X-Received: by 2002:a05:6830:f95:b0:71e:5a:f4e7 with SMTP id
 46e09a7af769-71e3b922adfmr2207514a34.19.1734117026028; 
 Fri, 13 Dec 2024 11:10:26 -0800 (PST)
Received: from stoup.. ([187.217.227.247]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-71e4834da91sm29697a34.18.2024.12.13.11.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Dec 2024 11:10:25 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>,
	qemu-block@nongnu.org (open list:IDE)
Subject: [PATCH 30/71] hw/ide: Constify all Property
Date: Fri, 13 Dec 2024 13:07:04 -0600
Message-ID: <20241213190750.2513964-35-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241213190750.2513964-1-richard.henderson@linaro.org>
References: <20241213190750.2513964-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32c.google.com
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ide/ahci.c    | 2 +-
 hw/ide/cf.c      | 2 +-
 hw/ide/cmd646.c  | 2 +-
 hw/ide/ide-dev.c | 6 +++---
 hw/ide/isa.c     | 2 +-
 hw/ide/macio.c   | 2 +-
 hw/ide/mmio.c    | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 0eb24304ee..8ee015c1a4 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1867,7 +1867,7 @@ static void sysbus_ahci_realize(DeviceState *dev, Error **errp)
     ahci_realize(&s->ahci, dev, &address_space_memory);
 }
 
-static Property sysbus_ahci_properties[] = {
+static const Property sysbus_ahci_properties[] = {
     DEFINE_PROP_UINT32("num-ports", SysbusAHCIState, ahci.ports, 1),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ide/cf.c b/hw/ide/cf.c
index 2a425cb0f2..190914f513 100644
--- a/hw/ide/cf.c
+++ b/hw/ide/cf.c
@@ -24,7 +24,7 @@ static void ide_cf_realize(IDEDevice *dev, Error **errp)
     ide_dev_initfn(dev, IDE_CFATA, errp);
 }
 
-static Property ide_cf_properties[] = {
+static const Property ide_cf_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 6b02fc81ec..942f6c470c 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -313,7 +313,7 @@ static void pci_cmd646_ide_exitfn(PCIDevice *dev)
     }
 }
 
-static Property cmd646_ide_properties[] = {
+static const Property cmd646_ide_properties[] = {
     DEFINE_PROP_UINT32("secondary", PCIIDEState, secondary, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index 03f7967798..cc92531f1c 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -29,7 +29,7 @@
 #include "qapi/visitor.h"
 #include "ide-internal.h"
 
-static Property ide_props[] = {
+static const Property ide_props[] = {
     DEFINE_PROP_UINT32("unit", IDEDevice, unit, -1),
     DEFINE_PROP_BOOL("win2k-install-hack", IDEDevice, win2k_install_hack, false),
     DEFINE_PROP_END_OF_LIST(),
@@ -191,7 +191,7 @@ static void ide_cd_realize(IDEDevice *dev, Error **errp)
     ide_dev_initfn(dev, IDE_CD, errp);
 }
 
-static Property ide_hd_properties[] = {
+static const Property ide_hd_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
     DEFINE_BLOCK_CHS_PROPERTIES(IDEDrive, dev.conf),
     DEFINE_PROP_BIOS_CHS_TRANS("bios-chs-trans",
@@ -218,7 +218,7 @@ static const TypeInfo ide_hd_info = {
     .class_init    = ide_hd_class_init,
 };
 
-static Property ide_cd_properties[] = {
+static const Property ide_cd_properties[] = {
     DEFINE_IDE_DEV_PROPERTIES(),
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index 211ebc9ba7..a0a7e4837c 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -101,7 +101,7 @@ ISADevice *isa_ide_init(ISABus *bus, int iobase, int iobase2, int irqnum,
     return isadev;
 }
 
-static Property isa_ide_properties[] = {
+static const Property isa_ide_properties[] = {
     DEFINE_PROP_UINT32("iobase",  ISAIDEState, iobase,  0x1f0),
     DEFINE_PROP_UINT32("iobase2", ISAIDEState, iobase2, 0x3f6),
     DEFINE_PROP_UINT32("irq",     ISAIDEState, irqnum,  14),
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 99477a3d13..25f8403e80 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -459,7 +459,7 @@ static void macio_ide_initfn(Object *obj)
                              qdev_prop_allow_set_link_before_realize, 0);
 }
 
-static Property macio_ide_properties[] = {
+static const Property macio_ide_properties[] = {
     DEFINE_PROP_UINT32("channel", MACIOIDEState, channel, 0),
     DEFINE_PROP_UINT32("addr", MACIOIDEState, addr, -1),
     DEFINE_PROP_END_OF_LIST(),
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index 53d22fb37f..43ab66f347 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -141,7 +141,7 @@ static void mmio_ide_initfn(Object *obj)
     sysbus_init_irq(d, &s->irq);
 }
 
-static Property mmio_ide_properties[] = {
+static const Property mmio_ide_properties[] = {
     DEFINE_PROP_UINT32("shift", MMIOIDEState, shift, 0),
     DEFINE_PROP_END_OF_LIST()
 };
-- 
2.43.0


