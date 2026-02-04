Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D11E95375
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 10:39:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnaBZ-00010f-Jk; Wed, 04 Feb 2026 05:32:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBM-0000co-L7
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vnaBI-00041u-Pt
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 05:32:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770201139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MmDTHq9GqQg3NC8nEsDrj9ODo/57KLqu2rbOXLXX4eE=;
 b=OLPRD+nwI+fuOG11Y8SItiV3ykD5r2O8rytqFdr+mv5QwmilM4M9mbvGWS7lCsfuAjOvuX
 XlctlKf8Ss2oQVVfiw0rall6JFXMQPIGfOfEQ2OEqevfD2bYl6j9dM+FwbDB/QqA82QxqF
 PRaiR5F77ZrtDZBt1POLrvp0Y1+8BgY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-_EzSBn6BPDuUj7YpV18LAw-1; Wed,
 04 Feb 2026 05:32:16 -0500
X-MC-Unique: _EzSBn6BPDuUj7YpV18LAw-1
X-Mimecast-MFC-AGG-ID: _EzSBn6BPDuUj7YpV18LAw_1770201135
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F364D195605F; Wed,  4 Feb 2026 10:32:14 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.44])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6A52F1800666; Wed,  4 Feb 2026 10:32:13 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 16/45] hw/arm/aspeed_ast27x0: Fix EHCI3/4 IRQ routing to GIC
Date: Wed,  4 Feb 2026 11:31:07 +0100
Message-ID: <20260204103136.1795455-17-clg@redhat.com>
In-Reply-To: <20260204103136.1795455-1-clg@redhat.com>
References: <20260204103136.1795455-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

EHCI3 and EHCI4 were missing entries in aspeed_soc_ast2700a1_irqmap,
so their source IRQs were never routed through the INTC OR-gates.

As a result, EHCI3/4 interrupts were not propagated to the GIC,
causing incorrect interrupt behavior for these controllers.

Add EHCI3 and EHCI4 to the IRQ map and route them to the same INTC
group as other shared peripherals, ensuring their interrupts are
properly connected to the GIC.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Fixes: ba27ba302a264117c8b8427f944ced1bed17c438 ("hw/arm: ast27x0: Wire up EHCI controllers")
Reviewed-by: Cédric Le Goater <clg@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20260203020855.1642884-2-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/arm/aspeed_ast27x0.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
index d17f44666112..e16183c3b329 100644
--- a/hw/arm/aspeed_ast27x0.c
+++ b/hw/arm/aspeed_ast27x0.c
@@ -149,6 +149,8 @@ static const int aspeed_soc_ast2700a1_irqmap[] = {
     [ASPEED_DEV_ETH1]      = 196,
     [ASPEED_DEV_ETH2]      = 196,
     [ASPEED_DEV_ETH3]      = 196,
+    [ASPEED_DEV_EHCI3]     = 196,
+    [ASPEED_DEV_EHCI4]     = 196,
     [ASPEED_DEV_PECI]      = 197,
     [ASPEED_DEV_SDHCI]     = 197,
 };
-- 
2.52.0


