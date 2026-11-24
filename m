Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3913606A332
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ByYwvkFg
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzqs-0000Zo-CS; Tue, 24 Nov 2026 18:23:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqm-0000VV-2q
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:00 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqh-0006JQ-PI
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=7Q8vcK6pp8jnVnCjyRjbmOniJ69JnrySfnqcCaHpuRg=; b=ByYwvkFgRf+NraRIKwg2fC4EDw
 CmOLguurIyG6OgQEEKm1F6mB3yG70Z8RMXbB5UsF9zwGU+4Di0mNG2JjIuOoD7RMpDzEKKpgAvxRn
 1z/ITJftIVEb3OKUXxcjYpBdrBlzT4kpDiXsbHwf+2LcESWmbnUMMDN2czKFZnVX9/zkVLZ6rZ6gM
 QWG0EmDqE6X3Fu1wgM5JXuaM3KUgJlEyhauqf0kiFxoqQzGaGfo/2htOB02X7L4eXi0BYPukwEuKK
 Hbb8xYQ3TxJ2jXbnctaD8vkMILe43Adp+suaI2YGl+aGUOxJQJb9QRjD371JRAyDGKpqsfs5UaWIL
 pkueEdZA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqZ-0000000Gdhz-45hv; Tue, 24 Nov 2026 23:22:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-0000000062U-2B62;
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
Subject: [PATCH v1 11/21] hw/i386/kvm/xen: Don't leak gnttab handle on reset
Date: Tue, 24 Nov 2026 23:22:37 +0000
Message-ID: <20261124232247.23169-12-dwmw2@infradead.org>
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

xen_xenstore_reset() and xen_primary_console_reset() open a new gnttab
handle without closing the previous one, leaking it and its mappings on
each guest soft reset. Close the old handle first; closing unmaps any
remaining refs.

Fixes: d05864d23b1a ("hw/xen: Map guest XENSTORE_PFN grant in emulated Xenstore")
Fixes: a72ccc7fc449 ("hw/xen: add support for Xen primary console in emulated mode")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_primary_console.c | 3 +++
 hw/i386/kvm/xen_xenstore.c        | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/hw/i386/kvm/xen_primary_console.c b/hw/i386/kvm/xen_primary_console.c
index bf61f6235be..0a2a6de3ecb 100644
--- a/hw/i386/kvm/xen_primary_console.c
+++ b/hw/i386/kvm/xen_primary_console.c
@@ -184,6 +184,9 @@ int xen_primary_console_reset(void)
 
     trace_xen_primary_console_reset(s->guest_port);
 
+    if (s->gt) {
+        qemu_xen_gnttab_close(s->gt);
+    }
     s->gt = qemu_xen_gnttab_open();
     uint32_t xs_gntref = GNTTAB_RESERVED_CONSOLE;
     s->granted_xs = qemu_xen_gnttab_map_refs(s->gt, 1, xen_domid, &xs_gntref,
diff --git a/hw/i386/kvm/xen_xenstore.c b/hw/i386/kvm/xen_xenstore.c
index 7d6d6d5cbb7..ff0dfb1bff8 100644
--- a/hw/i386/kvm/xen_xenstore.c
+++ b/hw/i386/kvm/xen_xenstore.c
@@ -1490,6 +1490,9 @@ int xen_xenstore_reset(void)
      * first place. Map the grant anyway, mostly for cosmetic purposes so
      * it *looks* like it's in use in the guest-visible grant table.
      */
+    if (s->gt) {
+        qemu_xen_gnttab_close(s->gt);
+    }
     s->gt = qemu_xen_gnttab_open();
     uint32_t xs_gntref = GNTTAB_RESERVED_XENSTORE;
     s->granted_xs = qemu_xen_gnttab_map_refs(s->gt, 1, xen_domid, &xs_gntref,
-- 
2.43.0


