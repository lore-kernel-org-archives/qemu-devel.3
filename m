Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C047C02197
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:23:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfF7Y-0004iF-RO; Tue, 04 Feb 2025 04:21:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7X-0004hI-SQ; Tue, 04 Feb 2025 04:21:27 -0500
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tfF7V-00052V-UP; Tue, 04 Feb 2025 04:21:27 -0500
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-436281c8a38so37592785e9.3; 
 Tue, 04 Feb 2025 01:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738660883; x=1739265683; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r8qJcnNvkV2vDa+pvhn/pUMBPEEUiO9U4AbL5C/A4EI=;
 b=M/v57iB4Kjy7a8+3loZLfcT00Fq8ANfbbvNuDKCybpKTRYdgudvNppThI88fJSybDE
 jZZfN0APomYCews0TCB5OF/7eaP7VIrGuGXETU8qAfSzJKtXZq6VI7GLwDeUSi1JtJu7
 it2Hr6SPU6UkbMIj2SY6K7bn0OQc3ByTtxErvQQp9Ch/5NohFOZ9PXk4rZYZEr+qxaKW
 Xg6SOqwbJcQRnSF9EwaKifWceZgBlG5jKvhgsjl4B35inLJ7jTyMxFvb1LPq3Y1alI+h
 ZckqR94S/sVpBcmU8XCjpjHzEFhGNI7g2hpbjPdnKw3xVxuwA1zAknTVZnPcnOjd0VlZ
 Utgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738660883; x=1739265683;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r8qJcnNvkV2vDa+pvhn/pUMBPEEUiO9U4AbL5C/A4EI=;
 b=qRQIDMlWPTjD98BvryGS52t7yXOwZQr0oZl34TfMb1F7z8LdLlik8aN1qepquVCHIv
 R6vLdgR6AnlA9b6E465V+5AJ2hqWTWcxKaT6j+JusSzRZhz5Rf2m3RaTWP6idmWY+h8d
 sT4TpY9wuOSSbOSS+oqItCAt2UH04eTJFjAhGhOv/2DtSoDxgRdToVZy3pYxa52fPBqk
 0YHcYImI2is/K09m807C3r07fItFx/zoblPj1F5m6XK8jqxaPkcuvV//i7Z5OouFn45w
 KVicke4WP8G2vNTB6VEURaLmICK7BqfFNO1N09+7WcDl2kT/oha7osmQBCAZtGn+S4/2
 A8AQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7xDphUFhkCYFlznmclSN/ycjp1tf3PL7LO8DSx9GV7dpjsb5BdEZ+ODolKc7ycS54wIsHCBXZdQ==@nongnu.org
X-Gm-Message-State: AOJu0YxU6PDa1bh+ZwUZQubL1fj1fPs1/ogNHqyFGWzvxNHuM+xxnQdA
 vXN6qZRJHDcKDWEGxVg96s5s7toXe8Tlpv06lEDgaxRdOIcF0Ivmx2InJg==
X-Gm-Gg: ASbGnctc8j8HHMgSKra8FCugFYbrAgI54nLq2wX35McPsDO1secsspp3g7bEGLPyofL
 vhEccAxRqGePQuYQlwhZdl2ri3Gk5M4MVw3k+IJ6akPYb1lKqs7OWVvMVkwc0uSVgpQq0iYgO4J
 vQ/Vb32mr8lHFRbw9jRJjn3WNwtW4o88voP+zEJje54qp4tOVdpmoGwS9gK2bcDoZl3lp7Q7ULp
 VeOMh8k8ItKXT2lUsyKHNAdWHZ3xyzVQSqR0iqFrwcpFGQHc4uJMSjLFBZX5wMJHoe7hKZZS1t+
 XkhrsVBYLSKtumj/YaEw48sjMpHWyLt14nSDjeczHm1jdlyQMbjKef8dWjVLGXAWI6OQZcinmF2
 h3YEvJgwXmw==
X-Google-Smtp-Source: AGHT+IGFnzhzFoa5lrzn5Br0tkTkWOKQ8AYyqJR7VRaIeZ6WJVyhVa8hl93unPjbRIxst2+Da+7BEw==
X-Received: by 2002:a05:600c:4c24:b0:434:f609:1afa with SMTP id
 5b1f17b1804b1-438e01fdfe1mr191296755e9.4.1738660883217; 
 Tue, 04 Feb 2025 01:21:23 -0800 (PST)
Received: from Georg-PC.fritz.box
 (p200300faaf0043006a2cae69f03f1c85.dip0.t-ipconnect.de.
 [2003:fa:af00:4300:6a2c:ae69:f03f:1c85])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23d42c7sm187233595e9.3.2025.02.04.01.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 01:21:21 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2 02/18] hw/pci-host/designware: Prevent device attachment on
 internal PCIe root bus
Date: Tue,  4 Feb 2025 10:20:56 +0100
Message-ID: <20250204092112.26957-3-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204092112.26957-1-shentey@gmail.com>
References: <20250204092112.26957-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x335.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On the real device, the PCIe root bus is only connected to a PCIe bridge and
does not allow for direct attachment of devices. Doing so in QEMU results in no
PCI devices being detected by Linux. Instead, PCI devices should plug into the
secondary PCIe bus spawned by the internal PCIe bridge.

Unfortunately, QEMU defaults to plugging devices into the PCIe root bus. To work
around this, every PCI device created on the command line needs an extra
`bus=dw-pcie` option which is error prone. Fix that by marking the PCIe root bus
as full which makes QEMU decend into the child PCIe bus.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/pci-host/designware.h |  7 +++++++
 hw/pci-host/designware.c         | 18 +++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index bf8b278978..a35a3bd06c 100644
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
index 3e8c36e6a7..c07740bfaa 100644
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
2.48.1


