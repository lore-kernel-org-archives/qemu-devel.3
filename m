Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2D35C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:44:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqbj-0003dr-Ti; Wed, 20 Mar 2024 03:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbh-0003cz-LB
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbe-0007dp-9b
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710920605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0/j5TE8Lyq+FPO3SzQoooNeZKB8trHQeFnP3lvDKCyM=;
 b=imxamz4wl5RwjXFWioX9MgJpNu2EOs5Toh/knpMdWMRIpSQGvtiMreSROwVmOgVl3p/qAg
 K9eJX+3MRL4DIPnagf2C+7Uu02zBHt8a1j4US7myRi2T9MKP2AL9WuFAX10We4W7XcBuaN
 OKm9XUfI0OFFoAzaSkyzW9UpIQyJg/I=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-474-Q_fp_F7HMcC_nCsiaMWItw-1; Wed,
 20 Mar 2024 03:43:22 -0400
X-MC-Unique: Q_fp_F7HMcC_nCsiaMWItw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DAB492807D64;
 Wed, 20 Mar 2024 07:43:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9967B1C060A6;
 Wed, 20 Mar 2024 07:43:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9BD3421E692E; Wed, 20 Mar 2024 08:43:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH 2/7] qapi: Rename visitor parameter @variants to @branches
Date: Wed, 20 Mar 2024 08:43:10 +0100
Message-ID: <20240320074315.23167-3-armbru@redhat.com>
In-Reply-To: <20240320074315.23167-1-armbru@redhat.com>
References: <20240320074315.23167-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
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

The previous commit narrowed the type of .visit_object_type()
parameter @variants from QAPISchemaVariants to QAPISchemaBranches.
Rename it to @branches.

Same for .visit_object_type_flat().

A few of these pass @branches to helper functions:
QAPISchemaGenRSTVisitor.visit_object_type() to ._nodes_for_members()
and ._nodes_for_variant_when(), and
QAPISchemaGenVisitVisitor.visit_object_type() to
gen_visit_object_members().  Rename the helpers' @variants parameters
to @branches as well.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py         | 18 +++++++++---------
 scripts/qapi/introspect.py     |  8 ++++----
 scripts/qapi/schema.py         |  4 ++--
 scripts/qapi/types.py          |  4 ++--
 scripts/qapi/visit.py          | 12 ++++++------
 tests/qapi-schema/test-qapi.py |  4 ++--
 6 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8d428c64b0..71362ba929 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -145,22 +145,22 @@ def _nodes_for_one_member(self, member):
             term.extend(self._nodes_for_ifcond(member.ifcond))
         return term
 
-    def _nodes_for_variant_when(self, variants, variant):
+    def _nodes_for_variant_when(self, branches, variant):
         """Return list of Text, literal nodes for variant 'when' clause
 
         Return a list of doctree nodes which give text like
         'when tagname is variant (If: ...)' suitable for use in
-        the 'variants' part of a definition list.
+        the 'branches' part of a definition list.
         """
         term = [nodes.Text(' when '),
-                nodes.literal('', variants.tag_member.name),
+                nodes.literal('', branches.tag_member.name),
                 nodes.Text(' is '),
                 nodes.literal('', '"%s"' % variant.name)]
         if variant.ifcond.is_present():
             term.extend(self._nodes_for_ifcond(variant.ifcond))
         return term
 
-    def _nodes_for_members(self, doc, what, base=None, variants=None):
+    def _nodes_for_members(self, doc, what, base=None, branches=None):
         """Return list of doctree nodes for the table of members"""
         dlnode = nodes.definition_list()
         for section in doc.args.values():
@@ -178,14 +178,14 @@ def _nodes_for_members(self, doc, what, base=None, variants=None):
                                          nodes.literal('', base.doc_type())],
                                         None)
 
-        if variants:
-            for v in variants.variants:
+        if branches:
+            for v in branches.variants:
                 if v.type.name == 'q_empty':
                     continue
                 assert not v.type.is_implicit()
                 term = [nodes.Text('The members of '),
                         nodes.literal('', v.type.doc_type())]
-                term.extend(self._nodes_for_variant_when(variants, v))
+                term.extend(self._nodes_for_variant_when(branches, v))
                 dlnode += self._make_dlitem(term, None)
 
         if not dlnode.children:
@@ -308,12 +308,12 @@ def visit_enum_type(self, name, info, ifcond, features, members, prefix):
                       + self._nodes_for_if_section(ifcond))
 
     def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
