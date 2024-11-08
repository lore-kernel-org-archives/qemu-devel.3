Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A81ED5C0EF
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 15:44:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9R8M-0002CP-TH; Fri, 08 Nov 2024 10:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8L-0002CC-3S
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:49 -0500
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1t9R8J-0005H3-Ig
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 10:42:48 -0500
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-71e52582cf8so1902751b3a.2
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 07:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731080566; x=1731685366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QxmRUlMoi7S4/7eFiKj9UJtfcRvcjfOPXhSE6dH7PHU=;
 b=YOQ4T6FIdorQ+s59FtNJovrYWkno843FoLEtYfkwj/skYq6xj18jICh9GPfJHJjwvc
 aFCwt7P9LoPktklGbrEWFBOEUQ3LcSP2vH4rd7HrMD2/6QTBodv9yEVazP40TOUcc8Le
 I9S1t8JgvexahSH5VkYeRNhX+PdCpzqPA9sw079iXwq5DojKpps/12R6aoQXgiMD6t+7
 CE/JFLPF0uIy3PgKlGOZvnb1/5LY6CTuRSrb+nJunHvFqJqaJdxsYgHMJ9ItrqylMD9k
 q6tNXbXRGEGb6gnyxBc0Kf9wPNzx8hjRe6NwcYSlUqCm3aUWlmnK17v15qIXjRXEo7h/
 K5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731080566; x=1731685366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QxmRUlMoi7S4/7eFiKj9UJtfcRvcjfOPXhSE6dH7PHU=;
 b=S84HOu7Fl+GT4uyjt5Lkn7Hqe/KcrCiCdZUKiqi+KpD8+NO4t3iNLxjdHogARuOsn8
 4BjDGv57osxi4lU6M6M7UN2VEl6rTee+k8IyvZPSBFeB06FEGSiKloB7V2B8Rdp4wKfq
 F/F1GJ2JFEh1bkiwN5/ADSwqjI84LnR9VIWVgpXGyoIQTcYkNULbxesskOU3e9qoSe1M
 tpH+zBs4e8Xc8lKYiMMWBKgw5scnzncDBhBDfYdJ/UyKv8nJry7tnZF5H/pDdWmDcy8I
 b6BACm3w+mNLolZR9bXDiA+pNATNZAA8vdWkRjUWthSZPxmKIdRUtCGSnuE7f8Abu9i1
 agaQ==
X-Gm-Message-State: AOJu0Yzae8cCbISmIjGMLNttoGTOTOtq2E/E54alnsQuFhg3wodmGOSW
 TnJDOOb4UGr6aZiSNY0g9bN6uVA3fFZMnvRzJE+tMKWmOQK2gjA2xeHqCA==
X-Google-Smtp-Source: AGHT+IGE1qzR0q0Jmc/he8szERQxzQ6kXiDuo7+FtMnEUwk9jLd33jyDjWncmE1uqoEhzwd9ZeXszw==
X-Received: by 2002:a05:6a20:a10e:b0:1db:ebf4:2cb8 with SMTP id
 adf61e73a8af0-1dc22b38e98mr4198376637.38.1731080565838; 
 Fri, 08 Nov 2024 07:42:45 -0800 (PST)
Received: from wheely.local0.net (124-171-217-17.tpgi.com.au. [124.171.217.17])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f48d32bsm3110444a12.17.2024.11.08.07.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 07:42:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Subject: [RFC PATCH 2/5] qtest/libqos/pci: Fix msix_enable sharing bar0
Date: Sat,  9 Nov 2024 01:42:25 +1000
Message-ID: <20241108154229.263097-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108154229.263097-1-npiggin@gmail.com>
References: <20241108154229.263097-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
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

Keep track of each the BAR iomaps for each device and add code in msix
to use existing iomap if the msix bars are already mapped.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/pci.h |  1 +
 tests/qtest/libqos/pci.c | 22 ++++++++++++++++------
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 9dc82ea723..5a7b2454ad 100644
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
index a42ca08261..45199c7dc4 100644
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
 
@@ -315,10 +321,14 @@ void qpci_msix_disable(QPCIDevice *dev)
     qpci_config_writew(dev, addr + PCI_MSIX_FLAGS,
                                                 val & ~PCI_MSIX_FLAGS_ENABLE);
 
-    if (dev->msix_pba_bar.addr != dev->msix_table_bar.addr) {
+    if (dev->msix_pba_bar_iomap) {
+        dev->msix_pba_bar_iomap = false;
         qpci_iounmap(dev, dev->msix_pba_bar);
     }
-    qpci_iounmap(dev, dev->msix_table_bar);
+    if (dev->msix_table_bar_iomap) {
+        dev->msix_table_bar_iomap = false;
+        qpci_iounmap(dev, dev->msix_table_bar);
+    }
 
     dev->msix_enabled = 0;
     dev->msix_table_off = 0;
-- 
2.45.2


