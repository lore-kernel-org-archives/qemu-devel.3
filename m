Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86255C27C54
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 14:31:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFE8K-0000xz-LY; Thu, 06 Jun 2024 10:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8G-0000mA-3o
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sFE8E-0000dL-0Q
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 10:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717684218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FUpBrgooZvG9jgmz1Pjev1l3L+B1Cacf4mMWQpHmpl0=;
 b=ihoUikcTeijdj5tR32Ii6iVV3xe9Pcts7Dc49Hmm3+DTC1LEevU2+B5BA8oJIbCE4vgbaQ
 nOjH8ecyT+zHH+JljoMufOZ7+ndaz0DDQZq00aMUHexoDIDX+7mR9LaQpPgZslgj/VkeA0
 yrxFkY519Bw+LK0JKwZEGHIrdF4a71Q=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-GRq-M0ioPf6xztLZ-1K8fw-1; Thu,
 06 Jun 2024 10:30:14 -0400
X-MC-Unique: GRq-M0ioPf6xztLZ-1K8fw-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF4D6193D8B4; Thu,  6 Jun 2024 14:30:13 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.217])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0230F195917B; Thu,  6 Jun 2024 14:30:12 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id E201318009A8; Thu,  6 Jun 2024 16:30:10 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH v3 1/4] qom: allow to mark objects as deprecated or not secure.
Date: Thu,  6 Jun 2024 16:30:07 +0200
Message-ID: <20240606143010.1318226-2-kraxel@redhat.com>
In-Reply-To: <20240606143010.1318226-1-kraxel@redhat.com>
References: <20240606143010.1318226-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Add flags to ObjectClass for objects which are deprecated or not secure.
Add 'deprecated' and 'not-secure' bools to ObjectTypeInfo, report in
'qom-list-types'.  Print the flags when listing devices via '-device
help'.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qom/object.h  | 3 +++
 qom/qom-qmp-cmds.c    | 8 ++++++++
 system/qdev-monitor.c | 8 ++++++++
 qapi/qom.json         | 8 +++++++-
 4 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 13d3a655ddf9..419bd9a4b219 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -136,6 +136,9 @@ struct ObjectClass
     ObjectUnparent *unparent;
 
     GHashTable *properties;
+
+    bool deprecated;
+    bool not_secure;
 };
 
 /**
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e91a2353472a..325ff0ba2a25 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -101,6 +101,14 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
     if (parent) {
         info->parent = g_strdup(object_class_get_name(parent));
     }
+    if (klass->deprecated) {
+        info->has_deprecated = true;
+        info->deprecated = true;
+    }
+    if (klass->not_secure) {
+        info->has_not_secure = true;
+        info->not_secure = true;
+    }
 
     QAPI_LIST_PREPEND(*pret, info);
 }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d667f..effdc95d21d3 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -144,6 +144,8 @@ static bool qdev_class_has_alias(DeviceClass *dc)
 
 static void qdev_print_devinfo(DeviceClass *dc)
 {
+    ObjectClass *klass = OBJECT_CLASS(dc);
+
     qemu_printf("name \"%s\"", object_class_get_name(OBJECT_CLASS(dc)));
     if (dc->bus_type) {
         qemu_printf(", bus %s", dc->bus_type);
@@ -157,6 +159,12 @@ static void qdev_print_devinfo(DeviceClass *dc)
     if (!dc->user_creatable) {
         qemu_printf(", no-user");
     }
+    if (klass->deprecated) {
+        qemu_printf(", deprecated");
+    }
+    if (klass->not_secure) {
+        qemu_printf(", not-secure");
+    }
     qemu_printf("\n");
 }
 
diff --git a/qapi/qom.json b/qapi/qom.json
index 8bd299265e39..3f20d4c6413b 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -163,10 +163,16 @@
 #
 # @parent: Name of parent type, if any (since 2.10)
 #
+# @deprecated: the type is deprecated (since 9.1)
+#
+# @not-secure: the type (typically a device) is not considered
+#     a security boundary (since 9.1)
+#
 # Since: 1.1
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
+  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str',
+            '*deprecated': 'bool', '*not-secure': 'bool' } }
 
 ##
 # @qom-list-types:
-- 
2.45.2


