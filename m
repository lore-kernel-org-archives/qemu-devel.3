Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D6E6C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 17:11:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvna-0003wF-JI; Fri, 02 Aug 2024 13:10:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvnY-0003vd-8F
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:10:36 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvnW-0001At-KB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 13:10:36 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7aa212c1c9so1070553866b.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 10:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722618632; x=1723223432; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CdBu2LzaQdEToYHGVd55qkz3ztTrZyNL6N7Zqjyb94o=;
 b=yvUgHFZWlS/cAg9gEECKe+yDcp8FFHjOWJlkNXlQlQImQ2qLVXIW9hVK9giDMR4NKC
 Uj1OxHSVZTDug70Ig8neoIkjAVOxF5kVG2ih2ZV0VaQId8RxQwNO07E66fWzhxvjPQAN
 uloe7lHOFvhengHIgLcGgnt87UQsvouUvamOszKOIWgNcRMwYRK82PhZwL2w/q/a0leN
 bDnlSDt3i7XtVso8rpl2twrw92lEvgHlmu5M9oYXRKaHzYkByQsoqXOlNrBgX7zdQHAx
 7KwqsnOwMcuyrZmKR5F9hu7DnbHga4lJWF1QO7SQrQiamM22xjzc6PkXf+efYIo7pqef
 jJ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722618632; x=1723223432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CdBu2LzaQdEToYHGVd55qkz3ztTrZyNL6N7Zqjyb94o=;
 b=JwlVz4zBxYSEcmNtzuFkDL3h9N3GCyNhJ5eXnYrPBFA/w0ZgKfmBS6RrPfnmU51wh4
 QDmVA8HtM6fzWbX3MmMHgYesrcLKEUn5hl3QR9yXZyZulf4PzLc/7AJoXWwyLZp4c/XE
 QhZm4Ost26bJxFiqdOSciJ1C0iCIHwkcSLmimo3utLbtD0iBrVK09M6uEPTEwssoQ3mZ
 jFAPRmdd8abt8Sb00lBzUgC1SnYRBbRfeUbllEN9bQ/NO34tB/9KsGSSx+dVSaDA6Pbf
 hJIjwp4nOX/Eqrsphlzk9ZMHn6rW7QXY1BjAT90vf6XiygsBn8UZ6VdpfEBRfKO5kVjQ
 sRYw==
X-Gm-Message-State: AOJu0Yz2TD5CF2DkuoRViaB28KYupxtJTaInA1w3vtlK2ZRU79u+cyqP
 LUv38S71julR8t6TPja+utcXnLsmqd8Ob4eCCx2LXlSyOFel+frkavw/zoxrrgoIeBvlBenYAOL
 F
X-Google-Smtp-Source: AGHT+IEMy7kmB516HpjVV0qwBBxb+YWqG4lx4Wmt1+CKjV7u6/eQptq+gQkZJ8kYcUmfcCYfXMN4mg==
X-Received: by 2002:a17:907:1c16:b0:a7a:a06b:eec9 with SMTP id
 a640c23a62f3a-a7dc4db9ef1mr269993066b.4.1722618632082; 
 Fri, 02 Aug 2024 10:10:32 -0700 (PDT)
Received: from m1x-phil.lan (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec8cd5sm118868966b.213.2024.08.02.10.10.30
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Aug 2024 10:10:31 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-9.1 v4 1/2] hw/pci-host/gt64120: Set PCI base address
 register write mask
Date: Fri,  2 Aug 2024 19:10:22 +0200
Message-ID: <20240802171023.85719-2-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802171023.85719-1-philmd@linaro.org>
References: <20240802171023.85719-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
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

When booting Linux we see:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
  pci 0000:00:00.0: [Firmware Bug]: reg 0x14: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x18: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x1c: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x20: invalid BAR (can't size)
  pci 0000:00:00.0: [Firmware Bug]: reg 0x24: invalid BAR (can't size)

This is due to missing base address register write mask.
Add it to get:

  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [mem 0x10000000-0x17ffffff]
  pci_bus 0000:00: root bus resource [io  0x1000-0x1fffff]
  pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
  pci 0000:00:00.0: [11ab:4620] type 00 class 0x060000
  pci 0000:00:00.0: reg 0x10: [mem 0x00000000-0x00000fff pref]
  pci 0000:00:00.0: reg 0x14: [mem 0x01000000-0x01000fff pref]
  pci 0000:00:00.0: reg 0x18: [mem 0x1c000000-0x1c000fff]
  pci 0000:00:00.0: reg 0x1c: [mem 0x1f000000-0x1f000fff]
  pci 0000:00:00.0: reg 0x20: [mem 0x1be00000-0x1be00fff]
  pci 0000:00:00.0: reg 0x24: [io  0x14000000-0x14000fff]

Since this device is only used by MIPS machines which aren't
versioned, we don't need to update migration compat machinery.

Mention the datasheet referenced. Remove the "Malta assumptions
ahead" comment since the reset values from the datasheet are used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index e02efc9e2e..7df2855f32 100644
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
@@ -1213,17 +1215,27 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
 
 static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
-    /* FIXME: Malta specific hw assumptions ahead */
+    /* Values from chapter 17.16 "PCI Configuration" */
+
     pci_set_word(d->config + PCI_COMMAND, 0);
     pci_set_word(d->config + PCI_STATUS,
                  PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
     pci_config_set_prog_interface(d->config, 0);
+
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff009);
+    pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001);
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
 
-- 
2.45.2


