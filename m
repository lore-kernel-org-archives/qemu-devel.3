Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FE2C41513
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2024 22:01:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s709w-0005Xg-8v; Tue, 14 May 2024 17:58:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s709s-0005WK-Tg
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1s709p-0008Pj-Tu
 for qemu-devel@nongnu.org; Tue, 14 May 2024 17:58:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715723881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7/DfOPlH5gs0diXQtgz3pXaLIlH4rV8K/i8zUNxA/3Q=;
 b=JxVlKQFZjRCpIKNOBMX2DlrzSNq89Qlb/JYz61raYkmmd9qRbh5gfpI3UtLuFvGOL42s7g
 MxWIV7oRbAW/Oebr13Cow86/+eXmfBPzCp9Xbs4e86OXITofiLka4W5H4qi7z9dmQIxNnD
 9XjbKSzYnbM/c/9h4/oRskL+AVZAU3Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-20-Ot5wjhPmNbaPm-mGJu2axA-1; Tue,
 14 May 2024 17:57:58 -0400
X-MC-Unique: Ot5wjhPmNbaPm-mGJu2axA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 90DC63801EDA;
 Tue, 14 May 2024 21:57:57 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.17.156])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AD6FB3C27;
 Tue, 14 May 2024 21:57:54 +0000 (UTC)
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
Subject: [PATCH 04/20] qapi/parser: preserve indentation in QAPIDoc sections
Date: Tue, 14 May 2024 17:57:23 -0400
Message-ID: <20240514215740.940155-5-jsnow@redhat.com>
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

Prior to this patch, a section like this:

@name: lorem ipsum
   dolor sit amet
     consectetur adipiscing elit

would be parsed as:

"lorem ipsum\ndolor sit amet\n  consectetur adipiscing elit"

We want to preserve the indentation for even the first body line so that
the entire block can be parsed directly as rST. This patch would now
parse that segment as:

"lorem ipsum\n   dolor sit amet\n     consectetur adipiscing elit"

This understandably breaks qapidoc.py; so a new function is added there
to re-dedent the text. Once the new generator is merged, this function
will not be needed any longer and can be dropped.

(I verified this patch changes absolutely nothing by comparing the
md5sums of the QMP ref html pages both before and after the change, so
it's certified inert. QAPI test output has been updated to reflect the
new strategy of preserving indents for rST.)

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py         | 36 +++++++++++++++++++++++++++++-----
 scripts/qapi/parser.py         |  8 ++++++--
 tests/qapi-schema/doc-good.out | 32 +++++++++++++++---------------
 3 files changed, 53 insertions(+), 23 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 1655682d4c7..2e3ffcbafb7 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -26,6 +26,7 @@
 
 import os
 import re
+import textwrap
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
@@ -51,6 +52,28 @@
 __version__ = "1.0"
 
 
+def dedent(text: str) -> str:
+    # Temporary: In service of the new QAPI domain, the QAPI doc parser
+    # now preserves indents in args/members/features text. QAPIDoc does
+    # not handle this well, so undo that change here.
+
+    # QAPIDoc is being rewritten and will be replaced soon,
+    # but this function is here in the interim as transition glue.
+
+    lines = text.splitlines(True)
+    if len(lines) > 1:
+        if re.match(r"\s+", lines[0]):
+            # First line is indented; description started on
+            # the line after the name. dedent the whole block.
+            return textwrap.dedent(text)
+        else:
+            # Descr started on same line. Dedent line 2+.
+            return lines[0] + textwrap.dedent("".join(lines[1:]))
+    else:
+        # Descr was a single line; dedent entire line.
+        return textwrap.dedent(text)
+
+
 # fmt: off
 # Function borrowed from pydash, which is under the MIT license
 def intersperse(iterable, separator):
@@ -169,7 +192,7 @@ def _nodes_for_members(self, doc, what, base=None, branches=None):
             term = self._nodes_for_one_member(section.member)
             # TODO drop fallbacks when undocumented members are outlawed
             if section.text:
