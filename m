Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D2CC28B2F
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:53:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH5K-0000uX-Dd; Sun, 09 Mar 2025 09:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH55-0008Ua-Ra
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH51-0002ub-Bi
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kSI4OOYTK441lwBQvB+VVbjfgVx14HM7h4TjjyU4yME=;
 b=bXwIBGWT8d2uIVc3xhRy/+CP6kGDLfqO1JcqTAamegjCKtNihFPZiV2ftzws/F/ynAA5IY
 99aqgx+6KxLBqDmKYjfV/rEnMsBhwETys8Y/qkiftoV48kVgAW2FAEeSsiJGRLAW0uiHkm
 5N+uv7W44hX8OnEebvrrkqMx1TJH+LA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-594-PUK10XofOoG72XCEXwxprw-1; Sun,
 09 Mar 2025 09:52:31 -0400
X-MC-Unique: PUK10XofOoG72XCEXwxprw-1
X-Mimecast-MFC-AGG-ID: PUK10XofOoG72XCEXwxprw_1741528350
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 59A331800EC5; Sun,  9 Mar 2025 13:52:30 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8EC981956094; Sun,  9 Mar 2025 13:52:28 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 22/46] hw/intc/aspeed: Reduce regs array size by adding a
 register sub-region
Date: Sun,  9 Mar 2025 14:51:06 +0100
Message-ID: <20250309135130.545764-23-clg@redhat.com>
In-Reply-To: <20250309135130.545764-1-clg@redhat.com>
References: <20250309135130.545764-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Jamin Lin <jamin_lin@aspeedtech.com>

Currently, the size of the "regs" array is 0x2000, which is too large. So far,
it only uses "GICINT128 to `GICINT134", and the offsets from 0 to 0x1000 are
unused. To save code size and avoid mapping large unused gaps, update to only
map the useful set of registers:

INTC register [0x1000 – 0x1804]

Update "reg_size" to 0x808. Introduce a new class attribute "reg_offset" to set
the start offset of a "INTC" sub-region. Set the "reg_offset" to 0x1000 for INTC
registers.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-6-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h |  1 +
 hw/intc/aspeed_intc.c         | 50 ++++++++++++++++++++---------------
 2 files changed, 30 insertions(+), 21 deletions(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index ec4936b3f486..208e764c4ade 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -42,6 +42,7 @@ struct AspeedINTCClass {
     uint32_t num_ints;
     uint64_t mem_size;
     uint64_t nr_regs;
+    uint64_t reg_offset;
 };
 
 #endif /* ASPEED_INTC_H */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 134922e46fdc..d684b4bb4fec 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -14,25 +14,31 @@
 #include "hw/registerfields.h"
 #include "qapi/error.h"
 
-/* INTC Registers */
-REG32(GICINT128_EN,         0x1000)
-REG32(GICINT128_STATUS,     0x1004)
-REG32(GICINT129_EN,         0x1100)
-REG32(GICINT129_STATUS,     0x1104)
-REG32(GICINT130_EN,         0x1200)
-REG32(GICINT130_STATUS,     0x1204)
-REG32(GICINT131_EN,         0x1300)
-REG32(GICINT131_STATUS,     0x1304)
-REG32(GICINT132_EN,         0x1400)
-REG32(GICINT132_STATUS,     0x1404)
-REG32(GICINT133_EN,         0x1500)
-REG32(GICINT133_STATUS,     0x1504)
-REG32(GICINT134_EN,         0x1600)
-REG32(GICINT134_STATUS,     0x1604)
-REG32(GICINT135_EN,         0x1700)
-REG32(GICINT135_STATUS,     0x1704)
-REG32(GICINT136_EN,         0x1800)
-REG32(GICINT136_STATUS,     0x1804)
+/*
+ * INTC Registers
+ *
+ * values below are offset by - 0x1000 from datasheet
+ * because its memory region is start at 0x1000
+ *
+ */
+REG32(GICINT128_EN,         0x000)
+REG32(GICINT128_STATUS,     0x004)
+REG32(GICINT129_EN,         0x100)
+REG32(GICINT129_STATUS,     0x104)
+REG32(GICINT130_EN,         0x200)
+REG32(GICINT130_STATUS,     0x204)
+REG32(GICINT131_EN,         0x300)
+REG32(GICINT131_STATUS,     0x304)
+REG32(GICINT132_EN,         0x400)
+REG32(GICINT132_STATUS,     0x404)
+REG32(GICINT133_EN,         0x500)
+REG32(GICINT133_STATUS,     0x504)
+REG32(GICINT134_EN,         0x600)
+REG32(GICINT134_STATUS,     0x604)
+REG32(GICINT135_EN,         0x700)
+REG32(GICINT135_STATUS,     0x704)
+REG32(GICINT136_EN,         0x800)
+REG32(GICINT136_STATUS,     0x804)
 
 #define GICINT_STATUS_BASE     R_GICINT128_STATUS
 
@@ -298,7 +304,8 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
                           TYPE_ASPEED_INTC ".regs", aic->nr_regs << 2);
 
-    memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
+    memory_region_add_subregion(&s->iomem_container, aic->reg_offset,
+                                &s->iomem);
 
     qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_ints);
 
@@ -348,7 +355,8 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     aic->num_lines = 32;
     aic->num_ints = 9;
     aic->mem_size = 0x4000;
-    aic->nr_regs = 0x2000 >> 2;
+    aic->nr_regs = 0x808 >> 2;
+    aic->reg_offset = 0x1000;
 }
 
 static const TypeInfo aspeed_2700_intc_info = {
-- 
2.48.1


