Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20CE1C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:04:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7i-0002or-IR; Mon, 06 May 2024 07:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7a-0002lI-Po
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7X-0003eK-3Z
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6eEWV2K0C1KrW1v+KAMV4hsT6507/sgqEaxxVW9IdH0=;
 b=RLfFpRMk2jW6PZ1IrLtPAzxNAYm7npAzqw0ygIScUFVxTDVhjMz04Ht4WXk/jpH/SGT0Ac
 DOSOxK7AGKrE00ZeWeKc6Tjgykx4HRVawoyEo7qxYZsik9up2UWfMGR1rZu095tCAs6d7X
 v4gAW5rvj1pd3BMsCYm/dbuO9ZGmQbM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-80-zn8WYcdUMkKNhvanyTCQ3Q-1; Mon, 06 May 2024 07:02:55 -0400
X-MC-Unique: zn8WYcdUMkKNhvanyTCQ3Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7992180021A;
 Mon,  6 May 2024 11:02:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2728D1C060D0;
 Mon,  6 May 2024 11:02:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C22C21E65ED; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 1/7] qapi: make since sections special WIP
Date: Mon,  6 May 2024 13:02:42 +0200
Message-ID: <20240506110254.3965097-3-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
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

since moves to end in generated output
---
 docs/sphinx/qapidoc.py         | 22 +++++++++++++++++-----
 scripts/qapi/parser.py         |  5 +++--
 tests/qapi-schema/test-qapi.py |  2 ++
 3 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8d428c64b0..ac81003f0e 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -250,6 +250,13 @@ def _nodes_for_features(self, doc):
         section += dlnode
         return [section]
 
+    def _nodes_for_since(self, doc):
+        if doc.since:
+            section = self._make_section('Since')
+            self._parse_text_into_node(doc.since.text, section)
+            return [section]
+        return []
+
     def _nodes_for_example(self, exampletext):
         """Return list of doctree nodes for a code example snippet"""
         return [nodes.literal_block(exampletext, exampletext)]
@@ -305,7 +312,8 @@ def visit_enum_type(self, name, info, ifcond, features, members, prefix):
                       self._nodes_for_enum_values(doc)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
+                      + self._nodes_for_if_section(ifcond)
+                      + self._nodes_for_since(doc))
 
     def visit_object_type(self, name, info, ifcond, features,
                           base, members, variants):
@@ -316,7 +324,8 @@ def visit_object_type(self, name, info, ifcond, features,
                       self._nodes_for_members(doc, 'Members', base, variants)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
+                      + self._nodes_for_if_section(ifcond)
+                      + self._nodes_for_since(doc))
 
     def visit_alternate_type(self, name, info, ifcond, features, variants):
         doc = self._cur_doc
@@ -324,7 +333,8 @@ def visit_alternate_type(self, name, info, ifcond, features, variants):
                       self._nodes_for_members(doc, 'Members')
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
+                      + self._nodes_for_if_section(ifcond)
+                      + self._nodes_for_since(doc))
 
     def visit_command(self, name, info, ifcond, features, arg_type,
                       ret_type, gen, success_response, boxed, allow_oob,
@@ -335,7 +345,8 @@ def visit_command(self, name, info, ifcond, features, arg_type,
                                                 arg_type if boxed else None)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
+                      + self._nodes_for_if_section(ifcond)
+                      + self._nodes_for_since(doc))
 
     def visit_event(self, name, info, ifcond, features, arg_type, boxed):
         doc = self._cur_doc
@@ -344,7 +355,8 @@ def visit_event(self, name, info, ifcond, features, arg_type, boxed):
                                                 arg_type if boxed else None)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
-                      + self._nodes_for_if_section(ifcond))
+                      + self._nodes_for_if_section(ifcond)
+                      + self._nodes_for_since(doc))
 
     def symbol(self, doc, entity):
         """Add documentation for one symbol to the document tree
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 7b13a583ac..0237d13da9 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -646,7 +646,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         self.errors: Optional[QAPIDoc.Section] = None
         # "Since" section
         self.since: Optional[QAPIDoc.Section] = None
-        # sections other than .body, .args, .features
+        # sections other than .body, .args, .features, .since
         self.sections: List[QAPIDoc.Section] = []
 
     def end(self) -> None:
@@ -683,7 +683,8 @@ def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % tag)
             self.since = section
-        self.sections.append(section)
+        if tag != 'Since':
+            self.sections.append(section)
         self.all_sections.append(section)
 
     def _new_description(self, info: QAPISourceInfo, name: str,
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 40095431ae..642daa29a4 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -131,6 +131,8 @@ def test_frontend(fname):
             print('    feature=%s\n%s' % (feat, section.text))
         for section in doc.sections:
             print('    section=%s\n%s' % (section.tag, section.text))
+        if doc.since:
+            print('    section=%s\n%s' % (doc.since.tag, doc.since.text))
 
 
 def open_test_result(dir_name, file_name, update):
-- 
2.44.0


