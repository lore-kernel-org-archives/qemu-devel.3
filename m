Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78DBBE77183
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Dec 2024 19:13:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMtwn-0001eb-6O; Sun, 15 Dec 2024 14:06:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwd-0001Pi-Ka
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:28 -0500
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tMtwa-0001CU-Dn
 for qemu-devel@nongnu.org; Sun, 15 Dec 2024 14:06:23 -0500
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-3eba7784112so1171245b6e.2
 for <qemu-devel@nongnu.org>; Sun, 15 Dec 2024 11:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734289579; x=1734894379; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U53muPL2bLLdVoKOwxM9M3Aqazdis5rVRboOucVaBPk=;
 b=pO3HyqEM+ENdMvVcISzSpx4NJU1xqaeQvbhcUAH5ZNgaFTdsHXc8buK9VcVsF/p1b2
 vOetcHOILxS4Jx0QD+LK+xhKEocpBQ5rUCl6gJ+DrDs5t7NoW4B+xRvy1l5ne0nsF1dI
 CHkPTJ3fKG8ubO96bvAWye+vAssqNgtB3leb58nu2mQBW6BPHcsPZP9gjAgGaoKDwPVW
 7/q14xgKR7fe4/KNTg0u0x8CAF4a0OVzPFnE0wsli6MsiNLgJ7bgCLCkwZYvtjCzCXOQ
 1G9EgywNmr45KliWr8TBO3mr/PgKomYDcWD9+RiPBbxzMvaGXk6cp1uzj9kA0DXIy/Bo
 B2Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734289579; x=1734894379;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U53muPL2bLLdVoKOwxM9M3Aqazdis5rVRboOucVaBPk=;
 b=qILTJViycN2bc6jsQO9HHQpuq6aTTRBJIQwIHtf6XHGIHPOV0XZxYin3LBVHjbaFs3
 hRgm5PZ4DRYyhpwH15XSurSNQINqjotr446hVGG0veR69tLqXzb3fZCwdUG+ezCgIMXT
 uDA6Rmp9BupTJB/lcT1uOX6dCOirOHYY1aeJTu0m8Bxad4C2yp9AW77SeF1q3Z13LU3v
 waRHGQ4kC6lvO+fi3TtWi2omxlcaRJdOe7pBj96v91lPiI7A5SDYDSSNv0QU1o16gwVh
 kqaB9lwQjnKPfoRkwCjQlQZa0kO6alErS0A1D575TyS5OXRslGybErWYn5uVUsTOF4D5
 pj+A==
X-Gm-Message-State: AOJu0YyaYn8x6T25a7x5133yusy5TtZsFAocLMDIkHxazQldmosOj9FE
 XJKOCIfNhdsiYxzBdp7moJe1C7xBo8zqqfRWL3gtZwkjhr3PfXxOBK3qIcWOxGSUrqoSQibbd4i
 PVMmH0xmx
X-Gm-Gg: ASbGncuIRBusmRLnEHaAR6aroQtMyTRxRwtrwLofDRzMytoNFbfMYUKhQSucBFZIT2e
 EcMmFoQviQMevvqZPYZYwQEA1f6Mi0D9z6+q0eurIWooM+nRppxo5p731NL/lp0IFAuOQZ+WNRr
 DRjozPc+/UKt6XN/1VyGSkjsNBgXhMPiTP7Jw+NsK+Wxa3cHKg5nEj3nKBYK+7Lue0asL8Xcs+m
 iRirf3dM6HYmFrpz4CJlP9LVQkSns+ms3UcJqUNWsyLwLEAj1LdpQuZPtuggSHb6Za/RUgfUo3K
 h2DoY+EqwhwenUtbGqB9yaAyZrMgEisKg8RsV7d29ag=
X-Google-Smtp-Source: AGHT+IGBFYhBH09OjShaFJCpxuiq35SNwAz3WadjuUmJoYQwQM3Y7M8YU3/FnRtY+JaQleJMf9a56w==
X-Received: by 2002:a05:6870:e247:b0:27b:61df:2160 with SMTP id
 586e51a60fabf-2a3ac8a887amr4906891fac.31.1734289579061; 
 Sun, 15 Dec 2024 11:06:19 -0800 (PST)
Received: from localhost.localdomain (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2a3d2914ac6sm1423214fac.39.2024.12.15.11.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Dec 2024 11:06:18 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 29/67] hw/ide: Constify all Property
Date: Sun, 15 Dec 2024 13:04:55 -0600
Message-ID: <20241215190533.3222854-30-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241215190533.3222854-1-richard.henderson@linaro.org>
References: <20241215190533.3222854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x230.google.com
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

Reviewed-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/ide/cf.c      | 2 +-
 hw/ide/cmd646.c  | 2 +-
 hw/ide/ide-dev.c | 6 +++---
 hw/ide/isa.c     | 2 +-
 hw/ide/macio.c   | 2 +-
 hw/ide/mmio.c    | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)

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


