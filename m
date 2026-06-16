Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85D0CD98EC
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 14:18:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZUbW-0001PQ-Jh; Tue, 16 Jun 2026 10:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbV-0001Ot-KR
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wZUbR-0003xv-US
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 10:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781619440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oXC0iO1Hz+oM+LbvcuaGj5YJhFCFriEh8sarIA2JmO8=;
 b=ghfxVNTqH2gdXnh4FluXpSBXEkZhE6vMglfSLtAQTLLALUyCr05ExigyLQCzg2raRmSTTF
 nWVh4VhNTscKx3h4zb7MXNsr9CMV0IBP7BA92LOhD5qFSNW2hKv7usl1ZOAjv0jOyj72B8
 /dJtU1ICe+nzEhbE+8xRU8S8YLQlEPM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-690-a4u5ehFUM-GmU2NoqeRSwA-1; Tue,
 16 Jun 2026 10:17:19 -0400
X-MC-Unique: a4u5ehFUM-GmU2NoqeRSwA-1
X-Mimecast-MFC-AGG-ID: a4u5ehFUM-GmU2NoqeRSwA_1781619438
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87A5519540DE
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F3D0518005AE
 for <qemu-devel@nongnu.org>; Tue, 16 Jun 2026 14:17:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4A36021E6A05; Tue, 16 Jun 2026 16:17:15 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 03/14] tests/qapi: generate output in source order
Date: Tue, 16 Jun 2026 16:17:04 +0200
Message-ID: <20260616141715.2974467-4-armbru@redhat.com>
In-Reply-To: <20260616141715.2974467-1-armbru@redhat.com>
References: <20260616141715.2974467-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: John Snow <jsnow@redhat.com>

Rewrite the test doc generator to produce output in source order instead
of arbitrarily by section name.

This patch removes our last use of the "body" field, which has an
effect on how the sections of each test documention block are
printed. We now print the name of the section followed by the section
text for all sections except Members and Features, which are printed
as "Member=%s" or "Feature=%s" followed by the section text,
respectively.

This patch is motivated by a desire to move the QAPIDoc API away from
named fields for specific sections in a bid to force all users to simply
iterate through all_sections in order, instead - and to remove the named
subsections.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20260611042332.482979-3-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/qapi-schema/doc-good.out | 82 +++++++++++++++++-----------------
 tests/qapi-schema/test-qapi.py | 14 +++---
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 04a5507264..b9829e2f84 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -54,15 +54,15 @@ event EVT_BOXED Object
     boxed=True
     feature feat3
 doc freeform
-    body=
+    Plain
 *******
 Section
 *******
 doc freeform
-    body=
+    Plain
 Just text, no heading.
 doc freeform
-    body=
+    Plain
 Subsection
 ==========
 
@@ -106,84 +106,84 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
-    body=
+    Plain
 
-    arg=one
+    Member=one
 The _one_ {and only}, description on the same line
-    arg=two
+    Member=two
 
-    feature=enum-feat
+    Feature=enum-feat
 Also _one_ {and only}
-    feature=enum-member-feat
+    Feature=enum-member-feat
 a member feature
-    section=Plain
+    Plain
 @two is undocumented
 doc symbol=Base
-    body=
+    Plain
 
-    arg=base1
+    Member=base1
  description starts on a new line,
  minimally indented
 doc symbol=Variant1
-    body=
+    Plain
 A paragraph
 
 Another paragraph
 
 @var1 is undocumented
-    arg=var1
+    Member=var1
 
-    feature=variant1-feat
+    Feature=variant1-feat
 a feature
-    feature=member-feat
+    Feature=member-feat
 a member feature
 doc symbol=Variant2
-    body=
+    Plain
 
 doc symbol=Object
-    body=
+    Plain
 
-    feature=union-feat1
+    Feature=union-feat1
 a feature
 doc symbol=Alternate
-    body=
+    Plain
 
-    arg=i
+    Member=i
 description starts on the same line
     remainder indented the same
     @b is undocumented
-    arg=b
+    Member=b
 
-    feature=alt-feat
+    Feature=alt-feat
 a feature
 doc freeform
-    body=
+    Plain
 Another subsection
 ==================
 doc symbol=cmd
-    body=
+    Plain
 
-    arg=arg1
+    Member=arg1
     description starts on a new line,
     indented
-    arg=arg2
+    Member=arg2
 description starts on the same line
     remainder indented differently
-    arg=arg3
+    Member=arg3
 
-    feature=cmd-feat1
+    Feature=cmd-feat1
 a feature
-    feature=cmd-feat2
+    Feature=cmd-feat2
 another feature
-    section=Plain
+    Plain
 .. note:: @arg3 is undocumented
-    section=Returns
+    Returns
 @Object
-    section=Errors
+    Errors
 some
-    section=Todo
+    Todo
 frobnicate
-    section=Plain
+    Plain
 .. admonition:: Notes
 
  - Lorem ipsum dolor sit amet
@@ -207,23 +207,23 @@ Examples::
 
 Note::
     Ceci n'est pas une note
-    section=Since
+    Since
 2.10
 doc symbol=cmd-boxed
-    body=
+    Plain
 If you're bored enough to read this, go see a video of boxed cats
-    feature=cmd-feat1
+    Feature=cmd-feat1
 a feature
-    feature=cmd-feat2
+    Feature=cmd-feat2
 another feature
-    section=Plain
+    Plain
 .. qmp-example::
 
    -> "this example"
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
-    body=
+    Plain
 
-    feature=feat3
+    Feature=feat3
 a feature
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index cf7fb8a6df..5beb96e894 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -19,6 +19,7 @@
 from io import StringIO
 
 from qapi.error import QAPIError
+from qapi.parser import QAPIDoc
 from qapi.schema import QAPISchema, QAPISchemaVisitor
 
 
@@ -116,13 +117,12 @@ def test_frontend(fname):
             print('doc symbol=%s' % doc.symbol)
         else:
             print('doc freeform')
-        print('    body=\n%s' % doc.body.text)
-        for arg, section in doc.args.items():
-            print('    arg=%s\n%s' % (arg, section.text))
-        for feat, section in doc.features.items():
-            print('    feature=%s\n%s' % (feat, section.text))
-        for section in doc.sections:
-            print('    section=%s\n%s' % (section.kind, section.text))
+        for section in doc.all_sections:
+            if isinstance(section, QAPIDoc.ArgSection):
+                print('    %s=%s' % (section.kind, section.name))
+            else:
+                print('    %s' % section.kind)
+            print(section.text)
 
 
 def open_test_result(dir_name, file_name, update):
-- 
2.54.0


