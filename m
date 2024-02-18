Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95EEBC4829E
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Feb 2024 06:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbb7A-0003bB-Lq; Sun, 18 Feb 2024 01:57:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbb78-0003aw-IN
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 01:57:26 -0500
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rbb76-00074W-GZ
 for qemu-devel@nongnu.org; Sun, 18 Feb 2024 01:57:26 -0500
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2995185dbbbso988796a91.3
 for <qemu-devel@nongnu.org>; Sat, 17 Feb 2024 22:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1708239443; x=1708844243;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=S43KsOcAcGX2yK/bYlsSfMSeKhPuT6av0Rv9GCnem8E=;
 b=eIDy27sk5677lckS/NnZG8/2Og5g3hjOsAItlY3zWZIh7GozN88rnfGb46mpHV3XoX
 dC9FpeP7Jjdf1/AwvDwcojFMxrHqyM1GCvL5EpK/wKdKnQqEF2tLekgGYWv4pzjMsEs+
 cIoop5asgRjN8rUK1A4uqNSKI0YxNDAaVUv79Ds0vzNemk2Z4jqmgSs0Q86V8Le9lIIz
 DVkHosN/ARI7gZP3fhtBABZgG+yLwtVGLRKpmANFWIAb0XflXdNekRO6vaWEwl5U0jJ1
 p76TaAr2xb8p+gcpCZMcfDDmYACbSpTTiZWtpEiklOxkYEM98Zufjb2fllhiIJOOZ7R0
 RjnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708239443; x=1708844243;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S43KsOcAcGX2yK/bYlsSfMSeKhPuT6av0Rv9GCnem8E=;
 b=dGHHHaGtUI1jC3LIJB1OihmmAVQ8kc365uaX6es/szjpcc3wLHRpkd8Uhh6tZEWy5V
 yJV3jK1BR0EL+tIJ16TRzpaOP8oJdXIut1iySflBU2f3ymx3meX7OvAWXEWLqb+uGe50
 aVFtJdfnhIDXZMw7lFfjddiPJNBB3suO0yOTz6UQN3R6LFeQDQ9ykzwUVaB7FbdPLQkQ
 yQLmM+u2FXRzXWUozS8m579tHlp/8sBb9ZVVC5TrAc5gADU1E8zAJs10bSr42/fnDXj3
 p7ZM/fZpoqCVPg5PewONfI2qEWGn3HodOxEGk442h0li0te8E+oeSws3dLnYMNFOijgQ
 DkgA==
X-Gm-Message-State: AOJu0YxKc8oygH06GLyC6wKm4ijz8qgfVe75cLXmZeO6oFa6XqA59lZU
 BgiVZ/btuciYlF9eSRlRWRXgD8lqmZX1KiIJSyShPoxlWxwZqqKrgZDR5esQl7s=
X-Google-Smtp-Source: AGHT+IFTD6sy61RcE5jh5CU7I7Pmm1S9iCsjITuhQEXnzKzeS3wzC6CdihKlK3ro8uI7tkVbvEZ+uQ==
X-Received: by 2002:a17:90b:fca:b0:299:3007:ad13 with SMTP id
 gd10-20020a17090b0fca00b002993007ad13mr5708889pjb.32.1708239442833; 
 Sat, 17 Feb 2024 22:57:22 -0800 (PST)
Received: from localhost ([157.82.200.138])
 by smtp.gmail.com with UTF8SMTPSA id
 sl14-20020a17090b2e0e00b00296d9c4d5f0sm2785185pjb.10.2024.02.17.22.57.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 17 Feb 2024 22:57:22 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sun, 18 Feb 2024 15:57:11 +0900
