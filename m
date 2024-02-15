Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8CFC4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag6D-0004pL-OT; Thu, 15 Feb 2024 13:04:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5s-0003k5-Sk
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:04:21 -0500
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag5c-0003Gj-75
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:04:20 -0500
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-511898b6c9eso1445331e87.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:04:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020242; x=1708625042; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pbWJfttw2i/6nkY9oTBvXTNqjF14WXnlPS1ndEBwSeA=;
 b=EO4AJs4JF5F4yqS/JhrgfEDmec71NJscSPIKghS9QnP6mQVHM8WtCHr47JqhexT7Kg
 88qs9tBwmC3B7KijzRmhVct4LlCm3HmqZ9H/05QXM2QEC1x5CHCcVJw1zfMG4NKPo6Q6
 7XmWLleScphA5EHN81ctwB6TXAsAS0XqJvAYnuREyC7ypPNiPzjMhErGzSu9mogarwxi
 qPB1kkE++MyAyTYx+H69FIy7T9VuYfdGK3aNA1cGoPtbhsi6pzrR82k5nXiOyp3YGXWb
 CmRN+a8LFrxBVL4+ITf5Gbsec+2dXyAIHQreEzDMMk8lJvQzVMJ+6U1XdhDxs1OgpAUA
 wivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020242; x=1708625042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pbWJfttw2i/6nkY9oTBvXTNqjF14WXnlPS1ndEBwSeA=;
 b=JL8WofBkTIDsStWWfCkaVchDZqMXivHUfxe2Oz84u6KgHBk4z1PMMHFdLfNNrCAs2A
 G/1VKSinZ7DmxSAM896AVS1o7qbL3pk1fkqiexmzKCizUo+4nrVhCTFvJesDtbtAvacs
 N4k+RRZ8udpj/hHyWnuaTZVcjgLQDJHCxoDbSMdtq+eF2r62L2gTLE4VSK/W5aqzEHf9
 oE4yLgn9I1FjWk8qX2TKiH+kRkHmrvmG3AmdhSlEB76eb6qI93tLWeSGJLT1BAIsZ8VJ
 nFcbOSgyQbzqM2+YqOKRMvKKawBqx3RMTniP3bsKbWDkY6QdPZMBxkEArPImHjZHgCPa
 Pwcg==
X-Gm-Message-State: AOJu0Ywxp0UKtB7+PQKnXRiP/KYsLrmg6lvKCZ2HdCgXVqUZpR8xAaZf
 0V+NV7IloIYRW4AgZJCn1wMe+1lQh32b3hsblLAXOIkyIPLoLDuSdtbyRyJzvu9ODJ4ZcU3BHci
 Dv1Y=
X-Google-Smtp-Source: AGHT+IFP/WpfmQBEAHodl2/Mt7aZKbTQSePuDkjkTMlGUROPE0ikmToK+R1Q3lZRs/SqE73LaDRkWg==
X-Received: by 2002:a19:3849:0:b0:511:7a31:d66d with SMTP id
 d9-20020a193849000000b005117a31d66dmr1604680lfj.57.1708020242033; 
 Thu, 15 Feb 2024 10:04:02 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 s15-20020a17090699cf00b00a3bd8a34b1bsm793336ejn.164.2024.02.15.10.03.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:04:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Rob Herring <robh@kernel.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, Beniamino Galvani <b.galvani@gmail.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL 55/56] hw/ide/ahci: Move SysBus definitions to 'ahci-sysbus.h'
Date: Thu, 15 Feb 2024 18:57:49 +0100
Message-ID: <20240215175752.82828-56-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::132;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x132.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Keep "hw/ide/ahci.h" AHCI-generic.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20240213081201.78951-10-philmd@linaro.org>
---
 include/hw/arm/allwinner-a10.h |  2 +-
 include/hw/arm/allwinner-r40.h |  2 +-
 include/hw/arm/xlnx-zynqmp.h   |  2 +-
 include/hw/ide/ahci-sysbus.h   | 35 ++++++++++++++++++++++++++++++++++
 include/hw/ide/ahci.h          | 29 +---------------------------
 hw/arm/highbank.c              |  2 +-
 hw/arm/sbsa-ref.c              |  1 +
 hw/ide/ahci-allwinner.c        |  3 +--
 hw/ide/ahci.c                  |  1 +
 9 files changed, 43 insertions(+), 34 deletions(-)
 create mode 100644 include/hw/ide/ahci-sysbus.h

diff --git a/include/hw/arm/allwinner-a10.h b/include/hw/arm/allwinner-a10.h
index 2eb83a17ea..67a9a17b86 100644
--- a/include/hw/arm/allwinner-a10.h
+++ b/include/hw/arm/allwinner-a10.h
@@ -5,7 +5,7 @@
 #include "hw/intc/allwinner-a10-pic.h"
 #include "hw/net/allwinner_emac.h"
 #include "hw/sd/allwinner-sdhost.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/usb/hcd-ohci.h"
 #include "hw/usb/hcd-ehci.h"
 #include "hw/rtc/allwinner-rtc.h"
