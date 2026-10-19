Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4603ACCF2E9
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoDd-0002OA-W5; Mon, 19 Oct 2026 10:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDH-0002CL-8y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDF-0005YB-13
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7RNZYnm+eF4OzlPujJSw4fjnHCyCQO0WFgeUq72Aac=;
 b=Yi8kSPmfx2QTOFzXWoP9/Ift4qhJVa+azdvaHJnk9IJ3QDuSI2pH3XqDvP4s7xdxBUUV5i
 NxSkc2WJ1+w/mjuLoLR/FAlYcEljsJnWxt9CE03NMOzy50N6sXK2RIern8VN/dK+UM1XOx
 K42Y3WnT7OUp0yJck3XgbdP1CBZ/mvQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-8utdj7Z_MbGJbAuQA2qqvw-1; Mon,
 19 Oct 2026 14:19:36 +0000
X-MC-Unique: 8utdj7Z_MbGJbAuQA2qqvw-1
X-Mimecast-MFC-AGG-ID: 8utdj7Z_MbGJbAuQA2qqvw_1792419575
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E65F1800EF5; Mon, 19 Oct 2026 14:19:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C0397D8; Mon, 19 Oct 2026 14:19:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A909721E6892; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 14/65] qom/qmp: populate description & default-value in
 qom_property_info()
Date: Mon, 19 Oct 2026 16:18:38 +0200
Message-ID: <20261019141929.1594337-15-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


