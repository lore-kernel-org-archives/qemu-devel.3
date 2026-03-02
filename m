Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D27FD58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:56:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyuI-0004iX-OM; Mon, 02 Mar 2026 03:45:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu4-0004WT-Uv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyu1-0001s8-OM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:45:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441120;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5cg9iNAoCO+mSrl7FtUY4PQzOZ1uktu6y7WfAOJhKwI=;
 b=PjGX5MNg+mQPLqGs02q/YwScty8Y0QY1WT/yaPPUDcIymx/O259/r3jbk0ESYcd5l5YUaa
 EEmyvrLm4HdCdoWzyaP751U598hL1j1AZPw4cnlGXYC+kDFBnrvPq0wbZVVLN4ANeHoSnH
 OHAMOYlv3Yy327r3lzzF48ssCFBwC58=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-39_OQ360PJKEXnjG-ptSQw-1; Mon, 02 Mar 2026 03:45:19 -0500
X-MC-Unique: 39_OQ360PJKEXnjG-ptSQw-1
X-Mimecast-MFC-AGG-ID: 39_OQ360PJKEXnjG-ptSQw_1772441118
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4836cc0b38eso46190415e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:45:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441117; x=1773045917; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5cg9iNAoCO+mSrl7FtUY4PQzOZ1uktu6y7WfAOJhKwI=;
 b=Sog9covcUy0jomS+0+5aJezTfKWaO++ud0TSUILYaXOOM40dizQXmAoq6EuwJAnmoF
 Wu8RS2/d2d7fBe2/1eGSOel3jOcthnHw/t7NZMpbqNOb9H4b2r58yNjcgIUqmNfaavm6
 K+sYHITy086T/UhzdsGUpKwkqOvvcUtKXJbHJ0+yj+lPd3cGaaKDFbIGlCN3smgQy4Ty
 735K7jIeBgM50ga/PUVdfhdLRhi42OVqyaNc2KDm7PqFmN6ckn5YPVqeAG/JEhsu3V7c
 v5D0N/qMvxuiElrDvounYa1AZntTFmvExJDPsx9WRj8xlX8ofZpCl3djVVBaMzp9Hs28
 gNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441117; x=1773045917;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5cg9iNAoCO+mSrl7FtUY4PQzOZ1uktu6y7WfAOJhKwI=;
 b=FvsY9GI/Je6p2XWQ4bU1wXEPnLZ52F37GvSFqVsukW8Z+NehKD5N8z0WnHCfomynSm
 +Ca1fH/GUGt6+WXLXJGztNVgO4GPdBgBIwH/qzHO3rZC1JgzrY1JGgOwnEifzDTumHcg
 Pcb/tCLIBoGWRmPXp2f7NzA8vRf38BgeWNmaMWupBcFdI0B6/KoKy2xWpBtN9sv0dLx9
 nuZrGCWY3prsDhPBr6zve1cxst2h2wx2cSSKHXaGW1dTNrjjVPqKHgiBRzxrR19p+xN9
 kMnIoVschWUHmGiRWvztO7SXWEDn7Z/oSg2GRZQZbMySE83qbBeBxoNVnV0L5oNO33KB
 RCpQ==
X-Gm-Message-State: AOJu0YwvRmrXS8Rh3Yx0XDIGTlxi4JM7qpwv2o7UFkhpIpKolWX54kGw
 sTLZM/i6SpAxa+wZAOM1fwlKOc+DkQDsfyoeB5d5cAFcKoE+qEVH/ZnsjrVTlRr4cNIdoeymc+a
 Hh/p4wfbHy9/pjOpOYVd6ZI7RupJ+4yc31+R+SSaRSzAL1NxPG2F/oy6yI3sk16CoitECpv6ICf
 jK59xZHZZSUJYFpVzWibwI1VTvxSbtaQXTNvvoySuY
