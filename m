Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DC8DCAC5B9
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 14:09:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v292Y-0006Op-G3; Fri, 26 Sep 2025 10:03:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292W-0006Oc-Vc
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v292P-0004j9-CP
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 10:03:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758895382;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7X4SWOuaRnjqI3c2+gQUnYmt1B06XZVz+IyxcK6V2i0=;
 b=GtE1sVNbkRAa/+MuC0MXkLb+S1XXOgCz0zwoJc0kvVGeA0bplgFumrxZgLWGBEOXIvmCFV
 vfcn/NIlgutyGIWQumeapYj0H1YEjUrTcIpY/x9SCC7LQxlzLbfPExHBu3/Hz5zjxCvT5/
 17Cgex+XzyhjIhrkGiKsLfODZo8NzIY=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-261-Ynb7ThTtPBGkJZLqQxTOcw-1; Fri,
 26 Sep 2025 10:02:58 -0400
X-MC-Unique: Ynb7ThTtPBGkJZLqQxTOcw-1
X-Mimecast-MFC-AGG-ID: Ynb7ThTtPBGkJZLqQxTOcw_1758895377
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 311D718005B0; Fri, 26 Sep 2025 14:02:50 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.175])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C8D0E1953957; Fri, 26 Sep 2025 14:02:41 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v2 11/32] qom: report & filter on security status in
 qom-list-types
Date: Fri, 26 Sep 2025 15:01:22 +0100
Message-ID: <20250926140144.1998694-12-berrange@redhat.com>
In-Reply-To: <20250926140144.1998694-1-berrange@redhat.com>
References: <20250926140144.1998694-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

This adds:

 * a new boolean 'secure' field to the type info returned by
   qom-list-types, which will be set if the type provides a
   security boundary

 * a new boolean 'secure' parameter to the arguments of
   qom-list-types, which can be used to filter types based
   on their security status

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/qom.json      | 10 ++++++++--
 qom/qom-qmp-cmds.c | 30 ++++++++++++++++++++++++------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 830cb2ffe7..3e5e7e6f6f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -210,12 +210,15 @@
 # @abstract: the type is abstract and can't be directly instantiated.
 #     Omitted if false.  (since 2.10)
 #
+# @secure: the type provides a security boundary.
+#     Omitted if false.  (since 10.2)
+#
 # @parent: Name of parent type, if any (since 2.10)
 #
 # Since: 1.1
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
+  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str', '*secure': 'bool' } }
 
 ##
 # @qom-list-types:
@@ -227,12 +230,15 @@
 #
 # @abstract: if true, include abstract types in the results
 #
+# @secure: if set, filter to only include types with matching security status
+#     (since 10.2)
+#
 # Returns: a list of types, or an empty list if no results are found
 #
 # Since: 1.1
 ##
 { 'command': 'qom-list-types',
-  'data': { '*implements': 'str', '*abstract': 'bool' },
+  'data': { '*implements': 'str', '*abstract': 'bool', '*secure': 'bool' },
   'returns': [ 'ObjectTypeInfo' ],
   'allow-preconfig': true }
 
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 57f1898cf6..9e221bb332 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -151,33 +151,51 @@ QObject *qmp_qom_get(const char *path, const char *property, Error **errp)
     return object_property_get_qobject(obj, property, errp);
 }
 
-static void qom_list_types_tramp(ObjectClass *klass, void *data)
+typedef struct {
+    ObjectTypeInfoList *list;
+    bool has_secure;
+    bool secure;
+} ObjectTypeInfoData;
+
+static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
 {
-    ObjectTypeInfoList **pret = data;
+    ObjectTypeInfoData *data = opaque;
     ObjectTypeInfo *info;
     ObjectClass *parent = object_class_get_parent(klass);
 
+    if (data->has_secure &&
+        data->secure != object_class_is_secure(klass)) {
+        return;
+    }
+
     info = g_malloc0(sizeof(*info));
     info->name = g_strdup(object_class_get_name(klass));
     info->has_abstract = info->abstract = object_class_is_abstract(klass);
+    info->has_secure = info->secure = object_class_is_secure(klass);
     if (parent) {
         info->parent = g_strdup(object_class_get_name(parent));
     }
 
-    QAPI_LIST_PREPEND(*pret, info);
+    QAPI_LIST_PREPEND(data->list, info);
 }
 
 ObjectTypeInfoList *qmp_qom_list_types(const char *implements,
                                        bool has_abstract,
                                        bool abstract,
+                                       bool has_secure,
+                                       bool secure,
                                        Error **errp)
 {
-    ObjectTypeInfoList *ret = NULL;
+    ObjectTypeInfoData data = {
+        .list = NULL,
+        .has_secure = has_secure,
+        .secure = secure,
+    };
 
     module_load_qom_all();
-    object_class_foreach(qom_list_types_tramp, implements, abstract, &ret);
+    object_class_foreach(qom_list_types_tramp, implements, abstract, &data);
 
-    return ret;
+    return data.list;
 }
 
 ObjectPropertyInfoList *qmp_device_list_properties(const char *typename,
-- 
2.50.1


