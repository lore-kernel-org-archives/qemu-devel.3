Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82294C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3S-0005XM-H6; Fri, 04 Sep 2026 15:58:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3P-0005Vx-RB
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3N-0007pz-B7
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551904;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0IyI6tQXCcNeMsf0ck978vGP4A8R508BayNZWAOWYnM=;
 b=NjHTzPJJF+nEAMMNU5o/mLaTRPiHXK2xuYqN8Qe1vn+kjHhPaInDqHpWCaXxXlp2Nh/spS
 MwF3E7/qliZlHKLJIu5F27siEdepWDuW4POv//avC5dbPkYQKu1fYHB/1h6XwZ4qjxM5SS
 EOsFHtMrlfBHZE2AqA/Syaz+qrbyjS4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-677-elo1RT8BPheZvapTsE5PXQ-1; Fri,
 04 Sep 2026 15:58:20 -0400
X-MC-Unique: elo1RT8BPheZvapTsE5PXQ-1
X-Mimecast-MFC-AGG-ID: elo1RT8BPheZvapTsE5PXQ_1788551899
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B311E18E9B2B; Fri,  4 Sep 2026 19:58:19 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C24C30002F5; Fri,  4 Sep 2026 19:58:18 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:46 +0400
Subject: [PATCH v4 03/75] qapi: factor out QAPISchemaUsedTypes from
 introspect visitor
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-3-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=17542;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=orSwB5aVnFipZW88PWn4H8cUfTf992qsMca5g88dS5A=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLI2F68UM1CoFwHNFUZLsxrpgTROoHLwMJUM
 hZgp1TLHFCJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5V6xD/4mEeWO5g0GfZkQLLUNFlT6W7c6NR2fjniVW6tTJrfVokpn6ogjwnS0qkPCnuwZIMSGIny
 vE0Hqj6MphcBZJXVt54WUZWxmAH3gKglVNmjGXG4UjNV+TosOIKrJxyCnFrsy4fi86iLHY0pYpc
 RWwmZMK+Hv/fuirEChoAkTVNYX0l9+hJmhsWl+D4R1kLinx29NqZVyEdhm8R86dPQ5AGdBYVm2n
 fcuthW3uQ0R3K0CpNSVPoVa0DXG8SKCSYtnQFBu8yK5omgU7mJkQRtBqiWGMl0DakMff6lCOa3n
 W8nhfLmBEeGBhxiMjO0Fh1qbDnnDjx9sbUJby3qhnzcpK5Xo3mpwLnPYcBguvK9znX5OazqoRgE
 O3NGU24KP/ZBPAQ2MtrrdXhVcy4OpzfbiNR8W0KAutoNutVtB7DWyuUafLm58jLVVJ1XhPp8K0x
 H+Yp3Pc7/HUClGnIDfbpwaQMmToONiwShnu4u7uy8Y9VcIu+bif+Rchwr00FISb7J/SZLoms6W2
 S8hqzuIXOI9DfsRUTVGdStw6xZ8xmBLJ0PjqtZWwGJbT/9gv3Et6YM5yENu/cjMegj7ArEAkFXW
 fiELL2b7CdGhQAxAL35V/Bz+WxdQLrJ4rLkzR3fMtSVJgVzYTBux6RDyAaMns/uBkcch/ZDMqp0
 oJctONf/6W85YRQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Move QMP-reachable type tracking and name masking out of the introspect
visitor into a standalone QAPISchemaUsedTypes visitor in a new
schema_analysis module. Run the analysis pass in QAPICBackend.generate()
in preparation for other generators.

While at it, refactor a bit the code to make it easier to read, and
optimize using _used_type_set for O(1) lookups.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 meson.build                     |   1 +
 scripts/qapi/backend.py         |   7 +-
 scripts/qapi/introspect.py      |  78 +++++--------------
 scripts/qapi/schema_analysis.py | 164 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 191 insertions(+), 59 deletions(-)

diff --git a/meson.build b/meson.build
index 5c9de307b081..e797f84a4084 100644
--- a/meson.build
+++ b/meson.build
@@ -3504,6 +3504,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/main.py',
                      meson.current_source_dir() / 'scripts/qapi/parser.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
+                     meson.current_source_dir() / 'scripts/qapi/schema_analysis.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 49ae6ecdd33e..59329965890f 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -8,6 +8,7 @@
 from .features import gen_features
 from .introspect import gen_introspect
 from .schema import QAPISchema
+from .schema_analysis import QAPISchemaUsedTypes
 from .types import gen_types
 from .visit import gen_visit
 
