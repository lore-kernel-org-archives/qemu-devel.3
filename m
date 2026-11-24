Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7E606A32A
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=iCplaFGm
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzqn-0000W1-EA; Tue, 24 Nov 2026 18:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzql-0000VM-IB
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:22:59 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+7be3010b4cb4d9f5c1a9+8493+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1xVzqh-0006JL-MU
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:22:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=NEdqkVW780b7/EBwy88Eid9pGH6VB8HPHsnSsQzF1WE=; b=iCplaFGmsblW2SJV3FvmC0xSrM
 1ye/eDTy0ssR0z1yr6RrPrKcPewXtbFqAjBTDsYxMSEvQeP+eWMc1kUZ7GlBZS90mpES1iL+qJt5s
 M/gQ5wEkx9PldAlvVG8Ly6la0vGtAJ+rWHDBTtUEtIL6n8MkPP7cib8lUgM4uHbcPWz5remxh1Rjr
 Gl7FsPgzW5RaeBH0k9xnbSycOBTIPyaIn3pmdq8I+Tl05mTKpPoz70qYH5wTbJnah/E2A87oXfLch
 hnHGE7ThgUKrALONFtfo7xKgkXBMV8QZKfzTo0VsBKaxseUwgvcWicSAYcJUgxZX842AjlLxZmHxp
 UyxYhBsQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqZ-0000000Gdhx-3FY9; Tue, 24 Nov 2026 23:22:48 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-00000000625-1eYh;
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
Subject: [PATCH v1 06/21] hw/xen: Validate grant copy segments against the
 page size
Date: Tue, 24 Nov 2026 23:22:32 +0000
Message-ID: <20261124232247.23169-7-dwmw2@infradead.org>
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

Reject a grant copy segment whose offset and length reach beyond the
granted page, matching Xen's GNTST_bad_copy_arg behaviour, in both the
emulated gnttab backend and the libxengnttab fallback. The only current
caller, xen-block, already bounds its segments to a single page.

Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
Fixes: c412ba47b2ec ("hw/xen: Add gnttab operations to allow redirection to internal emulation")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_gnttab.c | 10 ++++++++++
 hw/xen/xen-operations.c  | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 26d1febac4d..6e0038b22ff 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -473,6 +473,16 @@ static int xen_be_gnttab_copy(struct xengntdev_handle *xgt, bool to_domain,
         void *page;
         uint32_t ref = to_domain ? seg->dest.foreign.ref :
             seg->source.foreign.ref;
+        off_t offset = to_domain ? seg->dest.foreign.offset :
+            seg->source.foreign.offset;
+
+        if (offset < 0 || offset > XEN_PAGE_SIZE ||
+            seg->len > XEN_PAGE_SIZE - offset) {
+            if (errp) {
+                error_setg(errp, "grant copy segment out of page bounds");
+            }
+            return -EINVAL;
+        }
 
         page = xen_be_gnttab_map_refs(xgt, 1, domid, &ref, prot);
         if (!page) {
diff --git a/hw/xen/xen-operations.c b/hw/xen/xen-operations.c
index e00983ec447..bf0ec040bcf 100644
--- a/hw/xen/xen-operations.c
+++ b/hw/xen/xen-operations.c
@@ -50,6 +50,17 @@ static int libxengnttab_fallback_grant_copy(xengnttab_handle *xgt,
 
     for (i = 0; i < nr_segs; i++) {
         XenGrantCopySegment *seg = &segs[i];
+        off_t offset = to_domain ? seg->dest.foreign.offset :
+            seg->source.foreign.offset;
+
+        if (offset < 0 || offset > XEN_PAGE_SIZE ||
+            seg->len > XEN_PAGE_SIZE - offset) {
+            if (errp) {
+                error_setg(errp, "grant copy segment out of page bounds");
+            }
+            rc = -EINVAL;
+            goto done;
+        }
 
         refs[i] = to_domain ? seg->dest.foreign.ref :
             seg->source.foreign.ref;
-- 
2.43.0


