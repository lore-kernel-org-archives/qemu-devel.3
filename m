Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD385C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 21:23:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rctxv-0002tR-NX; Wed, 21 Feb 2024 16:17:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxg-0002ct-Bk
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:04 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rctxd-0000sg-ME
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 16:17:03 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4126f486429so17014975e9.0
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 13:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708550220; x=1709155020; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rri7DRJiOpDcuu3Ysur7tkTebJnDy+J9NH64dvVvHsc=;
 b=yKuCK9IZMXL7RWbQNfHHu6bio1XXVij196jfanWQDD+Jq5c+ye+bFj/6L5wPPtdf8M
 ABf6Jnj+ndrPaoDDobrVBBKXHgpQhDLXVf4SR2bWDOQmXhbliW4qzoKtpemndlKK6OC2
 k3Eqm5isHtkrjORy9epKN5lLWJbzBsa3+E94frBaFl4qVe+TwW3DWHi0/oo19HTKF1VI
 wm7GSTN1HLZUhi2SiwoQZIJk65sshlhrbB1ks/0/DkgP/rZ8U4pBLEWGy7SLvC+kH+jD
 vDYZ25rfvdfFSON5kD85/bgHt8dSR33dPazkCMFWoVc5oZ4v9oSZS1uR6i3FYUu0D6Ab
 UEGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708550220; x=1709155020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Rri7DRJiOpDcuu3Ysur7tkTebJnDy+J9NH64dvVvHsc=;
 b=PfiE2Y2BDVrIG9XsbUpdvKcwU6M29VJZFeG0JEV2R1zI8NS6BGqWXGr//sy28xozlu
 tmRd2ZDbJy/dvXC8ZpJZ0V/5QSLccZn7UiYFKbZSqpduVcRYFkbAd+8NEe1mINyuf9+f
 70gFQPeyoLky/arq0acACf2t3dq4GQ/ahC0CdkmMZ0qzfENbmXa8VtOpsxughQSEWN14
 XczjOs1LpA2gnpazvxq1m65jgqRav1umwAWsxNFKCM6irOoReyhKt+p1BBA2CVyrZUWD
 3iwIOI8W6JtYACGl9mdIpnMRBp7ExtObEwdJkZ7xyBC5p/LRSs6i5bRYMUGM7iAZFRTg
 +sxQ==
X-Gm-Message-State: AOJu0YwqIaiE2avN06UjqREJhZSRKTFNQ1zvqg9iyNbfmLyyuXhrKAXt
 l+Yb0+5oNSVItbRP0LUE80919sxdgHyUkRz7QDFs3zAPkNtpt9CzJRfXRlwW06IWLjZAQhe7RyD
 v+hw=
X-Google-Smtp-Source: AGHT+IH1Wh8xBW9ugZWWO2zkrqqPqjgp/yg3oSNB2LxswJR5aKQKpvaOlBlAD4XlsyNmVDVL3CuUag==
X-Received: by 2002:a05:600c:4455:b0:412:7045:64c9 with SMTP id
 v21-20020a05600c445500b00412704564c9mr3946267wmn.8.1708550219867; 
 Wed, 21 Feb 2024 13:16:59 -0800 (PST)
Received: from m1x-phil.lan ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 bt27-20020a056000081b00b0033d1b653e4csm18877936wrb.54.2024.02.21.13.16.58
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 21 Feb 2024 13:16:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 05/25] hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
Date: Wed, 21 Feb 2024 22:16:05 +0100
Message-ID: <20240221211626.48190-6-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240221211626.48190-1-philmd@linaro.org>
References: <20240221211626.48190-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

ppc4xx_pci.c is moved from the target specific ppc_ss[] meson
source set to pci_ss[] which is common to all targets: the
object is built once.

Declare PPC4XX_PCI selector in pci-host/Kconfig.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20240215105017.57748-4-philmd@linaro.org>
---
 MAINTAINERS                       | 1 +
 hw/{ppc => pci-host}/ppc4xx_pci.c | 0
 hw/pci-host/ppce500.c             | 2 +-
 hw/pci-host/Kconfig               | 4 ++++
 hw/pci-host/meson.build           | 1 +
 hw/pci-host/trace-events          | 4 ++++
 hw/ppc/Kconfig                    | 2 +-
 hw/ppc/meson.build                | 1 -
 hw/ppc/trace-events               | 4 ----
 9 files changed, 12 insertions(+), 7 deletions(-)
 rename hw/{ppc => pci-host}/ppc4xx_pci.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9b6ce9a934..8d9ccd5073 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1423,6 +1423,7 @@ Bamboo
 L: qemu-ppc@nongnu.org
 S: Orphan
 F: hw/ppc/ppc440_bamboo.c
+F: hw/pci-host/ppc4xx_pci.c
 F: tests/avocado/ppc_bamboo.py
 
 e500
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/pci-host/ppc4xx_pci.c
similarity index 100%
rename from hw/ppc/ppc4xx_pci.c
rename to hw/pci-host/ppc4xx_pci.c
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index fa0d67b342..95b983b2b3 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -5,7 +5,7 @@
  *
  * Author: Yu Liu,     <yu.liu@freescale.com>
  *
- * This file is derived from hw/ppc4xx_pci.c,
+ * This file is derived from ppc4xx_pci.c,
  * the copyright for that material belongs to the original owners.
  *
  * This is free software; you can redistribute it and/or modify
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index f046d76a68..0a221e719e 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -6,6 +6,10 @@ config XEN_IGD_PASSTHROUGH
     default y
     depends on XEN && PCI_I440FX
 
+config PPC4XX_PCI
+    bool
+    select PCI
+
 config RAVEN_PCI
     bool
     select PCI
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index 36d5ab756f..eb6dc71c88 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -14,6 +14,7 @@ pci_ss.add(when: 'CONFIG_REMOTE_PCIHOST', if_true: files('remote.c'))
 pci_ss.add(when: 'CONFIG_SH_PCI', if_true: files('sh_pci.c'))
 
 # PPC devices
+pci_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
 pci_ss.add(when: 'CONFIG_RAVEN_PCI', if_true: files('raven.c'))
 pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
 # NewWorld PowerMac
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index b2f47e6335..90a37ebff0 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -37,6 +37,10 @@ unin_data_read(uint64_t addr, unsigned len, uint64_t val) "read addr 0x%"PRIx64
 unin_write(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 
+# ppc4xx_pci.c
+ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
+ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
+
 # pnv_phb4.c
 pnv_phb4_xive_notify(uint64_t notif_port, uint64_t data) "notif=@0x%"PRIx64" data=0x%"PRIx64
 pnv_phb4_xive_notify_ic(uint64_t addr, uint64_t data) "addr=@0x%"PRIx64" data=0x%"PRIx64
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 44263a58c4..82e847d22c 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -53,7 +53,7 @@ config PPC440
 config PPC4XX
     bool
     select BITBANG_I2C
-    select PCI
+    select PPC4XX_PCI
     select PPC_UIC
 
 config SAM460EX
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index eba3406e7f..d0efc0aba5 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -63,7 +63,6 @@ ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_pcix.c', 'ppc440_uc.c'))
 ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
   'ppc4xx_devs.c',
-  'ppc4xx_pci.c',
   'ppc4xx_sdram.c'))
 ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
 # PReP
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index f670e8906c..b59fbf340f 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -146,10 +146,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 
-# ppc4xx_pci.c
-ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
-ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
-
 # ppc440_pcix.c
 ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
 ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
-- 
2.41.0


