Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2182C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:46:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqWv-0003qX-DJ; Mon, 10 Mar 2025 23:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWu-0003qA-JM
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqWs-0002CI-S8
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ttKw/vVjjacoXax5pLcJcspfJaVo5c4RH7gYOoGWA8=;
 b=KcpYOeq2wrrw/cAtrVGb5mdFX6IjIsrmfAsRQP03T8s+L/slLzdqGAh+Ic2tQpXQ+mxt6p
 UbdF3Av35I/GggIXv6oRz3Xe9L3WyTFk4VnuS+9VWcbCwIE9NUBavEt8kZeBYtkLiwLYJ4
 E0ktJoF/rKfniX6AlWWkihH4OZttFmI=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-465-6hbp0yrLPOaFDQ1s0RLDQQ-1; Mon,
 10 Mar 2025 23:43:37 -0400
X-MC-Unique: 6hbp0yrLPOaFDQ1s0RLDQQ-1
X-Mimecast-MFC-AGG-ID: 6hbp0yrLPOaFDQ1s0RLDQQ_1741664616
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4B552180034D; Tue, 11 Mar 2025 03:43:36 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EE74B1828A89; Tue, 11 Mar 2025 03:43:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 07/63] docs/qapi-domain: add resolve_any_xref()
Date: Mon, 10 Mar 2025 23:42:05 -0400
Message-ID: <20250311034303.75779-8-jsnow@redhat.com>
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

Add the ability to resolve cross-references using the `any`
cross-reference syntax. Adding QAPI-specific cross-reference roles will
be added in a forthcoming commit, and will share the same find_obj()
helper.

(There's less code needed for the generic cross-reference resolver, so
it comes first in this series.)

Once again, this code is based very heavily on sphinx.domains.python.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi_domain.py | 96 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 93 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 3e7718d32d1..f05c2cadf06 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -16,6 +16,9 @@
     Tuple,
 )
 
+from docutils import nodes
+
+from sphinx.addnodes import pending_xref
 from sphinx.domains import (
     Domain,
     Index,
@@ -24,10 +27,15 @@
 )
 from sphinx.locale import _, __
 from sphinx.util import logging
+from sphinx.util.nodes import make_refnode
 
 
 if TYPE_CHECKING:
+    from docutils.nodes import Element
+
     from sphinx.application import Sphinx
+    from sphinx.builders import Builder
+    from sphinx.environment import BuildEnvironment
 
 logger = logging.getLogger(__name__)
 
@@ -179,9 +187,91 @@ def merge_domaindata(
                 )
                 self.objects[fullname] = obj
 
-    def resolve_any_xref(self, *args: Any, **kwargs: Any) -> Any:
-        # pylint: disable=unused-argument
-        return []
+    def find_obj(
+        self, modname: str, name: str, typ: Optional[str]
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
+        if typ is None:
+            # type isn't specified, this is a generic xref.
+            # search *all* qapi-specific object types.
+            objtypes: List[str] = list(self.object_types)
+        else:
+            # type is specified and will be a role (e.g. obj, mod, cmd)
+            # convert this to eligible object types (e.g. command, module)
+            # using the QAPIDomain.object_types table.
+            objtypes = self.objtypes_for_role(typ, [])
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
+    ) -> List[Tuple[str, nodes.reference]]:
+        results: List[Tuple[str, nodes.reference]] = []
+        matches = self.find_obj(node.get("qapi:module"), target, None)
+        for name, obj in matches:
+            rolename = self.role_for_objtype(obj.objtype)
+            assert rolename is not None
+            role = f"qapi:{rolename}"
+            refnode = make_refnode(
+                builder, fromdocname, obj.docname, obj.node_id, contnode, name
+            )
+            results.append((role, refnode))
+        return results
 
 
 def setup(app: Sphinx) -> Dict[str, Any]:
-- 
2.48.1


