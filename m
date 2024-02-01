Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A94C48291
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 22:43:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVfmB-0006Id-45; Thu, 01 Feb 2024 17:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVfm1-0006D0-1G
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rVfls-0006bT-Vd
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 17:43:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706827378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=On/SA9nFdE39K910ykxOHaLDTvlkGV6N8L/mQHdc9zc=;
 b=FRJxpYf1ujAOZf69D4I0cgivQNUpQRIhcxGU+5mI1cXYcO7Kwl/OZ+AgxcGRQGj2No9z9+
 I1R4NzOWgnvw2B2J0I7BZ7SosxbNWLhmuaZBGQ2HDGc5LmiwEQgCduO1H6KlbiS0F+CWvm
 OlhN06dUfw7mzu2WlOAmMK47l0CRWpw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-UkNVmA0QOS6kuFc0zoGiLA-1; Thu,
 01 Feb 2024 17:42:55 -0500
X-MC-Unique: UkNVmA0QOS6kuFc0zoGiLA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3EC51C0CCA5;
 Thu,  1 Feb 2024 22:42:54 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.18.40])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7D9202166B33;
 Thu,  1 Feb 2024 22:42:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v3 18/20] qapi/schema: add type hints
Date: Thu,  1 Feb 2024 17:42:44 -0500
Message-ID: <20240201224246.39480-19-jsnow@redhat.com>
In-Reply-To: <20240201224246.39480-1-jsnow@redhat.com>
References: <20240201224246.39480-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch only adds type hints, which aren't utilized at runtime and
don't change the behavior of this module in any way.

In a scant few locations, type hints are removed where no longer
necessary due to inference power from typing all of the rest of
creation; and any type hints that no longer need string quotes are
changed.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/schema.py | 572 ++++++++++++++++++++++++++++-------------
 1 file changed, 398 insertions(+), 174 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 4d153b216c0..319c8475d21 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -16,11 +16,21 @@
 
 # TODO catching name collisions in generated code would be nice
 
+from __future__ import annotations
+
 from abc import ABC, abstractmethod
 from collections import OrderedDict
 import os
 import re
-from typing import List, Optional, cast
+from typing import (
+    Any,
+    Callable,
+    Dict,
+    List,
+    Optional,
+    Union,
+    cast,
+)
 
 from .common import (
     POINTER_SUFFIX,
@@ -32,26 +42,30 @@
 )
 from .error import QAPIError, QAPISemError, QAPISourceError
 from .expr import check_exprs
-from .parser import QAPIExpression, QAPISchemaParser
+from .parser import QAPIDoc, QAPIExpression, QAPISchemaParser
+from .source import QAPISourceInfo
 
 
 class QAPISchemaIfCond:
-    def __init__(self, ifcond=None):
+    def __init__(
+        self,
+        ifcond: Optional[Union[str, Dict[str, object]]] = None,
+    ) -> None:
         self.ifcond = ifcond
 
-    def _cgen(self):
+    def _cgen(self) -> str:
         return cgen_ifcond(self.ifcond)
 
-    def gen_if(self):
+    def gen_if(self) -> str:
         return gen_if(self._cgen())
 
-    def gen_endif(self):
+    def gen_endif(self) -> str:
         return gen_endif(self._cgen())
 
-    def docgen(self):
+    def docgen(self) -> str:
         return docgen_ifcond(self.ifcond)
 
-    def is_present(self):
+    def is_present(self) -> bool:
         return bool(self.ifcond)
 
 
