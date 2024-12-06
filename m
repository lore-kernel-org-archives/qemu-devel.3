Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EE78E77173
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2024 18:16:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJcqV-0001QQ-Kq; Fri, 06 Dec 2024 13:14:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqT-0001NL-2r
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:29 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tJcqR-0005Q6-GN
 for qemu-devel@nongnu.org; Fri, 06 Dec 2024 13:14:28 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4349fd77b33so22351885e9.2
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2024 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733508866; x=1734113666; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=owh50kXvsaInzhL7G0fsDGVpNu3LUuVKio+jRzd7Ga0=;
 b=jozGh2IoKPNWCTj3dbz5Qt0NhO2Cw5BkhKyo/tCuLk//+v6PLmtV9UO9xEfAOpBYvW
 ZQf0Hz3VKN4NprnOojf5Vux1OLRmDRhRztbi14NXtoYQoloeL/yNuDXDdzHwSYVcAKkV
 DtyYg1TpIhicrdnK7J58LXksZpVy5RoJf4VYjfyaBstGUNYZGAJQvQsdKEBK/VDjv2GP
 lFhe2djhBtbkn9bsFkoNeL+cyYYQ5sDCj6O92EuWIab1teGVFC+FRmccXZ/e3jhvADpZ
 MZw6ZB3PsmeOmTvO0iLU8BSxuVlcUIkYz/MRMJ2AZ+ZhsFrLAKAUj8drsuq+JgbtlaaV
 0WGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733508866; x=1734113666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=owh50kXvsaInzhL7G0fsDGVpNu3LUuVKio+jRzd7Ga0=;
 b=FpMWlwCVq5dBUP60zMhpGjreOK9VD+KSgbT7e4tNL/GwBhfQ4aPXnPcmIzVHPG6aK6
 P0QEoiNsB/OuCnooTEjdy4CVgMfhWN0SzPuSP+IidFWzAxU/rnjQLcLyWP6B2D2TZdaF
 xDeOWfu8P9bhUo2Rx2ZRfccXG7M0qxa7DY+aFWRVL/nAkeIXrmgCCwUklvg7LPhlExEf
 1HQndz6BvwKt1mvHE9XpJ56Bu2CmARLAUn7g8oyxqJACOXxbeV/ddmIRrV+AkF619ho6
 uN/MvC+6Odcv2sUb+mep8yrkcD2Ow3FJ9HMarxcKxFBF6RYAm1TiNi0MJNFnMkRaJYlw
 T0Yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNGCRCECN/18fOKf9gm+HhBmxw6GzDhhEcJhFUoDEqQOEzwIvaIv7oZuRaLL3sta4gO+HPFCpA0Aoh@nongnu.org
X-Gm-Message-State: AOJu0YygyscT0TdxZ6xLAvPT8p9q70QLdN1UDKGlKmvcvH787GhWzL+u
 9yBbLUIcwFTPGLNAlAw1umBz5318L1FTOlDnVsb2NTR9JmEOQko5uKI0YPvChYM=
X-Gm-Gg: ASbGncsQ/zpYW9FDVkbl5APjbdXQ7yfzuB3uW/fdh2ZYmzG1efJOiTGYBvTOSP+wwq2
 g8UazikvnacdMQzqeVtHGFR5lGqPIR60throjsI6m03P817jG5/Yo5v87N5sw6OkxbBmZN1RRjw
 oQxhkj9/MTAcp8pzMwMeK/HoipptWhlH6EeaS2OLdgwubPJtLTYic0TyMxP22bHQjW04fpAcFsl
 tK3FF5974cf8LZPsVAWtlzOgnvGpBfi3cnvTbI3AoH7yt9QoZXhWdPUYzqXDWaYBlc=
X-Google-Smtp-Source: AGHT+IGiQ4AU4yZBjbudxHMOaNRjcOuD4Np3qXJ4Ty1c5BjKPryT2dTklSgCy/x5MFwLTKF3LJP2Jw==
X-Received: by 2002:a05:600c:1d0b:b0:431:5ab3:d28d with SMTP id
 5b1f17b1804b1-434ddeb5518mr37823825e9.9.1733508865965; 
 Fri, 06 Dec 2024 10:14:25 -0800 (PST)
Received: from localhost.localdomain ([95.127.41.180])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434d52c0be4sm100555205e9.28.2024.12.06.10.14.22
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 06 Dec 2024 10:14:25 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Jiahui Cen <cenjiahui@huawei.com>,
	qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 3/6] hw/pci: Have PCI_BUS implement
 TYPE_FW_CFG_DATA_GENERATOR_INTERFACE
Date: Fri,  6 Dec 2024 19:13:49 +0100
Message-ID: <20241206181352.6836-4-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241206181352.6836-1-philmd@linaro.org>
References: <20241206181352.6836-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

The FW_CFG_DATA_GENERATOR allows any object to produce
blob of data consumable by the fw_cfg device. Implement
that for PCI bus objects.

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


