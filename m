Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59950E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuFq-0005Yq-1b; Thu, 12 Dec 2024 20:14:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFo-0005YY-Co
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuFj-0000Kx-7k
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQZ3m4r2y82cucY6Yi19vRrWkOCJ1oqcIjA0Q4VavPg=;
 b=i2uHucasbVl1ioy642tL8rpZ1nB3DjRTPiinHfULmL+tGI7LvaA8mT3SruT7LY+L7CTLoT
 meQ/mO8nXkHWjs/12neU5saGOkgL23xgiUiC0NE1/VxjwbPTDhDMNyrMllAINUxAQjkN54
 e9AwcL3HRqc/1b9pZG7KPwwV1axSyYg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-569-3-4-JDDrNB2nxfbkKYVXiA-1; Thu,
 12 Dec 2024 20:13:56 -0500
X-MC-Unique: 3-4-JDDrNB2nxfbkKYVXiA-1
X-Mimecast-MFC-AGG-ID: 3-4-JDDrNB2nxfbkKYVXiA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5247E19560AB; Fri, 13 Dec 2024 01:13:55 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6FD881956086; Fri, 13 Dec 2024 01:13:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 09/35] docs/qapi-domain: add QAPI xref roles
Date: Thu, 12 Dec 2024 20:12:38 -0500
Message-ID: <20241213011307.2942030-10-jsnow@redhat.com>
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

Add domain-specific cross-reference syntax. As of this commit, that
means new :qapi:mod:`block-core` and :qapi:obj:`block-core` referencing
syntax.

:mod: will only find modules, but :obj: will find anything registered to
the QAPI domain. (In forthcoming commits, this means commands, events,
enums, etc.)

Creating the cross-references is powered by the QAPIXRefRole class;
resolving them is handled by QAPIDomain.resolve_xref().

QAPIXrefRole is copied almost verbatim from Sphinx's own
PyXrefRole. PyXrefRole (and QAPIXrefRole) adds two features over the
base class:

(1) Creating a cross-reference with e.g. :py:class:`~class.name`
instructs sphinx to omit the fully qualified parts of the resolved name
from the actual link text. This may be useful in the future if we add
namespaces to QAPI documentation, e.g. :qapi:cmd:`~qsd.blockdev-backup`
could link to the QSD-specific documentation for blockdev-backup while
omitting that prefix from the link text.

(2) Prefixing the link target with a "." changes the search behavior to
prefer locally-scoped items first.

I think both of these are worth keeping to help manage future namespace
issues between QEMU, QSD and QGA; but it's possible it's extraneous. It
may possibly be worth keeping just to keep feature parity with Sphinx's
other domains; e.g. "principle of least surprise". Dunno.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 67 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index 4928fed3ed9..e4f822bbcbd 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -30,6 +30,7 @@
     ObjType,
 )
 from sphinx.locale import _, __
+from sphinx.roles import XRefRole
 from sphinx.util import logging
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
@@ -53,6 +54,34 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
+class QAPIXRefRole(XRefRole):
+    def process_link(
+        self,
+        env: BuildEnvironment,
+        refnode: Element,
+        has_explicit_title: bool,
+        title: str,
+        target: str,
+    ) -> tuple[str, str]:
+        refnode["qapi:module"] = env.ref_context.get("qapi:module")
+        if not has_explicit_title:
+            title = title.lstrip(".")  # only has a meaning for the target
+            target = target.lstrip("~")  # only has a meaning for the title
+            # if the first character is a tilde, don't display the module
+            # parts of the contents
+            if title[0:1] == "~":
+                title = title[1:]
+                dot = title.rfind(".")
+                if dot != -1:
+                    title = title[dot + 1 :]
+        # if the first character is a dot, search more specific namespaces first
+        # else search builtins first
+        if target[0:1] == ".":
+            target = target[1:]
+            refnode["refspecific"] = True
+        return title, target
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -216,7 +245,13 @@ class QAPIDomain(Domain):
         "module": QAPIModule,
     }
 
-    roles = {}
+    # These are all cross-reference roles; e.g.
+    # :qapi:cmd:`query-block`. The keys correlate to the names used in
+    # the object_types table values above.
+    roles = {
+        "mod": QAPIXRefRole(),
+        "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
+    }
 
     # Moved into the data property at runtime;
     # this is the internal index of reference-able objects.
@@ -355,6 +390,36 @@ def find_obj(
             matches = [m for m in matches if not m[1].aliased]
         return matches
 
+    def resolve_xref(
+        self,
+        env: BuildEnvironment,
+        fromdocname: str,
+        builder: Builder,
+        type: str,
+        target: str,
+        node: pending_xref,
+        contnode: Element,
+    ) -> Element | None:
+        modname = node.get("qapi:module")
+        matches = self.find_obj(modname, target, type)
+        multiple_matches = len(matches) > 1
+
+        if not matches:
+            return None
+        elif multiple_matches:
+            logger.warning(
+                __("more than one target found for cross-reference %r: %s"),
+                target,
+                ", ".join(match[0] for match in matches),
+                type="ref",
+                subtype="qapi",
+                location=node,
+            )
+        name, obj = matches[0]
+        return make_refnode(
+            builder, fromdocname, obj.docname, obj.node_id, contnode, name
+        )
+
     def resolve_any_xref(
         self,
         env: BuildEnvironment,
-- 
2.47.0


