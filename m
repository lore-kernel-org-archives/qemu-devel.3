Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E512C54798
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Mar 2024 18:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riIdM-0005kW-By; Thu, 07 Mar 2024 13:38:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1riIdK-0005kH-OM
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:38:22 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1riIdI-0003Vl-HY
 for qemu-devel@nongnu.org; Thu, 07 Mar 2024 13:38:22 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id E289D4E6013;
 Thu,  7 Mar 2024 19:38:13 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id rvDrDxA4MKQs; Thu,  7 Mar 2024 19:38:12 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 0105D4E6004; Thu,  7 Mar 2024 19:38:11 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 1 Mar 2024 19:01:10 +0100
Subject: [PATCH v2] hmp: Add option to info qtree to omit details
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Dr. David Alan Gilbert <dave@treblig.org>, berrange@redhat.com
Message-Id: <20240307183812.0105D4E6004@zero.eik.bme.hu>
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: 15
X-Spam_score: 1.5
X-Spam_bar: +
X-Spam_report: (1.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_96_XX=3.405,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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
Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
---
v2:
- Change the variable name to deails too
- Add braces to if (checkpatch did not warn for this so just noticed)

 hmp-commands-info.hx  |  6 +++---
 system/qdev-monitor.c | 27 +++++++++++++++------------
 2 files changed, 18 insertions(+), 15 deletions(-)

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
index a13db763e5..ad91e74181 100644
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
 
@@ -827,16 +819,27 @@ static void qbus_print(Monitor *mon, BusState *bus, int indent)
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
-    if (sysbus_get_default())
-        qbus_print(mon, sysbus_get_default(), 0);
+    bool details = !qdict_get_try_bool(qdict, "brief", false);
+
+    if (sysbus_get_default()) {
+        qbus_print(mon, sysbus_get_default(), 0, details);
+    }
 }
 
 void hmp_info_qdm(Monitor *mon, const QDict *qdict)
-- 
2.30.9


