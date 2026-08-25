Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B397C61DBD
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 22:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyzBp-0007Ag-5V; Tue, 25 Aug 2026 18:00:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBm-0006r9-7O
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:00:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wyzBj-0000jR-Gy
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 18:00:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787695210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SY6InGPHnSfQhAUxV5hYCkzqe8UvhX1o6PvLlw9tMPA=;
 b=bJLb37GED0h8MJd3o6+XFPRGwow45snfL1CAyqvUKuz6VPV3jUqqS7O+lcimkkJ9unOuls
 GSS3Yz8gC14CLWvPUVQssgq+xHWTdhRv+pWRUuIBMlSjlEcZIVKxXMzYj6NYQpRnT/+Ve2
 8qXM68QFuRFPz90uZy/46JtgqlSgNSo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-468-I-TL8sPHNky-3ZWZ-R478g-1; Tue,
 25 Aug 2026 18:00:08 -0400
X-MC-Unique: I-TL8sPHNky-3ZWZ-R478g-1
X-Mimecast-MFC-AGG-ID: I-TL8sPHNky-3ZWZ-R478g_1787695206
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 552DC195FCF7; Tue, 25 Aug 2026 22:00:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.17])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5305519560AB; Tue, 25 Aug 2026 22:00:02 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>, Reinoud Zandijk <reinoud@netbsd.org>,
 Kyle Evans <kevans@freebsd.org>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 16/16] sphinx: drop qapidoc back-compat overboiled
 spaghetti dinner
Date: Tue, 25 Aug 2026 17:58:51 -0400
Message-ID: <20260825215851.1780608-17-jsnow@redhat.com>
In-Reply-To: <20260825215851.1780608-1-jsnow@redhat.com>
References: <20260825215851.1780608-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Drop the disgusting amount of hacks required to keep qapidoc working
on older Sphinx versions, enjoying the cutting edge technology of
2023.

This felt like an achievement to have written, and equally feels an
achievement to have deleted.

