Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC1AAC54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 15:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkQEk-0003fx-Q9; Wed, 13 Mar 2024 11:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEY-0003a2-VI; Wed, 13 Mar 2024 11:09:37 -0400
Received: from forwardcorp1b.mail.yandex.net
 ([2a02:6b8:c02:900:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1rkQEU-0005ru-Td; Wed, 13 Mar 2024 11:09:34 -0400
Received: from mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c08:8793:0:640:b059:0])
 by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 630C860E2B;
 Wed, 13 Mar 2024 18:09:26 +0300 (MSK)
Received: from vsementsov-lin.. (unknown [2a02:6b8:b081:7318::1:20])
 by mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 99pZB52GZiE0-RMWiAOWN; Wed, 13 Mar 2024 18:09:25 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1710342565;
 bh=x0Yjo3IpW1vMsmgMTwP6wxC29Ocsm8AaiL9BdPXaULc=;
 h=Message-Id:Date:In-Reply-To:Cc:Subject:References:To:From;
 b=UUjA4evX1wTqskTwqT0ZaXBm9+JMQ7iyYJsemkKnWwSZ6m24yKpcdbktWYkcJKIdm
 Si5/yOTj4u2ZrZiQ6vK83CfFPx4BByxAUUxQbQfgbWZjwulu56LrPnDJhoKyNQzqVF
 gMFFmLde5bPICrx3BqQ4PWoY2LZ6V+IUoyKCeZV0=
Authentication-Results: mail-nwsmtp-smtp-corp-main-34.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jsnow@redhat.com, vsementsov@yandex-team.ru,
 kwolf@redhat.com, hreitz@redhat.com, devel@lists.libvirt.org,
 eblake@redhat.com, armbru@redhat.com, michael.roth@amd.com,
 pbonzini@redhat.com, pkrempa@redhat.com, f.ebner@proxmox.com
Subject: [RFC 01/15] scripts/qapi: support type-based unions
Date: Wed, 13 Mar 2024 18:08:53 +0300
Message-Id: <20240313150907.623462-2-vsementsov@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240313150907.623462-1-vsementsov@yandex-team.ru>
References: <20240313150907.623462-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c02:900:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1b.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Look at block-job-change command: we have to specify both 'id' to chose
the job to operate on and 'type' for QAPI union be parsed. But for user
this looks redundant: when we specify 'id', QEMU should be able to get
corresponding job's type.

This commit brings such a possibility: just specify some Enum type as
'discriminator', and define a function somewhere with prototype

bool YourUnionType_mapper(YourUnionType *, EnumType *out, Error **errp)

Further commits will use this functionality to upgrade block-job-change
interface and introduce some new interfaces.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
---
 scripts/qapi/introspect.py |  5 +++-
 scripts/qapi/schema.py     | 50 +++++++++++++++++++++++---------------
 scripts/qapi/types.py      |  3 ++-
 scripts/qapi/visit.py      | 43 ++++++++++++++++++++++++++------
 4 files changed, 73 insertions(+), 28 deletions(-)

diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 67c7d89aae..04d8d424f5 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -336,7 +336,10 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
             'members': [self._gen_object_member(m) for m in members]
         }
         if variants:
-            obj['tag'] = variants.tag_member.name
+            if variants.tag_member:
+                obj['tag'] = variants.tag_member.name
+            else:
+                obj['discriminator-type'] = variants.tag_type.name
             obj['variants'] = [self._gen_variant(v) for v in variants.variants]
         self._gen_tree(name, 'object', obj, ifcond, features)
 
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 8ba5665bc6..0efe8d815c 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -585,16 +585,16 @@ def visit(self, visitor):
 
 
 class QAPISchemaVariants:
-    def __init__(self, tag_name, info, tag_member, variants):
+    def __init__(self, discriminator, info, tag_member, variants):
         # Unions pass tag_name but not tag_member.
         # Alternates pass tag_member but not tag_name.
         # After check(), tag_member is always set.