@@ -49,7 +50,7 @@ def generate(self,
         """
         Generate C code for the given schema into the target directory.
 
-        :param schema_file: The primary QAPI schema file.
+        :param schema: The primary QAPI schema file.
         :param output_dir: The output directory to store generated code.
         :param prefix: Optional C-code prefix for symbol names.
         :param unmask: Expose non-ABI names through introspection?
@@ -57,9 +58,11 @@ def generate(self,
 
         :raise QAPIError: On failures.
         """
+        schema_types = QAPISchemaUsedTypes(unmask)
+        schema.visit(schema_types)
         gen_types(schema, output_dir, prefix, builtins)
         gen_features(schema, output_dir, prefix)
         gen_visit(schema, output_dir, prefix, builtins)
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
-        gen_introspect(schema, output_dir, prefix, unmask)
+        gen_introspect(schema, output_dir, prefix, schema_types)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 7e28de2279ad..9e76e3aa38a9 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -28,9 +28,7 @@
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,
-    QAPISchemaArrayType,
     QAPISchemaBranches,
-    QAPISchemaBuiltinType,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
@@ -40,6 +38,7 @@
     QAPISchemaType,
     QAPISchemaVariant,
 )
+from .schema_analysis import QAPISchemaUsedTypes
 from .source import QAPISourceInfo
 
 
@@ -169,15 +168,13 @@ def to_c_string(string: str) -> str:
 
 class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
 
-    def __init__(self, prefix: str, unmask: bool):
+    def __init__(self, prefix: str, schema_types: QAPISchemaUsedTypes):
         super().__init__(
             prefix, 'qapi-introspect',
             ' * QAPI/QMP schema introspection', __doc__)
-        self._unmask = unmask
+        self._schema_types = schema_types
         self._schema: Optional[QAPISchema] = None
         self._trees: List[Annotated[SchemaInfo]] = []
-        self._used_types: List[QAPISchemaType] = []
-        self._name_map: Dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -190,7 +187,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
 
     def visit_end(self) -> None:
         # visit the types that are actually used
-        for typ in self._used_types:
+        for typ in self._schema_types.used_types():
             typ.visit(self)
         # generate C
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
@@ -207,45 +204,11 @@ def visit_end(self) -> None:
                              c_string=_tree_to_qlit(self._trees)))
         self._schema = None
         self._trees = []
-        self._used_types = []
-        self._name_map = {}
 
     def visit_needed(self, entity: QAPISchemaEntity) -> bool:
         # Ignore types on first pass; visit_end() will pick up used types
         return not isinstance(entity, QAPISchemaType)
 
-    def _name(self, name: str) -> str:
-        if self._unmask:
-            return name
-        if name not in self._name_map:
-            self._name_map[name] = '%d' % len(self._name_map)
-        return self._name_map[name]
-
-    def _use_type(self, typ: QAPISchemaType) -> str:
-        assert self._schema is not None
-
-        # Map the various integer types to plain int
-        if typ.json_type() == 'int':
-            type_int = self._schema.lookup_type('int')
-            assert type_int
-            typ = type_int
-        elif (isinstance(typ, QAPISchemaArrayType) and
-              typ.element_type.json_type() == 'int'):
-            type_intlist = self._schema.lookup_type('intList')
-            assert type_intlist
-            typ = type_intlist
-        # Add type to work queue if new
-        if typ not in self._used_types:
-            self._used_types.append(typ)
-        # Clients should examine commands and events, not types.  Hide
-        # type names as integers to reduce the temptation.  Also, it
-        # saves a few characters on the wire.
-        if isinstance(typ, QAPISchemaBuiltinType):
-            return typ.name
-        if isinstance(typ, QAPISchemaArrayType):
-            return '[' + self._use_type(typ.element_type) + ']'
-        return self._name(typ.name)
-
     @staticmethod
     def _gen_features(features: Sequence[QAPISchemaFeature]
                       ) -> List[Annotated[str]]:
