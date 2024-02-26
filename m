Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2FC0C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:53:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZD-0002kX-1x; Mon, 26 Feb 2024 05:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYg-0002bc-Dr
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYZ-0003io-Fv
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HlwZfUu7aZshrJvo0RyUUeAZQEM9eADcDp82hTJ3OqU=;
 b=CgJE7mOYKh/XJIBrU23JgwJBqaMJU7zdZEpfLeNFoxrOLwi/a090y3vAhjJIEgiM4cqo6Y
 6+RphIZZspQ9CexkQ/ne4QHUGw2P3RKBpTGfWVskaZi73ixtLcoPsQBP1nwACuViaRz09C
 lZt9PGODM34UWls+zoYYtuzTBVGN1A0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-yOqwrroTP7Wl6bQ3kPuaxg-1; Mon, 26 Feb 2024 05:49:57 -0500
X-MC-Unique: yOqwrroTP7Wl6bQ3kPuaxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BFDE845E60;
 Mon, 26 Feb 2024 10:49:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE84C2026D0A;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A9B6721E5A58; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 12/17] qapi: Recognize section tags and 'Features:' only after
 blank line
Date: Mon, 26 Feb 2024 11:49:49 +0100
Message-ID: <20240226104954.3781985-13-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Putting a blank line before section tags and 'Features:' is good,
existing practice.  Enforce it.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-12-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/devel/qapi-code-gen.rst                 | 15 +++++++++------
 scripts/qapi/parser.py                       | 11 ++++++++---
 tests/qapi-schema/doc-duplicated-return.err  |  2 +-
 tests/qapi-schema/doc-duplicated-return.json |  1 +
 tests/qapi-schema/doc-duplicated-since.err   |  2 +-
 tests/qapi-schema/doc-duplicated-since.json  |  1 +
 tests/qapi-schema/doc-good.json              |  9 +++++++++
 tests/qapi-schema/doc-invalid-return.err     |  2 +-
 tests/qapi-schema/doc-invalid-return.json    |  1 +
 9 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 77a40f3bdc..6804a4b596 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -986,16 +986,17 @@ indented like this::
 Extensions added after the definition was first released carry a
 "(since x.y.z)" comment.
 
-The feature descriptions must be preceded by a line "Features:", like
-this::
+The feature descriptions must be preceded by a blank line and then a
+line "Features:", like this::
 
+  #
   # Features:
   #
   # @feature: Description text
 
-A tagged section starts with one of the following words:
-"Note:"/"Notes:", "Since:", "Example:"/"Examples:", "Returns:",
-"TODO:".  The section ends with the start of a new section.
+A tagged section begins with a paragraph that starts with one of the
+following words: "Note:"/"Notes:", "Since:", "Example:"/"Examples:",
+"Returns:", "TODO:".  It ends with the start of a new section.
 
 The second and subsequent lines of tagged sections must be indented
 like this::
@@ -1086,8 +1087,10 @@ need to line up with each other, like this::
  #     or cache associativity unknown)
  #     (since 5.0)
 
-Section tags are case-sensitive and end with a colon.  Good example::
+Section tags are case-sensitive and end with a colon.  They are only
+recognized after a blank line.  Good example::
 
+ #
  # Since: 7.1
 
 Bad examples (all ordinary paragraphs)::
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index f8da315332..de2ce3ec2c 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -538,6 +538,7 @@ def __init__(self, parser: QAPISchemaParser, info: QAPISourceInfo):
         # the current section
         self._section = self.body
         self._append_line = self._append_body_line
+        self._first_line_in_paragraph = False
 
     def has_section(self, tag: str) -> bool:
         """Return True if we have a section with this tag."""
@@ -560,12 +561,14 @@ def append(self, line: str) -> None:
         line = line[1:]
         if not line:
             self._append_freeform(line)
+            self._first_line_in_paragraph = True
             return
 
         if line[0] != ' ':
             raise QAPIParseError(self._parser, "missing space after #")
         line = line[1:]
         self._append_line(line)
+        self._first_line_in_paragraph = False
 
     def end_comment(self) -> None:
         self._switch_section(QAPIDoc.NullSection(self._parser))
