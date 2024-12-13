Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE411E77182
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:18:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGX-0006oJ-MM; Thu, 12 Dec 2024 20:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGT-0006Su-DR
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGQ-0000gs-D3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:14:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052481;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MIVqyDilLcqQD1IKvAN5ynNRWxlNH72emaCqA8E27/k=;
 b=RTY2j3zekcL4ggtyMNknU9/MgloZQgWbT5sc8iPdFHrmjzOKyzBCm4E3NuP50usflydV3z
 xE2Z5pLjTL1sgH1+nx8QrNpYmKqvQo12jPOXu4TL8MoH4+d2CzQ/H+h07HhknXtl/5bvdA
 bOJFEUdIx4gth41+DF+sejcVYLM+9sU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-ntPU_juhP9S7gdi5YfozUA-1; Thu,
 12 Dec 2024 20:14:39 -0500
X-MC-Unique: ntPU_juhP9S7gdi5YfozUA-1
X-Mimecast-MFC-AGG-ID: ntPU_juhP9S7gdi5YfozUA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D2FA195609E; Fri, 13 Dec 2024 01:14:38 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2CCC11956086; Fri, 13 Dec 2024 01:14:34 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 22/35] docs/qapi-domain: add qapi:union and qapi:branch
 directives
Date: Thu, 12 Dec 2024 20:12:51 -0500
Message-ID: <20241213011307.2942030-23-jsnow@redhat.com>
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

Adds the .. qapi:union:: directive, object, and :qapi:union:`name`
cross-referencing role.

In order to support discriminated branches of unions, a new qapi:branch
directive is created whose only purpose is to create a dynamically named
field list section based on the name of the branch key and value.

Because the label for these branch sections is dynamically generated,
this patch allows the use of either :memb: or :arg: in branches; they
are simply aliases and do not do anything different.

(This is to allow the directive to be used for either Commands or Unions
as needed; i.e. for commands whose argument type is a discriminated
union.)

For example:

.. qapi:union:: foo-union

   :memb foo-enum key: Discriminator field
   :memb foo-type fieldname: Some base type field that is always present

   .. qapi:branch:: key value1

      :memb type name: lorem ipsum ...

   .. qapi:branch:: key value2

      :memb type2 name2: dolor sit amet ...

In order to support this syntax, the root QAPIObject class needs to
perform some post-processing on field lists to merge adjecent field
lists. because each branch directive will return a separate field list,
and we want to combine them into one unified list for proper rendering.

NOTE: Technically, the branch directive will allow you to put arbitrary
ReST besides field lists inside of it, but it almost certainly won't do
anything you'd consider useful. I don't recommend it, but
programmatically forbidding it is expensive. Recommendation: "Don't!"

... and now ...

RFC: The branches abuse the field list system to create new categories
of field list entries that are dynamically generated. At the moment, I
do not have code to apply appropriate formatting to these headings, but
would like to apply ``literal`` syntax at a minimum to the enum values.

The other idea I have is to create a "blank" members value that doesn't
add a "title" (field label) on the left column and instead adds a
horizontal info bar into the arguments list in the right, but the
problem with this approach is that I won't be able to get rid of the "*
..." list bullet syntax, so it may look odd. Otherwise, a benefit to
this syntax is that it would allow us to write a longer explanation,
e.g. "When ``{key}`` is ``{value}``".

It's possible I could split the argument list into several nested lists,
but I haven't experimented in that direction yet - it's also likely that
Sphinx will want to append a ":" even to blank section titles, so this
may prove tricky to do within the constraints of Sphinx's existing Field
list system. (I believe the HTML formatter is responsible for appending
the colons.)

I'm open to suggestions, but wrestling with Sphinx, html and css is time
consuming (for me, at least), so ultimately, I'm afraid I must say:
***PATCHES WELCOME***.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapi-domain.py | 105 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index d94d84bc186..6120515bdc8 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -34,7 +34,12 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
-from sphinx.util.docfields import Field, GroupedField, TypedField
+from sphinx.util.docfields import (
+    DocFieldTransformer,
+    Field,
+    GroupedField,
+    TypedField,
+)
 from sphinx.util.docutils import SphinxDirective
 from sphinx.util.nodes import make_id, make_refnode
 
@@ -49,6 +54,8 @@
 
 logger = logging.getLogger(__name__)
 
+quack = cast  # O:-)
+
 
 class ObjectEntry(NamedTuple):
     docname: str