@@ -62,8 +76,8 @@ class QAPISchemaEntity:
     This is either a directive, such as include, or a definition.
     The latter uses sub-class `QAPISchemaDefinition`.
     """
-    def __init__(self, info):
-        self._module = None
+    def __init__(self, info: Optional[QAPISourceInfo]):
+        self._module: Optional[QAPISchemaModule] = None
         # For explicitly defined entities, info points to the (explicit)
         # definition.  For builtins (and their arrays), info is None.
         # For implicitly defined entities, info points to a place that
@@ -72,37 +86,46 @@ def __init__(self, info):
         self.info = info
         self._checked = False
 
-    def __repr__(self):
+    def __repr__(self) -> str:
         return "<%s at 0x%x>" % (type(self).__name__, id(self))
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         # pylint: disable=unused-argument
         self._checked = True
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         pass
 
-    def check_doc(self):
+    def check_doc(self) -> None:
         pass
 
-    def _set_module(self, schema, info):
+    def _set_module(
+        self, schema: QAPISchema, info: Optional[QAPISourceInfo]
+    ) -> None:
         assert self._checked
         fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
         self._module = schema.module_by_fname(fname)
         self._module.add_entity(self)
 
-    def set_module(self, schema):
+    def set_module(self, schema: QAPISchema) -> None:
         self._set_module(schema, self.info)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         # pylint: disable=unused-argument
         assert self._checked
 
 
 class QAPISchemaDefinition(QAPISchemaEntity):
-    meta: Optional[str] = None
+    meta: str
 
-    def __init__(self, name: str, info, doc, ifcond=None, features=None):
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        doc: Optional[QAPIDoc],
+        ifcond: Optional[QAPISchemaIfCond] = None,
+        features: Optional[List[QAPISchemaFeature]] = None,
+    ):
         assert isinstance(name, str)
         super().__init__(info)
         for f in features or []:
@@ -113,89 +136,147 @@ def __init__(self, name: str, info, doc, ifcond=None, features=None):
         self._ifcond = ifcond or QAPISchemaIfCond()
         self.features = features or []
 
-    def __repr__(self):
+    def __repr__(self) -> str:
         return "<%s:%s at 0x%x>" % (type(self).__name__, self.name,
                                     id(self))
 
-    def c_name(self):
+    def c_name(self) -> str:
         return c_name(self.name)
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         assert not self._checked
         super().check(schema)
-        seen = {}
+        seen: Dict[str, QAPISchemaMember] = {}
         for f in self.features:
             f.check_clash(self.info, seen)
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if doc:
             for f in self.features:
                 doc.connect_feature(f)
 
-    def check_doc(self):
+    def check_doc(self) -> None:
         super().check_doc()
         if self.doc:
             self.doc.check()
 
     @property
-    def ifcond(self):
+    def ifcond(self) -> QAPISchemaIfCond:
         assert self._checked
         return self._ifcond
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         return not self.info
 
-    def describe(self):
+    def describe(self) -> str:
         assert self.meta
         return "%s '%s'" % (self.meta, self.name)
 
 
 class QAPISchemaVisitor:
-    def visit_begin(self, schema):
+    def visit_begin(self, schema: QAPISchema) -> None:
         pass
 
-    def visit_end(self):
+    def visit_end(self) -> None:
         pass
 
-    def visit_module(self, name):
+    def visit_module(self, name: str) -> None:
         pass
 
-    def visit_needed(self, entity):
+    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
         # pylint: disable=unused-argument
         # Default to visiting everything
         return True
 
-    def visit_include(self, name, info):
+    def visit_include(self, name: str, info: Optional[QAPISourceInfo]) -> None:
         pass
 
-    def visit_builtin_type(self, name, info, json_type):
+    def visit_builtin_type(
+        self, name: str, info: Optional[QAPISourceInfo], json_type: str
+    ) -> None:
         pass
 
-    def visit_enum_type(self, name, info, ifcond, features, members, prefix):
+    def visit_enum_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        members: List[QAPISchemaEnumMember],
+        prefix: Optional[str],
+    ) -> None:
         pass
 
-    def visit_array_type(self, name, info, ifcond, element_type):
+    def visit_array_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        element_type: QAPISchemaType,
+    ) -> None:
         pass
 
-    def visit_object_type(self, name, info, ifcond, features,
-                          base, members, variants):
+    def visit_object_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        base: Optional[QAPISchemaObjectType],
+        members: List[QAPISchemaObjectTypeMember],
+        variants: Optional[QAPISchemaVariants],
+    ) -> None:
         pass
 
-    def visit_object_type_flat(self, name, info, ifcond, features,
-                               members, variants):
+    def visit_object_type_flat(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        members: List[QAPISchemaObjectTypeMember],
+        variants: Optional[QAPISchemaVariants],
+    ) -> None:
         pass
 
-    def visit_alternate_type(self, name, info, ifcond, features, variants):
+    def visit_alternate_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        variants: QAPISchemaVariants,
+    ) -> None:
         pass
 
-    def visit_command(self, name, info, ifcond, features,
-                      arg_type, ret_type, gen, success_response, boxed,
-                      allow_oob, allow_preconfig, coroutine):
+    def visit_command(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        ret_type: Optional[QAPISchemaType],
+        gen: bool,
+        success_response: bool,
+        boxed: bool,
+        allow_oob: bool,
+        allow_preconfig: bool,
+        coroutine: bool,
+    ) -> None:
         pass
 
-    def visit_event(self, name, info, ifcond, features, arg_type, boxed):
+    def visit_event(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[QAPISchemaObjectType],
+        boxed: bool,
+    ) -> None:
         pass
 
 
@@ -203,9 +284,9 @@ class QAPISchemaModule:
 
     BUILTIN_MODULE_NAME = './builtin'
 
-    def __init__(self, name):
+    def __init__(self, name: str):
         self.name = name
-        self._entity_list = []
+        self._entity_list: List[QAPISchemaEntity] = []
 
     @staticmethod
     def is_system_module(name: str) -> bool:
@@ -234,10 +315,10 @@ def is_builtin_module(cls, name: str) -> bool:
         """
         return name == cls.BUILTIN_MODULE_NAME
 
-    def add_entity(self, ent):
+    def add_entity(self, ent: QAPISchemaEntity) -> None:
         self._entity_list.append(ent)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_module(self.name)
         for entity in self._entity_list:
             if visitor.visit_needed(entity):
@@ -245,11 +326,11 @@ def visit(self, visitor):
 
 
 class QAPISchemaInclude(QAPISchemaEntity):
-    def __init__(self, sub_module, info):
+    def __init__(self, sub_module: QAPISchemaModule, info: QAPISourceInfo):
         super().__init__(info)
         self._sub_module = sub_module
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_include(self._sub_module.name, self.info)
 
