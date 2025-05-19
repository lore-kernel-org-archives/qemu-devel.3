Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC2FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 18:23:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH58U-0002q9-1Z; Mon, 19 May 2025 14:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH58N-0002nG-TI
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1uH58G-0000eS-9T
 for qemu-devel@nongnu.org; Mon, 19 May 2025 14:22:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747678948;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zn+6Q9Wc7beI4ZTUhSRPOPDPlLE8aQVYvFIwpKu8J/I=;
 b=V7VoXMzMToFYGDpWpzoZ9hAY5IZplZlG0gANV1tYJ1kO1Q6rYySyamRKhqGnYllwvmqV4e
 ZpBUW/uWyy8bhEcQBgwBiW9+ZYx5zjMJS5sndXnLxfMRspqDAAGU8SzvBwEpm4I57ltxa3
 xBTiGrIW+TZJZHSr8tYbkR56npCOMUQ=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-1t6NiJiiMReS8_N4KtsT_Q-1; Mon,
 19 May 2025 14:22:24 -0400
X-MC-Unique: 1t6NiJiiMReS8_N4KtsT_Q-1
X-Mimecast-MFC-AGG-ID: 1t6NiJiiMReS8_N4KtsT_Q_1747678942
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 42BD61955DB0; Mon, 19 May 2025 18:22:22 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.89.235])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 490E319560AB; Mon, 19 May 2025 18:22:16 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org,
 John Snow <jsnow@redhat.com>, Maksim Davydov <davydov-max@yandex-team.ru>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 4/8] python: use 3.9+ builtin type hints
Date: Mon, 19 May 2025 14:21:48 -0400
Message-ID: <20250519182153.3835722-5-jsnow@redhat.com>
In-Reply-To: <20250519182153.3835722-1-jsnow@redhat.com>
References: <20250519182153.3835722-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_FILL_THIS_FORM_SHORT=0.01 autolearn=ham autolearn_force=no
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

This patch changes type hints that have built-in equivalents as of
Python 3.9. The versions we currently use, imported from the typing
module, have been deprecated since 3.9 and may be removed at any time -
though to my knowledge, they are not scheduled for removal in 3.14.

The type hints to update are:

typing.Dict  => dict
typing.List  => list
typing.Tuple => tuple
typing.Set   => set
typing.Type  => type

