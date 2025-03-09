Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A31B1C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCB3-0000Hp-1c; Sun, 09 Mar 2025 04:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAh-0007WE-Qv
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAf-0002bb-Lz
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:38:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509484;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vKopI/AWjtj/zsIuyT99Y+aZfaf9wJkOLsCuec/d7F0=;
 b=CNR5rmNt0ptc54Cy9F7rj3gSahQ36mjF2wciBXdsxKpPkll98Vey7t2GtOsBw2cuzt3DSK
 fJ0DvR+S9nYXQEBzgsAFJi4XLs3PHd5Csicy2yKIRCfzwqx2J4M+q2VbJU4uXrwkvlJy/7
 e+aqtBculxlbp3M5z9GyEB8u6h09BWc=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-kU43lymBNIC1wRiO68CHPQ-1; Sun,
 09 Mar 2025 04:38:01 -0400
X-MC-Unique: kU43lymBNIC1wRiO68CHPQ-1
X-Mimecast-MFC-AGG-ID: kU43lymBNIC1wRiO68CHPQ_1741509480
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1F4DB19560AF; Sun,  9 Mar 2025 08:38:00 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0145519560AD; Sun,  9 Mar 2025 08:37:57 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 50/62] docs/qapidoc: add visit_returns() method
Date: Sun,  9 Mar 2025 04:35:37 -0400
Message-ID: <20250309083550.5155-51-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

Generates :returns: fields for explicit returns statements. Note that
this does not presently handle undocumented returns, which is handled in
a later commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index 834f12ba6e9..85e7367ad79 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -41,6 +41,7 @@
 from qapi.schema import (
     QAPISchema,
     QAPISchemaArrayType,
+    QAPISchemaCommand,
     QAPISchemaDefinition,
     QAPISchemaEnumMember,
     QAPISchemaFeature,
@@ -210,6 +211,20 @@ def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
 
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
+        assert typ
+        assert section.text  # We don't expect empty returns sections.
+        self.add_field("return", typ, section.text, section.info)
+
     def visit_errors(self, section: QAPIDoc.Section) -> None:
         # FIXME: the formatting for errors may be inconsistent and may
         # or may not require different newline placement to ensure
-- 
2.48.1


