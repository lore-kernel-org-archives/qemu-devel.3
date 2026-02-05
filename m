Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DFD2ECD999
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 20:00:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo5Vo-0007AB-DJ; Thu, 05 Feb 2026 14:59:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vf-0006zQ-5y
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:28 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ruslichenko.r@gmail.com>)
 id 1vo5Vc-0003Bj-Pq
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 14:59:26 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-47ee3a63300so14504485e9.2
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 11:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770321563; x=1770926363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ODPdQ6CGlB8sV1EdByujVoiH2o+cygpKFap6nFlHY6I=;
 b=Q1OK6GAWjgpO4TFab8dGa1a5elPXISG4JgM2QQF1tK5lZBhbsnpzoeRwDr8HeTdNYG
 Fv7mG3uf5vYbDr84sW1lU8PldU2MExNqbgD4w1q4I+e2Kkc1wTaDfVblF5dUX5MRb+YK
 c8pzUOkP5Pq+RuEq/weMZeWwgv/0tygfQjnClwhcNxsvSx6zZSpnonZ9Gw7heKgkexEM
 uSAsfUkq4mpHAdhZmafAsG+wc3yBRtL5T8P5Rqn1fUEZNTaZfSh4bwQgddBsHB9vdpLa
 l40MVLpBrnUUYs15h+UPz0vQvoPNGg/ltKgzziyi9EGS9JBOb+vEJc0b+THu3ed/amE0
 v9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770321563; x=1770926363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ODPdQ6CGlB8sV1EdByujVoiH2o+cygpKFap6nFlHY6I=;
 b=Ew1rEIocCewXukShVVeo7s6jrE4mw8Wl2xs9oV+W0xqjkb9QZgaxRARxmOWN8M+mjO
 mAIbzAiNvewvwm9baeW/ZjflGgP6OY2k7SMpj4mpkXcDdulVODstI23248lYVN5q0+58
 sJLqSYs8B8k+qR2B8CEkVwsYWF0jXamCg15dFH9i/V+F1JTa+ARN+MUYSBA267fSTGS7
 Ru0IDkjVX/S6vv9Lt8UHlO8uffHxRlxBbXlLn6f6fUq2nDkZO3jUS0xAtAOYab5vwvua
 Q4PqJNywYwch38abdAekY2LFxKgfP9r6LkFxyKR+qStpaJIOqZLIpwELU2LBoEiZTzLl
 b2FQ==
X-Gm-Message-State: AOJu0Ywre7dS7Wj77Ya5wuMEQnytpTNbmFIo+08/hlRdBJrytNu9nWnF
 YNbmaeTI+6oFrzCZW+vGAmTKM7g6Xfb+FUyzezUetMlhiU6KBx0fPtyUHHwadhbknv0=
X-Gm-Gg: AZuq6aKDVFwx+LEpI5rFo2C6inzatFCZ2lri8I3Vbdz4MLPO6jqVfQ8yY4fm0KMKJYh
 gpyXZLw+MyI4jxbC6+SegKgyJakYt8BBovCVUEjH0XT6bj+9c3qi+kBzfmRyfF38dmRF24bH1mN
 78tWm+m6O7flf2v44/u/g/qKsjJheOAVoZAyj5348c3BIcVu0JjHp7BEhBSTFzzy/R7mL3EneZT
 30j/oqCfFgRD2CrE8FeERO/OZIuv1p0sV6I+M50D+HuFMz+1ZM3tsdEWlDE2QBu5uop+6m/mFK4
 4Y1MFqBBT5VaT2ULJGjQbtrtflesCbOhaoC4hTjlKvLv96iSwVdigDbu/MVM8AYlyvu9eUug9tw
 dec0P18EIcEWw5Jo4LKdUdaVAi8P48lsrrWP2VktRShWsDz9G1b5lPYxUKLclnfaPxYQ9wuZwqo
 GHpgqvmJXHvqG32Ak3/Qo=
X-Received: by 2002:a05:6000:1844:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-4362938023amr621859f8f.60.1770321562947; 
 Thu, 05 Feb 2026 11:59:22 -0800 (PST)
