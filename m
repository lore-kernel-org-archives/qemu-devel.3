Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84FC1C25B76
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 10:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGyez-0006TJ-Mv; Tue, 11 Jun 2024 06:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyey-0006Sj-51
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:24 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGyew-0000Yw-5y
 for qemu-devel@nongnu.org; Tue, 11 Jun 2024 06:23:23 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-35f1bc2ab37so2167752f8f.1
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2024 03:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718101400; x=1718706200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D5kxM32IuNmuEBUfifZgDrwNVCiJKoR9GZCW1cb30w8=;
 b=HSzYvDD1CZItkK+k6C6NOM6SkI2S62X34nFkv6+KfbW+OXxbYea+MRLR8d85LkrVbP
 60RZWTbqdO4Ykqml/2vv50tywv56JCIoDE9lHpAvP3nIsY8W5w0if5VUogZDIGZZtBz/
 S4bsRA2ViPggTsRxojoMsKbd78P83EcJfl9VvupEORi+ZxamWLg7t6fL68mgt19PhV+q
 HgRE05/2k1NDNnErxLPqhNDbsfIFiRDHxB8US5AlKvBheqIaCh5V604BYsWgo6JQPkbm
 FgNifivEb+AyjhxLtTy71Ozs/OzxGgpCzc9J+BEC5exf0WhP4kRvWa828Xpct/wNRC7c
 OlBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718101400; x=1718706200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D5kxM32IuNmuEBUfifZgDrwNVCiJKoR9GZCW1cb30w8=;
 b=CRFMoBvRgLc9q72DFv91+SO/B4bweLO6yglujKM3MrGpyWdzpU94TeOVvrCuhmb0qD
 oQfloW/QyCKaSw3m99ZRFNouW1ZL0NXSMq9b4D1MUpD5ZVXk7tRey3SELHqeGDrb0CZg
 FAUwB5BUKJeFvdneGutIqJDnLKesBtv25FXyoh8liQB1SOAZEJdjqZzgOGqFPy5lUgCC
 JWyOxOY4uHTWaNoliTJ26jaYRdNsSIjvFxcQxrLQ4GJ2rEAuz75tVvivONuIckOe2oTk
 Pr3nGpKvIgycUN5eAPcyy0F633JBAgkufgiUqUammEd89c/H/H/LK5i84FdjUUcWYyfo
 Ej6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWX7FlV6z9vR1ji3liHWAO6LEi0xr1+rGuUYKxY5rUwGTD/EAr82bsoC7fj8/vAXK5C24q9Gk8xetpzF6FJaH3kSXpPEbI=
X-Gm-Message-State: AOJu0Yw9QnAmbRyOWfgH/K40ECISzNbXP71Nj8DAGclo/MsuXXt3NG0L
 s9ubkZgEtpkpJNbQuoQDFdWCspJSnhFkBFCx1GA9fwh3b9ZUXSnJetQ4PI0sDko=
X-Google-Smtp-Source: AGHT+IHa2AqmF/k3/t0zkFSupVbR5B8Yj5Z1o/Z4zBjj8b2ly6GB6OoCw+B5TS7y0gOA28qd3RuDfA==
X-Received: by 2002:a05:6000:a84:b0:35f:1f3c:b62a with SMTP id
 ffacd0b85a97d-35f1f3cb667mr4366867f8f.58.1718101400331; 
 Tue, 11 Jun 2024 03:23:20 -0700 (PDT)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-6.dsl.sta.abo.bbox.fr.
 [176.184.32.6]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f27600519sm3907640f8f.32.2024.06.11.03.23.18
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 11 Jun 2024 03:23:19 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] hw/usb: Introduce x-query-usbhost QMP command
Date: Tue, 11 Jun 2024 12:23:04 +0200
Message-ID: <20240611102305.60735-3-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240611102305.60735-1-philmd@linaro.org>
References: <20240611102305.60735-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

This is a counterpart to the HMP "info usbhost" command. It is being
added with an "x-" prefix because this QMP command is intended as an
adhoc debugging tool and will thus not be modelled in QAPI as fully
structured data, nor will it have long term guaranteed stability.
The existing HMP command is rewritten to call the QMP command.

Since host-libusb.c can be built as part of the 'hw-usb' module,
we introduce the libusb_register_hmp_info_hrt() helper to allow late
registration when the module is loaded.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json           | 18 ++++++++++++++++
 hw/usb/host-libusb.h        | 16 ++++++++++++++
 include/hw/usb.h            |  3 ---
 hw/usb/bus-stub.c           |  7 +++++-
 hw/usb/host-libusb-common.c | 31 ++++++++++++++++++++++++++
 hw/usb/host-libusb.c        | 43 +++++++++++++++++++++++++------------
 tests/qtest/qmp-cmd-test.c  |  3 +++
 hmp-commands-info.hx        |  2 ++
 hw/usb/meson.build          |  1 +
 9 files changed, 106 insertions(+), 18 deletions(-)
 create mode 100644 hw/usb/host-libusb.h
 create mode 100644 hw/usb/host-libusb-common.c