Subject: [PATCH v3] hw/core: Unify hotplug decision logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240218-bus-v3-1-877725ce6d15@daynix.com>
X-B4-Tracking: v=1; b=H4sIAEaq0WUC/1WMzQ6CMBAGX4Xs2Zr+gnjyPYyHQreyB4G02kAI7
 27Bi1w2mc03s0DEQBjhWiwQMFGkoc+gTgW0ne2fyMhlBsmlEvmw5hNZZaw2ujWuNjXk5RjQ07R
 X7o/MHcX3EOY9msT2PfpJMMF8ZTRHZS+ulDdn556mczu8YAsk+ScJ/pNklpTGxptKlt7yg7Su6
 xf76n6fzAAAAA==
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.3
Received-SPF: none client-ip=2607:f8b0:4864:20::102f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Commit 03fcbd9dc508 ("qdev: Check for the availability of a hotplug
controller before adding a device") says:
> The qdev_unplug() function contains a g_assert(hotplug_ctrl)
> statement, so QEMU crashes when the user tries to device_add +
> device_del a device that does not have a corresponding hotplug
> controller.

> The code in qdev_device_add() already checks whether the bus has a
> proper hotplug controller, but for devices that do not have a
> corresponding bus, here is no appropriate check available yet. In that
> case we should check whether the machine itself provides a suitable
> hotplug controller and refuse to plug the device if none is available.

However, it forgot to add the corresponding check to qdev_unplug().

Most checks are comon between the hot-plug and hot-unplug scenarios so
extract them and share the implementation, saving some code and fixing
the aforementioned bug.

Fixes: 7716b8ca74 ("qdev: HotplugHandler: Add support for unplugging BUS-less devices")
Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Changes in v3:
- Extracted checks common for hot-plug and hot-unplug into a function.
- Link to v2: https://lore.kernel.org/r/20231210-bus-v2-1-34ebf5726fa0@daynix.com

Changes in v2:
- Fixed indention.
- Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
---
 include/hw/qdev-core.h |  1 +
 hw/core/qdev-hotplug.c | 39 +++++++++++++++++++++++++++++++++++++++
 system/qdev-monitor.c  | 35 ++++-------------------------------
 3 files changed, 44 insertions(+), 31 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 9228e96c87e9..94ee4bb26415 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -533,6 +533,7 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
 bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp);
 
 /**
  * qdev_get_hotplug_handler() - Get handler responsible for device wiring
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index d495d0e9c70a..7785fc52267b 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -12,6 +12,8 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
 #include "hw/boards.h"
+#include "qapi/error.h"
+#include "qapi/qmp/qerror.h"
 
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
@@ -30,12 +32,43 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
+static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->hotpluggable) {
+        error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
+                   object_get_typename(OBJECT(dev)));
+        return false;
+    }
+
+    if (dev->parent_bus) {
+        if (!qbus_is_hotpluggable(dev->parent_bus)) {
+            error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
+            return false;
+        }
+    } else {
+        if (!qdev_get_machine_hotplug_handler(dev)) {
+            /* No bus, no machine hotplug handler --> device is not hotpluggable */
+            error_setg(errp, "Device '%s' can not be hotplugged on this machine",
+                       object_get_typename(OBJECT(dev)));
+            return false;
+        }
+    }
+
+    return true;
+}
+
 bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
 {
     MachineState *machine;
     MachineClass *mc;
     Object *m_obj = qdev_get_machine();
 
+    if (!qdev_hotplug_unplug_allowed_common(dev, errp)) {
+        return false;
+    }
+
     if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
         machine = MACHINE(m_obj);
         mc = MACHINE_GET_CLASS(machine);
@@ -47,6 +80,12 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
     return true;
 }
 
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp)
+{
+    return !qdev_unplug_blocked(dev, errp) &&
+           qdev_hotplug_unplug_allowed_common(dev, errp);
+}
+
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
 {
     if (dev->parent_bus) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5dd..b079e827ee8f 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -257,8 +257,7 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
     }
 
     dc = DEVICE_CLASS(oc);
-    if (!dc->user_creatable ||
-        (phase_check(PHASE_MACHINE_READY) && !dc->hotpluggable)) {
+    if (!dc->user_creatable) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
                    "a pluggable device type");
         return NULL;
@@ -668,11 +667,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
-    if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
-        return NULL;
-    }
-
     if (!migration_is_idle()) {
         error_setg(errp, "device_add not allowed while migrating");
         return NULL;
@@ -682,17 +676,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     dev = qdev_new(driver);
 
     /* Check whether the hotplug is allowed by the machine */
-    if (phase_check(PHASE_MACHINE_READY)) {
-        if (!qdev_hotplug_allowed(dev, errp)) {
-            goto err_del_dev;
-        }
-
-        if (!bus && !qdev_get_machine_hotplug_handler(dev)) {
-            /* No bus, no machine hotplug handler --> device is not hotpluggable */
-            error_setg(errp, "Device '%s' can not be hotplugged on this machine",
-                       driver);
-            goto err_del_dev;
-        }
+    if (phase_check(PHASE_MACHINE_READY) && !qdev_hotplug_allowed(dev, errp)) {
+        goto err_del_dev;
     }
 
     /*
@@ -899,23 +884,11 @@ static DeviceState *find_device_state(const char *id, Error **errp)
 
 void qdev_unplug(DeviceState *dev, Error **errp)
 {
-    DeviceClass *dc = DEVICE_GET_CLASS(dev);
     HotplugHandler *hotplug_ctrl;
     HotplugHandlerClass *hdc;
     Error *local_err = NULL;
 
-    if (qdev_unplug_blocked(dev, errp)) {
-        return;
-    }
-
-    if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
-        return;
-    }
-
-    if (!dc->hotpluggable) {
-        error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
-                   object_get_typename(OBJECT(dev)));
+    if (!qdev_hotunplug_allowed(dev, errp)) {
         return;
     }
 

---
base-commit: 5005aed8a7e728d028efb40e243ecfc2b4f3df3a
change-id: 20231202-bus-75a454c5d959

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


