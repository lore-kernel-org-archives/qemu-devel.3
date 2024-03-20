Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEE24C54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 07:44:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmqbl-0003eD-3E; Wed, 20 Mar 2024 03:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbj-0003dF-89
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rmqbh-0007g2-PY
 for qemu-devel@nongnu.org; Wed, 20 Mar 2024 03:43:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710920609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8Xv4sKeuJXrReP+xdm8YZZkzbF0yY+MYu1X3PH04IU=;
 b=S9lJqVZwTdin9a7LKjdgnZhbIfPfCfdfT/EDK6GgL4Xi2USVh/eAL7sS8vZqfXmCLCKLg0
 amoJ+uT1zdbdi13EhsQMRA3NCbWxdTOK/9UKbguQnt/dJUhh04nkyhnkrL9Eyokodwz5Sb
 cwllXUh5cMqxl9BsGK8TzoPuBqnaOj8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-C-IJO-DmMeOF-U0t7QdpRw-1; Wed, 20 Mar 2024 03:43:27 -0400
X-MC-Unique: C-IJO-DmMeOF-U0t7QdpRw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE8D98007A1;
 Wed, 20 Mar 2024 07:43:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE7551121337;
 Wed, 20 Mar 2024 07:43:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A4CB521E688F; Wed, 20 Mar 2024 08:43:15 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH 5/7] qapi: Rename QAPISchemaAlternateType.variants to
 .alternatives
Date: Wed, 20 Mar 2024 08:43:13 +0100
Message-ID: <20240320074315.23167-6-armbru@redhat.com>
In-Reply-To: <20240320074315.23167-1-armbru@redhat.com>
References: <20240320074315.23167-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

A previous commit narrowed the type of
QAPISchemaAlternateType.variants from QAPISchemaVariants to
QAPISchemaAlternatives.  Rename it to .alternatives.

Same for .__init__() parameter @variants.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index c9ff794d0c..9bdbfd52b2 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -651,25 +651,25 @@ def __init__(
         doc: Optional[QAPIDoc],
         ifcond: Optional[QAPISchemaIfCond],
         features: List[QAPISchemaFeature],
-        variants: QAPISchemaAlternatives,
+        alternatives: QAPISchemaAlternatives,
     ):
         super().__init__(name, info, doc, ifcond, features)
-        assert variants.tag_member
-        variants.set_defined_in(name)
-        variants.tag_member.set_defined_in(self.name)
-        self.variants = variants
+        assert alternatives.tag_member
+        alternatives.set_defined_in(name)
+        alternatives.tag_member.set_defined_in(self.name)
+        self.alternatives = alternatives
 
     def check(self, schema: QAPISchema) -> None:
         super().check(schema)
-        self.variants.tag_member.check(schema)
-        # Not calling self.variants.check_clash(), because there's nothing
-        # to clash with
-        self.variants.check(schema, {})
+        self.alternatives.tag_member.check(schema)
+        # Not calling self.alternatives.check_clash(), because there's
+        # nothing to clash with
+        self.alternatives.check(schema, {})
         # Alternate branch names have no relation to the tag enum values;
         # so we have to check for potential name collisions ourselves.
         seen: Dict[str, QAPISchemaMember] = {}
         types_seen: Dict[str, str] = {}
-        for v in self.variants.variants:
+        for v in self.alternatives.variants:
             v.check_clash(self.info, seen)
             qtype = v.type.alternate_qtype()
             if not qtype:
@@ -700,7 +700,7 @@ def check(self, schema: QAPISchema) -> None:
     def connect_doc(self, doc: Optional[QAPIDoc] = None) -> None:
         super().connect_doc(doc)
         doc = doc or self.doc
-        for v in self.variants.variants:
+        for v in self.alternatives.variants:
             v.connect_doc(doc)
 
     def c_type(self) -> str:
@@ -712,7 +712,8 @@ def json_type(self) -> str:
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         super().visit(visitor)
         visitor.visit_alternate_type(
-            self.name, self.info, self.ifcond, self.features, self.variants)
+            self.name, self.info, self.ifcond, self.features,
+            self.alternatives)
 
 
 class QAPISchemaVariants:
-- 
2.44.0


