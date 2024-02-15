Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3615C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZK9-0001su-Vv; Thu, 15 Feb 2024 05:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZK8-0001sW-8m
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:36 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZK6-0007ak-Gp
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:36 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so1213662a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 02:50:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707994233; x=1708599033; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VAFRh/EAl/HtsoAFF4atOhVIQ1s/gH8aym6XGe49VAg=;
 b=RZYCVcoKUk25g6ygDPRmTfYDjY6gFVAAaA2ZJ7O5NCm+UoSrDGq6RCequhtnasYoVx
 0x3ulLOrtkZs4nIUMktDGlFenZplBklRJ+g6AGutENCtumRLxWHw6EpFbX3JHiwBoKN1
 9LEtgrraz7q5t8JW7p5EvfC/t+weNQcwbl2NcJw/jQ+tUaqLZzQ/bRzSuA6ZZcKieM1u
 CCxQFLoacY+kDARDLeHqaWo8TYEokC0cBsgkrm9ehQEQC8vo5ecD+KwxPl1Ves/ip5t5
 AqcJU/C++4dS7KJaQbEudcAkxohJjdtvNC1VN/+QbFf9sw5jFf8QK+24W9+QwePIbtiu
 PLqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707994233; x=1708599033;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VAFRh/EAl/HtsoAFF4atOhVIQ1s/gH8aym6XGe49VAg=;
 b=c9U2Zy6wYwSRSkyeCema4dvyPH064tysoYe/eHj3CxrkPQid31rbk81oqlHumIPSQP
 Y0eueKZCr27Df6+NRqD6qHDvgzQ71o3t2zUyZymJA9bzlfeCddlh1j24oo2dmBPRjXP1
 WHyS8e7P5VmMAd+IlpQTB48N8v9CMDbtgqTagddtMn0LpWD7RWgv/Un+bMLrjNEO2Xs9
 34vpBevh4/pRf7ab0IrcZbwabAum+ATgC6NrqRGmH2/grl8sW0fc+pPmu9r0D6UQkB6d
 DKFv+ue/a5GfS93fXGr3JQZ/Ar7aK2aArxHTeX5z5g/WeRbjaKhwlNLblpIcwnBOOyFZ
 4Y3w==
X-Gm-Message-State: AOJu0YwK72YV77DjM9QaLUKLr0gWoDSmX5jAuE6p5CMY+qm7Lzkyjm6r
 yWoPIljST7hDTkO1PwIbP355U/p24dFvcm522py249zv0SsEW3t9qyyQdo6tCtt5nt7UJ1Zyka9
 q/WM=
X-Google-Smtp-Source: AGHT+IHt7wPSRiCYsHFGnZn4AepGcgu8KuhiOWsv9fHouhGQJwDizq38yMlervbrM4OICu4yK/7OVQ==
X-Received: by 2002:aa7:d6cb:0:b0:561:123f:a98f with SMTP id
 x11-20020aa7d6cb000000b00561123fa98fmr916202edr.24.1707994232894; 
 Thu, 15 Feb 2024 02:50:32 -0800 (PST)
Received: from localhost.localdomain ([92.88.170.215])
 by smtp.gmail.com with ESMTPSA id
 v20-20020aa7d9d4000000b00561fbfebdb5sm417338eds.96.2024.02.15.02.50.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 02:50:32 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 2/4] hw/ppc/ppc4xx_pci: Extract PCI host definitions to
 hw/pci-host/ppc4xx.h
Date: Thu, 15 Feb 2024 11:50:14 +0100
Message-ID: <20240215105017.57748-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215105017.57748-1-philmd@linaro.org>
References: <20240215105017.57748-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                  |  1 +
 include/hw/pci-host/ppc4xx.h | 17 +++++++++++++++++
 include/hw/ppc/ppc4xx.h      |  5 -----
 hw/ppc/ppc440_bamboo.c       |  1 +
 hw/ppc/ppc440_pcix.c         |  2 +-
 hw/ppc/ppc440_uc.c           |  1 +
 hw/ppc/ppc4xx_pci.c          |  2 +-
 hw/ppc/sam460ex.c            |  1 +
 8 files changed, 23 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/pci-host/ppc4xx.h

diff --git a/MAINTAINERS b/MAINTAINERS
index a24c2b51b6..a9458121d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2068,6 +2068,7 @@ F: hw/ppc/ppc4xx*.c
 F: hw/ppc/ppc440_uc.c
 F: hw/ppc/ppc440.h
 F: hw/i2c/ppc4xx_i2c.c
+F: include/hw/pci-host/ppc4xx.h
 F: include/hw/ppc/ppc4xx.h
 F: include/hw/i2c/ppc4xx_i2c.h
 F: hw/intc/ppc-uic.c
diff --git a/include/hw/pci-host/ppc4xx.h b/include/hw/pci-host/ppc4xx.h
new file mode 100644
index 0000000000..32396417fc
--- /dev/null
+++ b/include/hw/pci-host/ppc4xx.h
@@ -0,0 +1,17 @@
+/*
+ * QEMU PowerPC 4xx PCI-host definitions
+ *
+ * Copyright (c) 2018-2023 BALATON Zoltan
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_PCIHOST_PPC4XX_H
+#define HW_PCIHOST_PPC4XX_H
+
+#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
+#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
+#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
+#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
+
+#endif
diff --git a/include/hw/ppc/ppc4xx.h b/include/hw/ppc/ppc4xx.h
index ea7740239b..1bd9b8821b 100644
--- a/include/hw/ppc/ppc4xx.h
+++ b/include/hw/ppc/ppc4xx.h
@@ -29,11 +29,6 @@
 #include "exec/memory.h"
 #include "hw/sysbus.h"
 
-#define TYPE_PPC4xx_HOST_BRIDGE "ppc4xx-host-bridge"
-#define TYPE_PPC4xx_PCI_HOST "ppc4xx-pci-host"
-#define TYPE_PPC440_PCIX_HOST "ppc440-pcix-host"
-#define TYPE_PPC460EX_PCIE_HOST "ppc460ex-pcie-host"
-
 /*
  * Generic DCR device
  */
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index c75c3083e6..e18f57efce 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -24,6 +24,7 @@
 #include "elf.h"
 #include "hw/char/serial.h"
 #include "hw/ppc/ppc.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
 #include "hw/sysbus.h"
diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
index d84418cb7b..1926ae2a27 100644
--- a/hw/ppc/ppc440_pcix.c
+++ b/hw/ppc/ppc440_pcix.c
@@ -25,7 +25,7 @@
 #include "qemu/module.h"
 #include "qemu/units.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pci_host.h"
 #include "trace.h"
diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
index 7d6ca70387..1312aa2080 100644
--- a/hw/ppc/ppc440_uc.c
+++ b/hw/ppc/ppc440_uc.c
@@ -14,6 +14,7 @@
 #include "qemu/log.h"
 #include "hw/irq.h"
 #include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/qdev-properties.h"
 #include "hw/pci/pci.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index e4101398c9..b6c6c8993c 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
-#include "hw/ppc/ppc4xx.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
 #include "sysemu/reset.h"
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 1e615b8d35..a28498f39c 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -25,6 +25,7 @@
 #include "elf.h"
 #include "exec/memory.h"
 #include "ppc440.h"
+#include "hw/pci-host/ppc4xx.h"
 #include "hw/block/flash.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/reset.h"
-- 
2.41.0


