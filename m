Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE96AC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 15:14:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubKmL-0005bo-4L; Mon, 14 Jul 2025 11:07:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUa-0000IY-SG
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ubJUU-0003bz-Bm
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 09:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752500709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NEiGOxWmyqXwmey8dC4YB5ADtCrAiPmoRQecboXQjgs=;
 b=O/rLcGqa886hjTJVQpk7budCj8iHZPkZcpk6qMfJFiAt8RqOs0g/B078Dyk1RuG3QTyVKJ
 OiNGzxt4be/4h2s65BrwOs+3v7drpctkm26PjbfpsJTZSh/BDmkqqGfksoLcVzORneFFV9
 ITohpJIevhUI0+jgQTY3FjpnAygPcJw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-qTmWg45NPuyvVY3fj7vXMw-1; Mon,
 14 Jul 2025 09:45:02 -0400
X-MC-Unique: qTmWg45NPuyvVY3fj7vXMw-1
X-Mimecast-MFC-AGG-ID: qTmWg45NPuyvVY3fj7vXMw_1752500702
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 272DF1809C83
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB46319560A7
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 13:45:01 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B9BA421E6924; Mon, 14 Jul 2025 15:44:58 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	John Snow <jsnow@redhat.com>
Subject: [PULL 01/32] docs/sphinx: adjust qapidoc to cope with same-line error
 sections
Date: Mon, 14 Jul 2025 15:44:27 +0200
Message-ID: <20250714134458.2991097-2-armbru@redhat.com>
In-Reply-To: <20250714134458.2991097-1-armbru@redhat.com>
References: <20250714134458.2991097-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Without this, the line the new QAPI doc generator chokes on

    # Errors: some

in doc-good.json.  We still use the old doc generator for the tests,
but we're about to correct that.

Signed-off-by: John Snow <jsnow@redhat.com>
Message-ID: <20250618165353.1980365-2-jsnow@redhat.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Fixes: e9fbf1a0c6c2 (docs/qapidoc: add visit_errors() method)
[Amend commit message to point to reproducer, and add Fixes:]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/sphinx/qapidoc.py | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 8011ac9efa..5374dee8fa 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -267,10 +267,14 @@ def visit_returns(self, section: QAPIDoc.Section) -> None:
         self.add_field("return", typ, section.text, section.info)
 
     def visit_errors(self, section: QAPIDoc.Section) -> None:
-        # FIXME: the formatting for errors may be inconsistent and may
-        # or may not require different newline placement to ensure
-        # proper rendering as a nested list.
-        self.add_lines(f":error:\n{section.text}", section.info)
+        # If the section text does not start with a space, it means text
+        # began on the same line as the "Error:" string and we should
+        # not insert a newline in this case.
+        if section.text[0].isspace():
+            text = f":error:\n{section.text}"
+        else:
+            text = f":error: {section.text}"
+        self.add_lines(text, section.info)
 
     def preamble(self, ent: QAPISchemaDefinition) -> None:
         """
-- 
2.49.0


