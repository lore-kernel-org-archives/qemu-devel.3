Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28796CD11DB
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqbg-0003cM-Md; Wed, 20 Mar 2024 03:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbf-0003b0-EH
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbd-0007da-Fo
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710920604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VEQgO62qORazJGwyBJgLKdEnJL8QJhzbHwAjeCdVvE8=;
 b=DkqtnhvPpiBwIPSFLeQErs2rsBf65Au09LdtFyFwlgwsoycDUVV6nGFm5dfW2oYP38QKwT
 C0XpBFNlpiog4ty2hmFEMV4YDHO1gtTxV98xvLFCmRdnHqNzgR7Z/SarZ2Fdc719P/WsgF
 0jAr57Osu6XbrqzKtytm48eC9f4cB9A=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-vKwoVzm4OtqWKHIp5EvLZg-1; Wed, 20 Mar 2024 03:43:22 -0400
X-MC-Unique: vKwoVzm4OtqWKHIp5EvLZg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DBFF8185A789;
 Wed, 20 Mar 2024 07:43:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 99B47111E406;
 Wed, 20 Mar 2024 07:43:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9873F21E691E; Wed, 20 Mar 2024 08:43:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH 1/7] qapi: New QAPISchemaBranches, QAPISchemaAlternatives
Date: Wed, 20 Mar 2024 08:43:09 +0100
Message-ID: <20240320074315.23167-2-armbru@redhat.com>
In-Reply-To: <20240320074315.23167-1-armbru@redhat.com>
References: <20240320074315.23167-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

QAPISchemaVariants represents either a union type's branches, or an
alternate type's alternatives.  Much of its code is conditional on
which one it actually is.

Create QAPISchemaBranches for branches, and QAPISchemaAlternatives for
alternatives, both subtypes of QAPISchemaVariants.

Replace QAPISchemaVariants by one of them where possible.  Keep it
only where we actually deal with either of them.

QAPISchemaVariants.__init__() takes @tag_name and @tag_member, where
exactly one must be None: @tag_name for alternatives, @tag_member for
branches.  Let QAPISchemaBranches.__init__() take just @tag_name, and
QAPISchemaAlternatives.__init__() take just @tag_member.

A later patch will move the conditional code to the subtypes.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py |  7 ++++---
 scripts/qapi/schema.py     | 32 ++++++++++++++++++++++++--------
 scripts/qapi/types.py      |  6 ++++--
 scripts/qapi/visit.py      | 11 ++++++-----
 4 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 4679b1bc2c..b866517942 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -26,6 +26,8 @@
 from .gen import QAPISchemaMonolithicCVisitor
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
+    QAPISchemaBranches,
     QAPISchemaArrayType,
     QAPISchemaBuiltinType,
     QAPISchemaEntity,
@@ -36,7 +38,6 @@
     QAPISchemaObjectTypeMember,
     QAPISchemaType,
     QAPISchemaVariant,
-    QAPISchemaVariants,
 )
 from .source import QAPISourceInfo
 
@@ -335,7 +336,7 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
                                ifcond: QAPISchemaIfCond,
                                features: List[QAPISchemaFeature],
                                members: List[QAPISchemaObjectTypeMember],
-                               variants: Optional[QAPISchemaVariants]) -> None:
+                               variants: Optional[QAPISchemaBranches]) -> None:
         obj: SchemaInfoObject = {
             'members': [self._gen_object_member(m) for m in members]
         }
