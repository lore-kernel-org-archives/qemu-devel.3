Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FBE9E7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:19:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGr-0008FA-WB; Thu, 12 Dec 2024 20:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGp-00084G-Oe
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGn-0000tm-Lc
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fy89eOED+38llVWEs5a83zYeHZIY4d1VHdhXz1LxBdg=;
 b=f8wp/2cleRYHDEyXcrtqzOEWRj6kKy7fVwgb/ESe4C1Cv7gOynlRLqgVAAzgoqaUg0QHRo
 lAPLpFWO9qv6rT780nWeBMP05AyF63v/yeM6znHCqPiza154qahPqhinv7ihswyMrMKRcw
 7vrB4H8IJGlA8dALZQwV2FAWyf4WqlI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-416-t2WJGzZiN7KetpN03f2UgQ-1; Thu,
 12 Dec 2024 20:14:58 -0500
X-MC-Unique: t2WJGzZiN7KetpN03f2UgQ-1
X-Mimecast-MFC-AGG-ID: t2WJGzZiN7KetpN03f2UgQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ADA2B19560B8; Fri, 13 Dec 2024 01:14:56 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6F58F1956089; Fri, 13 Dec 2024 01:14:53 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 27/35] docs/qapi-domain: add type cross-refs to field
 lists
Date: Thu, 12 Dec 2024 20:12:56 -0500
Message-ID: <20241213011307.2942030-28-jsnow@redhat.com>
In-Reply-To: <20241213011307.2942030-1-jsnow@redhat.com>
References: <20241213011307.2942030-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

This commit, finally, adds cross-referencing support to various field
lists; modeled tightly after Sphinx's own Python domain code.

Cross-referencing support is added to type names provided to :arg:,
:memb:, :returns: and :choice:.

:feat:, :error: and :value:, which do not take type names, do not
support this syntax.

The general syntax is simple:

:arg TypeName ArgName: Lorem Ipsum ...

The domain will transform TypeName into :qapi:type:`TypeName` in this
basic case, and also apply the ``literal`` decoration to indicate that
this is a type cross-reference.

For optional arguments, the special "?" suffix is used. Because "*" has
special meaning in ReST that would cause parsing errors, we elect to use
"?" instead. The special syntax processing in QAPIXrefMixin strips this
character from the end of any type name argument and will append ",
optional" to the rendered output, applying the cross-reference only to
the actual type name.

The intent here is that the actual syntax in doc-blocks need not change;
but e.g. qapidoc.py will need to process and transform "@arg foo lorem
ipsum" into ":arg type? foo: lorem ipsum" based on the schema
information. Therefore, nobody should ever actually witness this
intermediate syntax unless they are writing manual documentation or the
doc transmogrifier breaks.

For array arguments, type names can similarly be surrounded by "[]",
which are stripped off and then re-appended outside of the
cross-reference.

