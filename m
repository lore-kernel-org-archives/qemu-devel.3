Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1591BC88E58
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Jg-0007o7-GS; Fri, 11 Sep 2026 12:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54Jc-0007Xm-2x
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JX-0007Mj-6K
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1wf+ZaNqzK9wfZCZMhyYKH8FlTyI6i370Yt222zEpII=;
 b=HAUrMoFo7WEiaBTM4akUIhTkZJ853UO7sjvuP5VaTF5a5HYB+8OPG3qdyTbzy+SXUqa34I
 CVPAPmCX8XSaOkIUjGcIVHTTYt6Th3EWqBBV/LyALp3Vxh+9NZh9YzN7MxlJS68kNNazVV
 Cl3p4y2gQ/8pzAp2DoWw74UNh9VEx+4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73-I6aaEsaDO6mGVxzAkSVKXA-1; Fri,
 11 Sep 2026 12:41:19 -0400
X-MC-Unique: I6aaEsaDO6mGVxzAkSVKXA-1
X-Mimecast-MFC-AGG-ID: I6aaEsaDO6mGVxzAkSVKXA_1789144878
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2155118011F6; Fri, 11 Sep 2026 16:41:18 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56E4C180036E; Fri, 11 Sep 2026 16:41:16 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:36 +0400
Subject: [PATCH v5 62/62] qapi: select introspectable types directly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-62-7732a55b7760@redhat.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9672;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3l7VhEaWRpQ+gnlEeTMg+ppu0Il4yvb3NhaK9k9PeXk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC29KHCofOlY5OUWdzaJIsTBpfL12FupyCABx
 8FNwKzFvXqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtvQAKCRDa6OEJdZac
 5ag6D/4lYvIsK2XkzHc4vP/h00ldULp4Gf3/30l1u7iJ32PeZ+wXkpypita0hNEbdU0LJSuTsjM
 EvzDi+jPQkgbczBGMBz2aJ1lrdsW6EHYaOi5y3zLaBRkhO0uZcZo74XCqHECSoDJtWnaM8AnaEU
 r1h8u7Ce1l1t4Cu6dSpsUM3Ay2sqC4hPNYEBIb9Nhj9gJyKVk4k8Ip93m4NJD0FyI49XXvVTG7u
 tSPYveDC/t/D8+49pae03BkWEdqU1WQ61Ccmx/Nb6RWFr44AecUbkzpnYFmJGYxe2TyU2v+X9/y
 YoB3/8xNAIs5K+TQhB1qKDqfaPRANOL6wbYl2VKM4tmC3jsIgspVBq4JW8Gs0dLMLKv9k6iCwkZ
 PXzT8WQCtaR7jAuI+vh7P/441nQMHa6f+iySkyOvp0mD9xQ+OCo++JNFfGFfwkMVSqBzuB5KEUY
 eX0qd3tOAtseiDe2B/DvOKsSkqqYla9nfs7Lf/K0r2d3BczJeP9zS4ZgFPlSAqDEJbsupTuskAi
 zxv0UR5Ag9YVmBI4TWPpceoH68JSlODkHANN+YN2VOTqsy+C789EyMlo+EHxIWWkUvPBynEkFFT
 EdB674AhK28FqSgVGiWDDdE+qLnOgKVETBSj3h7qirmhVTVg1UvSbsLf6Yjpa8uzSXb+ED1oHxT
 bP1BJGc7K7QSXlA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

With all explicit types exposed, introspection no longer needs a
reachability walk. Mark the internal QType enum and inline union bases
as non-introspectable where they are created, then collect eligible
types and assign names in a single schema pass.

Remove dependency traversal. Implicit argument objects and arrays remain
included.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/qapi/introspect.py      |   4 +-
 scripts/qapi/schema.py          |  16 ++++--
 scripts/qapi/schema_analysis.py | 110 ++++++----------------------------------
 3 files changed, 29 insertions(+), 101 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index e3749d38ced5..99eac5484528 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -202,7 +202,7 @@ def visit_begin(self, schema: QAPISchema) -> None:
         self._schema = schema
 
     def visit_end(self) -> None:
