Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA484C54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:26:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9P6-0007n4-TC; Fri, 15 Mar 2024 11:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9P5-0007kB-Cq
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9P3-00023z-9r
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0D6asP6gsXhYAMUhFluSAYqykSNu1a2/Kgq+A7MFMOo=;
 b=SFG3OFsSMi8frbCq6o6c1Z8v8FX7VbgqFbxcx5r0ffwpKksZjXbNSe/MYbmQcjO+Gs1mtH
 +b/b33nytISUE4hZZ17skdztV+FLFUOwfPddyBSr2XvwrxvZd2yOdLmjLD5iDyJleeLBwk
 tweeB6a0iLxMM+ffb2M3E8Mnn1Cm6e0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-lWomceGNNaGIkbE_izFlNg-1; Fri, 15 Mar 2024 11:23:04 -0400
X-MC-Unique: lWomceGNNaGIkbE_izFlNg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B12282248F;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E8C33492BD1;
 Fri, 15 Mar 2024 15:23:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E032821E6889; Fri, 15 Mar 2024 16:23:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 05/25] qapi: create QAPISchemaDefinition
Date: Fri, 15 Mar 2024 16:22:41 +0100
Message-ID: <20240315152301.3621858-6-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

From: John Snow <jsnow@redhat.com>

Include entities don't have names, but we generally expect "entities" to
have names. Reclassify all entities with names as *definitions*, leaving
the nameless include entities as QAPISchemaEntity instances.

This is primarily to help simplify typing around expectations of what
callers expect for properties of an "entity".

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 144 +++++++++++++++++++++++------------------
 1 file changed, 82 insertions(+), 62 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 117f0f78f0..b298c8b4f9 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -55,14 +55,13 @@ def is_present(self):
 
 
 class QAPISchemaEntity:
-    meta: Optional[str] = None
+    """
+    A schema entity.
 
-    def __init__(self, name: str, info, doc, ifcond=None, features=None):
-        assert name is None or isinstance(name, str)
-        for f in features or []:
-            assert isinstance(f, QAPISchemaFeature)
-            f.set_defined_in(name)
-        self.name = name
+    This is either a directive, such as include, or a definition.
+    The latter uses sub-class `QAPISchemaDefinition`.
+    """
+    def __init__(self, info):
         self._module = None
         # For explicitly defined entities, info points to the (explicit)
         # definition.  For builtins (and their arrays), info is None.
@@ -70,33 +69,17 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
         # triggered the implicit definition (there may be more than one
         # such place).
         self.info = info
-        self.doc = doc
-        self._ifcond = ifcond or QAPISchemaIfCond()
-        self.features = features or []
         self._checked = False
 
     def __repr__(self):
-        if self.name is None:
-            return "<%s at 0x%x>" % (type(self).__name__, id(self))
-        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
-                                    id(self))
-
-    def c_name(self):
-        return c_name(self.name)
+        return "<%s at 0x%x>" % (type(self).__name__, id(self))
 
     def check(self, schema):
         # pylint: disable=unused-argument
-        assert not self._checked
-        seen = {}
-        for f in self.features:
-            f.check_clash(self.info, seen)
         self._checked = True
 
     def connect_doc(self, doc=None):
-        doc = doc or self.doc
-        if doc:
-            for f in self.features:
-                doc.connect_feature(f)
+        pass
 
     def _set_module(self, schema, info):
         assert self._checked
@@ -107,6 +90,46 @@ def _set_module(self, schema, info):
     def set_module(self, schema):
         self._set_module(schema, self.info)
 
+    def visit(self, visitor):
+        # pylint: disable=unused-argument
+        assert self._checked
+
+
+class QAPISchemaDefinition(QAPISchemaEntity):
+    meta: Optional[str] = None
+
+    def __init__(self, name: str, info, doc, ifcond=None, features=None):
+        assert isinstance(name, str)
+        super().__init__(info)
+        for f in features or []:
+            assert isinstance(f, QAPISchemaFeature)
+            f.set_defined_in(name)
+        self.name = name
+        self.doc = doc
+        self._ifcond = ifcond or QAPISchemaIfCond()
+        self.features = features or []
+
+    def __repr__(self):
+        return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
+                                    id(self))
+
+    def c_name(self):
+        return c_name(self.name)
+
+    def check(self, schema):
+        assert not self._checked
+        super().check(schema)
+        seen = {}
+        for f in self.features:
+            f.check_clash(self.info, seen)
+
+    def connect_doc(self, doc=None):
+        super().connect_doc(doc)
+        doc = doc or self.doc
+        if doc:
+            for f in self.features:
+                doc.connect_feature(f)
+
     @property
     def ifcond(self):
         assert self._checked
