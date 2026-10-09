Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65237CA9EBE
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:05:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBDI-0000sS-HE; Fri, 09 Oct 2026 10:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDG-0000rs-1g
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDD-0007T2-Bj
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791554677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QBbuTqoPq1NM6KRF8rX74ImioIWIDBiC2afETo0yPJI=;
 b=DTACXFzQ3keI/W5yF1ld9+420M2QGqtKzo0VzErOAYwcwFV7cJUgnD1QD5PFWMfVSuy7m+
 VT2GmLfIiZff0OT6AXv9PYrrOmKNVYLgpE4ISa3vi+hfjqLkLWQ+hDTZAm4Ff1De5Ishkp
 X1sj4+dJU9IdEV0Y2AEFYQ8Zl1d/Q/g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-mpO6M0i5PlaRlXv5xH0fYg-1; Fri,
 9 Oct 2026 14:04:35 +0000
X-MC-Unique: mpO6M0i5PlaRlXv5xH0fYg-1
X-Mimecast-MFC-AGG-ID: mpO6M0i5PlaRlXv5xH0fYg_1791554674
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 66A6C19560A2; Fri,  9 Oct 2026 14:04:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C5A1218005B5; Fri,  9 Oct 2026 14:04:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4DFA821E6880; Fri, 09 Oct 2026 16:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	michael.roth@amd.com,
	jsnow@redhat.com
Subject: [RFC PATCH 2/6] qapi: Ease access to introspection names
Date: Fri,  9 Oct 2026 16:04:27 +0200
Message-ID: <20261009140431.3175479-3-armbru@redhat.com>
In-Reply-To: <20261009140431.3175479-1-armbru@redhat.com>
References: <20261009140431.3175479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

query-qmp-schema masks type names, because they are not part of the
external interface.  Marc-André Lureau would like to also use them
with qom-list & friends.  Trouble is the masked names are buried deep
in QAPISchemaGenIntrospectVisitor.  Lift them into schema.py: new
QAPISchemaDefinition method introspection_name() returns a
definition's name for use in introspection.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 23 ++++----------------
 scripts/qapi/schema.py     | 43 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 19 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 7e28de2279..644461560c 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -30,7 +30,6 @@
     QAPISchemaAlternatives,
     QAPISchemaArrayType,
     QAPISchemaBranches,
-    QAPISchemaBuiltinType,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
@@ -177,7 +176,6 @@ def __init__(self, prefix: str, unmask: bool):
         self._schema: Optional[QAPISchema] = None
         self._trees: List[Annotated[SchemaInfo]] = []
         self._used_types: List[QAPISchemaType] = []
-        self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -208,18 +206,14 @@ def visit_end(self) -> None:
         self._schema = None
         self._trees = []
         self._used_types = []
-        self._name_map = {}
 
     def visit_needed(self, entity: QAPISchemaEntity) -> bool:
         # Ignore types on first pass; visit_end() will pick up used types
         return not isinstance(entity, QAPISchemaType)
 
     def _name(self, name: str) -> str:
-        if self._unmask:
-            return name
-        if name not in self._name_map:
-            self._name_map[name] = '%d' % len(self._name_map)
-        return self._name_map[name]
+        assert self._schema
+        return self._schema.definition_introspection_name(name, self._unmask)
 
     def _use_type(self, typ: QAPISchemaType) -> str:
         assert self._schema is not None
@@ -237,13 +231,6 @@ def _use_type(self, typ: QAPISchemaType) -> str:
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
-        # Clients should examine commands and events, not types.  Hide
-        # type names as integers to reduce the temptation.  Also, it
-        # saves a few characters on the wire.
-        if isinstance(typ, QAPISchemaBuiltinType):
-            return typ.name
-        if isinstance(typ, QAPISchemaArrayType):
-            return '[' + self._use_type(typ.element_type) + ']'
         return self._name(typ.name)
 
     @staticmethod
