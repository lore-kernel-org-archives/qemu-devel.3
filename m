Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9495910F9972
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2026 19:33:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wAYW1-0005qL-Fl; Wed, 08 Apr 2026 15:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAY6p-0007CZ-Rn
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 14:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wAKyL-0005YE-Ir
 for qemu-devel@nongnu.org; Wed, 08 Apr 2026 00:57:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775624221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=12Ibako9l1QCgj1DoburL3oW+TWB9fRmzv8J5Z9tONs=;
 b=R57vrxixTkm1JrPrKfAIo+dwzVhXm7IBSmjNaScOu+5uBLdrinemGhM3JcymGb/l2RWH23
 equJJc1OSJJ2uWP/XXICA/OEp34pqDcIhjKPvauFatYKfFAlePVnOAAhFs2elqZxiPMivr
 2flf9ARXQmvN1ypWsD/QIZj5maoktVE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-tqP6xa1QO76yhAtKpQnmcg-1; Wed,
 08 Apr 2026 00:56:59 -0400
X-MC-Unique: tqP6xa1QO76yhAtKpQnmcg-1
X-Mimecast-MFC-AGG-ID: tqP6xa1QO76yhAtKpQnmcg_1775624217
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E70A195609D; Wed,  8 Apr 2026 04:56:57 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.7])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 54BCB19560A6; Wed,  8 Apr 2026 04:56:47 +0000 (UTC)
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
Subject: [PATCH v2 08/10] qapi: enforce doc block section ordering
Date: Wed,  8 Apr 2026 00:55:29 -0400
Message-ID: <20260408045531.3006678-9-jsnow@redhat.com>
In-Reply-To: <20260408045531.3006678-1-jsnow@redhat.com>
References: <20260408045531.3006678-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Ugly hack, gets the job done. Likely many simplifications can be made as
a result, but I didn't make any of them. There are some inconsistencies
with human-readable vs ENUM_NAMES in error messages in this patch, but
it appears to work anyway.

Consider this patch more of a rough idea and not anything approximating
the kind of code you'd want to see from an Enterprise Linux Senior
Software Engineer.

Signed-off-by: John Snow <jsnow@redhat.com>

---

[Review note: No changes to *.ir files. --js]

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 55 ++++++++++++++++++++++++++----------------
 1 file changed, 34 insertions(+), 21 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index ade26d124df..6e91cd19e58 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -547,22 +547,28 @@ def get_doc(self) -> 'QAPIDoc':
             self.accept(False)
             line = self.get_doc_line()
             have_tagged = False
-            no_more_tags = False
+            last_ordered_section = QAPIDoc.Kind.INTRO
 
             def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
+                nonlocal last_ordered_section
                 if isinstance(this, str):
                     this = QAPIDoc.Kind.from_string(this)
+
                 if this in (QAPIDoc.Kind.TODO, QAPIDoc.Kind.SINCE):
                     return
 
-                if no_more_tags:
+                if this.value < last_ordered_section.value:
                     raise QAPIParseError(
                         self,
-                        f"'{this}' section cannot appear after plain "
-                        "paragraphs that follow other tagged sections\n"
-                        "Move this section up above the plain paragraph(s)."
+                        f"'{this}' section cannot appear after "
+                        f"'{last_ordered_section}' section, please re-order "
+                        "the sections and adjust phrasing as necessary to "
+                        "ensure consistent documentation flow between the "
+                        "source code and the rendered HTML manual"
                     )
 
+                last_ordered_section = this
+
             while line is not None:
                 # Blank lines
                 while line == '':
@@ -593,7 +599,7 @@ def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
                             self, 'feature descriptions expected')
                     have_tagged = True
                 elif line == 'Details:':
-                    _tag_check("Details")
+                    _tag_check(QAPIDoc.Kind.DETAILS)
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -602,6 +608,7 @@ def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
                     have_tagged = True
                 elif match := self._match_at_name_colon(line):
                     # description
+                    _tag_check(QAPIDoc.Kind.MEMBER)
                     if have_tagged:
                         raise QAPIParseError(
                             self,
@@ -658,14 +665,16 @@ def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
                     line = self.get_doc_indented(doc)
                     have_tagged = True
                 else:
-                    # plain paragraph
-                    if have_tagged:
-                        no_more_tags = True
-
-                    # Paragraphs before tagged sections are "intro" paragraphs.
-                    # Any appearing after are "detail" paragraphs.
-                    intro = not have_tagged
-                    doc.ensure_untagged_section(self.info, intro)
+                    # Paragraphs appearing before any other sections are
+                    # "intro" paragraphs. Any appearing after are
+                    # "details" paragraphs.
+                    this_section = (
+                        QAPIDoc.Kind.DETAILS
+                        if have_tagged
+                        else QAPIDoc.Kind.INTRO
+                    )
+                    _tag_check(this_section)
+                    doc.ensure_untagged_section(self.info, this_section)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
         else:
@@ -707,14 +716,17 @@ class QAPIDoc:
     """
 
     class Kind(enum.Enum):
+        # The order here is the order in which sections must appear in
+        # source code; with the exception of 'TODO' which may appear
+        # anywhere but is treated as a comment.
         INTRO = 0
         MEMBER = 1
-        FEATURE = 2
-        RETURNS = 3
-        ERRORS = 4
-        SINCE = 5
+        RETURNS = 2
+        ERRORS = 3
+        FEATURE = 4
+        DETAILS = 5
         TODO = 6
-        DETAILS = 7
+        SINCE = 7
 
         @staticmethod
         def from_string(kind: str) -> 'QAPIDoc.Kind':
@@ -793,9 +805,10 @@ def end(self) -> None:
     def ensure_untagged_section(
         self,
         info: QAPISourceInfo,
-        intro: bool = True,
+        kind: Optional['QAPIDoc.Kind'] = None,
     ) -> None:
-        kind = QAPIDoc.Kind.INTRO if intro else QAPIDoc.Kind.DETAILS
+        if kind is None:
+            kind = QAPIDoc.Kind.INTRO
 
         if self.all_sections and self.all_sections[-1].kind == kind:
             # extend current section
-- 
2.53.0