Note: The mixin pattern here (borrowed from Sphinx) confuses mypy
because it cannot tell that it will be mixed into a descendent of
Field. Doing that instead causes more errors, because many versions of
Sphinx erroneously did not mark various arguments as Optional, so we're
a bit hosed either way. Do the simpler thing.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 136 +++++++++++++++++++++++++++++++++++--
 1 file changed, 129 insertions(+), 7 deletions(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index ba1e52a1f77..907ba6d27d3 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -47,11 +47,12 @@
 
 if TYPE_CHECKING:
     from docutils.nodes import Element, Node
+    from docutils.parsers.rst.states import Inliner
 
     from sphinx.application import Sphinx
     from sphinx.builders import Builder
     from sphinx.environment import BuildEnvironment
-    from sphinx.util.typing import OptionSpec
+    from sphinx.util.typing import OptionSpec, TextlikeNode
 
 logger = logging.getLogger(__name__)
 
@@ -78,6 +79,110 @@ class ObjectEntry(NamedTuple):
     aliased: bool
 
 
+class QAPIXrefMixin:
+    def make_xref(
+        self,
+        rolename: str,
+        domain: str,
+        target: str,
+        innernode: type[TextlikeNode] = nodes.literal,
+        contnode: Optional[Node] = None,
+        env: Optional[BuildEnvironment] = None,
+        inliner: Optional[Inliner] = None,
+        location: Optional[Node] = None,
+    ) -> Node:
+        # make_xref apparently has a mode of operation where the inliner
+        # class argument is passed to the role object
+        # (e.g. QAPIXRefRole) to construct the final result; passing
+        # inliner = location = None forces it into its legacy mode where
+        # it returns a pending_xref node instead.
+        # (This is how the built-in Python domain behaves.)
+        result = super().make_xref(  # type: ignore[misc]
+            rolename,
+            domain,
+            target,
+            innernode=innernode,
+            contnode=contnode,
+            env=env,
+            inliner=None,
+            location=None,
+        )
+        if isinstance(result, pending_xref):
+            assert env is not None
+            # Add domain-specific context information to the pending reference.
+            result["refspecific"] = True
+            result["qapi:module"] = env.ref_context.get("qapi:module")
+
+        assert isinstance(result, nodes.Node)
+        return result
+
+    def make_xrefs(
+        self,
+        rolename: str,
+        domain: str,
+        target: str,
+        innernode: type[TextlikeNode] = nodes.literal,
+        contnode: Optional[Node] = None,
+        env: Optional[BuildEnvironment] = None,
+        inliner: Optional[Inliner] = None,
+        location: Optional[Node] = None,
+    ) -> list[Node]:
+        # Note: this function is called on up to three fields of text:
+        # (1) The field name argument (e.g. member/arg name)
+        # (2) The field name type (e.g. member/arg type)
+        # (3) The field *body* text, for Fields that do not take arguments.
+
+        list_type = False
+        optional = False
+
+        # If the rolename is qapi:type, we know we are processing a type
+        # and not an arg/memb name or field body text.
+        if rolename == "type":
+            # force the innernode class to be a literal.
+            innernode = nodes.literal
+
+            # Type names that end with "?" are considered Optional
+            # arguments and should be documented as such, but it's not
+            # part of the xref itself.
+            if target.endswith("?"):
+                optional = True
+                target = target[:-1]
+
+            # Type names wrapped in brackets denote lists. strip the
+            # brackets and remember to add them back later.
+            if target.startswith("[") and target.endswith("]"):
+                list_type = True
+                target = target[1:-1]
+
+            # When processing Fields with bodyrolename="type", contnode
+            # will be present, which indicates that the body has already
+            # been parsed into nodes.  We don't want that, actually:
+            # we'll re-create our own nodes for it.
+            contnode = None
+
+        results = []
+        result = self.make_xref(
+            rolename,
+            domain,
+            target,
+            innernode,
+            contnode,
+            env,
+            inliner,
+            location,
+        )
+        results.append(result)
+
+        if list_type:
+            results.insert(0, nodes.literal("[", "["))
+            results.append(nodes.literal("]", "]"))
+        if optional:
+            results.append(nodes.Text(", "))
+            results.append(nodes.emphasis("?", "optional"))
+
+        return results
+
+
 class QAPIXRefRole(XRefRole):
     def process_link(
         self,
@@ -106,6 +211,18 @@ def process_link(
         return title, target
 
 
+class QAPIGroupedField(QAPIXrefMixin, GroupedField):
+    pass
+
+
+class QAPITypedField(QAPIXrefMixin, TypedField):
+    pass
+
+
+class QAPIField(QAPIXrefMixin, Field):
+    pass
+
+
 def since_validator(param: str) -> str:
     """
     Validate the `:since: X.Y` option field.
@@ -432,10 +549,11 @@ class QAPICommand(QAPIObject):
     doc_field_types.extend(
         [
             # :arg TypeName ArgName: descr
-            TypedField(
+            QAPITypedField(
                 "argument",
                 label=_("Arguments"),
                 names=("arg",),
+                typerolename="type",
                 can_collapse=False,
             ),
             # :error: descr
@@ -446,14 +564,15 @@ class QAPICommand(QAPIObject):
                 has_arg=False,
             ),
             # :returns TypeName: descr
-            GroupedField(
+            QAPIGroupedField(
                 "returnvalue",
                 label=_("Returns"),
+                rolename="type",
                 names=("return", "returns"),
                 can_collapse=True,
             ),
             # :returns-nodesc: TypeName
-            Field(
+            QAPIField(
                 "returnvalue",
                 label=_("Returns"),
                 names=("returns-nodesc",),
@@ -488,10 +607,11 @@ class QAPIAlternate(QAPIObject):
     doc_field_types.extend(
         [
             # :choice type name: descr
-            TypedField(
+            QAPITypedField(
                 "choice",
                 label=_("Choices"),
                 names=("choice",),
+                typerolename="type",
                 can_collapse=False,
             ),
         ]
@@ -505,10 +625,11 @@ class QAPIObjectWithMembers(QAPIObject):
     doc_field_types.extend(
         [
             # :member type name: descr
-            TypedField(
+            QAPITypedField(
                 "member",
                 label=_("Members"),
                 names=("memb",),
+                typerolename="type",
                 can_collapse=False,
             ),
         ]
@@ -660,12 +781,13 @@ def run(self) -> list[Node]:
         self.doc_field_types = [
             # :arg type name: descr
             # :memb type name: descr
-            TypedField(
+            QAPITypedField(
                 "branch-arg-or-memb",
                 label=f"[{discrim} = {value}]",
                 # In a branch, we don't actually use the name of the
                 # field name to generate the label; so allow either-or.
                 names=("arg", "memb"),
+                typerolename="type",
             ),
         ]
 
-- 
2.47.0


