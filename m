Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F2ECC88E53
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:38:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54GF-0005Jh-AA; Fri, 11 Sep 2026 12:37:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Fw-00053u-CH
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Fk-0005zv-Um
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144642;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ij86l8MjfFX4qhLLc01Pqlp0PoB08w95fScQeyXRmbw=;
 b=FLZO3kXA7wPulVhmFDor3kaYmBiNUTKPe+2WljZiI3dpT7IpO7UrJV9PvGHMpVRlmWnTru
 IsqmB/PpLe+aeO4bxXjusNdD+4x7OqKjf8ssL+iAdGz+RseswlJUoKjq6QQ+A7SW9itR0P
 T1bs766V/Z08G6YX3241OYS7w66c348=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-DrOqzToCNWu3t5bIbrSRQw-1; Fri,
 11 Sep 2026 12:37:19 -0400
X-MC-Unique: DrOqzToCNWu3t5bIbrSRQw-1
X-Mimecast-MFC-AGG-ID: DrOqzToCNWu3t5bIbrSRQw_1789144638
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0B8DF1964CC2; Fri, 11 Sep 2026 16:37:17 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B708A1800351; Fri, 11 Sep 2026 16:35:29 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:34:39 +0400
Subject: [PATCH v5 05/62] qapi: add type-infos generator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-5-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=12498;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=i8vmR5kDAF7dSqThQ8cXVRSNBrSLWVt5r+whL8RWnfg=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC22BBv3wuZOvyAGWuzUYDElekH15CB4UOzBQ
 T6+0r7NOkeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQttgAKCRDa6OEJdZac
 5TkWD/0SpDpAIOHmIE68/TYW3Aj+J3tXw5+tQ8fS31yZBwGX6VCGhACNiW6ga0azADUd02ebD9C
 GIqJE8hbDm3wh+iHySkK8x/MMW6fQu2gHwdgjC2TzdFIsRANn7xlqFyKCnQLhEhN5safWBKq0nQ
 AMvCX3p1tftv2kSbTo7RPeFBIDDR1+2Q6fPDl0OSIFBG8nkKlq31H5l2KBMoXxIxnQFeCKDuc9Y
 hoMYkHimhoMlCSU2T0v1sbfQNI4ist0fAQGEqkOcSCR50d7+hgbAnOxiMAoqYCetWZ4mPB9MSm9
 OhElMYgtOjk63BeVFAIf3wC4AuLHsr38SEq4NvFs2wat4dONOg7wVtTtPNlw1ONRQHFkr8Cxnnk
 t1HDW3gaxl+wb8uBt4l+urI+CM0wv9HZmD4tY5JaF5yv6GuzmhE7jsQsLcosgKd0hasbkw3sXW2
 PjjDxn/sVrJQn1b/J8X0hnXAiDthPZIS5+mx8XilyKMF5+Cq0OT1YRBYOoai0E6RTPe8xXuMTo+
 bRTWr1Jf7yBHA/bGY39gG46TtASfnCev73wd7ERAVm4rTADTFFjJqo5b8rvY90WhPEBrLFv/+U6
 clmkEMbfZbs+qcubzdWqFDBAeiTUCdLwRRvkse1w1MSMliUIpt8P4AE/Uuw5cw9q+Kcpmzz076U
 j8SVot8z8VP957Q==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

New QAPISchemaGenTypeInfoVisitor produces per-module
qapi-type-infos-*.h/c files. Each file declares QAPITypeInfo constants
pairing the QAPI type name with its masked introspection name.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.rst |  92 +++++++++++++++++++++++
 meson.build                  |   1 +
 scripts/qapi/backend.py      |   2 +
 scripts/qapi/type_infos.py   | 175 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 270 insertions(+)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index b697aab930d1..69d5c4af9874 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1250,6 +1250,9 @@ JSON array of strings.
 To examine a type, start with a command or event using it, then follow
 references by name.
 
+.. TODO document QOM introspection (qom-list, qom-list-properties,
+   qom-get) and how it relates to QAPI type information.
+
 .. TODO document QOM introspection (qom-list, qom-list-properties,
    qom-get) and how it relates to QAPI type information.
 