@@ -258,22 +339,22 @@ class QAPISchemaType(QAPISchemaDefinition, ABC):
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
     @abstractmethod
-    def c_type(self):
+    def c_type(self) -> str:
         pass
 
     # Return the C type to be used in a parameter list.
-    def c_param_type(self):
+    def c_param_type(self) -> str:
         return self.c_type()
 
     # Return the C type to be used where we suppress boxing.
-    def c_unboxed_type(self):
+    def c_unboxed_type(self) -> str:
         return self.c_type()
 
     @abstractmethod
-    def json_type(self):
+    def json_type(self) -> str:
         pass
 
-    def alternate_qtype(self):
+    def alternate_qtype(self) -> Optional[str]:
         json2qtype = {
             'null':    'QTYPE_QNULL',
             'string':  'QTYPE_QSTRING',
@@ -285,17 +366,17 @@ def alternate_qtype(self):
         }
         return json2qtype.get(self.json_type())
 
-    def doc_type(self):
+    def doc_type(self) -> Optional[str]:
         if self.is_implicit():
             return None
         return self.name
 
-    def need_has_if_optional(self):
+    def need_has_if_optional(self) -> bool:
         # When FOO is a pointer, has_FOO == !!FOO, i.e. has_FOO is redundant.
         # Except for arrays; see QAPISchemaArrayType.need_has_if_optional().
         return not self.c_type().endswith(POINTER_SUFFIX)
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         super().check(schema)
         for feat in self.features:
             if feat.is_special():
@@ -303,7 +384,7 @@ def check(self, schema):
                     self.info,
                     f"feature '{feat.name}' is not supported for types")
 
-    def describe(self):
+    def describe(self) -> str:
         assert self.meta
         return "%s type '%s'" % (self.meta, self.name)
 
@@ -311,7 +392,7 @@ def describe(self):
 class QAPISchemaBuiltinType(QAPISchemaType):
     meta = 'built-in'
 
-    def __init__(self, name, json_type, c_type):
+    def __init__(self, name: str, json_type: str, c_type: str):
         super().__init__(name, None, None)
         assert not c_type or isinstance(c_type, str)
         assert json_type in ('string', 'number', 'int', 'boolean', 'null',
@@ -319,24 +400,24 @@ def __init__(self, name, json_type, c_type):
         self._json_type_name = json_type
         self._c_type_name = c_type
 
-    def c_name(self):
+    def c_name(self) -> str:
         return self.name
 
-    def c_type(self):
+    def c_type(self) -> str:
         return self._c_type_name
 
-    def c_param_type(self):
+    def c_param_type(self) -> str:
         if self.name == 'str':
             return 'const ' + self._c_type_name
         return self._c_type_name
 
-    def json_type(self):
+    def json_type(self) -> str:
         return self._json_type_name
 
-    def doc_type(self):
+    def doc_type(self) -> str:
         return self.json_type()
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_builtin_type(self.name, self.info, self.json_type())
 
@@ -344,7 +425,16 @@ def visit(self, visitor):
 class QAPISchemaEnumType(QAPISchemaType):
     meta = 'enum'
 
-    def __init__(self, name, info, doc, ifcond, features, members, prefix):
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        doc: Optional[QAPIDoc],
+        ifcond: Optional[QAPISchemaIfCond],
+        features: Optional[List[QAPISchemaFeature]],
+        members: List[QAPISchemaEnumMember],
+        prefix: Optional[str],
+    ):
         super().__init__(name, info, doc, ifcond, features)
         for m in members:
             assert isinstance(m, QAPISchemaEnumMember)
@@ -353,32 +443,32 @@ def __init__(self, name, info, doc, ifcond, features, members, prefix):
         self.members = members
         self.prefix = prefix
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         super().check(schema)
-        seen = {}
+        seen: Dict[str, QAPISchemaMember] = {}
         for m in self.members:
             m.check_clash(self.info, seen)
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         for m in self.members:
             m.connect_doc(doc)
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         # See QAPISchema._def_predefineds()
         return self.name == 'QType'
 
-    def c_type(self):
+    def c_type(self) -> str:
         return c_name(self.name)
 
