Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA23CA5FA5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 22:38:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBJyO-0006w9-IV; Mon, 28 Sep 2026 18:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyL-0006ve-JC
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1xBJyJ-0006Au-Vk
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 18:37:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790635039;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E+Zr6oBsNO7wFv93vQtkNM89+5YyTi98aTofwxg5+II=;
 b=CN5GJ8AZZyg4uKuBXOq2aso/rW9nZwbKAz0NOXXhTh785B3guq34Blap8+2eRAN2cou9kO
 Mr2XsSwLik/1OcTOrU5/DgieFEyQWRfgpuI9KHRba7452+Nsy4aT7dFSz7y2FYOkahFMYn
 la5n0gH3mz08tMmK2d3u1v1lknM1k5Q=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-gIoMuClhMpeLpMqxdzqezw-1; Mon,
 28 Sep 2026 18:37:16 -0400
X-MC-Unique: gIoMuClhMpeLpMqxdzqezw-1
X-Mimecast-MFC-AGG-ID: gIoMuClhMpeLpMqxdzqezw_1790635034
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 567751926B77; Mon, 28 Sep 2026 22:37:13 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.217])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D634C19560AB; Mon, 28 Sep 2026 22:37:07 +0000 (UTC)
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
Subject: [PATCH 01/14] qapi: rename "plain" sections to "details"
Date: Mon, 28 Sep 2026 18:36:44 -0400
Message-ID: <20260928223657.2303684-2-jsnow@redhat.com>
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

With this change, we no longer have "plaintext" sections at all: they
are all now either "Intro" or "Details". This patch does not enforce
where those details sections must occur; that change occurs in a later
patch.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py         |  2 +-
 scripts/qapi/parser.py         | 18 +++++++++++-------
 tests/qapi-schema/doc-good.out | 18 +++++++++---------
 3 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 54a32e45f7e..ae57056a393 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -383,7 +383,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
         for section in sections:
             section.text = self.reformat_arobase(section.text)
 
-            if section.kind.name in ("PLAIN", "INTRO"):
+            if section.kind.name in ("INTRO", "DETAILS"):
                 self.visit_plaintext(section)
             elif section.kind == QAPIDoc.Kind.MEMBER:
                 assert isinstance(section, QAPIDoc.ArgSection)
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index dcc04b2663e..fe284a3f866 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -674,7 +674,7 @@ class QAPIDoc:
     """
 
     class Kind(enum.Enum):
-        PLAIN = 0
+        DETAILS = 0
         MEMBER = 1
         FEATURE = 2
         RETURNS = 3
@@ -747,12 +747,16 @@ def has_features(self) -> bool:
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
-            if not (section.kind.name in ("INTRO", "PLAIN") or section.text):
+            if (
+                    section.kind not in (
+                        QAPIDoc.Kind.INTRO, QAPIDoc.Kind.DETAILS
+                    ) and section.text == ''
+            ):
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.kind)
 
     def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
-        kind = QAPIDoc.Kind.PLAIN
+        kind = QAPIDoc.Kind.DETAILS
 
         if self.all_sections and self.all_sections[-1].kind == kind:
             # extend current section
@@ -837,8 +841,8 @@ def _insert_after_intro(
         """
         Insert a section immediately after the intro section.
 
-        While we convert PLAIN sections to INTRO sections, all
-        contiguous INTRO/PLAIN sections at the start of a QAPIDoc
+        While we convert DETAILS sections to INTRO sections, all
+        contiguous INTRO/DETAILS sections at the start of a QAPIDoc
         section list are treated as "the intro".
 
         Once INTRO conversion is complete, this helper will no longer be
@@ -855,7 +859,7 @@ def _insert_after_intro(
 
         index = 0
         for index, ref_section in enumerate(self.all_sections):
-            if ref_section.kind.name in ("PLAIN", "INTRO"):
+            if ref_section.kind.name in ("INTRO", "DETAILS"):
                 continue
             break
         else:
@@ -871,7 +875,7 @@ def append_member_stub(self, stub: 'QAPIDoc.Section') -> None:
         if self._insert_near_kind(QAPIDoc.Kind.MEMBER, stub, True):
             return
 
-        # No MEMBER sections present. Insert after INTRO/PLAIN sections.
+        # No MEMBER sections present. Insert after INTRO/DETAILS sections.
         self._insert_after_intro(stub)
 
     def connect_member(self, member: 'QAPISchemaMember') -> None:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index eaaf119dea8..1d4fbd3762a 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -54,15 +54,15 @@ event EVT_BOXED Object
     boxed=True
     feature feat3
 doc freeform
-    Plain
+    Details
 *******
 Section
 *******
 doc freeform
-    Plain
+    Details
 Just text, no heading.
 doc freeform
-    Plain
+    Details
 Subsection
 ==========
 
@@ -116,7 +116,7 @@ The _one_ {and only}, description on the same line
 Also _one_ {and only}
     Feature=enum-member-feat
 a member feature
-    Plain
+    Details
 @two is undocumented
 doc symbol=Base
     Intro
@@ -131,7 +131,7 @@ doc symbol=Variant1
     Another paragraph
     Member=var1
 
-    Plain
+    Details
 @var1 is undocumented
     Feature=variant1-feat
 a feature
@@ -157,7 +157,7 @@ description starts on the same line
     Feature=alt-feat
 a feature
 doc freeform
-    Plain
+    Details
 Another subsection
 ==================
 doc symbol=cmd
@@ -175,7 +175,7 @@ description starts on the same line
 a feature
     Feature=cmd-feat2
 another feature
-    Plain
+    Details
 .. note:: @arg3 is undocumented
     Returns
 @Object
@@ -183,7 +183,7 @@ another feature
 some
     Todo
 frobnicate
-    Plain
+    Details
 .. admonition:: Notes
 
  - Lorem ipsum dolor sit amet
@@ -217,7 +217,7 @@ doc symbol=cmd-boxed
 a feature
     Feature=cmd-feat2
 another feature
-    Plain
+    Details
 .. qmp-example::
 
    -> "this example"
-- 
2.55.0


