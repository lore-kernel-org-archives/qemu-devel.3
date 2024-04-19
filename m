Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 049C5C4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:40:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1C-0007SC-K4; Fri, 19 Apr 2024 00:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1A-0007PB-Df
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg17-00049u-SI
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eGh0Yo04442PQ/AzZ8ROlY8swRWkIkztCTSNUHGcCT0=;
 b=NtJCURMQ367FQplZwNy6/nOI+KMRkmIyKr1mMxTGGtP5v1RwkEeYYhBV8l2u0GmY1bJX34
 2N4YiR9zR8Kst/NE88T82MsBlU9silipDZVI+go175QFZNZ546tbgyoiZPp54CeEoHFKhU
 l2HEGTtA9TrfYIxlWJVxx4OR1bCDzq8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-nQvZ5gL6MMeY3PtFUAa08Q-1; Fri,
 19 Apr 2024 00:38:25 -0400
X-MC-Unique: nQvZ5gL6MMeY3PtFUAa08Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5C4251C0C66A;
 Fri, 19 Apr 2024 04:38:25 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A81EC40829C3;
 Fri, 19 Apr 2024 04:38:24 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 05/27] docs/qapi-domain: add resolve_any_xref()
Date: Fri, 19 Apr 2024 00:37:53 -0400
Message-ID: <20240419043820.178731-6-jsnow@redhat.com>
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

Add the ability to resolve cross-references using the `any`
cross-reference syntax. Adding QAPI-specific cross-reference roles will
be added in a forthcoming commit, and will share the same find_obj()
helper.

(There's less code needed for the generic cross-reference resolver, so
it comes first in this series.)

Once again, this code is based very heavily on sphinx.domains.python.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/qapi/index.rst        |  7 +++
 docs/sphinx/qapi-domain.py | 95 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 1 deletion(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 051dc6b3a37..39ad405fd93 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -40,3 +40,10 @@ QAPI Domain Test
 
    Modules will also be reported in the `qapi-index`, under the Modules
    category and in the alphabetical categories that follow.
+
+
+QAPI modules can now be cross-referenced using the ```any```
+cross-referencing syntax. Here's a link to `bar-module`, even though
+the actual output of that directive was suppressed. Here's a link to
+`block-core`. A link to ```foo-module``` won't resolve because of the
+``:no-index:`` option we used for that directive.
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 65409786119..4758451ff0e 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -21,6 +21,7 @@
 from docutils.parsers.rst import directives
 
 from sphinx import addnodes
+from sphinx.addnodes import pending_xref
 from sphinx.domains import (
     Domain,
     Index,
@@ -30,13 +31,19 @@
 from sphinx.locale import _, __
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective, switch_source_input
-from sphinx.util.nodes import make_id, nested_parse_with_titles
+from sphinx.util.nodes import (
+    make_id,
+    make_refnode,
+    nested_parse_with_titles,
+)
 
 
 if TYPE_CHECKING:
     from docutils.nodes import Element, Node
 
     from sphinx.application import Sphinx
+    from sphinx.builders import Builder
+    from sphinx.environment import BuildEnvironment
     from sphinx.util.typing import OptionSpec
 
 logger = logging.getLogger(__name__)
@@ -289,6 +296,92 @@ def merge_domaindata(self, docnames: List[str], otherdata: Dict[str, Any]) -> No
                 ), f"!?!? collision on merge? {fullname=} {obj=} {self.objects[fullname]=}"
                 self.objects[fullname] = obj
 
+    def find_obj(
+        self, modname: str, name: str, type: Optional[str]
+    ) -> list[tuple[str, ObjectEntry]]:
+        """
+        Find a QAPI object for "name", perhaps using the given module.
+
+        Returns a list of (name, object entry) tuples.
+
+        :param modname: The current module context (if any!)
+                        under which we are searching.
+        :param name: The name of the x-ref to resolve;
+                     may or may not include a leading module.
+        :param type: The role name of the x-ref we're resolving, if provided.
+                     (This is absent for "any" lookups.)
+        """
+        if not name:
+            return []
+
+        names: list[str] = []
+        matches: list[tuple[str, ObjectEntry]] = []
+
+        fullname = name
+        if "." in fullname:
+            # We're searching for a fully qualified reference;
+            # ignore the contextual module.
+            pass
+        elif modname:
+            # We're searching for something from somewhere;
+            # try searching the current module first.
+            # e.g. :qapi:cmd:`query-block` or `query-block` is being searched.
+            fullname = f"{modname}.{name}"
+
+        if type is None:
+            # type isn't specified, this is a generic xref.
+            # search *all* qapi-specific object types.
+            objtypes: Optional[List[str]] = list(self.object_types)
+        else:
+            # type is specified and will be a role (e.g. obj, mod, cmd)
+            # convert this to eligible object types (e.g. command, module)
+            # using the QAPIDomain.object_types table.
+            objtypes = self.objtypes_for_role(type)
+
+        # Either we should have been given no type, or the type we were
+        # given should correspond to at least one real actual object
+        # type.
+        assert objtypes
+
+        if name in self.objects and self.objects[name].objtype in objtypes:
+            names = [name]
+        elif fullname in self.objects and self.objects[fullname].objtype in objtypes:
+            names = [fullname]
+        else:
+            # exact match wasn't found; e.g. we are searching for
+            # `query-block` from a different (or no) module.
+            searchname = "." + name
+            names = [
+                oname
+                for oname in self.objects
+                if oname.endswith(searchname)
+                and self.objects[oname].objtype in objtypes
+            ]
+
+        matches = [(oname, self.objects[oname]) for oname in names]
+        if len(matches) > 1:
+            matches = [m for m in matches if not m[1].aliased]
+        return matches
+
+    def resolve_any_xref(
+        self,
+        env: BuildEnvironment,
+        fromdocname: str,
+        builder: Builder,
+        target: str,
+        node: pending_xref,
+        contnode: Element,
+    ) -> list[tuple[str, Element]]:
+        results: list[tuple[str, Element]] = []
+        matches = self.find_obj(node.get("qapi:module"), target, None)
+        for name, obj in matches:
+            role = "qapi:" + self.role_for_objtype(obj.objtype)
+            refnode = make_refnode(
+                builder, fromdocname, obj.docname, obj.node_id, contnode, name
+            )
+            results.append((role, refnode))
+        return results
+
 
 def setup(app: Sphinx) -> Dict[str, Any]:
     app.setup_extension("sphinx.directives")
-- 
2.44.0


