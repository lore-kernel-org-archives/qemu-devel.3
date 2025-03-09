Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B03CC28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trC9C-0001Pk-Dm; Sun, 09 Mar 2025 04:36:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC99-0001JU-H6
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trC97-0002Gf-Sw
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rEcgJgX1Tc9fh9KtTKUadgN+QWVciYvUV+p80OxqYOQ=;
 b=Qb2CcDU+x1T8GFqU/NQViYNtHs9ESQUNriNk1PSx+jFHxStyd+ZSK+xtARPIz8mvsAD8md
 VwJnHcSNzHUFL0NmXu402Sk+kHusKBjtTketRn0sZQ7G7Nybf0HGkWU86W3hbRlbdeFssC
 tyx+U3EHWtQeTefScUBKMitG8wnJjTw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-_Fh1_yTXMZOAA_OG_xybIw-1; Sun,
 09 Mar 2025 04:36:25 -0400
X-MC-Unique: _Fh1_yTXMZOAA_OG_xybIw-1
X-Mimecast-MFC-AGG-ID: _Fh1_yTXMZOAA_OG_xybIw_1741509382
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A926419560A3; Sun,  9 Mar 2025 08:36:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E81DA19560AB; Sun,  9 Mar 2025 08:36:20 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 12/62] docs/qapi-domain: add QAPIObject class
Date: Sun,  9 Mar 2025 04:34:59 -0400
Message-ID: <20250309083550.5155-13-jsnow@redhat.com>
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

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 95 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index a445150ae59..183d9a2766f 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -18,7 +18,9 @@
 )
 
 from docutils import nodes
+from docutils.parsers.rst import directives
 
+from compat import KeywordNode, SpaceNode
 from sphinx import addnodes
 from sphinx.addnodes import desc_signature, pending_xref
 from sphinx.directives import ObjectDescription
@@ -40,6 +42,7 @@
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
     from sphinx.environment import BuildEnvironment
+    from sphinx.util.typing import OptionSpec
 
 logger = logging.getLogger(__name__)
 
@@ -99,6 +102,8 @@ def process_link(
         return title, target
 
 
+# Alias for the return of handle_signature(), which is used in several places.
+# (In the Python domain, this is Tuple[str, str] instead.)
 Signature = str
 
 
@@ -158,6 +163,96 @@ def add_target_and_index(
                 )
 
 
+class QAPIObject(QAPIDescription):
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
+    def get_signature_suffix(self) -> List[nodes.Node]:
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
 class QAPIModule(QAPIDescription):
     """
     Directive to mark description of a new module.
-- 
2.48.1


