Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55689C88E4D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 16:45:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x54Jc-0007Z8-RU; Fri, 11 Sep 2026 12:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JR-0007Og-Sy
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1x54JQ-0007LR-3m
 for qemu-devel@nongnu.org; Fri, 11 Sep 2026 12:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789144875;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tVEqcWm0qmGrTdYv0ut5E0TOgGLwGMf0sJ5a2m4C7G0=;
 b=P8wDOWkGr63OWiL4oxQ2Mt6GM5C5V2PclJzty2WLY+zipH55qdzk1hNgKpaIuEIVsOUvc1
 56FhT6XN93ZOFLoKC4C8bXt24u+hTbsH28Xf2d2QxLZfWHngPWtkU7tC53+cdn12NK+zOk
 c8XiTagdxQ2Q3OrXvPyetDXyBqyyctM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-322-INhKPXwdPBGB4uQFuRCIYA-1; Fri,
 11 Sep 2026 12:41:12 -0400
X-MC-Unique: INhKPXwdPBGB4uQFuRCIYA-1
X-Mimecast-MFC-AGG-ID: INhKPXwdPBGB4uQFuRCIYA_1789144871
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 044211955F14; Fri, 11 Sep 2026 16:41:11 +0000 (UTC)
Received: from localhost (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09EDF180029C; Fri, 11 Sep 2026 16:41:09 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 11 Sep 2026 20:35:34 +0400
Subject: [PATCH v5 60/62] qapi: expose integer signedness and width in
 introspection
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260911-qom-qapi-v5-60-7732a55b7760@redhat.com>
References: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
In-Reply-To: <20260911-qom-qapi-v5-0-7732a55b7760@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 Michael Roth <michael.roth@amd.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Eric Blake <eblake@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=7727;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=2KmQlYMMKRf4yfohcWO2babcLQFJDLHQ8w1XzeZyyow=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqpC28kMTPdDd/NGgefpN204noC9h7Alevt6ub8
 Wzd/sI/EXuJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaqQtvAAKCRDa6OEJdZac
 5dBXEACdTSUFbw2xx4zlgRd5/iP+juSXdFlUpIeyx41QX4UTI7VJASTrtjAEQIF1ecDH61w8bgz
 AIk17qkb/yk0kHqKwHTzpJ4q/w0Jyj8JuHbqk1/WHLGHiFN6G4PZvf9xsrCqJr8N0WYfX36g2yy
 DCBwfF7dHU30qhX9Im8dtHV42gJyICqXerLtLdmg7mrYQFwfbH0kVMdUT05KcG+nC6is+PV1eKW
 IAwX4poNsSJ8kiNzL5u5t1P4PRSUTbVT689ggWOmbAqutblmNlFt4AED/NBe9LLiV7vqpeCPmj5
 M+pVdZPQtjbQPouWxkwqt6VtEp+JCDSiqMwxxxHh/mu5u8RdPFkzNfn/eJR3jPaVv2SrFyk1iyI
 +DXS3+2a3UyxeGuFJRS+gpeW2dyduGmEi8vWWQ2PjUDYEec9OMlbPOxbPLwY6QAB/W47WtU151Q
 CDbMT2VutGv0+PTVR+RMoh6W+B2w93ScDzP1O/Cfnzd2ScxvyU2y2ukg5Rd0ZfM32U/wn8O+GQn
 Mc9dglf6DW+wB/0emUuiOHY6CNql0/x9gl4YGYnHxnZnD4xq2sL1Hq/llPybcsyumDXgcdJwOx6
 hUsydCRhOJkNcmqwjK2DG6mu3H9Yv7LsKRZ1SvR12Cw96rZB78Tut6FDXX8jdmu8mFeD46nE9kC
 W2jtf5I7O7c8wWA==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
 docs/devel/qapi-code-gen.rst    | 17 +++++++++++------
 qapi/introspect.json            | 20 +++++++++++++++++++-
 scripts/qapi/introspect.py      | 29 ++++++++++++++++++++++++++---
 scripts/qapi/schema_analysis.py | 16 ----------------
 4 files changed, 56 insertions(+), 26 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 69d5c4af9874..512a885f75f8 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1404,14 +1404,19 @@ Example: the SchemaInfo for str ::
 
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