@@ -574,9 +577,11 @@ def end_comment(self) -> None:
     def _match_at_name_colon(string: str) -> Optional[Match[str]]:
         return re.match(r'@([^:]*): *', string)
 
-    @staticmethod
-    def _match_section_tag(string: str) -> Optional[Match[str]]:
-        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
+    def _match_section_tag(self, string: str) -> Optional[Match[str]]:
+        if not self._first_line_in_paragraph:
+            return None
+        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *',
+                        string)
 
     def _append_body_line(self, line: str) -> None:
         """
diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-schema/doc-duplicated-return.err
index fe97e3db8d..f19a2b8ec4 100644
--- a/tests/qapi-schema/doc-duplicated-return.err
+++ b/tests/qapi-schema/doc-duplicated-return.err
@@ -1 +1 @@
-doc-duplicated-return.json:7:1: duplicated 'Returns' section
+doc-duplicated-return.json:8:1: duplicated 'Returns' section
diff --git a/tests/qapi-schema/doc-duplicated-return.json b/tests/qapi-schema/doc-duplicated-return.json
index b44b5ae979..4e1ec2ef42 100644
--- a/tests/qapi-schema/doc-duplicated-return.json
+++ b/tests/qapi-schema/doc-duplicated-return.json
@@ -4,5 +4,6 @@
 # @foo:
 #
 # Returns: 0
+#
 # Returns: 1
 ##
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-schema/doc-duplicated-since.err
index abca141a2c..565b753b6a 100644
--- a/tests/qapi-schema/doc-duplicated-since.err
+++ b/tests/qapi-schema/doc-duplicated-since.err
@@ -1 +1 @@
-doc-duplicated-since.json:7:1: duplicated 'Since' section
+doc-duplicated-since.json:8:1: duplicated 'Since' section
diff --git a/tests/qapi-schema/doc-duplicated-since.json b/tests/qapi-schema/doc-duplicated-since.json
index 343cd872cb..2755f95719 100644
--- a/tests/qapi-schema/doc-duplicated-since.json
+++ b/tests/qapi-schema/doc-duplicated-since.json
@@ -4,5 +4,6 @@
 # @foo:
 #
 # Since: 0
+#
 # Since: 1
 ##
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 977bb38b6e..5bb2b69071 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -154,22 +154,29 @@
 # Features:
 # @cmd-feat1: a feature
 # @cmd-feat2: another feature
+#
 # Note: @arg3 is undocumented
+#
 # Returns: @Object
+#
 # TODO: frobnicate
+#
 # Notes:
 #
 #  - Lorem ipsum dolor sit amet
 #  - Ut enim ad minim veniam
 #
 #  Duis aute irure dolor
+#
 # Example:
 #
 #  -> in
 #  <- out
+#
 # Examples:
 #  - *verbatim*
 #  - {braces}
+#
 # Since: 2.10
 ##
 { 'command': 'cmd',
@@ -180,9 +187,11 @@
 ##
 # @cmd-boxed:
 # If you're bored enough to read this, go see a video of boxed cats
+#
 # Features:
 # @cmd-feat1: a feature
 # @cmd-feat2: another feature
+#
 # Example:
 #
 #  -> in
diff --git a/tests/qapi-schema/doc-invalid-return.err b/tests/qapi-schema/doc-invalid-return.err
index bc5826de20..3d9e71c2b3 100644
--- a/tests/qapi-schema/doc-invalid-return.err
+++ b/tests/qapi-schema/doc-invalid-return.err
@@ -1 +1 @@
-doc-invalid-return.json:5: 'Returns:' is only valid for commands
+doc-invalid-return.json:6: 'Returns:' is only valid for commands
diff --git a/tests/qapi-schema/doc-invalid-return.json b/tests/qapi-schema/doc-invalid-return.json
index 95e7583930..1aabef3482 100644
--- a/tests/qapi-schema/doc-invalid-return.json
+++ b/tests/qapi-schema/doc-invalid-return.json
@@ -2,6 +2,7 @@
 
 ##
 # @FOO:
+#
 # Returns: blah
 ##
 { 'event': 'FOO' }
-- 
2.43.0


