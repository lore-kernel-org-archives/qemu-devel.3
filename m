Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83CE4CCF2E3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:26:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIoDe-0002Op-L6; Mon, 19 Oct 2026 10:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDK-0002ED-Qd
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xIoDG-0005ZC-RX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 10:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792419582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5Sb94iBwFXdz5xApotilh2Mw+Wuzwcgc5GafGs/kCtY=;
 b=FEuzUnfPQmjAZWldh6hhWuQQQFBbWq9Psz3X3aBfkT/uVOSxVTDSLQ3S5cRGdm7Q7C95xr
 PymU85ozj3cL85cfE6EIE2G7hKUL9zw0J9UYM7cJHqcq0x9Cko8L4S3gs11nTm6JAOGymE
 b9vnIGnFknG9xN91XQr//hhTK6XQKWg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-tscTMOXGNo6KaGZkO-_DTA-1; Mon,
 19 Oct 2026 14:19:36 +0000
X-MC-Unique: tscTMOXGNo6KaGZkO-_DTA-1
X-Mimecast-MFC-AGG-ID: tscTMOXGNo6KaGZkO-_DTA_1792419575
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 61ADD1956055; Mon, 19 Oct 2026 14:19:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DF5351803A40; Mon, 19 Oct 2026 14:19:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 90E1921E6888; Mon, 19 Oct 2026 16:19:29 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 michael.roth@amd.com, pierrick.bouvier@oss.qualcomm.com,
 philmd@oss.qualcomm.com, kkostiuk@redhat.com, alistair.francis@wdc.com,
 amachhiw@linux.ibm.com
Subject: [PATCH v6 09/65] qapi: add type-infos generator
Date: Mon, 19 Oct 2026 16:18:33 +0200
Message-ID: <20261019141929.1594337-10-armbru@redhat.com>
In-Reply-To: <20261019141929.1594337-1-armbru@redhat.com>
References: <20261019141929.1594337-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 9
X-Spam_score: 0.9
X-Spam_bar: /
X-Spam_report: (0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

New QAPISchemaGenTypeInfoVisitor produces per-module
qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
pairing the QAPI type name with its masked introspection name.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst |  92 ++++++++++++++++++++
 meson.build                  |   1 +
 scripts/qapi/backend.py      |   2 +
 scripts/qapi/type_infos.py   | 163 +++++++++++++++++++++++++++++++++++
 4 files changed, 258 insertions(+)
 create mode 100644 scripts/qapi/type_infos.py

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 77f08bb68c..1cc5338a21 100644
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
@@ -2099,3 +2102,92 @@ Example::
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
+``list``
+    For types that have an array variant, a pointer to the array type's
+    ``QAPITypeInfo``.  ``NULL`` when no array type exists.
+
+These type info instances are used by QOM property registration
+functions (``object_property_add_qapi()``,
+``object_class_property_add_qapi_enum()``, etc.) to associate each
+property with its QAPI type.  The ``qom-list`` and
+``device-list-properties`` QMP commands then expose the ``qapi-type``
+field, giving management tools a formal type reference they can look
+up in the introspection schema.
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
+        .masked_name = "1",
+        .list = &UserDefOneList_type_info,
+    };
+
+    const QAPITypeInfo UserDefOneList_type_info = {
+        .name = "UserDefOneList",
+        .masked_name = "[1]",
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
index 432a333f56..a4e08a96a2 100644
--- a/meson.build
+++ b/meson.build
@@ -3518,6 +3518,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/parser.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
+                     meson.current_source_dir() / 'scripts/qapi/type_infos.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
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
index 0000000000..b29e31d926
--- /dev/null
+++ b/scripts/qapi/type_infos.py
@@ -0,0 +1,163 @@
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
+    def _has_list(self, name: str) -> bool:
+        assert self._schema is not None
+        return self._schema.lookup_type(name + 'List') is not None
+
+    def _masked_name(self, name: str) -> str:
+        assert self._schema is not None
+        return self._schema.definition_introspection_name(name, self._unmask)
+
+    def _gen_type_info(self, name: str,
+                       ifcond: Optional[QAPISchemaIfCond] = None,
+                       with_lookup: bool = False,
+                       with_list: bool = False) -> None:
+        c_id = c_name(name + '_type_info')
+        masked_name_str = '"%s"' % self._masked_name(name)
+        with ifcontext(ifcond or QAPISchemaIfCond(),
+                       self._genh, self._genc):
+            self._genh.add(mcgen('''
+
+extern const QAPITypeInfo %(c_id)s;
+''',
+                                 c_id=c_id))
+            self._genc.add(mcgen('''
+
+const QAPITypeInfo %(c_id)s = {
+    .name = "%(name)s",
+    .masked_name = %(masked_name)s,
+''',
+                                 c_id=c_id, name=name,
+                                 masked_name=masked_name_str))
+            if with_lookup:
+                self._genc.add(mcgen('''
+    .lookup = &%(c_name)s_lookup,
+''',
+                                     c_name=c_name(name)))
+            if with_list:
+                self._genc.add(mcgen('''
+    .list = &%(list_id)s,
+''',
+                                     list_id=c_name(name + 'List_type_info')))
+            self._genc.add(mcgen('''
+};
+'''))
+
+    def visit_builtin_type(self,
+                           name: str,
+                           info: Optional[QAPISourceInfo],
+                           json_type: str) -> None:
+        self._gen_type_info(name, with_list=self._has_list(name))
+
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
+        self._gen_type_info(name, ifcond,
+                            with_lookup=True,
+                            with_list=self._has_list(name))
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
+        self._gen_type_info(name, ifcond,
+                            with_list=self._has_list(name))
+
+    def visit_alternate_type(self,
+                             name: str,
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             alternatives: QAPISchemaAlternatives) -> None:
+        self._gen_type_info(name, ifcond,
+                            with_list=self._has_list(name))
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
-- 
2.55.0