@@ -271,8 +258,7 @@ def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
                 # Output a comment to make it easy to map masked names
                 # back to the source when reading the generated output.
                 comment = f'"{self._name(name)}" = {name}'
-            name = self._name(name)
-        obj['name'] = name
+        obj['name'] = self._name(name)
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)
@@ -327,8 +313,7 @@ def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: QAPISchemaIfCond,
                          element_type: QAPISchemaType) -> None:
         element = self._use_type(element_type)
-        self._gen_tree('[' + element + ']', 'array', {'element-type': element},
-                       ifcond)
+        self._gen_tree(name, 'array', {'element-type': element}, ifcond)
 
     def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
                                ifcond: QAPISchemaIfCond,
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 9c9e257a8f..11f3accec8 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -136,6 +136,13 @@ def __repr__(self) -> str:
     def c_name(self) -> str:
         return c_name(self.name)
 
+    def set_ordinal(self, ordinal: int) -> None:
+        pass
+
+    # pylint: disable=unused-argument
+    def introspection_name(self, unmask: bool) -> str:
+        return self.name
+
     def check(self, schema: QAPISchema) -> None:
         assert not self._checked
         super().check(schema)
@@ -323,6 +330,17 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
 
 
 class QAPISchemaType(QAPISchemaDefinition, ABC):
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        doc: Optional[QAPIDoc],
+        ifcond: Optional[QAPISchemaIfCond] = None,
+        features: Optional[List[QAPISchemaFeature]] = None,
+    ):
+        super().__init__(name, info, doc, ifcond, features)
+        self._masked_name: Optional[str] = None
+
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
     @abstractmethod
@@ -363,6 +381,17 @@ def need_has_if_optional(self) -> bool:
         # Except for arrays; see QAPISchemaArrayType.need_has_if_optional().
         return not self.c_type().endswith(POINTER_SUFFIX)
 
+    def set_ordinal(self, ordinal: int) -> None:
+        assert not self._masked_name
+        self._masked_name = str(ordinal)
+
+    def introspection_name(self, unmask: bool) -> str:
+        # Type names are not part of the external interface.  Hide
+        # them in introspection.  Also saves a few characters on the
+        # wire.
+        assert self._masked_name
+        return self.name if unmask else self._masked_name
+
     def check(self, schema: QAPISchema) -> None:
         super().check(schema)
         for feat in self.features:
@@ -402,6 +431,11 @@ def json_type(self) -> str:
     def doc_type(self) -> str:
         return self.json_type()
 
+    def introspection_name(self, unmask: bool):
+        if self.json_type() == 'int':
+            return 'int'
+        return self.name
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_builtin_type(self.name, self.info, self.json_type())
@@ -503,6 +537,9 @@ def doc_type(self) -> Optional[str]:
             return None
         return 'array of ' + elt_doc_type
 
+    def introspection_name(self, unmask: bool):
+        return '[' + self.element_type.introspection_name(unmask) + ']'
+
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_array_type(self.name, self.info, self.ifcond,
@@ -1182,6 +1219,7 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
                     "'%s' is already defined\n%s" % (defn.name, where))
             raise QAPISemError(
                 defn.info, "%s is already defined" % other_defn.describe())
+        defn.set_ordinal(len(self._entity_dict))
         self._entity_dict[defn.name] = defn
 
     def lookup_defn(self, name: str) -> Optional[QAPISchemaDefinition]:
@@ -1208,6 +1246,11 @@ def resolve_type(
                 info, "%s uses unknown type '%s'" % (what, name))
         return typ
 
+    def definition_introspection_name(self, name: str, unmask: bool) -> str:
+        defn = self.lookup_defn(name)
+        assert defn
+        return defn.introspection_name(unmask)
+
     def _module_name(self, fname: str) -> str:
         if QAPISchemaModule.is_system_module(fname):
             return fname
-- 
2.55.0


