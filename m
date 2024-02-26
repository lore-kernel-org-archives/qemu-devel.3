Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C062C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:17:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYxM-0001tz-3T; Mon, 26 Feb 2024 06:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYx2-0001Mj-ST
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:23 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYww-0000GF-Ud
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:16 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-33aeb088324so1849745f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946109; x=1709550909; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ArWa+e/moduzCYJ6asYa3Uf0/sMyr8zgG8KP2jihEtc=;
 b=EjkLiFbetxJX6y2wu0MdFFcFH9fPbbNxiepN5grHESCD3CY1UMefhRJALxoMsGVwaV
 s+LPaE+6VQrPMXyZV/fqYuesPWG82bdiOeRI9pxpMwDdvtmoKu+RiKqP0bYRbN9X5Dso
 3aIa7vMeIjMO6r3OLQTw8ZvmBSMZQXjWbdcMBZ4f7LFAsanJlW8OChxtvuCCo97Y5K34
 Pk7t9bNKywy3QNF9Vx5szIZiU6WyO5oKxYHq0UrJZqDsx041bprFAvgP4Yb21/rXtSpv
 AGe2scecz++iyKb7TIuaOxEJtEEXQxWm7kRXDNUf93Pr2ZqSbE5Khe5PklI2lmvJdrNf
 is4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946109; x=1709550909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ArWa+e/moduzCYJ6asYa3Uf0/sMyr8zgG8KP2jihEtc=;
 b=BQqT4Hc7DEBV/EkF2TXyRBohK3Bn2HsUEKAs/OgCKqKXj73Vd4V2sTZrqYWdMkg8QE
 7jrYAKrdKWDYOuctLN8sVPvm+MX/pj66i0ykAR7574C25FluSid+NhZldiqQToOapcFD
 p1ZwY61G4OcsagyT4WUnsudQ9gR7XSFOGv3HruXrGHfQDbxiLehnFK/5Ml1/duagzM83
 qsuHHBZ5SuGlUsVHn01MuWBJPhIVJP98HDkAw+REBeavYQkOBnj8dBcFXjzPpPc85tlA
 IX9ifTDkOJbQvG04lOcA24KWQBRuhqv63kocZAVz+sXb1+6sav5bOw0tAUOGByLkkQBT
 HRfA==
X-Gm-Message-State: AOJu0YzWCst/HXbPydf0PzUyDWeGyccSDX2QPBJkQsOUrIk39BZdsZ6E
 W/e4Y6yW40GoKb2AV9Nxb/dXYq7Hb1zgqrVJ43biLyJcRdI9WWohD4/jqnfBMzMVrtwkmiveQZQ
 z
X-Google-Smtp-Source: AGHT+IHYM/Q+UNz/TDrLeMKLELVbpOEQ/xRXzjjkILjXIeEtn7uHovsVkJmEJzq0hmD0RJ3hva8LDA==
X-Received: by 2002:adf:e909:0:b0:33d:26dd:8c4f with SMTP id
 f9-20020adfe909000000b0033d26dd8c4fmr4461691wrm.23.1708946109026; 
 Mon, 26 Feb 2024 03:15:09 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 w10-20020adff9ca000000b0033d1b760125sm8012280wrr.92.2024.02.26.03.15.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:08 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Ani Sinha <anisinha@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 08/15] hw/pci-bridge: Extract QOM ICH definitions to
 'ich9_dmi.h'
Date: Mon, 26 Feb 2024 12:14:07 +0100
Message-ID: <20240226111416.39217-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

