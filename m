Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5512FC54E67
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:26:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9P5-0007kL-QB; Fri, 15 Mar 2024 11:23:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9P2-0007i2-4m
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Or-00021q-3y
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9Wj7yJSL48eXnxd/mlr1VkhP1/ucXQGd7tkQifbWas=;
 b=Fj288bfnBYvhHK/Vgw6Nl3cIWOO/BfoTLO24yVPJuP6sQ+L0yX6mqBQAN6Bl1PKREXn8Fp
 oXQuUkBvqBARLoHP6iemYFDx6WDuXjT2DEsgHkClCbxa8EZ1Nf1DzvbDX2H+jIc396HvTK
 kVGfMdaUAtbaOCh6gjpzBfFvtA50aVQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-zo_uUqZpNbuVETAECUcrFA-1; Fri,
 15 Mar 2024 11:23:05 -0400
X-MC-Unique: zo_uUqZpNbuVETAECUcrFA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6E1961C00D32;
 Fri, 15 Mar 2024 15:23:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0DEAA492BD4;
 Fri, 15 Mar 2024 15:23:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0FAC321E682D; Fri, 15 Mar 2024 16:23:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 17/25] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
Date: Fri, 15 Mar 2024 16:22:53 +0100
Message-ID: <20240315152301.3621858-18-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
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

From: John Snow <jsnow@redhat.com>

There are two related changes here:

(1) We need to perform type narrowing for resolving the type of
    tag_member during check(), and

(2) tag_member is a delayed initialization field, but we can hide it
    behind a property that raises an Exception if it's called too
    early. This simplifies the typing in quite a few places and avoids
    needing to assert that the "tag_member is not None" at a dozen
    callsites, which can be confusing and suggest the wrong thing to a
    drive-by contributor.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 74b0d7b007..9c138badb0 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -627,25 +627,39 @@ def __init__(self, tag_name, info, tag_member, variants):
             assert isinstance(v, QAPISchemaVariant)
         self._tag_name = tag_name
         self.info = info
-        self.tag_member = tag_member
+        self._tag_member: Optional[QAPISchemaObjectTypeMember] = tag_member
         self.variants = variants
 
+    @property
+    def tag_member(self) -> 'QAPISchemaObjectTypeMember':
+        if self._tag_member is None:
+            raise RuntimeError(
+                "QAPISchemaVariants has no tag_member property until "
+                "after check() has been run."
+            )
+        return self._tag_member
+
     def set_defined_in(self, name):
         for v in self.variants:
             v.set_defined_in(name)
 
     def check(self, schema, seen):
         if self._tag_name:      # union
-            self.tag_member = seen.get(c_name(self._tag_name))
+            # We need to narrow the member type:
+            tmp = seen.get(c_name(self._tag_name))
+            assert tmp is None or isinstance(tmp, QAPISchemaObjectTypeMember)
+            self._tag_member = tmp
+
             base = "'base'"
             # Pointing to the base type when not implicit would be
             # nice, but we don't know it here
-            if not self.tag_member or self._tag_name != self.tag_member.name:
+            if not self._tag_member or self._tag_name != self._tag_member.name:
                 raise QAPISemError(
                     self.info,
                     "discriminator '%s' is not a member of %s"
                     % (self._tag_name, base))
             # Here we do:
+            assert self.tag_member.defined_in
             base_type = schema.lookup_type(self.tag_member.defined_in)
             assert base_type
             if not base_type.is_implicit():
@@ -666,11 +680,13 @@ def check(self, schema, seen):
                     "discriminator member '%s' of %s must not be conditional"
                     % (self._tag_name, base))
         else:                   # alternate
+            assert self._tag_member
             assert isinstance(self.tag_member.type, QAPISchemaEnumType)
             assert not self.tag_member.optional
             assert not self.tag_member.ifcond.is_present()
         if self._tag_name:      # union
             # branches that are not explicitly covered get an empty type
+            assert self.tag_member.defined_in
             cases = {v.name for v in self.variants}
             for m in self.tag_member.type.members:
                 if m.name not in cases:
-- 
2.44.0


