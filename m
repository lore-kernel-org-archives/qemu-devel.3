Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 304EAE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:02:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8a-0005lB-DI; Tue, 14 Jan 2025 13:59:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm8C-0005gk-9K
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm88-0002nB-Nd
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mzIZsWKDS71Cp8Mi+HOhPQz+VUZknAGLWuKylYXsJ2E=;
 b=XhdiCtE1yvhzc3ZSUwm97ltCBWbPmLqZTY2DudTaxagpcpmTTaZCADiq/xM5seQquVMFmf
 b3hD2YOMQe+QZTokSMF5ZVqSUbXRMKysHtPC33Fa5LnPYFgwekfb5FtCgao9bnUyOpL1DS
 ud8ER/PztTVPVsznz5WKnjQIQ/VNwsI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-387-rtYxkgAPNJCTbv6dryU4KQ-1; Tue,
 14 Jan 2025 13:59:05 -0500
X-MC-Unique: rtYxkgAPNJCTbv6dryU4KQ-1
X-Mimecast-MFC-AGG-ID: rtYxkgAPNJCTbv6dryU4KQ
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92F0319560AB; Tue, 14 Jan 2025 18:59:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7223019560AA; Tue, 14 Jan 2025 18:59:03 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 14/23] docs/qapidoc: add format_type() method
Date: Tue, 14 Jan 2025 13:58:31 -0500
Message-ID: <20250114185840.3058525-15-jsnow@redhat.com>
In-Reply-To: <20250114185840.3058525-1-jsnow@redhat.com>
References: <20250114185840.3058525-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This method is responsible for generating a type name for a given member
with the correct annotations for the QAPI domain. Features and enums do
not *have* types, so they return None. Everything else returns the type
name with a "?" suffix if that type is optional, and ensconced in
[brackets] if it's an array type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 64d13565c60..b1eaac6e215 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -30,7 +30,7 @@
 import re
 import sys
 import textwrap
-from typing import List
+from typing import List, Optional
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
@@ -38,7 +38,14 @@
 from qapi.error import QAPIError, QAPISemError
 from qapi.gen import QAPISchemaVisitor
 from qapi.parser import QAPIDoc
-from qapi.schema import QAPISchema, QAPISchemaEntity
+from qapi.schema import (
+    QAPISchema,
+    QAPISchemaArrayType,
+    QAPISchemaEntity,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaObjectTypeMember,
+)
 from qapi.source import QAPISourceInfo
 
 from sphinx import addnodes
@@ -125,6 +132,25 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    def format_type(self, ent) -> Optional[str]:
+        if isinstance(ent, (QAPISchemaEnumMember, QAPISchemaFeature)):
+            return None
+
+        qapi_type = ent
+        optional = False
+        if isinstance(ent, QAPISchemaObjectTypeMember):
+            qapi_type = ent.type
+            optional = ent.optional
+
+        if isinstance(qapi_type, QAPISchemaArrayType):
+            ret = f"[{qapi_type.element_type.doc_type()}]"
+        else:
+            ret = qapi_type.doc_type()
+        if optional:
+            ret += "?"
+
+        return ret
+
     # Transmogrification helpers
 
     def visit_paragraph(self, section: QAPIDoc.Section) -> None:
-- 
2.47.1


