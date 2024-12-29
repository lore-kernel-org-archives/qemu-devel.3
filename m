Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA304E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:27:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhC-0006UU-Jv; Sun, 29 Dec 2024 02:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhB-0006UL-MS
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:41 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnh8-00027g-Gn
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:40 -0500
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-5d122cf8dd1so14279180a12.2
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457197; x=1736061997;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5xOWX5rUHlpEZkafc0mWpxiHUlUMjALIHfNNYRm0LGQ=;
 b=qv6z6KvCyhmWTmZYuBkrRIAIF2ryHsQdG/WzIpqyejurU1gJJ6QkXdSZEKPoh9C4gP
 NXm56yu+GVR+rsBoBJp0Yzd/YPCxd2ibDYPD/cyzfO0rcTvjBiuCOVIFTH3/tWLE9YcR
 nmllPPHSrNHrdUCe/R0rnSJMIBkeBxsovEQgQAb0a+A/g9bvSBccS2FGCrMQ7PvH2nKE
 zGYLQxxbbBaf50m4XESYf3cahnPo8Ai75EbV6Mn4UGSVouyiGRzjoz3IqyYW3WGDMtva
 mMZFSBSNMVUtFXhK+zzxmkj1bOcEhGz0AcF5VaIls9CDTvlBlkYs+OObDYKAeoBBI2bB
 YCOA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+boY4xI5KBOMnKQ+O7DvMzUttRk9h8MJ3hOpmxU5ESISUQ0/D6O1F1OrZr+tfudSWv/hErZpe7ye9@nongnu.org
X-Gm-Message-State: AOJu0YwtFowUba3Jao8ROKDLYuYuwHe1C6uajZXPKmJdzXapb7FTf9ng
 +ppnHzGlSL/dkFFUY6jHeX6E0zWvHF/pcmzNFTCSsQ6D6s3laYm8
X-Gm-Gg: ASbGncvmCXnQXz3l6f6y67zNVN96uLKcY6sVKTXb07U83F7PUsxQ35AIeEWJrQa0IlF
 fdDE36O/rhLMdU8JotFVPPltq3Jdy+e4ZttNeP6ykCGJbkNEVShkk3wLPXPVvcVsGjta5C+eEzD
 McrfgHCvvyalcqgaGR82y3oRLMsydPRQM2QWKrP1eWuiM7sVMjfjQU93oSYR/uahFiOHCMWE1/5
 /VwVqEV/jiFO9/TcqI/30RgwGyCmmLZSN0hseicU4B4eDduxdmpq2RKKEewDajCGxiro0RXYrgz
 FTI=
X-Google-Smtp-Source: AGHT+IFT/wyKfiPeWuPVH4QIkpvN/X0Wu/9174/E+9sqAk9amRMroQSWZqW0YEyzbOITY9xmvf2wLQ==
X-Received: by 2002:a17:907:c1c:b0:aa6:8520:718b with SMTP id
 a640c23a62f3a-aac34218aabmr2620028366b.56.1735457196745; 
 Sat, 28 Dec 2024 23:26:36 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:35 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 05/35] next-cube: create new next.scsi container memory region
Date: Sun, 29 Dec 2024 08:24:56 +0100
Message-ID: <20241229072526.166555-6-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.208.44; envelope-from=th.huth@gmail.com;
 helo=mail-ed1-f44.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Move the ESP SCSI and SCSI CSR registers to the new next.scsi container memory
region.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241222130012.1013374-4-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 5f07791707..31c0532aff 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -94,6 +94,7 @@ struct NeXTPC {
 
     MemoryRegion mmiomem;
     MemoryRegion scrmem;
+    MemoryRegion scsimem;
 
     uint32_t scr1;
     uint32_t scr2;
@@ -843,7 +844,12 @@ static void next_scsi_init(DeviceState *pcdev)
     sysbusdev = SYS_BUS_DEVICE(dev);
     sysbus_realize_and_unref(sysbusdev, &error_fatal);
     sysbus_connect_irq(sysbusdev, 0, qdev_get_gpio_in(pcdev, NEXT_SCSI_I));
-    sysbus_mmio_map(sysbusdev, 0, 0x2114000);
+
+    memory_region_init(&next_pc->scsimem, OBJECT(next_pc), "next.scsi", 0x40);
+    memory_region_add_subregion(&next_pc->scsimem, 0x0,
+                                sysbus_mmio_get_region(sysbusdev, 0));
+
+    memory_region_add_subregion(&next_pc->scrmem, 0x14000, &next_pc->scsimem);
 
     next_pc->scsi_reset = qdev_get_gpio_in(dev, 0);
     next_pc->scsi_dma = qdev_get_gpio_in(dev, 1);
-- 
2.47.1


