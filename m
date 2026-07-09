Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEA93C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2026 14:07:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whpOf-0006mI-6I; Thu, 09 Jul 2026 10:06:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6811fc561b7d20610e5f39234d08542cc1f31fd7@kylie.crudebyte.com>)
 id 1whpOe-0006lt-3Q; Thu, 09 Jul 2026 10:06:36 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6811fc561b7d20610e5f39234d08542cc1f31fd7@kylie.crudebyte.com>)
 id 1whpOc-0003FQ-EU; Thu, 09 Jul 2026 10:06:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=K8zgQQ6Iv80yY1QpDUYnVdPfr2KBosKHF1doFomoksY=; b=ZaiSY
 SAfBMU8dH9Bvq034QsSeLvsR8PxcJObwn54s2atII6fbn8gkbXTbHttYqWG+H0CZ4dClCBy2V30JZ
 i+DBP74uG5H0AtXzM0c16eIYZh/FvQzwiNq8cwQjTV5sRodJO8K8HwRO1H8j51rznxlsWd9vnD92k
 v82DxrEmqBalPKfd/g63T3VAQGaKLA35W43sKyWUODvpWzs+sFVeOyjqaT8KFgqKxn/dUovyBoI7+
 kTUEBN3aBIQ0a+I1X15DCo2rtpt27qYeCetzqJcqshm4c+j9ixNngrN2JRFyP3Z+RRBZDRvER5vRQ
 sEtSeuGRjFRNk2FWiXIBUyZSWh91pIEZ0wbxLmPFQJeAn94+hTXV06HUytJRves2FEQ/sjHR2upDm
 nehtWfRTwmuWwcSOvw6fGrZVhTMFC4yJueMQ211HIv1Ea2qBoWFSGZtLVsxgJeBaJNPPKDCwZcfE6
 Yuapj3mAOsSTZuU/qoZgc9N86gv03frUlknEB9HixOfSt5LG1e4Q4xrIl0uNfsLcZLvct8wHNf7b4
 lL8AuQvl9FNeaMZrV3Kh/YdOZiAzuybCaUq7N/rfRlO7ykgCilOXRGLdXQpWexd/fznL+CfhRas+u
 2uBXiIaGY3svbpugvdLouUGN54KGbjFahiqoBheIUk5qY1ivNq4PEz/BX3PX5k=;
Message-ID: <6811fc561b7d20610e5f39234d08542cc1f31fd7.1783604079.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1783604079.git.qemu_oss@crudebyte.com>
References: <cover.1783604079.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Thu, 9 Jul 2026 15:50:36 +0200
Subject: [PATCH 3/3] hw/9pfs/xen: drain in-flight PDUs before xen-9p disconnect
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=6811fc561b7d20610e5f39234d08542cc1f31fd7@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

The xen-9p disconnect path has two issues:

1. It frees the Xen9pfsRing structures while in-flight PDUs may still
   reference them via pdu->tag to index rings[]. This causes a UAF
   in xen_9pfs_push_and_notify() when worker threads resume after
   completing filesystem operations.

2. It never calls v9fs_device_unrealize_common(), which means server
   state (struct LocalData, mountfd, FIDs) is never cleaned up on
   disconnect, causing a resource leak on every guest-initiated
   disconnect.

Fix both by draining in-flight PDUs via v9fs_reset() before tearing
down rings, and calling v9fs_device_unrealize_common() to clean up
server state.

Fixes: b37eeb0201 ("xen/9pfs: introduce Xen 9pfs backend")
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/xen-9p-backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 24c90d97ec..3b7a68779a 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -368,10 +368,14 @@ static void xen_9pfs_evtchn_event(void *opaque)
 static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
 {
     Xen9pfsDev *xen_9pdev = container_of(xendev, Xen9pfsDev, xendev);
+    V9fsState *s = &xen_9pdev->state;
     int i;
 
     trace_xen_9pfs_disconnect(xendev->name);
 
+    v9fs_reset(s);
+    v9fs_device_unrealize_common(s);
+
     for (i = 0; i < xen_9pdev->num_rings; i++) {
         if (xen_9pdev->rings[i].evtchndev != NULL) {
             qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),
-- 
2.47.3


