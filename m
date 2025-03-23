Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C72EC28B30
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Mar 2025 17:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1twPPN-0003c2-Os; Sun, 23 Mar 2025 13:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twPOg-0002Zo-FT
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:46:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1twPOb-00040m-OZ
 for qemu-devel@nongnu.org; Sun, 23 Mar 2025 13:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742751960;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0zrBPoVoU+HLkajTGv8FNra5OrxM1lKlyJrqR1Ud79Y=;
 b=KW3E+O5ld0z2LtXfC8bd6I6YXSNgddMHwABaML/yrYdOXel4pLkRCe+hG1JHJJ0VnzFpXA
 6ege1/DlDlU0lXdmZWV9zBMVrVont50zJVhwJ/PcCgmMkf3beldVLqCtJ26G0dxaou5bBn
 1kg+LRmdlV41TZ/fFYTaRMazL29/eQA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-402-u14d4ikdP0mZcB1wLHkJzA-1; Sun,
 23 Mar 2025 13:45:59 -0400
X-MC-Unique: u14d4ikdP0mZcB1wLHkJzA-1
X-Mimecast-MFC-AGG-ID: u14d4ikdP0mZcB1wLHkJzA_1742751958
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0E45B180035C; Sun, 23 Mar 2025 17:45:58 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.44.32.3])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 8D9D51956095; Sun, 23 Mar 2025 17:45:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Steven Lee <steven_lee@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 2/3] hw/intc/aspeed: Fix IRQ handler mask check
Date: Sun, 23 Mar 2025 18:45:40 +0100
Message-ID: <20250323174541.406860-3-clg@redhat.com>
In-Reply-To: <20250323174541.406860-1-clg@redhat.com>
References: <20250323174541.406860-1-clg@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

From: Steven Lee <steven_lee@aspeedtech.com>

Updated the IRQ handler mask check to AND with select variable.
This ensures that the interrupt service routine is correctly triggered
for the interrupts within the same irq group.

For example, both `eth0` and the debug UART are handled in `GICINT132`.
Without this fix, the debug console may hang if the `eth0` ISR is not
handled.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
Change-Id: Ic3609eb72218dfd68be6057d78b8953b18828709
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Fixes: d831c5fd8682 ("aspeed/intc: Add AST2700 support")
Link: https://lore.kernel.org/qemu-devel/20250320092543.4040672-2-steven_lee@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/intc/aspeed_intc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/intc/aspeed_intc.c b/hw/intc/aspeed_intc.c
index 3fd417084f5b..f17bf439256a 100644
--- a/hw/intc/aspeed_intc.c
+++ b/hw/intc/aspeed_intc.c
@@ -111,7 +111,7 @@ static void aspeed_intc_set_irq_handler(AspeedINTCState *s,
     outpin_idx = intc_irq->outpin_idx;
     inpin_idx = intc_irq->inpin_idx;
 
-    if (s->mask[inpin_idx] || s->regs[status_reg]) {
+    if ((s->mask[inpin_idx] & select) || (s->regs[status_reg] & select)) {
         /*
          * a. mask is not 0 means in ISR mode
          * sources interrupt routine are executing.
-- 
2.49.0


