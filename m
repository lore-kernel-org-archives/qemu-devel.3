Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BC5EE8FDD5
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPo-0002NE-Ot; Sat, 27 Dec 2025 04:16:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPn-0002Lp-3y
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPl-0002Jg-BS
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766827004;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ucdcdFeJmX6L6i+MMoj2gMbrmBI1FDIesQW4dBIATYA=;
 b=QVBhPfLg1OGRBvOc0blmRX7KN1680IyYm9pOcTRO6sRabSIRiYpoIgT3klxXQ0PFafzy8W
 ufYbOaQGdyKsfjUSz/dS9k2oJSwpLgc3YpvvbwpfiZWeeo7nlf/QbOGcSUrJGx/AkSA9Yz
 5mQnZdnwEmGhv3QIdcbfBqaXf5s+Y84=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-OlErE0vDO0qKRrEjGzfpKw-1; Sat, 27 Dec 2025 04:16:42 -0500
X-MC-Unique: OlErE0vDO0qKRrEjGzfpKw-1
X-Mimecast-MFC-AGG-ID: OlErE0vDO0qKRrEjGzfpKw_1766827001
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so54864775e9.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766827000; x=1767431800; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ucdcdFeJmX6L6i+MMoj2gMbrmBI1FDIesQW4dBIATYA=;
 b=t0cWNM9oa2GTz/o3dAINpuqTAHct0+zlNKpH2r7OOhzCM7H1aamMd0hkblbn81oxqK
 ZnZQrDlT1ktcJeO/KXJBPM6FjJbzgoSdY/bQNWnAmwHQYLPdOhoZ6jN82K99xyCpEscF
 rP6L3/ykwFQBnmwf0A+x+a02p/J8sInuseVQnVrdguwliX/aSzJ2o8sHhDOoUKYRq12y
 QrGBAX8/Ffhfb+F9ibStA8BDeytr6rFqdmN+Pcgbyzlp/aps7bNQ3KWHmpFStHALm/0l
 mFFRgOU7Z/zLs8tmrz1ViQkePJW/qU8x8uWNp2pWMw+EVu23W+Q1dogMoio0aTLglIkq
 iAqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766827000; x=1767431800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ucdcdFeJmX6L6i+MMoj2gMbrmBI1FDIesQW4dBIATYA=;
 b=J3O5VGoQ7lVwwNN30IRnymffukwRkR3fOrh6KqBG8u69hOD6+M8vfz3JpqyL1TyU4o
 4Q7MdCgvxtlKF3U5hXG3p4JWbJy7wr1qOrec8+5CQEqmb92z5WO75Ocof/0gJheVRd+U
 cEwv3yQQ+AxrxbnaLuoaTVqExGmwl9uheXdRY0DOIJP1QxOYOOiSIZbRpSNUJ8R7sS3d
 YenllOxknuSTKChZMFzjebvKrNAv04cJE4gA60VM34JxGh+glC7QDPFF1i52paIGoV1N
 Y1IdqyGiKUfqaV7HjVjKOghDxhi+DQW2mJ/aRZaO8x7y3GahcksTrMOQ2R4XNgOA8XxM
 PwUA==
X-Gm-Message-State: AOJu0YxvxY+TJoR1YMNFZKo5SLofKC0UhdcHjGpoR6USfH/sbJMisrRb
 ENZ/BSv4tmT+Fq1IWP3a2GM74k4Ok1uGzx1/5FLctSZtmQAbZWmRE8SVqWMRvM2Bt5Sw8sh5EL1
 TXJwU/8cKNMGB6m6P/nUUYs0kU/ESSOZcUJbc91ISH4JvuwCi19NM3LvkcNzMBVic5xjAT3azZO
 /z04TIPuzUgvBuaZa8i9eH+RkXQNkD2BAI++2iMkhC
