Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D63ED58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyux-0005TV-6n; Mon, 02 Mar 2026 03:46:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu4-0004Wx-VS
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu2-0001sA-6R
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HxkvqRRnYlF5KbWk2tQ9vyhLJTy/NzSBIyzd6zZjB+M=;
 b=hOyhwv9Ym8hF+ZUF4dkBDUYK4yQ3eOjxLoJW4DJxgeRF4UD9gqa5xC/F7JhQeIrHNX6T9a
 b2yPqbTEhtbhZKKNQO9Igl8GEx5nnPQR8gFZHcyKT+sF0j6s58TlD0r2tLJEffLBbT2bkZ
 it1/NdVzJXhO+Bam0ptobQZYRuo+87c=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-_daOfsgfP7uDJ_k9sSN6HA-1; Mon, 02 Mar 2026 03:45:16 -0500
X-MC-Unique: _daOfsgfP7uDJ_k9sSN6HA-1
X-Mimecast-MFC-AGG-ID: _daOfsgfP7uDJ_k9sSN6HA_1772441115
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4836bf1a920so44012345e9.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441114; x=1773045914; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HxkvqRRnYlF5KbWk2tQ9vyhLJTy/NzSBIyzd6zZjB+M=;
 b=DimGMbYcLuXB6BsX3tzeDx9/pDwv9NPpy4VOcjMyZYLaZTBiDvQ+lHn4bTKvQeQNoZ
 FtRPsd9nMvwKq4XDHcdVPzqcr/YR8vBQNKgStXt4dBxgL5hHTAIBJaMqKLsNJ8eZHt9S
 dL0A0tWN8C7F2QyBQaiee2hIMvFrLz4F/i2CelZRGQKDndywYMWam3AG7lV5SFA3LkWC
 d9IQogA+N3y1scoNal0wM8rVCR/0J8RDiM9yC/DNwDygqH4eH/kv/HdiAlRZANCEtDcT
 j/cUqSztovjwMIuFL87AaxrW23D/HQgQ0vEzHcjhghzVeL/lfsvmWte+Cp0f0m5Y1QT3
 bx0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441114; x=1773045914;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HxkvqRRnYlF5KbWk2tQ9vyhLJTy/NzSBIyzd6zZjB+M=;
 b=jQr9db9x6GZe1jtbIIkqUbRX0ZhSbsGs9JAFE9TRD18x2HbjYC1KifzB2kpy4WTC3i
 OUvQ1DFoWPguC2daK7EpZOkFkFVhcBhj9PiS2Mj2Px5ktbUodCpXYI3xpJE2hzsY0DYp
 g7uwG/pKoycJMBj+ocH+inK/lcm0FVZd1Xfh3+gAQQ2So/H9Myl1XwVkRxAoQ+ANarYZ
 OPyetRqNUrqGK97SVoB+Hc+0trH0hhK81CBFl5ZcUxDpced0XfeTdE6Am6mFm21ergjj
 VsfQfd/Ac6MBngLF+MhOLjrTY+9PF/ciWN+t8bURqFbYyNkS7dUnqgEsZDUJNnKOGkT6
 qaFA==
X-Gm-Message-State: AOJu0YzX1wJA4NE1l8sghMc9Zs+6ASFnBkdmbmz6CrgAruNLu6AeF6MF
 n++E1clLebNVYU1FINgwrwIri38s+/PD8acRkfAC98XH36xA/m0PmBcbRg6QVkM/uLUoG+aGhrT
 IUMO+aKgt5kK1uBjXzs3N4yhTHZl7FNXYWhgd/zbZpOWIf5ejOuq1QFkijsLT3xdoTJMByDj4zs
 ZlyjE29PCovFq9Av3uTADa8PuTx+biev0bHz88LzTV
X-Gm-Gg: ATEYQzw1XASnxqzakb8s9Crzveht5vkz+ruKvkUHcI1VgeU757mqXWFJdpFqoEhzGgi
 gGMXwmqcuOhpn1RJuNh0YaYn37S+1lIpsXwJ9whhAm7xNGSDuqWeh0bPLzqGG5pv2GNDs6tg/hn
 AZNrFre10yUPiz7SrGyqoBBp7NnUZOu+kT1aRwck8Ze89lI24xZnz34bq613svZAsTbc4dVTJDj
 WoVVVS3YRInpbA1KFVNe7cJ2K/Zem/3p/5pvqFKGnzaEpvmHGXsuS8jufdBsohuPhJBAOVK3bGM
 gY+3EspzpzF0/9N87H9V8oZb0zOEWxjwiheEW6M6W4+XH+jVdm8CVicn152LogJ/itqYdJCuK//
 fNv0TzRZvnrQj9BiGi8oDnVb9OGy3LIkd1IsJGoCJ6ERmUaKCSKeDIR8qyg5DtGp8oX8HfjiA5c
 a8YDNHuldLEe/17q8/v6GUs1ju1nE=
