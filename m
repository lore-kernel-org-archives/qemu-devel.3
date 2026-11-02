Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D661D606A5BC
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NOmldUwi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtEB-0003xy-1O; Mon, 02 Nov 2026 09:41:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDB-0003DF-Uq
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD8-0008S8-9M
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QeRm/AHNPeQvFEi2K+G5n11YZ7LPmUa7esM2HjTXHiE=;
 b=NOmldUwisInUDDeP5sgcAOP/seISewUKvO6l89uors/3X26NPVXYNF00r3fCQ/8q4yrjek
 X7qljAdkCBXG64Ni7TKkgXr5xebOhE0DPd4U0AW5VK89IrOFCtbBGxIK/bPLGHiTF8qgqv
 EHyPMiJ0Fr1M4yvE73hHScU9UaB8gck=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-175-iM20B0WVN1Sh63mb7QcW5Q-1; Mon,
 02 Nov 2026 09:40:28 -0500
X-MC-Unique: iM20B0WVN1Sh63mb7QcW5Q-1
X-Mimecast-MFC-AGG-ID: iM20B0WVN1Sh63mb7QcW5Q_1793630427
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73706195BDD0; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C3BA1956088; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 374D921E6896; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 18/74] qapi/schema: Rename .lookup_entity() and tighten return
 type
Date: Mon,  2 Nov 2026 15:39:22 +0100
Message-ID: <20261102144018.3212223-19-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Commit 060b5a9323 (qapi: Dumb down QAPISchema.lookup_entity())
accidentally relaxed QAPISchema.lookup_entity()'s return type to
QAPISchemaEntity.  Tighten it back to QAPISchemaDefinition, and rename
the method to .lookup_defn().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261101201717.3911097-2-armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 2 +-
 scripts/qapi/schema.py | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 54a32e45f7..31d09ed634 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -512,7 +512,7 @@ def transmogrify(self, schema: QAPISchema) -> nodes.Element:
                 modules.add(module_source)
 
             if doc.symbol:
-                ent = schema.lookup_entity(doc.symbol)
+                ent = schema.lookup_defn(doc.symbol)
                 assert isinstance(ent, QAPISchemaDefinition)
                 vis.visit_entity(ent)
             else:
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 8d88b40de2..9c9e257a8f 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1184,11 +1184,11 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
                 defn.info, "%s is already defined" % other_defn.describe())
         self._entity_dict[defn.name] = defn
 
-    def lookup_entity(self, name: str) -> Optional[QAPISchemaEntity]:
+    def lookup_defn(self, name: str) -> Optional[QAPISchemaDefinition]:
         return self._entity_dict.get(name)
 
     def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
-        typ = self.lookup_entity(name)
+        typ = self.lookup_defn(name)
         if isinstance(typ, QAPISchemaType):
             return typ
         return None
@@ -1324,7 +1324,7 @@ def _make_implicit_object_type(
             return None
         # See also QAPISchemaObjectTypeMember.describe()
         name = 'q_obj_%s-%s' % (name, role)
-        typ = self.lookup_entity(name)
+        typ = self.lookup_defn(name)
         if typ:
             assert isinstance(typ, QAPISchemaObjectType)
             # The implicit object type has multiple users.  This can
-- 
2.55.0


