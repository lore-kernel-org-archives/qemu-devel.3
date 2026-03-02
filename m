Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7212D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyu5-0004a0-NI; Mon, 02 Mar 2026 03:45:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytv-0003bA-D1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytt-0001qi-4B
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z8fdGKj2U4eZl70HRcrV9ZuNs8saWotz1oFJDPe1L4c=;
 b=WLyiDXXHF9pmw8YrRkzbNJRzJXZnog7M01FOoLfR/zKysSR+t9qmbG8ggJ3+B9ah6D7xYq
 WgQnd3ouoqnCWsyndMLW6FH7HwOwtErL1Zi8qr6mV70eZqTcLqXgDmkknPur7teulW52dK
 E2V0jTtfpnM79WB2tT6g4s5psZGBXDs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-qMco-7buM6SkSj8ZdckWcg-1; Mon, 02 Mar 2026 03:45:10 -0500
X-MC-Unique: qMco-7buM6SkSj8ZdckWcg-1
X-Mimecast-MFC-AGG-ID: qMco-7buM6SkSj8ZdckWcg_1772441109
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4837907ec88so48397255e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441108; x=1773045908; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z8fdGKj2U4eZl70HRcrV9ZuNs8saWotz1oFJDPe1L4c=;
 b=OtQ3qqo23HrjEoI/3KJzJwCTQfglroxbI++z16aNvk5e2ZkdcqG2Z6qRXEGWSHakQm
 LhcimJaBMdzAGwl36jq2uqPTYfJNGY0ChwEPMaEUhAAxqcgr2IXiFCgXo+Gmzll6i8vN
 b5h9l6Tjd1KHlEkFxagJhIK+SdilF3nTp7zPGwpv8iOIedrE9rjqKwrw+nnxY2ksBogU
 T9rDc7EaFtsyoxZRkY48D4udwc6MGeGtiWs56yLvZBdK2eFF2pyCP8SiEkl7m2QsB+XI
 vmc0dnlCbXQ46VbUw6Iwf8+oJlzrOXrLEauZSDQWWNm3aqtcSKmK2X22hdhNrYHleq5J
 Ls0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441108; x=1773045908;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=z8fdGKj2U4eZl70HRcrV9ZuNs8saWotz1oFJDPe1L4c=;
 b=RYpWbxBxJ4N64jReK4UB1bXyqg3tuvd2MxxCui1dSG2mH9sJdn26bO9KBKzPUmir5O
 g8F2DY6eo0Tw9TTEtljCI/0IAHSpJwYMEmVmC2mq9AJJH8v0n1La7ouLt6h6nr7mcQtu
 YxL0rlzbxhkzhrByS5Ru0kqZMVtjAQr21V0hIb+rzTcoLBTudKFNApAAXcm03SBTBqnD
 A1s9icGdb+jklEFBMtTAJAMWBoq14VhgzaJGRsEpQja1CKQq5uQm+bz3ZvaqKL2MHLOX
 4KCr6JaNQ2LA0viTnjM/VmPYB1VCPYRR1HKHOFXRov6r4LmI7JJr4MXP6w62O+P7YbYG
 sfKA==
X-Gm-Message-State: AOJu0YzzoEfia9mdnqlV3o+7vdu9F73g6zcJ3QSW+F0oTAYEmcRhwRpj
 NWTV7ua3D0pFLyJ4LX5OrfDei7yemGNc+wOFU4WjTkpb3Lq937q8NWQcsTI/nAGajYLTZW+ZO0w
 6wBleBfGQA2cr3gG7h6TGWmK5OQd5vFQFWNvdBKxwuDu+LPRvyTcpUNEAcRQ3qjJBQGKdybZYAa
 e2UEqZx9qqi47ifU9E1RyhW/VDhnh3paAyNd820hSE
