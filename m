Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BB0AC54E49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:52:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZ5-0002hJ-AK; Mon, 26 Feb 2024 05:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYi-0002bt-Kn
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYb-0003jn-Js
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0OpC8VJdKlXR+vl6ysj+HO/1NUcTsIx8fThTL+bzAhw=;
 b=UuQNgj3DZtyCCVbV/25Ey0SuKD5xHYfcqzzs8o9ALU0TlufJ6gwiPJLO1gy+2c5sNmB6aB
 +DpRyMVhlPP+yt3aScdhS0mB8NDfVULSnzMq8j53ivx5U6raoNDTsKa+CuQ0PSsHg2VkEs
 MgMqaQUZZsFdly6LjFFViBiK+fxOo0w=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-YdJgNVdaNMiACQDP97Cr_w-1; Mon, 26 Feb 2024 05:49:58 -0500
X-MC-Unique: YdJgNVdaNMiACQDP97Cr_w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 32A6B85CE41;
 Mon, 26 Feb 2024 10:49:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E556C8CE8;
 Mon, 26 Feb 2024 10:49:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B557721E5A0D; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 16/17] qapi: Reject multiple and empty feature descriptions
Date: Mon, 26 Feb 2024 11:49:53 +0100
Message-ID: <20240226104954.3781985-17-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
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

The parser recognizes only the first "Features:" line.  Any subsequent
ones are treated as ordinary text, as visible in test case
doc-duplicate-features.  Recognize "Features:" lines anywhere.  A
second one is an error.

A 'Features:' line without any features is useless, but not an error.
Make it an error.  This makes detecting a second "Features:" line
easier.

qapi/run-state.json actually has an instance of this since commit
fe17522d854 (qapi: Remove deprecated 'singlestep' member of
StatusInfo).  Clean it up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-16-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 qapi/run-state.json                          |  2 --
 scripts/qapi/parser.py                       |  8 ++++++-
 tests/qapi-schema/doc-duplicate-features.err |  1 +
 tests/qapi-schema/doc-duplicate-features.out | 22 --------------------
 tests/qapi-schema/doc-empty-features.err     |  1 +
 tests/qapi-schema/doc-empty-features.out     | 17 ---------------
 6 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index d19d23a0fd..dd0770b379 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -108,8 +108,6 @@
 #
 # @status: the virtual machine @RunState
 #
-# Features:
-#
 # Since: 0.14
 #
 ##
diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index 73ff150430..3d8c62b412 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -507,7 +507,10 @@ def get_doc(self) -> 'QAPIDoc':
                 if line is None:
                     break
                 # Non-blank line, first of a section
-                if line == 'Features:' and not doc.features:
+                if line == 'Features:':
+                    if doc.features:
+                        raise QAPIParseError(
+                            self, "duplicated 'Features:' line")
                     self.accept(False)
                     line = self.get_doc_line()
                     while line == '':
@@ -520,6 +523,9 @@ def get_doc(self) -> 'QAPIDoc':
                         if text:
                             doc.append_line(text)
                         line = self.get_doc_indented(doc)
+                    if not doc.features:
+                        raise QAPIParseError(
+                            self, 'feature descriptions expected')
                     no_more_args = True
                 elif match := self._match_at_name_colon(line):
                     # description
diff --git a/tests/qapi-schema/doc-duplicate-features.err b/tests/qapi-schema/doc-duplicate-features.err
index e69de29bb2..cadb2957a6 100644
--- a/tests/qapi-schema/doc-duplicate-features.err
+++ b/tests/qapi-schema/doc-duplicate-features.err
@@ -0,0 +1 @@
+doc-duplicate-features.json:9:1: duplicated 'Features:' line
diff --git a/tests/qapi-schema/doc-duplicate-features.out b/tests/qapi-schema/doc-duplicate-features.out
index 43bfe1034b..e69de29bb2 100644
--- a/tests/qapi-schema/doc-duplicate-features.out
+++ b/tests/qapi-schema/doc-duplicate-features.out
@@ -1,22 +0,0 @@
-module ./builtin
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module doc-duplicate-features.json
-command foo None -> None
-    gen=True success_response=True boxed=False oob=False preconfig=False
-    feature feat
-doc symbol=foo
-    body=
-
-    feature=feat
-mumble
-    section=None
-Features:
diff --git a/tests/qapi-schema/doc-empty-features.err b/tests/qapi-schema/doc-empty-features.err
index e69de29bb2..2709a18d8f 100644
--- a/tests/qapi-schema/doc-empty-features.err
+++ b/tests/qapi-schema/doc-empty-features.err
@@ -0,0 +1 @@
+doc-empty-features.json:8:1: feature descriptions expected
diff --git a/tests/qapi-schema/doc-empty-features.out b/tests/qapi-schema/doc-empty-features.out
index 473f59552d..e69de29bb2 100644
--- a/tests/qapi-schema/doc-empty-features.out
+++ b/tests/qapi-schema/doc-empty-features.out
@@ -1,17 +0,0 @@
-module ./builtin
-object q_empty
-enum QType
-    prefix QTYPE
-    member none
-    member qnull
-    member qnum
-    member qstring
-    member qdict
-    member qlist
-    member qbool
-module doc-empty-features.json
-command foo None -> None
-    gen=True success_response=True boxed=False oob=False preconfig=False
-doc symbol=foo
-    body=
-not a description
-- 
2.43.0


