Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A083AC48260
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 08:13:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZnu2-0000VU-GR; Tue, 13 Feb 2024 03:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZnu1-0000VC-9i
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:29 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rZntr-0000jV-Mi
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 03:12:29 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5119da22560so87544e87.2
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 00:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707811938; x=1708416738; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=N8pdPclv//gTPDxcO4OPrK97h1/L6R/pG9BlhZPSR0A=;
 b=Rbu1YKDeqQD9sBjTW/ETdKbKUallfiWhwgfPuyA0bdDbljU0JjEf3gvbwxAtZRVNPA
 AxF3MJyXakXsH3+V/TreGeQF8YA6K6uqrXAjo4mt5rPvOWfTMxYFDzis0n3TCWwgrP6X
 pnuAeF4Llm4q7Uok8TjPm5pvoOj8oLJzComTaWEMj7NPb0PHRtgSSjn81oNzfCR2gfq1
 Q6Z+3kJZwgHSEgov8sA57piK2g36l4uMtv6Hv+H3IIuIuzks6xnsyLRHclvRkhqVXuy9
 pgqXurnH/IjsXr4QR4hJlulsKEQekPCNn2E183FjcpiAK0kyjY22TasIFIpTSry098k6
 5njA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707811938; x=1708416738;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=N8pdPclv//gTPDxcO4OPrK97h1/L6R/pG9BlhZPSR0A=;
 b=spIWxgov0lc1rRFeUDDL2autCoWWHrPylyKBNPhvz1ja4FM5tKDWGfPP8LEX1wril+
 GjuVUAFC+Wu/5J4rS+MJSbwtym3qZdPvzQUlpUpZmN1i1MGpw6n+7xU4qnja4n+GaMK+
 chA/C5aIJQy21AZha9+VdlEzSHi/A2lVW0uQbvCigMD8P+fd04WNQtb00MzLftXZrPpR
 Wzasik6uolfVRZwLuk4D3UZHRVWkLC0+A4SI24TOkV4wa//v12ODWmFcUsKV8+HgIwLV
 b5zl1l+u1/VJqGuYks67nZx1HWuIDkWQTVaVpY/qTDleG8KHqrIsu3LTnqBRS0bMJ30K
 DglA==
X-Gm-Message-State: AOJu0Yyqqhol8XGrJnRhrr7kO9HheDEMvZ0B/rqvfXx5lugzFkMJDkWy
 EjxZflQtOPv6HfU3Z39ctPAhwaIm9ulU4HTcIm8LN79yIvObOvI0TsFjHQMr12EMrQbVqayHMxO
 W
X-Google-Smtp-Source: AGHT+IFmPU0pAHKuf4PnM3ilzQKASgSCvcRoSruPyctlHb2aTB6CDLtAlTay4rSJFbigJkEQhVXHmw==
X-Received: by 2002:a19:8c0e:0:b0:511:9ca1:12ee with SMTP id
 o14-20020a198c0e000000b005119ca112eemr511914lfd.51.1707811937613; 
 Tue, 13 Feb 2024 00:12:17 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCV5O8aKJAF8ta5d8oV1lTUbDj+XjaNQOCUHaQvFKpq/cHbV+NItK3hFig8zdYJsjduZfp+Qu1J2YwdhTBtQJ1FfBi56lMPjVIZnw6Zf2+NdRYI0fiCrISCu7fhmqjq4yB7GS2+QT1VxrsrfVyxA9vQ4XA3yHALEapzOwY6Q9FjFW3wkOMUsQjOi/emBD77maZWbA4V8pOMScEo6LA6r99CV+X0CZvel7uPZssxi1TYFwLgYaCV+5WAvYN+i8m2Pn/M0gsP/LuHOidW78zeap7hZur6Zg6hGEOWoGCY1+bil388JbZJP8k/06YPYrJM/NM9dFpXOz119QTBuGV0Mob73zoINJa5xSKrMjw==
Received: from m1x-phil.lan ([176.176.128.243])
 by smtp.gmail.com with ESMTPSA id
 s8-20020a7bc388000000b00410bca333b7sm6493537wmj.27.2024.02.13.00.12.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 13 Feb 2024 00:12:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 John Snow <jsnow@redhat.com>, qemu-arm@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-block@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PATCH 2/9] hw/ide/ahci: Expose AHCIPCIState structure
Date: Tue, 13 Feb 2024 09:11:53 +0100
Message-ID: <20240213081201.78951-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240213081201.78951-1-philmd@linaro.org>
References: <20240213081201.78951-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

