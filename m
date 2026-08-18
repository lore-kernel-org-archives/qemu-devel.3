Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6408DC5DF81
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 11:13:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwHlH-0004Ly-L4; Tue, 18 Aug 2026 07:13:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHlG-0004LK-4h
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:13:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wwHlE-0004wA-N4
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 07:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787051620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Am3fRUJN9WuS7yqX+JPuhH7t6tfc338MroN3poph0bA=;
 b=Op4/u9siMBv5vG4CgciHictbsR1C+fAZHgu2CRVRRZ11U6CyhN+E39LZ/qJKeKEppLkSXv
 tc1rVI0EjeanJt63WJiDC+deBBhJ76FchKnlk9pML+q7xwv94D82FwodRrqZwe4DdlrbJT
 eZMJHFj6po25wQlnUpk9L8AI/lSVLvM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-z8XOwSgsNGeqJbjhuHlJdw-1; Tue,
 18 Aug 2026 07:13:37 -0400
X-MC-Unique: z8XOwSgsNGeqJbjhuHlJdw-1
X-Mimecast-MFC-AGG-ID: z8XOwSgsNGeqJbjhuHlJdw_1787051616
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BB908195605E; Tue, 18 Aug 2026 11:13:36 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 486FD195608A; Tue, 18 Aug 2026 11:13:31 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 18 Aug 2026 15:10:34 +0400
Subject: [PATCH v3 07/74] qom: add qapi_type field to ObjectProperty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260818-qom-qapi-v3-7-24b8bbbe3d86@redhat.com>
References: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
In-Reply-To: <20260818-qom-qapi-v3-0-24b8bbbe3d86@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1476;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=TtVEytUTXDdPuJzkoYiSuVYrieRCBIflozR8YGeFf14=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqhD238vDavSvw7DI2BCywQMQa+BPMvgwUON0g2
 ihsOmKuKKWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaoQ9twAKCRDa6OEJdZac
 5X9ID/9oHV/poerUJfecOrjnpJRwJGs/WIZEQUn4nwJsFAObv2IMK9BM1EnUZHgPRYKk6A8fdz8
 L+69j+Ovi30dTmMAhIOrA6Ejrx8jIS8oTo2AYo0ZFaX+Gp1s9V0Fe11d6BaCxkFJ8xBBYV/Gg5B
 46n5QHqgL3aEkAQYRWm9SLDt+NPO/hvxNevQ6k3zniUfwHX7ARLTf1lTWdj2wjU8gK1GmNu/g+Y
 0UHcJMf9pNC9LE2DA35bSD1VcOQvgWfwwS+W7WrDC87jPMQg0moXjAhjEx/S+WCUEfkQtp33+ZJ
 Rc98AGLcUZtNfCFXS6m9dGYBjhH1fJXXxhWSQhL+PiMOUGlC0b57HSygZuc6IX+ZTouLqrUejWc
 0adGAKnBCdn74GzdbXnqYypgfcdvOqpCb87Pox1stWS108aNtk54IZNGMWldX16f8XqMYvNPooj
 ntYl76pY1olsVLs80TmwTUi1+75yyHa9K0/5oI19tXBTkUfd4CG+ZnwLsWp37D3kwniK1hD0IRW
 4tPx58MnJh/+PmN2CIE/oJykai5/2Cvh9kLEzOBqI8sH/rXjZTaX0gpdQlhmrExPSTP+xbclP5B
 1SQ0TJfu7vjhRjle5k8knMDu/wsV2yuR7x22FYzRcE6fvuHLlt/WadzrL1woXPROQ66ErYdphH9
 MNXQIcaKf9WWDWA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Add a const pointer to QAPITypeInfo in ObjectProperty. NULL for now,
but future patches will add means to make it non-null. The
QAPITypeInfo will then be used by QOM introspection to tie the
property to a QAPI type.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 include/qom/object.h | 2 ++
 qom/object.c         | 1 +
 2 files changed, 3 insertions(+)

diff --git a/include/qom/object.h b/include/qom/object.h
index 11b1c9d2dc8a..a262eda8de2c 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -15,6 +15,7 @@
 #define QEMU_OBJECT_H
 
 #include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-type-info.h"
 #include "qemu/module.h"
 
 struct TypeImpl;
@@ -91,6 +92,7 @@ struct ObjectProperty
     char *name;
     char *type;
     char *description;
+    const QAPITypeInfo *qapi_type;
     ObjectPropertyAccessor *get;
     ObjectPropertyAccessor *set;
     ObjectPropertyResolve *resolve;
diff --git a/qom/object.c b/qom/object.c
index 47977b1f440b..6224e643000b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -2937,6 +2937,7 @@ object_property_add_alias(Object *obj, const char *name,
                              property_release_alias,
                              prop);
     op->resolve = property_resolve_alias;
+    op->qapi_type = target_prop->qapi_type;
     if (target_prop->defval) {
         op->defval = qobject_ref(target_prop->defval);
     }

-- 
2.55.0.543.g5ebe2ebe4ea8