@@ -115,10 +138,6 @@ def ifcond(self):
     def is_implicit(self):
         return not self.info
 
-    def visit(self, visitor):
-        # pylint: disable=unused-argument
-        assert self._checked
-
     def describe(self):
         assert self.meta
         return "%s '%s'" % (self.meta, self.name)
@@ -218,7 +237,7 @@ def visit(self, visitor):
 
 class QAPISchemaInclude(QAPISchemaEntity):
     def __init__(self, sub_module, info):
-        super().__init__(None, info, None)
+        super().__init__(info)
         self._sub_module = sub_module
 
     def visit(self, visitor):
@@ -226,7 +245,7 @@ def visit(self, visitor):
         visitor.visit_include(self._sub_module.name, self.info)
 
 
-class QAPISchemaType(QAPISchemaEntity):
+class QAPISchemaType(QAPISchemaDefinition):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
     def c_type(self):
@@ -797,7 +816,7 @@ def __init__(self, name, info, typ, ifcond=None):
         super().__init__(name, info, typ, False, ifcond)
 
 
-class QAPISchemaCommand(QAPISchemaEntity):
+class QAPISchemaCommand(QAPISchemaDefinition):
     meta = 'command'
 
     def __init__(self, name, info, doc, ifcond, features,
@@ -868,7 +887,7 @@ def visit(self, visitor):
             self.coroutine)
 
 
-class QAPISchemaEvent(QAPISchemaEntity):
+class QAPISchemaEvent(QAPISchemaDefinition):
     meta = 'event'
 
     def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
@@ -939,23 +958,24 @@ def __init__(self, fname):
         self.check()
 
     def _def_entity(self, ent):
-        # Only the predefined types are allowed to not have info
-        assert ent.info or self._predefining
         self._entity_list.append(ent)
-        if ent.name is None:
-            return
+
+    def _def_definition(self, defn):
+        # Only the predefined types are allowed to not have info
+        assert defn.info or self._predefining
+        self._def_entity(defn)
         # TODO reject names that differ only in '_' vs. '.'  vs. '-',
         # because they're liable to clash in generated C.
-        other_ent = self._entity_dict.get(ent.name)
-        if other_ent:
-            if other_ent.info:
-                where = QAPISourceError(other_ent.info, "previous definition")
+        other_defn = self._entity_dict.get(defn.name)
+        if other_defn:
+            if other_defn.info:
+                where = QAPISourceError(other_defn.info, "previous definition")
                 raise QAPISemError(
-                    ent.info,
-                    "'%s' is already defined\n%s" % (ent.name, where))
+                    defn.info,
+                    "'%s' is already defined\n%s" % (defn.name, where))
             raise QAPISemError(
-                ent.info, "%s is already defined" % other_ent.describe())
-        self._entity_dict[ent.name] = ent
+                defn.info, "%s is already defined" % other_defn.describe())
+        self._entity_dict[defn.name] = defn
 
     def lookup_entity(self, name, typ=None):
         ent = self._entity_dict.get(name)
@@ -997,7 +1017,7 @@ def _def_include(self, expr: QAPIExpression):
             QAPISchemaInclude(self._make_module(include), expr.info))
 
     def _def_builtin_type(self, name, json_type, c_type):
-        self._def_entity(QAPISchemaBuiltinType(name, json_type, c_type))
+        self._def_definition(QAPISchemaBuiltinType(name, json_type, c_type))
         # Instantiating only the arrays that are actually used would
         # be nice, but we can't as long as their generated code
         # (qapi-builtin-types.[ch]) may be shared by some other
@@ -1023,15 +1043,15 @@ def _def_predefineds(self):
             self._def_builtin_type(*t)
         self.the_empty_object_type = QAPISchemaObjectType(
             'q_empty', None, None, None, None, None, [], None)
