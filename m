Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918EAC28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 03:58:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqaQ-0003uD-Nl; Mon, 10 Mar 2025 23:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqZQ-0000Mv-AQ
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:46:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqZL-0002nC-RK
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:46:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9Yjuy0WjRIO7+BSaUIErwrTlRMzRP054sMJSBpBw71I=;
 b=Htdg//61dsHGccX0v2hH13T9D8aWYxkTcjDCCfA8j6UhMk3FgLRxbH7iuHUGz+C+G10ZKT
 DSKT+LtwjwGvl3RTFkesUaz3pjCbXzzRQJFvoYURNad8/ZSVnK3EqVdko/bs7NXuKJ0t3b
 eI8T1deRv4rKKnxoDU+8yuLBcoabIKs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-369-AAYvBpUmMCeIpr6Axh-O4A-1; Mon,
 10 Mar 2025 23:46:10 -0400
X-MC-Unique: AAYvBpUmMCeIpr6Axh-O4A-1
X-Mimecast-MFC-AGG-ID: AAYvBpUmMCeIpr6Axh-O4A_1741664768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 43D171800257; Tue, 11 Mar 2025 03:46:08 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6719A1800373; Tue, 11 Mar 2025 03:46:05 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 52/63] docs/qapidoc: add visit_sections() method
Date: Mon, 10 Mar 2025 23:42:50 -0400
Message-ID: <20250311034303.75779-53-jsnow@redhat.com>
In-Reply-To: <20250311034303.75779-1-jsnow@redhat.com>
References: <20250311034303.75779-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 docs/sphinx/qapidoc.py | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index a8e19487d0a..83022b15ca2 100644
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


