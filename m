Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A649CC28B23
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 20:41:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqeV6-0004fk-TJ; Fri, 07 Mar 2025 15:40:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tqeUj-0004R5-2m
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:40:37 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jason.chien@sifive.com>)
 id 1tqeUg-0001wn-Mj
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 15:40:32 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2ff80290e44so2233404a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 12:40:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1741380029; x=1741984829; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ohIL3BV/104Xh7k2LK2qauY0LQOX7g9NVibMeK73rWw=;
 b=iKDatbPkWhloT8eiSVVqPgSX4g+PdBwKJUPPTfzSgCM3Bd2A1YElwIkOlFxcslY4m5
 lT2VHt0juxfjn7C0OeYnXnofCxxlWM40nR5dFsl6myXbHa96/GZYED3VxyiImxVVF2jx
 ZNmZYcv9mRB2OBPbIgvVosNfHxfQQJKCF0rr23EXnOZ85pq2ZJL2x45Jo5AzlaotuoDL
 OaorC9EE1KgDg7mTdWwkvXwo5+PGLTvHtY/eCNpPml616NLVGM+A8C33k5RuW6tOL7Nx
 N9TNgRVCB3MpgY34WnddRdgJZuXb2lpcF+1tjx7ytHCRDOUBN06HWGqhrK4rfpiBBFew
 hPhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741380029; x=1741984829;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ohIL3BV/104Xh7k2LK2qauY0LQOX7g9NVibMeK73rWw=;
 b=SmWzgtYOK+ws3NhzyXUI/Xjm5N+J7a8MtzmFM+KTHzCkymNkv8o1CKMdu+XmZkVn6S
 YEkl5w6sguZIAgSWv2CdVJe4o9NEqKN+49Qt/0CrwKAeH1KK8pmm/DIU3+QXYSVxaFa/
 4AEtba2X9SYpRecYYDDVIGXHBOL2hUukwEGf9Y0QWCZe6+WiUc2cNkB3pwH8sqlRUGSh
 S9/kWDQIyOZyAkgdQjNBqJcm3WuI/7D/yv5IrwuDPGrfCZSWl346eKv+GPtwt0fTyeMW
 Wck0Ffr6BW8wbLJ15hMYdufKLM6NAvk7dxwLCikZx9WdgnHuNqsevwUbVwiffl2hQ7X3
 R7Vg==
X-Gm-Message-State: AOJu0YxGn4ogUEUTuuVsF2TSVkrCJ/963s+qrpErGbUTaq5rd+ImGMPw
 GXRfedjSyfUEwGnTGd4K3XRW7qiymIkS+G/q8nGFxFJioHCP9XE7ePsbACn9CV8PQwVK2l/nTAv
 czS+OMyS6sOkUw7NotNnwn7v3IYVHbjb7Y+iJmp+aU8MKTOam77UeXbeJvCOBtjEGR06T3n6A28
 BYvfvV7SBeCALtk4/539wVYOViK9hnTyTVEdgJR2k=
X-Gm-Gg: ASbGncuZw7U9mshFjlFUh70Fn707FmmVpDA8+dEfC2NiH3u0JCwTu3mHaTnIcLmJQbu
 o3B+uzBKF8PnF6tzrETTpSXLdW0qy4ryZ1eudlM1eELVXJDM9PTv5NTn1PYhMKQ60WBF2vtq66G
 +iO2jY9eh+HfcOJq0mDGXZK/X7mXMxoWnX1ILPR3ZS32umXlt2Nfxr1CRXobLChg0x//E6iLOB2
 XBVYjH5wDtTggzqYAJjo3F2FFiKDvSlrroHwdDs44kpQ6j3oojTbGxFYDT4+sZKx85s+/e5NiIM
 4WJ4WMUFxXDlcIKzWb+tX2kWpJzyNpzhJI10Qa61wDBmkpCYD0V1Kr1qJ0Xza2GShUui9wiq
X-Google-Smtp-Source: AGHT+IFk3jj2iAPKHY4isBHv3wjs/MjcPMcFZrxkF8h9RElGBzhuzD4hijmzclDd+QFr/KqNCz38ag==
X-Received: by 2002:a17:90b:2d83:b0:2ff:64a0:4a58 with SMTP id
 98e67ed59e1d1-2ff7cf14552mr6416174a91.22.1741380028710; 
 Fri, 07 Mar 2025 12:40:28 -0800 (PST)