X-Gm-Gg: AY/fxX6e5oHZLSE5M1OxIru4evadIBXzOyIR4RjiVuhr+2tyQLa6P6XtqiaTXUN98G+
 EyBQXxMC/hM3qPwnF98GprUkASLh9QNMtoeoXZLvl25LCMS/6/r4lBvg6c7YBdkMmjLB1WowMc7
 kmJYrsnv1htAfMFeIv1YRRa7DLSUilgxpDY4jafRSNm2pNSl1DvT9gAqTrc8utpEgv/m7nk4Qli
 IHFGk97bMbGRXfHXZ2Q9BQqlQfsg1404X80BmI36SBhwUMBF64WY78V7nz1YSXyz6DciIW0yooP
 9xORdlfJ3xCgcV83HjZ2nn+ZlluhxfR1Z5qsvDnUVDKHLECPDaX5hcfQ2sBLVG6qTb7xKlg6pj5
 YSGoKkIg5F9eZMOkiCIJ80gpKMFow1tfn8c+YD9juOp3MdkhMTaNKT9Tm3Zq238GKBa/9DZTOga
 ucyu6anm7CArPNOzw=
X-Received: by 2002:a05:600c:4e0d:b0:47b:df60:8a14 with SMTP id
 5b1f17b1804b1-47d195495d4mr276571765e9.9.1766826999959; 
 Sat, 27 Dec 2025 01:16:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRtmw0zR5TU5EN6c0439SLtVdCVyqkLe3YWwR8f8OZoBqMmyOA6nd/T400DydwXDFf4jxJpw==
X-Received: by 2002:a05:600c:4e0d:b0:47b:df60:8a14 with SMTP id
 5b1f17b1804b1-47d195495d4mr276571505e9.9.1766826999369; 
 Sat, 27 Dec 2025 01:16:39 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43277b0efefsm16766436f8f.25.2025.12.27.01.16.38
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:38 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 009/153] include: move hw/hotplug.h to hw/core/
Date: Sat, 27 Dec 2025 10:13:56 +0100
Message-ID: <20251227091622.20725-10-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/acpi/cpu.h           | 2 +-
 include/hw/acpi/cpu_hotplug.h   | 2 +-
 include/hw/acpi/pcihp.h         | 2 +-
 include/hw/{ => core}/hotplug.h | 0
 include/hw/i386/pc.h            | 2 +-
 include/hw/pci/pcie.h           | 2 +-
 include/hw/pci/shpc.h           | 2 +-
 include/hw/qdev-core.h          | 2 +-
 hw/acpi/acpi-nvdimm-stub.c      | 2 +-
 hw/acpi/piix4.c                 | 2 +-
 hw/core/hotplug.c               | 2 +-
 hw/pci-bridge/pci_bridge_dev.c  | 2 +-
 hw/pci/pci.c                    | 2 +-
 hw/pci/pcie_port.c              | 2 +-
 hw/s390x/css-bridge.c           | 2 +-
 15 files changed, 14 insertions(+), 14 deletions(-)
 rename include/hw/{ => core}/hotplug.h (100%)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 95dc58b5adb..a64d19445cc 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -17,7 +17,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/core/boards.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 #define ACPI_CPU_HOTPLUG_REG_LEN 12
 
