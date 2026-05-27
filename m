Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5626FCD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:01:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMHy-0003Ry-Hy; Wed, 27 May 2026 17:59:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <95ab978f1919cf91ea1f2a5de6c870e30e420b32@kylie.crudebyte.com>)
 id 1wSMHx-0003Rh-56; Wed, 27 May 2026 17:59:45 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <95ab978f1919cf91ea1f2a5de6c870e30e420b32@kylie.crudebyte.com>)
 id 1wSMHv-0004Dm-SD; Wed, 27 May 2026 17:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=beY+g0h7CbOAhsljhLzAbanjhK51XDRWlDrhN3lBpoM=; b=ZA3wc
 gkXAmcH7eNob6Ezt+O6vLTiYkbOy2iRMgOvsuyqe7a8nK6WzDrQYGUoKVd+bB5eylAFLq6eobEtPi
 Z89pE4IhjSw/bgZixryUw1WKjUj2c7buWc24md8509s/mTkr+I1LBw2VNtFWcUjSSceDWGwUG0XzJ
 SFUMlWS6rcp3DpS0dmF30pC918OI8KhoOv4+gvPeFk4zciEynI7N0tfiHM4wy/O3XCqR9aUJ2n4VY
 qgvE2ogh+5Sc6aqnDMmCqQk4LWdNZENYnViluf53+HqXNUCsN7R4/c2cyqn2gKlcKrg8wsR7cl0GL
 M2KBx8S4lNFhLpuWE+T1d7LrueX27Mh7OVCtj4yzQJV69XKIJYmjRaXCqzrYm/ieAHklAHVwbp3MF
 KWSCSnskiVy04I4xl+P6gY++YSSCQBN8vSOP/GnerVm3ZehSYiUwKh0Yr3HxV5T6dqBq+BXsTj2AN
 NKa2/ABMKJEPOiYhvICr5xpD2Q5aETEOeNt9stvk+Mfw9rKv0aivMYU4+Z/MahkmmHC642K4Jsrrj
 h3FKOiMsD558kX1i9ykkQvqjOjbarX9NPyiUPwlK/uJa6T48hYlZ3DU0C8IuNaYWD9PILAmnLCsos
 RAXlVkbd/wMy6EnP//1uJYBcpnY4yvLeWbs5H/mZC5LW6FhybF3TLmh1Hp4wlw=;
Message-ID: <95ab978f1919cf91ea1f2a5de6c870e30e420b32.1779916560.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 27 May 2026 23:15:35 +0200
Subject: [PATCH 7/8] 9pfs/xen: implement response_buffer_size callback
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=95ab978f1919cf91ea1f2a5de6c870e30e420b32@kylie.crudebyte.com;
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

Add and implement the response_buffer_size callback for the Xen
transport.

Returns the size of the response buffer from the rings in_sg, as limit
for 9p server while generating a response for supplied PDU.

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/xen-9p-backend.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 94654022fe..258a1f2ec7 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -256,6 +256,16 @@ static size_t xen_9p_msize_limit(V9fsState *s)
     return XEN_FLEX_RING_SIZE(xen_9pfs->rings[0].ring_order);
 }
 
+static size_t xen_9pfs_response_buffer_size(V9fsPDU *pdu)
+{
+    Xen9pfsDev *priv = container_of(pdu->s, Xen9pfsDev, state);
+    Xen9pfsRing *ring = &priv->rings[pdu->tag % priv->num_rings];
+    int num;
+
+    xen_9pfs_in_sg(ring, ring->sg, &num, pdu->idx, 0);
+    return iov_size(ring->sg, num);
+}
+
 static const V9fsTransport xen_9p_transport = {
     .pdu_vmarshal = xen_9pfs_pdu_vmarshal,
     .pdu_vunmarshal = xen_9pfs_pdu_vunmarshal,
@@ -263,6 +273,7 @@ static const V9fsTransport xen_9p_transport = {
     .init_out_iov_from_pdu = xen_9pfs_init_out_iov_from_pdu,
     .push_and_notify = xen_9pfs_push_and_notify,
     .msize_limit = xen_9p_msize_limit,
+    .response_buffer_size = xen_9pfs_response_buffer_size,
 };
 
 static int xen_9pfs_init(struct XenLegacyDevice *xendev)
-- 
2.47.3