X-Gm-Gg: ATEYQzxEQUXmP0IBCgbigeJshXOp/NGekNCbu8RSqh2B8QzfgULBl47Y6NVbPsQ05hC
 iwTM7dVSwJBgkGNYVhtdgbRPSpOOHz/cUtBB/Ov3r9r93aIkI0FwpCerGvUGMYq2YlVlLCbXH+m
 G//rc28/egOszXy1t5lGkzSrnEOUVaRQStAVDei5Mz/aR8RtPE+RW8Mws88P3jmYasc4y8ldCfN
 m0Jh5fFACIqkebAaJgXTEzL2gSGuH+1R927HB04XT/tBMQPJbuHETOi2PK4mpU72G+puLi9xnoU
 /51p/Xb1lsvRwCwBxHYFGdCjnTvjN0X3LcLQgSR+fS5zbsUkzoVSyF+QwvSLkCOvu8blVnKNId5
 AU5OQPs+zRYgFsogkHZhszzJAnBNR7tlgosVTUMg5erhno/s9KL/lP67Q2ycM2zhMZ25az1Nz0S
 euFdWzyDBstpLjq1xDwyjtbAsGZDU=
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483c9c2059bmr169572555e9.32.1772441108277; 
 Mon, 02 Mar 2026 00:45:08 -0800 (PST)
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483c9c2059bmr169572045e9.32.1772441107762; 
 Mon, 02 Mar 2026 00:45:07 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcb318fsm194574745e9.6.2026.03.02.00.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:07 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 033/102] hw/nitro: Add Nitro Vsock Bus
Date: Mon,  2 Mar 2026 09:42:28 +0100
Message-ID: <20260302084338.473368-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Alexander Graf <graf@amazon.com>

Add a dedicated bus for Nitro Enclave vsock devices. In Nitro Enclaves,
communication between parent and enclave/hypervisor happens almost
exclusively through vsock. The nitro-vsock-bus models this dependency
in QEMU, which allows devices in this bus to implement individual services
on top of vsock.

The nitro machine spawns this bus by creating the included
nitro-vsock-bridge sysbus device.

The nitro accel then advertises the Enclave's CID to the bus by calling
nitro_vsock_bridge_start_enclave() on the bridge device as soon as it
knows the CID.

Nitro vsock devices can listen to that event and learn the Enclave's CID
when it is available to perform actions, such as connect to the debug
serial vsock port.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Alexander Graf <graf@amazon.com>
Link: https://lore.kernel.org/r/20260225220807.33092-4-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS                        |  6 ++
 meson.build                        |  1 +
 hw/nitro/trace.h                   |  4 ++
 include/hw/nitro/nitro-vsock-bus.h | 71 ++++++++++++++++++++++
 hw/nitro/nitro-vsock-bus.c         | 98 ++++++++++++++++++++++++++++++
 hw/Kconfig                         |  1 +
 hw/meson.build                     |  1 +
 hw/nitro/Kconfig                   |  2 +
 hw/nitro/meson.build               |  1 +
 hw/nitro/trace-events              |  2 +
 10 files changed, 187 insertions(+)
 create mode 100644 hw/nitro/trace.h
 create mode 100644 include/hw/nitro/nitro-vsock-bus.h
 create mode 100644 hw/nitro/nitro-vsock-bus.c
 create mode 100644 hw/nitro/Kconfig
 create mode 100644 hw/nitro/meson.build
 create mode 100644 hw/nitro/trace-events

