Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 535F7C54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:52:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZ5-0002ha-Dg; Mon, 26 Feb 2024 05:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYc-0002b0-92
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYZ-0003in-I6
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944598;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RbsmI2YIBgzD3a9xKSNh3LiAi39vXM047TKLXUMTa/0=;
 b=LmBk2G9liSSSlf+54QTW6am8X9kU5QZeHaQ5SMc2Krtkkw/l49AQM/ajI5Gecd3uVrmBWD
 XQkspHXwXRX0JPfLKWkRJ8LxqwPhkelg7aM0zL9e+v365/BZQtkfLeVb9zYWYY0grtmtI6
 BF+gjsWItj4cZlJBn7aHJ2sUqEnOm/o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-101-sngwXIwYNhK51eZDfusxww-1; Mon,
 26 Feb 2024 05:49:57 -0500
X-MC-Unique: sngwXIwYNhK51eZDfusxww-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0D9FA2812FE3;
 Mon, 26 Feb 2024 10:49:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BE8231812;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9DE9721E5A40; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 09/17] qapi: Rename QAPIDoc.Section.name to .tag
Date: Mon, 26 Feb 2024 11:49:46 +0100
Message-ID: <20240226104954.3781985-10-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Since the previous commit, QAPIDoc.Section.name is either
None (untagged section) or the section's tag string ('Returns',
'@name', ...).  Rename it to .tag.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-9-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 docs/sphinx/qapidoc.py         |  6 +++---
 scripts/qapi/parser.py         | 30 +++++++++++++++---------------
 tests/qapi-schema/test-qapi.py |  2 +-
 3 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 1e8b4a70a1..8d428c64b0 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -258,11 +258,11 @@ def _nodes_for_sections(self, doc):
         """Return list of doctree nodes for additional sections"""
         nodelist = []
         for section in doc.sections:
-            if section.name and section.name == 'TODO':
+            if section.tag and section.tag == 'TODO':
                 # Hide TODO: sections
                 continue
-            snode = self._make_section(section.name)
-            if section.name and section.name.startswith('Example'):
+            snode = self._make_section(section.tag)
+            if section.tag and section.tag.startswith('Example'):
                 snode += self._nodes_for_example(section.text)
             else:
                 self._parse_text_into_node(section.text, snode)
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 43daf55860..cc69f4f770 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -471,17 +471,17 @@ class QAPIDoc:
     class Section:
         # pylint: disable=too-few-public-methods
         def __init__(self, parser: QAPISchemaParser,
-                     name: Optional[str] = None):
+                     tag: Optional[str] = None):
             # section source info, i.e. where it begins
             self.info = parser.info
             # parser, for error messages about indentation
             self._parser = parser
             # section tag, if any ('Returns', '@name', ...)
-            self.name = name
+            self.tag = tag
             # section text without tag
             self.text = ''
             # indentation to strip (None means indeterminate)
-            self._indent = None if self.name else 0
+            self._indent = None if self.tag else 0
 
         def append(self, line: str) -> None:
             line = line.rstrip()
@@ -504,8 +504,8 @@ def append(self, line: str) -> None:
 
     class ArgSection(Section):
         def __init__(self, parser: QAPISchemaParser,
-                     name: str):
-            super().__init__(parser, name)
+                     tag: str):
+            super().__init__(parser, tag)
             self.member: Optional['QAPISchemaMember'] = None
 
         def connect(self, member: 'QAPISchemaMember') -> None:
@@ -536,10 +536,10 @@ def __init__(self, parser: QAPISchemaParser, info: QAPISourceInfo):
         self._section = self.body
         self._append_line = self._append_body_line
 
-    def has_section(self, name: str) -> bool:
-        """Return True if we have a section with this name."""
+    def has_section(self, tag: str) -> bool:
+        """Return True if we have a section with this tag."""
         for i in self.sections:
-            if i.name == name:
+            if i.tag == tag:
                 return True
         return False
 
@@ -710,11 +710,11 @@ def _start_args_section(self, name: str) -> None:
     def _start_features_section(self, name: str) -> None:
         self._start_symbol_section(self.features, name)
 
-    def _start_section(self, name: Optional[str] = None) -> None:
-        if name in ('Returns', 'Since') and self.has_section(name):
+    def _start_section(self, tag: Optional[str] = None) -> None:
+        if tag in ('Returns', 'Since') and self.has_section(tag):
             raise QAPIParseError(self._parser,
-                                 "duplicated '%s' section" % name)
-        new_section = QAPIDoc.Section(self._parser, name)
+                                 "duplicated '%s' section" % tag)
+        new_section = QAPIDoc.Section(self._parser, tag)
         self._switch_section(new_section)
         self.sections.append(new_section)
 
@@ -726,10 +726,10 @@ def _switch_section(self, new_section: 'QAPIDoc.Section') -> None:
         if self._section != self.body and not text:
             # We do not create anonymous sections unless there is
             # something to put in them; this is a parser bug.
-            assert self._section.name
+            assert self._section.tag
             raise QAPISemError(
                 self._section.info,
-                "text required after '%s:'" % self._section.name)
+                "text required after '%s:'" % self._section.tag)
 
         self._section = new_section
 
@@ -761,7 +761,7 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
     def check_expr(self, expr: QAPIExpression) -> None:
         if 'command' not in expr:
             sec = next((sec for sec in self.sections
-                        if sec.name == 'Returns'),
+                        if sec.tag == 'Returns'),
                        None)
             if sec:
                 raise QAPISemError(sec.info,
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 14f7b62a44..40095431ae 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -130,7 +130,7 @@ def test_frontend(fname):
         for feat, section in doc.features.items():
             print('    feature=%s\n%s' % (feat, section.text))
         for section in doc.sections:
-            print('    section=%s\n%s' % (section.name, section.text))
+            print('    section=%s\n%s' % (section.tag, section.text))
 
 
 def open_test_result(dir_name, file_name, update):
-- 
2.43.0


