Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31396C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:15:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2tI-0000Zr-QU; Tue, 12 Mar 2024 10:14:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t8-0000WV-Gf
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t4-00029F-1l
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pOLH+strOaKKcjBOz7lvead/NQ2pWb64J4IWeJN+W4I=;
 b=NNZN2TFETXiLTkcigiV6bHiPMZ6XCfih7lfzUbiIBt6MoxDaXkNWu6ZiZ/o9nRBnjBoRvG
 dA/LNCGDybUMsfvRnI/sR5To9k1pep0Mw5DXtsAbVO4B65vNcJo+O7mdyHJ67gzC7b82c+
 7mTEwSi1HZXrbGV2kjZQgR5bJcCsqg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-277-anzAephTMNyZJw6A3o3L9w-1; Tue, 12 Mar 2024 10:13:45 -0400
X-MC-Unique: anzAephTMNyZJw6A3o3L9w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73B6D100DEBD;
 Tue, 12 Mar 2024 14:13:44 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C6371C05E1C;
 Tue, 12 Mar 2024 14:13:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3188421E6939; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-block@nongnu.org,
	philmd@linaro.org
Subject: [PATCH 04/10] qapi: Inline and remove QERR_DEVICE_NO_HOTPLUG
 definition
Date: Tue, 12 Mar 2024 15:13:37 +0100
Message-ID: <20240312141343.3168265-5-armbru@redhat.com>
In-Reply-To: <20240312141343.3168265-1-armbru@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 hw/core/qdev.c            | 4 ++--
 system/qdev-monitor.c     | 2 +-
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index daa889809b..e93211085a 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_DEVICE_NO_HOTPLUG \
-    "Device '%s' does not support hotplugging"
-
 #define QERR_INVALID_PARAMETER \
     "Invalid parameter '%s'"
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index c68d0f7c51..00efaf1bd1 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -29,7 +29,6 @@
 #include "qapi/error.h"
 #include "qapi/qapi-events-qdev.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
@@ -479,7 +478,8 @@ static void device_set_realized(Object *obj, bool value, Error **errp)
     static int unattached_count;
 
     if (dev->hotplugged && !dc->hotpluggable) {
-        error_setg(errp, QERR_DEVICE_NO_HOTPLUG, object_get_typename(obj));
+        error_setg(errp, "Device '%s' does not support hotplugging",
+                   object_get_typename(obj));
         return;
     }
 
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 842c142c79..e2eea7d96e 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -918,7 +918,7 @@ void qdev_unplug(DeviceState *dev, Error **errp)
     }
 
     if (!dc->hotpluggable) {
-        error_setg(errp, QERR_DEVICE_NO_HOTPLUG,
+        error_setg(errp, "Device '%s' does not support hotplugging",
                    object_get_typename(OBJECT(dev)));
         return;
     }
-- 
2.44.0


