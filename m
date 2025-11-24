Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3115CFD317
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Nov 2025 10:33:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNTsy-0004Te-OZ; Mon, 24 Nov 2025 05:33:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTsR-0004JS-43
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:32:59 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vNTsM-0003dn-Ua
 for qemu-devel@nongnu.org; Mon, 24 Nov 2025 05:32:58 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-42b31c610fcso3536342f8f.0
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 02:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763980372; x=1764585172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Zz+qfOZw8v9N/8Ix/kj97eH5/LrKkuVWskuWR9JT6s4=;
 b=hq3niPZNTWtGFH/4rAau6V/E2dFIvwAx0m72zU37Q2bHmK2Hr74QLdfPNpovWZL77K
 3TYeZ4GG50ty9zdi0/aCTVPFq1ButDDdf14hSW0a2F7hN1JhhC1ackDszs/YoMNt39YA
 W0BI2iweR2a1NDoenDh7MffD4+HBCe65C5NzZGFTkHzWhSL5hT1QLgJ0XWpawtCHlMos
 YT7yXCXBnJXTn05YmM8KKn17o6NSNQ1BxcrKmCkDlKmK1/XQAOuRbGzM1Ki+39I18suP
 thFkjBKOcfzDBIBmMdmMiCbRrjBkCe1t/8p6r2g3UsJliFd7wgf8+ZeeKttH5hbhx6Us
 1VGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763980372; x=1764585172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zz+qfOZw8v9N/8Ix/kj97eH5/LrKkuVWskuWR9JT6s4=;
 b=ZpmPiv/vDuJ6XmL+RYQRR0kaKk+vTwxXS+MB3twRTuMy7/0d+mnYhKOqDk+E/dhFjO
 D1VLzZxJ6/zAkH0qiY83WkiCTMGaA3oac19JJ1q+u2/+RRggUIKSDJ8/muA4C8V+d0gu
 FCKKbPbmvFdZOOyD9Jg7Bqd+xPAkWB2wIz9YRQ5dz9UXZq2gNFobgaBKjA+4GP38DZD5
 OW3aad+Wu20LN6ODaUVKOOKfSLYOqI+IYBcNCs8v3AXgSiz7EpL+zMbtmDWYnRxzUgl9
 IHgTW/V/vYojHa08g38xY7XP19eOIIMfJwnEXn+PlML0AriaGpkI4yNo5aLVMAGW1YDV
 dgIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWukChuhM7j4Gvn6PQWzgQt4HkEPKE4sHSUtZ3Pp6RTO4U7NLjQ/rZZ0G4dyvwcgCPUng6dGWuurUd4@nongnu.org
X-Gm-Message-State: AOJu0YxQ3tZVxJ1PTImpC/W/v0nYVLmPxndA+f/ZXjejlzRVmJGyNail
 +90ogGx0Ud7m5+f4eNVlzCSktZZ2pNmZMg+IFgC5NfC/KBGvD0CO+JLncu+S5c99HLl7kFBnLZE
 D0HhWk2HImg==
X-Gm-Gg: ASbGncucsIa9vchOwD7QprEhtzClEUT7HEFRxS/bjUPWOrMBWpH7SZzhOZdR7MulhT3
 VjExZhbIYf/zAlsp54Q0enORgem5A/zJDyQYiRo+MmyKhEJ/GvQN4ZG97QXncOAPFOUHKSAPFr0
 WeKp3LYuIzhqWBdmW0zNDs0pFy6Kw4zVvmo9Z63oJMbmxkYjkJwN5LTOyrmaDAoBmCIOV0B6JpS
 hcvXEJ7/Gn6O+dIMhfjtZlQYX3pGCHIArz/kz4BIk5ZcyofFlV7OIpa7kIOoRzmmnOpHlVitCXc
 aC6FZ8qpakVsKSqCyOyolvH15MzKK70OrcZcf4+zrUQ8hO7zg0rowSQZDLCnsBt7NxVHnn5EqW5
 2gvWzOjNwcYDz8QS7gSu9yaJcS/8gJANpP27l31R5sx1DEOEQGade+mdj0pR+/36cO3X2ERBJDS
 3eb+xtpDwBMuKu0XJ+pTCCHtGI8u+2ebI3aqfrdQsWLzSZH+TqZHbGBopz4cA7
X-Google-Smtp-Source: AGHT+IGSadljwKYCHdopsAYfliZl8SdvuZYqjP6gthZPpgWXqrPWmgWr9ur+CJ9vlU8ywIfhF9aiYw==
X-Received: by 2002:a05:6000:40cc:b0:42b:4267:83e9 with SMTP id
 ffacd0b85a97d-42cc1ac91e1mr11578292f8f.2.1763980372356; 
 Mon, 24 Nov 2025 02:32:52 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8ff3sm29114282f8f.29.2025.11.24.02.32.51
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 24 Nov 2025 02:32:51 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Markus Armbruster <armbru@redhat.com>,
	qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH-for-11.0 1/2] hw/pci: Rename pci_bridge_exitfn() ->
 pci_bridge_unrealize()
