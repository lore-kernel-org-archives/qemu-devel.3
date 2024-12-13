Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74D7E77180
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 01:16:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLuGm-0007jk-6S; Thu, 12 Dec 2024 20:15:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGi-0007XJ-FA
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLuGg-0000i0-5j
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 20:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734052495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fcuiOMT3uLSddjTINzRUt/NUAzts5LxaEcR7TXL6FJQ=;
 b=O/Z7RYaQZStZKYHhlYDzBWqw12VLnfHxy/Fqx1oyV9oo5QXzDkoTsFdrzHSd1dkEaNgmuv
 6LTNN6+Mb6Km5Avac5Ua/cXLh/gyvoUXTaTw7KmmxHZ6x721m/qwa6kPl5Z0/mHujzPGFH
 cpvK1itxPPhxeGFPh5ilRM12N8f/nK0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-4yWFKl7IPkyGClQD2RuukQ-1; Thu,
 12 Dec 2024 20:14:54 -0500
X-MC-Unique: 4yWFKl7IPkyGClQD2RuukQ-1
X-Mimecast-MFC-AGG-ID: 4yWFKl7IPkyGClQD2RuukQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3ADB819560A3; Fri, 13 Dec 2024 01:14:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 82A2B1956086; Fri, 13 Dec 2024 01:14:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [RFC PATCH v2 26/35] docs/qapi-domain: add warnings for malformed
 field lists
Date: Thu, 12 Dec 2024 20:12:55 -0500
Message-ID: <20241213011307.2942030-27-jsnow@redhat.com>
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

Normally, Sphinx will silently fall back to its standard field list
processing if it doesn't match one of your defined fields. A lot of the
time, that's not what we want - we want to be warned if we goof
something up.

For instance, the canonical argument field list form is:

:arg type name: descr

This form is captured by Sphinx and transformed so that the field label
will become "Arguments:". It's possible to omit the type name and descr
and still have it be processed correctly. However, if you omit the type
name, Sphinx no longer recognizes it:

:arg: this is not recognized.

This will turn into an arbitrary field list entry whose label is "Arg:",
and it otherwise silently fails. You may also see failures for doing
things like using :values: instead of :value:, or :errors: instead of
:error:, and so on. It's also case sensitive, and easy to trip up.

Add a validator that guarantees all field list entries that are the
direct child of an ObjectDescription use only recognized forms of field
lists, and emit a warning (treated as error by default in most build
configurations) whenever we detect one that is goofed up.

However, there's still benefit to allowing arbitrary fields -- they are
after all not a Sphinx invention, but perfectly normal docutils
syntax. Create an allow list for known spellings we don't mind letting
through, but warn against anything else.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py               |  9 +++++
 docs/sphinx/qapi-domain.py | 80 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 89 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index f2986ef7d74..bad35114351 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -153,6 +153,15 @@
 with open(os.path.join(qemu_docdir, 'defs.rst.inc')) as f:
     rst_epilog += f.read()
 
+
+# Normally, the QAPI domain is picky about what field lists you use to
+# describe a QAPI entity. If you'd like to use arbitrary additional
+# fields in source documentation, add them here.
+qapi_allowed_fields = {
+    "see also",
+}
+
+
 # -- Options for HTML output ----------------------------------------------
 
 # The theme to use for HTML and HTML Help pages.  See the documentation for
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index f7c7aaa507f..ba1e52a1f77 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -58,6 +58,19 @@
 quack = cast  # O:-)
 
 
+def _unpack_field(
+    field: nodes.Node,
+) -> Tuple[nodes.field_name, nodes.field_body]:
+    """
+    docutils helper: unpack a field node in a type-safe manner.
+    """
+    assert isinstance(field, nodes.field)
+    assert len(field.children) == 2
+    assert isinstance(field.children[0], nodes.field_name)
+    assert isinstance(field.children[1], nodes.field_body)
+    return (field.children[0], field.children[1])
+
+
 class ObjectEntry(NamedTuple):
     docname: str
     node_id: str
@@ -328,10 +341,71 @@ def _merge_adjoining_field_lists(
         for child in delete_queue:
             contentnode.remove(child)
 
+    def _validate_field(self, field: nodes.field) -> None:
+        """Validate field lists in this QAPI Object Description."""
+        name, _ = _unpack_field(field)
+        allowed_fields = set(self.env.app.config.qapi_allowed_fields)
+
+        field_label = name.astext()
+        if (
+            re.match(r"\[\S+ = \S+\]", field_label)
+            or field_label in allowed_fields
+        ):
+            # okie-dokey. branch entry or known good allowed name.
+            return
+
+        try:
+            # split into field type and argument (if provided)
+            # e.g. `:arg type name: descr` is
+            # field_type = "arg", field_arg = "type name".
+            field_type, field_arg = field_label.split(None, 1)
+        except ValueError:
+            # No arguments provided
+            field_type = field_label
+            field_arg = ""
+
+        typemap = self.get_field_type_map()
+        if field_type in typemap:
+            # This is a special docfield, yet-to-be-processed. Catch
+            # correct names, but incorrect arguments. This mismatch WILL
+            # cause Sphinx to render this field incorrectly (without a
+            # warning), which is never what we want.
+            typedesc = typemap[field_type][0]
+            if typedesc.has_arg != bool(field_arg):
+                msg = f"docfield field list type {field_type!r} "
+                if typedesc.has_arg:
+                    msg += "requires an argument."
+                else:
+                    msg += "takes no arguments."
+                logger.warning(msg, location=field)
+        else:
+            # This is unrecognized entirely. It's valid rST to use
+            # arbitrary fields, but let's ensure the documentation
+            # writer has done this intentionally.
+            valid = ", ".join(sorted(set(typemap) | allowed_fields))
+            msg = (
+                f"Unrecognized field list name {field_label!r}.\n"
+                f"Valid fields for qapi:{self.objtype} are: {valid}\n"
+                "\n"
+                "If this usage is intentional, please add it to "
+                "'qapi_allowed_fields' in docs/conf.py."
+            )
+            logger.warning(msg, location=field)
+
     def transform_content(self, contentnode: addnodes.desc_content) -> None:
         self._add_infopips(contentnode)
         self._merge_adjoining_field_lists(contentnode)
 
+        # Validate field lists. Note that this hook runs after any
+        # branch directives have processed and transformed their field
+        # lists, but before the main object directive has had a chance
+        # to do so.
+        for child in contentnode:
+            if isinstance(child, nodes.field_list):
+                for field in child.children:
+                    assert isinstance(field, nodes.field)
+                    self._validate_field(field)
+
     def _toc_entry_name(self, sig_node: desc_signature) -> str:
         # This controls the name in the TOC and on the sidebar.
 
@@ -901,6 +975,12 @@ def resolve_any_xref(
 
 def setup(app: Sphinx) -> Dict[str, Any]:
     app.setup_extension("sphinx.directives")
+    app.add_config_value(
+        "qapi_allowed_fields",
+        set(),
+        "env",  # Setting impacts parsing phase
+        types=set,
+    )
     app.add_domain(QAPIDomain)
 
     return {
-- 
2.47.0


