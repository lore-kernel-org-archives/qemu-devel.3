Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC692CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:05:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBDJ-0000tG-Vy; Fri, 09 Oct 2026 10:04:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDI-0000sT-EJ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDG-0007Tk-Vv
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791554682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zmlXgzNE4BsM+gSTwsbMzIiXDHGXqNkooV3t9InUBt8=;
 b=KZNz7dfYTv0u2y5fEnmYUK08CWvyKly8UVHHl4hVscT8xEOGdqTaO2lS5WAkxESw6mEgXn
 hJuYUtGkPyDU5d4aaX9nT2GeiI360dlCworXbho5OX6mYop3I4oPGVh+/ZITt3ljvzdCpS
 0WHQWrhLMWWQaNO4xX5gCV5nSfJzo9U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-602-_GK4jmoAO_iACpSC0K-Uzg-1; Fri,
 9 Oct 2026 14:04:39 +0000
X-MC-Unique: _GK4jmoAO_iACpSC0K-Uzg-1
X-Mimecast-MFC-AGG-ID: _GK4jmoAO_iACpSC0K-Uzg_1791554677
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 053181955D93; Fri,  9 Oct 2026 14:04:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B287E1800361; Fri,  9 Oct 2026 14:04:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E77A21E6885; Fri, 09 Oct 2026 16:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	michael.roth@amd.com,
	jsnow@redhat.com
Subject: [RFC PATCH 6/6] qapi/introspect: Tweak integer type masking
Date: Fri,  9 Oct 2026 16:04:31 +0200
Message-ID: <20261009140431.3175479-7-armbru@redhat.com>
In-Reply-To: <20261009140431.3175479-1-armbru@redhat.com>
References: <20261009140431.3175479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Since introspection maps all integer types to 'int', we need to skip
all but one of them.  Instead of filtering by hardcoded name, filter
out duplicates.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 15302ecf15..dc6f70a6fe 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -172,7 +172,7 @@ def __init__(self, prefix: str, unmask: bool):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
-        self._trees: List[Annotated[SchemaInfo]] = []
+        self._trees: Dict[str, Annotated[SchemaInfo]] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -191,13 +191,14 @@ def visit_end(self) -> None:
 extern const QLitObject %(c_name)s;
 ''',
                              c_name=c_name(name)))
+        trees = list(self._trees.values())
         self._genc.add(mcgen('''
 const QLitObject %(c_name)s = %(c_string)s;
 ''',
                              c_name=c_name(name),
-                             c_string=_tree_to_qlit(self._trees)))
+                             c_string=_tree_to_qlit(trees)))
         self._schema = None
-        self._trees = []
+        self._trees = {}
 
     def _name(self, name: str) -> str:
         assert self._schema
@@ -235,7 +236,12 @@ def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
         obj['meta-type'] = mtype
         if features:
             obj['features'] = self._gen_features(features)
-        self._trees.append(Annotated(obj, ifcond, comment))
+        if introspection_name in self._trees:
+            # Duplicates are possible because
+            # QAPISchemaBuiltinType.introspection_name() returns 'int'
+            # for all integer types.  Ignore them.
+            return
+        self._trees[introspection_name] = Annotated(obj, ifcond, comment)
 
     def _gen_enum_member(self, member: QAPISchemaEnumMember
                          ) -> Annotated[SchemaInfoEnumMember]:
@@ -268,8 +274,6 @@ def _gen_variant(self, variant: QAPISchemaVariant
 
     def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
                            json_type: str) -> None:
-        if json_type == 'int' and name != 'int':
-            return
         self._gen_tree(name, 'builtin', {'json-type': json_type})
 
     def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
@@ -287,8 +291,6 @@ def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
     def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
                          ifcond: QAPISchemaIfCond,
                          element_type: QAPISchemaType) -> None:
-        if element_type.json_type() == 'int' and name != 'intList':
-            return
         element = self._use_type(element_type)
         self._gen_tree(name, 'array', {'element-type': element}, ifcond)
 
-- 
2.55.0


