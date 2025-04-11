Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27956C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 04:42:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u36DT-0003RI-B1; Fri, 11 Apr 2025 00:42:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DP-0003QV-0g; Fri, 11 Apr 2025 00:42:07 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u36DN-0001fU-B9; Fri, 11 Apr 2025 00:42:06 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22928d629faso15956525ad.3; 
 Thu, 10 Apr 2025 21:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744346523; x=1744951323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xDeAZLdMZEZbIzS8jBS1ynoCpqyQ1zcOuidUzgg27yA=;
 b=XAml7ngNIDV8shbkq1wpZvWnVMoJHiOFTdfT7f/hH41w0yB9QS3ZyZ8RNR9YC+IROa
 dYdiV9zp/BfOVodGJLFbEbPSLtYKWoB+3Ng89u8DZm046QQ/N6EZM0MaZ+8SS9a8xjm0
 8Cu9HBqe3q/eXGc4C0Jo5cvhz3e8HZF/aqShIFgnBk5eiJUYuE6ash7/Wlr5a+RH4Pvk
 7iPFTj95tTbCGCDs5V6J02fofwTaFrhsH/JjsK1guquP0z+V4LWy66ILvNTjwG+8Fw7e
 0eMZ/g9BrtGn3Px0RCzm9Y+ypNBrQrt50oNc3zPRJpLr4r+f32Nlghq4hoSfu3qcabE2
 M9Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744346523; x=1744951323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xDeAZLdMZEZbIzS8jBS1ynoCpqyQ1zcOuidUzgg27yA=;
 b=fF8dLT3UT6sjcD3Nbb5V1DOsYqcyDueRhPUtlNv+Zw02zRiHDX/KQm9TEnomsvERpp
 DB+w7XjwYqYGx7ppZraSICdZPaI4dDLaD1+sexqm3r2MG5KfFOLHuOYOTEgzgbLcbd3p
 vtbCIYbk8XankoAr8y+FfjN4kB7OLr43RncZwo8+66X6Lz7nJGjbB2yujWwDMKLArmts
 VOe5wn13bxfbExdzOMH50+FVUTQ3naqS1A4O4unHgIv99ftykbBnyyILUp/os13sSiKl
 qpd+hBa/XU9IOJBO591Ab0RlwRdrvWe+jfuA3fomAEX0jVUanjT//IzfDD/l+C5dK2Mf
 8+GQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHlAy2OkGgNe8/DLHYx9CBFw6xZgRuCk1BgCWvheQA9AnFy1eXSaQE1E1cAKPwbf/EebUB3RZr7T7E@nongnu.org
X-Gm-Message-State: AOJu0YzfJzNpu9q6uMh6IPP3nRht7+FLQck1zCG36vmyZVVWuAspq/bt
 K59I6raIpwJ8olvAwLjRjTEIB3+bwl7iGlBvhA3mnlnI2XVcy8niusm+nw==
X-Gm-Gg: ASbGncsx+xTIuyEpJ1N3tibs9+DtuNye+iW5LwV+GR3ax/Ywcl3ssgbnwVgeS0maGR/
 G3Eyf06z5/ufdJvAKLspTg6UWWBOIm4XlCn4JVfi6Zzg/Uf6K6Z8OnoqhSaHNksKb51Og4bdDRK
 Zdlr5vKAR/DTNrcPUQO+uYdQwFGXSIlf2ip13YmVmx2Wxm5LpYP6Jo4s/XVPef7pV5ymxFCYzx3
 TNoH/1BwR+LW2nzdiRBQamJkpMNS6wIwMiMN+uulUN1dyqpqZUg5uUHqbgwDii1boTHv+SpWbvo
 BEBNUAREAoib6w7qUCx87G1J0847ZgD/jHC7ESmw0uwZSlUJ/HFP+xs=
X-Google-Smtp-Source: AGHT+IGO2MMSl5/kghcY/caUEPyovyxUPFpIUbSaX/elFVTmpTaa2oE/6N1x1RwKI8JMJ89Ar2q0JA==
X-Received: by 2002:a17:902:e54a:b0:225:b718:4dff with SMTP id
 d9443c01a7336-22bea4fdd91mr22322215ad.53.1744346522989; 
 Thu, 10 Apr 2025 21:42:02 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c971e4sm39672745ad.136.2025.04.10.21.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 21:42:02 -0700 (PDT)
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
Subject: [PATCH v4 5/7] qtest/libqos/pci: Enforce balanced iomap/unmap
Date: Fri, 11 Apr 2025 14:41:27 +1000
Message-ID: <20250411044130.201724-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411044130.201724-1-npiggin@gmail.com>
References: <20250411044130.201724-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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
index fd195ac4e6f..5c7ebad4270 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -61,10 +61,19 @@ struct QPCIBar {
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
index 14581178c79..02d88acd500 100644
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
+    for (i = 0; i < QPCI_NUM_REGIONS; i++) {
+        g_assert(!dev->bars_mapped[i]);
+    }
 }
 
 static uint8_t qpci_find_resource_reserve_capability(QPCIDevice *dev)
@@ -515,21 +520,31 @@ void qpci_memwrite(QPCIDevice *dev, QPCIBar token, uint64_t off,
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
@@ -572,12 +587,34 @@ QPCIBar qpci_iomap(QPCIDevice *dev, int barno, uint64_t *sizeptr)
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
@@ -588,6 +625,10 @@ QPCIBar qpci_legacy_iomap(QPCIDevice *dev, uint16_t addr)
 
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