Received: from thinkpad-t470s.. ([93.140.16.93])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-436297450b4sm514079f8f.34.2026.02.05.11.59.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 11:59:22 -0800 (PST)
From: Ruslan Ruslichenko <ruslichenko.r@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, artem_mygaiev@epam.com,
 volodymyr_babchuk@epam.com, takahiro.nakata.wr@renesas.com,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 francisco.iglesias@amd.com, Ruslan_Ruslichenko@epam.com,
 "Edgar E . Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH 26/29] hw/core: Add Remote Port connection support to
 fdt-generic
Date: Thu,  5 Feb 2026 20:58:21 +0100
Message-ID: <20260205195824.2610192-27-ruslichenko.r@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
References: <20260205195824.2610192-1-ruslichenko.r@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=ruslichenko.r@gmail.com; helo=mail-wm1-x32d.google.com
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

From: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>

Extend the fdt-generic utility to automatically configure Remote Port
devices defined in the Device Tree.

This patch enables the system to:
- Identify Remote Port devices and their configuration parameters directly
  from the Device Tree description.
- Automatically establish connections between these devices and the
  central Remote Port adaptor.
- Register legacy reset handlers for devices instantiated via FDT,
  as required by specific Remote Port devices to ensure they reset
  properly.

This allows users to define complex co-simulation environments purely
through Device Tree data, removing the need for hardcoded initialization.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Signed-off-by: Takahiro Nakata <takahiro.nakata.wr@renesas.com>
Signed-off-by: Ruslan Ruslichenko <Ruslan_Ruslichenko@epam.com>
---
 hw/core/fdt_generic_util.c | 120 +++++++++++++++++++++++++++++++++----
 1 file changed, 107 insertions(+), 13 deletions(-)

diff --git a/hw/core/fdt_generic_util.c b/hw/core/fdt_generic_util.c
index d183a44433..180038baf6 100644
--- a/hw/core/fdt_generic_util.c
+++ b/hw/core/fdt_generic_util.c
@@ -61,6 +61,9 @@
     } \
 } while (0)
 
+#include "hw/core/remote-port-memory-slave.h"
+#include "hw/core/remote-port.h"
+
 #define PROP_ARRAY_LEN_PREFIX "len-"
 
 /* FIXME: wrap direct calls into libfdt */
@@ -1097,6 +1100,20 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
     }
     fdt_init_set_opaque(fdti, node_path, dev);
 
+    /*
+     * Set the default sync-quantum based on the global one. Node properties
+     * in the dtb can later override this value.
+     */
+    if (global_sync_quantum) {
+        ObjectProperty *p;
+
+        p = object_property_find(OBJECT(dev), "sync-quantum");
+        if (p) {
+            object_property_set_int(OBJECT(dev), "sync-quantum",
+                                    global_sync_quantum, &errp);
+        }
+    }
+
     props = qemu_devtree_get_props(fdti->fdt, node_path);
     for (prop = props; prop->name; prop++) {
         const char *propname = trim_vendor(prop->name);
@@ -1142,25 +1159,99 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
         fdt_init_qdev_scalar_prop(OBJECT(dev), p, fdti, node_path, prop);
     }
 
