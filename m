Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29ECDC282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:46:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxrC-0003Wt-1P; Tue, 11 Mar 2025 07:33:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqW-0003Cx-7M
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq9-0006Wz-Mp
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHpn6RM60iN5008DmLJtF3vc+uN0LyK9v2tygWdAa+s=;
 b=VWQhv3bggyPMt1qNRDo6TvWm6CDhT8pFUtMXcW05FZxNO7/PsWqL9TmOWfu7OCUozw2IlT
 3pW+aT9OTSC/o8m2B3tE04ZVtaHShWPpQ8GF92IAsOeMgsOH6tro06gbCIOgKmJzq3me5i
 WsukI/oXFGnH4BRqOitZ048/P6AudPw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-459-kofgPJx5OIu94Pf_wR0DWw-1; Tue,
 11 Mar 2025 07:31:59 -0400
X-MC-Unique: kofgPJx5OIu94Pf_wR0DWw-1
X-Mimecast-MFC-AGG-ID: kofgPJx5OIu94Pf_wR0DWw_1741692718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3FD23180035E
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B8C183001D15
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 548AF21E61BD; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 39/61] docs/qapidoc: add visit_freeform() method
Date: Tue, 11 Mar 2025 12:31:15 +0100
Message-ID: <20250311113137.1277125-40-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: John Snow <jsnow@redhat.com>

Add the transmogrifier implementation for converting freeform doc blocks
to rST.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-43-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 6de8c90054..ddad604145 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -29,6 +29,7 @@
 from contextlib import contextmanager
 import os
 from pathlib import Path
+import re
 import sys
 from typing import TYPE_CHECKING
 
@@ -55,6 +56,8 @@
         Sequence,
     )
 
+    from qapi.parser import QAPIDoc
+
     from sphinx.application import Sphinx
     from sphinx.util.typing import ExtensionMetadata
 
@@ -130,6 +133,47 @@ def visit_module(self, path: str) -> None:
         self.add_line_raw(f".. qapi:module:: {name}", path, 1)
         self.ensure_blank_line()
 
+    def visit_freeform(self, doc: QAPIDoc) -> None:
+        # TODO: Once the old qapidoc transformer is deprecated, freeform
+        # sections can be updated to pure rST, and this transformed removed.
+        #
+        # For now, translate our micro-format into rST. Code adapted
+        # from Peter Maydell's freeform().
+
+        assert len(doc.all_sections) == 1, doc.all_sections
+        body = doc.all_sections[0]
+        text = body.text
+        info = doc.info
+
+        if re.match(r"=+ ", text):
+            # Section/subsection heading (if present, will always be the
+            # first line of the block)
+            (heading, _, text) = text.partition("\n")
+            (leader, _, heading) = heading.partition(" ")
+            # Implicit +1 for heading in the containing .rst doc
+            level = len(leader) + 1
+
+            # https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
+            markers = ' #*=_^"'
+            overline = level <= 2
+            marker = markers[level]
+
+            self.ensure_blank_line()
+            # This credits all 2 or 3 lines to the single source line.
+            if overline:
+                self.add_line(marker * len(heading), info)
+            self.add_line(heading, info)
+            self.add_line(marker * len(heading), info)
+            self.ensure_blank_line()
+
+            # Eat blank line(s) and advance info
+            trimmed = text.lstrip("\n")
+            text = trimmed
+            info = info.next_line(len(text) - len(trimmed) + 1)
+
+        self.add_lines(text, info)
+        self.ensure_blank_line()
+
 
 class QAPISchemaGenDepVisitor(QAPISchemaVisitor):
     """A QAPI schema visitor which adds Sphinx dependencies each module
-- 
2.48.1


