Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26684CA5FA1
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:38:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJyr-00071s-5d; Mon, 28 Sep 2026 18:37:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyp-00071G-6i
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyn-0006Do-Et
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635068;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zNPSCAGT8naj7/CMTraZ0sXWBDY1bHeXVOh1E8VeXRA=;
 b=OUzaL4uXs3/U849c9itTEgIsFcFRf7gAQdfzfzWs+SmNFaaBkKtGJXRAFRrdY8AnLDmAHp
 2YLO6dGsGrDdc0iab3/hNQjCDWtId0Iyy+Vap+eZ5dmibyQa6miXAAeEtmX6rxo8gYvw5u
 KJJiwCEwRXo6iUjJKEwk8WWXbzx1HHs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-Yo0bDo4bP6uVU5qGS7-oCw-1; Mon,
 28 Sep 2026 18:37:46 -0400
X-MC-Unique: Yo0bDo4bP6uVU5qGS7-oCw-1
X-Mimecast-MFC-AGG-ID: Yo0bDo4bP6uVU5qGS7-oCw_1790635064
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A96BE1926B77; Mon, 28 Sep 2026 22:37:43 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CE1581956047; Mon, 28 Sep 2026 22:37:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Hanna Reitz <hreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jiri Pirko <jiri@resnulli.us>, Alex Williamson <alex@shazbot.org>,
 Markus Armbruster <armbru@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Roth <michael.roth@amd.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowangio@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>
Subject: [PATCH 04/14] qapi/parser: enforce doc block section ordering
Date: Mon, 28 Sep 2026 18:36:47 -0400
Message-ID: <20260928223657.2303684-5-jsnow@redhat.com>
In-Reply-To: <20260928223657.2303684-1-jsnow@redhat.com>
References: <20260928223657.2303684-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Enforce the relative ordering of "Intro", "Members", "Features",
"Errors" and "Returns" sections.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst | 19 +++++++++++------
 scripts/qapi/parser.py       | 41 ++++++++++++++++++++++++++++++------
 2 files changed, 48 insertions(+), 12 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 3ac1c2dae18..29e9c5a3da6 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -985,12 +985,19 @@ When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
 Definition documentation starts with a description naming the
-definition with an optional indented overview (the "intro"),
-:ref:`descriptions <doc-descrip>` of each argument (for commands and
-events), member (for structs and unions), branch (for alternates), or
-value (for enums), :ref:`feature descriptions <doc-feat>` of each
-feature (if any), and finally optional :ref:`tagged sections
-<doc-tagged>`.
+definition with an optional indented overview (the "intro").
+
+The introduction is followed by :ref:`descriptions <doc-descrip>` of
+each argument (for commands and events), member (for structs and
+unions), branch (for alternates), or value (for enums).
+
+:ref:`Tagged sections <doc-tagged>` follow in order: Returns (for
+commands), Errors (for commands), and lastly :ref:`feature
+descriptions <doc-feat>` if applicable.
+
+Definition documentation concludes with rST-formatted detail
+paragraphs (including examples, notes, &c), and finally an optional
+"Since" tagged section at the very end.
 
 .. _doc-descrip:
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index fe284a3f866..94a60a23482 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -545,6 +545,28 @@ def get_doc(self) -> 'QAPIDoc':
             doc.all_sections.append(QAPIDoc.Section(info, QAPIDoc.Kind.INTRO))
             line = self.get_doc_indented(doc)
             no_more_args = False
+            last_ordered_section = QAPIDoc.Kind.INTRO
+
+            def _tag_check(this: Union['QAPIDoc.Kind', str]) -> None:
+                nonlocal last_ordered_section
+                if isinstance(this, str):
+                    this = QAPIDoc.Kind.from_string(this)
+
+                if this in (QAPIDoc.Kind.TODO, QAPIDoc.Kind.SINCE,
+                            QAPIDoc.Kind.DETAILS):
+                    return
+
+                if this.value < last_ordered_section.value:
+                    raise QAPIParseError(
+                        self,
+                        f"'{this}' section cannot appear after "
+                        f"'{last_ordered_section}' section, please re-order "
+                        "the sections and adjust phrasing as necessary to "
+                        "ensure consistent documentation flow between the "
+                        "source code and the rendered HTML manual"
+                    )
+
+                last_ordered_section = this
 
             while line is not None:
                 # Blank lines
@@ -558,6 +580,7 @@ def get_doc(self) -> 'QAPIDoc':
                     if doc.has_features:
                         raise QAPIParseError(
                             self, "duplicated 'Features:' line")
+                    _tag_check(QAPIDoc.Kind.FEATURE)
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -581,6 +604,7 @@ def get_doc(self) -> 'QAPIDoc':
                             self,
                             "description of '@%s:' follows a section"
                             % match.group(1))
+                    _tag_check(QAPIDoc.Kind.MEMBER)
                     while (line is not None
                            and (match := self._match_at_name_colon(line))):
                         doc.new_argument(self.info, match.group(1))
@@ -621,6 +645,7 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
+                    _tag_check(match.group(1))
                     doc.new_tagged_section(
                         self.info,
                         QAPIDoc.Kind.from_string(match.group(1))
@@ -632,6 +657,7 @@ def get_doc(self) -> 'QAPIDoc':
                     no_more_args = True
                 else:
                     # plain paragraph(s)
+                    _tag_check(QAPIDoc.Kind.DETAILS)
                     doc.ensure_untagged_section(self.info)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
@@ -674,14 +700,17 @@ class QAPIDoc:
     """
 
     class Kind(enum.Enum):
-        DETAILS = 0
+        # The order here is the order in which sections must appear in
+        # source code; with the exception of 'TODO' which may appear
+        # anywhere but is treated as a comment.
+        INTRO = 0
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
-        INTRO = 7
+        SINCE = 7
 
         @staticmethod
         def from_string(kind: str) -> 'QAPIDoc.Kind':
-- 
2.55.0


