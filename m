Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14F10F53D85
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:27:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2CfB-0002RW-TQ; Mon, 16 Mar 2026 14:27:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Cew-0002I4-8C
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2Ceu-0007ze-IJ
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:27:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lKIXJd8NRU5DR7rwShKctvPLHKRhAskhEtUKToDtb6w=;
 b=OC/vh+dh3MutT5lVoNfI2hKONNw+itkgOf5E4GZso7cM6NfhfXdBiupYJk0lI/c5855m2X
 6+p7ivOas+FOf7Qg29/ckbCmAa18bp4pxbovo1m2cQtW8dne3kR2Ib3s4R7SO5u8AIiI6s
 HRcYF6Rh65HRDpgd2fYrcHXVEnu1+XU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-657-Y0IkgOI8OUWu7_U2c63WWQ-1; Mon,
 16 Mar 2026 14:27:16 -0400
X-MC-Unique: Y0IkgOI8OUWu7_U2c63WWQ-1
X-Mimecast-MFC-AGG-ID: Y0IkgOI8OUWu7_U2c63WWQ_1773685634
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E9831800365; Mon, 16 Mar 2026 18:27:14 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 796CD30001A2; Mon, 16 Mar 2026 18:27:05 +0000 (UTC)
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
Subject: [PATCH 6/8] qapi: enforce doc block section ordering
Date: Mon, 16 Mar 2026 14:26:05 -0400
Message-ID: <20260316182608.148628-7-jsnow@redhat.com>
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

Ugly hack, gets the job done. Likely many simplifications can be made as
a result, but I didn't make any of them. There are some inconsistencies
with human-readable vs ENUM_NAMES in error messages in this patch, but
it appears to work anyway.

Consider this patch more of a rough idea and not anything approximating
the kind of code you'd want to see from an Enterprise Linux Senior
Software Engineer.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 39 +++++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9e8dfc67208..1a7856bf213 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -545,19 +545,25 @@ def get_doc(self) -> 'QAPIDoc':
             self.accept(False)
             line = self.get_doc_line()
             have_tagged = False
-            no_more_tags = False
+            last_section = QAPIDoc.Kind.INTRO
 
             def _tag_check(what: str) -> None:
+                nonlocal last_section
+
                 if what in ('TODO', 'Since'):
                     return
 
-                if no_more_tags:
+                this_section = QAPIDoc.Kind.from_string(what)
+                if this_section.value < last_section.value:
                     raise QAPIParseError(
                         self,
-                        f"'{what}' section cannot appear after plain "
-                        "paragraphs that follow other tagged sections\n"
-                        "Move this section up above the plain paragraph(s)."
+                        f"'{what}' section cannot appear after "
+                        f"'{last_section!s}' section, please re-order the "
+                        "sections and adjust phrasing as necessary to ensure "
+                        "consistent documentation flow between the source "
+                        "code and the rendered HTML manual"
                     )
+                last_section = this_section
 
             while line is not None:
                 # Blank lines
@@ -571,7 +577,7 @@ def _tag_check(what: str) -> None:
                     if doc.features:
                         raise QAPIParseError(
                             self, "duplicated 'Features:' line")
-                    _tag_check("Features")
+                    _tag_check("FEATURE")
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -589,7 +595,7 @@ def _tag_check(what: str) -> None:
                             self, 'feature descriptions expected')
                     have_tagged = True
                 elif line == 'Details:':
-                    _tag_check("Details")
+                    _tag_check("DETAILS")
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -598,6 +604,7 @@ def _tag_check(what: str) -> None:
                     have_tagged = True
                 elif match := self._match_at_name_colon(line):
                     # description
+                    _tag_check("MEMBER")
                     if have_tagged:
                         raise QAPIParseError(
                             self,
@@ -654,13 +661,10 @@ def _tag_check(what: str) -> None:
                     line = self.get_doc_indented(doc)
                     have_tagged = True
                 else:
-                    # plain paragraph
-                    if have_tagged:
-                        no_more_tags = True
-
                     # Paragraphs before tagged sections are "intro" paragraphs.
                     # Any appearing after are "detail" paragraphs.
                     intro = not have_tagged
+                    _tag_check("INTRO" if intro else "DETAILS")
                     doc.ensure_untagged_section(self.info, intro)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
@@ -703,14 +707,17 @@ class QAPIDoc:
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
-- 
2.53.0


