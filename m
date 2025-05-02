Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A38FC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgiq-00029B-LE; Thu, 01 May 2025 23:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgin-000248-NO; Thu, 01 May 2025 23:05:53 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgil-0000co-Po; Thu, 01 May 2025 23:05:53 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso2400366b3a.2; 
 Thu, 01 May 2025 20:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155149; x=1746759949; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8VLYjH2+L+2Qg1nSwJ1zvQjbci9GKYgTGLD6Z6MI90U=;
 b=it007pE05u3WT12duwIhLKVc2HIlacAy/3+j91hvfPolTl3zacZp9IFRb/IZiZWtqw
 JZ9jGAXzz+g5YnlOLHrIgAccRRhAbS1IUtL2H3daQOdZaO//XFmF7s/IzXkaTiY/ePdb
 Qr7OJYMzY7qXdDxThqrKlgGvlkzAUeeBp4WzztWc5Q87bsmp4QiI23qso5YpmbSzMwWG
 l7XodWrE4Rx4dlj+JNAjzJOnPF+WnnQ3yERBrVl2XeD33p+NC73NSVxwIwiZJqv9X3SX
 YyExc1VVO0OLcvCd8wzuShQnPn260pR5XqhnSfP/MwZVltE5pnb2A+pFemEG1xoJxFK0
 pG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155149; x=1746759949;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8VLYjH2+L+2Qg1nSwJ1zvQjbci9GKYgTGLD6Z6MI90U=;
 b=UK9TJtqF7LK1hp4dCxTXsnTAT8nz6QfM4juqroP6AcRBF5OGmobOVe+RZKJfPdlup4
 OGRbt+VYUZFS9NzaUYL4i+wGtJcyFGKzRMUlk28p+DUYuJD6WEl4/XJUbzTEU/n7Erda
 FZ3G1MgRItYMW+QB06tAF8UffYsrF5ZwLp8MTYNGBAzuQ3/NOK+KvgqvXPTA1e27VC4Q
 T3L+OGsB00Dk/Zxl+GXsiB9UUl6k+UV6hiNCq2pVGNEn5YTtt3zWJpEqgUZW7WVG/uF/
 5GUIjzeuNaCAk8F5IBmkFl8bGocPvt6Per6A1qzl1kO1a7kN8V82OAxZlR81rvrtz6E0
 4neg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVeImx/dEZia8hGMEEjWWt/TdECkDAb14NWOOjjxzcBPVJJFBEgr7Kl3GXqnE1rGcu/2mn0hKxSPKWh@nongnu.org,
 AJvYcCWnIwg5yXI1Guxc9ZvICLV3dfD6GM10q1l+suqiwV8qEjj/eP7Vb1HZfjU2/1kRL8BAc9DawJZA1Ho=@nongnu.org
X-Gm-Message-State: AOJu0YytXuQ2EK8CUr0RW+Q/z1MsNjvPhTMmcZMPZBQ9dIKc9yBmXR6D
 P6uz5ePxpX2Dd/wG2kyMiydhb9zZAfQJoujpXPJQSidUAx7O0p0HeD7+Eg==
X-Gm-Gg: ASbGncsZ2zhca+pPgstqs486UrGhSZLOchXeOTf0Ya5gLcFV/CMfpsx+obthX48WGwj
 greXc8+prE3w5DjAe6hzfaXJIHnoipPU3F2FMzEf6OeoAOYODgNniwWSvP8KEnG9JountbFI2r+
 fTL7Ww8hB14k1c2xPwrFSe0wyBz/ndy9MEvA/mZMaI+MS1rZY/oiyaZx+H0So1gLxmXqkFowHJb
 GdDQiVZJSn9lHQc/vfQLAfZEhwd9o6pJ3XruD64JOyipKvHfXvPqTE3dy/HD0k+cBFxx/O8/d7T
 gT+P5/52u6tAiK9Yrj41K9ak3+D/LBLX60RYZ0Bkb/Y6
X-Google-Smtp-Source: AGHT+IE61ncXhT0vFkJuSeNbhL9AtY79R1JopNpnSsYkTnhyHOB2Oc2Om5w3FQdfKUUG6tjovDsUlg==
X-Received: by 2002:a05:6a00:1bc6:b0:736:46b4:bef2 with SMTP id
 d2e1a72fcca58-74058a20a33mr1678534b3a.6.1746155149308; 
 Thu, 01 May 2025 20:05:49 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:48 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
