Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36A8606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fsnM7Exd
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNc16-0005l8-8A; Sun, 01 Nov 2026 15:19:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzn-0004yG-OT
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbze-0007Be-1Q
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XnJifS1G7liQbYvSnt6tKc8iG7M6FUaHuIdhs0nco7k=;
 b=fsnM7ExdFGp93mHpUCt/+x3hd81xiEi1BRfOPn2ARUATj3d/ty5PO9sM8USNupIG/uN8BS
 lD23IioVS+vKzGxcpcR2YaPAdwUeDn6tAV6baCC3wmnU0ltPhBbG+j7Lju+Wgbe/KdQB/9
 fq+b1nU9q92Du+8Qsj3IuNSoeAt4Gb4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-4r2IMbpYPZqegH9cHIaJ0Q-1; Sun,
 01 Nov 2026 15:17:24 -0500
X-MC-Unique: 4r2IMbpYPZqegH9cHIaJ0Q-1
X-Mimecast-MFC-AGG-ID: 4r2IMbpYPZqegH9cHIaJ0Q_1793564243
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A7B3A1955F54
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 25A2F1800586
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B7F0621E6888; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 09/56] qapi: add type-infos generator
Date: Sun,  1 Nov 2026 21:16:30 +0100
Message-ID: <20261101201717.3911097-10-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

New QAPISchemaGenTypeInfoVisitor produces per-module
qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
pairing the QAPI type name with its masked introspection name.

We want per-module .h for less recompiling when we touch QAPI types.
Unfortunately, the per-module .c usually all change then, because the
masked names all change.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst  |  87 ++++++++++++++++++++
 meson.build                   |   1 +
 qapi/meson.build              |   4 +
 qga/meson.build               |   2 +
 scripts/qapi/backend.py       |   2 +
 scripts/qapi/type_infos.py    | 149 ++++++++++++++++++++++++++++++++++
 tests/include/meson.build     |   2 +
 tests/meson.build             |   6 ++
 tests/qapi-schema/meson.build |   1 +
 9 files changed, 254 insertions(+)
 create mode 100644 scripts/qapi/type_infos.py

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 3c21dda91b..fc3a1dd6d8 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1250,6 +1250,9 @@ JSON array of strings.
 To examine a type, start with a command or event using it, then follow
 references by name.
 
+.. TODO document QOM introspection (qom-list, qom-list-properties,
+   qom-get) and how it relates to QAPI type information.
+
 The SchemaInfo for a command has meta-type "command", and variant
 members "arg-type", "ret-type" and "allow-oob".  On the wire, the
 "arguments" member of a client's "execute" command must conform to the
@@ -2087,3 +2090,87 @@ Example::
     }));
 
     [Uninteresting stuff omitted...]
