Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E654C88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 16:06:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7Ece-00063O-Tt; Thu, 17 Sep 2026 12:06:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcV-0005sH-2T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x7EcP-0006t7-7Z
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 12:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789661148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mWjtgRPnsKG/TTE0wUI5Zo3PVF5E2wPwy4wEYJhNQHQ=;
 b=Gn1KelfFiViCvwPzDkVMMPLIE/VNLG8yrETR0K0/B1AcBzpiH1dgUfcyvJRM7xL8qkyn1W
 eJPofPU9hdMvyTHwvoBsiWkQXJSoBCuRyGW+nGrCzUBUTZhMt5ifnnbzXn1+IuRq4jBtnc
 ZHLvKVU7b3Werhn5ESVgu6Albsqerkk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-304-4pbjSA6WOZOvyMNvzD1B2w-1; Thu,
 17 Sep 2026 12:05:46 -0400
X-MC-Unique: 4pbjSA6WOZOvyMNvzD1B2w-1
X-Mimecast-MFC-AGG-ID: 4pbjSA6WOZOvyMNvzD1B2w_1789661145
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95A5B18301BF
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 16:05:45 +0000 (UTC)
Received: from berrange.csb (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 95F98300022B; Thu, 17 Sep 2026 16:05:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 11/14] qom: refactor data passing for QOM list filtering
Date: Thu, 17 Sep 2026 17:05:22 +0100
Message-ID: <20260917160525.1275388-12-berrange@redhat.com>
In-Reply-To: <20260917160525.1275388-1-berrange@redhat.com>
References: <20260917160525.1275388-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
index 330895361d4..b999e9f7238 100644
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