X-Gm-Gg: ATEYQzxLjF7NrO/vdzHtE5rX4+Px5dsO90hZJnxB5kRNy69qKqPjUhmB+Lv5FHKgS4r
 BM7teiHTH+RyRFPo7nciXBo8Q1bAbs5YKYEBVKIhT4x53Rxk//hGS2cUXGFmjusxEc4Gn+MOwEe
 7pQvT2p/8GD3qN4aDLq6mB2OoVdCNl8kzKd2zWaA1yMtWOrSJ7CYDprHMHiRzZQ2uXjlgNU0zqy
 FJE1Mf3qF5/FDPeC2qAL9QlhJSqOLLDlnPAijU4mZ9ytEPGOCwMfk5wVado4hwYyDj8K/yZINb3
 Q8uCwNp1MMXEIwpgOmIZKbyrxq8sYHsP0wVle4ifJQtK/lBHUAb5lTYvgBA5W1J+ViQVJX+nRMR
 H7iyc50mN4Zj3PyIV1b/jRiiwRI7aFbReG82DrzUZ1ylVDJGhH1LfcTdFQxVoS3pTD4hJtoP2Hi
 je5C/ZLoMwhc+1jd5XYlr1IvPgp9U=
X-Received: by 2002:a05:600c:621b:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483c9babe69mr198708165e9.11.1772441117238; 
 Mon, 02 Mar 2026 00:45:17 -0800 (PST)
X-Received: by 2002:a05:600c:621b:b0:47e:e076:c7a5 with SMTP id
 5b1f17b1804b1-483c9babe69mr198707675e9.11.1772441116677; 
 Mon, 02 Mar 2026 00:45:16 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483c3b841absm305835035e9.13.2026.03.02.00.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:45:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <graf@amazon.com>
Subject: [PULL 036/102] hw/nitro: Introduce Nitro Enclave Heartbeat device
Date: Mon,  2 Mar 2026 09:42:31 +0100
Message-ID: <20260302084338.473368-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Nitro Enclaves expect the parent instance to host a vsock heartbeat listener
at port 9000. To host a Nitro Enclave with the nitro accel in QEMU, add
such a heartbeat listener as device model, so that the machine can
easily instantiate it.

Signed-off-by: Alexander Graf <graf@amazon.com>

Link: https://lore.kernel.org/r/20260225220807.33092-7-graf@amazon.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/nitro/heartbeat.h |  24 ++++++++
 hw/nitro/heartbeat.c         | 115 +++++++++++++++++++++++++++++++++++
 hw/nitro/Kconfig             |   4 ++
 hw/nitro/meson.build         |   1 +
 hw/nitro/trace-events        |   4 ++
 5 files changed, 148 insertions(+)
 create mode 100644 include/hw/nitro/heartbeat.h
 create mode 100644 hw/nitro/heartbeat.c

