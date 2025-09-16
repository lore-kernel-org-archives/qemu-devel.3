Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B542ECAC598
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Sep 2025 18:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uya7J-0006aY-GV; Tue, 16 Sep 2025 14:09:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya58-0003Tx-TY
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:18 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uya4v-0001e4-Tx
 for qemu-devel@nongnu.org; Tue, 16 Sep 2025 14:07:04 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-45dfb8e986aso57691195e9.0
 for <qemu-devel@nongnu.org>; Tue, 16 Sep 2025 11:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758046008; x=1758650808; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ubfc2PZj+oS1m5/ITApUfm2bX3aVbus3n9rVpILRrWE=;
 b=jvB/OlytC3Cd0Ypu3HNq+FQ7FvQjfIvSeBDqPl9tgfMxoxlKlCJhYzbK7kjCqZKNRz
 5Ndq+ZjFwYQWchjswDlKkefv/nU3gnF6k0HI0TrAl36lLVkM49Q6tTs5PrqjScD4TPK4
 i7QVA7/Pb8+JiENZFs6Bi/scgAnqYlyItIaYxys/2DMu6bbwYWaJs/wRydQxbrLrthSS
 +PVdaoiCyCCHcl6S+Ek+y6QNLmUqdmY0hC7Cg8n4IEvPRs8ccS57wM8n1QBdY2Sl/oYj
 0aTLPdxEssaj5pZZ2mRgGzDPhAQpeYB31rt9Wz0LoZO79mYMIJJjfm79X4DJfo9aRnH3
 nUjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758046008; x=1758650808;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ubfc2PZj+oS1m5/ITApUfm2bX3aVbus3n9rVpILRrWE=;
 b=Q0hn5IYU7qrYZJlzZHVFKzf1NgLtWHgt1DQKgZQ3bGJ2QLAXpomLYmoXIMVXBxKoFj
 Mjs8YKaqHP1Xhc962g/+ajpj/cUCOYavMYInGEqrQWZrZy3n8xo6VUFP2GrnvMY66w9j
 lL9SqZ568h8X3/OFN5xMwkoIaDjSrnfzZbfSfaHy9NHZptTP0KsOh1SuQbc+Gapv9qDL
 A0si5sEtYK8zruhiJD7Q//hADBbfsWj0EnzNUTZNOZX5Ha7whrH9Fapi9Z3V9CxAlmPw
 rOKHJi4hz1WMQwb8AGLDT8+cq7t26c4dwaEyTW/KTFTD4nqRX5vl0FanoCwQSpMr/bpf
 CZqw==
X-Gm-Message-State: AOJu0YyHsW11nHbCgOpeWZYADi/ytZjP45KhVMlH1Ua9CbNPylFmoFI/
 YHpnSeJURFNqYg9GfzHxsrX3KRPYPEvsHkCS4tO+aPQfGOAv16tUtZ0T+6JFu3/4csaGTZhId0g
 TQVDJ
X-Gm-Gg: ASbGncvNIrEOOjFoTIUL9qAzl7BrZSpP72qcrgyHpAvjCkBkwEMxWAUlY2CQun/CQoV
 JIXcB9PEiyYyqJfO/W84D7PhBiaxHylfnXIpwo6SnERHhQ8LOkeBu5CeRMu+sBedXs0tLUsvey6
 nDrxJMqBmh7k4q7pMe1HxXBmH4G3XI7Mt7rj0l5+zoI8JL6bO4uyXcs0R47PsKpYsLSobQxpqqN
 sOTGC5F3DfzO/8K7CkLK7cVGUULQpOPrUghqQPSulNg9hjlMg8sK9QfC2f7DnJgbwl5DDCBKnzJ
 YvW16M+CQk7nbUKAb3j0qiYhJZd4X6NAZWroI8Pvphcx4C1sPUNoLil6IC8uoZ7m72vFzstIy2U
 u9HawrS7owjf9Itz9YwtbB7tKv+6IZLGsKuf+ACY=
X-Google-Smtp-Source: AGHT+IFApf8ohbI8uwk+/MEsz8A+1IubEnMXSZzTRs4tUjzWR4e0k0InydV3hI/MH4a9X+zVisgRuQ==
X-Received: by 2002:a05:600c:1909:b0:45f:2c89:a873 with SMTP id
 5b1f17b1804b1-45f2cbafa55mr63564115e9.35.1758046007948; 
 Tue, 16 Sep 2025 11:06:47 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e760775880sm23033286f8f.2.2025.09.16.11.06.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Sep 2025 11:06:47 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 30/36] hw/pci: Introduce pci_setup_iommu_per_bus() for per-bus
 IOMMU ops retrieval
Date: Tue, 16 Sep 2025 19:06:04 +0100
Message-ID: <20250916180611.1481266-31-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250916180611.1481266-1-peter.maydell@linaro.org>
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32e.google.com
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

