Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16861D6B086
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Jan 2026 16:14:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlUb4-0001bH-5w; Thu, 29 Jan 2026 11:10:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUap-0000bK-MS
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:05 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1vlUan-0006oT-A4
 for qemu-devel@nongnu.org; Thu, 29 Jan 2026 11:10:03 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso9935305e9.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jan 2026 08:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769702999; x=1770307799; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=veysRNauk8VXncuyC7/h3gsWbA6jttORlD+vMEjZXSs=;
 b=idRjtUezipt7uuQuAxMtSYPBybyU1PX3cM6idE8mwmDZBMWYNf53lgHa702uIaWWMg
 C7zJMFMm3toQBnaG1tq0HhjgEynvpY9CUI/8j9SoEus+YAEOtg1up/pndew+AqUQcTiC
 eFqZOMCDZTETpz+IqGbJHFkBnAAv3/4Sg6nISh03QpNKMKv+oEwzsMOhNJTOUWDrR+lH
 eupuGOwfvdRLFoDVxflXmldA32QO/UUGL6DAWjPQd6T+sA/Lo5pcKMkjPZh/4v+T9rVG
 43XL4V8mnqfwb6WGA4ovy5CDgMK3oZMEmkXbrWXS2GfY39rYIDErcQ4A24Y9IdYoUxyz
 e8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769702999; x=1770307799;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=veysRNauk8VXncuyC7/h3gsWbA6jttORlD+vMEjZXSs=;
 b=KudNK5FodWy6fIUnoaZImFlJBxo6sBf+jexmkSC9fEEUyp25FvDepgFbR8J0jangy7
 NXJaDv3F7vYZx7ZwzoDg5wUyrV9oTSzGOweH1IKR7Y73rgMCpzJ+FuwxbOutvmDgz8Fm
 uDay+1jqL8nWchgmuLLJY8l/VCIN4Oj04Sr5fd5foCvZu394gXRLSzf4xJ4EbbqGOnJh
 5X1acuCM8LcXIN1B+otnXywpOxc+Tws2Bxx0dTekwElEiICqO+XaQItnkJcUSs64bAMU
 bu0FU8dCEOgQiYPIYzOvmMGxuaEbSITc3E4iM7UW8odCpeIjCGx5x0u84qB0bzn2piqn
 KeUw==
X-Gm-Message-State: AOJu0YyiUEcUf+LRHECNoWcYA+iUNksNOGHmpODAzw8xkY8DXJMJJS5+
 zGV6YdLW81th/XtS6x08YR/dRkpp+ucO+T5wX0984ye1PHTo7UDDwtSV7Jln640MkoDbyP7tJ/D
 254oamsA=
X-Gm-Gg: AZuq6aIZQ/nVv6XmsVL1ogNkiaqp6hupRtY3me2zo9LKfHrO/FYhXGKJFqyx0jSx6/t
 NBbnkMqQcv3iVqXTuMasr7PSdQGV9+244nBoSsCYJqyx5jRc2EZ2zTV33phoH1JrBnYKUA0+upD
 jx4EF92lvOemNndzov6JxTH332qPzu/E4NYbEgqrz1uOFXGR+7jprRAvBK8bTWcXp8eNp0rueyx
 CDc6Rg14x51M8ak3Gscsp+eK6s24ozS6jjAsaw9/3NvqDaB9XSzLEaC5cWH/jXMljmGIfAlcmwq
 qxLoLs0txYP/SFIY26qlb8GI1/NFEB6R/PmH62XyqJ7WmyCE9pmHIt5BFgIj2EGNIpxeJEXxDT1
 WV35Fwe2hUdm44gdXi3FrGHQW+HzxhOHJ13ROQxhe8ILl6uOHzk5hmqD5mRBdsePHePu0THw0+Y
 KAuiacziGsz8a1B1eXEN39hbhEQGEQqA==
X-Received: by 2002:a05:600c:4e90:b0:477:582e:7a81 with SMTP id
 5b1f17b1804b1-48069c2a907mr103774265e9.4.1769702999460; 
 Thu, 29 Jan 2026 08:09:59 -0800 (PST)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edf62sm16762185f8f.13.2026.01.29.08.09.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 08:09:58 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 34/43] hw/pci: Add helper to insert PCIe extended capability at
 a fixed offset
