Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D980DC79F85
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 20:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2a84-0007Gh-Sh; Fri, 04 Sep 2026 16:03:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7f-0006X6-Jz
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x2a7d-0000F6-F5
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 16:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788552168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lIWD43VFl3TxW9MusC/G2QnK5XBQflgz2T49dLLBGHg=;
 b=SDR127COcGrv7VZw+CZv+BwrfasxJEnfIiH0ErJf7P1+nLSAbRsaELcqvpde7inqJjazqQ
 H1Gm6Unrp3N9aflu16XcyOUXMWlia4bb3GB/zU5hMFvD08XS4Kt/M9Q8nlwhVwG2Lc8Hi4
 ycmWk6L+32dHR3j1GTX5SROlf/IOlBI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-183-_O3eFB1TNUy_9FWKYQTemg-1; Fri,
 04 Sep 2026 16:02:47 -0400
X-MC-Unique: _O3eFB1TNUy_9FWKYQTemg-1
X-Mimecast-MFC-AGG-ID: _O3eFB1TNUy_9FWKYQTemg_1788552166
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D6EA180AE12; Fri,  4 Sep 2026 20:02:46 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2F3011955D8D; Fri,  4 Sep 2026 20:02:44 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 04 Sep 2026 23:58:57 +0400
Subject: [PATCH v4 74/75] qapi: expose integer signedness and width in
 introspection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260904-qom-qapi-v4-74-a985f168e938@redhat.com>
References: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
In-Reply-To: <20260904-qom-qapi-v4-0-a985f168e938@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=8446;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=LJPllIkg6wKToPmVx8RTOdW0Jstfox64RTLtI3VMjQM=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqmyLMQZSyJjoIVRIskTDIGVZckB4WYAAaRHJ2O
 JUSKjyMkYWJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCapsizAAKCRDa6OEJdZac
 5dJ8D/9BelrLie6vyV3Y8cyRwg++ej8f5m/+bqC85tupNeBSlm1QPDRv9EXo7LVFxEtRuvWkgcT
 eXKzaQke3PDNrsCiQVwUBhImmfBbLEr51jl+gdg/atNweKO7PUJkcMUd7R3S3TEOeUUxfshOFzd
 5fz3EgGkEErmEDVdsRyKCWBmiyCwx+1PRX3kwzcaQZzeLMkm9SgbopkfJ51cv+1SMISk5CV+vwN
 LAUDXcofE1lJ3eFeq/zjUT7Xj9ZDuv67fawKjJ4dXGtOwKl5XfJjsdE+S97DBklvfRMl5VDZMHM
 aDuCRLVVOpZ6B0Sb3p9ne05lZksRWHIx7gfXKDd/ks/xU4+dgbkXnDhmkLCPqubMEpzbfasuAN+
 ALio1RGlJxJ6KGa6wtfEdXFhSZAT50jT8oyjCHqcLCanK4yzKUpvj/BH90frhhqz2c3uraPEmRW
 6X1FdNL/Reoy4Q/FxhFBTsEDpQIfe+SjLSHmggs/ht6+KsoPx1m+KEQ3GVeAsaZ2rU0KrUIuVkZ
 fTkiq4pXOi9EbaZfGyHgiwLcHRwNMBfWfFdmQUUDgYqJ8/vCc45X7Mne7Cy1m9q0qUAJRfvkpHb
 h9O4JN3MIqZYEwLKNkfRZx+/9cEy/qKBggopj0f4eZ5KSuecN5VLi6HORB6m6mVdQM2yhvqhsh4
 2YleYNgEl2N2UxQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Integer built-in types are currently canonicalized to "int" in
query-qmp-schema. Consequently, clients cannot distinguish types such
as int8, uint64, and size, even though they accept different ranges.

Preserve the individual integer types during schema analysis and add an
optional "integer" member to SchemaInfoBuiltin. It reports whether the
type is signed and its width in bits. This also preserves the actual
element type for arrays of integers.