-    def member_names(self):
+    def member_names(self) -> List[str]:
         return [m.name for m in self.members]
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'string'
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_enum_type(
             self.name, self.info, self.ifcond, self.features,
@@ -388,60 +478,71 @@ def visit(self, visitor):
 class QAPISchemaArrayType(QAPISchemaType):
     meta = 'array'
 
-    def __init__(self, name, info, element_type):
+    def __init__(
+        self, name: str, info: Optional[QAPISourceInfo], element_type: str
+    ):
         super().__init__(name, info, None)
         assert isinstance(element_type, str)
         self._element_type_name = element_type
         self.element_type: QAPISchemaType
 
-    def need_has_if_optional(self):
+    def need_has_if_optional(self) -> bool:
         # When FOO is an array, we still need has_FOO to distinguish
         # absent (!has_FOO) from present and empty (has_FOO && !FOO).
         return True
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         super().check(schema)
         self.element_type = schema.resolve_type(
             self._element_type_name, self.info,
             self.info.defn_meta if self.info else None)
         assert not isinstance(self.element_type, QAPISchemaArrayType)
 
-    def set_module(self, schema):
+    def set_module(self, schema: QAPISchema) -> None:
         self._set_module(schema, self.element_type.info)
 
     @property
-    def ifcond(self):
+    def ifcond(self) -> QAPISchemaIfCond:
         assert self._checked
         return self.element_type.ifcond
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         return True
 
-    def c_type(self):
+    def c_type(self) -> str:
         return c_name(self.name) + POINTER_SUFFIX
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'array'
 
-    def doc_type(self):
+    def doc_type(self) -> Optional[str]:
         elt_doc_type = self.element_type.doc_type()
         if not elt_doc_type:
             return None
         return 'array of ' + elt_doc_type
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_array_type(self.name, self.info, self.ifcond,
                                  self.element_type)
 
-    def describe(self):
+    def describe(self) -> str:
         assert self.meta
         return "%s type ['%s']" % (self.meta, self._element_type_name)
 
 
 class QAPISchemaObjectType(QAPISchemaType):
-    def __init__(self, name, info, doc, ifcond, features,
-                 base, local_members, variants):
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        doc: Optional[QAPIDoc],
+        ifcond: Optional[QAPISchemaIfCond],
+        features: Optional[List[QAPISchemaFeature]],
+        base: Optional[str],
+        local_members: List[QAPISchemaObjectTypeMember],
+        variants: Optional[QAPISchemaVariants],
+    ):
         # struct has local_members, optional base, and no variants
         # union has base, variants, and no local_members
         super().__init__(name, info, doc, ifcond, features)
@@ -460,7 +561,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.members: List[QAPISchemaObjectTypeMember]
         self._checking = False
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         # This calls another type T's .check() exactly when the C
         # struct emitted by gen_object() contains that T's C struct
         # (pointers don't count).
@@ -506,14 +607,18 @@ def check(self, schema):
     # Check that the members of this type do not cause duplicate JSON members,
     # and update seen to track the members seen so far. Report any errors
     # on behalf of info, which is not necessarily self.info
-    def check_clash(self, info, seen):
+    def check_clash(
+        self,
+        info: Optional[QAPISourceInfo],
+        seen: Dict[str, QAPISchemaMember],
+    ) -> None:
         assert self._checked
         for m in self.members:
             m.check_clash(info, seen)
         if self.variants:
             self.variants.check_clash(info, seen)
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if self.base and self.base.is_implicit():
@@ -521,32 +626,32 @@ def connect_doc(self, doc=None):
         for m in self.local_members:
             m.connect_doc(doc)
 
-    def is_implicit(self):
+    def is_implicit(self) -> bool:
         # See QAPISchema._make_implicit_object_type(), as well as
         # _def_predefineds()
         return self.name.startswith('q_')
 
-    def is_empty(self):
+    def is_empty(self) -> bool:
         return not self.members and not self.variants
 
-    def has_conditional_members(self):
+    def has_conditional_members(self) -> bool:
         return any(m.ifcond.is_present() for m in self.members)
 
-    def c_name(self):
+    def c_name(self) -> str:
         assert self.name != 'q_empty'
         return super().c_name()
 
-    def c_type(self):
+    def c_type(self) -> str:
         assert not self.is_implicit()
         return c_name(self.name) + POINTER_SUFFIX
 
-    def c_unboxed_type(self):
+    def c_unboxed_type(self) -> str:
         return c_name(self.name)
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'object'
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_object_type(
             self.name, self.info, self.ifcond, self.features,
@@ -559,7 +664,15 @@ def visit(self, visitor):
 class QAPISchemaAlternateType(QAPISchemaType):
     meta = 'alternate'
 
-    def __init__(self, name, info, doc, ifcond, features, variants):
+    def __init__(
+        self,
+        name: str,
+        info: QAPISourceInfo,
+        doc: Optional[QAPIDoc],
+        ifcond: Optional[QAPISchemaIfCond],
+        features: List[QAPISchemaFeature],
+        variants: QAPISchemaVariants,
+    ):
         super().__init__(name, info, doc, ifcond, features)
         assert isinstance(variants, QAPISchemaVariants)
         assert variants.tag_member
@@ -567,7 +680,7 @@ def __init__(self, name, info, doc, ifcond, features, variants):
         variants.tag_member.set_defined_in(self.name)
         self.variants = variants
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         super().check(schema)
         self.variants.tag_member.check(schema)
         # Not calling self.variants.check_clash(), because there's nothing
@@ -575,8 +688,8 @@ def check(self, schema):
         self.variants.check(schema, {})
         # Alternate branch names have no relation to the tag enum values;
         # so we have to check for potential name collisions ourselves.
-        seen = {}
-        types_seen = {}
+        seen: Dict[str, QAPISchemaMember] = {}
+        types_seen: Dict[str, str] = {}
         for v in self.variants.variants:
             v.check_clash(self.info, seen)
             qtype = v.type.alternate_qtype()
@@ -605,26 +718,32 @@ def check(self, schema):
                         % (v.describe(self.info), types_seen[qt]))
                 types_seen[qt] = v.name
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         for v in self.variants.variants:
             v.connect_doc(doc)
 
