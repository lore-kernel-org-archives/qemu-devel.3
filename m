Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD64606A323
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 10:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QiyiOM8a
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWWIk-0008HD-2T; Thu, 26 Nov 2026 05:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIb-00088r-1O
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xWWIX-0006h4-Ol
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 05:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795687308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sgoE5hergT1p/ZNK1JULh8bOWlKP4+wYeuMAe1n/dZo=;
 b=QiyiOM8aNkUcXI/KJjNobloj/iXmZQHnv/cNqVjoa/dJ2cnvTvgdoSb0V3UpeTlrVKnMq0
 u6XiGvhTB8Lez+q9MgE9h6B8fA0QWD9KLkWG9ymG9nSnJF8dvTiCosUtP4egkmO1haMF9n
 mHvCG/zhGAKH/zGMGUsI8v1JUAsquTA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-621-C-2K1QWPP6q2pPJXBlDafw-1; Thu,
 26 Nov 2026 10:01:46 +0000
X-MC-Unique: C-2K1QWPP6q2pPJXBlDafw-1
X-Mimecast-MFC-AGG-ID: C-2K1QWPP6q2pPJXBlDafw_1795687305
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80AC51800625; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E42A1956086; Thu, 26 Nov 2026 10:01:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E4D7421E688B; Thu, 26 Nov 2026 11:01:39 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 jsnow@redhat.com, crosa@redhat.com, eblake@redhat.com,
 devel@lists.libvirt.org
Subject: [PATCH 11/16] tests: Wean off ObjectPropertyInfo member @type
Date: Thu, 26 Nov 2026 11:01:34 +0100
Message-ID: <20261126100139.3557890-12-armbru@redhat.com>
In-Reply-To: <20261126100139.3557890-1-armbru@redhat.com>
References: <20261126100139.3557890-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

Use members @kind and @qom-type instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qtest/device-introspect-test.c | 4 ++--
 tests/qtest/qom-test.c               | 4 ++--
 tests/qtest/readconfig-test.c        | 5 +++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index f6eca2c8eb7..60afdbbc9d0 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -120,8 +120,8 @@ static void qom_tree_walk(QTestState *qts, const char *path, GString *result)
 
     QLIST_FOREACH_ENTRY(list, e) {
         QDict *prop = qobject_to(QDict, qlist_entry_obj(e));
-        const char *type = qdict_get_str(prop, "type");
-        if (g_str_has_prefix(type, "child<")) {
+        const char *kind = qdict_get_str(prop, "kind");
+        if (!strcmp(kind, "child")) {
             const char *name = qdict_get_str(prop, "name");
             children = g_list_prepend(children, g_strdup(name));
         }
diff --git a/tests/qtest/qom-test.c b/tests/qtest/qom-test.c
index cf4c6b5add5..6f1e9606c5e 100644
--- a/tests/qtest/qom-test.c
+++ b/tests/qtest/qom-test.c
@@ -148,8 +148,8 @@ static void test_properties(QTestState *qts, const char *path, bool recurse)
     list = qobject_to(QList, qdict_get(response, "return"));
     QLIST_FOREACH_ENTRY(list, entry) {
         tuple = qobject_to(QDict, qlist_entry_obj(entry));
-        bool is_child = strstart(qdict_get_str(tuple, "type"), "child<", NULL);
-        bool is_link = strstart(qdict_get_str(tuple, "type"), "link<", NULL);
+        bool is_child = !strcmp(qdict_get_str(tuple, "kind"), "child");
+        bool is_link = !strcmp(qdict_get_str(tuple, "kind"), "link");
 
         if (is_child || is_link) {
             child_path = g_strdup_printf("%s/%s",
diff --git a/tests/qtest/readconfig-test.c b/tests/qtest/readconfig-test.c
index c6f32a4e144..7e473f98ee0 100644
--- a/tests/qtest/readconfig-test.c
+++ b/tests/qtest/readconfig-test.c
@@ -132,7 +132,6 @@ static void test_object_available(QObject *res, const char *name,
     ObjectPropertyInfoList *tmp;
     ObjectPropertyInfo *obj;
     bool object_available = false;
-    g_autofree char *childtype = g_strdup_printf("child<%s>", type);
 
     g_assert(res);
     v = qobject_input_visitor_new(res);
@@ -144,7 +143,9 @@ static void test_object_available(QObject *res, const char *name,
         g_assert(tmp->value);
 
         obj = tmp->value;
-        if (g_str_equal(obj->name, name) && g_str_equal(obj->type, childtype)) {
+        if (g_str_equal(obj->name, name)
+            && obj->kind == OBJECT_PROPERTY_KIND_CHILD
+            && g_str_equal(obj->u.child.qom_type, type)) {
             object_available = true;
             break;
         }
-- 
2.55.0