I performed this change the dumb way (I couldn't work out for the life
of me how to beg ls-files to exclude subprojects and empty directories,
desipte it having an option which claims to do precisely that. Suggest a
nicer way to do this if you'd like.)

git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Dict\[/dict\[/g'
git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/List\[/list\[/g'
git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Tuple\[/tuple\[/g'
git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Set\[/set\[/g'
git ls-files | grep -v 'roms/' | grep -v 'subprojects/' | grep -v 'tests/lcitool/libvirt-ci' | xargs sed -i -e 's/Type\[/type\[/g'

I then used "git add -p" and excluded changes by hand that weren't
appropriate. I then reviewed all of the changed files by hand to review
the imports and update them accordingly.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/compat.py                         |   3 +-
 docs/sphinx/dbusdoc.py                        |   9 +-
 docs/sphinx/dbusdomain.py                     |  29 ++---
 docs/sphinx/fakedbusdoc.py                    |   4 +-
 docs/sphinx/qapi_domain.py                    |  68 +++++------
 docs/sphinx/qapidoc.py                        |   7 +-
 python/qemu/machine/machine.py                |  30 ++---
 python/qemu/machine/qtest.py                  |  12 +-
 python/qemu/qmp/events.py                     |  15 +--
 python/qemu/qmp/legacy.py                     |  13 +-
 python/qemu/qmp/message.py                    |   7 +-
 python/qemu/qmp/models.py                     |   3 +-
 python/qemu/qmp/protocol.py                   |   8 +-
 python/qemu/qmp/qmp_client.py                 |   6 +-
 python/qemu/qmp/qmp_shell.py                  |  10 +-
 python/qemu/qmp/qmp_tui.py                    |  21 ++--
 python/qemu/utils/accel.py                    |   4 +-
 python/qemu/utils/qemu_ga_client.py           |   3 +-
 python/qemu/utils/qom_common.py               |  17 +--
 python/qemu/utils/qom_fuse.py                 |   3 +-
 python/scripts/mkvenv.py                      |  14 +--
 .../codeconverter/codeconverter/patching.py   |  44 +++----
 .../codeconverter/codeconverter/qom_macros.py |  36 +++---
 .../codeconverter/qom_type_info.py            |  16 +--
 scripts/compare-machine-types.py              |  40 +++---
 scripts/qapi/commands.py                      |  13 +-
 scripts/qapi/common.py                        |   9 +-
 scripts/qapi/events.py                        |   8 +-
 scripts/qapi/expr.py                          |  20 ++-
 scripts/qapi/gen.py                           |  12 +-
 scripts/qapi/introspect.py                    |  42 +++----
 scripts/qapi/parser.py                        |  37 +++---
 scripts/qapi/schema.py                        | 114 +++++++++---------
 scripts/qapi/source.py                        |  10 +-
 scripts/qapi/types.py                         |  20 +--
 scripts/qapi/visit.py                         |  14 +--
 scripts/rust/rustc_args.py                    |   6 +-
 scripts/u2f-setup-gen.py                      |   3 +-
 tests/functional/qemu_test/ports.py           |   3 +-
 tests/functional/test_acpi_bits.py            |   3 +-
 tests/qemu-iotests/151                        |   4 +-
 tests/qemu-iotests/297                        |   5 +-
 tests/qemu-iotests/300                        |   4 +-
 tests/qemu-iotests/fat16.py                   |  10 +-
 tests/qemu-iotests/findtests.py               |  12 +-
 tests/qemu-iotests/iotests.py                 |  38 +++---
 tests/qemu-iotests/linters.py                 |   6 +-
 tests/qemu-iotests/testenv.py                 |   6 +-
 tests/qemu-iotests/testrunner.py              |  12 +-
 .../qemu-iotests/tests/stream-under-throttle  |   3 +-
 50 files changed, 375 insertions(+), 461 deletions(-)

diff --git a/docs/sphinx/compat.py b/docs/sphinx/compat.py
index 9cf7fe006e4..50002b6fea7 100644
--- a/docs/sphinx/compat.py
+++ b/docs/sphinx/compat.py
@@ -8,7 +8,6 @@
     Any,
     Callable,
     Optional,
-    Type,
 )
 
 from docutils import nodes
@@ -85,7 +84,7 @@ def _compat_make_xref(  # pylint: disable=unused-argument
     rolename: str,
     domain: str,
     target: str,
-    innernode: Type[TextlikeNode] = addnodes.literal_emphasis,
+    innernode: type[TextlikeNode] = addnodes.literal_emphasis,
     contnode: Optional[Node] = None,
     env: Optional[BuildEnvironment] = None,
     inliner: Any = None,
diff --git a/docs/sphinx/dbusdoc.py b/docs/sphinx/dbusdoc.py
index be284ed08fd..5bff49b41d2 100644
--- a/docs/sphinx/dbusdoc.py
+++ b/docs/sphinx/dbusdoc.py
@@ -13,14 +13,9 @@
     TYPE_CHECKING,
     Any,
     Callable,
-    Dict,
     Iterator,
-    List,
     Optional,
     Sequence,
-    Set,
-    Tuple,
-    Type,
     TypeVar,
     Union,
 )
@@ -116,7 +111,7 @@ def add_interface(self, iface):
         self.indent = self.indent[:-3]
 
 
-def parse_generated_content(state: RSTState, content: StringList) -> List[Node]:
+def parse_generated_content(state: RSTState, content: StringList) -> list[Node]:
     """Parse a generated content by Documenter."""
     with switch_source_input(state, content):
         node = nodes.paragraph()
@@ -157,7 +152,7 @@ def run(self):
         return result
 
 
-def setup(app: Sphinx) -> Dict[str, Any]:
+def setup(app: Sphinx) -> dict[str, Any]:
     """Register dbus-doc directive with Sphinx"""
     app.add_config_value("dbusdoc_srctree", None, "env")
     app.add_directive("dbus-doc", DBusDocDirective)
diff --git a/docs/sphinx/dbusdomain.py b/docs/sphinx/dbusdomain.py
index 9872fd5bf6a..75a6b5590bc 100644
--- a/docs/sphinx/dbusdomain.py
+++ b/docs/sphinx/dbusdomain.py
@@ -8,13 +8,10 @@
 
 from typing import (
     Any,
-    Dict,
     Iterable,
     Iterator,
-    List,
     NamedTuple,
     Optional,
-    Tuple,
     cast,
 )
 
@@ -87,7 +84,7 @@ def handle_signature(self, sig: str, signode: desc_signature) -> str:
         signode += addnodes.desc_name(sig, sig)
         return sig
 
-    def run(self) -> List[Node]:
+    def run(self) -> list[Node]:
         _, node = super().run()
         name = self.arguments[0]
         section = nodes.section(ids=[name + "-section"])
@@ -113,7 +110,7 @@ class DBusMethod(DBusMember):
         }
     )
 
-    doc_field_types: List[Field] = [
+    doc_field_types: list[Field] = [
         TypedField(
             "arg",
             label=_("Arguments"),
@@ -171,7 +168,7 @@ class DBusSignal(DBusMethod):
     Implementation of ``dbus:signal``.
     """
 
-    doc_field_types: List[Field] = [
+    doc_field_types: list[Field] = [
         TypedField(
             "arg",
             label=_("Arguments"),
@@ -203,7 +200,7 @@ class DBusProperty(DBusMember):
         }
     )
 
-    doc_field_types: List[Field] = []
+    doc_field_types: list[Field] = []
 
     def get_index_text(self, ifacename: str, name: str) -> str:
         return _("%s (%s property)") % (name, ifacename)
@@ -244,7 +241,7 @@ def handle_signature(self, sig: str, signode: desc_signature) -> str:
         signode += addnodes.desc_sig_keyword_type(ty, ty)
         return sig
 
-    def run(self) -> List[Node]:
+    def run(self) -> list[Node]:
         self.name = "dbus:member"
         return super().run()
 
@@ -281,10 +278,10 @@ class DBusIndex(Index):
 
     def generate(
         self, docnames: Iterable[str] = None
-    ) -> Tuple[List[Tuple[str, List[IndexEntry]]], bool]:
-        content: Dict[str, List[IndexEntry]] = {}
+    ) -> tuple[list[tuple[str, list[IndexEntry]]], bool]:
+        content: dict[str, list[IndexEntry]] = {}
         # list of prefixes to ignore
-        ignores: List[str] = self.domain.env.config["dbus_index_common_prefix"]
+        ignores: list[str] = self.domain.env.config["dbus_index_common_prefix"]
         ignores = sorted(ignores, key=len, reverse=True)
 
         ifaces = sorted(
@@ -329,7 +326,7 @@ class DBusDomain(Domain):
 
     name = "dbus"
     label = "D-Bus"
-    object_types: Dict[str, ObjType] = {
+    object_types: dict[str, ObjType] = {
         "interface": ObjType(_("interface"), "iface", "obj"),
         "method": ObjType(_("method"), "meth", "obj"),
         "signal": ObjType(_("signal"), "sig", "obj"),
@@ -347,7 +344,7 @@ class DBusDomain(Domain):
         "sig": DBusXRef(),
         "prop": DBusXRef(),
     }
-    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {
+    initial_data: dict[str, dict[str, tuple[Any]]] = {
         "objects": {},  # fullname -> ObjectEntry
     }
     indices = [
@@ -355,7 +352,7 @@ class DBusDomain(Domain):
     ]
 
     @property
-    def objects(self) -> Dict[str, ObjectEntry]:
+    def objects(self) -> dict[str, ObjectEntry]:
         return self.data.setdefault("objects", {})  # fullname -> ObjectEntry
 
     def note_object(
@@ -368,7 +365,7 @@ def clear_doc(self, docname: str) -> None:
             if obj.docname == docname:
                 del self.objects[fullname]
 
-    def find_obj(self, typ: str, name: str) -> Optional[Tuple[str, ObjectEntry]]:
+    def find_obj(self, typ: str, name: str) -> Optional[tuple[str, ObjectEntry]]:
         # skip parens
         if name[-2:] == "()":
             name = name[:-2]
@@ -396,7 +393,7 @@ def resolve_xref(
                 builder, fromdocname, objdef.docname, objdef.node_id, contnode
             )
 
-    def get_objects(self) -> Iterator[Tuple[str, str, str, str, str, int]]:
+    def get_objects(self) -> Iterator[tuple[str, str, str, str, str, int]]:
         for refname, obj in self.objects.items():
             yield (refname, refname, obj.objtype, obj.docname, obj.node_id, 1)
 
diff --git a/docs/sphinx/fakedbusdoc.py b/docs/sphinx/fakedbusdoc.py
index 2d2e6ef6403..29da1b3d93d 100644
--- a/docs/sphinx/fakedbusdoc.py
+++ b/docs/sphinx/fakedbusdoc.py
@@ -9,7 +9,7 @@
 
 from docutils.parsers.rst import Directive
 from sphinx.application import Sphinx
-from typing import Any, Dict
+from typing import Any
 
 
 class FakeDBusDocDirective(Directive):
@@ -20,7 +20,7 @@ def run(self):
         return []
 
 
-def setup(app: Sphinx) -> Dict[str, Any]:
+def setup(app: Sphinx) -> dict[str, Any]:
     """Register a fake dbus-doc directive with Sphinx"""
     app.add_directive("dbus-doc", FakeDBusDocDirective)
 
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index ebc46a72c61..665f0953b44 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -9,14 +9,7 @@
 
 import re
 import types
-from typing import (
-    TYPE_CHECKING,
-    List,
-    NamedTuple,
-    Tuple,
-    Type,
-    cast,
-)
+from typing import TYPE_CHECKING, NamedTuple, cast
 
 from docutils import nodes
 from docutils.parsers.rst import directives
@@ -49,7 +42,6 @@
     from typing import (
         AbstractSet,
         Any,
-        Dict,
         Iterable,
         Optional,
         Union,
@@ -68,7 +60,7 @@
 
 def _unpack_field(
     field: nodes.Node,
-) -> Tuple[nodes.field_name, nodes.field_body]:
+) -> tuple[nodes.field_name, nodes.field_body]:
     """
     docutils helper: unpack a field node in a type-safe manner.
     """
@@ -140,11 +132,11 @@ def result_nodes(
         env: BuildEnvironment,
         node: Element,
         is_ref: bool,
-    ) -> Tuple[List[nodes.Node], List[nodes.system_message]]:
+    ) -> tuple[list[nodes.Node], list[nodes.system_message]]:
 
         # node here is the pending_xref node (or whatever nodeclass was
         # configured at XRefRole class instantiation time).
-        results: List[nodes.Node] = [node]
+        results: list[nodes.Node] = [node]
 
         if node.get("qapi:array"):
             results.insert(0, nodes.literal("[", "["))
@@ -178,13 +170,13 @@ def handle_signature(self, sig: str, signode: desc_signature) -> Signature:
         # subclasses will handle this.
         return sig
 
-    def get_index_text(self, name: Signature) -> Tuple[str, str]:
+    def get_index_text(self, name: Signature) -> tuple[str, str]:
         """Return the text for the index entry of the object."""
 
         # NB: this is used for the global index, not the QAPI index.
         return ("single", f"{name} (QMP {self.objtype})")
 
-    def _get_context(self) -> Tuple[str, str]:
+    def _get_context(self) -> tuple[str, str]:
         namespace = self.options.get(
             "namespace", self.env.ref_context.get("qapi:namespace", "")
         )
@@ -240,7 +232,7 @@ def add_target_and_index(
                 )
 
     @staticmethod
-    def split_fqn(name: str) -> Tuple[str, str, str]:
+    def split_fqn(name: str) -> tuple[str, str, str]:
         if ":" in name:
             ns, name = name.split(":")
         else:
@@ -255,7 +247,7 @@ def split_fqn(name: str) -> Tuple[str, str, str]:
 
     def _object_hierarchy_parts(
         self, sig_node: desc_signature
-    ) -> Tuple[str, ...]:
+    ) -> tuple[str, ...]:
         if "fullname" not in sig_node:
             return ()
         return self.split_fqn(sig_node["fullname"])
@@ -264,7 +256,7 @@ def _toc_entry_name(self, sig_node: desc_signature) -> str:
         # This controls the name in the TOC and on the sidebar.
 
         # This is the return type of _object_hierarchy_parts().
-        toc_parts = cast(Tuple[str, ...], sig_node.get("_toc_parts", ()))
+        toc_parts = cast(tuple[str, ...], sig_node.get("_toc_parts", ()))
         if not toc_parts:
             return ""
 
@@ -323,7 +315,7 @@ class QAPIObject(QAPIDescription):
         ),
     ]
 
-    def get_signature_prefix(self) -> List[nodes.Node]:
+    def get_signature_prefix(self) -> list[nodes.Node]:
         """Return a prefix to put before the object name in the signature."""
         assert self.objtype
         return [
@@ -331,9 +323,9 @@ def get_signature_prefix(self) -> List[nodes.Node]:
             SpaceNode(" "),
         ]
 
-    def get_signature_suffix(self) -> List[nodes.Node]:
+    def get_signature_suffix(self) -> list[nodes.Node]:
         """Return a suffix to put after the object name in the signature."""
-        ret: List[nodes.Node] = []
+        ret: list[nodes.Node] = []
 
         if "since" in self.options:
             ret += [
@@ -383,7 +375,7 @@ def _add_infopips(self, contentnode: addnodes.desc_content) -> None:
         infopips.attributes["classes"].append("qapi-infopips")
 
         def _add_pip(
-            source: str, content: Union[str, List[nodes.Node]], classname: str
+            source: str, content: Union[str, list[nodes.Node]], classname: str
         ) -> None:
             node = nodes.container(source)
             if isinstance(content, str):
@@ -626,7 +618,7 @@ class QAPIModule(QAPIDescription):
           Lorem ipsum, dolor sit amet ...
     """
 
-    def run(self) -> List[Node]:
+    def run(self) -> list[Node]:
         modname = self.arguments[0].strip()
         self.env.ref_context["qapi:module"] = modname
         ret = super().run()
@@ -641,11 +633,11 @@ def run(self) -> List[Node]:
         ret.extend(desc_node.children[1].children)
 
         # Re-home node_ids so anchor refs still work:
-        node_ids: List[str]
+        node_ids: list[str]
         if node_ids := [
             node_id
             for el in desc_node.children[0].traverse(nodes.Element)
-            for node_id in cast(List[str], el.get("ids", ()))
+            for node_id in cast(list[str], el.get("ids", ()))
         ]:
             target_node = nodes.target(ids=node_ids)
             ret.insert(1, target_node)
@@ -657,7 +649,7 @@ class QAPINamespace(SphinxDirective):
     has_content = False
     required_arguments = 1
 
-    def run(self) -> List[Node]:
+    def run(self) -> list[Node]:
         namespace = self.arguments[0].strip()
         self.env.ref_context["qapi:namespace"] = namespace
 
@@ -679,9 +671,9 @@ class QAPIIndex(Index):
     def generate(
         self,
         docnames: Optional[Iterable[str]] = None,
-    ) -> Tuple[List[Tuple[str, List[IndexEntry]]], bool]:
+    ) -> tuple[list[tuple[str, list[IndexEntry]]], bool]:
         assert isinstance(self.domain, QAPIDomain)
-        content: Dict[str, List[IndexEntry]] = {}
+        content: dict[str, list[IndexEntry]] = {}
         collapse = False
 
         for objname, obj in self.domain.objects.items():
@@ -733,7 +725,7 @@ class QAPIDomain(Domain):
     # e.g., the :qapi:type: cross-reference role can refer to enum,
     # struct, union, or alternate objects; but :qapi:obj: can refer to
     # anything. Each object also gets its own targeted cross-reference role.
-    object_types: Dict[str, ObjType] = {
+    object_types: dict[str, ObjType] = {
         "module": ObjType(_("module"), "mod", "any"),
         "command": ObjType(_("command"), "cmd", "any"),
         "event": ObjType(_("event"), "event", "any"),
@@ -771,7 +763,7 @@ class QAPIDomain(Domain):
 
     # Moved into the data property at runtime;
     # this is the internal index of reference-able objects.
-    initial_data: Dict[str, Dict[str, Tuple[Any]]] = {
+    initial_data: dict[str, dict[str, tuple[Any]]] = {
         "objects": {},  # fullname -> ObjectEntry
     }
 
@@ -781,14 +773,14 @@ class QAPIDomain(Domain):
     ]
 
     @property
-    def objects(self) -> Dict[str, ObjectEntry]:
+    def objects(self) -> dict[str, ObjectEntry]:
         ret = self.data.setdefault("objects", {})
         return ret  # type: ignore[no-any-return]
 
     def setup(self) -> None:
         namespaces = set(self.env.app.config.qapi_namespaces)
         for namespace in namespaces:
-            new_index: Type[QAPIIndex] = types.new_class(
+            new_index: type[QAPIIndex] = types.new_class(
                 f"{namespace}Index", bases=(QAPIIndex,)
             )
             new_index.name = f"{namespace.lower()}-index"
@@ -838,7 +830,7 @@ def clear_doc(self, docname: str) -> None:
                 del self.objects[fullname]
 
     def merge_domaindata(
-        self, docnames: AbstractSet[str], otherdata: Dict[str, Any]
+        self, docnames: AbstractSet[str], otherdata: dict[str, Any]
     ) -> None:
         for fullname, obj in otherdata["objects"].items():
             if obj.docname in docnames:
@@ -853,7 +845,7 @@ def merge_domaindata(
 
     def find_obj(
         self, namespace: str, modname: str, name: str, typ: Optional[str]
-    ) -> List[Tuple[str, ObjectEntry]]:
+    ) -> list[tuple[str, ObjectEntry]]:
         """
         Find a QAPI object for "name", maybe using contextual information.
 
@@ -890,7 +882,7 @@ def find_obj(
 
         if typ is None:
             # :any: lookup, search everything:
-            objtypes: List[str] = list(self.object_types)
+            objtypes: list[str] = list(self.object_types)
         else:
             # type is specified and will be a role (e.g. obj, mod, cmd)
             # convert this to eligible object types (e.g. command, module)
@@ -901,7 +893,7 @@ def find_obj(
         # search!
         # ##
 
-        def _search(needle: str) -> List[str]:
+        def _search(needle: str) -> list[str]:
             if (
                 needle
                 and needle in self.objects
@@ -1015,8 +1007,8 @@ def resolve_any_xref(
         target: str,
         node: pending_xref,
         contnode: Element,
-    ) -> List[Tuple[str, nodes.reference]]:
-        results: List[Tuple[str, nodes.reference]] = []
+    ) -> list[tuple[str, nodes.reference]]:
+        results: list[tuple[str, nodes.reference]] = []
         matches = self.find_obj(
             node.get("qapi:namespace"), node.get("qapi:module"), target, None
         )
@@ -1031,7 +1023,7 @@ def resolve_any_xref(
         return results
 
 
-def setup(app: Sphinx) -> Dict[str, Any]:
+def setup(app: Sphinx) -> dict[str, Any]:
     app.setup_extension("sphinx.directives")
     app.add_config_value(
         "qapi_allowed_fields",
diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8011ac9efaf..ff102a8cab3 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -71,7 +71,6 @@
     from typing import (
         Any,
         Generator,
-        List,
         Optional,
         Sequence,
         Union,
@@ -674,7 +673,7 @@ def _highlightlang(self) -> addnodes.highlightlang:
         )
         return node
 
-    def admonition_wrap(self, *content: nodes.Node) -> List[nodes.Node]:
+    def admonition_wrap(self, *content: nodes.Node) -> list[nodes.Node]:
         title = "Example:"
         if "title" in self.options:
             title = f"{title} {self.options['title']}"
@@ -687,7 +686,7 @@ def admonition_wrap(self, *content: nodes.Node) -> List[nodes.Node]:
         )
         return [admon]
 
-    def run_annotated(self) -> List[nodes.Node]:
+    def run_annotated(self) -> list[nodes.Node]:
         lang_node = self._highlightlang()
 
         content_node: nodes.Element = nodes.section()
@@ -708,7 +707,7 @@ def run_annotated(self) -> List[nodes.Node]:
 
         return content_node.children
 
-    def run(self) -> List[nodes.Node]:
+    def run(self) -> list[nodes.Node]:
         annotated = "annotated" in self.options
 
         if annotated:
diff --git a/python/qemu/machine/machine.py b/python/qemu/machine/machine.py
index ebb58d5b68c..52a2d735d32 100644
--- a/python/qemu/machine/machine.py
+++ b/python/qemu/machine/machine.py
@@ -31,12 +31,8 @@
 from typing import (
     Any,
     BinaryIO,
-    Dict,
-    List,
     Optional,
     Sequence,
-    Tuple,
-    Type,
     TypeVar,
 )
 
@@ -156,9 +152,9 @@ def __init__(self,
         self._qmp_timer = qmp_timer
 
         self._name = name or f"{id(self):x}"
-        self._sock_pair: Optional[Tuple[socket.socket, socket.socket]] = None
+        self._sock_pair: Optional[tuple[socket.socket, socket.socket]] = None
         self._cons_sock_pair: Optional[
-            Tuple[socket.socket, socket.socket]] = None
+            tuple[socket.socket, socket.socket]] = None
         self._temp_dir: Optional[str] = None
         self._base_temp_dir = base_temp_dir
         self._log_dir = log_dir
@@ -176,11 +172,11 @@ def __init__(self,
         self._qemu_log_path: Optional[str] = None
         self._qemu_log_file: Optional[BinaryIO] = None
         self._popen: Optional['subprocess.Popen[bytes]'] = None
-        self._events: List[QMPMessage] = []
+        self._events: list[QMPMessage] = []
         self._iolog: Optional[str] = None
         self._qmp_set = True   # Enable QMP monitor by default.
         self._qmp_connection: Optional[QEMUMonitorProtocol] = None
-        self._qemu_full_args: Tuple[str, ...] = ()
+        self._qemu_full_args: tuple[str, ...] = ()
         self._launched = False
         self._machine: Optional[str] = None
         self._console_index = 0
@@ -188,7 +184,7 @@ def __init__(self,
         self._console_device_type: Optional[str] = None
         self._console_socket: Optional[socket.socket] = None
         self._console_file: Optional[socket.SocketIO] = None
-        self._remove_files: List[str] = []
+        self._remove_files: list[str] = []
         self._user_killed = False
         self._quit_issued = False
 
@@ -196,7 +192,7 @@ def __enter__(self: _T) -> _T:
         return self
 
     def __exit__(self,
-                 exc_type: Optional[Type[BaseException]],
+                 exc_type: Optional[type[BaseException]],
                  exc_val: Optional[BaseException],
                  exc_tb: Optional[TracebackType]) -> None:
         self.shutdown()
@@ -292,7 +288,7 @@ def _load_io_log(self) -> None:
                 self._iolog = iolog.read()
 
     @property
-    def _base_args(self) -> List[str]:
+    def _base_args(self) -> list[str]:
         args = ['-display', 'none', '-vga', 'none']
 
         if self._qmp_set:
@@ -324,7 +320,7 @@ def _base_args(self) -> List[str]:
         return args
 
     @property
-    def args(self) -> List[str]:
+    def args(self) -> list[str]:
         """Returns the list of arguments given to the QEMU binary."""
         return self._args
 
@@ -685,14 +681,14 @@ def _qmp(self) -> QEMUMonitorProtocol:
 
     @classmethod
     def _qmp_args(cls, conv_keys: bool,
-                  args: Dict[str, Any]) -> Dict[str, object]:
+                  args: dict[str, Any]) -> dict[str, object]:
         if conv_keys:
             return {k.replace('_', '-'): v for k, v in args.items()}
 
         return args
 
     def qmp(self, cmd: str,
-            args_dict: Optional[Dict[str, object]] = None,
+            args_dict: Optional[dict[str, object]] = None,
             conv_keys: Optional[bool] = None,
             **args: Any) -> QMPMessage:
         """
@@ -714,7 +710,7 @@ def qmp(self, cmd: str,
         return ret
 
     def cmd(self, cmd: str,
-            args_dict: Optional[Dict[str, object]] = None,
+            args_dict: Optional[dict[str, object]] = None,
             conv_keys: Optional[bool] = None,
             **args: Any) -> QMPReturnValue:
         """
@@ -745,7 +741,7 @@ def get_qmp_event(self, wait: bool = False) -> Optional[QMPMessage]:
             return self._events.pop(0)
         return self._qmp.pull_event(wait=wait)
 
-    def get_qmp_events(self, wait: bool = False) -> List[QMPMessage]:
+    def get_qmp_events(self, wait: bool = False) -> list[QMPMessage]:
         """
         Poll for queued QMP events and return a list of dicts
         """
@@ -800,7 +796,7 @@ def event_wait(self, name: str,
         return self.events_wait([(name, match)], timeout)
 
     def events_wait(self,
-                    events: Sequence[Tuple[str, Any]],
+                    events: Sequence[tuple[str, Any]],
                     timeout: float = 60.0) -> Optional[QMPMessage]:
         """
         events_wait waits for and returns a single named event from QMP.
diff --git a/python/qemu/machine/qtest.py b/python/qemu/machine/qtest.py
index 4f5ede85b23..2582d89cc5e 100644
--- a/python/qemu/machine/qtest.py
+++ b/python/qemu/machine/qtest.py
@@ -19,13 +19,7 @@
 
 import os
 import socket
-from typing import (
-    List,
-    Optional,
-    Sequence,
-    TextIO,
-    Tuple,
-)
+from typing import Optional, Sequence, TextIO
 
 from qemu.qmp import SocketAddrT
 
@@ -145,10 +139,10 @@ def __init__(self,
                          qmp_timer=qmp_timer)
         self._qtest: Optional[QEMUQtestProtocol] = None
         self._qtest_sock_pair: Optional[
-            Tuple[socket.socket, socket.socket]] = None
+            tuple[socket.socket, socket.socket]] = None
 
     @property
-    def _base_args(self) -> List[str]:
+    def _base_args(self) -> list[str]:
         args = super()._base_args
         assert self._qtest_sock_pair is not None
         fd = self._qtest_sock_pair[0].fileno()
diff --git a/python/qemu/qmp/events.py b/python/qemu/qmp/events.py
index cfb5f0ac621..93ae808b2ac 100644
--- a/python/qemu/qmp/events.py
+++ b/python/qemu/qmp/events.py
@@ -455,10 +455,7 @@ def accept(self, event) -> bool:
     Callable,
     Iterable,
     Iterator,
-    List,
     Optional,
-    Set,
-    Tuple,
     Union,
 )
 
@@ -504,10 +501,10 @@ def __init__(
         self._queue: 'asyncio.Queue[Message]' = asyncio.Queue()
 
         # Intended as a historical record, NOT a processing queue or backlog.
-        self._history: List[Message] = []
+        self._history: list[Message] = []
 
         #: Primary event filter, based on one or more event names.
-        self.names: Set[str] = set()
+        self.names: set[str] = set()
         if isinstance(names, str):
             self.names.add(names)
         elif names is not None:
@@ -517,7 +514,7 @@ def __init__(
         self.event_filter: Optional[EventFilter] = event_filter
 
     def __repr__(self) -> str:
-        args: List[str] = []
+        args: list[str] = []
         if self.names:
             args.append(f"names={self.names!r}")
         if self.event_filter:
@@ -532,7 +529,7 @@ def __repr__(self) -> str:
         return f"{type(self).__name__}{state}({argstr})"
 
     @property
-    def history(self) -> Tuple[Message, ...]:
+    def history(self) -> tuple[Message, ...]:
         """
         A read-only history of all events seen so far.
 
@@ -596,7 +593,7 @@ def empty(self) -> bool:
         """
         return self._queue.empty()
 
-    def clear(self) -> List[Message]:
+    def clear(self) -> list[Message]:
         """
         Clear this listener of all pending events.
 
@@ -650,7 +647,7 @@ class Events:
     property.
     """
     def __init__(self) -> None:
-        self._listeners: List[EventListener] = []
+        self._listeners: list[EventListener] = []
 
         #: Default, all-events `EventListener`. See `qmp.events` for more info.
         self.events: EventListener = EventListener()
diff --git a/python/qemu/qmp/legacy.py b/python/qemu/qmp/legacy.py
index 9606e731864..de859a99f72 100644
--- a/python/qemu/qmp/legacy.py
+++ b/python/qemu/qmp/legacy.py
@@ -27,10 +27,7 @@
 from typing import (
     Any,
     Awaitable,
-    Dict,
-    List,
     Optional,
-    Type,
     TypeVar,
     Union,
 )
@@ -41,13 +38,13 @@
 
 
 #: QMPMessage is an entire QMP message of any kind.
-QMPMessage = Dict[str, Any]
+QMPMessage = dict[str, Any]
 
 #: QMPReturnValue is the 'return' value of a command.
 QMPReturnValue = object
 
 #: QMPObject is any object in a QMP message.
-QMPObject = Dict[str, object]
+QMPObject = dict[str, object]
 
 # QMPMessage can be outgoing commands or incoming events/returns.
 # QMPReturnValue is usually a dict/json object, but due to QAPI's
@@ -121,7 +118,7 @@ def __enter__(self: _T) -> _T:
         return self
 
     def __exit__(self,
-                 exc_type: Optional[Type[BaseException]],
+                 exc_type: Optional[type[BaseException]],
                  exc_val: Optional[BaseException],
                  exc_tb: Optional[TracebackType]) -> None:
         # Implement context manager exit function.
@@ -202,7 +199,7 @@ def cmd_obj(self, qmp_cmd: QMPMessage) -> QMPMessage:
         )
 
     def cmd_raw(self, name: str,
-                args: Optional[Dict[str, object]] = None) -> QMPMessage:
+                args: Optional[dict[str, object]] = None) -> QMPMessage:
         """
         Build a QMP command and send it to the QMP Monitor.
 
@@ -260,7 +257,7 @@ def pull_event(self,
             )
         )
 
-    def get_events(self, wait: Union[bool, float] = False) -> List[QMPMessage]:
+    def get_events(self, wait: Union[bool, float] = False) -> list[QMPMessage]:
         """
         Get a list of QMP events and clear all pending events.
 
diff --git a/python/qemu/qmp/message.py b/python/qemu/qmp/message.py
index dabb8ec360e..d9234fa2453 100644
--- a/python/qemu/qmp/message.py
+++ b/python/qemu/qmp/message.py
@@ -8,7 +8,6 @@
 import json
 from json import JSONDecodeError
 from typing import (
-    Dict,
     Iterator,
     Mapping,
     MutableMapping,
@@ -71,7 +70,7 @@ def __init__(self,
                  value: Union[bytes, Mapping[str, object]] = b'{}', *,
                  eager: bool = True):
         self._data: Optional[bytes] = None
-        self._obj: Optional[Dict[str, object]] = None
+        self._obj: Optional[dict[str, object]] = None
 
         if isinstance(value, bytes):
             self._data = value
@@ -125,7 +124,7 @@ def __bytes__(self) -> bytes:
     # Conversion Methods
 
     @property
-    def _object(self) -> Dict[str, object]:
+    def _object(self) -> dict[str, object]:
         """
         A `dict` representing this QMP message.
 
@@ -150,7 +149,7 @@ def _serialize(cls, value: object) -> bytes:
         return json.dumps(value, separators=(',', ':')).encode('utf-8')
 
     @classmethod
-    def _deserialize(cls, data: bytes) -> Dict[str, object]:
+    def _deserialize(cls, data: bytes) -> dict[str, object]:
         """
         Deserialize JSON `bytes` into a native Python `dict`.
 
diff --git a/python/qemu/qmp/models.py b/python/qemu/qmp/models.py
index 19dbe8781f4..0e4a3c4e5ed 100644
--- a/python/qemu/qmp/models.py
+++ b/python/qemu/qmp/models.py
@@ -11,7 +11,6 @@
 import copy
 from typing import (
     Any,
-    Dict,
     Mapping,
     Optional,
     Sequence,
@@ -72,7 +71,7 @@ def __init__(self, raw: Mapping[str, Any]):
         self._check_member('QMP', abc.Mapping, "JSON object")
         self.QMP = QMPGreeting(self._raw['QMP'])
 
-    def _asdict(self) -> Dict[str, object]:
+    def _asdict(self) -> dict[str, object]:
         """
         For compatibility with the iotests sync QMP wrapper.
 
diff --git a/python/qemu/qmp/protocol.py b/python/qemu/qmp/protocol.py
index 26486889d02..43aefd7b01a 100644
--- a/python/qemu/qmp/protocol.py
+++ b/python/qemu/qmp/protocol.py
@@ -28,9 +28,7 @@
     Awaitable,
     Callable,
     Generic,
-    List,
     Optional,
-    Tuple,
     TypeVar,
     Union,
     cast,
@@ -50,7 +48,7 @@
 _U = TypeVar('_U')
 _TaskFN = Callable[[], Awaitable[None]]  # aka ``async def func() -> None``
 
-InternetAddrT = Tuple[str, int]
+InternetAddrT = tuple[str, int]
 UnixAddrT = str
 SocketAddrT = Union[UnixAddrT, InternetAddrT]
 
@@ -248,7 +246,7 @@ def __init__(self, name: Optional[str] = None) -> None:
         self._writer_task: Optional[asyncio.Future[None]] = None
 
         # Aggregate of the above two tasks, used for Exception management.
-        self._bh_tasks: Optional[asyncio.Future[Tuple[None, None]]] = None
+        self._bh_tasks: Optional[asyncio.Future[tuple[None, None]]] = None
 
         #: Disconnect task. The disconnect implementation runs in a task
         #: so that asynchronous disconnects (initiated by the
@@ -744,7 +742,7 @@ async def _wait_disconnect(self) -> None:
         assert self.runstate == Runstate.DISCONNECTING
         assert self._dc_task
 
-        aws: List[Awaitable[object]] = [self._dc_task]
+        aws: list[Awaitable[object]] = [self._dc_task]
         if self._bh_tasks:
             aws.insert(0, self._bh_tasks)
         all_defined_tasks = asyncio.gather(*aws)
diff --git a/python/qemu/qmp/qmp_client.py b/python/qemu/qmp/qmp_client.py
index 55508ff73f3..515784ab552 100644
--- a/python/qemu/qmp/qmp_client.py
+++ b/python/qemu/qmp/qmp_client.py
@@ -12,8 +12,6 @@
 import socket
 import struct
 from typing import (
-    Dict,
-    List,
     Mapping,
     Optional,
     Union,
@@ -262,7 +260,7 @@ def __init__(self, name: Optional[str] = None) -> None:
         self._execute_id = 0
 
         # Incoming RPC reply messages.
-        self._pending: Dict[
+        self._pending: dict[
             Union[str, None],
             'asyncio.Queue[QMPClient._PendingT]'
         ] = {}
@@ -339,7 +337,7 @@ async def _negotiate(self) -> None:
         """
         self.logger.debug("Negotiating capabilities ...")
 
-        arguments: Dict[str, List[str]] = {}
+        arguments: dict[str, list[str]] = {}
         if self._greeting and 'oob' in self._greeting.QMP.capabilities:
             arguments.setdefault('enable', []).append('oob')
         msg = self.make_execute_msg('qmp_capabilities', arguments=arguments)
diff --git a/python/qemu/qmp/qmp_shell.py b/python/qemu/qmp/qmp_shell.py
index c39ba4be165..7265bd1120e 100644
--- a/python/qemu/qmp/qmp_shell.py
+++ b/python/qemu/qmp/qmp_shell.py
@@ -134,9 +134,7 @@
 import sys
 from typing import (
     IO,
-    Dict,
     Iterator,
-    List,
     NoReturn,
     Optional,
     Sequence,
@@ -165,9 +163,9 @@ class QMPCompleter:
     QMPCompleter provides a readline library tab-complete behavior.
     """
     # NB: Python 3.9+ will probably allow us to subclass list[str] directly,
-    # but pylint as of today does not know that List[str] is simply 'list'.
+    # but pylint as of today does not know that list[str] is simply 'list'.
     def __init__(self) -> None:
-        self._matches: List[str] = []
+        self._matches: list[str] = []
 
     def append(self, value: str) -> None:
         """Append a new valid completion to the list of possibilities."""
@@ -229,7 +227,7 @@ def __init__(self, address: SocketAddrT,
         self._greeting: Optional[QMPMessage] = None
         self._completer = QMPCompleter()
         self._transmode = False
-        self._actions: List[QMPMessage] = []
+        self._actions: list[QMPMessage] = []
         self._histfile = os.path.join(os.path.expanduser('~'),
                                       '.qmp-shell_history')
         self.pretty = pretty
@@ -246,7 +244,7 @@ def close(self) -> None:
 
     def _fill_completion(self) -> None:
         try:
-            cmds = cast(List[Dict[str, str]], self.cmd('query-commands'))
+            cmds = cast(list[dict[str, str]], self.cmd('query-commands'))
             for cmd in cmds:
                 self._completer.append(cmd['name'])
         except ExecuteError:
diff --git a/python/qemu/qmp/qmp_tui.py b/python/qemu/qmp/qmp_tui.py
index 12bdc17c99e..0cf91e83670 100644
--- a/python/qemu/qmp/qmp_tui.py
+++ b/python/qemu/qmp/qmp_tui.py
@@ -22,14 +22,7 @@
 from logging import Handler, LogRecord
 import signal
 import sys
-from typing import (
-    List,
-    Optional,
-    Tuple,
-    Type,
-    Union,
-    cast,
-)
+from typing import Optional, Union, cast
 
 
 try:
@@ -120,7 +113,7 @@ def format_json(msg: str) -> str:
 
 
 def has_handler_type(logger: logging.Logger,
-                     handler_type: Type[Handler]) -> bool:
+                     handler_type: type[Handler]) -> bool:
     """
     The Logger class has no interface to check if a certain type of handler is
     installed or not. So we provide an interface to do so.
@@ -151,7 +144,7 @@ class App(QMPClient):
     :param retry_delay:
         The delay(sec) before each retry
     """
-    def __init__(self, address: Union[str, Tuple[str, int]], num_retries: int,
+    def __init__(self, address: Union[str, tuple[str, int]], num_retries: int,
                  retry_delay: Optional[int]) -> None:
         urwid.register_signal(type(self), UPDATE_MSG)
         self.window = Window(self)
@@ -448,11 +441,11 @@ class Editor(urwid_readline.ReadlineEdit):
     def __init__(self, parent: App) -> None:
         super().__init__(caption='> ', multiline=True)
         self.parent = parent
-        self.history: List[str] = []
+        self.history: list[str] = []
         self.last_index: int = -1
         self.show_history: bool = False
 
-    def keypress(self, size: Tuple[int, int], key: str) -> Optional[str]:
+    def keypress(self, size: tuple[int, int], key: str) -> Optional[str]:
         """
         Handles the keypress on this widget.
 
@@ -530,7 +523,7 @@ def __init__(self, parent: App) -> None:
         super().__init__(self.history)
 
     def add_to_history(self,
-                       history: Union[str, List[Tuple[str, str]]]) -> None:
+                       history: Union[str, list[tuple[str, str]]]) -> None:
         """
         Appends a message to the list and set the focus to the last appended
         message.
@@ -541,7 +534,7 @@ def add_to_history(self,
         self.history.append(urwid.Text(history))
         self.history.set_focus(len(self.history) - 1)
 
-    def mouse_event(self, size: Tuple[int, int], _event: str, button: float,
+    def mouse_event(self, size: tuple[int, int], _event: str, button: float,
                     _x: int, _y: int, focus: bool) -> None:
         # Unfortunately there are no urwid constants that represent the mouse
         # events.
diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
index 386ff640ca8..eddb01628a3 100644
--- a/python/qemu/utils/accel.py
+++ b/python/qemu/utils/accel.py
@@ -17,7 +17,7 @@
 import logging
 import os
 import subprocess
-from typing import List, Optional
+from typing import Optional
 
 
 LOG = logging.getLogger(__name__)
@@ -31,7 +31,7 @@
 }
 
 
-def list_accel(qemu_bin: str) -> List[str]:
+def list_accel(qemu_bin: str) -> list[str]:
     """
     List accelerators enabled in the QEMU binary.
 
diff --git a/python/qemu/utils/qemu_ga_client.py b/python/qemu/utils/qemu_ga_client.py
index cf0fcf9a8bb..48b94e5d83b 100644
--- a/python/qemu/utils/qemu_ga_client.py
+++ b/python/qemu/utils/qemu_ga_client.py
@@ -45,7 +45,6 @@
 from typing import (
     Any,
     Callable,
-    Dict,
     Optional,
     Sequence,
 )
@@ -159,7 +158,7 @@ def fsfreeze(self, cmd: str) -> object:
         # Can be int (freeze, thaw) or GuestFsfreezeStatus (status)
         return getattr(self.qga, 'fsfreeze' + '_' + cmd)()
 
-    def fstrim(self, minimum: int) -> Dict[str, object]:
+    def fstrim(self, minimum: int) -> dict[str, object]:
         # returns GuestFilesystemTrimResponse
         ret = getattr(self.qga, 'fstrim')(minimum=minimum)
         assert isinstance(ret, dict)
diff --git a/python/qemu/utils/qom_common.py b/python/qemu/utils/qom_common.py
index dd2c8b1908c..245c5cedfa3 100644
--- a/python/qemu/utils/qom_common.py
+++ b/python/qemu/utils/qom_common.py
@@ -18,14 +18,7 @@
 import argparse
 import os
 import sys
-from typing import (
-    Any,
-    Dict,
-    List,
-    Optional,
-    Type,
-    TypeVar,
-)
+from typing import Any, Optional, TypeVar
 
 from qemu.qmp import QMPError
 from qemu.qmp.legacy import QEMUMonitorProtocol
@@ -44,7 +37,7 @@ def __init__(self, name: str, type_: str,
         self.default_value = default_value
 
     @classmethod
-    def make(cls, value: Dict[str, Any]) -> 'ObjectPropertyInfo':
+    def make(cls, value: dict[str, Any]) -> 'ObjectPropertyInfo':
         """
         Build an ObjectPropertyInfo from a Dict with an unknown shape.
         """
@@ -136,18 +129,18 @@ def run(self) -> int:
         """
         raise NotImplementedError
 
-    def qom_list(self, path: str) -> List[ObjectPropertyInfo]:
+    def qom_list(self, path: str) -> list[ObjectPropertyInfo]:
         """
         :return: a strongly typed list from the 'qom-list' command.
         """
         rsp = self.qmp.cmd('qom-list', path=path)
-        # qom-list returns List[ObjectPropertyInfo]
+        # qom-list returns list[ObjectPropertyInfo]
         assert isinstance(rsp, list)
         return [ObjectPropertyInfo.make(x) for x in rsp]
 
     @classmethod
     def command_runner(
-            cls: Type[CommandT],
+            cls: type[CommandT],
             args: argparse.Namespace
     ) -> int:
         """
diff --git a/python/qemu/utils/qom_fuse.py b/python/qemu/utils/qom_fuse.py
index cf7e344bd53..36819b7d623 100644
--- a/python/qemu/utils/qom_fuse.py
+++ b/python/qemu/utils/qom_fuse.py
@@ -38,7 +38,6 @@
 import sys
 from typing import (
     IO,
-    Dict,
     Iterator,
     Mapping,
     Optional,
@@ -79,7 +78,7 @@ def configure_parser(cls, parser: argparse.ArgumentParser) -> None:
     def __init__(self, args: argparse.Namespace):
         super().__init__(args)
         self.mount = args.mount
-        self.ino_map: Dict[str, int] = {}
+        self.ino_map: dict[str, int] = {}
         self.ino_count = 1
 
     def run(self) -> int:
diff --git a/python/scripts/mkvenv.py b/python/scripts/mkvenv.py
index 8ac5b0b2a05..d026ac17ff3 100644
--- a/python/scripts/mkvenv.py
+++ b/python/scripts/mkvenv.py
@@ -78,11 +78,9 @@
 from types import SimpleNamespace
 from typing import (
     Any,
-    Dict,
     Iterator,
     Optional,
     Sequence,
-    Tuple,
     Union,
 )
 import venv
@@ -510,7 +508,7 @@ def diagnose(
     online: bool,
     wheels_dir: Optional[Union[str, Path]],
     prog: Optional[str],
-) -> Tuple[str, bool]:
+) -> tuple[str, bool]:
     """
     Offer a summary to the user as to why a package failed to be installed.
 
@@ -623,7 +621,7 @@ def pip_install(
     )
 
 
-def _make_version_constraint(info: Dict[str, str], install: bool) -> str:
+def _make_version_constraint(info: dict[str, str], install: bool) -> str:
     """
     Construct the version constraint part of a PEP 508 dependency
     specification (for example '>=0.61.5') from the accepted and
@@ -648,10 +646,10 @@ def _make_version_constraint(info: Dict[str, str], install: bool) -> str:
 
 
 def _do_ensure(
-    group: Dict[str, Dict[str, str]],
+    group: dict[str, dict[str, str]],
     online: bool = False,
     wheels_dir: Optional[Union[str, Path]] = None,
-) -> Optional[Tuple[str, bool]]:
+) -> Optional[tuple[str, bool]]:
     """
     Use pip to ensure we have the packages specified in @group.
 
@@ -716,7 +714,7 @@ def _do_ensure(
     return None
 
 
-def _parse_groups(file: str) -> Dict[str, Dict[str, Any]]:
+def _parse_groups(file: str) -> dict[str, dict[str, Any]]:
     if not HAVE_TOMLLIB:
         if sys.version_info < (3, 11):
             raise Ouch("found no usable tomli, please install it")
@@ -756,7 +754,7 @@ def ensure_group(
 
     parsed_deps = _parse_groups(file)
 
-    to_install: Dict[str, Dict[str, str]] = {}
+    to_install: dict[str, dict[str, str]] = {}
     for group in groups:
         try:
             to_install.update(parsed_deps[group])
diff --git a/scripts/codeconverter/codeconverter/patching.py b/scripts/codeconverter/codeconverter/patching.py
index 9e92505d394..2646811b037 100644
--- a/scripts/codeconverter/codeconverter/patching.py
+++ b/scripts/codeconverter/codeconverter/patching.py
@@ -5,7 +5,7 @@
 #
 # This work is licensed under the terms of the GNU GPL, version 2.  See
 # the COPYING file in the top-level directory.
-from typing import IO, Match, NamedTuple, Optional, Literal, Iterable, Type, Dict, List, Any, TypeVar, NewType, Tuple, Union
+from typing import IO, Match, NamedTuple, Optional, Literal, Iterable, Any, TypeVar, NewType, Union
 from pathlib import Path
 from itertools import chain
 from tempfile import NamedTemporaryFile
@@ -181,14 +181,14 @@ def domatch(klass, content: str, pos=0, endpos=-1) -> Optional[Match]:
             content = content[:endpos]
         return klass.compiled_re().match(content, pos)
 
-    def group_finditer(self, klass: Type['FileMatch'], group: Union[str, int]) -> Iterable['FileMatch']:
+    def group_finditer(self, klass: type['FileMatch'], group: Union[str, int]) -> Iterable['FileMatch']:
         assert self.file.original_content
         return (klass(self.file, m)
                 for m in klass.finditer(self.file.original_content,
                                         self.match.start(group),
                                         self.match.end(group)))
 
-    def try_group_match(self, klass: Type['FileMatch'], group: Union[str, int]) -> Optional['FileMatch']:
+    def try_group_match(self, klass: type['FileMatch'], group: Union[str, int]) -> Optional['FileMatch']:
         assert self.file.original_content
         m = klass.domatch(self.file.original_content,
                           self.match.start(group),
@@ -213,12 +213,12 @@ class FullMatch(FileMatch):
     """
     regexp = r'(?s).*' # (?s) is re.DOTALL
 
-def all_subclasses(c: Type[FileMatch]) -> Iterable[Type[FileMatch]]:
+def all_subclasses(c: type[FileMatch]) -> Iterable[type[FileMatch]]:
     for sc in c.__subclasses__():
         yield sc
         yield from all_subclasses(sc)
 
-def match_class_dict() -> Dict[str, Type[FileMatch]]:
+def match_class_dict() -> dict[str, type[FileMatch]]:
     d = dict((t.__name__, t) for t in all_subclasses(FileMatch))
     return d
 
@@ -239,7 +239,7 @@ def apply_patches(s: str, patches: Iterable[Patch]) -> str:
     """
     r = StringIO()
     last = 0
-    def patch_sort_key(item: Tuple[int, Patch]) -> Tuple[int, int, int]:
+    def patch_sort_key(item: tuple[int, Patch]) -> tuple[int, int, int]:
         """Patches are sorted by byte position,
         patches at the same byte position are applied in the order
         they were generated.
@@ -263,22 +263,22 @@ def patch_sort_key(item: Tuple[int, Patch]) -> Tuple[int, int, int]:
 
 class RegexpScanner:
     def __init__(self) -> None:
-        self.match_index: Dict[Type[Any], List[FileMatch]] = {}
-        self.match_name_index: Dict[Tuple[Type[Any], str, str], Optional[FileMatch]] = {}
+        self.match_index: dict[type[Any], list[FileMatch]] = {}
+        self.match_name_index: dict[tuple[type[Any], str, str], Optional[FileMatch]] = {}
 
-    def _matches_of_type(self, klass: Type[Any]) -> Iterable[FileMatch]:
+    def _matches_of_type(self, klass: type[Any]) -> Iterable[FileMatch]:
         raise NotImplementedError()
 
-    def matches_of_type(self, t: Type[T]) -> List[T]:
+    def matches_of_type(self, t: type[T]) -> list[T]:
         if t not in self.match_index:
             self.match_index[t] = list(self._matches_of_type(t))
         return self.match_index[t] # type: ignore
 
-    def find_matches(self, t: Type[T], name: str, group: str='name') -> List[T]:
+    def find_matches(self, t: type[T], name: str, group: str='name') -> list[T]:
         indexkey = (t, name, group)
         if indexkey in self.match_name_index:
             return self.match_name_index[indexkey] # type: ignore
-        r: List[T] = []
+        r: list[T] = []
         for m in self.matches_of_type(t):
             assert isinstance(m, FileMatch)
             if m.getgroup(group) == name:
@@ -286,7 +286,7 @@ def find_matches(self, t: Type[T], name: str, group: str='name') -> List[T]:
         self.match_name_index[indexkey] = r # type: ignore
         return r
 
-    def find_match(self, t: Type[T], name: str, group: str='name') -> Optional[T]:
+    def find_match(self, t: type[T], name: str, group: str='name') -> Optional[T]:
         l = self.find_matches(t, name, group)
         if not l:
             return None
@@ -307,7 +307,7 @@ def __init__(self, files: 'FileList', filename: os.PathLike, force:bool=False) -
         super().__init__()
         self.allfiles = files
         self.filename = Path(filename)
-        self.patches: List[Patch] = []
+        self.patches: list[Patch] = []
         self.force = force
 
     def __repr__(self) -> str:
@@ -321,7 +321,7 @@ def line_col(self, start: int) -> LineAndColumn:
         """Return line and column for a match object inside original_content"""
         return line_col(self.original_content, start)
 
-    def _matches_of_type(self, klass: Type[Any]) -> List[FileMatch]:
+    def _matches_of_type(self, klass: type[Any]) -> list[FileMatch]:
         """Build FileMatch objects for each match of regexp"""
         if not hasattr(klass, 'regexp') or klass.regexp is None:
             return []
@@ -333,7 +333,7 @@ def _matches_of_type(self, klass: Type[Any]) -> List[FileMatch]:
             klass.__name__,' '.join(names(matches)))
         return matches
 
-    def find_match(self, t: Type[T], name: str, group: str='name') -> Optional[T]:
+    def find_match(self, t: type[T], name: str, group: str='name') -> Optional[T]:
         for m in self.matches_of_type(t):
             assert isinstance(m, FileMatch)
             if m.getgroup(group) == name:
@@ -358,7 +358,7 @@ def all_matches(self) -> Iterable[FileMatch]:
         return (m for l in lists
                   for m in l)
 
-    def gen_patches(self, matches: List[FileMatch]) -> None:
+    def gen_patches(self, matches: list[FileMatch]) -> None:
         for m in matches:
             DBG("Generating patches for %r", m)
             for i,p in enumerate(m.gen_patches()):
@@ -367,7 +367,7 @@ def gen_patches(self, matches: List[FileMatch]) -> None:
                     self.line_col(p.start), self.line_col(p.end), p.replacement)
                 self.patches.append(p)
 
-    def scan_for_matches(self, class_names: Optional[List[str]]=None) -> Iterable[FileMatch]:
+    def scan_for_matches(self, class_names: Optional[list[str]]=None) -> Iterable[FileMatch]:
         DBG("class names: %r", class_names)
         class_dict = match_class_dict()
         if class_names is None:
@@ -413,7 +413,7 @@ def ref(self):
 class FileList(RegexpScanner):
     def __init__(self):
         super().__init__()
-        self.files: List[FileInfo] = []
+        self.files: list[FileInfo] = []
 
     def extend(self, *args, **kwargs):
         self.files.extend(*args, **kwargs)
@@ -421,7 +421,7 @@ def extend(self, *args, **kwargs):
     def __iter__(self):
         return iter(self.files)
 
-    def _matches_of_type(self, klass: Type[Any]) -> Iterable[FileMatch]:
+    def _matches_of_type(self, klass: type[Any]) -> Iterable[FileMatch]:
         return chain(*(f._matches_of_type(klass) for f in self.files))
 
     def find_file(self, name: str) -> Optional[FileInfo]:
@@ -432,7 +432,7 @@ def find_file(self, name: str) -> Optional[FileInfo]:
         else:
             return None
 
-    def one_pass(self, class_names: List[str]) -> int:
+    def one_pass(self, class_names: list[str]) -> int:
         total_patches = 0
         for f in self.files:
             INFO("Scanning file %s", f.filename)
@@ -448,7 +448,7 @@ def one_pass(self, class_names: List[str]) -> int:
                     logger.exception("%s: failed to patch file", f.filename)
         return total_patches
 
-    def patch_content(self, max_passes, class_names: List[str]) -> None:
+    def patch_content(self, max_passes, class_names: list[str]) -> None:
         """Multi-pass content patching loop
 
         We run multiple passes because there are rules that will
diff --git a/scripts/codeconverter/codeconverter/qom_macros.py b/scripts/codeconverter/codeconverter/qom_macros.py
index 2b0c8224a18..9942c6274c8 100644
--- a/scripts/codeconverter/codeconverter/qom_macros.py
+++ b/scripts/codeconverter/codeconverter/qom_macros.py
@@ -68,7 +68,7 @@ def __str__(self) -> str:
         s = ', '.join('%s=%s' % (f,v) for f,v in values if v is not None)
         return f'{s}'
 
-    def check_consistency(self) -> List[str]:
+    def check_consistency(self) -> list[str]:
         """Check if identifiers are consistent with each other,
         return list of problems (or empty list if everything seems consistent)
         """
@@ -235,7 +235,7 @@ def find_typedef(f: FileInfo, name: Optional[str]) -> Optional[TypedefMatch]:
         NAMED('qom_typename', RE_IDENTIFIER), r'\s*\)\n',
         n='?', name='check_args'))
 
-EXPECTED_CHECKER_SUFFIXES: List[Tuple[CheckerMacroName, str]] = [
+EXPECTED_CHECKER_SUFFIXES: list[tuple[CheckerMacroName, str]] = [
     ('OBJECT_GET_CLASS', '_GET_CLASS'),
     ('OBJECT_CLASS_CHECK', '_CLASS'),
 ]
@@ -267,7 +267,7 @@ def sanity_check(self) -> None:
         if self.typedefname and self.find_typedef() is None:
             self.warn("typedef used by %s not found", self.name)
 
-    def find_matching_macros(self) -> List['TypeCheckMacro']:
+    def find_matching_macros(self) -> list['TypeCheckMacro']:
         """Find other check macros that generate the same macro names
 
         The returned list will always be sorted.
@@ -280,7 +280,7 @@ def find_matching_macros(self) -> List['TypeCheckMacro']:
                    and (my_ids.uppercase == m.type_identifiers.uppercase
                         or my_ids.typename == m.type_identifiers.typename)]
 
-    def merge_ids(self, matches: List['TypeCheckMacro']) -> Optional[TypeIdentifiers]:
+    def merge_ids(self, matches: list['TypeCheckMacro']) -> Optional[TypeIdentifiers]:
         """Try to merge info about type identifiers from all matches in a list"""
         if not matches:
             return None
@@ -580,10 +580,10 @@ def gen_patches(self) -> Iterable[Patch]:
             return
 
         # group checkers by uppercase name:
-        decl_types: List[Type[TypeDeclaration]] = [DeclareInstanceChecker, DeclareInstanceType,
+        decl_types: list[type[TypeDeclaration]] = [DeclareInstanceChecker, DeclareInstanceType,
                                                    DeclareClassCheckers, DeclareClassType,
                                                    DeclareObjCheckers]
-        checker_dict: Dict[str, List[TypeDeclaration]] = {}
+        checker_dict: dict[str, list[TypeDeclaration]] = {}
         for t in decl_types:
             for m in self.file.matches_of_type(t):
                 checker_dict.setdefault(m.group('uppercase'), []).append(m)
@@ -602,9 +602,9 @@ def gen_patches(self) -> Iterable[Patch]:
             field_dict = dict((f, v.pop() if v else None) for f,v in fvalues.items())
             yield from self.gen_patches_for_type(uppercase, checkers, field_dict)
 
-    def find_conflicts(self, uppercase: str, checkers: List[TypeDeclaration]) -> bool:
+    def find_conflicts(self, uppercase: str, checkers: list[TypeDeclaration]) -> bool:
         """Look for conflicting declarations that would make it unsafe to add new ones"""
-        conflicting: List[FileMatch] = []
+        conflicting: list[FileMatch] = []
         # conflicts in the same file:
         conflicting.extend(chain(self.file.find_matches(DefineDirective, uppercase),
                                  self.file.find_matches(DeclareInterfaceChecker, uppercase, 'uppercase'),
@@ -633,8 +633,8 @@ def find_conflicts(self, uppercase: str, checkers: List[TypeDeclaration]) -> boo
         return False
 
     def gen_patches_for_type(self, uppercase: str,
-                             checkers: List[TypeDeclaration],
-                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+                             checkers: list[TypeDeclaration],
+                             fields: dict[str, Optional[str]]) -> Iterable[Patch]:
         """Should be reimplemented by subclasses"""
         return
         yield
@@ -643,8 +643,8 @@ class DeclareVoidTypes(TypeDeclarationFixup):
     """Add DECLARE_*_TYPE(..., void) when there's no declared type"""
     regexp = RE_FILE_BEGIN
     def gen_patches_for_type(self, uppercase: str,
-                             checkers: List[TypeDeclaration],
-                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+                             checkers: list[TypeDeclaration],
+                             fields: dict[str, Optional[str]]) -> Iterable[Patch]:
         if self.find_conflicts(uppercase, checkers):
             return
 
@@ -671,8 +671,8 @@ def gen_patches_for_type(self, uppercase: str,
 class AddDeclareTypeName(TypeDeclarationFixup):
     """Add DECLARE_TYPE_NAME declarations if necessary"""
     def gen_patches_for_type(self, uppercase: str,
-                             checkers: List[TypeDeclaration],
-                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+                             checkers: list[TypeDeclaration],
+                             fields: dict[str, Optional[str]]) -> Iterable[Patch]:
         typename = fields.get('typename')
         if typename is None:
             self.warn("typename unavailable")
@@ -753,7 +753,7 @@ def find_typename_uppercase(files: FileList, typename: str) -> Optional[str]:
 
 def find_type_checkers(files:FileList, name:str, group:str='uppercase') -> Iterable[TypeCheckerDeclaration]:
     """Find usage of DECLARE*CHECKER macro"""
-    c: Type[TypeCheckerDeclaration]
+    c: type[TypeCheckerDeclaration]
     for c in (DeclareInstanceChecker, DeclareClassCheckers, DeclareObjCheckers, ObjectDeclareType, ObjectDeclareSimpleType):
         yield from files.find_matches(c, name=name, group=group)
 
@@ -774,8 +774,8 @@ class InitialIncludes(FileMatch):
                  n='*', name='includes'))
 
 class SymbolUserList(NamedTuple):
-    definitions: List[FileMatch]
-    users: List[FileMatch]
+    definitions: list[FileMatch]
+    users: list[FileMatch]
 
 class MoveSymbols(FileMatch):
     """Handle missing symbols
@@ -789,7 +789,7 @@ def gen_patches(self) -> Iterator[Patch]:
             self.debug("skipping object.h")
             return
 
-        index: Dict[RequiredIdentifier, SymbolUserList] = {}
+        index: dict[RequiredIdentifier, SymbolUserList] = {}
         definition_classes = [SimpleTypedefMatch, FullStructTypedefMatch, ConstantDefine, Include]
         user_classes = [TypeCheckMacro, DeclareObjCheckers, DeclareInstanceChecker, DeclareClassCheckers, InterfaceCheckMacro]
 
diff --git a/scripts/codeconverter/codeconverter/qom_type_info.py b/scripts/codeconverter/codeconverter/qom_type_info.py
index 22a25560760..efcf791f3cf 100644
--- a/scripts/codeconverter/codeconverter/qom_type_info.py
+++ b/scripts/codeconverter/codeconverter/qom_type_info.py
@@ -25,7 +25,7 @@
 RE_TYPEINFO_START = S(r'^[ \t]*', M(r'(static|const)\s+', name='modifiers'), r'TypeInfo\s+',
                       NAMED('name', RE_IDENTIFIER), r'\s*=\s*{[ \t]*\n')
 
-ParsedArray = List[str]
+ParsedArray = list[str]
 ParsedInitializerValue = Union[str, ParsedArray]
 class InitializerValue(NamedTuple):
     raw: str
@@ -59,7 +59,7 @@ def parsed(self) -> ParsedInitializerValue:
             return array.parsed()
         return parsed
 
-TypeInfoInitializers = Dict[str, FieldInitializer]
+TypeInfoInitializers = dict[str, FieldInitializer]
 
 class TypeDefinition(FileMatch):
     """
@@ -343,7 +343,7 @@ def gen_patches(self) -> Iterable[Patch]:
 
         ok = True
 
-        #checkers: List[TypeCheckerDeclaration] = list(find_type_checkers(self.allfiles, uppercase))
+        #checkers: list[TypeCheckerDeclaration] = list(find_type_checkers(self.allfiles, uppercase))
         #for c in checkers:
         #    c.info("instance type checker declaration (%s) is here", c.group('uppercase'))
         #if not checkers:
@@ -448,7 +448,7 @@ class ObjectDefineType(TypeDefinition):
                r'\s*\);?\n?')
 
 def find_type_definitions(files: FileList, uppercase: str) -> Iterable[TypeDefinition]:
-    types: List[Type[TypeDefinition]] = [TypeInfoVar, ObjectDefineType, ObjectDefineTypeExtended]
+    types: list[type[TypeDefinition]] = [TypeInfoVar, ObjectDefineType, ObjectDefineTypeExtended]
     for t in types:
         for m in files.matches_of_type(t):
             m.debug("uppercase: %s", m.uppercase)
@@ -459,8 +459,8 @@ def find_type_definitions(files: FileList, uppercase: str) -> Iterable[TypeDefin
 class AddDeclareVoidClassType(TypeDeclarationFixup):
     """Will add DECLARE_CLASS_TYPE(..., void) if possible"""
     def gen_patches_for_type(self, uppercase: str,
-                             checkers: List[TypeDeclaration],
-                             fields: Dict[str, Optional[str]]) -> Iterable[Patch]:
+                             checkers: list[TypeDeclaration],
+                             fields: dict[str, Optional[str]]) -> Iterable[Patch]:
         defs = list(find_type_definitions(self.allfiles, uppercase))
         if len(defs) > 1:
             self.warn("multiple definitions for %s", uppercase)
@@ -554,7 +554,7 @@ def gen_patches(self) -> Iterable[Patch]:
             if not self.file.force:
                 return
 
-        decl_types: List[Type[TypeDeclaration]] = [DeclareClassCheckers, DeclareObjCheckers]
+        decl_types: list[type[TypeDeclaration]] = [DeclareClassCheckers, DeclareObjCheckers]
         class_decls = [m for t in decl_types
                        for m in self.allfiles.find_matches(t, uppercase, 'uppercase')]
 
@@ -634,7 +634,7 @@ def gen_patches(self) -> Iterable[Patch]:
             if not self.file.force:
                 return
 
-        decl_types: List[Type[TypeDeclaration]] = [DeclareClassCheckers, DeclareObjCheckers]
+        decl_types: list[type[TypeDeclaration]] = [DeclareClassCheckers, DeclareObjCheckers]
         class_decls = [m for t in decl_types
                        for m in self.allfiles.find_matches(t, uppercase, 'uppercase')]
         if class_decls:
diff --git a/scripts/compare-machine-types.py b/scripts/compare-machine-types.py
index 2af3995eb82..b47ab058645 100755
--- a/scripts/compare-machine-types.py
+++ b/scripts/compare-machine-types.py
@@ -31,7 +31,7 @@
 from argparse import ArgumentParser, RawTextHelpFormatter, Namespace
 import pandas as pd
 from contextlib import ExitStack
-from typing import Optional, List, Dict, Generator, Tuple, Union, Any, Set
+from typing import Optional, Generator, Union, Any
 
 try:
     qemu_dir = path.abspath(path.dirname(path.dirname(__file__)))
@@ -81,7 +81,7 @@ def is_child_of(self, parent: 'Driver') -> bool:
 
         return False
 
-    def set_implementations(self, implementations: List['Driver']) -> None:
+    def set_implementations(self, implementations: list['Driver']) -> None:
         self.implementations = implementations
 
 
@@ -89,7 +89,7 @@ class QEMUObject(Driver):
     def __init__(self, vm: QEMUMachine, name: str) -> None:
         super().__init__(vm, name, True)
 
-    def set_implementations(self, implementations: List[Driver]) -> None:
+    def set_implementations(self, implementations: list[Driver]) -> None:
         self.implementations = implementations
 
         # each implementation of the abstract driver has to use property getter
@@ -105,7 +105,7 @@ def set_implementations(self, implementations: List[Driver]) -> None:
 class QEMUDevice(QEMUObject):
     def __init__(self, vm: QEMUMachine) -> None:
         super().__init__(vm, 'device')
-        self.cached: Dict[str, List[Dict[str, Any]]] = {}
+        self.cached: dict[str, list[dict[str, Any]]] = {}
 
     def get_prop(self, driver: str, prop_name: str) -> str:
         if driver not in self.cached:
@@ -121,7 +121,7 @@ def get_prop(self, driver: str, prop_name: str) -> str:
 class QEMUx86CPU(QEMUObject):
     def __init__(self, vm: QEMUMachine) -> None:
         super().__init__(vm, 'x86_64-cpu')
-        self.cached: Dict[str, Dict[str, Any]] = {}
+        self.cached: dict[str, dict[str, Any]] = {}
 
     def get_prop(self, driver: str, prop_name: str) -> str:
         if not driver.endswith('-x86_64-cpu'):
@@ -141,7 +141,7 @@ def get_prop(self, driver: str, prop_name: str) -> str:
 class QEMUMemoryBackend(QEMUObject):
     def __init__(self, vm: QEMUMachine) -> None:
         super().__init__(vm, 'memory-backend')
-        self.cached: Dict[str, List[Dict[str, Any]]] = {}
+        self.cached: dict[str, list[dict[str, Any]]] = {}
 
     def get_prop(self, driver: str, prop_name: str) -> str:
         if driver not in self.cached:
@@ -172,7 +172,7 @@ class VMPropertyGetter:
     """It implements the relationship between drivers and how to get their
     properties"""
     def __init__(self, vm: QEMUMachine) -> None:
-        self.drivers: Dict[str, Driver] = {}
+        self.drivers: dict[str, Driver] = {}
 
         qom_all_types = vm.cmd('qom-list-types', abstract=True)
         self.drivers = {t['name']: new_driver(vm, t['name'],
@@ -201,7 +201,7 @@ def get_prop(self, driver: str, prop: str) -> str:
 
         return drv.get_prop(driver, prop)
 
-    def get_implementations(self, driver: str) -> List[str]:
+    def get_implementations(self, driver: str) -> list[str]:
         return [impl.name for impl in self.drivers[driver].implementations]
 
 
@@ -211,10 +211,10 @@ class Machine:
     implementations)
     """
     # raw_mt_dict - dict produced by `query-machines`
-    def __init__(self, raw_mt_dict: Dict[str, Any],
+    def __init__(self, raw_mt_dict: dict[str, Any],
                  qemu_drivers: VMPropertyGetter) -> None:
         self.name = raw_mt_dict['name']
-        self.compat_props: Dict[str, Any] = {}
+        self.compat_props: dict[str, Any] = {}
         # properties are applied sequentially and can rewrite values like in
         # QEMU. Also it has to resolve class relationships to apply appropriate
         # values from abstract class to all implementations
@@ -239,7 +239,7 @@ class Configuration():
     """Class contains all necessary components to generate table and is used
     to compare different binaries"""
     def __init__(self, vm: QEMUMachine,
-                 req_mt: List[str], all_mt: bool) -> None:
+                 req_mt: list[str], all_mt: bool) -> None:
         self._vm = vm
         self._binary = vm.binary
         self._qemu_args = args.qemu_args.split(' ')
@@ -247,11 +247,11 @@ def __init__(self, vm: QEMUMachine,
         self._qemu_drivers = VMPropertyGetter(vm)
         self.req_mt = get_req_mt(self._qemu_drivers, vm, req_mt, all_mt)
 
-    def get_implementations(self, driver_name: str) -> List[str]:
+    def get_implementations(self, driver_name: str) -> list[str]:
         return self._qemu_drivers.get_implementations(driver_name)
 
-    def get_table(self, req_props: List[Tuple[str, str]]) -> pd.DataFrame:
-        table: List[pd.DataFrame] = []
+    def get_table(self, req_props: list[tuple[str, str]]) -> pd.DataFrame:
+        table: list[pd.DataFrame] = []
         for mt in self.req_mt:
             name = f'{self._binary}\n{mt.name}'
             column = []
@@ -339,7 +339,7 @@ def parse_args() -> Namespace:
     return parser.parse_args()
 
 
-def mt_comp(mt: Machine) -> Tuple[str, int, int, int]:
+def mt_comp(mt: Machine) -> tuple[str, int, int, int]:
     """Function to compare and sort machine by names.
     It returns socket_name, major version, minor version, revision"""
     # none, microvm, x-remote and etc.
@@ -353,7 +353,7 @@ def mt_comp(mt: Machine) -> Tuple[str, int, int, int]:
 
 
 def get_mt_definitions(qemu_drivers: VMPropertyGetter,
-                       vm: QEMUMachine) -> List[Machine]:
+                       vm: QEMUMachine) -> list[Machine]:
     """Constructs list of machine definitions (primarily compat_props) via
     info from QEMU"""
     raw_mt_defs = vm.cmd('query-machines', compat_props=True)
@@ -366,7 +366,7 @@ def get_mt_definitions(qemu_drivers: VMPropertyGetter,
 
 
 def get_req_mt(qemu_drivers: VMPropertyGetter, vm: QEMUMachine,
-               req_mt: Optional[List[str]], all_mt: bool) -> List[Machine]:
+               req_mt: Optional[list[str]], all_mt: bool) -> list[Machine]:
     """Returns list of requested by user machines"""
     mt_defs = get_mt_definitions(qemu_drivers, vm)
     if all_mt:
@@ -384,12 +384,12 @@ def get_req_mt(qemu_drivers: VMPropertyGetter, vm: QEMUMachine,
     return matched_mt
 
 
-def get_affected_props(configs: List[Configuration]) -> Generator[Tuple[str,
+def get_affected_props(configs: list[Configuration]) -> Generator[tuple[str,
                                                                         str],
                                                                   None, None]:
     """Helps to go through all affected in machine definitions drivers
     and properties"""
-    driver_props: Dict[str, Set[Any]] = {}
+    driver_props: dict[str, set[Any]] = {}
     for config in configs:
         for mt in config.req_mt:
             compat_props = mt.compat_props
@@ -437,7 +437,7 @@ def simplify_table(table: pd.DataFrame) -> pd.DataFrame:
 # driver2 | property3 |  value5  |  value6  | ...
 #   ...   |    ...    |   ...    |   ...    | ...
 #
-def fill_prop_table(configs: List[Configuration],
+def fill_prop_table(configs: list[Configuration],
                     is_raw: bool) -> pd.DataFrame:
     req_props = list(get_affected_props(configs))
     if not req_props:
diff --git a/scripts/qapi/commands.py b/scripts/qapi/commands.py
index 79142273828..cd3a665319a 100644
--- a/scripts/qapi/commands.py
+++ b/scripts/qapi/commands.py
@@ -13,12 +13,7 @@
 See the COPYING file in the top-level directory.
 """
 
-from typing import (
-    Dict,
-    List,
-    Optional,
-    Set,
-)
+from typing import Optional
 
 from .common import c_name, mcgen
 from .gen import (
@@ -276,7 +271,7 @@ def gen_marshal(name: str,
 
 
 def gen_register_command(name: str,
-                         features: List[QAPISchemaFeature],
+                         features: list[QAPISchemaFeature],
                          success_response: bool,
                          allow_oob: bool,
                          allow_preconfig: bool,
@@ -308,7 +303,7 @@ def __init__(self, prefix: str, gen_tracing: bool):
             prefix, 'qapi-commands',
             ' * Schema-defined QAPI/QMP commands', None, __doc__,
             gen_tracing=gen_tracing)
-        self._visited_ret_types: Dict[QAPIGenC, Set[QAPISchemaType]] = {}
+        self._visited_ret_types: dict[QAPIGenC, set[QAPISchemaType]] = {}
         self._gen_tracing = gen_tracing
 
     def _begin_user_module(self, name: str) -> None:
@@ -375,7 +370,7 @@ def visit_command(self,
                       name: str,
                       info: Optional[QAPISourceInfo],
                       ifcond: QAPISchemaIfCond,
-                      features: List[QAPISchemaFeature],
+                      features: list[QAPISchemaFeature],
                       arg_type: Optional[QAPISchemaObjectType],
                       ret_type: Optional[QAPISchemaType],
                       gen: bool,
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index d7c8aa3365c..2c55b70a8bd 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -14,7 +14,6 @@
 import re
 from typing import (
     Any,
-    Dict,
     Match,
     Optional,
     Sequence,
@@ -199,11 +198,11 @@ def guardend(name: str) -> str:
                  name=c_fname(name).upper())
 
 
-def gen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]],
+def gen_ifcond(ifcond: Optional[Union[str, dict[str, Any]]],
                cond_fmt: str, not_fmt: str,
                all_operator: str, any_operator: str) -> str:
 
-    def do_gen(ifcond: Union[str, Dict[str, Any]],
+    def do_gen(ifcond: Union[str, dict[str, Any]],
                need_parens: bool) -> str:
         if isinstance(ifcond, str):
             return cond_fmt % ifcond
@@ -226,11 +225,11 @@ def gen_infix(operator: str, operands: Sequence[Any]) -> str:
     return do_gen(ifcond, False)
 
 
-def cgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
+def cgen_ifcond(ifcond: Optional[Union[str, dict[str, Any]]]) -> str:
     return gen_ifcond(ifcond, 'defined(%s)', '!%s', ' && ', ' || ')
 
 
-def docgen_ifcond(ifcond: Optional[Union[str, Dict[str, Any]]]) -> str:
+def docgen_ifcond(ifcond: Optional[Union[str, dict[str, Any]]]) -> str:
     # TODO Doc generated for conditions needs polish
     return gen_ifcond(ifcond, '%s', 'not %s', ' and ', ' or ')
 
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index d179b0ed695..8584d69f33a 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -12,7 +12,7 @@
 See the COPYING file in the top-level directory.
 """
 
-from typing import List, Optional
+from typing import Optional
 
 from .common import c_enum_const, c_name, mcgen
 from .gen import QAPISchemaModularCVisitor, build_params, ifcontext
@@ -80,7 +80,7 @@ def gen_param_var(typ: QAPISchemaObjectType) -> str:
 
 def gen_event_send(name: str,
                    arg_type: Optional[QAPISchemaObjectType],
-                   features: List[QAPISchemaFeature],
+                   features: list[QAPISchemaFeature],
                    boxed: bool,
                    event_enum_name: str,
                    event_emit: str) -> str:
@@ -180,7 +180,7 @@ def __init__(self, prefix: str):
             prefix, 'qapi-events',
             ' * Schema-defined QAPI/QMP events', None, __doc__)
         self._event_enum_name = c_name(prefix + 'QAPIEvent', protect=False)
-        self._event_enum_members: List[QAPISchemaEnumMember] = []
+        self._event_enum_members: list[QAPISchemaEnumMember] = []
         self._event_emit_name = c_name(prefix + 'qapi_event_emit')
 
     def _begin_user_module(self, name: str) -> None:
@@ -230,7 +230,7 @@ def visit_event(self,
                     name: str,
                     info: Optional[QAPISourceInfo],
                     ifcond: QAPISchemaIfCond,
-                    features: List[QAPISchemaFeature],
+                    features: list[QAPISchemaFeature],
                     arg_type: Optional[QAPISchemaObjectType],
                     boxed: bool) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
diff --git a/scripts/qapi/expr.py b/scripts/qapi/expr.py
index cae0a083591..144e3dfaa32 100644
--- a/scripts/qapi/expr.py
+++ b/scripts/qapi/expr.py
@@ -33,9 +33,7 @@
 
 import re
 from typing import (
-    Dict,
     Iterable,
-    List,
     Optional,
     Union,
     cast,
@@ -183,11 +181,11 @@ def check_defn_name_str(name: str, info: QAPISourceInfo, meta: str) -> None:
                 info, "%s name should not end in 'List'" % meta)
 
 
-def check_keys(value: Dict[str, object],
+def check_keys(value: dict[str, object],
                info: QAPISourceInfo,
                source: str,
-               required: List[str],
-               optional: List[str]) -> None:
+               required: list[str],
+               optional: list[str]) -> None:
     """
     Ensure that a dict has a specific set of keys.
 
@@ -247,7 +245,7 @@ def check_flags(expr: QAPIExpression) -> None:
             expr.info, "flags 'allow-oob' and 'coroutine' are incompatible")
 
 
-def check_if(expr: Dict[str, object],
+def check_if(expr: dict[str, object],
              info: QAPISourceInfo, source: str) -> None:
     """
     Validate the ``if`` member of an object.
@@ -319,8 +317,8 @@ def normalize_members(members: object) -> None:
     ``{'type': value}``.
 
     :forms:
-      :sugared: ``Dict[str, Union[str, TypeRef]]``
-      :canonical: ``Dict[str, TypeRef]``
+      :sugared: ``dict[str, Union[str, TypeRef]]``
+      :canonical: ``dict[str, TypeRef]``
 
     :param members: The members value to normalize.
 
@@ -416,8 +414,8 @@ def check_features(features: Optional[object],
     Any ``str`` element will be normalized to ``{'name': element}``.
 
     :forms:
-      :sugared: ``List[Union[str, Feature]]``
-      :canonical: ``List[Feature]``
+      :sugared: ``list[Union[str, Feature]]``
+      :canonical: ``list[Feature]``
 
     :param features: The features member value to validate.
     :param info: QAPI schema source file information.
@@ -592,7 +590,7 @@ def check_event(expr: QAPIExpression) -> None:
         check_type_name_or_implicit(args, expr.info, "'data'", None)
 
 
-def check_exprs(exprs: List[QAPIExpression]) -> List[QAPIExpression]:
+def check_exprs(exprs: list[QAPIExpression]) -> list[QAPIExpression]:
     """
     Validate and normalize a list of parsed QAPI schema expressions.
 
diff --git a/scripts/qapi/gen.py b/scripts/qapi/gen.py
index d3c56d45c89..53b267228e5 100644
--- a/scripts/qapi/gen.py
+++ b/scripts/qapi/gen.py
@@ -15,13 +15,7 @@
 import os
 import re
 import sys
-from typing import (
-    Dict,
-    Iterator,
-    Optional,
-    Sequence,
-    Tuple,
-)
+from typing import Iterator, Optional, Sequence
 
 from .common import (
     c_enum_const,
@@ -136,7 +130,7 @@ def build_params(arg_type: Optional[QAPISchemaObjectType],
 class QAPIGenCCode(QAPIGen):
     def __init__(self, fname: str):
         super().__init__(fname)
-        self._start_if: Optional[Tuple[QAPISchemaIfCond, str, str]] = None
+        self._start_if: Optional[tuple[QAPISchemaIfCond, str, str]] = None
 
     def start_if(self, ifcond: QAPISchemaIfCond) -> None:
         assert self._start_if is None
@@ -264,7 +258,7 @@ def __init__(self,
         self._builtin_blurb = builtin_blurb
         self._pydoc = pydoc
         self._current_module: Optional[str] = None
-        self._module: Dict[str, Tuple[QAPIGenC, QAPIGenH,
+        self._module: dict[str, tuple[QAPIGenC, QAPIGenH,
                                       Optional[QAPIGenTrace]]] = {}
         self._main_module: Optional[str] = None
         self._gen_tracing = gen_tracing
diff --git a/scripts/qapi/introspect.py b/scripts/qapi/introspect.py
index 89ee5d5f176..037ed35d3f4 100644
--- a/scripts/qapi/introspect.py
+++ b/scripts/qapi/introspect.py
@@ -14,9 +14,7 @@
 from dataclasses import dataclass
 from typing import (
     Any,
-    Dict,
     Generic,
-    List,
     Optional,
     Sequence,
     TypeVar,
@@ -52,7 +50,7 @@
 # Un-annotated values may be:
 #     Scalar: str, bool, None.
 #     Non-scalar: List, Dict
-# _value = Union[str, bool, None, Dict[str, JSONValue], List[JSONValue]]
+# _value = Union[str, bool, None, dict[str, JSONValue], list[JSONValue]]
 #
 # With optional annotations, the type of all values is:
 # JSONValue = Union[_Value, Annotated[_Value]]
@@ -61,7 +59,7 @@
 # mark the imprecision in the type model where we'd otherwise use JSONValue.
 _Stub = Any
 _Scalar = Union[str, bool, None]
-_NonScalar = Union[Dict[str, _Stub], List[_Stub]]
+_NonScalar = Union[dict[str, _Stub], list[_Stub]]
 _Value = Union[_Scalar, _NonScalar]
 JSONValue = Union[_Value, 'Annotated[_Value]']
 
@@ -69,12 +67,12 @@
 # lack precise types for them here. Python 3.6 does not offer
 # TypedDict constructs, so they are broadly typed here as simple
 # Python Dicts.
-SchemaInfo = Dict[str, object]
-SchemaInfoEnumMember = Dict[str, object]
-SchemaInfoObject = Dict[str, object]
-SchemaInfoObjectVariant = Dict[str, object]
-SchemaInfoObjectMember = Dict[str, object]
-SchemaInfoCommand = Dict[str, object]
+SchemaInfo = dict[str, object]
+SchemaInfoEnumMember = dict[str, object]
+SchemaInfoObject = dict[str, object]
+SchemaInfoObjectVariant = dict[str, object]
+SchemaInfoObjectMember = dict[str, object]
+SchemaInfoCommand = dict[str, object]
 
 
 _ValueT = TypeVar('_ValueT', bound=_Value)
@@ -175,9 +173,9 @@ def __init__(self, prefix: str, unmask: bool):
             ' * QAPI/QMP schema introspection', __doc__)
         self._unmask = unmask
         self._schema: Optional[QAPISchema] = None
-        self._trees: List[Annotated[SchemaInfo]] = []
-        self._used_types: List[QAPISchemaType] = []
-        self._name_map: Dict[str, str] = {}
+        self._trees: list[Annotated[SchemaInfo]] = []
+        self._used_types: list[QAPISchemaType] = []
+        self._name_map: dict[str, str] = {}
         self._genc.add(mcgen('''
 #include "qemu/osdep.h"
 #include "%(prefix)sqapi-introspect.h"
@@ -248,10 +246,10 @@ def _use_type(self, typ: QAPISchemaType) -> str:
 
     @staticmethod
     def _gen_features(features: Sequence[QAPISchemaFeature]
-                      ) -> List[Annotated[str]]:
+                      ) -> list[Annotated[str]]:
         return [Annotated(f.name, f.ifcond) for f in features]
 
-    def _gen_tree(self, name: str, mtype: str, obj: Dict[str, object],
+    def _gen_tree(self, name: str, mtype: str, obj: dict[str, object],
                   ifcond: QAPISchemaIfCond = QAPISchemaIfCond(),
                   features: Sequence[QAPISchemaFeature] = ()) -> None:
         """
@@ -313,8 +311,8 @@ def visit_builtin_type(self, name: str, info: Optional[QAPISourceInfo],
 
     def visit_enum_type(self, name: str, info: Optional[QAPISourceInfo],
                         ifcond: QAPISchemaIfCond,
-                        features: List[QAPISchemaFeature],
-                        members: List[QAPISchemaEnumMember],
+                        features: list[QAPISchemaFeature],
+                        members: list[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
         self._gen_tree(
             name, 'enum',
@@ -332,8 +330,8 @@ def visit_array_type(self, name: str, info: Optional[QAPISourceInfo],
 
     def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
                                ifcond: QAPISchemaIfCond,
-                               features: List[QAPISchemaFeature],
-                               members: List[QAPISchemaObjectTypeMember],
+                               features: list[QAPISchemaFeature],
+                               members: list[QAPISchemaObjectTypeMember],
                                branches: Optional[QAPISchemaBranches]) -> None:
         obj: SchemaInfoObject = {
             'members': [self._gen_object_member(m) for m in members]
@@ -345,7 +343,7 @@ def visit_object_type_flat(self, name: str, info: Optional[QAPISourceInfo],
 
     def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
-                             features: List[QAPISchemaFeature],
+                             features: list[QAPISchemaFeature],
                              alternatives: QAPISchemaAlternatives) -> None:
         self._gen_tree(
             name, 'alternate',
@@ -357,7 +355,7 @@ def visit_alternate_type(self, name: str, info: Optional[QAPISourceInfo],
 
     def visit_command(self, name: str, info: Optional[QAPISourceInfo],
                       ifcond: QAPISchemaIfCond,
-                      features: List[QAPISchemaFeature],
+                      features: list[QAPISchemaFeature],
                       arg_type: Optional[QAPISchemaObjectType],
                       ret_type: Optional[QAPISchemaType], gen: bool,
                       success_response: bool, boxed: bool, allow_oob: bool,
@@ -376,7 +374,7 @@ def visit_command(self, name: str, info: Optional[QAPISourceInfo],
 
     def visit_event(self, name: str, info: Optional[QAPISourceInfo],
                     ifcond: QAPISchemaIfCond,
-                    features: List[QAPISchemaFeature],
+                    features: list[QAPISchemaFeature],
                     arg_type: Optional[QAPISchemaObjectType],
                     boxed: bool) -> None:
         assert self._schema is not None
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 949d9e8bff7..1475e92a208 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -20,12 +20,9 @@
 from typing import (
     TYPE_CHECKING,
     Any,
-    Dict,
-    List,
     Mapping,
     Match,
     Optional,
-    Set,
     Union,
 )
 
@@ -41,10 +38,10 @@
 
 
 # Return value alias for get_expr().
-_ExprValue = Union[List[object], Dict[str, object], str, bool]
+_ExprValue = Union[list[object], dict[str, object], str, bool]
 
 
-class QAPIExpression(Dict[str, Any]):
+class QAPIExpression(dict[str, Any]):
     # pylint: disable=too-few-public-methods
     def __init__(self,
                  data: Mapping[str, object],
@@ -91,7 +88,7 @@ class QAPISchemaParser:
     """
     def __init__(self,
                  fname: str,
-                 previously_included: Optional[Set[str]] = None,
+                 previously_included: Optional[set[str]] = None,
                  incl_info: Optional[QAPISourceInfo] = None):
         self._fname = fname
         self._included = previously_included or set()
@@ -107,8 +104,8 @@ def __init__(self,
         self.line_pos = 0
 
         # Parser output:
-        self.exprs: List[QAPIExpression] = []
-        self.docs: List[QAPIDoc] = []
+        self.exprs: list[QAPIExpression] = []
+        self.docs: list[QAPIDoc] = []
 
         # Showtime!
         self._parse()
@@ -195,7 +192,7 @@ def reject_expr_doc(doc: Optional['QAPIDoc']) -> None:
     def _include(include: str,
                  info: QAPISourceInfo,
                  incl_fname: str,
-                 previously_included: Set[str]
+                 previously_included: set[str]
                  ) -> Optional['QAPISchemaParser']:
         incl_abs_fname = os.path.abspath(incl_fname)
         # catch inclusion cycle
@@ -220,7 +217,7 @@ def _include(include: str,
     @staticmethod
     def _pragma(name: str, value: object, info: QAPISourceInfo) -> None:
 
-        def check_list_str(name: str, value: object) -> List[str]:
+        def check_list_str(name: str, value: object) -> list[str]:
             if (not isinstance(value, list) or
                     any(not isinstance(elt, str) for elt in value)):
                 raise QAPISemError(
@@ -354,8 +351,8 @@ def accept(self, skip_comment: bool = True) -> None:
                                    self.src[self.cursor-1:])
                 raise QAPIParseError(self, "stray '%s'" % match.group(0))
 
-    def get_members(self) -> Dict[str, object]:
-        expr: Dict[str, object] = {}
+    def get_members(self) -> dict[str, object]:
+        expr: dict[str, object] = {}
         if self.tok == '}':
             self.accept()
             return expr
@@ -381,8 +378,8 @@ def get_members(self) -> Dict[str, object]:
             if self.tok != "'":
                 raise QAPIParseError(self, "expected string")
 
-    def get_values(self) -> List[object]:
-        expr: List[object] = []
+    def get_values(self) -> list[object]:
+        expr: list[object] = []
         if self.tok == ']':
             self.accept()
             return expr
@@ -694,21 +691,21 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # definition doc's symbol, None for free-form doc
         self.symbol: Optional[str] = symbol
         # the sections in textual order
-        self.all_sections: List[QAPIDoc.Section] = [
+        self.all_sections: list[QAPIDoc.Section] = [
             QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
         ]
         # the body section
         self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
         # dicts mapping parameter/feature names to their description
-        self.args: Dict[str, QAPIDoc.ArgSection] = {}
-        self.features: Dict[str, QAPIDoc.ArgSection] = {}
+        self.args: dict[str, QAPIDoc.ArgSection] = {}
+        self.features: dict[str, QAPIDoc.ArgSection] = {}
         # a command's "Returns" and "Errors" section
         self.returns: Optional[QAPIDoc.Section] = None
         self.errors: Optional[QAPIDoc.Section] = None
         # "Since" section
         self.since: Optional[QAPIDoc.Section] = None
         # sections other than .body, .args, .features
-        self.sections: List[QAPIDoc.Section] = []
+        self.sections: list[QAPIDoc.Section] = []
 
     def end(self) -> None:
         for section in self.all_sections:
@@ -763,7 +760,7 @@ def _new_description(
         info: QAPISourceInfo,
         name: str,
         kind: 'QAPIDoc.Kind',
-        desc: Dict[str, ArgSection]
+        desc: dict[str, ArgSection]
     ) -> None:
         if not name:
             raise QAPISemError(info, "invalid parameter name")
@@ -834,7 +831,7 @@ def check_expr(self, expr: QAPIExpression) -> None:
     def check(self) -> None:
 
         def check_args_section(
-                args: Dict[str, QAPIDoc.ArgSection], what: str
+                args: dict[str, QAPIDoc.ArgSection], what: str
         ) -> None:
             bogus = [name for name, section in args.items()
                      if not section.member]
diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index cbe3b5aa91e..aaeb7b202f8 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -24,8 +24,6 @@
 from typing import (
     Any,
     Callable,
-    Dict,
-    List,
     Optional,
     Union,
     ValuesView,
@@ -49,7 +47,7 @@
 class QAPISchemaIfCond:
     def __init__(
         self,
-        ifcond: Optional[Union[str, Dict[str, object]]] = None,
+        ifcond: Optional[Union[str, dict[str, object]]] = None,
     ) -> None:
         self.ifcond = ifcond
 
@@ -121,7 +119,7 @@ def __init__(
         info: Optional[QAPISourceInfo],
         doc: Optional[QAPIDoc],
         ifcond: Optional[QAPISchemaIfCond] = None,
-        features: Optional[List[QAPISchemaFeature]] = None,
+        features: Optional[list[QAPISchemaFeature]] = None,
     ):
         super().__init__(info)
         for f in features or []:
@@ -141,7 +139,7 @@ def c_name(self) -> str:
     def check(self, schema: QAPISchema) -> None:
         assert not self._checked
         super().check(schema)
-        seen: Dict[str, QAPISchemaMember] = {}
+        seen: dict[str, QAPISchemaMember] = {}
         for f in self.features:
             f.check_clash(self.info, seen)
 
@@ -192,8 +190,8 @@ def visit_enum_type(
         name: str,
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
-        members: List[QAPISchemaEnumMember],
+        features: list[QAPISchemaFeature],
+        members: list[QAPISchemaEnumMember],
         prefix: Optional[str],
     ) -> None:
         pass
@@ -212,9 +210,9 @@ def visit_object_type(
         name: str,
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
+        features: list[QAPISchemaFeature],
         base: Optional[QAPISchemaObjectType],
-        members: List[QAPISchemaObjectTypeMember],
+        members: list[QAPISchemaObjectTypeMember],
         branches: Optional[QAPISchemaBranches],
     ) -> None:
         pass
@@ -224,8 +222,8 @@ def visit_object_type_flat(
         name: str,
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
-        members: List[QAPISchemaObjectTypeMember],
+        features: list[QAPISchemaFeature],
+        members: list[QAPISchemaObjectTypeMember],
         branches: Optional[QAPISchemaBranches],
     ) -> None:
         pass
@@ -235,7 +233,7 @@ def visit_alternate_type(
         name: str,
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
+        features: list[QAPISchemaFeature],
         alternatives: QAPISchemaAlternatives,
     ) -> None:
         pass
@@ -245,7 +243,7 @@ def visit_command(
         name: str,
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
+        features: list[QAPISchemaFeature],
         arg_type: Optional[QAPISchemaObjectType],
         ret_type: Optional[QAPISchemaType],
         gen: bool,
@@ -262,7 +260,7 @@ def visit_event(
         name: str,
         info: Optional[QAPISourceInfo],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
+        features: list[QAPISchemaFeature],
         arg_type: Optional[QAPISchemaObjectType],
         boxed: bool,
     ) -> None:
@@ -275,7 +273,7 @@ class QAPISchemaModule:
 
     def __init__(self, name: str):
         self.name = name
-        self._entity_list: List[QAPISchemaEntity] = []
+        self._entity_list: list[QAPISchemaEntity] = []
 
     @staticmethod
     def is_system_module(name: str) -> bool:
@@ -418,8 +416,8 @@ def __init__(
         info: Optional[QAPISourceInfo],
         doc: Optional[QAPIDoc],
         ifcond: Optional[QAPISchemaIfCond],
-        features: Optional[List[QAPISchemaFeature]],
-        members: List[QAPISchemaEnumMember],
+        features: Optional[list[QAPISchemaFeature]],
+        members: list[QAPISchemaEnumMember],
         prefix: Optional[str],
     ):
         super().__init__(name, info, doc, ifcond, features)
@@ -430,7 +428,7 @@ def __init__(
 
     def check(self, schema: QAPISchema) -> None:
         super().check(schema)
-        seen: Dict[str, QAPISchemaMember] = {}
+        seen: dict[str, QAPISchemaMember] = {}
         for m in self.members:
             m.check_clash(self.info, seen)
 
@@ -447,7 +445,7 @@ def is_implicit(self) -> bool:
     def c_type(self) -> str:
         return c_name(self.name)
 
-    def member_names(self) -> List[str]:
+    def member_names(self) -> list[str]:
         return [m.name for m in self.members]
 
     def json_type(self) -> str:
@@ -521,9 +519,9 @@ def __init__(
         info: Optional[QAPISourceInfo],
         doc: Optional[QAPIDoc],
         ifcond: Optional[QAPISchemaIfCond],
-        features: Optional[List[QAPISchemaFeature]],
+        features: Optional[list[QAPISchemaFeature]],
         base: Optional[str],
-        local_members: List[QAPISchemaObjectTypeMember],
+        local_members: list[QAPISchemaObjectTypeMember],
         branches: Optional[QAPISchemaBranches],
     ):
         # struct has local_members, optional base, and no branches
@@ -538,7 +536,7 @@ def __init__(
         self.base = None
         self.local_members = local_members
         self.branches = branches
-        self.members: List[QAPISchemaObjectTypeMember]
+        self.members: list[QAPISchemaObjectTypeMember]
         self._check_complete = False
 
     def check(self, schema: QAPISchema) -> None:
@@ -573,9 +571,9 @@ def check(self, schema: QAPISchema) -> None:
             m.check_clash(self.info, seen)
 
         # self.check_clash() works in terms of the supertype, but
-        # self.members is declared List[QAPISchemaObjectTypeMember].
+        # self.members is declared list[QAPISchemaObjectTypeMember].
         # Cast down to the subtype.
-        members = cast(List[QAPISchemaObjectTypeMember], list(seen.values()))
+        members = cast(list[QAPISchemaObjectTypeMember], list(seen.values()))
 
         if self.branches:
             self.branches.check(schema, seen)
@@ -590,7 +588,7 @@ def check(self, schema: QAPISchema) -> None:
     def check_clash(
         self,
         info: Optional[QAPISourceInfo],
-        seen: Dict[str, QAPISchemaMember],
+        seen: dict[str, QAPISchemaMember],
     ) -> None:
         assert self._checked
         for m in self.members:
@@ -650,7 +648,7 @@ def __init__(
         info: QAPISourceInfo,
         doc: Optional[QAPIDoc],
         ifcond: Optional[QAPISchemaIfCond],
-        features: List[QAPISchemaFeature],
+        features: list[QAPISchemaFeature],
         alternatives: QAPISchemaAlternatives,
     ):
         super().__init__(name, info, doc, ifcond, features)
@@ -667,8 +665,8 @@ def check(self, schema: QAPISchema) -> None:
         self.alternatives.check(schema, {})
         # Alternate branch names have no relation to the tag enum values;
         # so we have to check for potential name collisions ourselves.
-        seen: Dict[str, QAPISchemaMember] = {}
-        types_seen: Dict[str, str] = {}
+        seen: dict[str, QAPISchemaMember] = {}
+        types_seen: dict[str, str] = {}
         for v in self.alternatives.variants:
             v.check_clash(self.info, seen)
             qtype = v.type.alternate_qtype()
@@ -720,7 +718,7 @@ class QAPISchemaVariants:
     def __init__(
         self,
         info: QAPISourceInfo,
-        variants: List[QAPISchemaVariant],
+        variants: list[QAPISchemaVariant],
     ):
         self.info = info
         self.tag_member: QAPISchemaObjectTypeMember
@@ -732,7 +730,7 @@ def set_defined_in(self, name: str) -> None:
 
     # pylint: disable=unused-argument
     def check(
-            self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
+            self, schema: QAPISchema, seen: dict[str, QAPISchemaMember]
     ) -> None:
         for v in self.variants:
             v.check(schema)
@@ -741,13 +739,13 @@ def check(
 class QAPISchemaBranches(QAPISchemaVariants):
     def __init__(self,
                  info: QAPISourceInfo,
-                 variants: List[QAPISchemaVariant],
+                 variants: list[QAPISchemaVariant],
                  tag_name: str):
         super().__init__(info, variants)
         self._tag_name = tag_name
 
     def check(
-            self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
+            self, schema: QAPISchema, seen: dict[str, QAPISchemaMember]
     ) -> None:
         # We need to narrow the member type:
         tag_member = seen.get(c_name(self._tag_name))
@@ -815,7 +813,7 @@ def check(
     def check_clash(
         self,
         info: Optional[QAPISourceInfo],
-        seen: Dict[str, QAPISchemaMember],
+        seen: dict[str, QAPISchemaMember],
     ) -> None:
         for v in self.variants:
             # Reset seen map for each variant, since qapi names from one
@@ -829,13 +827,13 @@ def check_clash(
 class QAPISchemaAlternatives(QAPISchemaVariants):
     def __init__(self,
                  info: QAPISourceInfo,
-                 variants: List[QAPISchemaVariant],
+                 variants: list[QAPISchemaVariant],
                  tag_member: QAPISchemaObjectTypeMember):
         super().__init__(info, variants)
         self.tag_member = tag_member
 
     def check(
-            self, schema: QAPISchema, seen: Dict[str, QAPISchemaMember]
+            self, schema: QAPISchema, seen: dict[str, QAPISchemaMember]
     ) -> None:
         super().check(schema, seen)
         assert isinstance(self.tag_member.type, QAPISchemaEnumType)
@@ -865,7 +863,7 @@ def set_defined_in(self, name: str) -> None:
     def check_clash(
         self,
         info: Optional[QAPISourceInfo],
-        seen: Dict[str, QAPISchemaMember],
+        seen: dict[str, QAPISchemaMember],
     ) -> None:
         cname = c_name(self.name)
         if cname in seen:
@@ -916,7 +914,7 @@ def __init__(
         name: str,
         info: Optional[QAPISourceInfo],
         ifcond: Optional[QAPISchemaIfCond] = None,
-        features: Optional[List[QAPISchemaFeature]] = None,
+        features: Optional[list[QAPISchemaFeature]] = None,
     ):
         super().__init__(name, info, ifcond)
         for f in features or []:
@@ -948,7 +946,7 @@ def __init__(
         typ: str,
         optional: bool,
         ifcond: Optional[QAPISchemaIfCond] = None,
-        features: Optional[List[QAPISchemaFeature]] = None,
+        features: Optional[list[QAPISchemaFeature]] = None,
     ):
         super().__init__(name, info, ifcond)
         for f in features or []:
@@ -965,7 +963,7 @@ def check(self, schema: QAPISchema) -> None:
         assert self.defined_in
         self.type = schema.resolve_type(self._type_name, self.info,
                                         self.describe)
-        seen: Dict[str, QAPISchemaMember] = {}
+        seen: dict[str, QAPISchemaMember] = {}
         for f in self.features:
             f.check_clash(self.info, seen)
 
@@ -998,7 +996,7 @@ def __init__(
         info: QAPISourceInfo,
         doc: Optional[QAPIDoc],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
+        features: list[QAPISchemaFeature],
         arg_type: Optional[str],
         ret_type: Optional[str],
         gen: bool,
@@ -1080,7 +1078,7 @@ def __init__(
         info: QAPISourceInfo,
         doc: Optional[QAPIDoc],
         ifcond: QAPISchemaIfCond,
-        features: List[QAPISchemaFeature],
+        features: list[QAPISchemaFeature],
         arg_type: Optional[str],
         boxed: bool,
     ):
@@ -1138,12 +1136,12 @@ def __init__(self, fname: str):
 
         exprs = check_exprs(parser.exprs)
         self.docs = parser.docs
-        self._entity_list: List[QAPISchemaEntity] = []
-        self._entity_dict: Dict[str, QAPISchemaDefinition] = {}
-        self._module_dict: Dict[str, QAPISchemaModule] = {}
+        self._entity_list: list[QAPISchemaEntity] = []
+        self._entity_dict: dict[str, QAPISchemaDefinition] = {}
+        self._module_dict: dict[str, QAPISchemaModule] = {}
         # NB, values in the dict will identify the first encountered
         # usage of a named feature only
-        self._feature_dict: Dict[str, QAPISchemaFeature] = {}
+        self._feature_dict: dict[str, QAPISchemaFeature] = {}
 
         # All schemas get the names defined in the QapiSpecialFeature enum.
         # Rely on dict iteration order matching insertion order so that
@@ -1269,9 +1267,9 @@ def _def_predefineds(self) -> None:
 
     def _make_features(
         self,
-        features: Optional[List[Dict[str, Any]]],
+        features: Optional[list[dict[str, Any]]],
         info: Optional[QAPISourceInfo],
-    ) -> List[QAPISchemaFeature]:
+    ) -> list[QAPISchemaFeature]:
         if features is None:
             return []
 
@@ -1287,8 +1285,8 @@ def _make_features(
     def _make_enum_member(
         self,
         name: str,
-        ifcond: Optional[Union[str, Dict[str, Any]]],
-        features: Optional[List[Dict[str, Any]]],
+        ifcond: Optional[Union[str, dict[str, Any]]],
+        features: Optional[list[dict[str, Any]]],
         info: Optional[QAPISourceInfo],
     ) -> QAPISchemaEnumMember:
         return QAPISchemaEnumMember(name, info,
@@ -1296,8 +1294,8 @@ def _make_enum_member(
                                     self._make_features(features, info))
 
     def _make_enum_members(
-        self, values: List[Dict[str, Any]], info: Optional[QAPISourceInfo]
-    ) -> List[QAPISchemaEnumMember]:
+        self, values: list[dict[str, Any]], info: Optional[QAPISourceInfo]
+    ) -> list[QAPISchemaEnumMember]:
         return [self._make_enum_member(v['name'], v.get('if'),
                                        v.get('features'), info)
                 for v in values]
@@ -1317,7 +1315,7 @@ def _make_implicit_object_type(
         info: QAPISourceInfo,
         ifcond: QAPISchemaIfCond,
         role: str,
-        members: List[QAPISchemaObjectTypeMember],
+        members: list[QAPISchemaObjectTypeMember],
     ) -> Optional[str]:
         if not members:
             return None
@@ -1348,9 +1346,9 @@ def _def_enum_type(self, expr: QAPIExpression) -> None:
     def _make_member(
         self,
         name: str,
-        typ: Union[List[str], str],
+        typ: Union[list[str], str],
         ifcond: QAPISchemaIfCond,
-        features: Optional[List[Dict[str, Any]]],
+        features: Optional[list[dict[str, Any]]],
         info: QAPISourceInfo,
     ) -> QAPISchemaObjectTypeMember:
         optional = False
@@ -1365,9 +1363,9 @@ def _make_member(
 
     def _make_members(
         self,
-        data: Dict[str, Any],
+        data: dict[str, Any],
         info: QAPISourceInfo,
-    ) -> List[QAPISchemaObjectTypeMember]:
+    ) -> list[QAPISchemaObjectTypeMember]:
         return [self._make_member(key, value['type'],
                                   QAPISchemaIfCond(value.get('if')),
                                   value.get('features'), info)
@@ -1415,7 +1413,7 @@ def _def_union_type(self, expr: QAPIExpression) -> None:
                                QAPISchemaIfCond(value.get('if')),
                                info)
             for (key, value) in data.items()]
-        members: List[QAPISchemaObjectTypeMember] = []
+        members: list[QAPISchemaObjectTypeMember] = []
         self._def_definition(
             QAPISchemaObjectType(name, info, expr.doc, ifcond, features,
                                  base, members,
@@ -1479,7 +1477,7 @@ def _def_event(self, expr: QAPIExpression) -> None:
         self._def_definition(QAPISchemaEvent(name, info, expr.doc, ifcond,
                                              features, data, boxed))
 
-    def _def_exprs(self, exprs: List[QAPIExpression]) -> None:
+    def _def_exprs(self, exprs: list[QAPIExpression]) -> None:
         for expr in exprs:
             if 'enum' in expr:
                 self._def_enum_type(expr)
diff --git a/scripts/qapi/source.py b/scripts/qapi/source.py
index ffdc3f482ac..960fe58a5ff 100644
--- a/scripts/qapi/source.py
+++ b/scripts/qapi/source.py
@@ -10,7 +10,7 @@
 # See the COPYING file in the top-level directory.
 
 import copy
-from typing import List, Optional, TypeVar
+from typing import Optional, TypeVar
 
 
 class QAPISchemaPragma:
@@ -21,13 +21,13 @@ def __init__(self) -> None:
         # Are documentation comments required?
         self.doc_required = False
         # Commands whose names may use '_'
-        self.command_name_exceptions: List[str] = []
+        self.command_name_exceptions: list[str] = []
         # Commands allowed to return a non-dictionary
-        self.command_returns_exceptions: List[str] = []
+        self.command_returns_exceptions: list[str] = []
         # Types, commands, and events with undocumented members
-        self.documentation_exceptions: List[str] = []
+        self.documentation_exceptions: list[str] = []
         # Types whose member names may violate case conventions
-        self.member_name_exceptions: List[str] = []
+        self.member_name_exceptions: list[str] = []
 
 
 class QAPISourceInfo:
diff --git a/scripts/qapi/types.py b/scripts/qapi/types.py
index 2bf75338283..ad84e68b488 100644
--- a/scripts/qapi/types.py
+++ b/scripts/qapi/types.py
@@ -13,7 +13,7 @@
 # See the COPYING file in the top-level directory.
 """
 
-from typing import List, Optional
+from typing import Optional
 
 from .common import c_enum_const, c_name, mcgen
 from .gen import QAPISchemaModularCVisitor, gen_features, ifcontext
@@ -38,7 +38,7 @@
 
 
 def gen_enum_lookup(name: str,
-                    members: List[QAPISchemaEnumMember],
+                    members: list[QAPISchemaEnumMember],
                     prefix: Optional[str] = None) -> str:
     max_index = c_enum_const(name, '_MAX', prefix)
     feats = ''
@@ -82,7 +82,7 @@ def gen_enum_lookup(name: str,
 
 
 def gen_enum(name: str,
-             members: List[QAPISchemaEnumMember],
+             members: list[QAPISchemaEnumMember],
              prefix: Optional[str] = None) -> str:
     # append automatically generated _MAX value
     enum_members = members + [QAPISchemaEnumMember('_MAX', None)]
@@ -136,7 +136,7 @@ def gen_array(name: str, element_type: QAPISchemaType) -> str:
                  c_name=c_name(name), c_type=element_type.c_type())
 
 
-def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
+def gen_struct_members(members: list[QAPISchemaObjectTypeMember]) -> str:
     ret = ''
     for memb in members:
         ret += memb.ifcond.gen_if()
@@ -155,7 +155,7 @@ def gen_struct_members(members: List[QAPISchemaObjectTypeMember]) -> str:
 
 def gen_object(name: str, ifcond: QAPISchemaIfCond,
                base: Optional[QAPISchemaObjectType],
-               members: List[QAPISchemaObjectTypeMember],
+               members: list[QAPISchemaObjectTypeMember],
                variants: Optional[QAPISchemaVariants]) -> str:
     if name in objects_seen:
         return ''
@@ -325,8 +325,8 @@ def visit_enum_type(self,
                         name: str,
                         info: Optional[QAPISourceInfo],
                         ifcond: QAPISchemaIfCond,
-                        features: List[QAPISchemaFeature],
-                        members: List[QAPISchemaEnumMember],
+                        features: list[QAPISchemaFeature],
+                        members: list[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.preamble_add(gen_enum(name, members, prefix))
@@ -346,9 +346,9 @@ def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
                           ifcond: QAPISchemaIfCond,
-                          features: List[QAPISchemaFeature],
+                          features: list[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
-                          members: List[QAPISchemaObjectTypeMember],
+                          members: list[QAPISchemaObjectTypeMember],
                           branches: Optional[QAPISchemaBranches]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
@@ -369,7 +369,7 @@ def visit_alternate_type(self,
                              name: str,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
-                             features: List[QAPISchemaFeature],
+                             features: list[QAPISchemaFeature],
                              alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh):
             self._genh.preamble_add(gen_fwd_object_or_array(name))
diff --git a/scripts/qapi/visit.py b/scripts/qapi/visit.py
index 36e240967b6..a0221fe5ab8 100644
--- a/scripts/qapi/visit.py
+++ b/scripts/qapi/visit.py
@@ -13,7 +13,7 @@
 See the COPYING file in the top-level directory.
 """
 
-from typing import List, Optional
+from typing import Optional
 
 from .common import (
     c_enum_const,
@@ -59,7 +59,7 @@ def gen_visit_members_decl(name: str) -> str:
 
 def gen_visit_object_members(name: str,
                              base: Optional[QAPISchemaObjectType],
-                             members: List[QAPISchemaObjectTypeMember],
+                             members: list[QAPISchemaObjectTypeMember],
                              branches: Optional[QAPISchemaBranches]) -> str:
     ret = mcgen('''
 
@@ -370,8 +370,8 @@ def visit_enum_type(self,
                         name: str,
                         info: Optional[QAPISourceInfo],
                         ifcond: QAPISchemaIfCond,
-                        features: List[QAPISchemaFeature],
-                        members: List[QAPISchemaEnumMember],
+                        features: list[QAPISchemaFeature],
+                        members: list[QAPISchemaEnumMember],
                         prefix: Optional[str]) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name, scalar=True))
@@ -390,9 +390,9 @@ def visit_object_type(self,
                           name: str,
                           info: Optional[QAPISourceInfo],
                           ifcond: QAPISchemaIfCond,
-                          features: List[QAPISchemaFeature],
+                          features: list[QAPISchemaFeature],
                           base: Optional[QAPISchemaObjectType],
-                          members: List[QAPISchemaObjectTypeMember],
+                          members: list[QAPISchemaObjectTypeMember],
                           branches: Optional[QAPISchemaBranches]) -> None:
         # Nothing to do for the special empty builtin
         if name == 'q_empty':
@@ -412,7 +412,7 @@ def visit_alternate_type(self,
                              name: str,
                              info: Optional[QAPISourceInfo],
                              ifcond: QAPISchemaIfCond,
-                             features: List[QAPISchemaFeature],
+                             features: list[QAPISchemaFeature],
                              alternatives: QAPISchemaAlternatives) -> None:
         with ifcontext(ifcond, self._genh, self._genc):
             self._genh.add(gen_visit_decl(name))
diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
index 2633157df2a..5de6079b9a0 100644
--- a/scripts/rust/rustc_args.py
+++ b/scripts/rust/rustc_args.py
@@ -28,7 +28,7 @@
 from dataclasses import dataclass
 import logging
 from pathlib import Path
-from typing import Any, Iterable, List, Mapping, Optional, Set
+from typing import Any, Iterable, Mapping, Optional
 
 try:
     import tomllib
@@ -41,7 +41,7 @@
 class CargoTOML:
     tomldata: Mapping[Any, Any]
     workspace_data: Mapping[Any, Any]
-    check_cfg: Set[str]
+    check_cfg: set[str]
 
     def __init__(self, path: Optional[str], workspace: Optional[str]):
         if path is not None:
@@ -78,7 +78,7 @@ def get_table(self, key: str, can_be_workspace: bool = False) -> Mapping[Any, An
 
 @dataclass
 class LintFlag:
-    flags: List[str]
+    flags: list[str]
     priority: int
 
 
diff --git a/scripts/u2f-setup-gen.py b/scripts/u2f-setup-gen.py
index 2122598fed8..677530dbe9c 100755
--- a/scripts/u2f-setup-gen.py
+++ b/scripts/u2f-setup-gen.py
@@ -12,7 +12,6 @@
 import sys
 import os
 from random import randint
-from typing import Tuple
 
 from cryptography.hazmat.backends import default_backend
 from cryptography.hazmat.primitives.asymmetric import ec
@@ -53,7 +52,7 @@ def write_setup_dir(dirpath: str, privkey_pem: bytes, cert_pem: bytes,
         f.write(f'{str(counter)}\n')
 
 
-def generate_ec_key_pair() -> Tuple[str, str]:
+def generate_ec_key_pair() -> tuple[str, str]:
     """
     Generate an ec key pair.
 
diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
index 631b77abf6b..3b9f5f286a1 100644
--- a/tests/functional/qemu_test/ports.py
+++ b/tests/functional/qemu_test/ports.py
@@ -12,7 +12,6 @@
 import socket
 
 from .config import BUILD_DIR
-from typing import List
 
 
 class Ports():
@@ -41,7 +40,7 @@ def check_bind(self, port: int) -> bool:
 
         return True
 
-    def find_free_ports(self, count: int) -> List[int]:
+    def find_free_ports(self, count: int) -> list[int]:
         result = []
         for port in range(self.PORTS_START, self.PORTS_END):
             if self.check_bind(port):
diff --git a/tests/functional/test_acpi_bits.py b/tests/functional/test_acpi_bits.py
index 8e0563a97b1..b9ca6a9b162 100755
--- a/tests/functional/test_acpi_bits.py
+++ b/tests/functional/test_acpi_bits.py
@@ -37,7 +37,6 @@
 import subprocess
 
 from typing import (
-    List,
     Optional,
     Sequence,
 )
@@ -76,7 +75,7 @@ def __init__(self,
         self.base_temp_dir = base_temp_dir
 
     @property
-    def _base_args(self) -> List[str]:
+    def _base_args(self) -> list[str]:
         args = super()._base_args
         args.extend([
             '-chardev',
diff --git a/tests/qemu-iotests/151 b/tests/qemu-iotests/151
index f2ff9c5dac2..5cb462b79a3 100755
--- a/tests/qemu-iotests/151
+++ b/tests/qemu-iotests/151
@@ -23,7 +23,7 @@ import math
 import os
 import subprocess
 import time
-from typing import List, Optional
+from typing import Optional
 import iotests
 from iotests import qemu_img
 
@@ -195,7 +195,7 @@ class TestActiveMirror(iotests.QMPTestCase):
 class TestThrottledWithNbdExportBase(iotests.QMPTestCase):
     image_len = 128 * 1024 * 1024  # MB
     iops: Optional[int] = None
-    background_processes: List['subprocess.Popen[str]'] = []
+    background_processes: list['subprocess.Popen[str]'] = []
 
     def setUp(self):
         # Must be set by subclasses
diff --git a/tests/qemu-iotests/297 b/tests/qemu-iotests/297
index ee78a627359..505905b775b 100755
--- a/tests/qemu-iotests/297
+++ b/tests/qemu-iotests/297
@@ -19,7 +19,6 @@
 import os
 import subprocess
 import sys
-from typing import List
 
 import iotests
 import linters
@@ -41,7 +40,7 @@ def check_linter(linter: str) -> bool:
     return True
 
 
-def test_pylint(files: List[str]) -> None:
+def test_pylint(files: list[str]) -> None:
     print('=== pylint ===')
     sys.stdout.flush()
 
@@ -51,7 +50,7 @@ def test_pylint(files: List[str]) -> None:
     linters.run_linter('pylint', files)
 
 
-def test_mypy(files: List[str]) -> None:
+def test_mypy(files: list[str]) -> None:
     print('=== mypy ===')
     sys.stdout.flush()
 
diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
index e46616d7b19..9d5fd74920a 100755
--- a/tests/qemu-iotests/300
+++ b/tests/qemu-iotests/300
@@ -22,12 +22,12 @@
 import os
 import random
 import re
-from typing import Dict, List, Optional
+from typing import Optional
 
 import iotests
 
 
-BlockBitmapMapping = List[Dict[str, object]]
+BlockBitmapMapping = list[dict[str, object]]
 
 mig_sock = os.path.join(iotests.sock_dir, 'mig_sock')
 
diff --git a/tests/qemu-iotests/fat16.py b/tests/qemu-iotests/fat16.py
index 7d2d0524133..a2c69b3a54d 100644
--- a/tests/qemu-iotests/fat16.py
+++ b/tests/qemu-iotests/fat16.py
@@ -15,7 +15,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 
-from typing import Callable, List, Optional, Protocol, Set
+from typing import Callable, Optional, Protocol
 import string
 
 SECTOR_SIZE = 512
@@ -227,7 +227,7 @@ def __init__(
         self.fats = self.read_sectors(
             self.boot_sector.reserved_sectors, fat_size_in_sectors
         )
-        self.fats_dirty_sectors: Set[int] = set()
+        self.fats_dirty_sectors: set[int] = set()
 
     def read_sectors(self, start_sector: int, num_sectors: int) -> bytes:
         return self.sector_reader(start_sector + self.start_sector,
@@ -238,7 +238,7 @@ def write_sectors(self, start_sector: int, data: bytes) -> None:
 
     def directory_from_bytes(
         self, data: bytes, start_sector: int
-    ) -> List[FatDirectoryEntry]:
+    ) -> list[FatDirectoryEntry]:
         """
         Convert `bytes` into a list of `FatDirectoryEntry` objects.
         Will ignore long file names.
@@ -268,7 +268,7 @@ def directory_from_bytes(
             )
         return entries
 
-    def read_root_directory(self) -> List[FatDirectoryEntry]:
+    def read_root_directory(self) -> list[FatDirectoryEntry]:
         root_dir = self.read_sectors(
             self.boot_sector.root_dir_start(), self.boot_sector.root_dir_size()
         )
@@ -373,7 +373,7 @@ def write_cluster(self, cluster: int, data: bytes) -> None:
 
     def read_directory(
         self, cluster: Optional[int]
-    ) -> List[FatDirectoryEntry]:
+    ) -> list[FatDirectoryEntry]:
         """
         Read the directory at the given cluster.
         """
diff --git a/tests/qemu-iotests/findtests.py b/tests/qemu-iotests/findtests.py
index dd77b453b8a..11531bdca7b 100644
--- a/tests/qemu-iotests/findtests.py
+++ b/tests/qemu-iotests/findtests.py
@@ -21,7 +21,7 @@
 import re
 from collections import defaultdict
 from contextlib import contextmanager
-from typing import Optional, List, Iterator, Set
+from typing import Optional, Iterator
 
 
 @contextmanager
@@ -89,10 +89,10 @@ def parse_test_name(self, name: str) -> str:
 
         return name
 
-    def find_tests(self, groups: Optional[List[str]] = None,
-                   exclude_groups: Optional[List[str]] = None,
-                   tests: Optional[List[str]] = None,
-                   start_from: Optional[str] = None) -> List[str]:
+    def find_tests(self, groups: Optional[list[str]] = None,
+                   exclude_groups: Optional[list[str]] = None,
+                   tests: Optional[list[str]] = None,
+                   start_from: Optional[str] = None) -> list[str]:
         """Find tests
 
         Algorithm:
@@ -123,7 +123,7 @@ def find_tests(self, groups: Optional[List[str]] = None,
         if tests is None:
             tests = []
 
-        res: Set[str] = set()
+        res: set[str] = set()
         if groups:
             # Some groups specified. exclude_groups supported, additionally
             # selecting some individual tests supported as well.
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7292c8b342a..49a6bbc4cde 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -31,8 +31,8 @@
 import subprocess
 import sys
 import time
-from typing import (Any, Callable, Dict, Iterable, Iterator,
-                    List, Optional, Sequence, TextIO, Tuple, Type, TypeVar)
+from typing import (Any, Callable, Iterable, Iterator,
+                    Optional, Sequence, TextIO, TypeVar)
 import unittest
 
 from contextlib import contextmanager
@@ -154,7 +154,7 @@ def qemu_tool_popen(args: Sequence[str],
 def qemu_tool_pipe_and_status(tool: str, args: Sequence[str],
                               connect_stderr: bool = True,
                               drop_successful_output: bool = False) \
-        -> Tuple[str, int]:
+        -> tuple[str, int]:
     """
     Run a tool and return both its output and its exit code
     """
@@ -168,7 +168,7 @@ def qemu_tool_pipe_and_status(tool: str, args: Sequence[str],
             output = ''
         return (output, subp.returncode)
 
-def qemu_img_create_prepare_args(args: List[str]) -> List[str]:
+def qemu_img_create_prepare_args(args: list[str]) -> list[str]:
     if not args or args[0] != 'create':
         return list(args)
     args = args[1:]
@@ -344,7 +344,7 @@ def img_info_log(filename: str, filter_path: Optional[str] = None,
         filter_path = filename
     log(filter_img_info(output, filter_path, drop_child_info))
 
-def qemu_io_wrap_args(args: Sequence[str]) -> List[str]:
+def qemu_io_wrap_args(args: Sequence[str]) -> list[str]:
     if '-f' in args or '--image-opts' in args:
         return qemu_io_args_no_fmt + list(args)
     else:
@@ -457,7 +457,7 @@ def __init__(self, *args: str, instance_id: str = 'a', qmp: bool = False):
 
         assert self._pid == self._p.pid
 
-    def qmp(self, cmd: str, args: Optional[Dict[str, object]] = None) \
+    def qmp(self, cmd: str, args: Optional[dict[str, object]] = None) \
             -> QMPMessage:
         assert self._qmp is not None
         return self._qmp.cmd_raw(cmd, args)
@@ -466,7 +466,7 @@ def get_qmp(self) -> QEMUMonitorProtocol:
         assert self._qmp is not None
         return self._qmp
 
-    def cmd(self, cmd: str, args: Optional[Dict[str, object]] = None) \
+    def cmd(self, cmd: str, args: Optional[dict[str, object]] = None) \
             -> QMPReturnValue:
         assert self._qmp is not None
         return self._qmp.cmd(cmd, **(args or {}))
@@ -498,7 +498,7 @@ def qemu_nbd(*args):
     '''Run qemu-nbd in daemon mode and return the parent's exit code'''
     return subprocess.call(qemu_nbd_args + ['--fork'] + list(args))
 
-def qemu_nbd_early_pipe(*args: str) -> Tuple[int, str]:
+def qemu_nbd_early_pipe(*args: str) -> tuple[int, str]:
     '''Run qemu-nbd in daemon mode and return both the parent's exit code
        and its output in case of an error'''
     full_args = qemu_nbd_args + ['--fork'] + list(args)
@@ -706,7 +706,7 @@ def filter_qtest(output: str) -> str:
     output = re.sub(r'\n?\[I \+\d+\.\d+\] CLOSED\n?$', '', output)
     return output
 
-Msg = TypeVar('Msg', Dict[str, Any], List[Any], str)
+Msg = TypeVar('Msg', dict[str, Any], list[Any], str)
 
 def log(msg: Msg,
         filters: Iterable[Callable[[Msg], Msg]] = (),
@@ -919,7 +919,7 @@ def add_paused(self):
 
     def hmp(self, command_line: str, use_log: bool = False) -> QMPMessage:
         cmd = 'human-monitor-command'
-        kwargs: Dict[str, Any] = {'command-line': command_line}
+        kwargs: dict[str, Any] = {'command-line': command_line}
         if use_log:
             return self.qmp_log(cmd, **kwargs)
         else:
@@ -1462,7 +1462,7 @@ def verify_quorum():
     if not supports_quorum():
         notrun('quorum support missing')
 
-def has_working_luks() -> Tuple[bool, str]:
+def has_working_luks() -> tuple[bool, str]:
     """
     Check whether our LUKS driver can actually create images
     (this extends to LUKS encryption for qcow2).
@@ -1550,8 +1550,8 @@ def skip_if_unsupported(required_formats=(), read_only=False):
     '''Skip Test Decorator
        Runs the test if all the required formats are whitelisted'''
     def skip_test_decorator(func):
-        def func_wrapper(test_case: QMPTestCase, *args: List[Any],
-                         **kwargs: Dict[str, Any]) -> None:
+        def func_wrapper(test_case: QMPTestCase, *args: list[Any],
+                         **kwargs: dict[str, Any]) -> None:
             if callable(required_formats):
                 fmts = required_formats(test_case)
             else:
@@ -1567,13 +1567,13 @@ def func_wrapper(test_case: QMPTestCase, *args: List[Any],
     return skip_test_decorator
 
 def skip_for_formats(formats: Sequence[str] = ()) \
-    -> Callable[[Callable[[QMPTestCase, List[Any], Dict[str, Any]], None]],
-                Callable[[QMPTestCase, List[Any], Dict[str, Any]], None]]:
+    -> Callable[[Callable[[QMPTestCase, list[Any], dict[str, Any]], None]],
+                Callable[[QMPTestCase, list[Any], dict[str, Any]], None]]:
     '''Skip Test Decorator
        Skips the test for the given formats'''
     def skip_test_decorator(func):
-        def func_wrapper(test_case: QMPTestCase, *args: List[Any],
-                         **kwargs: Dict[str, Any]) -> None:
+        def func_wrapper(test_case: QMPTestCase, *args: list[Any],
+                         **kwargs: dict[str, Any]) -> None:
             if imgfmt in formats:
                 msg = f'{test_case}: Skipped for format {imgfmt}'
                 test_case.case_skip(msg)
@@ -1625,7 +1625,7 @@ class ReproducibleTestRunner(unittest.TextTestRunner):
     def __init__(
         self,
         stream: Optional[TextIO] = None,
-        resultclass: Type[unittest.TextTestResult] =
+        resultclass: type[unittest.TextTestResult] =
         ReproducibleTestResult,
         **kwargs: Any
     ) -> None:
@@ -1635,7 +1635,7 @@ def __init__(
                          resultclass=resultclass,
                          **kwargs)
 
-def execute_unittest(argv: List[str], debug: bool = False) -> None:
+def execute_unittest(argv: list[str], debug: bool = False) -> None:
     """Executes unittests within the calling module."""
 
     # Some tests have warnings, especially ResourceWarnings for unclosed
diff --git a/tests/qemu-iotests/linters.py b/tests/qemu-iotests/linters.py
index 9fb3fd14497..21b26bff298 100644
--- a/tests/qemu-iotests/linters.py
+++ b/tests/qemu-iotests/linters.py
@@ -17,7 +17,7 @@
 import re
 import subprocess
 import sys
-from typing import List, Mapping, Optional
+from typing import Mapping, Optional
 
 
 # TODO: Empty this list!
@@ -49,7 +49,7 @@ def is_python_file(filename):
             return False
 
 
-def get_test_files() -> List[str]:
+def get_test_files() -> list[str]:
     named_tests = [f'tests/{entry}' for entry in os.listdir('tests')]
     check_tests = set(os.listdir('.') + named_tests) - set(SKIP_FILES)
     return list(filter(is_python_file, check_tests))
@@ -57,7 +57,7 @@ def get_test_files() -> List[str]:
 
 def run_linter(
         tool: str,
-        args: List[str],
+        args: list[str],
         env: Optional[Mapping[str, str]] = None,
         suppress_output: bool = False,
 ) -> None:
diff --git a/tests/qemu-iotests/testenv.py b/tests/qemu-iotests/testenv.py
index 6326e46b7b1..3c0d5027594 100644
--- a/tests/qemu-iotests/testenv.py
+++ b/tests/qemu-iotests/testenv.py
@@ -25,7 +25,7 @@
 import random
 import subprocess
 import glob
-from typing import List, Dict, Any, Optional
+from typing import Any, Optional
 
 if sys.version_info >= (3, 9):
     from contextlib import AbstractContextManager as ContextManager
@@ -81,7 +81,7 @@ class TestEnv(ContextManager['TestEnv']):
                      'IMGKEYSECRET', 'QEMU_DEFAULT_MACHINE', 'MALLOC_PERTURB_',
                      'GDB_OPTIONS', 'PRINT_QEMU']
 
-    def prepare_subprocess(self, args: List[str]) -> Dict[str, str]:
+    def prepare_subprocess(self, args: list[str]) -> dict[str, str]:
         if self.debug:
             args.append('-d')
 
@@ -96,7 +96,7 @@ def prepare_subprocess(self, args: List[str]) -> Dict[str, str]:
         os_env.update(self.get_env())
         return os_env
 
-    def get_env(self) -> Dict[str, str]:
+    def get_env(self) -> dict[str, str]:
         env = {}
         for v in self.env_variables:
             val = getattr(self, v.lower(), None)
diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
index 2e236c8fa39..d4e5c4c7ff9 100644
--- a/tests/qemu-iotests/testrunner.py
+++ b/tests/qemu-iotests/testrunner.py
@@ -27,7 +27,7 @@
 import shutil
 import sys
 from multiprocessing import Pool
-from typing import List, Optional, Any, Sequence, Dict
+from typing import Optional, Any, Sequence
 from testenv import TestEnv
 
 if sys.version_info >= (3, 9):
@@ -43,7 +43,7 @@ def silent_unlink(path: Path) -> None:
         pass
 
 
-def file_diff(file1: str, file2: str) -> List[str]:
+def file_diff(file1: str, file2: str) -> list[str]:
     with open(file1, encoding="utf-8") as f1, \
          open(file2, encoding="utf-8") as f2:
         # We want to ignore spaces at line ends. There are a lot of mess about
@@ -66,7 +66,7 @@ class LastElapsedTime(ContextManager['LastElapsedTime']):
     def __init__(self, cache_file: str, env: TestEnv) -> None:
         self.env = env
         self.cache_file = cache_file
-        self.cache: Dict[str, Dict[str, Dict[str, float]]]
+        self.cache: dict[str, dict[str, dict[str, float]]]
 
         try:
             with open(cache_file, encoding="utf-8") as f:
@@ -122,8 +122,8 @@ def proc_run_test(test: str, test_field_width: int) -> TestResult:
         assert runner is not None
         return runner.run_test(test, test_field_width, mp=True)
 
-    def run_tests_pool(self, tests: List[str],
-                       test_field_width: int, jobs: int) -> List[TestResult]:
+    def run_tests_pool(self, tests: list[str],
+                       test_field_width: int, jobs: int) -> list[TestResult]:
 
         # passing self directly to Pool.starmap() just doesn't work, because
         # it's a context manager.
@@ -369,7 +369,7 @@ def run_test(self, test: str,
         sys.stdout.flush()
         return res
 
-    def run_tests(self, tests: List[str], jobs: int = 1) -> bool:
+    def run_tests(self, tests: list[str], jobs: int = 1) -> bool:
         n_run = 0
         failed = []
         notrun = []
diff --git a/tests/qemu-iotests/tests/stream-under-throttle b/tests/qemu-iotests/tests/stream-under-throttle
index 1a50b682fc4..84627fe3ef5 100755
--- a/tests/qemu-iotests/tests/stream-under-throttle
+++ b/tests/qemu-iotests/tests/stream-under-throttle
@@ -21,7 +21,6 @@
 
 import asyncio
 import os
-from typing import List
 import iotests
 from iotests import qemu_img_create, qemu_io
 
@@ -39,7 +38,7 @@ class TcgVM(iotests.VM):
     the order they appear.
     '''
     @property
-    def _base_args(self) -> List[str]:
+    def _base_args(self) -> list[str]:
         # Put -accel tcg first so it takes precedence
         return ['-accel', 'tcg'] + super()._base_args
 
-- 
2.48.1