-        assert bool(tag_member) != bool(tag_name)
-        assert (isinstance(tag_name, str) or
+        assert bool(tag_member) != bool(discriminator)
+        assert (isinstance(discriminator, str) or
                 isinstance(tag_member, QAPISchemaObjectTypeMember))
         for v in variants:
             assert isinstance(v, QAPISchemaVariant)
-        self._tag_name = tag_name
+        self.discriminator = discriminator
         self.info = info
         self.tag_member = tag_member
         self.variants = variants
@@ -604,16 +604,24 @@ def set_defined_in(self, name):
             v.set_defined_in(name)
 
     def check(self, schema, seen):
-        if self._tag_name:      # union
-            self.tag_member = seen.get(c_name(self._tag_name))
+        self.tag_type = None
+
+        if self.discriminator:      # assume union with type discriminator
+            self.tag_type = schema.lookup_type(self.discriminator)
+
+        # union with discriminator field
+        if self.discriminator and not self.tag_type:
+            tag_name = self.discriminator
+            self.tag_member = seen.get(c_name(tag_name))
+            self.tag_type = self.tag_member.type
             base = "'base'"
             # Pointing to the base type when not implicit would be
             # nice, but we don't know it here
-            if not self.tag_member or self._tag_name != self.tag_member.name:
+            if not self.tag_member or tag_name != self.tag_member.name:
                 raise QAPISemError(
                     self.info,
                     "discriminator '%s' is not a member of %s"
-                    % (self._tag_name, base))
+                    % (tag_name, base))
             # Here we do:
             base_type = schema.lookup_type(self.tag_member.defined_in)
             assert base_type
@@ -623,29 +631,33 @@ def check(self, schema, seen):
                 raise QAPISemError(
                     self.info,
                     "discriminator member '%s' of %s must be of enum type"
-                    % (self._tag_name, base))
+                    % (tag_name, base))
             if self.tag_member.optional:
                 raise QAPISemError(
                     self.info,
                     "discriminator member '%s' of %s must not be optional"
-                    % (self._tag_name, base))
+                    % (tag_name, base))
             if self.tag_member.ifcond.is_present():
                 raise QAPISemError(
                     self.info,
                     "discriminator member '%s' of %s must not be conditional"
-                    % (self._tag_name, base))
-        else:                   # alternate
+                    % (tag_name, base))
+        elif not self.tag_type:  # alternate
             assert isinstance(self.tag_member.type, QAPISchemaEnumType)
             assert not self.tag_member.optional
             assert not self.tag_member.ifcond.is_present()
-        if self._tag_name:      # union
+
+        if self.tag_type:      # union
             # branches that are not explicitly covered get an empty type
             cases = {v.name for v in self.variants}
-            for m in self.tag_member.type.members:
+            for m in self.tag_type.members:
                 if m.name not in cases:
                     v = QAPISchemaVariant(m.name, self.info,
                                           'q_empty', m.ifcond)
-                    v.set_defined_in(self.tag_member.defined_in)
+                    if self.tag_member:
+                        v.set_defined_in(self.tag_member.defined_in)
+                    else:
+                        v.set_defined_in(self.tag_type.name)
                     self.variants.append(v)
         if not self.variants:
             raise QAPISemError(self.info, "union has no branches")
@@ -654,11 +666,11 @@ def check(self, schema, seen):
             # Union names must match enum values; alternate names are
             # checked separately. Use 'seen' to tell the two apart.
             if seen:
