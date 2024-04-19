Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AAB5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1Q-0007WK-EA; Fri, 19 Apr 2024 00:38:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1C-0007SK-MJ
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg16-00049b-RX
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nj35h2WAXeTMyr3hnl2WAc6btn9ZnHTwGwLAP2BhYio=;
 b=RswWdNoDryF9Kw/DThevsWBNRlmd3hXvpONAlhJTcMyEeNWPObDQcapWjzkZndjjF+x9l4
 yJBufLQKgS7E5JNATzhFOq4DX0uoMXdTiGqvu1uKyk0yryA8rBfxlKN64G3hFQNrPfNt1E
 /qz/dV9lZ8x1QUpen6P0LtK1C8dGXt8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-wLCbpNe7NWaM-CKB29iYqA-1; Fri,
 19 Apr 2024 00:38:23 -0400
X-MC-Unique: wLCbpNe7NWaM-CKB29iYqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2559E3CBDF66;
 Fri, 19 Apr 2024 04:38:23 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 741F54011FF7;
 Fri, 19 Apr 2024 04:38:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 02/27] docs/qapi-domain: add qapi:module directive
Date: Fri, 19 Apr 2024 00:37:50 -0400
Message-ID: <20240419043820.178731-3-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.067,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This adds a qapi:module directive, which just notes the current module
being documented and performs a nested parse of the content block, if
present.

This code is based pretty heavily on Sphinx's PyModule directive, but
with the modindex functionality excised.

This commit also adds the _nested_parse helper, which adds cross-version
compatibility for nested parsing while preserving proper line context
information.

For example:

.. qapi:module:: block-core

   Hello, and welcome to block-core!
   =================================

   lorem ipsum, dolor sit amet ...

