Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BC20C48BF6
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:03:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razg6-0005y2-Vm; Fri, 16 Feb 2024 09:59:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razg1-0005tO-9l
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfx-00083D-Tw
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=quNPGzAfYk4xijW3ChKUFh1qR6poXO1qlh5/lMiUjvM=;
 b=TM7u8YZlMuJjafmUz4Ud2JmHsseZKVl2+S+qnB4244BWKaYzsmgAycLFCoI/lGpZIzXjfJ
 EehBdkWWJK2r509pzz5Cx92fk7lvKqTiKcamS2cKNdh948taBZC3SK/qrB1pG+m2E5VYgq
 qB6Dr2b0/TvFZLk/Iw06Ew2FFJUtvCQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-kHQYADYhO6qhNVCwBBPQaw-1; Fri,
 16 Feb 2024 09:58:49 -0500
X-MC-Unique: kHQYADYhO6qhNVCwBBPQaw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A41381C0433B;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6485D2166B4F;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3C36D21E5A5B; Fri, 16 Feb 2024 15:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 15/16] qapi: Reject multiple and empty feature descriptions
Date: Fri, 16 Feb 2024 15:58:39 +0100
Message-ID: <20240216145841.2099240-16-armbru@redhat.com>
In-Reply-To: <20240216145841.2099240-1-armbru@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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