+    if (object_dynamic_cast(dev, TYPE_REMOTE_PORT_DEVICE)) {
+        for (i = 0; ; ++i) {
+            char adaptor_node_path[DT_PATH_LENGTH];
+            uint32_t adaptor_phandle, chan;
+            DeviceState *adaptor;
+            char *name;
+
+            adaptor_phandle = qemu_fdt_getprop_cell(fdti->fdt, node_path,
+                                                    "remote-ports",
+                                                    2 * i, false, &errp);
+            if (errp) {
+                fprintf(stderr, "cant get phandle from \"remote-ports\" "
+                            "property\n");
+                break;
+            }
+            if (qemu_devtree_get_node_by_phandle(fdti->fdt, adaptor_node_path,
+                                                 adaptor_phandle)) {
+                fprintf(stderr, "cant get node from phandle\n");
+                break;
+            }
+            while (!fdt_init_has_opaque(fdti, adaptor_node_path)) {
+                fdt_init_yield(fdti);
+            }
+            adaptor = DEVICE(fdt_init_get_opaque(fdti, adaptor_node_path));
+            name = g_strdup_printf("rp-adaptor%" PRId32, i);
+            object_property_set_link(OBJECT(dev), name, OBJECT(adaptor), &errp);
+            fprintf(stderr, "connecting RP to adaptor %s channel %d",
+                        object_get_canonical_path(OBJECT(adaptor)), i);
+            g_free(name);
+            if (errp) {
+                fprintf(stderr, "cant set adaptor link for device property\n");
+                break;
+            }
+
+            chan = qemu_fdt_getprop_cell(fdti->fdt, node_path, "remote-ports",
+                                         2 * i + 1, false, &errp);
+            if (errp) {
+                fprintf(stderr, "cant get channel from \"remote-ports\" "
+                            "property\n");
+                break;
+            }
+
+            name = g_strdup_printf("rp-chan%" PRId32, i);
+            object_property_set_int(OBJECT(dev), name, chan, &errp);
+            /*
+             * Not critical - device has right to not care about channel
+             * numbers if its a pure slave (only responses).
+             */
+            if (errp) {
+                fprintf(stderr, "cant set %s property %s\n", name,
+                        error_get_pretty(errp));
+                errp = NULL;
+            }
+            g_free(name);
+
+            name = g_strdup_printf("remote-port-dev%d", chan);
+            object_property_set_link(OBJECT(adaptor), name, OBJECT(dev), &errp);
+            g_free(name);
+            if (errp) {
+                fprintf(stderr, "cant set device link for adaptor\n");
+                break;
+            }
+        }
+        errp = NULL;
+    }
+
     if (object_dynamic_cast(dev, TYPE_DEVICE)) {
+        DeviceClass *dc = DEVICE_GET_CLASS(dev);
         const char *short_name = qemu_devtree_get_node_name(fdti->fdt,
                                                             node_path);
 
-        /* Connect chardev if we can */
-        if (serial_hd(fdt_serial_ports)) {
-            Chardev *value = (Chardev *) serial_hd(fdt_serial_ports);
-            char *chardev;
-
-            /* Check if the device already has a chardev.  */
-            chardev = object_property_get_str(dev, "chardev", &errp);
-            if (!errp && !strcmp(chardev, "")) {
-                object_property_set_str(dev, "chardev", value->label, &errp);
-                if (!errp) {
-                    /* It worked, the device is a charecter device */
-                    fdt_serial_ports++;
+        /*
+         * We don't want to connect remote port chardev's to the user facing
+         * serial devices.
+         */
+        if (!object_dynamic_cast(dev, TYPE_REMOTE_PORT)) {
+            /* Connect chardev if we can */
+            if (serial_hd(fdt_serial_ports)) {
+                Chardev *value = (Chardev *) serial_hd(fdt_serial_ports);
+                char *chardev;
+
+                /* Check if the device already has a chardev.  */
+                chardev = object_property_get_str(dev, "chardev", &errp);
+                if (!errp && !strcmp(chardev, "")) {
+                    object_property_set_str(dev, "chardev", value->label,
+                                            &errp);
+                    if (!errp) {
+                        /* It worked, the device is a charecter device */
+                        fdt_serial_ports++;
+                    }
                 }
+                errp = NULL;
             }
-            errp = NULL;
         }
 
         /* Regular TYPE_DEVICE houskeeping */
@@ -1176,6 +1267,9 @@ static int fdt_init_qdev(char *node_path, FDTMachineInfo *fdti, char *compat)
         } else {
             object_property_set_bool(OBJECT(dev), "realized", true,
                                      &error_fatal);
+            if (dc->legacy_reset) {
+                qemu_register_reset((void (*)(void *))dc->legacy_reset, dev);
+            }
         }
     }
 
-- 
2.43.0