Date: Mon, 24 Nov 2025 11:32:43 +0100
Message-ID: <20251124103244.78932-2-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251124103244.78932-1-philmd@linaro.org>
References: <20251124103244.78932-1-philmd@linaro.org>
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

pci_bridge_exitfn() is called by PCI bridges DeviceUnrealize
path. Rename using _unrealize() suffix to clarify that.

Mechanical change doing:

  $ sed -i -e s/pci_bridge_exitfn/pci_bridge_unrealize/ \
        $(git grep -wl pci_bridge_exitfn)

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/pci/pci_bridge.h        | 2 +-
 hw/pci-bridge/cxl_downstream.c     | 4 ++--
 hw/pci-bridge/cxl_upstream.c       | 4 ++--
 hw/pci-bridge/i82801b11.c          | 2 +-
 hw/pci-bridge/pci_bridge_dev.c     | 4 ++--
 hw/pci-bridge/pcie_pci_bridge.c    | 4 ++--
 hw/pci-bridge/pcie_root_port.c     | 4 ++--
 hw/pci-bridge/simba.c              | 2 +-
 hw/pci-bridge/xio3130_downstream.c | 4 ++--
 hw/pci-bridge/xio3130_upstream.c   | 4 ++--
 hw/pci-host/designware.c           | 2 +-
 hw/pci-host/xilinx-pcie.c          | 2 +-
 hw/pci/pci_bridge.c                | 2 +-
 13 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index a055fd8d321..b693470a4ea 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -138,7 +138,7 @@ void pci_bridge_disable_base_limit(PCIDevice *dev);
 void pci_bridge_reset(DeviceState *qdev);
 
 void pci_bridge_initfn(PCIDevice *pci_dev, const char *typename);
-void pci_bridge_exitfn(PCIDevice *pci_dev);
+void pci_bridge_unrealize(PCIDevice *pci_dev);
 
 void pci_bridge_dev_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
                             Error **errp);
