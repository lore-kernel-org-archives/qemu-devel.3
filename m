Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3AB1C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:19:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXpD-0001ID-4z; Wed, 24 Apr 2024 04:17:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXog-0000PC-Pw
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoc-0006NR-Gu
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QcafE001xOcjxMIocmQop4ggl5SkBI7dDGkHJDJs+Ho=;
 b=Nf+wj000hqBIkynnrqjmVO3p2cC2HR1jqhV4i1lIkT2RUApam7sAX9qSiOSLtQnwwtHsOu
 IA+MZbnECtT+2cGu+tJZPSW/D74c5ybz4NXWrRlFPSQjAg+jvvv67B+reBbm0ppl9TmC0K
 KUSuqgUsA1TQw/Pr7y2CbfVCp62JbbY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-8yL8lh6AM4O4FmnGtMUYSg-1; Wed, 24 Apr 2024 04:17:14 -0400
X-MC-Unique: 8yL8lh6AM4O4FmnGtMUYSg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D65A80253A;
 Wed, 24 Apr 2024 08:17:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3D391C15771;
 Wed, 24 Apr 2024 08:17:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 179D721F980D; Wed, 24 Apr 2024 10:17:11 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 25/25] qapi: Dumb down QAPISchema.lookup_entity()
Date: Wed, 24 Apr 2024 10:17:10 +0200
Message-ID: <20240424081710.2907748-26-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.67,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

QAPISchema.lookup_entity() takes an optional type argument, a subtype
of QAPISchemaDefinition, and returns that type or None.  Callers can
use this to save themselves an isinstance() test.

The only remaining user of this convenience feature is .lookup_type().
But we don't actually save anything anymore there: we still need the
isinstance() to help mypy over the hump.

Drop the .lookup_entity() argument, and adjust .lookup_type().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240315152301.3621858-26-armbru@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
[Commit message typo fixed]
---
 scripts/qapi/schema.py | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index a6180f93c6..5924947fc3 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -1157,20 +1157,14 @@ def _def_definition(self, defn: QAPISchemaDefinition) -> None:
                 defn.info, "%s is already defined" % other_defn.describe())
         self._entity_dict[defn.name] = defn
 
-    def lookup_entity(
-        self,
-        name: str,
-        typ: Optional[type] = None,
-    ) -> Optional[QAPISchemaDefinition]:
-        ent = self._entity_dict.get(name)
-        if typ and not isinstance(ent, typ):
-            return None
-        return ent
+    def lookup_entity(self,name: str) -> Optional[QAPISchemaEntity]:
+        return self._entity_dict.get(name)
 
     def lookup_type(self, name: str) -> Optional[QAPISchemaType]:
-        typ = self.lookup_entity(name, QAPISchemaType)
-        assert typ is None or isinstance(typ, QAPISchemaType)
-        return typ
+        typ = self.lookup_entity(name)
+        if isinstance(typ, QAPISchemaType):
+            return typ
+        return None
 
     def resolve_type(
         self,
-- 
2.44.0


