Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA581E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 10:04:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWBrl-0000f7-JY; Fri, 10 Jan 2025 05:03:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+4d36ee5d223a5d86d66e+7810+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tWBrd-0000Gf-G5; Fri, 10 Jan 2025 05:03:39 -0500
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+4d36ee5d223a5d86d66e+7810+infradead.org+dwmw2@desiato.srs.infradead.org>)
 id 1tWBra-0003rI-8X; Fri, 10 Jan 2025 05:03:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Reply-To:Content-Type:Content-ID:Content-Description;
 bh=X9zPJARrpqAjJWmqv/5Ourv8FRQelInhZmfRvKOuCvE=; b=p5CUhAGkiy/Ab65rEyWrr+bC/e
 R4Ww/x6oWNsGbvYIgqh5v++zG7YpiB1LauJCN+l1yK41FHft1fOgE827KN8mn5K86vqq5SjIeuXCd
 bgp7f5nxwT8i+ZnrXi0Y5fEz8FVeKd//w+GOwvb8LQ8dabPvo8a3iIRfpsbIv9PfkJo+S7BvIHFrj
 qJN/KjsRxXLXyaKzrdaOjcZHSkeVLD8Hv372ooE7E/nLi1VrLMX2xwcbIXQYZqsMC/I9QsNnJgAxO
 nOSa7L3UXpZTqvNbm6BCBHR4iiTfk9fWDDIqALBv4mtUQDVA24+8hsBJxzDunP4dqviW7pntf1GuT
 3xsgmF0Q==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tWBrT-00000009jwm-47GC; Fri, 10 Jan 2025 10:03:28 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tWBrS-00000002D8J-41Ad; Fri, 10 Jan 2025 10:03:26 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Roger Pau Monne <roger.pau@citrix.com>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, xen-devel@lists.xenproject.org,
 qemu-block@nongnu.org
Subject: [PATCH 4/4] hw/xen: Use xs_node_read() from xenstore_read_str()
 instead of open-coding it
Date: Fri, 10 Jan 2025 10:03:26 +0000
Message-ID: <20250110100326.527101-4-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250110100326.527101-1-dwmw2@infradead.org>
References: <fc9b22c55eaaa79a3ef9829c270bc4b4e93be7a0.camel@infradead.org>
 <20250110100326.527101-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 desiato.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05;
 envelope-from=BATV+4d36ee5d223a5d86d66e+7810+infradead.org+dwmw2@desiato.srs.infradead.org;
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: David Woodhouse <dwmw@amazon.co.uk>

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 hw/xen/xen_pvdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/hw/xen/xen_pvdev.c b/hw/xen/xen_pvdev.c
index c5ad71e8dc..c9143ba259 100644
--- a/hw/xen/xen_pvdev.c
+++ b/hw/xen/xen_pvdev.c
@@ -22,6 +22,7 @@
 #include "qemu/main-loop.h"
 #include "hw/qdev-core.h"
 #include "hw/xen/xen-legacy-backend.h"
+#include "hw/xen/xen-bus-helper.h"
 #include "hw/xen/xen_pvdev.h"
 
 /* private */
@@ -81,12 +82,9 @@ int xenstore_write_str(const char *base, const char *node, const char *val)
 
 char *xenstore_read_str(const char *base, const char *node)
 {
-    char abspath[XEN_BUFSIZE];
-    unsigned int len;
     char *str, *ret = NULL;
 
-    snprintf(abspath, sizeof(abspath), "%s/%s", base, node);
-    str = qemu_xen_xs_read(xenstore, 0, abspath, &len);
+    str = xs_node_read(xenstore, 0, NULL, NULL, "%s/%s", base, node);
     if (str != NULL) {
         /* move to qemu-allocated memory to make sure
          * callers can safely g_free() stuff. */
-- 
2.47.0