diff --git a/hw/pci-bridge/cxl_downstream.c b/hw/pci-bridge/cxl_downstream.c
index 1065245a8b8..9431fc3864c 100644
--- a/hw/pci-bridge/cxl_downstream.c
+++ b/hw/pci-bridge/cxl_downstream.c
@@ -198,7 +198,7 @@ static void cxl_dsp_realize(PCIDevice *d, Error **errp)
  err_msi:
     msi_uninit(d);
  err_bridge:
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static void cxl_dsp_exitfn(PCIDevice *d)
@@ -209,7 +209,7 @@ static void cxl_dsp_exitfn(PCIDevice *d)
     pcie_chassis_del_slot(s);
     pcie_cap_exit(d);
     msi_uninit(d);
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static const Property cxl_dsp_props[] = {
diff --git a/hw/pci-bridge/cxl_upstream.c b/hw/pci-bridge/cxl_upstream.c
index 208e0c6172e..f9c26c72bae 100644
--- a/hw/pci-bridge/cxl_upstream.c
+++ b/hw/pci-bridge/cxl_upstream.c
@@ -351,7 +351,7 @@ err_cap:
 err_msi:
     msi_uninit(d);
 err_bridge:
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static void cxl_usp_exitfn(PCIDevice *d)
@@ -359,7 +359,7 @@ static void cxl_usp_exitfn(PCIDevice *d)
     pcie_aer_exit(d);
     pcie_cap_exit(d);
     msi_uninit(d);
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static const Property cxl_upstream_props[] = {
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 1d73c14c1f8..028e82e1ac0 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -75,7 +75,7 @@ static void i82801b11_bridge_realize(PCIDevice *d, Error **errp)
     return;
 
 err_bridge:
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static const VMStateDescription i82801b11_bridge_dev_vmstate = {
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b328e50ab31..7446b8a0474 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -122,7 +122,7 @@ slotid_error:
         shpc_cleanup(dev, &bridge_dev->bar);
     }
 shpc_error:
-    pci_bridge_exitfn(dev);
+    pci_bridge_unrealize(dev);
 }
 
 static void pci_bridge_dev_exitfn(PCIDevice *dev)
@@ -137,7 +137,7 @@ static void pci_bridge_dev_exitfn(PCIDevice *dev)
     if (shpc_present(dev)) {
         shpc_cleanup(dev, &bridge_dev->bar);
     }
-    pci_bridge_exitfn(dev);
+    pci_bridge_unrealize(dev);
 }
 
 static void pci_bridge_dev_instance_finalize(Object *obj)
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index fce292a519b..2c6d58292dd 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -92,7 +92,7 @@ pm_error:
 cap_error:
     shpc_cleanup(d, &pcie_br->shpc_bar);
 error:
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static void pcie_pci_bridge_exit(PCIDevice *d)
@@ -100,7 +100,7 @@ static void pcie_pci_bridge_exit(PCIDevice *d)
     PCIEPCIBridge *bridge_dev = PCIE_PCI_BRIDGE_DEV(d);
     pcie_cap_exit(d);
     shpc_cleanup(d, &bridge_dev->shpc_bar);
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static void pcie_pci_bridge_reset(DeviceState *qdev)
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 22c2fdb71e7..123c5e2c6e0 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -131,7 +131,7 @@ err_int:
         rpc->interrupts_uninit(d);
     }
 err_bridge:
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static void rp_exit(PCIDevice *d)
@@ -145,7 +145,7 @@ static void rp_exit(PCIDevice *d)
     if (rpc->interrupts_uninit) {
         rpc->interrupts_uninit(d);
     }
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static const Property rp_props[] = {
diff --git a/hw/pci-bridge/simba.c b/hw/pci-bridge/simba.c
index bbae594e119..ff7768152cf 100644
--- a/hw/pci-bridge/simba.c
+++ b/hw/pci-bridge/simba.c
@@ -72,7 +72,7 @@ static void simba_pci_bridge_class_init(ObjectClass *klass, const void *data)
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
     k->realize = simba_pci_bridge_realize;
-    k->exit = pci_bridge_exitfn;
+    k->exit = pci_bridge_unrealize;
     k->vendor_id = PCI_VENDOR_ID_SUN;
     k->device_id = PCI_DEVICE_ID_SUN_SIMBA;
     k->revision = 0x11;
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index dc7d1aa7d77..1f48747bffa 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -120,7 +120,7 @@ err_pcie_cap:
 err_msi:
     msi_uninit(d);
 err_bridge:
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static void xio3130_downstream_exitfn(PCIDevice *d)
@@ -131,7 +131,7 @@ static void xio3130_downstream_exitfn(PCIDevice *d)
     pcie_chassis_del_slot(s);
     pcie_cap_exit(d);
     msi_uninit(d);
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static const Property xio3130_downstream_props[] = {
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 40057b749bf..1945d90800f 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -99,7 +99,7 @@ err:
 err_msi:
     msi_uninit(d);
 err_bridge:
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static void xio3130_upstream_exitfn(PCIDevice *d)
@@ -107,7 +107,7 @@ static void xio3130_upstream_exitfn(PCIDevice *d)
     pcie_aer_exit(d);
     pcie_cap_exit(d);
     msi_uninit(d);
-    pci_bridge_exitfn(d);
+    pci_bridge_unrealize(d);
 }
 
 static const VMStateDescription vmstate_xio3130_upstream = {
diff --git a/hw/pci-host/designware.c b/hw/pci-host/designware.c
index f6e49ce9b8d..ca38d8a76d8 100644
--- a/hw/pci-host/designware.c
+++ b/hw/pci-host/designware.c
@@ -599,7 +599,7 @@ static void designware_pcie_root_class_init(ObjectClass *klass,
     k->device_id = 0xABCD;
     k->revision = 0;
     k->class_id = PCI_CLASS_BRIDGE_PCI;
-    k->exit = pci_bridge_exitfn;
+    k->exit = pci_bridge_unrealize;
     k->realize = designware_pcie_root_realize;
     k->config_read = designware_pcie_root_config_read;
     k->config_write = designware_pcie_root_config_write;
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index c71492de9e7..06c5bbef515 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -298,7 +298,7 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, const void *data)
     k->revision = 0;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
     k->realize = xilinx_pcie_root_realize;
-    k->exit = pci_bridge_exitfn;
+    k->exit = pci_bridge_unrealize;
     device_class_set_legacy_reset(dc, pci_bridge_reset);
     k->config_read = xilinx_pcie_root_config_read;
     k->config_write = xilinx_pcie_root_config_write;
diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 76255c4cd89..6daf84b2038 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -397,7 +397,7 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
 }
 
 /* default qdev clean up function for PCI-to-PCI bridge */
-void pci_bridge_exitfn(PCIDevice *pci_dev)
+void pci_bridge_unrealize(PCIDevice *pci_dev)
 {
     PCIBridge *s = PCI_BRIDGE(pci_dev);
     assert(QLIST_EMPTY(&s->sec_bus.child));
-- 
2.51.0


