Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 938CDC36013
	for <qemu-devel@archiver.kernel.org>; Sun, 30 Mar 2025 21:04:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tyzp3-0007kH-By; Sun, 30 Mar 2025 17:04:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyzp1-0007jo-DI
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 17:03:59 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakeshjb010@gmail.com>)
 id 1tyzoz-0007wK-Fg
 for qemu-devel@nongnu.org; Sun, 30 Mar 2025 17:03:59 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-223a7065ff8so51721315ad.0
 for <qemu-devel@nongnu.org>; Sun, 30 Mar 2025 14:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743368635; x=1743973435; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XRt6bFBPlykpz723Z4IdFPu1RwRGPt4kx4foOoe7ogY=;
 b=RbhT3unuipBujCoO/YUFp2H2JC153VXTcL6T3xUE2VwSKpol5+hFiwonj4yz86JTGz
 1GJN41eU/b/NPOedv3AhiIgETyCuzQ44sBxHUuGFS4RWGo53RwHRYRnmgDrvZYqKW+WL
 hJKGG7Rdfb2zXhzzO0s+pslNbaFdrbJxEcYY4VvDXw2rUvcinfqA56Y3t6lvDLFdU+Ih
 orMLJaqTjJNCeRd83NP0iZHYQudZaKGe6WPce4R/2tQk0fagjkEjGccVEEdP0jyMrwlp
 D97AlwAW9SHAb6WTROp/1ulZIvKJYfYQvugSgel41xfngCq9mCCw5x18aILQYaRBP6vl
 Xovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743368635; x=1743973435;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XRt6bFBPlykpz723Z4IdFPu1RwRGPt4kx4foOoe7ogY=;
 b=QLSe9l/6bKabj1OUIGaav/3hCWS5nzWcCaWgfTIrfZUjgVVJzbHNAv7a9r67u+JREG
 oQu2poVviPF6CJVI4KPef3rDIF0CFnxd8NN+ZHREZZMYOqRlRB0CwDjQIBOs/jMhuKKj
 Q6K/9443hp2eGhHgwCBOw6kBXExznSakGwPGExdPcaF9Dt1oAgbseIDxcZ294mzdcoZq
 LYuDOdQaMTMijJ/VZ2Z5/6QB+3KacN37HJ5wLI/gwLJFA79quCHgHmnT5WJJPb3MxTiR
 gUp+neCF5tioxXdo87SttFLd3UbUFs7nN6PfivWO/L8v/DoETqdJmA6QM6b/v74R98cK
 HQug==
X-Gm-Message-State: AOJu0YzjPDbpQu0d56UiryPiQVn5xOREmIXSZsIz15fzpG9m9eh0xUaC
 7YbDBbdrLG4F3exoryrsrt4/qsD32yQhlOyx7s1fUnQJlQsKFF8w7RcnTk4ZFZs=
X-Gm-Gg: ASbGncvgfgNDTsWXp2VY3IXsY0Z9iCTZ4TvMZk2MVQjWe9qrRkwX3JC0fUfeGaf2nd5
 YGx6aeABpWXnjCAdg7xy2+dP8lsfeYss0Ue7qYWUC2pua0IOuxxzK+tWscPlTZvsOpTHrFId2D6
 3NX0VH0eYPkJt7jeaG1t4gGQN1q23+xA4wl7jAXwmii41vOVdnxl8Mnt2n8OMN9zMGNZu9NVqTA
 fNnldMD3eE9VsFYf8TbEkUCgnVG+5kn2tSTnuk7DlhqKGXZHcJmoP/4J6UvpKxJxxX3FFCeCCw6
 mpVPmnV/znr9nbXjj0Fks5TTJzRDYlhgFXps8Jwpqcb4EzVping=
