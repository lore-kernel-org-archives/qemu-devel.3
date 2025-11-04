Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCAA4CCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 13:23:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGH00-0001Fw-Ft; Tue, 04 Nov 2025 08:23:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyj-0000En-HQ
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vGGyh-0001cz-LK
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 08:21:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762262497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nB9bHUOCLBvQ5g3WUO0uBsAxrycGoa4Rljt33VyM9xs=;
 b=QKRLqjc53oyGMz0YkFTNau2/3XLf9GNLZehYXP9yjEcrq/h+HGmaCA158kT4RZsqnDtnYh
 3yN+VMltqzutI6fX0sMRw9WctMKs4cYQn2KTEV93daTM+mpQdc9k9csPqrLlZhL6AC3eW/
 he7RBMO/mcVa4Dje8dhCIwsMm9SuBeQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-Jk7V5KHnMg-KQg-prgrCZA-1; Tue,
 04 Nov 2025 08:21:33 -0500
X-MC-Unique: Jk7V5KHnMg-KQg-prgrCZA-1
X-Mimecast-MFC-AGG-ID: Jk7V5KHnMg-KQg-prgrCZA_1762262492
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 14D961956070; Tue,  4 Nov 2025 13:21:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C64219540DB; Tue,  4 Nov 2025 13:21:31 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8DFDB21E66E4; Tue, 04 Nov 2025 14:21:25 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: [PULL 12/12] qapi: Add documentation format validation
Date: Tue,  4 Nov 2025 14:21:25 +0100
Message-ID: <20251104132125.4134730-13-armbru@redhat.com>
In-Reply-To: <20251104132125.4134730-1-armbru@redhat.com>
References: <20251104132125.4134730-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Add explicit validation for QAPI documentation formatting rules:

1. Lines must not exceed 70 columns in width (including '# ' prefix)
2. Sentences must be separated by two spaces

Example sections and literal :: blocks (seldom case) are excluded, we
don't require them to be <= 70, that would be too restrictive. Anyway,
they share common 80-columns recommendations (not requirements).

Add two simple tests, illustrating the change.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Message-ID: <20251031183129.246814-1-vsementsov@yandex-team.ru>

