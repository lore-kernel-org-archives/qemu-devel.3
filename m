Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D92C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 04:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkGRB-0007yY-4P; Wed, 13 Mar 2024 00:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQu-0007uF-6Z
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rkGQr-0001rS-AQ
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 00:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710304896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WEDIoVPOeTuf+QVZMJaYVYq2r7iKETXU0cn8JtACErE=;
 b=U59bbtF05ABJboorLZEunUdds+7TIzh7P2jnOPwxc33/xeGMtBVnRSFOQFMap9QJFNyc/8
 MNzY8lErKTlf+HghRJN0G/mT4XkD0xaIfAxEydVf2/X37v5zqF5p/s4bfy1RXTD8RKWWME
 DqXMYcECkazEgB/dpihbYOie6GhoP+Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558--xfbeI5TOT6VIbkZZhrUjw-1; Wed,
 13 Mar 2024 00:41:34 -0400
X-MC-Unique: -xfbeI5TOT6VIbkZZhrUjw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 624B71C05AE9;
 Wed, 13 Mar 2024 04:41:34 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.16.65])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2881710E4B;
 Wed, 13 Mar 2024 04:41:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v4 17/23] qapi/schema: fix typing for
 QAPISchemaVariants.tag_member
Date: Wed, 13 Mar 2024 00:41:21 -0400
Message-ID: <20240313044127.49089-18-jsnow@redhat.com>
In-Reply-To: <20240313044127.49089-1-jsnow@redhat.com>
References: <20240313044127.49089-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
---
 scripts/qapi/schema.py | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index fb30314741a..39f653f13fd 100644
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
             base_type = schema.resolve_type(self.tag_member.defined_in)
             if not base_type.is_implicit():
                 base = "base type '%s'" % self.tag_member.defined_in
@@ -665,11 +679,13 @@ def check(self, schema, seen):
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