diff --git a/MAINTAINERS b/MAINTAINERS
index 606b16762cf..d781fe59bb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3020,6 +3020,12 @@ F: hw/vmapple/*
 F: include/hw/vmapple/*
 F: docs/system/arm/vmapple.rst
 
+Nitro Enclaves (native)
+M: Alexander Graf <graf@amazon.com>
+S: Maintained
+F: hw/nitro/
+F: include/hw/nitro/
+
 Subsystems
 ----------
 Overall Audio backends
diff --git a/meson.build b/meson.build
index 2bae618d848..f3ee08772d4 100644
--- a/meson.build
+++ b/meson.build
@@ -3620,6 +3620,7 @@ if have_system
     'hw/misc/macio',
     'hw/net',
     'hw/net/can',
+    'hw/nitro',
     'hw/nubus',
     'hw/nvme',
     'hw/nvram',
diff --git a/hw/nitro/trace.h b/hw/nitro/trace.h
new file mode 100644
index 00000000000..b455d6c17b3
--- /dev/null
+++ b/hw/nitro/trace.h
@@ -0,0 +1,4 @@
+/*
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+#include "trace/trace-hw_nitro.h"
diff --git a/include/hw/nitro/nitro-vsock-bus.h b/include/hw/nitro/nitro-vsock-bus.h
new file mode 100644
index 00000000000..064260aa410
--- /dev/null
+++ b/include/hw/nitro/nitro-vsock-bus.h
@@ -0,0 +1,71 @@
+/*
+ * Nitro Enclave Vsock Bus
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_NITRO_VSOCK_BUS_H
+#define HW_NITRO_VSOCK_BUS_H
+
+#include "hw/core/qdev.h"
+#include "hw/core/sysbus.h"
+#include "qom/object.h"
+
+#define TYPE_NITRO_VSOCK_BUS "nitro-vsock-bus"
+OBJECT_DECLARE_SIMPLE_TYPE(NitroVsockBus, NITRO_VSOCK_BUS)
+
+#define TYPE_NITRO_VSOCK_BRIDGE "nitro-vsock-bridge"
+OBJECT_DECLARE_SIMPLE_TYPE(NitroVsockBridge, NITRO_VSOCK_BRIDGE)
+
+#define TYPE_NITRO_VSOCK_DEVICE "nitro-vsock-device"
+OBJECT_DECLARE_TYPE(NitroVsockDevice, NitroVsockDeviceClass,
+                    NITRO_VSOCK_DEVICE)
+
+struct NitroVsockBus {
+    BusState parent_obj;
+};
+
+struct NitroVsockBridge {
+    SysBusDevice parent_obj;
+
+    NitroVsockBus bus;
+    uint32_t enclave_cid;
+};
+
+struct NitroVsockDevice {
+    DeviceState parent_obj;
+};
+
+struct NitroVsockDeviceClass {
+    DeviceClass parent_class;
+
+    /*
+     * Called after the enclave has been started and the CID is known.
+     * Devices use this to establish vsock connections to the enclave.
+     */
+    void (*enclave_started)(NitroVsockDevice *dev, uint32_t enclave_cid,
+                            Error **errp);
+};
+
+/*
+ * Machine helper to create the Nitro vsock bridge sysbus device.
+ */
+NitroVsockBridge *nitro_vsock_bridge_create(void);
+
+/*
+ * Find the Nitro vsock bridge on the sysbus.
+ */
+static inline NitroVsockBridge *nitro_vsock_bridge_find(void)
+{
+    return NITRO_VSOCK_BRIDGE(
+        object_resolve_path_type("", TYPE_NITRO_VSOCK_BRIDGE, NULL));
+}
+
+/*
+ * Notify the bridge that the enclave has started. Dispatches
+ * enclave_started() to all devices on the bus.
+ */
+void nitro_vsock_bridge_start_enclave(NitroVsockBridge *bridge,
+                                      uint32_t enclave_cid, Error **errp);
+
+#endif /* HW_NITRO_VSOCK_BUS_H */
diff --git a/hw/nitro/nitro-vsock-bus.c b/hw/nitro/nitro-vsock-bus.c
new file mode 100644
index 00000000000..eed29df512e
--- /dev/null
+++ b/hw/nitro/nitro-vsock-bus.c
@@ -0,0 +1,98 @@
+/*
+ * Nitro Enclave Vsock Bus
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Authors:
+ *   Alexander Graf <graf@amazon.com>
+ *
+ * A bus for Nitro Enclave vsock devices. In Nitro Enclaves, communication
+ * between parent and enclave/hypervisor happens almost exclusively through
+ * vsock. The nitro-vsock-bus models this dependency in QEMU, which allows
+ * devices in this bus to implement individual services on top of vsock.
+ *
+ * The nitro accel advertises the Enclave's CID to the bus by calling
+ * nitro_vsock_bridge_start_enclave() on the bridge device as soon as it
+ * knows the CID.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "monitor/qdev.h"
+#include "hw/core/sysbus.h"
+#include "hw/nitro/nitro-vsock-bus.h"
+
+void nitro_vsock_bridge_start_enclave(NitroVsockBridge *bridge,
+                                      uint32_t enclave_cid, Error **errp)
+{
+    ERRP_GUARD();
+    BusState *qbus = BUS(&bridge->bus);
+    BusChild *kid;
+
+    bridge->enclave_cid = enclave_cid;
+
+    QTAILQ_FOREACH(kid, &qbus->children, sibling) {
+        NitroVsockDevice *ndev = NITRO_VSOCK_DEVICE(kid->child);
+        NitroVsockDeviceClass *ndc = NITRO_VSOCK_DEVICE_GET_CLASS(ndev);
+
+        if (ndc->enclave_started) {
+            ndc->enclave_started(ndev, enclave_cid, errp);
+            if (*errp) {
+                return;
+            }
+        }
+    }
+}
+
+NitroVsockBridge *nitro_vsock_bridge_create(void)
+{
+    DeviceState *dev = qdev_new(TYPE_NITRO_VSOCK_BRIDGE);
+
+    qdev_set_id(dev, g_strdup("nitro-vsock"), &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+
+    return NITRO_VSOCK_BRIDGE(dev);
+}
+
+static void nitro_vsock_bridge_init(Object *obj)
+{
+    NitroVsockBridge *s = NITRO_VSOCK_BRIDGE(obj);
+
+    qbus_init(&s->bus, sizeof(s->bus), TYPE_NITRO_VSOCK_BUS,
+              DEVICE(s), "nitro-vsock");
+    object_property_add_uint32_ptr(obj, "enclave-cid",
+                                   &s->enclave_cid, OBJ_PROP_FLAG_READ);
+}
+
+static void nitro_vsock_device_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->bus_type = TYPE_NITRO_VSOCK_BUS;
+}
+
+static const TypeInfo nitro_vsock_bus_types[] = {
+    {
+        .name = TYPE_NITRO_VSOCK_BUS,
+        .parent = TYPE_BUS,
+        .instance_size = sizeof(NitroVsockBus),
+    },
+    {
+        .name = TYPE_NITRO_VSOCK_BRIDGE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(NitroVsockBridge),
+        .instance_init = nitro_vsock_bridge_init,
+    },
+    {
+        .name = TYPE_NITRO_VSOCK_DEVICE,
+        .parent = TYPE_DEVICE,
+        .instance_size = sizeof(NitroVsockDevice),
+        .class_size = sizeof(NitroVsockDeviceClass),
+        .class_init = nitro_vsock_device_class_init,
+        .abstract = true,
+    },
+};
+
+DEFINE_TYPES(nitro_vsock_bus_types);
diff --git a/hw/Kconfig b/hw/Kconfig
index f8f92b5d03d..b3ce1520a6b 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -22,6 +22,7 @@ source isa/Kconfig
 source mem/Kconfig
 source misc/Kconfig
 source net/Kconfig
+source nitro/Kconfig
 source nubus/Kconfig
 source nvme/Kconfig
 source nvram/Kconfig
diff --git a/hw/meson.build b/hw/meson.build
index 66e46b8090d..36da5322f7e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -44,6 +44,7 @@ subdir('isa')
 subdir('mem')
 subdir('misc')
 subdir('net')
+subdir('nitro')
 subdir('nubus')
 subdir('nvme')
 subdir('nvram')
diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
new file mode 100644
index 00000000000..767472cb2c6
--- /dev/null
+++ b/hw/nitro/Kconfig
@@ -0,0 +1,2 @@
+config NITRO_VSOCK_BUS
+    bool
diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
new file mode 100644
index 00000000000..7e2807f1379
--- /dev/null
+++ b/hw/nitro/meson.build
@@ -0,0 +1 @@
+system_ss.add(when: 'CONFIG_NITRO_VSOCK_BUS', if_true: files('nitro-vsock-bus.c'))
diff --git a/hw/nitro/trace-events b/hw/nitro/trace-events
new file mode 100644
index 00000000000..9ccc5790487
--- /dev/null
+++ b/hw/nitro/trace-events
@@ -0,0 +1,2 @@
+# See docs/devel/tracing.rst for syntax documentation.
+
-- 
2.53.0


