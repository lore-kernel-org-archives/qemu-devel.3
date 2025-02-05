Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B3F8C02192
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2025 23:13:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfoaU-0002Ra-Am; Wed, 05 Feb 2025 18:13:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoaQ-0002G0-9F
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:13:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1tfoaO-0005hr-AH
 for qemu-devel@nongnu.org; Wed, 05 Feb 2025 18:13:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738797215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ifDmYjcDkcsPKK2h0FWyf0lwnkxZx0G8P2XUmvBR8Ko=;
 b=Tg4+Gc9QfHKod/c6vHSLKU+8ynKodO6GQB24BLsAmcw81OAVrpaUQcJj1mWMgzYcn+u4iC
 qZscmuu5LwNqrxoMn4lFNzO2MU10ZEwe7y87RAlmQBgYp+vI5N/toZRubwODdz9uUGWzSt
 7uHWpFzzoA97XyxYzJJgx4Q/OSYYkm4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-373-VplHk14OM9Cq4uaHomXB-Q-1; Wed,
 05 Feb 2025 18:13:25 -0500
X-MC-Unique: VplHk14OM9Cq4uaHomXB-Q-1
X-Mimecast-MFC-AGG-ID: VplHk14OM9Cq4uaHomXB-Q
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6EBB31800987; Wed,  5 Feb 2025 23:13:23 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.66.104])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A01B81800570; Wed,  5 Feb 2025 23:13:17 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Yanan Wang <wangyanan55@huawei.com>, Fabiano Rosas <farosas@suse.de>,
 Zhao Liu <zhao1.liu@intel.com>, Lukas Straub <lukasstraub2@web.de>,
 Eduardo Habkost <eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH 11/42] docs/qapidoc: add preamble() method
Date: Wed,  5 Feb 2025 18:11:37 -0500
Message-ID: <20250205231208.1480762-12-jsnow@redhat.com>
In-Reply-To: <20250205231208.1480762-1-jsnow@redhat.com>
References: <20250205231208.1480762-1-jsnow@redhat.com>
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

This method adds the options/preamble to each definition block. Notably,
:since: and :ifcond: are added, as are any "special features" such as
:deprecated: and :unstable:.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 docs/sphinx/qapidoc.py | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
index c42cc3705aa..97868e5c375 100644
--- a/docs/sphinx/qapidoc.py
+++ b/docs/sphinx/qapidoc.py
@@ -38,7 +38,7 @@
 from qapi.error import QAPIError, QAPISemError
 from qapi.gen import QAPISchemaVisitor
 from qapi.parser import QAPIDoc
-from qapi.schema import QAPISchema
+from qapi.schema import QAPISchema, QAPISchemaEntity
 from qapi.source import QAPISourceInfo
 
 from sphinx import addnodes
@@ -125,6 +125,36 @@ def ensure_blank_line(self) -> None:
             # +2: correct for zero/one index, then increment by one.
             self.add_line_raw("", fname, line + 2)
 
+    # Transmogrification helpers
+
+    def preamble(self, ent: QAPISchemaEntity) -> None:
+        """
+        Generate option lines for qapi entity directives.
+        """
+        if ent.doc and ent.doc.since:
+            assert ent.doc.since.kind == QAPIDoc.Kind.SINCE
+            # Generated from the entity's docblock; info location is exact.
+            self.add_line(f":since: {ent.doc.since.text}", ent.doc.since.info)
+
+        if ent.ifcond.is_present():
+            doc = ent.ifcond.docgen()
+            # Generated from entity definition; info location is approximate.
+            self.add_line(f":ifcond: {doc}", ent.info)
+
+        # Hoist special features such as :deprecated: and :unstable:
+        # into the options block for the entity. If, in the future, new
+        # special features are added, qapi-domain will chirp about
+        # unrecognized options and fail until they are handled in
+        # qapi-domain.
+        for feat in ent.features:
+            if feat.is_special():
+                # FIXME: handle ifcond if present. How to display that
+                # information is TBD.
+                # Generated from entity def; info location is approximate.
+                self.add_line(f":{feat.name}:", feat.info)
+
+        self.ensure_blank_line()
+
     # Transmogrification core methods
 
     def visit_module(self, path: str) -> None:
-- 
2.48.1


