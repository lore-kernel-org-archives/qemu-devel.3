Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CB3C3271E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 21:03:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sP783-0001OJ-GP; Wed, 03 Jul 2024 17:03:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP780-0001Ms-LB
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:03:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sP77y-0002J4-Ks
 for qemu-devel@nongnu.org; Wed, 03 Jul 2024 17:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720040577;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bYt+M1Vz4HSKtH7x62vDhOJdfNxWp/An1HxtiZGPiB4=;
 b=S3Nz3ra9FjCjtiCITX1/xJndTkz7drek+PVuM1qAN5OxFg5ZlXd6dopzdKQTDoaGwTXR6J
 4q9jEM0OPJiJjXvuIBbM18yVaz/4y4Fae7T8WvtXDhb8BUJ9Z5nprNC+fkS1OIu/i3YewK
 KvirL2Lu6SIMMQuY9oOLmphOMD/ZSJg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-vxZO8It8OdGnSOBhuJKHjg-1; Wed,
 03 Jul 2024 17:02:54 -0400
X-MC-Unique: vxZO8It8OdGnSOBhuJKHjg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 833751954B0C; Wed,  3 Jul 2024 21:02:51 +0000 (UTC)
Received: from scv.localdomain (unknown [10.22.34.31])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 21D301955F21; Wed,  3 Jul 2024 21:02:43 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Reitz <hreitz@redhat.com>, Mads Ynddal <mads@ynddal.dk>,
 Alex Williamson <alex.williamson@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Jiri Pirko <jiri@resnulli.us>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 8/8] qapi: remove "Example" doc section
Date: Wed,  3 Jul 2024 17:01:43 -0400
Message-ID: <20240703210144.339530-9-jsnow@redhat.com>
In-Reply-To: <20240703210144.339530-1-jsnow@redhat.com>
References: <20240703210144.339530-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Fully eliminate the "Example" sections in QAPI doc blocks now that they
have all been converted to arbitrary rST syntax using the
".. qmp-example::" directive. Update tests to match.

Migrating to the new syntax
---------------------------

The old "Example:" or "Examples:" section syntax is now caught as an
error, but "Example::" is stil permitted as explicit rST syntax for an
un-lexed, generic preformatted text block.

('Example' is not special in this case, any sentence that ends with "::"
will start an indented code block in rST.)

Arbitrary rST for Examples is now possible, but it's strongly
recommended that documentation authors use the ".. qmp-example::"
directive for consistent visual formatting in rendered HTML docs. The
":title:" directive option may be used to add extra information into the
title bar for the example. The ":annotated:" option can be used to write
arbitrary rST instead, with nested "::" blocks applying QMP formatting
where desired.

Other choices available are ".. code-block:: QMP" which will not create
an "Example:" box, or the short-form "::" code-block syntax which will
not apply QMP highlighting when used outside of the qmp-example
directive.

Why?
----

This patch has several benefits:

1. Example sections can now be written more arbitrarily, mixing
   explanatory paragraphs and code blocks however desired.

2. Example sections can now use fully arbitrary rST.

3. All code blocks are now lexed and validated as QMP; increasing
   usability of the docs and ensuring validity of example snippets.

   (To some extent - This patch only gaurantees it lexes correctly, not
   that it's valid under the JSON or QMP grammars. It will catch most
   small mistakes, however.)

4. Each qmp-example can be titled or annotated independently without
   bypassing the QMP lexer/validator.

   (i.e. code blocks are now for *code* only, so we don't have to
   sacrifice exposition for having lexically valid examples.)

NOTE: As with the "Notes" conversion patch, this patch (and those
      preceding) may change the rendering order for Examples in the
      current generator. The forthcoming qapidoc rewrite will fix this
      by always generating documentation in source order.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst    | 58 ++++++++++++++++++++++++++++-----
 scripts/qapi/parser.py          | 10 +++++-
 tests/qapi-schema/doc-good.json | 19 +++++++----
 tests/qapi-schema/doc-good.out  | 26 ++++++++++-----
 tests/qapi-schema/doc-good.txt  | 23 ++++++-------
 5 files changed, 98 insertions(+), 38 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index ae97b335cbf..2e10a3cbd69 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -899,7 +899,7 @@ Documentation markup
 ~~~~~~~~~~~~~~~~~~~~
 
 Documentation comments can use most rST markup.  In particular,
-a ``::`` literal block can be used for examples::
+a ``::`` literal block can be used for pre-formatted text::
 
     # ::
     #
@@ -995,8 +995,8 @@ line "Features:", like this::
   # @feature: Description text
 
 A tagged section begins with a paragraph that starts with one of the
-following words: "Since:", "Example:"/"Examples:", "Returns:",
-"Errors:", "TODO:".  It ends with the start of a new section.
+following words: "Since:", "Returns:", "Errors:", "TODO:".  It ends with
+the start of a new section.
 
 The second and subsequent lines of tagged sections must be indented
 like this::
@@ -1020,13 +1020,53 @@ detailing a relevant error condition. For example::
 A "Since: x.y.z" tagged section lists the release that introduced the
 definition.
 
