Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB8CFC48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 16:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6gS-0002jn-Ob; Mon, 19 Feb 2024 11:40:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gR-0002hS-8E
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:59 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rc6gP-00034I-D2
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:39:58 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3394bec856fso3191098f8f.0
 for <qemu-devel@nongnu.org>; Mon, 19 Feb 2024 08:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708360795; x=1708965595; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=y/Jebg64AQMhqQ0a3cA7lmqym47W2wyRtw41CtoK9cY=;
 b=ZJdVPb5868fUZs3gNwdcl4s8Vn6ovsALkFOwDuBwIdjwEofaGJ6xKc4XqOHFZVtHY8
 m+L3HtXBka/AsqgS9ft/HhSjptxMKYYmhcsNWghYeiYxPSk05Mjxey3XZpJPwvZR7DBZ
 +F1n0Djt4fj8BNuWgg2wbWzu2Minediwi7OLf3ajCt1QUZuZdipEQNiAyls9Ajkq8YgT
 S4yQ87hCwE106fz7HoZuc/qw5saCYQ+A5JbXNpQiBgKbeCbNhnB6iX3A8NR7RJGsKmCi
 dML6KUP7JmSChUdO+zlXX/Dp73sNqI3mj62jUCX/wulYD03+1alS9dpCNvApFjOv4fZ+
 vgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708360795; x=1708965595;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=y/Jebg64AQMhqQ0a3cA7lmqym47W2wyRtw41CtoK9cY=;
 b=ICVci7S53gS0JjngP9G16hSF/XOit9te1aau1N5zmvljIi54qi/gqdIXElSxasvVJ/
 1j36rqei7rFNDyzK7Oe3/goU1N85C1K+QsuBy4xJc1ACINPS9iWbF+6no7/ZRzfFz862
 XLB1umssEDSNwV9XlamBogRahG1GO9S0qi5YlE/93YWgsJ8Bl4IWfFyTnWta2JuMGNhP
 FiP0mwBT2j69VzNolMkGPCM4eQXpVxmXho0zC1HWDdJCHjbQj9YNAFa13aHp49FDheT5
 GvEW2eZYWSzaXZlQ7Zi6L5MFe9kHZs/j0FqHHZ1fvPgBZplEV4b6TtMb6MbAuT3XjnfP
 qYag==
X-Gm-Message-State: AOJu0YyS/bK/qBRuKe+sXr5OCgj+rCzzNEo9T0gbjebnf03pHvcZrzAT
 3/rbrPei5QRZQivV9sPJhFqtpBEam+nc4XLE27eKzel/lxYFFZQ45p4hx+cKmLJ4D7KlYoWHRAM
 2
X-Google-Smtp-Source: AGHT+IGehn18lu2rIAh9lUAizlg6cd9A6bhcmWMG2QT3K/6H3h+Jwkz73ZbzHpJqN8+Wba57ZV1dEg==
X-Received: by 2002:a5d:658f:0:b0:33d:513a:9248 with SMTP id
 q15-20020a5d658f000000b0033d513a9248mr2317433wru.15.1708360795575; 
 Mon, 19 Feb 2024 08:39:55 -0800 (PST)
Received: from m1x-phil.lan ([176.176.181.220])
 by smtp.gmail.com with ESMTPSA id
 t23-20020a1c7717000000b00412680b270csm2471766wmi.5.2024.02.19.08.39.52
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Feb 2024 08:39:55 -0800 (PST)
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
Subject: [PATCH 08/14] hw/southbridge/ich9: Add the DMI-to-PCI bridge
Date: Mon, 19 Feb 2024 17:38:48 +0100
Message-ID: <20240219163855.87326-9-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240219163855.87326-1-philmd@linaro.org>
References: <20240219163855.87326-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Instantiate TYPE_ICH_DMI_PCI_BRIDGE in TYPE_ICH9_SOUTHBRIDGE.