diff --git a/include/hw/acpi/cpu_hotplug.h b/include/hw/acpi/cpu_hotplug.h
index 3b932abbbbe..5b670b04eb6 100644
--- a/include/hw/acpi/cpu_hotplug.h
+++ b/include/hw/acpi/cpu_hotplug.h
@@ -16,7 +16,7 @@
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/pc-hotplug.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/acpi/cpu.h"
 
 typedef struct AcpiCpuHotplug {
diff --git a/include/hw/acpi/pcihp.h b/include/hw/acpi/pcihp.h
index ca6a2588258..efce5fd2e10 100644
--- a/include/hw/acpi/pcihp.h
+++ b/include/hw/acpi/pcihp.h
@@ -29,7 +29,7 @@
 
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 #define ACPI_PCIHP_IO_BASE_PROP "acpi-pcihp-io-base"
 #define ACPI_PCIHP_IO_LEN_PROP "acpi-pcihp-io-len"
diff --git a/include/hw/hotplug.h b/include/hw/core/hotplug.h
similarity index 100%
rename from include/hw/hotplug.h
rename to include/hw/core/hotplug.h
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ade2da92bad..b3a45ab71a8 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -9,7 +9,7 @@
 #include "hw/block/flash.h"
 #include "hw/i386/x86.h"
 
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "qom/object.h"
 #include "hw/i386/sgx-epc.h"
 #include "hw/cxl/cxl.h"
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index 42cebcd0338..c880ae1e04b 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -25,7 +25,7 @@
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_aer.h"
 #include "hw/pci/pcie_sriov.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 typedef struct PCIEPort PCIEPort;
 typedef struct PCIESlot PCIESlot;
diff --git a/include/hw/pci/shpc.h b/include/hw/pci/shpc.h
index ad1089567a0..fce5bdd3bc7 100644
--- a/include/hw/pci/shpc.h
+++ b/include/hw/pci/shpc.h
@@ -2,7 +2,7 @@
 #define SHPC_H
 
 #include "system/memory.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/pci/pci_device.h"
 #include "migration/vmstate.h"
 
diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 5cf2db7ee11..f0ef2dc3aa8 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -7,7 +7,7 @@
 #include "qemu/rcu.h"
 #include "qemu/rcu_queue.h"
 #include "qom/object.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/resettable.h"
 
 /**
diff --git a/hw/acpi/acpi-nvdimm-stub.c b/hw/acpi/acpi-nvdimm-stub.c
index 65f491d6535..22ba17f5118 100644
--- a/hw/acpi/acpi-nvdimm-stub.c
+++ b/hw/acpi/acpi-nvdimm-stub.c
@@ -1,6 +1,6 @@
 #include "qemu/osdep.h"
 #include "hw/mem/nvdimm.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 void nvdimm_acpi_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev)
 {
diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index 7a18f18dda2..9e0892a51f8 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -35,7 +35,7 @@
 #include "qemu/range.h"
 #include "hw/acpi/cpu_hotplug.h"
 #include "hw/acpi/cpu.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/acpi/memory_hotplug.h"
diff --git a/hw/core/hotplug.c b/hw/core/hotplug.c
index 17ac9866859..68aabad8ae0 100644
--- a/hw/core/hotplug.c
+++ b/hw/core/hotplug.c
@@ -10,7 +10,7 @@
  * See the COPYING file in the top-level directory.
  */
 #include "qemu/osdep.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "qemu/module.h"
 
 void hotplug_handler_pre_plug(HotplugHandler *plug_handler,
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b328e50ab31..cb4809f38b1 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -30,7 +30,7 @@
 #include "hw/qdev-properties.h"
 #include "system/memory.h"
 #include "hw/pci/pci_bus.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "qom/object.h"
 
 #define TYPE_PCI_BRIDGE_DEV      "pci-bridge"
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e03953813c2..02a59f355b6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -45,7 +45,7 @@
 #include "trace.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/core/boards.h"
 #include "hw/nvram/fw_cfg.h"
 #include "qapi/error.h"
diff --git a/hw/pci/pcie_port.c b/hw/pci/pcie_port.c
index f3841a26568..20b5e4cfb51 100644
--- a/hw/pci/pcie_port.c
+++ b/hw/pci/pcie_port.c
@@ -22,7 +22,7 @@
 #include "hw/pci/pcie_port.h"
 #include "hw/qdev-properties.h"
 #include "qemu/module.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 
 void pcie_port_init_reg(PCIDevice *d)
 {
diff --git a/hw/s390x/css-bridge.c b/hw/s390x/css-bridge.c
index 0f87b8c5c44..f3b6ef56300 100644
--- a/hw/s390x/css-bridge.c
+++ b/hw/s390x/css-bridge.c
@@ -12,7 +12,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "hw/hotplug.h"
+#include "hw/core/hotplug.h"
 #include "hw/qdev-properties.h"
 #include "hw/sysbus.h"
 #include "qemu/bitops.h"
-- 
2.52.0


