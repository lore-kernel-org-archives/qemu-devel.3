Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE9B4C25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 09:56:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBtXz-0008AP-7Z; Tue, 28 May 2024 05:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtXw-000881-EB
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBtXu-0001RM-6g
 for qemu-devel@nongnu.org; Tue, 28 May 2024 05:55:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716890104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Md1MVArHUd05WOeyAIhNVCIfQzrbfrJLv5muxML0fkM=;
 b=E37cjacs/+U3gzCvacHES/9atABoeBKsmWtXY6oHBcRoYOaa42JpHu8zTEBKltEXKiIcst
 fagh1dcoMQ48GfISjKbY7PRTvz05s19pm801KZUlaR0wAsCFslheyJ/m2p5HRIM6Bg3ekA
 ENpmUl8/CDSEXfI6BYYYpG7N0IrLxiU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-CCX3byV-OxSXCRpd5gx7vw-1; Tue,
 28 May 2024 05:55:02 -0400
X-MC-Unique: CCX3byV-OxSXCRpd5gx7vw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0355B29AA390;
 Tue, 28 May 2024 09:55:02 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 738911C00047;
 Tue, 28 May 2024 09:55:00 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id DD0BC1800DCA; Tue, 28 May 2024 11:54:59 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 1/4] qom: allow to mark objects (including devices) as
 deprecated.
Date: Tue, 28 May 2024 11:54:56 +0200
Message-ID: <20240528095459.896594-2-kraxel@redhat.com>
In-Reply-To: <20240528095459.896594-1-kraxel@redhat.com>
References: <20240528095459.896594-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Add deprecation_note field (string) to ObjectClass.
Add deprecated bool to ObjectTypeInfo, report in 'qom-list-types'.
Print the note when listing devices via '-device help'.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qom/object.h  | 1 +
 qom/qom-qmp-cmds.c    | 4 ++++
 system/qdev-monitor.c | 5 +++++
 qapi/qom.json         | 4 +++-
 4 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 13d3a655ddf9..6c682aa0135f 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -136,6 +136,7 @@ struct ObjectClass
     ObjectUnparent *unparent;
 
     GHashTable *properties;
+    const char *deprecation_note;
 };
 
 /**
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index e91a2353472a..43de9c9ae141 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -101,6 +101,10 @@ static void qom_list_types_tramp(ObjectClass *klass, void *data)
     if (parent) {
         info->parent = g_strdup(object_class_get_name(parent));
     }
+    if (klass->deprecation_note) {
+        info->has_deprecated = true;
+        info->deprecated = true;
+    }
 
     QAPI_LIST_PREPEND(*pret, info);
 }
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 6af6ef7d667f..704be312e1a7 100644
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
@@ -157,6 +159,9 @@ static void qdev_print_devinfo(DeviceClass *dc)
     if (!dc->user_creatable) {
         qemu_printf(", no-user");
     }
+    if (klass->deprecation_note) {
+        qemu_printf(", deprecated \"%s\"", klass->deprecation_note);
+    }
     qemu_printf("\n");
 }
 
diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785ac..bd062feabaf7 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -163,10 +163,12 @@
 #
 # @parent: Name of parent type, if any (since 2.10)
 #
+# @deprecated: the type is deprecated (since 9.1)
+#
 # Since: 1.1
 ##
 { 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
+  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str', '*deprecated': 'bool' } }
 
 ##
 # @qom-list-types:
-- 
2.45.1


