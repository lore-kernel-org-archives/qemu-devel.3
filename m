Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DCC0C10F15
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 08:17:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzXoe-0000NE-8j; Wed, 24 Apr 2024 04:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoc-0000Lq-Jb
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rzXoZ-0006M0-Uw
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 04:17:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713946635;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ISyh3RRXd2jvQFg0Yb6P52AqbwlJikH4TBpkFzkZ6Bw=;
 b=K7bzwXODiIQD8DCrwxpaQnOPkCPoFzTvgJ3V5uNDbdAlxJ3gKU93ZYloZRLIj8bi/6bRG+
 WWtePe+1DJHfQMMTn44TBqQiP0s6WTVPbWomdYQ7+qQhQEtmrWmoFcawoHEtSl9h3RCBXP
 b/BuJL4h5pg/MZBOaEXE+homfNGwUHs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-90MCLKojM6SQbGbkQPAtUw-1; Wed, 24 Apr 2024 04:17:13 -0400
X-MC-Unique: 90MCLKojM6SQbGbkQPAtUw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C08F1011A14;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0CCC020128F3;
 Wed, 24 Apr 2024 08:17:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DDBE521E65E1; Wed, 24 Apr 2024 10:17:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	John Snow <jsnow@redhat.com>
Subject: [PULL 09/25] qapi/schema: adjust type narrowing for mypy's benefit
Date: Wed, 24 Apr 2024 10:16:54 +0200
Message-ID: <20240424081710.2907748-10-armbru@redhat.com>
In-Reply-To: <20240424081710.2907748-1-armbru@redhat.com>
References: <20240424081710.2907748-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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
Message-ID: <20240315152301.3621858-10-armbru@redhat.com>
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


