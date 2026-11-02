Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D066079AB5
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MyQYOapE
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDf-0003RO-Am; Mon, 02 Nov 2026 09:41:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDB-0003D1-6v
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD8-0008SN-9R
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1vWrF76QyBOQJL9ArpPgVf9RSg+nebgYyjOi2LONmiw=;
 b=MyQYOapEEhEvLcn8BLfDN1LAKU0YWCUAh7kQS2qIVN60Lz68HpmL1+uB77PnpHdtt9Ein8
 xNBWuqbE6nEBiC1VTVyO4r7ZrbEVPR8k+YdK/KIdEaEnEWhXdENO/OQVOb6gN0xofSEz3c
 o3BTj3pwF9Qb67F4jXfnFuAghhPUFJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-mtR_1METNpaXlpZ7vXZVbg-1; Mon,
 02 Nov 2026 09:40:28 -0500
X-MC-Unique: mtR_1METNpaXlpZ7vXZVbg-1
X-Mimecast-MFC-AGG-ID: mtR_1METNpaXlpZ7vXZVbg_1793630427
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B714180A9D6; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 574D41803A51; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 69F6421E68A2; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 30/74] qom/qmp: populate description & default-value in
 qom_property_info()
Date: Mon,  2 Nov 2026 15:39:34 +0100
Message-ID: <20261102144018.3212223-31-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Message-ID: <20261101201717.3911097-14-armbru@redhat.com>
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


