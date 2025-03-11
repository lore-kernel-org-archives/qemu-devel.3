Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1711FC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:48:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsQ-0006dI-7W; Tue, 11 Mar 2025 07:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqo-0003N1-UE
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqB-0006XO-4j
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kELx4R5nyjgFkpx05YRwXMpWdxrB+seHv2cdVN50orQ=;
 b=J5uoiFscNDHzSLAo+wUMgFeYVYmYuC4+JcgBslOk1OCz/HSJ92Hnw7kLl9GxHLgBCgjQFi
 n30EgGvZ8hlsWHfl6ksCFqFCpO1Su0EM2BlDymNa8d9FBsCvDUKlAlMYJCoOk6/AkMXCUc
 +oZ70O06BxjkxsRK9/xU0yzyd4KyLlQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-457-bV3tZdAQNL-OWJVrn6YygA-1; Tue,
 11 Mar 2025 07:31:58 -0400
X-MC-Unique: bV3tZdAQNL-OWJVrn6YygA-1
X-Mimecast-MFC-AGG-ID: bV3tZdAQNL-OWJVrn6YygA_1741692718
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 10F8B1955BC9
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B03C1828A95
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 586ED21E614A; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 40/61] docs/qapidoc: add preamble() method
Date: Tue, 11 Mar 2025 12:31:16 +0100
Message-ID: <20250311113137.1277125-41-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

This method adds the options/preamble to each definition block. Notably,
:since: and :ifcond: are added, as are any "special features" such as
:deprecated: and :unstable:.

If conditionals, if attached to special features, are currently
unhandled in this patch and will be addressed at a future date. We
currently do not have any if conditionals attached to special features.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-44-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index ddad604145..f56aa6d1fd 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -37,7 +37,12 @@
 from docutils.parsers.rst import Directive, directives
 from docutils.statemachine import StringList
 from qapi.error import QAPIError
-from qapi.schema import QAPISchema, QAPISchemaVisitor
+from qapi.parser import QAPIDoc
+from qapi.schema import (
+    QAPISchema,
+    QAPISchemaDefinition,
+    QAPISchemaVisitor,
+)
 from qapi.source import QAPISourceInfo
 
 from qapidoc_legacy import QAPISchemaGenRSTVisitor  # type: ignore
@@ -56,8 +61,6 @@
         Sequence,
     )
 
-    from qapi.parser import QAPIDoc
-
     from sphinx.application import Sphinx
     from sphinx.util.typing import ExtensionMetadata
 
@@ -125,6 +128,38 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    # Transmogrification helpers
+
+    def preamble(self, ent: QAPISchemaDefinition) -> None:
+        """
+        Generate option lines for QAPI entity directives.
+        """
+        if ent.doc and ent.doc.since:
+            assert ent.doc.since.kind == QAPIDoc.Kind.SINCE
+            # Generated from the entity's docblock; info location is exact.
+            self.add_line(f":since: {ent.doc.since.text}", ent.doc.since.info)
+
+        if ent.ifcond.is_present():
+            doc = ent.ifcond.docgen()
+            assert ent.info
+            # Generated from entity definition; info location is approximate.
+            self.add_line(f":ifcond: {doc}", ent.info)
+
+        # Hoist special features such as :deprecated: and :unstable:
+        # into the options block for the entity. If, in the future, new
+        # special features are added, qapi-domain will chirp about
+        # unrecognized options and fail until they are handled in
+        # qapi-domain.
+        for feat in ent.features:
+            if feat.is_special():
+                # FIXME: handle ifcond if present. How to display that
+                # information is TBD.
+                # Generated from entity def; info location is approximate.
+                assert feat.info
+                self.add_line(f":{feat.name}:", feat.info)
+
+        self.ensure_blank_line()
+
     # Transmogrification core methods
 
     def visit_module(self, path: str) -> None:
-- 
2.48.1


