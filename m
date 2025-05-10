Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3296CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 06:18:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDdWN-0002dy-Bm; Sat, 10 May 2025 02:17:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWK-0002Td-6M
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:12 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uDdWH-0007pS-In
 for qemu-devel@nongnu.org; Sat, 10 May 2025 02:17:11 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-b03bc416962so1817200a12.0
 for <qemu-devel@nongnu.org>; Fri, 09 May 2025 23:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1746857828; x=1747462628;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m7mnp6lNSyXTIoW/v3nWPrXMjMc+XgNrnacWKtypI7A=;
 b=MXBqHVXFoqNSxqTQGSzZkDlXFCFWMpQ69qpuZSkDpSBgV3xv0LoAk4O5eISgQX/UFx
 SQ9VkNc99VbKwtYQZaIlgBpKuOulxBOv3RSmT9dz9QVS6jrN82lPW/QP8pr/NZ79D5w/
 oHmMWVUH9pDbmlZodA+cMa/Gx48mkoJSeLo0disEz01pim7pHTufiahSUunCVA2F2aXu
 RJzyG0xBTdwT0hkpehI1z7hzF1XSUDWyWqQBbjnhu5bkSOl2zmfijKbxo4ungK6pilc/
 RQ3vawCq2HEx6KEHtzyWBEN5OYWEIp3PASwhBhG3SkYNWX90nYCJVyT1wtWKrcR2WQvw
 uqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746857828; x=1747462628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m7mnp6lNSyXTIoW/v3nWPrXMjMc+XgNrnacWKtypI7A=;
 b=gZZzQrD2T8BcLrC2Ul5weV65fMMjANMMYtAtSkwNLXG8omt1mHWh17BmsgcNqlw1Pm
 4T6Gdx0TdlCx7w+LkboLOT097eN2jp74xIEgQuGd0jNyVvQuFM8RI92oJXgeJRp6Mqso
 ZGt6nbW3BvGdUW6gvppvrmsGGCMx0W4CUKWKl/C9h/wqKmjVuH8YlexZOmS1rqQ164nu
 Qe2fu8QtqJ0bv4v8JV9AaIe0MQIq6n8/Y8xhSBkgHXvRY7Hz/Qz0otMyOPfAJtOsJ+Vo
 4nvgbKqidJBziDiF6wHeMb02493/7j/IJEHnmcM/wJET/TM5Lq764694VBvY/AdjJxyU
 XAhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlfosqbkVMcZLvCbH6oYx3gMJDlHXSEBNMBW3Ox3ZHbZXNRqjX99eyFJqLDaoP3N7cJPtZ5B5h56Vc@nongnu.org
X-Gm-Message-State: AOJu0YyfXq63UkN0Qj5ORaPfmkgEprJFZtqKaCsgBqJ3QiucZy1aduHb
 KTF5tdmhlh52exKOT21/m4jRKOM2MSTEjM9cLrfJj8eCq+cP4KPSZ/ULen28FlA=
X-Gm-Gg: ASbGncuuz7iVcWtVbthpXOJKXLfuOYQQdImcYy7N3xPN5mWtujoTwmOMIm46lgwNR1N
 ay8PFTDFdlZwxbgRPrgWrlsc+eAZjxzl5m2qbbOI3Bgvwfh+igac0rQRGZRC0UYrB0mHywfvZNk
 JkDxnGXvPQXbfGBOEDBArRXFRf1O0wWAs62c7dtzLPjmzdFSCPBWREkuGvkf1IDFxRQMJc6c+Gg
 BKzZn4xfxuvOlE0kZ7u8binB5DzHHdFrZdHqttmKkZ83aPDh2wLCX3QW3/H3bSzYF9BYwdcRtws
 Rkohdv9EVIqKHkdzS/eWzj3LSiFnjCk7O0wWlNmn2CKEK0xBjR9Z
X-Google-Smtp-Source: AGHT+IEjF28fhEeKFt5eqVCtIbUvJtFYltO8Pn6lhEkL1/CX0sPo+43ubPEqNJZuXhwHjmdkPdZjgA==
X-Received: by 2002:a17:902:d2c7:b0:224:912:153 with SMTP id
 d9443c01a7336-22fc8aff15amr104373465ad.5.1746857827820; 
 Fri, 09 May 2025 23:17:07 -0700 (PDT)
Received: from localhost ([157.82.128.1]) by smtp.gmail.com with UTF8SMTPSA id
 d9443c01a7336-22fc7540ca4sm27374435ad.52.2025.05.09.23.17.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 May 2025 23:17:07 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 10 May 2025 15:16:55 +0900
