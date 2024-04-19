Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A181BC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:42:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1T-0007Xq-QS; Fri, 19 Apr 2024 00:38:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1I-0007UF-M0
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1G-0004De-JM
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CoSqUgSzEsMb4xXZdgb8ytZiYXh2CE2Rj6nvlRqURIo=;
 b=IIs/4bkCql31VMRimLC2HW9XPsiFgpjQm90LF6+3odLf2gn264zr28bCjfONaURR2HWzaX
 cMMfNatjO3+b0T94YFzjm/6m19HIbQDZHVYBCGPEU7ojjU6HKZAKfECZV41n0jjVXJP9m+
 qwPvV295QrXTk6WxbfMxFMpO6PQJwdc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-584-Ycmgmc0nOHGfdZP06g2IUQ-1; Fri,
 19 Apr 2024 00:38:34 -0400
X-MC-Unique: Ycmgmc0nOHGfdZP06g2IUQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C415286A9C8;
 Fri, 19 Apr 2024 04:38:34 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7BF0F40829C5;
 Fri, 19 Apr 2024 04:38:33 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 17/27] docs/qapi-domain: add qapi:union and qapi:branch
 directives
Date: Fri, 19 Apr 2024 00:38:05 -0400
Message-ID: <20240419043820.178731-18-jsnow@redhat.com>
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
 docs/qapi/index.rst        | 37 ++++++++++++++
 docs/sphinx/qapi-domain.py | 98 +++++++++++++++++++++++++++++++++++++-
 2 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index b07e6e9e2e3..d37ceac497f 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -103,6 +103,18 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :arg baz: Missing a type.
    :feat unstable: More than unstable, this command doesn't even exist!
    :arg no-descr:
+   :arg BitmapSyncMode discrim: How about branches in commands?
+
+   .. qapi:branch:: discrim on-success
+
+      :arg str foobar: This is an argument that belongs to a tagged union branch.
+      :arg int? foobaz: This is another argument belonging to the same branch.
+
+   .. qapi:branch:: discrim never
+
+      :arg str barfoo: This is an argument that belongs to a *different* tagged union branch.
+      :arg int64 zzxyz: And this is another argument belonging to that same branch.
+
    :feat hallucination: This command is a figment of your imagination.
    :error CommandNotFound: When you try to use this command, because it
       isn't real.
@@ -190,3 +202,28 @@ Explicit cross-referencing syntax for QAPI modules is available with
      operations.  0 means unlimited.  If max-chunk is non-zero then it
      should not be less than job cluster size which is calculated as
      maximum of target image cluster size and 64k.  Default 0.
+
+.. qapi:union:: RbdEncryptionOptions
+   :since: 6.1
+
+   :memb RbdImageEncryptionFormat format: Encryption format.
+   :memb RbdEncryptionOptions? parent: Parent image encryption options
+      (for cloned images).  Can be left unspecified if this cloned image
+      is encrypted using the same format and secret as its parent image
+      (i.e. not explicitly formatted) or if its parent image is not
+      encrypted.  (Since 8.0)
+
+   .. qapi:branch:: format luks
+
+      :memb str key-secret: ID of a QCryptoSecret object providing a
+         passphrase for unlocking the encryption
+
+   .. qapi:branch:: format luks2
+
+      :memb str key-secret: ID of a QCryptoSecret object providing a
+         passphrase for unlocking the encryption
+
+   .. qapi:branch:: format luks-any
+
+      :memb str key-secret: ID of a QCryptoSecret object providing a
+         passphrase for unlocking the encryption
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index b46faeaceef..f0094300c03 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -33,7 +33,12 @@
 from sphinx.locale import _, __
 from sphinx.roles import XRefRole
 from sphinx.util import logging
-from sphinx.util.docfields import GroupedField, TypedField
+from sphinx.util.docfields import (
+    DocFieldTransformer,
+    Field,
+    GroupedField,
+    TypedField,
+)
 from sphinx.util.docutils import SphinxDirective, switch_source_input
 from sphinx.util.nodes import (
     make_id,
@@ -52,6 +57,8 @@
 
 logger = logging.getLogger(__name__)
 
+quack = cast  # O:-)
+
 
 class ObjectEntry(NamedTuple):
     docname: str
@@ -242,6 +249,30 @@ def add_target_and_index(
                     ("single", indextext, node_id, "", None)
                 )
 
+    def _merge_adjoining_field_lists(self, contentnode: addnodes.desc_content) -> None:
+        # Take any adjacent field lists and glue them together into
+        # one list for further processing by Sphinx. This is done so
+        # that field lists declared in nested directives can be
+        # flattened into non-nested field lists.
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
 
@@ -349,6 +380,12 @@ class QAPIStruct(QAPIObjectWithMembers):
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
@@ -439,6 +476,59 @@ def run(self) -> List[Node]:
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
+        _nested_parse(self, content_node)
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
@@ -505,6 +595,7 @@ class QAPIDomain(Domain):
         "enum": ObjType(_("enum"), "enum", "obj", "type"),
         "struct": ObjType(_("struct"), "struct", "obj", "type"),
         "alternate": ObjType(_("alternate"), "alt", "obj", "type"),
+        "union": ObjType(_("union"), "union", "obj", "type"),
     }
 
     # Each of these provides a ReST directive,
@@ -516,6 +607,10 @@ class QAPIDomain(Domain):
         "enum": QAPIEnum,
         "struct": QAPIStruct,
         "alternate": QAPIAlternate,
+        "union": QAPIUnion,
+        # This is not an object in its own right;
+        # It's a directive for documenting branch members of Union types.
+        "branch": Branch,
     }
 
     # These are all cross-reference roles; e.g.
@@ -528,6 +623,7 @@ class QAPIDomain(Domain):
         "enum": QAPIXRefRole(),
         "struct": QAPIXRefRole(),
         "alt": QAPIXRefRole(),
+        "union": QAPIXRefRole(),
         "type": QAPIXRefRole(),  # reference any data type (excludes modules, commands, events)
         "obj": QAPIXRefRole(),  # reference *any* type of QAPI object.
     }
-- 
2.44.0


