Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9F1C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 11:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trxsQ-0006lL-Fu; Tue, 11 Mar 2025 07:34:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqb-0003FN-8N
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trxqA-0006XD-CW
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 07:32:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741692721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=52E2Meg0uM+hlv5UQ3Tc1MyKxWQex8OaRjQ9GV3pE9g=;
 b=eou1Jb/AhCvKDsRPfFSb0OO7vsX1EqZemZu73JElo+Fr4omF/d5dcGN3hRriFQjW4oNCQ9
 HESGbuSNrHf+84toGsHnkuIBDH+ZiFp4MvKFgkLusuMww7NCwV/9HJHQAnhHQJ8rwPTOym
 F1hDf2qdoBWROhJJkWReGmSm+AueL0M=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-308-V9AvJkUkMZS7FvFcJ16uuw-1; Tue,
 11 Mar 2025 07:31:59 -0400
X-MC-Unique: V9AvJkUkMZS7FvFcJ16uuw-1
X-Mimecast-MFC-AGG-ID: V9AvJkUkMZS7FvFcJ16uuw_1741692718
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7E21C19560B5
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:58 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E13DC30001A2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 11:31:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B51721E6143; Tue, 11 Mar 2025 12:31:38 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 49/61] docs/qapidoc: add visit_sections() method
Date: Tue, 11 Mar 2025 12:31:25 +0100
Message-ID: <20250311113137.1277125-50-armbru@redhat.com>
In-Reply-To: <20250311113137.1277125-1-armbru@redhat.com>
References: <20250311113137.1277125-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

Implement the actual main dispatch method that processes and handles the
list of doc sections for a given QAPI entity.

Process doc sections in strict source order. This is good; reordering
doc text is undesirable. Improvement over the old doc generator, which
can reorder doc comments that don't adhere to (largely unspoken)
conventions.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250311034303.75779-53-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
[Commit message extended]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index a8e19487d0..83022b15ca 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -288,6 +288,31 @@ def preamble(self, ent: QAPISchemaDefinition) -> None:
 
         self.ensure_blank_line()
 
+    def visit_sections(self, ent: QAPISchemaDefinition) -> None:
+        sections = ent.doc.all_sections if ent.doc else []
+
+        # Add sections in source order:
+        for section in sections:
+            if section.kind == QAPIDoc.Kind.PLAIN:
+                self.visit_paragraph(section)
+            elif section.kind == QAPIDoc.Kind.MEMBER:
+                assert isinstance(section, QAPIDoc.ArgSection)
+                self.visit_member(section)
+            elif section.kind == QAPIDoc.Kind.FEATURE:
+                assert isinstance(section, QAPIDoc.ArgSection)
+                self.visit_feature(section)
+            elif section.kind in (QAPIDoc.Kind.SINCE, QAPIDoc.Kind.TODO):
+                # Since is handled in preamble, TODO is skipped intentionally.
+                pass
+            elif section.kind == QAPIDoc.Kind.RETURNS:
+                self.visit_returns(section)
+            elif section.kind == QAPIDoc.Kind.ERRORS:
+                self.visit_errors(section)
+            else:
+                assert False
+
+        self.ensure_blank_line()
+
     # Transmogrification core methods
 
     def visit_module(self, path: str) -> None:
-- 
2.48.1


