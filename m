Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4C0C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:39:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1A-0007PK-UO; Fri, 19 Apr 2024 00:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg18-0007NW-Mv
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg16-00049e-S2
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501507;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/AEQhBBM6eRMT5ZEFVa7wWZlrEMhJwKKNup8PtABSHw=;
 b=MaFjkz5/hsRmt5BzPb+T8LBXiIyxM8J4h7YEjenz++ykDItusd/R0XMjf2fqeV7PfEPSBE
 QweBET31F44SUg5cTIv8ktP522TVZSuoDABKGpqVxz2rTT2uGqUubeYV+bxXr0tJTkegX3
 TmJhFDignb0c5bFH7064X/gkn8dLgQ0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-BGK83vgJM4SGsq4-78L5OA-1; Fri, 19 Apr 2024 00:38:24 -0400
X-MC-Unique: BGK83vgJM4SGsq4-78L5OA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D9C76810602;
 Fri, 19 Apr 2024 04:38:23 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33C8440357A7;
 Fri, 19 Apr 2024 04:38:23 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 03/27] docs/qapi-module: add QAPI domain object registry
Date: Fri, 19 Apr 2024 00:37:51 -0400
Message-ID: <20240419043820.178731-4-jsnow@redhat.com>
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

This is the first step towards QAPI domain cross-references and a QAPI
reference index.

For now, just create the object registry and amend the qapi:module
directive to use that registry. Update the merge_domaindata method now
that we have actual data we may need to merge.

RFC: Much of this code is adapted directly from sphinx.domains.python;
it is unclear to me if there ever would be a collision on merge, hence
the assertion. I haven't been able to trigger it or find better code to
use as a template, so probably I'll just leave the assertion in there.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 76 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 7c5e4407bc1..ab80fd5f634 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -11,6 +11,7 @@
     Dict,
     Iterable,
     List,
+    NamedTuple,
     Tuple,
     cast,
 )
@@ -20,6 +21,7 @@
 
 from sphinx import addnodes
 from sphinx.domains import Domain, ObjType
+from sphinx.locale import _, __
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import make_id, nested_parse_with_titles
@@ -34,6 +36,13 @@
 logger = logging.getLogger(__name__)
 
 
+class ObjectEntry(NamedTuple):
+    docname: str
+    node_id: str
+    objtype: str
+    aliased: bool
+
+
 def _nested_parse(directive: SphinxDirective, content_node: Element) -> None:
     """
     This helper preserves error parsing context across sphinx versions.
@@ -101,6 +110,7 @@ class QAPIModule(SphinxDirective):
     }
 
     def run(self) -> List[Node]:
+        domain = cast(QAPIDomain, self.env.get_domain("qapi"))
         modname = self.arguments[0].strip()
         no_index = "no-index" in self.options or "noindex" in self.options
 
@@ -113,11 +123,14 @@ def run(self) -> List[Node]:
         inode = addnodes.index(entries=[])
 
         if not no_index:
+            # note module to the domain
             node_id = make_id(self.env, self.state.document, "module", modname)
             target = nodes.target("", "", ids=[node_id], ismod=True)
             self.set_source_info(target)
             self.state.document.note_explicit_target(target)
 
+            domain.note_object(modname, "module", node_id, location=target)
+
             indextext = f"QAPI module; {modname}"
             inode = addnodes.index(
                 entries=[
@@ -148,7 +161,12 @@ class QAPIDomain(Domain):
     name = "qapi"
     label = "QAPI"
 
-    object_types: Dict[str, ObjType] = {}
+    # This table associates cross-reference object types (key) with an
+    # ObjType instance, which defines the valid cross-reference roles
+    # for each object type.
+    object_types: Dict[str, ObjType] = {
+        "module": ObjType(_("module"), "mod", "obj"),
+    }
 
     # Each of these provides a ReST directive,
     # e.g. .. qapi:module:: block-core
@@ -157,11 +175,63 @@ class QAPIDomain(Domain):
     }
 
     roles = {}
-    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {}
+
+    # Moved into the data property at runtime;
+    # this is the internal index of reference-able objects.
+    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {
+        "objects": {},  # fullname -> ObjectEntry
+    }
+
     indices = []
 
+    @property
+    def objects(self) -> Dict[str, ObjectEntry]:
+        return self.data.setdefault("objects", {})  # type: ignore[no-any-return]
+
+    def note_object(
+        self,
+        name: str,
+        objtype: str,
+        node_id: str,
+        aliased: bool = False,
+        location: Any = None,
+    ) -> None:
+        """Note a QAPI object for cross reference."""
+        if name in self.objects:
+            other = self.objects[name]
+            if other.aliased and aliased is False:
+                # The original definition found. Override it!
+                pass
+            elif other.aliased is False and aliased:
+                # The original definition is already registered.
+                return
+            else:
+                # duplicated
+                logger.warning(
+                    __(
+                        "duplicate object description of %s, "
+                        "other instance in %s, use :no-index: for one of them"
+                    ),
+                    name,
+                    other.docname,
+                    location=location,
+                )
+        self.objects[name] = ObjectEntry(self.env.docname, node_id, objtype, aliased)
+
+    def clear_doc(self, docname: str) -> None:
+        for fullname, obj in list(self.objects.items()):
+            if obj.docname == docname:
+                del self.objects[fullname]
+
     def merge_domaindata(self, docnames: List[str], otherdata: Dict[str, Any]) -> None:
-        pass
+        for fullname, obj in otherdata["objects"].items():
+            if obj.docname in docnames:
+                # FIXME: Unsure of the implications of merge conflicts.
+                # Sphinx's own python domain doesn't appear to bother.
+                assert (
+                    fullname not in self.objects
+                ), f"!?!? collision on merge? {fullname=} {obj=} {self.objects[fullname]=}"
+                self.objects[fullname] = obj
 
 
 def setup(app: Sphinx) -> Dict[str, Any]:
-- 
2.44.0


