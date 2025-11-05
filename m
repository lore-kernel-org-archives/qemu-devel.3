Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 646C4CCF9F8
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Nov 2025 20:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGkYK-0002ae-5b; Wed, 05 Nov 2025 15:56:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.repko@syntacore.com>)
 id 1vGjcK-0005LC-7F; Wed, 05 Nov 2025 14:56:28 -0500
Received: from m.syntacore.com ([178.249.69.228])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <i.repko@syntacore.com>)
 id 1vGjcI-0000uk-Ii; Wed, 05 Nov 2025 14:56:27 -0500
Received: from MRN-SC-KSMG-01.corp.syntacore.com (localhost [127.0.0.1])
 by m.syntacore.com (Postfix) with ESMTP id CB4EC1A0004;
 Wed,  5 Nov 2025 19:56:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 m.syntacore.com CB4EC1A0004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=syntacore.com; s=m;
 t=1762372575; bh=G1q86/DgqPNjCWBa7TyF1koxVFpglV1ohFFAZyKfyBs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
 b=HZkAzBDjqtvmZxgoj7TCx8vxmWwbZnW9IkwQpg2uvNMkj0WIljLmgs/RUTBEGAsS9
 YrhEY9jFoLaLc69PIrocOBwUgj3Ty+GdAEcDCQvPs9kaxzNxN6pp7XJSxlQPsOXUvd
 G8HRPoDAKHHzjJLa5bMJfRr92LztP34dn+xB8UWJL6heSWEHAgsJM0vbYBHwfrgnI1
 r7uV1ppGgUIHtKS1119OyqV/8GfmgmBgz93KDFz0wnWCWzohKDxFg8KPZF8b4vdhAv
 Rmfu79lzWmiV0XR+zVBBI4E0HQHyGv+91JCEL+wWTzT6heJ7bl6C6ba+JddZyTRt0Y
 1FLGw3pXofpZA==
Received: from S-SC-EXCH-01.corp.syntacore.com (mail.syntacore.com
 [10.76.202.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by m.syntacore.com (Postfix) with ESMTPS;
 Wed,  5 Nov 2025 19:56:15 +0000 (UTC)
Received: from NB-8361.lan (172.27.13.83) by S-SC-EXCH-01.corp.syntacore.com
 (10.76.202.20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 5 Nov
 2025 22:55:22 +0300
From: Ilya Repko <i.repko@syntacore.com>
To: 
CC: Ilya Repko <i.repko@syntacore.com>, "Edgar E. Iglesias"
 <edgar.iglesias@gmail.com>, Alistair Francis <alistair@alistair23.me>, Peter
 Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, "open
 list:Xilinx Zynq" <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>
Subject: [PATCH] Revert "hw/net: Fix the transmission return size"
Date: Wed, 5 Nov 2025 22:55:30 +0300
Message-ID: <20251105195532.347555-1-i.repko@syntacore.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.27.13.83]
X-ClientProxiedBy: S-SC-EXCH-01.corp.syntacore.com (10.76.202.20) To
 S-SC-EXCH-01.corp.syntacore.com (10.76.202.20)
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310,
 bases: 2025/11/05 19:22:00 #27886012
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 5
Received-SPF: pass client-ip=178.249.69.228;
 envelope-from=i.repko@syntacore.com; helo=m.syntacore.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Nov 2025 15:56:12 -0500
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

This reverts commit 3a6d374b754b4b345195ff6846eeaffedc96a7c5.

During axienet_eth_rx_notify(), s->rxpos is modified to indicate how much
data was pushed to AXI DMA. eth_rx() would then return this value.
If at 0, network subsystem would consider packet reception as failed
and put the packet in a queue for later.

Before we attempt to push packet data to AXI DMA, the packet is stored
in s->rxmem buffer. If an attempt to push data fails, we will reattempt
to deliver it from s->rxmem buffer once s2mm stream gets a new descriptor.
s->rxmem would not be overwritten by a subsequent eth_rx() call, because
eth_can_rx() protects it in case it has any data at all. Leaving the packet
in a NetQueue though effectively duplicates it.

Therefore, eth_rx() must indicate successful packet reception in case
data push to AXI DMA fails.

Signed-off-by: Ilya Repko <i.repko@syntacore.com>
---
 hw/net/xilinx_axienet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index 31e7708082..101b3f260a 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -867,7 +867,7 @@ static ssize_t eth_rx(NetClientState *nc, const uint8_t *buf, size_t size)
     axienet_eth_rx_notify(s);
 
     enet_update_irq(s);
-    return s->rxpos;
+    return size;
 }
 
 static size_t
-- 
2.51.1


