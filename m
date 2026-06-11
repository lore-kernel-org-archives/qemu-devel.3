Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37444CD98C6
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 04:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXWyW-0007TI-8s; Thu, 11 Jun 2026 00:25:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWyV-0007M4-36
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:25:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wXWyT-0005d0-Fh
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 00:25:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781151900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VwOBoDaGDJlIZ921Yr5vzll8ZG1QrMqqed9kC3sj/2k=;
 b=iNuKASZoXM0tmy3ZTazKK+aEbP0XvkhHvGw6NL1RGA6pbQ+LvKia/iwBxpMarK0sx7/Mqn
 XwPueNsWTueWh6gLnsFZj8l4JDKXfQV15o5ol35xMVUIz0wB0EPsFJMUQ2VC8AuKkzxd8j
 5I01lvuCFrwdw8o5f9+NqatP8lqNJkI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-9M_ZRV-BOqWacLhqf3XTVQ-1; Thu,
 11 Jun 2026 00:24:51 -0400
X-MC-Unique: 9M_ZRV-BOqWacLhqf3XTVQ-1
X-Mimecast-MFC-AGG-ID: 9M_ZRV-BOqWacLhqf3XTVQ_1781151890
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C27BC195FE1B; Thu, 11 Jun 2026 04:24:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.80.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F20361800480; Thu, 11 Jun 2026 04:24:42 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, linux-edac@vger.kernel.org,
 John Snow <jsnow@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: [PATCH v4 13/13] qapi/docs: add "Intro" section parsing
Date: Thu, 11 Jun 2026 00:23:32 -0400
Message-ID: <20260611042332.482979-14-jsnow@redhat.com>
In-Reply-To: <20260611042332.482979-1-jsnow@redhat.com>
References: <20260611042332.482979-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
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

Add parsing for explicit Intro section syntax.

A side effect of this patch is that we will (currently) always create
an empty Intro section, similar to how we used to have an empty Plain
section. The tests are adjusted accordingly, rendered document output
does not change at all.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/devel/qapi-code-gen.rst   | 16 +++++++---------
 scripts/qapi/parser.py         |  4 ++--
 tests/qapi-schema/doc-good.out | 18 ++++++++++++++++++
 3 files changed, 27 insertions(+), 11 deletions(-)

diff --git a/docs/devel/qapi-code-gen.rst b/docs/devel/qapi-code-gen.rst
index 3a632b4a648..b1cc5b5f0db 100644
--- a/docs/devel/qapi-code-gen.rst
+++ b/docs/devel/qapi-code-gen.rst
@@ -984,11 +984,11 @@ definition it documents.
 When documentation is required (see pragma_ 'doc-required'), every
 definition must have documentation.
 
-Definition documentation starts with a line naming the definition,
-followed by an optional overview, a description of each argument (for
-commands and events), member (for structs and unions), branch (for
-alternates), or value (for enums), a description of each feature (if
-any), and finally optional tagged sections.
+Definition documentation starts with a description naming the
+definition with an optional indented overview, a description of each
+argument (for commands and events), member (for structs and unions),
+branch (for alternates), or value (for enums), a description of each
+feature (if any), and finally optional tagged sections.
 
 Descriptions start with '\@name:'.  The description text must be
 indented like this::
@@ -1093,8 +1093,7 @@ Examples of complete definition documentation::
 
  ##
  # @BlockStats:
- #
- # Statistics of a virtual block device or a block backing device.
+ #     Statistics of a virtual block device or a block backing device.
  #
  # @device: If the stats are for a virtual block device, the name
  #     corresponding to the virtual block device.
@@ -1111,8 +1110,7 @@ Examples of complete definition documentation::
 
  ##
  # @query-blockstats:
- #
- # Query the @BlockStats for all virtual block devices.
+ #     Query the @BlockStats for all virtual block devices.
  #
  # @query-nodes: If true, the command will query all the block nodes
  #     ... explain, explain ...
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index b7a7b9465a9..9e14c2f7921 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -542,8 +542,8 @@ def get_doc(self) -> 'QAPIDoc':
             if not symbol:
                 raise QAPIParseError(self, "name required after '@'")
             doc = QAPIDoc(info, symbol)
-            self.accept(False)
-            line = self.get_doc_line()
+            doc.all_sections.append(QAPIDoc.Section(info, QAPIDoc.Kind.INTRO))
+            line = self.get_doc_indented(doc)
             no_more_args = False
 
             while line is not None:
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 16f44221771..371dd25ffc7 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -106,6 +106,8 @@ Examples:
 - *verbatim*
 - {braces}
 doc symbol=Enum
+    Intro
+
     Member=one
 The _one_ {and only}, description on the same line
     Member=two
@@ -117,10 +119,14 @@ a member feature
     Plain
 @two is undocumented
 doc symbol=Base
+    Intro
+
     Member=base1
  description starts on a new line,
  minimally indented
 doc symbol=Variant1
+    Intro
+
     Plain
 A paragraph
 
@@ -134,10 +140,16 @@ a feature
     Feature=member-feat
 a member feature
 doc symbol=Variant2
+    Intro
+
 doc symbol=Object
+    Intro
+
     Feature=union-feat1
 a feature
 doc symbol=Alternate
+    Intro
+
     Member=i
 description starts on the same line
     remainder indented the same
@@ -151,6 +163,8 @@ doc freeform
 Another subsection
 ==================
 doc symbol=cmd
+    Intro
+
     Member=arg1
     description starts on a new line,
     indented
@@ -198,6 +212,8 @@ Note::
     Since
 2.10
 doc symbol=cmd-boxed
+    Intro
+
     Plain
 If you're bored enough to read this, go see a video of boxed cats
     Feature=cmd-feat1
@@ -211,5 +227,7 @@ another feature
 
    <- ... has no title ...
 doc symbol=EVT_BOXED
+    Intro
+
     Feature=feat3
 a feature
-- 
2.54.0


