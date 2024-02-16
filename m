Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C4D9C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:02:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razg4-0005wq-TY; Fri, 16 Feb 2024 09:59:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfy-0005ox-Ne
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfw-00080b-AX
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095530;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HIK8NVXLFq86OC3EM3YnOVdedAOyiByskqw7B4pBzug=;
 b=N/zfxhrOJl159dqABE4UbDQ5imW2YeFqZRj1ak0hwdHOVD3PEccFtMwH+OAtq1v+Y79M5+
 d5oM/VJahjVk9roxNZqe9JSQgoxcL74ZR83CZ6fnzt3+DpN/DWGkSwbDb07swoHH6t3cTo
 cHF9mHEHeX20zXTXrG+hR3yTBjZXxO4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-607-eZrQl_wEPAmS2TcRj4eo7w-1; Fri,
 16 Feb 2024 09:58:49 -0500
X-MC-Unique: eZrQl_wEPAmS2TcRj4eo7w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62CC01C04339;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 23450AC0C;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A8BC21E657E; Fri, 16 Feb 2024 15:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 05/16] qapi: Improve error position for bogus argument
 descriptions
Date: Fri, 16 Feb 2024 15:58:29 +0100
Message-ID: <20240216145841.2099240-6-armbru@redhat.com>
In-Reply-To: <20240216145841.2099240-1-armbru@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

When documented arguments don't exist, the error message points to the
beginning of the definition comment.  Point to the first bogus
argument description instead.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                          | 4 +++-
 tests/qapi-schema/doc-bad-alternate-member.err  | 2 +-
 tests/qapi-schema/doc-bad-boxed-command-arg.err | 2 +-
 tests/qapi-schema/doc-bad-command-arg.err       | 2 +-
 tests/qapi-schema/doc-bad-enum-member.err       | 2 +-
 tests/qapi-schema/doc-bad-event-arg.err         | 2 +-
 tests/qapi-schema/doc-bad-feature.err           | 2 +-
 tests/qapi-schema/doc-bad-union-member.err      | 2 +-
 8 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 88221b3c64..82db595dcf 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -472,6 +472,8 @@ class Section:
         # pylint: disable=too-few-public-methods
         def __init__(self, parser: QAPISchemaParser,
                      name: Optional[str] = None):
+            # section source info, i.e. where it begins
+            self.info = parser.info
             # parser, for error messages about indentation
             self._parser = parser
             # optional section name (argument/member or section name)
@@ -770,7 +772,7 @@ def check_args_section(
                      if not section.member]
             if bogus:
                 raise QAPISemError(
-                    self.info,
+                    args[bogus[0]].info,
                     "documented %s%s '%s' %s not exist" % (
                         what,
                         "s" if len(bogus) > 1 else "",
diff --git a/tests/qapi-schema/doc-bad-alternate-member.err b/tests/qapi-schema/doc-bad-alternate-member.err
index d7286bb57c..1f6b7d2fe4 100644
--- a/tests/qapi-schema/doc-bad-alternate-member.err
+++ b/tests/qapi-schema/doc-bad-alternate-member.err
@@ -1 +1 @@
-doc-bad-alternate-member.json:3: documented members 'aa', 'bb' do not exist
+doc-bad-alternate-member.json:7: documented members 'aa', 'bb' do not exist
diff --git a/tests/qapi-schema/doc-bad-boxed-command-arg.err b/tests/qapi-schema/doc-bad-boxed-command-arg.err
index 7137af3ec9..d6793e7fd8 100644
--- a/tests/qapi-schema/doc-bad-boxed-command-arg.err
+++ b/tests/qapi-schema/doc-bad-boxed-command-arg.err
@@ -1 +1 @@
-doc-bad-boxed-command-arg.json:9: documented member 'a' does not exist
+doc-bad-boxed-command-arg.json:11: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-command-arg.err b/tests/qapi-schema/doc-bad-command-arg.err
index 18ed076cef..b76167ec60 100644
--- a/tests/qapi-schema/doc-bad-command-arg.err
+++ b/tests/qapi-schema/doc-bad-command-arg.err
@@ -1 +1 @@
-doc-bad-command-arg.json:3: documented member 'b' does not exist
+doc-bad-command-arg.json:6: documented member 'b' does not exist
diff --git a/tests/qapi-schema/doc-bad-enum-member.err b/tests/qapi-schema/doc-bad-enum-member.err
index 7efeb47363..0aa8d8e8e2 100644
--- a/tests/qapi-schema/doc-bad-enum-member.err
+++ b/tests/qapi-schema/doc-bad-enum-member.err
@@ -1 +1 @@
-doc-bad-enum-member.json:3: documented member 'a' does not exist
+doc-bad-enum-member.json:5: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-event-arg.err b/tests/qapi-schema/doc-bad-event-arg.err
index d13cacf21f..90527d5f82 100644
--- a/tests/qapi-schema/doc-bad-event-arg.err
+++ b/tests/qapi-schema/doc-bad-event-arg.err
@@ -1 +1 @@
-doc-bad-event-arg.json:3: documented member 'a' does not exist
+doc-bad-event-arg.json:5: documented member 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-feature.err b/tests/qapi-schema/doc-bad-feature.err
index 49d1746c3d..3166c6a305 100644
--- a/tests/qapi-schema/doc-bad-feature.err
+++ b/tests/qapi-schema/doc-bad-feature.err
@@ -1 +1 @@
-doc-bad-feature.json:3: documented feature 'a' does not exist
+doc-bad-feature.json:7: documented feature 'a' does not exist
diff --git a/tests/qapi-schema/doc-bad-union-member.err b/tests/qapi-schema/doc-bad-union-member.err
index 6dd2726a65..cdf1225cab 100644
--- a/tests/qapi-schema/doc-bad-union-member.err
+++ b/tests/qapi-schema/doc-bad-union-member.err
@@ -1 +1 @@
-doc-bad-union-member.json:3: documented members 'a', 'b' do not exist
+doc-bad-union-member.json:5: documented members 'a', 'b' do not exist
-- 
2.43.0


