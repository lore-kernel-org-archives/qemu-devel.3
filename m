Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E36C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXbt-0006Wq-0P; Wed, 24 Apr 2024 04:04:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbY-0005td-Go
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXbW-0003oI-H2
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:03:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713945823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZdO3ys51gFGTtlPnaZEuNtvyTcKAodScH+C3F5XFx4Q=;
 b=Yv26J/PnBazg9yB/rQb5HNyYHqeOmCJxgzLov3YG1YI1Ryjr7W0WoR9OBRcijSi8zxmsFd
 TiXtudBzQWDT3B0jyn1qOj+xQBzkJc0PK9iqEziaOd01mM6sdnkvf4Whg2tzRFea+T/zo2
 9jUyBY6HOeOv7oPaZyBk9ptmebrYaO0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-bbUme36JMGa1gPcDkbxOMw-1; Wed, 24 Apr 2024 04:03:39 -0400
X-MC-Unique: bbUme36JMGa1gPcDkbxOMw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 44875812C39;
 Wed, 24 Apr 2024 08:03:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 257F5C13FA4;
 Wed, 24 Apr 2024 08:03:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4AD0D21E65D8; Wed, 24 Apr 2024 10:03:37 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 07/10] qapi: Inline and remove QERR_INVALID_PARAMETER_TYPE
 definition
Date: Wed, 24 Apr 2024 10:03:34 +0200
Message-ID: <20240424080337.2782594-8-armbru@redhat.com>
In-Reply-To: <20240424080337.2782594-1-armbru@redhat.com>
References: <20240424080337.2782594-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Manual changes (escaping the format in qapi/visit.py).

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240312141343.3168265-8-armbru@redhat.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 qom/object.c              | 4 ++--
 scripts/qapi/visit.py     | 5 ++---
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 63ab775dc5..b723830eff 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -17,9 +17,6 @@
  * add new ones!
  */
 
-#define QERR_INVALID_PARAMETER_TYPE \
-    "Invalid parameter type for '%s', expected: %s"
-
 #define QERR_INVALID_PARAMETER_VALUE \
     "Parameter '%s' expects %s"
 
diff --git a/qom/object.c b/qom/object.c
index 3d96818f7d..44ec8f6460 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -23,7 +23,6 @@
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/forward-visitor.h"
 #include "qapi/qapi-builtin-visit.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
 #include "trace.h"
 
@@ -1912,7 +1911,8 @@ static Object *object_resolve_link(Object *obj, const char *name,
     } else if (!target) {
         target = object_resolve_path(path, &ambiguous);
         if (target || ambiguous) {
-            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, target_type);
+            error_setg(errp, "Invalid parameter type for '%s', expected: %s",
+                             name, target_type);
         } else {
             error_set(errp, ERROR_CLASS_DEVICE_NOT_FOUND,
                       "Device '%s' not found", path);
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index c56ea4d724..a21b7b1468 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -278,8 +278,8 @@ def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
         abort();
     default:
         assert(visit_is_input(v));
-        error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name ? name : "null",
-                   "%(name)s");
+        error_setg(errp, "Invalid parameter type for '%%s', expected: %(name)s",
+                         name ? name : "null");
         /* Avoid passing invalid *obj to qapi_free_%(c_name)s() */
         g_free(*obj);
         *obj = NULL;
@@ -356,7 +356,6 @@ def _begin_user_module(self, name: str) -> None:
         self._genc.preamble_add(mcgen('''
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "qapi/qmp/qerror.h"
 #include "%(visit)s.h"
 ''',
                                       visit=visit))
-- 
2.44.0


