Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89635C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:51:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfim-0005RI-W3; Tue, 04 Mar 2025 22:47:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfik-0005Qe-Nc
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfii-00064Z-7g
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ng15VbEQRc/aE0mDvlp5ZprGwNkxrt0jH74IRQaoYcQ=;
 b=NMOPO3L6WAU8F8JDfkM4RDJ7zPSRToLahv+2dqgcuaTUUR5UlhLgtiHy6p97MbPT7Cqwnl
 xCg/yosC3aRu41prYlptfD7w8nxRxhYNIv2AzLd4FaTVz3pEH4lze7umZh1eiAPQM262iS
 4hYph3dRYx/7Mc9EIdoHDN0631Bg/2I=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-TT1OfoijPbaruIlJsHNDuA-1; Tue,
 04 Mar 2025 22:46:34 -0500
X-MC-Unique: TT1OfoijPbaruIlJsHNDuA-1
X-Mimecast-MFC-AGG-ID: TT1OfoijPbaruIlJsHNDuA_1741146393
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 318D31954190; Wed,  5 Mar 2025 03:46:33 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 62B031955DDD; Wed,  5 Mar 2025 03:46:30 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 05/57] docs/qapi-domain: add qapi:module directive
Date: Tue,  4 Mar 2025 22:45:14 -0500
Message-ID: <20250305034610.960147-6-jsnow@redhat.com>
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

This adds a qapi:module directive, which just notes the current module
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
 docs/sphinx/qapi_domain.py | 107 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 106 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index a1983d94440..8ce3caf933d 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -8,20 +8,119 @@
     TYPE_CHECKING,
     AbstractSet,
     Any,
+    ClassVar,
     Dict,
+    Iterable,
+    List,
     Tuple,
+    cast,
 )
 
+from docutils import nodes
+from docutils.parsers.rst import directives
+
+from compat import nested_parse
+from sphinx import addnodes
 from sphinx.domains import Domain, ObjType
 from sphinx.util import logging
+from sphinx.util.docutils import SphinxDirective
+from sphinx.util.nodes import make_id
 
 
 if TYPE_CHECKING:
+    from docutils.nodes import Element, Node
+
     from sphinx.application import Sphinx
+    from sphinx.util.typing import OptionSpec
 
 logger = logging.getLogger(__name__)
 
 
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
+        nested_parse(self, content_node)
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
 
@@ -29,7 +128,13 @@ class QAPIDomain(Domain):
     label = "QAPI"
 
     object_types: Dict[str, ObjType] = {}
-    directives = {}
+
+    # Each of these provides a rST directive,
+    # e.g. .. qapi:module:: block-core
+    directives = {
+        "module": QAPIModule,
+    }
+
     roles = {}
     initial_data: Dict[str, Dict[str, Tuple[Any]]] = {}
     indices = []
-- 
2.48.1


