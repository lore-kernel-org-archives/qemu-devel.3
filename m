Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B69CC48BC4
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 18:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rag5m-0003Zn-Mo; Thu, 15 Feb 2024 13:04:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag50-0000bY-19
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:26 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rag4v-00036Y-GI
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 13:03:24 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a34c5ca2537so143203766b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 10:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708020198; x=1708624998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zv0rwoijSdDo8xIDgkkDnlRfaEZ/bLwEpbnDkMeyuSU=;
 b=w5pvYt96CON05tBbhV+mBu1jCQVTvHsuLrNahQcc3PFchz+4XMbAnjFBnJby2xJj/I
 pcM6/99+Gpdtshho/EjJcHNnREIVh3Oc2cRpDUOXTXILOPZfblCSyaY1Y9RABXX6LbKL
 sepO7B1F38mAtCRl44qCo3uM3b/1i/OCjl33AnELcC0K3GQdV+fcskez90JjLNiWL3mB
 cfw6TexiP6kjCezpms0umHVv9s0nPN+zH9B2flxbA5gYXDkDtoVYezWLCFq/2QvS2Can
 7sTcfA3HEe9+e8XuAQfWwR9jyo5C1aFi9qJfTHvUmd2aNbytwobGXKzyoNSm4OioNYKr
 3uCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708020198; x=1708624998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zv0rwoijSdDo8xIDgkkDnlRfaEZ/bLwEpbnDkMeyuSU=;
 b=lP7FAB8T0EX+BiKc7ARdti3MQL84KvdrqXsuA0RDzxpB8zO5zVaBme4A1dHrb//Dqg
 LMV8TsZnpaGGarh9CkwGmxB5qmAtZxXM1b8jyHpa+J1OKOG0kCxHBDM/TBDx+CjY/M5U
 3/SlGMJ/r2IMpZyp+jxB/zuVd2DALe1ydXVaEgLTLm/4g2/AUpysFreDS92BcP8lqGsm
 QE/F/zz1upPrY7iYo6KEQ5lDR0w6xAAdxDGNOuXikgLp7eFhPrickATu5y8MuXXL63Vi
 7A2anOoYult4B/xmGBTwTRtnkAjkUqt3nYBVu0Ojb0HIukF5+q1IE/p2qUmog0aES0Pf
 a/tg==
X-Gm-Message-State: AOJu0YxNLv8VNnyv/VZFFXfu5gjskQhQ3r5EENFyvAs8ZiFe0doXpo2F
 ZdMoYhs0pNfTuhyhuhFXjiI5ptBHMnDwgTRB2PI7BFI8DAQ/KrLbVSYnYUgt4pOWya9fESNpQrQ
 F+WI=
X-Google-Smtp-Source: AGHT+IEiI7lxr4JeVw2hsBMeVDu8TkR+CvLr/LWJj+beQC1JsUhXkkvmeHjcuqP7bK/nljgHOsdgPA==
X-Received: by 2002:a17:906:ad5:b0:a3d:b3a7:b8ce with SMTP id
 z21-20020a1709060ad500b00a3db3a7b8cemr991576ejf.0.1708020198368; 
 Thu, 15 Feb 2024 10:03:18 -0800 (PST)
Received: from m1x-phil.lan ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 j7-20020a170906278700b00a3d76518122sm783781ejc.9.2024.02.15.10.03.16
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 15 Feb 2024 10:03:17 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 John Snow <jsnow@redhat.com>, Paul Burton <paulburton@kernel.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
Subject: [PULL 48/56] hw/ide/ahci: Expose AHCIPCIState structure
Date: Thu, 15 Feb 2024 18:57:42 +0100
Message-ID: <20240215175752.82828-49-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240215175752.82828-1-philmd@linaro.org>
References: <20240215175752.82828-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x629.google.com
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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20240213081201.78951-3-philmd@linaro.org>
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
index a81c86b255..76b3b6032b 100644
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


