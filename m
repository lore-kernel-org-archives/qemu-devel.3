Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56B64C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:37:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC9B-0001LT-0S; Sun, 09 Mar 2025 04:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC98-0001FA-0t
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC96-0002GZ-7a
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MJNbHga1Ej11wBv+ChByVHDJy5gxgQNlZ3MkdWVm7BA=;
 b=AedKXEUoTwfG4iI2sWTvqJERPGpUEa2YcGbtOVMXjObhmG+IktQXAsXA0U/bxyeEJmW2BO
 ZKD3cuHZE+k5KbXxo/g2h4ZnO79NsEkvoFuqm5LzraGUT2Er7LqjQEpewtdZO9S4NQiS9B
 P0T4qApqId4YXMy4UAUY3fkUGZaywR0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-653-DNzMSVADNbWaqDOlH9zfKw-1; Sun,
 09 Mar 2025 04:36:21 -0400
X-MC-Unique: DNzMSVADNbWaqDOlH9zfKw-1
X-Mimecast-MFC-AGG-ID: DNzMSVADNbWaqDOlH9zfKw_1741509380
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B721A19560A3; Sun,  9 Mar 2025 08:36:20 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D482A19560AB; Sun,  9 Mar 2025 08:36:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 11/62] docs/qapi-domain: add qapi:module directive
Date: Sun,  9 Mar 2025 04:34:58 -0400
Message-ID: <20250309083550.5155-12-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

This adds the qapi:module directive, which just notes the current module
being documented and performs a nested parse of the content block, if
present.

This code is based pretty heavily on Sphinx's PyModule directive, but
with unnecessary features excised.

For example:

.. qapi:module:: block-core

   Hello, and welcome to block-core!
   =================================

   lorem ipsum, dolor sit amet ...

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 71 ++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 0365891f354..a445150ae59 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -19,6 +19,7 @@
 
 from docutils import nodes
 
+from sphinx import addnodes
 from sphinx.addnodes import desc_signature, pending_xref
 from sphinx.directives import ObjectDescription
 from sphinx.domains import (
@@ -34,7 +35,7 @@
 
 
 if TYPE_CHECKING:
-    from docutils.nodes import Element
+    from docutils.nodes import Element, Node
 
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
@@ -157,6 +158,60 @@ def add_target_and_index(
                 )
 
 
+class QAPIModule(QAPIDescription):
+    """
+    Directive to mark description of a new module.
+
+    This directive doesn't generate any special formatting, and is just
+    a pass-through for the content body. Named section titles are
+    allowed in the content body.
+
+    Use this directive to create entries for the QAPI module in the
+    global index and the qapi index; as well as to associate subsequent
+    definitions with the module they are defined in for purposes of
+    search and QAPI index organization.
+
+    :arg: The name of the module.
+    :opt no-index: Don't add cross-reference targets or index entries.
+    :opt no-typesetting: Don't render the content body (but preserve any
+       cross-reference target IDs in the squelched output.)
+
+    Example::
+
+       .. qapi:module:: block-core
+          :no-index:
+          :no-typesetting:
+
+          Lorem ipsum, dolor sit amet ...
+    """
+
+    def run(self) -> List[Node]:
+        modname = self.arguments[0].strip()
+        self.env.ref_context["qapi:module"] = modname
+        ret = super().run()
+
+        # ObjectDescription always creates a visible signature bar. We
+        # want module items to be "invisible", however.
+
+        # Extract the content body of the directive:
+        assert isinstance(ret[-1], addnodes.desc)
+        desc_node = ret.pop(-1)
+        assert isinstance(desc_node.children[1], addnodes.desc_content)
+        ret.extend(desc_node.children[1].children)
+
+        # Re-home node_ids so anchor refs still work:
+        node_ids: List[str]
+        if node_ids := [
+            node_id
+            for el in desc_node.children[0].traverse(nodes.Element)
+            for node_id in cast(List[str], el.get("ids", ()))
+        ]:
+            target_node = nodes.target(ids=node_ids)
+            ret.insert(1, target_node)
+
+        return ret
+
+
 class QAPIIndex(Index):
     """
     Index subclass to provide the QAPI definition index.
@@ -222,17 +277,21 @@ class QAPIDomain(Domain):
     # This table associates cross-reference object types (key) with an
     # ObjType instance, which defines the valid cross-reference roles
     # for each object type.
+    object_types: Dict[str, ObjType] = {
+        "module": ObjType(_("module"), "mod", "any"),
+    }
 
-    # Actual table entries for module, command, event, etc will come in
-    # forthcoming commits.
-    object_types: Dict[str, ObjType] = {}
-
-    directives = {}
+    # Each of these provides a rST directive,
+    # e.g. .. qapi:module:: block-core
+    directives = {
+        "module": QAPIModule,
+    }
 
     # These are all cross-reference roles; e.g.
     # :qapi:cmd:`query-block`. The keys correlate to the names used in
     # the object_types table values above.
     roles = {
+        "mod": QAPIXRefRole(),
         "any": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.48.1


