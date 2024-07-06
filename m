Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FFF5C38150
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 07:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPzmn-000726-14; Sat, 06 Jul 2024 03:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmj-0006z8-Fe
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmU-0004TN-0K
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720250662;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ns6nIeZPUAmhkYE6dKJvQg333aSyIsLC2CaNlzLLLFg=;
 b=O2AsphZM5UovDMRW9RUX8QQnW2OuQh/6Ggc7Zom0Bn+vA8jclw9VlE2Js8uTAZkIc0idER
 xzlETkFe34dWYt9VLdcO5rXK5hUEL+I70NfRADev1LfprGhaAvzxS88Bl/CNLUzwrJjjcM
 JkIRH5xOPIWdqZFqKBKQR4J2vN56s+c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-609-LmFgcelHPwaw6AigXPpgvA-1; Sat,
 06 Jul 2024 03:24:20 -0400
X-MC-Unique: LmFgcelHPwaw6AigXPpgvA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6718D19560AA; Sat,  6 Jul 2024 07:24:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C50F51955F6B; Sat,  6 Jul 2024 07:24:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 88B1F21E5A6F; Sat,  6 Jul 2024 09:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 01/13] qapi: linter fixups
Date: Sat,  6 Jul 2024 09:24:04 +0200
Message-ID: <20240706072416.1717485-2-armbru@redhat.com>
In-Reply-To: <20240706072416.1717485-1-armbru@redhat.com>
References: <20240706072416.1717485-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: John Snow <jsnow@redhat.com>

Fix minor irritants to pylint/flake8 et al.

(Yes, these need to be guarded by the Python tests. That's a work in
progress, a series that's quite likely to follow once I finish this
Sphinx project. Please pardon the temporary irritation.)

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240626222128.406106-3-jsnow@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/introspect.py | 8 ++++----
 scripts/qapi/schema.py     | 6 +++---
 scripts/qapi/visit.py      | 5 +++--
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 86c075a6ad..ac14b20f30 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -27,8 +27,8 @@
 from .schema import (
     QAPISchema,
     QAPISchemaAlternatives,
-    QAPISchemaBranches,
     QAPISchemaArrayType,
+    QAPISchemaBranches,
     QAPISchemaBuiltinType,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
@@ -233,9 +233,9 @@ def _use_type(self, typ: QAPISchemaType) -> str:
             typ = type_int
         elif (isinstance(typ, QAPISchemaArrayType) and
               typ.element_type.json_type() == 'int'):
-            type_intList = self._schema.lookup_type('intList')
-            assert type_intList
-            typ = type_intList
+            type_intlist = self._schema.lookup_type('intList')
+            assert type_intlist
+            typ = type_intlist
         # Add type to work queue if new
         if typ not in self._used_types:
             self._used_types.append(typ)
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 721c470d2b..d65c35f6ee 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -730,6 +730,7 @@ def set_defined_in(self, name: str) -> None:
         for v in self.variants:
             v.set_defined_in(name)
 
+    # pylint: disable=unused-argument
     def check(
             self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
     ) -> None:
@@ -1166,7 +1167,7 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
                 defn.info, "%s is already defined" % other_defn.describe())
         self._entity_dict[defn.name] = defn
 
-    def lookup_entity(self,name: str) -> Optional[QAPISchemaEntity]:
+    def lookup_entity(self, name: str) -> Optional[QAPISchemaEntity]:
         return self._entity_dict.get(name)
 
     def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
@@ -1302,11 +1303,10 @@ def _make_implicit_object_type(
         name = 'q_obj_%s-%s' % (name, role)
         typ = self.lookup_entity(name)
         if typ:
-            assert(isinstance(typ, QAPISchemaObjectType))
+            assert isinstance(typ, QAPISchemaObjectType)
             # The implicit object type has multiple users.  This can
             # only be a duplicate definition, which will be flagged
             # later.
-            pass
         else:
             self._def_definition(QAPISchemaObjectType(
                 name, info, None, ifcond, None, None, members, None))
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index e766acaac9..12f92e429f 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -280,8 +280,9 @@ def gen_visit_alternate(name: str,
         abort();
     default:
         assert(visit_is_input(v));
-        error_setg(errp, "Invalid parameter type for '%%s', expected: %(name)s",
-                         name ? name : "null");
+        error_setg(errp,
+                   "Invalid parameter type for '%%s', expected: %(name)s",
+                   name ? name : "null");
         /* Avoid passing invalid *obj to qapi_free_%(c_name)s() */
         g_free(*obj);
         *obj = NULL;
-- 
2.45.0


