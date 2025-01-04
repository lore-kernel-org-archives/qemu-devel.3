Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2086CE77188
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jan 2025 06:41:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTxqG-0006D1-Ki; Sat, 04 Jan 2025 01:41:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTxqA-0006Cc-5d
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 01:40:54 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tTxq7-0007PF-L8
 for qemu-devel@nongnu.org; Sat, 04 Jan 2025 01:40:53 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-21628b3fe7dso175932585ad.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jan 2025 22:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1735972848; x=1736577648;
 darn=nongnu.org; 
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9MZ4H9hkbLmPvO5vmO8SOFmLF+4diLNAJZrxcWzi1mk=;
 b=CqACSAxWaSCYGZoTHe2bv/I0AuVMweB8Ztn7/w0HgnXK27EWJsCzFXpPwW1XgP6eP3
 UAwkGr1sgd1p5oC4ZGzkEwOvCLpeZ90Yzq8dYNEVS6J8IvNj6F6w90gWw9N3OGcNeoTV
 B9D368MfPmE1BgNtF7avOlxuofSG2eWaISt8ZrIZLSQX2ddC2s76StuFsAdNwqcePjy8
 XqCpM7J2Qy9rrZLpRk16TzsTfIL6hnhgIjyP13Db237NoauyrCjZQD+eRG9mREfJ4A3x
 CeCNDeaIZx41mBlzvdjg8Sbokr5zhKA5NS2oyJU4ISEsfPnxPz1GNljFbbJkRrY0Ll3j
 ZlWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735972848; x=1736577648;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9MZ4H9hkbLmPvO5vmO8SOFmLF+4diLNAJZrxcWzi1mk=;
 b=qv9tdUHZ2xH60lkOMil9rZDVqXM0BqltJXBKq9VtFEeRGk/AF1/QDezBid0RmADg8R
 bWyvG/ZqyxWz7VzV3MLMBlVCMa+ldiNEc7GIMO7jWWpowvxJwRNoNHe/J/96JKzgTfJJ
 aeZ1TNL6y5yb+LV8M0WcZFxBHPw+A6XPYBT1fm67BSoCyLHDxn7g2L6a+kGbTfdee+8k
 9r8W/6QCu2XGmvB9JJmQHGP8Q1DaZAPeGdlD0AixbXYeD2/llfe1pnuKvdOXKerM5k+k
 /XfEZqQ3S4Ur5zhJZ8MRBJMsahKF1TjYKiUdETkTYi0hUgOgX7stvMBRyuoxDJudVzG3
 Sq5A==
X-Gm-Message-State: AOJu0YxQQF81oQbgv7FZzAz8f46h8TbF0wgzfATX3NKLo4Xf16sgIHia
 ALCcq4Uj1QryWwcmHRqZikWlhnLpuJckLqdCmNCKYIZEdIFdU0KVqlrB2GNhBeU=
X-Gm-Gg: ASbGnctyDSsvQD+l8Eaxteyfu1LjjgsVvy+z+aN7Q7VZ0acrlDr3pgFYGYmR8DZNaJM
 2jm89T1q6/qU/jFAwrftUA1wsznN8sVV7qmphPMEmdCR6UbTLl/BKyH6fLI5pyMg1LnwOtS/nJH
 naX4lP13NNSU827Y/3jxZFwBZ8AzFQXBLYn2dkoqQ07w3usTO2okLLQv1sswK5YOyrkCYMCMuxn
 JdTXhlwH9XA1LHZ3WvmnceSZOLmReuxd2ABqJZ+tXqyVfJ5Ec/bZB7+f+pF
X-Google-Smtp-Source: AGHT+IEXXSn0sJrAWJWWfiDV9I+S47Xy0Zn4n/L+4ucz48q1PaE44ifvEdP/yKBC+gWl45EfF0C0GA==
X-Received: by 2002:a17:902:db11:b0:216:2f9d:32c with SMTP id
 d9443c01a7336-219e6f262ddmr746520405ad.53.1735972848354; 
 Fri, 03 Jan 2025 22:40:48 -0800 (PST)
Received: from localhost ([157.82.207.107])
 by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-219dc962bfasm255265285ad.2.2025.01.03.22.40.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Jan 2025 22:40:48 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 04 Jan 2025 15:40:40 +0900
Subject: [PATCH v4] hw/core: Unify hotplug decision logic
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250104-bus-v4-1-244cf1c6e2aa@daynix.com>
X-B4-Tracking: v=1; b=H4sIAOfXeGcC/2XMQQ6CMBAF0KuYrq1ppx0KrryHcVHaIl0IptUGQ
 ri7BWIicTPJn/z3JxJd8C6S82EiwSUffd/lII8HYlrd3R31NmcCDATPh9bvSBVqidKgrbAiufk
 MrvHDunK95dz6+OrDuI4mvnz3PnHKaaNQMid0aQu4WD12fjiZ/kGWgQQ/iLMNQUZCurpBBUWj2
 R8SXyQZ8HJDIqNSKQVoXGE57tA8zx84s9bdAQEAAA==