In order to be able to QOM-embed a structure, we need
its full definition. Move it from "ahci_internal.h"
to the new "hw/ide/ahci-pci.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/ide/ahci_internal.h    |  8 --------
 include/hw/ide/ahci-pci.h | 22 ++++++++++++++++++++++
 include/hw/ide/ahci.h     |  3 ---
 hw/i386/pc_q35.c          |  2 +-
 hw/ide/ahci.c             |  1 +
 hw/ide/ich.c              |  1 +
 hw/mips/boston.c          |  2 +-
 7 files changed, 26 insertions(+), 13 deletions(-)
 create mode 100644 include/hw/ide/ahci-pci.h

diff --git a/hw/ide/ahci_internal.h b/hw/ide/ahci_internal.h
index c244bbd8be..4dc2805d21 100644
--- a/hw/ide/ahci_internal.h
+++ b/hw/ide/ahci_internal.h
@@ -324,14 +324,6 @@ struct AHCIDevice {
     MemReentrancyGuard mem_reentrancy_guard;
 };
 
-struct AHCIPCIState {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    AHCIState ahci;
-};
-
 extern const VMStateDescription vmstate_ahci;
 
 #define VMSTATE_AHCI(_field, _state) {                               \
diff --git a/include/hw/ide/ahci-pci.h b/include/hw/ide/ahci-pci.h
new file mode 100644
index 0000000000..c2ee616962
--- /dev/null
+++ b/include/hw/ide/ahci-pci.h
@@ -0,0 +1,22 @@
+/*
+ * QEMU AHCI Emulation (PCI devices)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#ifndef HW_IDE_AHCI_PCI_H
+#define HW_IDE_AHCI_PCI_H
+
+#include "qom/object.h"
+#include "hw/ide/ahci.h"
+#include "hw/pci/pci_device.h"
+
+#define TYPE_ICH9_AHCI "ich9-ahci"
+OBJECT_DECLARE_SIMPLE_TYPE(AHCIPCIState, ICH9_AHCI)
+
+struct AHCIPCIState {
+    PCIDevice parent_obj;
+
+    AHCIState ahci;
+};
+
+#endif
diff --git a/include/hw/ide/ahci.h b/include/hw/ide/ahci.h
index 210e5e734c..6818d02063 100644
--- a/include/hw/ide/ahci.h
+++ b/include/hw/ide/ahci.h
@@ -52,9 +52,6 @@ typedef struct AHCIState {
 } AHCIState;
 
 
-#define TYPE_ICH9_AHCI "ich9-ahci"
-OBJECT_DECLARE_SIMPLE_TYPE(AHCIPCIState, ICH9_AHCI)
-
 int32_t ahci_get_num_ports(PCIDevice *dev);
 void ahci_ide_create_devs(PCIDevice *dev, DriveInfo **hd);
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 33a4413708..ace8d3839a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -47,7 +47,7 @@
 #include "hw/display/ramfb.h"
 #include "hw/firmware/smbios.h"
 #include "hw/ide/pci.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-pci.h"
 #include "hw/intc/ioapic.h"
 #include "hw/southbridge/ich9.h"
 #include "hw/usb.h"
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index 0eb83a6d46..aa9381a7b2 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -36,6 +36,7 @@
 #include "sysemu/dma.h"
 #include "hw/ide/internal.h"
 #include "hw/ide/pci.h"
+#include "hw/ide/ahci-pci.h"
 #include "ahci_internal.h"
 
 #include "trace.h"
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 49f8eb8a7d..d190012a95 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -69,6 +69,7 @@
 #include "hw/isa/isa.h"
 #include "sysemu/dma.h"
 #include "hw/ide/pci.h"
+#include "hw/ide/ahci-pci.h"
 #include "ahci_internal.h"
 
 #define ICH9_MSI_CAP_OFFSET     0x80
diff --git a/hw/mips/boston.c b/hw/mips/boston.c
index 4e11ff6cd6..cbcefdd693 100644
--- a/hw/mips/boston.c
+++ b/hw/mips/boston.c
@@ -24,7 +24,7 @@
 #include "hw/boards.h"
 #include "hw/char/serial.h"
 #include "hw/ide/pci.h"
-#include "hw/ide/ahci.h"
+#include "hw/ide/ahci-pci.h"
 #include "hw/loader.h"
 #include "hw/loader-fit.h"
 #include "hw/mips/bootloader.h"
-- 
2.41.0