Teach the introspection generator to emit integer values and update the
documentation to describe the extended schema information.

For example for introspection, for all kind of int, before:
{"name": "int", "json-type": "int", "meta-type": "builtin"}

After, there are various int types such as:
{"name": "int64", "integer": {"bits": 64, "signed": true}, "json-type":
"int", "meta-type": "builtin"}

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 docs/devel/qapi-code-gen.rst    | 24 ++++++++++++++----------
 qapi/introspect.json            | 20 +++++++++++++++++++-
 scripts/qapi/introspect.py      | 29 ++++++++++++++++++++++++++---
 scripts/qapi/schema_analysis.py | 16 ----------------
 4 files changed, 59 insertions(+), 30 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index d176238fc2ef..a158f017d9a7 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1400,14 +1400,19 @@ Example: the SchemaInfo for str ::
 
     { "name": "str", "meta-type": "builtin", "json-type": "string" }
 
-The QAPI schema supports a number of integer types that only differ in
-how they map to C.  They are identical as far as SchemaInfo is
-concerned.  Therefore, they get all mapped to a single type "int" in
-SchemaInfo.
+The QAPI schema supports a number of integer types with different widths
+and signedness.  Each has its own SchemaInfo with "json-type" "int" and
+variant member "integer" specifying its "signed" flag and width in
+"bits".
+
+Example: the SchemaInfo for uint8 ::
+
+    { "name": "uint8", "meta-type": "builtin", "json-type": "int",
+      "integer": { "signed": false, "bits": 8 } }
 
 As explained above, type names are not part of the wire ABI.  Not even
-the names of built-in types.  Clients should examine member
-"json-type" instead of hard-coding names of built-in types.
+the names of built-in types.  Clients should examine members "json-type"
+and "integer" instead of hard-coding names of built-in types.
 
 
 Compatibility considerations
@@ -2130,10 +2135,9 @@ Each ``QAPITypeInfo`` struct has the following fields:
 ``masked_name``
     For user-defined types, the masked name used in
     ``query-qmp-schema`` output. For array types, the corresponding
-    bracketed introspection name. Built-in types use their QAPI name;
-    note that introspection canonicalizes the integer built-in types
-    to ``int``. Internal types not present in introspection use
-    ``NULL``.
+    bracketed introspection name. Built-in types, including the distinct
+    integer types, use their QAPI name. Internal types not present in
+    introspection use ``NULL``.
 
 ``lookup``
     For enum types, a pointer to the corresponding ``QEnumLookup``
diff --git a/qapi/introspect.json b/qapi/introspect.json
index c8432c8ed8ec..8b5848862c4e 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -117,10 +117,28 @@
 #
 # @json-type: the JSON type used for this type on the wire.
 #
+# @integer: the integer type's representation.  Present exactly when
+#     @json-type is 'int'.  (since 11.2)
+#
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoBuiltin',
-  'data': { 'json-type': 'JSONType' } }
+  'data': { 'json-type': 'JSONType',
+            '*integer': 'SchemaInfoBuiltinInteger' } }
+
+##
+# @SchemaInfoBuiltinInteger:
+#
+# Representation of an integer built-in type.
+#
+# @signed: whether the integer is signed.
+#
+# @bits: the integer's width in bits.
+#
+# Since: 11.2
+##
+{ 'struct': 'SchemaInfoBuiltinInteger',
+  'data': { 'signed': 'bool', 'bits': 'int' } }
 
 ##
 # @JSONType:
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index ce37ce787567..e3749d38ced5 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -49,7 +49,7 @@
 # A complexity over JSON is that our values may or may not be annotated.
 #
 # Un-annotated values may be:
-#     Scalar: str, bool, None.
+#     Scalar: str, bool, int, None.
 #     Non-scalar: List, Dict
 # _value = Union[str, bool, None, Dict[str, JSONValue], List[JSONValue]]
 #