diff --git a/qapi/machine.json b/qapi/machine.json
index 1283d14493..1b428f29d4 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1813,6 +1813,24 @@
   'returns': 'HumanReadableText',
   'features': [ 'unstable' ] }
 
+##
+# @x-query-usbhost:
+#
+# Query information on host USB devices
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: Host USB device information
+#
+# Since: 9.1
+##
+{ 'command': 'x-query-usbhost',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ],
+  'if': 'CONFIG_USB_LIBUSB' }
+
 ##
 # @SmbiosEntryPointType:
 #
diff --git a/hw/usb/host-libusb.h b/hw/usb/host-libusb.h
new file mode 100644
index 0000000000..eaada081a5
--- /dev/null
+++ b/hw/usb/host-libusb.h
@@ -0,0 +1,16 @@
+/*
+ * QEMU USB host redirector
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#ifndef HW_USB_HOST_LIBUSB_H
+#define HW_USB_HOST_LIBUSB_H
+
+#include "qapi/qapi-types-common.h"
+
+void libusb_register_hmp_info_hrt(HumanReadableText *(*handler)(Error **errp));
+
+#endif
diff --git a/include/hw/usb.h b/include/hw/usb.h
index d46d96779a..c0b34af518 100644
--- a/include/hw/usb.h
+++ b/include/hw/usb.h
@@ -465,9 +465,6 @@ void usb_device_reset(USBDevice *dev);
 void usb_wakeup(USBEndpoint *ep, unsigned int stream);
 void usb_generic_async_ctrl_complete(USBDevice *s, USBPacket *p);
 
-/* usb-linux.c */
-void hmp_info_usbhost(Monitor *mon, const QDict *qdict);
-
 /* usb ports of the VM */
 
 #define VM_USB_HUB_SIZE 8
diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
index fcabe8429e..948429bb33 100644
--- a/hw/usb/bus-stub.c
+++ b/hw/usb/bus-stub.c
@@ -11,7 +11,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-machine.h"
 #include "sysemu/sysemu.h"
-#include "monitor/monitor.h"
 #include "hw/usb.h"
 
 USBDevice *usbdevice_create(const char *driver)
@@ -26,3 +25,9 @@ HumanReadableText *qmp_x_query_usb(Error **errp)
     error_setg(errp, "Support for USB devices not built-in");
     return NULL;
 }
+
+HumanReadableText *qmp_x_query_usbhost(Error **errp)
+{
+    error_setg(errp, "Support for USB devices not built-in");
+    return NULL;
+}
diff --git a/hw/usb/host-libusb-common.c b/hw/usb/host-libusb-common.c
new file mode 100644
index 0000000000..406a2b25be
--- /dev/null
+++ b/hw/usb/host-libusb-common.c
@@ -0,0 +1,31 @@
+/*
+ * QEMU USB host redirector helpers
+ *
+ * SPDX-FileContributor: Philippe Mathieu-Daudé <philmd@linaro.org>
+ * SPDX-FileCopyrightText: 2024 Linaro Ltd.
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/module.h"
+#include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+#include "monitor/monitor.h"
+#include "host-libusb.h"
+
+static HumanReadableText *(*qmp_x_query_usbhost_handler)(Error **errp);
+
+void libusb_register_hmp_info_hrt(HumanReadableText *(*handler)(Error **errp))
+{
+    qmp_x_query_usbhost_handler = handler;
+    monitor_register_hmp_info_hrt("usbhost", handler);
+}
+
+HumanReadableText *qmp_x_query_usbhost(Error **errp)
+{
+    if (module_load("hw-usb-", "host", errp) <= 0) {
+        return NULL;
+    }
+    assert(qmp_x_query_usbhost_handler);
+    return qmp_x_query_usbhost_handler(errp);
+}
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 80122b4125..b3e1443794 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -1,5 +1,5 @@
 /*
- * Linux host USB redirector
+ * QEMU USB host redirector
  *
  * Copyright (c) 2005 Fabrice Bellard
  *
@@ -46,6 +46,8 @@
 #endif
 
 #include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/type-helpers.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
@@ -57,6 +59,7 @@
 
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
+#include "host-libusb.h"
 
 /* ------------------------------------------------------------------------ */
 
