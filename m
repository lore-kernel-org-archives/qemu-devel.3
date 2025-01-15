Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79B77C02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 15:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tY4tm-0004FB-6K; Wed, 15 Jan 2025 10:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4tk-0004Ex-Q5; Wed, 15 Jan 2025 10:01:36 -0500
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tY4ti-0002u4-8S; Wed, 15 Jan 2025 10:01:36 -0500
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2ee50ffcf14so1650812a91.0; 
 Wed, 15 Jan 2025 07:01:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736953292; x=1737558092; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6QI+StavfES5vlYy9klhZaUtTtmII/hVb11fVMVfTA=;
 b=C1/L9VE8bHIjGYEShm9MxP/oAc1c7GseTkYFLSMx2fSjsfQsLQnZG6VVnFXlPbATGS
 eI3+EEzdCP6TX+yPmACcsSb0bivDjOGnCAcO15yQ7u4WsV0pMUrCmcD/aaQvfcSDfgl/
 1IvMD1vdkDu2Yw2n+CVix/Wl95Mkoqpd2yKsy0UdsLC9cs2TeGJGG/onvtHVWd5VK380
 jX8lpYeTIy6cJc5pp+OE1N25HIl+HUB4Wj+78rnS0mBRMylMYP3Nvi6tSS2E/xgRuqIp
 FLzTorUPCE+2sD/os90YV8DoWWnt/A5Wwo0J4HSW9ZKYxBxL6pb/lFdXeoY4m+Za9FND
 AO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736953292; x=1737558092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6QI+StavfES5vlYy9klhZaUtTtmII/hVb11fVMVfTA=;
 b=lzIIpRGcd4IZHuMUBIHjd7xKC1KzPiC2wlwBA94ntq6CgtCv+otdVa9WApYs0UbOsc
 /hZ6k/SdASKS7CpjFacpjEpoviRvwonHYqeamNdK5AZY/Nqt2MLLmPb3KLvCu1M30cHF
 kGcX4nN/Oio74HCqSL+ep/X7sQMjNLybq8pv2kzYyAR5qC4QoiCAoN8VGWvuqKP3izs4
 lc1dL4DBG1fz7dXfFAwr7WtPmEINRd+HSuGXZsstbInKrg19L4MKpwRCQN86L5tUrDnT
 XA52YpXl5htjLw4vQ2zYuazMmH+bHRbjGywXTetM0NGBagMOJge/STELOD7xxxja68TV
 qwig==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+LAo29EmgUYrXxjPd2SwTy6rhjvX1tL62H2gTPYD+VHuUbkBmqnwPLil/Q9DYwHn6+30eTv7ufSeW@nongnu.org
X-Gm-Message-State: AOJu0YwXReWQPelfcgVpS1CIVLltfxryM9Q/rDTyo9gy/ScFYvjn7WNM
 Tavu+wM+QhMsdVDp2Zvxts8fg/VKo9zNHQpJO/PPaoChZkGtK50TAJfw+A==
X-Gm-Gg: ASbGncu4UQv4mvc/c26ZB8IJuwexTLKShlxAzXlTEJ0ZSapb4FkV0JgpS8dMBANPVcQ
 6YLmMLO3LjGqj5XctBo6mRgkexkuvikP5r4q1zVsxChH+ZU8YDQ+IV1SGYHz5gZ0KwOfU96oqeD
 g4gUI23FA39j9+DFiTL03s3Eh5PnpQmU4jGQEiCtoYwsSt09Sei3YvZp1PdYZiOY+GlZCUs36sx
 VmK7S4VpQnsHz8ScutommzgQtOICWlyfLltIdAbm8k27k0jSjkxkpCjkY2tcw==
X-Google-Smtp-Source: AGHT+IHDYgdrnuyIKi1Ffq+jXsk5UJh/wQ3U5IhAFNbKCBdAgNez/up0T5A72BS4aTMoR2futqTNKQ==
X-Received: by 2002:a05:6a00:a0d:b0:726:a820:921d with SMTP id
 d2e1a72fcca58-72d8c6fcf40mr5240177b3a.10.1736953291904; 
 Wed, 15 Jan 2025 07:01:31 -0800 (PST)