-    def c_type(self):
+    def c_type(self) -> str:
         return c_name(self.name) + POINTER_SUFFIX
 
-    def json_type(self):
+    def json_type(self) -> str:
         return 'value'
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_alternate_type(
             self.name, self.info, self.ifcond, self.features, self.variants)
 
 
 class QAPISchemaVariants:
-    def __init__(self, tag_name, info, tag_member, variants):
+    def __init__(
+        self,
+        tag_name: Optional[str],
+        info: QAPISourceInfo,
+        tag_member: Optional[QAPISchemaObjectTypeMember],
+        variants: List[QAPISchemaVariant],
+    ):
         # Unions pass tag_name but not tag_member.
         # Alternates pass tag_member but not tag_name.
         # After check(), tag_member is always set.
@@ -635,11 +754,11 @@ def __init__(self, tag_name, info, tag_member, variants):
             assert isinstance(v, QAPISchemaVariant)
         self._tag_name = tag_name
         self.info = info
-        self._tag_member: Optional[QAPISchemaObjectTypeMember] = tag_member
+        self._tag_member = tag_member
         self.variants = variants
 
     @property
-    def tag_member(self) -> 'QAPISchemaObjectTypeMember':
+    def tag_member(self) -> QAPISchemaObjectTypeMember:
         if self._tag_member is None:
             raise RuntimeError(
                 "QAPISchemaVariants has no tag_member property until "
@@ -647,11 +766,13 @@ def tag_member(self) -> 'QAPISchemaObjectTypeMember':
             )
         return self._tag_member
 
-    def set_defined_in(self, name):
+    def set_defined_in(self, name: str) -> None:
         for v in self.variants:
             v.set_defined_in(name)
 
-    def check(self, schema, seen):
+    def check(
+        self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
+    ) -> None:
         if self._tag_name:      # union
             # We need to narrow the member type:
             tmp = seen.get(c_name(self._tag_name))
@@ -720,7 +841,11 @@ def check(self, schema, seen):
                         % (v.describe(self.info), v.type.describe()))
                 v.type.check(schema)
 
-    def check_clash(self, info, seen):
+    def check_clash(
+        self,
+        info: Optional[QAPISourceInfo],
+        seen: Dict[str, QAPISchemaMember],
+    ) -> None:
         for v in self.variants:
             # Reset seen map for each variant, since qapi names from one
             # branch do not affect another branch.
@@ -734,18 +859,27 @@ class QAPISchemaMember:
     """ Represents object members, enum members and features """
     role = 'member'
 
-    def __init__(self, name, info, ifcond=None):
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: Optional[QAPISchemaIfCond] = None,
+    ):
         assert isinstance(name, str)
         self.name = name
         self.info = info
         self.ifcond = ifcond or QAPISchemaIfCond()
-        self.defined_in = None
+        self.defined_in: Optional[str] = None
 
-    def set_defined_in(self, name):
+    def set_defined_in(self, name: str) -> None:
         assert not self.defined_in
         self.defined_in = name
 
-    def check_clash(self, info, seen):
+    def check_clash(
+        self,
+        info: Optional[QAPISourceInfo],
+        seen: Dict[str, QAPISchemaMember],
+    ) -> None:
         cname = c_name(self.name)
         if cname in seen:
             raise QAPISemError(
@@ -754,11 +888,11 @@ def check_clash(self, info, seen):
                 % (self.describe(info), seen[cname].describe(info)))
         seen[cname] = self
 
-    def connect_doc(self, doc):
+    def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
         if doc:
             doc.connect_member(self)
 
-    def describe(self, info):
+    def describe(self, info: Optional[QAPISourceInfo]) -> str:
         role = self.role
         meta = 'type'
         defined_in = self.defined_in
@@ -790,14 +924,20 @@ def describe(self, info):
 class QAPISchemaEnumMember(QAPISchemaMember):
     role = 'value'
 
-    def __init__(self, name, info, ifcond=None, features=None):
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: Optional[QAPISchemaIfCond] = None,
+        features: Optional[List[QAPISchemaFeature]] = None,
+    ):
         super().__init__(name, info, ifcond)
         for f in features or []:
             assert isinstance(f, QAPISchemaFeature)
             f.set_defined_in(name)
         self.features = features or []
 
-    def connect_doc(self, doc):
+    def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
         super().connect_doc(doc)
         if doc:
             for f in self.features:
@@ -807,12 +947,20 @@ def connect_doc(self, doc):
 class QAPISchemaFeature(QAPISchemaMember):
     role = 'feature'
 
