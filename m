Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31BDC369DC
	for <qemu-devel@archiver.kernel.org>; Fri,  2 May 2025 03:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAgiv-0002HV-1a; Thu, 01 May 2025 23:06:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgit-0002Fo-Gq; Thu, 01 May 2025 23:05:59 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uAgir-0000mA-OA; Thu, 01 May 2025 23:05:59 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so2376638b3a.2; 
 Thu, 01 May 2025 20:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746155155; x=1746759955; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rbWiZk9FIuTQk1R1l7yjGMAZNpLJl/v15pcW+S5JT5Q=;
 b=D7KdES1SV5TQoe4833/Slu/C6paTJmHrRRxXjcnMgOgBM37UzsCIM4+7jMXxWIntYv
 TkV1UFPyNGBlWvPkH2nVwkH3boicUTzzQu0Gj/NJgFSpWojoT5oGc08Sg1k6nZBu7pzP
 y7l4KKFyATniBM8dP81APZ5tP9m92aQITn0R7I0NaxOr8DeVQ9jZ1fc5JW9JIUiO88dd
 1sxyu0BjgoQDmJSNPbUJf9bVGK1vRVrazubEAYKaYhCz8EkYzJf1RcP9w3ofik8uDK3F
 EBoWS7aHXzXFfZzex0qYRmFalxwBKnE9lqBzpB1MNZH+7ytS55wsEbBTTN/pf9d15liC
 noxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746155155; x=1746759955;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rbWiZk9FIuTQk1R1l7yjGMAZNpLJl/v15pcW+S5JT5Q=;
 b=RN6Xqjk/QcHgLlQvQfM9IhWh53AUlyxa3LSdx5fUWqY3jv4o3WZPqdRjzmhuDxExTn
 ddFTjZncLkqes488kdPAychpMdvno6yQv3k6/aE/xOcrHLvGosjiu5uymdwTZk883NIu
 VMGcPQWGHTw6Yrct/X7cbTfB5thPyM+BlnBMAoKh78Ax1r3VbJoxaMOPghi/HrT2VRzw
 UG5x2p9tVowST+mLhFoSDIm2W+2Wz+av35ZVnwaBwUszzzh8LL4hYZfqpfXBTV4rfHJ/
 sGDJo/jHOIrv4V929z97Go4MErHajtqeMX6vnOl1pHK5+gMvz7LubY6Jd7Gt3GjmpdWh
 LiQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU4xnDJSJaiGMQgOWtwX8gMwyvsaBktxViccEQEwfVegcXlyovbIuZNPSqWzseOtcDXe2dbb+Wfb8NG@nongnu.org,
 AJvYcCXZZJ3jXhi/KnDF3m3Bkf0AOMRZqK2o0jWwGX8zFDDNOm0Qff0vQj1wsSevmQaDvjCGhDphyN9hhjU=@nongnu.org
X-Gm-Message-State: AOJu0YyrnHOk1QoRc71evlpuwOQeLqWAQUEqmspleK+RDzZrEd/gkkgu
 Sw04WhB2K6QNGxcjkiEkkzs3VbUKOFjizS6m420+sd1Ax7qqdTe4/gwV5w==
X-Gm-Gg: ASbGncsbneI6E6lQlOPgzDquCGlrA9ehBpbUfyagKgoHZBOQ7XeIKDVI1juXgUQJtTl
 gREqKYkfl/j0ul4KcZoqU00SS3tyk9kBSFv1oHHcvkqMBmxBs1iM2ITnC9GRMe2muEQzuTghYLU
 lSbnADm/Bj04VxwDF0wj32W8KIUUfuQWtYtfEtDR/qxn7+tuEEJklDSHhqHVJoSM56ajqsmWKO0
 0BPhLV1G3u/Qelt8VuwRyoOoQCgHeAKIZVNTimYlKVGaVLWNPCM5OCuoKUnOWJOY9yjX4oR4Ami
 JzwV8Co+PAmxU41grXCYGbvRRa9EhPzmrLeJ83D0ZxXDhVXAWunpj8c=
X-Google-Smtp-Source: AGHT+IEAIMZrsKspe0rfYw8VBj6Q0CSBkdZtaWfOdr9njWtGSnLTMAaJKA7qd7+jMFpKbKZihFi2BQ==
X-Received: by 2002:a05:6a20:d50a:b0:1f5:8d91:293a with SMTP id
 adf61e73a8af0-20ce03ee7bemr2173969637.41.1746155155059; 
 Thu, 01 May 2025 20:05:55 -0700 (PDT)
Received: from wheely.local0.net ([220.253.99.94])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059020932sm463382b3a.92.2025.05.01.20.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 May 2025 20:05:54 -0700 (PDT)
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
Subject: [PATCH v5 10/11] qtest/libqos/pci: Fix qpci_msix_enable sharing bar0
Date: Fri,  2 May 2025 13:04:44 +1000
Message-ID: <20250502030446.88310-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250502030446.88310-1-npiggin@gmail.com>
References: <20250502030446.88310-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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
index a51bf60620f..852d4a85f6f 100644
--- a/tests/qtest/libqos/pci.h
+++ b/tests/qtest/libqos/pci.h
@@ -74,6 +74,7 @@ struct QPCIDevice
     bool bars_mapped[QPCI_NUM_REGIONS];
     QPCIBar bars[QPCI_NUM_REGIONS];
     bool msix_enabled;
+    bool msix_table_bar_iomap, msix_pba_bar_iomap;
     QPCIBar msix_table_bar, msix_pba_bar;
     uint64_t msix_table_off, msix_pba_off;
 };
diff --git a/tests/qtest/libqos/pci.c b/tests/qtest/libqos/pci.c
index 694f1458f46..cc83dcc163a 100644
--- a/tests/qtest/libqos/pci.c
+++ b/tests/qtest/libqos/pci.c
@@ -274,15 +274,21 @@ void qpci_msix_enable(QPCIDevice *dev)
 
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
 
@@ -293,6 +299,7 @@ void qpci_msix_disable(QPCIDevice *dev)
 {
     uint8_t addr;
     uint16_t val;
+    uint32_t table;
 
     g_assert(dev->msix_enabled);
     addr = qpci_find_capability(dev, PCI_CAP_ID_MSIX, 0);
@@ -301,10 +308,31 @@ void qpci_msix_disable(QPCIDevice *dev)
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


