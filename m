Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92CDD606A31C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=h3aatKch
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIp-0008IK-Mc; Thu, 26 Nov 2026 05:02:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIc-00089A-Hf
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIZ-0006hh-OU
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PHQZfw7/yqiv4DHK6LpdiOeHrxqcdzQGiY4buOVXSkU=;
 b=h3aatKchTj89JqxRLclXQFmFKHiAEIhRLD4P06CMRIbYZpyKn2aSlkfpvZWCSdAL67buG7
 GGccusSED/SCtarRvPkun8NDYwyWyCN0UIHWKSkuMFRJkCCLfrqVr6VyQMrl7YQ+HxjmgE
 6L6QnXL+Y0x7LLXNwCEAKc9h+Yb/Xtk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-VoSxaqbbMvWdxrO6V89DZQ-1; Thu,
 26 Nov 2026 10:01:46 +0000
X-MC-Unique: VoSxaqbbMvWdxrO6V89DZQ-1
X-Mimecast-MFC-AGG-ID: VoSxaqbbMvWdxrO6V89DZQ_1795687305
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4D34180063E; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63DD51801A60; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ECEC521E6890; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 13/16] qom: Extend ObjectPropertyValue so clients don't have
 to parse @type
Date: Thu, 26 Nov 2026 11:01:36 +0100
Message-ID: <20261126100139.3557890-14-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

ObjectPropertyValue member @type is "child<T>" for a child property of
QOM type T, and "link<T>" for a link property of QOM type T.  Such
encoding of information in strings should be avoided in QMP, because
it requires clients to parse the strings in addition to parse JSON.

Turn ObjectPropertyValue into a union with discriminator @kind and a
variant member @qom-type in branches "child" and "link".  This
provides the same information unencoded.

A later commit will deprecate @type.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qom.json      | 12 +++++++++---
 qom/qom-qmp-cmds.c |  9 +++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index ca74b652a0d..0b274787b3f 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -86,6 +86,8 @@
 #
 # @name: the name of the property.
 #
+# @kind: TODO
+#
 # @type: the type of the property, as described in
 #     `ObjectPropertyInfo`.
 #
@@ -101,11 +103,15 @@
 #
 # Since: 10.1
 ##
-{ 'struct': 'ObjectPropertyValue',
-  'data': { 'name': 'str',
+{ 'union': 'ObjectPropertyValue',
+  'base': { 'name': 'str',
+            'kind': 'ObjectPropertyKind',
             'type': 'str',
             'qapi-type': { 'type': 'str', 'features': [ 'unstable' ] },
-            '*value': 'any' } }
+            '*value': 'any' },
+  'discriminator': 'kind',
+  'data': { 'child': 'ObjectPropertyQomType',
+            'link': 'ObjectPropertyQomType' } }
 
 ##
 # @ObjectPropertiesValues:
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 2b491caaf7a..d2945d1efe0 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -97,6 +97,15 @@ static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
     QAPI_LIST_PREPEND(*props, item);
 
     item->name = g_strdup(prop->name);
+    if (object_property_is_child(prop)) {
+        item->kind = OBJECT_PROPERTY_KIND_CHILD;
+        item->u.child.qom_type = g_strdup(prop->qom_type);
+    } else if (object_property_is_link(prop)) {
+        item->kind = OBJECT_PROPERTY_KIND_LINK;
+        item->u.link.qom_type = g_strdup(prop->qom_type);
+    } else {
+        item->kind = OBJECT_PROPERTY_KIND_OTHER;
+    }
     item->type = g_strdup(prop->type);
     if (prop->qapi_type) {
         assert(prop->qapi_type->masked_name);
-- 
2.55.0


