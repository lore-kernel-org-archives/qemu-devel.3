Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A23C54798
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Feb 2024 17:18:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reI7f-00020o-Le; Sun, 25 Feb 2024 12:17:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI7e-0001zj-5S
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:17:06 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reI7a-0003zS-KO
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 12:17:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41241f64c6bso18724005e9.0
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708881419; x=1709486219; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gkPCXbejDmS0Tz82absP8HIve4fjz8E5Jb0BUq+vylY=;
 b=PxswJHTXbL8Zp4poXKP1k7pGyEfkCalxYsgnmSVhkzdvLSczj/EWHmPbkwcbZBW9sz
 XBPq10p7vK8bQo8hoSWtLHEvzWLMgBxbRFXc15/F9yTydH02FiSKvyNIIGBz6VDB1NVK
 VLkrhH1roR60elhwcZsV41pVYrkRutT+4JnaGHlL8baHJEI94S0oelxhK5IGwDXZA5D0
 AUzx+wlap4iTVMg1ECUn43kuI8no/73aoXQDXzMS/VKyGEHu6YSlUFN7z77UvzU9OD2L
 s2ZV2RXvniJBtr3NftZW58Lu5JhBWj9XUG8EPoaPEaUNbipGNzMdOkFgLMQVmFNXeADs
 EDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708881419; x=1709486219;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gkPCXbejDmS0Tz82absP8HIve4fjz8E5Jb0BUq+vylY=;
 b=CRK2LrpDfukRkvwFV+DmxbMOgAyhiD1HT6ltQeDePjkpFRljRreIEMgWMCBZf6vaaA
 J/5yG+PGttlA4ICQxLeRipW3j8Ami+wqdfEZzyDdJXo3wrkkLmuvOepV/JW99HlDCE4G
 ZD8fIxZTTGCduqpodhOb6/OwfM9ERCEOhI5lyR/KU8KGSgvoQuM9z9AMi5iwvSHdGZXN
 HSjbPtNRXSeAVx9g1d9PTLyzr0UN6oXv6lyJbEEz3sXpRlaDySmfhYunTXMzm2upTHCO
 jVktBNYvoH0XOH0BfOpHY9oSPj3gNuVQZAtSIAe6rS2uqVdhdSchCF9OUjOWfq5IGN92
 eVRA==
X-Gm-Message-State: AOJu0YwJFUrFWAR0iUPp3IxLky0M6mBRDQiD5mVZ0kTc206sEhwKv/e3
 0hz+6Z8g5PsSaRqjKnF98onET/bs4qX9ZX3VtUldRNkwnQXZ0x4JUZ2bRG0x0wAeTEsGABXfGWK
 a
X-Google-Smtp-Source: AGHT+IHh6Q3za8EeVMvVjlK3VJ2iyARIPfPBTjiEEn9RVLvvDerbGgVVn/Up/r7f1k45LZPGfG4eKQ==
X-Received: by 2002:a5d:4802:0:b0:33d:c2cb:c18d with SMTP id
 l2-20020a5d4802000000b0033dc2cbc18dmr2468095wrq.32.1708881419242; 
 Sun, 25 Feb 2024 09:16:59 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a5d4e83000000b0033d12895cfdsm5591435wru.61.2024.02.25.09.16.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Feb 2024 09:16:58 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, Radoslaw Biernacki <rad@semihalf.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 3/3] hw/ide: Include 'ide_internal.h' from current path
Date: Sun, 25 Feb 2024 18:16:37 +0100
Message-ID: <20240225171637.4709-4-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240225171637.4709-1-philmd@linaro.org>
References: <20240225171637.4709-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

Rename "internal.h" as "ide_internal.h", and include
it via its relative local path, instead of absolute
to the project root path.

Mechanical patch doing:

  $ sed -i -e 's#hw/ide/internal.h#ide_internal.h#' \
        $(git grep -l hw/ide/internal)
  $ git mv hw/ide/internal.h hw/ide/ide_internal.h

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci_internal.h                | 2 +-
 hw/ide/{internal.h => ide_internal.h} | 0
 hw/ide/ahci.c                         | 2 +-
 hw/ide/atapi.c                        | 2 +-
 hw/ide/cmd646.c                       | 2 +-
 hw/ide/core.c                         | 2 +-
 hw/ide/ide-bus.c                      | 2 +-
 hw/ide/ide-dev.c                      | 2 +-
 hw/ide/ioport.c                       | 2 +-
 hw/ide/isa.c                          | 2 +-
 hw/ide/macio.c                        | 2 +-
 hw/ide/microdrive.c                   | 2 +-
 hw/ide/mmio.c                         | 2 +-
 hw/ide/pci.c                          | 2 +-
 hw/ide/piix.c                         | 2 +-
 hw/ide/sii3112.c                      | 2 +-
 hw/ide/via.c                          | 2 +-
 17 files changed, 16 insertions(+), 16 deletions(-)
 rename hw/ide/{internal.h => ide_internal.h} (100%)

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index 4e13329bb2..34f3d50ca9 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -25,7 +25,7 @@
 #define HW_IDE_AHCI_INTERNAL_H
 
 #include "hw/ide/ahci.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/pci/pci_device.h"
 
 #define AHCI_MEM_BAR_SIZE         0x1000
