Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47D8ACD37B6
	for <qemu-devel@archiver.kernel.org>; Sun, 10 May 2026 13:44:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wM4SB-00080b-6D; Sun, 10 May 2026 09:44:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4S8-0007za-0T
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wM4S5-0004PL-2n
 for qemu-devel@nongnu.org; Sun, 10 May 2026 09:44:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778420652;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+38+VZ6Pmd0MFgR6FoHfrmM7yO6Iys6cW09ihGsXkVo=;
 b=OYHhrUTyvs9oeNPO9qzb2bYkAdtiGWIES0pSByA0fG8lHi/oWt3DxY9731GN540OTGUlXr
 EkoSh9//jaT0vZRuwThvSsHDFkRPSq8kQCvppKdUm6tCTaUWuaP3LEf8sVQShipR1eeE4A
 R/UDo3X7gfI0wilIeL/KrBFLeVsvCZg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-UP8J0AdRO9yNayZA61AigQ-1; Sun,
 10 May 2026 09:44:10 -0400
X-MC-Unique: UP8J0AdRO9yNayZA61AigQ-1
X-Mimecast-MFC-AGG-ID: UP8J0AdRO9yNayZA61AigQ_1778420649
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D4B4419560AA
 for <qemu-devel@nongnu.org>; Sun, 10 May 2026 13:44:09 +0000 (UTC)
Received: from localhost (unknown [10.44.24.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FFE318004A3; Sun, 10 May 2026 13:44:06 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Sun, 10 May 2026 17:43:00 +0400
Subject: [PATCH 03/54] qapi: add type-infos generator
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260510-qom-qapi-v1-3-48ba6a1a1fa5@redhat.com>
References: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
In-Reply-To: <20260510-qom-qapi-v1-0-48ba6a1a1fa5@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=11421;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=qHb8b82GU+OQNQNEluK510LJkdY+C23LVofbl02FKPY=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqAItuSKz/3vEVuI2u4OHgQjY1eM31i7c57+vq2
 DOzsvjXUg+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCagCLbgAKCRDa6OEJdZac
 5US3D/9rTl4dktMf4AbLQX5Cob4r3Uid++IH4S8M/oBuJibdCd+ngYyf/oLnkzOR9+PhyELcQcF
 7AOg80TX8lVCqhqRBHuW9+LiekqdLCrp2Z7CJusJVKF69rrI620teBXe4dszKulb15CfaOqWfRN
 /S2bwW8M/yvIeqQAX1/8tVEtC4/wlLrEw6Oqsd7CmNhTWVPm82pA1sl9lhC+uNduVznYAQgkjK/
 zGNK8WJzeTtpnF6gZ64N3GF6L7cC7KfTxTE2Qmpc35zCEHDzXCts2ivcyJw1XDyfmvGsXZFn3dp
 +IVPLW68whGQLqllbKIEdk+KqF1BP3ujqTab/mnDYgvSmuxzHfNrIfLRKdEoXK15tm6d55D16aD
 bCv/GZo7TZQPYjCGF6JALbAqEJyUp6ifgt68Z3ZRW7OsUQPOIrYlc9nJn+LSZIT3WKQ4VTR1kPQ
 fOlQNDPvv3GKc1MDH4PW2odaLlmETY89kKDbHakQtHp/+PnMBII4Ucm39H+/+7YUFUn0YKc2iEV
 loa+eP+HdJSubqo2QqsF/vks14I4Psn4vMoIZbMfgmqwvQ1+8MowEbmr4846+L8i+AZTLFvhfOp
 t7mH8En8nWdm52yXS2oLXJNB0vLjO+IKFWfOn5d16lL7jz1WUOMi2jMCaKSymAowtx6aGeRV0ps
 iSpW9unAkD4YswQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 docs/devel/qapi-code-gen.rst |  90 +++++++++++++++++++++
 meson.build                  |   1 +
 scripts/qapi/type_infos.py   | 182 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 273 insertions(+)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 3a632b4a648..bb2e8d9c675 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -2103,3 +2103,93 @@ Example::
     }));
 
     [Uninteresting stuff omitted...]
