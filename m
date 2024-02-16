Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C392FC48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 15:04:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1razg1-0005tw-Mp; Fri, 16 Feb 2024 09:58:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfy-0005o4-Cj
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1razfw-00080w-7x
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 09:58:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708095531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B0iJ0gaDU/b24vwME4+tomt1j16zpj3IJVim2hsEfBI=;
 b=KnD3QgSmZRRSZoDufn6Sg94F/QLjQVIJE3h1EU0+7IRkR404LFDWBHMbpS11NtqoAiaovG
 Yqc19/oMMh0vWvNX3NeVj6iiJ9rVZCSx+MES1SeUefKB+qX9bSXGQWVyXKeBtOkjfggQ9t
 qyVPEcABDXLbiLpdEnLGW5lkvfLA8R8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-536-Bg5bgOVkNxOukZ4xC2-NDQ-1; Fri, 16 Feb 2024 09:58:49 -0500
X-MC-Unique: Bg5bgOVkNxOukZ4xC2-NDQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8511C848A67;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6299E20229A7;
 Fri, 16 Feb 2024 14:58:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2691921E60F5; Fri, 16 Feb 2024 15:58:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: michael.roth@amd.com, jsnow@redhat.com, eblake@redhat.com,
 peter.maydell@linaro.org
Subject: [PATCH 09/16] qapi: Reject section heading in the middle of a doc
 comment
Date: Fri, 16 Feb 2024 15:58:33 +0100
Message-ID: <20240216145841.2099240-10-armbru@redhat.com>
In-Reply-To: <20240216145841.2099240-1-armbru@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.364,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

docs/devel/qapi-code-gen.txt claims "A heading line must be the first
line of the documentation comment block" since commit
55ec69f8b16 (docs/devel/qapi-code-gen.txt: Update to new rST backend
conventions).  Not true, we have code to make it work anywhere in a
free-form doc comment: commit dcdc07a97cb (qapi: Make section headings
start a new doc comment block).

Make it true, for simplicity's sake.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/parser.py                       | 6 +++---
 tests/qapi-schema/doc-good.json              | 4 +++-
 tests/qapi-schema/doc-non-first-section.err  | 1 +
 tests/qapi-schema/doc-non-first-section.json | 6 ++++++
 tests/qapi-schema/doc-non-first-section.out  | 0
 5 files changed, 13 insertions(+), 4 deletions(-)
 create mode 100644 tests/qapi-schema/doc-non-first-section.err
 create mode 100644 tests/qapi-schema/doc-non-first-section.json
 create mode 100644 tests/qapi-schema/doc-non-first-section.out

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index cc69f4f770..3aefec1c2b 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -440,9 +440,9 @@ def get_doc(self, info: QAPISourceInfo) -> List['QAPIDoc']:
                         self,
                         "unexpected '=' markup in definition documentation")
                 if cur_doc.body.text:
-                    cur_doc.end_comment()
-                    docs.append(cur_doc)
-                    cur_doc = QAPIDoc(self, info)
+                    raise QAPIParseError(
+                        self,
+                        "'=' heading must come first in a comment block")
             cur_doc.append(self.val)
             self.accept(False)
 
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index 24a84fe6d7..0479d16a01 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -9,7 +9,9 @@
 
 ##
 # = Section
-#
+##
+
+##
 # == Subsection
 #
 # *with emphasis*
diff --git a/tests/qapi-schema/doc-non-first-section.err b/tests/qapi-schema/doc-non-first-section.err
new file mode 100644
index 0000000000..eeced2bca7
--- /dev/null
+++ b/tests/qapi-schema/doc-non-first-section.err
@@ -0,0 +1 @@
+doc-non-first-section.json:5:1: '=' heading must come first in a comment block
diff --git a/tests/qapi-schema/doc-non-first-section.json b/tests/qapi-schema/doc-non-first-section.json
new file mode 100644
index 0000000000..1590876061
--- /dev/null
+++ b/tests/qapi-schema/doc-non-first-section.json
@@ -0,0 +1,6 @@
+# = section must be first line
+
+##
+#
+# = Not first
+##
diff --git a/tests/qapi-schema/doc-non-first-section.out b/tests/qapi-schema/doc-non-first-section.out
new file mode 100644
index 0000000000..e69de29bb2
-- 
2.43.0


