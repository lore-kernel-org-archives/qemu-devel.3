Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8409606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Z4dnY8MP
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbzz-00058F-6f; Sun, 01 Nov 2026 15:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzd-0004qc-OZ
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbza-00079U-3S
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7RNZYnm+eF4OzlPujJSw4fjnHCyCQO0WFgeUq72Aac=;
 b=Z4dnY8MPfM3WYdnAkE8ucJtv07c0BNiLL15o6TKsRXpL8IUwwaBerlAHU2PUZEeUyLhzgX
 Aea8Coa40A0CAD64bcPIMuu9Naj/jZp/dq38zk1keGQnX3UCl6XtAhJ2gvZeSz8T92u+cC
 wfPs4/4kqE64S7oT1xQWKFX6lBEUeHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-BvXEXWlkMNi0VJFnY3x6TA-1; Sun,
 01 Nov 2026 15:17:24 -0500
X-MC-Unique: BvXEXWlkMNi0VJFnY3x6TA-1
X-Mimecast-MFC-AGG-ID: BvXEXWlkMNi0VJFnY3x6TA_1793564243
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F9081800364
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1E60F30002CF
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CA20421E6890; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 13/56] qom/qmp: populate description & default-value in
 qom_property_info()
Date: Sun,  1 Nov 2026 21:16:34 +0100
Message-ID: <20261101201717.3911097-14-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Move description and default_value population from the individual QMP
handlers into qom_property_info(), so all callers get them.

This also adds description and default-value to qom-list responses,
which previously only returned name and type. The handler doesn't care.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qom/qom-qmp-cmds.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 47bf3bf293..84a2959051 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -35,6 +35,8 @@ static ObjectPropertyInfo *qom_property_info(ObjectProperty *prop)
 
     info->name = g_strdup(prop->name);
     info->type = g_strdup(prop->type);
+    info->description = g_strdup(prop->description);
+    info->default_value = qobject_ref(prop->defval);
     if (prop->qapi_type) {
         assert(prop->qapi_type->masked_name);
         info->qapi_type = g_strdup(prop->qapi_type->masked_name);
@@ -243,8 +245,6 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
 
     object_property_iter_init(&iter, obj);
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info;
-
         /* Skip Object and DeviceState properties */
         if (strcmp(prop->name, "type") == 0 ||
             strcmp(prop->name, "realized") == 0 ||
@@ -254,11 +254,7 @@ ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
             continue;
         }
 
-        info = qom_property_info(prop);
-        info->description = g_strdup(prop->description);
-        info->default_value = qobject_ref(prop->defval);
-
-        QAPI_LIST_PREPEND(prop_list, info);
+        QAPI_LIST_PREPEND(prop_list, qom_property_info(prop));
     }
 
     object_unref(obj);
@@ -295,12 +291,7 @@ ObjectPropertyInfoList *qmp_qom_list_properties(const char *typename,
         object_property_iter_init(&iter, obj);
     }
     while ((prop = object_property_iter_next(&iter))) {
-        ObjectPropertyInfo *info = qom_property_info(prop);
-
-        info->description = g_strdup(prop->description);
-        info->default_value = qobject_ref(prop->defval);
-
-        QAPI_LIST_PREPEND(prop_list, info);
+        QAPI_LIST_PREPEND(prop_list, qom_property_info(prop));
     }
 
     object_unref(obj);
-- 
2.55.0