Received: from wheely.local0.net ([118.210.104.29])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40658a7esm9519592b3a.106.2025.01.15.07.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jan 2025 07:01:31 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, qemu-block@nongnu.org
Subject: [PATCH v2 2/5] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Date: Thu, 16 Jan 2025 01:01:08 +1000
Message-ID: <20250115150112.346497-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250115150112.346497-1-npiggin@gmail.com>
References: <20250115150112.346497-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102c.google.com
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

Devices where the MSI-X addresses are shared with other MMIO on BAR0
can not use msi_enable because it unmaps and remaps BAR0, which
interferes with device MMIO mappings. xhci-nec is one such device we
would like to test msix with.

Use the BAR iomap tracking structure introduced in the previous change
to have qpci_misx_enable() use existing iomaps if msix bars are
already mapped.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h |  1 +
 tests/qtest/libqos/pci.c | 40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 9dc82ea723a..5a7b2454ad5 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -68,6 +68,7 @@ struct QPCIDevice
     bool bars_mapped[6];
     QPCIBar bars[6];
     bool msix_enabled;
+    bool msix_table_bar_iomap, msix_pba_bar_iomap;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
 };
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index a42ca08261d..023c1617680 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -288,15 +288,21 @@ void qpci_msix_enable(QPCIDevice *dev)
 
     table = qpci_config_readl(dev, addr + PCI_MSIX_TABLE);
     bir_table = table & PCI_MSIX_FLAGS_BIRMASK;
-    dev->msix_table_bar = qpci_iomap(dev, bir_table, NULL);
+    if (dev->bars_mapped[bir_table]) {
+        dev->msix_table_bar = dev->bars[bir_table];
+    } else {
+        dev->msix_table_bar_iomap = true;
+        dev->msix_table_bar = qpci_iomap(dev, bir_table, NULL);
+    }
     dev->msix_table_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
 
     table = qpci_config_readl(dev, addr + PCI_MSIX_PBA);
     bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
-    if (bir_pba != bir_table) {
-        dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
+    if (dev->bars_mapped[bir_pba]) {
+        dev->msix_pba_bar = dev->bars[bir_pba];
     } else {
-        dev->msix_pba_bar = dev->msix_table_bar;
+        dev->msix_pba_bar_iomap = true;
+        dev->msix_pba_bar = qpci_iomap(dev, bir_pba, NULL);
     }
     dev->msix_pba_off = table & ~PCI_MSIX_FLAGS_BIRMASK;
 
@@ -307,6 +313,7 @@ void qpci_msix_disable(QPCIDevice *dev)
 {
     uint8_t addr;
     uint16_t val;
+    uint32_t table;
 
     g_assert(dev->msix_enabled);
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
@@ -315,10 +322,31 @@ void qpci_msix_disable(QPCIDevice *dev)
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
                                                 val & ~PCI_MSIX_FLAGS_ENABLE);
 
-    if (dev->msix_pba_bar.addr != dev->msix_table_bar.addr) {
+    if (dev->msix_pba_bar_iomap) {
+        dev->msix_pba_bar_iomap = false;
         qpci_iounmap(dev, dev->msix_pba_bar);
+    } else {
+        /*
+         * If we had reused an existing iomap, ensure it is still mapped
+         * otherwise it would be a bug if it were unmapped before msix is
+         * disabled. A refcounting iomap implementation could avoid this
+         * issue entirely, but let's wait until that's needed.
+         */
+        uint8_t bir_pba;
+        table = qpci_config_readl(dev, addr + PCI_MSIX_PBA);
+        bir_pba = table & PCI_MSIX_FLAGS_BIRMASK;
+        g_assert(dev->bars_mapped[bir_pba]);
+    }
+
+    if (dev->msix_table_bar_iomap) {
+        dev->msix_table_bar_iomap = false;
+        qpci_iounmap(dev, dev->msix_table_bar);
+    } else {
+        uint8_t bir_table;
+        table = qpci_config_readl(dev, addr + PCI_MSIX_TABLE);
+        bir_table = table & PCI_MSIX_FLAGS_BIRMASK;
+        g_assert(dev->bars_mapped[bir_table]);
     }
-    qpci_iounmap(dev, dev->msix_table_bar);
 
     dev->msix_enabled = 0;
     dev->msix_table_off = 0;
-- 
2.45.2