Received: from hsinchu16.internal.sifive.com ([210.176.154.34])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff5aa3d3ccsm3270900a91.0.2025.03.07.12.40.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 12:40:28 -0800 (PST)
From: Jason Chien <jason.chien@sifive.com>
To: qemu-devel@nongnu.org,
	qemu-riscv@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Andrey Smirnov <andrew.smirnov@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 qemu-arm@nongnu.org (open list:MCIMX7D SABRE / i...),
 Jason Chien <jason.chien@sifive.com>
Subject: [PATCH 3/4] hw/pci-host/designware: Implement
 PCIIOMMUOps.set_downstream_mr()
Date: Sat,  8 Mar 2025 04:39:36 +0800
Message-ID: <20250307203952.13871-4-jason.chien@sifive.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20250307203952.13871-1-jason.chien@sifive.com>
References: <20250307203952.13871-1-jason.chien@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=jason.chien@sifive.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The original DesignWare PCIe host implementation could not connect with
an IOMMU, as both attempted to register PCIIOMMUOps.

This commit resolves the conflict by hooking PCIIOMMUOps.set_downstream_mr()
through designware_pcie_host_set_mr(), allowing the IOMMU to designate the
PCIe host's downstream memory region via pci_setup_iommu_downstream_mr()
without competing for PCIIOMMUOps.

Signed-off-by: Jason Chien <jason.chien@sifive.com>
---
 hw/pci-host/designware.c         | 18 +++++++++++++++---
 include/hw/pci-host/designware.h |  2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index c07740bfaa..fafbf90259 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -404,7 +404,6 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 {
     DesignwarePCIERoot *root = DESIGNWARE_PCIE_ROOT(dev);
     DesignwarePCIEHost *host = designware_pcie_root_to_host(root);
-    MemoryRegion *host_mem = get_system_memory();
     MemoryRegion *address_space = &host->pci.memory;
     PCIBridge *br = PCI_BRIDGE(dev);
     DesignwarePCIEViewport *viewport;
@@ -445,7 +444,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
         viewport->cr[0]   = DESIGNWARE_PCIE_ATU_TYPE_MEM;
 
         source      = &host->pci.address_space_root;
-        destination = host_mem;
+        destination = &host->bridge_mr;
         direction   = "Inbound";
 
         /*
@@ -470,7 +469,7 @@ static void designware_pcie_root_realize(PCIDevice *dev, Error **errp)
 
         destination = &host->pci.memory;
         direction   = "Outbound";
-        source      = host_mem;
+        source      = get_system_memory();
 
         /*
          * Configure MemoryRegion implementing CPU -> PCI memory
@@ -675,8 +674,16 @@ static AddressSpace *designware_pcie_host_set_iommu(PCIBus *bus, void *opaque,
     return &s->pci.address_space;
 }
 
+static void designware_pcie_host_set_mr(void *opaque, MemoryRegion *mr)
+{
+    DesignwarePCIEHost *s = DESIGNWARE_PCIE_HOST(opaque);
+
+    memory_region_add_subregion_overlap(&s->bridge_mr, 0, mr, INT32_MAX);
+}
+
 static const PCIIOMMUOps designware_iommu_ops = {
     .get_address_space = designware_pcie_host_set_iommu,
+    .set_downstream_mr = designware_pcie_host_set_mr,
 };
 
 static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
@@ -713,6 +720,11 @@ static void designware_pcie_host_realize(DeviceState *dev, Error **errp)
                                      TYPE_DESIGNWARE_PCIE_ROOT_BUS);
     pci->bus->flags |= PCI_BUS_EXTENDED_CONFIG_SPACE;
 
+    memory_region_init(&s->bridge_mr, OBJECT(s),
+                       "pcie-bus-bridge-memory", UINT64_MAX);
+    memory_region_add_subregion(&s->bridge_mr, 0x0, get_system_memory());
+    address_space_init(&s->bridge_as, &s->bridge_mr, "pcie-bus-bridge-space");
+
     memory_region_init(&s->pci.address_space_root,
                        OBJECT(s),
                        "pcie-bus-address-space-root",
diff --git a/include/hw/pci-host/designware.h b/include/hw/pci-host/designware.h
index a35a3bd06c..30f1598dbe 100644
--- a/include/hw/pci-host/designware.h
+++ b/include/hw/pci-host/designware.h
@@ -97,6 +97,8 @@ struct DesignwarePCIEHost {
     } pci;
 
     MemoryRegion mmio;
+    AddressSpace bridge_as;
+    MemoryRegion bridge_mr;
 };
 
 #endif /* DESIGNWARE_H */
-- 
2.43.2


