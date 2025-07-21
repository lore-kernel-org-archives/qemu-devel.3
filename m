Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93CF0C83F26
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 16:28:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udtKO-0001r4-4N; Mon, 21 Jul 2025 12:25:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJO-0006T0-MK
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1udtJM-0001hk-CE
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 12:24:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753115058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O9WGDuT1CFZxwfiq/QihXJzI9C556RMFzq4pAzWArqo=;
 b=I+2HZXgvZqOh+mOLKwn85mf6f+lSL96YkeEWx3hGB1j0LDCv5SetL6d3L9y29zvbAA//Gr
 K1ygqlfjDhorHpPyKFYXQnynPHD2IthE3O2q0Rr/dVjBx01wrE+ESRpdTTTlwOdMHv0dJc
 nV9OvDSmkhRjEjw8YLhsi2cRyCHhY1o=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-MtEoBqCQOFiqa8mE1yqCJA-1; Mon,
 21 Jul 2025 12:24:15 -0400
X-MC-Unique: MtEoBqCQOFiqa8mE1yqCJA-1
X-Mimecast-MFC-AGG-ID: MtEoBqCQOFiqa8mE1yqCJA_1753115054
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2DBDC1800284; Mon, 21 Jul 2025 16:24:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.19])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 34B84195608D; Mon, 21 Jul 2025 16:24:11 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 34/50] ppc/xive: tctx_accept only lower irq line if an
 interrupt was presented
Date: Mon, 21 Jul 2025 18:22:17 +0200
Message-ID: <20250721162233.686837-35-clg@redhat.com>
In-Reply-To: <20250721162233.686837-1-clg@redhat.com>
References: <20250721162233.686837-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.926,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Nicholas Piggin <npiggin@gmail.com>

The relationship between an interrupt signaled in the TIMA and the QEMU
irq line to the processor to be 1:1, so they should be raised and
lowered together and "just in case" lowering should be avoided (it could
mask

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Glenn Miles <milesg@linux.ibm.com>
Tested-by: Gautam Menghani <gautam@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20250512031100.439842-35-npiggin@gmail.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/xive.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index 119a178f2e23..db26dae7dbf4 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -95,8 +95,6 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
     g_assert(tctx->regs[TM_QW2_HV_POOL + TM_PIPR] == 0);
     g_assert(tctx->regs[TM_QW2_HV_POOL + TM_CPPR] == 0);
 
-    qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
-
     if (xive_nsr_indicates_exception(sig_ring, nsr)) {
         uint8_t cppr = sig_regs[TM_PIPR];
         uint8_t ring;
@@ -117,6 +115,7 @@ uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8_t sig_ring)
 
         /* Clear the exception from NSR */
         sig_regs[TM_NSR] = 0;
+        qemu_irq_lower(xive_tctx_output(tctx, sig_ring));
 
         trace_xive_tctx_accept(tctx->cs->cpu_index, ring,
                                regs[TM_IPB], sig_regs[TM_PIPR],
-- 
2.50.1


