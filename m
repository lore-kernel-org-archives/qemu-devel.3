Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D96F46102
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2026 12:57:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w4epi-0000K1-T7; Mon, 23 Mar 2026 08:56:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4epB-0008Sw-82
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:56:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1w4ep9-00063h-Ij
 for qemu-devel@nongnu.org; Mon, 23 Mar 2026 08:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774270562;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zulI+hRCZwLd9hKIUXsHFy0DOV2UeF6F+JTY28uBAHY=;
 b=QW28RB9ibNZgFg0C5YlBgtA1KPtTPAohMq3qmpGnwq9w7fjs7j+88mKjyjrViV9+2jr2ot
 /fyYl65A9mgPXm5n9mnZIJa/aAhKiVaRUBmbcdH1/WVfu1fSBX6ePDbxEjEwgHQ+pH6q1r
 64XJrp82xT9ac/AvWEvR5SblJss8oaE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-213-zCrxi5S2NQ2XCV2ATF92Tg-1; Mon,
 23 Mar 2026 08:55:57 -0400
X-MC-Unique: zCrxi5S2NQ2XCV2ATF92Tg-1
X-Mimecast-MFC-AGG-ID: zCrxi5S2NQ2XCV2ATF92Tg_1774270556
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F19D1956046; Mon, 23 Mar 2026 12:55:56 +0000 (UTC)
Received: from corto.redhat.com (unknown [10.45.224.42])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 27A2F19560B7; Mon, 23 Mar 2026 12:55:53 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 2/3] ftgmac100: Improve DMA error handling
Date: Mon, 23 Mar 2026 13:55:44 +0100
Message-ID: <20260323125545.577653-3-clg@redhat.com>
In-Reply-To: <20260323125545.577653-1-clg@redhat.com>
References: <20260323125545.577653-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Currently, DMA memory operation errors in the ftgmac100 model are not
all tested and this can lead to a guest-triggerable denial of service
as described in https://gitlab.com/qemu-project/qemu/-/work_items/3335.

To fix this, check the return value of ftgmac100_write_bd() in the TX
path and exit the TX loop on error to prevent further processing. In
the event of a DMA error, also set FTGMAC100_INT_AHB_ERR interrupt
flag as appropriate.

The FTGMAC100_INT_AHB_ERR interrupt status bit only applies to the
AST2400 SoC; on newer Aspeed SoCs, it is a reserved bit.
Nevertheless, since it is supported by the Linux driver and it should
be safe to use in the QEMU implementation across all SoCs.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3335
Reviewed-by: Jamin Lin <jamin_lin@aspeedtech.com>
Link: https://lore.kernel.org/qemu-devel/20260322215732.387383-3-clg@redhat.com
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/net/ftgmac100.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
index d29f7dcd171b..2f05bba11d01 100644
--- a/hw/net/ftgmac100.c
+++ b/hw/net/ftgmac100.c
@@ -624,7 +624,10 @@ static void ftgmac100_do_tx(FTGMAC100State *s, uint64_t tx_ring,
         bd.des0 &= ~FTGMAC100_TXDES0_TXDMA_OWN;
 
         /* Write back the modified descriptor.  */
-        ftgmac100_write_bd(&bd, addr);
+        if (ftgmac100_write_bd(&bd, addr)) {
+            s->isr |= FTGMAC100_INT_AHB_ERR;
+            break;
+        }
         /* Advance to the next descriptor.  */
         if (bd.des0 & s->txdes0_edotr) {
             addr = tx_ring;
@@ -1134,7 +1137,10 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
             bd.des0 |= flags | FTGMAC100_RXDES0_LRS;
             s->isr |= FTGMAC100_INT_RPKT_BUF;
         }
-        ftgmac100_write_bd(&bd, addr);
+        if (ftgmac100_write_bd(&bd, addr)) {
+            s->isr |= FTGMAC100_INT_AHB_ERR;
+            break;
+        }
         if (bd.des0 & s->rxdes0_edorr) {
             addr = s->rx_ring;
         } else {
-- 
2.53.0


