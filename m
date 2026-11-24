Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D733606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=olyREV0E
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzqu-0000a4-Ie; Tue, 24 Nov 2026 18:23:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqp-0000XZ-Ja
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:03 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqk-0006ZP-D0
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=fWZq+phibeUOAuCvTbIBUu8IYuUINRpE+QvToHPSryc=; b=olyREV0EM42s4OFSemiYPWrcmz
 nBl210NlEyXbsalTjLv/ZvSjQ9oY6zkhValMnTsqQ57gRPeEio/58Q3hOhBCPMob+Ion6pw7xgJDX
 HcGSqj1ow9xIy5yr4tWm4q9ItKtX5H7M8llT6LGfUdJX3mR//BoqU81QK0bHhbkPMNSVXF9rfMIaG
 HdFkc48goyA5+2S3JgsCi50vIQ/p4fRKaAIQelLGINLO1R5jKF3KUzxL4OojCMpxds+y8sevGkGQI
 GMFVYtm8Fko+PMVNXTHT3lu5luX7EWk/CmgqJKOl12szWx3+LN3wJdND7tlcIQlgFqnNFEjhCwPg2
 wxlQ/xIQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqc-00000004eUz-1kfl; Tue, 24 Nov 2026 23:22:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-0000000061t-1D5p;
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
Subject: [PATCH v1 02/21] i386/xen: Don't resample GSI when per-vCPU upcall
 vector is in use
Date: Tue, 24 Nov 2026 23:22:28 +0000
Message-ID: <20261124232247.23169-3-dwmw2@infradead.org>
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

The callback_via GSI (or PCI INTx) and the per-vCPU upcall vector are
mutually exclusive delivery mechanisms for Xen event channel upcalls.
Xen itself will never assert the callback GSI for a vCPU which has a
per-vCPU upcall vector configured.

When the interrupt is acked, QEMU's resampling logic reasserts the
GSI if evtchn_upcall_pending is still set. If the guest has configured
a per-vCPU upcall vector, events are delivered through that vector and
the GSI is unexpected; a guest which receives both the vector upcall
and a spurious GSI interrupt for the same event can crash. This was
observed in production with Windows guests on a different VMM which
implements the same resampling logic.

If a per-vCPU upcall vector is configured, don't resample the GSI;
just deassert it.

Fixes: ddf0fd9ae1fd ("hw/xen: Support HVM_PARAM_CALLBACK_TYPE_GSI callback")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 target/i386/kvm/xen-emu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target/i386/kvm/xen-emu.c b/target/i386/kvm/xen-emu.c
index 29364a92797..7337561b159 100644
--- a/target/i386/kvm/xen-emu.c
+++ b/target/i386/kvm/xen-emu.c
@@ -435,6 +435,13 @@ void kvm_xen_maybe_deassert_callback(CPUState *cs)
         return;
     }
 
+    if (env->xen_vcpu_callback_vector) {
+        BQL_LOCK_GUARD();
+        env->xen_callback_asserted = false;
+        xen_evtchn_set_callback_level(0);
+        return;
+    }
+
     /* If the evtchn_upcall_pending flag is cleared, turn the GSI off. */
     if (!vi->evtchn_upcall_pending) {
         bql_lock();
-- 
2.43.0