diff --git a/hw/ide/internal.h b/hw/ide/ide_internal.h
similarity index 100%
rename from hw/ide/internal.h
rename to hw/ide/ide_internal.h
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 54c9685495..c2af344ac5 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -34,7 +34,7 @@
 #include "qemu/module.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/ide/pci.h"
 #include "hw/ide/ahci-pci.h"
 #include "hw/ide/ahci-sysbus.h"
diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
index dcc39df9a4..8ac99f64d2 100644
--- a/hw/ide/atapi.c
+++ b/hw/ide/atapi.c
@@ -24,7 +24,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/scsi/scsi.h"
 #include "sysemu/block-backend.h"
 #include "scsi/constants.h"
diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index 23d213ff01..be72f4d3ed 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -33,7 +33,7 @@
 #include "sysemu/reset.h"
 
 #include "hw/ide/pci.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "trace.h"
 
 /* CMD646 specific */
diff --git a/hw/ide/core.c b/hw/ide/core.c
index 9c4a812902..8f2004f93b 100644
--- a/hw/ide/core.c
+++ b/hw/ide/core.c
@@ -41,7 +41,7 @@
 #include "qemu/cutils.h"
 #include "sysemu/replay.h"
 #include "sysemu/runstate.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "trace.h"
 
 /* These values were based on a Seagate ST3500418AS but have been modified
diff --git a/hw/ide/ide-bus.c b/hw/ide/ide-bus.c
index 57fe67b29c..32e9f62137 100644
--- a/hw/ide/ide-bus.c
+++ b/hw/ide/ide-bus.c
@@ -21,7 +21,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/runstate.h"
diff --git a/hw/ide/ide-dev.c b/hw/ide/ide-dev.c
index c8e2033469..832293ca69 100644
--- a/hw/ide/ide-dev.c
+++ b/hw/ide/ide-dev.c
@@ -23,7 +23,7 @@
 #include "qemu/error-report.h"
 #include "qemu/module.h"
 #include "hw/ide/ide-dev.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
 #include "sysemu/sysemu.h"
diff --git a/hw/ide/ioport.c b/hw/ide/ioport.c
index 0b283ac783..7a80c549ec 100644
--- a/hw/ide/ioport.c
+++ b/hw/ide/ioport.c
@@ -25,7 +25,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/isa/isa.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "trace.h"
 
 int ide_init_ioport(IDEBus *bus, ISADevice *dev, int iobase, int iobase2)
diff --git a/hw/ide/isa.c b/hw/ide/isa.c
index cc865c83dc..2fc28d64b6 100644
--- a/hw/ide/isa.c
+++ b/hw/ide/isa.c
@@ -32,7 +32,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/isa.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "qom/object.h"
 
 /***********************************************************/
diff --git a/hw/ide/macio.c b/hw/ide/macio.c
index 0d2c6ba910..7611a99ef5 100644
--- a/hw/ide/macio.c
+++ b/hw/ide/macio.c
@@ -33,7 +33,7 @@
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
 
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 
 /* debug MACIO */
 // #define DEBUG_MACIO
diff --git a/hw/ide/microdrive.c b/hw/ide/microdrive.c
index a7f415f0fc..09781658f9 100644
--- a/hw/ide/microdrive.c
+++ b/hw/ide/microdrive.c
@@ -31,7 +31,7 @@
 #include "sysemu/dma.h"
 #include "hw/irq.h"
 
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "qom/object.h"
 
 #define TYPE_MICRODRIVE "microdrive"
diff --git a/hw/ide/mmio.c b/hw/ide/mmio.c
index e8f41c0610..1ba2541b40 100644
--- a/hw/ide/mmio.c
+++ b/hw/ide/mmio.c
@@ -30,7 +30,7 @@
 #include "sysemu/dma.h"
 
 #include "hw/ide/mmio.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/qdev-properties.h"
 
 /***********************************************************/
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index 73efeec7f4..855cbb031d 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -30,7 +30,7 @@
 #include "sysemu/dma.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/ide/pci.h"
 #include "trace.h"
 
diff --git a/hw/ide/piix.c b/hw/ide/piix.c
index 1773a068c3..886cf840f1 100644
--- a/hw/ide/piix.c
+++ b/hw/ide/piix.c
@@ -30,7 +30,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/pci/pci.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/ide/piix.h"
 #include "hw/ide/pci.h"
 #include "trace.h"
diff --git a/hw/ide/sii3112.c b/hw/ide/sii3112.c
index 321b9e46a1..e28bbd160d 100644
--- a/hw/ide/sii3112.c
+++ b/hw/ide/sii3112.c
@@ -13,7 +13,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/ide/pci.h"
 #include "qemu/module.h"
 #include "trace.h"
diff --git a/hw/ide/via.c b/hw/ide/via.c
index cf151e70ec..ceecb3aa01 100644
--- a/hw/ide/via.c
+++ b/hw/ide/via.c
@@ -25,7 +25,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/ide/internal.h"
+#include "ide_internal.h"
 #include "hw/pci/pci.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-- 
2.41.0


