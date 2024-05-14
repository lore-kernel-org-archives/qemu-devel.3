Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56DFAC04FFE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 22:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s70AN-0005hr-3B; Tue, 14 May 2024 17:58:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AL-0005fi-1X
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s70AE-0008VM-1E
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UmRJ2o/Nw5EvJ/nYmvUPiVWV0dgik2S+bAY6mCQZBXo=;
 b=YqlEQIbQ2vTU7NaIjdiuOQ8HCSkXCk1Ia8MGpP4CUOYsMbYDvzwMX7Zal4YeG0npECfBCl
 QQH6YMI3hJSF2gcpY97lf+wi1ok5ol59SIBk6AMfmGJpd11aeD/K+T53AJHAL+KlppW2e4
 d6N2IkVgZfXeX3qudmIeDhchAzrOYeE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-Lea9fgNkMj-PXTy1IGsaog-1; Tue,
 14 May 2024 17:58:12 -0400
X-MC-Unique: Lea9fgNkMj-PXTy1IGsaog-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 893371C031AC;
 Tue, 14 May 2024 21:58:11 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C5E523C27;
 Tue, 14 May 2024 21:58:07 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Markus Armbruster <armbru@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Kevin Wolf <kwolf@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Mads Ynddal <mads@ynddal.dk>,
 Jason Wang <jasowang@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-block@nongnu.org,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH 08/20] qapi/parser: differentiate intro and outro paragraphs
Date: Tue, 14 May 2024 17:57:27 -0400
Message-ID: <20240514215740.940155-9-jsnow@redhat.com>
In-Reply-To: <20240514215740.940155-1-jsnow@redhat.com>
References: <20240514215740.940155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.974,
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

Add a semantic tag to paragraphs that appear *before* tagged
sections/members/features and those that appear after. This will control
how they are inlined when doc sections are merged and flattened.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qapi/parser.py | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index cf4cbca1c1f..b1794f71e12 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -503,6 +503,10 @@ def get_doc(self) -> 'QAPIDoc':
             self.accept(False)
             line = self.get_doc_line()
             no_more_args = False
+            # Paragraphs before members/features/tagged are "intro" paragraphs.
+            # Any appearing subsequently are "outro" paragraphs.
+            # This is only semantic metadata for the doc generator.
+            intro = True
 
             while line is not None:
                 # Blank lines
@@ -532,6 +536,7 @@ def get_doc(self) -> 'QAPIDoc':
                         raise QAPIParseError(
                             self, 'feature descriptions expected')
                     no_more_args = True
+                    intro = False
                 elif match := self._match_at_name_colon(line):
                     # description
                     if no_more_args:
@@ -547,6 +552,7 @@ def get_doc(self) -> 'QAPIDoc':
                             doc.append_line(text)
                         line = self.get_doc_indented(doc)
                     no_more_args = True
+                    intro = False
                 elif match := re.match(
                         r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
                         line):
@@ -557,13 +563,14 @@ def get_doc(self) -> 'QAPIDoc':
                         doc.append_line(text)
                     line = self.get_doc_indented(doc)
                     no_more_args = True
+                    intro = False
                 elif line.startswith('='):
                     raise QAPIParseError(
                         self,
                         "unexpected '=' markup in definition documentation")
                 else:
                     # tag-less paragraph
-                    doc.ensure_untagged_section(self.info)
+                    doc.ensure_untagged_section(self.info, intro)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
         else:
@@ -617,7 +624,7 @@ def __init__(
             self,
             info: QAPISourceInfo,
             tag: Optional[str] = None,
-            kind: str = 'paragraph',
+            kind: str = 'intro-paragraph',
         ):
             # section source info, i.e. where it begins
             self.info = info
@@ -625,7 +632,7 @@ def __init__(
             self.tag = tag
             # section text without tag
             self.text = ''
-            # section type - {paragraph, feature, member, tagged}
+            # section type - {<intro|outro>-paragraph, feature, member, tagged}
             self.kind = kind
 
         def append_line(self, line: str) -> None:
@@ -666,7 +673,11 @@ def end(self) -> None:
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.tag)
 
-    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
+    def ensure_untagged_section(
+        self,
+        info: QAPISourceInfo,
+        intro: bool = True,
+    ) -> None:
         if self.all_sections and not self.all_sections[-1].tag:
             section = self.all_sections[-1]
             # Section is empty so far; update info to start *here*.
@@ -677,7 +688,8 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
                 self.all_sections[-1].text += '\n'
             return
         # start new section
-        section = self.Section(info)
+        kind = ("intro" if intro else "outro") + "-paragraph"
+        section = self.Section(info, kind=kind)
         self.sections.append(section)
         self.all_sections.append(section)
 
-- 
2.44.0


