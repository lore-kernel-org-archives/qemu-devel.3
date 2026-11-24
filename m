Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD012606A68F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=uMvqhYcU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzqn-0000Vs-65; Tue, 24 Nov 2026 18:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqk-0000UM-OQ
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:22:58 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqh-0006KI-PL
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:22:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=mShxXaZv6TY0Zli6pFAQOFKuPFGFrSk9kLHIUrN7Ut8=; b=uMvqhYcUlLku2c+q0NhmFreiZL
 TXqO78fEulJkymZMHBv8tmwLdtaQ3Rcskf8g6WHxqeBONoGsdnS5w0MtUe02gohddf/vzkGUQhnB8
 V6URimHadQK9fN5WMBerum0CbF5wwZmBYuUbej5eCu5OJR7XYac2D+134ru0r65BHmnvunVLRcv5s
 GWYqKwmlyZYTV3RDkXA4cguPMfbkWZ8PsuPV8O5TMBsd2GABaKtJZA5li7GdyfqX6d3sp3P2FjYoV
 QbOU9l/pHVf2+6Lt9m0GCTHVjj6O7eLgfmvTg+X4UO/izy/cvY2T331EUUSh5PyOMXnJWQSQ0beph
 xPcPKP5g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqa-0000000Gdi2-12sA; Tue, 24 Nov 2026 23:22:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-0000000062s-2sK5;
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
Subject: [PATCH v1 17/21] hw/9pfs/xen-9p-backend: Close event channel handle
 on disconnect
Date: Tue, 24 Nov 2026 23:22:43 +0000
Message-ID: <20261124232247.23169-18-dwmw2@infradead.org>
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

Disconnect only unbound the port, then dropped the pointer, leaking the
handle and its file descriptor on every disconnect/reconnect cycle.
Close the handle; closing also unbinds.

Fixes: b37eeb020123 ("xen/9pfs: introduce Xen 9pfs backend")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4523
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/9pfs/xen-9p-backend.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
index 6e26a445a09..612f19c45c8 100644
--- a/hw/9pfs/xen-9p-backend.c
+++ b/hw/9pfs/xen-9p-backend.c
@@ -392,8 +392,7 @@ static void xen_9pfs_disconnect(struct XenLegacyDevice *xendev)
         if (xen_9pdev->rings[i].evtchndev != NULL) {
             qemu_set_fd_handler(qemu_xen_evtchn_fd(xen_9pdev->rings[i].evtchndev),
                                 NULL, NULL, NULL);
-            qemu_xen_evtchn_unbind(xen_9pdev->rings[i].evtchndev,
-                                   xen_9pdev->rings[i].local_port);
+            qemu_xen_evtchn_close(xen_9pdev->rings[i].evtchndev);
             xen_9pdev->rings[i].evtchndev = NULL;
         }
         if (xen_9pdev->rings[i].data != NULL) {
-- 
2.43.0


