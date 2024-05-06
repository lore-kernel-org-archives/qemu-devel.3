Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD231C10F16
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 11:07:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s3w7r-00036s-Lw; Mon, 06 May 2024 07:03:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7f-0002on-Ew
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1s3w7X-0003eh-4Q
 for qemu-devel@nongnu.org; Mon, 06 May 2024 07:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714993378;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HXdJA2BHeqHIiC0EhCGjai0a7ae19Qf0y5BbHTMjxDU=;
 b=c9ZdTfLC/s/pIp3qGBcZW26GAb4pFzaNi9OWASkEmya+CsjxTYB+kSzO6Vwxc91bYJFap7
 baM8/IsODAC01szduQkakYQ8poiJeY412mSkta7uEgtz2M6sxaAfiUTsA0bE9bprwVQqAd
 PB1GJ0xTh69uSBEdH4VVU5kM0t1CiJU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-IQb2DXQAOEWhUQLVOe_OXQ-1; Mon, 06 May 2024 07:02:56 -0400
X-MC-Unique: IQb2DXQAOEWhUQLVOe_OXQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 774AB1049C93;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 58075200B09C;
 Mon,  6 May 2024 11:02:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47A6421E5D28; Mon,  6 May 2024 13:02:54 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 3/7] qapi: make returns sections special WIP
Date: Mon,  6 May 2024 13:02:46 +0200
Message-ID: <20240506110254.3965097-7-armbru@redhat.com>
In-Reply-To: <20240506110254.3965097-1-armbru@redhat.com>
References: <20240506110254.3965097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

returns moves in generated output
---
 docs/sphinx/qapidoc.py         |  8 ++++++++
 scripts/qapi/parser.py         |  4 ++--
 tests/qapi-schema/doc-good.out |  4 ++--
 tests/qapi-schema/doc-good.txt | 12 ++++++------
 tests/qapi-schema/test-qapi.py |  2 ++
 5 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index f19f5ded78..24bf1d9a90 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -250,6 +250,13 @@ def _nodes_for_features(self, doc):
         section += dlnode
         return [section]
 
+    def _nodes_for_returns(self, doc, ret_type):
+        if doc.returns:
+            section = self._make_section('Returns')
+            self._parse_text_into_node(doc.returns.text, section)
+            return [section]
+        return []
+
     def _nodes_for_since(self, doc):
         if doc.since:
             # TODO emphasis
@@ -343,6 +350,7 @@ def visit_command(self, name, info, ifcond, features, arg_type,
         self._add_doc('Command',
                       self._nodes_for_arguments(doc,
                                                 arg_type if boxed else None)
+                      + self._nodes_for_returns(doc, ret_type)
                       + self._nodes_for_features(doc)
                       + self._nodes_for_sections(doc)
                       + self._nodes_for_if_section(ifcond)
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 0237d13da9..e8a482c37d 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -646,7 +646,7 @@ def __init__(self, info: QAPISourceInfo, symbol: Optional[str] = None):
         self.errors: Optional[QAPIDoc.Section] = None
         # "Since" section
         self.since: Optional[QAPIDoc.Section] = None
-        # sections other than .body, .args, .features, .since
+        # sections other than .body, .args, .features, .returns, .since
         self.sections: List[QAPIDoc.Section] = []
 
     def end(self) -> None:
@@ -683,7 +683,7 @@ def new_tagged_section(self, info: QAPISourceInfo, tag: str) -> None:
                 raise QAPISemError(
                     info, "duplicated '%s' section" % tag)
             self.since = section
-        if tag != 'Since':
+        if tag not in ('Returns', 'Since'):
             self.sections.append(section)
         self.all_sections.append(section)
 
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 716a9a4102..f2be711a2c 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -165,14 +165,14 @@ description starts on the same line
 remainder indented differently
     arg=arg3
 
+    section=Returns
+@Object
     feature=cmd-feat1
 a feature
     feature=cmd-feat2
 another feature
     section=Note
 @arg3 is undocumented
-    section=Returns
-@Object
     section=Errors
 some
     section=TODO
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index 56d50d4992..fd88301431 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -184,6 +184,12 @@ Arguments
    Not documented
 
 
+Returns
+~~~~~~~
+
+"Object"
+
+
 Features
 ~~~~~~~~
 
@@ -200,12 +206,6 @@ Note
 "arg3" is undocumented
 
 
-Returns
-~~~~~~~
-
-"Object"
-
-
 Errors
 ~~~~~~
 
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index 642daa29a4..1628efe0f3 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -127,6 +127,8 @@ def test_frontend(fname):
         print('    body=\n%s' % doc.body.text)
         for arg, section in doc.args.items():
             print('    arg=%s\n%s' % (arg, section.text))
+        if doc.returns:
+            print('    section=%s\n%s' % (doc.returns.tag, doc.returns.text))
         for feat, section in doc.features.items():
             print('    feature=%s\n%s' % (feat, section.text))
         for section in doc.sections:
-- 
2.44.0