Since the Q35 machine doesn't use it, add the 'd2p-enabled'
property to disable it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/southbridge/ich9.h |  9 ---------
 hw/i386/pc_q35.c              |  1 +
 hw/southbridge/ich9.c         | 27 +++++++++++++++++++++++++++
 hw/southbridge/Kconfig        |  1 +
 4 files changed, 29 insertions(+), 9 deletions(-)

diff --git a/include/hw/southbridge/ich9.h b/include/hw/southbridge/ich9.h
index 162ae3baa1..b9122d299d 100644
--- a/include/hw/southbridge/ich9.h
+++ b/include/hw/southbridge/ich9.h
@@ -108,15 +108,6 @@ struct ICH9LPCState {
 #define ICH9_USB_UHCI1_DEV                      29
 #define ICH9_USB_UHCI1_FUNC                     0
 
-/* D30:F0 DMI-to-PCI bridge */
-#define ICH9_D2P_BRIDGE                         "ICH9 D2P BRIDGE"
-#define ICH9_D2P_BRIDGE_SAVEVM_VERSION          0
-
-#define ICH9_D2P_BRIDGE_DEV                     30
-#define ICH9_D2P_BRIDGE_FUNC                    0
-
-#define ICH9_D2P_SECONDARY_DEFAULT              (256 - 8)
-
 /* D31:F0 LPC Processor Interface */
 #define ICH9_RST_CNT_IOPORT                     0xCF9
 
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 311ac2be6f..2f15af540f 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -238,6 +238,7 @@ static void pc_q35_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "ich9", OBJECT(ich9));
     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
                              OBJECT(host_bus), &error_abort);
+    qdev_prop_set_bit(ich9, "d2p-enabled", false);
     qdev_realize_and_unref(ich9, NULL, &error_fatal);
 
     /* irq lines */
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index f3a9b932ab..6df47e81fb 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -12,19 +12,42 @@
 #include "hw/qdev-properties.h"
 #include "hw/southbridge/ich9.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/ich_dmi_pci.h"
+
+#define ICH9_D2P_DEVFN          PCI_DEVFN(30, 0)
 
 struct ICH9State {
     DeviceState parent_obj;
 
+    I82801b11Bridge d2p;
+
     PCIBus *pci_bus;
+    bool d2p_enabled;
 };
 
 static Property ich9_props[] = {
     DEFINE_PROP_LINK("mch-pcie-bus", ICH9State, pci_bus,
                      TYPE_PCIE_BUS, PCIBus *),
+    DEFINE_PROP_BOOL("d2p-enabled", ICH9State, d2p_enabled, true),
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static bool ich9_realize_d2p(ICH9State *s, Error **errp)
+{
+    if (!module_object_class_by_name(TYPE_ICH_DMI_PCI_BRIDGE)) {
+        error_setg(errp, "DMI-to-PCI function not available in this build");
+        return false;
+    }
+    object_initialize_child(OBJECT(s), "d2p", &s->d2p, TYPE_ICH_DMI_PCI_BRIDGE);
+    qdev_prop_set_int32(DEVICE(&s->d2p), "addr", ICH9_D2P_DEVFN);
+    if (!qdev_realize(DEVICE(&s->d2p), BUS(s->pci_bus), errp)) {
+        return false;
+    }
+    object_property_add_alias(OBJECT(s), "pci.0", OBJECT(&s->d2p), "pci.0");
+
+    return true;
+}
+
 static void ich9_init(Object *obj)
 {
 }
@@ -37,6 +60,10 @@ static void ich9_realize(DeviceState *dev, Error **errp)
         error_setg(errp, "'pcie-bus' property must be set");
         return;
     }
+
+    if (s->d2p_enabled && !ich9_realize_d2p(s, errp)) {
+        return;
+    }
 }
 
 static void ich9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/southbridge/Kconfig b/hw/southbridge/Kconfig
index 852b7f346f..db7259bf6f 100644
--- a/hw/southbridge/Kconfig
+++ b/hw/southbridge/Kconfig
@@ -3,3 +3,4 @@
 config ICH9
     bool
     depends on PCI_EXPRESS
+    imply I82801B11
-- 
2.41.0


