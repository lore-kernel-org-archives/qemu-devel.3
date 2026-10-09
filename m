Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF10FCA6019
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:05:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBDJ-0000sn-C7; Fri, 09 Oct 2026 10:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDG-0000s1-R0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDD-0007TB-CM
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791554678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9s+13MqC59E8bYJ9f4X5Mw2tM98XxqkQLGi0V+Eo/do=;
 b=Bztt97R90fPm41OfP3aPQEf9GenrJIUXvvBQ4SYOmmXPLyc8OZJKRsMhm9x2ny+f/5Uuu6
 E+wHcYiWy0/66PfJug2YnwgydWS0j5D4b6v3HVkDZ0nlqz3z438BFwPArP3/morvfX1CDV
 IGQ5mVziZ99YrBkw5rn610HVJfyG4uI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-DiswULCnPvm7uFFZ_7GxvA-1; Fri,
 9 Oct 2026 14:04:35 +0000
X-MC-Unique: DiswULCnPvm7uFFZ_7GxvA-1
X-Mimecast-MFC-AGG-ID: DiswULCnPvm7uFFZ_7GxvA_1791554674
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2858318345A1; Fri,  9 Oct 2026 14:04:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B224541D; Fri,  9 Oct 2026 14:04:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 49D3F21E692D; Fri, 09 Oct 2026 16:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	michael.roth@amd.com,
	jsnow@redhat.com
Subject: [RFC PATCH 1/6] qapi/schema: Rename .lookup_entity() and tighten
 return type
Date: Fri,  9 Oct 2026 16:04:26 +0200
Message-ID: <20261009140431.3175479-2-armbru@redhat.com>
In-Reply-To: <20261009140431.3175479-1-armbru@redhat.com>
References: <20261009140431.3175479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

Commit 060b5a9323 (qapi: Dumb down QAPISchema.lookup_entity())
accidentally relaxed QAPISchema.lookup_entity()'s return type to
QAPISchemaEntity.  Tighten it back to QAPISchemaDefinition, and rename
the method to .lookup_defn().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


