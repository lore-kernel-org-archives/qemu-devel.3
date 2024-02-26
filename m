Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3259FC54E51
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZE-0002kq-7b; Mon, 26 Feb 2024 05:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYm-0002cD-Gi
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYb-0003jp-NO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zpbPMw0AV3eYRGJICWVf22yH/4UM4eiSrRuRqrdP+o0=;
 b=Z152aEWOT5JH8+zcFY++9+2TADP97kIakyhgn2ZSNLANh2fXqCR3GVJbQ+Fw5FMhEgrixB
 KiBuotMSn6bjbN7EY7Eo4HYx4nXtHH323hPyS7MbwkeD0wv8VI34sRQdqEC98DDEIzkf6x
 ZuBQFXnWsMngX/flRFuSIs3Cy/FPf6g=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-224-b8p_-VwmNa2CC4oVx-nEOQ-1; Mon,
 26 Feb 2024 05:49:59 -0500
X-MC-Unique: b8p_-VwmNa2CC4oVx-nEOQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B5C9A2812FE5;
 Mon, 26 Feb 2024 10:49:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 380AB40166A5;
 Mon, 26 Feb 2024 10:49:58 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B277E21E5A5C; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 15/17] qapi: Rewrite doc comment parser
Date: Mon, 26 Feb 2024 11:49:52 +0100
Message-ID: <20240226104954.3781985-16-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

QAPISchemaParser is a conventional recursive descent parser.  Except
QAPISchemaParser.get_doc() delegates most of the doc comment parsing
work to a state machine in QAPIDoc.  The state machine doesn't get
tokens like a recursive descent parser, it is fed tokens.

I find this state machine rather opaque and hard to maintain.

Replace it by a conventional parser, all in QAPISchemaParser.  Less
code, and (at least in my opinion) easier to understand.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-15-armbru@redhat.com>
Tested-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/parser.py | 478 ++++++++++++++++++-----------------------
 1 file changed, 210 insertions(+), 268 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 48cc9a6367..73ff150430 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -134,8 +134,8 @@ def _parse(self) -> None:
             info = self.info
             if self.tok == '#':
                 self.reject_expr_doc(cur_doc)
-                for cur_doc in self.get_doc(info):
-                    self.docs.append(cur_doc)
+                cur_doc = self.get_doc()
+                self.docs.append(cur_doc)
                 continue
 
             expr = self.get_expr()
@@ -414,39 +414,171 @@ def get_expr(self) -> _ExprValue:
                 self, "expected '{', '[', string, or boolean")
         return expr
 
-    def get_doc(self, info: QAPISourceInfo) -> List['QAPIDoc']:
+    def get_doc_line(self) -> Optional[str]:
+        if self.tok != '#':
+            raise QAPIParseError(
+                self, "documentation comment must end with '##'")
+        assert isinstance(self.val, str)
+        if self.val.startswith('##'):
+            # End of doc comment
+            if self.val != '##':
+                raise QAPIParseError(
+                    self, "junk after '##' at end of documentation comment")
+            return None
+        if self.val == '#':
+            return ''
+        if self.val[1] != ' ':
+            raise QAPIParseError(self, "missing space after #")
+        return self.val[2:].rstrip()
+
+    @staticmethod
+    def _match_at_name_colon(string: str) -> Optional[Match[str]]:
+        return re.match(r'@([^:]*): *', string)
+
+    def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
+        self.accept(False)
+        line = self.get_doc_line()
+        while line == '':
+            doc.append_line(line)
+            self.accept(False)
+            line = self.get_doc_line()
+        if line is None:
+            return line
+        indent = must_match(r'\s*', line).end()
+        if not indent:
+            return line
+        doc.append_line(line[indent:])
+        prev_line_blank = False
+        while True:
+            self.accept(False)
+            line = self.get_doc_line()
+            if line is None:
+                return line
+            if self._match_at_name_colon(line):
+                return line
+            cur_indent = must_match(r'\s*', line).end()
+            if line != '' and cur_indent < indent:
+                if prev_line_blank:
+                    return line
+                raise QAPIParseError(
+                    self,
+                    "unexpected de-indent (expected at least %d spaces)" %
+                    indent)
+            doc.append_line(line[indent:])
+            prev_line_blank = True
+
+    def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:
+        while True:
+            self.accept(False)
+            line = self.get_doc_line()
+            if line is None:
+                return line
+            if line == '':
+                return line
+            doc.append_line(line)
+
+    def get_doc(self) -> 'QAPIDoc':
         if self.val != '##':
             raise QAPIParseError(
                 self, "junk after '##' at start of documentation comment")
