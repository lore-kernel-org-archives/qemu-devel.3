Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CD6606A696
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=kGl8PcHH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzr3-0000fU-Vw; Tue, 24 Nov 2026 18:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqp-0000YZ-Vh
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:04 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqk-0006ZH-EY
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=DwSIl3YjsuOZ09uV3T3X5vCjJ3huKi3Xcf0yWKrN1pw=; b=kGl8PcHHViYt2K1voQ4sTXfXqn
 CpRywx944KOHnJDx5JoW02cyU+m3ejXVFJJQiHdDV8rh1F97bHkwrEtfOVkHmtdFwWlYQCMDOHjgK
 h7S9qttzUGqtl/A+WcIbXI55+v+Jk2ZPCWvBW6caH8sqPVN+Zb7q28JD1eyAP/zF/C3o+YlgK6Ifq
 o/tPtagB4ZTWDkv3QxAGZaCD2o+MdN9mnLCm3SEv5Y3lSwVZtjcxWQOKaUxcyfuJBEfzc3hWGja5Q
 BrYoI6ZBzoMR/g2m2HqYg0iI9aWeTm8icM4HbwzIyDm+axrIUc/vy9rVTdeNudlk82xRC/lFNpGyK
 V4dMRhpA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqc-00000004eV5-1kcJ; Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-0000000062g-2Xfp;
 Tue, 24 Nov 2026 23:22:47 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paul Durrant <paul@xen.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Jason Wang <jasowangio@gmail.com>, Hui Peng <benquike@gmail.com>,
 Mark Syms <mark.syms@citrix.com>, Feifan Qian <bea1e@proton.me>,
 David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v1 14/21] hw/9pfs/xen-9p-backend: Use validated snapshot for
 request iovecs
Date: Tue, 24 Nov 2026 23:22:40 +0000
Message-ID: <20261124232247.23169-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org;
 helo=desiato.infradead.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

xen_9pfs_out_sg() re-read the consumer index from the shared ring page
when building the request iovecs, so with an index the validation in
xen_9pfs_receive() never saw, the iovecs can reach past the end of the
ring mapping. Reconstruct the index from the out_cons/out_size snapshot
taken at validation time, and split the iovecs purely against the ring
size.

Fixes: CVE-2026-123072
Fixes: 40a2389207fb ("xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/9pfs/xen-9p-backend.c | 43 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 06709d54084..22b2190b1b6 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -105,34 +105,29 @@ static void xen_9pfs_out_sg(Xen9pfsRing *ring,
                             int *num,
                             uint32_t idx)
 {
-    RING_IDX cons, prod, masked_prod, masked_cons;
-
-    cons = ring->intf->out_cons;
-    prod = ring->intf->out_prod;
-    xen_rmb();
-    masked_prod = xen_9pfs_mask(prod, XEN_FLEX_RING_SIZE(ring->ring_order));
-    masked_cons = xen_9pfs_mask(cons, XEN_FLEX_RING_SIZE(ring->ring_order));
-
-    if (masked_cons < masked_prod) {
+    RING_IDX cons, masked_cons;
+    RING_IDX ring_size = XEN_FLEX_RING_SIZE(ring->ring_order);
+
+    /*
+     * Use the consumer index and request size snapshotted when the
+     * request was validated in xen_9pfs_receive(). Do not re-read the
+     * index from the shared page: the guest may have changed it since
+     * validation, and out_size (bounded by the ring size at validation
+     * time) could then reach past the end of the ring mapping.
+     */
+    cons = ring->out_cons - ring->out_size;
+    masked_cons = xen_9pfs_mask(cons, ring_size);
+
+    if (ring->out_size <= ring_size - masked_cons) {
         out_sg[0].iov_base = ring->ring.out + masked_cons;
         out_sg[0].iov_len = ring->out_size;
         *num = 1;
     } else {
-        if (ring->out_size >
-            (XEN_FLEX_RING_SIZE(ring->ring_order) - masked_cons)) {
-            out_sg[0].iov_base = ring->ring.out + masked_cons;
-            out_sg[0].iov_len = XEN_FLEX_RING_SIZE(ring->ring_order) -
-                                masked_cons;
-            out_sg[1].iov_base = ring->ring.out;
-            out_sg[1].iov_len = ring->out_size -
-                                (XEN_FLEX_RING_SIZE(ring->ring_order) -
-                                 masked_cons);
-            *num = 2;
-        } else {
-            out_sg[0].iov_base = ring->ring.out + masked_cons;
-            out_sg[0].iov_len = ring->out_size;
-            *num = 1;
-        }
+        out_sg[0].iov_base = ring->ring.out + masked_cons;
+        out_sg[0].iov_len = ring_size - masked_cons;
+        out_sg[1].iov_base = ring->ring.out;
+        out_sg[1].iov_len = ring->out_size - (ring_size - masked_cons);
+        *num = 2;
     }
 }
 
-- 
2.43.0