-    def is_special(self):
+    def is_special(self) -> bool:
         return self.name in ('deprecated', 'unstable')
 
 
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
-    def __init__(self, name, info, typ, optional, ifcond=None, features=None):
+    def __init__(
+        self,
+        name: str,
+        info: QAPISourceInfo,
+        typ: str,
+        optional: bool,
+        ifcond: Optional[QAPISchemaIfCond] = None,
+        features: Optional[List[QAPISchemaFeature]] = None,
+    ):
         super().__init__(name, info, ifcond)
         assert isinstance(typ, str)
         assert isinstance(optional, bool)
@@ -824,19 +972,19 @@ def __init__(self, name, info, typ, optional, ifcond=None, features=None):
         self.optional = optional
         self.features = features or []
 
-    def need_has(self):
+    def need_has(self) -> bool:
         assert self.type
         return self.optional and self.type.need_has_if_optional()
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         assert self.defined_in
         self.type = schema.resolve_type(self._type_name, self.info,
                                         self.describe)
-        seen = {}
+        seen: Dict[str, QAPISchemaMember] = {}
         for f in self.features:
             f.check_clash(self.info, seen)
 
-    def connect_doc(self, doc):
+    def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
         super().connect_doc(doc)
         if doc:
             for f in self.features:
@@ -846,24 +994,42 @@ def connect_doc(self, doc):
 class QAPISchemaVariant(QAPISchemaObjectTypeMember):
     role = 'branch'
 
-    def __init__(self, name, info, typ, ifcond=None):
+    def __init__(
+        self,
+        name: str,
+        info: QAPISourceInfo,
+        typ: str,
+        ifcond: QAPISchemaIfCond,
+    ):
         super().__init__(name, info, typ, False, ifcond)
 
 
 class QAPISchemaCommand(QAPISchemaDefinition):
     meta = 'command'
 
-    def __init__(self, name, info, doc, ifcond, features,
-                 arg_type, ret_type,
-                 gen, success_response, boxed, allow_oob, allow_preconfig,
-                 coroutine):
+    def __init__(
+        self,
+        name: str,
+        info: QAPISourceInfo,
+        doc: Optional[QAPIDoc],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[str],
+        ret_type: Optional[str],
+        gen: bool,
+        success_response: bool,
+        boxed: bool,
+        allow_oob: bool,
+        allow_preconfig: bool,
+        coroutine: bool,
+    ):
         super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         assert not ret_type or isinstance(ret_type, str)
         self._arg_type_name = arg_type
-        self.arg_type = None
+        self.arg_type: Optional[QAPISchemaObjectType] = None
         self._ret_type_name = ret_type
-        self.ret_type = None
+        self.ret_type: Optional[QAPISchemaType] = None
         self.gen = gen
         self.success_response = success_response
         self.boxed = boxed
@@ -871,7 +1037,7 @@ def __init__(self, name, info, doc, ifcond, features,
         self.allow_preconfig = allow_preconfig
         self.coroutine = coroutine
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         assert self.info is not None
         super().check(schema)
         if self._arg_type_name:
@@ -907,14 +1073,14 @@ def check(self, schema):
                         "command's 'returns' cannot take %s"
                         % self.ret_type.describe())
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_command(
             self.name, self.info, self.ifcond, self.features,
@@ -926,14 +1092,23 @@ def visit(self, visitor):
 class QAPISchemaEvent(QAPISchemaDefinition):
     meta = 'event'
 
-    def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
+    def __init__(
+        self,
+        name: str,
+        info: QAPISourceInfo,
+        doc: Optional[QAPIDoc],
+        ifcond: QAPISchemaIfCond,
+        features: List[QAPISchemaFeature],
+        arg_type: Optional[str],
+        boxed: bool,
+    ):
         super().__init__(name, info, doc, ifcond, features)
         assert not arg_type or isinstance(arg_type, str)
         self._arg_type_name = arg_type
-        self.arg_type = None
+        self.arg_type: Optional[QAPISchemaObjectType] = None
         self.boxed = boxed
 
-    def check(self, schema):
+    def check(self, schema: QAPISchema) -> None:
         super().check(schema)
         if self._arg_type_name:
             typ = schema.resolve_type(
@@ -955,14 +1130,14 @@ def check(self, schema):
                     self.info,
                     "conditional event arguments require 'boxed': true")
 
-    def connect_doc(self, doc=None):
+    def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
         if doc:
             if self.arg_type and self.arg_type.is_implicit():
                 self.arg_type.connect_doc(doc)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_event(
             self.name, self.info, self.ifcond, self.features,
@@ -970,7 +1145,7 @@ def visit(self, visitor):
 
 
 class QAPISchema:
-    def __init__(self, fname):
+    def __init__(self, fname: str):
         self.fname = fname
 
         try:
@@ -982,9 +1157,9 @@ def __init__(self, fname):
 
         exprs = check_exprs(parser.exprs)
         self.docs = parser.docs
-        self._entity_list = []
-        self._entity_dict = {}
-        self._module_dict = OrderedDict()
+        self._entity_list: List[QAPISchemaEntity] = []
+        self._entity_dict: Dict[str, QAPISchemaDefinition] = {}
+        self._module_dict: Dict[str, QAPISchemaModule] = OrderedDict()
         self._schema_dir = os.path.dirname(fname)
         self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
         self._make_module(fname)
@@ -994,10 +1169,10 @@ def __init__(self, fname):
         self._def_exprs(exprs)
         self.check()
 
-    def _def_entity(self, ent):
+    def _def_entity(self, ent: QAPISchemaEntity) -> None:
         self._entity_list.append(ent)
 
-    def _def_definition(self, defn):
+    def _def_definition(self, defn: QAPISchemaDefinition) -> None:
         # Only the predefined types are allowed to not have info
         assert defn.info or self._predefining
         self._def_entity(defn)
@@ -1014,18 +1189,27 @@ def _def_definition(self, defn):
                 defn.info, "%s is already defined" % other_defn.describe())
         self._entity_dict[defn.name] = defn
 
-    def lookup_entity(self, name, typ=None):
+    def lookup_entity(
+        self,
+        name: str,
+        typ: Optional[type] = None,
+    ) -> Optional[QAPISchemaEntity]:
         ent = self._entity_dict.get(name)
         if typ and not isinstance(ent, typ):
             return None
         return ent
 
-    def lookup_type(self, name):
+    def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
         typ = self.lookup_entity(name, QAPISchemaType)
         assert typ is None or isinstance(typ, QAPISchemaType)
         return typ
 
-    def resolve_type(self, name, info=None, what=None):
+    def resolve_type(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo] = None,
+        what: Union[None, str, Callable[[QAPISourceInfo], str]] = None,
+    ) -> QAPISchemaType:
         typ = self.lookup_type(name)
         if not typ:
             assert info and what  # built-in types must not fail lookup
