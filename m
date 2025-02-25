Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF092C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 18:10:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmzM6-0006qf-EC; Tue, 25 Feb 2025 13:08:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJj-0000JU-TB
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:12 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmzJd-0002JQ-BL
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 13:06:00 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4394036c0efso37901645e9.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 10:05:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740506746; x=1741111546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=JM1z9IEOs0dWia7GldRmlxQ1KHltnDm7hKq9lC7Qz7k=;
 b=H9TteOQAQeXZa1YetMyixTOlJ9SDxyOryL5oi32AWoXirgNG+2ASxEX+c76frLYrhc
 VzSxBNMH41omXmdfxIi17GI3854+H0IPf6mYHnAxhXe1T7thVX/7G3cxZOVff2vW56TI
 GSIfRliQSYDVjNfI9Kfh6fPBpYNKM4FNQVdCzjiaTqPi6kWrVLgSFP08vOvKTR9Z83jE
 AjtLZ/5lL+Nlgw8QAe3MCH+yO1t5qRzU+2MgoSC/EUviRPsxZYEjsTXvjgT89XvsEahm
 UZAw6TMP+Nmj6amJIOzjtnUqIZBpCasupuCtWOxTzm+gmdSbzDlrocmGWG2VMkoamfqV
 fSpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740506746; x=1741111546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JM1z9IEOs0dWia7GldRmlxQ1KHltnDm7hKq9lC7Qz7k=;
 b=qgzdbKBc8/GzHJ5M6nO8PymwHzunN8Pd682mAVxXIMJEb1LxJEw09GwZvL55A3ytaW
 hjZTRmABMGszuN0v7oR0wubZvxB61A5DXw3PVHMWdatpr4YWJ+I10QwX2PBKiv7efBx0
 CBkiP6ej9a7f2HFWC/DldhL0CzrxA4Jru+yFX3dBmf5H+97n9RKvj9ELeJgS4InwMjjW
 8dqTilHnTpumRv/skL0kiNPJnJJuawJsS8LcBqXEYNq4KpZiYBKEc/Qe9T+ppkq0/t5R
 AdMmGUUbCW7eHsIq2Ao24G8bsLhyj9wdEUjZUoDLJg21hofx3fSm5+g98HB7uzqGVM6e
 VNhQ==
X-Gm-Message-State: AOJu0YxfrscSX5ib1WPZXct3mKdopnC6aX/4B9zGU8sMO/+v9xHGU2cK
 z5ojx8unxL5WCcSwIl26CDZDakYaXA/Jrxx1b2L9xXBhUuN3J7GTczXEtP0SOd+zLRngC0tKl2+
 J
X-Gm-Gg: ASbGnct7yd6uXm0/EOd3DljUyw7irKcCoDj18I4MnmK66f4sx1ffDSaR9fnyofC/vIQ
 1sfJvOQX50Wa7a2HPD30xPmFDmzY9vIn38wcjDIs0bZbwvunN2G/X3c/JanVRn2fq4mjPMslYSY
 5urCnU/9Z9VD5B9dbhzUTp7mEaRK9XLg5ZmJMdLXSDMNzsYp4ZJW/Kc6CeOKpqgqM8C1LULXdJW
 fNHH3qnUnTNnEpyMm1JJQxpE6Edckk3Ctib/5TJf2Q8NeIFbsx+HqS18Vi0cIBzWz9ic7v70Hs/
 SF67FO//g0v9SdoSmLnxCFgD10RVkCt5
X-Google-Smtp-Source: AGHT+IFlE7NCzaac9t8TlelW8jl3fuxdhqqj4uL22vb9e2vlcVE77Tkc+PKc/2gej6Z3BXABv3lNWQ==
X-Received: by 2002:a05:600c:4f0d:b0:439:98ca:e3a4 with SMTP id
 5b1f17b1804b1-43ab90169d5mr4441495e9.19.1740506746166; 
 Tue, 25 Feb 2025 10:05:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ab156a136sm35147875e9.35.2025.02.25.10.05.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2025 10:05:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/43] hw/pci-host/designware: Prevent device attachment on
 internal PCIe root bus
Date: Tue, 25 Feb 2025 18:04:55 +0000
Message-ID: <20250225180510.1318207-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225180510.1318207-1-peter.maydell@linaro.org>
References: <20250225180510.1318207-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

On the real device, the PCIe root bus is only connected to a PCIe bridge and
does not allow for direct attachment of devices. Doing so in QEMU results in no
PCI devices being detected by Linux. Instead, PCI devices should plug into the
secondary PCIe bus spawned by the internal PCIe bridge.

Unfortunately, QEMU defaults to plugging devices into the PCIe root bus. To work
around this, every PCI device created on the command line needs an extra
`bus=dw-pcie` option which is error prone. Fix that by marking the PCIe root bus
as full which makes QEMU decend into the child PCIe bus.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-id: 20250223114708.1780-3-shentey@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/pci-host/designware.h |  7 +++++++
 hw/pci-host/designware.c         | 18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index bf8b2789787..a35a3bd06c8 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -25,12 +25,19 @@
 #include "hw/pci/pci_bridge.h"
 #include "qom/object.h"
 
+#define TYPE_DESIGNWARE_PCIE_ROOT_BUS "designware-pcie-root-BUS"
+OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERootBus, DESIGNWARE_PCIE_ROOT_BUS)
+
 #define TYPE_DESIGNWARE_PCIE_HOST "designware-pcie-host"
 OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIEHost, DESIGNWARE_PCIE_HOST)
 
 #define TYPE_DESIGNWARE_PCIE_ROOT "designware-pcie-root"
 OBJECT_DECLARE_SIMPLE_TYPE(DesignwarePCIERoot, DESIGNWARE_PCIE_ROOT)
 
+struct DesignwarePCIERootBus {
+    PCIBus parent;
+};
+
 typedef struct DesignwarePCIEViewport {
     DesignwarePCIERoot *root;
 
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index 3e8c36e6a76..c07740bfaa4 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -55,6 +55,17 @@
 #define DESIGNWARE_PCIE_ATU_DEVFN(x)               (((x) >> 16) & 0xff)
 #define DESIGNWARE_PCIE_ATU_UPPER_TARGET           0x91C
 
+static void designware_pcie_root_bus_class_init(ObjectClass *klass, void *data)
+{
+    BusClass *k = BUS_CLASS(klass);
+
+    /*
+     * Designware has only a single root complex. Enforce the limit on the
+     * parent bus
+     */
+    k->max_dev = 1;
+}
+
 static DesignwarePCIEHost *
 designware_pcie_root_to_host(DesignwarePCIERoot *root)
 {
@@ -699,7 +710,7 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                                      &s->pci.memory,
                                      &s->pci.io,
                                      0, 4,
-                                     TYPE_PCIE_BUS);
+                                     TYPE_DESIGNWARE_PCIE_ROOT_BUS);
     pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
 
     memory_region_init(&s->pci.address_space_root,
@@ -754,6 +765,11 @@ static void designware_pcie_host_init(Object *obj)
 
 static const TypeInfo designware_pcie_types[] = {
     {
+        .name           = TYPE_DESIGNWARE_PCIE_ROOT_BUS,
+        .parent         = TYPE_PCIE_BUS,
+        .instance_size  = sizeof(DesignwarePCIERootBus),
+        .class_init     = designware_pcie_root_bus_class_init,
+    }, {
         .name           = TYPE_DESIGNWARE_PCIE_HOST,
         .parent         = TYPE_PCI_HOST_BRIDGE,
         .instance_size  = sizeof(DesignwarePCIEHost),
-- 
2.43.0


