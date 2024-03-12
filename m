Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D5A0C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:15:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2uM-0002TK-D0; Tue, 12 Mar 2024 10:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2tL-0000fJ-9G
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t8-0002Cd-4m
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:14:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a1BAftT8z48Vt5DWdMlzg8ja8eBDK/wd67jBTXaOBwk=;
 b=Pfa/hsyiv/7zJ3ev5U4xYMF+GuWn5Zbh6qzOo3fA0ZVR5FbXXbSF6FMhxvQPlEFFTwXVco
 sE3rhe0IrT1Lu34XoLZLM33dLxSEWkqArDCfKk4rvmqlNnJfLB4Bbn9I81ZspT9V1RVt6T
 Wyas0QrXwyaTaZ35WrTOv7yphqlnSa0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-321-tCub1hvOM8WywVSZL0cnXA-1; Tue,
 12 Mar 2024 10:13:46 -0400
X-MC-Unique: tCub1hvOM8WywVSZL0cnXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 70C0B1C54038;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C5AD40C6CB1;
 Tue, 12 Mar 2024 14:13:44 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2E8DB21E692E; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-block@nongnu.org,
	philmd@linaro.org
Subject: [PATCH 03/10] qapi: Inline and remove QERR_DEVICE_HAS_NO_MEDIUM
 definition
Date: Tue, 12 Mar 2024 15:13:36 +0100
Message-ID: <20240312141343.3168265-4-armbru@redhat.com>
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
 block/snapshot.c          | 7 ++++---
 blockdev.c                | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 06a1d2248e..daa889809b 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_DEVICE_HAS_NO_MEDIUM \
-    "Device '%s' has no medium"
-
 #define QERR_DEVICE_NO_HOTPLUG \
     "Device '%s' does not support hotplugging"
 
diff --git a/block/snapshot.c b/block/snapshot.c
index 8694fc0a3e..e2c18d3f8f 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -28,7 +28,6 @@
 #include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qstring.h"
 #include "qemu/option.h"
 #include "sysemu/block-backend.h"
@@ -359,7 +358,8 @@ int bdrv_snapshot_delete(BlockDriverState *bs,
     GLOBAL_STATE_CODE();
 
     if (!drv) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' has no medium",
+                   bdrv_get_device_name(bs));
         return -ENOMEDIUM;
     }
     if (!snapshot_id && !name) {
@@ -437,7 +437,8 @@ int bdrv_snapshot_load_tmp(BlockDriverState *bs,
     GRAPH_RDLOCK_GUARD_MAINLOOP();
 
     if (!drv) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, bdrv_get_device_name(bs));
+        error_setg(errp, "Device '%s' has no medium",
+                   bdrv_get_device_name(bs));
         return -ENOMEDIUM;
     }
     if (!snapshot_id && !name) {
diff --git a/blockdev.c b/blockdev.c
index d8fb3399f5..bd408e3e75 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1395,7 +1395,7 @@ static void external_snapshot_action(TransactionAction *action,
     bdrv_drained_begin(state->old_bs);
 
     if (!bdrv_is_inserted(state->old_bs)) {
-        error_setg(errp, QERR_DEVICE_HAS_NO_MEDIUM, device);
+        error_setg(errp, "Device '%s' has no medium", device);
         return;
     }
 
-- 
2.44.0


