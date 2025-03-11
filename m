Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18A83C2BA1B
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:51:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqZl-0000YZ-Uh; Mon, 10 Mar 2025 23:46:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqYs-00080o-PM
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:45:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqYq-0002hp-Mt
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:45:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rlh6+1tMYkikdwZnftzQv1RUGX9Ul7a3hErx607ywWc=;
 b=P+K/htRn7+muI6Iv5Z5bwVANZ2Qtbf6ybdAGE9MgHNCjAexTNSe93UZi9HAHoaD2PJJTHJ
 qBRIza3vScXRbL2BzHU08DD29G1kHw3l7Z/HjbhQL+N/F+EzQIkHqHlzGQqB5tYsvP6qKW
 iFHm4LTj1YKak7gT8NIDcWOG2tpMbx0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-8o2hHyXUOH2vrM3H7u-YGw-1; Mon,
 10 Mar 2025 23:45:39 -0400
X-MC-Unique: 8o2hHyXUOH2vrM3H7u-YGw-1
X-Mimecast-MFC-AGG-ID: 8o2hHyXUOH2vrM3H7u-YGw_1741664738
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C621180034D; Tue, 11 Mar 2025 03:45:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 09B8F1800366; Tue, 11 Mar 2025 03:45:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 43/63] docs/qapidoc: add preamble() method
Date: Mon, 10 Mar 2025 23:42:41 -0400
Message-ID: <20250311034303.75779-44-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This method adds the options/preamble to each definition block. Notably,
:since: and :ifcond: are added, as are any "special features" such as
:deprecated: and :unstable:.

If conditionals, if attached to special features, are currently
unhandled in this patch and will be addressed at a future date. We
currently do not have any if conditionals attached to special features.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index ddad6041455..f56aa6d1fd7 100644
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