+
+
+Code generated for type information
+-----------------------------------
+
+Type information is generated for user-defined types and their array
+types.  With option --builtins, it is also generated for the built-in
+types.
+
+The following files are created:
+
+ ``$(prefix)qapi-type-infos.c``
+     A ``QAPITypeInfo`` instance for each type listed above, providing
+     a mapping between the QAPI type name and the masked name used by
+     introspection, along with optional enum lookup table and array
+     type pointers.
+
+ ``$(prefix)qapi-type-infos.h``
+     Declarations for the above type info instances
+
+Each ``QAPITypeInfo`` struct has the following fields:
+
+``name``
+    The QAPI type name (e.g. ``"UserDefOne"``).
+
+``masked_name``
+    The masked name used in ``query-qmp-schema`` output.
+
+``lookup``
+    For enum types, a pointer to the corresponding ``QEnumLookup``
+    table.  ``NULL`` for non-enum types.
+
+These type info instances are used by QOM property registration
+functions (``object_property_add()``,
+``object_class_property_add_enum()``, etc.) to associate each property
+with its QAPI type.  The ``qom-list`` and ``device-list-properties``
+QMP commands then expose the ``qapi-type`` field, giving management
+tools a formal type reference they can look up in the introspection
+schema.
+
+Example::
+
+    $ cat qapi-generated/example-qapi-type-infos.h
+    [Uninteresting stuff omitted...]
+
+    #ifndef EXAMPLE_QAPI_TYPE_INFOS_H
+    #define EXAMPLE_QAPI_TYPE_INFOS_H
+
+    #include "qapi/qapi-builtin-type-infos.h"
+
+    extern const QAPITypeInfo UserDefOne_type_info;
+
+    extern const QAPITypeInfo UserDefOneList_type_info;
+
+    #endif /* EXAMPLE_QAPI_TYPE_INFOS_H */
+    $ cat qapi-generated/example-qapi-type-infos.c
+    [Uninteresting stuff omitted...]
+
+    const QAPITypeInfo UserDefOne_type_info = {
+        .name = "UserDefOne",
+        .masked_name = "32",
+    };
+
+    const QAPITypeInfo UserDefOneList_type_info = {
+        .name = "UserDefOneList",
+        .masked_name = "[32]",
+    };
+
+    [Uninteresting stuff omitted...]
+
+For a modular QAPI schema (see section `Include directives`_), code for
+each sub-module SUBDIR/SUBMODULE.json is actually generated into ::
+
+ SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.h
+ SUBDIR/$(prefix)qapi-type-infos-SUBMODULE.c
+
+If qapi-gen.py is run with option --builtins, additional files are
+created:
+
+ ``qapi-builtin-type-infos.h``
+     Type info instances for built-in types
+
+ ``qapi-builtin-type-infos.c``
+     Definitions for the above type info instances
diff --git a/meson.build b/meson.build
index 7ec3fb9023..2af6f2af01 100644
--- a/meson.build
+++ b/meson.build
@@ -3522,6 +3522,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/parser.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
+                     meson.current_source_dir() / 'scripts/qapi/type_infos.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
diff --git a/qapi/meson.build b/qapi/meson.build
index a46269b5a0..7477953492 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -79,6 +79,7 @@ endif
 
 qapi_nonmodule_outputs = [
   'qapi-introspect.c', 'qapi-introspect.h',
+  'qapi-type-infos.c', 'qapi-type-infos.h',
   'qapi-types.c', 'qapi-types.h',
   'qapi-visit.h', 'qapi-visit.c',
   'qapi-commands.h', 'qapi-commands.c',
@@ -88,6 +89,7 @@ qapi_nonmodule_outputs = [
 ]
 
 qapi_outputs = qapi_nonmodule_outputs + [
+  'qapi-builtin-type-infos.c', 'qapi-builtin-type-infos.h',
   'qapi-builtin-types.c', 'qapi-builtin-visit.c',
   'qapi-builtin-types.h', 'qapi-builtin-visit.h',
 ]
@@ -96,6 +98,8 @@ qapi_inputs = []
 foreach module : qapi_all_modules
   qapi_inputs += [ files(module + '.json') ]
   qapi_module_outputs = [
+    'qapi-type-infos-@0@.c'.format(module),
+    'qapi-type-infos-@0@.h'.format(module),
     'qapi-types-@0@.c'.format(module),
     'qapi-types-@0@.h'.format(module),
     'qapi-visit-@0@.c'.format(module),
diff --git a/qga/meson.build b/qga/meson.build
index a046ebe305..5cc43b87df 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -39,6 +39,8 @@ qga_qapi_outputs = [
   'qga-qapi-init-commands.h',
   'qga-qapi-introspect.c',
   'qga-qapi-introspect.h',
+  'qga-qapi-type-infos.c',
+  'qga-qapi-type-infos.h',
   'qga-qapi-types.c',
   'qga-qapi-types.h',
   'qga-qapi-visit.c',
diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 49ae6ecdd3..508ab21735 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -8,6 +8,7 @@
 from .features import gen_features
 from .introspect import gen_introspect
 from .schema import QAPISchema
+from .type_infos import gen_type_infos
 from .types import gen_types
 from .visit import gen_visit
 
@@ -63,3 +64,4 @@ def generate(self,
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
         gen_introspect(schema, output_dir, prefix, unmask)
+        gen_type_infos(schema, output_dir, prefix, builtins, unmask)
diff --git a/scripts/qapi/type_infos.py b/scripts/qapi/type_infos.py
new file mode 100644
index 0000000000..d9ed16d185
--- /dev/null
+++ b/scripts/qapi/type_infos.py
@@ -0,0 +1,149 @@
+"""
+QAPI type info generator
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+
+from typing import List, Optional
+
+from .common import c_name, mcgen
+from .gen import QAPISchemaModularCVisitor, ifcontext
+from .schema import (
+    QAPISchema,
+    QAPISchemaAlternatives,
+    QAPISchemaBranches,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+)
+from .source import QAPISourceInfo
+
+
+class QAPISchemaGenTypeInfoVisitor(QAPISchemaModularCVisitor):
+
+    def __init__(self, prefix: str, unmask: bool):
+        super().__init__(
+            prefix, 'qapi-type-infos',
+            ' * Schema-defined QAPI type info',
+            ' * Built-in QAPI type info', __doc__)
+        self._unmask = unmask
+        self._schema: Optional[QAPISchema] = None
+
+    def visit_begin(self, schema: QAPISchema) -> None:
+        super().visit_begin(schema)
+        self._schema = schema
+
+    def _begin_builtin_module(self) -> None:
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "qapi/qapi-builtin-types.h"
+#include "qapi/qapi-builtin-type-infos.h"
+'''))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/qapi-type-info.h"
+'''))
+
+    def _begin_user_module(self, name: str) -> None:
+        type_infos = self._module_basename('qapi-type-infos', name)
+        types = self._module_basename('qapi-types', name)
+        self._genc.preamble_add(mcgen('''
+#include "qemu/osdep.h"
+#include "%(types)s.h"
+#include "%(type_infos)s.h"
+''',
+                                      types=types,
+                                      type_infos=type_infos))
+        self._genh.preamble_add(mcgen('''
+#include "qapi/qapi-builtin-type-infos.h"
+'''))
+
+    def _masked_name(self, name: str) -> str:
+        assert self._schema is not None
+        return self._schema.definition_introspection_name(name, self._unmask)
+
+    def _gen_type_info(self, name: str,
+                       ifcond: Optional[QAPISchemaIfCond] = None,
+                       with_lookup: bool = False) -> None:
+        cname = c_name(name, protect=False)
+        with ifcontext(ifcond or QAPISchemaIfCond(),
+                       self._genh, self._genc):
+            self._genh.add(mcgen('''
+
+extern const QAPITypeInfo %(cname)s_type_info;
+''',
+                                 cname=cname))
+            self._genc.add(mcgen('''
+
+const QAPITypeInfo %(cname)s_type_info = {
+    .name = "%(name)s",
+    .masked_name = "%(masked_name)s",
+''',
+                                 cname=cname, name=name,
+                                 masked_name=self._masked_name(name)))
+            if with_lookup:
+                self._genc.add(mcgen('''
+    .lookup = &%(cname)s_lookup,
+''',
+                                     cname=cname))
+            self._genc.add(mcgen('''
+};
+'''))
+
+    def visit_builtin_type(self,
+                           name: str,
+                           info: Optional[QAPISourceInfo],
+                           json_type: str) -> None:
+        self._gen_type_info(name)
+
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
+        self._gen_type_info(name, ifcond,
+                            with_lookup=True)
+
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: QAPISchemaIfCond,
+                         element_type: QAPISchemaType) -> None:
+        self._gen_type_info(name, ifcond)
+
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          branches: Optional[QAPISchemaBranches]) -> None:
+        assert self._schema is not None
+        typ = self._schema.lookup_type(name)
+        assert typ
+        if typ.is_implicit():
+            return
+        self._gen_type_info(name, ifcond)
+
+    def visit_alternate_type(self,
+                             name: str,
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             alternatives: QAPISchemaAlternatives) -> None:
+        self._gen_type_info(name, ifcond)
+
+
+def gen_type_infos(schema: QAPISchema,
+                   output_dir: str,
+                   prefix: str,
+                   opt_builtins: bool,
+                   opt_unmask: bool) -> None:
+    vis = QAPISchemaGenTypeInfoVisitor(prefix, opt_unmask)
+    schema.visit(vis)
+    vis.write(output_dir, opt_builtins)
diff --git a/tests/include/meson.build b/tests/include/meson.build
index 8e8d1ec4e6..026480d968 100644
--- a/tests/include/meson.build
+++ b/tests/include/meson.build
@@ -4,6 +4,8 @@ test_qapi_outputs_extra = [
   'test-qapi-commands-sub-module.h',
   'test-qapi-events-sub-module.c',
   'test-qapi-events-sub-module.h',
+  'test-qapi-type-infos-sub-module.c',
+  'test-qapi-type-infos-sub-module.h',
   'test-qapi-types-sub-module.c',
   'test-qapi-types-sub-module.h',
   'test-qapi-visit-sub-module.c',
diff --git a/tests/meson.build b/tests/meson.build
index 5877d2f60b..6769a1e781 100644
--- a/tests/meson.build
+++ b/tests/meson.build
@@ -2,6 +2,8 @@ subdir('bench')
 subdir('qemu-iotests')
 
 test_qapi_outputs = [
+  'qapi-builtin-type-infos.c',
+  'qapi-builtin-type-infos.h',
   'qapi-builtin-types.c',
   'qapi-builtin-types.h',
   'qapi-builtin-visit.c',
@@ -22,6 +24,10 @@ test_qapi_outputs = [
   'test-qapi-init-commands.h',
   'test-qapi-introspect.c',
   'test-qapi-introspect.h',
+  'test-qapi-type-infos-sub-sub-module.c',
+  'test-qapi-type-infos-sub-sub-module.h',
+  'test-qapi-type-infos.c',
+  'test-qapi-type-infos.h',
   'test-qapi-types-sub-sub-module.c',
   'test-qapi-types-sub-sub-module.h',
   'test-qapi-types.c',
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index debff633ac..392b59d8dc 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -231,6 +231,7 @@ custom_target('QAPI doc',
                        'doc-good-qapi-events.c', 'doc-good-qapi-events.h',
                        'doc-good-qapi-init-commands.c', 'doc-good-qapi-init-commands.h',
                        'doc-good-qapi-introspect.c', 'doc-good-qapi-introspect.h',
+                       'doc-good-qapi-type-infos.c', 'doc-good-qapi-type-infos.h',
                        'doc-good-qapi-types.c', 'doc-good-qapi-types.h',
                        'doc-good-qapi-visit.c', 'doc-good-qapi-visit.h' ],
               input: files('doc-good.json'),
-- 
2.55.0


