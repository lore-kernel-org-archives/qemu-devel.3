Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2172FC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilci-0001w5-PC; Sun, 12 Jul 2026 00:17:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcT-0001gi-3b; Sun, 12 Jul 2026 00:16:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcQ-0006G7-2L; Sun, 12 Jul 2026 00:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=co03GFHPji+tzW8/TSZZLngqZ6kFf91s5aFiFGJfF+A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=jyiGT8czrPz5nxKPkaz7uGFJ0DawzptyEnX0t2fklWzZ6bYdspo0DfMjmUUCCj5M4
 JybneT/eEDyQ41wwHTf98WUZ3zWdh3Qh5GddhdGg3GLUM+Vgi+xFSpodBeVx3V+cRl
 EAZ104TAo9SiqriTB1bZoXmdeGCQiNKzP8Vg1YRuP2ZZL+qK8OjiZBmhL6CU/8ahxy
 uU2ECvHocJKIyisvWq8gmGuG8GlhexADDTo7MedWRepVTLp+hgx2r0h4epar3T+12i
 r5XFa3Li4fEp4ToC/udxo7PMRuZFTnLdzfIIhk9IWZndbFQOlaH4Hh9bZxypdeIBYZ
 ZKnmllKqlasfQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BEAFE1C0BE2;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id F2D1C3EB942;
 Sun, 12 Jul 2026 07:16:30 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2526E133C7; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 07/75] 9pfs/xen: implement msize_limit callback
Date: Sun, 12 Jul 2026 07:14:25 +0300
Message-ID: <20260712041539.108341-7-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

Add and implement the msize_limit callback for the Xen transport.

The limit is calculated using XEN_FLEX_RING_SIZE() based on the
negotiated ring_order. For the theoretical maximum ring_order of 9,
this results in a maximum 'msize' of 1048576 bytes (1 MiB).

The minimum limit of all rings is picked, because multiple rings
could theoretically have different ring_orders.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/qemu-devel/9471786bc47b93e822f6c6233a83f2b9f61e6c82.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit 815d1799c3d3d6cd058cb4634392ca5a34830450)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 79359d911a7..f168c6ef0ee 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -250,12 +250,31 @@ static void xen_9pfs_push_and_notify(V9fsPDU *pdu)
     qemu_bh_schedule(ring->bh);
 }
 
+static size_t xen_9p_msize_limit(V9fsState *s)
+{
+    Xen9pfsDev *xen_9pfs = container_of(s, Xen9pfsDev, state);
+    size_t limit;
+    int i;
+
+    if (!xen_9pfs->num_rings) {
+        return 0;
+    }
+
+    limit = XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
+    for (i = 1; i < xen_9pfs->num_rings; i++) {
+        limit = MIN(limit, XEN_FLEX_RING_SIZE(xen_9pfs->rings[i].ring_order));
+    }
+
+    return limit;
+}
+
 static const V9fsTransport xen_9p_transport = {
     .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
     .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
     .init_in_iov_from_pdu = xen_9pfs_init_in_iov_from_pdu,
     .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
     .push_and_notify = xen_9pfs_push_and_notify,
+    .msize_limit = xen_9p_msize_limit,
 };
 
 static int xen_9pfs_init(struct XenLegacyDevice *xendev)
-- 
2.47.3