@@ -267,11 +230,10 @@ def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
         """
         comment: Optional[str] = None
         if mtype not in ('command', 'event', 'builtin', 'array'):
-            if not self._unmask:
-                # Output a comment to make it easy to map masked names
-                # back to the source when reading the generated output.
-                comment = f'"{self._name(name)}" = {name}'
-            name = self._name(name)
+            masked = self._schema_types.masked_name(name)
+            if masked != name:
+                comment = f'"{masked}" = {name}'
+            name = masked
         obj['name'] = name
         obj['meta-type'] = mtype
         if features:
@@ -291,7 +253,7 @@ def _gen_object_member(self, member: QAPISchemaObjectTypeMember
                            ) -> Annotated[SchemaInfoObjectMember]:
         obj: SchemaInfoObjectMember = {
             'name': member.name,
-            'type': self._use_type(member.type)
+            'type': self._schema_types.introspection_name(member.type)
         }
         if member.optional:
             obj['default'] = None
@@ -303,7 +265,7 @@ def _gen_variant(self, variant: QAPISchemaVariant
                      ) -> Annotated[SchemaInfoObjectVariant]:
         obj: SchemaInfoObjectVariant = {
             'case': variant.name,
-            'type': self._use_type(variant.type)
+            'type': self._schema_types.introspection_name(variant.type)
         }
         return Annotated(obj, variant.ifcond)
 
@@ -326,7 +288,7 @@ def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: QAPISchemaIfCond,
                          element_type: QAPISchemaType) -> None:
-        element = self._use_type(element_type)
+        element = self._schema_types.introspection_name(element_type)
         self._gen_tree('[' + element + ']', 'array', {'element-type': element},
                        ifcond)
 
@@ -349,8 +311,9 @@ def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
                              alternatives: QAPISchemaAlternatives) -> None:
         self._gen_tree(
             name, 'alternate',
-            {'members': [Annotated({'type': self._use_type(m.type)},
-                                   m.ifcond)
+            {'members': [Annotated({
+                'type': self._schema_types.introspection_name(m.type)
+            }, m.ifcond)
                          for m in alternatives.variants]},
             ifcond, features
         )
@@ -367,8 +330,8 @@ def visit_command(self, name: str, info: Optional[QAPISourceInfo],
         arg_type = arg_type or self._schema.the_empty_object_type
         ret_type = ret_type or self._schema.the_empty_object_type
         obj: SchemaInfoCommand = {
-            'arg-type': self._use_type(arg_type),
-            'ret-type': self._use_type(ret_type)
+            'arg-type': self._schema_types.introspection_name(arg_type),
+            'ret-type': self._schema_types.introspection_name(ret_type)
         }
         if allow_oob:
             obj['allow-oob'] = allow_oob
@@ -382,12 +345,13 @@ def visit_event(self, name: str, info: Optional[QAPISourceInfo],
         assert self._schema is not None
 
         arg_type = arg_type or self._schema.the_empty_object_type
-        self._gen_tree(name, 'event', {'arg-type': self._use_type(arg_type)},
-                       ifcond, features)
+        self._gen_tree(name, 'event', {
+            'arg-type': self._schema_types.introspection_name(arg_type)
+        }, ifcond, features)
 
 
 def gen_introspect(schema: QAPISchema, output_dir: str, prefix: str,
-                   opt_unmask: bool) -> None:
-    vis = QAPISchemaGenIntrospectVisitor(prefix, opt_unmask)
+                   schema_types: QAPISchemaUsedTypes) -> None:
+    vis = QAPISchemaGenIntrospectVisitor(prefix, schema_types)
     schema.visit(vis)
     vis.write(output_dir)
diff --git a/scripts/qapi/schema_analysis.py b/scripts/qapi/schema_analysis.py
new file mode 100644
index 000000000000..7e42abbc14e1
--- /dev/null
+++ b/scripts/qapi/schema_analysis.py
@@ -0,0 +1,164 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+"""
+Collect introspectable types from a QAPI schema and assign masked names.
+
+Copyright (C) 2015-2026 Red Hat, Inc.
+
+Authors:
+ Markus Armbruster <armbru@redhat.com>
+ John Snow <jsnow@redhat.com>
+ Marc-André Lureau <marcandre.lureau@redhat.com>
+"""
+
+from typing import (
+    Dict,
+    List,
+    Optional,
+    Sequence,
+    Set,
+)
+
+from .schema import (
+    QAPISchema,
+    QAPISchemaAlternatives,
+    QAPISchemaArrayType,
+    QAPISchemaBranches,
+    QAPISchemaBuiltinType,
+    QAPISchemaEntity,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVisitor,
+)
+from .source import QAPISourceInfo
+
+
+class QAPISchemaUsedTypes(QAPISchemaVisitor):
+    """Collect the set of QMP-reachable types from a schema.
+
+    Types are discovered transitively starting from commands and events.
+    Each type is also given a masked introspection name (an integer
+    string).
+    """
+
+    def __init__(self, unmask: bool):
+        self._unmask = unmask
+        self._schema: Optional[QAPISchema] = None
+        # Ordered list + set: insert during iteration + O(1) check
+        self._used_types: List[QAPISchemaType] = []
+        self._used_types_set: Set[QAPISchemaType] = set()
+        self._name_map: Dict[str, str] = {}
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        self._schema = schema
+        self._used_types = []
+        self._used_types_set = set()
+        self._name_map = {}
+
+    def visit_end(self) -> None:
+        assert self._schema is not None
+        # Discover transitively-used types; the list grows as
+        # visiting each type registers the types it references.
+        for typ in self._used_types:
+            typ.visit(self)
+        # Assign stable masked names now that all types are known
+        counter = 0
+        for typ in self._used_types:
+            if isinstance(typ, (QAPISchemaBuiltinType, QAPISchemaArrayType)):
+                continue
+            self._name_map[typ.name] = (
+                typ.name if self._unmask else str(counter))
+            counter += 1
+
+    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
+        # Skip types during main traversal; visit_end() handles them
+        return not isinstance(entity, QAPISchemaType)
+
+    def visit_command(self, name: str, info: Optional[QAPISourceInfo],
+                      ifcond: QAPISchemaIfCond,
+                      features: List[QAPISchemaFeature],
+                      arg_type: Optional[QAPISchemaObjectType],
+                      ret_type: Optional[QAPISchemaType], gen: bool,
+                      success_response: bool, boxed: bool, allow_oob: bool,
+                      allow_preconfig: bool, coroutine: bool) -> None:
+        assert self._schema is not None
+        self._register_type(arg_type or self._schema.the_empty_object_type)
+        self._register_type(ret_type or self._schema.the_empty_object_type)
+
+    def visit_event(self, name: str, info: Optional[QAPISourceInfo],
+                    ifcond: QAPISchemaIfCond,
+                    features: List[QAPISchemaFeature],
+                    arg_type: Optional[QAPISchemaObjectType],
+                    boxed: bool) -> None:
+        assert self._schema is not None
+        self._register_type(arg_type or self._schema.the_empty_object_type)
+
+    def visit_object_type_flat(
+            self, name: str, info: Optional[QAPISourceInfo],
+            ifcond: QAPISchemaIfCond,
+            features: List[QAPISchemaFeature],
+            members: List[QAPISchemaObjectTypeMember],
+            branches: Optional[QAPISchemaBranches]) -> None:
+        for m in members:
+            self._register_type(m.type)
+        if branches:
+            for v in branches.variants:
+                self._register_type(v.type)
+
+    def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
+                         ifcond: QAPISchemaIfCond,
+                         element_type: QAPISchemaType) -> None:
+        self._register_type(element_type)
+
+    def visit_alternate_type(
+            self, name: str, info: Optional[QAPISourceInfo],
+            ifcond: QAPISchemaIfCond,
+            features: List[QAPISchemaFeature],
+            alternatives: QAPISchemaAlternatives) -> None:
+        for m in alternatives.variants:
+            self._register_type(m.type)
+
+    def _register_type(self, typ: QAPISchemaType) -> None:
+        """Record a type as QMP-reachable (idempotent)."""
+        typ = self._canonicalize_type(typ)
+        if typ not in self._used_types_set:
+            self._used_types.append(typ)
+            self._used_types_set.add(typ)
+            if isinstance(typ, QAPISchemaArrayType):
+                self._register_type(typ.element_type)
+
+    def _canonicalize_type(self, typ: QAPISchemaType) -> QAPISchemaType:
+        """Canonicalize integer types to plain int."""
+        assert self._schema is not None
+        if typ.json_type() == 'int':
+            type_int = self._schema.lookup_type('int')
+            assert type_int
+            return type_int
+        if (isinstance(typ, QAPISchemaArrayType) and
+                typ.element_type.json_type() == 'int'):
+            type_intlist = self._schema.lookup_type('intList')
+            assert type_intlist
+            return type_intlist
+        return typ
+
+    def masked_name(self, name: str) -> str:
+        """Return the masked name for a non-builtin, non-array type."""
+        assert name in self._name_map, \
+            f"type '{name}' was not registered or is builtin/array"
+        return self._name_map[name]
+
+    def introspection_name(self, typ: QAPISchemaType) -> str:
+        """Return the introspection name for a type."""
+        typ = self._canonicalize_type(typ)
+        if isinstance(typ, QAPISchemaBuiltinType):
+            return typ.name
+        if isinstance(typ, QAPISchemaArrayType):
+            return '[' + self.introspection_name(typ.element_type) + ']'
+        assert typ in self._used_types_set
+        return self.masked_name(typ.name)
+
+    def used_types(self) -> Sequence[QAPISchemaType]:
+        """Return the types to include in QAPI introspection."""
+        return self._used_types

-- 
2.55.0.543.g5ebe2ebe4ea8


