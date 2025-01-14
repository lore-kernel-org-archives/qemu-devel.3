Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EDD7C02185
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 19:03:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXm8i-0005nz-SB; Tue, 14 Jan 2025 13:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm8G-0005hh-3w
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tXm8C-0002no-RW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 13:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736881154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N1u8KZNLqEbowZNlJYRyeQnHxwCDXocg8vevIGmNUJI=;
 b=ASBepj0GQQgYGVtVE8E3PWO5uwFLHYI8TH/67lKn47CFa0DMWrgrWK1ZrVkt2cSDg4Ambg
 dQ9x4wtpLBz8E8t6YHaF2NsvD0RR6krRzcPK1PsNyyyemrUg5R7WCQ3TYyaXEHvFUPKBcx
 SmGm2yQoZUGF4AG1VbkBoTsfVaaH1cM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-408-inroKbqqNYmbg2P_peDTsg-1; Tue,
 14 Jan 2025 13:59:11 -0500
X-MC-Unique: inroKbqqNYmbg2P_peDTsg-1
X-Mimecast-MFC-AGG-ID: inroKbqqNYmbg2P_peDTsg
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0CBFE1955DDE; Tue, 14 Jan 2025 18:59:10 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.175])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 00C5519560A3; Tue, 14 Jan 2025 18:59:08 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Michael Roth <michael.roth@amd.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 18/23] docs/qapidoc: add visit_returns() method
Date: Tue, 14 Jan 2025 13:58:35 -0500
Message-ID: <20250114185840.3058525-19-jsnow@redhat.com>
In-Reply-To: <20250114185840.3058525-1-jsnow@redhat.com>
References: <20250114185840.3058525-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

Generates :returns: fields for explicit returns statements. Note that
this does not presently handle undocumented returns, which is handled in
a later commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index a4dbfa3b3dd..cbc62eb5084 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -41,6 +41,7 @@
 from qapi.schema import (
     QAPISchema,
     QAPISchemaArrayType,
+    QAPISchemaCommand,
     QAPISchemaEntity,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
@@ -202,6 +203,19 @@ def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
 
         self.generate_field("feat", section.member, section.text, section.info)
 
+    def visit_returns(self, section: QAPIDoc.Section) -> None:
+        assert isinstance(self.entity, QAPISchemaCommand)
+        rtype = self.entity.ret_type
+        # q_empty can produce None, but we won't be documenting anything
+        # without an explicit return statement in the doc block, and we
+        # should not have any such explicit statements when there is no
+        # return value.
+        assert rtype
+
+        typ = self.format_type(rtype)
+        assert section.text  # We don't expect empty returns sections.
+        self.add_field("returns", typ, section.text, section.info)
+
     def visit_errors(self, section: QAPIDoc.Section) -> None:
         # FIXME: the formatting for errors may be inconsistent and may
         # or may not require different newline placement to ensure
-- 
2.47.1


