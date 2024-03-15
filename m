Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6D55C54E58
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Mar 2024 15:25:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rl9Ot-0007AR-JY; Fri, 15 Mar 2024 11:23:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9Os-00074S-AP
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rl9On-0001zR-BH
 for qemu-devel@nongnu.org; Fri, 15 Mar 2024 11:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710516188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iuXlJWkLOTSCm4x+nIQ3+iRqxZDs2p0TRUEIhBFjwi4=;
 b=QGljV25gSVDU3tnDK7tbXMWd3I/NfLcWGa4kNVD9w+exhKPFbSQTv6ql/50xKTBbjzo0Ea
 Mnj0iXlei+AmWlR1+iPGWhhNgSd7XrehC1WftPQMWurxm5YnPrih8RMvrGatXJ8ga22sbD
 UUl53ZDtatwwbavM1st/8SaOEi38VMk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-Ix3j29kkPiC8fCkuECzPtg-1; Fri, 15 Mar 2024 11:23:04 -0400
X-MC-Unique: Ix3j29kkPiC8fCkuECzPtg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E5F88007BA;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1DB91111E3F3;
 Fri, 15 Mar 2024 15:23:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EC0E921E68BD; Fri, 15 Mar 2024 16:23:01 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	peter.maydell@linaro.org,
	michael.roth@amd.com
Subject: [PATCH v5 09/25] qapi/schema: adjust type narrowing for mypy's benefit
Date: Fri, 15 Mar 2024 16:22:45 +0100
Message-ID: <20240315152301.3621858-10-armbru@redhat.com>
In-Reply-To: <20240315152301.3621858-1-armbru@redhat.com>
References: <20240315152301.3621858-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.933,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

We already take care to perform some type narrowing for arg_type and
ret_type, but not in a way where mypy can utilize the result once we add
type hints, e.g.:

qapi/schema.py:833: error: Incompatible types in assignment (expression
has type "QAPISchemaType", variable has type
"Optional[QAPISchemaObjectType]") [assignment]

qapi/schema.py:893: error: Incompatible types in assignment (expression
has type "QAPISchemaType", variable has type
"Optional[QAPISchemaObjectType]") [assignment]

A simple change to use a temporary variable helps the medicine go down.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 scripts/qapi/schema.py | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 0b01c841ff..e44802369d 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -843,13 +843,14 @@ def __init__(self, name, info, doc, ifcond, features,
     def check(self, schema):
         super().check(schema)
         if self._arg_type_name:
-            self.arg_type = schema.resolve_type(
+            arg_type = schema.resolve_type(
                 self._arg_type_name, self.info, "command's 'data'")
-            if not isinstance(self.arg_type, QAPISchemaObjectType):
+            if not isinstance(arg_type, QAPISchemaObjectType):
                 raise QAPISemError(
                     self.info,
                     "command's 'data' cannot take %s"
-                    % self.arg_type.describe())
+                    % arg_type.describe())
+            self.arg_type = arg_type
             if self.arg_type.variants and not self.boxed:
                 raise QAPISemError(
                     self.info,
@@ -866,8 +867,8 @@ def check(self, schema):
             if self.name not in self.info.pragma.command_returns_exceptions:
                 typ = self.ret_type
                 if isinstance(typ, QAPISchemaArrayType):
-                    typ = self.ret_type.element_type
                     assert typ
+                    typ = typ.element_type
                 if not isinstance(typ, QAPISchemaObjectType):
                     raise QAPISemError(
                         self.info,
@@ -903,13 +904,14 @@ def __init__(self, name, info, doc, ifcond, features, arg_type, boxed):
     def check(self, schema):
         super().check(schema)
         if self._arg_type_name:
-            self.arg_type = schema.resolve_type(
+            typ = schema.resolve_type(
                 self._arg_type_name, self.info, "event's 'data'")
-            if not isinstance(self.arg_type, QAPISchemaObjectType):
+            if not isinstance(typ, QAPISchemaObjectType):
                 raise QAPISemError(
                     self.info,
                     "event's 'data' cannot take %s"
-                    % self.arg_type.describe())
+                    % typ.describe())
+            self.arg_type = typ
             if self.arg_type.variants and not self.boxed:
                 raise QAPISemError(
                     self.info,
-- 
2.44.0


