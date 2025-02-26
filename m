Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFBBC021B8
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 10:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnEev-0004Ge-Lu; Wed, 26 Feb 2025 05:28:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEeu-0004FT-3B
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tnEeq-0003fq-Ks
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 05:28:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740565729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+sEz+qKlhBfhwTwh2XVESCntzWnD9G5DdJ/8arWYldE=;
 b=fsV/cJyNAGZnJ1vFG8Z9R15jo+Ghp4vDwHTAjL4ommM3qJzNm5tRZeq1H9VQ9aLDmJatn/
 ldP35MtHyAUKGPyfrpR1h8LEk9PDOhfPQB4/N/dujibCmixvuRD6u9u2IQxQdB0iuDcD1N
 vAHPufp9YsxU1MF6vH8rvHMFtkZN7yY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-205-jbhY6Ro1Pg6KJKKLzbUT0A-1; Wed,
 26 Feb 2025 05:28:47 -0500
X-MC-Unique: jbhY6Ro1Pg6KJKKLzbUT0A-1
X-Mimecast-MFC-AGG-ID: jbhY6Ro1Pg6KJKKLzbUT0A_1740565726
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85E0818E6952
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.9])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1772B1800946
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 10:28:45 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9B74221E65EA; Wed, 26 Feb 2025 11:28:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 4/6] docs/qapidoc: support header-less freeform sections
Date: Wed, 26 Feb 2025 11:28:40 +0100
Message-ID: <20250226102842.3721046-5-armbru@redhat.com>
In-Reply-To: <20250226102842.3721046-1-armbru@redhat.com>
References: <20250226102842.3721046-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

The code as written crashes when a free-form documentation block doesn't
start with a heading or subheading, for example:

| ##
| # Just text, no heading.
| ##

The code will attempt to use the `node` variable uninitialized. To fix,
create a generic block to insert the doc text into.

(This patch also removes a lingering pylint warning in the QAPIDoc
implementation that prevents getting a clean baseline to use for
forthcoming additions.)

Fixes: 43e0d14ee09a (docs/sphinx: fix extra stuff in TOC after freeform QMP sections)
Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250224033741.222749-5-jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Test updated to cover this]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py          | 2 ++
 tests/qapi-schema/doc-good.json | 4 ++++
 tests/qapi-schema/doc-good.out  | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5f96b46270..5a4d7388b2 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -421,6 +421,8 @@ def freeform(self, doc):
             node = self._start_new_heading(heading, len(leader))
             if text == '':
                 return
+        else:
+            node = nodes.container()
 
         self._parse_text_into_node(text, node)
         self._cur_doc = None
diff --git a/tests/qapi-schema/doc-good.json b/tests/qapi-schema/doc-good.json
index f64bf38d85..0a4f139f83 100644
--- a/tests/qapi-schema/doc-good.json
+++ b/tests/qapi-schema/doc-good.json
@@ -11,6 +11,10 @@
 # = Section
 ##
 
+##
+# Just text, no heading.
+##
+
 ##
 # == Subsection
 #
diff --git a/tests/qapi-schema/doc-good.out b/tests/qapi-schema/doc-good.out
index ec277be91e..0a9da3efde 100644
--- a/tests/qapi-schema/doc-good.out
+++ b/tests/qapi-schema/doc-good.out
@@ -56,6 +56,9 @@ event EVT_BOXED Object
 doc freeform
     body=
 = Section
+doc freeform
+    body=
+Just text, no heading.
 doc freeform
     body=
 == Subsection
-- 
2.48.1


