Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 054E4C52D6D
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 18:00:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZa5c-0002Nk-SL; Thu, 01 Aug 2024 13:59:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5b-0002KI-2j
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sZa5X-0005zA-5b
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 13:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722535181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKj/R/LTdslBdO3NPUSSDISUWikk5J0XoRlJ1Pv42W4=;
 b=BFjJ7a4Ywx1rUeywjovfnyBVPDjQxKbBk6nhcxqIkn3xSyBqnzc+EfThc5bGCYMVrfNdgQ
 v7y+5U2B7KXDkUvBNf44FFFzweAUanMuA9zlwiHIJWVcWZRPkEYNrwadif2+LU0BU9N4+Y
 4hOPWHM5jDMCEvYhC/NNUmfa3McBYLE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-M5j83n_QN126TT3PRBeP7g-1; Thu,
 01 Aug 2024 13:59:38 -0400
X-MC-Unique: M5j83n_QN126TT3PRBeP7g-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C36D619560A2; Thu,  1 Aug 2024 17:59:37 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.17])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C7D7519560AA; Thu,  1 Aug 2024 17:59:34 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 6/6] qapi: expose all schema features to code
Date: Thu,  1 Aug 2024 18:59:13 +0100
Message-ID: <20240801175913.669013-7-berrange@redhat.com>
In-Reply-To: <20240801175913.669013-1-berrange@redhat.com>
References: <20240801175913.669013-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This removed the QapiFeatures enum and auto-generates an enum which
exposes all features defined by the schema to code.

The 'deprecated' and 'unstable' features still have a little bit of
special handling, being force defined to be the 1st + 2nd features
in the enum, regardless of whether they're used in the schema. This
is because QAPI common code references these features.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/qapi/util.h      |   5 --
 meson.build              |   1 +
 scripts/qapi/features.py | 134 +++++++++++++++++++++++++++++++++++++++
 scripts/qapi/main.py     |   2 +
 scripts/qapi/schema.py   |   5 +-
 scripts/qapi/types.py    |   4 +-
 6 files changed, 144 insertions(+), 7 deletions(-)
 create mode 100644 scripts/qapi/features.py

diff --git a/include/qapi/util.h b/include/qapi/util.h
index a693cac9ea..9e390486c0 100644
--- a/include/qapi/util.h
+++ b/include/qapi/util.h
@@ -11,11 +11,6 @@
 #ifndef QAPI_UTIL_H
 #define QAPI_UTIL_H
 
-typedef enum {
-    QAPI_FEATURE_DEPRECATED,
-    QAPI_FEATURE_UNSTABLE,
-} QapiFeature;
-
 typedef struct QEnumLookup {
     const char *const *array;
     const uint64_t *const features;
diff --git a/meson.build b/meson.build
index 97f63aa86c..40002c59f5 100644
--- a/meson.build
+++ b/meson.build
@@ -3268,6 +3268,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
+                     meson.current_source_dir() / 'scripts/qapi/features.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
 ]
diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
new file mode 100644
index 0000000000..9b77be6310
--- /dev/null
+++ b/scripts/qapi/features.py
@@ -0,0 +1,134 @@
+"""
+QAPI types generator
+
+Copyright 2024 Red Hat
+
+This work is licensed under the terms of the GNU GPL, version 2.
+# See the COPYING file in the top-level directory.
+"""
+
+from typing import List, Optional
+
+from .common import c_enum_const, mcgen, c_name
+from .gen import QAPISchemaMonolithicCVisitor
+from .schema import (
+    QAPISchema,
+    QAPISchemaAlternatives,
+    QAPISchemaBranches,
+    QAPISchemaEntity,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaIfCond,
+    QAPISchemaObjectType,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
+    QAPISchemaVariants,
+)
+from .source import QAPISourceInfo
+
+
+class QAPISchemaGenFeatureVisitor(QAPISchemaMonolithicCVisitor):
+
+    def __init__(self, prefix: str):
+        super().__init__(
+            prefix, 'qapi-features',
+            ' * Schema-defined QAPI features',
+            __doc__)
+
+        self.features = {}
+
+    def visit_end(self) -> None:
+        features = []
+
+        # We always want special features to have the same
+        # enum value across all schemas, since they're
+        # referenced from common code. Put them at the
+        # start of the list, regardless of whether they
+        # are actually referenced in the schema
+        for name in QAPISchemaFeature.SPECIAL_NAMES:
+            features.append(name)
+
+        features.extend(sorted(self.features.keys()))
+
+        if len(features) > 64:
+            raise Exception("Maximum of 64 schema features is permitted")
+
+        self._genh.add("typedef enum {\n")
+        for name in features:
+            self._genh.add(f"    {c_enum_const(self._prefix + 'QAPI_FEATURE', name)},\n")
+
+        self._genh.add("} " + c_name(self._prefix + 'QapiFeature') + ";\n")
+
+    def _record(self, features: List[QAPISchemaFeature]):
+        for f in features:
+            # Special features are handled separately
+            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
+                continue
+            self.features[f.name] = True
+
+    def visit_enum_type(self,
+                        name: str,
+                        info: Optional[QAPISourceInfo],
+                        ifcond: QAPISchemaIfCond,
+                        features: List[QAPISchemaFeature],
+                        members: List[QAPISchemaEnumMember],
+                        prefix: Optional[str]) -> None:
+        self._record(features)
+
+    def visit_object_type_flat(self,
+                               name: str,
+                               info: Optional[QAPISourceInfo],
+                               ifcond: QAPISchemaIfCond,
+                               features: List[QAPISchemaFeature],
+                               members: List[QAPISchemaObjectTypeMember],
+                               branches: Optional[QAPISchemaBranches]) -> None:
+        self._record(features)
+
+    def visit_object_type(self,
+                          name: str,
+                          info: Optional[QAPISourceInfo],
+                          ifcond: QAPISchemaIfCond,
+                          features: List[QAPISchemaFeature],
+                          base: Optional[QAPISchemaObjectType],
+                          members: List[QAPISchemaObjectTypeMember],
+                          branches: Optional[QAPISchemaBranches]) -> None:
+        self._record(features)
+
+    def visit_alternate_type(self,
+                             name: str,
+                             info: Optional[QAPISourceInfo],
+                             ifcond: QAPISchemaIfCond,
+                             features: List[QAPISchemaFeature],
+                             alternatives: QAPISchemaAlternatives) -> None:
+        self._record(features)
+
+    def visit_command(self,
+                      name: str,
+                      info: Optional[QAPISourceInfo],
+                      ifcond: QAPISchemaIfCond,
+                      features: List[QAPISchemaFeature],
+                      arg_type: Optional[QAPISchemaObjectType],
+                      ret_type: Optional[QAPISchemaType],
+                      gen: bool,
+                      success_response: bool,
+                      boxed: bool,
+                      allow_oob: bool,
+                      allow_preconfig: bool,
+                      coroutine: bool) -> None:
+        self._record(features)
+
+    def visit_event(self,
+                    name: str,
+                    info: Optional[QAPISourceInfo],
+                    ifcond: QAPISchemaIfCond,
+                    features: List[QAPISchemaFeature],
+                    arg_type: Optional[QAPISchemaObjectType],
+                    boxed: bool) -> None:
+        self._record(features)
+
+def gen_features(schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str) -> None:
+    vis = QAPISchemaGenFeatureVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
diff --git a/scripts/qapi/main.py b/scripts/qapi/main.py
index 316736b6a2..2b9a2c0c02 100644
--- a/scripts/qapi/main.py
+++ b/scripts/qapi/main.py
@@ -18,6 +18,7 @@
 from .introspect import gen_introspect
 from .schema import QAPISchema
 from .types import gen_types
+from .features import gen_features
 from .visit import gen_visit
 
 
@@ -49,6 +50,7 @@ def generate(schema_file: str,
 
     schema = QAPISchema(schema_file)
     gen_types(schema, output_dir, prefix, builtins)
+    gen_features(schema, output_dir, prefix)
     gen_visit(schema, output_dir, prefix, builtins)
     gen_commands(schema, output_dir, prefix, gen_tracing)
     gen_events(schema, output_dir, prefix)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index d65c35f6ee..160ce0a7c0 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -933,8 +933,11 @@ def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
 class QAPISchemaFeature(QAPISchemaMember):
     role = 'feature'
 
+    # Features which are standardized across all schemas
+    SPECIAL_NAMES = ['deprecated', 'unstable']
+
     def is_special(self) -> bool:
-        return self.name in ('deprecated', 'unstable')
+        return self.name in QAPISchemaFeature.SPECIAL_NAMES
 
 
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index b2d26c2ea8..3435f1b0b0 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -313,7 +313,9 @@ def _begin_user_module(self, name: str) -> None:
                                       types=types, visit=visit))
         self._genh.preamble_add(mcgen('''
 #include "qapi/qapi-builtin-types.h"
-'''))
+#include "%(prefix)sqapi-features.h"
+''',
+                                      prefix=self._prefix))
 
     def visit_begin(self, schema: QAPISchema) -> None:
         # gen_object() is recursive, ensure it doesn't visit the empty type
-- 
2.45.2