-                if v.name not in self.tag_member.type.member_names():
+                if v.name not in self.tag_type.member_names():
                     raise QAPISemError(
                         self.info,
                         "branch '%s' is not a value of %s"
-                        % (v.name, self.tag_member.type.describe()))
+                        % (v.name, self.tag_type.describe()))
                 if not isinstance(v.type, QAPISchemaObjectType):
                     raise QAPISemError(
                         self.info,
@@ -1116,7 +1128,7 @@ def _make_variant(self, case, typ, ifcond, info):
     def _def_union_type(self, expr: QAPIExpression):
         name = expr['union']
         base = expr['base']
-        tag_name = expr['discriminator']
+        discriminator = expr['discriminator']
         data = expr['data']
         assert isinstance(data, dict)
         info = expr.info
@@ -1136,7 +1148,7 @@ def _def_union_type(self, expr: QAPIExpression):
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
                                  QAPISchemaVariants(
-                                     tag_name, info, None, variants)))
+                                     discriminator, info, None, variants)))
 
     def _def_alternate_type(self, expr: QAPIExpression):
         name = expr['alternate']
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index c39d054d2c..13021e3f82 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -230,7 +230,8 @@ def gen_variants(variants: QAPISchemaVariants) -> str:
     ret = mcgen('''
     union { /* union tag is @%(c_name)s */
 ''',
-                c_name=c_name(variants.tag_member.name))
+                c_name=c_name(variants.tag_member.name if variants.tag_member
+                              else variants.tag_type.name))
 
     for var in variants.variants:
         if var.type.name == 'q_empty':
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index c56ea4d724..fbe7ae071d 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -60,6 +60,13 @@ def gen_visit_members_decl(name: str) -> str:
                  c_name=c_name(name))
 
 
+def gen_visit_members_tag_mapper_decl(name: str, tag_type: str) -> str:
+    return mcgen('''
+
+bool %(c_name)s_mapper(%(c_name)s *obj, %(tag_type)s *tag, Error **errp);
+                 ''', c_name=c_name(name), tag_type=c_name(tag_type))
+
+
 def gen_visit_object_members(name: str,
                              base: Optional[QAPISchemaObjectType],
                              members: List[QAPISchemaObjectTypeMember],
@@ -83,6 +90,12 @@ def gen_visit_object_members(name: str,
             ret += memb.ifcond.gen_endif()
     ret += sep
 
+    if variants:
+        ret += mcgen('''
+    %(c_name)s tag;
+''',
+                     c_name=c_name(variants.tag_type.name))
+
     if base:
         ret += mcgen('''
     if (!visit_type_%(c_type)s_members(v, (%(c_type)s *)obj, errp)) {
@@ -132,17 +145,29 @@ def gen_visit_object_members(name: str,
         ret += memb.ifcond.gen_endif()
 
     if variants:
-        tag_member = variants.tag_member
-        assert isinstance(tag_member.type, QAPISchemaEnumType)
+        tag_type = variants.tag_type
+        assert isinstance(tag_type, QAPISchemaEnumType)
 
-        ret += mcgen('''
-    switch (obj->%(c_name)s) {
+        if variants.tag_member:
+            ret += mcgen('''
+    tag = obj->%(c_name)s;
 ''',
-                     c_name=c_name(tag_member.name))
+                         c_name=c_name(variants.tag_member.name))
+        else:
+            ret += mcgen('''
+    if (!%(c_name)s_mapper(obj, &tag, errp)) {
+        return false;
+    }
+''',
+                         c_name=c_name(name))
+
+        ret += mcgen('''
+    switch (tag) {
+''')
 
         for var in variants.variants:
-            case_str = c_enum_const(tag_member.type.name, var.name,
-                                    tag_member.type.prefix)
+            case_str = c_enum_const(tag_type.name, var.name,
+                                    tag_type.prefix)
             ret += var.ifcond.gen_if()
             if var.type.name == 'q_empty':
                 # valid variant and nothing to do
@@ -400,6 +425,10 @@ def visit_object_type(self,
             return
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_members_decl(name))
+            if variants and variants.tag_type:
+                self._genh.add(
+                    gen_visit_members_tag_mapper_decl(name,
+                                                      variants.tag_type.name))
             self._genc.add(gen_visit_object_members(name, base,
                                                     members, variants))
             # TODO Worth changing the visitor signature, so we could
-- 
2.34.1


