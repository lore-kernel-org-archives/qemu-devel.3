Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8633E77184
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:21:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvGt-0006U2-O5; Thu, 12 Dec 2024 21:19:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvGs-0006TN-2N
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvGo-0007to-7Y
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:19:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734056348;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cDobDB3pb0NaBcNiYkLQuhQ3PP4r2qTjMiaHW5gzlYE=;
 b=G+vBigg8mphadayBp082VHCJRDhrxXl2y/YtR90XzqK2XJQnJrlzSLHciu/J2hCL8YXpLQ
 3if+sEv6hreCAXWT4mLhDNmti3PEa80MB6/8uGvuYWdr668cFzja6fM5PcAoJweh6h4mgy
 XjwNbUBvEc//zVpJ9EPiAQP6v7CA8fA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-397-Ip1voa0DPfWjAGNnA0mLQg-1; Thu,
 12 Dec 2024 21:19:05 -0500
X-MC-Unique: Ip1voa0DPfWjAGNnA0mLQg-1
X-Mimecast-MFC-AGG-ID: Ip1voa0DPfWjAGNnA0mLQg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69A871956058; Fri, 13 Dec 2024 02:19:04 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8C00A195605A; Fri, 13 Dec 2024 02:18:59 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 04/23] qapi: expand tags to all doc sections
Date: Thu, 12 Dec 2024 21:18:07 -0500
Message-ID: <20241213021827.2956769-5-jsnow@redhat.com>
In-Reply-To: <20241213021827.2956769-1-jsnow@redhat.com>
References: <20241213021827.2956769-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

This patch adds an explicit section tag to all QAPIDoc
sections. Members/Features are now explicitly tagged as such, with the
name now being stored in a dedicated "name" field (which qapidoc.py was
not actually using anyway.)

WIP: Yeah, the difference between "tagged" and "untagged" sections is
now pretty poorly named, and explicitly giving "untagged" sections an
"UNTAGGED" tag is ... well, worse. but mechanically, this accomplishes
what I need for the series.

