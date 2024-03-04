Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7602DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 06:34:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh1tD-00063U-2p; Mon, 04 Mar 2024 01:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sX-0005YI-FY
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rh1sR-00008H-IA
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 01:32:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709533961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C0RuL1Qwg1qvrtn12kstdflDO5kngKZEh/ycmJgdVY8=;
 b=Oku7QvXX1MPUERxRuaqN2Ukxo7vb//vfJCr8satFbi3nmzlTP7CqqSnZDNe6Rn4D/3gxlR
 0LYdKFWig7WawmyjGRuJd4cKyt86YfDfOXpqHVlNY6tpR58ZbKZzUJP9+E2HXUz6GL1Tfq
 2JXIlAW9WdrTSikn79MQIPpb4VdUwSs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-563-VC7O7hY4NJq8ka1iJw6uaA-1; Mon,
 04 Mar 2024 01:32:39 -0500
X-MC-Unique: VC7O7hY4NJq8ka1iJw6uaA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BFC23816447;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4899640C6EBA;
 Mon,  4 Mar 2024 06:32:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EB5121E682B; Mon,  4 Mar 2024 07:32:36 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
Subject: [PULL 13/18] qapi: Reject "Returns" section when command doesn't
 return anything
Date: Mon,  4 Mar 2024 07:32:31 +0100
Message-ID: <20240304063236.213955-14-armbru@redhat.com>
In-Reply-To: <20240304063236.213955-1-armbru@redhat.com>
References: <20240304063236.213955-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240227113921.236097-14-armbru@redhat.com>
---
 scripts/qapi/parser.py                     | 7 ++++++-
 tests/qapi-schema/doc-invalid-return2.err  | 1 +
 tests/qapi-schema/doc-invalid-return2.json | 7 +++++++
 tests/qapi-schema/doc-invalid-return2.out  | 0
 tests/qapi-schema/meson.build              | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)
 create mode 100644 tests/qapi-schema/doc-invalid-return2.err
 create mode 100644 tests/qapi-schema/doc-invalid-return2.json
 create mode 100644 tests/qapi-schema/doc-invalid-return2.out

diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
index a32b2c7e7f..d8f76060b8 100644
--- a/scripts/qapi/parser.py
+++ b/scripts/qapi/parser.py
@@ -721,7 +721,12 @@ def connect_feature(self, feature: 'QAPISchemaFeature') -> None:
         self.features[feature.name].connect(feature)
 
     def check_expr(self, expr: QAPIExpression) -> None:
-        if 'command' not in expr:
+        if 'command' in expr:
+            if self.returns and 'returns' not in expr:
+                raise QAPISemError(
+                    self.returns.info,
+                    "'Returns' section, but command doesn't return anything")
+        else:
             if self.returns:
                 raise QAPISemError(
                     self.returns.info,
diff --git a/tests/qapi-schema/doc-invalid-return2.err b/tests/qapi-schema/doc-invalid-return2.err
new file mode 100644
index 0000000000..c3d0c7a452
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-return2.err
@@ -0,0 +1 @@
+doc-invalid-return2.json:5: 'Returns' section, but command doesn't return anything
diff --git a/tests/qapi-schema/doc-invalid-return2.json b/tests/qapi-schema/doc-invalid-return2.json
new file mode 100644
index 0000000000..37883d4fea
--- /dev/null
+++ b/tests/qapi-schema/doc-invalid-return2.json
@@ -0,0 +1,7 @@
+# Command doesn't return anything
+
+##
+# @foo:
+# Returns: blah
+##
+{ 'command': 'foo' }
diff --git a/tests/qapi-schema/doc-invalid-return2.out b/tests/qapi-schema/doc-invalid-return2.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qapi-schema/meson.build b/tests/qapi-schema/meson.build
index 4b8329d070..0f479d9317 100644
--- a/tests/qapi-schema/meson.build
+++ b/tests/qapi-schema/meson.build
@@ -79,6 +79,7 @@ schemas = [
   'doc-invalid-end.json',
   'doc-invalid-end2.json',
   'doc-invalid-return.json',
+  'doc-invalid-return2.json',
   'doc-invalid-section.json',
   'doc-invalid-start.json',
   'doc-missing-colon.json',
-- 
2.44.0


