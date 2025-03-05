Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8047FC282D3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 03:54:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpfiZ-0005OJ-5P; Tue, 04 Mar 2025 22:46:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiV-0005NV-1H
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tpfiT-00062A-BN
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 22:46:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741146399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ll7eEBHZmTf+wxXy0PnPmZ084Yv37EYEVaALXgrczEc=;
 b=QALFHnsJpoBYb/GDoY7bhrtVc+i4946cWb3nUYM5Yf+PVwmpFnkIOMTkV6NkQqcWLWCs3J
 1Y/37GMoeVsWs15DC9iX4zbewcI21LMqdO8L/n9CPPaGEUfVCzlUmd2cKG0+S7OSwn5vGo
 oEtu92WvUD7R/8+0PWJlW9ooOD5P+08=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-671-gn5YVELhNsabTpMWURxPQw-1; Tue,
 04 Mar 2025 22:46:36 -0500
X-MC-Unique: gn5YVELhNsabTpMWURxPQw-1
X-Mimecast-MFC-AGG-ID: gn5YVELhNsabTpMWURxPQw_1741146395
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E3601954190; Wed,  5 Mar 2025 03:46:35 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.45])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 793F41956095; Wed,  5 Mar 2025 03:46:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 06/57] docs/qapi-domain: add QAPI domain object registry
Date: Tue,  4 Mar 2025 22:45:15 -0500
Message-ID: <20250305034610.960147-7-jsnow@redhat.com>
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

This is the first step towards QAPI domain cross-references and a QAPI
reference index.

This patch just creates the object registry and amends the qapi:module
directive to use that registry. Update the merge_domaindata stub method
now that we have actual data we may need to merge.

This patch also defines that "module" entities can be referenced with
:qapi:mod:`foo` or :qapi:any:`foo` references, although the
implementation for those roles is handled in a forthcoming patch.

Note that how to handle merge conflict resolution is unhandled, as the
Sphinx python domain itself does not handle it either. I do not know how
to intentionally trigger it, so I've left an assertion instead if it
should ever come up ...

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 81 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 78 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 8ce3caf933d..b17fcb93f24 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -12,6 +12,7 @@
     Dict,
     Iterable,
     List,
+    NamedTuple,
     Tuple,
     cast,
 )
@@ -22,6 +23,7 @@
 from compat import nested_parse
 from sphinx import addnodes
 from sphinx.domains import Domain, ObjType
+from sphinx.locale import _, __
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id
@@ -36,6 +38,13 @@
 logger = logging.getLogger(__name__)
 
 
+class ObjectEntry(NamedTuple):
+    docname: str
+    node_id: str
+    objtype: str
+    aliased: bool
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -80,6 +89,7 @@ class QAPIModule(SphinxDirective):
     }
 
     def run(self) -> List[Node]:
+        domain = cast(QAPIDomain, self.env.get_domain("qapi"))
         modname = self.arguments[0].strip()
         no_index = "no-index" in self.options or "noindex" in self.options
 
@@ -92,11 +102,14 @@ def run(self) -> List[Node]:
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
@@ -127,7 +140,12 @@ class QAPIDomain(Domain):
     name = "qapi"
     label = "QAPI"
 
-    object_types: Dict[str, ObjType] = {}
+    # This table associates cross-reference object types (key) with an
+    # ObjType instance, which defines the valid cross-reference roles
+    # for each object type.
+    object_types: Dict[str, ObjType] = {
+        "module": ObjType(_("module"), "mod", "any"),
+    }
 
     # Each of these provides a rST directive,
     # e.g. .. qapi:module:: block-core
@@ -136,13 +154,70 @@ class QAPIDomain(Domain):
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
+        ret = self.data.setdefault("objects", {})
+        return ret  # type: ignore[no-any-return]
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
+        self.objects[name] = ObjectEntry(
+            self.env.docname, node_id, objtype, aliased
+        )
+
+    def clear_doc(self, docname: str) -> None:
+        for fullname, obj in list(self.objects.items()):
+            if obj.docname == docname:
+                del self.objects[fullname]
+
     def merge_domaindata(
         self, docnames: AbstractSet[str], otherdata: Dict[str, Any]
     ) -> None:
-        pass
+        for fullname, obj in otherdata["objects"].items():
+            if obj.docname in docnames:
+                # Sphinx's own python domain doesn't appear to bother to
+                # check for collisions. Assert they don't happen and
+                # we'll fix it if/when the case arises.
+                assert fullname not in self.objects, (
+                    "bug - collision on merge?"
+                    f" {fullname=} {obj=} {self.objects[fullname]=}"
+                )
+                self.objects[fullname] = obj
 
     def resolve_any_xref(self, *args: Any, **kwargs: Any) -> Any:
         # pylint: disable=unused-argument
-- 
2.48.1


