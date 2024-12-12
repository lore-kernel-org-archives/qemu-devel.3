Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0541CE77180
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2024 08:37:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLefa-0006iv-GM; Thu, 12 Dec 2024 03:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefX-0006ii-Ig
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:35 -0500
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tLefU-0004Y3-HL
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 03:35:34 -0500
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2eeb4d643a5so271760a91.3
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2024 00:35:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1733992531; x=1734597331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6QI+StavfES5vlYy9klhZaUtTtmII/hVb11fVMVfTA=;
 b=iWHzVpGBUP3wia5m1d1bAKeYYURLSwe2/YFuCeCOgHHn4Dmp0vVg7gdDNMrvCdSTFL
 f8iJvH0jaGIQK2Lp+DFO2DsvF1SbD0ADeDVpyz44XfvMKOY+TXXeoyISsimhfPbXmdBj
 yt5XG9tWQoCFJaqSm1Zs1FjMgKMlnJtve+5xyJMbvzvuyYOumzqyB3ThmYCo10reguUT
 Cot3RYxDXQK50dV+xZ9pVHjSkNWdKtAUBUZjZagyN/8ObwW7GXyn5oZeCI3mSX7yrMq6
 jnOFqTiepD41eYTCauAVlMeInM56KfRC3wKukPeN8/tEHuILYTyD0YkPb3lIyWT9Uzgy
 nqng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733992531; x=1734597331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6QI+StavfES5vlYy9klhZaUtTtmII/hVb11fVMVfTA=;
 b=kExjoz6au4HBe24YxZRsvL+hcm0FnxycDYq0Z3rzCFJkorakK8D5+NBxpxjgZWDn17
 Y3u6tm46j4o4JLLNKjBGMKVNDGA6i07yrifMBTh8KM9CK7S9MzJVGnpCaz52hMhlEGu9
 by1sW/t85Mjyt8K+OfryrDdlmct2Qfm0TV4h5p6zhHQGgbVV59Vd+QjbgRA7rxTlr2lo
 I3uMwkbv1KiZn4/GVTC9/QcLnf0dZDdmsx8tJo6YBdQ+Ln76pSJDMsOAo92lgQH9e76v
 +leMR6338aEuid/22f5/QtwfwzrWFmNmGN0rMbVmOnYYmEg2BCb+HnmEJ5SjwGxgNWJC
 fYhw==
X-Gm-Message-State: AOJu0YzyqzVQqMNSl/UUgADuBs5KZ2YP9L7wjVayEr3hCh7MLyP4RYWg
 CD/pMRcb28FrcTZTVmXlM9876wWSPP6StItS7RHsF1FnM3s2JoT4VodDIw==
X-Gm-Gg: ASbGncsZ5aO77wld//T0FeDHx3AXpKmPza3rmKkBeCD0U3sdhY7vKG8FyFJw0zc3JU6
 ozF8Uhrzv2VlM0ZBtuw53KTmCWiWisoaJhHI46kAJT+dWF1pJ9tokzKkL4ci1yY5a3srW3Tgzvi
 JO4HWQBUs1kfzegazxGW3vXORO8Rjx6egbWlICUhIWdEaI9Z6dGmF/rh81hTFJREmQmj47YoYhG
 1Te8arWx/0ntYTKaz0KLe0RijL4DJ2GgC8QIR6UhU68whuCRwxUJWXgFBM=
X-Google-Smtp-Source: AGHT+IESTsS3C0fK7iP4KKd2Hu4bTJZGNqCuyMaGPChplcBzzJcsSbnVN1go4XAdghHa83uHYw/sfg==
X-Received: by 2002:a17:90b:1c05:b0:2ee:f550:3837 with SMTP id
 98e67ed59e1d1-2f127f64262mr9871515a91.7.1733992530781; 
 Thu, 12 Dec 2024 00:35:30 -0800 (PST)
Received: from wheely.local0.net ([1.146.48.169])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f142dae788sm714624a91.12.2024.12.12.00.35.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Dec 2024 00:35:30 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 2/8] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Date: Thu, 12 Dec 2024 18:34:55 +1000
Message-ID: <20241212083502.1439033-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241212083502.1439033-1-npiggin@gmail.com>
References: <20241212083502.1439033-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1036.google.com
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


