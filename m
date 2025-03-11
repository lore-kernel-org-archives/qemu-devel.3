Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAA11C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 04:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trqax-0005HH-9t; Mon, 10 Mar 2025 23:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqZ6-0008Nc-HI
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:46:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trqYz-0002j9-Cd
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 23:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741664752;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yciYLWRt9Lw3nixFl1/U8yAozl9NWb+UUTP2YlwnXbE=;
 b=h7yDlDKp3A/QMgiwd7UY08NZFXGyiNqc/j3sslnQDcRkO56B8/GlwryOGAzk8dBrbIqTk5
 ZgtUmLzuqroWD4seLMo3hUIlZW4rcZvCH466ImSgB1r+brTthwOlNU6JzX0/lNthdneXC3
 Y1HzyPxwDEGTEihArlXVhm5BTG2LchE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-E-uCZqQrNW-l79C67nmLDw-1; Mon,
 10 Mar 2025 23:45:49 -0400
X-MC-Unique: E-uCZqQrNW-l79C67nmLDw-1
X-Mimecast-MFC-AGG-ID: E-uCZqQrNW-l79C67nmLDw_1741664748
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15F32180025C; Tue, 11 Mar 2025 03:45:48 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.49])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4289E1800366; Tue, 11 Mar 2025 03:45:44 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v3 46/63] docs/qapidoc: add format_type() method
Date: Mon, 10 Mar 2025 23:42:44 -0400
Message-ID: <20250311034303.75779-47-jsnow@redhat.com>
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

This method is responsible for generating a type name for a given member
with the correct annotations for the QAPI domain. Features and enums do
not *have* types, so they return None. Everything else returns the type
name with a "?" suffix if that type is optional, and ensconced in
[brackets] if it's an array type.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index c17cb9f9b16..5144bb965af 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -40,7 +40,13 @@
 from qapi.parser import QAPIDoc
 from qapi.schema import (
     QAPISchema,
+    QAPISchemaArrayType,
     QAPISchemaDefinition,
+    QAPISchemaEnumMember,
+    QAPISchemaFeature,
+    QAPISchemaMember,
+    QAPISchemaObjectTypeMember,
+    QAPISchemaType,
     QAPISchemaVisitor,
 )
 from qapi.source import QAPISourceInfo
@@ -58,7 +64,9 @@
         Any,
         Generator,
         List,
+        Optional,
         Sequence,
+        Union,
     )
 
     from sphinx.application import Sphinx
@@ -128,6 +136,30 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    def format_type(
+        self, ent: Union[QAPISchemaDefinition | QAPISchemaMember]
+    ) -> Optional[str]:
+        if isinstance(ent, (QAPISchemaEnumMember, QAPISchemaFeature)):
+            return None
+
+        qapi_type = ent
+        optional = False
+        if isinstance(ent, QAPISchemaObjectTypeMember):
+            qapi_type = ent.type
+            optional = ent.optional
+
+        if isinstance(qapi_type, QAPISchemaArrayType):
+            ret = f"[{qapi_type.element_type.doc_type()}]"
+        else:
+            assert isinstance(qapi_type, QAPISchemaType)
+            tmp = qapi_type.doc_type()
+            assert tmp
+            ret = tmp
+        if optional:
+            ret += "?"
+
+        return ret
+
     # Transmogrification helpers
 
     def visit_paragraph(self, section: QAPIDoc.Section) -> None:
-- 
2.48.1


