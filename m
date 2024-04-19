Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80F16C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1I-0007Tt-H8; Fri, 19 Apr 2024 00:38:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1A-0007PO-Ko
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg18-00049w-0V
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3l3KznzN5IC/sqY7udLFwiu1omnR5f9e149VssCm8M4=;
 b=JmWjrzpmFhYnSTyIligfZt0CudonvyYQejTacTfW7pmDwy+37PG4fBx1E1Ka7OOPX4zRil
 fUmNSz0bvzWwaeQNzEo8oMRlSHWZiBYBuE0YYMG0wXMCprfvjkLjRFA4gNj71tPD9WlD3x
 iGML9YHJlf9w0nOsrey3Mj697J41h4s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-tUZYw9Z_MqylqBWHWXXE0A-1; Fri,
 19 Apr 2024 00:38:27 -0400
X-MC-Unique: tUZYw9Z_MqylqBWHWXXE0A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CE9DE286A9D6;
 Fri, 19 Apr 2024 04:38:26 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2BC664011FF7;
 Fri, 19 Apr 2024 04:38:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 07/27] docs/qapi-domain: add qapi:command directive
Date: Fri, 19 Apr 2024 00:37:55 -0400
Message-ID: <20240419043820.178731-8-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

This commit adds a generic QAPIObject class for use in documenting
various QAPI entities in the Sphinx ecosystem.

It also adds a stubbed version of QAPICommand that utilizes the
QAPIObject class; along with the qapi:command directive, the
:qapi:cmd: cross-reference role, and the "command" object type in the
QAPI object registry.

They don't do anything *particularly* interesting yet, but that will
come in forthcoming commits.

Note: some versions of mypy get a little confused over the difference
between class and instance variables; because sphinx's ObjectDescription
does not declare option_spec as a ClassVar (even though it's obvious
that it is), mypy may produce this error:

qapi-domain.py:125: error: Cannot override instance variable (previously
declared on base class "ObjectDescription") with class variable [misc]

