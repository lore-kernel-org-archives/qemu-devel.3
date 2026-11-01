Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B551606A324
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Nov 2026 20:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GzE3kMzG
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNbzi-0004rq-E8; Sun, 01 Nov 2026 15:17:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbzb-0004pr-SB
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNbza-00079Q-0h
 for qemu-devel@nongnu.org; Sun, 01 Nov 2026 15:17:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793564245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CSxgsTUnQouCiI9l4m+bAXq4jKGAtFjLqin4bnvrP94=;
 b=GzE3kMzG1B4BuJTNaKalS/1m5U5mVBeaVAUvj8WRPC7xuwFDXKrsYpgJnc5xEksoQTxAUW
 JQbgKuvhm+9OZmertA0Voawu/utL9ypjxwLwKrIHspFmBmaWG5fG72PAiD7TFMgzsxMe2R
 gwuJDTg+lgrX4nQAsI5Vx9Pytxl62tg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-380-2yafYqvaMvKN8VVTv4PLZw-1; Sun,
 01 Nov 2026 15:17:21 -0500
X-MC-Unique: 2yafYqvaMvKN8VVTv4PLZw-1
X-Mimecast-MFC-AGG-ID: 2yafYqvaMvKN8VVTv4PLZw_1793564240
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3808519560B7
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EAE24195608B
 for <qemu-devel@nongnu.org>; Sun,  1 Nov 2026 20:17:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9508A21E692D; Sun, 01 Nov 2026 21:17:17 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	pbonzini@redhat.com,
	berrange@redhat.com
Subject: [PATCH v8 01/56] qapi/schema: Rename .lookup_entity() and tighten
 return type
Date: Sun,  1 Nov 2026 21:16:22 +0100
Message-ID: <20261101201717.3911097-2-armbru@redhat.com>
In-Reply-To: <20261101201717.3911097-1-armbru@redhat.com>
References: <20261101201717.3911097-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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