Date: Thu, 29 Jan 2026 16:09:08 +0000
Message-ID: <20260129160917.1415092-35-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129160917.1415092-1-peter.maydell@linaro.org>
References: <20260129160917.1415092-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
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

Add pcie_insert_capability(), a helper to insert a PCIe extended
capability into an existing extended capability list at a caller
specified offset.

Unlike pcie_add_capability(), which always appends a capability to the
end of the list, this helper preserves the existing list ordering while
allowing insertion at an arbitrary offset.

The helper only validates that the insertion does not overwrite an
existing PCIe extended capability header, since corrupting a header
would break the extended capability linked list. Validation of overlaps
with other configuration space registers or capability-specific
register blocks is left to the caller.

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
Message-id: 20260126104342.253965-35-skolothumtho@nvidia.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/pci/pcie.c         | 69 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/pci/pcie.h |  2 ++
 2 files changed, 71 insertions(+)

diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index b302de6419..aa9024e532 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -1050,6 +1050,75 @@ static void pcie_ext_cap_set_next(PCIDevice *dev, uint16_t pos, uint16_t next)
     pci_set_long(dev->config + pos, header);
 }
 
+/*
+ * Insert a PCIe extended capability at a given offset.
+ *
+ * This helper only validates that the insertion does not overwrite an
+ * existing PCIe extended capability header, as corrupting a header would
+ * break the extended capability linked list.
+ *
+ * The caller must ensure that (offset, size) does not overlap with other
+ * registers or capability-specific register blocks. Overlaps with
+ * capability-specific registers are not checked and are considered a
+ * user-controlled override.
+ *
+ * Note: Best effort helper. The PCIe spec does not require extended
+ * capabilities to be ordered, but most devices use a forward-linked list.
+ * Devices that do not consistently use a forward-linked list may cause
+ * insertion to fail.
+ */
+bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
+                            uint16_t offset, uint16_t size)
+{
+    uint16_t pos = PCI_CONFIG_SPACE_SIZE, prev = 0;
+    uint32_t header;
+
+    assert(pci_is_express(dev));
+
+    if (!QEMU_IS_ALIGNED(offset, PCI_EXT_CAP_ALIGN) ||
+        size < 8 ||
+        offset < PCI_CONFIG_SPACE_SIZE ||
+        offset >= PCIE_CONFIG_SPACE_SIZE ||
+        offset + size > PCIE_CONFIG_SPACE_SIZE) {
+        return false;
+    }
+
+    header = pci_get_long(dev->config + pos);
+    if (!header) {
+        /* No extended capability present, insertion must be at the ECAP head */
+        if (offset != pos) {
+            return false;
+        }
+        pci_set_long(dev->config + pos, PCI_EXT_CAP(cap_id, cap_ver, 0));
+        goto out;
+    }
+
+    while (header && pos && offset >= pos) {
+        uint16_t next = PCI_EXT_CAP_NEXT(header);
+
+        /* Reject insertion inside an existing ECAP header (4 bytes) */
+        if (offset < pos + PCI_EXT_CAP_ALIGN) {
+            return false;
+        }
+
+        prev = pos;
+        pos = next;
+        header = pos ? pci_get_long(dev->config + pos) : 0;
+    }
+
+    pci_set_long(dev->config + offset, PCI_EXT_CAP(cap_id, cap_ver, pos));
+    if (prev) {
+        pcie_ext_cap_set_next(dev, prev, offset);
+    }
+
+out:
+    /* Make capability read-only by default */
+    memset(dev->wmask + offset, 0, size);
+    memset(dev->w1cmask + offset, 0, size);
+    /* Check capability by default */
+    memset(dev->cmask + offset, 0xFF, size);
+    return true;
+}
 /*
  * Caller must supply valid (offset, size) such that the range wouldn't
  * overlap with other capability or other registers.
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index c880ae1e04..d68bfa6257 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -133,6 +133,8 @@ uint16_t pcie_find_capability(PCIDevice *dev, uint16_t cap_id);
 void pcie_add_capability(PCIDevice *dev,
                          uint16_t cap_id, uint8_t cap_ver,
                          uint16_t offset, uint16_t size);
+bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t cap_ver,
+                            uint16_t offset, uint16_t size);
 void pcie_sync_bridge_lnk(PCIDevice *dev);
 
 void pcie_acs_init(PCIDevice *dev, uint16_t offset);
-- 
2.43.0


