Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82D93C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKrP-0008QQ-35; Mon, 14 Jul 2025 11:12:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUs-0000Rp-FQ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUY-0003dY-0E
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500712;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GeiJhC/nSM/BlyEgZ8Zd30VgEpD06uF5OTd6MpMSpLo=;
 b=N+kufWct38/UKAVH2Yn1P6Xbu3Q47RlyPHrI4Ey+bbpJwWknV4mNWvqvxeSkUeN2TqSQ4p
 RpRzsIpqOIDNdx+f9xuDKMcSR7DfrLIVgHi81DqDrig+qY74eH8vIwvTrq9rGt+5YGYbMH
 SsI7U6LGfZf+ZODMn8dDMgmwqi4wcRE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-586-_CdVPNGcMwSgRu9IsvrhMg-1; Mon,
 14 Jul 2025 09:45:11 -0400
X-MC-Unique: _CdVPNGcMwSgRu9IsvrhMg-1
X-Mimecast-MFC-AGG-ID: _CdVPNGcMwSgRu9IsvrhMg_1752500709
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E03E195608E; Mon, 14 Jul 2025 13:45:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A613A1800264; Mon, 14 Jul 2025 13:45:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3890521E60FC; Mon, 14 Jul 2025 15:44:59 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Steve Sistare <steven.sistare@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 30/32] qom: qom-list-get
Date: Mon, 14 Jul 2025 15:44:56 +0200
Message-ID: <20250714134458.2991097-31-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Steve Sistare <steven.sistare@oracle.com>

Using qom-list and qom-get to get all the nodes and property values in
a QOM tree can take multiple seconds because it requires 1000's of
individual QOM requests.  Some managers fetch the entire tree or a
large subset of it when starting a new VM, and this cost is a
substantial fraction of start up time.

Define the qom-list-get command, which fetches all the properties and
values for a list of paths.  This can be much faster than qom-list
plus qom-get.  When getting an entire QOM tree, I measured a 10x
speedup in elapsed time.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <1752248703-217318-2-git-send-email-steven.sistare@oracle.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi/qom.json      | 50 +++++++++++++++++++++++++++++++++++++++++++
 qom/qom-qmp-cmds.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 103 insertions(+)

diff --git a/qapi/qom.json b/qapi/qom.json
index 4e85baae47..687714e2ef 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -47,6 +47,34 @@
             '*description': 'str',
             '*default-value': 'any' } }
 
+##
+# @ObjectPropertyValue:
+#
+# @name: the name of the property.
+#
+# @type: the type of the property, as described in `ObjectPropertyInfo`.
+#
+# @value: the value of the property.  Absent when the property cannot
+#     be read.
+#
+# Since 10.1
+##
+{ 'struct': 'ObjectPropertyValue',
+  'data': { 'name': 'str',
+            'type': 'str',
+            '*value': 'any' } }
+
+##
+# @ObjectPropertiesValues:
+#
+# @properties: a list of properties.
+#
+# Since 10.1
+##
+{ 'struct': 'ObjectPropertiesValues',
+  'data': { 'properties': [ 'ObjectPropertyValue' ] }}
+
+
 ##
 # @qom-list:
 #
@@ -124,6 +152,28 @@
   'returns': 'any',
   'allow-preconfig': true }
 
+##
+# @qom-list-get:
+#
+# List properties and their values for each object path in the input
+# list.
+#
+# @paths: The absolute or partial path for each object, as described
+#     in `qom-get`.
+#
+# Errors:
+#     - If any path is not valid or is ambiguous
+#
+# Returns: A list where each element is the result for the
+#     corresponding element of @paths.
+#
+# Since 10.1
+##
+{ 'command': 'qom-list-get',
+  'data': { 'paths': [ 'str' ] },
+  'returns': [ 'ObjectPropertiesValues' ],
+  'allow-preconfig': true }
+
 ##
 # @qom-set:
 #
diff --git a/qom/qom-qmp-cmds.c b/qom/qom-qmp-cmds.c
index 293755f409..57f1898cf6 100644
--- a/qom/qom-qmp-cmds.c
+++ b/qom/qom-qmp-cmds.c
@@ -69,6 +69,59 @@ ObjectPropertyInfoList *qmp_qom_list(const char *path, Error **errp)
     return props;
 }
 
+static void qom_list_add_property_value(Object *obj, ObjectProperty *prop,
+                                        ObjectPropertyValueList **props)
+{
+    ObjectPropertyValue *item = g_new0(ObjectPropertyValue, 1);
+
+    QAPI_LIST_PREPEND(*props, item);
+
+    item->name = g_strdup(prop->name);
+    item->type = g_strdup(prop->type);
+    item->value = object_property_get_qobject(obj, prop->name, NULL);
+}
+
+static ObjectPropertyValueList *qom_get_property_value_list(const char *path,
+                                                            Error **errp)
+{
+    Object *obj;
+    ObjectProperty *prop;
+    ObjectPropertyIterator iter;
+    ObjectPropertyValueList *props = NULL;
+
+    obj = qom_resolve_path(path, errp);
+    if (obj == NULL) {
+        return NULL;
+    }
+
+    object_property_iter_init(&iter, obj);
+    while ((prop = object_property_iter_next(&iter))) {
+        qom_list_add_property_value(obj, prop, &props);
+    }
+
+    return props;
+}
+
+ObjectPropertiesValuesList *qmp_qom_list_get(strList *paths, Error **errp)
+{
+    ObjectPropertiesValuesList *head = NULL, **tail = &head;
+    strList *path;
+
+    for (path = paths; path; path = path->next) {
+        ObjectPropertiesValues *item = g_new0(ObjectPropertiesValues, 1);
+
+        QAPI_LIST_APPEND(tail, item);
+
+        item->properties = qom_get_property_value_list(path->value, errp);
+        if (!item->properties) {
+            qapi_free_ObjectPropertiesValuesList(head);
+            return NULL;
+        }
+    }
+
+    return head;
+}
+
 void qmp_qom_set(const char *path, const char *property, QObject *value,
                  Error **errp)
 {
-- 
2.49.0


