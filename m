Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AE8606A689
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=rIrIBwsh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzr2-0000eE-Su; Tue, 24 Nov 2026 18:23:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqx-0000bL-Bc
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:11 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqu-0006tF-7m
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=i4B6bqyTVLsX4pdrr6Z2tGS5jrujsXnubmc2oU/AG+g=; b=rIrIBwshFRXjX80qqkWQWRBXqq
 lQU9dpwGYR3lEvehHB9qQgedtr7BuNS/gZVAnHn1qPcBEtfoDeJ8KSjJstpQk2vSHumx7CcALNHN/
 5jKp8Sg8/XuU5V/Qh3cIjLKqg2QL5C9AuwIhnwDoBODqEjaiC7XD6w9PNn3vpHTNQ+IKLOEp9ZD30
 OKAi22XLiRXzwaWUKIO44rfp77bw95a0jrJelwc73g8zV3/4RuNT16TqR37qtqABuUMEAtRK2LxzF
 /CRV2cFAtGRo/5NiYpfXF2Dx4/29HRkMBLMG1L5Aht/fVnJtnh9nLPOwy7cKuuFs5+DivPkXHSXyQ
 n7YonpXw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqc-00000004eV8-1lDN; Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-00000000634-39To;
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
Subject: [PATCH v1 20/21] hw/i386/kvm/xen_evtchn: Hold port_lock for whole of
 bind_pirq_op
Date: Tue, 24 Nov 2026 23:22:46 +0000
Message-ID: <20261124232247.23169-21-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261124232247.23169-1-dwmw2@infradead.org>
References: <20261124232247.23169-1-dwmw2@infradead.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The check for an existing binding read s->pirq[].port before taking
port_lock, and the allocation wrote it after. The BQL serialises the
writers in practice, but holding port_lock across the check and the
allocation is clearly correct and lets Coverity see it too.

The region now under the lock is pure port_table/pirq bookkeeping.
The MSI unmask and kvm_update_msi_routes_all() calls must remain
outside port_lock: they can re-enter via the MSI translate function,
which takes port_lock itself. The PIRQ→evtchn→GSI delivery paths have
further BQL/port_lock ordering constraints — see the comments in
xen_evtchn_set_callback_level() and xen_evtchn_set_gsi().

Resolves: Coverity CID 1527403
Fixes: 6096cf7877bc ("hw/xen: Support MSI mapping to PIRQ")
Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_evtchn.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/hw/i386/kvm/xen_evtchn.c b/hw/i386/kvm/xen_evtchn.c
index e2803cad0a8..cfe735219bf 100644
--- a/hw/i386/kvm/xen_evtchn.c
+++ b/hw/i386/kvm/xen_evtchn.c
@@ -1289,24 +1289,21 @@ int xen_evtchn_bind_pirq_op(struct evtchn_bind_pirq *pirq)
 
     BQL_LOCK_GUARD();
 
-    if (s->pirq[pirq->pirq].port) {
-        return -EBUSY;
-    }
+    WITH_QEMU_LOCK_GUARD(&s->port_lock) {
+        if (s->pirq[pirq->pirq].port) {
+            return -EBUSY;
+        }
 
-    qemu_mutex_lock(&s->port_lock);
+        ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
+                            &pirq->port);
+        if (ret) {
+            return ret;
+        }
 
-    ret = allocate_port(s, 0, EVTCHNSTAT_pirq, pirq->pirq,
-                        &pirq->port);
-    if (ret) {
-        qemu_mutex_unlock(&s->port_lock);
-        return ret;
+        s->pirq[pirq->pirq].port = pirq->port;
+        trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
     }
 
-    s->pirq[pirq->pirq].port = pirq->port;
-    trace_kvm_xen_bind_pirq(pirq->pirq, pirq->port);
-
-    qemu_mutex_unlock(&s->port_lock);
-
     /*
      * Need to do the unmask outside port_lock because it may call
      * back into the MSI translate function.
-- 
2.43.0


