Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4379C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 08:44:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYLTs-0006tK-Oa; Thu, 16 Jan 2025 03:44:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYLTm-0006p1-8D; Thu, 16 Jan 2025 03:43:54 -0500
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org>)
 id 1tYLTg-0006nk-OV; Thu, 16 Jan 2025 03:43:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
 Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
 To:From:Reply-To:Content-ID:Content-Description;
 bh=9YnMqT9L5zpcIdMPGD+T5rZV+9M0PECfN24dS3f5adI=; b=QAhTn+9luHDcx4ZBpcWeH90OPD
 kUrxeCoetP1gumKPKrYKI0tOm+chuyObKhh8XsUWhf15Snreba/gTrp9g4OmorKfNLsrOLHPEUpWP
 PQ+WEsNZikrHtjPm+i/8KmuA1lmh2mEXDeBieo3/4G2hhT/FN+eykSgP6+rjuBL2ftHX8UAtx8ih5
 Bfcijh2bcxhKSL53SrxjdJIdyfwH/zccZnOt15oaxu+YZqIvHSP3CQoRNquwqLGot4MaBi9TKU+2A
 Uuz7NHdmOX8hnCLRLt6l7tmi54R1Ra25u9P6DxwUasWLonC7win3ViRVG9hZPpALXtbzuGHC9Y1cH
 T3091e/A==;
Received: from [2001:8b0:10b:1::ebe] (helo=i7.infradead.org)
 by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
 id 1tYLTd-0000000AkbV-0JOu; Thu, 16 Jan 2025 08:43:45 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.98 #2 (Red Hat
 Linux)) id 1tYLTc-00000007pI8-3Dc0; Thu, 16 Jan 2025 08:43:44 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>, Paul Durrant <paul@xen.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 David Woodhouse <dwmw@amazon.co.uk>,
 Anthony PERARD <anthony.perard@vates.tech>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Subject: [PULL 6/8] hw/xen: Use xs_node_read() from xenstore_read_str()
 instead of open-coding it
Date: Thu, 16 Jan 2025 08:43:30 +0000
Message-ID: <20250116084332.1864967-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250116084332.1864967-1-dwmw2@infradead.org>
References: <20250116084332.1864967-1-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
Received-SPF: none client-ip=2001:8b0:10b:1236::1;
 envelope-from=BATV+cabf69696ff47aa9dee2+7816+infradead.org+dwmw2@casper.srs.infradead.org;
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
Reviewed-by: Anthony PERARD <anthony.perard@vates.tech>
Acked-by: Roger Pau Monné <roger.pau@citrix.com>
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


