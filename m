Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D408C83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKqm-0007Ov-8S; Mon, 14 Jul 2025 11:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUV-0000GH-AQ
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUQ-0003Xu-Dk
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3c4K7n3IfwGoNKL5/wNBn8NnRX7qMr6IpHiyT/o7x2k=;
 b=cBXgOhJxutOK/qGT9MoCpyXKpFqFaOMvZLqEozogL6gKcvAKw/KiDBmNdh0CZfBfhG7RT1
 aowiENHHkETvQsTx16KyVT2xY4vSM04a6aWIBLB1zFuXIWImBH/B723fVPjBO3IKcK+Iry
 a+v4MsMosesTXsxJ/pfJqVnZsysxuU0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-I0GwAMOTPFOJIZZt-yfKIQ-1; Mon,
 14 Jul 2025 09:45:03 -0400
X-MC-Unique: I0GwAMOTPFOJIZZt-yfKIQ-1
X-Mimecast-MFC-AGG-ID: I0GwAMOTPFOJIZZt-yfKIQ_1752500702
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2209119560B2
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A38A11800285
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BE13521E6925; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 02/32] docs/sphinx: parse @references in freeform text
Date: Mon, 14 Jul 2025 15:44:28 +0200
Message-ID: <20250714134458.2991097-3-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Oversight in the new qapidoc transmogrifier: @references in freeform
documentation blocks were not being transformed to literals. This fixes
that, and the next patch ensures that we're testing for this O:-)

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250618165353.1980365-3-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 5374dee8fa..adc14ade45 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -218,6 +218,11 @@ def generate_field(
         typ = self.format_type(member)
         self.add_field(kind, member.name, body, info, typ)
 
+    @staticmethod
+    def reformat_arobase(text: str) -> str:
+        """ reformats @var to ``var`` """
+        return re.sub(r"@([\w-]+)", r"``\1``", text)
+
     # Transmogrification helpers
 
     def visit_paragraph(self, section: QAPIDoc.Section) -> None:
@@ -361,8 +366,7 @@ def visit_sections(self, ent: QAPISchemaDefinition) -> None:
 
         # Add sections in source order:
         for i, section in enumerate(sections):
-            # @var is translated to ``var``:
-            section.text = re.sub(r"@([\w-]+)", r"``\1``", section.text)
+            section.text = self.reformat_arobase(section.text)
 
             if section.kind == QAPIDoc.Kind.PLAIN:
                 self.visit_paragraph(section)
@@ -405,7 +409,7 @@ def visit_freeform(self, doc: QAPIDoc) -> None:
 
         assert len(doc.all_sections) == 1, doc.all_sections
         body = doc.all_sections[0]
-        text = body.text
+        text = self.reformat_arobase(body.text)
         info = doc.info
 
         if re.match(r"=+ ", text):
-- 
2.49.0


