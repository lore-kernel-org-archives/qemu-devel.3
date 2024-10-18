Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A246CD2FFEC
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Oct 2024 10:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t1k3J-000185-7W; Fri, 18 Oct 2024 06:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1k3H-00017n-6N
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1t1k3F-0005SG-6O
 for qemu-devel@nongnu.org; Fri, 18 Oct 2024 06:17:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1729246664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PaOSakKOmE5ehEPJkhtzfQrPBczEuW/5wx/f2Vv7Ta4=;
 b=g3DF2Dsu+REy1ISecLuUt3n+p1FLjwtkh70JVXHv9BjOB0qEOCCHV/XVgVOm6MOmgxhrxm
 LrQBBebTv5SsTwdh+7ZWQyaJWulZgKVGyQZEF44osc7pbFLvm763rrPBKLiw8RPAoIlsyj
 MU+Ur+LOMcpJO1J/vkPmJX9ATuP69XQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-UQ9_cHbaMoOng7PZ6td5nA-1; Fri,
 18 Oct 2024 06:17:41 -0400
X-MC-Unique: UQ9_cHbaMoOng7PZ6td5nA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 229A219560AE; Fri, 18 Oct 2024 10:17:40 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.61])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A187219560A3; Fri, 18 Oct 2024 10:17:37 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 4/4] qapi: expose all schema features to code
Date: Fri, 18 Oct 2024 11:17:24 +0100
Message-ID: <20241018101724.1221152-5-berrange@redhat.com>
In-Reply-To: <20241018101724.1221152-1-berrange@redhat.com>
References: <20241018101724.1221152-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.068,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This replaces use of the constants from the QapiSpecialFeatures
enum, with constants from the auto-generate QapiFeatures enum
in qapi-features.h

The 'deprecated' and 'unstable' features still have a little bit of
special handling, being force defined to be the 1st + 2nd features
in the enum, regardless of whether they're used in the schema. This
retains compatibility with common code that references the features
via the QapiSpecialFeatures constants.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 meson.build              |  1 +
 scripts/qapi/commands.py |  1 +
 scripts/qapi/features.py | 62 ++++++++++++++++++++++++++++++++++++++++
 scripts/qapi/gen.py      |  4 +--
 scripts/qapi/main.py     |  2 ++
 scripts/qapi/schema.py   | 19 +++++++++++-
 scripts/qapi/types.py    |  6 ++--
 scripts/qapi/visit.py    |  3 +-
 8 files changed, 92 insertions(+), 6 deletions(-)
 create mode 100644 scripts/qapi/features.py

diff --git a/meson.build b/meson.build
index d26690ce20..b9d58be66f 100644
--- a/meson.build
+++ b/meson.build
@@ -3332,6 +3332,7 @@ qapi_gen_depends = [ meson.current_source_dir() / 'scripts/qapi/__init__.py',
                      meson.current_source_dir() / 'scripts/qapi/schema.py',
                      meson.current_source_dir() / 'scripts/qapi/source.py',
                      meson.current_source_dir() / 'scripts/qapi/types.py',
+                     meson.current_source_dir() / 'scripts/qapi/features.py',
                      meson.current_source_dir() / 'scripts/qapi/visit.py',
                      meson.current_source_dir() / 'scripts/qapi-gen.py'
 ]
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index d629d2d97e..bf88bfc442 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -355,6 +355,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-commands.h"
 #include "%(prefix)sqapi-init-commands.h"