+
+
+Code generated for type information
+-----------------------------------
+
+The following files are created:
+
+ ``$(prefix)qapi-type-infos.c``
+     A ``QAPITypeInfo`` instance for each schema-defined type, providing
+     a mapping between the C type name and the schema name used by
+     introspection, along with optional enum lookup table and list-element
+     pointers.
+
+ ``$(prefix)qapi-type-infos.h``
+     Declarations for the above type info instances
+
+Each ``QAPITypeInfo`` struct has the following fields:
+
+``name``
+    The C identifier of the type (e.g. ``"UserDefOne"``).
+
+``schema_name``
+    The masked name used in ``query-qmp-schema`` output, or ``NULL``
+    for built-in types whose schema name equals their C name.  This
+    allows management tools to cross-reference a QOM property's
+    ``qapi-type`` against the introspection schema.
+
+``lookup``
+    For enum types, a pointer to the corresponding ``QEnumLookup``
+    table.  ``NULL`` for non-enum types.
+
+``list``
+    For types that have an array variant, a pointer to the list type's
+    ``QAPITypeInfo``.  ``NULL`` when no list type exists.
+
+These type info instances are used by QOM property registration
+functions (``object_property_add_qapi()``,
+``object_class_property_add_qapi_enum()``, etc.) to associate each
+property with its QAPI schema type.  The ``qom-list`` and
+``device-list-properties`` QMP commands then expose the ``qapi-type``
+field, giving management tools a formal type reference into the
+introspection schema.
+
+Implicit types (names starting with ``q_``) are skipped.
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
+        .schema_name = "1",
+        .list = &UserDefOneList_type_info,
+    };
+
+    const QAPITypeInfo UserDefOneList_type_info = {
+        .name = "UserDefOneList",
+        .schema_name = "[1]",
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
index 5fbdc75a0fc..f239ed24fae 100644
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
diff --git a/scripts/qapi/type_infos.py b/scripts/qapi/type_infos.py
new file mode 100644
index 00000000000..dc7e2bace9e
--- /dev/null
+++ b/scripts/qapi/type_infos.py
@@ -0,0 +1,182 @@
+"""
+QAPI type info generator
+
+SPDX-License-Identifier: GPL-2.0-or-later
+"""
+
+from typing import (
+    Dict,
+    List,
+    Optional,
+    Set,
+)
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
+    QAPISchemaVisitor,
+)
+from .source import QAPISourceInfo
+
+
+class _ArrayTypeCollector(QAPISchemaVisitor):
+    def __init__(self) -> None:
+        self.list_types: Set[str] = set()
+
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: QAPISchemaIfCond,
+                         element_type: QAPISchemaType) -> None:
+        self.list_types.add(name)
+
+
+class QAPISchemaGenTypeInfoVisitor(QAPISchemaModularCVisitor):
+
+    def __init__(self, prefix: str, name_map: Dict[str, str],
+                 list_types: Set[str]):
+        super().__init__(
+            prefix, 'qapi-type-infos',
+            ' * Schema-defined QAPI type info',
+            ' * Built-in QAPI type info', __doc__)
+        self._name_map = name_map
+        self._list_types = list_types
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
+                       ifcond: Optional[QAPISchemaIfCond] = None,
+                       with_lookup: bool = False,
+                       with_list: bool = False,
+                       schema_name: Optional[str] = None) -> None:
+        c_id = c_name(name + '_type_info')
+        lookup = ''
+        if with_lookup:
+            lookup = mcgen('''
+    .lookup = &%(c_name)s_lookup,
+''',
+                           c_name=c_name(name))
+        list_ref = ''
+        if with_list:
+            list_ref = mcgen('''
+    .list = &%(list_id)s,
+''',
+                             list_id=c_name(name + 'List_type_info'))
+        if schema_name is None:
+            masked = self._name_map.get(name)
+            schema_name = '"%s"' % masked if masked is not None else 'NULL'
+        else:
+            schema_name = '"%s"' % schema_name
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
+    .schema_name = %(schema_name)s,
+%(lookup)s%(list_ref)s};
+''',
+                                 c_id=c_id, name=name,
+                                 schema_name=schema_name,
+                                 lookup=lookup,
+                                 list_ref=list_ref))
+
+    def _has_list(self, name: str) -> bool:
+        return name + 'List' in self._list_types
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
+        self._gen_type_info(name, ifcond, with_lookup=True,
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
+        self._gen_type_info(name, ifcond,
+                            with_list=self._has_list(name))
+
+    def visit_array_type(self,
+                         name: str,
+                         info: Optional[QAPISourceInfo],
+                         ifcond: QAPISchemaIfCond,
+                         element_type: QAPISchemaType) -> None:
+        elem_schema = self._name_map.get(element_type.name,
+                                         element_type.name)
+        self._gen_type_info(name, ifcond,
+                            schema_name='[' + elem_schema + ']')
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
+                   name_map: Dict[str, str]) -> None:
+    collector = _ArrayTypeCollector()
+    schema.visit(collector)
+    vis = QAPISchemaGenTypeInfoVisitor(prefix, name_map,
+                                       collector.list_types)
+    schema.visit(vis)
+    vis.write(output_dir, opt_builtins)

-- 
2.54.0