The detection of example and literal blocks isn't quite correct, but
it works well enough, and we can improve on top.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Comments, error messages, and test file names tweaked]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                        | 50 ++++++++++++++++++-
 .../doc-bad-space-between-sentences.err       |  2 +
 .../doc-bad-space-between-sentences.json      |  6 +++
 .../doc-bad-space-between-sentences.out       |  0
 tests/qapi-schema/doc-long-line.err           |  1 +
 tests/qapi-schema/doc-long-line.json          |  6 +++
 tests/qapi-schema/doc-long-line.out           |  0
 tests/qapi-schema/meson.build                 |  2 +
 8 files changed, 66 insertions(+), 1 deletion(-)
 create mode 100644 tests/qapi-schema/doc-bad-space-between-sentences.err
 create mode 100644 tests/qapi-schema/doc-bad-space-between-sentences.json
 create mode 100644 tests/qapi-schema/doc-bad-space-between-sentences.out
 create mode 100644 tests/qapi-schema/doc-long-line.err
 create mode 100644 tests/qapi-schema/doc-long-line.json
 create mode 100644 tests/qapi-schema/doc-long-line.out

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 9fbf80a541..1bb1af7051 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -108,6 +108,11 @@ def __init__(self,
         self.exprs: List[QAPIExpression] = []
         self.docs: List[QAPIDoc] = []
 
+        # State for tracking qmp-example blocks and simple
+        # :: literal blocks.
+        self._literal_mode = False
+        self._literal_mode_indent = 0
+
         # Showtime!
         self._parse()
 
@@ -423,12 +428,55 @@ def get_doc_line(self) -> Optional[str]:
             if self.val != '##':
                 raise QAPIParseError(
                     self, "junk after '##' at end of documentation comment")
+            self._literal_mode = False
             return None
         if self.val == '#':
             return ''
         if self.val[1] != ' ':
             raise QAPIParseError(self, "missing space after #")
-        return self.val[2:].rstrip()
+
+        line = self.val[2:].rstrip()
+
+        if re.match(r'(\.\. +qmp-example)? *::$', line):
+            self._literal_mode = True
+            self._literal_mode_indent = 0
+        elif self._literal_mode and line:
+            indent = re.match(r'^ *', line).end()
+            if self._literal_mode_indent == 0:
+                self._literal_mode_indent = indent
+            elif indent < self._literal_mode_indent:
+                # ReST directives stop at decreasing indentation
+                self._literal_mode = False
+
+        if not self._literal_mode:
+            self._validate_doc_line_format(line)
+
+        return line
+
+    def _validate_doc_line_format(self, line: str) -> None:
+        """
+        Validate documentation format rules for a single line:
+        1. Lines should not exceed 70 characters
+        2. Sentences should be separated by two spaces
+        """
+        full_line_length = len(line) + 2  # "# " = 2 characters
+        if full_line_length > 70:
+            # Skip URL lines - they can't be broken
+            if re.match(r' *(https?|ftp)://[^ ]*$', line):
+                pass
+            else:
+                raise QAPIParseError(
+                    self, "documentation line longer than 70 characters")
+
+        single_space_pattern = r'(\be\.g\.|^ *\d\.|([.!?])) [A-Z0-9(]'
+        for m in list(re.finditer(single_space_pattern, line)):
+            if not m.group(2):
+                continue
+            # HACK so the error message points to the offending spot
+            self.pos = self.line_pos + 2 + m.start(2) + 1
+            raise QAPIParseError(
+                self, "Use two spaces between sentences\n"
+                "If this not the end of a sentence, please report a bug.")
 
     @staticmethod
     def _match_at_name_colon(string: str) -> Optional[Match[str]]:
diff --git a/tests/qapi-schema/doc-bad-space-between-sentences.err b/tests/qapi-schema/doc-bad-space-between-sentences.err
new file mode 100644
index 0000000000..479982ce22
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-space-between-sentences.err
@@ -0,0 +1,2 @@
+doc-bad-space-between-sentences.json:4:47: Use two spaces between sentences
+If this not the end of a sentence, please report a bug.
diff --git a/tests/qapi-schema/doc-bad-space-between-sentences.json b/tests/qapi-schema/doc-bad-space-between-sentences.json
new file mode 100644
index 0000000000..87b6f6eb4e
--- /dev/null
+++ b/tests/qapi-schema/doc-bad-space-between-sentences.json
@@ -0,0 +1,6 @@
+##
+# @foo:
+#
+# Sentences should be separated by two spaces. But here is only one.
+##
+{ 'command': 'foo' }
diff --git a/tests/qapi-schema/doc-bad-space-between-sentences.out b/tests/qapi-schema/doc-bad-space-between-sentences.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/doc-long-line.err b/tests/qapi-schema/doc-long-line.err
new file mode 100644
index 0000000000..7baa5297cf
--- /dev/null
+++ b/tests/qapi-schema/doc-long-line.err
@@ -0,0 +1 @@
+doc-long-line.json:4:1: documentation line longer than 70 characters
diff --git a/tests/qapi-schema/doc-long-line.json b/tests/qapi-schema/doc-long-line.json
new file mode 100644
index 0000000000..c10153b0d5
--- /dev/null
+++ b/tests/qapi-schema/doc-long-line.json
@@ -0,0 +1,6 @@
+##
+# @foo:
+#
+# This line has exactly 71 chars, including the leading hash and space.
+##
+{ 'command': 'foo' }
diff --git a/tests/qapi-schema/doc-long-line.out b/tests/qapi-schema/doc-long-line.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index c47025d16d..debff633ac 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -61,6 +61,7 @@ schemas = [
   'doc-bad-event-arg.json',
   'doc-bad-feature.json',
   'doc-bad-indent.json',
+  'doc-bad-space-between-sentences.json',
   'doc-bad-symbol.json',
   'doc-bad-union-member.json',
   'doc-before-include.json',
@@ -81,6 +82,7 @@ schemas = [
   'doc-invalid-return2.json',
   'doc-invalid-section.json',
   'doc-invalid-start.json',
+  'doc-long-line.json',
   'doc-missing-colon.json',
   'doc-missing-expr.json',
   'doc-missing-space.json',
-- 
2.49.0


