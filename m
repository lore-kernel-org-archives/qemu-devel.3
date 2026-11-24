Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A612C606A688
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=IBzxmwof
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzqx-0000bQ-Nx; Tue, 24 Nov 2026 18:23:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqn-0000XB-Rn
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:02 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqk-0006ZJ-Di
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=KXxedB2pK6pXvErwQ2DMjcN5CVWCsn8Q2L2nKaNMhso=; b=IBzxmwofTwZI485wtJH6dOx8RK
 O/CR8Q/7G8CvgmT675huSFzRGjm4+j5Pk3pldINu8LFSpINN3m+ANLHBINx32FID6NOvrnpGoAMOT
 j90FspoZlnbR5CYJayzDYOJ45NxXE97LS/Nd8Wstv7ANgOyP/OZZiT0iZP4s0SGFexwiYD+gQaj1+
 84SpzleCzHxHZmZtTsNkyb5Q3sTYmkFkgKxAOfMmLZ2xH9IVYnlao/ExcbX2JHWEPzj96VhMOC+PZ
 FnUkQwTEGjXt77pNf98NndWpKQHIMlixCx3bItruRQ0j1f7/regg1WNNDQCm/Cv/5e2gZbtvZzsbF
 0b8g2YMg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqc-00000004eV9-1k12; Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-00000000638-3F7z;
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
Subject: [PATCH v1 21/21] hw/i386/kvm/xen_evtchn: Allow unmapping an emulated
 MSI PIRQ
Date: Tue, 24 Nov 2026 23:22:47 +0000
Message-ID: <20261124232247.23169-22-dwmw2@infradead.org>
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

The "unmap GSI PIRQs only" check rejected every negative gsi, which
includes IRQ_MSI_EMU, so the later IRQ_MSI_EMU branch that flushes the
KVM MSI routes was unreachable and guests could never unmap an MSI
PIRQ. Xen permits it: physdev_unmap_pirq() on a domain with HVM pirqs
routes emulated-IRQ pirqs through unmap_domain_pirq_emuirq(), which
succeeds for MSI emuirqs. Let IRQ_MSI_EMU through; the existing
unreachable branch then does the route flush as originally intended.

Resolves: Coverity CID 1507603
Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index cfe735219bf..5a986c1e2a4 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1925,13 +1925,15 @@ int xen_physdev_unmap_pirq(struct physdev_unmap_pirq *unmap)
 
     gsi = s->pirq[pirq].gsi;
 
-    /* We can only unmap GSI PIRQs */
-    if (gsi < 0) {
+    /* We can only unmap GSI PIRQs and emulated MSIs */
+    if (gsi < 0 && gsi != IRQ_MSI_EMU) {
         qemu_mutex_unlock(&s->port_lock);
         return -EINVAL;
     }
 
-    s->gsi_pirq[gsi] = 0;
+    if (gsi >= 0) {
+        s->gsi_pirq[gsi] = 0;
+    }
     s->pirq[pirq].gsi = IRQ_UNBOUND; /* Doesn't actually matter because: */
     pirq_inuse_word(s, pirq) &= ~pirq_inuse_bit(pirq);
 
-- 
2.43.0


