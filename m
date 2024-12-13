Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4718EE77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 23:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tMF8V-000390-GE; Fri, 13 Dec 2024 18:31:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8M-00032M-OL
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:47 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tMF8L-000321-4W
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 18:31:46 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3862a921123so1697880f8f.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 15:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734132701; x=1734737501; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGLsAY1QOgkinuwwLWyIxYZvjMgpGCzP2nfQjOcTbV8=;
 b=SbzNgFM8kikmxtsqU5OaAqSR7+CMVbqC9a2Txn4m258AL6bWpRhXMcGPCvGCN2Ojmg
 XvS6IQGZhacRa6DcYLFVHvyprMUZsyN/e+8eKmcy+mlpEmxSmQmn2yjso1pAbXDZ8uW9
 3T3pxfHbFNt6xT8y9urAdrkzkgSeIs4efGb3g8Iq6QigEbqg9zM1R8oYy9TbcoO8hb2W
 K3gH+B7FcOiL6m/pfuSehn8A25gDUrGsv94/Nskg+JSOttEA9rTz5X9oFy3Mj6jnH2X/
 cwdbdYeTilDGzHWk6LaXZqZJyaXpdTEHunhdkxKlknDDuQ7Dd3HZ6UaI7CWb2dpoxPL0
 zttQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734132701; x=1734737501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bGLsAY1QOgkinuwwLWyIxYZvjMgpGCzP2nfQjOcTbV8=;
 b=OjKNa9pEMrc8L/rckpN33OFmoF808mqV1QGIIgy+CJiUbn5Vh12fofeKRaJUckMhet
 9VltBMgaBFdCjztAab5Bshl1PQLxx21eV39A9PApxyj/QaBk7C0AIW3KA2VwtR6HRc+j
 xeiY/HzwbmX1PK1O371+804gxIv1eENtxxMNAcUpczx1M2iKVbkcN/wkf9wHCbscC8m1
 xkKB3GrJJWg7GH4IHMJbwF27QnUmE6GycgOfS+Mw4YD7vpr+vh+K6Gd7AmhxXdDThoTb
 9mH5bd0GVT9GcG3NwL3K4WdTcdaDRPEKqr9RDQk5HmtL09Zi3/TbLjoYr48UA5bPOT4j
 QLKQ==
X-Gm-Message-State: AOJu0YxZuoLKfLJJ39P7T9lEITZtfw4VYBMszcF+Jf/p87VtINEYF5F6
 LBBVSfb2hCq5TsooLnVHhH1YLqaqVLYEyOvFBXjMsxTDwRd2I3JqNv7PTsCCDsHjfLXSUr/F51Y
 6Pno=
X-Gm-Gg: ASbGncv/ftPL8VmsslcEDZf4r294b8Xc5u4M9ShXuKwhZ4rglVd5c8tBwUQkT4aLMYB
 unSoao7Uft7m1B3tdprobhmMFQWpEMVoXBo4SluRMLqC4yzUgwprugsHOMmHa6EmMAE3xD6nN9w
 u3gpZfZIesTKUgTs+pWVTG8RhTLiqy1iwsC5rRCGCrEJ6R3TDnMKLFlzIUw9oKvvG2B5fySY7Pz
 9rmbSPlK56L1gPlCI0ZkhR9MsmcuwaOOxJ6R1tsDu7l4af6uVlh8pQL12Xp0FyR4ZLPute2f7U2
 s5ffeQ==
X-Google-Smtp-Source: AGHT+IFnNsNu+qUMzcLjg0KQjYC6n3utD8jvcknr6dN1qh+4psvFXLXY/G4wAED6P2Mp5Oq2Wc0cAQ==
X-Received: by 2002:a05:6000:1fae:b0:385:ea2b:12cc with SMTP id
 ffacd0b85a97d-38880acd0b7mr3491819f8f.13.1734132701437; 
 Fri, 13 Dec 2024 15:31:41 -0800 (PST)
Received: from localhost.localdomain ([45.93.146.194])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-388c8046bf8sm821961f8f.82.2024.12.13.15.31.40
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 15:31:40 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 08/20] hw/pci: Have PCI_BUS implement
 TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
Date: Sat, 14 Dec 2024 00:30:43 +0100
Message-ID: <20241213233055.39574-9-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213233055.39574-1-philmd@linaro.org>
References: <20241213233055.39574-1-philmd@linaro.org>
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

The FW_CFG_DATA_GENERATOR interface allows any object to
produce a blob of data consumable by the fw_cfg device.
Implement that for PCI bus objects.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20241213133352.10915-5-philmd@linaro.org>
---
 hw/pci/pci.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1416ae202c3..8844251eceb 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -46,6 +46,7 @@
 #include "hw/pci/msix.h"
 #include "hw/hotplug.h"
 #include "hw/boards.h"
+#include "hw/nvram/fw_cfg.h"
 #include "qapi/error.h"
 #include "qemu/cutils.h"
 #include "pci-internal.h"
@@ -216,11 +217,41 @@ static uint16_t pcibus_numa_node(PCIBus *bus)
     return NUMA_NODE_UNASSIGNED;
 }
 
+static GByteArray *pci_bus_fw_cfg_gen_data(Object *obj, Error **errp)
+{
+    PCIBus *bus = PCI_BUS(obj);
+    GByteArray *byte_array;
+    uint64_t extra_hosts = 0;
+
+    if (!bus) {
+        return NULL;
+    }
+
+    QLIST_FOREACH(bus, &bus->child, sibling) {
+        /* look for expander root buses */
+        if (pci_bus_is_root(bus)) {
+            extra_hosts++;
+        }
+    }
+
+    if (!extra_hosts) {
+        return NULL;
+    }
+    extra_hosts = cpu_to_le64(extra_hosts);
+
+    byte_array = g_byte_array_new();
+    g_byte_array_append(byte_array,
+                        (const void *)&extra_hosts, sizeof(extra_hosts));
+
+    return byte_array;
+}
+
 static void pci_bus_class_init(ObjectClass *klass, void *data)
 {
     BusClass *k = BUS_CLASS(klass);
     PCIBusClass *pbc = PCI_BUS_CLASS(klass);
     ResettableClass *rc = RESETTABLE_CLASS(klass);
+    FWCfgDataGeneratorClass *fwgc = FW_CFG_DATA_GENERATOR_CLASS(klass);
 
     k->print_dev = pcibus_dev_print;
     k->get_dev_path = pcibus_get_dev_path;
@@ -232,6 +263,8 @@ static void pci_bus_class_init(ObjectClass *klass, void *data)
 
     pbc->bus_num = pcibus_num;
     pbc->numa_node = pcibus_numa_node;
+
+    fwgc->get_data = pci_bus_fw_cfg_gen_data;
 }
 
 static const TypeInfo pci_bus_info = {
@@ -240,6 +273,10 @@ static const TypeInfo pci_bus_info = {
     .instance_size = sizeof(PCIBus),
     .class_size = sizeof(PCIBusClass),
     .class_init = pci_bus_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_FW_CFG_DATA_GENERATOR_INTERFACE },
+        { }
+    }
 };
 
 static const TypeInfo cxl_interface_info = {
-- 
2.45.2


