Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A610C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 14:57:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXET-0004gQ-3Z; Thu, 01 Aug 2024 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXER-0004fF-Th
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:56:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZXEQ-0004Ue-8A
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 10:56:43 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-428e1915e7fso6118385e9.1
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 07:56:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722524200; x=1723129000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOavi68dVWhtO7uLbJ3C8KU4nLZTxGicWmAVgpdjLVU=;
 b=B+Mgegd7F6dabjoiNmuO6K3ZEm9TrgB5160zO8j3RaUygv30RBH0WhGt3OiZCJGNMU
 weXWFJ4NonWoQQKzp7Q6yYAq6yR2Ifo7wpxKlnPJeTU9Z8WJ3Z9+RF4V91JtjibpWmiq
 P+zTIkx9cnMUIOlwqIBmjsJ3VEvZqvSvsfS7xftd4+i+C+Udomr/RLKa5fUJk70NFHiY
 hDP9dFeM6wYELSrNm03HeR0MeNHfCxQSgLd7XHCdt8xAqOjkE1xsiv1LjObCMYcs323J
 /OOUqDXr7y8gCnM78K/RiS3WXOf/Ao0lqYfCyhji2Q7fSBIp0een/mlF2JXm+p13dvh9
 3d5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722524200; x=1723129000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZOavi68dVWhtO7uLbJ3C8KU4nLZTxGicWmAVgpdjLVU=;
 b=HykL4vTEgcO28ylE46F0O9xMqtr8kSvHyGPoifiNJ9nRtIjjHIE6G0667YO7gEQiml
 6C+fzo88PKrfpeb0eFld3Mgu/aqlaCIOxef5Zj4pEgeAkUMFA6b7en0hABFTG5m/k78P
 zYzeynVP1Hq+iRuT/Ht2JQcIPJ25M0aBuIZHJqWCJvMXYHUGoz/6BEYz5ZjCJM9rS1ge
 A1Uihp2Ooj00RArCBkjaK4J9veLymQ530gn3cTPT9eFA1QDNMa5m+k9LmTUGJYh+didt
 RO7SDlzQyacNXrGwu3BEGnvejxcjPS6FCzOn74OnC7hx0FFAwwZAYSmFH+eh6U2UBqha
 zc/w==
X-Gm-Message-State: AOJu0Ywwy7IWVFJAfDI3xnxuN2Xv8tXgYthFu4jLa4w+nQCfi7pUzYLp
 BTgCL7Kl0qwaQxfkcGz/QE/25waLX9CHIwzJs9FboUPvBqgmzavVSxKX4nnG6VB6U5cQAjUNe5+
 TufE=
X-Google-Smtp-Source: AGHT+IHn/PB7MIqeB60EPTdGTA6Cm2c6Cs1OxWm3/U8vyRAmYnmdYequbl4q/z+CRMROo/mI4bZBxA==
X-Received: by 2002:a05:600c:a0b:b0:426:549b:dd7a with SMTP id
 5b1f17b1804b1-428e6b93992mr675665e9.36.1722524200291; 
 Thu, 01 Aug 2024 07:56:40 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.130.148])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4282b89aa4bsm61006475e9.7.2024.08.01.07.56.38
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 01 Aug 2024 07:56:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-9.1 v2 1/2] hw/pci-host/gt64120: Reset config registers
 during RESET phase
Date: Thu,  1 Aug 2024 16:56:29 +0200
Message-ID: <20240801145630.52680-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801145630.52680-1-philmd@linaro.org>
References: <20240801145630.52680-1-philmd@linaro.org>
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


