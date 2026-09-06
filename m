Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45272C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:13:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GP0-0003mI-FA; Sun, 06 Sep 2026 13:11:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOe-0003dW-GB
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOd-00009O-1w
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:11:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KfE/DKFTY0eE+C8K2XBx523m0rfeC7/0AsRo3m2ghUE=;
 b=du1PeNqMYXXW+1wnkNLeAGm99cQqfXrkxzQm05mSsk9hpT4nFFlqIN6m8JhWRNodFoLer5
 CwTfFenSrEc6mgOkC8mzcmTlQXzMFfQPc9tqrORMpR6XpYM1eiOK0DWZoILAhWDdxBOsBd
 5CBJPSkvqQrlcv52RBVmKFc6dKskL6s=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-ESH2usrfPlS7n3pVp4Rxbw-1; Sun,
 06 Sep 2026 13:11:06 -0400
X-MC-Unique: ESH2usrfPlS7n3pVp4Rxbw-1
X-Mimecast-MFC-AGG-ID: ESH2usrfPlS7n3pVp4Rxbw_1788714665
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D11A1801238; Sun,  6 Sep 2026 17:11:05 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0B20C1955F06; Sun,  6 Sep 2026 17:11:03 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 17/40] hw/misc/aspeed_sbc: Increase register space to 0x1000
Date: Sun,  6 Sep 2026 19:09:58 +0200
Message-ID: <20260906171021.26568-18-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The SBC controller register space is 0x1000.
Increase ASPEED_SBC_NR_REGS accordingly to cover the
full register space.

This changes the size of the VMState register array and
therefore breaks migration compatibility with older QEMU
versions. Simply bump the VMState version to 2,
as Aspeed machines are not intended for
virtualization use cases.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260901085238.995968-7-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/misc/aspeed_sbc.h | 2 +-
 hw/misc/aspeed_sbc.c         | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/hw/misc/aspeed_sbc.h b/include/hw/misc/aspeed_sbc.h
index 07c7c22a86ab..eea6e2b27fbf 100644
--- a/include/hw/misc/aspeed_sbc.h
+++ b/include/hw/misc/aspeed_sbc.h
@@ -17,7 +17,7 @@
 #define TYPE_ASPEED_AST10X0_SBC TYPE_ASPEED_SBC "-ast10x0"
 OBJECT_DECLARE_TYPE(AspeedSBCState, AspeedSBCClass, ASPEED_SBC)
 
-#define ASPEED_SBC_NR_REGS (0x93c >> 2)
+#define ASPEED_SBC_NR_REGS (0x1000 >> 2)
 
 #define QSR_AES                     BIT(27)
 #define QSR_RSA1024                 (0x0 << 12)
diff --git a/hw/misc/aspeed_sbc.c b/hw/misc/aspeed_sbc.c
index 1dfcf14e5ba6..7397d9bbf066 100644
--- a/hw/misc/aspeed_sbc.c
+++ b/hw/misc/aspeed_sbc.c
@@ -307,15 +307,15 @@ static void aspeed_sbc_realize(DeviceState *dev, Error **errp)
     }
 
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_sbc_ops, s,
-            TYPE_ASPEED_SBC, 0x1000);
+            TYPE_ASPEED_SBC, ASPEED_SBC_NR_REGS << 2);
 
     sysbus_init_mmio(sbd, &s->iomem);
 }
 
 static const VMStateDescription vmstate_aspeed_sbc = {
     .name = TYPE_ASPEED_SBC,
-    .version_id = 1,
-    .minimum_version_id = 1,
+    .version_id = 2,
+    .minimum_version_id = 2,
     .fields = (const VMStateField[]) {
         VMSTATE_UINT32_ARRAY(regs, AspeedSBCState, ASPEED_SBC_NR_REGS),
         VMSTATE_END_OF_LIST(),
-- 
2.55.0


