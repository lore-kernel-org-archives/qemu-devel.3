Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AF8F53D85
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:28:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Cem-0002CN-0E; Mon, 16 Mar 2026 14:27:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2CeG-000284-Kx
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2CeD-0007ur-RZ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:26:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDr4qW1cCLHh1QmrWa/bQiw2/kYAn+dP+GKx4KX3cKQ=;
 b=boEJdVlQkYmU7ZpQTAsa2d69doUkjN9n3Xi3fMoeJEoXOYufzlx03mY8TFgOjuRMgwQc4K
 m+9I7iAJJGINmYdXlbwMVzI7FquSBeKcJI30ueu9HmhghYce1APh+qPRPJJ7kBnOPdfskU
 OKoq9ALRh1vJeobH9I6gkqgUzUDru30=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-645-obXZ218vMXeG95YMsLshBg-1; Mon,
 16 Mar 2026 14:26:33 -0400
X-MC-Unique: obXZ218vMXeG95YMsLshBg-1
X-Mimecast-MFC-AGG-ID: obXZ218vMXeG95YMsLshBg_1773685591
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE62818005B6; Mon, 16 Mar 2026 18:26:30 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66F5E3000223; Mon, 16 Mar 2026 18:26:22 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Jason Wang <jasowang@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Alex Williamson <alex@shazbot.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Yanan Wang <wangyanan55@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Ani Sinha <anisinha@redhat.com>
Subject: [PATCH 1/8] qapi: differentiate "intro" and "details" sections
Date: Mon, 16 Mar 2026 14:26:00 -0400
Message-ID: <20260316182608.148628-2-jsnow@redhat.com>
In-Reply-To: <20260316182608.148628-1-jsnow@redhat.com>
References: <20260316182608.148628-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This patch begins distinguishing "Plain" sections as being either
"Intro" or "Details" sections for the purpose of knowing when/where/how
to inline those sections.

The Intro section is always the first section of any doc block. It may
be empty or any number of paragraphs. It is interrupted by any other
non-plaintext section, i.e.; Members, Features, Errors, Returns, Since,
and TODO.

The details section, when present, is either the last section or the
second-to-last section when a "Since:" section is present. It consists
of any plain text in the doc block that follows any named sections if
present.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py         |  2 +-
 scripts/qapi/parser.py         | 35 +++++++++++++++++++++++-----------
 tests/qapi-schema/doc-good.out |  8 ++++----
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index c2f09bac16c..e359836f110 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -368,7 +368,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
         for i, section in enumerate(sections):
             section.text = self.reformat_arobase(section.text)
 
-            if section.kind == QAPIDoc.Kind.PLAIN:
+            if section.kind.name in ("INTRO", "DETAILS"):
                 self.visit_paragraph(section)
             elif section.kind == QAPIDoc.Kind.MEMBER:
                 assert isinstance(section, QAPIDoc.ArgSection)
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index c3cf33904ef..da0ac32ad89 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -544,7 +544,7 @@ def get_doc(self) -> 'QAPIDoc':
             doc = QAPIDoc(info, symbol)
             self.accept(False)
             line = self.get_doc_line()
-            no_more_args = False
+            have_tagged = False
 
             while line is not None:
                 # Blank lines
@@ -573,10 +573,10 @@ def get_doc(self) -> 'QAPIDoc':
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
@@ -588,7 +588,7 @@ def get_doc(self) -> 'QAPIDoc':
                         if text:
                             doc.append_line(text)
                         line = self.get_doc_indented(doc)
-                    no_more_args = True
+                    have_tagged = True
                 elif match := re.match(
                         r'(Returns|Errors|Since|Notes?|Examples?|TODO)'
                         r'(?!::): *',
@@ -629,10 +629,14 @@ def get_doc(self) -> 'QAPIDoc':
                     if text:
                         doc.append_line(text)
                     line = self.get_doc_indented(doc)
-                    no_more_args = True
+                    have_tagged = True
                 else:
                     # plain paragraph
-                    doc.ensure_untagged_section(self.info)
+
+                    # Paragraphs before tagged sections are "intro" paragraphs.
+                    # Any appearing after are "detail" paragraphs.
+                    intro = not have_tagged
+                    doc.ensure_untagged_section(self.info, intro)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
         else:
@@ -674,13 +678,14 @@ class QAPIDoc:
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
+        DETAILS = 7
 
         @staticmethod
         def from_string(kind: str) -> 'QAPIDoc.Kind':
@@ -730,7 +735,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         self.symbol: Optional[str] = symbol
         # the sections in textual order
         self.all_sections: List[QAPIDoc.Section] = [
-            QAPIDoc.Section(info, QAPIDoc.Kind.PLAIN)
+            QAPIDoc.Section(info, QAPIDoc.Kind.INTRO)
         ]
         # the body section
         self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
@@ -748,12 +753,20 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
-            if section.kind != QAPIDoc.Kind.PLAIN and section.text == '':
+            if (
+                    section.kind not in (
+                        QAPIDoc.Kind.INTRO, QAPIDoc.Kind.DETAILS
+                    ) and section.text == ''
+            ):
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.kind)
 
-    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
-        kind = QAPIDoc.Kind.PLAIN
+    def ensure_untagged_section(
+        self,
+        info: QAPISourceInfo,
+        intro: bool = True,
+    ) -> None:
+        kind = QAPIDoc.Kind.INTRO if intro else QAPIDoc.Kind.DETAILS
 
         if self.all_sections and self.all_sections[-1].kind == kind:
             # extend current section
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 04a55072646..04e29e8d50f 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -116,7 +116,7 @@ The _one_ {and only}, description on the same line
 Also _one_ {and only}
     feature=enum-member-feat
 a member feature
-    section=Plain
+    section=Details
 @two is undocumented
 doc symbol=Base
     body=
@@ -175,7 +175,7 @@ description starts on the same line
 a feature
     feature=cmd-feat2
 another feature
-    section=Plain
+    section=Details
 .. note:: @arg3 is undocumented
     section=Returns
 @Object
@@ -183,7 +183,7 @@ another feature
 some
     section=Todo
 frobnicate
-    section=Plain
+    section=Details
 .. admonition:: Notes
 
  - Lorem ipsum dolor sit amet
@@ -216,7 +216,7 @@ If you're bored enough to read this, go see a video of boxed cats
 a feature
     feature=cmd-feat2
 another feature
-    section=Plain
+    section=Details
 .. qmp-example::
 
    -> "this example"
-- 
2.53.0


