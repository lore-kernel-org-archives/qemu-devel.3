Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211E8C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:06:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7q-00035s-Qj; Mon, 06 May 2024 07:03:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7g-0002oz-Vp
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7Y-0003fM-KJ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NuQ9Fil2xTNfxL9eTvXPA3hWo76CgVTuL8CK0QDZm6w=;
 b=YbmZLVGeQNHteegvgVQSkQtRDcaJRMnmCeT7ZE/ZMWmIj1qxnFhEGxJLRmTdnFrb03mVFd
 FwDCVWR2rB+9BfoQR+bkLOBf72IOykHjSlvWM88jipvIQWXFesUU3L77zz74E/i/ylpQeO
 OomgOGzDKJxkmZAsUC0KkEz+upHrRfw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-GdW2s1XgPOaMvcCfBv-ixw-1; Mon,
 06 May 2024 07:02:56 -0400
X-MC-Unique: GdW2s1XgPOaMvcCfBv-ixw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B0A43810B06;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 61615400D279;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5E1C221D49C6; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PULL 7/7] qapi: Simplify QAPISchemaVariants @tag_member
Date: Mon,  6 May 2024 13:02:54 +0200
Message-ID: <20240506110254.3965097-15-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

For union types, the tag member is known only after .check().

We used to code this in a simple way: QAPISchemaVariants attribute
.tag_member was None for union types until .check().

Since this complicated typing, recent commit "qapi/schema: fix typing
for QAPISchemaVariants.tag_member" hid it behind a property.

The previous commit lets us treat .tag_member just like the other
attributes that become known only in .check(): declare, but don't
initialize it in .__init__().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 44 +++++++++++++++++-------------------------
 1 file changed, 18 insertions(+), 26 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index c5b824f1fd..721c470d2b 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -723,18 +723,9 @@ def __init__(
         variants: List[QAPISchemaVariant],
     ):
         self.info = info
-        self._tag_member: Optional[QAPISchemaObjectTypeMember] = None
+        self.tag_member: QAPISchemaObjectTypeMember
         self.variants = variants
 
-    @property
-    def tag_member(self) -> QAPISchemaObjectTypeMember:
-        if self._tag_member is None:
-            raise RuntimeError(
-                "QAPISchemaVariants has no tag_member property until "
-                "after check() has been run."
-            )
-        return self._tag_member
-
     def set_defined_in(self, name: str) -> None:
         for v in self.variants:
             v.set_defined_in(name)
@@ -758,47 +749,48 @@ def check(
             self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
     ) -> None:
         # We need to narrow the member type:
-        tmp = seen.get(c_name(self._tag_name))
-        assert tmp is None or isinstance(tmp, QAPISchemaObjectTypeMember)
-        self._tag_member = tmp
+        tag_member = seen.get(c_name(self._tag_name))
+        assert (tag_member is None
+                or isinstance(tag_member, QAPISchemaObjectTypeMember))
 
         base = "'base'"
         # Pointing to the base type when not implicit would be
         # nice, but we don't know it here
-        if not self._tag_member or self._tag_name != self._tag_member.name:
+        if not tag_member or self._tag_name != tag_member.name:
             raise QAPISemError(
                 self.info,
                 "discriminator '%s' is not a member of %s"
                 % (self._tag_name, base))
+        self.tag_member = tag_member
         # Here we do:
-        assert self.tag_member.defined_in
-        base_type = schema.lookup_type(self.tag_member.defined_in)
+        assert tag_member.defined_in
+        base_type = schema.lookup_type(tag_member.defined_in)
         assert base_type
         if not base_type.is_implicit():
-            base = "base type '%s'" % self.tag_member.defined_in
-        if not isinstance(self.tag_member.type, QAPISchemaEnumType):
+            base = "base type '%s'" % tag_member.defined_in
+        if not isinstance(tag_member.type, QAPISchemaEnumType):
             raise QAPISemError(
                 self.info,
                 "discriminator member '%s' of %s must be of enum type"
                 % (self._tag_name, base))
-        if self.tag_member.optional:
+        if tag_member.optional:
             raise QAPISemError(
                 self.info,
                 "discriminator member '%s' of %s must not be optional"
                 % (self._tag_name, base))
-        if self.tag_member.ifcond.is_present():
+        if tag_member.ifcond.is_present():
             raise QAPISemError(
                 self.info,
                 "discriminator member '%s' of %s must not be conditional"
                 % (self._tag_name, base))
         # branches that are not explicitly covered get an empty type
-        assert self.tag_member.defined_in
+        assert tag_member.defined_in
         cases = {v.name for v in self.variants}
-        for m in self.tag_member.type.members:
+        for m in tag_member.type.members:
             if m.name not in cases:
                 v = QAPISchemaVariant(m.name, self.info,
                                       'q_empty', m.ifcond)
-                v.set_defined_in(self.tag_member.defined_in)
+                v.set_defined_in(tag_member.defined_in)
                 self.variants.append(v)
         if not self.variants:
             raise QAPISemError(self.info, "union has no branches")
@@ -807,11 +799,11 @@ def check(
             # Union names must match enum values; alternate names are
             # checked separately. Use 'seen' to tell the two apart.
             if seen:
-                if v.name not in self.tag_member.type.member_names():
+                if v.name not in tag_member.type.member_names():
                     raise QAPISemError(
                         self.info,
                         "branch '%s' is not a value of %s"
-                        % (v.name, self.tag_member.type.describe()))
+                        % (v.name, tag_member.type.describe()))
                 if not isinstance(v.type, QAPISchemaObjectType):
                     raise QAPISemError(
                         self.info,
@@ -839,7 +831,7 @@ def __init__(self,
                  variants: List[QAPISchemaVariant],
                  tag_member: QAPISchemaObjectTypeMember):
         super().__init__(info, variants)
-        self._tag_member = tag_member
+        self.tag_member = tag_member
 
     def check(
             self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
-- 
2.44.0


