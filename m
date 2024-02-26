Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5F45C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 11:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYxM-0001ui-3R; Mon, 26 Feb 2024 06:15:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxC-0001cd-Un
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:29 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reYxA-0000Iu-Nt
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 06:15:26 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-33d6cc6d2fcso1885957f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 03:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708946121; x=1709550921; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lZ1MjFFP7CBRD+d2PVUAbb1TpM05+DB5Hf5IgGpJXgc=;
 b=ny6WxQK4rC/cP4TcHMA6eWsTI0awq7r9g4y1Yd2sJ/nmdqcjHdcAlaog3l/DUl65vH
 n8oG1tpyATPb5BdHfJgigXPO8ca7jgldi39wJzw3SAdr5n0sRdyE6hLJSJ/aWHib+Muc
 lBBEHdXz+D37uLVDsExxgqEB4H34WIA3Ivu7F0wtqNEvgcZxhPCYvM93oK4DQ3AjJXBs
 hwELeVI18ec9gQ9GiiLsMppZqTrB9HPLqSekclfZk+PFBU5ShMMit4u27Sph2I1mzevB
 ldsjYH38oVXR/WzGst7s9PBq9VwlRuo2vq/V++NtE0zC+l1DXA6UZDpuqlyhiNGuIgnP
 2jqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708946121; x=1709550921;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lZ1MjFFP7CBRD+d2PVUAbb1TpM05+DB5Hf5IgGpJXgc=;
 b=hGatApEVlU0id34jO52otGftPUAHdSAizDWXA3h4WfzyRfBcc4GNCIACLV0gm62WYd
 9ZROJyrN1de/EzQeUrtbl+JyG5PWJ2EbSCJhBn1tS1tR6JnIjbIMm9JvP2JGD0po7mfZ
 NDUKA1jb3DMqs4QlzikrwFSwKQAMQcnb0heeJOI8qbXdVTl1oshftZom4EZDeSFkuLJQ
 HA1cd2zgSmwkoNUkFAOPeDb+4mujzopDbT/WvyP4dJFTETt4P0sfZ4ixby1Y0s64dR30
 QLwcErawgca0yzDbZMjrr1MIBivezNd7E4D2BDFUx+PL0TByHF8M14wxzDYyTCJCoPm7
 /1XQ==
X-Gm-Message-State: AOJu0Yw9eD2fgRR4uRwAOi8Kn/ePvrMe4QxfW4Nux7h2EdH65pRxDd1/
 Z1nmsAIlb3Lykx828/yIOpSdBOGPg58gjJ1v778L7Z2QXbZV+lzekW4oYxf8ncKMWKjSELokbZ2
 /
X-Google-Smtp-Source: AGHT+IGBUo6IReaoZYzxpKHUBizzuBkpfnFXuJo123VZgtOx349yXLpAdeCmGbB4DIXzyQ+qYmrUeA==
X-Received: by 2002:adf:db07:0:b0:33d:82ae:67f8 with SMTP id
 s7-20020adfdb07000000b0033d82ae67f8mr4697015wri.50.1708946121143; 
 Mon, 26 Feb 2024 03:15:21 -0800 (PST)
Received: from m1x-phil.lan ([176.176.164.69])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a5d4d06000000b0033d873f08d4sm7910526wrt.98.2024.02.26.03.15.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 26 Feb 2024 03:15:20 -0800 (PST)
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
Subject: [PATCH v2 10/15] hw/southbridge/ich9: Add the DMI-to-PCI bridge
Date: Mon, 26 Feb 2024 12:14:09 +0100
Message-ID: <20240226111416.39217-11-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240226111416.39217-1-philmd@linaro.org>
References: <20240226111416.39217-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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
index 8c8a2f65b8..f951cf1e3a 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -226,6 +226,7 @@ static void pc_q35_init(MachineState *machine)
     object_property_add_child(OBJECT(machine), "ich9", OBJECT(ich9));
     object_property_set_link(OBJECT(ich9), "mch-pcie-bus",
                              OBJECT(pcms->pcibus), &error_abort);
+    qdev_prop_set_bit(ich9, "d2p-enabled", false);
     qdev_realize_and_unref(ich9, NULL, &error_fatal);
 
     /* create ISA bus */
diff --git a/hw/southbridge/ich9.c b/hw/southbridge/ich9.c
index f3a9b932ab..8c4356ff74 100644
--- a/hw/southbridge/ich9.c
+++ b/hw/southbridge/ich9.c
@@ -12,16 +12,23 @@
 #include "hw/qdev-properties.h"
 #include "hw/southbridge/ich9.h"
 #include "hw/pci/pci.h"
+#include "hw/pci-bridge/ich9_dmi.h"
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
 
@@ -29,6 +36,22 @@ static void ich9_init(Object *obj)
 {
 }
 
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
 static void ich9_realize(DeviceState *dev, Error **errp)
 {
     ICH9State *s = ICH9_SOUTHBRIDGE(dev);
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


