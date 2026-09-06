Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F45C79F85
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Sep 2026 17:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3GOH-0003Ox-7Z; Sun, 06 Sep 2026 13:10:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOE-0003O9-8B
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1x3GOC-0008WQ-Ma
 for qemu-devel@nongnu.org; Sun, 06 Sep 2026 13:10:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788714644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KYJNHvtdPWfDLazPopsDYRtzkPqnwpcn6vzjJPRUIrU=;
 b=aBVqCvVkCvYF99aw9YQCtT7Fz6e0BEki1Xg4jG4X0VDblAD9Zyt146tdD3ohldOiyt1jms
 2lYsREAicRYtxwptdEGdzjkvo/p5HCtZqiGINcPeE3s7iHrWzZuWa7fu4W2Fa+cRnw1ac+
 RoewCqmInQZEpfDsOQcEy5loHpCOTxc=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-6dvLfLoAM5abE1aSUeSJXw-1; Sun,
 06 Sep 2026 13:10:40 -0400
X-MC-Unique: 6dvLfLoAM5abE1aSUeSJXw-1
X-Mimecast-MFC-AGG-ID: 6dvLfLoAM5abE1aSUeSJXw_1788714639
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5E5901956066; Sun,  6 Sep 2026 17:10:39 +0000 (UTC)
Received: from yukon.redhat.com (unknown [10.44.32.24])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B648B1955F06; Sun,  6 Sep 2026 17:10:37 +0000 (UTC)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>
Subject: [PULL 05/40] hw/usb/hcd-ehci: Handle get_dwords() failures in async
 writeback
Date: Sun,  6 Sep 2026 19:09:46 +0200
Message-ID: <20260906171021.26568-6-clg@redhat.com>
In-Reply-To: <20260906171021.26568-1-clg@redhat.com>
References: <20260906171021.26568-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Coverity reports that ehci_writeback_async_complete_packet() ignores
the return value of get_dwords() when reading the QH and qTD.

Handle read failures in the same way as QH and qTD verification
failures by freeing the packet and returning early.

Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
Resolves: Coverity CID 1685236
Fixes: 2b3de6ada5d ("ehci: writeback_async_complete_packet: verify qh and qtd")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Link: https://lore.kernel.org/qemu-devel/20260817055318.3826428-4-jamin_lin@aspeedtech.com
Signed-off-by: Cédric Le Goater <clg@redhat.com>
---
 hw/usb/hcd-ehci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 5187ecc7e4f9..f371e567f38b 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -527,11 +527,11 @@ static void ehci_writeback_async_complete_packet(EHCIPacket *p)
     /* Verify the qh + qtd, like we do when going through fetchqh & fetchqtd */
     memset(&qh, 0, sizeof(qh));
     memset(&qtd, 0, sizeof(qtd));
-    get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
-               (uint32_t *) &qh, ehci_qh_dwords(q->ehci));
-    get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
-               (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci));
-    if (!ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
+    if (!get_dwords(q->ehci, NLPTR_GET(q->qhaddr),
+                    (uint32_t *) &qh, ehci_qh_dwords(q->ehci)) ||
+        !get_dwords(q->ehci, NLPTR_GET(q->qtdaddr),
+                    (uint32_t *) &qtd, ehci_qtd_dwords(q->ehci)) ||
+        !ehci_verify_qh(q, &qh) || !ehci_verify_qtd(p, &qtd)) {
         p->async = EHCI_ASYNC_INITIALIZED;
         ehci_free_packet(p);
         return;
-- 
2.55.0


