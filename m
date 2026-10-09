Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44569CA6015
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2026 14:05:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xFBDJ-0000so-Du; Fri, 09 Oct 2026 10:04:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDG-0000s3-TZ
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1xFBDF-0007TL-7j
 for qemu-devel@nongnu.org; Fri, 09 Oct 2026 10:04:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791554680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2alIP8jKln//VCQ4oUpDoAEG8zxQvPiKhuCbdtOD1A=;
 b=HUJWlP4D9raJqzONz4QXiQym+fo9YIRT+VVVWmq6G1YPpu2EIBb7+pqlFaYAsQXFQP8J15
 aaVPiWB2JqTNZhd/3kBCtbsZgj4mukyrRX+Fc0K61b3AAZWzQKI97Xt82N29WlsL5ofo0I
 vP1NsSNwRZ2uk8NhqFF5dsvcya5z7SU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-600-y-KED8bSNKGiW3tetIjEIQ-1; Fri,
 9 Oct 2026 14:04:38 +0000
X-MC-Unique: y-KED8bSNKGiW3tetIjEIQ-1
X-Mimecast-MFC-AGG-ID: y-KED8bSNKGiW3tetIjEIQ_1791554677
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E578C18345A8; Fri,  9 Oct 2026 14:04:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9A46D1956095; Fri,  9 Oct 2026 14:04:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5A2B621E6884; Fri, 09 Oct 2026 16:04:31 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	michael.roth@amd.com,
	jsnow@redhat.com
Subject: [RFC PATCH 5/6] qapi: QAPISchemaVisitor.visit_needed() is now unused,
 drop
Date: Fri,  9 Oct 2026 16:04:30 +0200
Message-ID: <20261009140431.3175479-6-armbru@redhat.com>
In-Reply-To: <20261009140431.3175479-1-armbru@redhat.com>
References: <20261009140431.3175479-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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


