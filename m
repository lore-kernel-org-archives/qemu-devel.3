Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 024C7E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuHe-0001ND-3E; Thu, 12 Dec 2024 20:15:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuH6-0000yR-S1
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGw-0000vL-0Q
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXzDH2S44TEsrk3c9xiUrSweb/whHKYC8mLrAY2rHQY=;
 b=PvsCfXf6qhaoQhVTHJK+lSzWdXD1Bc4hS9chFwANA1Ei29fFlZTEZPAwXbLb28Dh/ngGRs
 1VXTaWJSb+9cLa0T79jmgKjg8svdANfpJ4k0/yZ8l8mSH1b+TBVX5mw62RHLKXmd5/whEt
 gXYzJJFx7lh2PwYE0DNknLr3hG4q2JI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-149-hsmOC9QlN-qBOYJorDcc2A-1; Thu,
 12 Dec 2024 20:15:10 -0500
X-MC-Unique: hsmOC9QlN-qBOYJorDcc2A-1
X-Mimecast-MFC-AGG-ID: hsmOC9QlN-qBOYJorDcc2A
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0912419560AF; Fri, 13 Dec 2024 01:15:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5655E1956096; Fri, 13 Dec 2024 01:15:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 31/35] docs/qapi-domain: collapsible branches
Date: Thu, 12 Dec 2024 20:13:00 -0500
Message-ID: <20241213011307.2942030-32-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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
 docs/conf.py                           |   1 +
 docs/sphinx-static/theme_overrides.css |  10 ++
 docs/sphinx/collapse.py                | 200 +++++++++++++++++++++++++
 docs/sphinx/qapi-domain.py             | 157 +++++++++++++++----
 4 files changed, 341 insertions(+), 27 deletions(-)
 create mode 100644 docs/sphinx/collapse.py

