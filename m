Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D0EDC4828F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Feb 2024 09:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXdzk-0005Sj-5Y; Wed, 07 Feb 2024 04:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdzf-0005Q5-NB
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:24 -0500
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rXdze-0008Ku-2D
 for qemu-devel@nongnu.org; Wed, 07 Feb 2024 04:13:23 -0500
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a3832ef7726so45363266b.0
 for <qemu-devel@nongnu.org>; Wed, 07 Feb 2024 01:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707297200; x=1707902000; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CLIvO5yt2v6iz48I5tKRmsspXhcoptGguz7s2UGjGhU=;
 b=kCTPCp/AaRMIJ6fC1sUbRANrOcn1q3Xn4o/Fblp698uIgk4ASwWvoFJWAGSfla4A/u
 GDW/myrepr9QIBCLBRZByilZRGmLiaFzZfpttVrmAmeqOPXH2/Ljzz3fgwoPWOiEYkOx
 GyTk9NyTFbX5BUNcssymxKda3S0ZORiz6U+KwUinrYBik0+4dYc86leB7BOTpfd4J4N6
 eKfFQ3UJXD6aEtAQphzoKL+AutQLwOjWJZLsTGg+2vffPZDsYFJDoy0WPwYR1xcJFwGi
 CgkdpxJclXR5prvg0NeYkA4oEM0LOKiRpSHBwK8XfULBWOFte0VCRxErf2u8hFY690cP
 DKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707297200; x=1707902000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CLIvO5yt2v6iz48I5tKRmsspXhcoptGguz7s2UGjGhU=;
 b=G3+Wv0HvaSuF6dN73eZ+q1P8TKok24Xws0r4mV7WEsyTLk0iaKV+oISyXkiC83eWAl
 ke3GElTOW/extn68F9ec6AEB5atwegrAhN2klmuribP1OKRrwx+FHw+g9L07RnqARljU
 lRQ73rkyXOMwcEPu9UWFGbJ6zd5ODX6+hgcHTLqdNKrDdeUX36PTZ58tGmiNutOpgp61
 peFpNUiI9JPQbF/VMHFyFAjRBjxXD1SPDgEL2XM2ESW7r6zDCGgvykGcLUenI0H9AH8j
 XKmcHT3LG1Q0ZbxagRyq5ZnaMT8A6wxdz9Rt245q+mVxppJPMwvBpXaiN6OsCtTPhKqV
 Ujrg==
X-Gm-Message-State: AOJu0Yz12v+9ZZNyH+z/NEJF9/uGuctplxNFYwlBTKjKidAcs0NHlxXp
 fZpjpUG5uVYXjeDYyhibVifEpgsKRQYtsH7a8KM8oqwVlYQSzlUNllRditQQvItJaUfylTLGrEz
 K
X-Google-Smtp-Source: AGHT+IGxv+xgIqJzDYSqPL9HdYDYlMKkrIdmByLxu7EtUgK+6oxrr7gN8b0Iwy9XC1QdH7jfub50Rw==
X-Received: by 2002:a17:907:7791:b0:a38:7171:e832 with SMTP id
 ky17-20020a170907779100b00a387171e832mr866963ejc.32.1707297200021; 
 Wed, 07 Feb 2024 01:13:20 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVXvJM8Abm/Lo9YPdc4HJ2GV9NcB8x8JKV7ELA3XRPZB1KkCW6XBmVhuIHI0E4dieMt/D8smeoz7G514P5irK9YiJfRIsM3BB8WNxR6FhufVoFpXovhSw/gT4g9HstkRpO+l38OyrJ0ls08ku7jWLU11m5WD/fMEjCE10oWCl6VXIRPI0A0fjKLU/29HdauepD5opz3lPHVzmnzGy/+Ws3rxx4B/6+1JpEEhTwsSLnRr9z79shmpZw=
Received: from m1x-phil.lan ([176.176.170.22])
 by smtp.gmail.com with ESMTPSA id
 h9-20020a17090619c900b00a35ed4fd4cesm526799ejd.115.2024.02.07.01.13.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 07 Feb 2024 01:13:19 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/4] hw/ppc/ppc440_pcix: Move ppc440_pcix.c to hw/pci-host/
Date: Wed,  7 Feb 2024 10:12:54 +0100
Message-ID: <20240207091254.1478-5-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240207091254.1478-1-philmd@linaro.org>
References: <20240207091254.1478-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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

ppc440_pcix.c is moved from the target specific ppc_ss[] meson
source set to pci_ss[] which is common to all targets: the
object is built once.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                        | 2 +-
 hw/{ppc => pci-host}/ppc440_pcix.c | 0
 hw/pci-host/Kconfig                | 4 ++++
 hw/pci-host/meson.build            | 1 +
 hw/pci-host/trace-events           | 8 ++++++++
 hw/ppc/Kconfig                     | 1 +
 hw/ppc/meson.build                 | 2 +-
 hw/ppc/trace-events                | 8 --------
 8 files changed, 16 insertions(+), 10 deletions(-)
 rename hw/{ppc => pci-host}/ppc440_pcix.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1927530c2d..42e63ed696 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1554,7 +1554,7 @@ L: qemu-ppc@nongnu.org
 S: Maintained
 F: hw/ppc/sam460ex.c
 F: hw/ppc/ppc440_uc.c
