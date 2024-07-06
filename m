Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30EEAC2BD09
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jul 2024 07:27:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPzmo-00072j-Jr; Sat, 06 Jul 2024 03:24:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmk-0006zG-6Q
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sPzmU-0004Z2-AN
 for qemu-devel@nongnu.org; Sat, 06 Jul 2024 03:24:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720250664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3+6/kX/LDqotJtx2AFNwS8iiHAoO1D3Wb76nmU7XcM0=;
 b=SH2TcMFLsbsRtAg7aVzTOB9ecS92cbGqmcSC35xBZd4CoNP9TveCI7T4bKrmF2JkcRVkmo
 s3G21ru3c5XX6RFGSIlO6B9S6MfoV/A2QMAbUgXY3PLWBCiZv4LxPMpkjiVbioggYXVRZQ
 wA151GJnLqCfglF50OU4CejQ2cynjx8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-13-DuA4tTw6NPC-xWxY7_GDkA-1; Sat,
 06 Jul 2024 03:24:23 -0400
X-MC-Unique: DuA4tTw6NPC-xWxY7_GDkA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3AB8D195608A; Sat,  6 Jul 2024 07:24:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3ABE1955E70; Sat,  6 Jul 2024 07:24:21 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A919521F4B99; Sat,  6 Jul 2024 09:24:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 12/13] qapi/parser: don't parse rST markup as section headers
Date: Sat,  6 Jul 2024 09:24:15 +0200
Message-ID: <20240706072416.1717485-13-armbru@redhat.com>
In-Reply-To: <20240706072416.1717485-1-armbru@redhat.com>
References: <20240706072416.1717485-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: John Snow <jsnow@redhat.com>

The double-colon synax is rST formatting that precedes a literal code
block. We do not want to capture these as QAPI-specific sections.

Coerce blocks that start with e.g. "Example::" to be parsed as untagged
paragraphs instead of special tagged sections.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20240626222128.406106-14-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Indentation tweaked for consistency]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py          | 9 +++++++--
 tests/qapi-schema/doc-good.json | 3 +++
 tests/qapi-schema/doc-good.out  | 3 +++
 tests/qapi-schema/doc-good.txt  | 3 +++
 4 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 0a13f0f541..6ad5663e54 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -544,10 +544,15 @@ def get_doc(self) -> 'QAPIDoc':
                         line = self.get_doc_indented(doc)
                     no_more_args = True
                 elif match := re.match(
-                        r'(Returns|Errors|Since|Notes?|Examples?|TODO): *',
-                        line):
+                        r'(Returns|Errors|Since|Notes?|Examples?|TODO)'
+                        r'(?!::): *',
+                        line,
+                ):
                     # tagged section
 
+                    # Note: "sections" with two colons are left alone as
+                    # rST markup and not interpreted as a section heading.
+
                     # TODO: Remove this error sometime in 2025 or so
                     # after we've fully transitioned to the new qapidoc
                     # generator.
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 32ff910b4f..b565895858 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -181,6 +181,9 @@
 #  - *verbatim*
 #  - {braces}
 #
+# Note::
+#     Ceci n'est pas une note
+#
 # Since: 2.10
 ##
 { 'command': 'cmd',
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index 631dc9f8da..a8e9456f60 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -190,6 +190,9 @@ frobnicate
     section=Examples
  - *verbatim*
  - {braces}
+    section=None
+Note::
+    Ceci n'est pas une note
     section=Since
 2.10
 doc symbol=cmd-boxed
diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index d8bfa742c2..30d457e548 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -231,6 +231,9 @@ Examples
    - *verbatim*
    - {braces}
 
+Note::
+   Ceci n'est pas une note
+
 
 Since
 ~~~~~
-- 
2.45.0


