Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67BBDC52D70
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 10:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sauVI-0003fx-Mf; Mon, 05 Aug 2024 05:59:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVF-0003cR-9b
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:45 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sauVD-0001GY-OO
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 05:59:44 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1fec34f94abso80505715ad.2
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2024 02:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1722851982; x=1723456782;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=LuOaJH+QrihGyemQSgnz7T1Hq666W5wLKaLdXVtBW7s=;
 b=Byf5RirmOslpgKoSN4Q/rT000nyKOjgr+UvITW5WvxouVLpjET4voW0Dxlep0nuA+H
 BxymreOQb2LgVi2gJ5rzfiJGxR549b3FAYf+1LphbULX9bSJOFKqLlM7o3tL1fNfTBOI
 6C4eNS4bj39HydVAPLUY+kcYomclQI465sO2aBEhxM9iear3AM1oO0s+y+3wwWPaVV1Z
 1/N8NFQC1zQ6yFCNHEYroOdYBFYsqMdRIlSIQcdDtHDxbi9TOGs7CMHm8wRczUhoJLPL
 Ro41QRoNyR93lopY0a5Ve1XUr291c2C7aBMfQFhCoNZHwQNCufvV7fQtzXRF0gaJd8LH
 4lyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722851982; x=1723456782;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LuOaJH+QrihGyemQSgnz7T1Hq666W5wLKaLdXVtBW7s=;
 b=VQi/n0yHTUuCxKBx58nlZX7M6zRYOXJoAlszEFHb754ex8go6c/CPg6F0eKP4V+KiX
 e/VPbY3SNZx8/zx5qPqVNsG9omAT1h87CB9FcprgnjODiX7zxtCvIb5qfWeEniJfV2TR
 MltUlw1oQsiv6pwNiafs16tV54LdnjTSBpN7NyO5K27hXk11jkOISf79dykrwKDXVSTn
 QK4rW437ngm1TaE3TRd3juCTvmnFHICR2bb4QQoTxFgY93lxSoMPNwitLmo4xXsdla5w
 72fmm49SDC9nbnmIYToZ5kyx4k7YP6xRlwfVW8KLz4A8Mw7uOS2OXTWndjRULNoAXbhb
 Twdg==
X-Gm-Message-State: AOJu0YxRgrbO7hkyzW8RO1tTbW+vgeXs4IZYdcxR3RJAeQN39ST8TnQx
 XaQ8mg9dZnvHnxWV15AUyIp2z+EHw1XRy157FzNcBuNsWqJWUEaSeEfL900TdOQ=
X-Google-Smtp-Source: AGHT+IFj7TbHtdBmFoX9Qo4BTVQbRdxt0oFv0r2d8KTdoCAp1Qx0OJVrdhJc4nk9BSDZd2w45bDmqA==
X-Received: by 2002:a17:902:d4c5:b0:1ff:1bd:7e61 with SMTP id
 d9443c01a7336-1ff57258aa1mr123317335ad.14.1722851982425; 
 Mon, 05 Aug 2024 02:59:42 -0700 (PDT)
Received: from localhost ([157.82.202.230])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-1ff58a66284sm63775605ad.0.2024.08.05.02.59.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Aug 2024 02:59:42 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Mon, 05 Aug 2024 18:59:01 +0900
Subject: [PATCH for-9.2 v13 04/12] s390x/pci: Check for multifunction after
 device realization
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240805-reuse-v13-4-aaeaa4d7dfd2@daynix.com>
References: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
In-Reply-To: <20240805-reuse-v13-0-aaeaa4d7dfd2@daynix.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>, 
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The SR-IOV PFs set the multifunction bits during device realization so
check them after that. This forbids adding SR-IOV devices to s390x.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 hw/s390x/s390-pci-bus.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index 3e57d5faca18..00b2c1f6157b 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -971,14 +971,7 @@ static void s390_pcihost_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
                     "this device");
     }
 
-    if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
-        PCIDevice *pdev = PCI_DEVICE(dev);
-
-        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
-            error_setg(errp, "multifunction not supported in s390");
-            return;
-        }
-    } else if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
+    if (object_dynamic_cast(OBJECT(dev), TYPE_S390_PCI_DEVICE)) {
         S390PCIBusDevice *pbdev = S390_PCI_DEVICE(dev);
 
         if (!s390_pci_alloc_idx(s, pbdev)) {
@@ -1069,6 +1062,11 @@ static void s390_pcihost_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     } else if (object_dynamic_cast(OBJECT(dev), TYPE_PCI_DEVICE)) {
         pdev = PCI_DEVICE(dev);
 
+        if (pdev->cap_present & QEMU_PCI_CAP_MULTIFUNCTION) {
+            error_setg(errp, "multifunction not supported in s390");
+            return;
+        }
+
         if (!dev->id) {
             /* In the case the PCI device does not define an id */
             /* we generate one based on the PCI address         */

-- 
2.45.2


