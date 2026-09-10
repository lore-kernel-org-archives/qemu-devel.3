Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE23C79FB9
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:37:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4c9X-0003Be-TN; Thu, 10 Sep 2026 06:37:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c9X-000395-3Z
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c9U-0007iE-Dw
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789036627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayhgKrurP9uKIIxZOSsOToWEUcaVKB8ROFt2LR3a45Q=;
 b=Q36jG73elu7ZCdspjf+/Z5JWsKw/NUh6bidX+WXYou3+3BQmHu5mqWP4fLAWO5HQ1Pbo4A
 yU5I7TKy6YD0EmyLkAGnzkymj9dYIxvHz4lzR2C182fUPgfS5rB2VUCuAbc1jZSZmsxJeW
 i1XD3lBnCZvCVpIJeEH0V3DQzzpLX/4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-jdVlAD5eOva2XXGu3dV_fA-1; Thu,
 10 Sep 2026 06:37:03 -0400
X-MC-Unique: jdVlAD5eOva2XXGu3dV_fA-1
X-Mimecast-MFC-AGG-ID: jdVlAD5eOva2XXGu3dV_fA_1789036622
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5941D18005A6; Thu, 10 Sep 2026 10:37:02 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 18DD030001A2; Thu, 10 Sep 2026 10:36:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v4 11/14] qom: refactor data passing for QOM list filtering
Date: Thu, 10 Sep 2026 11:36:25 +0100
Message-ID: <20260910103628.2326622-12-berrange@redhat.com>
In-Reply-To: <20260910103628.2326622-1-berrange@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

Currently the QOM list method can filter on the abstract flag,
but extending the filtering to more variables requires a way
to pass in extra data items. This requires a refactoring of the
iterator to take a full struct as its opaque data item.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qom/qom-qmp-cmds.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 330895361d..b999e9f723 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -151,9 +151,13 @@ QObject *qmp_qom_get(const char *path, const char *property, Error **errp)
     return object_property_get_qobject(obj, property, errp);
 }
 
-static void qom_list_types_tramp(ObjectClass *klass, void *data)
+typedef struct {
+    ObjectTypeInfoList *list;
+} ObjectTypeInfoData;
+
+static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
 {
-    ObjectTypeInfoList **pret = data;
+    ObjectTypeInfoData *data = opaque;
     ObjectTypeInfo *info;
     ObjectClass *parent = object_class_get_parent(klass);
 
@@ -164,7 +168,7 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
         info->parent = g_strdup(object_class_get_name(parent));
     }
 
-    QAPI_LIST_PREPEND(*pret, info);
+    QAPI_LIST_PREPEND(data->list, info);
 }
 
 ObjectTypeInfoList *qmp_qom_list_types(const char *implements,
@@ -172,12 +176,14 @@ ObjectTypeInfoList *qmp_qom_list_types(const char *implements,
                                        bool abstract,
                                        Error **errp)
 {
-    ObjectTypeInfoList *ret = NULL;
+    ObjectTypeInfoData data = {
+        .list = NULL,
+    };
 
     module_load_qom_all();
-    object_class_foreach(qom_list_types_tramp, implements, abstract, &ret);
+    object_class_foreach(qom_list_types_tramp, implements, abstract, &data);
 
-    return ret;
+    return data.list;
 }
 
 ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
-- 
2.55.0