+#include "%(prefix)sqapi-features.h"
 
 void %(c_prefix)sqmp_init_marshal(QmpCommandList *cmds)
 {
diff --git a/scripts/qapi/features.py b/scripts/qapi/features.py
new file mode 100644
index 0000000000..dc10c7cea0
--- /dev/null
+++ b/scripts/qapi/features.py
@@ -0,0 +1,62 @@
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
+    QAPISchemaFeature,
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
+    def visit_begin(self, schema: QAPISchema):
+        self.features = schema._feature_dict
+
+    def visit_end(self) -> None:
+        features = [
+            self.features[f]
+            for f in QAPISchemaFeature.SPECIAL_NAMES
+        ]
+
+        features.extend(
+            sorted(
+                filter(lambda f: not f.is_special(),
+                       self.features.values()),
+                key=lambda f: f.name)
+        )
+
+        self._genh.add("typedef enum {\n")
+        for f in features:
+            self._genh.add(f"    {c_enum_const('qapi_feature', f.name)}")
+            if f.name in QAPISchemaFeature.SPECIAL_NAMES:
+                self._genh.add(f" = {c_enum_const('qapi', f.name)},\n" )
+            else:
+                self._genh.add(",\n")
+
+        self._genh.add("} " + c_name('QapiFeature') + ";\n")
+
+def gen_features(schema: QAPISchema,
+                 output_dir: str,
+                 prefix: str) -> None:
+    vis = QAPISchemaGenFeatureVisitor(prefix)
+    schema.visit(vis)
+    vis.write(output_dir)
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index aba1a982f6..6ef603941c 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -42,8 +42,8 @@
 
 
 def gen_features(features: Sequence[QAPISchemaFeature]) -> str:
-    features = [f"1u << {c_enum_const('qapi', feat.name)}"
-                        for feat in features if feat.is_special()]
+    features = [f"1u << {c_enum_const('qapi_feature', feat.name)}"
+                        for feat in features]
     return ' | '.join(features) or '0'
 
 
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
index e97c978d38..5e14b1829b 100644
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
@@ -1138,6 +1141,11 @@ def __init__(self, fname: str):
         self._entity_list: List[QAPISchemaEntity] = []
         self._entity_dict: Dict[str, QAPISchemaDefinition] = {}
         self._module_dict: Dict[str, QAPISchemaModule] = OrderedDict()
+        self._feature_dict: Dict[str, QAPISchemaFeature] = {}
+
+        for f in QAPISchemaFeature.SPECIAL_NAMES:
+            self._feature_dict[f] = QAPISchemaFeature(f, "special feature")
+
         self._schema_dir = os.path.dirname(fname)
         self._make_module(QAPISchemaModule.BUILTIN_MODULE_NAME)
         self._make_module(fname)
@@ -1258,6 +1266,15 @@ def _make_features(
     ) -> List[QAPISchemaFeature]:
         if features is None:
             return []
+
+        for f in features:
+            feat = QAPISchemaFeature(f['name'], info)
+            if feat.name not in self._feature_dict:
+                if len(self._feature_dict) == 64:
+                    raise Exception("Maximum of 64 schema features is permitted")
+
+                self._feature_dict[feat.name] = feat
+
         return [QAPISchemaFeature(f['name'], info,
                                   QAPISchemaIfCond(f.get('if')))
                 for f in features]
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index ade6b7a3d7..7618d3eb6f 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -308,11 +308,13 @@ def _begin_user_module(self, name: str) -> None:
 #include "qapi/dealloc-visitor.h"
 #include "%(types)s.h"
 #include "%(visit)s.h"
+#include "%(prefix)sqapi-features.h"
 ''',
-                                      types=types, visit=visit))
+                                      types=types, visit=visit, prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
 #include "qapi/qapi-builtin-types.h"
-'''))
+''',
+                                      prefix=self._prefix))
 
     def visit_begin(self, schema: QAPISchema) -> None:
         # gen_object() is recursive, ensure it doesn't visit the empty type
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 8dbf4ef1c3..2d678c281d 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -360,8 +360,9 @@ def _begin_user_module(self, name: str) -> None:
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "%(visit)s.h"
+#include "%(prefix)sqapi-features.h"
 ''',
-                                      visit=visit))
+                                      visit=visit, prefix=self._prefix))
         self._genh.preamble_add(mcgen('''
 #include "qapi/qapi-builtin-visit.h"
 #include "%(types)s.h"
-- 
2.46.0


