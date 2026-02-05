Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D7A1ECD99E
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vp-0007E3-Md; Thu, 05 Feb 2026 14:59:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vi-000722-CA
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:30 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vg-0003D0-9m
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:29 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4806f80cac9so9433495e9.1
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321566; x=1770926366; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EYgtnXWNUJT6Dac5zqSSe5+G0V1Qkagn78Y+hx3iUhk=;
 b=nTCDWJlVMWpterN9WMR7KcWlh1EqNO+cb0HedIymucwJy1AQ39CdYB21JV3Boc5KP+
 oZa2eNuRJkeUeatfI43dfhwaukriITa58vYLmwu2ISg0SUY06bQs8Lb3Pc2xlhIQ/Sah
 RaP25peff9s7HjqrfuOkPEMMWWVhWTWcrKRAUepGtmBFDwfQann5xNDwDQFG7HARMYwc
 m0FLjqWvkbXcL4wi6Di9TN0vNo33MUhoBhFn6rdsU9uSAUIL3VUib/GiUQsPEyb+GFHB
 2Ul8DIUIJCVAeQWpdnFWYbApTgk6zGmNUznv2M8psnBJotWJWM/kAm6kUzGUoWYMJ13F
 v7pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321566; x=1770926366;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EYgtnXWNUJT6Dac5zqSSe5+G0V1Qkagn78Y+hx3iUhk=;
 b=NdmLL0CFCMD3mVUwsEFnVyMeu3+z1OLVNi3lKChYxSaIfRbV6WogCDffgp029rIbrq
 sbBdcdfdT0qlJgU1BeJRYRcGT9dbWN/Kvifd/HgxRLOzfT03UUsKCuJZSewrT2hbixCa
 4/X1nKrSYm4FAOS4kIE/EXD/YTOLYryWan3ICmD4KlKjwYObClwuRSPkhpctaZaMVvpb
 +RteWqdSy9Nd3FD2Jh509eiDFnJ1L+GbItlOWE9p8a9ZEzzy2nAPMu8FwadVc9CuVTZv
 K2V6jcx4GCkw2zcZ0k7T6VlmNCiS+j6rCoNd3fLpLAjhbobwZ0LqiW+ingogZztpOzPo
 jeWw==
X-Gm-Message-State: AOJu0YzlwVH8lLytbVKExENp4eo5n6pgmEVli5xJSY9924f7s8PNNWcd
 1+sjnspxkDawT0fAnbJwPIYSRXEu6bWCl0r+upRD44yYlkaCw7ZYrHlmrEWlkn/u0Uw=
X-Gm-Gg: AZuq6aKGS/E9XH0ZqZdWpu84l71e52nYxvgumdyoek383LJ0vlqq5LaucZHEX0YCiNe
 T1/W4tJKuaNFVZqJ7SMqXHryXTL0h9tAsV4U5DvElBzYrK0nfyZleBCfYvSRbkfoSN8CYWKnIPF
 VqM9zJi5vF9zWnLFPoQkmnuDDoQ5UJ68ahW/CjahyZOQb9uyoV65xmJNLH42KZosX/yfrEgCx5H
 B9W5pMWSnEjGG1f8RobnZUq5fDTTV7sBB/0HIY1T8I54kG9TOtqeexgyuoKXcMV/0XE/9lFDEfh
 eKUAfeq2gixEwb4ZmWosCHHylPvKhBr7z0z5EwbgbRPlFn9xtBwHmiffW3DEwBH6R6bEUKiEOoe
 UTB5JMSsM3SWPNmae/XKt2qN2fPfmNRoNGGluxqYHrCdJbNUDWqDgnrh33HkFHbn7LkDTsH62x6
 E5zXrwAN6W8OwyUCtesWI=
X-Received: by 2002:a05:6000:2681:b0:42f:8816:a509 with SMTP id
 ffacd0b85a97d-4362938f3f4mr725064f8f.62.1770321566414; 
 Thu, 05 Feb 2026 11:59:26 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:25 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 28/29] hw/core: Add Remote Port attachment helpers
Date: Thu,  5 Feb 2026 20:58:23 +0100
Message-ID: <20260205195824.2610192-29-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>

