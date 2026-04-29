Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBCECCFA13
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:26:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAYL-0006LV-In; Wed, 29 Apr 2026 15:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYH-0006JP-Vv
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wIAYG-0007jY-0n
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777490786;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u0MZS1bSbu4EQv/u0Yr8n1ph2IX/3wmcQ+CPEwREwE4=;
 b=gT+n+3mXZ3aBN289ui8TKBLlUpjWgNwOUg8xPgAT5D9IyleTNJYOh4aDU1LBAXV0S0kE+9
 dH5w5m5RjIUOsUISLg2/nj49f3MChElxMExkyCtOueHzYOKyTeC1i9jN3FfF90NEfppsNO
 Nr8BawNEa/6FvNtUSh6n0BzD6zA574U=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-393-s-oFL-bnO269XFOLdvC4lQ-1; Wed,
 29 Apr 2026 15:26:23 -0400
X-MC-Unique: s-oFL-bnO269XFOLdvC4lQ-1
X-Mimecast-MFC-AGG-ID: s-oFL-bnO269XFOLdvC4lQ_1777490782
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D204618003FC; Wed, 29 Apr 2026 19:26:21 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.204])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 31716180045E; Wed, 29 Apr 2026 19:26:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 01/13] tests/qapi: generate output in source order
Date: Wed, 29 Apr 2026 15:25:59 -0400
Message-ID: <20260429192611.1581223-2-jsnow@redhat.com>
In-Reply-To: <20260429192611.1581223-1-jsnow@redhat.com>
References: <20260429192611.1581223-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Rewrite the test doc generator to produce output in source order instead
of arbitrarily by section name.

This patch removes our last use of the "body" field, which has an effect
on how the first plaintext section of each test documented is printed:
we now print "section=Plain" followed by the section text instead of
"body=[...]".

This patch is motivated by a desire to move the QAPIDoc API away from
named fields for specific sections in a bid to force all users to simply
iterate through all_sections in order, instead - and to remove the named
subsections.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qapi-schema/doc-good.out | 26 +++++++++++++-------------
 tests/qapi-schema/test-qapi.py | 15 ++++++++-------
 2 files changed, 21 insertions(+), 20 deletions(-)

diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 04a55072646..e2be6f96bbf 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -54,15 +54,15 @@ event EVT_BOXED Object
     boxed=True
     feature feat3
 doc freeform
-    body=
+    section=Plain
 *******
 Section
 *******
 doc freeform
-    body=
+    section=Plain
 Just text, no heading.
 doc freeform
-    body=
+    section=Plain
 Subsection
 ==========
 
@@ -106,7 +106,7 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
-    body=
+    section=Plain
 
     arg=one
 The _one_ {and only}, description on the same line
@@ -119,13 +119,13 @@ a member feature
     section=Plain
 @two is undocumented
 doc symbol=Base
-    body=
+    section=Plain
 
     arg=base1
  description starts on a new line,
  minimally indented
 doc symbol=Variant1
-    body=
+    section=Plain
 A paragraph
 
 Another paragraph
@@ -138,15 +138,15 @@ a feature
     feature=member-feat
 a member feature
 doc symbol=Variant2
-    body=
+    section=Plain
 
 doc symbol=Object
-    body=
+    section=Plain
 
     feature=union-feat1
 a feature
 doc symbol=Alternate
-    body=
+    section=Plain
 
     arg=i
 description starts on the same line
@@ -157,11 +157,11 @@ description starts on the same line
     feature=alt-feat
 a feature
 doc freeform
-    body=
+    section=Plain
 Another subsection
 ==================
 doc symbol=cmd
-    body=
+    section=Plain
 
     arg=arg1
     description starts on a new line,
@@ -210,7 +210,7 @@ Note::
     section=Since
 2.10
 doc symbol=cmd-boxed
-    body=
+    section=Plain
 If you're bored enough to read this, go see a video of boxed cats
     feature=cmd-feat1
 a feature
@@ -223,7 +223,7 @@ another feature
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
-    body=
+    section=Plain
 
     feature=feat3
 a feature
diff --git a/tests/qapi-schema/test-qapi.py b/tests/qapi-schema/test-qapi.py
index cf7fb8a6df5..27885147b4d 100755
--- a/tests/qapi-schema/test-qapi.py
+++ b/tests/qapi-schema/test-qapi.py
@@ -19,6 +19,7 @@
 from io import StringIO
 
 from qapi.error import QAPIError
+from qapi.parser import QAPIDoc
 from qapi.schema import QAPISchema, QAPISchemaVisitor
 
 
@@ -116,13 +117,13 @@ def test_frontend(fname):
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
+            if section.kind == QAPIDoc.Kind.MEMBER:
+                print('    arg=%s\n%s' % (section.name, section.text))
+            elif section.kind == QAPIDoc.Kind.FEATURE:
+                print('    feature=%s\n%s' % (section.name, section.text))
+            else:
+                print('    section=%s\n%s' % (section.kind, section.text))
 
 
 def open_test_result(dir_name, file_name, update):
-- 
2.54.0