Currently, pci_setup_iommu() registers IOMMU ops for a given PCIBus.
However, when retrieving IOMMU ops for a device using
pci_device_get_iommu_bus_devfn(), the function checks the parent_dev
and fetches IOMMU ops from the parent device, even if the current
bus does not have any associated IOMMU ops.

This behavior works for now because QEMU's IOMMU implementations are
globally scoped, and host bridges rely on the bypass_iommu property
to skip IOMMU translation when needed.

However, this model will break with the soon to be introduced
arm-smmuv3 device, which allows users to associate the IOMMU
with a specific PCIe root complex (e.g., the default pcie.0
or a pxb-pcie root complex).

For example, consider the following setup with multiple root
complexes:

-device arm-smmuv3,primary-bus=pcie.0,id=smmuv3.0 \
...
-device pxb-pcie,id=pcie.1,bus_nr=8,bus=pcie.0 \
-device pcie-root-port,id=pcie.port1,bus=pcie.1 \
-device virtio-net-pci,bus=pcie.port1

In Qemu, pxb-pcie acts as a special root complex whose parent is
effectively the default root complex(pcie.0). Hence, though pcie.1
has no associated SMMUv3 as per above, pci_device_get_iommu_bus_devfn()
will incorrectly return the IOMMU ops from pcie.0 due to the fallback
via parent_dev.

To fix this, introduce a new helper pci_setup_iommu_per_bus() that
explicitly sets the new iommu_per_bus field in the PCIBus structure.
This helper will be used in a subsequent patch that adds support for
the new arm-smmuv3 device.

Update pci_device_get_iommu_bus_devfn() to use iommu_per_bus when
determining the correct IOMMU ops, ensuring accurate behavior for
per-bus IOMMUs.

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Nathan Chen <nathanc@nvidia.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Tested-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Donald Dutile <ddutile@redhat.com>
Message-id: 20250829082543.7680-7-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/pci/pci.h     |  2 ++
 include/hw/pci/pci_bus.h |  1 +
 hw/pci/pci.c             | 31 +++++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 6b7d3ac8a36..6bccb25ac2f 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -773,6 +773,8 @@ int pci_iommu_unregister_iotlb_notifier(PCIDevice *dev, uint32_t pasid,
  */
 void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
 
+void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque);
+
 pcibus_t pci_bar_address(PCIDevice *d,
                          int reg, uint8_t type, pcibus_t size);
 
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 22613125462..c7384467888 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -35,6 +35,7 @@ struct PCIBus {
     enum PCIBusFlags flags;
     const PCIIOMMUOps *iommu_ops;
     void *iommu_opaque;
+    bool iommu_per_bus;
     uint8_t devfn_min;
     uint32_t slot_reserved_mask;
     pci_set_irq_fn set_irq;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 297196b2421..c3df9d6656b 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2912,6 +2912,19 @@ static void pci_device_get_iommu_bus_devfn(PCIDevice *dev,
             }
         }
 
+        /*
+         * When multiple PCI Express Root Buses are defined using pxb-pcie,
+         * the IOMMU configuration may be specific to each root bus. However,
+         * pxb-pcie acts as a special root complex whose parent is effectively
+         * the default root complex(pcie.0). Ensure that we retrieve the
+         * correct IOMMU ops(if any) in such cases.
+         */
+        if (pci_bus_is_express(iommu_bus) && pci_bus_is_root(iommu_bus)) {
+            if (parent_bus->iommu_per_bus) {
+                break;
+            }
+        }
+
         iommu_bus = parent_bus;
     }
 
@@ -3172,6 +3185,24 @@ void pci_setup_iommu(PCIBus *bus, const PCIIOMMUOps *ops, void *opaque)
     bus->iommu_opaque = opaque;
 }
 
+/*
+ * Similar to pci_setup_iommu(), but sets iommu_per_bus to true,
+ * indicating that the IOMMU is specific to this bus. This is used by
+ * IOMMU implementations that are tied to a specific PCIe root complex.
+ *
+ * In QEMU, pxb-pcie behaves as a special root complex whose parent is
+ * effectively the default root complex (pcie.0). The iommu_per_bus
+ * is checked in pci_device_get_iommu_bus_devfn() to ensure the correct
+ * IOMMU ops are returned, avoiding the use of the parent’s IOMMU when
+ * it's not appropriate.
+ */
+void pci_setup_iommu_per_bus(PCIBus *bus, const PCIIOMMUOps *ops,
+                             void *opaque)
+{
+    pci_setup_iommu(bus, ops, opaque);
+    bus->iommu_per_bus = true;
+}
+
 static void pci_dev_get_w64(PCIBus *b, PCIDevice *dev, void *opaque)
 {
     Range *range = opaque;
-- 
2.43.0