X-Google-Smtp-Source: AGHT+IFxQz7WKDrp95x+xNvrJkfE2SYBnj8nXI8jboAOZnyCMNcRMF39l/p1JfD2INOABIL5J6tIwA==
X-Received: by 2002:a05:6a20:c701:b0:1f5:8e54:9f10 with SMTP id
 adf61e73a8af0-2009f75b1b3mr11963350637.34.1743368635506; 
 Sun, 30 Mar 2025 14:03:55 -0700 (PDT)
Received: from blackjackal.. ([2409:40f4:2018:65c1:9e7e:5b0:1e97:7aae])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af93b6a08f7sm5218166a12.29.2025.03.30.14.03.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Mar 2025 14:03:55 -0700 (PDT)
From: Rakesh Jeyasingh <rakeshjb010@gmail.com>
To: qemu-devel@nongnu.org,
	philmd@linaro.org,
	thuth@redhat.com
Cc: pbonzini@redhat.com, balaton@eik.bme.hu, marcandre.lureau@redhat.com,
 rakeshjb010@gmail.com
Subject: [PATCH v3 1/2] hw/pci-host/gt64120: Fix endianness handling
Date: Mon, 31 Mar 2025 02:31:54 +0530
Message-ID: <20250330210155.74295-2-rakeshjb010@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250330210155.74295-1-rakeshjb010@gmail.com>
References: <20250330210155.74295-1-rakeshjb010@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=rakeshjb010@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

The GT-64120 PCI controller requires special handling where:
1. Host bridge(bus 0 ,device 0) must use native endianness
2. Other devices follow MByteSwap bit in GT_PCI0_CMD

Previous implementation accidentally swapped all accesses, breaking
host bridge detection (lspci -d 11ab:4620).

This patch:
- Removes gt64120_update_pci_cfgdata_mapping(), moving data_mem initialization
  to gt64120_realize()
- Adds custom read/write handlers
- Replace raw bit check with FIELD_EX32 for MByteSwap .
- Use extract32 for bus/device check (bus 0, device 0).
- Implement size-specific swaps (bswap16 for 2-byte, bswap32 for 4-byte)
  per MemoryRegionOps requirements.

Fixes: 145e2198 ("hw/mips/gt64xxx_pci: Endian-swap using PCI_HOST_BRIDGE MemoryRegionOps")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2826

Signed-off-by: Rakesh Jeyasingh <rakeshjb010@gmail.com>
---
 hw/pci-host/gt64120.c | 99 ++++++++++++++++++++++++++++---------------
 1 file changed, 65 insertions(+), 34 deletions(-)

diff --git a/hw/pci-host/gt64120.c b/hw/pci-host/gt64120.c
index d5c13a89b6..b6abfb1512 100644
--- a/hw/pci-host/gt64120.c
+++ b/hw/pci-host/gt64120.c
@@ -320,38 +320,6 @@ static void gt64120_isd_mapping(GT64120State *s)
     memory_region_transaction_commit();
 }
 
