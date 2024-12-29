Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E9B3E7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhS-0006Yd-OZ; Sun, 29 Dec 2024 02:26:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhR-0006YD-9U
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:57 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhP-00029g-Tl
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:57 -0500
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-aaec61d0f65so1187740866b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457214; x=1736062014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Y0TLko33F2MaasDIQT476NGblIvnt2E8jIKb4P34+54=;
 b=ADC77sc4cP2W26Dg/izOCYTSpVhFiPoRhzWpm/+XvvdcDqhVnMWYKOkHqa2wlnR6jt
 99I2tU4iCzXc9EkHPckC/mUF6jVgH7th/G8uozuA8EQ+ZvQABf/vSXgDV5lw5DkJK0LV
 Fv8NW0M0F18X6QrBVf/dArU4kpzfNm6lWYN8bWUXtujofEsoKyRs42BDunu0vlwwk8as
 KmqKJEihMBn1IgBnHtCT3nJZHbQrnHc4BT7AdVvLrVvTehNFpHEJr5ePOAFAq54ZV1pw
 /I+52Z9oOGcdz+k42AUumXtTg35GJpOl77ehmODpGW4ovV60P1StqOeCrnChsmx9uLZy
 w3lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUM23oSWMO8jKuImeh0scLlQzddF4RjqKqTPhA8VNW/fA0PWp3tVXkDmYtq/CYNoxRR345Uey50oR1a@nongnu.org
X-Gm-Message-State: AOJu0Yy35fdK/gMz+ANVcH0QeOGHbCMBcLDoGyTQrLZwosGEsVOhP96G
 0wX0k8yAR4DERHqVNS+eFU3yKaeQo52t7fLIInXVFo7a7q8VY13oSvQRCA==
X-Gm-Gg: ASbGnctQOiHFFtjnHhs1bqZYvWD7LDHZcxk2EwvyJAt+RmTuL1b4NumSe6kyLx316na
 D8CSJZbHAJ6iehkHmNfQaOYtegdB339KCBIbVNmlgcINr8zAEQbSOfWdv9EJXsQux//HX5HBIW0
 jabtgC+alKQWJwOAFmfezWmgNJu6EcpIRWODTYZq8IBvCot+KymK29pdj9zti8QwNfgEstB0+oO
 mUtOUT1lsg/9kdb8iG1q6IBAKE1YHY6sf4iJsKVGFklQdz8NJUgiMUySnoBvD3j+QqiSSlQnfWF
 xEM=
X-Google-Smtp-Source: AGHT+IHMjjUArp9xGeb+wlWNZWsn5pQpSBhiLqU3bnG0kY32kR8uc+hQLx3xssDy2axR2jwoGYr/DA==
X-Received: by 2002:a17:907:c03:b0:aab:9361:f8f8 with SMTP id
 a640c23a62f3a-aac335624cemr2785930166b.50.1735457214452; 
 Sat, 28 Dec 2024 23:26:54 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:53 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 12/35] next-cube: map ESCC registers as a subregion of the
 next.scr memory region
Date: Sun, 29 Dec 2024 08:25:03 +0100
Message-ID: <20241229072526.166555-13-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.48; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f48.google.com
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

Since the ESCC device exists within the memory range of the next.scr memory region, map
the ESCC device registers as a subregion of the next.scr memory region instead of
directly to the system address space.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20241222130012.1013374-11-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 4d7fcdd943..6ddd9ad0ec 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -980,6 +980,7 @@ static const MemoryRegionOps next_floppy_ops = {
 
 static void next_escc_init(DeviceState *pcdev)
 {
+    NeXTPC *next_pc = NEXT_PC(pcdev);
     DeviceState *dev;
     SysBusDevice *s;
 
@@ -997,7 +998,9 @@ static void next_escc_init(DeviceState *pcdev)
     sysbus_realize_and_unref(s, &error_fatal);
     sysbus_connect_irq(s, 0, qdev_get_gpio_in(pcdev, NEXT_SCC_I));
     sysbus_connect_irq(s, 1, qdev_get_gpio_in(pcdev, NEXT_SCC_DMA_I));
-    sysbus_mmio_map(s, 0, 0x2118000);
+
+    memory_region_add_subregion(&next_pc->scrmem, 0x18000,
+                                sysbus_mmio_get_region(s, 0));
 }
 
 static void next_pc_reset(DeviceState *dev)
-- 
2.47.1