X-Received: by 2002:a05:600c:8b01:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-483c9beb38emr216891585e9.35.1772441113676; 
 Mon, 02 Mar 2026 00:45:13 -0800 (PST)
X-Received: by 2002:a05:600c:8b01:b0:477:9b4a:a82 with SMTP id
 5b1f17b1804b1-483c9beb38emr216890995e9.35.1772441113149; 
 Mon, 02 Mar 2026 00:45:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b89c99sm270042655e9.15.2026.03.02.00.45.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:12 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 035/102] hw/nitro/nitro-serial-vsock: Nitro Enclaves vsock
 console
Date: Mon,  2 Mar 2026 09:42:30 +0100
Message-ID: <20260302084338.473368-36-pbonzini@redhat.com>
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

Nitro Enclaves support a special "debug" mode. When in debug mode, the
Nitro Hypervisor provides a vsock port that the parent can connect to to
receive serial console output of the Enclave. Add a new nitro-serial-vsock
driver that implements short-circuit logic to establish the vsock
connection to that port and feed its data into a chardev, so that a machine
model can use it as serial device.

Signed-off-by: Alexander Graf <graf@amazon.com>

Link: https://lore.kernel.org/r/20260225220807.33092-6-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/nitro/serial-vsock.h |  24 +++++++
 hw/nitro/serial-vsock.c         | 123 ++++++++++++++++++++++++++++++++
 hw/nitro/Kconfig                |   4 ++
 hw/nitro/meson.build            |   1 +
 hw/nitro/trace-events           |   2 +
 5 files changed, 154 insertions(+)
 create mode 100644 include/hw/nitro/serial-vsock.h
 create mode 100644 hw/nitro/serial-vsock.c