-
-        docs = []
-        cur_doc = QAPIDoc(self, info)
+        info = self.info
         self.accept(False)
-        while self.tok == '#':
-            assert isinstance(self.val, str)
-            if self.val.startswith('##'):
-                # End of doc comment
-                if self.val != '##':
-                    raise QAPIParseError(
-                        self,
-                        "junk after '##' at end of documentation comment")
-                cur_doc.end_comment()
-                docs.append(cur_doc)
-                self.accept()
-                return docs
-            if self.val.startswith('# ='):
-                if cur_doc.symbol:
+        line = self.get_doc_line()
+        if line is not None and line.startswith('@'):
+            # Definition documentation
+            if not line.endswith(':'):
+                raise QAPIParseError(self, "line should end with ':'")
+            # Invalid names are not checked here, but the name
+            # provided *must* match the following definition,
+            # which *is* validated in expr.py.
+            symbol = line[1:-1]
+            if not symbol:
+                raise QAPIParseError(self, "name required after '@'")
+            doc = QAPIDoc(self, info, symbol)
+            self.accept(False)
+            line = self.get_doc_line()
+            no_more_args = False
+
+            while line is not None:
+                # Blank lines
+                while line == '':
+                    self.accept(False)
+                    line = self.get_doc_line()
+                if line is None:
+                    break
+                # Non-blank line, first of a section
+                if line == 'Features:' and not doc.features:
+                    self.accept(False)
+                    line = self.get_doc_line()
+                    while line == '':
+                        self.accept(False)
+                        line = self.get_doc_line()
+                    while (line is not None
+                           and (match := self._match_at_name_colon(line))):
+                        doc.new_feature(match.group(1))
+                        text = line[match.end():]
+                        if text:
+                            doc.append_line(text)
+                        line = self.get_doc_indented(doc)
+                    no_more_args = True
+                elif match := self._match_at_name_colon(line):
+                    # description
+                    if no_more_args:
+                        raise QAPIParseError(
+                            self,
+                            "description of '@%s:' follows a section"
+                            % match.group(1))
+                    while (line is not None
+                           and (match := self._match_at_name_colon(line))):
+                        doc.new_argument(match.group(1))
+                        text = line[match.end():]
+                        if text:
+                            doc.append_line(text)
+                        line = self.get_doc_indented(doc)
+                    no_more_args = True
+                elif match := re.match(
+                        r'(Returns|Since|Notes?|Examples?|TODO): *',
+                        line):
+                    # tagged section
+                    doc.new_tagged_section(match.group(1))
+                    text = line[match.end():]
+                    if text:
+                        doc.append_line(text)
+                    line = self.get_doc_indented(doc)
+                    no_more_args = True
+                elif line.startswith('='):
                     raise QAPIParseError(
                         self,
                         "unexpected '=' markup in definition documentation")
-                if cur_doc.body.text:
+                else:
+                    # tag-less paragraph
+                    doc.ensure_untagged_section()
+                    doc.append_line(line)
+                    line = self.get_doc_paragraph(doc)
+        else:
+            # Free-form documentation
+            doc = QAPIDoc(self, info)
+            doc.ensure_untagged_section()
+            first = True
+            while line is not None:
+                if match := self._match_at_name_colon(line):
                     raise QAPIParseError(
                         self,
-                        "'=' heading must come first in a comment block")
-            cur_doc.append(self.val)
-            self.accept(False)
+                        "'@%s:' not allowed in free-form documentation"
+                        % match.group(1))
+                if line.startswith('='):
+                    if not first:
+                        raise QAPIParseError(
+                            self,
+                            "'=' heading must come first in a comment block")
+                doc.append_line(line)
+                self.accept(False)
+                line = self.get_doc_line()
+                first = False
 