@@ -1040,23 +1224,25 @@ def _module_name(self, fname: str) -> str:
             return fname
         return os.path.relpath(fname, self._schema_dir)
 
-    def _make_module(self, fname):
+    def _make_module(self, fname: str) -> QAPISchemaModule:
         name = self._module_name(fname)
         if name not in self._module_dict:
             self._module_dict[name] = QAPISchemaModule(name)
         return self._module_dict[name]
 
-    def module_by_fname(self, fname):
+    def module_by_fname(self, fname: str) -> QAPISchemaModule:
         name = self._module_name(fname)
         return self._module_dict[name]
 
-    def _def_include(self, expr: QAPIExpression):
+    def _def_include(self, expr: QAPIExpression) -> None:
         include = expr['include']
         assert expr.doc is None
         self._def_entity(
             QAPISchemaInclude(self._make_module(include), expr.info))
 
-    def _def_builtin_type(self, name, json_type, c_type):
+    def _def_builtin_type(
+        self, name: str, json_type: str, c_type: str
+    ) -> None:
         self._def_definition(QAPISchemaBuiltinType(name, json_type, c_type))
         # Instantiating only the arrays that are actually used would
         # be nice, but we can't as long as their generated code
@@ -1064,7 +1250,7 @@ def _def_builtin_type(self, name, json_type, c_type):
         # schema.
         self._make_array_type(name, None)
 
-    def _def_predefineds(self):
+    def _def_predefineds(self) -> None:
         for t in [('str',    'string',  'char' + POINTER_SUFFIX),
                   ('number', 'number',  'double'),
                   ('int',    'int',     'int64_t'),
@@ -1093,31 +1279,52 @@ def _def_predefineds(self):
         self._def_definition(QAPISchemaEnumType(
             'QType', None, None, None, None, qtype_values, 'QTYPE'))
 
-    def _make_features(self, features, info):
+    def _make_features(
+        self,
+        features: Optional[List[Dict[str, Any]]],
+        info: Optional[QAPISourceInfo],
+    ) -> List[QAPISchemaFeature]:
         if features is None:
             return []
         return [QAPISchemaFeature(f['name'], info,
                                   QAPISchemaIfCond(f.get('if')))
                 for f in features]
 
-    def _make_enum_member(self, name, ifcond, features, info):
+    def _make_enum_member(
+        self,
+        name: str,
+        ifcond: Optional[Union[str, Dict[str, Any]]],
+        features: Optional[List[Dict[str, Any]]],
+        info: Optional[QAPISourceInfo],
+    ) -> QAPISchemaEnumMember:
         return QAPISchemaEnumMember(name, info,
                                     QAPISchemaIfCond(ifcond),
                                     self._make_features(features, info))
 
-    def _make_enum_members(self, values, info):
+    def _make_enum_members(
+        self, values: List[Dict[str, Any]], info: Optional[QAPISourceInfo]
+    ) -> List[QAPISchemaEnumMember]:
         return [self._make_enum_member(v['name'], v.get('if'),
                                        v.get('features'), info)
                 for v in values]
 
-    def _make_array_type(self, element_type, info):
+    def _make_array_type(
+        self, element_type: str, info: Optional[QAPISourceInfo]
+    ) -> str:
         name = element_type + 'List'    # reserved by check_defn_name_str()
         if not self.lookup_type(name):
             self._def_definition(QAPISchemaArrayType(
                 name, info, element_type))
         return name
 
-    def _make_implicit_object_type(self, name, info, ifcond, role, members):
+    def _make_implicit_object_type(
+        self,
+        name: str,
+        info: QAPISourceInfo,
+        ifcond: QAPISchemaIfCond,
+        role: str,
+        members: List[QAPISchemaObjectTypeMember],
+    ) -> Optional[str]:
         if not members:
             return None
         # See also QAPISchemaObjectTypeMember.describe()
@@ -1133,7 +1340,7 @@ def _make_implicit_object_type(self, name, info, ifcond, role, members):
                 name, info, None, ifcond, None, None, members, None))
         return name
 