@@ -59,11 +59,25 @@
 # Sadly, mypy does not support recursive types; so the _Stub alias is used to
 # mark the imprecision in the type model where we'd otherwise use JSONValue.
 _Stub = Any  # pylint: disable=invalid-name
-_Scalar = Union[str, bool, None]
+_Scalar = Union[str, bool, int, None]
 _NonScalar = Union[Dict[str, _Stub], List[_Stub]]
 _Value = Union[_Scalar, _NonScalar]
 JSONValue = Union[_Value, 'Annotated[_Value]']
 
+
+_INTEGER_TYPE_INFO = {
+    'int': (True, 64),
+    'int8': (True, 8),
+    'int16': (True, 16),
+    'int32': (True, 32),
+    'int64': (True, 64),
+    'uint8': (False, 8),
+    'uint16': (False, 16),
+    'uint32': (False, 32),
+    'uint64': (False, 64),
+    'size': (False, 64),
+}
+
 # These types are based on structures defined in QEMU's schema, so we
 # lack precise types for them here. Python 3.6 does not offer
 # TypedDict constructs, so they are broadly typed here as simple
@@ -135,6 +149,8 @@ def indent(level: int) -> str:
         ret += f"QLIT_QSTR({to_c_string(obj)})"
     elif isinstance(obj, bool):
         ret += f"QLIT_QBOOL({str(obj).lower()})"
+    elif isinstance(obj, int):
+        ret += f"QLIT_QNUM({obj})"
 
     # Non-scalars:
     elif isinstance(obj, list):
@@ -271,7 +287,14 @@ def _gen_variant(self, variant: QAPISchemaVariant
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-        self._gen_tree(name, 'builtin', {'json-type': json_type})
+        obj: Dict[str, object] = {'json-type': json_type}
+        if json_type == 'int':
+            signed, bits = _INTEGER_TYPE_INFO[name]
+            obj['integer'] = {
+                'signed': signed,
+                'bits': bits,
+            }
+        self._gen_tree(name, 'builtin', obj)
 
     def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
                         ifcond: QAPISchemaIfCond,
diff --git a/scripts/qapi/schema_analysis.py b/scripts/qapi/schema_analysis.py
index 1d12306f61e2..1aad2dc80380 100644
--- a/scripts/qapi/schema_analysis.py
+++ b/scripts/qapi/schema_analysis.py
@@ -123,27 +123,12 @@ def visit_alternate_type(
 
     def _register_type(self, typ: QAPISchemaType) -> None:
         """Record a type for introspection (idempotent)."""
-        typ = self._canonicalize_type(typ)
         if typ not in self._types_set:
             self._types.append(typ)
             self._types_set.add(typ)
             if isinstance(typ, QAPISchemaArrayType):
                 self._register_type(typ.element_type)
 
-    def _canonicalize_type(self, typ: QAPISchemaType) -> QAPISchemaType:
-        """Canonicalize integer types to plain int."""
-        assert self._schema is not None
-        if typ.json_type() == 'int':
-            type_int = self._schema.lookup_type('int')
-            assert type_int
-            return type_int
-        if (isinstance(typ, QAPISchemaArrayType) and
-                typ.element_type.json_type() == 'int'):
-            type_intlist = self._schema.lookup_type('intList')
-            assert type_intlist
-            return type_intlist
-        return typ
-
     def masked_name(self, name: str) -> str:
         """Return the masked name for a non-builtin, non-array type."""
         assert name in self._name_map, \
@@ -152,7 +137,6 @@ def masked_name(self, name: str) -> str:
 
     def introspection_name(self, typ: QAPISchemaType) -> str:
         """Return the introspection name for a type."""
-        typ = self._canonicalize_type(typ)
         if isinstance(typ, QAPISchemaBuiltinType):
             return typ.name
         if isinstance(typ, QAPISchemaArrayType):

-- 
2.55.0.543.g5ebe2ebe4ea8


