Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A138C369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:43:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36DX-0003Xk-9e; Fri, 11 Apr 2025 00:42:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DT-0003Rl-D0; Fri, 11 Apr 2025 00:42:13 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DR-0001gY-RO; Fri, 11 Apr 2025 00:42:11 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-227d6b530d8so15726585ad.3; 
 Thu, 10 Apr 2025 21:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346528; x=1744951328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2cWVx1L0woS82QKvU4U4iEBvVwH0DB4IYMt1yOjho04=;
 b=R4Dw5aJZAQUMSeGYsM8eREWbNlEl5lyimIkLufr4KVECs/x8LHMlo94L2PeHKdJQwr
 GEMcjst2SjPRHBfhtNK8f9m8h7sbuhQQrgmcc7OLPzwUgC8Ef+pl9qA73yCtboliqr4G
 +L3MNu4EP80xbGpQgud6piBdXygGMfDp0RrsSuW8xUrgx9PVGWusDdVkhx/7eU+R7ZOL
 rSQjK+BLFE6I1R57tqHc62SL40jTTy7vGqzK+zxFNkP+FtBZLhu8lc+jDxQk/rKs48lO
 LBkbUSW4ott1oxboSI88rUE4NLrupfBLzjQRK1YJfW10lI7edIWkz2b048I+vcANE6hT
 gENg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346528; x=1744951328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2cWVx1L0woS82QKvU4U4iEBvVwH0DB4IYMt1yOjho04=;
 b=Q6Ho2nEW3s9mLT81s24GKWrlzWLtKTPe7PgWOzp9yTLq1RKFZtGHVM7o9JdEhGNTmu
 gQG8nHwqor/SVC2PxLPjg8o8O4ZaqpLASwb8rch73IRNZYfV5WT1vp0uFtrs1AF5gQ8J
 VGyY7r5vzWkR2L69CDclknlG+KQIq7hOzemFC3cNp2O0qSU+JaDn7jIgHo4NTbQ34+Fs
 32OcqsXgyMZL5sLFoGVY2Xbg3ZWWon88xbeUMluQn2nRfjW4qB847QNrgoa1HdiZc1uk
 lp3BO14PvI1XUZtr0jB6MhfYOOTFd6d9XjzzmWOS81YXnvT8YWylh+RXNHID12afBHAE
 jpkQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhaY1ofdoq3vsGDw5ZJDnIZ4woyE+Lqja+qdcd/985IIiiTHMMw7Tlkg2A0jfnfm+IL68I0GZ5zoMI@nongnu.org
X-Gm-Message-State: AOJu0YzmZtLLQ3kCum/fjob2F7d2iwyk19qoYRp26yITXFEmmABdBMf3
 3G/dsFLS8b001jgkM3bYXBGKHJiclqtuk9FpYgBzYOHDNUp5pbvIaSjV8w==
X-Gm-Gg: ASbGncuZz+bhxNRS5r99hJqPrzDTqiiP2b/2NXezSkw0VIg8JMmcyHwktGVdpW4KeV9
 gjdvb0LPmy9XHGJGNsiadvYG6gJpDUcaZEfbgQdWJPwtH8+xYkqBvxn5IOeJLPP1WSb8hceiBUV
 0RaaqFi0WUJFcrwk3N1YTs3pTo9ZOhtlJfBDXaPm6OCWW9DhzJRGU4Rn+CKAT1CCm8G6AsC/NPY
 v/tNUeYL9kXV3v8SJll6wJVOJrFNLrwzbh7dsV7XElAJEpXUgaY3WMGWdK+zheyG6CG1gE4f+gY
 noJP2BJY5swdGM+kzLnoO2YuE7Pl1GJ7j263VMZrCMrL
X-Google-Smtp-Source: AGHT+IGtcmZCX7jmNC79i/P2dbOn1HjNSrHk2RiHVwewma4209dyW3AzvopyySFuksCOIsR9K62fRw==
X-Received: by 2002:a17:902:da91:b0:220:f7bb:842 with SMTP id
 d9443c01a7336-22bea4efafamr18183435ad.42.1744346527825; 
 Thu, 10 Apr 2025 21:42:07 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:42:07 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, Fabiano Rosas <farosas@suse.de>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
Subject: [PATCH v4 6/7] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Date: Fri, 11 Apr 2025 14:41:28 +1000
Message-ID: <20250411044130.201724-7-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411044130.201724-1-npiggin@gmail.com>
References: <20250411044130.201724-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x633.google.com
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
would like to test with msix.

Use the BAR iomap tracking structure introduced in the previous change
to have qpci_misx_enable() use existing iomaps if msix bars are
already mapped.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h |  1 +
 tests/qtest/libqos/pci.c | 40 ++++++++++++++++++++++++++++++++++------
 2 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 5c7ebad4270..d334d9c0837 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -75,6 +75,7 @@ struct QPCIDevice
     bool bars_mapped[QPCI_NUM_REGIONS];
     QPCIBar bars[QPCI_NUM_REGIONS];
     bool msix_enabled;
+    bool msix_table_bar_iomap, msix_pba_bar_iomap;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
 };
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 02d88acd500..72adf81ddd6 100644
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
2.47.1