diff --git a/include/hw/nitro/heartbeat.h b/include/hw/nitro/heartbeat.h
new file mode 100644
index 00000000000..6b9271a47df
--- /dev/null
+++ b/include/hw/nitro/heartbeat.h
@@ -0,0 +1,24 @@
+/*
+ * Nitro Heartbeat device
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_MISC_NITRO_HEARTBEAT_H
+#define HW_MISC_NITRO_HEARTBEAT_H
+
+#include "hw/nitro/nitro-vsock-bus.h"
+#include "chardev/char-fe.h"
+#include "qom/object.h"
+
+#define TYPE_NITRO_HEARTBEAT "nitro-heartbeat"
+OBJECT_DECLARE_SIMPLE_TYPE(NitroHeartbeatState, NITRO_HEARTBEAT)
+
+struct NitroHeartbeatState {
+    NitroVsockDevice parent_obj;
+
+    CharFrontend vsock;     /* vsock server chardev for heartbeat */
+    bool done;
+};
+
+#endif /* HW_MISC_NITRO_HEARTBEAT_H */
diff --git a/hw/nitro/heartbeat.c b/hw/nitro/heartbeat.c
new file mode 100644
index 00000000000..dc413232667
--- /dev/null
+++ b/hw/nitro/heartbeat.c
@@ -0,0 +1,115 @@
+/*
+ * Nitro Enclave Heartbeat device
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates. All Rights Reserved.
+ *
+ * Authors:
+ *   Alexander Graf <graf@amazon.com>
+ *
+ * The Nitro Enclave init process sends a heartbeat byte (0xB7) to
+ * CID 3 (parent) port 9000 on boot to signal it reached initramfs.
+ * The parent must accept the connection, read the byte, and echo it
+ * back. If the enclave init cannot reach the listener, it exits.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "chardev/char.h"
+#include "chardev/char-fe.h"
+#include "hw/nitro/heartbeat.h"
+#include "trace.h"
+
+#define HEARTBEAT_PORT      9000
+#define VMADDR_CID_ANY_STR  "4294967295"
+
+static int nitro_heartbeat_can_read(void *opaque)
+{
+    NitroHeartbeatState *s = opaque;
+
+    /* One-shot protocol: stop reading after the first heartbeat */
+    return s->done ? 0 : 1;
+}
+
+static void nitro_heartbeat_read(void *opaque, const uint8_t *buf, int size)
+{
+    NitroHeartbeatState *s = opaque;
+
+    if (s->done || size < 1) {
+        return;
+    }
+
+    /* Echo the heartbeat byte back and disconnect */
+    qemu_chr_fe_write_all(&s->vsock, buf, 1);
+    s->done = true;
+    qemu_chr_fe_deinit(&s->vsock, true);
+
+    trace_nitro_heartbeat_done();
+}
+
+static void nitro_heartbeat_event(void *opaque, QEMUChrEvent event)
+{
+    trace_nitro_heartbeat_event(event);
+}
+
+static void nitro_heartbeat_realize(DeviceState *dev, Error **errp)
+{
+    NitroHeartbeatState *s = NITRO_HEARTBEAT(dev);
+    g_autofree char *chardev_id = NULL;
+    Chardev *chr;
+    ChardevBackend *backend;
+    ChardevSocket *sock;
+
+    chardev_id = g_strdup_printf("nitro-heartbeat");
+
+    backend = g_new0(ChardevBackend, 1);
+    backend->type = CHARDEV_BACKEND_KIND_SOCKET;
+    sock = backend->u.socket.data = g_new0(ChardevSocket, 1);
+    sock->addr = g_new0(SocketAddressLegacy, 1);
+    sock->addr->type = SOCKET_ADDRESS_TYPE_VSOCK;
+    sock->addr->u.vsock.data = g_new0(VsockSocketAddress, 1);
+    sock->addr->u.vsock.data->cid = g_strdup(VMADDR_CID_ANY_STR);
+    sock->addr->u.vsock.data->port = g_strdup_printf("%u", HEARTBEAT_PORT);
+    sock->server = true;
+    sock->has_server = true;
+    sock->wait = false;
+    sock->has_wait = true;
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
+                             nitro_heartbeat_can_read,
+                             nitro_heartbeat_read,
+                             nitro_heartbeat_event,
+                             NULL, s, NULL, true);
+}
+
+static void nitro_heartbeat_class_init(ObjectClass *oc, const void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = nitro_heartbeat_realize;
+}
+
+static const TypeInfo nitro_heartbeat_info = {
+    .name = TYPE_NITRO_HEARTBEAT,
+    .parent = TYPE_NITRO_VSOCK_DEVICE,
+    .instance_size = sizeof(NitroHeartbeatState),
+    .class_init = nitro_heartbeat_class_init,
+};
+
+static void nitro_heartbeat_register(void)
+{
+    type_register_static(&nitro_heartbeat_info);
+}
+
+type_init(nitro_heartbeat_register);
diff --git a/hw/nitro/Kconfig b/hw/nitro/Kconfig
index ce24c09c218..d3fbc7b683c 100644
--- a/hw/nitro/Kconfig
+++ b/hw/nitro/Kconfig
@@ -4,3 +4,7 @@ config NITRO_VSOCK_BUS
 config NITRO_SERIAL_VSOCK
     bool
     depends on NITRO_VSOCK_BUS
+
+config NITRO_HEARTBEAT
+    bool
+    depends on NITRO_VSOCK_BUS
diff --git a/hw/nitro/meson.build b/hw/nitro/meson.build
index 76399d4265d..381c1ee6c15 100644
--- a/hw/nitro/meson.build
+++ b/hw/nitro/meson.build
@@ -1,2 +1,3 @@
 system_ss.add(when: 'CONFIG_NITRO_VSOCK_BUS', if_true: files('nitro-vsock-bus.c'))
 system_ss.add(when: 'CONFIG_NITRO_SERIAL_VSOCK', if_true: files('serial-vsock.c'))
+system_ss.add(when: 'CONFIG_NITRO_HEARTBEAT', if_true: files('heartbeat.c'))
diff --git a/hw/nitro/trace-events b/hw/nitro/trace-events
index 20617a024a9..311ab78e699 100644
--- a/hw/nitro/trace-events
+++ b/hw/nitro/trace-events
@@ -2,3 +2,7 @@
 
 # serial-vsock.c
 nitro_serial_vsock_event(int event) "event %d"
+
+# heartbeat.c
+nitro_heartbeat_event(int event) "event %d"
+nitro_heartbeat_done(void) "enclave heartbeat received"
-- 
2.53.0


