Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EECCD8CA4
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:51:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSrd-0001g3-OZ; Mon, 08 Jun 2026 01:49:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrT-0001Xo-8h
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrR-0000XA-MC
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MXmUhA3gQLASTOz62jAZDxuN/8QqLB/kGw07hGz1IXM=;
 b=QXQ9gQHuxBrYaHl5fiSaSskBao9VB6+PANGUISOPW9G2376yzP9/BwH9pmdaBnPCf+pTmM
 6exE71vjpXEOvfsbTus9s29IMKwWMdspWTpHAI7NRXhMYGVVDdE0VNPKzUuIWKYaO/yDWQ
 wZRVJ9on6EGOjmJI/oWkDt0k366J/H8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-372-X3tFSyuEOZe-yD-BSzvQlA-1; Mon,
 08 Jun 2026 01:49:17 -0400
X-MC-Unique: X3tFSyuEOZe-yD-BSzvQlA-1
X-Mimecast-MFC-AGG-ID: X3tFSyuEOZe-yD-BSzvQlA_1780897756
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D0B2F1800347; Mon,  8 Jun 2026 05:49:16 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5C47B1688; Mon,  8 Jun 2026 05:49:15 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 23/37] hw/net/ftgmac100: Convert to DEFINE_TYPES() with inlined
 TypeInfo
Date: Mon,  8 Jun 2026 07:48:12 +0200
Message-ID: <20260608054826.346488-24-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Replace the legacy type_register_static()/type_init() registration
pattern with the modern DEFINE_TYPES() macro.

Inline 2 standalone TypeInfo variables (ftgmac100_info,
aspeed_mii_info) directly into the 'ftgmac100_types[]' array,
removing the need for separate declarations. Note that this file
covers both the Faraday FTGMAC100 Gigabit Ethernet controller and
the Aspeed MII controller, which share the same type registration.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-24-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/ftgmac100.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index 2bec817b9dec..a53c840c3725 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -1279,12 +1279,6 @@ static void ftgmac100_class_init(ObjectClass *klass, const void *data)
     dc->desc = "Faraday FTGMAC100 Gigabit Ethernet emulation";
 }
 
-static const TypeInfo ftgmac100_info = {
-    .name = TYPE_FTGMAC100,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(FTGMAC100State),
-    .class_init = ftgmac100_class_init,
-};
 
 /*
  * AST2600 MII controller
@@ -1438,17 +1432,19 @@ static void aspeed_mii_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, aspeed_mii_properties);
 }
 
-static const TypeInfo aspeed_mii_info = {
-    .name = TYPE_ASPEED_MII,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedMiiState),
-    .class_init = aspeed_mii_class_init,
+static const TypeInfo ftgmac100_types[] = {
+    {
+        .name          = TYPE_FTGMAC100,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(FTGMAC100State),
+        .class_init    = ftgmac100_class_init,
+    },
+    {
+        .name          = TYPE_ASPEED_MII,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedMiiState),
+        .class_init    = aspeed_mii_class_init,
+    }
 };
 
-static void ftgmac100_register_types(void)
-{
-    type_register_static(&ftgmac100_info);
-    type_register_static(&aspeed_mii_info);
-}
-
-type_init(ftgmac100_register_types)
+DEFINE_TYPES(ftgmac100_types)
-- 
2.54.0


