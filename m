Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A7AC35FF4
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 13:53:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trH58-00004q-Bd; Sun, 09 Mar 2025 09:52:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4y-0008RB-56
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1trH4t-0002lw-Ei
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 09:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741528346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i35CW3OHelPcDwfPqpO5ZwM+mKjTY1hLS4ccNpZvm4s=;
 b=VVBNNxZlCKZYWRJ7bSqy9WRHVwrbSGaU+gqA4mQXGzVNaKKP+zElMM/bIIJDhjsXT19FGN
 6R8hUUmGt78OBSDG6wdUyTSu12LJHSwN+0Zu7n5H3l/gjb+acyiACCt6tV15tRKSGRu/l8
 Gr5Zz8p7+YpVvp+m1lPysLl9Yl1N74g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-pAKdj4_8PU2vRkM5pPo_LA-1; Sun,
 09 Mar 2025 09:52:22 -0400
X-MC-Unique: pAKdj4_8PU2vRkM5pPo_LA-1
X-Mimecast-MFC-AGG-ID: pAKdj4_8PU2vRkM5pPo_LA_1741528341
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A4126180035D; Sun,  9 Mar 2025 13:52:21 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.17])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 13AD11956094; Sun,  9 Mar 2025 13:52:19 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 18/46] hw/intc/aspeed: Support setting different memory size
Date: Sun,  9 Mar 2025 14:51:02 +0100
Message-ID: <20250309135130.545764-19-clg@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

According to the AST2700 datasheet, the INTC(CPU DIE) controller has 16KB
(0x4000) of register space, and the INTCIO (I/O DIE) controller has 1KB (0x400)
of register space.

Introduced a new class attribute "mem_size" to set different memory sizes for
the INTC models in AST2700.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20250307035945.3698802-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 include/hw/intc/aspeed_intc.h | 3 +++
 hw/intc/aspeed_intc.c         | 9 ++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/hw/intc/aspeed_intc.h b/include/hw/intc/aspeed_intc.h
index 18cb43476cd7..03324f05ab58 100644
--- a/include/hw/intc/aspeed_intc.h
+++ b/include/hw/intc/aspeed_intc.h
@@ -25,6 +25,8 @@ struct AspeedINTCState {
 
     /*< public >*/
     MemoryRegion iomem;
+    MemoryRegion iomem_container;
+
     uint32_t regs[ASPEED_INTC_NR_REGS];
     OrIRQState orgates[ASPEED_INTC_NR_INTS];
     qemu_irq output_pins[ASPEED_INTC_NR_INTS];
@@ -39,6 +41,7 @@ struct AspeedINTCClass {
 
     uint32_t num_lines;
     uint32_t num_ints;
+    uint64_t mem_size;
 };
 
 #endif /* ASPEED_INTC_H */
diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 126b711b9430..033b574c1e24 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -302,10 +302,16 @@ static void aspeed_intc_realize(DeviceState *dev, Error **errp)
     AspeedINTCClass *aic = ASPEED_INTC_GET_CLASS(s);
     int i;
 
+    memory_region_init(&s->iomem_container, OBJECT(s),
+            TYPE_ASPEED_INTC ".container", aic->mem_size);
+
+    sysbus_init_mmio(sbd, &s->iomem_container);
+
     memory_region_init_io(&s->iomem, OBJECT(s), &aspeed_intc_ops, s,
                           TYPE_ASPEED_INTC ".regs", ASPEED_INTC_NR_REGS << 2);
 
-    sysbus_init_mmio(sbd, &s->iomem);
+    memory_region_add_subregion(&s->iomem_container, 0x0, &s->iomem);
+
     qdev_init_gpio_in(dev, aspeed_intc_set_irq, aic->num_ints);
 
     for (i = 0; i < aic->num_ints; i++) {
@@ -344,6 +350,7 @@ static void aspeed_2700_intc_class_init(ObjectClass *klass, void *data)
     dc->desc = "ASPEED 2700 INTC Controller";
     aic->num_lines = 32;
     aic->num_ints = 9;
+    aic->mem_size = 0x4000;
 }
 
 static const TypeInfo aspeed_2700_intc_info = {
-- 
2.48.1