A note on the content_node parameter: Sphinx has been gradually
implementing typing support and renaming parameters to be
consistent. As a result of losing our intermediate compatibility shim,
mypy and pylint now check directly against the Sphinx version. So,
alongside removing compat gunk, we need to fix up some parameter
naming for the Sphinx upgrade, too.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/compat.py      | 230 -------------------------------------
 docs/sphinx/qapi_domain.py |  53 +++++----
 2 files changed, 28 insertions(+), 255 deletions(-)
 delete mode 100644 docs/sphinx/compat.py

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
deleted file mode 100644
index 9cf7fe006e4..00000000000
--- a/docs/sphinx/compat.py
+++ /dev/null
@@ -1,230 +0,0 @@
-"""
-Sphinx cross-version compatibility goop
-"""
-
-import re
-from typing import (
-    TYPE_CHECKING,
-    Any,
-    Callable,
-    Optional,
-    Type,
-)
-
-from docutils import nodes
-from docutils.nodes import Element, Node, Text
-from docutils.statemachine import StringList
-
-import sphinx
-from sphinx import addnodes, util
-from sphinx.directives import ObjectDescription
-from sphinx.environment import BuildEnvironment
-from sphinx.roles import XRefRole
-from sphinx.util import docfields
-from sphinx.util.docutils import (
-    ReferenceRole,
-    SphinxDirective,
-    switch_source_input,
-)
-from sphinx.util.typing import TextlikeNode
-
-
-MAKE_XREF_WORKAROUND = sphinx.version_info[:3] < (4, 1, 0)
-
-
-SpaceNode: Callable[[str], Node]
-KeywordNode: Callable[[str, str], Node]
-
-if sphinx.version_info[:3] >= (4, 0, 0):
-    SpaceNode = addnodes.desc_sig_space
-    KeywordNode = addnodes.desc_sig_keyword
-else:
-    SpaceNode = Text
-    KeywordNode = addnodes.desc_annotation
-
-
-def nested_parse_with_titles(
-    directive: SphinxDirective, content_node: Element
-) -> None:
-    """
-    This helper preserves error parsing context across sphinx versions.
-    """
-
-    # necessary so that the child nodes get the right source/line set
-    content_node.document = directive.state.document
-
-    try:
-        # Modern sphinx (6.2.0+) supports proper offsetting for
-        # nested parse error context management
-        util.nodes.nested_parse_with_titles(
-            directive.state,
-            directive.content,
-            content_node,
-            content_offset=directive.content_offset,
-        )
-    except TypeError:
-        # No content_offset argument. Fall back to SSI method.
-        with switch_source_input(directive.state, directive.content):
-            util.nodes.nested_parse_with_titles(
-                directive.state, directive.content, content_node
-            )
-
-
-# ###########################################
-# xref compatibility hacks for Sphinx < 4.1 #
-# ###########################################
-
-# When we require >= Sphinx 4.1, the following function and the
-# subsequent 3 compatibility classes can be removed. Anywhere in
-# qapi_domain that uses one of these Compat* types can be switched to
-# using the garden-variety lib-provided classes with no trickery.
-
-
-def _compat_make_xref(  # pylint: disable=unused-argument
-    self: sphinx.util.docfields.Field,
-    rolename: str,
-    domain: str,
-    target: str,
-    innernode: Type[TextlikeNode] = addnodes.literal_emphasis,
-    contnode: Optional[Node] = None,
-    env: Optional[BuildEnvironment] = None,
-    inliner: Any = None,
-    location: Any = None,
-) -> Node:
-    """
-    Compatibility workaround for Sphinx versions prior to 4.1.0.
-
-    Older sphinx versions do not use the domain's XRefRole for parsing
-    and formatting cross-references, so we need to perform this magick
-    ourselves to avoid needing to write the parser/formatter in two
-    separate places.
-
-    This workaround isn't brick-for-brick compatible with modern Sphinx
-    versions, because we do not have access to the parent directive's
-    state during this parsing like we do in more modern versions.
-
-    It's no worse than what pre-Sphinx 4.1.0 does, so... oh well!
-    """
-
-    # Yes, this function is gross. Pre-4.1 support is a miracle.
-    # pylint: disable=too-many-locals
-
-    assert env
-    # Note: Sphinx's own code ignores the type warning here, too.
-    if not rolename:
-        return contnode or innernode(target, target)  # type: ignore[call-arg]
-
-    # Get the role instance, but don't *execute it* - we lack the
-    # correct state to do so. Instead, we'll just use its public
-    # methods to do our reference formatting, and emulate the rest.
-    role = env.get_domain(domain).roles[rolename]
-    assert isinstance(role, XRefRole)
-
-    # XRefRole features not supported by this compatibility shim;
-    # these were not supported in Sphinx 3.x either, so nothing of
-    # value is really lost.
-    assert not target.startswith("!")
-    assert not re.match(ReferenceRole.explicit_title_re, target)
-    assert not role.lowercase
-    assert not role.fix_parens
-
-    # Code below based mostly on sphinx.roles.XRefRole; run() and
-    # create_xref_node()
-    options = {
-        "refdoc": env.docname,
-        "refdomain": domain,
-        "reftype": rolename,
-        "refexplicit": False,
-        "refwarn": role.warn_dangling,
-    }
-    refnode = role.nodeclass(target, **options)
-    title, target = role.process_link(env, refnode, False, target, target)
-    refnode["reftarget"] = target
-    classes = ["xref", domain, f"{domain}-{rolename}"]
-    refnode += role.innernodeclass(target, title, classes=classes)
-
-    # This is the very gross part of the hack. Normally,
-    # result_nodes takes a document object to which we would pass
-    # self.inliner.document. Prior to Sphinx 4.1, we don't *have* an
-    # inliner to pass, so we have nothing to pass here. However, the
-    # actual implementation of role.result_nodes in this case
-    # doesn't actually use that argument, so this winds up being
-    # ... fine. Rest easy at night knowing this code only runs under
-    # old versions of Sphinx, so at least it won't change in the
-    # future on us and lead to surprising new failures.
-    # Gross, I know.
-    result_nodes, _messages = role.result_nodes(
-        None,  # type: ignore
-        env,
-        refnode,
-        is_ref=True,
-    )
-    return nodes.inline(target, "", *result_nodes)
-
-
-class CompatField(docfields.Field):
-    if MAKE_XREF_WORKAROUND:
-        make_xref = _compat_make_xref
-
-
-class CompatGroupedField(docfields.GroupedField):
-    if MAKE_XREF_WORKAROUND:
-        make_xref = _compat_make_xref
-
-
-class CompatTypedField(docfields.TypedField):
-    if MAKE_XREF_WORKAROUND:
-        make_xref = _compat_make_xref
-
-
-# ################################################################
-# Nested parsing error location fix for Sphinx 5.3.0 < x < 6.2.0 #
-# ################################################################
-
-# When we require Sphinx 4.x, the TYPE_CHECKING hack where we avoid
-# subscripting ObjectDescription at runtime can be removed in favor of
-# just always subscripting the class.
-
-# When we require Sphinx > 6.2.0, the rest of this compatibility hack
-# can be dropped and QAPIObject can just inherit directly from
-# ObjectDescription[Signature].
-
-SOURCE_LOCATION_FIX = (5, 3, 0) <= sphinx.version_info[:3] < (6, 2, 0)
-
-Signature = str
-
-
-if TYPE_CHECKING:
-    _BaseClass = ObjectDescription[Signature]
-else:
-    _BaseClass = ObjectDescription
-
-
-class ParserFix(_BaseClass):
-
-    _temp_content: StringList
-    _temp_offset: int
-    _temp_node: Optional[addnodes.desc_content]
-
-    def before_content(self) -> None:
-        # Work around a sphinx bug and parse the content ourselves.
-        self._temp_content = self.content
-        self._temp_offset = self.content_offset
-        self._temp_node = None
-
-        if SOURCE_LOCATION_FIX:
-            self._temp_node = addnodes.desc_content()
-            self.state.nested_parse(
-                self.content, self.content_offset, self._temp_node
-            )
-            # Sphinx will try to parse the content block itself,
-            # Give it nothingness to parse instead.
-            self.content = StringList()
-            self.content_offset = 0
-
-    def transform_content(self, content_node: addnodes.desc_content) -> None:
-        # Sphinx workaround: Inject our parsed content and restore state.
-        if self._temp_node:
-            content_node += self._temp_node.children
-            self.content = self._temp_content
-            self.content_offset = self._temp_offset
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index f561dc465f8..159857113a4 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -30,20 +30,10 @@
 )
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
-from sphinx.util import logging
+from sphinx.util import docfields, logging
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
 
