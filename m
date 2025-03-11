Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F71FC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:36:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxqb-0003Gk-A8; Tue, 11 Mar 2025 07:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqO-0003Bs-01
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxq3-0006Vj-Tm
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692717;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qZu5A5HVKpNveCGYnJSjm3oY88cHVB8L/mvhdhIhxjQ=;
 b=KULcTU/2Ej1izq1v7jWw/4ksvblLUbkzqLX6OYuq7U32x8Y2ke6qqj1WcFwbJd3r3Xjj3l
 eGc7x/bMLMKdAWu6gJbPgTNUFR758lFr8qD7xnuFjqvrEEOpj0Ijj5nauy8gzr1szyzYqN
 pWx8lElFbLKuMCO8gJ7Bg9kAvRQd/PA=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-499-42aZZNdIP1y2g7Th5lBh-Q-1; Tue,
 11 Mar 2025 07:31:56 -0400
X-MC-Unique: 42aZZNdIP1y2g7Th5lBh-Q-1
X-Mimecast-MFC-AGG-ID: 42aZZNdIP1y2g7Th5lBh-Q_1741692715
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0134719560B7
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:54 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 55410195608F
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1AF3F21E64B1; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 24/61] docs/qapi-domain: add warnings for malformed field lists
Date: Tue, 11 Mar 2025 12:31:00 +0100
Message-ID: <20250311113137.1277125-25-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

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
Message-ID: <20250311034303.75779-27-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/conf.py               |  9 +++++
 docs/sphinx/qapi_domain.py | 74 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 83 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index 49d9de894c..a3f9fa63d9 100644
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
diff --git a/docs/sphinx/qapi_domain.py b/docs/sphinx/qapi_domain.py
index 4531b5d857..9fe006eef3 100644
--- a/docs/sphinx/qapi_domain.py
+++ b/docs/sphinx/qapi_domain.py
@@ -49,6 +49,19 @@
 logger = logging.getLogger(__name__)
 
 
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
@@ -330,9 +343,64 @@ def _add_pip(
         if infopips.children:
             contentnode.insert(0, infopips)
 
+    def _validate_field(self, field: nodes.field) -> None:
+        """Validate field lists in this QAPI Object Description."""
+        name, _ = _unpack_field(field)
+        allowed_fields = set(self.env.app.config.qapi_allowed_fields)
+
+        field_label = name.astext()
+        if field_label in allowed_fields:
+            # Explicitly allowed field list name, OK.
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
     def transform_content(self, content_node: addnodes.desc_content) -> None:
         self._add_infopips(content_node)
 
+        # Validate field lists.
+        for child in content_node:
+            if isinstance(child, nodes.field_list):
+                for field in child.children:
+                    assert isinstance(field, nodes.field)
+                    self._validate_field(field)
+
 
 class QAPICommand(QAPIObject):
     """Description of a QAPI Command."""
@@ -769,6 +837,12 @@ def resolve_any_xref(
 
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
2.48.1


