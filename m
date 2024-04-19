Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86E9EC04FF6
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Apr 2024 04:41:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxg1U-0007Yu-W4; Fri, 19 Apr 2024 00:38:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1K-0007UL-W5
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1rxg1J-0004EH-5z
 for qemu-devel@nongnu.org; Fri, 19 Apr 2024 00:38:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713501520;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7jjLauuGCciQkrLfyUwiXsCrDWKAvSteSgJzJEAZUE8=;
 b=JYw/KNo4uWj9ZCw5Djqe7k6NyVXMFtSNa9OwWfU3ABZ0ZWl5+xTAkgDURhOWZfLaJfuVTK
 fjuzL42GYOVHaGmcRc0s7sRytNRnXGiG85Rx3JdyL0Q4kKzCqAGI+W/dF8Mh2LXu9drIck
 nnmDXA+siKV8CLPQJsh1Szn2vv5vVsc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-259-3ztlf7YMP8C0syRqoqQUPw-1; Fri,
 19 Apr 2024 00:38:38 -0400
X-MC-Unique: 3ztlf7YMP8C0syRqoqQUPw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5473D29AA38E;
 Fri, 19 Apr 2024 04:38:38 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A331C40C1233;
 Fri, 19 Apr 2024 04:38:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 22/27] docs/qapi-domain: add warnings for malformed field lists
Date: Fri, 19 Apr 2024 00:38:10 -0400
Message-ID: <20240419043820.178731-23-jsnow@redhat.com>
In-Reply-To: <20240419043820.178731-1-jsnow@redhat.com>
References: <20240419043820.178731-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
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

-

RFC: Yes, this patch breaks the build! I thought it'd be helpful for you
to see the error checking in action. The next commit drops the erroneous
fields.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/conf.py               | 12 ++++++++
 docs/qapi/index.rst        | 27 +++++++++++++++++
 docs/sphinx/qapi-domain.py | 59 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 98 insertions(+)

diff --git a/docs/conf.py b/docs/conf.py
index b15665d956d..7a7d7005780 100644
--- a/docs/conf.py
+++ b/docs/conf.py
@@ -148,6 +148,18 @@
 with open(os.path.join(qemu_docdir, 'defs.rst.inc')) as f:
     rst_epilog += f.read()
 
+
+# Normally, the QAPI domain is picky about what field lists you use to
+# describe a QAPI entity. If you'd like to use arbitrary additional
+# fields in source documentation, add them here.
+qapi_allowed_fields = {
+    "example",
+    "note",
+    "see also",
+    "TODO",
+}
+
+
 # -- Options for HTML output ----------------------------------------------
 
 # The theme to use for HTML and HTML Help pages.  See the documentation for
diff --git a/docs/qapi/index.rst b/docs/qapi/index.rst
index 5bb1c37a5ed..ef58dfc4bcd 100644
--- a/docs/qapi/index.rst
+++ b/docs/qapi/index.rst
@@ -133,6 +133,33 @@ Explicit cross-referencing syntax for QAPI modules is available with
    :memb: this is malformed and unrecognized.
    :choice type name: This is unrecognized.
    :errors FooError: Also malformed.
+   :example: This isn't a "semantic" field, but it's been added to the
+      allowed field names list. you can use whatever field names you'd
+      like; but to prevent accidental typos, there is an allow list of
+      "arbitrary" section names.
+
+      You can nestle code-blocks in here, too, by using the ``::``
+      syntax::
+
+         -> { [ "bidirectional QMP example" ] }
+         <- { [ "hello world!"] }
+
+      Or use explicit ``.. code-block:: QMP`` syntax, but it must start
+      on its own line with a blank line both before and after the
+      directive to render correctly:
+
+      .. code-block:: QMP
+
+         -> "Hello friend!"
+
+      Note that the QMP highlighter is merely garden-variety JSON, but
+      with the addition of ``->``, ``<-`` and ``...`` symbols to help
+      denote bidirectionality and elided segments. Eduardo Habkost and I
+      wrote this lexer many moons ago to support the
+      :doc:`/interop/bitmaps` documentation.
+   :see also: This is also not a "semantic" field. The only limit is
+      your imagination and what you can convince others to let you check
+      into conf.py.
 
    Field lists can appear anywhere in the directive block, but any field
    list entries in the same list block that are recognized as special
diff --git a/docs/sphinx/qapi-domain.py b/docs/sphinx/qapi-domain.py
index e44db10488f..bf8bb933345 100644
--- a/docs/sphinx/qapi-domain.py
+++ b/docs/sphinx/qapi-domain.py
@@ -334,10 +334,63 @@ def _merge_adjoining_field_lists(self, contentnode: addnodes.desc_content) -> No
         for child in delete_queue:
             contentnode.remove(child)
 
+    def _validate_field(self, field: nodes.field) -> None:
+        field_name = field.children[0]
+        assert isinstance(field_name, nodes.field_name)
+        allowed_fields = set(self.env.app.config.qapi_allowed_fields)
+
+        field_label = field_name.astext()
+        if re.match(r"\[\S+ = \S+\]", field_label) or field_label in allowed_fields:
+            # okie-dokey. branch entry or known good allowed name.
+            return
+
+        try:
+            # split into field type and argument
+            field_type, fieldarg = field_label.split(None, 1)
+        except ValueError:
+            # No arguments provided
+            field_type = field_label
+            fieldarg = ""
+
+        typemap = self.get_field_type_map()
+        if field_type in typemap:
+            # This is a semantic field, yet-to-be-processed. Catch
+            # correct names, but incorrect arguments (which WILL fail to
+            # process correctly).
+            typedesc = typemap[field_type][0]
+            if typedesc.has_arg != bool(fieldarg):
+                msg = f"semantic field list type {field_type!r} "
+                if typedesc.has_arg:
+                    msg += "requires an argument."
+                else:
+                    msg += "takes no arguments."
+                logger.warning(msg, location=field)
+        else:
+            # This is unrecognized entirely.
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
 
@@ -872,6 +925,12 @@ def resolve_any_xref(
 
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
2.44.0


