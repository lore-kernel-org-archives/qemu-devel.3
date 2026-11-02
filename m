Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34EA5606AB93
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q5T8hZKL
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDc-0003QU-Nb; Mon, 02 Nov 2026 09:41:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD8-0003Cm-UF
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD5-0008R4-2O
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/UYa6LLClnDjYHXTafCjn8wvKGxrdMcS48zwF7HEK0=;
 b=Q5T8hZKLxnhULZB+dBtbeS3oHPn9xBpM+M5Ot2fIZPenl3T8cazwfr3t7fzyMrXshWLuh+
 1o/ew6NSAZC0CkZUzF+lcLnvx26xXdaSDjxhidbBPgkM/yPZTrv5DDkItF7ohMMzbMEZ+L
 /Ql+DWSF0aVv5Pw2IpcXaC16iNqddeE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-xp2d7Uq3Nhqt4Znejuo7ug-1; Mon,
 02 Nov 2026 09:40:28 -0500
X-MC-Unique: xp2d7Uq3Nhqt4Znejuo7ug-1
X-Mimecast-MFC-AGG-ID: xp2d7Uq3Nhqt4Znejuo7ug_1793630427
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 918CF180A9E2; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13A671955F43; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4419221E6899; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 21/74] qapi/introspect: Don't elide types
Date: Mon,  2 Nov 2026 15:39:25 +0100
Message-ID: <20261102144018.3212223-22-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

query-qmp-schema elides types not reachable from commands and events.
It currently emits 1251 out of 1385 definitions, and elides 134 types.
Whether that's worthwhile is debatable.

Marc-André Lureau would like to make QOM introspection (qom-list &
friends) refer to QAPI types.  We additionally need types reachable
from QOM properties.

Unfortunately, the QAPI generator knows nothing about QOM properties.

We could manually mark the QAPI types to elide, or the QAPI types not
to elide even though they are not reachable from commands and events.
Feels very much not worthwhile to me.

We could conservatively approximate "reachable from QOM properties" by
"available for use with QOM properties".  These are the built-in and
user-defined types, and their arrays.  With that, we'd elide just 38
out of 1385 definitions.  Too few to be worthwhile.

Simply emit everything.

Output of query-qmp-schema grows from 247KiB to 274KiB for me.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261101201717.3911097-5-armbru@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 67 ++++++++++++++----------------------
 scripts/qapi/introspect.py   | 31 +++--------------
 2 files changed, 30 insertions(+), 68 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 1e89cbbcd7..3c21dda91b 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -1250,8 +1250,6 @@ JSON array of strings.
 To examine a type, start with a command or event using it, then follow
 references by name.
 
-QAPI schema definitions not reachable that way are omitted.
-
 The SchemaInfo for a command has meta-type "command", and variant
 members "arg-type", "ret-type" and "allow-oob".  On the wire, the
 "arguments" member of a client's "execute" command must conform to the
