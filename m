Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 971A0CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 09:08:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vB8Hx-0001Jl-KN; Tue, 21 Oct 2025 05:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Hw-0001JO-1K
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vB8Hu-0003wd-7F
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 05:04:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761037453;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2KZIoozjfu2C+xVlZ+aEGmbOyE0e3/BqkuwJq/qKsDc=;
 b=XBUelE1Z+2ETIt7WfDBVyiuh50V8NsNY9Ls22qog7LPskqgU7Bdnw/7NGBn7PIKFVSDB+L
 NvXXx7Mn4ohNaGR0Hf69N7tU0KdcQ4zPKN8cTbVcwe24OXAZoFowPi4cBz5qatmpg8zZ/4
 i/GzgLnuKZbae97HOHFfCu79rlCdpnI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-591-9RF8dQpmMCyr6AMNtNhr3w-1; Tue,
 21 Oct 2025 05:04:09 -0400
X-MC-Unique: 9RF8dQpmMCyr6AMNtNhr3w-1
X-Mimecast-MFC-AGG-ID: 9RF8dQpmMCyr6AMNtNhr3w_1761037448
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 45D8B180035D; Tue, 21 Oct 2025 09:04:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.9])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A8A221954102; Tue, 21 Oct 2025 09:04:05 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Volker=20R=C3=BCmelin?= <vr_qemu@t-online.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 08/43] qdev: add qdev_find_default_bus()
Date: Tue, 21 Oct 2025 13:02:39 +0400
Message-ID: <20251021090317.425409-9-marcandre.lureau@redhat.com>
In-Reply-To: <20251021090317.425409-1-marcandre.lureau@redhat.com>
References: <20251021090317.425409-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

This helper is used next by -audio code.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/monitor/qdev.h |  3 +++
 system/qdev-monitor.c  | 21 +++++++++++++++++----
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 1d57bf6577..de33637869 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -1,6 +1,8 @@
 #ifndef MONITOR_QDEV_H
 #define MONITOR_QDEV_H
 
+#include "hw/qdev-core.h"
+
 /*** monitor commands ***/
 
 void hmp_info_qtree(Monitor *mon, const QDict *qdict);
@@ -11,6 +13,7 @@ int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
 DeviceState *qdev_device_add_from_qdict(const QDict *opts,
                                         bool from_json, Error **errp);
+BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp);
 
 /**
  * qdev_set_id: parent the device and set its id if provided.
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 2ac92d0a07..4b732f579a 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -621,6 +621,21 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
     return prop->name;
 }
 
+BusState *qdev_find_default_bus(DeviceClass *dc, Error **errp)
+{
+    BusState *bus = NULL;
+
+    assert(dc->bus_type != NULL);
+    bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);
+    if (!bus || qbus_is_full(bus)) {
+        error_setg(errp, "No '%s' bus found for device '%s'",
+                   dc->bus_type, object_class_get_name(OBJECT_CLASS(dc)));
+        return NULL;
+    }
+
+    return bus;
+}
+
 DeviceState *qdev_device_add_from_qdict(const QDict *opts,
                                         bool from_json, Error **errp)
 {
@@ -657,10 +672,8 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
             return NULL;
         }
     } else if (dc->bus_type != NULL) {
-        bus = qbus_find_recursive(sysbus_get_default(), NULL, dc->bus_type);
-        if (!bus || qbus_is_full(bus)) {
-            error_setg(errp, "No '%s' bus found for device '%s'",
-                       dc->bus_type, driver);
+        bus = qdev_find_default_bus(dc, errp);
+        if (!bus) {
             return NULL;
         }
     }
-- 
2.51.0


