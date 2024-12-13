Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27B2BE7717F
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2024 02:21:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLvHm-0000CQ-9O; Thu, 12 Dec 2024 21:20:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHj-0008VU-5z
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:20:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tLvHZ-0007z7-Ia
 for qemu-devel@nongnu.org; Thu, 12 Dec 2024 21:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734056396;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7aPZLMd95e7JjTn9sy+x0lQ0lPYQehAuYgXwUC7zyw4=;
 b=VM53L/xj815z98isdyj1Z5RxvZJBc7KRknYOzoU+Jj/8geuOZ/aM55fPKayz0ViQQkp6Ln
 rzGnEsbHUhyP6pK2/j4mjydAb30lD8ncSo0l3bwV8X3ZRFCCFnp+dwBYI9FLC1413dc7nD
 6SMryE1NUOJpjAlvZ0yrxMyQiDHNiTc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-16-j52UaJ8dP8a172057kvpaA-1; Thu,
 12 Dec 2024 21:19:54 -0500
X-MC-Unique: j52UaJ8dP8a172057kvpaA-1
X-Mimecast-MFC-AGG-ID: j52UaJ8dP8a172057kvpaA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 199D61956086; Fri, 13 Dec 2024 02:19:53 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.88.22])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 3BA58195605A; Fri, 13 Dec 2024 02:19:50 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 20/23] docs/qapidoc: add visit_sections() method
Date: Thu, 12 Dec 2024 21:18:23 -0500
Message-ID: <20241213021827.2956769-21-jsnow@redhat.com>
In-Reply-To: <20241213021827.2956769-1-jsnow@redhat.com>
References: <20241213021827.2956769-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.496,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Implement the actual main dispatch method that processes and handles the
list of doc sections for a given QAPI entity.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index fe01ee71c26..eda6aa0897b 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -278,6 +278,29 @@ def preamble(self, ent: QAPISchemaEntity) -> None:
 
         self.ensure_blank_line()
 
+    def visit_sections(self, ent: QAPISchemaEntity) -> None:
+        sections = ent.doc.all_sections if ent.doc else []
+
+        # Add sections *in the order they are documented*:
+        for section in sections:
+            if section.tag == QAPIDoc.Tag.UNTAGGED:
+                self.visit_paragraph(section)
+            elif section.tag == QAPIDoc.Tag.MEMBER:
+                self.visit_member(section)
+            elif section.tag == QAPIDoc.Tag.FEATURE:
+                self.visit_feature(section)
+            elif section.tag in (QAPIDoc.Tag.SINCE, QAPIDoc.Tag.TODO):
+                # Since is handled in preamble, TODO is skipped intentionally.
+                pass
+            elif section.tag == QAPIDoc.Tag.RETURNS:
+                self.visit_returns(section)
+            elif section.tag == QAPIDoc.Tag.ERRORS:
+                self.visit_errors(section)
+            else:
+                assert False
+
+        self.ensure_blank_line()
+
     # Transmogrification core methods
 
     def visit_module(self, path: str) -> None:
-- 
2.47.0


