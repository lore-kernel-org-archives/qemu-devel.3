Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CE78CAC592
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:13:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya5i-0004MD-0Y; Tue, 16 Sep 2025 14:07:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4w-0003Ac-4X
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:59 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4k-0001dK-Mh
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:06:51 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-45ed646b656so49695745e9.3
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046002; x=1758650802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=seP0xrEvNCnKjpsBJ955vCqpOKXP9VKXeAgomjXz8Bg=;
 b=p2xpZQ72YqwobVuaWPdSCkH8slU2Pj5g5cmq1Rj1yjCWuYuuwz5ui9LcW3aNuWDogl
 rj3PTrZZl4nQqJbtzhhQTE6fXPn8HHcXiR75Iz0/fciZCzVadOL3dxBg/n5TR8J21AYa
 iPYD3YjOS0oz3RIQSB5ZBuJSKPMIndOnHya41mdkb+ilPZ3Iq3zZ1+sGsV0g1M5vtaRz
 QnRO3Q+rffk5HWknuIo/VVPik0TCrMRqRsu6MQSEJ2N3yrlhMY1eBBja0mLoQnn4DNEj
 3tSRq3THOETRXjHo6Z5nfeBhLxSDWQHqOw7m7YjryiAJ6w8M74fU0KsEshcdQLw4J+bU
 0T1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046002; x=1758650802;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=seP0xrEvNCnKjpsBJ955vCqpOKXP9VKXeAgomjXz8Bg=;
 b=i+k3FG7cMyvEl8BQuY5zJDjoBkqqSW4A8f/jBCxhQqszNfwSAG6w/zzoU23dhIy+Q4
 9dLDyiYA8yytSwKyV6loK+DJSlgQ8oJUIMI/WYDSCBbgwp5ejGo0U0uyRn8O0+7o+MRx
 stlxuzwWlbZgONBsnSEWlNqrs/VFDXoL5ZnP8ZGvtN1dAKWOJKadr8eBE/jg2R+Kc3gL
 J6AfIZXQWHd/JtnWCWJSwC6GkYt+ZnfZmIAeFdmW+918+MyOOUk+AofBgAxkyeDOrjh7
 k+jWackTEa/JNgjNMUrSqubu3k0DVkNeOWeveSKEZ/8xVzOl0iLJbIM0M9jp/4uuPgWL
 e0Ig==
X-Gm-Message-State: AOJu0Yybnto1S4lerDyvohoASbbz1Jnp3mr1Jx8pZ/OOF6PvcMdoABqR
 q2OoOX6l/6wlxMQbW0SWTysk75dcwsZSEXOKo3AJ64Eri39WMl/fyx8p/LXnBmlUqxYHuimluSh
 xbDPb
X-Gm-Gg: ASbGnctG4ZVzBycXe+XuCYng2pMdHj0Akk13y0EWRhohrZikAB4jwbwZ+scycHOSBQu
 bsL1XGUcWSGB4cXO46iH4DrJ3ft+vvExUgT1jbGGbt5VePJRyrgpdJ1y6/wML87tAh56nJcey41
 Ff50XPkLAwDtd0M+sbLlgm45raU5BtIBS7YRzsXboxSEDatM9kr3TUZ2XpG98QwhWeyYzkxqtwo
 tzHJyzGIyAJXDX0Y2RNYaxfkGqqM9swXb0bE2Ve3UaE7hPuVJJ5C+0REwGbc2nZ46wSPVOVu5dE
 WJcXyU75X71K615qNcq5L54WntRI/1KICUlCr4XurWSyNJEtQMa2q8PWNjZ/WbNTAXSMD+DnLE9
 r6dIe9PIYnxwWzs2YNoJNVw92UL6S
X-Google-Smtp-Source: AGHT+IFdBk1x/+6Goql+jZuEF7SparSqo6EV6b+3ga04pRrN0C0ZqqPkjreu4Wzihf5wTbUvK6tSbw==
X-Received: by 2002:adf:ee46:0:b0:3ec:4e41:fd86 with SMTP id
 ffacd0b85a97d-3ec4e41ff5fmr3147507f8f.50.1758046002136; 
 Tue, 16 Sep 2025 11:06:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 25/36] hw/arm/smmu-common: Check SMMU has PCIe Root Complex
 association