-    def _def_enum_type(self, expr: QAPIExpression):
+    def _def_enum_type(self, expr: QAPIExpression) -> None:
         name = expr['enum']
         data = expr['data']
         prefix = expr.get('prefix')
@@ -1144,7 +1351,14 @@ def _def_enum_type(self, expr: QAPIExpression):
             name, info, expr.doc, ifcond, features,
             self._make_enum_members(data, info), prefix))
 
-    def _make_member(self, name, typ, ifcond, features, info):
+    def _make_member(
+        self,
+        name: str,
+        typ: Union[List[str], str],
+        ifcond: QAPISchemaIfCond,
+        features: Optional[List[Dict[str, Any]]],
+        info: QAPISourceInfo,
+    ) -> QAPISchemaObjectTypeMember:
         optional = False
         if name.startswith('*'):
             name = name[1:]
@@ -1155,13 +1369,17 @@ def _make_member(self, name, typ, ifcond, features, info):
         return QAPISchemaObjectTypeMember(name, info, typ, optional, ifcond,
                                           self._make_features(features, info))
 
-    def _make_members(self, data, info):
+    def _make_members(
+        self,
+        data: Dict[str, Any],
+        info: QAPISourceInfo,
+    ) -> List[QAPISchemaObjectTypeMember]:
         return [self._make_member(key, value['type'],
                                   QAPISchemaIfCond(value.get('if')),
                                   value.get('features'), info)
                 for (key, value) in data.items()]
 
-    def _def_struct_type(self, expr: QAPIExpression):
+    def _def_struct_type(self, expr: QAPIExpression) -> None:
         name = expr['struct']
         base = expr.get('base')
         data = expr['data']
@@ -1173,13 +1391,19 @@ def _def_struct_type(self, expr: QAPIExpression):
             self._make_members(data, info),
             None))
 
-    def _make_variant(self, case, typ, ifcond, info):
+    def _make_variant(
+        self,
+        case: str,
+        typ: str,
+        ifcond: QAPISchemaIfCond,
+        info: QAPISourceInfo,
+    ) -> QAPISchemaVariant:
         if isinstance(typ, list):
             assert len(typ) == 1
             typ = self._make_array_type(typ[0], info)
         return QAPISchemaVariant(case, info, typ, ifcond)
 
-    def _def_union_type(self, expr: QAPIExpression):
+    def _def_union_type(self, expr: QAPIExpression) -> None:
         name = expr['union']
         base = expr['base']
         tag_name = expr['discriminator']
@@ -1204,7 +1428,7 @@ def _def_union_type(self, expr: QAPIExpression):
                                  QAPISchemaVariants(
                                      tag_name, info, None, variants)))
 
-    def _def_alternate_type(self, expr: QAPIExpression):
+    def _def_alternate_type(self, expr: QAPIExpression) -> None:
         name = expr['alternate']
         data = expr['data']
         assert isinstance(data, dict)
@@ -1222,7 +1446,7 @@ def _def_alternate_type(self, expr: QAPIExpression):
                 name, info, expr.doc, ifcond, features,
                 QAPISchemaVariants(None, info, tag_member, variants)))
 
-    def _def_command(self, expr: QAPIExpression):
+    def _def_command(self, expr: QAPIExpression) -> None:
         name = expr['command']
         data = expr.get('data')
         rets = expr.get('returns')
@@ -1247,7 +1471,7 @@ def _def_command(self, expr: QAPIExpression):
                               rets, gen, success_response, boxed, allow_oob,
                               allow_preconfig, coroutine))
 
-    def _def_event(self, expr: QAPIExpression):
+    def _def_event(self, expr: QAPIExpression) -> None:
         name = expr['event']
         data = expr.get('data')
         boxed = expr.get('boxed', False)
@@ -1261,7 +1485,7 @@ def _def_event(self, expr: QAPIExpression):
         self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifcond,
                                              features, data, boxed))
 
-    def _def_exprs(self, exprs):
+    def _def_exprs(self, exprs: List[QAPIExpression]) -> None:
         for expr in exprs:
             if 'enum' in expr:
                 self._def_enum_type(expr)
@@ -1280,7 +1504,7 @@ def _def_exprs(self, exprs):
             else:
                 assert False
 
-    def check(self):
+    def check(self) -> None:
         for ent in self._entity_list:
             ent.check(self)
             ent.connect_doc()
@@ -1288,7 +1512,7 @@ def check(self):
         for ent in self._entity_list:
             ent.set_module(self)
 
-    def visit(self, visitor):
+    def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_begin(self)
         for mod in self._module_dict.values():
             mod.visit(visitor)
-- 
2.43.0