@@ -229,6 +236,35 @@ def add_target_and_index(
                     ("single", indextext, node_id, "", None)
                 )
 
+    def _merge_adjoining_field_lists(
+        self, contentnode: addnodes.desc_content
+    ) -> None:
+        # Take any adjacent field lists and glue them together into
+        # one list for further processing by Sphinx. This is done so
+        # that field lists declared in nested directives can be
+        # flattened into non-nested field lists.
+        #
+        # This only impacts field lists at the root level of the Object
+        # Description.
+
+        first_list = None
+        delete_queue: List[nodes.field_list] = []
+        for child in contentnode:
+            if isinstance(child, nodes.field_list):
+                if not first_list:
+                    first_list = child
+                else:
+                    first_list += child.children
+                    delete_queue.append(child)
+            else:
+                first_list = None
+
+        for child in delete_queue:
+            contentnode.remove(child)
+
+    def transform_content(self, contentnode: addnodes.desc_content) -> None:
+        self._merge_adjoining_field_lists(contentnode)
+
     def _toc_entry_name(self, sig_node: desc_signature) -> str:
         # This controls the name in the TOC and on the sidebar.
 
@@ -350,6 +386,12 @@ class QAPIStruct(QAPIObjectWithMembers):
     pass
 
 
+class QAPIUnion(QAPIObjectWithMembers):
+    """Description of a QAPI Union."""
+
+    pass
+
+
 class QAPIModule(SphinxDirective):
     """
     Directive to mark description of a new module.
@@ -440,6 +482,61 @@ def run(self) -> List[Node]:
         return ret
 
 
+class Branch(SphinxDirective):
+    """
+    Nested directive which only serves to introduce temporary
+    metadata but return its parsed content nodes unaltered otherwise.
+
+    Technically, you can put whatever you want in here, but doing so may
+    prevent proper merging of adjacent field lists.
+    """
+
+    doc_field_types: List[Field] = []
+    has_content = True
+    required_arguments = 2
+    optional_arguments = 0
+    domain = "qapi"
+
+    def get_field_type_map(self) -> Dict[str, Tuple[Field, bool]]:
+        ret = {}
+        for field in self.doc_field_types:
+            for name in field.names:
+                ret[name] = (field, False)
+
+            if field.is_typed:
+                typed_field = cast(TypedField, field)
+                for name in typed_field.typenames:
+                    ret[name] = (field, True)
+        return ret
+
+    def run(self) -> list[Node]:
+        discrim = self.arguments[0].strip()
+        value = self.arguments[1].strip()
+
+        # The label name is dynamically generated per-instance instead
+        # of per-class to incorporate the branch conditions as a label
+        # name.
+        self.doc_field_types = [
+            # :arg type name: descr
+            # :memb type name: descr
+            TypedField(
+                "branch-arg-or-memb",
+                label=f"[{discrim} = {value}]",
+                # In a branch, we don't actually use the name of the
+                # field name to generate the label; so allow either-or.
+                names=("arg", "memb"),
+            ),
+        ]
+
+        content_node: addnodes.desc_content = addnodes.desc_content()
+        nested_parse(self, content_node)
+        # DocFieldTransformer usually expects ObjectDescription, but... quack!
+        transformer = DocFieldTransformer(quack(ObjectDescription, self))
+        transformer.transform_all(content_node)
+
+        return content_node.children
+
+
 class QAPIIndex(Index):
     """
     Index subclass to provide the QAPI definition index.
@@ -514,6 +611,7 @@ class QAPIDomain(Domain):
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
         "struct": ObjType(_("struct"), "struct", "obj", "type"),
         "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
+        "union": ObjType(_("union"), "union", "obj", "type"),
     }
 
     # Each of these provides a rST directive,
@@ -525,6 +623,10 @@ class QAPIDomain(Domain):
         "enum": QAPIEnum,
         "struct": QAPIStruct,
         "alternate": QAPIAlternate,
+        "union": QAPIUnion,
+        # This is not an object in its own right;
+        # It's a directive for documenting branch members of Union types.
+        "branch": Branch,
     }
 
     # These are all cross-reference roles; e.g.
@@ -537,6 +639,7 @@ class QAPIDomain(Domain):
         "enum": QAPIXRefRole(),
         "struct": QAPIXRefRole(),
         "alt": QAPIXRefRole(),
+        "union": QAPIXRefRole(),
         # reference any data type (excludes modules, commands, events)
         "type": QAPIXRefRole(),
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
-- 
2.47.0