Please suggest better naming conventions, keeping in mind that I
currently have plans for a future patch that splits the "UNTAGGED" tag
into "INTRO" and "DETAILS" tags. But, we still need a meta-name for the
category of sections that are "formerly known as untagged" but cannot be
called "freeform" because that name is used for the category of
docblocks that are not attached to an entity (but happens to be
comprised entirely of "formerly known as untagged" sections.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py |  7 ++--
 scripts/qapi/parser.py | 88 ++++++++++++++++++++++++++++++++----------
 2 files changed, 72 insertions(+), 23 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 61997fd21af..6abdcc884f5 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -35,6 +35,7 @@
 from docutils.statemachine import ViewList
 from qapi.error import QAPIError, QAPISemError
 from qapi.gen import QAPISchemaVisitor
+from qapi.parser import QAPIDoc
 from qapi.schema import QAPISchema
 
 from sphinx import addnodes
@@ -258,11 +259,11 @@ def _nodes_for_sections(self, doc):
         """Return list of doctree nodes for additional sections"""
         nodelist = []
         for section in doc.sections:
-            if section.tag and section.tag == 'TODO':
+            if section.tag == QAPIDoc.Tag.TODO:
                 # Hide TODO: sections
                 continue
 
-            if not section.tag:
+            if section.tag == QAPIDoc.Tag.UNTAGGED:
                 # Sphinx cannot handle sectionless titles;
                 # Instead, just append the results to the prior section.
                 container = nodes.container()
@@ -270,7 +271,7 @@ def _nodes_for_sections(self, doc):
                 nodelist += container.children
                 continue
 
-            snode = self._make_section(section.tag)
+            snode = self._make_section(section.tag.name.title())
             self._parse_text_into_node(dedent(section.text), snode)
             nodelist.append(snode)
         return nodelist
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 36cb64a677a..fd841725527 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -15,6 +15,7 @@
 # See the COPYING file in the top-level directory.
 
 from collections import OrderedDict
+import enum
 import os
 import re
 from typing import (
@@ -575,7 +576,10 @@ def get_doc(self) -> 'QAPIDoc':
                         )
                         raise QAPIParseError(self, emsg)
 
-                    doc.new_tagged_section(self.info, match.group(1))
+                    doc.new_tagged_section(
+                        self.info,
+                        QAPIDoc.Tag.from_string(match.group(1))
+                    )
                     text = line[match.end():]
                     if text:
                         doc.append_line(text)
@@ -635,10 +639,30 @@ class QAPIDoc:
     Free-form documentation blocks consist only of a body section.
     """
 
+    class Tag(enum.Enum):
+        UNTAGGED = 0
+        MEMBER = 1
+        FEATURE = 2
+        RETURNS = 3
+        ERRORS = 4
+        SINCE = 5
+        TODO = 6
+
+        @staticmethod
+        def from_string(tag: str) -> 'QAPIDoc.Tag':
+            return QAPIDoc.Tag[tag.upper()]
+
+        def text_required(self) -> bool:
+            # Only "untagged" sections can be empty
+            return self.value not in (0,)
+
     class Section:
         # pylint: disable=too-few-public-methods
-        def __init__(self, info: QAPISourceInfo,
-                     tag: Optional[str] = None):
+        def __init__(
+            self,
+            info: QAPISourceInfo,
+            tag: 'QAPIDoc.Tag',
+        ):
             # section source info, i.e. where it begins
             self.info = info
             # section tag, if any ('Returns', '@name', ...)
@@ -650,8 +674,14 @@ def append_line(self, line: str) -> None:
             self.text += line + '\n'
 
     class ArgSection(Section):
-        def __init__(self, info: QAPISourceInfo, tag: str):
+        def __init__(
+            self,
+            info: QAPISourceInfo,
+            tag: 'QAPIDoc.Tag',
+            name: str
+        ):
             super().__init__(info, tag)
+            self.name = name
             self.member: Optional['QAPISchemaMember'] = None
 
         def connect(self, member: 'QAPISchemaMember') -> None:
@@ -663,7 +693,9 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         # definition doc's symbol, None for free-form doc
         self.symbol: Optional[str] = symbol
         # the sections in textual order
-        self.all_sections: List[QAPIDoc.Section] = [QAPIDoc.Section(info)]
+        self.all_sections: List[QAPIDoc.Section] = [
+            QAPIDoc.Section(info, QAPIDoc.Tag.UNTAGGED)
+        ]
         # the body section
         self.body: Optional[QAPIDoc.Section] = self.all_sections[0]
         # dicts mapping parameter/feature names to their description
@@ -680,12 +712,17 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
     def end(self) -> None:
         for section in self.all_sections:
             section.text = section.text.strip('\n')
-            if section.tag is not None and section.text == '':
+            if section.tag.text_required() and section.text == '':
                 raise QAPISemError(
                     section.info, "text required after '%s:'" % section.tag)
 
-    def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
-        if self.all_sections and not self.all_sections[-1].tag:
+    def ensure_untagged_section(
+        self,
+        info: QAPISourceInfo,
+    ) -> None:
+        tag = QAPIDoc.Tag.UNTAGGED
+
+        if self.all_sections and self.all_sections[-1].tag == tag:
             # extend current section
             section = self.all_sections[-1]
             if not section.text:
@@ -693,24 +730,29 @@ def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
                 section.info = info
             section.text += '\n'
             return
+
         # start new section
-        section = self.Section(info)
+        section = self.Section(info, tag)
         self.sections.append(section)
         self.all_sections.append(section)
 
-    def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
+    def new_tagged_section(
+        self,
+        info: QAPISourceInfo,
+        tag: 'QAPIDoc.Tag',
+    ) -> None:
         section = self.Section(info, tag)
-        if tag == 'Returns':
+        if tag == QAPIDoc.Tag.RETURNS:
             if self.returns:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % tag)
             self.returns = section
-        elif tag == 'Errors':
+        elif tag == QAPIDoc.Tag.ERRORS:
             if self.errors:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % tag)
             self.errors = section
-        elif tag == 'Since':
+        elif tag == QAPIDoc.Tag.SINCE:
             if self.since:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % tag)
@@ -718,21 +760,26 @@ def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
         self.sections.append(section)
         self.all_sections.append(section)
 
-    def _new_description(self, info: QAPISourceInfo, name: str,
-                         desc: Dict[str, ArgSection]) -> None:
+    def _new_description(
+        self,
+        info: QAPISourceInfo,
+        name: str,
+        tag: 'QAPIDoc.Tag',
+        desc: Dict[str, ArgSection]
+    ) -> None:
         if not name:
             raise QAPISemError(info, "invalid parameter name")
         if name in desc:
             raise QAPISemError(info, "'%s' parameter name duplicated" % name)
-        section = self.ArgSection(info, '@' + name)
+        section = self.ArgSection(info, tag, name)
         self.all_sections.append(section)
         desc[name] = section
 
     def new_argument(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, self.args)
+        self._new_description(info, name, QAPIDoc.Tag.MEMBER, self.args)
 
     def new_feature(self, info: QAPISourceInfo, name: str) -> None:
-        self._new_description(info, name, self.features)
+        self._new_description(info, name, QAPIDoc.Tag.FEATURE, self.features)
 
     def append_line(self, line: str) -> None:
         self.all_sections[-1].append_line(line)
@@ -744,8 +791,9 @@ def connect_member(self, member: 'QAPISchemaMember') -> None:
                 raise QAPISemError(member.info,
                                    "%s '%s' lacks documentation"
                                    % (member.role, member.name))
-            self.args[member.name] = QAPIDoc.ArgSection(
-                self.info, '@' + member.name)
+            section = QAPIDoc.ArgSection(
+                self.info, QAPIDoc.Tag.MEMBER, member.name)
+            self.args[member.name] = section
         self.args[member.name].connect(member)
 
     def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
-- 
2.47.0


