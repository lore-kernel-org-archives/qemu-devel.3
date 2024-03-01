Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 368D5C5475B
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 18:13:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg7NB-0004Tg-PN; Fri, 01 Mar 2024 13:12:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rg7N9-0004Sq-IZ
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:12:39 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rg7N7-00050H-EW
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 13:12:39 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 1EFA44E6013;
 Fri,  1 Mar 2024 19:12:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id YV6P0doiTqEV; Fri,  1 Mar 2024 19:12:29 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 332754E602B; Fri,  1 Mar 2024 19:12:29 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH] hmp: Add option to info qtree to omit details
Date: Fri, 01 Mar 2024 19:05:22 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Dr David Alan Gilbert <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 berrange@redhat.com
Message-Id: <20240301181229.332754E602B@zero.eik.bme.hu>
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The output of info qtree monitor command is very long. Add an option
to print a brief overview omitting all the details.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hmp-commands-info.hx  |  6 +++---
 system/qdev-monitor.c | 24 +++++++++++++-----------
 2 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index da120f82a3..ad1b1306e3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -540,9 +540,9 @@ ERST
 
     {
         .name       = "qtree",
-        .args_type  = "",
-        .params     = "",
-        .help       = "show device tree",
+        .args_type  = "brief:-b",
+        .params     = "[-b]",
+        .help       = "show device tree (-b: brief, omit properties)",
         .cmd        = hmp_info_qtree,
     },
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index a13db763e5..d5cef36800 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -744,7 +744,6 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
 }
 
 #define qdev_printf(fmt, ...) monitor_printf(mon, "%*s" fmt, indent, "", ## __VA_ARGS__)
-static void qbus_print(Monitor *mon, BusState *bus, int indent);
 
 static void qdev_print_props(Monitor *mon, DeviceState *dev, Property *props,
                              int indent)
@@ -784,13 +783,9 @@ static void bus_print_dev(BusState *bus, Monitor *mon, DeviceState *dev, int ind
 static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
 {
     ObjectClass *class;
-    BusState *child;
     NamedGPIOList *ngl;
     NamedClockList *ncl;
 
-    qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
-                dev->id ? dev->id : "");
-    indent += 2;
     QLIST_FOREACH(ngl, &dev->gpios, node) {
         if (ngl->num_in) {
             qdev_printf("gpio-in \"%s\" %d\n", ngl->name ? ngl->name : "",
@@ -814,12 +809,9 @@ static void qdev_print(Monitor *mon, DeviceState *dev, int indent)
         class = object_class_get_parent(class);
     } while (class != object_class_by_name(TYPE_DEVICE));
     bus_print_dev(dev->parent_bus, mon, dev, indent);
-    QLIST_FOREACH(child, &dev->child_bus, sibling) {
-        qbus_print(mon, child, indent);
-    }
 }
 
-static void qbus_print(Monitor *mon, BusState *bus, int indent)
+static void qbus_print(Monitor *mon, BusState *bus, int indent, bool details)
 {
     BusChild *kid;
 
@@ -827,16 +819,26 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent)
     indent += 2;
     qdev_printf("type %s\n", object_get_typename(OBJECT(bus)));
     QTAILQ_FOREACH(kid, &bus->children, sibling) {
+        BusState *child_bus;
         DeviceState *dev = kid->child;
-        qdev_print(mon, dev, indent);
+        qdev_printf("dev: %s, id \"%s\"\n", object_get_typename(OBJECT(dev)),
+                    dev->id ? dev->id : "");
+        if (details) {
+            qdev_print(mon, dev, indent + 2);
+        }
+        QLIST_FOREACH(child_bus, &dev->child_bus, sibling) {
+            qbus_print(mon, child_bus, indent + 2, details);
+        }
     }
 }
 #undef qdev_printf
 
 void hmp_info_qtree(Monitor *mon, const QDict *qdict)
 {
+    bool brief = qdict_get_try_bool(qdict, "brief", false);
+
     if (sysbus_get_default())
-        qbus_print(mon, sysbus_get_default(), 0);
+        qbus_print(mon, sysbus_get_default(), 0, !brief);
 }
 
 void hmp_info_qdm(Monitor *mon, const QDict *qdict)
-- 
2.30.9