-An "Example" or "Examples" section is rendered entirely
-as literal fixed-width text.  "TODO" sections are not rendered at all
-(they are for developers, not users of QMP).  In other sections, the
-text is formatted, and rST markup can be used.
+"TODO" sections are not rendered at all (they are for developers, not
+users of QMP).  In other sections, the text is formatted, and rST markup
+can be used.
+
+QMP Examples can be added by using the ``.. qmp-example::``
+directive. In its simplest form, this can be used to contain a single
+QMP code block which accepts standard JSON syntax with additional server
+directionality indicators (``->`` and ``<-``), and elisions (``...``).
+
+Optionally, a plaintext title may be provided by using the ``:title:``
+directive option. If the title is omitted, the example title will
+default to "Example:".
+
+A simple QMP example::
+
+  # .. qmp-example::
+  #    :title: Using query-block
+  #
+  #    -> { "execute": "query-block" }
+  #    <- { ... }
+
+More complex or multi-step examples where exposition is needed before or
+between QMP code blocks can be created by using the ``:annotated:``
+directive option. When using this option, nested QMP code blocks must be
+entered explicitly with rST's ``::`` syntax.
+
+Highlighting in non-QMP languages can be accomplished by using the
+``.. code-block:: lang`` directive, and non-highlighted text can be
+achieved by omitting the language argument.
 
 For example::
 
+  # .. qmp-example::
+  #    :annotated:
+  #    :title: A more complex demonstration
+  #
+  #    This is a more complex example that can use
+  #    ``arbitrary rST syntax`` in its exposition::
+  #
+  #      -> { "execute": "query-block" }
+  #      <- { ... }
+  #
+  #    Above, lengthy output has been omitted for brevity.
+
+
+Examples of complete definition documentation::
+
  ##
  # @BlockStats:
  #
@@ -1058,11 +1098,11 @@ For example::
  #
  # Since: 0.14
  #
- # Example:
+ # .. qmp-example::
  #
  #     -> { "execute": "query-blockstats" }
  #     <- {
- #          ... lots of output ...
+ #          ...
  #        }
  ##
  { 'command': 'query-blockstats',
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 6ad5663e545..adc85b5b394 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -553,7 +553,7 @@ def get_doc(self) -> 'QAPIDoc':
                     # Note: "sections" with two colons are left alone as
                     # rST markup and not interpreted as a section heading.
 
-                    # TODO: Remove this error sometime in 2025 or so
+                    # TODO: Remove these errors sometime in 2025 or so
                     # after we've fully transitioned to the new qapidoc
                     # generator.
 
@@ -567,6 +567,14 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
+                    if 'Example' in match.group(1):
+                        emsg = (
+                            f"The '{match.group(1)}' section is no longer "
+                            "supported. Please use the '.. qmp-example::' "
+                            "directive, or other suitable markup instead."
+                        )
+                        raise QAPIParseError(self, emsg)
+
                     doc.new_tagged_section(self.info, match.group(1))
                     text = line[match.end():]
                     if text:
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 107123f8a8d..c71d65cd51f 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -172,12 +172,17 @@
 #
 #  Duis aute irure dolor
 #
-# Example:
+# .. qmp-example::
+#    :title: Ideal fast-food burger situation
 #
-#  -> in
-#  <- out
+#    -> "in"
+#    <- "out"
 #
-# Examples:
+# Examples::
+#
+#  - Not a QMP code block
+#  - Merely a preformatted code block literal
+#  It isn't even an rST list.
 #  - *verbatim*
 #  - {braces}
 #
@@ -199,11 +204,11 @@
 # @cmd-feat1: a feature
 # @cmd-feat2: another feature
 #
-# Example:
+# .. qmp-example::
 #
-#  -> in
+#    -> "this example"
 #
-#  <- out
+#    <- "has no title"
 ##
 { 'command': 'cmd-boxed', 'boxed': true,
   'data': 'Object',
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index bd876b6542d..eee18cd436a 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -184,13 +184,21 @@ frobnicate
  - Ut enim ad minim veniam
 
  Duis aute irure dolor
-    section=Example
- -> in
- <- out
-    section=Examples
+
+.. qmp-example::
+   :title: Ideal fast-food burger situation
+
+   -> "in"
+   <- "out"
+
+Examples::
+
+ - Not a QMP code block
+ - Merely a preformatted code block literal
+ It isn't even an rST list.
  - *verbatim*
  - {braces}
-    section=None
+
 Note::
    Ceci n'est pas une note
     section=Since
@@ -202,10 +210,12 @@ If you're bored enough to read this, go see a video of boxed cats
 a feature
     feature=cmd-feat2
 another feature
-    section=Example
- -> in
+    section=None
+.. qmp-example::
 
- <- out
+   -> "this example"
+
+   <- "has no title"
 doc symbol=EVT_BOXED
     body=
 
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 30d457e5488..cb37db606a6 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -217,17 +217,16 @@ Notes:
 
 Duis aute irure dolor
 
+Example: Ideal fast-food burger situation:
 
-Example
-~~~~~~~
+   -> "in"
+   <- "out"
 
-   -> in
-   <- out
-
-
-Examples
-~~~~~~~~
+Examples:
 
+   - Not a QMP code block
+   - Merely a preformatted code block literal
+   It isn't even an rST list.
    - *verbatim*
    - {braces}
 
@@ -261,13 +260,11 @@ Features
 "cmd-feat2"
    another feature
 
+Example::
 
-Example
-~~~~~~~
+   -> "this example"
 
-   -> in
-
-   <- out
+   <- "has no title"
 
 
 "EVT_BOXED" (Event)
-- 
2.45.0