diff --git a/docs/conf.py b/docs/conf.py
index bad35114351..7998d81f1d9 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -61,6 +61,7 @@
 # extensions coming with Sphinx (named 'sphinx.ext.*') or your custom
 # ones.
 extensions = [
+    'collapse',
     'depfile',
     'hxtool',
     'kerneldoc',
diff --git a/docs/sphinx-static/theme_overrides.css b/docs/sphinx-static/theme_overrides.css
index 5ceb89eb9a8..2ba98d23bbd 100644
--- a/docs/sphinx-static/theme_overrides.css
+++ b/docs/sphinx-static/theme_overrides.css
@@ -296,3 +296,13 @@ dl.field-list > dt {
 dl.field-list > dd:not(:last-child) {
     padding-bottom: 1em;
 }
+
+dl.field-list > dd > details {
+    border-left: solid 5px #bcc6d2;
+}
+
+dl.field-list > dd > details > summary {
+    background-color: #eaedf1;
+    color: black;
+    padding-left: 0.75em;
+}
diff --git a/docs/sphinx/collapse.py b/docs/sphinx/collapse.py
new file mode 100644
index 00000000000..519f1f4b95b
--- /dev/null
+++ b/docs/sphinx/collapse.py
@@ -0,0 +1,200 @@
+"""
+Adds a collapsible section to an HTML page using a details_ element.
+
+.. _details: https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details
+
+Modified (for formatting, vendoring and removing dependencies) from
+sphinx_toolbox.collapse, originally by Dominic Davis-Foster
+<dominic@davis-foster.co.uk>
+
+See https://github.com/sphinx-toolbox/sphinx-toolbox/tree/master
+
+"""
+
+#
+#  Copyright © 2021 Dominic Davis-Foster <dominic@davis-foster.co.uk>
+#
+#  Permission is hereby granted, free of charge, to any person obtaining a copy
+#  of this software and associated documentation files (the "Software"), to deal
+#  in the Software without restriction, including without limitation the rights
+#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+#  copies of the Software, and to permit persons to whom the Software is
+#  furnished to do so, subject to the following conditions:
+#
+#  The above copyright notice and this permission notice shall be
+#  included in all copies or substantial portions of the Software.
+#
+#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+#  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+#  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
+#  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
+#  DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+#  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
+#  OR OTHER DEALINGS IN THE SOFTWARE.
+#
+
+# stdlib
+from typing import (
+    Any,
+    ClassVar,
+    Dict,
+    Optional,
+    Sequence,
+)
+
+# 3rd party
+from docutils import nodes
+from docutils.parsers.rst import directives
+from docutils.parsers.rst.roles import set_classes
+
+from sphinx.application import Sphinx
+from sphinx.util.docutils import SphinxDirective
+from sphinx.writers.html import HTMLTranslator
+
+
+__all__ = (
+    "CollapseDirective",
+    "CollapseNode",
+    "visit_collapse_node",
+    "depart_collapse_node",
+    "setup",
+)
+
+
+def flag(argument: Any) -> bool:
+    """
+    Check for a valid flag option (no argument) and return :py:obj:`True`.
+
+    Used in the ``option_spec`` of directives.
+
+    .. seealso::
+
+       :class:`docutils.parsers.rst.directives.flag`, which returns
+       :py:obj:`None` instead of :py:obj:`True`.
+
+    :raises: :exc:`ValueError` if an argument is given.
+    """
+    if argument and argument.strip():
+        raise ValueError(f"No argument is allowed; {argument!r} supplied")
+    else:
+        return True
+
+
+class CollapseDirective(SphinxDirective):
+    """
+    A Sphinx directive to add a collapsible section to an HTML page
+    using a details_ element.
+
+    .. _details:
+       https://developer.mozilla.org/en-US/docs/Web/HTML/Element/details
+    """
+
+    final_argument_whitespace: ClassVar[bool] = True
+    has_content: ClassVar[bool] = True
+
+    # The label
+    required_arguments: ClassVar[int] = 1
+
+    option_spec = {
+        "class": directives.class_option,
+        "name": directives.unchanged,
+        "open": flag,
+    }
+
+    def run(self) -> Sequence[nodes.Node]:
+        """
+        Process the content of the directive.
+        """
+
+        set_classes(self.options)
+        self.assert_has_content()
+
+        text = "\n".join(self.content)
+        label = self.arguments[0]
+
+        collapse_node = CollapseNode(text, label, **self.options)
+
+        self.add_name(collapse_node)
+
+        collapse_node["classes"].append(f"summary-{nodes.make_id(label)}")
+
+        self.state.nested_parse(
+            self.content, self.content_offset, collapse_node
+        )
+
+        return [collapse_node]
+
+
+class CollapseNode(nodes.Body, nodes.Element):
+    """
+    Node that represents a collapsible section.
+
+    :param rawsource:
+    :param label:
+    """
+
+    def __init__(
+        self,
+        rawsource: str = "",
+        label: Optional[str] = None,
+        *children: Any,
+        **attributes: Any,
+    ) -> None:
+        super().__init__(rawsource, *children, **attributes)
+        self.label = label
+
+
+def visit_collapse_node(translator: HTMLTranslator, node: CollapseNode) -> None:
+    """
+    Visit a :class:`~.CollapseNode`.
+
+    :param translator:
+    :param node: The node being visited.
+    """
+
+    tag_parts = ["details"]
+
+    if names := node.get("names", None):
+        tag_parts.append(f'name="{" ".join(names)}"')
+
+    if classes := node.get("classes", None):
+        tag_parts.append(f'class="{" ".join(classes)}"')
+
+    if node.attributes.get("open", False):
+        tag_parts.append("open")
+
+    translator.body.append(
+        f"<{' '.join(tag_parts)}>\n<summary>{node.label}</summary>"
+    )
+    translator.context.append("</details>")
+
+
+def depart_collapse_node(
+    translator: HTMLTranslator, node: CollapseNode
+) -> None:
+    """
+    Depart a :class:`~.CollapseNode`.
+
+    :param translator:
+    :param node: The node being visited.
+    """
+    translator.body.append(translator.context.pop())
+
+
+def setup(app: Sphinx) -> Dict[str, Any]:
+    """
+    Setup :mod:`sphinx_toolbox.collapse`.
+
+    :param app: The Sphinx application.
+    """
+    app.add_directive("collapse", CollapseDirective)
+    app.add_node(
+        CollapseNode,
+        html=(visit_collapse_node, depart_collapse_node),
+        latex=(lambda *args, **kwargs: None, lambda *args, **kwargs: None),
+    )
+
+    return {
+        "parallel_read_safe": True,
+        "version": "3.5.0",
+    }
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 7cbf12d93f7..ee9b1d056ff 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -23,6 +23,7 @@
 from docutils.parsers.rst import directives
 from docutils.statemachine import StringList
 
+from collapse import CollapseNode
 from compat import keyword_node, nested_parse, space_node
 import sphinx
 from sphinx import addnodes
@@ -466,10 +467,7 @@ def _validate_field(self, field: nodes.field) -> None:
         allowed_fields = set(self.env.app.config.qapi_allowed_fields)
 
         field_label = name.astext()
-        if (
-            re.match(r"\[\S+ = \S+\]", field_label)
-            or field_label in allowed_fields
-        ):
+        if field_label == ":BRANCH:" or field_label in allowed_fields:
             # okie-dokey. branch entry or known good allowed name.
             return
 
@@ -528,6 +526,8 @@ def before_content(self) -> None:
             self.content_offset = 0
 
     def transform_content(self, contentnode: addnodes.desc_content) -> None:
+        self.content_node = contentnode
+
         # Sphinx workaround: Inject our parsed content and restore state.
         if self._temp_node:
             contentnode += self._temp_node.children
@@ -547,6 +547,66 @@ def transform_content(self, contentnode: addnodes.desc_content) -> None:
                     assert isinstance(field, nodes.field)
                     self._validate_field(field)
 
+    def after_content(self) -> None:
+        # Now that the DocFieldTransformer has been invoked in
+        # ObjectDescription.run, we can take our branch entries and
+        # extract their contents and inject them into the preceding
+        # field list body.
+
+        # For example:
+        #
+        # Arguments: * lorem
+        #            * ipsum
+        # :BRANCH:   <branch stuff here>
+        #
+        # will be transformed into:
+        #
+        # Arguments: * lorem
+        #            * ipsum
+        #            <branch stuff here>
+
+        branch_content: List[nodes.Node] = []
+        insertion_field: Optional[nodes.field] = None
+
+        def _inject(
+            field: Optional[nodes.field], content: List[nodes.Node]
+        ) -> None:
+            if not (field or content):
+                return
+            if not field:
+                print(
+                    "ERROR: qapi:branch directive used without a preceding "
+                    "Members/Arguments field; there's nowhere to inject the "
+                    "branch members into!"
+                )
+                return
+            _, body = _unpack_field(field)
+            body += content
+
+        for child in self.content_node:
+            if isinstance(child, nodes.field_list):
+                delete_queue: List[nodes.field] = []
+                for field in child.children:
+                    assert isinstance(field, nodes.field)
+                    name, body = _unpack_field(field)
+                    if name.astext() == ":BRANCH:":
+                        branch_content.extend(body.children)
+                        delete_queue.append(field)
+                    elif not branch_content:
+                        insertion_field = field
+                    else:
+                        # Field is not a branch and branch_content is not empty;
+                        # we should do the insertion here and now.
+                        _inject(insertion_field, branch_content)
+                        insertion_field = None
+                        branch_content = []
+
+                # Delete any branches encountered thus far.
+                for field in delete_queue:
+                    child.remove(field)
+
+        _inject(insertion_field, branch_content)
+
     def _toc_entry_name(self, sig_node: desc_signature) -> str:
         # This controls the name in the TOC and on the sidebar.
 
@@ -770,14 +830,27 @@ def run(self) -> List[Node]:
 
 class Branch(SphinxDirective):
     """
-    Nested directive which only serves to introduce temporary
-    metadata but return its parsed content nodes unaltered otherwise.
+    A nested directive to document union Branches.
 
-    Technically, you can put whatever you want in here, but doing so may
-    prevent proper merging of adjacent field lists.
+    This directive should contain at most one type of semantic/grouped
+    field list type, either "memb" or "arg".
     """
 
-    doc_field_types: List[Field] = []
+    # The :BRANCH: name is a placeholder. You can probably get a
+    # legitimate field list with this name if you try hard
+    # enough, but it should be difficult to do by accident.
+    doc_field_types: List[Field] = [
+        # :arg type name: descr
+        # :memb type name: descr
+        QAPITypedField(
+            "branch-arg-or-memb",
+            label=":BRANCH:",
+            names=("arg", "memb"),
+            typerolename="type",
+            can_collapse=False,
+        ),
+    ]
+
     has_content = True
     required_arguments = 2
     optional_arguments = 0
@@ -799,29 +872,59 @@ def run(self) -> list[Node]:
         discrim = self.arguments[0].strip()
         value = self.arguments[1].strip()
 
-        # The label name is dynamically generated per-instance instead
-        # of per-class to incorporate the branch conditions as a label
-        # name.
-        self.doc_field_types = [
-            # :arg type name: descr
-            # :memb type name: descr
-            QAPITypedField(
-                "branch-arg-or-memb",
-                label=f"[{discrim} = {value}]",
-                # In a branch, we don't actually use the name of the
-                # field name to generate the label; so allow either-or.
-                names=("arg", "memb"),
-                typerolename="type",
-            ),
-        ]
-
-        content_node: addnodes.desc_content = addnodes.desc_content()
+        content_node = addnodes.desc_content()
         nested_parse(self, content_node)
         # DocFieldTransformer usually expects ObjectDescription, but... quack!
         transformer = DocFieldTransformer(quack(ObjectDescription, self))
         transformer.transform_all(content_node)
 
-        return content_node.children
+        if not content_node.children:
+            # Empty branch - it happens. Squelch it.
+            return []
+
+        # Now, we're gonna do some surgery.
+        #
+        # We're going to find any field lists that contain members/args
+        # and extract the transformed content from that field list,
+        # while deleting the field list itself - to avoid having nested
+        # field lists for branches.
+
+        replacements = []
+        for child in content_node:
+            if isinstance(child, nodes.field_list):
+                if len(child.children) != 1:
+                    # We're only interested in field lists with one field;
+                    # since these are the semantically grouped/formatted bits.
+                    continue
+
+                field = child.children[0]
+                assert isinstance(field, nodes.field)
+                field_name, field_body = _unpack_field(field)
+
+                if field_name.astext() == ":BRANCH:":
+                    replacements.append((child, field_body))
+
+        # Delete grouped field lists, replacing them with just their content;
+        # after field transformation, this should be a list.
+        for child, field_body in replacements:
+            child.replace_self(field_body.children)
+
+        # Wrap the entire contents up in a collapsible node
+        collapse_node = CollapseNode(
+            "", f"When {discrim} is {value}: ...", *content_node.children
+        )
+
+        # Then wrap it all back up in a new field list.
+        new_content = nodes.field_list(
+            "",
+            nodes.field(
+                "",
+                nodes.field_name("", ":BRANCH:"),
+                nodes.field_body("", collapse_node),
+            ),
+        )
+
+        return [new_content]
 
 
 class QAPIIndex(Index):
-- 
2.47.0


