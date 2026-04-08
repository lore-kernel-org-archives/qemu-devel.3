Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (unknown [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74D6710F995C
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 18:30:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAXep-00056S-4Z; Wed, 08 Apr 2026 14:29:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAXen-000556-RO
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:29:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKxT-0005UH-Qx
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eN1Lr5jD4lirMRmReH/dTqZHRqKW+Gj5QMyDxvzEpUg=;
 b=VuS8q6z3CJ6R9zYXZg00tSzNOJrMA9UZdaFz6rJU9NPO3JejBP3N1nQsVgSep2lwat3/lv
 ND6oVkw7cxuWHMaR4eWwIPIB6lCYuRdVh7B8vrePiSO1ZbaLApPOZCR5Fhhzz/9ZU9LkDb
 iFfijaig2t/NmS4P51pzlr3zgsLej1Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-329-lOT0K19TPK6DqGxGM7vQLw-1; Wed,
 08 Apr 2026 00:56:03 -0400
X-MC-Unique: lOT0K19TPK6DqGxGM7vQLw-1
X-Mimecast-MFC-AGG-ID: lOT0K19TPK6DqGxGM7vQLw_1775624161
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ADD41800281; Wed,  8 Apr 2026 04:56:01 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id EFD7F19560A6; Wed,  8 Apr 2026 04:55:52 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kashyap Chamarthy <kchamart@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Hanna Reitz <hreitz@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex@shazbot.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH v2 02/10] qapi: prohibit 'details' sections between tagged
 sections
Date: Wed,  8 Apr 2026 00:55:23 -0400
Message-ID: <20260408045531.3006678-3-jsnow@redhat.com>
In-Reply-To: <20260408045531.3006678-1-jsnow@redhat.com>
References: <20260408045531.3006678-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

This patch prohibits plain documentation sections from appearing between
(most*) tagged/description sections. The two existing uses of this
pattern (One in tests, one in our actual docs) are patched out.

This is being done for two main reasons:

(1) By limiting the locations where a "details" section may occur, it is
easier to reason about where a details section must be placed when
merging two or more documentation blocks together. This eases the logic
in the forthcoming inliner significantly.

(2) It improves visual consistency in the rendered HTML output. Tagged
sections and descriptions are all presented in a tabular format, so
prohibiting free-form text from interleaving the table looks better.

(*"most": As of this patch, TODO and Since sections may still occur
before, after, or between detail sections. These sections are removed
from the flow of the document when rendered to HTML, so in effect even
though we may have multiple details sections, they will be contiguous in
rendered HTML output.)

Signed-off-by: John Snow <jsnow@redhat.com>

---

[Review note: the output of *.ir files changes slightly, but
intentionally, with this patch; the two distinct changes correlate with
the edits made to the qapi .json files modified explicitly by this
patch. --js]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst                 | 15 +++++++++++----
 qapi/qom.json                                |  4 ++--
 scripts/qapi/parser.py                       | 19 +++++++++++++++++++
 tests/qapi-schema/doc-good.json              |  4 ++--
 tests/qapi-schema/doc-good.out               |  4 ++--
 tests/qapi-schema/doc-good.txt               |  8 ++++----
 tests/qapi-schema/doc-misplaced-details.err  |  0
 tests/qapi-schema/doc-misplaced-details.json |  3 +++
 tests/qapi-schema/doc-misplaced-details.out  | 11 +++++++++++
 tests/qapi-schema/meson.build                |  1 +
 10 files changed, 55 insertions(+), 14 deletions(-)
 create mode 100644 tests/qapi-schema/doc-misplaced-details.err
 create mode 100644 tests/qapi-schema/doc-misplaced-details.json
 create mode 100644 tests/qapi-schema/doc-misplaced-details.out

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 3a632b4a648..06ab3547fdc 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -985,10 +985,17 @@ When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
 Definition documentation starts with a line naming the definition,
-followed by an optional overview, a description of each argument (for
-commands and events), member (for structs and unions), branch (for
-alternates), or value (for enums), a description of each feature (if
-any), and finally optional tagged sections.
+followed by an optional overview (the "intro"), a description of each
+argument (for commands and events), member (for structs and unions),
+branch (for alternates), or value (for enums), a description of each
+feature (if any), most optional tagged sections, plaintext detail
+paragraphs, and finally the optional "Since" tagged section.
+
+Paragraphs following the optional overview (the "intro") may not appear
+between any description or tagged section as described above. These
+sections are "detail" sections and must appear at the end of the
+documentation block, with the exception of "Since" or "TODO" sections
+which may appear after.
 
 Descriptions start with '\@name:'.  The description text must be
 indented like this::
diff --git a/qapi/qom.json b/qapi/qom.json
index c653248f85d..1b47abd44e9 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -243,12 +243,12 @@
 #
 # @typename: the type name of an object
 #
+# Returns: a list describing object properties
+#
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
 #
-# Returns: a list describing object properties
-#
 # Since: 2.12
 ##
 { 'command': 'qom-list-properties',
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index da0ac32ad89..8a21e9e8b56 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -545,6 +545,21 @@ def get_doc(self) -> 'QAPIDoc':
             self.accept(False)
             line = self.get_doc_line()
             have_tagged = False
+            no_more_tags = False
+
+            def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
+                if isinstance(this, str):
+                    this = QAPIDoc.Kind.from_string(this)
+                if this in (QAPIDoc.Kind.TODO, QAPIDoc.Kind.SINCE):
+                    return
+
+                if no_more_tags:
+                    raise QAPIParseError(
+                        self,
+                        f"'{this}' section cannot appear after plain "
+                        "paragraphs that follow other tagged sections\n"
+                        "Move this section up above the plain paragraph(s)."
+                    )
 
             while line is not None:
                 # Blank lines
@@ -558,6 +573,7 @@ def get_doc(self) -> 'QAPIDoc':
                     if doc.features:
                         raise QAPIParseError(
                             self, "duplicated 'Features:' line")
+                    _tag_check(QAPIDoc.Kind.FEATURE)
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -621,6 +637,7 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
+                    _tag_check(match.group(1))
                     doc.new_tagged_section(
                         self.info,
                         QAPIDoc.Kind.from_string(match.group(1))
@@ -632,6 +649,8 @@ def get_doc(self) -> 'QAPIDoc':
                     have_tagged = True
                 else:
                     # plain paragraph
+                    if have_tagged:
+                        no_more_tags = True
 
                     # Paragraphs before tagged sections are "intro" paragraphs.
                     # Any appearing after are "detail" paragraphs.
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index fac13425b72..9103fed472e 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -165,12 +165,12 @@
 # @cmd-feat1: a feature
 # @cmd-feat2: another feature
 #
-# .. note:: @arg3 is undocumented
-#
 # Returns: @Object
 #
 # Errors: some
 #
+# .. note:: @arg3 is undocumented
+#
 # TODO: frobnicate
 #
 # .. admonition:: Notes
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 04e29e8d50f..6a0167ad580 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -175,12 +175,12 @@ description starts on the same line
 a feature
     feature=cmd-feat2
 another feature
-    section=Details
-.. note:: @arg3 is undocumented
     section=Returns
 @Object
     section=Errors
 some
+    section=Details
+.. note:: @arg3 is undocumented
     section=Todo
 frobnicate
     section=Details
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 74b73681d32..ded699dd596 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -120,16 +120,16 @@ Command cmd (Since: 2.10)
 
       * **cmd-feat2** -- another feature
 
-   Note:
-
-     "arg3" is undocumented
-
    Return:
       "Object" -- "Object"
 
    Errors:
       some
 
+   Note:
+
+     "arg3" is undocumented
+
    Notes:
 
    * Lorem ipsum dolor sit amet
diff --git a/tests/qapi-schema/doc-misplaced-details.err b/tests/qapi-schema/doc-misplaced-details.err
new file mode 100644
index 00000000000..e69de29bb2d
diff --git a/tests/qapi-schema/doc-misplaced-details.json b/tests/qapi-schema/doc-misplaced-details.json
new file mode 100644
index 00000000000..de593ab0f69
--- /dev/null
+++ b/tests/qapi-schema/doc-misplaced-details.json
@@ -0,0 +1,3 @@
+# FIXME / TODO
+# This test should test for the error message when we misplace details
+# sections interleaved between descriptions/tagged sections.
diff --git a/tests/qapi-schema/doc-misplaced-details.out b/tests/qapi-schema/doc-misplaced-details.out
new file mode 100644
index 00000000000..3c602d2592c
--- /dev/null
+++ b/tests/qapi-schema/doc-misplaced-details.out
@@ -0,0 +1,11 @@
+module ./builtin
+object q_empty
+enum QType
+    member none
+    member qnull
+    member qnum
+    member qstring
+    member qdict
+    member qlist
+    member qbool
+module doc-misplaced-details.json
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index debff633ac1..c233d77ab78 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -83,6 +83,7 @@ schemas = [
   'doc-invalid-section.json',
   'doc-invalid-start.json',
   'doc-long-line.json',
+  'doc-misplaced-details.json',
   'doc-missing-colon.json',
   'doc-missing-expr.json',
   'doc-missing-space.json',
-- 
2.53.0