@@ -2012,32 +2010,19 @@ Example::
 
     const QLitObject example_qmp_schema_qlit = QLIT_QLIST(((QLitObject[]) {
         QLIT_QDICT(((QLitDictEntry[]) {
-            { "arg-type", QLIT_QSTR("34"), },
-            { "meta-type", QLIT_QSTR("command"), },
-            { "name", QLIT_QSTR("my-command"), },
-            { "ret-type", QLIT_QSTR("32"), },
+            { "json-type", QLIT_QSTR("string"), },
+            { "meta-type", QLIT_QSTR("builtin"), },
+            { "name", QLIT_QSTR("str"), },
             {}
         })),
+        /* "[str]" = strList */
         QLIT_QDICT(((QLitDictEntry[]) {
-            { "arg-type", QLIT_QSTR("30"), },
-            { "meta-type", QLIT_QSTR("event"), },
-            { "name", QLIT_QSTR("MY_EVENT"), },
-            {}
-        })),
-        /* "34" = q_obj_my-command-arg */
-        QLIT_QDICT(((QLitDictEntry[]) {
-            { "members", QLIT_QLIST(((QLitObject[]) {
-                QLIT_QDICT(((QLitDictEntry[]) {
-                    { "name", QLIT_QSTR("arg1"), },
-                    { "type", QLIT_QSTR("[32]"), },
-                    {}
-                })),
-                {}
-            })), },
-            { "meta-type", QLIT_QSTR("object"), },
-            { "name", QLIT_QSTR("34"), },
+            { "element-type", QLIT_QSTR("str"), },
+            { "meta-type", QLIT_QSTR("array"), },
+            { "name", QLIT_QSTR("[str]"), },
             {}
         })),
+        [Remainder of built-in types omitted...]
         /* "32" = UserDefOne */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "members", QLIT_QLIST(((QLitObject[]) {
@@ -2064,15 +2049,6 @@ Example::
             { "name", QLIT_QSTR("32"), },
             {}
         })),
-        /* "30" = q_empty */
-        QLIT_QDICT(((QLitDictEntry[]) {
-            { "members", QLIT_QLIST(((QLitObject[]) {
-                {}
-            })), },
-            { "meta-type", QLIT_QSTR("object"), },
-            { "name", QLIT_QSTR("30"), },
-            {}
-        })),
         /* "[32]" = UserDefOneList */
         QLIT_QDICT(((QLitDictEntry[]) {
             { "element-type", QLIT_QSTR("32"), },
@@ -2080,22 +2056,31 @@ Example::
             { "name", QLIT_QSTR("[32]"), },
             {}
         })),
+        /* "34" = q_obj_my-command-arg */
         QLIT_QDICT(((QLitDictEntry[]) {
-            { "json-type", QLIT_QSTR("int"), },
-            { "meta-type", QLIT_QSTR("builtin"), },
-            { "name", QLIT_QSTR("int"), },
+            { "members", QLIT_QLIST(((QLitObject[]) {
+                QLIT_QDICT(((QLitDictEntry[]) {
+                    { "name", QLIT_QSTR("arg1"), },
+                    { "type", QLIT_QSTR("[32]"), },
+                    {}
+                })),
+                {}
+            })), },
+            { "meta-type", QLIT_QSTR("object"), },
+            { "name", QLIT_QSTR("34"), },
             {}
         })),
         QLIT_QDICT(((QLitDictEntry[]) {
-            { "json-type", QLIT_QSTR("string"), },
-            { "meta-type", QLIT_QSTR("builtin"), },
-            { "name", QLIT_QSTR("str"), },
+            { "arg-type", QLIT_QSTR("34"), },
+            { "meta-type", QLIT_QSTR("command"), },
+            { "name", QLIT_QSTR("my-command"), },
+            { "ret-type", QLIT_QSTR("32"), },
             {}
         })),
         QLIT_QDICT(((QLitDictEntry[]) {
-            { "json-type", QLIT_QSTR("boolean"), },
-            { "meta-type", QLIT_QSTR("builtin"), },
-            { "name", QLIT_QSTR("bool"), },
+            { "arg-type", QLIT_QSTR("30"), },
+            { "meta-type", QLIT_QSTR("event"), },
+            { "name", QLIT_QSTR("MY_EVENT"), },
             {}
         })),
         {}
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 49d1ed2897..15302ecf15 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -28,9 +28,7 @@
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,
-    QAPISchemaArrayType,
     QAPISchemaBranches,
-    QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
     QAPISchemaIfCond,
@@ -175,7 +173,6 @@ def __init__(self, prefix: str, unmask: bool):
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
         self._trees: List[Annotated[SchemaInfo]] = []
-        self._used_types: List[QAPISchemaType] = []
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -187,10 +184,6 @@ def visit_begin(self, schema: QAPISchema) -> None:
         self._schema = schema
 
     def visit_end(self) -> None:
-        # visit the types that are actually used
-        for typ in self._used_types:
-            typ.visit(self)
-        # generate C
         name = c_name(self._prefix, protect=False) + 'qmp_schema_qlit'
         self._genh.add(mcgen('''
 #include "qobject/qlit.h"
@@ -205,32 +198,12 @@ def visit_end(self) -> None:
                              c_string=_tree_to_qlit(self._trees)))
         self._schema = None
         self._trees = []
-        self._used_types = []
-
-    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
-        # Ignore types on first pass; visit_end() will pick up used types
-        return not isinstance(entity, QAPISchemaType)
 
     def _name(self, name: str) -> str:
         assert self._schema
         return self._schema.definition_introspection_name(name, self._unmask)
 
     def _use_type(self, typ: QAPISchemaType) -> str:
-        assert self._schema is not None
-
-        # Map the various integer types to plain int
-        if typ.json_type() == 'int':
-            type_int = self._schema.lookup_type('int')
-            assert type_int
-            typ = type_int
-        elif (isinstance(typ, QAPISchemaArrayType) and
-              typ.element_type.json_type() == 'int'):
-            type_intlist = self._schema.lookup_type('intList')
-            assert type_intlist
-            typ = type_intlist
-        # Add type to work queue if new
-        if typ not in self._used_types:
-            self._used_types.append(typ)
         return self._name(typ.name)
 
     @staticmethod
@@ -295,6 +268,8 @@ def _gen_variant(self, variant: QAPISchemaVariant
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
+        if json_type == 'int' and name != 'int':
+            return
         self._gen_tree(name, 'builtin', {'json-type': json_type})
 
     def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
@@ -312,6 +287,8 @@ def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: QAPISchemaIfCond,
                          element_type: QAPISchemaType) -> None:
+        if element_type.json_type() == 'int' and name != 'intList':
+            return
         element = self._use_type(element_type)
         self._gen_tree(name, 'array', {'element-type': element}, ifcond)
 
-- 
2.55.0