I can't control that; so silence the error with a pragma.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  34 ++++++++++
 docs/sphinx/qapi-domain.py | 132 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 165 insertions(+), 1 deletion(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index e2223d5f363..5516f762a24 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -51,3 +51,37 @@ the actual output of that directive was suppressed. Here's a link to
 Explicit cross-referencing syntax for QAPI modules is available with
 ``:qapi:mod:`foo```, here's a link to :qapi:mod:`bar-module` and one to
 :qapi:mod:`block-core`.
+
+
+.. qapi:command:: example-command
+
+   This directive creates a QAPI command named `example-command` that
+   appears in both the `genindex` and the `qapi-index`. As of this
+   commit, there aren't any special arguments or options you can give to
+   this directive, it merely parses its content block and handles the
+   TOC/index/xref book-keeping.
+
+   Unlike the QAPI module directive, this directive *does* add a TOC
+   entry by default.
+
+   This object can be referenced in *quite a few ways*:
+
+   * ```example-command``` => `example-command`
+   * ```block-core.example-command``` => `block-core.example-command`
+   * ``:qapi:cmd:`example-command``` => :qapi:cmd:`example-command`
+   * ``:qapi:cmd:`block-core.example-command``` => :qapi:cmd:`block-core.example-command`
+   * ``:qapi:cmd:`~example-command``` => :qapi:cmd:`~example-command`
+   * ``:qapi:cmd:`~block-core.example-command``` => :qapi:cmd:`~block-core.example-command`
+   * ``:qapi:obj:`example-command``` => :qapi:obj:`example-command`
+   * ``:qapi:obj:`block-core.example-command``` => :qapi:obj:`block-core.example-command`
+   * ``:qapi:obj:`~example-command``` => :qapi:obj:`~example-command`
+   * ``:qapi:obj:`~block-core.example-command``` => :qapi:obj:`~block-core.example-command`
+
+   As of Sphinx v7.2.6, there are a few sphinx-standard options this
+   directive has:
+
+   * ``:no-index:`` or ``:noindex:`` Don't add to the `genindex` nor
+     the `qapi-index`; do not register for cross-references.
+   * ``:no-index-entry:`` or ``:noindexentry:``
+   * ``:no-contents-entry:`` or ``:nocontentsentry:``
+   * ``:no-typesetting:``
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index d28ac1cb9d8..2c1e60290d9 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -21,7 +21,8 @@
 from docutils.parsers.rst import directives
 
 from sphinx import addnodes
-from sphinx.addnodes import pending_xref
+from sphinx.addnodes import desc_signature, pending_xref
+from sphinx.directives import ObjectDescription
 from sphinx.domains import (
     Domain,
     Index,
@@ -108,6 +109,132 @@ def _nested_parse(directive: SphinxDirective, content_node: Element) -> None:
             nested_parse_with_titles(directive.state, directive.content, content_node)
 
 
+# Alias for the return of handle_signature(), which is used in several places.
+# (In the Python domain, this is Tuple[str, str] instead.)
+Signature = str
+
+
+class QAPIObject(ObjectDescription[Signature]):
+    """
+    Description of a generic QAPI object.
+
+    It's not used directly, but is instead subclassed by specific directives.
+    """
+
+    # Inherit some standard options from Sphinx's ObjectDescription
+    option_spec: OptionSpec = ObjectDescription.option_spec.copy()  # type:ignore[misc]
+    option_spec.update(
+        {
+            # Borrowed from the Python domain:
+            "module": directives.unchanged,  # Override contextual module name
+        }
+    )
+
+    def get_signature_prefix(self, sig: str) -> List[nodes.Node]:
+        """Returns a prefix to put before the object name in the signature."""
+        assert self.objtype
+        return [
+            addnodes.desc_sig_keyword("", self.objtype.title()),
+            addnodes.desc_sig_space(),
+        ]
+
+    def get_signature_suffix(self, sig: str) -> list[nodes.Node]:
+        """Returns a suffix to put after the object name in the signature."""
+        return []
+
+    def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
+        """
+        Transform a QAPI definition name into RST nodes.
+
+        This method was originally intended for handling function
+        signatures. In the QAPI domain, however, we only pass the
+        command name as the directive argument and handle everything
+        else in the content body with field lists.
+
+        As such, the only argument here is "sig", which is just the QAPI
+        definition name.
+        """
+        modname = self.options.get("module", self.env.ref_context.get("qapi:module"))
+
+        signode["fullname"] = sig
+        signode["module"] = modname
+        sig_prefix = self.get_signature_prefix(sig)
+        if sig_prefix:
+            signode += addnodes.desc_annotation(str(sig_prefix), "", *sig_prefix)
+        signode += addnodes.desc_name(sig, sig)
+        signode += self.get_signature_suffix(sig)
+
+        return sig
+
+    def _object_hierarchy_parts(self, sig_node: desc_signature) -> Tuple[str, ...]:
+        if "fullname" not in sig_node:
+            return ()
+        modname = sig_node.get("module")
+        fullname = sig_node["fullname"]
+
+        if modname:
+            return (modname, *fullname.split("."))
+        else:
+            return tuple(fullname.split("."))
+
+    def get_index_text(self, modname: str, name: Signature) -> str:
+        """Return the text for the index entry of the object."""
+        # NB this is used for the global index, not the QAPI index.
+        return f"{name} (QMP {self.objtype})"
+
+    def add_target_and_index(
+        self, name: Signature, sig: str, signode: desc_signature
+    ) -> None:
+        # Called by ObjectDescription.run with the result of
+        # handle_signature; name is the return value of handle_signature
+        # where sig is the original argument to handle_signature. In our
+        # case, they're the same for now.
+        assert self.objtype
+
+        modname = self.options.get("module", self.env.ref_context.get("qapi:module"))
+        # Here, sphinx decides to prepend the module name. OK.
+        fullname = (modname + "." if modname else "") + name
+        node_id = make_id(self.env, self.state.document, "", fullname)
+        signode["ids"].append(node_id)
+        self.state.document.note_explicit_target(signode)
+
+        domain = cast(QAPIDomain, self.env.get_domain("qapi"))
+        domain.note_object(fullname, self.objtype, node_id, location=signode)
+
+        if "no-index-entry" not in self.options:
+            indextext = self.get_index_text(modname, name)
+            assert self.indexnode is not None
+            if indextext:
+                self.indexnode["entries"].append(
+                    ("single", indextext, node_id, "", None)
+                )
+
+    def _toc_entry_name(self, sig_node: desc_signature) -> str:
+        # This controls the name in the TOC and on the sidebar.
+
+        # This is the return type of _object_hierarchy_parts().
+        toc_parts = cast(Tuple[str, ...], sig_node.get("_toc_parts", ()))
+        if not toc_parts:
+            return ""
+
+        config = self.env.app.config
+        *parents, name = toc_parts
+        if config.toc_object_entries_show_parents == "domain":
+            return sig_node.get("fullname", name)
+        if config.toc_object_entries_show_parents == "hide":
+            return name
+        if config.toc_object_entries_show_parents == "all":
+            return ".".join(parents + [name])
+        return ""
+
+
+class QAPICommand(QAPIObject):
+    """Description of a QAPI Command."""
+
+    # Nothing unique for now! Changed in later commits O:-)
+    pass
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -255,12 +382,14 @@ class QAPIDomain(Domain):
     # for each object type.
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "obj"),
+        "command": ObjType(_("command"), "cmd", "obj"),
     }
 
     # Each of these provides a ReST directive,
     # e.g. .. qapi:module:: block-core
     directives = {
         "module": QAPIModule,
+        "command": QAPICommand,
     }
 
     # These are all cross-reference roles; e.g.
@@ -268,6 +397,7 @@ class QAPIDomain(Domain):
     # the object_types table values above.
     roles = {
         "mod": QAPIXRefRole(),
+        "cmd": QAPIXRefRole(),
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.44.0


