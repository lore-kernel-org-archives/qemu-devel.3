Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96F12C0218C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2025 01:24:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1talwj-0001ne-QA; Wed, 22 Jan 2025 20:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1talwi-0001nV-BB
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:23:48 -0500
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gustavo.romero@linaro.org>)
 id 1talwg-0005Dd-En
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 20:23:48 -0500
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ee786b3277so563180a91.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2025 17:23:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737595424; x=1738200224; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fB0l760Z+HTTNLq/bpM+BYuFk5FnmF0utBf+aW4qcPg=;
 b=d8ZO5nA0s/1oLqpHmiSEMQbz5g4iADCVyQC76BhIYbv5V1+14xudsCEoTOkhNRn13w
 SMtNJx39SS5HPWwBOgT6yiBosluZs31Xoo4p0PetZYV9h/Ldg6BPaHNofQETGt3L1+O/
 Nmdl3QGL5yT664RsVvwJxPVMy+6rwEotPtKBDoeduwOEpz0icSfTF9qFCIdujaHU3+se
 S6xEtpC7v7I5E+Kr1IXTo+LGDHp20hvwfSEptzHUjnVicyIIOhq7q20SPv0Pn2XeYF8y
 9J7GXFc0AqobzVWyh7vJZdSQSWyTyUSHKN2LPZjYstUTOTjTjf3tJiPm1UuJYz2QifZT
 ojqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737595424; x=1738200224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fB0l760Z+HTTNLq/bpM+BYuFk5FnmF0utBf+aW4qcPg=;
 b=tRr9xrV3M9p2ws2qtdu1QeyQ+ehBibjJTB6FYu6cEWSt9Xu223n2UXGeDLV/7d5o7Q
 VUAuHnGcgstmD+I8qqId6MFL+bJFT8akP9Rm+6va8G5IwbjJr17JT6P3BBFJoMHarDks
 f2Oo9LF87R58m3HXOjMUnhg6XZ5Ln0KGp3oP8S5W/QKzs9P8qtSVj7dLyMP8XbnDsbCl
 DFrYbZEATZBK+OtUqifPgh/DKcR3HVLYZqKoT1klSmeQXsU29utDLv39ywlGA3ZoKQx9
 1p9GbwjJvyPvlb9z9aVXnTWsFLe3gZw11UVvcUieS5x7i2BOkXr0nbWm6sdegvgrDVkt
 3dyQ==
X-Gm-Message-State: AOJu0YzKffa5pOxMK1X34hYz585CJsf1s68GqpdLbDsIQwkwuWOFRBCs
 esAvHOYF+yfJyKGEvK65qaxwDCTcpPqO3n79Uy0Kj4nY0/4FGmrcalNu+oSyY37dZ0M48dI9M8C
 n
X-Gm-Gg: ASbGncv0S7zbkJe3cyyMPNc9KtY7sY4sjG2w73U+fJy4KjiVh4gcDk/qT331d94cqvX
 YmmelqepxdsOsza/26Bb/fvoUBedtOBqeNO/BGTiW3X3jEe9y4lckWLTQLEjdoWyRq8YwZb54ac
 1OAoEXtEwXfvotx6dbn+DdWmR560TSak5itMKz58OwgFE0bH+w8Odp0VKwU2Kr52jjJ7OoHMz88
 3zYYCaWondTDZG8FdDA3SJ+xWP1Hg1jZrgQkxzVE6BBGVhQmpea3hnf6Z1u0/ki9LSYdW+Sqnho
 bni3U1BS6Js=
X-Google-Smtp-Source: AGHT+IHhM5UjPENGvUuNl1WjMT4YiP8llP5Sk1WHqQot0XOOoWeK7kBK58ZBPaB2jYOtJLJUmkjcsw==
X-Received: by 2002:a17:90b:2dc6:b0:2ee:d63f:d8f with SMTP id
 98e67ed59e1d1-2f782c787f3mr34649811a91.13.1737595424474; 
 Wed, 22 Jan 2025 17:23:44 -0800 (PST)
