Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA57CCA0EDC
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Aug 2025 11:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1umVpU-0001pt-J8; Thu, 14 Aug 2025 07:09:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umVpR-0001os-RI
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:09:05 -0400
Received: from air.basealt.ru ([193.43.8.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gerben@altlinux.org>)
 id 1umVpP-0003ux-CE
 for qemu-devel@nongnu.org; Thu, 14 Aug 2025 07:09:05 -0400
Received: from boringlust.malta.altlinux.ru (obninsk.basealt.ru
 [217.15.195.17]) (Authenticated sender: rastyoginds)
 by air.basealt.ru (Postfix) with ESMTPSA id E0DFC233B3;
 Thu, 14 Aug 2025 14:08:57 +0300 (MSK)
From: gerben@altlinux.org
To: qemu-devel@nongnu.org,
	mst@redhat.com
Cc: sdl.qemu@linuxtesting.org
Subject: [PATCH] hw/virtio/virtio-pci: add defensive check for vector_irqfd
Date: Thu, 14 Aug 2025 14:08:08 +0300
Message-ID: <20250814110830.14660-1-gerben@altlinux.org>
X-Mailer: git-send-email 2.42.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=193.43.8.18; envelope-from=gerben@altlinux.org;
 helo=air.basealt.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
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

From: Denis Rastyogin <gerben@altlinux.org>

Add a NULL check for proxy->vector_irqfd in
virtio_pci_one_vector_unmask() before taking the irqfd path.
This prevents potential access to uninitialized state if
vector_irqfd is absent.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Reported-by: Alexey Appolonov <alexey@altlinux.org>
Signed-off-by: Denis Rastyogin <gerben@altlinux.org>
---
 hw/virtio/virtio-pci.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 767216d795..07904f6f9b 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1015,7 +1015,11 @@ static int virtio_pci_one_vector_unmask(VirtIOPCIProxy *proxy,
             event_notifier_set(n);
         }
     } else {
-        ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
+        if (proxy->vector_irqfd) {
+            ret = kvm_virtio_pci_irqfd_use(proxy, n, vector);
+        } else {
+            ret = -EFAULT;
+        }
     }
     return ret;
 }
-- 
2.42.2