-        # visit the types that are actually used
+        # Visit all introspectable types
         for typ in self._schema_types.types():
             typ.visit(self)
         # generate C
@@ -222,7 +222,7 @@ def visit_end(self) -> None:
         self._trees = []
 
     def visit_needed(self, entity: QAPISchemaEntity) -> bool:
-        # Ignore types on first pass; visit_end() will pick up used types
+        # Ignore types on first pass; visit_end() emits introspectable types
         return not isinstance(entity, QAPISchemaType)
 
     @staticmethod
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 8d88b40de2e1..10c5299bcf6d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -323,6 +323,9 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
 
 
 class QAPISchemaType(QAPISchemaDefinition, ABC):
+    # Internal types without a separate wire representation opt out.
+    introspectable: bool = True
+
     # Return the C type for common use.
     # For the types we commonly box, this is a pointer type.
     @abstractmethod
@@ -1265,8 +1268,10 @@ def _def_predefineds(self) -> None:
         qtype_values = self._make_enum_members(
             [{'name': n} for n in qtypes], None)
 
-        self._def_definition(QAPISchemaEnumType(
-            'QType', None, None, None, None, qtype_values, None))
+        qtype = QAPISchemaEnumType(
+            'QType', None, None, None, None, qtype_values, None)
+        qtype.introspectable = False
+        self._def_definition(qtype)
 
     def _make_features(
         self,
@@ -1331,8 +1336,11 @@ def _make_implicit_object_type(
             # only be a duplicate definition, which will be flagged
             # later.
         else:
-            self._def_definition(QAPISchemaObjectType(
-                name, info, None, ifcond, None, None, members, None))
+            typ = QAPISchemaObjectType(
+                name, info, None, ifcond, None, None, members, None)
+            # Inline union bases are flattened into the containing union.
+            typ.introspectable = role != 'base'
+            self._def_definition(typ)
         return name
 
     def _def_enum_type(self, expr: QAPIExpression) -> None:
diff --git a/scripts/qapi/schema_analysis.py b/scripts/qapi/schema_analysis.py
index 1aad2dc80380..03804f60e0e0 100644
--- a/scripts/qapi/schema_analysis.py
+++ b/scripts/qapi/schema_analysis.py
@@ -10,129 +10,50 @@
  Marc-André Lureau <marcandre.lureau@redhat.com>
 """
 
-from typing import (
-    Dict,
-    List,
-    Optional,
-    Sequence,
-    Set,
-)
+from typing import Dict, List, Sequence
 
 from .schema import (
     QAPISchema,
-    QAPISchemaAlternatives,
     QAPISchemaArrayType,
-    QAPISchemaBranches,
     QAPISchemaBuiltinType,
     QAPISchemaEntity,
-    QAPISchemaFeature,
-    QAPISchemaIfCond,
-    QAPISchemaObjectType,
-    QAPISchemaObjectTypeMember,
     QAPISchemaType,
     QAPISchemaVisitor,
 )
-from .source import QAPISourceInfo
 
 
 class QAPISchemaTypeAnalysis(QAPISchemaVisitor):
     """Analyze types from a QAPI schema.
 
-    Every non-builtin, non-array type is given a masked introspection
-    name (an integer string).
+    Every included non-builtin, non-array type is assigned an introspection
+    name. Names are masked as integer strings unless unmasking is requested.
     """
 
     def __init__(self, unmask: bool):
         self._unmask = unmask
-        self._schema: Optional[QAPISchema] = None
-        # Ordered list + set: insert during iteration + O(1) check
         self._types: List[QAPISchemaType] = []
-        self._types_set: Set[QAPISchemaType] = set()
         self._name_map: Dict[str, str] = {}
 
     def visit_begin(self, schema: QAPISchema) -> None:
-        self._schema = schema
         self._types = []
-        self._types_set = set()
         self._name_map = {}
 
-    def visit_end(self) -> None:
-        assert self._schema is not None
-        # Discover type dependencies; the list grows as
-        # visiting each type registers the types it references.
-        for typ in self._types:
-            typ.visit(self)
-
-        # Assign masked names now that all introspected types are known.
-        counter = 0
-        for typ in self._types:
-            if isinstance(typ, (QAPISchemaBuiltinType, QAPISchemaArrayType)):
-                continue
-            self._name_map[typ.name] = (
-                typ.name if self._unmask else str(counter))
-            counter += 1
-
     def visit_needed(self, entity: QAPISchemaEntity) -> bool:
-        # Side effect: register all introspectable types now, so that
-        # visit_end() can traverse them to discover type dependencies.
-        if isinstance(entity, QAPISchemaType):
-            if (not entity.is_implicit() or
-                    isinstance(entity, QAPISchemaArrayType)):
-                self._register_type(entity)
-            return False
-        return True
-
-    def visit_command(self, name: str, info: Optional[QAPISourceInfo],
-                      ifcond: QAPISchemaIfCond,
-                      features: List[QAPISchemaFeature],
-                      arg_type: Optional[QAPISchemaObjectType],
-                      ret_type: Optional[QAPISchemaType], gen: bool,
-                      success_response: bool, boxed: bool, allow_oob: bool,
-                      allow_preconfig: bool, coroutine: bool) -> None:
-        assert self._schema is not None
-        self._register_type(arg_type or self._schema.the_empty_object_type)
-        self._register_type(ret_type or self._schema.the_empty_object_type)
-
-    def visit_event(self, name: str, info: Optional[QAPISourceInfo],
-                    ifcond: QAPISchemaIfCond,
-                    features: List[QAPISchemaFeature],
-                    arg_type: Optional[QAPISchemaObjectType],
-                    boxed: bool) -> None:
-        assert self._schema is not None
-        self._register_type(arg_type or self._schema.the_empty_object_type)
-
-    def visit_object_type_flat(
-            self, name: str, info: Optional[QAPISourceInfo],
-            ifcond: QAPISchemaIfCond,
-            features: List[QAPISchemaFeature],
-            members: List[QAPISchemaObjectTypeMember],
-            branches: Optional[QAPISchemaBranches]) -> None:
-        for m in members:
-            self._register_type(m.type)
-        if branches:
-            for v in branches.variants:
-                self._register_type(v.type)
-
-    def visit_alternate_type(
-            self, name: str, info: Optional[QAPISourceInfo],
-            ifcond: QAPISchemaIfCond,
-            features: List[QAPISchemaFeature],
-            alternatives: QAPISchemaAlternatives) -> None:
-        for m in alternatives.variants:
-            self._register_type(m.type)
-
-    def _register_type(self, typ: QAPISchemaType) -> None:
-        """Record a type for introspection (idempotent)."""
-        if typ not in self._types_set:
-            self._types.append(typ)
-            self._types_set.add(typ)
-            if isinstance(typ, QAPISchemaArrayType):
-                self._register_type(typ.element_type)
+        if isinstance(entity, QAPISchemaType) and entity.introspectable:
+            self._types.append(entity)
+            if not isinstance(entity, (QAPISchemaBuiltinType,
+                                       QAPISchemaArrayType)):
+                self._name_map[entity.name] = (
+                    entity.name if self._unmask else str(len(self._name_map)))
+        return False
 
     def masked_name(self, name: str) -> str:
-        """Return the masked name for a non-builtin, non-array type."""
+        """Return a non-builtin, non-array type's assigned introspection name.
+
+        Return the original name when unmasking is requested.
+        """
         assert name in self._name_map, \
-            f"type '{name}' was not registered or is builtin/array"
+            f"type '{name}' has no assigned introspection name"
         return self._name_map[name]
 
     def introspection_name(self, typ: QAPISchemaType) -> str:
@@ -141,7 +62,6 @@ def introspection_name(self, typ: QAPISchemaType) -> str:
             return typ.name
         if isinstance(typ, QAPISchemaArrayType):
             return '[' + self.introspection_name(typ.element_type) + ']'
-        assert typ in self._types_set
         return self.masked_name(typ.name)
 
     def types(self) -> Sequence[QAPISchemaType]:

-- 
2.55.0.543.g5ebe2ebe4ea8


