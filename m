Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E3CCCF884D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2024 16:07:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swknZ-0002Xg-HJ; Fri, 04 Oct 2024 12:04:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swknS-0002OP-Qb; Fri, 04 Oct 2024 12:04:50 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1swknR-0001cD-8x; Fri, 04 Oct 2024 12:04:50 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8727C95573;
 Fri,  4 Oct 2024 19:03:30 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id C13E014D981;
 Fri,  4 Oct 2024 19:03:32 +0300 (MSK)
Received: (nullmailer pid 1282545 invoked by uid 1000);
 Fri, 04 Oct 2024 16:03:32 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 14/23] remote: Remove unused remote_iohub_finalize
Date: Fri,  4 Oct 2024 19:03:22 +0300
Message-Id: <20241004160331.1282441-15-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004160331.1282441-1-mjt@tls.msk.ru>
References: <20241004160331.1282441-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: "Dr. David Alan Gilbert" <dave@treblig.org>

remote_iohub_finalize has never been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
Reviewed-by: Jagannathan Raman <jag.raman@oracle.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 hw/remote/iohub.c         | 13 -------------
 include/hw/remote/iohub.h |  1 -
 2 files changed, 14 deletions(-)

diff --git a/hw/remote/iohub.c b/hw/remote/iohub.c
index 40dfee4bad..988d3285cc 100644
--- a/hw/remote/iohub.c
+++ b/hw/remote/iohub.c
@@ -33,19 +33,6 @@ void remote_iohub_init(RemoteIOHubState *iohub)
     }
 }
 
-void remote_iohub_finalize(RemoteIOHubState *iohub)
-{
-    int pirq;
-
-    for (pirq = 0; pirq < REMOTE_IOHUB_NB_PIRQS; pirq++) {
-        qemu_set_fd_handler(event_notifier_get_fd(&iohub->resamplefds[pirq]),
-                            NULL, NULL, NULL);
-        event_notifier_cleanup(&iohub->irqfds[pirq]);
-        event_notifier_cleanup(&iohub->resamplefds[pirq]);
-        qemu_mutex_destroy(&iohub->irq_level_lock[pirq]);
-    }
-}
-
 int remote_iohub_map_irq(PCIDevice *pci_dev, int intx)
 {
     return pci_dev->devfn;
diff --git a/include/hw/remote/iohub.h b/include/hw/remote/iohub.h
index 6a8444f9a9..09ee6c77b6 100644
--- a/include/hw/remote/iohub.h
+++ b/include/hw/remote/iohub.h
@@ -37,6 +37,5 @@ void remote_iohub_set_irq(void *opaque, int pirq, int level);
 void process_set_irqfd_msg(PCIDevice *pci_dev, MPQemuMsg *msg);
 
 void remote_iohub_init(RemoteIOHubState *iohub);
-void remote_iohub_finalize(RemoteIOHubState *iohub);
 
 #endif
-- 
2.39.5