-F: hw/ppc/ppc440_pcix.c
+F: hw/pci-host/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
 F: hw/rtc/m41t80.c
diff --git a/hw/ppc/ppc440_pcix.c b/hw/pci-host/ppc440_pcix.c
similarity index 100%
rename from hw/ppc/ppc440_pcix.c
rename to hw/pci-host/ppc440_pcix.c
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 0a221e719e..b348cacadb 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -10,6 +10,10 @@ config PPC4XX_PCI
     bool
     select PCI
 
+config PPC440_PCI
+    bool
+    select PCI
+
 config RAVEN_PCI
     bool
     select PCI
diff --git a/hw/pci-host/meson.build b/hw/pci-host/meson.build
index eb6dc71c88..83cf3a1783 100644
--- a/hw/pci-host/meson.build
+++ b/hw/pci-host/meson.build
@@ -15,6 +15,7 @@ pci_ss.add(when: 'CONFIG_SH_PCI', if_true: files('sh_pci.c'))
 
 # PPC devices
 pci_ss.add(when: 'CONFIG_PPC4XX_PCI', if_true: files('ppc4xx_pci.c'))
+pci_ss.add(when: 'CONFIG_PPC440_PCI', if_true: files('ppc440_pcix.c'))
 pci_ss.add(when: 'CONFIG_RAVEN_PCI', if_true: files('raven.c'))
 pci_ss.add(when: 'CONFIG_GRACKLE_PCI', if_true: files('grackle.c'))
 # NewWorld PowerMac
diff --git a/hw/pci-host/trace-events b/hw/pci-host/trace-events
index 90a37ebff0..0a816b9aa1 100644
--- a/hw/pci-host/trace-events
+++ b/hw/pci-host/trace-events
@@ -41,6 +41,14 @@ unin_read(uint64_t addr, uint64_t value) "addr=0x%" PRIx64 " val=0x%"PRIx64
 ppc4xx_pci_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
 ppc4xx_pci_set_irq(int irq_num) "PCI irq %d"
 
+# ppc440_pcix.c
+ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
+ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
+ppc440_pcix_update_pim(int idx, uint64_t size, uint64_t la) "Added window %d of size=0x%" PRIx64 " to CPU=0x%" PRIx64
+ppc440_pcix_update_pom(int idx, uint32_t size, uint64_t la, uint64_t pcia) "Added window %d of size=0x%x from CPU=0x%" PRIx64 " to PCI=0x%" PRIx64
+ppc440_pcix_reg_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
+ppc440_pcix_reg_write(uint64_t addr, uint32_t val, uint32_t size) "addr 0x%" PRIx64 " = 0x%" PRIx32 " size 0x%" PRIx32
+
 # pnv_phb4.c
 pnv_phb4_xive_notify(uint64_t notif_port, uint64_t data) "notif=@0x%"PRIx64" data=0x%"PRIx64
 pnv_phb4_xive_notify_ic(uint64_t addr, uint64_t data) "addr=@0x%"PRIx64" data=0x%"PRIx64
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 82e847d22c..2da6c16186 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -46,6 +46,7 @@ config PPC440
     imply TEST_DEVICES
     imply E1000_PCI
     select PCI_EXPRESS
+    select PPC440_PCI
     select PPC4XX
     select SERIAL
     select FDT_PPC
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
index d0efc0aba5..da14fccce5 100644
--- a/hw/ppc/meson.build
+++ b/hw/ppc/meson.build
@@ -60,7 +60,7 @@ ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
   'ppc405_uc.c'))
 ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
   'ppc440_bamboo.c',
-  'ppc440_pcix.c', 'ppc440_uc.c'))
+  'ppc440_uc.c'))
 ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
   'ppc4xx_devs.c',
   'ppc4xx_sdram.c'))
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index b59fbf340f..157ea756e9 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -146,14 +146,6 @@ rs6000mc_size_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 rs6000mc_size_write(uint32_t addr, uint32_t val) "write addr=0x%x val=0x%x"
 rs6000mc_parity_read(uint32_t addr, uint32_t val) "read addr=0x%x val=0x%x"
 
-# ppc440_pcix.c
-ppc440_pcix_map_irq(int32_t devfn, int irq_num, int slot) "devfn 0x%x irq %d -> %d"
-ppc440_pcix_set_irq(int irq_num) "PCI irq %d"
-ppc440_pcix_update_pim(int idx, uint64_t size, uint64_t la) "Added window %d of size=0x%" PRIx64 " to CPU=0x%" PRIx64
-ppc440_pcix_update_pom(int idx, uint32_t size, uint64_t la, uint64_t pcia) "Added window %d of size=0x%x from CPU=0x%" PRIx64 " to PCI=0x%" PRIx64
-ppc440_pcix_reg_read(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
-ppc440_pcix_reg_write(uint64_t addr, uint32_t val, uint32_t size) "addr 0x%" PRIx64 " = 0x%" PRIx32 " size 0x%" PRIx32
-
 # ppc405_boards.c
 opba_readb(uint64_t addr, uint32_t val) "addr 0x%" PRIx64 " = 0x%" PRIx32
 opba_writeb(uint64_t addr, uint64_t val) "addr 0x%" PRIx64 " = 0x%" PRIx64
-- 
2.41.0


