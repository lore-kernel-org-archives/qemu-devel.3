Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16FAC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:48:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfk9-0001jK-8D; Tue, 04 Mar 2025 22:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfk2-000155-Cq
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfk0-0006Gb-Mm
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:48:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xjrvi7N8n46beIgRb552NDK9zm0wuktcVMLvc+e5dro=;
 b=JXqLXe2RaSpKgp3g3SW4mWabRRLn2JjYAalp/iJapD3pWO0swkEyigd4fgVLfqR9hwFhYD
 jz3J/b0mcmAr0LPan+wP9200Ahc32H/PUMN0j0h903BGAQZK04vm9lixmKlqgaNdhDnfLf
 lH1UvALyZsbpSOY1Q3MGDohuU6H2VcA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-576-ULkdddoRMqKsd_Yxaf1IpA-1; Tue,
 04 Mar 2025 22:48:04 -0500
X-MC-Unique: ULkdddoRMqKsd_Yxaf1IpA-1
X-Mimecast-MFC-AGG-ID: ULkdddoRMqKsd_Yxaf1IpA_1741146483
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78C841801A05; Wed,  5 Mar 2025 03:48:03 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 22B0F1955DDE; Wed,  5 Mar 2025 03:47:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 29/57] docs/qapi-domain: Fix error context reporting in Sphinx
 5.x and 6.x
Date: Tue,  4 Mar 2025 22:45:38 -0500
Message-ID: <20250305034610.960147-30-jsnow@redhat.com>
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

Sphinx 5.3.0 to Sphinx 6.2.0 has a bug where nested content in an
ObjectDescription content block has its error position reported
incorrectly due to an oversight when they added nested section support
to this directive.

(This bug is present in Sphinx's own Python and C domains; test it
yourself by creating a py:func directive and creating a syntax error in
the directive's content block. The reporting will be incorrect.)

To avoid overriding and re-implementing the entirety of the run()
method, a workaround is employed where we parse the content block
ourselves in before_content(), then null the content block to make
Sphinx's own parsing a no-op. Then, in transform_content (which occurs
after Sphinx's nested parse), we simply swap our own parsed content tree
back in for Sphinx's.

It appears a little tricky, but it's the nicest solution I can find.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py      | 56 ++++++++++++++++++++++++++++++++++++++
 docs/sphinx/qapi_domain.py | 13 +++++----
 2 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 7e8d72c9b1f..e13bee5c209 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -4,6 +4,7 @@
 
 import re
 from typing import (
+    TYPE_CHECKING,
     Any,
     Callable,
     Optional,
@@ -12,9 +13,11 @@
 
 from docutils import nodes
 from docutils.nodes import Element, Node, Text
+from docutils.statemachine import StringList
 
 import sphinx
 from sphinx import addnodes
+from sphinx.directives import ObjectDescription
 from sphinx.environment import BuildEnvironment
 from sphinx.roles import XRefRole
 from sphinx.util import docfields
@@ -171,3 +174,56 @@ class CompatGroupedField(docfields.GroupedField):
 class CompatTypedField(docfields.TypedField):
     if MAKE_XREF_WORKAROUND:
         make_xref = _compat_make_xref
+
+
+# ################################################################
+# Nested parsing error location fix for Sphinx 5.3.0 < x < 6.2.0 #
+# ################################################################
+
+# When we require Sphinx 4.x, the TYPE_CHECKING hack where we avoid
+# subscripting ObjectDescription at runtime can be removed in favor of
+# just always subscripting the class.
+
+# When we require Sphinx > 6.2.0, the rest of this compatibility hack
+# can be dropped and QAPIObject can just inherit directly from
+# ObjectDescription[Signature].
+
+SOURCE_LOCATION_FIX = (5, 3, 0) <= sphinx.version_info[:3] < (6, 2, 0)
+
+Signature = str
+
+
+if TYPE_CHECKING:
+    _BaseClass = ObjectDescription[Signature]
+else:
+    _BaseClass = ObjectDescription
+
+
+class ParserFix(_BaseClass):
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
+    def transform_content(self, content_node: addnodes.desc_content) -> None:
+        # Sphinx workaround: Inject our parsed content and restore state.
+        if self._temp_node:
+            content_node += self._temp_node.children
+            self.content = self._temp_content
+            self.content_offset = self._temp_offset
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 9a11a2dcbe0..077ab7ae47a 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -31,6 +31,8 @@
     CompatGroupedField,
     CompatTypedField,
     KeywordNode,
+    ParserFix,
+    Signature,
     SpaceNode,
     nested_parse,
 )
@@ -163,12 +165,7 @@ def since_validator(param: str) -> str:
     return param
 
 
-# Alias for the return of handle_signature(), which is used in several places.
-# (In the Python domain, this is Tuple[str, str] instead.)
-Signature = str
-
-
-class QAPIObject(ObjectDescription[Signature]):
+class QAPIObject(ParserFix):
     """
     Description of a generic QAPI object.
 
@@ -415,6 +412,10 @@ def _validate_field(self, field: nodes.field) -> None:
             logger.warning(msg, location=field)
 
     def transform_content(self, content_node: addnodes.desc_content) -> None:
+        # This hook runs after before_content and the nested parse, but
+        # before the DocFieldTransformer is executed.
+        super().transform_content(content_node)
+
         self._add_infopips(content_node)
 
         # Validate field lists.
-- 
2.48.1


