Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5923C48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razg5-0005xe-Oc; Fri, 16 Feb 2024 09:59:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razg1-0005u0-Lx
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfy-00083X-1u
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ayzqrCGnN+bTkvGcJo2VWUwPmuqrj02rJlUdNWCYIX0=;
 b=QtN2CUp2RSRLJjb7ou/gqpYGRygtSfBd/av//AWGlM1kXuuNF+69AQhAeUt8RZmhs3K2da
 7feP5lV/ThyzVtKQHvnEtfWIVxYrtdiXl0BrqtdiTCyxTeTnXgEUXt7zr/tQ7c2lGtkMb1
 UJrnD3VsaDeiU8H7nAcDnOKRTUUTrJo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-538-KiwaqQI2P9KEwcUpoa_TQw-1; Fri,
 16 Feb 2024 09:58:50 -0500
X-MC-Unique: KiwaqQI2P9KEwcUpoa_TQw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C17AB1C04333;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 819822166AE5;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3F5C421E5A5C; Fri, 16 Feb 2024 15:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 16/16] qapi: Divorce QAPIDoc from QAPIParseError
Date: Fri, 16 Feb 2024 15:58:40 +0100
Message-ID: <20240216145841.2099240-17-armbru@redhat.com>
In-Reply-To: <20240216145841.2099240-1-armbru@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

QAPIDoc stores a reference to QAPIParser just to pass it to
QAPIParseError.  The resulting error position depends on the state of
the parser.  It happens to be the current comment line.  Servicable,
but action at a distance.

The commit before previous moved most uses of QAPIParseError from
QAPIDoc to QAPIParser.  There are just three left.  Convert them to
QAPISemError.  This involves passing info to a few methods.  Then drop
the reference to QAPIParser.

The three errors lose the column number.  Not really interesting here:
it's the comment line's indentation.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                      | 66 +++++++++------------
 tests/qapi-schema/doc-duplicated-arg.err    |  2 +-
 tests/qapi-schema/doc-duplicated-return.err |  2 +-
 tests/qapi-schema/doc-duplicated-since.err  |  2 +-
 tests/qapi-schema/doc-empty-arg.err         |  2 +-
 5 files changed, 32 insertions(+), 42 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 3d8c62b412..11707418fb 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -494,7 +494,7 @@ def get_doc(self) -> 'QAPIDoc':
             symbol = line[1:-1]
             if not symbol:
                 raise QAPIParseError(self, "name required after '@'")
-            doc = QAPIDoc(self, info, symbol)
+            doc = QAPIDoc(info, symbol)
             self.accept(False)
             line = self.get_doc_line()
             no_more_args = False
@@ -518,7 +518,7 @@ def get_doc(self) -> 'QAPIDoc':
                         line = self.get_doc_line()
                     while (line is not None
                            and (match := self._match_at_name_colon(line))):
-                        doc.new_feature(match.group(1))
+                        doc.new_feature(self.info, match.group(1))
                         text = line[match.end():]
                         if text:
                             doc.append_line(text)
@@ -536,7 +536,7 @@ def get_doc(self) -> 'QAPIDoc':
                             % match.group(1))
                     while (line is not None
                            and (match := self._match_at_name_colon(line))):
-                        doc.new_argument(match.group(1))
+                        doc.new_argument(self.info, match.group(1))
                         text = line[match.end():]
                         if text:
                             doc.append_line(text)
@@ -546,7 +546,7 @@ def get_doc(self) -> 'QAPIDoc':
                         r'(Returns|Since|Notes?|Examples?|TODO): *',
                         line):
                     # tagged section
-                    doc.new_tagged_section(match.group(1))
+                    doc.new_tagged_section(self.info, match.group(1))
                     text = line[match.end():]
                     if text:
                         doc.append_line(text)
@@ -558,13 +558,13 @@ def get_doc(self) -> 'QAPIDoc':
                         "unexpected '=' markup in definition documentation")
                 else:
                     # tag-less paragraph
-                    doc.ensure_untagged_section()
+                    doc.ensure_untagged_section(self.info)
                     doc.append_line(line)
                     line = self.get_doc_paragraph(doc)
         else:
             # Free-form documentation
-            doc = QAPIDoc(self, info)
-            doc.ensure_untagged_section()
+            doc = QAPIDoc(info)
+            doc.ensure_untagged_section(self.info)
             first = True
             while line is not None:
                 if match := self._match_at_name_colon(line):
