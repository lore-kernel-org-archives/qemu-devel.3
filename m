Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B615DCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 05:54:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWSqp-0001Fo-Et; Mon, 08 Jun 2026 01:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqo-0001Em-3M
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wWSqm-0000LB-By
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 01:48:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780897719;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hGfeYpuAix5wAfxjUsQQZ4i5WS2PTpyUMv2zAR6tQE0=;
 b=IIrCTKr/xseJx7gozNuKafIOkW+kNyx1j3+CTfELagsf2xvpSozzQyaHW1GrJl5aotdgnF
 jrHxP7BIuJIHCVhyuxhh/nNzmZt4mre7tBY2eyPrSTUWfVTVErofOQfHho+Uvo8+RCzV4k
 5gLXd7u+Zxf4Jh5jc0IClNuvTsXmRWM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-691-X67GyIKcPV-PRZhqxA8Kxw-1; Mon,
 08 Jun 2026 01:48:37 -0400
X-MC-Unique: X67GyIKcPV-PRZhqxA8Kxw-1
X-Mimecast-MFC-AGG-ID: X67GyIKcPV-PRZhqxA8Kxw_1780897717
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E106A195608A; Mon,  8 Jun 2026 05:48:36 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.33])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2BDE927A; Mon,  8 Jun 2026 05:48:34 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 03/37] hw/misc/aspeed_ltpi: Convert to DEFINE_TYPES() with
 inlined TypeInfo
Date: Mon,  8 Jun 2026 07:47:52 +0200
Message-ID: <20260608054826.346488-4-clg@redhat.com>
In-Reply-To: <20260608054826.346488-1-clg@redhat.com>
References: <20260608054826.346488-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Inline the standalone 'aspeed_ltpi_info' TypeInfo variable directly
into the 'aspeed_ltpi_types[]' array, removing the need for a separate
declaration.

No functional change.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260601024959.2347639-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/misc/aspeed_ltpi.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/hw/misc/aspeed_ltpi.c b/hw/misc/aspeed_ltpi.c
index 956e91d14361..2e413550b9fd 100644
--- a/hw/misc/aspeed_ltpi.c
+++ b/hw/misc/aspeed_ltpi.c
@@ -179,16 +179,13 @@ static void aspeed_ltpi_class_init(ObjectClass *klass, const void *data)
     rc->phases.hold = aspeed_ltpi_reset_hold;
 }
 
-static const TypeInfo aspeed_ltpi_info = {
-    .name          = TYPE_ASPEED_LTPI,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(AspeedLTPIState),
-    .class_init    = aspeed_ltpi_class_init,
+static const TypeInfo aspeed_ltpi_types[] = {
+    {
+        .name          = TYPE_ASPEED_LTPI,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(AspeedLTPIState),
+        .class_init    = aspeed_ltpi_class_init,
+    }
 };
 
-static void aspeed_ltpi_register_types(void)
-{
-    type_register_static(&aspeed_ltpi_info);
-}
-
-type_init(aspeed_ltpi_register_types);
+DEFINE_TYPES(aspeed_ltpi_types)
-- 
2.54.0


