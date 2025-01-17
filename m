Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18274C02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:23:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq46-0007jo-9N; Fri, 17 Jan 2025 12:23:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3p-0007Wu-L6; Fri, 17 Jan 2025 12:23:14 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tYq3o-00063w-1K; Fri, 17 Jan 2025 12:23:09 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso45544505ad.3; 
 Fri, 17 Jan 2025 09:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134586; x=1737739386; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BH1wCV8PXHzuAt3MSEu+tLtfIzMOQCTZueYB6tyK/1s=;
 b=kdc9x2GbfCVPFkbOewZY+IzY/9CaehyR6KacuWsl1GB5x5zJ99D6999V1HLrkudcHh
 8GiwA9YPOwGkKz29oYWAB7VFr9Rjj4IkArCJ4U6POWqmV+3wSbsjtdvWpGJUi6uUq6dn
 R7cU2tqkAjhXemA3V4H/yiiSDTAc4+paM1MZX13Mz3/5Mpu8x5ur+tu4/wgBChCaTJv3
 0vbwa+fnmldj73ViSdJ9iGMZXLfNdKFqjEATnjrJuhbe5W0N7Rff42/aw/jFGvJ2it/+
 yC1AdQ20EUFZJ4zBuq7YhLCCyPmJ58po0ihOWvja73FjH6YGFP0CLChdqBQNV8SE9EMA
 EnOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134586; x=1737739386;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BH1wCV8PXHzuAt3MSEu+tLtfIzMOQCTZueYB6tyK/1s=;
 b=lEvMH9YAsAWTGAVWsJHQsPr/ZvKOjn7vHGetyoEG3QxeFfQ+q498hDi5m8djrgFdOV
 xzADY9QnUFUCf7ZdVzhUA7TvmteJOacZQn1vrgHcAiPEa+/Z0WVmAP6Isb6IR5uHeHw+
 zq1x4c6AB90ONYvZ13Q6lgnQ1BqXTcSgs673NowvjA2LLP9Q4xiHbwQXXReqRxx4zx+Y
 V+qGU47syGSzWoh50YChUxxHjHDaGkmR4RA3ZbxrBzyvHUmzRvfMIc+hdTAqN32jrPwf
 eKeqykOdTmJTpm3RQ+NStO0j+8DW/MLwgqa929ZG7Miet9eGxpzCxgOgQqAEZRiVoVjG
 OAEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViPngm2hmNHkUyjEcwodX7lWurnxNal8yd/zgkHak/tw3pz16GINgmT/h6ZDXUJvIfrs5jjlFGVImxIQ==@nongnu.org,
 AJvYcCW8nle8GN1OBMUh9pIbQs2tpWR1RK+xSfHbAyRvMYx8TIOniCufXhU6AonMAaGaRCB3YWTctEXGo4Jl@nongnu.org
X-Gm-Message-State: AOJu0Yy8Y75rw/C32pMUV7xnj/xAZuOk9Rl1CF78RtxipKBCAiOpxmt/
 WYVoQb4NSJrIW4y3v2jIXdQsppJ0EfKyihOFuaE1pO3NsYUG6qGH
X-Gm-Gg: ASbGncvcTUXODkU13cjJVcJIcW2Zc84VqTjCPh767b1Zlcmg0K7RMQD/vFMGC3sIQOq
 nvgbh+gb7UrV9dTbcS35JQ2ikjtqFSfj5AI8whJSh9nsfPuUaSHRfr1kf4nXI08jHMYTlHrZh9r
 sa1L1LH65KBADfCPXozDT2Yt62VWOrNGepNZkkm18VPfkfwxgqx1KuNFyFgnaGJlqwnxxy/NVND
 C4xus4Cm1ncCMoeNz6iZcxCsxqnY9kQajmUK6Q8/zbjGpto12urSV7to17lIMC27WlXiHoR8HNL
 SrwB89hVlmZQsrU=
X-Google-Smtp-Source: AGHT+IG4HNyccLh6DnfBYjHTltMuqjvdN3N+aIw9dZCcsUT5oLtB9c3sVKmqLSoLdxD73EsDKUdPEg==
X-Received: by 2002:a05:6a00:994:b0:725:f376:f4f4 with SMTP id
 d2e1a72fcca58-72daf97af6emr4543340b3a.13.1737134585921; 
 Fri, 17 Jan 2025 09:23:05 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72daba511a4sm2235950b3a.140.2025.01.17.09.23.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:23:05 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Nicholas Piggin <npiggin@gmail.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Subject: [PATCH v3 3/4] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Date: Sat, 18 Jan 2025 03:22:42 +1000
Message-ID: <20250117172244.406206-4-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117172244.406206-1-npiggin@gmail.com>
References: <20250117172244.406206-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
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
index 05089a5f24f..a187349d30a 100644
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