@@ -347,7 +348,7 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
     def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             variants: QAPISchemaAlternatives) -> None:
         self._gen_tree(
             name, 'alternate',
             {'members': [Annotated({'type': self._use_type(m.type)},
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 5924947fc3..5cdedfc2c8 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -215,7 +215,7 @@ def visit_object_type(
         features: List[QAPISchemaFeature],
         base: Optional[QAPISchemaObjectType],
         members: List[QAPISchemaObjectTypeMember],
-        variants: Optional[QAPISchemaVariants],
+        variants: Optional[QAPISchemaBranches],
     ) -> None:
         pass
 
@@ -226,7 +226,7 @@ def visit_object_type_flat(
         ifcond: QAPISchemaIfCond,
         features: List[QAPISchemaFeature],
         members: List[QAPISchemaObjectTypeMember],
-        variants: Optional[QAPISchemaVariants],
+        variants: Optional[QAPISchemaBranches],
     ) -> None:
         pass
 
@@ -236,7 +236,7 @@ def visit_alternate_type(
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
         features: List[QAPISchemaFeature],
-        variants: QAPISchemaVariants,
+        variants: QAPISchemaAlternatives,
     ) -> None:
         pass
 
@@ -524,7 +524,7 @@ def __init__(
         features: Optional[List[QAPISchemaFeature]],
         base: Optional[str],
         local_members: List[QAPISchemaObjectTypeMember],
-        variants: Optional[QAPISchemaVariants],
+        variants: Optional[QAPISchemaBranches],
     ):
         # struct has local_members, optional base, and no variants
         # union has base, variants, and no local_members
@@ -651,7 +651,7 @@ def __init__(
         doc: Optional[QAPIDoc],
         ifcond: Optional[QAPISchemaIfCond],
         features: List[QAPISchemaFeature],
-        variants: QAPISchemaVariants,
+        variants: QAPISchemaAlternatives,
     ):
         super().__init__(name, info, doc, ifcond, features)
         assert variants.tag_member
@@ -833,6 +833,22 @@ def check_clash(
             v.type.check_clash(info, dict(seen))
 
 
+class QAPISchemaBranches(QAPISchemaVariants):
+    def __init__(self,
+                 info: QAPISourceInfo,
+                 variants: List[QAPISchemaVariant],
+                 tag_name: str):
+        super().__init__(tag_name, info, None, variants)
+
+
+class QAPISchemaAlternatives(QAPISchemaVariants):
+    def __init__(self,
+                 info: QAPISourceInfo,
+                 variants: List[QAPISchemaVariant],
+                 tag_member: QAPISchemaObjectTypeMember):
+        super().__init__(None, info, tag_member, variants)
+
+
 class QAPISchemaMember:
     """ Represents object members, enum members and features """
     role = 'member'
@@ -1388,8 +1404,8 @@ def _def_union_type(self, expr: QAPIExpression) -> None:
         self._def_definition(
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
-                                 QAPISchemaVariants(
-                                     tag_name, info, None, variants)))
+                                 QAPISchemaBranches(
+                                     info, variants, tag_name)))
 
     def _def_alternate_type(self, expr: QAPIExpression) -> None:
         name = expr['alternate']
@@ -1407,7 +1423,7 @@ def _def_alternate_type(self, expr: QAPIExpression) -> None:
         self._def_definition(
             QAPISchemaAlternateType(
                 name, info, expr.doc, ifcond, features,
-                QAPISchemaVariants(None, info, tag_member, variants)))
+                QAPISchemaAlternatives(info, variants, tag_member)))
 
     def _def_command(self, expr: QAPIExpression) -> None:
         name = expr['command']
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index c39d054d2c..23cdf3e83e 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -23,6 +23,8 @@
 )
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
+    QAPISchemaBranches,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
     QAPISchemaIfCond,
@@ -348,7 +350,7 @@ def visit_object_type(self,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
-                          variants: Optional[QAPISchemaVariants]) -> None:
+                          variants: Optional[QAPISchemaBranches]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
@@ -369,7 +371,7 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             variants: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
         self._genh.add(gen_object(name, ifcond, None,
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index c56ea4d724..746735e013 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -28,6 +28,8 @@
 )
 from .schema import (
     QAPISchema,
+    QAPISchemaAlternatives,
+    QAPISchemaBranches,
     QAPISchemaEnumMember,
     QAPISchemaEnumType,
     QAPISchemaFeature,
@@ -35,7 +37,6 @@
     QAPISchemaObjectType,
     QAPISchemaObjectTypeMember,
     QAPISchemaType,
-    QAPISchemaVariants,
 )
 from .source import QAPISourceInfo
 
@@ -63,7 +64,7 @@ def gen_visit_members_decl(name: str) -> str:
 def gen_visit_object_members(name: str,
                              base: Optional[QAPISchemaObjectType],
                              members: List[QAPISchemaObjectTypeMember],
-                             variants: Optional[QAPISchemaVariants]) -> str:
+                             variants: Optional[QAPISchemaBranches]) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s_members(Visitor *v, %(c_name)s *obj, Error **errp)
@@ -222,7 +223,7 @@ def gen_visit_enum(name: str) -> str:
                  c_name=c_name(name))
 
 
-def gen_visit_alternate(name: str, variants: QAPISchemaVariants) -> str:
+def gen_visit_alternate(name: str, variants: QAPISchemaAlternatives) -> str:
     ret = mcgen('''
 
 bool visit_type_%(c_name)s(Visitor *v, const char *name,
@@ -394,7 +395,7 @@ def visit_object_type(self,
                           features: List[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
                           members: List[QAPISchemaObjectTypeMember],
-                          variants: Optional[QAPISchemaVariants]) -> None:
+                          variants: Optional[QAPISchemaBranches]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
             return
@@ -414,7 +415,7 @@ def visit_alternate_type(self,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
                              features: List[QAPISchemaFeature],
-                             variants: QAPISchemaVariants) -> None:
+                             variants: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
             self._genc.add(gen_visit_alternate(name, variants))
-- 
2.44.0


