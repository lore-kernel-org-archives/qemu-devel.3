Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A10B7E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:21:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvHL-000751-G3; Thu, 12 Dec 2024 21:19:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHI-0006xM-Jo
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvH9-0007vh-7w
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734056369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=na36P0xPb98LF0zfhIOu1XpWvn4Hy7/NC8d5ma6ZPIM=;
 b=Yh/b9G1q/6CX9Zjo2u4u5XZO0mMdrfe7B/WuQLkia8YgpiufbIW0hDT3jJ+1wmOSOf8+MI
 hjjU3T6wqUsXv6q+eefCHSgDdi4PW5ckmW2rcHAQg7lcV5Pjwavrol8XJsqxMCKyOQEe9r
 Fgg5Ash37Wd65+NxEzOu+2X4ZN+RBTQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-325-E1yGRB1dNsyaPM1jTe0wjg-1; Thu,
 12 Dec 2024 21:19:26 -0500
X-MC-Unique: E1yGRB1dNsyaPM1jTe0wjg-1
X-Mimecast-MFC-AGG-ID: E1yGRB1dNsyaPM1jTe0wjg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC5CC195608B; Fri, 13 Dec 2024 02:19:25 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5DAD195605A; Fri, 13 Dec 2024 02:19:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 11/23] docs/qapidoc: add preamble() method
Date: Thu, 12 Dec 2024 21:18:14 -0500
Message-ID: <20241213021827.2956769-12-jsnow@redhat.com>
In-Reply-To: <20241213021827.2956769-1-jsnow@redhat.com>
References: <20241213021827.2956769-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This method adds the options/preamble to each definition block. Notably,
:since: and :ifcond: are added, as are any "special features" such as
:deprecated: and :unstable:.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 6f8f69077b1..85c7ce94564 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -38,7 +38,7 @@
 from qapi.error import QAPIError, QAPISemError
 from qapi.gen import QAPISchemaVisitor
 from qapi.parser import QAPIDoc
-from qapi.schema import QAPISchema
+from qapi.schema import QAPISchema, QAPISchemaEntity
 from qapi.source import QAPISourceInfo
 
 from sphinx import addnodes
@@ -125,6 +125,37 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    # Transmogrification helpers
+
+    def preamble(self, ent: QAPISchemaEntity) -> None:
+        """
+        Generate option lines for qapi entity directives.
+        """
+        if ent.doc and ent.doc.since:
+            assert ent.doc.since.tag == QAPIDoc.Tag.SINCE
+            # Generated from the entity's docblock; info location is exact.
+            self.add_line(f":since: {ent.doc.since.text}", ent.doc.since.info)
+
+        if ent.ifcond.is_present():
+            doc = ent.ifcond.docgen()
+            # Generated from entity definition; info location is approximate.
+            self.add_line(f":ifcond: {doc}", ent.info)
+
+        # Hoist special features such as :deprecated: and :unstable:
+        # into the options block for the entity. If, in the future, new
+        # special features are added, qapi-domain will chirp about
+        # unrecognized options and fail.
+        for feat in ent.features:
+            if feat.is_special():
+                # We don't expect special features to have an ifcond property.
+                # (Hello, intrepid developer in the future who changed that!)
+                # ((With luck, you are not me.))
+                assert not feat.ifcond.is_present()
+                # Generated from entity def; info location is approximate.
+                self.add_line(f":{feat.name}:", feat.info)
+
+        self.ensure_blank_line()
+
     # Transmogrification core methods
 
     def visit_module(self, path: str) -> None:
-- 
2.47.0


