Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE503C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 10:54:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reYZD-0002ko-VZ; Mon, 26 Feb 2024 05:50:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYe-0002bW-PB
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reYYa-0003iv-E8
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 05:50:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708944599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8w12yVQTUHu71nwpu/QeSRSCKr3NQUj/iWWCHnk5SRs=;
 b=TsXMkLL+9MeP4qWdDI+ZjBVY//BRotI6rUySAPKvfaqxyZygy54zr0evN2MIuHtPFq7kBN
 rI2dKYsW2von4HQLgHuVJ70uSTrb403uUV7eiykLxbXPxvallXDysvXXNIsyjM8IFMNqw7
 WzIHD6cmMy1d6VLT1sMERf5BzAJXCJI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-482-lXPPQQXcM2CyEiDA9LYXDw-1; Mon,
 26 Feb 2024 05:49:57 -0500
X-MC-Unique: lXPPQQXcM2CyEiDA9LYXDw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E57721C382A7;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C33D840C1430;
 Mon, 26 Feb 2024 10:49:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AC8A221E5A5A; Mon, 26 Feb 2024 11:49:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 13/17] qapi: Call QAPIDoc.check() always
Date: Mon, 26 Feb 2024 11:49:50 +0100
Message-ID: <20240226104954.3781985-14-armbru@redhat.com>
In-Reply-To: <20240226104954.3781985-1-armbru@redhat.com>
References: <20240226104954.3781985-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

We currently call QAPIDoc.check() only for definition documentation.
Calling it for free-form documentation as well is simpler.  No change,
because it doesn't actually do anything there.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-ID: <20240216145841.2099240-13-armbru@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
---
 scripts/qapi/schema.py | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 6a836950a9..8ba5665bc6 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -95,10 +95,6 @@ def connect_doc(self, doc=None):
             for f in self.features:
                 doc.connect_feature(f)
 
-    def check_doc(self):
-        if self.doc:
-            self.doc.check()
-
     def _set_module(self, schema, info):
         assert self._checked
         fname = info.fname if info else QAPISchemaModule.BUILTIN_MODULE_NAME
@@ -1223,9 +1219,10 @@ def check(self):
         for ent in self._entity_list:
             ent.check(self)
             ent.connect_doc()
-            ent.check_doc()
         for ent in self._entity_list:
             ent.set_module(self)
+        for doc in self.docs:
+            doc.check()
 
     def visit(self, visitor):
         visitor.visit_begin(self)
-- 
2.43.0


