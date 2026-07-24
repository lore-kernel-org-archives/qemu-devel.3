Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0F49C531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 09:48:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnCVs-0003HT-Vn; Fri, 24 Jul 2026 05:48:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVr-0003GR-Rb; Fri, 24 Jul 2026 05:48:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wnCVq-00059U-B3; Fri, 24 Jul 2026 05:48:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784886463; bh=Ed7IB/Ssxjee4lM+vHXFTzTBO/kOLZPEpfJwG/DnMVs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=n0u3Dgt4+Sr0PSrJlgH0T48Ujt6fBweSt3+73NCcqyzz+FtEfYe7+MUpWuUprDhSR
 9/VhtiwNOgL5yTi+0jFabpbkVM0HBW01SaZ91Bq8jxIIS9pT+7l1d/aknBCjGzdPWp
 pcZaExeTX1TtjzVlxU8pqdwt7K3YYl4VB42hJ5Hk+DpMUxo9F2V+HGe5SqOTN6xMfv
 dLYNycVPzkGyC79XMrEpDlAls8yCIe+WfGUpUkRcEpEyCtnmGws+1LlF99bReKDX7a
 QQHIGX7OH4Em6IuLStDti6qCvERHp1wyAP/LmFK3sCwXDkZ+GhW0aOAzuF8IsXihYd
 +sEi9pRFlQllw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 657501C4576;
 Fri, 24 Jul 2026 12:47:43 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5FAB23F46B5;
 Fri, 24 Jul 2026 12:48:04 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 4BF401854A; Fri, 24 Jul 2026 12:47:54 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Evgeny Kolmakov <randomjack94dev@gmail.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 5/7] hw/hyperv/vmbus: Use QEMU_LOCK_GUARD()
Date: Fri, 24 Jul 2026 12:47:47 +0300
Message-ID: <20260724094754.1053970-6-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260724094754.1053970-1-mjt@tls.msk.ru>
References: <20260724094754.1053970-1-mjt@tls.msk.ru>
MIME-Version: 1.0
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Evgeny Kolmakov <randomjack94dev@gmail.com>

Replace manual qemu_mutex_(un)lock() calls with
QEMU_LOCK_GUARD() to remove 'goto out' code

Signed-off-by: Evgeny Kolmakov <randomjack94dev@gmail.com>
Reviewed-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/hyperv/vmbus.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/hw/hyperv/vmbus.c b/hw/hyperv/vmbus.c
index c5259d1a764..ab99f082d10 100644
--- a/hw/hyperv/vmbus.c
+++ b/hw/hyperv/vmbus.c
@@ -1525,14 +1525,12 @@ static VMBusChannel *find_channel(VMBus *vmbus, uint32_t id)
 static int enqueue_incoming_message(VMBus *vmbus,
                                     const struct hyperv_post_message_input *msg)
 {
-    int ret = 0;
     uint8_t idx, prev_size;
 
-    qemu_mutex_lock(&vmbus->rx_queue_lock);
+    QEMU_LOCK_GUARD(&vmbus->rx_queue_lock);
 
     if (vmbus->rx_queue_size == HV_MSG_QUEUE_LEN) {
-        ret = -ENOBUFS;
-        goto out;
+        return -ENOBUFS;
     }
 
     prev_size = vmbus->rx_queue_size;
@@ -1544,9 +1542,7 @@ static int enqueue_incoming_message(VMBus *vmbus,
     if (!prev_size) {
         vmbus_resched(vmbus);
     }
-out:
-    qemu_mutex_unlock(&vmbus->rx_queue_lock);
-    return ret;
+    return 0;
 }
 
 static uint16_t vmbus_recv_message(const struct hyperv_post_message_input *msg,
@@ -2097,10 +2093,10 @@ static void process_message(VMBus *vmbus)
     void *msgdata;
     uint32_t msglen;
 
-    qemu_mutex_lock(&vmbus->rx_queue_lock);
+    QEMU_LOCK_GUARD(&vmbus->rx_queue_lock);
 
     if (!vmbus->rx_queue_size) {
-        goto unlock;
+        return;
     }
 
     hv_msg = &vmbus->rx_queue[vmbus->rx_queue_head];
@@ -2149,8 +2145,6 @@ out:
     vmbus->rx_queue_head %= HV_MSG_QUEUE_LEN;
 
     vmbus_resched(vmbus);
-unlock:
-    qemu_mutex_unlock(&vmbus->rx_queue_lock);
 }
 
 static const struct {
-- 
2.47.3