@@ -1813,10 +1816,12 @@ static const TypeInfo usb_host_dev_info = {
 module_obj(TYPE_USB_HOST_DEVICE);
 module_kconfig(USB);
 
+static HumanReadableText *qmp_mod_query_usbhost(Error **errp);
+
 static void usb_host_register_types(void)
 {
     type_register_static(&usb_host_dev_info);
-    monitor_register_hmp("usbhost", true, hmp_info_usbhost);
+    libusb_register_hmp_info_hrt(qmp_mod_query_usbhost);
 }
 
 type_init(usb_host_register_types)
@@ -1921,18 +1926,25 @@ static void usb_host_auto_check(void *unused)
     timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
 }
 
-void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
+static HumanReadableText *qmp_mod_query_usbhost(Error **errp)
 {
+    g_autoptr(GString) buf = g_string_new("");
     libusb_device **devs = NULL;
     struct libusb_device_descriptor ddesc;
     char port[16];
     int i, n;
 
     if (usb_host_init() != 0) {
-        return;
+        error_setg(errp, "Failed to init libusb");
+        return NULL;
     }
 
     n = libusb_get_device_list(ctx, &devs);
+    if (!n) {
+        error_setg(errp, "No host USB device");
+        return NULL;
+    }
+
     for (i = 0; i < n; i++) {
         if (libusb_get_device_descriptor(devs[i], &ddesc) != 0) {
             continue;
@@ -1941,14 +1953,15 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
             continue;
         }
         usb_host_get_port(devs[i], port, sizeof(port));
-        monitor_printf(mon, "  Bus %d, Addr %d, Port %s, Speed %s Mb/s\n",
-                       libusb_get_bus_number(devs[i]),
-                       libusb_get_device_address(devs[i]),
-                       port,
-                       speed_name[libusb_get_device_speed(devs[i])]);
-        monitor_printf(mon, "    Class %02x:", ddesc.bDeviceClass);
-        monitor_printf(mon, " USB device %04x:%04x",
-                       ddesc.idVendor, ddesc.idProduct);
+        g_string_append_printf(buf,
+                               "  Bus %d, Addr %d, Port %s, Speed %s Mb/s\n",
+                               libusb_get_bus_number(devs[i]),
+                               libusb_get_device_address(devs[i]),
+                               port,
+                               speed_name[libusb_get_device_speed(devs[i])]);
+        g_string_append_printf(buf, "    Class %02x:", ddesc.bDeviceClass);
+        g_string_append_printf(buf, " USB device %04x:%04x",
+                               ddesc.idVendor, ddesc.idProduct);
         if (ddesc.iProduct) {
             libusb_device_handle *handle;
             if (libusb_open(devs[i], &handle) == 0) {
@@ -1957,10 +1970,12 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
                                                    ddesc.iProduct,
                                                    name, sizeof(name));
                 libusb_close(handle);
-                monitor_printf(mon, ", %s", name);
+                g_string_append_printf(buf, ", %s", name);
             }
         }
-        monitor_printf(mon, "\n");
+        g_string_append_c(buf, '\n');
     }
     libusb_free_device_list(devs, 1);
+
+    return human_readable_text_from_str(buf);
 }
diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index 2c15f60958..731d3c6c59 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -49,6 +49,9 @@ static int query_error_class(const char *cmd)
         { "query-vm-generation-id", ERROR_CLASS_GENERIC_ERROR },
         /* Only valid with a USB bus added */
         { "x-query-usb", ERROR_CLASS_GENERIC_ERROR },
+#ifdef CONFIG_USB_LIBUSB
+        { "x-query-usbhost", ERROR_CLASS_GENERIC_ERROR },
+#endif
         /* Only valid with accel=tcg */
         { "x-query-jit", ERROR_CLASS_GENERIC_ERROR },
         { "x-query-opcount", ERROR_CLASS_GENERIC_ERROR },
diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index cfd4ad5651..134f970584 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -335,12 +335,14 @@ SRST
     Show guest USB devices.
 ERST
 
+#ifdef CONFIG_USB_LIBUSB
     {
         .name       = "usbhost",
         .args_type  = "",
         .params     = "",
         .help       = "show host USB devices",
     },
+#endif
 
 SRST
   ``info usbhost``
diff --git a/hw/usb/meson.build b/hw/usb/meson.build
index d7de1003e3..af92b504fd 100644
--- a/hw/usb/meson.build
+++ b/hw/usb/meson.build
@@ -7,6 +7,7 @@ system_ss.add(when: 'CONFIG_USB', if_true: files(
   'core.c',
   'desc.c',
   'desc-msos.c',
+  'host-libusb-common.c',
   'libhw.c',
   'pcap.c',
 ), if_false: files('bus-stub.c'))
-- 
2.41.0


