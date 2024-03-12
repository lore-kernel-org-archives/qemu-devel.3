Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85BF4C54E60
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 14:16:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk2tn-0000yD-Pi; Tue, 12 Mar 2024 10:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2tB-0000Zs-HX
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rk2t4-0002Al-VQ
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 10:13:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710252829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HcFZDgD45EqkvdlOQUrgLpUdCGTxDcVOQaK1UoOzDnw=;
 b=YgNE66kLQQfGiJBax9WKPyZqCEc5QFbtTKof0vzrQqTncmOFtNW9QonmcFQnEygAPEFjdG
 Dfi3khW4wsxGIGtUi0ju2z2XI8wqAYVTW4c5YewU4lqC5ONeIWpfn0ckiYd3CJPUHGHJBt
 Ag8AfG6o8ve5gQMvZe3aKuukXuACTIY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-Tlr0N80fPhWfhx4TGZQR6w-1; Tue, 12 Mar 2024 10:13:46 -0400
X-MC-Unique: Tlr0N80fPhWfhx4TGZQR6w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE0A38A3D20;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99E3F37F1;
 Tue, 12 Mar 2024 14:13:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4444521E681B; Tue, 12 Mar 2024 15:13:43 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org,
	qemu-block@nongnu.org,
	philmd@linaro.org
Subject: [PATCH 10/10] qapi: Inline and remove QERR_PROPERTY_VALUE_BAD
 definition
Date: Tue, 12 Mar 2024 15:13:43 +0100
Message-ID: <20240312141343.3168265-11-armbru@redhat.com>
In-Reply-To: <20240312141343.3168265-1-armbru@redhat.com>
References: <20240312141343.3168265-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
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

Manual change. Remove the definition in
include/qapi/qmp/qerror.h.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qerror.h | 3 ---
 hw/core/qdev-properties.c | 3 +--
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/include/qapi/qmp/qerror.h b/include/qapi/qmp/qerror.h
index 385a4876d6..00b18e9082 100644
--- a/include/qapi/qmp/qerror.h
+++ b/include/qapi/qmp/qerror.h
@@ -26,9 +26,6 @@
 #define QERR_MISSING_PARAMETER \
     "Parameter '%s' is missing"
 
-#define QERR_PROPERTY_VALUE_BAD \
-    "Property '%s.%s' doesn't take value '%s'"
-
 #define QERR_PROPERTY_VALUE_OUT_OF_RANGE \
     "Property %s.%s doesn't take value %" PRId64 " (minimum: %" PRId64 ", maximum: %" PRId64 ")"
 
diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index 7d6fa726fd..86a583574d 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -2,7 +2,6 @@
 #include "hw/qdev-properties.h"
 #include "qapi/error.h"
 #include "qapi/qapi-types-misc.h"
-#include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qlist.h"
 #include "qemu/ctype.h"
 #include "qemu/error-report.h"
@@ -792,7 +791,7 @@ void error_set_from_qdev_prop_error(Error **errp, int ret, Object *obj,
         break;
     default:
     case -EINVAL:
-        error_setg(errp, QERR_PROPERTY_VALUE_BAD,
+        error_setg(errp, "Property '%s.%s' doesn't take value '%s'",
                    object_get_typename(obj), name, value);
         break;
     case -ENOENT:
-- 
2.44.0