-from compat import (
-    CompatField,
-    CompatGroupedField,
-    CompatTypedField,
-    KeywordNode,
-    ParserFix,
-    Signature,
-    SpaceNode,
-)
-
 
 if TYPE_CHECKING:
     from typing import (
@@ -157,7 +147,10 @@ def result_nodes(
         return results, []
 
 
-class QAPIDescription(ParserFix):
+Signature = str
+
+
+class QAPIDescription(ObjectDescription[Signature]):
     """
     Generic QAPI description.
 
@@ -315,7 +308,7 @@ class QAPIObject(QAPIDescription):
 
     doc_field_types = [
         # :feat name: descr
-        CompatGroupedField(
+        docfields.GroupedField(
             "feature",
             label=_("Features"),
             names=("feat",),
@@ -327,8 +320,8 @@ def get_signature_prefix(self) -> List[nodes.Node]:
         """Return a prefix to put before the object name in the signature."""
         assert self.objtype
         return [
-            KeywordNode("", self.objtype.title()),
-            SpaceNode(" "),
+            addnodes.desc_sig_keyword("", self.objtype.title()),
+            addnodes.desc_sig_space(" "),
         ]
 
     def get_signature_suffix(self) -> List[nodes.Node]:
@@ -337,7 +330,7 @@ def get_signature_suffix(self) -> List[nodes.Node]:
 
         if "since" in self.options:
             ret += [
-                SpaceNode(" "),
+                addnodes.desc_sig_space(" "),
                 addnodes.desc_sig_element(
                     "", f"(Since: {self.options['since']})"
                 ),
@@ -376,7 +369,7 @@ def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
 
         return sig
 
-    def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
+    def _add_infopips(self, content_node: addnodes.desc_content) -> None:
         # Add various eye-catches and things that go below the signature
         # bar, but precede the user-defined content.
         infopips = nodes.container()
@@ -420,7 +413,7 @@ def _add_pip(
             )
 
         if infopips.children:
-            contentnode.insert(0, infopips)
+            content_node.insert(0, infopips)
 
     def _validate_field(self, field: nodes.field) -> None:
         """Validate field lists in this QAPI Object Description."""
@@ -470,7 +463,17 @@ def _validate_field(self, field: nodes.field) -> None:
             )
             logger.warning(msg, location=field)
 
-    def transform_content(self, content_node: addnodes.desc_content) -> None:
+    def transform_content(
+        self,
+        # Sphinx changed the name of the content_node parameter
+        # sometime after Sphinx 7.2.6, so no matter which name we
+        # choose, either our minimum tests or our bleeding edge tests
+        # will complain about the parameter rename. Use the eventual
+        # name and silence the error for our minreq tests.
+        #
+        # pylint: disable=arguments-renamed
+        content_node: addnodes.desc_content
+    ) -> None:
         # This hook runs after before_content and the nested parse, but
         # before the DocFieldTransformer is executed.
         super().transform_content(content_node)
@@ -485,7 +488,7 @@ def transform_content(self, content_node: addnodes.desc_content) -> None:
                     self._validate_field(field)
 
 
-class SpecialTypedField(CompatTypedField):
+class SpecialTypedField(docfields.TypedField):
     def make_field(self, *args: Any, **kwargs: Any) -> nodes.field:
         ret = super().make_field(*args, **kwargs)
 
@@ -518,14 +521,14 @@ class QAPICommand(QAPIObject):
                 can_collapse=False,
             ),
             # :error: descr
-            CompatField(
+            docfields.Field(
                 "error",
                 label=_("Errors"),
                 names=("error", "errors"),
                 has_arg=False,
             ),
             # :return TypeName: descr
-            CompatGroupedField(
+            docfields.GroupedField(
                 "returnvalue",
                 label=_("Return"),
                 rolename="type",
@@ -533,7 +536,7 @@ class QAPICommand(QAPIObject):
                 can_collapse=True,
             ),
             # :return-nodesc: TypeName
-            CompatField(
+            docfields.Field(
                 "returnvalue",
                 label=_("Return"),
                 names=("return-nodesc",),
@@ -551,7 +554,7 @@ class QAPIEnum(QAPIObject):
     doc_field_types.extend(
         [
             # :value name: descr
-            CompatGroupedField(
+            docfields.GroupedField(
                 "value",
                 label=_("Values"),
                 names=("value",),
@@ -568,7 +571,7 @@ class QAPIAlternate(QAPIObject):
     doc_field_types.extend(
         [
             # :alt type name: descr
-            CompatTypedField(
+            docfields.TypedField(
                 "alternative",
                 label=_("Alternatives"),
                 names=("alt",),
-- 
2.55.0


