Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64D2E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:19:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuI0-00024i-Uy; Thu, 12 Dec 2024 20:16:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuH6-0000wI-KE
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuH4-0000wR-I5
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2Us7t8EzSXoOEU6CCGbRd6lLvImyt92QDEHdxf45t34=;
 b=LjrkIwUQ1RIJNYThLKUN19Xzo9bhtdtfEDYzCE+YSmNLxPe013NLzGwdUFn+T0kPwBjBU9
 FyrQvv6cOGKBYEWP/13RK1Gf2rqwBTMMmONIUHg/81WBOAmnHacl35mM55AkkXev6e/Jkf
 jkABZKvJCe/3oaZ0WkUCPr0wcB5JeBc=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-xabWTRepOqCJF9arhJUp_w-1; Thu,
 12 Dec 2024 20:15:17 -0500
X-MC-Unique: xabWTRepOqCJF9arhJUp_w-1
X-Mimecast-MFC-AGG-ID: xabWTRepOqCJF9arhJUp_w
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 140ED19560A3; Fri, 13 Dec 2024 01:15:16 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 16F681956086; Fri, 13 Dec 2024 01:15:13 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 33/35] WIP: 3.x ParserFix
Date: Thu, 12 Dec 2024 20:13:02 -0500
Message-ID: <20241213011307.2942030-34-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py      | 33 +++++++++++++++++++++++++++++++++
 docs/sphinx/qapi-domain.py | 32 +++++++-------------------------
 2 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 657c05a81a4..5126b450a5f 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -12,9 +12,11 @@
 
 from docutils import nodes
 from docutils.nodes import Element, Node, Text
+from docutils.statemachine import StringList
 
 import sphinx
 from sphinx import addnodes
+from sphinx.directives import ObjectDescription
 from sphinx.environment import BuildEnvironment
 from sphinx.roles import XRefRole
 from sphinx.util import docfields
@@ -28,6 +30,7 @@
 
 
 MAKE_XREF_WORKAROUND = sphinx.version_info[:3] < (4, 1, 0)
+SOURCE_LOCATION_FIX = (5, 3, 0) <= sphinx.version_info[:3] < (6, 2, 0)
 
 
 space_node: Callable[[str], Node]
@@ -156,3 +159,33 @@ class CompatTypedField(CompatFieldMixin, docfields.TypedField):
     Field = CompatField
     GroupedField = CompatGroupedField
     TypedField = CompatTypedField
+
+
+class ParserFix(ObjectDescription):
+
+    _temp_content: StringList
+    _temp_offset: int
+    _temp_node: Optional[addnodes.desc_content]
+
+    def before_content(self) -> None:
+        # Work around a sphinx bug and parse the content ourselves.
+        self._temp_content = self.content
+        self._temp_offset = self.content_offset
+        self._temp_node = None
+
+        if SOURCE_LOCATION_FIX:
+            self._temp_node = addnodes.desc_content()
+            self.state.nested_parse(
+                self.content, self.content_offset, self._temp_node
+            )
+            # Sphinx will try to parse the content block itself,
+            # Give it nothingness to parse instead.
+            self.content = StringList()
+            self.content_offset = 0
+
+    def transform_content(self, contentnode: addnodes.desc_content) -> None:
+        # Sphinx workaround: Inject our parsed content and restore state.
+        if self._temp_node:
+            contentnode += self._temp_node.children
+            self.content = self._temp_content
+            self.content_offset = self._temp_offset
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index ebdf9074391..00d32d44e1d 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -21,18 +21,17 @@
 
 from docutils import nodes
 from docutils.parsers.rst import directives
-from docutils.statemachine import StringList
 
 from collapse import CollapseNode
 from compat import (
     Field,
     GroupedField,
+    ParserFix,
     TypedField,
     keyword_node,
     nested_parse,
     space_node,
 )
-import sphinx
 from sphinx import addnodes
 from sphinx.addnodes import desc_signature, pending_xref
 from sphinx.directives import ObjectDescription
@@ -170,7 +169,7 @@ def since_validator(param: str) -> str:
 Signature = str
 
 
-class QAPIObject(ObjectDescription[Signature]):
+class QAPIObject(ParserFix, ObjectDescription[Signature]):
     """
     Description of a generic QAPI object.
 
@@ -436,31 +435,14 @@ def _validate_field(self, field: nodes.field) -> None:
             )
             logger.warning(msg, location=field)
 
-    def before_content(self) -> None:
-        # Work around a sphinx bug and parse the content ourselves.
-        self._temp_content = self.content
-        self._temp_offset = self.content_offset
-        self._temp_node = None
-
-        if (5, 3, 0) <= sphinx.version_info[:3] < (6, 2, 0):
-            self._temp_node = addnodes.desc_content()
-            self.state.nested_parse(
-                self.content, self.content_offset, self._temp_node
-            )
-            # Sphinx will try to parse the content block itself,
-            # Give it nothingness to parse instead.
-            self.content = StringList()
-            self.content_offset = 0
-
     def transform_content(self, contentnode: addnodes.desc_content) -> None:
+        # This hook runs after before_content and the nested parse, but
+        # before the DocFieldTransformer is executed.
+        super().transform_content(contentnode)
+
+        # Bookmark this content_node for later use in after_content().
         self.content_node = contentnode
 
-        # Sphinx workaround: Inject our parsed content and restore state.
-        if self._temp_node:
-            contentnode += self._temp_node.children
-            self.content = self._temp_content
-            self.content_offset = self._temp_offset
-
         self._add_infopips(contentnode)
         self._merge_adjoining_field_lists(contentnode)
 
-- 
2.47.0