diff --git a/include/hw/nitro/serial-vsock.h b/include/hw/nitro/serial-vsock.h
new file mode 100644
index 00000000000..c365880e110
--- /dev/null
+++ b/include/hw/nitro/serial-vsock.h
@@ -0,0 +1,24 @@
+/*
+ * Nitro Enclave Serial (vsock)
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_CHAR_NITRO_SERIAL_VSOCK_H
+#define HW_CHAR_NITRO_SERIAL_VSOCK_H
+
+#include "hw/nitro/nitro-vsock-bus.h"
+#include "chardev/char-fe.h"
+#include "qom/object.h"
+
+#define TYPE_NITRO_SERIAL_VSOCK "nitro-serial-vsock"
+OBJECT_DECLARE_SIMPLE_TYPE(NitroSerialVsockState, NITRO_SERIAL_VSOCK)
+
+struct NitroSerialVsockState {
+    NitroVsockDevice parent_obj;
+
+    CharFrontend output;    /* chardev to write console output to */
+    CharFrontend vsock;     /* vsock chardev to enclave console */
+};
+
+#endif /* HW_CHAR_NITRO_SERIAL_VSOCK_H */
diff --git a/hw/nitro/serial-vsock.c b/hw/nitro/serial-vsock.c
new file mode 100644
index 00000000000..1d56c338049
--- /dev/null
+++ b/hw/nitro/serial-vsock.c
@@ -0,0 +1,123 @@
+/*
+ * Nitro Enclave Vsock Serial
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Authors:
+ *   Alexander Graf <graf@amazon.com>
+ *
+ * With Nitro Enclaves in debug mode, the Nitro Hypervisor provides a vsock
+ * port that the parent can connect to to receive serial console output of
+ * the Enclave. This driver implements short-circuit logic to establish the
+ * vsock connection to that port and feed its data into a chardev, so that
+ * a machine model can use it as serial device.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "hw/core/qdev-properties.h"
+#include "hw/core/qdev-properties-system.h"
+#include "hw/nitro/serial-vsock.h"
+#include "trace.h"
+
+#define CONSOLE_PORT_START 10000
+#define VMADDR_CID_HYPERVISOR_STR "0"
+
+static int nitro_serial_vsock_can_read(void *opaque)
+{
+    NitroSerialVsockState *s = opaque;
+
+    /* Refuse vsock input until the output backend is ready */
+    return qemu_chr_fe_backend_open(&s->output) ? 4096 : 0;
+}
+
+static void nitro_serial_vsock_read(void *opaque, const uint8_t *buf, int size)
+{
+    NitroSerialVsockState *s = opaque;
+
+    /* Forward all vsock data to the output chardev */
+    qemu_chr_fe_write_all(&s->output, buf, size);
+}
+
+static void nitro_serial_vsock_event(void *opaque, QEMUChrEvent event)
+{
+    /* No need to action on connect/disconnect events, but trace for debug */
+    trace_nitro_serial_vsock_event(event);
+}
+
+static void nitro_serial_vsock_enclave_started(NitroVsockDevice *dev,
+                                               uint32_t enclave_cid,
+                                               Error **errp)
+{
+    NitroSerialVsockState *s = NITRO_SERIAL_VSOCK(dev);
+    uint32_t port = enclave_cid + CONSOLE_PORT_START;
+    g_autofree char *chardev_id = NULL;
+    Chardev *chr;
+    ChardevBackend *backend;
+    ChardevSocket *sock;
+
+    /*
+     * We know the Enclave CID to connect to now. Create a vsock
+     * client chardev that connects to the Enclave's console.
+     */
+    chardev_id = g_strdup_printf("nitro-console-%u", enclave_cid);
+
+    backend = g_new0(ChardevBackend, 1);
+    backend->type = CHARDEV_BACKEND_KIND_SOCKET;
+    sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
+    sock->addr = g_new0(SocketAddressLegacy, 1);
+    sock->addr->type = SOCKET_ADDRESS_TYPE_VSOCK;
+    sock->addr->u.vsock.data = g_new0(VsockSocketAddress, 1);
+    sock->addr->u.vsock.data->cid = g_strdup(VMADDR_CID_HYPERVISOR_STR);
+    sock->addr->u.vsock.data->port = g_strdup_printf("%u", port);
+    sock->server = false;
+    sock->has_server = true;
+
+    chr = qemu_chardev_new(chardev_id, TYPE_CHARDEV_SOCKET,
+                           backend, NULL, errp);
+    if (!chr) {
+        return;
+    }
+
+    if (!qemu_chr_fe_init(&s->vsock, chr, errp)) {
+        return;
+    }
+
+    qemu_chr_fe_set_handlers(&s->vsock,
+                             nitro_serial_vsock_can_read,
+                             nitro_serial_vsock_read,
+                             nitro_serial_vsock_event,
+                             NULL, s, NULL, true);
+}
+
+static const Property nitro_serial_vsock_props[] = {
+    DEFINE_PROP_CHR("chardev", NitroSerialVsockState, output),
+};
+
+static void nitro_serial_vsock_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    NitroVsockDeviceClass *ndc = NITRO_VSOCK_DEVICE_CLASS(oc);
+
+    device_class_set_props(dc, nitro_serial_vsock_props);
+    ndc->enclave_started = nitro_serial_vsock_enclave_started;
+}
+
+static const TypeInfo nitro_serial_vsock_info = {
+    .name = TYPE_NITRO_SERIAL_VSOCK,
+    .parent = TYPE_NITRO_VSOCK_DEVICE,
+    .instance_size = sizeof(NitroSerialVsockState),
+    .class_init = nitro_serial_vsock_class_init,
+};
+
+static void nitro_serial_vsock_register(void)
+{
+    type_register_static(&nitro_serial_vsock_info);
+}
+
+type_init(nitro_serial_vsock_register);
diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
index 767472cb2c6..ce24c09c218 100644
--- a/hw/nitro/Kconfig
+++ b/hw/nitro/Kconfig
@@ -1,2 +1,6 @@
 config NITRO_VSOCK_BUS
     bool
+
+config NITRO_SERIAL_VSOCK
+    bool
+    depends on NITRO_VSOCK_BUS
diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
index 7e2807f1379..76399d4265d 100644
--- a/hw/nitro/meson.build
+++ b/hw/nitro/meson.build
@@ -1 +1,2 @@
 system_ss.add(when: 'CONFIG_NITRO_VSOCK_BUS', if_true: files('nitro-vsock-bus.c'))
+system_ss.add(when: 'CONFIG_NITRO_SERIAL_VSOCK', if_true: files('serial-vsock.c'))
diff --git a/hw/nitro/trace-events b/hw/nitro/trace-events
index 9ccc5790487..20617a024a9 100644
--- a/hw/nitro/trace-events
+++ b/hw/nitro/trace-events
@@ -1,2 +1,4 @@
 # See docs/devel/tracing.rst for syntax documentation.
 
+# serial-vsock.c
+nitro_serial_vsock_event(int event) "event %d"
-- 
2.53.0


