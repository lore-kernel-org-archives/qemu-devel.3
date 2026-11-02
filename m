Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EE7606C541
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fpe77ORa
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtDw-0003ZD-06; Mon, 02 Nov 2026 09:41:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD6-0003CC-7E
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD4-0008QY-3X
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630429;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gzmXv7OAR6YIIk+AkZhohdUnPss/h2HWsXgpzVBE9+w=;
 b=fpe77ORa2UtbQpC/lxORXiXLD2k+iN8j5KVv69Ai2EXhND9jAS3pUq6zXBVQre5BnuKX5L
 Yqvdl/nnsENN9ovj97xKVD1v50zs4QJX83Ke7Cglr88qjyWWrkv9S8C8jUbaWyCeD86zFe
 BnkpDt6KiKQzhOSpF5p4fSiBUkfUKo0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-461-t5egH857PiGkyxWWaPThfA-1; Mon,
 02 Nov 2026 09:40:28 -0500
X-MC-Unique: t5egH857PiGkyxWWaPThfA-1
X-Mimecast-MFC-AGG-ID: t5egH857PiGkyxWWaPThfA_1793630427
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3129D1800D8D; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E120018004D2; Mon,  2 Nov 2026 14:40:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C5A021E689B; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 23/74] qapi/introspect: Tweak integer type masking
Date: Mon,  2 Nov 2026 15:39:27 +0100
Message-ID: <20261102144018.3212223-24-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Since introspection maps all integer types to 'int', we need to skip
all but one of them.  Instead of filtering by hardcoded name, filter
out duplicates.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261101201717.3911097-7-armbru@redhat.com>
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


