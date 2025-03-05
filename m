Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F07EC19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:49:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfir-0005SR-20; Tue, 04 Mar 2025 22:47:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfip-0005Rm-El
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfin-00065F-Je
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:47:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146420;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DyjACrY0my7wCr/yL1onWCjkED4tWYNrUnfInrUzYqo=;
 b=gh4u+UpCA60UIto65Kxqxj4D1v5c1vpx01wAfGGmdGSqDba3nm9r7FwEP/ggaqf9UbA8g/
 I8pisYCHXhBlXlSXgUd+byAh51DBHw2spLe3jX9LDRgpTZWrSRvhuCAHiIA1e3F8Yu6ndn
 8aofSx36edKGygiiw65GJRobglMGWWs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-l2RzfjO1PwC42XOWigfVRg-1; Tue,
 04 Mar 2025 22:46:56 -0500
X-MC-Unique: l2RzfjO1PwC42XOWigfVRg-1
X-Mimecast-MFC-AGG-ID: l2RzfjO1PwC42XOWigfVRg_1741146415
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0D6BD1800258; Wed,  5 Mar 2025 03:46:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 040D61956095; Wed,  5 Mar 2025 03:46:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 11/57] docs/qapi-domain: add qapi:command directive
Date: Tue,  4 Mar 2025 22:45:20 -0500
Message-ID: <20250305034610.960147-12-jsnow@redhat.com>
In-Reply-To: <20250305034610.960147-1-jsnow@redhat.com>
References: <20250305034610.960147-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
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

This commit adds a stubbed version of QAPICommand that utilizes the
QAPIObject class, the qapi:command directive, the :qapi:cmd:
cross-reference role, and the "command" object type in the QAPI object
registry.

This commit also adds the aforementioned generic QAPIObject class for
use in documenting various QAPI entities in the Sphinx ecosystem.

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
 docs/sphinx/qapi_domain.py | 146 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 144 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 104bae709f3..6168c23936f 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -21,9 +21,10 @@
 from docutils import nodes
 from docutils.parsers.rst import directives
 
-from compat import nested_parse
+from compat import KeywordNode, SpaceNode, nested_parse
 from sphinx import addnodes
-from sphinx.addnodes import pending_xref
+from sphinx.addnodes import desc_signature, pending_xref
+from sphinx.directives import ObjectDescription
 from sphinx.domains import (
     Domain,
     Index,
@@ -103,6 +104,144 @@ def process_link(
         return title, target
 
 
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
+    option_spec: OptionSpec = (  # type:ignore[misc]
+        ObjectDescription.option_spec.copy()
+    )
+    option_spec.update(
+        {
+            # Borrowed from the Python domain:
+            "module": directives.unchanged,  # Override contextual module name
+        }
+    )
+
+    def get_signature_prefix(self) -> List[nodes.Node]:
+        """Returns a prefix to put before the object name in the signature."""
+        assert self.objtype
+        return [
+            KeywordNode("", self.objtype.title()),
+            SpaceNode(" "),
+        ]
+
+    def get_signature_suffix(self) -> list[nodes.Node]:
+        """Returns a suffix to put after the object name in the signature."""
+        return []
+
+    def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
+        """
+        Transform a QAPI definition name into RST nodes.
+
+        This method was originally intended for handling function
+        signatures. In the QAPI domain, however, we only pass the
+        definition name as the directive argument and handle everything
+        else in the content body with field lists.
+
+        As such, the only argument here is "sig", which is just the QAPI
+        definition name.
+        """
+        modname = self.options.get(
+            "module", self.env.ref_context.get("qapi:module")
+        )
+
+        signode["fullname"] = sig
+        signode["module"] = modname
+        sig_prefix = self.get_signature_prefix()
+        if sig_prefix:
+            signode += addnodes.desc_annotation(
+                str(sig_prefix), "", *sig_prefix
+            )
+        signode += addnodes.desc_name(sig, sig)
+        signode += self.get_signature_suffix()
+
+        return sig
+
+    def _object_hierarchy_parts(
+        self, sig_node: desc_signature
+    ) -> Tuple[str, ...]:
+        if "fullname" not in sig_node:
+            return ()
+        modname = sig_node.get("module")
+        fullname = sig_node["fullname"]
+
+        if modname:
+            return (modname, *fullname.split("."))
+
+        return tuple(fullname.split("."))
+
+    def get_index_text(self, modname: str, name: Signature) -> str:
+        """Return the text for the index entry of the object."""
+        # We don't care about the module name here:
+        # pylint: disable=unused-argument
+
+        # NB: this is used for the global index, not the QAPI index.
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
+        modname = self.options.get(
+            "module", self.env.ref_context.get("qapi:module")
+        )
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
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -260,12 +399,14 @@ class QAPIDomain(Domain):
     # for each object type.
     object_types: Dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "any"),
+        "command": ObjType(_("command"), "cmd", "any"),
     }
 
     # Each of these provides a rST directive,
     # e.g. .. qapi:module:: block-core
     directives = {
         "module": QAPIModule,
+        "command": QAPICommand,
     }
 
     # These are all cross-reference roles; e.g.
@@ -273,6 +414,7 @@ class QAPIDomain(Domain):
     # the object_types table values above.
     roles = {
         "mod": QAPIXRefRole(),
+        "cmd": QAPIXRefRole(),
         "any": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
 
-- 
2.48.1


