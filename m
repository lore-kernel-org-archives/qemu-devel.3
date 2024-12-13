Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF08EE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 13:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tM5pE-0006BK-Kg; Fri, 13 Dec 2024 08:35:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5oB-0005EZ-DE
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:21 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tM5o8-00016Z-VC
 for qemu-devel@nongnu.org; Fri, 13 Dec 2024 08:34:18 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4361dc6322fso11740655e9.3
 for <qemu-devel@nongnu.org>; Fri, 13 Dec 2024 05:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734096853; x=1734701653; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=keEAo9CNDWNBW9lBlzlrISyY+AFYXI3pGoxc0E2DIgY=;
 b=Krziu5I0VYSwqQ6p0LCHeMRO2LNvOJyQigB56OtHvOrwIsWRD2SS0miohndyzqsaXC
 OdBlLqXMFpBR3s+RhkPNFJVtkDwhMd1WQeX04prbgifX+69uDK0mHPuhvm5ZJ1CN0E42
 HtHSBLmyIwExRlYcgPPFsbJst2qqXv5CU8GqoYGUywbhI4bgA7brjYNbBZC+C1Swrk+q
 xaYmx8dk1BoSfGqvDSMfAj5IOaVQr4mTJkW8asPdvFukk6BOveDnRt+F68IfW0YYvCSm
 y0TrXH0XIN60K6Y/PfXIAkds9qIHg7SpnLmNptMkf2jrytnjQF1yctFi+0YU85OB5WR/
 96Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734096853; x=1734701653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=keEAo9CNDWNBW9lBlzlrISyY+AFYXI3pGoxc0E2DIgY=;
 b=ajZ1XvXrpygQeqH/ISLKArRhV6bW5ZyZsNKgKqhiKF/uZcRHPmwI5IEoWFc2aAZK5H
 TX+G4b74wc/ystvDVRVaW/vGWYKcAkYizjcYXo07k8yiiuc6L1aw5eLa2xASAI7PxCJz
 MlXn2yxUNz3cjvIz9PoIzqG4CFIK6Dw4VhTJph7fhtaDbXnh5TsoNaXIufcpRfIX8Qc2
 By4sRS9iekR2kEeSanTJodIulsfnvfPknVA29q46FyIwK6NDao0HuKuPb8ZWUPgFpejN
 eo7+/b8VCjDC4s1L/zfZCOe/LYMwZxBFD7MQr8v6CzDKq5QrZZICs/6kWww1MRUKnbYH
 Q9RA==
X-Gm-Message-State: AOJu0YyDE7/f0RPdlYTFnQocYBVw82JzxjdJ0Whf2sRt/8vULl+UH6/B
 HN+95Y3VoNdA+GTDkpYMabY4mUzvOKCTF4gAH7V+6sr1mJ6Fb4z4de5QDH1rxeNgl78rwpq9mfK
 T
X-Gm-Gg: ASbGncsyq3BH3fX6XSrCo5OoXycbfiUD22Ps1uhnkJTfx3sqE1YluCOQD2S2MJ8EppQ
 jB7ig4fEIrOj1hmu+Kf14u/ktENIGnosYEr5tar0uh1ZB3wMtgAqRLuV6xf4+KUqO4OW0rd89dQ
 /RRmsangnPXYCTdi6x7czvY0DRdeK5u0ffUiSI7YQcOVhsBmTcQ2HQWYt8Gy70nDqWD0DVwKhaG
 AZEyYZlrygGjm+NOfi5qKEvy1Z/sPx1Nq8cclavpML3exORf4ACLGDeYZJmeFq/xwedezId9eZh
 FUDKEodaRRdzmZQ/FXXTI+nMytgwXVMdhheO
X-Google-Smtp-Source: AGHT+IE0ffWZw+U60PDT7QBRhyibaA5YDxPBq0XXXZqasm/RJH5hNoTjSv/ogL3zZMijlrlO6a1i4Q==
X-Received: by 2002:a5d:584b:0:b0:386:1cd3:8a09 with SMTP id
 ffacd0b85a97d-38880abfd60mr2192970f8f.1.1734096853442; 
 Fri, 13 Dec 2024 05:34:13 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436256b4556sm48690705e9.33.2024.12.13.05.34.12
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 13 Dec 2024 05:34:13 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 4/7] hw/pci: Have PCI_BUS implement
 TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
Date: Fri, 13 Dec 2024 14:33:49 +0100
Message-ID: <20241213133352.10915-5-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241213133352.10915-1-philmd@linaro.org>
References: <20241213133352.10915-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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


