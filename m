Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06DCE77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 07:43:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNoho-0007jS-0s; Wed, 18 Dec 2024 02:42:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohm-0007jK-Nq
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:42:50 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohk-0006hY-KQ
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:42:50 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-728eedfca37so6321322b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 23:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734507767; x=1735112567; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bRTDyBdfnK9kAprnP+Hh3qG7LUon4ziNP1QIA/V4/Ww=;
 b=OkhgyRatjPJGOAUol+614WJ5NEiWOoyp4dZPqK6VguJfjgwBQOYmaCwZmt67nxqa+x
 QiWsAKSA0ZFkU/7pndK0BvjbUIjM6vhMLaLJ2F0f2fmWRYQj3OkVV+8JG+diWTQArI3z
 fuPXLdo+Bn3VGSrGw2eMVsc4PukodPGf1n7w2eTMe5zPy2wFxFRbv6Lw6srTbosEJAbu
 7w89T7NnnBWD7Rsu+I5Rc7+96vgNz1YcpITxWvipSHd9fGojfFr5J67k5zU0g5Z6Pufp
 32/UyGT7AnpNblXELsusABQ0euDOevtwNoaOq9wuQPBYfI2hpC1eC3+kd3awvqyB+qhu
 LUUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734507767; x=1735112567;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bRTDyBdfnK9kAprnP+Hh3qG7LUon4ziNP1QIA/V4/Ww=;
 b=EzJHmdbvq4py7KAD48/v9uuutvmHCi9qN2THcuUkqcl3kuQFBZbhe2smTL+2iUCmG2
 pST9UfZ504Zbozzo3hLpxSRIz74dRV/P0Unte+HZwzQe7Qm6ouu4rnQqW3HV4QMuPcbe
 borvmUlxAC/ysYw/PUNZb4eXk3bf9mftOji7fgMvw/0x4W5m+i8L2Y3ZjCcY9MYpH/WN
 i2099DBTlBp1cknYFCmK8euX2IZLQZGPQEFtYMD+L3mpNf5+IFwVGZFJ+n16gIbjn84R
 airDkze7oKBaUSCdG4pS3rPYg5GFE4FHIjYFZ3JHQoIIsYmJJot4iPzRFsj2LbgDqOsi
 YhyQ==
X-Gm-Message-State: AOJu0YzGnXHIO/ELjEzAQj++aNkuE/TxkBi57Rvw0lyxHKRdnWFNdoi5
 TFPm3M0v0/FR/WxEwXQLvEpUX2snLpQxILljofBjjRUunKAlEHWo+hWYOQ==
X-Gm-Gg: ASbGncu66HZ2e+ZXSDC/lrLenvPK9aAGR8EcXTfmpPAOIdGYQpu2nKwa9uNDCTeAQrw
 XPpUsuTR1XqtqNI6elSCe/0wA1uWpf8ZXBfbiRXLtLFXHAiPFcvlZmfuiQ9LO3SjknA7oZzf4Fd
 5xbsA8zxV1xEyfo0YsrPPGQkvneVo6dQislv7rjs9ScL5fdRq1yDY5DR54gNvPTpiwA5OfIWbnO
 ANO/30V3LGTcAHwpbLFk/y6fzzaveDJGeEsax9WG2s0TQD4rclhPZ5dOvswGvQvAaeqapvfu8aj
 LqpXV3UVnA==
X-Google-Smtp-Source: AGHT+IEkBa11aQAthEAHT3iqR8+FsIc7vO78JQzpOFjXyOhemtexAb4tpwjEh7tgs7YLBRr6C7RuSA==
X-Received: by 2002:a05:6a00:2e9a:b0:725:cfd0:dffa with SMTP id
 d2e1a72fcca58-72a8d223ad7mr3138470b3a.5.1734507766756; 
 Tue, 17 Dec 2024 23:42:46 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918af0caesm7900933b3a.86.2024.12.17.23.42.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:42:46 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 1/5] qtest/pci: Enforce balanced iomap/unmap
Date: Wed, 18 Dec 2024 17:42:27 +1000
Message-ID: <20241218074232.1784427-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218074232.1784427-1-npiggin@gmail.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x431.google.com
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

Add assertions to ensure a BAR is not mapped twice, and only
previously mapped BARs are unmapped. This can help catch some
bugs.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 tests/qtest/libqos/ahci.h       |  1 +
 tests/qtest/libqos/pci.h        |  2 ++
 tests/qtest/libqos/virtio-pci.h |  1 +
 tests/qtest/ahci-test.c         |  2 ++
 tests/qtest/libqos/ahci.c       |  6 ++++++
 tests/qtest/libqos/pci.c        | 32 +++++++++++++++++++++++++++++++-
 tests/qtest/libqos/virtio-pci.c |  6 +++++-
 7 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/tests/qtest/libqos/ahci.h b/tests/qtest/libqos/ahci.h