Date: Tue, 16 Sep 2025 19:05:59 +0100
Message-ID: <20250916180611.1481266-26-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
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

From: Shameer Kolothum <skolothumtho@nvidia.com>

We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
root complexes to be associated with SMMU.

Although this change does not affect functionality at present, it is
required when we add support for user-creatable SMMUv3 devices in
future patches.

Note: Added a specific check to identify pxb-pcie to avoid matching
pxb-cxl host bridges, which are also of type PCI_HOST_BRIDGE. This
restriction can be relaxed once support for CXL devices on arm/virt
is added and validated with SMMUv3.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Message-id: 20250829082543.7680-2-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/pci/pci_bridge.h         |  1 +
 hw/arm/smmu-common.c                | 31 ++++++++++++++++++++++++++---
 hw/pci-bridge/pci_expander_bridge.c |  1 -
 3 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 8cdacbc4e16..a055fd8d321 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -104,6 +104,7 @@ typedef struct PXBPCIEDev {
     PXBDev parent_obj;
 } PXBPCIEDev;
 
+#define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
 #define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
diff --git a/hw/arm/smmu-common.c b/hw/arm/smmu-common.c
index 0dcaf2f5897..7f64ea48d03 100644
--- a/hw/arm/smmu-common.c
+++ b/hw/arm/smmu-common.c
@@ -20,6 +20,7 @@
 #include "trace.h"
 #include "exec/target_page.h"
 #include "hw/core/cpu.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qemu/jhash.h"
@@ -925,6 +926,7 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
 {
     SMMUState *s = ARM_SMMU(dev);
     SMMUBaseClass *sbc = ARM_SMMU_GET_CLASS(dev);
+    PCIBus *pci_bus = s->primary_bus;
     Error *local_err = NULL;
 
     sbc->parent_realize(dev, &local_err);
@@ -937,11 +939,34 @@ static void smmu_base_realize(DeviceState *dev, Error **errp)
                                      g_free, g_free);
     s->smmu_pcibus_by_busptr = g_hash_table_new(NULL, NULL);
 
-    if (s->primary_bus) {
-        pci_setup_iommu(s->primary_bus, &smmu_ops, s);
-    } else {
+    if (!pci_bus) {
         error_setg(errp, "SMMU is not attached to any PCI bus!");
+        return;
     }
+
+    /*
+     * We only allow default PCIe Root Complex(pcie.0) or pxb-pcie based extra
+     * root complexes to be associated with SMMU.
+     */
+    if (pci_bus_is_express(pci_bus) && pci_bus_is_root(pci_bus) &&
+        object_dynamic_cast(OBJECT(pci_bus)->parent, TYPE_PCI_HOST_BRIDGE)) {
+        /*
+         * This condition matches either the default pcie.0, pxb-pcie, or
+         * pxb-cxl. For both pxb-pcie and pxb-cxl, parent_dev will be set.
+         * Currently, we don't allow pxb-cxl as it requires further
+         * verification. Therefore, make sure this is indeed pxb-pcie.
+         */
+        if (pci_bus->parent_dev) {
+            if (!object_dynamic_cast(OBJECT(pci_bus), TYPE_PXB_PCIE_BUS)) {
+                goto out_err;
+            }
+        }
+        pci_setup_iommu(pci_bus, &smmu_ops, s);
+        return;
+    }
+out_err:
+    error_setg(errp, "SMMU should be attached to a default PCIe root complex"
+               "(pcie.0) or a pxb-pcie based root complex");
 }
 
 /*
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 3a29dfefc2c..1bcceddbc4d 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -34,7 +34,6 @@ typedef struct PXBBus PXBBus;
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
                          TYPE_PXB_BUS)
 
-#define TYPE_PXB_PCIE_BUS "pxb-pcie-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-- 
2.43.0


