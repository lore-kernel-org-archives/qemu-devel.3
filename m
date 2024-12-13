Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 548D6E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:19:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuFs-0005a8-K3; Thu, 12 Dec 2024 20:14:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFo-0005YZ-DB
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFj-0000Kv-23
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PI658TGxm2lg3c756jMgWMre84BQOwaV4cMaqomDZpo=;
 b=JZqbn/U1bumKHcgv2URaqDQWjora60x5a3pm9h1II63dCFDUoQUDBW9tRk7SEd0s5yT0Jn
 0QVWfQZ40+DSDPh5w2EZBUWLTLaagRA679+2jtqFfmPMWGRo/jtf9Cl28rwsix1KLPUDRH
 uySFhodBmUpOFszMIB5DgklDSNEJoZk=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-062IK_IyPTaUv3tyLatcrg-1; Thu,
 12 Dec 2024 20:13:54 -0500
X-MC-Unique: 062IK_IyPTaUv3tyLatcrg-1
X-Mimecast-MFC-AGG-ID: 062IK_IyPTaUv3tyLatcrg
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DAF219560B3; Fri, 13 Dec 2024 01:13:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 551C71956086; Fri, 13 Dec 2024 01:13:51 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 08/35] docs/qapi-domain: add resolve_any_xref()
Date: Thu, 12 Dec 2024 20:12:37 -0500
Message-ID: <20241213011307.2942030-9-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
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

Add the ability to resolve cross-references using the `any`
cross-reference syntax. Adding QAPI-specific cross-reference roles will
be added in a forthcoming commit, and will share the same find_obj()
helper.

(There's less code needed for the generic cross-reference resolver, so
it comes first in this series.)

Once again, this code is based very heavily on sphinx.domains.python.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 94 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 93 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index a83041a0aac..4928fed3ed9 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -22,6 +22,7 @@
 
 from compat import nested_parse
 from sphinx import addnodes
+from sphinx.addnodes import pending_xref
 from sphinx.domains import (
     Domain,
     Index,
@@ -31,13 +32,15 @@
 from sphinx.locale import _, __
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective
-from sphinx.util.nodes import make_id
+from sphinx.util.nodes import make_id, make_refnode
 
 
 if TYPE_CHECKING:
     from docutils.nodes import Element, Node
 
     from sphinx.application import Sphinx
+    from sphinx.builders import Builder
+    from sphinx.environment import BuildEnvironment
     from sphinx.util.typing import OptionSpec
 
 logger = logging.getLogger(__name__)
@@ -282,6 +285,95 @@ def merge_domaindata(
                 )
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
+        elif (
+            fullname in self.objects
+            and self.objects[fullname].objtype in objtypes
+        ):
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
2.47.0


