Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 542ADE7718B
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2024 07:28:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tRnhL-0006Wa-8e; Sun, 29 Dec 2024 02:26:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhE-0006V2-OS
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:44 -0500
Received: from mail-ej1-f42.google.com ([209.85.218.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1tRnhD-00028M-AW
 for qemu-devel@nongnu.org; Sun, 29 Dec 2024 02:26:44 -0500
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-aa6c0d1833eso1746793866b.1
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2024 23:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735457202; x=1736062002;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jKMbZ7tOE4zEmIm/XjRbDObEJm0egPj+8uDYK+TX4uk=;
 b=nk4HVy0ZEzh5DvRT2+zL6l8lhWaG0/jtKS0ZTz9HZySAWGlkFhRx81duFzcoaCeAmI
 HuSTYSqfZyb/fRF4wzLlpC70r4ciS9F2YBMTfIozElQ4cn0/U6xV3ILpF+VlSVa1UGkL
 VNaW7CDkLnNrdbKaVIAiTITp1DcJBs/yRhvy/WBCZDW3e9y9azFPizLbWsjnBuyzN3kj
 MFrR0w0JyMp3UGEcEJjQrKEDJqq4JM7Kbb7lNvOUJU5rHpyfuezyEPxPYSGy+vfajEn5
 6OUeH1NyqwXHBEybZ4mndYwI9CxGuzTJg8hVIQyzZJxMTwk4Cv4Aoh9VCn0BxRC0Wm3a
 fFEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqZPlIPpvchoLdHypQEssjxgczUgBWwJ0zpF53MOXegQLFxMmCOgoVa8jWuibJyfztWH/92Bq4T5um@nongnu.org
X-Gm-Message-State: AOJu0YwqSU/NNQMNosIfMVgInTegfik5X1qoVCxugj5wJfgXD+Q3PuvY
 3GF22GUKqGPJcWkxKfjE4cSUNnmnPjL27O1JrxrKNJcgD8az8D9odmq+xA==
X-Gm-Gg: ASbGncscg0ZtUYxv2jUzclBgFSEEQ8027euZUR3GoqOnnJHZCvzzWh3JYNFxdfjDWpd
 RYjaPOjUSZPUGvOOc/8p/mAypd5XI9ubar+9rymijwFXjnho/orhGubj5gHUL0cbhvboTI0jJIJ
 25kVMoOVXFYojylkjjlES8eSuduvT7vwyQ0ip9I4dsYmsLmMtlwlNNsz2a9bH+FKgrqOc33JPGu
 7VRsOsUR5DmEe1p26wQ9xRrWx74KeWrjrU3xeXPVBOY17fB9SDSIMrMOwvEqT2zVa0yzI3quQzJ
 LIM=
X-Google-Smtp-Source: AGHT+IFhw8Up3yiaWgbctfRePQ9guT2Ftb9o+5mSHuxeKcejS2MyKxrLFUq8N5/hUVEmKP5yiJX4bg==
X-Received: by 2002:a17:906:dc89:b0:aa6:af4b:7c89 with SMTP id
 a640c23a62f3a-aac3446dd7cmr2563586066b.61.1735457201616; 
 Sat, 28 Dec 2024 23:26:41 -0800 (PST)
Received: from tpx1.. (ip-109-42-49-90.web.vodafone.de. [109.42.49.90])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aac0e895194sm1329218666b.70.2024.12.28.23.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 28 Dec 2024 23:26:40 -0800 (PST)
From: Thomas Huth <huth@tuxfamily.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PULL 07/35] next-cube: introduce next_pc_init() object init function
Date: Sun, 29 Dec 2024 08:24:58 +0100
Message-ID: <20241229072526.166555-8-huth@tuxfamily.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241229072526.166555-1-huth@tuxfamily.org>
References: <20241229072526.166555-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.218.42; envelope-from=th.huth@gmail.com;
 helo=mail-ej1-f42.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.156, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
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

Move initialisation of the memory regions and GPIOs from next_pc_realize() to
the new next_pc_init() function.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Message-ID: <20241222130012.1013374-6-mark.cave-ayland@ilande.co.uk>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/next-cube.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/next-cube.c b/hw/m68k/next-cube.c
index 97dea45b13..c187a469d9 100644
--- a/hw/m68k/next-cube.c
+++ b/hw/m68k/next-cube.c
@@ -897,20 +897,24 @@ static void next_pc_reset(DeviceState *dev)
 
 static void next_pc_realize(DeviceState *dev, Error **errp)
 {
-    NeXTPC *s = NEXT_PC(dev);
-    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
+    /* SCSI */
+    next_scsi_init(dev);
+}
+
+static void next_pc_init(Object *obj)
+{
+    NeXTPC *s = NEXT_PC(obj);
+    SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
 
-    qdev_init_gpio_in(dev, next_irq, NEXT_NUM_IRQS);
+    qdev_init_gpio_in(DEVICE(obj), next_irq, NEXT_NUM_IRQS);
 
     memory_region_init_io(&s->mmiomem, OBJECT(s), &next_mmio_ops, s,
                           "next.mmio", 0x9000);
     memory_region_init_io(&s->scrmem, OBJECT(s), &next_scr_ops, s,
                           "next.scr", 0x20000);
+
     sysbus_init_mmio(sbd, &s->mmiomem);
     sysbus_init_mmio(sbd, &s->scrmem);
-
-    /* SCSI */
-    next_scsi_init(dev);
 }
 
 /*
@@ -971,6 +975,7 @@ static void next_pc_class_init(ObjectClass *klass, void *data)
 static const TypeInfo next_pc_info = {
     .name = TYPE_NEXT_PC,
     .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_init = next_pc_init,
     .instance_size = sizeof(NeXTPC),
     .class_init = next_pc_class_init,
 };
-- 
2.47.1