Introduce helper functions to dynamically attach and detach Remote Port
devices to an adaptor.

This patch adds the logic to:
- Connect devices to an adaptor via QOM links ('rp_device_attach').
- Parse command-line options ('rp_device_add') to automatically wire up
  devices using 'rp-adaptor' and 'rp-chan' properties.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Mirsad Ostrakovic <mirsad_ostrakovic@epam.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/meson.build           |   1 +
 hw/core/remote-port-qdev.c    | 181 ++++++++++++++++++++++++++++++++++
 include/hw/core/remote-port.h |  27 +++++
 3 files changed, 209 insertions(+)
 create mode 100644 hw/core/remote-port-qdev.c

diff --git a/hw/core/meson.build b/hw/core/meson.build
index 7013638fcf..4638106e92 100644
--- a/hw/core/meson.build
+++ b/hw/core/meson.build
@@ -35,6 +35,7 @@ system_ss.add(when: 'CONFIG_REMOTE_PORT', if_true: files(
   'remote-port-gpio.c',
   'remote-port-stream.c',
   'remote-port-ats.c',
+  'remote-port-qdev.c'
 ))
 
 system_ss.add(files(
diff --git a/hw/core/remote-port-qdev.c b/hw/core/remote-port-qdev.c
new file mode 100644
index 0000000000..35c9a6790d
--- /dev/null
+++ b/hw/core/remote-port-qdev.c
@@ -0,0 +1,181 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * QEMU remote attach
+ *
+ * Copyright (c) 2013 Xilinx Inc
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
+ *
+ * This code is licensed under the GNU GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/core/sysbus.h"
+#include "monitor/monitor.h"
+#include "monitor/qdev.h"
+#include "system/arch_init.h"
+#include "qapi/error.h"
+#include "qemu/config-file.h"
+#include "qemu/error-report.h"
+#include "qemu/help_option.h"
+#include "qemu/cutils.h"
+#include "qemu/option.h"
+
+#include "hw/core/remote-port.h"
+
+/* RP helper function to attach a device to an adaptor.  */
+void rp_device_attach(Object *adaptor, Object *dev,
+                      int rp_nr, int dev_nr,
+                      Error **errp)
+{
+    Error *err = NULL;
+    uint32_t nr_devs;
+    char *name;
+    int i;
+
+    assert(adaptor);
+    assert(dev);
+
+    /* Verify that the adaptor is of Remote Port type.  */
+    if (!object_dynamic_cast(adaptor, TYPE_REMOTE_PORT)) {
+        error_setg(errp, "%s is not a Remote-Port adaptor!",
+                   object_get_canonical_path(adaptor));
+        return;
+    }
+
+    name = g_strdup_printf("rp-adaptor%d", rp_nr);
+    object_property_set_link(dev, name, adaptor, &err);
+    g_free(name);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    name = g_strdup_printf("rp-chan%d", rp_nr);
+    object_property_set_int(dev, name, dev_nr, &err);
+    g_free(name);
+    if (err != NULL
+        && !object_dynamic_cast(dev, TYPE_REMOTE_PORT_DEVICE)) {
+        /*
+         * RP devices that only receive requests may not need to
+         * know their channel/dev number. If not, treat this as
+         * an error.
+         */
+        error_propagate(errp, err);
+        return;
+    }
+    err = NULL;
+
+    nr_devs = object_property_get_int(dev, "nr-devs", &err);
+    if (err) {
+        nr_devs = 1;
+        err = NULL;
+    }
+
+    /* Multi-channel devs use consecutive numbering.  */
+    for (i = 0; i < nr_devs; i++) {
+        name = g_strdup_printf("remote-port-dev%d", dev_nr + i);
+        object_property_set_link(adaptor, name, dev, &err);
+        g_free(name);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+}
+
+/* RP helper function to detach a device to an adaptor.  */
+void rp_device_detach(Object *adaptor, Object *dev,
+                      int rp_nr, int dev_nr,
+                      Error **errp)
+{
+    Error *err = NULL;
+    uint32_t nr_devs;
+    char *name;
+    int i;
+
+    assert(adaptor);
+    assert(dev);
+
+    name = g_strdup_printf("rp-adaptor%d", rp_nr);
+    object_property_set_link(dev, name, NULL, NULL);
+    g_free(name);
+
+    nr_devs = object_property_get_int(dev, "nr-devs", &err);
+    if (err) {
+        nr_devs = 1;
+        err = NULL;
+    }
+
+    for (i = 0; i < nr_devs; i++) {
+        name = g_strdup_printf("remote-port-dev%d", dev_nr + i);
+        object_property_set_link(adaptor, name, NULL, &err);
+        g_free(name);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return;
+        }
+    }
+}
+
+/* Scan for remote-port links to be setup.  */
+bool rp_device_add(const QDict *opts, DeviceState *dev, Error **errp)
+{
+    Error *err = NULL;
+    Object *adaptor;
+    bool ambiguous;
+    const char *path;
+    char *name;
+    int i;
+
+    /*
+     * Find the adaptor this remote-port device is connected to.
+     * At the moment, we only support one adaptor per device.
+     */
+    name = g_strdup_printf("rp-adaptor%d", 0);
+    path = qdict_get_try_str(opts, name);
+    g_free(name);
+    if (!path) {
+        /* This is not a remote-port device. Treat as success.  */
+        return true;
+    }
+    adaptor = object_resolve_path(path, &ambiguous);
+    if (!adaptor) {
+        error_setg(errp, "Did not find rp adaptor %s!", path);
+        return false;
+    }
+
+    /*
+     * Loop through the channels this device provides and attach
+     * them to the adaptor.
+     */
+    for (i = 0; i < INT_MAX; i++) {
+        unsigned long dev_nr;
+        const char *dev_nr_str;
+
+        name = g_strdup_printf("rp-chan%d", i);
+        dev_nr_str = qdict_get_try_str(opts, name);
+        g_free(name);
+
+        if (!dev_nr_str) {
+            if (i == 0) {
+                /* At least one channel must be provided.  */
+                error_setg(errp, "Did not find rp-chan%d!", i);
+                return false;
+            }
+            return true;
+        }
+
+        if (qemu_strtoul(dev_nr_str, NULL, 0, &dev_nr)) {
+            error_setg(errp, "Invalid rp-chan%d!", i);
+            return false;
+        }
+
+        /* Now, attach the device to the adaptor.  */
+        rp_device_attach(adaptor, OBJECT(dev), 0, dev_nr, &err);
+        if (err != NULL) {
+            error_propagate(errp, err);
+            return false;
+        }
+    }
+    return true;
+}
diff --git a/include/hw/core/remote-port.h b/include/hw/core/remote-port.h
index 172c4b6204..252230961b 100644
--- a/include/hw/core/remote-port.h
+++ b/include/hw/core/remote-port.h
@@ -134,6 +134,33 @@ struct RemotePort {
     RemotePortDevice *devs[REMOTE_PORT_MAX_DEVS];
 };
 
+/**
+ * rp_device_attach:
+ * @adaptor: The adaptor onto which to attach the device
+ * @dev: The device to be attached to the adaptor
+ * @rp_nr: The remote-port adaptor nr. A device may attach to multiple
+ *         adaptors.
+ * @dev_nr: The device/channel number to bind the device to.
+ * @errp: returns an error if this function fails
+ *
+ * Attaches a device onto an adaptor and binds it to a device number.
+ */
+void rp_device_attach(Object *adaptor, Object *dev,
+                      int rp_nr, int dev_nr,
+                      Error **errp);
+void rp_device_detach(Object *adaptor, Object *dev,
+                      int rp_nr, int dev_nr,
+                      Error **errp);
+/**
+ * rp_device_add
+ * @opts:  qdev opts created by the qdev subsystem
+ * @dev: The device to be connected
+ * @errp: Returns an error if the function fails
+ *
+ * Function used in qdev-monitor.c to connect remote port devices.
+ * Returns teue on success and false on failure.
+ */
+bool rp_device_add(const QDict *opts, DeviceState *dev, Error **errp);
 
 void rp_rsp_mutex_lock(RemotePort *s);
 void rp_rsp_mutex_unlock(RemotePort *s);
-- 
2.43.0


