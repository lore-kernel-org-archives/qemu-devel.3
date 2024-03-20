Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A59C54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqc3-0003hv-HQ; Wed, 20 Mar 2024 03:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqc1-0003hR-Rh
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbz-0007kl-Sf
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710920626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OA65odhw6yvz8wFdh9oVTxjcsGiEwAHIVPPzhH06qI0=;
 b=TCW+Sm2Dt/a50ABpCcRdudh5ZwKAxUArhgwySyzkpWovTvVt5guaCahqpZSEDnpzCdZVH5
 PxD6d4jf7RYUmnvWbP+Qp72PhsHJhGpDiizwOVGFqRrYgyJO72228WA3RLwRIVPwIPqrG0
 HfbicIYyiF+hHY7dN6O/mz1g/+OLyhI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-ZvsoHS4PNeCx94QlvFyzwg-1; Wed, 20 Mar 2024 03:43:43 -0400
X-MC-Unique: ZvsoHS4PNeCx94QlvFyzwg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 09B0D800262;
 Wed, 20 Mar 2024 07:43:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C22713C20;
 Wed, 20 Mar 2024 07:43:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7EDC21E6891; Wed, 20 Mar 2024 08:43:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH 6/7] qapi: Move conditional code from QAPISchemaVariants to
 its subtypes
Date: Wed, 20 Mar 2024 08:43:14 +0100
Message-ID: <20240320074315.23167-7-armbru@redhat.com>
In-Reply-To: <20240320074315.23167-1-armbru@redhat.com>
References: <20240320074315.23167-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.422,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

QAPISchemaVariants.check()'s code is almost entirely conditional on
union vs. alternate type.

Move the conditional code to QAPISchemaBranches.check() and
QAPISchemaAlternatives.check(), where the conditions are always
satisfied.

Attribute QAPISchemaVariants.tag_name is now only used by
QAPISchemaBranches.  Move it there.

Refactor the three types' .__init__() to make them a bit simpler.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 138 ++++++++++++++++++++---------------------
 1 file changed, 69 insertions(+), 69 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 9bdbfd52b2..c5b824f1fd 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -719,20 +719,11 @@ def visit(self, visitor: QAPISchemaVisitor) -> None:
 class QAPISchemaVariants:
     def __init__(
         self,
-        tag_name: Optional[str],
         info: QAPISourceInfo,
-        tag_member: Optional[QAPISchemaObjectTypeMember],
         variants: List[QAPISchemaVariant],
     ):
-        # Unions pass tag_name but not tag_member.
-        # Alternates pass tag_member but not tag_name.
-        # After check(), tag_member is always set.
-        assert bool(tag_member) != bool(tag_name)
-        assert (isinstance(tag_name, str) or
-                isinstance(tag_member, QAPISchemaObjectTypeMember))
-        self._tag_name = tag_name
         self.info = info
-        self._tag_member = tag_member
+        self._tag_member: Optional[QAPISchemaObjectTypeMember] = None
         self.variants = variants
 
     @property
@@ -749,58 +740,66 @@ def set_defined_in(self, name: str) -> None:
             v.set_defined_in(name)
 
     def check(
-        self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
+            self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
     ) -> None:
-        if self._tag_name:      # union
-            # We need to narrow the member type:
-            tmp = seen.get(c_name(self._tag_name))
-            assert tmp is None or isinstance(tmp, QAPISchemaObjectTypeMember)
-            self._tag_member = tmp
+        for v in self.variants:
+            v.check(schema)
 
