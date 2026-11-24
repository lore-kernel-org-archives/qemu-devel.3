Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FE5606A329
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=F0Nol9H4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzqn-0000Wr-GF; Tue, 24 Nov 2026 18:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqm-0000VW-54
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:00 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqh-0006JN-PJ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=hdyfm7GpJ9FLtKxanRFDOcqZILwEpUm9W0rWeuqixlE=; b=F0Nol9H4CEqNAfhv45Miss1ani
 XYN56Xrq1FtjpWaI+0gypS+mw7nIwd42pCP5rcyfVh4xuGfpKPgSLOH2uZsFlXKv1tQ/F+oxOI5CK
 Kj5H0gbwqBHB7QSo1N566xQmUml0PTsrsM1rU6jCnMLrmNln1ejFCepPXGFtDoxg3iLhD/jLBqxvg
 vYhuHo5DB734c1HXV6N7p/BKnfe2M65z8yq4F0Od8T3n/kWa37KO5yWGtAXXDEPhkOjAXLFyyqrhn
 wAbc+SNxGqvJPLVYcD7ySaztLDqj7iw3PM1gqCwYQik1oHclEgkEjdcaYiZ+in+mfTTVw7w/Hnwh+
 vYlx3IGw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqa-0000000Gdi3-0ZNx; Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-0000000062w-2xwb;
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
Subject: [PATCH v1 18/21] hw/net/xen_nic: Bound the TX and RX rings' producer
 index
Date: Tue, 24 Nov 2026 23:22:44 +0000
Message-ID: <20261124232247.23169-19-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org;
 helo=casper.infradead.org
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
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

net_tx_packets() consumed requests until req_cons caught up with the
raw req_prod from the shared ring. A bogus req_prod made the loop
process up to 2^32 stale slots while holding the BQL. Check
RING_REQUEST_PROD_OVERFLOW on both rings, as xen-block already does.

Fixes: e613b064a88a ("xen: add net backend driver.")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4515
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/net/xen_nic.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/net/xen_nic.c b/hw/net/xen_nic.c
index e615303da6a..4de2464376f 100644
--- a/hw/net/xen_nic.c
+++ b/hw/net/xen_nic.c
@@ -138,6 +138,12 @@ static bool net_tx_packets(struct XenNetDev *netdev)
         rp = netdev->tx_ring.sring->req_prod;
         xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
+        if (RING_REQUEST_PROD_OVERFLOW(&netdev->tx_ring, rp)) {
+            qemu_log_mask(LOG_GUEST_ERROR, "vif%u: bad req_prod %u\n",
+                          netdev->dev, rp);
+            break;
+        }
+
         while ((rc != rp)) {
             if (RING_REQUEST_CONS_OVERFLOW(&netdev->tx_ring, rc)) {
                 break;
@@ -268,7 +274,8 @@ static ssize_t net_rx_packet(NetClientState *nc, const uint8_t *buf, size_t size
     rp = netdev->rx_ring.sring->req_prod;
     xen_rmb(); /* Ensure we see queued requests up to 'rp'. */
 
-    if (rc == rp || RING_REQUEST_CONS_OVERFLOW(&netdev->rx_ring, rc)) {
+    if (rc == rp || RING_REQUEST_PROD_OVERFLOW(&netdev->rx_ring, rp) ||
+        RING_REQUEST_CONS_OVERFLOW(&netdev->rx_ring, rc)) {
         return 0;
     }
     if (size > XEN_PAGE_SIZE - NET_IP_ALIGN) {
-- 
2.43.0