(For RFC purposes, this commit also adds a test document that
demonstrates the functionality-so-far to allow reviewers to easily test
and experiment with each commit. The eventual submission for inclusion
will remove this playground file.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/index.rst             |   1 +
 docs/qapi/index.rst        |  38 +++++++++++
 docs/sphinx/qapi-domain.py | 128 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 166 insertions(+), 1 deletion(-)
 create mode 100644 docs/qapi/index.rst

diff --git a/docs/index.rst b/docs/index.rst
index 0b9ee9901d9..11c18c598a8 100644
--- a/docs/index.rst
+++ b/docs/index.rst
@@ -18,3 +18,4 @@ Welcome to QEMU's documentation!
    interop/index
    specs/index
    devel/index
+   qapi/index
diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
new file mode 100644
index 00000000000..880fd17c709
--- /dev/null
+++ b/docs/qapi/index.rst
@@ -0,0 +1,38 @@
+----------------
+QAPI Domain Test
+----------------
+
+.. qapi:module:: foo-module
+   :no-index:
+
+   This starts a hypothetical module named ``foo-module``, but it
+   doesn't create a cross-reference target and it isn't added to the
+   index.
+
+   Check out the `genindex` for proof that foo-module is not present.
+
+.. qapi:module:: bar-module
+   :no-typesetting:
+
+   This starts a hypothetical module named ``bar-module``, but the
+   contents of the body here will not be rendered in the
+   output. However, any link targets created here or in nested
+   directives will be preserved and functional.
+
+   Check out the `genindex` for proof that bar-module is present in two
+   places! (under both "bar-module" and "QAPI module".)
+
+.. qapi:module:: block-core
+
+   Block core (VM unrelated)
+   =========================
+
+   This starts the documentation section for the ``block-core`` module.
+   All documentation objects that follow belong to the block-core module
+   until another ``qapi:module:`` directive is encountered.
+
+   This directive does not create an entry in the sidebar or the TOC
+   *unless* you create a nested section title within the directive.
+
+   The ``block-core`` module will have two entries in the `genindex`,
+   under both "block-core" and "QAPI module".
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 163b9ff21c3..7c5e4407bc1 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -7,21 +7,141 @@
 from typing import (
     TYPE_CHECKING,
     Any,
+    ClassVar,
     Dict,
+    Iterable,
     List,
     Tuple,
+    cast,
 )
 
+from docutils import nodes
+from docutils.parsers.rst import directives
+
+from sphinx import addnodes
 from sphinx.domains import Domain, ObjType
 from sphinx.util import logging
+from sphinx.util.docutils import SphinxDirective, switch_source_input
+from sphinx.util.nodes import make_id, nested_parse_with_titles
 
 
 if TYPE_CHECKING:
+    from docutils.nodes import Element, Node
+
     from sphinx.application import Sphinx
+    from sphinx.util.typing import OptionSpec
 
 logger = logging.getLogger(__name__)
 
 
+def _nested_parse(directive: SphinxDirective, content_node: Element) -> None:
+    """
+    This helper preserves error parsing context across sphinx versions.
+    """
+
+    # necessary so that the child nodes get the right source/line set
+    content_node.document = directive.state.document
+
+    try:
+        # Modern sphinx (6.2.0+) supports proper offsetting for
+        # nested parse error context management
+        nested_parse_with_titles(
+            directive.state,
+            directive.content,
+            content_node,
+            content_offset=directive.content_offset,  # type: ignore[call-arg]
+        )
+    except TypeError:
+        # No content_offset argument. Fall back to SSI method.
+        with switch_source_input(directive.state, directive.content):
+            nested_parse_with_titles(directive.state, directive.content, content_node)
+
+
+class QAPIModule(SphinxDirective):
+    """
+    Directive to mark description of a new module.
+
+    This directive doesn't generate any special formatting, and is just
+    a pass-through for the content body. Named section titles are
+    allowed in the content body.
+
+    Use this directive to associate subsequent definitions with the
+    module they are defined in for purposes of search and QAPI index
+    organization.
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
+
+    """
+
+    has_content = True
+    required_arguments = 1
+    optional_arguments = 0
+    final_argument_whitespace = False
+
+    option_spec: ClassVar[OptionSpec] = {
+        # These are universal "Basic" options;
+        # https://www.sphinx-doc.org/en/master/usage/domains/index.html#basic-markup
+        "no-index": directives.flag,
+        "no-typesetting": directives.flag,
+        "no-contents-entry": directives.flag,  # NB: No effect
+        # Deprecated aliases; to be removed in Sphinx 9.0
+        "noindex": directives.flag,
+        "nocontentsentry": directives.flag,  # NB: No effect
+    }
+
+    def run(self) -> List[Node]:
+        modname = self.arguments[0].strip()
+        no_index = "no-index" in self.options or "noindex" in self.options
+
+        self.env.ref_context["qapi:module"] = modname
+
+        content_node: Element = nodes.section()
+        _nested_parse(self, content_node)
+
+        ret: List[Node] = []
+        inode = addnodes.index(entries=[])
+
+        if not no_index:
+            node_id = make_id(self.env, self.state.document, "module", modname)
+            target = nodes.target("", "", ids=[node_id], ismod=True)
+            self.set_source_info(target)
+            self.state.document.note_explicit_target(target)
+
+            indextext = f"QAPI module; {modname}"
+            inode = addnodes.index(
+                entries=[
+                    ("pair", indextext, node_id, "", None),
+                ]
+            )
+            ret.append(inode)
+            content_node.insert(0, target)
+
+        if "no-typesetting" in self.options:
+            if node_ids := [
+                node_id
+                for el in content_node.findall(nodes.Element)
+                for node_id in cast(Iterable[str], el.get("ids", ()))
+            ]:
+                target = nodes.target(ids=node_ids)
+                self.set_source_info(target)
+                ret.append(target)
+        else:
+            ret.extend(content_node.children)
+
+        return ret
+
+
 class QAPIDomain(Domain):
     """QAPI language domain."""
 
@@ -29,7 +149,13 @@ class QAPIDomain(Domain):
     label = "QAPI"
 
     object_types: Dict[str, ObjType] = {}
-    directives = {}
+
+    # Each of these provides a ReST directive,
+    # e.g. .. qapi:module:: block-core
+    directives = {
+        "module": QAPIModule,
+    }
+
     roles = {}
     initial_data: Dict[str, Dict[str, Tuple[Any]]] = {}
     indices = []
-- 
2.44.0