Expose TYPE_ICH_DMI_PCI_BRIDGE to the new
"hw/pci-bridge/ich9_dmi.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                               |  1 +
 include/hw/pci-bridge/ich9_dmi.h          | 20 ++++++++++++++++++++
 include/hw/southbridge/ich9.h             |  2 --
 hw/pci-bridge/{i82801b11.c => ich9_dmi.c} | 11 ++++-------
 hw/pci-bridge/meson.build                 |  2 +-
 5 files changed, 26 insertions(+), 10 deletions(-)
 create mode 100644 include/hw/pci-bridge/ich9_dmi.h
 rename hw/pci-bridge/{i82801b11.c => ich9_dmi.c} (95%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0849283287..52282c680e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2618,6 +2618,7 @@ F: hw/i2c/smbus_ich9.c
 F: hw/isa/lpc_ich9.c
 F: include/hw/acpi/ich9*.h
 F: include/hw/i2c/ich9_smbus.h
+F: include/hw/pci-bridge/ich9_dmi.h
 F: include/hw/southbridge/ich9.h
 
 PIIX4 South Bridge (i82371AB)
diff --git a/include/hw/pci-bridge/ich9_dmi.h b/include/hw/pci-bridge/ich9_dmi.h
new file mode 100644
index 0000000000..7cf5d9d9b2
--- /dev/null
+++ b/include/hw/pci-bridge/ich9_dmi.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_PCI_BRIDGE_ICH9_DMI_H
+#define HW_PCI_BRIDGE_ICH9_DMI_H
+
+#include "qom/object.h"
+#include "hw/pci/pci_bridge.h"
+
+#define TYPE_ICH_DMI_PCI_BRIDGE "i82801b11-bridge"
+OBJECT_DECLARE_SIMPLE_TYPE(I82801b11Bridge, ICH_DMI_PCI_BRIDGE)
+
+struct I82801b11Bridge {
+    PCIBridge parent_obj;
+};
+
+#endif
diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index bee522a4cf..b2abf483e0 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -114,8 +114,6 @@ struct ICH9LPCState {
 
 #define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
 
-#define ICH9_D2P_A2_REVISION                    0x92
-
 /* D31:F0 LPC Processor Interface */
 #define ICH9_RST_CNT_IOPORT                     0xCF9
 
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/ich9_dmi.c
similarity index 95%
rename from hw/pci-bridge/i82801b11.c
rename to hw/pci-bridge/ich9_dmi.c
index c140919cbc..927e48bf2e 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/ich9_dmi.c
@@ -45,7 +45,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "hw/southbridge/ich9.h"
+#include "hw/pci-bridge/ich9_dmi.h"
 
 /*****************************************************************************/
 /* ICH9 DMI-to-PCI bridge */
@@ -53,11 +53,8 @@
 #define I82801ba_SSVID_SVID     0
 #define I82801ba_SSVID_SSID     0
 
-typedef struct I82801b11Bridge {
-    /*< private >*/
-    PCIBridge parent_obj;
-    /*< public >*/
-} I82801b11Bridge;
+
+#define ICH9_D2P_A2_REVISION                    0x92
 
 static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
 {
@@ -103,7 +100,7 @@ static void i82801b11_bridge_class_init(ObjectClass *klass, void *data)
 }
 
 static const TypeInfo i82801b11_bridge_info = {
-    .name          = "i82801b11-bridge",
+    .name          = TYPE_ICH_DMI_PCI_BRIDGE,
     .parent        = TYPE_PCI_BRIDGE,
     .instance_size = sizeof(I82801b11Bridge),
     .class_init    = i82801b11_bridge_class_init,
diff --git a/hw/pci-bridge/meson.build b/hw/pci-bridge/meson.build
index f2a60434dd..d746487193 100644
--- a/hw/pci-bridge/meson.build
+++ b/hw/pci-bridge/meson.build
@@ -1,6 +1,6 @@
 pci_ss = ss.source_set()
 pci_ss.add(files('pci_bridge_dev.c'))
-pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('i82801b11.c'))
+pci_ss.add(when: 'CONFIG_I82801B11', if_true: files('ich9_dmi.c'))
 pci_ss.add(when: 'CONFIG_IOH3420', if_true: files('ioh3420.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PORT', if_true: files('pcie_root_port.c', 'gen_pcie_root_port.c'))
 pci_ss.add(when: 'CONFIG_PCIE_PCI_BRIDGE', if_true: files('pcie_pci_bridge.c'))
-- 
2.41.0


