Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06CCC02183
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2025 17:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYq9R-0004Gk-N9; Fri, 17 Jan 2025 12:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYq9Q-0004GW-DE
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:28:56 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1tYq9O-00078R-Vu
 for qemu-devel@nongnu.org; Fri, 17 Jan 2025 12:28:56 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-219f8263ae0so46020585ad.0
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2025 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737134933; x=1737739733; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DEqWTc5ydAaQroS10fFe0iUZijmNw6ECGMsxRlRKy+Y=;
 b=gZFJKHJrzHTT0DrX0rfCEoCNUNBzfgygg57C6Ia78PYZ1Rvf6F49tz6ICtks3rvHty
 2PdHLXFzvYA3i7dT/PbHfcoL2R1+k7gOlt7fxpzvEebbZki2tpBK+OdPmnhDFuqAyClX
 Aj0LBxnzJG7EhjtKEHPFnbkJsxcvNpPlBS4Lx3tfMo4pDVH4WL6p4pod0S6T6tXqRAW+
 a4gB5QhJs1vrrouUW7mwGBxpJO4CUJY08mfw19XgCsrWBJZimtFGwDY0h+9G7Qj6muBA
 Vio2DJljGX9SDfCmzwWJU5Xi4sBhpzn2FDBWO0KD8Ywqk6G4O546mhiI7dv+25hUnWpN
 Hw2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737134933; x=1737739733;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DEqWTc5ydAaQroS10fFe0iUZijmNw6ECGMsxRlRKy+Y=;
 b=QHXvtTsPQ0QjJ7YAWBJouHmW8W5j8CJZflwGupmYvdFqj/UpRrVJJnnw7foh1FYZ7n
 hCU9xDBQulynfz1HUwNpGN/hfPAjRg+yxiclN6ue5cLxforLV52L1hVriEgNhz+2uaLG
 hV0Kr6n1YsSIPmqRp7f8k3Qzxdd1703yxp5WQU+GwFhsNU5nkIPygI50BxkLUXzYyi2/
 mzotRrTZSCViAlyXTM7yt/pvD5LBiLwFGKhWIge6QMPhj+hn0bzD07ap26Y+md+Ux5zf
 qVIPTdV575hn+j0u7GF5572KWDE72OBY5hiLhDyBYHh3iPDHgzrHQmg9aMX6NSq9KKHz
 gJhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXMMwN7z8RSIvYq5oNI1jwWsRzilsIUl4uEoM+CDofYcfo5pHo9Ft0qCmLtFjciA/79YHt/TqMTPplv@nongnu.org
X-Gm-Message-State: AOJu0YwNaUQXbE+aNDD+Av0Gs78gse3zNAdqy/pBONRzFl/d2gK1T+Vx
 gxr6wy724FDddQ188ErwcV7P2nx2asGaNY3VkG9OcOWLKewiQDODUx1Jgg==
X-Gm-Gg: ASbGncsupkD5cvLencxB+f6drxWonB1OXLKsilzqIrFTHIzbKktKge1oPxCi39jsYWL
 wPjskAulbBWAVlhM9KtOGzOIHHkxwSRBfA276ufHhHWtP/0Yy3A2643dSJpyeFjimOUoFtSB1PP
 ZCAozyidZUui6TGtkVChR23TsaSuMBQyr+DsqwW0A2jWs5ByOaWwPz/NdPKsS9GNEVMRGyouhrC
 KpXnFWhCHShGDs/WgMQaw832ADMx2KYO86CorkiWaq4qLtdyWDox32Bkl4OmozBgYgJ4/RMAI6G
 TaEBHsf7jxbxWa8=
X-Google-Smtp-Source: AGHT+IHNy+2QauNlXQHFcE6ESJW0IkNBP2c+Hm54EYqutzDkn3SmkYg4S2i4ndP63AR+LvivBTE59A==
X-Received: by 2002:a17:902:ce09:b0:216:2bd7:1c2e with SMTP id
 d9443c01a7336-21c3540acc8mr51546615ad.18.1737134933310; 
 Fri, 17 Jan 2025 09:28:53 -0800 (PST)
Received: from wheely.local0.net (124-169-212-233.tpgi.com.au.
 [124.169.212.233]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21c2d3a8a2bsm18658805ad.142.2025.01.17.09.28.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jan 2025 09:28:52 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Subject: [PATCH 1/2] hw/pci/msix: Warn on PBA writes
Date: Sat, 18 Jan 2025 03:28:40 +1000
Message-ID: <20250117172842.406338-2-npiggin@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250117172842.406338-1-npiggin@gmail.com>
References: <20250117172842.406338-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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

Of the MSI-X PBA pending bits, the PCI Local Bus Specification says:

  Software should never write, and should only read
  Pending Bits. If software writes to Pending Bits, the
  result is undefined.

Log a GUEST_ERROR message if the PBA is written to by software.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/pci/msix.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/pci/msix.c b/hw/pci/msix.c
index 57ec7084a47..66f27b9d712 100644
--- a/hw/pci/msix.c
+++ b/hw/pci/msix.c
@@ -15,6 +15,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/log.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/pci.h"
@@ -260,6 +261,14 @@ static uint64_t msix_pba_mmio_read(void *opaque, hwaddr addr,
 static void msix_pba_mmio_write(void *opaque, hwaddr addr,
                                 uint64_t val, unsigned size)
 {
+    PCIDevice *dev = opaque;
+
+    qemu_log_mask(LOG_GUEST_ERROR,
+                  "PCI [%s:%02x:%02x.%x] attempt to write to MSI-X "
+                  "PBA at 0x%" FMT_PCIBUS ", ignoring.\n",
+                  pci_root_bus_path(dev), pci_dev_bus_num(dev),
+                  PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn),
+                  addr);
 }
 
 static const MemoryRegionOps msix_pba_mmio_ops = {
-- 
2.45.2


