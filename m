Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9559C79F82
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 19:58:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a3d-0005h5-Op; Fri, 04 Sep 2026 15:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3S-0005We-08
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a3Q-0007r0-2v
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 15:58:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788551907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w8m95gEWA5U3jbTNceNdKWBzcxPjyCwUAePZf6sjHEs=;
 b=d5KGbdQswxOohWqZktMWeQ2ZmC0lX4Ix47PHIglAjdMIa6qfVlfVYaCYxVwornVGOwwjvf
 qagpjBpjkakvndUM7FFqXoFhdL02Y6jAwuWubiuvIj5kZx/BodWd2KqhluRQcZSH4Hc2+E
 9mbgoonZ8lhdDpVCcBHt09JYsSUtVLw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-664-NCMGYen-POGcogvyyFClEA-1; Fri,
 04 Sep 2026 15:58:24 -0400
X-MC-Unique: NCMGYen-POGcogvyyFClEA-1
X-Mimecast-MFC-AGG-ID: NCMGYen-POGcogvyyFClEA_1788551903
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 336E21954195; Fri,  4 Sep 2026 19:58:23 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 65EBB1800641; Fri,  4 Sep 2026 19:58:22 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:57:47 +0400
Subject: [PATCH v4 04/75] qapi: register all introspectable types, not just
 QMP-reachable ones
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-4-a985f168e938@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7834;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=+ugXkl0/59jlcWQDIp9PvCnhUKa9x6JqLEfbZx+Dfds=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLIKwqk6ovV3dklKJ1Jz/TxvcvcBaAGbSkpt
 ztlLyimBgOJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsiyAAKCRDa6OEJdZac
 5YiGD/9yLXGmYh9F8WTfXtmEpvwkF8uwJNsF9bXrS6nrG7M2XQWc9NsXbXwZWd47Gebc97T5/Jd
 ApMoRTmX7hXXHMDcfk6V4dH9H/huQzp304H6R1t6upKxIykJqkczwhZ/viMVsJepOh0aF/q2Z86
 4YmstLlHYhuLBrJwSnoLavCY/K0IOYIRbhIRdzEUq3mmbX+g80LFGfYJcJhsT7b5gJNqVrmVFmR
 xXpgQyMedQpQbgVMMHPgcwFHfwN3grl+Xfghqr20DL+3s7jU2wJjiqkC8n9NvlYBHNSPR50muK+
 V4Dvg0AVaS+pfzh5OnVy7qEgXiadhdCqOMqOARTj4XgFu6clv4wx2dYeSeDDK8OY32KsJv2RC4p
 tJBOBSqdf5KwGSP7MZpAnV9/5PP9eYajGihxj3gnMEhdA/tqM/i/NhqCkENy+ODlCYNCUL7s+9K
 muKnm1URJbBXRUE6kggo/S2RZIPGIa3VfTkBWwkrhhy9CGVRDX0LrQsOjevdYUW+6zLzKeu4N+d
 lL1PUyN79aHb0331mWvO4nwdUhNdZTJE/gPdcHoPMrbqhi3qz3k71COkrEm8DKpzpXsJt4OQgge
 6TFyY+/0RR/0lA5c8rINaVZNQL0hc+xqdxqK0uRRavUDBYZjlMBOs7JOIHmm+YLxEXjMNjxN+Sp
 0Pv5jVD27h7LMMw==
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

Rename QAPISchemaUsedTypes to QAPISchemaTypeAnalysis and broaden type
collection: instead of discovering types transitively from commands and
events, register every non-implicit type upfront in visit_needed() and
let visit_end() resolve their dependencies.

This is needed so that QOM property types that are defined in the QAPI
schema but not referenced by any command or event still appear in
query-qmp-schema output, making them introspectable by management tools.

Commands and events still register their (often implicit) argument and
return types, which visit_needed() intentionally skips.

This makes the x86-64 schema grow from 244K to 265K.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/backend.py         |  4 +--
 scripts/qapi/introspect.py      |  6 ++---
 scripts/qapi/schema_analysis.py | 55 +++++++++++++++++++++--------------------
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/scripts/qapi/backend.py b/scripts/qapi/backend.py
index 59329965890f..24717be48c3c 100644
--- a/scripts/qapi/backend.py
+++ b/scripts/qapi/backend.py
@@ -8,7 +8,7 @@
 from .features import gen_features
 from .introspect import gen_introspect
 from .schema import QAPISchema
-from .schema_analysis import QAPISchemaUsedTypes
+from .schema_analysis import QAPISchemaTypeAnalysis
 from .types import gen_types
 from .visit import gen_visit
 
