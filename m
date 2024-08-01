Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4622CC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:01:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXID-0002vo-Bv; Thu, 01 Aug 2024 11:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXIB-0002oz-94
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:00:35 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXI9-0005BJ-IX
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:00:35 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428e1915e18so5613065e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524431; x=1723129231; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=whLuDOK9toAT29dbP2+0VZN5lCFcvZojP5d7snHmEIM=;
 b=AvnRqI5vhN6SHiOonItss9l9jCYs8Fwkbkr4vkP0CLJz4owrLFK1mOVfMZp+rtNxje
 vbVvdz2Vf6JIzghO1wq5pbZSqZ8tZ2/7HdQ4i5NeQM1kXXsfDAgs6EfDWcTELjDecuhQ
 4c6EpmnWe5G1lv+/IXQMm7SWJGQdXcXimhF8rdhFXWqTY7fvcD2+JFS8RV9K8+hkEDhk
 sGJlc9rD9P2IMndbKdqY+j7TozxR8dXEzxR8JtAAkV4w7tA3Hk81g/O+2Hecd8HUAuXU
 0kg/JQ/FCaoBkIT6Js8El5zlYpZZcEGV9MxdDPBoBYktzwauyteLjrSFL5TetGHaUYIn
 A8LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524431; x=1723129231;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=whLuDOK9toAT29dbP2+0VZN5lCFcvZojP5d7snHmEIM=;
 b=XFBnQ7P0zDPTRwdkBsIcnhT3L3QQ3VPqdw6kixCoJUQZpAf0Sqad0WSl8JHaGeVw3y
 sf8zfz+aYMlKHRiIVhs6hhUdDx16TF8zDMbTiw6Dx1kmtsXbyzI9NPZqRzi6XyJYdNMk
 vvkaDPQOchSnXD7HThFeBEEsj5JX6LCDkZwKLh6yTpQEfaAZ/hHRAQOcTWBNWDhs92eR
 O9AcThCrFgGLzuqASefFakAF3XKt+IX/SNW6Fp7BICub+sGLEYLWZPuXPLUcjXt+e1ni
 SNkP2lomzlkWOj7cahBOYuS+3wvK2Fm/wDCF5ibYYEET/6XJN9jtsbWE/qTqil7Uuwbo
 vrdg==
X-Gm-Message-State: AOJu0YwOFAu+2jB47l9fuZoAj1ONsI+dcCePvZeWioZVtDFekTIc6IDh
 2AoL7RSXkNR466nGd8WwLRoPpjJF5XPejmhTqbRuiEv31VXJIqeDoWdnFQPuKG5vZ/kE0ZHZ9Pb
 pvOY=
X-Google-Smtp-Source: AGHT+IEyZMB96EhTN7JPn4P6Dtx42cn1y/+EBRVNCUUPEnteTJuvgKTzXb5Ub6CL5LbaLPjRYOu3Fg==
X-Received: by 2002:a05:600c:4684:b0:426:618f:1a31 with SMTP id
 5b1f17b1804b1-428e6b96485mr956025e9.34.1722524431280; 
 Thu, 01 Aug 2024 08:00:31 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282bb6405csm61714935e9.34.2024.08.01.08.00.29
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 08:00:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-9.1 v3 1/2] hw/pci-host/gt64120: Reset config registers
 during RESET phase
Date: Thu,  1 Aug 2024 17:00:20 +0200
Message-ID: <20240801150021.52977-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801150021.52977-1-philmd@linaro.org>
References: <20240801150021.52977-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

Reset config values in the device RESET phase, not only once
when the device is realized, because otherwise the device can
use unknown values at reset.

Mention the datasheet referenced. Remove the "Malta assumptions
ahead" comment since the reset values from the datasheet are used.

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index e02efc9e2e..b68d647753 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1,6 +1,8 @@
 /*
  * QEMU GT64120 PCI host
  *
+ * (Datasheet GT-64120 Rev 1.4 from Sep 14, 1999)
+ *
  * Copyright (c) 2006,2007 Aurelien Jarno
  *
  * Permission is hereby granted, free of charge, to any person obtaining a copy
@@ -1211,19 +1213,24 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
     empty_slot_init("GT64120", 0, 0x20000000);
 }
 
-static void gt64120_pci_realize(PCIDevice *d, Error **errp)
+static void gt64120_pci_reset_hold(Object *obj, ResetType type)
 {
-    /* FIXME: Malta specific hw assumptions ahead */
+    PCIDevice *d = PCI_DEVICE(obj);
+
+    /* Values from chapter 17.16 "PCI Configuration" */
+
     pci_set_word(d->config + PCI_COMMAND, 0);
     pci_set_word(d->config + PCI_STATUS,
                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
     pci_config_set_prog_interface(d->config, 0);
+
     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_2, 0x1c000000);
     pci_set_long(d->config + PCI_BASE_ADDRESS_3, 0x1f000000);
     pci_set_long(d->config + PCI_BASE_ADDRESS_4, 0x14000000);
     pci_set_long(d->config + PCI_BASE_ADDRESS_5, 0x14000001);
+
     pci_set_byte(d->config + 0x3d, 0x01);
 }
 
@@ -1231,8 +1238,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    k->realize = gt64120_pci_realize;
+    rc->phases.hold = gt64120_pci_reset_hold;
     k->vendor_id = PCI_VENDOR_ID_MARVELL;
     k->device_id = PCI_DEVICE_ID_MARVELL_GT6412X;
     k->revision = 0x10;
-- 
2.45.2


