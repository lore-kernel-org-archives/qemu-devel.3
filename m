Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A468C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:34:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEW9h-0006eH-2m; Tue, 04 Jun 2024 11:32:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9e-0006bI-SD
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sEW9d-0001Hb-6B
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 11:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717515172;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4adVHmCbzeBezujTwCZuobD70x9l5Rn6nXDmdzXRVJg=;
 b=DIdSeb87OZKmox+H3KZi3eoextxl5QELTgiR9ayICS6DMWHn91CZjEwyIhmJkExyTFex0e
 iP8XhBFJzom5bKgAlibyYurhPtDqsENLL+8fuYcqen07NFV6eMOZe8OFimnbCl3Wr1FJOr
 bW1AjujSsYAHWagsfZVQhg7RYyHT2Ww=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-142-GCiby5NiPgqCeFAws9BTJA-1; Tue,
 04 Jun 2024 11:32:50 -0400
X-MC-Unique: GCiby5NiPgqCeFAws9BTJA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0BFA829ABA01;
 Tue,  4 Jun 2024 15:32:50 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.39.194.137])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B142492BD3;
 Tue,  4 Jun 2024 15:32:49 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 05/14] qapi: stop hardcoding list of special features
Date: Tue,  4 Jun 2024 16:32:33 +0100
Message-ID: <20240604153242.251334-6-berrange@redhat.com>
In-Reply-To: <20240604153242.251334-1-berrange@redhat.com>
References: <20240604153242.251334-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Use the additional list of special features for commands, previously
defined by a pragma, to augment the standard 'unstable' and 'deprecated'
ones.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/schema.py | 33 ++++++++++++++++++++++++++++-----
 1 file changed, 28 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 721c470d2b..b83a9bdcb7 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -932,8 +932,18 @@ def connect_doc(self, doc: Optional[QAPIDoc]) -> None:
 class QAPISchemaFeature(QAPISchemaMember):
     role = 'feature'
 
+    def __init__(
+        self,
+        name: str,
+        info: Optional[QAPISourceInfo],
+        ifcond: Optional[QAPISchemaIfCond] = None,
+        special: bool = False,
+    ):
+        super().__init__(name, info, ifcond)
+        self.special = special
+
     def is_special(self) -> bool:
-        return self.name in ('deprecated', 'unstable')
+        return self.special
 
 
 class QAPISchemaObjectTypeMember(QAPISchemaMember):
@@ -1143,6 +1153,9 @@ def __init__(self, fname: str):
         self._predefining = True
         self._def_predefineds()
         self._predefining = False
+        self._custom_special_features: Dict[str, List[str]] = {
+            'command': parser.info.pragma.command_features
+        }
         self._def_exprs(exprs)
         self.check()
 
@@ -1254,12 +1267,21 @@ def _make_features(
         self,
         features: Optional[List[Dict[str, Any]]],
         info: Optional[QAPISourceInfo],
+        custom_special_features: Optional[List[str]] = [],
     ) -> List[QAPISchemaFeature]:
         if features is None:
             return []
-        return [QAPISchemaFeature(f['name'], info,
-                                  QAPISchemaIfCond(f.get('if')))
-                for f in features]
+        ret = []
+        for f in features:
+            name = f['name']
+            special = name in ["unstable", "deprecated"]
+            if custom_special_features is not None:
+                if name in custom_special_features:
+                    special = True
+            ret.append(QAPISchemaFeature(name, info,
+                                         QAPISchemaIfCond(f.get('if')),
+                                         special))
+        return ret
 
     def _make_enum_member(
         self,
@@ -1430,7 +1452,8 @@ def _def_command(self, expr: QAPIExpression) -> None:
         coroutine = expr.get('coroutine', False)
         ifcond = QAPISchemaIfCond(expr.get('if'))
         info = expr.info
-        features = self._make_features(expr.get('features'), info)
+        features = self._make_features(expr.get('features'), info,
+                                       self._custom_special_features['command'])
         if isinstance(data, OrderedDict):
             data = self._make_implicit_object_type(
                 name, info, ifcond,
-- 
2.45.1


