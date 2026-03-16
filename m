Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDE8F53D85
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 18:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2Cep-0002Fb-0M; Mon, 16 Mar 2026 14:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2CeO-00029a-Jl
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1w2CeM-0007vk-W0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2026 14:26:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773685606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sy/Cw5GC+xThnVFcAcoMnkGAV6OthaOchQyBKJokw4g=;
 b=H3DOm3Vvy6Y9429UtNuqpn8U/YkeZWO5Ly7g771NNwP3/ior9TKhki0u/fllCwr4XwyZbf
 MzEBPhO+6b6gPVN/IEhkO3sT0v6/T6LPotDgi2AuxOIAsOgUPH9hoHRTW/R9jlg/gokdNR
 PHmZFBhU0DdToUII08zn+yXooBF5BU8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-278-0ZVkTDU-PAu4pCeAlDmK2g-1; Mon,
 16 Mar 2026 14:26:43 -0400
X-MC-Unique: 0ZVkTDU-PAu4pCeAlDmK2g-1
X-Mimecast-MFC-AGG-ID: 0ZVkTDU-PAu4pCeAlDmK2g_1773685601
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 78DF0195609F; Mon, 16 Mar 2026 18:26:40 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.45])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0552830002DA; Mon, 16 Mar 2026 18:26:30 +0000 (UTC)
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
Subject: [PATCH 2/8] qapi: prohibit 'details' sections between tagged sections
Date: Mon, 16 Mar 2026 14:26:01 -0400
Message-ID: <20260316182608.148628-3-jsnow@redhat.com>
In-Reply-To: <20260316182608.148628-1-jsnow@redhat.com>
References: <20260316182608.148628-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This patch prohibits plain documentation sections from appearing between
"tagged" sections. The two existing uses of this pattern are patched
out.

This is being done primarily to ensure consistency between the source
documents and the final, rendered HTML output. Because
member/feature/returns/error sections will always appear in a visually
grouped element in the HTML output, prohibiting plain paragraphs between
those sections ensures ordering consistency between source and the final
render.

Additionally, prohibiting such "middle" text paragraphs allows us to
classify all plain text sections as either "intro" or "details" sections,
because these sections must either appear before structured/tagged
sections ("intro") or afterwards ("details").

This keeps the inlining algorithm simpler with fewer "splice" points
when merging multiple documentation blocks.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/qom.json                   |  4 ++--
 scripts/qapi/parser.py          | 17 +++++++++++++++++
 tests/qapi-schema/doc-good.json |  4 ++--
 tests/qapi-schema/doc-good.out  |  4 ++--
 tests/qapi-schema/doc-good.txt  |  8 ++++----
 5 files changed, 27 insertions(+), 10 deletions(-)

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
index da0ac32ad89..dea056df30d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -545,6 +545,19 @@ def get_doc(self) -> 'QAPIDoc':
             self.accept(False)
             line = self.get_doc_line()
             have_tagged = False
+            no_more_tags = False
+
+            def _tag_check(what: str) -> None:
+                if what in ('TODO', 'Since'):
+                    return
+
+                if no_more_tags:
+                    raise QAPIParseError(
+                        self,
+                        f"'{what}' section cannot appear after plain "
+                        "paragraphs that follow other tagged sections\n"
+                        "Move this section up above the plain paragraph(s)."
+                    )
 
             while line is not None:
                 # Blank lines
@@ -558,6 +571,7 @@ def get_doc(self) -> 'QAPIDoc':
                     if doc.features:
                         raise QAPIParseError(
                             self, "duplicated 'Features:' line")
+                    _tag_check("Features")
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -621,6 +635,7 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
+                    _tag_check(match.group(1))
                     doc.new_tagged_section(
                         self.info,
                         QAPIDoc.Kind.from_string(match.group(1))
@@ -632,6 +647,8 @@ def get_doc(self) -> 'QAPIDoc':
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
-- 
2.53.0


