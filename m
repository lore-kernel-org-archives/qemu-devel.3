Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ACA6C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpflD-0005Er-5b; Tue, 04 Mar 2025 22:49:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfkm-0004Jr-Ox
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfkl-0006On-28
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:49:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LhfTvZSOFIKGzjAQ6Ymgn0Jsa6ARUZT0HLCMnY9mMyI=;
 b=ZYIegH5CBNnkNToWdC32STNeJbm1w3mofRCl9BPEH7O1dtB7EOE+4TevZWSZ2p29UwqB3o
 C9AQ9egK1PLbIqOAP07nmVUd06Xe8xzz3etyWGG6nVfoC2CJcuP/HfRg4DsqKpsAdCjFjE
 p6a/ksM1g9cfm36XhkpOaEJFjbDBTaI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-vCHpAMRCPMu07Gnvhyo9dQ-1; Tue,
 04 Mar 2025 22:48:48 -0500
X-MC-Unique: vCHpAMRCPMu07Gnvhyo9dQ-1
X-Mimecast-MFC-AGG-ID: vCHpAMRCPMu07Gnvhyo9dQ_1741146527
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 01C5A1955D4B; Wed,  5 Mar 2025 03:48:47 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B99D31956095; Wed,  5 Mar 2025 03:48:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 41/57] docs/qapidoc: add preamble() method
Date: Tue,  4 Mar 2025 22:45:50 -0500
Message-ID: <20250305034610.960147-42-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index cf5dbb0133d..d8bf0073dfa 100644
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
+        Generate option lines for qapi entity directives.
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


