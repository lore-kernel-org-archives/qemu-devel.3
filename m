Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 524AFC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 22:27:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMb2E-0005PV-EV; Wed, 26 Jun 2024 18:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb2C-0005Oy-Q5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1sMb2B-0002HT-0E
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 18:22:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719440553;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n5p7l/8qH5RC/KJ9DC6qPOIpLraTEAkYrzDGrZv2Ki8=;
 b=eyI+FlTTOx7Cgfv6A66LWam0Lf9MKQfCc8A2aaVHQMgKiRT8iSj7yOM7MIjW20bdke6D/N
 PFM7jy48+BFFLQZIzkW4UTDLo4ZIVHD5G0ZL6YjjVDbaV8wsqzlIpA7kSnhMrtdecbdjMd
 1z4O3Gv/Xv3WeKrdmkOoC+5axjKn6UU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-YIjRjaZaNn6zQotlSqVnjQ-1; Wed,
 26 Jun 2024 18:22:30 -0400
X-MC-Unique: YIjRjaZaNn6zQotlSqVnjQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95F76195608A; Wed, 26 Jun 2024 22:22:22 +0000 (UTC)
Received: from scv.redhat.com (unknown [10.22.8.67])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7B4E91955F2D; Wed, 26 Jun 2024 22:22:15 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Jiri Pirko <jiri@resnulli.us>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eric Blake <eblake@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Victor Toso de Carvalho <victortoso@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Ani Sinha <anisinha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Peter Xu <peterx@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Lukas Straub <lukasstraub2@web.de>, Igor Mammedov <imammedo@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Hanna Reitz <hreitz@redhat.com>, Konstantin Kostiuk <kkostiuk@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 05/21] qapi/parser: preserve indentation in QAPIDoc sections
Date: Wed, 26 Jun 2024 18:21:11 -0400
Message-ID: <20240626222128.406106-6-jsnow@redhat.com>
In-Reply-To: <20240626222128.406106-1-jsnow@redhat.com>
References: <20240626222128.406106-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Change get_doc_indented() to preserve indentation on all subsequent text
lines, and create a compatibility dedent() function for qapidoc.py that
removes indentation the same way get_doc_indented() did.

This is being done for the benefit of a new qapidoc generator which
requires that indentation in argument and features sections are
preserved.

Prior to this patch, a section like this:

```
@name: lorem ipsum
   dolor sit amet
     consectetur adipiscing elit
```

would have its body text be parsed into:

```
lorem ipsum
dolor sit amet
  consectetur adipiscing elit
```

We want to preserve the indentation for even the first body line so that
the entire block can be parsed directly as rST. This patch would now
parse that segment into:

```
lorem ipsum
   dolor sit amet
     consectetur adipiscing elit
```

This is helpful for formatting arguments and features as field lists in
rST, where the new generator will format this information as:

```
:arg type name: lorem ipsum
   dolor sit amet
     consectetur apidiscing elit
```

...and can be formed by the simple concatenation of the field list
construct and the body text. The indents help preserve the continuation
of a block-level element, and further allow the use of additional rST
block-level constructs such as code blocks, lists, and other such
markup.

This understandably breaks the existing qapidoc.py; so a new function is
added there to dedent the text for compatibility. Once the new generator
is merged, this function will not be needed any longer and can be
dropped.

Signed-off-by: John Snow <jsnow@redhat.com>
[Edited commit message and code comments per review --js]
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py         | 27 ++++++++++++++++++++++-----
 scripts/qapi/parser.py         |  4 ++--
 tests/qapi-schema/doc-good.out | 32 ++++++++++++++++----------------
 3 files changed, 40 insertions(+), 23 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 659e507353a..f9683444b14 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -26,6 +26,7 @@
 
 import os
 import re
+import textwrap
 
 from docutils import nodes
 from docutils.parsers.rst import Directive, directives
@@ -53,6 +54,19 @@
 __version__ = "1.0"
 
 
+def dedent(text: str) -> str:
+    # Adjust indentation to make description text parse as paragraph.
+
+    lines = text.splitlines(True)
+    if re.match(r"\s+", lines[0]):
+        # First line is indented; description started on the line after
+        # the name. dedent the whole block.
+        return textwrap.dedent(text)
+
+    # Descr started on same line. Dedent line 2+.
+    return lines[0] + textwrap.dedent("".join(lines[1:]))
+
+
 # Disable black auto-formatter until re-enabled:
 # fmt: off
 
@@ -164,7 +178,7 @@ def _nodes_for_members(self, doc, what, base=None, branches=None):
             term = self._nodes_for_one_member(section.member)
             # TODO drop fallbacks when undocumented members are outlawed
             if section.text:
-                defn = section.text
+                defn = dedent(section.text)
             else:
                 defn = [nodes.Text('Not documented')]
 
@@ -202,7 +216,7 @@ def _nodes_for_enum_values(self, doc):
                 termtext.extend(self._nodes_for_ifcond(section.member.ifcond))
             # TODO drop fallbacks when undocumented members are outlawed
             if section.text:
-                defn = section.text
+                defn = dedent(section.text)
             else:
                 defn = [nodes.Text('Not documented')]
 
@@ -237,7 +251,7 @@ def _nodes_for_features(self, doc):
         dlnode = nodes.definition_list()
         for section in doc.features.values():
             dlnode += self._make_dlitem(
-                [nodes.literal('', section.member.name)], section.text)
+                [nodes.literal('', section.member.name)], dedent(section.text))
             seen_item = True
 
         if not seen_item:
@@ -260,9 +274,12 @@ def _nodes_for_sections(self, doc):
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
index 7b13a583ac1..1ef1f85b028 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -448,7 +448,7 @@ def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
         indent = must_match(r'\s*', line).end()
         if not indent:
             return line
-        doc.append_line(line[indent:])
+        doc.append_line(line)
         prev_line_blank = False
         while True:
             self.accept(False)
@@ -465,7 +465,7 @@ def get_doc_indented(self, doc: 'QAPIDoc') -> Optional[str]:
                     self,
                     "unexpected de-indent (expected at least %d spaces)" %
                     indent)
-            doc.append_line(line[indent:])
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
2.45.0