-        self._def_entity(self.the_empty_object_type)
+        self._def_definition(self.the_empty_object_type)
 
         qtypes = ['none', 'qnull', 'qnum', 'qstring', 'qdict', 'qlist',
                   'qbool']
         qtype_values = self._make_enum_members(
             [{'name': n} for n in qtypes], None)
 
-        self._def_entity(QAPISchemaEnumType('QType', None, None, None, None,
-                                            qtype_values, 'QTYPE'))
+        self._def_definition(QAPISchemaEnumType(
+            'QType', None, None, None, None, qtype_values, 'QTYPE'))
 
     def _make_features(self, features, info):
         if features is None:
@@ -1053,7 +1073,8 @@ def _make_enum_members(self, values, info):
     def _make_array_type(self, element_type, info):
         name = element_type + 'List'    # reserved by check_defn_name_str()
         if not self.lookup_type(name):
-            self._def_entity(QAPISchemaArrayType(name, info, element_type))
+            self._def_definition(QAPISchemaArrayType(
+                name, info, element_type))
         return name
 
     def _make_implicit_object_type(self, name, info, ifcond, role, members):
@@ -1068,7 +1089,7 @@ def _make_implicit_object_type(self, name, info, ifcond, role, members):
             # later.
             pass
         else:
-            self._def_entity(QAPISchemaObjectType(
+            self._def_definition(QAPISchemaObjectType(
                 name, info, None, ifcond, None, None, members, None))
         return name
 
@@ -1079,7 +1100,7 @@ def _def_enum_type(self, expr: QAPIExpression):
         ifcond = QAPISchemaIfCond(expr.get('if'))
         info = expr.info
         features = self._make_features(expr.get('features'), info)
-        self._def_entity(QAPISchemaEnumType(
+        self._def_definition(QAPISchemaEnumType(
             name, info, expr.doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
 
@@ -1107,7 +1128,7 @@ def _def_struct_type(self, expr: QAPIExpression):
         info = expr.info
         ifcond = QAPISchemaIfCond(expr.get('if'))
         features = self._make_features(expr.get('features'), info)
-        self._def_entity(QAPISchemaObjectType(
+        self._def_definition(QAPISchemaObjectType(
             name, info, expr.doc, ifcond, features, base,
             self._make_members(data, info),
             None))
@@ -1137,7 +1158,7 @@ def _def_union_type(self, expr: QAPIExpression):
                                info)
             for (key, value) in data.items()]
         members: List[QAPISchemaObjectTypeMember] = []
-        self._def_entity(
+        self._def_definition(
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
                                  QAPISchemaVariants(
@@ -1156,7 +1177,7 @@ def _def_alternate_type(self, expr: QAPIExpression):
                                info)
             for (key, value) in data.items()]
         tag_member = QAPISchemaObjectTypeMember('type', info, 'QType', False)
-        self._def_entity(
+        self._def_definition(
             QAPISchemaAlternateType(
                 name, info, expr.doc, ifcond, features,
                 QAPISchemaVariants(None, info, tag_member, variants)))
@@ -1181,11 +1202,10 @@ def _def_command(self, expr: QAPIExpression):
         if isinstance(rets, list):
             assert len(rets) == 1
             rets = self._make_array_type(rets[0], info)
-        self._def_entity(QAPISchemaCommand(name, info, expr.doc, ifcond,
-                                           features, data, rets,
-                                           gen, success_response,
-                                           boxed, allow_oob, allow_preconfig,
-                                           coroutine))
+        self._def_definition(
+            QAPISchemaCommand(name, info, expr.doc, ifcond, features, data,
+                              rets, gen, success_response, boxed, allow_oob,
+                              allow_preconfig, coroutine))
 
     def _def_event(self, expr: QAPIExpression):
         name = expr['event']
@@ -1198,8 +1218,8 @@ def _def_event(self, expr: QAPIExpression):
             data = self._make_implicit_object_type(
                 name, info, ifcond,
                 'arg', self._make_members(data, info))
-        self._def_entity(QAPISchemaEvent(name, info, expr.doc, ifcond,
-                                         features, data, boxed))
+        self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifcond,
+                                             features, data, boxed))
 
     def _def_exprs(self, exprs):
         for expr in exprs:
-- 
2.44.0