@@ -58,7 +58,7 @@ def generate(self,
 
         :raise QAPIError: On failures.
         """
-        schema_types = QAPISchemaUsedTypes(unmask)
+        schema_types = QAPISchemaTypeAnalysis(unmask)
         schema.visit(schema_types)
         gen_types(schema, output_dir, prefix, builtins)
         gen_features(schema, output_dir, prefix)
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 9e76e3aa38a9..77c29425c42d 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -38,7 +38,7 @@
     QAPISchemaType,
     QAPISchemaVariant,
 )
-from .schema_analysis import QAPISchemaUsedTypes
+from .schema_analysis import QAPISchemaTypeAnalysis
 from .source import QAPISourceInfo
 
 
@@ -168,7 +168,7 @@ def to_c_string(string: str) -> str:
 
 class QAPISchemaGenIntrospectVisitor(QAPISchemaMonolithicCVisitor):
 
-    def __init__(self, prefix: str, schema_types: QAPISchemaUsedTypes):
+    def __init__(self, prefix: str, schema_types: QAPISchemaTypeAnalysis):
         super().__init__(
             prefix, 'qapi-introspect',
             ' * QAPI/QMP schema introspection', __doc__)
@@ -187,7 +187,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
 
     def visit_end(self) -> None:
         # visit the types that are actually used
-        for typ in self._schema_types.used_types():
+        for typ in self._schema_types.types():
             typ.visit(self)
         # generate C
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
diff --git a/scripts/qapi/schema_analysis.py b/scripts/qapi/schema_analysis.py
index 7e42abbc14e1..1d12306f61e2 100644
--- a/scripts/qapi/schema_analysis.py
+++ b/scripts/qapi/schema_analysis.py
@@ -35,37 +35,37 @@
 from .source import QAPISourceInfo
 
 
-class QAPISchemaUsedTypes(QAPISchemaVisitor):
-    """Collect the set of QMP-reachable types from a schema.
+class QAPISchemaTypeAnalysis(QAPISchemaVisitor):
+    """Analyze types from a QAPI schema.
 
-    Types are discovered transitively starting from commands and events.
-    Each type is also given a masked introspection name (an integer
-    string).
+    Every non-builtin, non-array type is given a masked introspection
+    name (an integer string).
     """
 
     def __init__(self, unmask: bool):
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
         # Ordered list + set: insert during iteration + O(1) check
-        self._used_types: List[QAPISchemaType] = []
-        self._used_types_set: Set[QAPISchemaType] = set()
+        self._types: List[QAPISchemaType] = []
+        self._types_set: Set[QAPISchemaType] = set()
         self._name_map: Dict[str, str] = {}
 
     def visit_begin(self, schema: QAPISchema) -> None:
         self._schema = schema
-        self._used_types = []
-        self._used_types_set = set()
+        self._types = []
+        self._types_set = set()
         self._name_map = {}
 
     def visit_end(self) -> None:
         assert self._schema is not None
-        # Discover transitively-used types; the list grows as
+        # Discover type dependencies; the list grows as
         # visiting each type registers the types it references.
-        for typ in self._used_types:
+        for typ in self._types:
             typ.visit(self)
-        # Assign stable masked names now that all types are known
+
+        # Assign masked names now that all introspected types are known.
         counter = 0
-        for typ in self._used_types:
+        for typ in self._types:
             if isinstance(typ, (QAPISchemaBuiltinType, QAPISchemaArrayType)):
                 continue
             self._name_map[typ.name] = (
@@ -73,8 +73,14 @@ def visit_end(self) -> None:
             counter += 1
 
     def visit_needed(self, entity: QAPISchemaEntity) -> bool:
-        # Skip types during main traversal; visit_end() handles them
-        return not isinstance(entity, QAPISchemaType)
+        # Side effect: register all introspectable types now, so that
+        # visit_end() can traverse them to discover type dependencies.
+        if isinstance(entity, QAPISchemaType):
+            if (not entity.is_implicit() or
+                    isinstance(entity, QAPISchemaArrayType)):
+                self._register_type(entity)
+            return False
+        return True
 
     def visit_command(self, name: str, info: Optional[QAPISourceInfo],
                       ifcond: QAPISchemaIfCond,
@@ -107,11 +113,6 @@ def visit_object_type_flat(
             for v in branches.variants:
                 self._register_type(v.type)
 
-    def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
-                         ifcond: QAPISchemaIfCond,
-                         element_type: QAPISchemaType) -> None:
-        self._register_type(element_type)
-
     def visit_alternate_type(
             self, name: str, info: Optional[QAPISourceInfo],
             ifcond: QAPISchemaIfCond,
@@ -121,11 +122,11 @@ def visit_alternate_type(
             self._register_type(m.type)
 
     def _register_type(self, typ: QAPISchemaType) -> None:
-        """Record a type as QMP-reachable (idempotent)."""
+        """Record a type for introspection (idempotent)."""
         typ = self._canonicalize_type(typ)
-        if typ not in self._used_types_set:
-            self._used_types.append(typ)
-            self._used_types_set.add(typ)
+        if typ not in self._types_set:
+            self._types.append(typ)
+            self._types_set.add(typ)
             if isinstance(typ, QAPISchemaArrayType):
                 self._register_type(typ.element_type)
 
@@ -156,9 +157,9 @@ def introspection_name(self, typ: QAPISchemaType) -> str:
             return typ.name
         if isinstance(typ, QAPISchemaArrayType):
             return '[' + self.introspection_name(typ.element_type) + ']'
-        assert typ in self._used_types_set
+        assert typ in self._types_set
         return self.masked_name(typ.name)
 
-    def used_types(self) -> Sequence[QAPISchemaType]:
+    def types(self) -> Sequence[QAPISchemaType]:
         """Return the types to include in QAPI introspection."""
-        return self._used_types
+        return self._types

-- 
2.55.0.543.g5ebe2ebe4ea8


