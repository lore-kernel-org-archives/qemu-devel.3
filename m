Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 939A3E77183
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 07:43:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNohv-0007kG-4Z; Wed, 18 Dec 2024 02:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohr-0007ju-8o
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:42:55 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tNohp-0006i7-Bm
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 02:42:54 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-725f4623df7so5498256b3a.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2024 23:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734507771; x=1735112571; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e6QI+StavfES5vlYy9klhZaUtTtmII/hVb11fVMVfTA=;
 b=SxDDSFSb5+x8QIA5kJVokxeMx9Q0BK2rtYLnGhusKCccNjw5bFHSW8aX20Lb6JwM00
 UODQuhxquBt2qSFTE6j8axuIxiAM3cdvcxnmVpdW0rGqt4teU4LTnFOAJ8JoYanPyQLK
 DYzCvZr4cPuHlFeap+gt0Zi91ztUmKcllVKveUS8Ro6ARGBUY3uvc5cCL9v6E6a8OnxP
 CXvjIEGm62Wfohu6MtisafsgU2aFVvl4+AF7uP5lyGRAG52/OWkYFa2GQmAgF0wgQ5s2
 doTutSB9vmaOrYcJOhJ+P3S9fs3h+5rZz/l+Tnwb0jthtem8FfIXp4a8H3Je2sc7ocLO
 Yozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734507771; x=1735112571;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=e6QI+StavfES5vlYy9klhZaUtTtmII/hVb11fVMVfTA=;
 b=Uka5/+qKzKI+FsWq0cPnOW49IDdkuYEN6Z7InSqzX2//vakXBlInghNi4hkaBzNWlZ
 xvS3oZVmnvDWNRC2ZL10PjOSFeI5C06MQJLPqbYjCTA/7x3MMNKBKSZlr/SeaDSe4iha
 hA4fheGHctvB/Hr61vMN/vWUG2a0M/tKg2AjQNUkl8VkAhlId+0fyB+bRBz/uE55QZHe
 u+ZFMPpuHJvwBmm59Cy4ACEqcBi5+faxBoGhyeSPqi1GLh/8/II5uzaYbWvlUKUrBwBS
 DK8haHxBuqDNE2sk4Zn8WVfcJ9yXlqYUi0fwlV0N8LLYFfqCvduEDaONrh5NsVMCLsCR
 oQGw==
X-Gm-Message-State: AOJu0YxJz/axN1/TS2jv2j907LcXefFLVkXMjcYRrAccQDr9n+whtkfT
 qtB4NbmP10BaMm8w2YiPQNrLrLf93FT9E3GmILrRooS0k9EWn1gZO7TCOQ==
X-Gm-Gg: ASbGnctoEenMsWUTdknIGGav/tGvDKB3zx9GjkCiOtlpHhUJ2ssX8+663jxjLwrpMHX
 4tytlLAC/RR5Lt+r8LitrLksEZm16srxcvVjNa1YonEL0AFMWrgw1JcD+lkkANrYcgo9LVYPz60
 IGiq+CGj9B+6qw8p7sqsGW0/1SVdfTS8jpRUvvhxHRpWIY486W2dwSwxk1KMPUyGzGoTmJSJd5z
 0mNALdSPpWF9QBRZQj4qwXIvy+Jp7PdXHADOwLp2SJzhC67CzUuWlom+oGLfAqJAXvFZk43gxWM
 kiK1Pd0F+w==
X-Google-Smtp-Source: AGHT+IFJ0eKApvsuy3Zy2t9apqWQMyZhLMs6XbT/YBKfzMKhqx7/C2He/Wg2VAn4/egUZICJRL+KSw==
X-Received: by 2002:a05:6a00:3307:b0:725:90f9:daf9 with SMTP id
 d2e1a72fcca58-72a8d261072mr2725391b3a.15.1734507771477; 
 Tue, 17 Dec 2024 23:42:51 -0800 (PST)
Received: from wheely.local0.net (14-200-18-130.tpgi.com.au. [14.200.18.130])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72918af0caesm7900933b3a.86.2024.12.17.23.42.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Dec 2024 23:42:50 -0800 (PST)
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
Subject: [PATCH 2/5] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Date: Wed, 18 Dec 2024 17:42:28 +1000
Message-ID: <20241218074232.1784427-3-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241218074232.1784427-1-npiggin@gmail.com>
References: <20241218074232.1784427-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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


