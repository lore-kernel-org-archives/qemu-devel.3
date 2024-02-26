Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF06C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZE-0002lf-Sz; Mon, 26 Feb 2024 05:50:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYh-0002bi-4P
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYa-0003jR-JR
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3GWUHtjiTVTcyXYDkXaYPS+RGx2VTtD2GOtHpGZPuXw=;
 b=UrFscSb8Cpshshmol92OYeGl0AoFmM6gkZBDATl+7cbms9Mhk60vANXuONPLgrPjFbt6dn
 QL+0tKQ9MZKnIn0w4Rfh4MFsRLRsI1i1hqEVNKBZHZcRYaDTtOllQGdoeKdmRfOLSjJSZX
 D4ECxFSZsFjUkXEwnDVwrolhe2CBHw4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-398-5EscpoW4Owy1Kn189Ql_uw-1; Mon,
 26 Feb 2024 05:49:56 -0500
X-MC-Unique: 5EscpoW4Owy1Kn189Ql_uw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A957C3C00085;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FD491C06714;
 Mon, 26 Feb 2024 10:49:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 89B8121E6682; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 02/17] tests/qapi-schema: Fix test 'QAPI rST doc'
Date: Mon, 26 Feb 2024 11:49:39 +0100
Message-ID: <20240226104954.3781985-3-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The test compares Sphinx plain-text output against a golden reference.
To work on Windows hosts, it filters out carriage returns in both
files.  Unfortunately, the filter doesn't work: it creates an empty
file.  Comparing empty files always succeeds.

Fix the filter, and update the golden reference to current Sphinx
output.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-2-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qapi-schema/doc-good.txt | 21 +++++++++------------
 tests/qapi-schema/meson.build  | 10 ++++++----
 2 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/tests/qapi-schema/doc-good.txt b/tests/qapi-schema/doc-good.txt
index b3b76bd43f..879f6ff50a 100644
--- a/tests/qapi-schema/doc-good.txt
+++ b/tests/qapi-schema/doc-good.txt
@@ -44,7 +44,7 @@ Values
 ~~~~~~
 
 "one" (**If: **"IFONE")
-   The _one_ {and only}
+   The _one_ {and only}, description on the same line
 
 "two"
    Not documented
@@ -76,7 +76,7 @@ Members
 ~~~~~~~
 
 "base1": "Enum"
-   the first member
+   description starts on a new line, minimally indented
 
 
 If
@@ -90,7 +90,9 @@ If
 
 A paragraph
 
-Another paragraph (but no "var": line)
+Another paragraph
+
+"var1" is undocumented
 
 
 Members
@@ -141,7 +143,8 @@ Members
 ~~~~~~~
 
 "i": "int"
-   an integer "b" is undocumented
+   description starts on the same line remainder indented the same "b"
+   is undocumented
 
 "b": "boolean"
    Not documented
@@ -172,10 +175,10 @@ Arguments
 ~~~~~~~~~
 
 "arg1": "int"
-   the first argument
+   description starts on a new line, indented
 
 "arg2": "string" (optional)
-   the second argument
+   description starts on the same line remainder indented differently
 
 "arg3": "boolean"
    Not documented
@@ -203,12 +206,6 @@ Returns
 "Object"
 
 
-TODO
-~~~~
-
-frobnicate
-
-
 Notes
 ~~~~~
 
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index af085f745d..44a9385563 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -273,15 +273,17 @@ if build_docs
                                     output: ['doc-good.txt.nocr'],
                                     input: qapi_doc_out[0],
                                     build_by_default: true,
-                                    command: [remove_cr, '@INPUT@'],
-                                    capture: true)
+                                    command: [remove_cr],
+                                    capture: true,
+                                    feed: true)
 
   qapi_doc_ref_nocr = custom_target('QAPI rST doc reference newline-sanitized',
                                     output: ['doc-good.ref.nocr'],
                                     input: files('doc-good.txt'),
                                     build_by_default: true,
-                                    command: [remove_cr, '@INPUT@'],
-                                    capture: true)
+                                    command: [remove_cr],
+                                    capture: true,
+                                    feed: true)
 
   test('QAPI rST doc', diff, args: ['-u', qapi_doc_ref_nocr[0], qapi_doc_out_nocr[0]],
        suite: ['qapi-schema', 'qapi-doc'])
-- 
2.43.0


