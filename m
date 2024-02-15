Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB1A4C48BEF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 10:51:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raZKG-0001vz-6O; Thu, 15 Feb 2024 05:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZKE-0001vV-Q9
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:42 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1raZKD-0007br-3l
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 05:50:42 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso158984a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 02:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707994239; x=1708599039; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yhZzQzmhVddUlJgteVfeViS+t3SxqCZ/XKPCSY22WK8=;
 b=MxXROj9PoStTbIwDZaER9h2hL7N4m1OzL584T3dbQIG4YJCdNn6Xzk3Ef/ec/XVxrH
 BdvWlLbnzSe2cXPQjqf1q0u8ZKWk9xfI0mDCSxZw3BOr689J2RGTK2q4CaaQBFtO7vvF
 0A5p9Xk50g6xeAQp0VtxeQj1FHosEXBN0vTnBV+qiBd6yVkR3OKFOvmytUszulAa+/H6
 /nV/Qubq5LEgVij48yu/4OAuDWKMCISqGOSqBy19AlJUdSdgSf4ZfcpWFLGQtkON/HPv
 ZoRsitZfhmHe5BiaLSN1t+BGn+3MJ8le7GYb3PHeedPJd2v8hMZ5kwt2gnR3BuEW+pya
 iiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707994239; x=1708599039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhZzQzmhVddUlJgteVfeViS+t3SxqCZ/XKPCSY22WK8=;
 b=gYcdIL8yejpZjoyUVVrk5i4GuWLULYryqeWJnIkGRY0TFX/bvKNiAqNQ1UVXMYSYpk
 Z/LaXFKvna4HUweB0VVwIP85/gMXLf5lZhJjVC28BI4JOoOgssyMViF2VCvvtC3bZMBp
 a+8kWJlPc0QtC4vcNVv8bsU/0wZeFRzc3IpvvFQLGTvKbismkZ5cjWgFhz3tFC2Y0jy1
 CvXRlatZrawxNMLSQe5fawGLD9SLNxAmOBCnniAcm4XxLgiYqQ+WZ0Y38uwBIe2CRY6g
 kR7R46ZYLI/YRdvjHs1cf5wGn0P3oRtpWcr0wBJp3dh7RZafIyaxvHUJZ8pv9664MAOj
 GbeA==
X-Gm-Message-State: AOJu0YwcaWEGE9UHvORq4KRyowm7HCH/8hxzJncgQC22WWhhP7NvJdxA
 lW9Cs+wkRzHK8fWpdUiR02h2yYARQRzIqnhWvd2OwubD/yUXNjJmJ/Yf2x5xPv2F+EjgrjeQdzu
 wiIQ=
X-Google-Smtp-Source: AGHT+IHStNOwJ6wDjlukmt335wQymkGoA+NuiP9pN5Dwx2RbQitG08j3vwhx5KJHXigdX5nX9+4Z6A==
X-Received: by 2002:a17:906:851:b0:a3c:c5ee:fd84 with SMTP id
 f17-20020a170906085100b00a3cc5eefd84mr1204389ejd.48.1707994239154; 
 Thu, 15 Feb 2024 02:50:39 -0800 (PST)
Received: from localhost.localdomain ([92.88.170.215])
 by smtp.gmail.com with ESMTPSA id
 wb3-20020a170907d50300b00a3d2e690abfsm413344ejc.122.2024.02.15.02.50.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 02:50:38 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Nicholas Piggin <npiggin@gmail.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 3/4] hw/ppc/ppc4xx_pci: Move ppc4xx_pci.c to hw/pci-host/
Date: Thu, 15 Feb 2024 11:50:15 +0100
Message-ID: <20240215105017.57748-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215105017.57748-1-philmd@linaro.org>
References: <20240215105017.57748-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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
index a9458121d9..b24f7e7e60 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1421,6 +1421,7 @@ Bamboo
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