@@ -607,12 +607,10 @@ class QAPIDoc:
     """
 
     class Section:
-        def __init__(self, parser: QAPISchemaParser,
+        def __init__(self, info: QAPISourceInfo,
                      tag: Optional[str] = None):
             # section source info, i.e. where it begins
-            self.info = parser.info
-            # parser, for error messages about indentation
-            self._parser = parser
+            self.info = info
             # section tag, if any ('Returns', '@name', ...)
             self.tag = tag
             # section text without tag
@@ -622,27 +620,20 @@ def append_line(self, line: str) -> None:
             self.text += line + '\n'
 
     class ArgSection(Section):
-        def __init__(self, parser: QAPISchemaParser,
-                     tag: str):
-            super().__init__(parser, tag)
+        def __init__(self, info: QAPISourceInfo, tag: str):
+            super().__init__(info, tag)
             self.member: Optional['QAPISchemaMember'] = None
 
         def connect(self, member: 'QAPISchemaMember') -> None:
             self.member = member
 
-    def __init__(self, parser: QAPISchemaParser, info: QAPISourceInfo,
-                 symbol: Optional[str] = None):
-        # self._parser is used to report errors with QAPIParseError.  The
-        # resulting error position depends on the state of the parser.
-        # It happens to be the beginning of the comment.  More or less
-        # servicable, but action at a distance.
-        self._parser = parser
+    def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # info points to the doc comment block's first line
         self.info = info
         # definition doc's symbol, None for free-form doc
         self.symbol: Optional[str] = symbol
         # the sections in textual order
-        self.all_sections: List[QAPIDoc.Section] = [QAPIDoc.Section(parser)]
+        self.all_sections: List[QAPIDoc.Section] = [QAPIDoc.Section(info)]
         # the body section
         self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
         # dicts mapping parameter/feature names to their description
@@ -658,44 +649,43 @@ def end(self) -> None:
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.tag)
 
-    def ensure_untagged_section(self) -> None:
+    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
         if self.all_sections and not self.all_sections[-1].tag:
             # extend current section
             self.all_sections[-1].text += '\n'
             return
         # start new section
-        section = self.Section(self._parser)
+        section = self.Section(info)
         self.sections.append(section)
         self.all_sections.append(section)
 
-    def new_tagged_section(self, tag: str) -> None:
+    def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
         if tag in ('Returns', 'Since'):
             for section in self.all_sections:
                 if isinstance(section, self.ArgSection):
                     continue
                 if section.tag == tag:
-                    raise QAPIParseError(
-                        self._parser, "duplicated '%s' section" % tag)
-        section = self.Section(self._parser, tag)
+                    raise QAPISemError(
+                        info, "duplicated '%s' section" % tag)
+        section = self.Section(info, tag)
         self.sections.append(section)
         self.all_sections.append(section)
 
-    def _new_description(self, name: str,
+    def _new_description(self, info: QAPISourceInfo, name: str,
                          desc: Dict[str, ArgSection]) -> None:
         if not name:
-            raise QAPIParseError(self._parser, "invalid parameter name")
+            raise QAPISemError(info, "invalid parameter name")
         if name in desc:
-            raise QAPIParseError(self._parser,
-                                 "'%s' parameter name duplicated" % name)
-        section = self.ArgSection(self._parser, '@' + name)
+            raise QAPISemError(info, "'%s' parameter name duplicated" % name)
+        section = self.ArgSection(info, '@' + name)
         self.all_sections.append(section)
         desc[name] = section
 
-    def new_argument(self, name: str) -> None:
-        self._new_description(name, self.args)
+    def new_argument(self, info: QAPISourceInfo, name: str) -> None:
+        self._new_description(info, name, self.args)
 
-    def new_feature(self, name: str) -> None:
-        self._new_description(name, self.features)
+    def new_feature(self, info: QAPISourceInfo, name: str) -> None:
+        self._new_description(info, name, self.features)
 
     def append_line(self, line: str) -> None:
         self.all_sections[-1].append_line(line)
@@ -707,7 +697,7 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
             self.args[member.name] = QAPIDoc.ArgSection(
-                self._parser, '@' + member.name)
+                self.info, '@' + member.name)
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
diff --git a/tests/qapi-schema/doc-duplicated-arg.err b/tests/qapi-schema/doc-duplicated-arg.err
index 0d0d777a1f..d876312734 100644
--- a/tests/qapi-schema/doc-duplicated-arg.err
+++ b/tests/qapi-schema/doc-duplicated-arg.err
@@ -1 +1 @@
-doc-duplicated-arg.json:6:1: 'a' parameter name duplicated
+doc-duplicated-arg.json:6: 'a' parameter name duplicated
diff --git a/tests/qapi-schema/doc-duplicated-return.err b/tests/qapi-schema/doc-duplicated-return.err
index f19a2b8ec4..503b916b25 100644
--- a/tests/qapi-schema/doc-duplicated-return.err
+++ b/tests/qapi-schema/doc-duplicated-return.err
@@ -1 +1 @@
-doc-duplicated-return.json:8:1: duplicated 'Returns' section
+doc-duplicated-return.json:8: duplicated 'Returns' section
diff --git a/tests/qapi-schema/doc-duplicated-since.err b/tests/qapi-schema/doc-duplicated-since.err
index 565b753b6a..a9b60c0c3d 100644
--- a/tests/qapi-schema/doc-duplicated-since.err
+++ b/tests/qapi-schema/doc-duplicated-since.err
@@ -1 +1 @@
-doc-duplicated-since.json:8:1: duplicated 'Since' section
+doc-duplicated-since.json:8: duplicated 'Since' section
diff --git a/tests/qapi-schema/doc-empty-arg.err b/tests/qapi-schema/doc-empty-arg.err
index 2d0f35f310..83f4fc66d5 100644
--- a/tests/qapi-schema/doc-empty-arg.err
+++ b/tests/qapi-schema/doc-empty-arg.err
@@ -1 +1 @@
-doc-empty-arg.json:5:1: invalid parameter name
+doc-empty-arg.json:5: invalid parameter name
-- 
2.43.0