Subject: [PATCH 2/3] docs: Require sphinx>=6.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250510-sphinx72-v1-2-2358e0c68bbe@daynix.com>
References: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
In-Reply-To: <20250510-sphinx72-v1-0-2358e0c68bbe@daynix.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: devel@daynix.com, John Snow <jsnow@redhat.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.15-dev-edae6
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This makes docs/sphinx/compat.py unnecessary. The accepted range of the
sphinx_rtd_theme version was also changed to >=1.2 for compatibility
with sphinx>=6.2.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 docs/sphinx/compat.py      | 230 ---------------------------------------------
 docs/sphinx/qapi_domain.py |  33 +++----
 pythondeps.toml            |   4 +-
 3 files changed, 17 insertions(+), 250 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
deleted file mode 100644
index 9cf7fe006e44..000000000000
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
index c94af5719ca0..29e006c9cf0f 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -21,14 +21,10 @@
 from docutils import nodes
 from docutils.parsers.rst import directives
 
-from compat import (
-    CompatField,
-    CompatGroupedField,
-    CompatTypedField,
-    KeywordNode,
-    ParserFix,
-    Signature,
-    SpaceNode,
+from sphinx.util.docfields import (
+    Field,
+    GroupedField,
+    TypedField,
 )
 from sphinx import addnodes
 from sphinx.directives import ObjectDescription
@@ -64,6 +60,7 @@
     from sphinx.util.typing import OptionSpec
 
 
+Signature = str
 logger = logging.getLogger(__name__)
 
 
@@ -158,7 +155,7 @@ def result_nodes(
         return results, []
 
 
-class QAPIDescription(ParserFix):
+class QAPIDescription(ObjectDescription[Signature]):
     """
     Generic QAPI description.
 
@@ -312,7 +309,7 @@ class QAPIObject(QAPIDescription):
 
     doc_field_types = [
         # :feat name: descr
-        CompatGroupedField(
+        GroupedField(
             "feature",
             label=_("Features"),
             names=("feat",),
@@ -324,8 +321,8 @@ def get_signature_prefix(self) -> List[nodes.Node]:
         """Return a prefix to put before the object name in the signature."""
         assert self.objtype
         return [
-            KeywordNode("", self.objtype.title()),
-            SpaceNode(" "),
+            addnodes.desc_sig_keyword("", self.objtype.title()),
+            addnodes.desc_sig_space(" "),
         ]
 
     def get_signature_suffix(self) -> List[nodes.Node]:
@@ -334,7 +331,7 @@ def get_signature_suffix(self) -> List[nodes.Node]:
 
         if "since" in self.options:
             ret += [
-                SpaceNode(" "),
+                addnodes.desc_sig_space(" "),
                 addnodes.desc_sig_element(
                     "", f"(Since: {self.options['since']})"
                 ),
@@ -482,7 +479,7 @@ def transform_content(self, content_node: addnodes.desc_content) -> None:
                     self._validate_field(field)
 
 
-class SpecialTypedField(CompatTypedField):
+class SpecialTypedField(TypedField):
     def make_field(self, *args: Any, **kwargs: Any) -> nodes.field:
         ret = super().make_field(*args, **kwargs)
 
@@ -515,14 +512,14 @@ class QAPICommand(QAPIObject):
                 can_collapse=False,
             ),
             # :error: descr
-            CompatField(
+            Field(
                 "error",
                 label=_("Errors"),
                 names=("error", "errors"),
                 has_arg=False,
             ),
             # :return TypeName: descr
-            CompatGroupedField(
+            GroupedField(
                 "returnvalue",
                 label=_("Return"),
                 rolename="type",
@@ -540,7 +537,7 @@ class QAPIEnum(QAPIObject):
     doc_field_types.extend(
         [
             # :value name: descr
-            CompatGroupedField(
+            GroupedField(
                 "value",
                 label=_("Values"),
                 names=("value",),
@@ -557,7 +554,7 @@ class QAPIAlternate(QAPIObject):
     doc_field_types.extend(
         [
             # :alt type name: descr
-            CompatTypedField(
+            TypedField(
                 "alternative",
                 label=_("Alternatives"),
                 names=("alt",),
diff --git a/pythondeps.toml b/pythondeps.toml
index 4f6b6f01e0d0..0d8f5ae24a24 100644
--- a/pythondeps.toml
+++ b/pythondeps.toml
@@ -24,8 +24,8 @@ pycotap = { accepted = ">=1.1.0", installed = "1.3.1" }
 
 [docs]
 # Please keep the installed versions in sync with docs/requirements.txt
-sphinx = { accepted = ">=3.4.3", installed = "6.2.1", canary = "sphinx-build" }
-sphinx_rtd_theme = { accepted = ">=0.5", installed = "1.2.2" }
+sphinx = { accepted = ">=6.2", installed = "6.2.1", canary = "sphinx-build" }
+sphinx_rtd_theme = { accepted = ">=1.2", installed = "1.2.2" }
 
 [avocado]
 # Note that qemu.git/python/ is always implicitly installed.

-- 
2.49.0