index a0487a1557d..5d7e26aee2a 100644
--- a/tests/qtest/libqos/ahci.h
+++ b/tests/qtest/libqos/ahci.h
@@ -575,6 +575,7 @@ QPCIDevice *get_ahci_device(QTestState *qts, uint32_t *fingerprint);
 void free_ahci_device(QPCIDevice *dev);
 void ahci_pci_enable(AHCIQState *ahci);
 void start_ahci_device(AHCIQState *ahci);
+void stop_ahci_device(AHCIQState *ahci);
 void ahci_hba_enable(AHCIQState *ahci);
 
 /* Port Management */
diff --git a/tests/qtest/libqos/pci.h b/tests/qtest/libqos/pci.h
index 83896145235..9dc82ea723a 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -65,6 +65,8 @@ struct QPCIDevice
 {
     QPCIBus *bus;
     int devfn;
+    bool bars_mapped[6];
+    QPCIBar bars[6];
     bool msix_enabled;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
diff --git a/tests/qtest/libqos/virtio-pci.h b/tests/qtest/libqos/virtio-pci.h
index f5115cacba2..efdf904b254 100644
--- a/tests/qtest/libqos/virtio-pci.h
+++ b/tests/qtest/libqos/virtio-pci.h
@@ -26,6 +26,7 @@ typedef struct QVirtioPCIDevice {
     uint64_t config_msix_addr;
     uint32_t config_msix_data;
 
+    bool enabled;
     int bar_idx;
 
     /* VIRTIO 1.0 */
diff --git a/tests/qtest/ahci-test.c b/tests/qtest/ahci-test.c
index 5a1923f721b..b3dae7a8ce4 100644
--- a/tests/qtest/ahci-test.c
+++ b/tests/qtest/ahci-test.c
@@ -1483,6 +1483,8 @@ static void test_reset_pending_callback(void)
     /* Wait for throttled write to finish. */
     sleep(1);
 
+    stop_ahci_device(ahci);
+
     /* Start again. */
     ahci_clean_mem(ahci);
     ahci_pci_enable(ahci);
diff --git a/tests/qtest/libqos/ahci.c b/tests/qtest/libqos/ahci.c
index 34a75b7f43b..cfc435b6663 100644
--- a/tests/qtest/libqos/ahci.c
+++ b/tests/qtest/libqos/ahci.c
@@ -217,6 +217,12 @@ void start_ahci_device(AHCIQState *ahci)
     qpci_device_enable(ahci->dev);
 }
 
+void stop_ahci_device(AHCIQState *ahci)
+{
+    /* Map AHCI's ABAR (BAR5) */
+    qpci_iounmap(ahci->dev, ahci->hba_bar);
+}
+
 /**
  * Test and initialize the AHCI's HBA memory areas.
  * Initialize and start any ports with devices attached.
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index b23d72346b6..a42ca08261d 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -93,12 +93,17 @@ QPCIDevice *qpci_device_find(QPCIBus *bus, int devfn)
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
+    for (i = 0; i < 6; i++) {
+        g_assert(!dev->bars_mapped[i]);
+    }
 }
 
 static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
@@ -531,6 +536,8 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
     uint64_t loc;
 
     g_assert(barno >= 0 && barno <= 5);
+    g_assert(!dev->bars_mapped[barno]);
+
     bar_reg = bar_reg_map[barno];
 
     qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
@@ -574,12 +581,35 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
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
+    static const int bar_reg_map[] = {
+        PCI_BASE_ADDRESS_0, PCI_BASE_ADDRESS_1, PCI_BASE_ADDRESS_2,
+        PCI_BASE_ADDRESS_3, PCI_BASE_ADDRESS_4, PCI_BASE_ADDRESS_5,
+    };
+    int bar_reg;
+    int i;
+
+    for (i = 0; i < 6; i++) {
+        if (!dev->bars_mapped[i]) {
+            continue;
+        }
+        if (dev->bars[i].addr == bar.addr) {
+            dev->bars_mapped[i] = false;
+            bar_reg = bar_reg_map[i];
+            qpci_config_writel(dev, bar_reg, 0xFFFFFFFF);
+            /* FIXME: the address space is leaked */
+            return;
+        }
+    }
+    g_assert_not_reached();
 }
 
 QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
diff --git a/tests/qtest/libqos/virtio-pci.c b/tests/qtest/libqos/virtio-pci.c
index 485b8f6b7e0..2b59fb181c9 100644
--- a/tests/qtest/libqos/virtio-pci.c
+++ b/tests/qtest/libqos/virtio-pci.c
@@ -304,11 +304,15 @@ void qvirtio_pci_device_enable(QVirtioPCIDevice *d)
 {
     qpci_device_enable(d->pdev);
     d->bar = qpci_iomap(d->pdev, d->bar_idx, NULL);
+    d->enabled = true;
 }
 
 void qvirtio_pci_device_disable(QVirtioPCIDevice *d)
 {
-    qpci_iounmap(d->pdev, d->bar);
+    if (d->enabled) {
+        qpci_iounmap(d->pdev, d->bar);
+        d->enabled = false;
+    }
 }
 
 void qvirtqueue_pci_msix_setup(QVirtioPCIDevice *d, QVirtQueuePCI *vqpci,
-- 
2.45.2


