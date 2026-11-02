Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347236088B10
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2026 14:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XSVJ3kL1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNtEE-0004BQ-Dg; Mon, 02 Nov 2026 09:41:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtDA-0003Cw-G1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xNtD6-0008SB-M1
 for qemu-devel@nongnu.org; Mon, 02 Nov 2026 09:40:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793630431;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gkMSluGbkdTqOaPCGpiW3WpFrqQZjAGnKt7nLESnzoo=;
 b=XSVJ3kL1J/k/YM3wrhXaTs9ZABGzWy3UEuycCfLidSW7i4lAPQZUxmFH/RGsUNy9+C/Xx0
 rGR9xZj2DDXuiCtRB9bheW60ivNCUR08bb0rIrA83LBtEWIFjASlAymq3sKzpen78bz06H
 btxU3JykA5/HdmL/jmSgiMi40paLTfQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-292-RNYXPcBFN269LX4HuD7bBA-1; Mon,
 02 Nov 2026 09:40:28 -0500
X-MC-Unique: RNYXPcBFN269LX4HuD7bBA-1
X-Mimecast-MFC-AGG-ID: RNYXPcBFN269LX4HuD7bBA_1793630427
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 70A7C195BDC5; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 30D74767; Mon,  2 Nov 2026 14:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4837421E689A; Mon, 02 Nov 2026 15:40:19 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 22/74] qapi: QAPISchemaVisitor.visit_needed() is now unused,
 drop
Date: Mon,  2 Nov 2026 15:39:26 +0100
Message-ID: <20261102144018.3212223-23-armbru@redhat.com>
In-Reply-To: <20261102144018.3212223-1-armbru@redhat.com>
References: <20261102144018.3212223-1-armbru@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 5
X-Spam_score: 0.5
X-Spam_bar: /
X-Spam_report: (0.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20261101201717.3911097-6-armbru@redhat.com>
---
 scripts/qapi/schema.py | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/scripts/qapi/schema.py b/scripts/qapi/schema.py
index 11f3accec8..9e2152fa41 100644
--- a/scripts/qapi/schema.py
+++ b/scripts/qapi/schema.py
@@ -179,11 +179,6 @@ def visit_end(self) -> None:
     def visit_module(self, name: str) -> None:
         pass
 
-    def visit_needed(self, entity: QAPISchemaEntity) -> bool:
-        # pylint: disable=unused-argument
-        # Default to visiting everything
-        return True
-
     def visit_include(self, name: str, info: Optional[QAPISourceInfo]) -> None:
         pass
 
@@ -315,8 +310,7 @@ def add_entity(self, ent: QAPISchemaEntity) -> None:
     def visit(self, visitor: QAPISchemaVisitor) -> None:
         visitor.visit_module(self.name)
         for entity in self._entity_list:
-            if visitor.visit_needed(entity):
-                entity.visit(visitor)
+            entity.visit(visitor)
 
 
 class QAPISchemaInclude(QAPISchemaEntity):
-- 
2.55.0


