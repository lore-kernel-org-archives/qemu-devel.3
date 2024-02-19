Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BCAC48BF8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:40:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6gF-00020n-77; Mon, 19 Feb 2024 11:39:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gD-0001vH-2f
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:45 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gB-0002yn-8I
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:44 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-41261233e61so8607315e9.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360781; x=1708965581; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eHqLJIf48lUklPD2bsMO5k3sbW9zd3TEK1XtTCythow=;
 b=vbwXM9vaKtADKSqj1B4rhNH9Qtpu+Wc2qlY/gRERD7lATZ0+aR8VQLO8CYVh6+HCzI
 VWo07vohP2vbRpqJTrSoEviaGxHKgFHq1exot130ANqNuUAAdb4qsQS8wd09mrgL2AeX
 Z+t3cYGg43izAg2VBfpEBiOLqQYxORNLWxL0r7XPKfAV6FjfaUhTrXhbQYIlb5e6sW4k
 +k/lbodmq26Ug/ksEg9rdFT0A2r7YgFLnuYrCuWbZ5+NIfrsmBaxF48R88X5MPhLX5lh
 F87WGRQBRVRvQmlLoW2KuOKSqa25FtjlKUluCS4iWolVYr4htreRJo2ywDhFT1DkMqd0
 1LkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360781; x=1708965581;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eHqLJIf48lUklPD2bsMO5k3sbW9zd3TEK1XtTCythow=;
 b=xSwkQify3752lJlU0hJYzZlqIGU1bvEds0fqbfvH3jKouVhZ51iOeOvmaQAmkyXtdN
 OZo603RuBUeLYadIiwxBMF+lw7CKurNLWids57M7RU6et7+P6kCn9bRagzeSM7TdUgCL
 0TZDgNARgujIwJrnbSEOZGPUhoEBiadRgpjdkDxfD1d5V2HleV0u016orUdwiiDV2PSL
 nQfYzQW84b/wC6/1aQkhQGZAG93rppQThenT8IEtZ77cC+3m8cdezGAHMzgPA9nV0XSg
 9L+keM56XgcLEW5JFYyIf/iDK2Ze+KS3owePiGR5fy//4BwyLFytNjLpJVDr2HipFp4L
 b6qQ==
X-Gm-Message-State: AOJu0YyysRPbXP2PWs427iL4628m4zEHjddFj49YFKz58dbE9y7j2Fvb
 SaiUK2viqFTWAbS+gfgC+aiQsNXJWMbHlqiLJYclAh1vFRXUaCli7NFx4OR531v11lrsUCsK5Mq
 Y
X-Google-Smtp-Source: AGHT+IEJsakYa9P4Z0qhYdzvRgFxhjP7w89K7jZtJe7VQdQ+dsVrHm+CkgwcNlnMscvuIHMsKpx9OA==
X-Received: by 2002:a05:600c:518e:b0:412:6c73:a63e with SMTP id
 fa14-20020a05600c518e00b004126c73a63emr484118wmb.0.1708360781284; 
 Mon, 19 Feb 2024 08:39:41 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 21-20020a05600c229500b0041228b2e179sm11715550wmf.39.2024.02.19.08.39.39
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org,
	Bernhard Beschow <shentey@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 06/14] hw/pci-bridge: Extract QOM ICH definitions to
 'ich_dmi_pci.h'
Date: Mon, 19 Feb 2024 17:38:46 +0100
Message-ID: <20240219163855.87326-7-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
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
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
"hw/pci-bridge/ich_dmi_pci.h" header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 MAINTAINERS                         |  1 +
 include/hw/pci-bridge/ich_dmi_pci.h | 20 ++++++++++++++++++++
 include/hw/southbridge/ich9.h       |  2 --
 hw/pci-bridge/i82801b11.c           | 11 ++++-------
 4 files changed, 25 insertions(+), 9 deletions(-)
 create mode 100644 include/hw/pci-bridge/ich_dmi_pci.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 1b210c5cc1..50507c3dd6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2609,6 +2609,7 @@ F: hw/acpi/ich9*.c
 F: hw/i2c/smbus_ich9.c
 F: hw/isa/lpc_ich9.c
 F: include/hw/acpi/ich9*.h
+F: include/hw/pci-bridge/ich_dmi_pci.h
 F: include/hw/southbridge/ich9.h
 
 PIIX4 South Bridge (i82371AB)
diff --git a/include/hw/pci-bridge/ich_dmi_pci.h b/include/hw/pci-bridge/ich_dmi_pci.h
new file mode 100644
index 0000000000..7623b32b8e
--- /dev/null
+++ b/include/hw/pci-bridge/ich_dmi_pci.h
@@ -0,0 +1,20 @@
+/*
+ * QEMU ICH4 i82801b11 dmi-to-pci Bridge Emulation
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_PCI_BRIDGE_ICH_D2P_H
+#define HW_PCI_BRIDGE_ICH_D2P_H
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
 
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index c140919cbc..dd17e35b0a 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -45,7 +45,7 @@
 #include "hw/pci/pci_bridge.h"
 #include "migration/vmstate.h"
 #include "qemu/module.h"
-#include "hw/southbridge/ich9.h"
+#include "hw/pci-bridge/ich_dmi_pci.h"
 
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
-- 
2.41.0