+                          base, members, branches):
         doc = self._cur_doc
         if base and base.is_implicit():
             base = None
         self._add_doc('Object',
-                      self._nodes_for_members(doc, 'Members', base, variants)
+                      self._nodes_for_members(doc, 'Members', base, branches)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
                       + self._nodes_for_if_section(ifcond))
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index b866517942..7852591490 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -336,13 +336,13 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
                                ifcond: QAPISchemaIfCond,
                                features: List[QAPISchemaFeature],
                                members: List[QAPISchemaObjectTypeMember],
-                               variants: Optional[QAPISchemaBranches]) -> None:
+                               branches: Optional[QAPISchemaBranches]) -> None:
         obj: SchemaInfoObject = {
             'members': [self._gen_object_member(m) for m in members]
         }
-        if variants:
-            obj['tag'] = variants.tag_member.name
-            obj['variants'] = [self._gen_variant(v) for v in variants.variants]
+        if branches:
+            obj['tag'] = branches.tag_member.name
+            obj['variants'] = [self._gen_variant(v) for v in branches.variants]
         self._gen_tree(name, 'object', obj, ifcond, features)
 
     def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 5cdedfc2c8..65c82dd4f1 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -215,7 +215,7 @@ def visit_object_type(
         features: List[QAPISchemaFeature],
         base: Optional[QAPISchemaObjectType],
         members: List[QAPISchemaObjectTypeMember],
-        variants: Optional[QAPISchemaBranches],
+        branches: Optional[QAPISchemaBranches],
     ) -> None:
         pass
 
@@ -226,7 +226,7 @@ def visit_object_type_flat(
         ifcond: QAPISchemaIfCond,
         features: List[QAPISchemaFeature],
         members: List[QAPISchemaObjectTypeMember],
-        variants: Optional[QAPISchemaBranches],
+        branches: Optional[QAPISchemaBranches],
     ) -> None:
         pass
 
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 23cdf3e83e..0abb78f3a8 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -350,13 +350,13 @@ def visit_object_type(self,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
-                          variants: Optional[QAPISchemaBranches]) -> None:
+                          branches: Optional[QAPISchemaBranches]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
-        self._genh.add(gen_object(name, ifcond, base, members, variants))
+        self._genh.add(gen_object(name, ifcond, base, members, branches))
         with ifcontext(ifcond, self._genh, self._genc):
             if base and not base.is_implicit():
                 self._genh.add(gen_upcast(name, base))
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 746735e013..cbaec4cf90 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -64,7 +64,7 @@ def gen_visit_members_decl(name: str) -> str:
 def gen_visit_object_members(name: str,
                              base: Optional[QAPISchemaObjectType],
                              members: List[QAPISchemaObjectTypeMember],
-                             variants: Optional[QAPISchemaBranches]) -> str:
+                             branches: Optional[QAPISchemaBranches]) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
@@ -132,8 +132,8 @@ def gen_visit_object_members(name: str,
 ''')
         ret += memb.ifcond.gen_endif()
 
-    if variants:
-        tag_member = variants.tag_member
+    if branches:
+        tag_member = branches.tag_member
         assert isinstance(tag_member.type, QAPISchemaEnumType)
 
         ret += mcgen('''
@@ -141,7 +141,7 @@ def gen_visit_object_members(name: str,
 ''',
                      c_name=c_name(tag_member.name))
 
-        for var in variants.variants:
+        for var in branches.variants:
             case_str = c_enum_const(tag_member.type.name, var.name,
                                     tag_member.type.prefix)
             ret += var.ifcond.gen_if()
@@ -395,14 +395,14 @@ def visit_object_type(self,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
-                          variants: Optional[QAPISchemaBranches]) -> None:
+                          branches: Optional[QAPISchemaBranches]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_members_decl(name))
             self._genc.add(gen_visit_object_members(name, base,
-                                                    members, variants))
+                                                    members, branches))
             # TODO Worth changing the visitor signature, so we could
             # directly use rather than repeat type.is_implicit()?
             if not name.startswith('q_'):
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 40095431ae..7c67ad8d9b 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -48,7 +48,7 @@ def visit_array_type(self, name, info, ifcond, element_type):
         self._print_if(ifcond)
 
     def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
+                          base, members, branches):
         print('object %s' % name)
         if base:
             print('    base %s' % base.name)
@@ -57,7 +57,7 @@ def visit_object_type(self, name, info, ifcond, features,
                   % (m.name, m.type.name, m.optional))
             self._print_if(m.ifcond, 8)
             self._print_features(m.features, indent=8)
-        self._print_variants(variants)
+        self._print_variants(branches)
         self._print_if(ifcond)
         self._print_features(features)
 
-- 
2.44.0