Subject: [PATCH v5 09/11] qtest/libqos/pci: Enforce balanced iomap/unmap
Date: Fri,  2 May 2025 13:04:43 +1000
Message-ID: <20250502030446.88310-10-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

Add assertions to ensure a BAR is not mapped twice, and that only
previously mapped BARs are unmapped. This can help catch bugs and
fragile coding.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h |  9 +++++++
 tests/qtest/libqos/pci.c | 51 ++++++++++++++++++++++++++++++++++++----
 2 files changed, 55 insertions(+), 5 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 19f1dd13501..a51bf60620f 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -60,10 +60,19 @@ struct QPCIBar {
     bool is_io;
 };
 
+/*
+ * hw/pci permits 7 (PCI_NUM_REGIONS) regions, the last for PCI_ROM_SLOT.
+ * libqos does not implement PCI_ROM_SLOT at the moment, and as such it
+ * permits 6.
+ */
+#define QPCI_NUM_REGIONS 6
+
 struct QPCIDevice
 {
     QPCIBus *bus;
     int devfn;
+    bool bars_mapped[QPCI_NUM_REGIONS];
+    QPCIBar bars[QPCI_NUM_REGIONS];
     bool msix_enabled;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index de95329e486..694f1458f46 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -79,12 +79,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
 void qpci_device_init(QPCIDevice *dev, QPCIBus *bus, QPCIAddress *addr)
 {
     uint16_t vendor_id, device_id;
+    int i;
 
     qpci_device_set(dev, bus, addr->devfn);
     vendor_id = qpci_config_readw(dev, PCI_VENDOR_ID);
     device_id = qpci_config_readw(dev, PCI_DEVICE_ID);
     g_assert(!addr->vendor_id || vendor_id == addr->vendor_id);
     g_assert(!addr->device_id || device_id == addr->device_id);
+
+    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
+        g_assert(!dev->bars_mapped[i]);
+    }
 }
 
 static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
@@ -549,21 +554,31 @@ void qpci_memwrite(QPCIDevice *dev, QPCIBar token, uint64_t off,
     dev->bus->memwrite(dev->bus, token.addr + off, buf, len);
 }
 
-QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
+static uint8_t qpci_bar_reg(int barno)
 {
-    QPCIBus *bus = dev->bus;
     static const int bar_reg_map[] = {
         PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
         PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
     };
+
+    g_assert(barno >= 0 && barno <= QPCI_NUM_REGIONS);
+
+    return bar_reg_map[barno];
+}
+
+QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
+{
+    QPCIBus *bus = dev->bus;
     QPCIBar bar;
     int bar_reg;
     uint32_t addr, size;
     uint32_t io_type;
     uint64_t loc;
 
-    g_assert(barno >= 0 && barno <= 5);
-    bar_reg = bar_reg_map[barno];
+    g_assert(barno >= 0 && barno <= QPCI_NUM_REGIONS);
+    g_assert(!dev->bars_mapped[barno]);
+
+    bar_reg = qpci_bar_reg(barno);
 
     qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
     addr = qpci_config_readl(dev, bar_reg);
@@ -606,12 +621,34 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     }
 
     bar.addr = loc;
+
+    dev->bars_mapped[barno] = true;
+    dev->bars[barno] = bar;
+
     return bar;
 }
 
 void qpci_iounmap(QPCIDevice *dev, QPCIBar bar)
 {
-    /* FIXME */
+    int bar_reg;
+    int i;
+
+    g_assert(bar.addr);
+
+    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
+        if (!dev->bars_mapped[i]) {
+            continue;
+        }
+        if (dev->bars[i].addr == bar.addr) {
+            dev->bars_mapped[i] = false;
+            memset(&dev->bars_mapped[i], 0, sizeof(dev->bars_mapped[i]));
+            bar_reg = qpci_bar_reg(i);
+            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
+            /* FIXME: the address space is leaked */
+            return;
+        }
+    }
+    g_assert_not_reached(); /* device was not iomap()ed */
 }
 
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
@@ -622,6 +659,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
 
 void qpci_migrate_fixup(QPCIDevice *to, QPCIDevice *from)
 {
+    memcpy(to->bars_mapped, from->bars_mapped, sizeof(from->bars_mapped));
+    memset(from->bars_mapped, 0, sizeof(from->bars_mapped));
+    memcpy(to->bars, from->bars, sizeof(from->bars));
+    memset(from->bars, 0, sizeof(from->bars));
 }
 
 void add_qpci_address(QOSGraphEdgeOptions *opts, QPCIAddress *addr)
-- 
2.47.1


