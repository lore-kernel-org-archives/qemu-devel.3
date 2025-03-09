Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EBB7C282D1
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 08:38:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trCAh-0007Nl-1L; Sun, 09 Mar 2025 04:38:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAX-0006i1-Vx
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1trCAW-0002a5-8A
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 04:37:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741509475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hyoOxfuL+eN7sxGkqJtJc7tjE8pjAxa9kZ6Hj/epo/4=;
 b=cLE5OWZxE5DV7FEns2yr1s9ZO5wO/e2Ou39YxauwX28uJA6ctz7jy+il8Rx5FqUwYKoJk0
 A3DxyVOwT2fKkEdKmyz9By2mwRm3AG8bjLjuzXX8PScp9PSvGPez1wBuuZxK+cXdM0s848
 FtXAY0YoR9FLntLcV/r1NqKkkoot/t8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-154-58qITFhLMou3_Mff3GjYBw-1; Sun,
 09 Mar 2025 04:37:52 -0400
X-MC-Unique: 58qITFhLMou3_Mff3GjYBw-1
X-Mimecast-MFC-AGG-ID: 58qITFhLMou3_Mff3GjYBw_1741509470
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0AAC1800260; Sun,  9 Mar 2025 08:37:50 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id C1D8A19560AB; Sun,  9 Mar 2025 08:37:48 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eric Blake <eblake@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>
Subject: [PATCH v2 46/62] docs/qapidoc: add format_type() method
Date: Sun,  9 Mar 2025 04:35:33 -0400
Message-ID: <20250309083550.5155-47-jsnow@redhat.com>
In-Reply-To: <20250309083550.5155-1-jsnow@redhat.com>
References: <20250309083550.5155-1-jsnow@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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
index 14feafe866e..0f895a3624a 100644
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