To: Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>
Cc: qemu-devel@nongnu.org, devel@daynix.com, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Changes in v4:
- Rebased.
- Link to v3: https://lore.kernel.org/r/20240218-bus-v3-1-877725ce6d15@daynix.com

Changes in v3:
- Extracted checks common for hot-plug and hot-unplug into a function.
- Link to v2: https://lore.kernel.org/r/20231210-bus-v2-1-34ebf5726fa0@daynix.com

Changes in v2:
- Fixed indention.
- Link to v1: https://lore.kernel.org/r/20231202-bus-v1-1-f7540e3a8d62@daynix.com
---
 include/hw/qdev-core.h |  3 ++-
 hw/core/qdev-hotplug.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 system/qdev-monitor.c  | 37 +++++--------------------------------
 3 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index e6ef80b7fd0e..c417d4f92bdd 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -544,7 +544,8 @@ void qdev_set_legacy_instance_id(DeviceState *dev, int alias_id,
                                  int required_for_version);
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev);
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev);
-bool qdev_hotplug_allowed(DeviceState *dev, Error **errp);
+bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp);
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp);
 
 /**
  * qdev_get_hotplug_handler() - Get handler responsible for device wiring
diff --git a/hw/core/qdev-hotplug.c b/hw/core/qdev-hotplug.c
index d495d0e9c70a..e11597acd1f7 100644
--- a/hw/core/qdev-hotplug.c
+++ b/hw/core/qdev-hotplug.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 #include "hw/qdev-core.h"
 #include "hw/boards.h"
+#include "qapi/error.h"
 
 HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
 {
@@ -30,12 +31,45 @@ HotplugHandler *qdev_get_machine_hotplug_handler(DeviceState *dev)
     return NULL;
 }
 
-bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
+static bool qdev_hotplug_unplug_allowed_common(DeviceState *dev, BusState *bus,
+                                               Error **errp)
+{
+    DeviceClass *dc = DEVICE_GET_CLASS(dev);
+
+    if (!dc->hotpluggable) {
+        error_setg(errp, "Device '%s' does not support hotplugging",
+                   object_get_typename(OBJECT(dev)));
+        return false;
+    }
+
+    if (bus) {
+        if (!qbus_is_hotpluggable(bus)) {
+            error_setg(errp, "Bus '%s' does not support hotplugging",
+                       bus->name);
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
+bool qdev_hotplug_allowed(DeviceState *dev, BusState *bus, Error **errp)
 {
     MachineState *machine;
     MachineClass *mc;
     Object *m_obj = qdev_get_machine();
 
+    if (!qdev_hotplug_unplug_allowed_common(dev, bus, errp)) {
+        return false;
+    }
+
     if (object_dynamic_cast(m_obj, TYPE_MACHINE)) {
         machine = MACHINE(m_obj);
         mc = MACHINE_GET_CLASS(machine);
@@ -47,6 +81,12 @@ bool qdev_hotplug_allowed(DeviceState *dev, Error **errp)
     return true;
 }
 
+bool qdev_hotunplug_allowed(DeviceState *dev, Error **errp)
+{
+    return !qdev_unplug_blocked(dev, errp) &&
+           qdev_hotplug_unplug_allowed_common(dev, dev->parent_bus, errp);
+}
+
 HotplugHandler *qdev_get_bus_hotplug_handler(DeviceState *dev)
 {
     if (dev->parent_bus) {
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index c844f5380255..30f28eb8e4ae 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -263,8 +263,7 @@ static DeviceClass *qdev_get_device_class(const char **driver, Error **errp)
     }
 
     dc = DEVICE_CLASS(oc);
-    if (!dc->user_creatable ||
-        (phase_check(PHASE_MACHINE_READY) && !dc->hotpluggable)) {
+    if (!dc->user_creatable) {
         error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "driver",
                    "a pluggable device type");
         return NULL;
@@ -675,11 +674,6 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         return NULL;
     }
 
-    if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
-        error_setg(errp, "Bus '%s' does not support hotplugging", bus->name);
-        return NULL;
-    }
-
     if (migration_is_running()) {
         error_setg(errp, "device_add not allowed while migrating");
         return NULL;
@@ -689,17 +683,9 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
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
+    if (phase_check(PHASE_MACHINE_READY) &&
+        !qdev_hotplug_allowed(dev, bus, errp)) {
+        goto err_del_dev;
     }
 
     /*
@@ -902,24 +888,11 @@ static DeviceState *find_device_state(const char *id, bool use_generic_error,
 
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
-        error_setg(errp, "Bus '%s' does not support hotplugging",
-                   dev->parent_bus->name);
-        return;
-    }
-
-    if (!dc->hotpluggable) {
-        error_setg(errp, "Device '%s' does not support hotplugging",
-                   object_get_typename(OBJECT(dev)));
+    if (!qdev_hotunplug_allowed(dev, errp)) {
         return;
     }
 

---
base-commit: 38d0939b86e2eef6f6a622c6f1f7befda0146595
change-id: 20231202-bus-75a454c5d959

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


