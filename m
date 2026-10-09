Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD0DCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:05:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBDI-0000sM-5V; Fri, 09 Oct 2026 10:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDF-0000rk-Ln
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDD-0007T1-CG
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791554677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r7j/xoTFi8J56u7Lizjo2qLZPXawPskxyd5srOi+aZY=;
 b=W7+kdRlIXQSI11K5Z7ihvi9kvuZW7a8jdysmmevFmF44rgHb2tL4koXc1qNaYN4vBI/3sB
 1AF/YlVa40/5tzeELsHW55i7QOmGV0brDblMbzCRsmgc1+yZkB6enL5PBVFsclwtu2aNMo
 LqKCuuTcmydpdubETPJMCzANV0n/uiU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-GtE3I6CVM5queF__KBVoMQ-1; Fri,
 9 Oct 2026 14:04:35 +0000
X-MC-Unique: GtE3I6CVM5queF__KBVoMQ-1
X-Mimecast-MFC-AGG-ID: GtE3I6CVM5queF__KBVoMQ_1791554674
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33CFD1955F71; Fri,  9 Oct 2026 14:04:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 972B730001BB; Fri,  9 Oct 2026 14:04:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5619821E6883; Fri, 09 Oct 2026 16:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	michael.roth@amd.com,
	jsnow@redhat.com
Subject: [RFC PATCH 4/6] qapi/introspect: Don't elide types
Date: Fri,  9 Oct 2026 16:04:29 +0200
Message-ID: <20261009140431.3175479-5-armbru@redhat.com>
In-Reply-To: <20261009140431.3175479-1-armbru@redhat.com>
References: <20261009140431.3175479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
---
 scripts/qapi/introspect.py | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

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


