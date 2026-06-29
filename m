Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D5FC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCBx-00014A-6L; Mon, 29 Jun 2026 09:38:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <815d1799c3d3d6cd058cb4634392ca5a34830450@kylie.crudebyte.com>)
 id 1weCBm-0000vn-5D; Mon, 29 Jun 2026 09:38:20 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <815d1799c3d3d6cd058cb4634392ca5a34830450@kylie.crudebyte.com>)
 id 1weCBk-0003pn-M2; Mon, 29 Jun 2026 09:38:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=JDJlc7IO//w+TTraQ7wtDmZb2j4bqceOuIKvYV6trOY=; b=s1xEV
 sekCMvkaOP/Y9uFtr9HcwhoM4FENtZWILpUjn0CpAoUpqS0bu7c9wPWc9PaP9VnIFUMfjRRWVzTBP
 HGXGbaaQAk/NVxUnGhR+A3mAcIsFa5zMlk9h2a3Fuxdp+UpY3k1LXmHgKZj/qSQDF+l3gBYUSz9nH
 yW1uq7INuUjW+0KgpYbZswlRwQpYNaLqZSy9da1Fv+d+BwHWM17MiTRYpesvMdHj75oztvgK4FAti
 8wMrhf1jNxuanB4WRNTPnwfwAMjdVpG9yj7PxGTdqUotP/yFXVTfrboP9bjYb+26UyhTq+jM36FWU
 fBJR0OUtxvGLuokvs5NgxUiTIEzEsQWDw7oSckfBQlt7KMBqd2NQXWrzcZF3a8h96gqwG39r1axcU
 8XP1Y1iS+K3NlS7FJG6IFJSicrKMfk7OKBILgZEXfJ7hntHRjR89AY4+uvZvtqanbzdRxYzZlCDYm
 1kMv+GXVq+XfeB68O3SAHn3KEHOOu2HFUt1fOFwdZc4I82p049MlelDdSuJYHosz1rlTb4M/CjdmV
 rCKu9d6l/kLLb2qTXuAHzBHPjjhbqrMWWAU3Kugp4ZsF/VOpBXWMlNyM5QxNi9y7B7CeeLFDEfO6b
 EIyDnhsohyboc7R8mwbRWFF0XbgBlwkh3az8CRPhkj5gCkJNUOYxsbsjcRfXS4=;
Message-ID: <815d1799c3d3d6cd058cb4634392ca5a34830450.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 03/23] 9pfs/xen: implement msize_limit callback
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=815d1799c3d3d6cd058cb4634392ca5a34830450@kylie.crudebyte.com;
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

Add and implement the msize_limit callback for the Xen transport.

The limit is calculated using XEN_FLEX_RING_SIZE() based on the
negotiated ring_order. For the theoretical maximum ring_order of 9,
this results in a maximum 'msize' of 1048576 bytes (1 MiB).

The minimum limit of all rings is picked, because multiple rings
could theoretically have different ring_orders.

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/qemu-devel/9471786bc47b93e822f6c6233a83f2b9f61e6c82.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/xen-9p-backend.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index ca0fff5fa9..e31124bcf5 100644
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