Received: from gromero0.. ([191.205.214.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f7e6a5e389sm2498793a91.4.2025.01.22.17.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2025 17:23:43 -0800 (PST)
From: Gustavo Romero <gustavo.romero@linaro.org>
To: qemu-devel@nongnu.org,
	philmd@linaro.org,
	armbru@redhat.com
Cc: alex.bennee@linaro.org,
	gustavo.romero@linaro.org
Subject: [PATCH v2 1/2] hw/misc/ivshmem-pci: Rename remaining parts for
 consistency
Date: Thu, 23 Jan 2025 01:22:11 +0000
Message-Id: <20250123012212.716499-2-gustavo.romero@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250123012212.716499-1-gustavo.romero@linaro.org>
References: <20250123012212.716499-1-gustavo.romero@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=gustavo.romero@linaro.org; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

For consistency, rename the remaining parts of ivshmem PCI device after
it was renamed from ivshmem to ivshmem-pci.

Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
---
 contrib/ivshmem-client/ivshmem-client.h              | 2 +-
 contrib/ivshmem-server/ivshmem-server.h              | 2 +-
 docs/system/device-emulation.rst                     | 2 +-
 docs/system/devices/ivshmem-flat.rst                 | 2 +-
 docs/system/devices/{ivshmem.rst => ivshmem-pci.rst} | 4 ++--
 hw/misc/Kconfig                                      | 4 ++--
 hw/misc/ivshmem-pci.c                                | 2 +-
 hw/misc/meson.build                                  | 4 ++--
 include/hw/misc/{ivshmem.h => ivshmem-pci.h}         | 6 +++---
 tests/qtest/meson.build                              | 2 +-
 10 files changed, 15 insertions(+), 15 deletions(-)
 rename docs/system/devices/{ivshmem.rst => ivshmem-pci.rst} (96%)
 rename include/hw/misc/{ivshmem.h => ivshmem-pci.h} (88%)

diff --git a/contrib/ivshmem-client/ivshmem-client.h b/contrib/ivshmem-client/ivshmem-client.h
index fc45a38060..9b0b24ce69 100644
--- a/contrib/ivshmem-client/ivshmem-client.h
+++ b/contrib/ivshmem-client/ivshmem-client.h
@@ -22,7 +22,7 @@
 #include <sys/select.h>
 
 #include "qemu/queue.h"
-#include "hw/misc/ivshmem.h"
+#include "hw/misc/ivshmem-pci.h"
 
 /**
  * Maximum number of notification vectors supported by the client
diff --git a/contrib/ivshmem-server/ivshmem-server.h b/contrib/ivshmem-server/ivshmem-server.h
index d870adb6a0..a8c1a6d5fb 100644
--- a/contrib/ivshmem-server/ivshmem-server.h
+++ b/contrib/ivshmem-server/ivshmem-server.h
@@ -30,7 +30,7 @@
 
 #include "qemu/event_notifier.h"
 #include "qemu/queue.h"
-#include "hw/misc/ivshmem.h"
+#include "hw/misc/ivshmem-pci.h"
 
 /**
  * Maximum number of notification vectors supported by the server
diff --git a/docs/system/device-emulation.rst b/docs/system/device-emulation.rst
index a1b0d7997e..137371eaf7 100644
--- a/docs/system/device-emulation.rst
+++ b/docs/system/device-emulation.rst
@@ -85,7 +85,7 @@ Emulated Devices
    devices/can.rst
    devices/ccid.rst
    devices/cxl.rst
-   devices/ivshmem.rst
+   devices/ivshmem-pci.rst
    devices/ivshmem-flat.rst
    devices/keyboard.rst
    devices/net.rst
diff --git a/docs/system/devices/ivshmem-flat.rst b/docs/system/devices/ivshmem-flat.rst
index 1f97052804..ccdceef171 100644
--- a/docs/system/devices/ivshmem-flat.rst
+++ b/docs/system/devices/ivshmem-flat.rst
@@ -17,7 +17,7 @@ running Linux), and an arm VM (using the ivshmem-flat device and running Zephyr
 instead).
 
 The ivshmem-flat device does not support the use of a ``memdev`` option (see
-ivshmem.rst for more details). It relies on the ivshmem server to create and
+ivshmem-pci.rst for more details). It relies on the ivshmem server to create and
 distribute the proper shared memory file descriptor and the eventfd(s) to notify
 (interrupt) the peers. Therefore, to use this device, it is always necessary to
 have an ivshmem server up and running for proper device creation.
diff --git a/docs/system/devices/ivshmem.rst b/docs/system/devices/ivshmem-pci.rst
similarity index 96%
rename from docs/system/devices/ivshmem.rst
rename to docs/system/devices/ivshmem-pci.rst
index ce71e25663..4cd434e2db 100644
--- a/docs/system/devices/ivshmem.rst
+++ b/docs/system/devices/ivshmem-pci.rst
@@ -1,5 +1,5 @@
-Inter-VM Shared Memory device
------------------------------
+Inter-VM Shared Memory PCI device
+---------------------------------
 
 On Linux hosts, a shared memory device is available. The basic syntax
 is:
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 8f9ce2f68c..366c7e295f 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -67,12 +67,12 @@ config MACIO
     select MAC_NVRAM
     select MOS6522
 
-config IVSHMEM_DEVICE
+config IVSHMEM_PCI
     bool
     default y if PCI_DEVICES
     depends on PCI && LINUX && IVSHMEM && MSI_NONBROKEN
 
-config IVSHMEM_FLAT_DEVICE
+config IVSHMEM_FLAT
     bool
     default y
     depends on LINUX && IVSHMEM
diff --git a/hw/misc/ivshmem-pci.c b/hw/misc/ivshmem-pci.c
index 900d523334..8f9cd94f42 100644
--- a/hw/misc/ivshmem-pci.c
+++ b/hw/misc/ivshmem-pci.c
@@ -37,7 +37,7 @@
 #include "system/hostmem.h"
 #include "qapi/visitor.h"
 
-#include "hw/misc/ivshmem.h"
+#include "hw/misc/ivshmem-pci.h"
 #include "qom/object.h"
 
 #define PCI_VENDOR_ID_IVSHMEM   PCI_VENDOR_ID_REDHAT_QUMRANET
diff --git a/hw/misc/meson.build b/hw/misc/meson.build
index 55f493521b..0459820332 100644
--- a/hw/misc/meson.build
+++ b/hw/misc/meson.build
@@ -38,8 +38,8 @@ system_ss.add(when: 'CONFIG_SIFIVE_U_PRCI', if_true: files('sifive_u_prci.c'))
 subdir('macio')
 
 # ivshmem devices
-system_ss.add(when: 'CONFIG_IVSHMEM_DEVICE', if_true: files('ivshmem-pci.c'))
-system_ss.add(when: 'CONFIG_IVSHMEM_FLAT_DEVICE', if_true: files('ivshmem-flat.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_PCI', if_true: files('ivshmem-pci.c'))
+system_ss.add(when: 'CONFIG_IVSHMEM_FLAT', if_true: files('ivshmem-flat.c'))
 
 system_ss.add(when: 'CONFIG_ALLWINNER_SRAMC', if_true: files('allwinner-sramc.c'))
 system_ss.add(when: 'CONFIG_ALLWINNER_A10_CCM', if_true: files('allwinner-a10-ccm.c'))
diff --git a/include/hw/misc/ivshmem.h b/include/hw/misc/ivshmem-pci.h
similarity index 88%
rename from include/hw/misc/ivshmem.h
rename to include/hw/misc/ivshmem-pci.h
index 433ef53d79..c00b39c0cd 100644
--- a/include/hw/misc/ivshmem.h
+++ b/include/hw/misc/ivshmem-pci.h
@@ -17,9 +17,9 @@
  * Contributions after 2012-01-13 are licensed under the terms of the
  * GNU GPL, version 2 or (at your option) any later version.
  */
-#ifndef IVSHMEM_H
-#define IVSHMEM_H
+#ifndef IVSHMEM_PCI_H
+#define IVSHMEM_PCI_H
 
 #define IVSHMEM_PROTOCOL_VERSION 0
 
-#endif /* IVSHMEM_H */
+#endif /* IVSHMEM_PCI_H */
diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 94b28e5a53..80f15185ca 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -37,7 +37,7 @@ endif
 
 qtests_pci = \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : []) +                  \
-  (config_all_devices.has_key('CONFIG_IVSHMEM_DEVICE') ? ['ivshmem-test'] : [])
+  (config_all_devices.has_key('CONFIG_IVSHMEM_PCI') ? ['ivshmem-test'] : [])
 
 qtests_cxl = \
   (config_all_devices.has_key('CONFIG_CXL') ? ['cxl-test'] : [])
-- 
2.34.1


