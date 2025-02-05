Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82C35C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:19:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfocD-0000SO-28; Wed, 05 Feb 2025 18:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfobs-00087N-Km
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfobq-00061W-6K
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797305;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aCyKutJWGOcr8VObj1Oj+4uR8ZmsNxHABIofgBJXEss=;
 b=QvI+nQQg5AYdawh4iEhU0EiLmH2DmugP/Vc21jUMi+1VB27LFvJTgcQ7FG79rtsHIYoq+9
 PqzC/oXCZ1kA85+1hcPVeEbck+FWQasAx4GycJM/foXSkooblSVvElvHci2PaPXbQS5qqV
 U/tUi1paXCAvbBDSw6YPTXKznbXGnh8=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-679-RrnFoDO_Mh6zp2Hc-d4TDQ-1; Wed,
 05 Feb 2025 18:15:02 -0500
X-MC-Unique: RrnFoDO_Mh6zp2Hc-d4TDQ-1
X-Mimecast-MFC-AGG-ID: RrnFoDO_Mh6zp2Hc-d4TDQ
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C7D61800570; Wed,  5 Feb 2025 23:15:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 607FF1800570; Wed,  5 Feb 2025 23:14:54 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 27/42] qapi: differentiate "intro" and "detail" sections
Date: Wed,  5 Feb 2025 18:11:53 -0500
Message-ID: <20250205231208.1480762-28-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch begins distinguishing "Plain" sections as being either
"Intro" or "Details" sections for the purpose of knowing when and where
to inline those sections.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py         |  4 ++--
 scripts/qapi/parser.py         | 30 +++++++++++++++++++-----------
 tests/qapi-schema/doc-good.out |  8 ++++----
 3 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 2d83556629d..154ebc1b4cd 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -289,7 +289,7 @@ def visit_sections(self, ent: QAPISchemaEntity) -> None:
 
         # Add sections *in the order they are documented*:
         for section in sections:
-            if section.kind == QAPIDoc.Kind.PLAIN:
+            if section.kind.name in ("INTRO", "DETAIL"):
                 self.visit_paragraph(section)
             elif section.kind == QAPIDoc.Kind.MEMBER:
                 self.visit_member(section)
@@ -578,7 +578,7 @@ def _nodes_for_sections(self, doc):
                 # Hide TODO: sections
                 continue
 
-            if section.kind == QAPIDoc.Kind.PLAIN:
+            if section.kind.name in ("INTRO", "DETAIL"):
                 # Sphinx cannot handle sectionless titles;
                 # Instead, just append the results to the prior section.
                 container = nodes.container()
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index a8b30ae1a4b..b2f77ffdd7a 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -499,7 +499,7 @@ def get_doc(self) -> 'QAPIDoc':
             doc = QAPIDoc(info, symbol)
             self.accept(False)
             line = self.get_doc_line()
-            no_more_args = False
+            have_tagged = False
 
             while line is not None:
                 # Blank lines
@@ -528,10 +528,10 @@ def get_doc(self) -> 'QAPIDoc':
                     if not doc.features:
                         raise QAPIParseError(
                             self, 'feature descriptions expected')
-                    no_more_args = True
+                    have_tagged = True
                 elif match := self._match_at_name_colon(line):
                     # description
-                    if no_more_args:
+                    if have_tagged:
                         raise QAPIParseError(
                             self,
                             "description of '@%s:' follows a section"
@@ -543,7 +543,7 @@ def get_doc(self) -> 'QAPIDoc':
                         if text:
                             doc.append_line(text)
                         line = self.get_doc_indented(doc)
-                    no_more_args = True
+                    have_tagged = True
                 elif match := re.match(
                         r'(Returns|Errors|Since|Notes?|Examples?|TODO)'
                         r'(?!::): *',
@@ -584,14 +584,20 @@ def get_doc(self) -> 'QAPIDoc':
                     if text:
                         doc.append_line(text)
                     line = self.get_doc_indented(doc)
-                    no_more_args = True
+                    have_tagged = True
                 elif line.startswith('='):
                     raise QAPIParseError(
                         self,
                         "unexpected '=' markup in definition documentation")
                 else:
                     # plain paragraph(s)
-                    doc.ensure_untagged_section(self.info)
+                    if have_tagged:
+                        no_more_tags = True
+
+                    # Paragraphs before tagged sections are "intro" paragraphs.
+                    # Any appearing after are "detail" paragraphs.
+                    intro = not have_tagged
+                    doc.ensure_untagged_section(self.info, intro)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
         else:
@@ -640,21 +646,22 @@ class QAPIDoc:
     """
 
     class Kind(enum.Enum):
-        PLAIN = 0
+        INTRO = 0
         MEMBER = 1
         FEATURE = 2
         RETURNS = 3
         ERRORS = 4
         SINCE = 5
         TODO = 6
+        DETAIL = 7
 
         @staticmethod
         def from_string(kind: str) -> 'QAPIDoc.Kind':
             return QAPIDoc.Kind[kind.upper()]
 
         def text_required(self) -> bool:
-            # Only "plain" sections can be empty
-            return self.value not in (0,)
+            # Only Intro/Detail sections can be empty
+            return self.value not in (0, 7)
 
         def __str__(self) -> str:
             return self.name.title()
@@ -700,7 +707,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         self.symbol: Optional[str] = symbol
         # the sections in textual order
         self.all_sections: List[QAPIDoc.Section] = [
-            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
+            QAPIDoc.Section(info, QAPIDoc.Kind.INTRO)
         ]
         # the body section
         self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
@@ -725,8 +732,9 @@ def end(self) -> None:
     def ensure_untagged_section(
         self,
         info: QAPISourceInfo,
+        intro: bool = True,
     ) -> None:
-        kind = QAPIDoc.Kind.PLAIN
+        kind = QAPIDoc.Kind.INTRO if intro else QAPIDoc.Kind.DETAIL
 
         if self.all_sections and self.all_sections[-1].kind == kind:
             # extend current section
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 2d33a305ee7..3eb28503f6b 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -110,7 +110,7 @@ The _one_ {and only}, description on the same line
 Also _one_ {and only}
     feature=enum-member-feat
 a member feature
-    section=Plain
+    section=Detail
 @two is undocumented
 doc symbol=Base
     body=
@@ -168,7 +168,7 @@ description starts on the same line
 a feature
     feature=cmd-feat2
 another feature
-    section=Plain
+    section=Detail
 .. note:: @arg3 is undocumented
     section=Returns
 @Object
@@ -176,7 +176,7 @@ another feature
 some
     section=Todo
 frobnicate
-    section=Plain
+    section=Detail
 .. admonition:: Notes
 
  - Lorem ipsum dolor sit amet
@@ -209,7 +209,7 @@ If you're bored enough to read this, go see a video of boxed cats
 a feature
     feature=cmd-feat2
 another feature
-    section=Plain
+    section=Detail
 .. qmp-example::
 
    -> "this example"
-- 
2.48.1


