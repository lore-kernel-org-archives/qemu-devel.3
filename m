Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5C52C25B5F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:05:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7m-0002zK-0Z; Mon, 06 May 2024 07:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7a-0002lJ-T9
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7X-0003el-72
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nyVLHeduWKWXEcXc63nmjHd8vIqUBrwtESlJ8J+9mrE=;
 b=jKcSxXcgQwSHvoGDOS5shKzkhoiFKhbjjqZSpO2dLRAxnUuY2dsyiXS/HKg1bPuGTvBufg
 wmqOiyD32U6uXguTf7BdH6/tWvN/tBT0j53nnr5F8E9yQmhPGfHRY7mPhWz6C6dR0SWRNU
 Fkalgsm8VuZL00ZP3gyzMncBGcSE8TY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-111-TFMCNSlzOlOcjxevfjiX3w-1; Mon, 06 May 2024 07:02:57 -0400
X-MC-Unique: TFMCNSlzOlOcjxevfjiX3w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 92B2918065AD;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58036C13FA1;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 44D0521E6142; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 3/7] qapi: Rename visitor parameter @variants to @alternatives
Date: Mon,  6 May 2024 13:02:45 +0200
Message-ID: <20240506110254.3965097-6-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A previous commit narrowed the type of .visit_alternate_type()
parameter @variants from QAPISchemaVariants to QAPISchemaAlternatives.
Rename it to @alternatives.

One of them passes @alternatives to helper function
gen_visit_alternate().  Rename its @variants parameter to
@alternatives as well.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py         | 3 ++-
 scripts/qapi/introspect.py     | 4 ++--
 scripts/qapi/schema.py         | 2 +-
 scripts/qapi/types.py          | 4 ++--
 scripts/qapi/visit.py          | 9 +++++----
 tests/qapi-schema/test-qapi.py | 5 +++--
 6 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 71362ba929..f270b494f0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -318,7 +318,8 @@ def visit_object_type(self, name, info, ifcond, features,
                       + self._nodes_for_sections(doc)
                       + self._nodes_for_if_section(ifcond))
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self, name, info, ifcond, features,
+                             alternatives):
         doc = self._cur_doc
         self._add_doc('Alternate',
                       self._nodes_for_members(doc, 'Members')
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 7852591490..86c075a6ad 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -348,12 +348,12 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
     def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaAlternatives) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         self._gen_tree(
             name, 'alternate',
             {'members': [Annotated({'type': self._use_type(m.type)},
                                    m.ifcond)
-                         for m in variants.variants]},
+                         for m in alternatives.variants]},
             ifcond, features
         )
 
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 65c82dd4f1..2b67992aee 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -236,7 +236,7 @@ def visit_alternate_type(
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
         features: List[QAPISchemaFeature],
-        variants: QAPISchemaAlternatives,
+        alternatives: QAPISchemaAlternatives,
     ) -> None:
         pass
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 0abb78f3a8..69f5f6ffd0 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -371,11 +371,11 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaAlternatives) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_object(name, ifcond, None,
-                                  [variants.tag_member], variants))
+                                  [alternatives.tag_member], alternatives))
         with ifcontext(ifcond, self._genh, self._genc):
             self._gen_type_cleanup(name)
 
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index fbae5f3e4e..e766acaac9 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -223,7 +223,8 @@ def gen_visit_enum(name: str) -> str:
                  c_name=c_name(name))
 
 
-def gen_visit_alternate(name: str, variants: QAPISchemaAlternatives) -> str:
+def gen_visit_alternate(name: str,
+                        alternatives: QAPISchemaAlternatives) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -245,7 +246,7 @@ def gen_visit_alternate(name: str, variants: QAPISchemaAlternatives) -> str:
 ''',
                 c_name=c_name(name))
 
-    for var in variants.variants:
+    for var in alternatives.variants:
         ret += var.ifcond.gen_if()
         ret += mcgen('''
     case %(case)s:
@@ -414,10 +415,10 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaAlternatives) -> None:
+                             alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
-            self._genc.add(gen_visit_alternate(name, variants))
+            self._genc.add(gen_visit_alternate(name, alternatives))
 
 
 def gen_visit(schema: QAPISchema,
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 7c67ad8d9b..7e3f9f4aa1 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -61,9 +61,10 @@ def visit_object_type(self, name, info, ifcond, features,
         self._print_if(ifcond)
         self._print_features(features)
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(self, name, info, ifcond, features,
+                             alternatives):
         print('alternate %s' % name)
-        self._print_variants(variants)
+        self._print_variants(alternatives)
         self._print_if(ifcond)
         self._print_features(features)
 
-- 
2.44.0


