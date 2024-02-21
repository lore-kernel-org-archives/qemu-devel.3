Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDAF2C5478B
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxz-0002ux-Ih; Wed, 21 Feb 2024 16:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxh-0002eN-R1
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:06 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxY-0000pn-6x
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:05 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-33d7b04f7e9so788454f8f.1
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550214; x=1709155014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GU7gAHkVNY1ZnCm5tOTnwrsOZMxJGgzLpPFYNVYgH0g=;
 b=s2bYLsq/SnTwAs0PbA68nT8WROylbqGw12WHNeXeDvXHA5Ipw1TC4u39WSBKOre/Rf
 eL7t+tno5MU1NBQ6K1NrGh10L8Cs2/AsuVRcJ25iyuSN9+tE8rTcs+0vNBXJeQyH4ecU
 /kjCakh/NDBAFgKXodOwwwRg7eBCjdI1U38dARbstT0KySPDwU7SssOFJC59CDytSsfN
 zAkKKtHufOD/sPxKffC8Iz4uYsqOMHbeuCPj0bikcvdfP6dHus5K7G9iJBowgZ/QCCXw
 meAMy0HULcxg9VQcLG6jvyOCSz9qg4IE5iQVa+bEh3rh/Zs6LNn2f5n7v9Tj+9LgYpic
 Mo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550214; x=1709155014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GU7gAHkVNY1ZnCm5tOTnwrsOZMxJGgzLpPFYNVYgH0g=;
 b=S33sEnL1ZJPiv0VlrvyEwiGU2qWKcwNviPVrrEGvg7y914Chv+PsjiVzpOVgqZHa9X
 gNtU2TUIhk7lBy0YrQB8U3fMSsXwqMsgWNSWdJnfzvI/hyI5JXFEdG57T8mwWZVsPi/J
 BZ3cxs+d5ntUuKPmifkVt+RhKPTXpjoW30hNH/pr6parFAWKlNQG2zxfb8ImeaqGs5cQ
 ocbXoEUuJXsxGigGXUsAhLIv2m7kOcfxiz56Pa8m+lz6w1cRT9ahKRbbtyCpc789erIT
 z/mdKD/2FFmRt3xSogPQemxGhj3RN31slZCBZ+gSXzzFKTcrMbSemIU3GLj8ldywVIHq
 sugA==
X-Gm-Message-State: AOJu0YxNlZfMlraRUgOG+Z+vjSwraaZCt2qOMliUVXKNveByK2rjaXf4
 PS3zu8Q4CwnI9TOtDAyarqXW4xiaDowTRj8bFzeWhmiLehYCI/i7rBgminOrew6MbmgkSsuD69+
 j6bo=
X-Google-Smtp-Source: AGHT+IGfgsZXmjxVbcD0rnQvNVUiD/uZOY4xP1iLwFSz+ySQHXhyphKMCM7a8iCvIyHaLgIaWZqarw==
X-Received: by 2002:a5d:47ac:0:b0:33d:38cf:aa76 with SMTP id
 12-20020a5d47ac000000b0033d38cfaa76mr10702068wrb.46.1708550213945; 
 Wed, 21 Feb 2024 13:16:53 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 df5-20020a5d5b85000000b0033d87557283sm997351wrb.0.2024.02.21.13.16.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:16:53 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Thomas Huth <thuth@redhat.com>
Subject: [PULL 04/25] hw/ppc/ppc4xx_pci: Extract PCI host definitions to
 hw/pci-host/ppc4xx.h
Date: Wed, 21 Feb 2024 22:16:04 +0100
Message-ID: <20240221211626.48190-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-Id: <20240215105017.57748-3-philmd@linaro.org>
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
index 7d61fb9319..9b6ce9a934 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2070,6 +2070,7 @@ F: hw/ppc/ppc4xx*.c
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