@@ -2102,3 +2105,92 @@ Example::
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
index 96df1ce81eaf..175d7c2a225b 100644
--- a/meson.build
+++ b/meson.build
@@ -3506,6 +3506,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/schema_analysis.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
+                     meson.current_source_dir() / 'scripts/qapi/type_infos.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 24717be48c3c..7c2b47a41ae6 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -9,6 +9,7 @@
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .schema_analysis import QAPISchemaTypeAnalysis
+from .type_infos import gen_type_infos
 from .types import gen_types
 from .visit import gen_visit
 
@@ -66,3 +67,4 @@ def generate(self,
         gen_commands(schema, output_dir, prefix, gen_tracing)
         gen_events(schema, output_dir, prefix)
         gen_introspect(schema, output_dir, prefix, schema_types)
+        gen_type_infos(schema, output_dir, prefix, builtins, schema_types)
diff --git a/scripts/qapi/type_infos.py b/scripts/qapi/type_infos.py
new file mode 100644
index 000000000000..cbdfb5f9919a
--- /dev/null
+++ b/scripts/qapi/type_infos.py
@@ -0,0 +1,175 @@
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
+from .schema_analysis import QAPISchemaTypeAnalysis
+from .source import QAPISourceInfo
+
+
+class QAPISchemaGenTypeInfoVisitor(QAPISchemaModularCVisitor):
+
+    def __init__(self, prefix: str, schema_types: QAPISchemaTypeAnalysis):
+        super().__init__(
+            prefix, 'qapi-type-infos',
+            ' * Schema-defined QAPI type info',
+            ' * Built-in QAPI type info', __doc__)
+        self._schema_types = schema_types
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
+    def _gen_type_info(self, name: str,
+                       masked_name: str,
+                       ifcond: Optional[QAPISchemaIfCond] = None,
+                       with_lookup: bool = False,
+                       with_list: bool = False) -> None:
+        c_id = c_name(name + '_type_info')
+        masked_name_str = '"%s"' % masked_name
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
+    def _has_list(self, name: str) -> bool:
+        assert self._schema is not None
+        return self._schema.lookup_type(name + 'List') is not None
+
+    def _masked_name(self, name: str) -> str:
+        return self._schema_types.masked_name(name)
+
+    def visit_builtin_type(self,
+                           name: str,
+                           info: Optional[QAPISourceInfo],
+                           json_type: str) -> None:
+        assert self._schema is not None
+        typ = self._schema.lookup_type(name)
+        assert typ is not None
+        masked_name = self._schema_types.introspection_name(typ)
+        self._gen_type_info(name, masked_name,
+                            with_list=self._has_list(name))
+
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
+        assert self._schema is not None
+        typ = self._schema.lookup_type(name)
+        assert typ is not None
+        if typ.is_implicit():
+            masked_name = name
+        else:
+            masked_name = self._masked_name(name)
+        self._gen_type_info(name, masked_name, ifcond,
+                            with_lookup=True,
+                            with_list=self._has_list(name))
+
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          branches: Optional[QAPISchemaBranches]) -> None:
+        if name.startswith('q_'):
+            return
+        self._gen_type_info(name, self._masked_name(name), ifcond,
+                            with_list=self._has_list(name))
+
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: QAPISchemaIfCond,
+                         element_type: QAPISchemaType) -> None:
+        elem_schema = self._schema_types.introspection_name(element_type)
+        masked_name = '[' + elem_schema + ']'
+        self._gen_type_info(name, masked_name, ifcond)
+
+    def visit_alternate_type(self,
+                             name: str,
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             alternatives: QAPISchemaAlternatives) -> None:
+        self._gen_type_info(name, self._masked_name(name), ifcond,
+                            with_list=self._has_list(name))
+
+
+def gen_type_infos(schema: QAPISchema,
+                   output_dir: str,
+                   prefix: str,
+                   opt_builtins: bool,
+                   schema_types: QAPISchemaTypeAnalysis) -> None:
+    vis = QAPISchemaGenTypeInfoVisitor(prefix, schema_types)
+    schema.visit(vis)
+    vis.write(output_dir, opt_builtins)

-- 
2.55.0.543.g5ebe2ebe4ea8


