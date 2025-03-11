Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81630C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:48:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsH-0005qb-Ff; Tue, 11 Mar 2025 07:34:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqn-0003Mh-Lp
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqB-0006Vn-BC
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oisWfkS61zdF24rZ4fy5fo5E+tP9TzVK64LPlgqAuuE=;
 b=WNZ6sbfBuX6CpizIwcZCY4OZ2/aRNtQi2FTOAHmLzkLYOki4c5lYmSP+OIW1bLeZg6DpoY
 T+pGGm21Py34EdRuL9wtKRS0h23300Uh57EJ4demV1LBI5V+CfzvNNt6Bsn3f1H8ZI0OnV
 RQXPwHb8H32oGmVqt9RQl9n94ISmjKU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-45-RraL3mpUPra3gES5BZhMGA-1; Tue,
 11 Mar 2025 07:31:52 -0400
X-MC-Unique: RraL3mpUPra3gES5BZhMGA-1
X-Mimecast-MFC-AGG-ID: RraL3mpUPra3gES5BZhMGA_1741692709
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78DCE1954B36
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E1DD51801747
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:48 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D545321E6561; Tue, 11 Mar 2025 12:31:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 09/61] docs/qapi-domain: add qapi:module directive
Date: Tue, 11 Mar 2025 12:30:45 +0100
Message-ID: <20250311113137.1277125-10-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
Message-ID: <20250311034303.75779-12-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapi_domain.py | 71 ++++++++++++++++++++++++++++++++++----
 1 file changed, 65 insertions(+), 6 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 0ee36b4644..e623d1f867 100644
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
@@ -193,6 +194,60 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
         return ""
 
 
+class QAPIModule(QAPIDescription):
+    """
+    Directive to mark description of a new module.
+
+    This directive doesn't generate any special formatting, and is just
+    a pass-through for the content body. Named section titles are
+    allowed in the content body.
+
+    Use this directive to create entries for the QAPI module in the
+    global index and the QAPI index; as well as to associate subsequent
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
@@ -258,17 +313,21 @@ class QAPIDomain(Domain):
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