-            base = "'base'"
-            # Pointing to the base type when not implicit would be
-            # nice, but we don't know it here
-            if not self._tag_member or self._tag_name != self._tag_member.name:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator '%s' is not a member of %s"
-                    % (self._tag_name, base))
-            # Here we do:
-            assert self.tag_member.defined_in
-            base_type = schema.lookup_type(self.tag_member.defined_in)
-            assert base_type
-            if not base_type.is_implicit():
-                base = "base type '%s'" % self.tag_member.defined_in
-            if not isinstance(self.tag_member.type, QAPISchemaEnumType):
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must be of enum type"
-                    % (self._tag_name, base))
-            if self.tag_member.optional:
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be optional"
-                    % (self._tag_name, base))
-            if self.tag_member.ifcond.is_present():
-                raise QAPISemError(
-                    self.info,
-                    "discriminator member '%s' of %s must not be conditional"
-                    % (self._tag_name, base))
-        else:                   # alternate
-            assert self._tag_member
-            assert isinstance(self.tag_member.type, QAPISchemaEnumType)
-            assert not self.tag_member.optional
-            assert not self.tag_member.ifcond.is_present()
-        if self._tag_name:      # union
-            # branches that are not explicitly covered get an empty type
-            assert self.tag_member.defined_in
-            cases = {v.name for v in self.variants}
-            for m in self.tag_member.type.members:
-                if m.name not in cases:
-                    v = QAPISchemaVariant(m.name, self.info,
-                                          'q_empty', m.ifcond)
-                    v.set_defined_in(self.tag_member.defined_in)
-                    self.variants.append(v)
+
+class QAPISchemaBranches(QAPISchemaVariants):
+    def __init__(self,
+                 info: QAPISourceInfo,
+                 variants: List[QAPISchemaVariant],
+                 tag_name: str):
+        super().__init__(info, variants)
+        self._tag_name = tag_name
+
+    def check(
+            self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
+    ) -> None:
+        # We need to narrow the member type:
+        tmp = seen.get(c_name(self._tag_name))
+        assert tmp is None or isinstance(tmp, QAPISchemaObjectTypeMember)
+        self._tag_member = tmp
+
+        base = "'base'"
+        # Pointing to the base type when not implicit would be
+        # nice, but we don't know it here
+        if not self._tag_member or self._tag_name != self._tag_member.name:
+            raise QAPISemError(
+                self.info,
+                "discriminator '%s' is not a member of %s"
+                % (self._tag_name, base))
+        # Here we do:
+        assert self.tag_member.defined_in
+        base_type = schema.lookup_type(self.tag_member.defined_in)
+        assert base_type
+        if not base_type.is_implicit():
+            base = "base type '%s'" % self.tag_member.defined_in
+        if not isinstance(self.tag_member.type, QAPISchemaEnumType):
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must be of enum type"
+                % (self._tag_name, base))
+        if self.tag_member.optional:
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must not be optional"
+                % (self._tag_name, base))
+        if self.tag_member.ifcond.is_present():
+            raise QAPISemError(
+                self.info,
+                "discriminator member '%s' of %s must not be conditional"
+                % (self._tag_name, base))
+        # branches that are not explicitly covered get an empty type
+        assert self.tag_member.defined_in
+        cases = {v.name for v in self.variants}
+        for m in self.tag_member.type.members:
+            if m.name not in cases:
+                v = QAPISchemaVariant(m.name, self.info,
+                                      'q_empty', m.ifcond)
+                v.set_defined_in(self.tag_member.defined_in)
+                self.variants.append(v)
         if not self.variants:
             raise QAPISemError(self.info, "union has no branches")
         for v in self.variants:
@@ -834,20 +833,21 @@ def check_clash(
             v.type.check_clash(info, dict(seen))
 
 
-class QAPISchemaBranches(QAPISchemaVariants):
-    def __init__(self,
-                 info: QAPISourceInfo,
-                 variants: List[QAPISchemaVariant],
-                 tag_name: str):
-        super().__init__(tag_name, info, None, variants)
-
-
 class QAPISchemaAlternatives(QAPISchemaVariants):
     def __init__(self,
                  info: QAPISourceInfo,
                  variants: List[QAPISchemaVariant],
                  tag_member: QAPISchemaObjectTypeMember):
-        super().__init__(None, info, tag_member, variants)
+        super().__init__(info, variants)
+        self._tag_member = tag_member
+
+    def check(
+            self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
+    ) -> None:
+        super().check(schema, seen)
+        assert isinstance(self.tag_member.type, QAPISchemaEnumType)
+        assert not self.tag_member.optional
+        assert not self.tag_member.ifcond.is_present()
 
 
 class QAPISchemaMember:
-- 
2.44.0


