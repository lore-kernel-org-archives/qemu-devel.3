Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C167C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2tj-0000rz-FJ; Tue, 12 Mar 2024 10:14:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t9-0000Yt-QH
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t4-00029j-4s
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252828;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EfKEUanZYxUIJ2dDav+OV0GW1QHkTACV4MMey+9QxoQ=;
 b=KBZcPeqbQgKxS9NLP5LWZWL13dTrXrEEtdefiIru9qJh+z25RXXD3pptrujE32svn7aOme
 6PdSFv5D1E73BDb08h8c6WFB0izSC3kqgvPjVX96OyBn9oZqHqkvX1nKwQJke6cHD6Wss6
 J+rtUXrAAFnLHnIuk4nsB/PBcuB0m8I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-313-xZ7AfJZ3MSSzQ_lmlnR6Qw-1; Tue, 12 Mar 2024 10:13:44 -0400
X-MC-Unique: xZ7AfJZ3MSSzQ_lmlnR6Qw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 723BC8A1931;
 Tue, 12 Mar 2024 14:13:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A65C40C6DB7;
 Tue, 12 Mar 2024 14:13:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2BC3721E691E; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-block@nongnu.org, philmd@linaro.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PATCH 02/10] qapi: Inline and remove QERR_BUS_NO_HOTPLUG definition
Date: Tue, 12 Mar 2024 15:13:35 +0100
Message-ID: <20240312141343.3168265-3-armbru@redhat.com>
In-Reply-To: <20240312141343.3168265-1-armbru@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Address the comment added in commit 4629ed1e98
("qerror: Finally unused, clean up"), from 2015:

  /*
   * These macros will go away, please don't use
   * in new code, and do not add new ones!
   */

Mechanical transformation using sed, and manual cleanup.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 hw/ppc/spapr_pci.c        | 5 ++---
 system/qdev-monitor.c     | 8 +++++---
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 0c2689cf8a..06a1d2248e 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_BUS_NO_HOTPLUG \
-    "Bus '%s' does not support hotplugging"
-
 #define QERR_DEVICE_HAS_NO_MEDIUM \
     "Device '%s' has no medium"
 
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 25e0295d6f..72cfba419a 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -39,7 +39,6 @@
 #include "trace.h"
 #include "qemu/error-report.h"
 #include "qemu/module.h"
-#include "qapi/qmp/qerror.h"
 #include "hw/ppc/fdt.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_bus.h"
@@ -1554,7 +1553,7 @@ static void spapr_pci_pre_plug(HotplugHandler *plug_handler,
          * we need to let them know it's not enabled
          */
         if (plugged_dev->hotplugged) {
-            error_setg(errp, QERR_BUS_NO_HOTPLUG,
+            error_setg(errp, "Bus '%s' does not support hotplugging",
                        phb->parent_obj.bus->qbus.name);
             return;
         }
@@ -1675,7 +1674,7 @@ static void spapr_pci_unplug_request(HotplugHandler *plug_handler,
     SpaprDrc *drc = drc_from_dev(phb, pdev);
 
     if (!phb->dr_enabled) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG,
+        error_setg(errp, "Bus '%s' does not support hotplugging",
                    phb->parent_obj.bus->qbus.name);
         return;
     }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 09e07cab9b..842c142c79 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -661,7 +661,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
 
     if (qdev_should_hide_device(opts, from_json, errp)) {
         if (bus && !qbus_is_hotpluggable(bus)) {
-            error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
+            error_setg(errp, "Bus '%s' does not support hotplugging",
+                       bus->name);
         }
         return NULL;
     } else if (*errp) {
@@ -669,7 +670,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
     }
 
     if (phase_check(PHASE_MACHINE_READY) && bus && !qbus_is_hotpluggable(bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, bus->name);
+        error_setg(errp, "Bus '%s' does not support hotplugging", bus->name);
         return NULL;
     }
 
@@ -911,7 +912,8 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     }
 
     if (dev->parent_bus && !qbus_is_hotpluggable(dev->parent_bus)) {
-        error_setg(errp, QERR_BUS_NO_HOTPLUG, dev->parent_bus->name);
+        error_setg(errp, "Bus '%s' does not support hotplugging",
+                   dev->parent_bus->name);
         return;
     }
 
-- 
2.44.0


