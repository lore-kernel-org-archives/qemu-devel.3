Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1572D132A6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 10:16:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7u7N-0000jc-7w; Mon, 04 Nov 2024 05:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u7F-0000i3-C4
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1t7u7D-0006Xx-Ub
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 05:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730715318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KwxKjafKDnKBkadg0NOHGWyqqTRQcVmPU7A81oAJBiI=;
 b=cOvHolq38GU2ICFdSBPfqnHvUUKSOyOTXmc1CV45DXpEQSAzuL0j7rVdnI5wNjw7PdPvQp
 wpwxBCAC4fi4X1PrY2ZXMVIenaFvoKOwK6TndhMuwUBqRGOjQ5OqvWtATx7o4gCSNone9M
 ItJrQSAeFoq1R8Wgy2Tjl3wNzpDr8V0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-681-5M6F8JWJO6ud02TEs7EC2Q-1; Mon,
 04 Nov 2024 05:15:16 -0500
X-MC-Unique: 5M6F8JWJO6ud02TEs7EC2Q-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED5F41944D3C; Mon,  4 Nov 2024 10:15:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.39.192.67])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8F59F1956052; Mon,  4 Nov 2024 10:15:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 04/10] hw/arm/aspeed_ast27x0: Avoid hardcoded '256' in IRQ
 calculation
Date: Mon,  4 Nov 2024 11:14:55 +0100
Message-ID: <20241104101501.2487001-5-clg@redhat.com>
In-Reply-To: <20241104101501.2487001-1-clg@redhat.com>
References: <20241104101501.2487001-1-clg@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Peter Maydell <peter.maydell@linaro.org>

When calculating the index into the GIC's GPIO array for per-CPU
interrupts, we have to start with the number of SPIs.  The code
currently hard-codes this to 'NUM_IRQS = 256'.  However the number of
SPIs is set separately and implicitly by the value of
AST2700_MAX_IRQ, which is the number of SPIs plus 32 (since it is
what we set the GIC num-irq property to).

Define AST2700_MAX_IRQ as the total number of SPIs; this brings
AST2700 into line with AST2600, which defines AST2600_MAX_IRQ as the
number of SPIs not including the 32 internal interrupts.  We can then
use AST2700_MAX_IRQ instead of the hardcoded 256.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 hw/arm/aspeed_ast27x0.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index 5638a7a5781b..7b2464409521 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -66,7 +66,7 @@ static const hwaddr aspeed_soc_ast2700_memmap[] = {
     [ASPEED_DEV_GPIO]      =  0x14C0B000,
 };
 
-#define AST2700_MAX_IRQ 288
+#define AST2700_MAX_IRQ 256
 
 /* Shared Peripheral Interrupt values below are offset by -32 from datasheet */
 static const int aspeed_soc_ast2700_irqmap[] = {
@@ -403,7 +403,7 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
     gicdev = DEVICE(&a->gic);
     qdev_prop_set_uint32(gicdev, "revision", 3);
     qdev_prop_set_uint32(gicdev, "num-cpu", sc->num_cpus);
-    qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ);
+    qdev_prop_set_uint32(gicdev, "num-irq", AST2700_MAX_IRQ + GIC_INTERNAL);
 
     redist_region_count = qlist_new();
     qlist_append_int(redist_region_count, sc->num_cpus);
@@ -417,8 +417,7 @@ static bool aspeed_soc_ast2700_gic_realize(DeviceState *dev, Error **errp)
 
     for (i = 0; i < sc->num_cpus; i++) {
         DeviceState *cpudev = DEVICE(&a->cpu[i]);
-        int NUM_IRQS = 256;
-        int intidbase = NUM_IRQS + i * GIC_INTERNAL;
+        int intidbase = AST2700_MAX_IRQ + i * GIC_INTERNAL;
 
         const int timer_irq[] = {
             [GTIMER_PHYS] = ARCH_TIMER_NS_EL1_IRQ,
-- 
2.47.0


