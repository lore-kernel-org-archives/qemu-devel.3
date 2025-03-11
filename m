Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AA4C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqX7-0003tU-GD; Mon, 10 Mar 2025 23:43:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqX5-0003t7-Sw
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqX4-0002EN-Ck
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=stzF6/CJeq7vIqCZSk1ikow7UVn/PG7F5Z3GgigrYhE=;
 b=FHpKbslo5+PQ3wILnEKNlQAB7dUeY1+lT/15gLUIdCieGd4wGj73wvbiVRTRUuCu4PVbSs
 6pHUwnRsLvPkGjtv7xkqSAExgyS69R4wGhp0OuiqJwvjEJTtad0hkrr0OTgzhcsYnjQy9a
 NxNPO13QDGlm9HLxNXPv6hzYvuUINgE=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-WLaAMq2ePkybrIU_LtM2qw-1; Mon,
 10 Mar 2025 23:43:50 -0400
X-MC-Unique: WLaAMq2ePkybrIU_LtM2qw-1
X-Mimecast-MFC-AGG-ID: WLaAMq2ePkybrIU_LtM2qw_1741664629
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DC76F180AF65; Tue, 11 Mar 2025 03:43:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D13391800373; Tue, 11 Mar 2025 03:43:45 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 11/63] docs/qapi-domain: add qapi:module directive
Date: Mon, 10 Mar 2025 23:42:09 -0400
Message-ID: <20250311034303.75779-12-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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
index 0ee36b46448..e623d1f8678 100644
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


