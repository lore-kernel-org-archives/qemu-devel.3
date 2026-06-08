Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B16CD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSrB-0001PQ-T2; Mon, 08 Jun 2026 01:49:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSrA-0001NQ-18
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSr7-0000Q3-Pr
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:49:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897741;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f8nn7+5MK5dYSRR9+P7Ec0CabtdONessNo0TO/ApKhI=;
 b=XxU8VcTqGHQYnENC2XeYglZ3XNqTo2OHFgxPI9YC4CQqruw/oW6vAuGUcUiXYR00qwQrxZ
 3/ZZA5hUUvG5DrlRAHj/gd14y/gbv+DH0N5/Acj9OrEQJnke+5vwPDsj0i5RJoPvepDHgp
 awX8TcSkDXzD/jmMBRQiSiCDfbnWtqM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-32-5-N_4-SUPn6p_v9hXMFskw-1; Mon,
 08 Jun 2026 01:48:57 -0400
X-MC-Unique: 5-N_4-SUPn6p_v9hXMFskw-1
X-Mimecast-MFC-AGG-ID: 5-N_4-SUPn6p_v9hXMFskw_1780897736
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D380F180049F; Mon,  8 Jun 2026 05:48:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5ED6327A; Mon,  8 Jun 2026 05:48:55 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 13/37] hw/gpio/aspeed_sgpio: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:48:02 +0200
Message-ID: <20260608054826.346488-14-clg@redhat.com>
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Replace the legacy type_register_static()/type_init() registration
pattern with the modern DEFINE_TYPES() macro.

Inline 2 standalone TypeInfo variables (aspeed_sgpio_info and
aspeed_sgpio_ast2700_info) directly into the 'aspeed_sgpio_types[]'
array, removing the need for separate declarations.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-14-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/gpio/aspeed_sgpio.c | 37 ++++++++++++++++---------------------
 1 file changed, 16 insertions(+), 21 deletions(-)

diff --git a/hw/gpio/aspeed_sgpio.c b/hw/gpio/aspeed_sgpio.c
index 0c53b03464e4..7d2f73699520 100644
--- a/hw/gpio/aspeed_sgpio.c
+++ b/hw/gpio/aspeed_sgpio.c
@@ -321,26 +321,21 @@ static void aspeed_sgpio_2700_class_init(ObjectClass *klass, const void *data)
     agc->reg_ops = &aspeed_sgpio_2700_ops;
 }
 
-static const TypeInfo aspeed_sgpio_info = {
-    .name           = TYPE_ASPEED_SGPIO,
-    .parent         = TYPE_SYS_BUS_DEVICE,
-    .instance_size  = sizeof(AspeedSGPIOState),
-    .class_size     = sizeof(AspeedSGPIOClass),
-    .class_init     = aspeed_sgpio_class_init,
-    .abstract       = true,
-};
-
-static const TypeInfo aspeed_sgpio_ast2700_info = {
-    .name           = TYPE_ASPEED_SGPIO "-ast2700",
-    .parent         = TYPE_ASPEED_SGPIO,
-    .class_init     = aspeed_sgpio_2700_class_init,
-    .instance_init  = aspeed_sgpio_init,
+static const TypeInfo aspeed_sgpio_types[] = {
+    {
+        .name           = TYPE_ASPEED_SGPIO,
+        .parent         = TYPE_SYS_BUS_DEVICE,
+        .instance_size  = sizeof(AspeedSGPIOState),
+        .class_size     = sizeof(AspeedSGPIOClass),
+        .class_init     = aspeed_sgpio_class_init,
+        .abstract       = true,
+    },
+    {
+        .name           = TYPE_ASPEED_SGPIO "-ast2700",
+        .parent         = TYPE_ASPEED_SGPIO,
+        .class_init     = aspeed_sgpio_2700_class_init,
+        .instance_init  = aspeed_sgpio_init,
+    }
 };
 
-static void aspeed_sgpio_register_types(void)
-{
-    type_register_static(&aspeed_sgpio_info);
-    type_register_static(&aspeed_sgpio_ast2700_info);
-}
-
-type_init(aspeed_sgpio_register_types);
+DEFINE_TYPES(aspeed_sgpio_types)
-- 
2.54.0


