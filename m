Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 342EA606A685
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 23:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=TwVely/1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVzrK-0000rQ-WB; Tue, 24 Nov 2026 18:23:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqz-0000cA-U3
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:13 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+8ed7664ba4dc972f2276+8493+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1xVzqv-0006zl-Js
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 18:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=CuCNOHrw3g5kpN0eJlwQJDa3PSDtkFSPqrd1YVfbUH4=; b=TwVely/1oU3dXIXs/wYs9bg3V7
 v9Nr5aM4ZZiTZw6SLi74DnVzy7ZBLWoznl+XKvXaln4y2FdYnT0A/ILwNp339CIgT4I9CXALgwjqr
 RmjtdBRxqB8aHygJAbNoXA6G/wDDL31jtfoJVbbHAXaI1pRLBnqN61POd36Gsowg6z3q8bqh1Ig2m
 sTO3i7pWZyUfcogkMXBaC7pZIGcqziE/qAUQMWr8gYJcBXXwm+1hPKpHx6TTSD3Ly12Abn0Ykl4lu
 vz/j8JhOcbDhaphlqd+SmhmMpa0l7TWz3MUd5V9g6H3d+NIIQn34Vt8a/F6vyXfAkEUOPTIzQ8kHp
 Yhgu418Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
 id 1xVzqc-00000004eUx-1kJG; Tue, 24 Nov 2026 23:22:58 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red
 Hat Linux)) id 1xVzqZ-00000000622-1Xjf;
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
Subject: [PATCH v1 05/21] hw/i386/kvm/xen_gnttab: Fix error handling in
 xen_be_gnttab_map_refs()
Date: Tue, 24 Nov 2026 23:22:31 +0000
Message-ID: <20261124232247.23169-6-dwmw2@infradead.org>
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
X-Spam-Status: No, score=-21.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: David Woodhouse <dwmw@amazon.co.uk>

When the grant's target page cannot be mapped, the failure path calls
gnt_unref(), which asserts that the map_track[] refcount is non-zero —
but the refcount was only incremented after a successful mapping. Take
the reference as soon as gnt_ref() succeeds, so the failure path stays
balanced.

Refuse writable mappings, including a write upgrade of an existing
mapping, when the underlying memory region is read-only, and set errno
when the upgrade fails.

Fixes: b08d88e30f06 ("hw/xen: Add emulated implementation of grant table operations")
Reported-by: Hui Peng <benquike@gmail.com>
Closes: https://gitlab.com/qemu-project/qemu/-/work_items/4525
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/i386/kvm/xen_gnttab.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/hw/i386/kvm/xen_gnttab.c b/hw/i386/kvm/xen_gnttab.c
index 85b324e62d0..26d1febac4d 100644
--- a/hw/i386/kvm/xen_gnttab.c
+++ b/hw/i386/kvm/xen_gnttab.c
@@ -363,7 +363,9 @@ static void *xen_be_gnttab_map_refs(struct xengntdev_handle *xgt,
     act = g_hash_table_lookup(xgt->active_maps, GINT_TO_POINTER(refs[0]));
     if (act) {
         if ((prot & PROT_WRITE) && !(act->prot & PROT_WRITE)) {
-            if (gnt_ref(s, refs[0], prot) == INVALID_GPA) {
+            if (act->mrs.readonly ||
+                gnt_ref(s, refs[0], prot) == INVALID_GPA) {
+                errno = EINVAL;
                 return NULL;
             }
             act->prot |= PROT_WRITE;
@@ -376,12 +378,19 @@ static void *xen_be_gnttab_map_refs(struct xengntdev_handle *xgt,
             return NULL;
         }
 
+        /*
+         * Keep the map_track[] count balanced with the gnt_unref() in the
+         * failure path below, which asserts that it never underflows.
+         */
+        s->map_track[refs[0]]++;
+
         act = g_new0(struct active_ref, 1);
         act->prot = prot;
         act->refcnt = 1;
         act->mrs = memory_region_find(get_system_memory(), gpa, XEN_PAGE_SIZE);
 
         if (act->mrs.mr &&
+            !(act->mrs.readonly && (prot & PROT_WRITE)) &&
             !int128_lt(act->mrs.size, int128_make64(XEN_PAGE_SIZE)) &&
             memory_region_get_ram_addr(act->mrs.mr) != RAM_ADDR_INVALID) {
             act->virtaddr = qemu_map_ram_ptr(act->mrs.mr->ram_block,
@@ -394,7 +403,6 @@ static void *xen_be_gnttab_map_refs(struct xengntdev_handle *xgt,
             return NULL;
         }
 
-        s->map_track[refs[0]]++;
         g_hash_table_insert(xgt->active_maps, GINT_TO_POINTER(refs[0]), act);
     }
 
-- 
2.43.0


