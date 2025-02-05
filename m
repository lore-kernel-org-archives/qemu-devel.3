Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCF37C02194
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfocD-0000PT-0h; Wed, 05 Feb 2025 18:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfobz-0008Me-TN
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfobw-000623-Bb
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:15:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797311;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8PKSfUfVQASo0aYn9iWkW/aHJ0yWG6y6ge07cOtET04=;
 b=V8dUUC0cMPU3iRQ6QNmHBIeOQ/HmE1Ai5YhhWsItAYGcaZbi7Q9ACJRqGiWyurov9ZUUYn
 rZ5IW9qaK2Vg/gof4Qfapj/EmTdb3LUr/WfcQFWodwUtXOuVvPIj+wZUXRy02MVuIcEwws
 uyeMTx54Coxc7CkUKw5c8jBpAnRSg/k=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-336-qaIabqK4MnCbPjo5-3U25Q-1; Wed,
 05 Feb 2025 18:15:08 -0500
X-MC-Unique: qaIabqK4MnCbPjo5-3U25Q-1
X-Mimecast-MFC-AGG-ID: qaIabqK4MnCbPjo5-3U25Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AB6411800984; Wed,  5 Feb 2025 23:15:06 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 246BB1800570; Wed,  5 Feb 2025 23:15:00 +0000 (UTC)
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
Subject: [PATCH 28/42] qapi/parser: prohibit untagged sections between tagged
 sections
Date: Wed,  5 Feb 2025 18:11:54 -0500
Message-ID: <20250205231208.1480762-29-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

This is being done primarily to ensure consistency between the source
documents and the final, rendered HTML output. Because
member/feature/returns sections will always appear in a visually grouped
element in the HTML output, prohibiting free paragraphs between those
sections ensures ordering consistency between source and the final
render.

Additionally, prohibiting such "middle" text paragraphs allows us to
classify all plain text sections as either "intro" or "detail"
sections, because these sections must either appear before structured
elements ("intro") or afterwards ("detail").

This keeps the inlining algorithm simpler with fewer "splice" points
when inlining multiple documentation blocks.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 qapi/net.json                   |  4 ++--
 qapi/qom.json                   |  4 ++--
 scripts/qapi/parser.py          | 16 ++++++++++++++++
 tests/qapi-schema/doc-good.json |  4 ++--
 tests/qapi-schema/doc-good.out  |  4 ++--
 tests/qapi-schema/doc-good.txt  |  8 ++++----
 6 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/qapi/net.json b/qapi/net.json
index 2739a2f4233..49bc7de64e9 100644
--- a/qapi/net.json
+++ b/qapi/net.json
@@ -655,13 +655,13 @@
 #     this to zero disables this function.  This member is mutually
 #     exclusive with @reconnect.  (default: 0) (Since: 9.2)
 #
-# Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
-#
 # Features:
 #
 # @deprecated: Member @reconnect is deprecated.  Use @reconnect-ms
 #     instead.
 #
+# Only SocketAddress types 'unix', 'inet' and 'fd' are supported.
+#
 # Since: 7.2
 ##
 { 'struct': 'NetdevStreamOptions',
diff --git a/qapi/qom.json b/qapi/qom.json
index 28ce24cd8d0..11277d1f84c 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -195,12 +195,12 @@
 #
 # @typename: the type name of an object
 #
+# Returns: a list of ObjectPropertyInfo describing object properties
+#
 # .. note:: Objects can create properties at runtime, for example to
 #    describe links between different devices and/or objects.  These
 #    properties are not included in the output of this command.
 #
-# Returns: a list of ObjectPropertyInfo describing object properties
-#
 # Since: 2.12
 ##
 { 'command': 'qom-list-properties',
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index b2f77ffdd7a..c5d2b950a82 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -500,6 +500,20 @@ def get_doc(self) -> 'QAPIDoc':
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
+                        f"{what!r} section cannot appear after free "
+                        "paragraphs that follow other tagged sections. "
+                        "Move this section upwards with the preceding "
+                        "tagged sections."
+                    )
 
             while line is not None:
                 # Blank lines
@@ -513,6 +527,7 @@ def get_doc(self) -> 'QAPIDoc':
                     if doc.features:
                         raise QAPIParseError(
                             self, "duplicated 'Features:' line")
+                    _tag_check("Features")
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -576,6 +591,7 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
+                    _tag_check(match.group(1))
                     doc.new_tagged_section(
                         self.info,
                         QAPIDoc.Kind.from_string(match.group(1))
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index f64bf38d854..14b2091b08f 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -157,12 +157,12 @@
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
index 3eb28503f6b..77edadb6e40 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -168,12 +168,12 @@ description starts on the same line
 a feature
     feature=cmd-feat2
 another feature
-    section=Detail
-.. note:: @arg3 is undocumented
     section=Returns
 @Object
     section=Errors
 some
+    section=Detail
+.. note:: @arg3 is undocumented
     section=Todo
 frobnicate
     section=Detail
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index cb37db606a6..dc40b3f7046 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -193,10 +193,6 @@ Features
 "cmd-feat2"
    another feature
 
-Note:
-
-  "arg3" is undocumented
-
 
 Returns
 ~~~~~~~
@@ -209,6 +205,10 @@ Errors
 
 some
 
+Note:
+
+  "arg3" is undocumented
+
 Notes:
 
 * Lorem ipsum dolor sit amet
-- 
2.48.1