-                defn = section.text
+                defn = dedent(section.text)
             else:
                 defn = [nodes.Text('Not documented')]
 
@@ -207,7 +230,7 @@ def _nodes_for_enum_values(self, doc):
                 termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
             # TODO drop fallbacks when undocumented members are outlawed
             if section.text:
-                defn = section.text
+                defn = dedent(section.text)
             else:
                 defn = [nodes.Text('Not documented')]
 
@@ -242,7 +265,7 @@ def _nodes_for_features(self, doc):
         dlnode = nodes.definition_list()
         for section in doc.features.values():
             dlnode += self._make_dlitem(
-                [nodes.literal('', section.member.name)], section.text)
+                [nodes.literal('', section.member.name)], dedent(section.text))
             seen_item = True
 
         if not seen_item:
@@ -265,9 +288,12 @@ def _nodes_for_sections(self, doc):
                 continue
             snode = self._make_section(section.tag)
             if section.tag and section.tag.startswith('Example'):
-                snode += self._nodes_for_example(section.text)
+                snode += self._nodes_for_example(dedent(section.text))
             else:
-                self._parse_text_into_node(section.text, snode)
+                self._parse_text_into_node(
+                    dedent(section.text) if section.tag else section.text,
+                    snode,
+                )
             nodelist.append(snode)
         return nodelist
 
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 7b13a583ac1..8cdd5334ec6 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -448,7 +448,10 @@ def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
         indent = must_match(r'\s*', line).end()
         if not indent:
             return line
-        doc.append_line(line[indent:])
+
+        # Preserve the indent, it's needed for rST formatting.
+        doc.append_line(line)
+
         prev_line_blank = False
         while True:
             self.accept(False)
@@ -465,7 +468,8 @@ def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
                     self,
                     "unexpected de-indent (expected at least %d spaces)" %
                     indent)
-            doc.append_line(line[indent:])
+            # Again, preserve the indent for ReST.
+            doc.append_line(line)
             prev_line_blank = True
 
     def get_doc_paragraph(self, doc: 'QAPIDoc') -> Optional[str]:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 716a9a41026..435f6e6d768 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -117,8 +117,8 @@ doc symbol=Base
     body=
 
     arg=base1
-description starts on a new line,
-minimally indented
+ description starts on a new line,
+ minimally indented
 doc symbol=Variant1
     body=
 A paragraph
@@ -145,8 +145,8 @@ doc symbol=Alternate
 
     arg=i
 description starts on the same line
-remainder indented the same
-@b is undocumented
+    remainder indented the same
+    @b is undocumented
     arg=b
 
     feature=alt-feat
@@ -158,11 +158,11 @@ doc symbol=cmd
     body=
 
     arg=arg1
-description starts on a new line,
-indented
+    description starts on a new line,
+    indented
     arg=arg2
 description starts on the same line
-remainder indented differently
+    remainder indented differently
     arg=arg3
 
     feature=cmd-feat1
@@ -178,16 +178,16 @@ some
     section=TODO
 frobnicate
     section=Notes
-- Lorem ipsum dolor sit amet
-- Ut enim ad minim veniam
+ - Lorem ipsum dolor sit amet
+ - Ut enim ad minim veniam
 
-Duis aute irure dolor
+ Duis aute irure dolor
     section=Example
--> in
-<- out
+ -> in
+ <- out
     section=Examples
-- *verbatim*
-- {braces}
+ - *verbatim*
+ - {braces}
     section=Since
 2.10
 doc symbol=cmd-boxed
@@ -198,9 +198,9 @@ a feature
     feature=cmd-feat2
 another feature
     section=Example
--> in
+ -> in
 
-<- out
+ <- out
 doc symbol=EVT_BOXED
     body=
 
-- 
2.44.0


