Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A21C79F9F
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2026 10:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4c9b-0003LX-5s; Thu, 10 Sep 2026 06:37:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c9Z-0003DF-1h
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1x4c9W-0007lU-Se
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 06:37:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789036630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9zjeL7Bi7S8pfI44ZpjgUyiYQRHPvAE+LawV2R0Z6t4=;
 b=QLCP80KYV9WfgL02uV429pDD4RRltQEckQH1r0kuPB9h9dr/JSw1ACl5qA1i5AFceNUDwk
 Ca9J1F50JovSMnnewNHN1exU7si1Dj2Y3aHo2VNyETZ113mbpmktDExYpqjWgbo5mc0e6a
 UqUeCHab75oPJBWoTCkRqk0zUbdCCkI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-1QNP8SEnPr2wCb0X2DCclQ-1; Thu,
 10 Sep 2026 06:37:07 -0400
X-MC-Unique: 1QNP8SEnPr2wCb0X2DCclQ-1
X-Mimecast-MFC-AGG-ID: 1QNP8SEnPr2wCb0X2DCclQ_1789036626
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E12031954223; Thu, 10 Sep 2026 10:37:05 +0000 (UTC)
Received: from berrange.csb (headnet03.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BABF530001A2; Thu, 10 Sep 2026 10:37:02 +0000 (UTC)
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
Subject: [PATCH v4 12/14] qom: report & filter on security status in
 qom-list-types
Date: Thu, 10 Sep 2026 11:36:26 +0100
Message-ID: <20260910103628.2326622-13-berrange@redhat.com>
In-Reply-To: <20260910103628.2326622-1-berrange@redhat.com>
References: <20260910103628.2326622-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This adds:

 * a new boolean 'secure' field to the type info returned by
   qom-list-types, which will be set if the type provides a
   security boundary

 * a new boolean 'secure' parameter to the arguments of
   qom-list-types, which can be used to filter types based
   on their security status

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/qom.json      | 13 +++++++++++--
 qom/qom-qmp-cmds.c | 12 ++++++++++++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4a9b7f9088..5895c97750 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -210,12 +210,18 @@
 # @abstract: the type is abstract and can't be directly instantiated.
 #     Omitted if false.  (since 2.10)
 #
+# @secure: the type provides a security boundary.  Omitted if false.
+#     (since 11.2)
+#
 # @parent: Name of parent type, if any (since 2.10)
 #
 # Since: 1.1
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
+  'data': { 'name': 'str',
+            '*abstract': 'bool',
+            '*parent': 'str',
+            '*secure': 'bool' } }
 
 ##
 # @qom-list-types:
@@ -227,12 +233,15 @@
 #
 # @abstract: if true, include abstract types in the results
 #
+# @secure: if set, filter to only include types with matching security
+#     status (since 11.2)
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
index b999e9f723..9474a1b04b 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -153,6 +153,8 @@ QObject *qmp_qom_get(const char *path, const char *property, Error **errp)
 
 typedef struct {
     ObjectTypeInfoList *list;
+    bool has_secure;
+    bool secure;
 } ObjectTypeInfoData;
 
 static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
@@ -161,9 +163,15 @@ static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
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
@@ -174,10 +182,14 @@ static void qom_list_types_tramp(ObjectClass *klass, void *opaque)
 ObjectTypeInfoList *qmp_qom_list_types(const char *implements,
                                        bool has_abstract,
                                        bool abstract,
+                                       bool has_secure,
+                                       bool secure,
                                        Error **errp)
 {
     ObjectTypeInfoData data = {
         .list = NULL,
+        .has_secure = has_secure,
+        .secure = secure,
     };
 
     module_load_qom_all();
-- 
2.55.0


