Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4A5606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tls.msk.ru header.i=@tls.msk.ru header.a=rsa-sha256 header.s=202602 header.b=N3q74EoZ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWowK-0005My-PS; Fri, 27 Nov 2026 00:56:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWow9-0004nS-1R; Fri, 27 Nov 2026 00:55:57 -0500
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1xWow4-0000Ya-KT; Fri, 27 Nov 2026 00:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1795758873; bh=dCZOH6pZF5PiJWqBqXa1SaZq91mUz+pXWSte8PXEX6M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=N3q74EoZN971l84Vg5Oprt6V6MdH9CyE3uEI6xTVCiJQWpZ1jMJpt/ZzBjStHAl3I
 k2fO8zceXsVTOqQQvIvSGyRbY+xLq/KCiCzElggYnZwejYNa/rtDdrLxPJhyLqM5SD
 UX1zjO2wpAhWIRCz7HvH3HxMvctOC2cz3tw6YlWSmyHcgRiwtfr+ySBXujB6diq+WN
 6GxdbaZaANshkL3XeXkhHP0eD/RrGcjybnpam2sSqlJzVbPv1aaIPfQby1nSZxx9ct
 Suh8Bda+cRQ0RtHQ9od4vl/+LAsTMkS8WhZ9HGUKD906vKw86XVpdNDTwNlLpo2OTz
 l/4lvEWB4vz5g==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D68E91EA2D7;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D4458469914;
 Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C8F30CF234; Fri, 27 Nov 2026 08:54:33 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Markku=20Ahvenj=C3=A4rvi?= <mankku@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.16 v2 079/140] hw/nvme: fix missed CQ updates
Date: Fri, 27 Nov 2026 08:53:05 +0300
Message-ID: <20261127055421.39015-20-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
References: <qemu-stable-10.0.16-20261127085304@cover.tls.msk.ru>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Markku Ahvenjärvi <mankku@gmail.com>

When doorbell buffers are enabled, CQ head updates may race with
completion posting. When a CQ doorbell leaves pending completions, the
event index may become stale and cause the guest to suppress the next
MMIO doorbell write. QEMU may then fail to observe that the CQ has
been drained. With legacy INTx, this can leave the interrupt asserted
indefinitely and cause an interrupt storm.

Update the CQ event index as part of doorbell processing to ensure that
subsequent head updates notify QEMU.

Cc: qemu-stable@nongnu.org
Fixes: 3f7fe8de3d49 ("hw/nvme: Implement shadow doorbell buffer support")
Fixes: 2e53b0b45024 ("hw/nvme: Use ioeventfd to handle doorbell updates")
Signed-off-by: Markku Ahvenjärvi <mankku@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit c5d75e36cd729131237ffcfc3a52a72c871c6aa7)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 94f52cb70f8..0077984fcd8 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -4747,6 +4747,7 @@ static void nvme_cq_notifier(EventNotifier *e)
         return;
     }
 
+    nvme_update_cq_eventidx(cq);
     nvme_update_cq_head(cq);
 
     if (cq->tail == cq->head) {
@@ -8220,6 +8221,8 @@ static void nvme_process_db(NvmeCtrl *n, hwaddr addr, int val)
             }
 
             nvme_irq_deassert(n, cq);
+        } else if (n->dbbuf_enabled) {
+            nvme_update_cq_eventidx(cq);
         }
     } else {
         /* Submission queue doorbell write */
-- 
2.47.3


