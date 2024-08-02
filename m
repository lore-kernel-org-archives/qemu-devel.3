Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCB9C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:32:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZzsI-0006ax-UK; Fri, 02 Aug 2024 17:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzsC-0006BD-Su
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:31:40 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZzsB-0003Jo-9u
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:31:40 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a7aa4bf4d1eso225394866b.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722634297; x=1723239097; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u0NPDPj0IuFlNwdkUvZuUBMEuKlzPRqWqvQfGq6P0Mw=;
 b=hlR1rTwMuCjQ1vqIexsEobHqoFSkgl8W/83FOfM0baAhlj8TyFce7pQmUrd/iWZuqN
 m+vcXobzYcuO7sQpw1YTLeofWXNAab5iGYdaBVyNf+dlZ7Rh0IF9xyP/UO9QMsX/ufTK
 zh5tXcz6oOdNByASEY1u4P+GSWDNKMB+WuEOSqYFTuco6urCVrhtQcLiMWYCr+7SLS6Z
 j4v8pqXXQVWS0hGqHfGuVaAkrrgq2NOCy2ylWtxSBrSEa7JNLvLhxhBQGzsqzn5FCqB4
 WTVllGTkFMtXHPE3xG23Glhd/FTJypxcu6ArhzodcvtfbJZPOruT35eoBbOkFAzpUg7q
 A3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722634297; x=1723239097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=u0NPDPj0IuFlNwdkUvZuUBMEuKlzPRqWqvQfGq6P0Mw=;
 b=tbzvz1q6SlVRNtSTo2n4Rw5D9EICRPbOkSSO1l6Ig9U7gED+M3e5RKrn1+zVlE43lh
 LwhKrko5IVIlNrVP+yRLB+UdE0x9rsuJpEoOf2OdyFYgcEaL9IfA+/UkKBkB6RfUv9dG
 tllt+KyTsmvIuWoiaoQ6Yv6R0oG8fj987DxFDK0QSQw2+VvzWqWMbk9Kc6j1Xa+Dqrjv
 wmbiOZmRLVBb5GzMPG31Aih9tdwAvBb3rvPEA9FrOH/KvLQMMJ6AOSdijFYPysmThZwQ
 Z4SpOYLMGq5B2zuihn2rFoXuGKvS5+kzG/RH83Rv9UAZGBI+p0e8ghCUY9t8TyN4DK5a
 zVFQ==
X-Gm-Message-State: AOJu0YwviF0OyWWoRGYRU1uyOWCdz2f3YPxFO6tFoU/WkJW5IV+WMOAs
 GjpHmWPLM8sVOWetrQdFCHkB6t+EudGbk3yYws7sZ7gDeEtLcraOjFEzHPpLEWj5/kNBu9vtIiU
 Z
X-Google-Smtp-Source: AGHT+IFS9NpJSAx4q+mibUMjVFBO4rE4GFznOOlWtLgN9YK2IG3luz44QV/WrVXF8nLhH7Ra08Y1yg==
X-Received: by 2002:a17:907:72c5:b0:a7a:929f:c0d6 with SMTP id
 a640c23a62f3a-a7dc508005bmr388290466b.38.1722634297150; 
 Fri, 02 Aug 2024 14:31:37 -0700 (PDT)
Received: from m1x-phil.lan (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d45400sm140676266b.141.2024.08.02.14.31.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 02 Aug 2024 14:31:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: [PATCH-for-9.1 v5 2/2] hw/pci-host/gt64120: Reset config registers
 during RESET phase
Date: Fri,  2 Aug 2024 23:31:22 +0200
Message-ID: <20240802213122.86852-3-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240802213122.86852-1-philmd@linaro.org>
References: <20240802213122.86852-1-philmd@linaro.org>
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

Reset config values in the device RESET phase, not only once
when the device is realized, because otherwise the device can
use unknown values at reset.

Since we are adding a new reset method, use the preferred
Resettable API (for a simple leaf device reset, a
DeviceClass::reset method and a ResettableClass::reset_hold
method are essentially identical).

Reported-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/pci-host/gt64120.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index 573d2619ee..33607dfbec 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -1217,17 +1217,24 @@ static void gt64120_pci_realize(PCIDevice *d, Error **errp)
 {
     /* Values from chapter 17.16 "PCI Configuration" */
 
-    pci_set_word(d->config + PCI_COMMAND, 0);
-    pci_set_word(d->config + PCI_STATUS,
-                 PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
-    pci_config_set_prog_interface(d->config, 0);
-
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_0, 0xfffff008); /* SCS[1:0] */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_1, 0xfffff008); /* SCS[3:2] */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_2, 0xfffff008); /* CS[2:0] */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_3, 0xfffff008); /* CS[3], BootCS */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_4, 0xfffff000); /* ISD MMIO */
     pci_set_long(d->wmask + PCI_BASE_ADDRESS_5, 0xfffff001); /* ISD I/O */
+}
+
+static void gt64120_pci_reset_hold(Object *obj, ResetType type)
+{
+    PCIDevice *d = PCI_DEVICE(obj);
+
+    /* Values from chapter 17.16 "PCI Configuration" */
+
+    pci_set_word(d->config + PCI_COMMAND, 0);
+    pci_set_word(d->config + PCI_STATUS,
+                 PCI_STATUS_FAST_BACK | PCI_STATUS_DEVSEL_MEDIUM);
+    pci_config_set_prog_interface(d->config, 0);
 
     pci_set_long(d->config + PCI_BASE_ADDRESS_0, 0x00000008);
     pci_set_long(d->config + PCI_BASE_ADDRESS_1, 0x01000008);
@@ -1243,7 +1250,9 @@ static void gt64120_pci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.hold = gt64120_pci_reset_hold;
     k->realize = gt64120_pci_realize;
     k->vendor_id = PCI_VENDOR_ID_MARVELL;
     k->device_id = PCI_DEVICE_ID_MARVELL_GT6412X;
-- 
2.45.2