diff --git a/include/hw/arm/allwinner-r40.h b/include/hw/arm/allwinner-r40.h
index 66c38e7d90..614e74b7ed 100644
--- a/include/hw/arm/allwinner-r40.h
+++ b/include/hw/arm/allwinner-r40.h
@@ -22,7 +22,7 @@
 
 #include "qom/object.h"
 #include "hw/timer/allwinner-a10-pit.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gic.h"
 #include "hw/sd/allwinner-sdhost.h"
 #include "hw/misc/allwinner-r40-ccu.h"
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index 96358d51eb..48f7948092 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -22,7 +22,7 @@
 #include "hw/net/cadence_gem.h"
 #include "hw/char/cadence_uart.h"
 #include "hw/net/xlnx-zynqmp-can.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/sd/sdhci.h"
 #include "hw/ssi/xilinx_spips.h"
 #include "hw/dma/xlnx_dpdma.h"
diff --git a/include/hw/ide/ahci-sysbus.h b/include/hw/ide/ahci-sysbus.h
new file mode 100644
index 0000000000..06eaac8cb6
--- /dev/null
+++ b/include/hw/ide/ahci-sysbus.h
@@ -0,0 +1,35 @@
+/*
+ * QEMU AHCI Emulation (MMIO-mapped devices)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_IDE_AHCI_SYSBUS_H
+#define HW_IDE_AHCI_SYSBUS_H
+
+#include "qom/object.h"
+#include "hw/sysbus.h"
+#include "hw/ide/ahci.h"
+
+#define TYPE_SYSBUS_AHCI "sysbus-ahci"
+OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
+
+struct SysbusAHCIState {
+    SysBusDevice parent_obj;
+
+    AHCIState ahci;
+};
+
+#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
+OBJECT_DECLARE_SIMPLE_TYPE(AllwinnerAHCIState, ALLWINNER_AHCI)
+
+#define ALLWINNER_AHCI_MMIO_OFF  0x80
+#define ALLWINNER_AHCI_MMIO_SIZE 0x80
+
+struct AllwinnerAHCIState {
+    SysbusAHCIState parent_obj;
+
+    MemoryRegion mmio;
+    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE / 4];
+};
+
+#endif
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index c0b10c2bb4..ba31e75ff9 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -24,8 +24,7 @@
 #ifndef HW_IDE_AHCI_H
 #define HW_IDE_AHCI_H
 
-#include "hw/sysbus.h"
-#include "qom/object.h"
+#include "exec/memory.h"
 
 typedef struct AHCIDevice AHCIDevice;
 
@@ -54,30 +53,4 @@ typedef struct AHCIState {
 
 void ahci_ide_create_devs(AHCIState *ahci, DriveInfo **hd);
 
-#define TYPE_SYSBUS_AHCI "sysbus-ahci"
-OBJECT_DECLARE_SIMPLE_TYPE(SysbusAHCIState, SYSBUS_AHCI)
-
-struct SysbusAHCIState {
-    /*< private >*/
-    SysBusDevice parent_obj;
-    /*< public >*/
-
-    AHCIState ahci;
-};
-
-#define TYPE_ALLWINNER_AHCI "allwinner-ahci"
-OBJECT_DECLARE_SIMPLE_TYPE(AllwinnerAHCIState, ALLWINNER_AHCI)
-
-#define ALLWINNER_AHCI_MMIO_OFF  0x80
-#define ALLWINNER_AHCI_MMIO_SIZE 0x80
-
-struct AllwinnerAHCIState {
-    /*< private >*/
-    SysbusAHCIState parent_obj;
-    /*< public >*/
-
-    MemoryRegion mmio;
-    uint32_t regs[ALLWINNER_AHCI_MMIO_SIZE/4];
-};
-
 #endif /* HW_IDE_AHCI_H */
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 9fdac1cc81..c71b1a8db3 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -30,7 +30,7 @@
 #include "hw/boards.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/cpu/a9mpcore.h"
 #include "hw/cpu/a15mpcore.h"
 #include "qemu/log.h"
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index f2adf30337..5d3a574664 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -38,6 +38,7 @@
 #include "hw/boards.h"
 #include "hw/ide/internal.h"
 #include "hw/ide/ahci_internal.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/loader.h"
diff --git a/hw/ide/ahci-allwinner.c b/hw/ide/ahci-allwinner.c
index b173121006..9620de8ce8 100644
--- a/hw/ide/ahci-allwinner.c
+++ b/hw/ide/ahci-allwinner.c
@@ -19,9 +19,8 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "sysemu/dma.h"
-#include "hw/ide/internal.h"
 #include "migration/vmstate.h"
-#include "ahci_internal.h"
+#include "hw/ide/ahci-sysbus.h"
 
 #include "trace.h"
 
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 041cc87c11..54c9685495 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -37,6 +37,7 @@
 #include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
+#include "hw/ide/ahci-sysbus.h"
 #include "ahci_internal.h"
 
 #include "trace.h"
-- 
2.41.0


