Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B920C021B3
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Feb 2025 11:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmASG-0008QP-2c; Sun, 23 Feb 2025 06:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASD-0008Pj-Kc; Sun, 23 Feb 2025 06:47:25 -0500
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmASB-0005vT-Nx; Sun, 23 Feb 2025 06:47:25 -0500
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-ab744d5e567so606938866b.1; 
 Sun, 23 Feb 2025 03:47:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740311241; x=1740916041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uWfrQhvz/dbConbW1e2cYEwd7c6kqdBGuDJ0FPSuEbo=;
 b=jSib/9rlrO+yUViatlvCt0Y+dGMKaA3evumBiamf/6HS1DXMAicn7qbhNE+9YY0j+8
 7rM05E8q4E9qDoLm1te/e02zO6o0YqiymKD5qaUWYuRdA01haplnreBvRSbvit+aOAd2
 6Lv+8xFhjTje+xjmWgDzac0uMYpqyZ7+9JpoX360zJ8rI0H3c5KGZ6shFako1gGd0jk4
 igMkbLtaNtCthRQg8YeOmXsLC/kigM06j7aaXWdxY+e9YJsF3eoRxiL6+ProsvPV4GDY
 IE7m+v7UA2cd2x/JDOcrWglR7WQsXN83dEVXvo0cn0WWhlseNYPD5GkTvIAUBxUBDOcv
 USXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740311241; x=1740916041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uWfrQhvz/dbConbW1e2cYEwd7c6kqdBGuDJ0FPSuEbo=;
 b=sm2gCqtJ3XDF+YyTimGvXzzpszCoTMg99GuieU2lzDQtT+MENFM4qDnS91FHZIZCG/
 CwcvwjIGJXaviy15TSIi1SSFiKUBy8VN2A3XkxDpjsEQpfzlTarc17nKW/fgKEYNko4W
 qbbf74w/8fzve/7aKa7nWo/xKv/9oZfHvTAPSt1ca/pHgdSOHhlbqltOKp24NCnFSwcD
 m2nMzngWIYsY8m3qM32flMxR4xstRA+RfUd4FOUe3CkgQb6Guag4QEGelwpaF6ZGoezY
 ZU2GMwV+3yEfougNUd6QURxS9pbFnXXmAYqwdPS5SJ+0HHJ4YK/IFWk3RKhSV7mu6zqG
 zCJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBUcz00TZ1tZh9f9DN4sK3Ht344d8vIpHmfh+i3koOMxqSiufO55TACHDa/Uq4CKliR35GteRhcA==@nongnu.org
X-Gm-Message-State: AOJu0Ywyu/UCGRixJzh6LmFClwVCtG29qu/Er38ocZhmSRt8Q2iC99RA
 alOH+BdQkvevG2Li4g+j2t3ZbjTg/CZvrzsaIcSkj6mvadmRTvtiflFF3g==
X-Gm-Gg: ASbGncteGDrQLEDKTTE1/bDG1SWbYzo7iFyhZps+ER544I7+mFxutdlK8nAp8GQbSsV
 DbB7uZ2FP3RlgcMb++qxQ5AzDLFfPT8HyG6quaVwJesULlbaCY+e6Sex0GW9qsi7G0lLpMFzrpJ
 W1+FfhO9b0FmxiDK+WNW2rMlOp0gq/L2XoITZadk1Gd1v6XaTeQ3diQDTTUek0iFHIoUTaxpACO
 8M825ed7eZ8815OJqEbXnA+i//Qdj82hPC9C0rb2T8G8es5ARqP5zv/YBYSwfFIUPzNjn9rmYBY
 sOxZMlizIFZNCLmDCnwS7rPXH+Ji20nVx/Y8yzBRo0V/mPzdRH1j85e5vtUjms8PhQcqAxllFSS
 w7DWpSOg6Daw6
X-Google-Smtp-Source: AGHT+IFlbpOrROEdqJPURx30e+IPdb5EIdcwBkWKH6+nUgHdf+W5q1SGEFxvkA7PKeUTw7blfVJypA==
X-Received: by 2002:a17:906:308c:b0:ab3:9aba:ce7d with SMTP id
 a640c23a62f3a-abc0ae1ab4cmr755188166b.1.1740311240904; 
 Sun, 23 Feb 2025 03:47:20 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-011-167-038.77.11.pool.telefonica.de. [77.11.167.38])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba4b9ee98sm1240515466b.167.2025.02.23.03.47.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 03:47:20 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 02/18] hw/pci-host/designware: Prevent device attachment on
 internal PCIe root bus
Date: Sun, 23 Feb 2025 12:46:52 +0100
Message-ID: <20250223114708.1780-3-shentey@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250223114708.1780-1-shentey@gmail.com>
References: <20250223114708.1780-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62e.google.com
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

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
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


