Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC4B1C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZI-0002pD-2m; Mon, 26 Feb 2024 05:50:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYi-0002bu-Lj
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYc-0003jf-1f
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fGjWcbnRDrafVL+gPn1YGVCIw7yG/XxNC4mi7ogESDA=;
 b=Kv1+VrgU5pIi39Dzj61TAFjXXso7dXgw1zjgzhdlEk0GMIbpnyUZrHqeQi1i39TbxNypuP
 w+sCBdi5JR6ixV9Usl5yU9XimkrXV3T+GPTFoNYl5/qB09BxOAea9nw3t43Shr0r5PczU3
 EWbDWiCuD3q0XoHyWC/MNUf5130RLsQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-2V1JKz0oPTiXkDofIwR8HQ-1; Mon, 26 Feb 2024 05:49:57 -0500
X-MC-Unique: 2V1JKz0oPTiXkDofIwR8HQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E4F53882086;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C0C1E40C94A8;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A0E2F21E5A41; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 10/17] qapi: Reject section heading in the middle of a doc
 comment
Date: Mon, 26 Feb 2024 11:49:47 +0100
Message-ID: <20240226104954.3781985-11-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

docs/devel/qapi-code-gen.txt claims "A heading line must be the first
line of the documentation comment block" since commit
55ec69f8b16 (docs/devel/qapi-code-gen.txt: Update to new rST backend
conventions).  Not true, we have code to make it work anywhere in a
free-form doc comment: commit dcdc07a97cb (qapi: Make section headings
start a new doc comment block).

Make it true, for simplicity's sake.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-10-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
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