-static void gt64120_update_pci_cfgdata_mapping(GT64120State *s)
-{
-    /* Indexed on MByteSwap bit, see Table 158: PCI_0 Command, Offset: 0xc00 */
-    static const MemoryRegionOps *pci_host_data_ops[] = {
-        &pci_host_data_be_ops, &pci_host_data_le_ops
-    };
-    PCIHostState *phb = PCI_HOST_BRIDGE(s);
-
-    memory_region_transaction_begin();
-
-    /*
-     * The setting of the MByteSwap bit and MWordSwap bit in the PCI Internal
-     * Command Register determines how data transactions from the CPU to/from
-     * PCI are handled along with the setting of the Endianness bit in the CPU
-     * Configuration Register. See:
-     * - Table 16: 32-bit PCI Transaction Endianness
-     * - Table 158: PCI_0 Command, Offset: 0xc00
-     */
-
-    if (memory_region_is_mapped(&phb->data_mem)) {
-        memory_region_del_subregion(&s->ISD_mem, &phb->data_mem);
-        object_unparent(OBJECT(&phb->data_mem));
-    }
-    memory_region_init_io(&phb->data_mem, OBJECT(phb),
-                          pci_host_data_ops[s->regs[GT_PCI0_CMD] & 1],
-                          s, "pci-conf-data", 4);
-    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
-                                        &phb->data_mem, 1);
-
-    memory_region_transaction_commit();
-}
-
 static void gt64120_pci_mapping(GT64120State *s)
 {
     memory_region_transaction_begin();
@@ -645,7 +613,6 @@ static void gt64120_writel(void *opaque, hwaddr addr,
     case GT_PCI0_CMD:
     case GT_PCI1_CMD:
         s->regs[saddr] = val & 0x0401fc0f;
-        gt64120_update_pci_cfgdata_mapping(s);
         break;
     case GT_PCI0_TOR:
     case GT_PCI0_BS_SCS10:
@@ -1024,6 +991,65 @@ static const MemoryRegionOps isd_mem_ops = {
     },
 };
 
+static bool is_phb_dev0(const PCIHostState *phb)
+{
+    /*Checks if the current PCI configuration access targets the host bridge(bus 0, device 0)*/
+    return extract32(phb->config_reg, 11, 5/*dev*/ + 8/*bus*/) == 0;
+}
+
+static uint64_t gt64120_pci_data_read(void *opaque, hwaddr addr, unsigned size)
+{
+    GT64120State *s = opaque;
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    uint32_t val;
+    bool le_mode = FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD, MByteSwap);
+
+    if (!(phb->config_reg & (1 << 31))) {
+        val = 0xffffffff;
+    } else {
+        val = pci_data_read(phb->bus, phb->config_reg | (addr & 3), size);
+    }
+
+    /* Only swap for non-bridge devices in big-endian mode */
+    if (!le_mode && !is_phb_dev0(phb)) {
+        if (size == 2) {
+            val = bswap16(val);
+        } else if (size == 4) {
+            val = bswap32(val); 
+        }
+    }
+    return val;
+}
+
+static void gt64120_pci_data_write(void *opaque, hwaddr addr, 
+    uint64_t val, unsigned size)
+{
+    GT64120State *s = opaque;
+    PCIHostState *phb = PCI_HOST_BRIDGE(s);
+    bool le_mode = FIELD_EX32(s->regs[GT_PCI0_CMD], GT_PCI0_CMD, MByteSwap);
+
+    if (!le_mode && !is_phb_dev0(phb)) {
+        if (size == 2) {
+            val = bswap16(val);
+        } else if (size == 4) {
+            val = bswap32(val);
+        }
+    }
+    if (phb->config_reg & (1u << 31)){
+        pci_data_write(phb->bus, phb->config_reg | (addr & 3), val, size);
+    }
+}
+
+static const MemoryRegionOps gt64120_pci_data_ops = {
+    .read = gt64120_pci_data_read,
+    .write = gt64120_pci_data_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 4,
+    },
+};
+
 static void gt64120_reset(DeviceState *dev)
 {
     GT64120State *s = GT64120_PCI_HOST_BRIDGE(dev);
@@ -1178,7 +1204,6 @@ static void gt64120_reset(DeviceState *dev)
 
     gt64120_isd_mapping(s);
     gt64120_pci_mapping(s);
-    gt64120_update_pci_cfgdata_mapping(s);
 }
 
 static void gt64120_realize(DeviceState *dev, Error **errp)
@@ -1202,6 +1227,12 @@ static void gt64120_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGADDR << 2,
                                         &phb->conf_mem, 1);
 
+    memory_region_init_io(&phb->data_mem, OBJECT(phb),
+                          &gt64120_pci_data_ops,
+                          s, "pci-conf-data", 4);
+    memory_region_add_subregion_overlap(&s->ISD_mem, GT_PCI0_CFGDATA << 2,
+                                        &phb->data_mem, 1);
+
 
     /*
      * The whole address space decoded by the GT-64120A doesn't generate
-- 
2.43.0


