Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84372C28B2F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqX3-0003se-Bl; Mon, 10 Mar 2025 23:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqX1-0003sH-QE
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqX0-0002DW-5r
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zwdMjwJu8ylkpK+t8VkVictceMJ1UL9aW45nygG4aiw=;
 b=L18dE0wql+JrTSf2ej+YQJfl41SXMPn2l6zU6lJhE5u/xs1DTCkSG5uSv+dVfAw5/07qMf
 BumKv1Az5SHqzQkyggg7pdv8Z8Z5gGR8Tcy8oyLz+7raYbOvufj/GTRW0Ijd8nP3yOAB0R
 pOjJb3aSB+wTtJ1fxbzncAroDVYca7M=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-BWsoGcYqObOuFxubB6cuKQ-1; Mon,
 10 Mar 2025 23:43:46 -0400
X-MC-Unique: BWsoGcYqObOuFxubB6cuKQ-1
X-Mimecast-MFC-AGG-ID: BWsoGcYqObOuFxubB6cuKQ_1741664625
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DCA519560A3; Tue, 11 Mar 2025 03:43:45 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 085C51800366; Tue, 11 Mar 2025 03:43:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 10/63] docs/qapi-domain: Add QAPIDescription abstract class
Date: Mon, 10 Mar 2025 23:42:08 -0400
Message-ID: <20250311034303.75779-11-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

This class is a generic, top-level directive for documenting some kind
of QAPI thingamajig that we expect to go into the Index. This class
doesn't do much by itself, and it isn't yet associated with any
particular directive.

handle_signature(), _object_hierarchy_parts() and _toc_entry_name() are
defined in the base class. get_index_text() and add_target_and_index()
are new methods defined here; they are based heavily on the layout and
format of the Python domain's general object class.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 101 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 49d42c0921c..0ee36b46448 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -14,11 +14,13 @@
     NamedTuple,
     Optional,
     Tuple,
+    cast,
 )
 
 from docutils import nodes
 
-from sphinx.addnodes import pending_xref
+from sphinx.addnodes import desc_signature, pending_xref
+from sphinx.directives import ObjectDescription
 from sphinx.domains import (
     Domain,
     Index,
@@ -28,7 +30,7 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
-from sphinx.util.nodes import make_refnode
+from sphinx.util.nodes import make_id, make_refnode
 
 
 if TYPE_CHECKING:
@@ -96,6 +98,101 @@ def process_link(
         return title, target
 
 
+Signature = str
+
+
+class QAPIDescription(ObjectDescription[Signature]):
+    """
+    Generic QAPI description.
+
+    This is meant to be an abstract class, not instantiated
+    directly. This class handles the abstract details of indexing, the
+    TOC, and reference targets for QAPI descriptions.
+    """
+
+    def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
+        # Do nothing. The return value here is the "name" of the entity
+        # being documented; for QAPI, this is the same as the
+        # "signature", which is just a name.
+
+        # Normally this method must also populate signode with nodes to
+        # render the signature; here we do nothing instead - the
+        # subclasses will handle this.
+        return sig
+
+    def get_index_text(self, name: Signature) -> Tuple[str, str]:
+        """Return the text for the index entry of the object."""
+
+        # NB: this is used for the global index, not the QAPI index.
+        return ("single", f"{name} (QMP {self.objtype})")
+
+    def add_target_and_index(
+        self, name: Signature, sig: str, signode: desc_signature
+    ) -> None:
+        # name is the return value of handle_signature.
+        # sig is the original, raw text argument to handle_signature.
+        # For QAPI, these are identical, currently.
+
+        assert self.objtype
+
+        # If we're documenting a module, don't include the module as
+        # part of the FQN.
+        modname = ""
+        if self.objtype != "module":
+            modname = self.options.get(
+                "module", self.env.ref_context.get("qapi:module")
+            )
+        fullname = (modname + "." if modname else "") + name
+
+        node_id = make_id(
+            self.env, self.state.document, self.objtype, fullname
+        )
+        signode["ids"].append(node_id)
+
+        self.state.document.note_explicit_target(signode)
+        domain = cast(QAPIDomain, self.env.get_domain("qapi"))
+        domain.note_object(fullname, self.objtype, node_id, location=signode)
+
+        if "no-index-entry" not in self.options:
+            arity, indextext = self.get_index_text(name)
+            assert self.indexnode is not None
+            if indextext:
+                self.indexnode["entries"].append(
+                    (arity, indextext, node_id, "", None)
+                )
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
 class QAPIIndex(Index):
     """
     Index subclass to provide the QAPI definition index.
-- 
2.48.1