-        raise QAPIParseError(self, "documentation comment must end with '##'")
+        self.accept(False)
+        doc.end()
+        return doc
 
 
 class QAPIDoc:
@@ -469,7 +601,6 @@ class QAPIDoc:
     """
 
     class Section:
-        # pylint: disable=too-few-public-methods
         def __init__(self, parser: QAPISchemaParser,
                      tag: Optional[str] = None):
             # section source info, i.e. where it begins
@@ -480,29 +611,8 @@ def __init__(self, parser: QAPISchemaParser,
             self.tag = tag
             # section text without tag
             self.text = ''
-            # indentation to strip (None means indeterminate)
-            self._indent = None if self.tag else 0
-
-        def append(self, line: str) -> None:
-            line = line.rstrip()
-
-            if line:
-                indent = must_match(r'\s*', line).end()
-                if self._indent is None:
-                    # indeterminate indentation
-                    if self.text != '':
-                        # non-blank, non-first line determines indentation
-                        if indent == 0:
-                            raise QAPIParseError(
-                                self._parser, "line needs to be indented")
-                        self._indent = indent
-                elif indent < self._indent:
-                    raise QAPIParseError(
-                        self._parser,
-                        "unexpected de-indent (expected at least %d spaces)" %
-                        self._indent)
-                line = line[self._indent:]
 
+        def append_line(self, line: str) -> None:
             self.text += line + '\n'
 
     class ArgSection(Section):
@@ -514,243 +624,75 @@ def __init__(self, parser: QAPISchemaParser,
         def connect(self, member: 'QAPISchemaMember') -> None:
             self.member = member
 
-    class NullSection(Section):
-        """
-        Immutable dummy section for use at the end of a doc block.
-        """
-        # pylint: disable=too-few-public-methods
-        def append(self, line: str) -> None:
-            assert False, "Text appended after end_comment() called."
-
-    def __init__(self, parser: QAPISchemaParser, info: QAPISourceInfo):
+    def __init__(self, parser: QAPISchemaParser, info: QAPISourceInfo,
+                 symbol: Optional[str] = None):
         # self._parser is used to report errors with QAPIParseError.  The
         # resulting error position depends on the state of the parser.
         # It happens to be the beginning of the comment.  More or less
         # servicable, but action at a distance.
         self._parser = parser
+        # info points to the doc comment block's first line
         self.info = info
-        self.symbol: Optional[str] = None
-        self.body = QAPIDoc.Section(parser)
-        # dicts mapping parameter/feature names to their ArgSection
-        self.args: Dict[str, QAPIDoc.ArgSection] = OrderedDict()
-        self.features: Dict[str, QAPIDoc.ArgSection] = OrderedDict()
+        # definition doc's symbol, None for free-form doc
+        self.symbol: Optional[str] = symbol
+        # the sections in textual order
+        self.all_sections: List[QAPIDoc.Section] = [QAPIDoc.Section(parser)]
+        # the body section
+        self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
+        # dicts mapping parameter/feature names to their description
+        self.args: Dict[str, QAPIDoc.ArgSection] = {}
+        self.features: Dict[str, QAPIDoc.ArgSection] = {}
+        # sections other than .body, .args, .features
         self.sections: List[QAPIDoc.Section] = []
-        # the current section
-        self._section = self.body
-        self._append_line = self._append_body_line
-        self._first_line_in_paragraph = False
 
-    def has_section(self, tag: str) -> bool:
-        """Return True if we have a section with this tag."""
-        for i in self.sections:
-            if i.tag == tag:
-                return True
-        return False
+    def end(self) -> None:
+        for section in self.all_sections:
+            section.text = section.text.strip('\n')
+            if section.tag is not None and section.text == '':
+                raise QAPISemError(
+                    section.info, "text required after '%s:'" % section.tag)
 
-    def append(self, line: str) -> None:
-        """
-        Parse a comment line and add it to the documentation.
-
-        The way that the line is dealt with depends on which part of
-        the documentation we're parsing right now:
-        * The body section: ._append_line is ._append_body_line
-        * An argument section: ._append_line is ._append_args_line
-        * A features section: ._append_line is ._append_features_line
-        * An additional section: ._append_line is ._append_various_line
-        """
-        line = line[1:]
-        if not line:
-            self._append_freeform(line)
-            self._first_line_in_paragraph = True
+    def ensure_untagged_section(self) -> None:
+        if self.all_sections and not self.all_sections[-1].tag:
+            # extend current section
+            self.all_sections[-1].text += '\n'
             return
+        # start new section
+        section = self.Section(self._parser)
+        self.sections.append(section)
+        self.all_sections.append(section)
 
-        if line[0] != ' ':
-            raise QAPIParseError(self._parser, "missing space after #")
-        line = line[1:]
-        self._append_line(line)
-        self._first_line_in_paragraph = False
+    def new_tagged_section(self, tag: str) -> None:
+        if tag in ('Returns', 'Since'):
+            for section in self.all_sections:
+                if isinstance(section, self.ArgSection):
+                    continue
+                if section.tag == tag:
+                    raise QAPIParseError(
+                        self._parser, "duplicated '%s' section" % tag)
+        section = self.Section(self._parser, tag)
+        self.sections.append(section)
+        self.all_sections.append(section)
 
-    def end_comment(self) -> None:
-        self._switch_section(QAPIDoc.NullSection(self._parser))
-
-    @staticmethod
-    def _match_at_name_colon(string: str) -> Optional[Match[str]]:
-        return re.match(r'@([^:]*): *', string)
-
-    def _match_section_tag(self, string: str) -> Optional[Match[str]]:
-        if not self._first_line_in_paragraph:
-            return None
-        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *',
-                        string)
-
-    def _append_body_line(self, line: str) -> None:
-        """
-        Process a line of documentation text in the body section.
-
-        If this a symbol line and it is the section's first line, this
-        is a definition documentation block for that symbol.
-
-        If it's a definition documentation block, another symbol line
-        begins the argument section for the argument named by it, and
-        a section tag begins an additional section.  Start that
-        section and append the line to it.
-
-        Else, append the line to the current section.
-        """
-        # FIXME not nice: things like '#  @foo:' and '# @foo: ' aren't
-        # recognized, and get silently treated as ordinary text
-        if not self.symbol and not self.body.text and line.startswith('@'):
-            if not line.endswith(':'):
-                raise QAPIParseError(self._parser, "line should end with ':'")
-            self.symbol = line[1:-1]
-            # Invalid names are not checked here, but the name provided MUST
-            # match the following definition, which *is* validated in expr.py.
-            if not self.symbol:
-                raise QAPIParseError(
-                    self._parser, "name required after '@'")
-        elif self.symbol:
-            # This is a definition documentation block
-            if self._match_at_name_colon(line):
-                self._append_line = self._append_args_line
-                self._append_args_line(line)
-            elif line == 'Features:':
-                self._append_line = self._append_features_line
-            elif self._match_section_tag(line):
-                self._append_line = self._append_various_line
-                self._append_various_line(line)
-            else:
-                self._append_freeform(line)
-        else:
-            # This is a free-form documentation block
-            self._append_freeform(line)
-
-    def _append_args_line(self, line: str) -> None:
-        """
-        Process a line of documentation text in an argument section.
-
-        A symbol line begins the next argument section, a section tag
-        section or a non-indented line after a blank line begins an
-        additional section.  Start that section and append the line to
-        it.
-
-        Else, append the line to the current section.
-
-        """
-        match = self._match_at_name_colon(line)
-        if match:
-            line = line[match.end():]
-            self._start_args_section(match.group(1))
-        elif self._match_section_tag(line):
-            self._append_line = self._append_various_line
-            self._append_various_line(line)
-            return
-        elif (self._section.text.endswith('\n\n')
-              and line and not line[0].isspace()):
-            if line == 'Features:':
-                self._append_line = self._append_features_line
-            else:
-                self._start_section()
-                self._append_line = self._append_various_line
-                self._append_various_line(line)
-            return
-
-        self._append_freeform(line)
-
-    def _append_features_line(self, line: str) -> None:
-        match = self._match_at_name_colon(line)
-        if match:
-            line = line[match.end():]
-            self._start_features_section(match.group(1))
-        elif self._match_section_tag(line):
-            self._append_line = self._append_various_line
-            self._append_various_line(line)
-            return
-        elif (self._section.text.endswith('\n\n')
-              and line and not line[0].isspace()):
-            self._start_section()
-            self._append_line = self._append_various_line
-            self._append_various_line(line)
-            return
-
-        self._append_freeform(line)
-
-    def _append_various_line(self, line: str) -> None:
-        """
-        Process a line of documentation text in an additional section.
-
-        A symbol line is an error.
-
-        A section tag begins an additional section.  Start that
-        section and append the line to it.
-
-        Else, append the line to the current section.
-        """
-        match = self._match_at_name_colon(line)
-        if match:
-            raise QAPIParseError(self._parser,
-                                 "description of '@%s:' follows a section"
-                                 % match.group(1))
-        match = self._match_section_tag(line)
-        if match:
-            line = line[match.end():]
-            self._start_section(match.group(1))
-
-        self._append_freeform(line)
-
-    def _start_symbol_section(
-            self,
-            symbols_dict: Dict[str, 'QAPIDoc.ArgSection'],
-            name: str) -> None:
-        # FIXME invalid names other than the empty string aren't flagged
+    def _new_description(self, name: str,
+                         desc: Dict[str, ArgSection]) -> None:
         if not name:
             raise QAPIParseError(self._parser, "invalid parameter name")
-        if name in symbols_dict:
+        if name in desc:
             raise QAPIParseError(self._parser,
                                  "'%s' parameter name duplicated" % name)
-        assert not self.sections
-        new_section = QAPIDoc.ArgSection(self._parser, '@' + name)
-        self._switch_section(new_section)
-        symbols_dict[name] = new_section
+        section = self.ArgSection(self._parser, '@' + name)
+        self.all_sections.append(section)
+        desc[name] = section
 
-    def _start_args_section(self, name: str) -> None:
-        self._start_symbol_section(self.args, name)
+    def new_argument(self, name: str) -> None:
+        self._new_description(name, self.args)
 
-    def _start_features_section(self, name: str) -> None:
-        self._start_symbol_section(self.features, name)
+    def new_feature(self, name: str) -> None:
+        self._new_description(name, self.features)
 
-    def _start_section(self, tag: Optional[str] = None) -> None:
-        if not tag and not self._section.tag:
-            # extend current section
-            return
-        if tag in ('Returns', 'Since') and self.has_section(tag):
-            raise QAPIParseError(self._parser,
-                                 "duplicated '%s' section" % tag)
-        new_section = QAPIDoc.Section(self._parser, tag)
-        self._switch_section(new_section)
-        self.sections.append(new_section)
-
-    def _switch_section(self, new_section: 'QAPIDoc.Section') -> None:
-        text = self._section.text = self._section.text.strip('\n')
-
-        # Only the 'body' section is allowed to have an empty body.
-        # All other sections, including anonymous ones, must have text.
-        if self._section != self.body and not text:
-            # We do not create anonymous sections unless there is
-            # something to put in them; this is a parser bug.
-            assert self._section.tag
-            raise QAPISemError(
-                self._section.info,
-                "text required after '%s:'" % self._section.tag)
-
-        self._section = new_section
-
-    def _append_freeform(self, line: str) -> None:
-        match = re.match(r'(@\S+:)', line)
-        if match:
-            raise QAPIParseError(self._parser,
-                                 "'%s' not allowed in free-form documentation"
-                                 % match.group(1))
-        self._section.append(line)
+    def append_line(self, line: str) -> None:
+        self.all_sections[-1].append_line(line)
 
     def connect_member(self, member: 'QAPISchemaMember') -> None:
         if member.name not in self.args:
@@ -758,8 +700,8 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                 raise QAPISemError(member.info,
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
-            self.args[member.name] = QAPIDoc.ArgSection(self._parser,
-                                                        '@' + member.name)
+            self.args[member.name] = QAPIDoc.ArgSection(
+                self._parser, '@' + member.name)
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
-- 
2.43.0


