Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D7D4C27C5E
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2024 06:39:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGYgB-0000as-Kr; Mon, 10 Jun 2024 02:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYgA-0000ab-Pd
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:38:54 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sGYg8-00080U-VQ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2024 02:38:54 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-35f23f3da44so566855f8f.0
 for <qemu-devel@nongnu.org>; Sun, 09 Jun 2024 23:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718001531; x=1718606331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9iNPEtf11j5JqAAG55iCQcbXFCFEpywuWfVwzaU/JPk=;
 b=QU5Ut5dmWNFN/U7GL2B1KJuvt5G1GXB6gDs7KdQ9HN003/Ntuf2kmAw+f0JgxNzRp9
 FjE0Mcipy7HIw/gZdbJqZaNheFU1Q22iotqY/NuxjFmIMHmjCIUnf8UTJdKeXSdrXHB8
 vnRRllR+UvFz86IF4IucgDalJ+lPRjUhu07RDAaVGNxxaT30LuV10rW3ehWSUDtp/C/m
 vDO6g3PCfG3d35iHBD2MG+x6GAsqm5rcnzKFwiX3w+dV8pzpv2U/7oSqp3XX27VUBJvw
 xAn8r+P9HV2a8VbhCBTi0PQKqra15wsfBSHzujPGi0dXjpNkzeS94/u/EXPKaNsDFQmV
 P/Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718001531; x=1718606331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9iNPEtf11j5JqAAG55iCQcbXFCFEpywuWfVwzaU/JPk=;
 b=jozgPIatvqSKz9SyJs4/3U5TI7FGRqNP4w5Fc5u7XxAWB1resBNegSrKlXZSkwvA+p
 6uVD9Z+YUBzbZdBm6Mkxo2vRBt1dfv1EV9FWN4gBc6Hh4feJMRfFSFza26ffQoI762Xo
 /exJKohAVoYkn84lEM4g1r9vnCubxjPomefawqpD+cNWl/h01NUvbVwSmlSX+9jLlrID
 k5ktWVF2zi0YsFpsXbSkW959wP2p5S93UDqxfpHuFH7q79u5KUkxdkr/yU7Wsg5gnEQS
 cq9llxDgOvwVmBNd9dozOMfHeYD7qAsgEedbv17ymzmVyBOhfh+h+e3JZ3VJYYF4ZDfS
 oIeA==
X-Gm-Message-State: AOJu0YzlZrD/cKK/19VzvlPRselLnwGnzZ2Yq1HvtRW9NUliG75LdLAz
 C1Kp37OK4bQQw1Vnlntbse49oyXiJYdTlmCnB18pSPXhjKZC9ys+X302m2GkHdBfSAkGKukdhAI
 r
X-Google-Smtp-Source: AGHT+IHfapzTBwQ30XgJrnJ3V21uUihjYK34fzM2cAQgwc3ssdr520I8ql1JltDGf6j37clepOhqQw==
X-Received: by 2002:a5d:44ca:0:b0:354:eb62:365c with SMTP id
 ffacd0b85a97d-35efed3f402mr6455252f8f.15.1718001530910; 
 Sun, 09 Jun 2024 23:38:50 -0700 (PDT)
Received: from m1x-phil.lan ([176.176.129.242])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f24fb3fa4sm1578468f8f.102.2024.06.09.23.38.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 09 Jun 2024 23:38:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Don Porter <porter@cs.unc.edu>, Eric Blake <eblake@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH] hw/usb: Introduce x-query-usbhost QMP command
Date: Mon, 10 Jun 2024 08:38:47 +0200
Message-ID: <20240610063848.51027-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 qapi/machine.json          | 18 ++++++++++++++++++
 include/hw/usb.h           |  3 ---
 hw/usb/bus-stub.c          |  7 ++++++-
 hw/usb/host-libusb.c       | 38 +++++++++++++++++++++++++-------------
 tests/qtest/qmp-cmd-test.c |  3 +++
 5 files changed, 52 insertions(+), 17 deletions(-)

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
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index 80122b4125..5781d7fa7c 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -46,6 +46,8 @@
 #endif
 
 #include "qapi/error.h"
+#include "qapi/qapi-commands-machine.h"
+#include "qapi/type-helpers.h"
 #include "migration/vmstate.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
@@ -1816,7 +1818,7 @@ module_kconfig(USB);
 static void usb_host_register_types(void)
 {
     type_register_static(&usb_host_dev_info);
-    monitor_register_hmp("usbhost", true, hmp_info_usbhost);
+    monitor_register_hmp_info_hrt("usbhost", qmp_x_query_usbhost);
 }
 
 type_init(usb_host_register_types)
@@ -1921,18 +1923,25 @@ static void usb_host_auto_check(void *unused)
     timer_mod(usb_auto_timer, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + 2000);
 }
 
-void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
+HumanReadableText *qmp_x_query_usbhost(Error **errp)
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
@@ -1941,14 +1950,15 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
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
@@ -1957,10 +1967,12 @@ void hmp_info_usbhost(Monitor *mon, const QDict *qdict)
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
-- 
2.41.0


