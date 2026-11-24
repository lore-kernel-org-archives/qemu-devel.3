Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6829606A33E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=DDIp988r
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzqu-0000a5-Ih; Tue, 24 Nov 2026 18:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqm-0000VX-5J
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:00 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqh-0006JP-Nf
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=omSfQRir3NOjvaxuaNmQVmaf9UjouyCVezkBBc8wqZc=; b=DDIp988rHTV7Y/YJBbUl8MtY+f
 OSqNgMp//dwiaqlE3WGUaJXxYnmYB/NT/ba1puqnp8cX9ie0PYqlb9T+KM0U6hx5GGut/gkATWMH9
 yP3Amt8TaJ3JOtwSmKg8N2zr/679L3/Rrv9kUFzfXVpbQXhGOdbkFebtVmzeorfbDYfOhvMCUYFUh
 fcFMf8pLi9VAcogUdNbm4F1RVTCi7dY7TYoqSa11A2fXVoxW/ffIOIq+B+qD13h04kIj+5Et+uxcE
 dZE11z2cqqphjDPQmPI1zJEE03phi+Dhnq5nY2/my1iWWGPTEcTWfK64JlzqroPoJHw16J1abaUHH
 RR18poDw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqZ-0000000Gdhv-3Fud; Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-0000000061z-1Qql;
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
Subject: [PATCH v1 04/21] hw/xen: Publish backend features before setting
 state to InitWait
Date: Tue, 24 Nov 2026 23:22:30 +0000
Message-ID: <20261124232247.23169-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

The XenbusStateInitWait transition tells the frontend that the
backend's parameters are readable, but xen_device_realize() set it
before calling the implementation's realize method — which is what
writes the feature nodes ('max-ring-page-order' et al. for xen-block,
'feature-rx-copy' for xen-net).

Linux blkfront reads 'max-ring-page-order' with xenbus_read_unsigned():
no wait, no retry, default 0. Lose the race and it silently negotiates
a single-page ring — 32 request slots instead of 256. A device
hot-plugged into a running guest loses essentially every time; at boot
the frontend doesn't come looking until long after realize finished.
Netfront reads its feature nodes the same way.

Commit 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too
early") introduced this by moving the realize call after the block of
code which both populates the initial xenstore nodes *and* sets
InitWait. The crash it fixed was real — xen-block's realize processes
watch events via blkconf_geometry()'s aio_poll(), and the handlers fell
over when the nodes didn't yet exist — but only the node population
needed to come first.

So keep the node population and the 'online' write before realize, and
move only the InitWait transition after it. A watch event during
realize now finds the frontend in Initialising and no backend 'state'
node, which the handlers tolerate; none of the three realize
implementations reads the backend state. Verified against the original
2023 crash reproducer as well as the ring-order negotiation.

Fixes: 240cc11369fc ("hw/xen: Avoid crash when backend watch fires too early")
Reported-by: Mark Syms <mark.syms@citrix.com>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/xen/xen-bus.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/xen/xen-bus.c b/hw/xen/xen-bus.c
index 17bbbe2ea71..b75ce7f0957 100644
--- a/hw/xen/xen-bus.c
+++ b/hw/xen/xen-bus.c
@@ -1082,7 +1082,6 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
     xen_device_backend_printf(xendev, "hotplug-status", "connected");
 
     xen_device_backend_set_online(xendev, true);
-    xen_device_backend_set_state(xendev, XenbusStateInitWait);
 
     if (!xen_device_frontend_exists(xendev)) {
         xen_device_frontend_printf(xendev, "backend", "%s",
@@ -1093,6 +1092,19 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
         xen_device_frontend_set_state(xendev, XenbusStateInitialising, true);
     }
 
+    /*
+     * The implementation's realize method may write feature nodes to
+     * the backend area (e.g. 'max-ring-page-order' for xen-block,
+     * 'feature-rx-copy' for xen-net). It must be called after the
+     * backend and frontend areas are populated, because it can invoke
+     * aio_poll() (e.g. through blkconf_geometry()) and thus process
+     * watch events which need to read the 'state' nodes. But it must
+     * be called *before* the backend state is set to InitWait below,
+     * because InitWait is the frontend's cue that the backend's
+     * feature nodes can be read; a frontend which reads them promptly
+     * (as Linux blkfront and netfront do, without waiting or retrying)
+     * must not find them missing.
+     */
     if (xendev_class->realize) {
         xendev_class->realize(xendev, errp);
         if (*errp) {
@@ -1100,6 +1112,8 @@ static void xen_device_realize(DeviceState *dev, Error **errp)
         }
     }
 
+    xen_device_backend_set_state(xendev, XenbusStateInitWait);
+
     xendev->exit.notify = xen_device_exit;
     qemu_add_exit_notifier(&xendev->exit);
     return;
-- 
2.43.0


