Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0606606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:14:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVqLs-0007aX-MJ; Tue, 24 Nov 2026 08:14:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.brett@citrix.com>)
 id 1xVouI-0003De-DO
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:41:54 -0500
Received: from na1pdmzitismtp02.tibco.com ([160.101.131.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.brett@citrix.com>)
 id 1xVouG-0007dc-UF
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 06:41:54 -0500
Received: from mewpvdipd1100.citrite.net (unknown [10.113.40.46])
 by na1pdmzitismtp02.tibco.com (Postfix) with ESMTP id 86D8B84E0BB6;
 Tue, 24 Nov 2026 06:40:13 -0500 (EST)
To: qemu-devel@nongnu.org
Cc: Alex Brett <alex.brett@citrix.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 xen-devel@lists.xenproject.org
Subject: [PATCH] xen-mapcache: Fix a build error with -fexceptions
Date: Tue, 24 Nov 2026 11:41:26 +0000
Message-ID: <20261124114127.790173-1-alex.brett@citrix.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=160.101.131.9; envelope-from=alex.brett@citrix.com;
 helo=na1pdmzitismtp02.tibco.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:14:27 -0500
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Alex Brett <alex.brett@citrix.com>
From:  Alex Brett via qemu development <qemu-devel@nongnu.org>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

When building with -Werror=maybe-uninitialized and -fexceptions, gcc can
report:
error: 'err' may be used uninitialized [-Werror=maybe-uninitialized]

err gets assigned to g_new0() unconditionally, but under -fexceptions
the calls to trace_xen_remap_bucket() or g_new0() might unwind, leading
the g_autofree cleanup to run g_free() on an uninitialised err. Avoid
the warning and any future issues by initialising it to NULL in the same
pattern as other definitions.

Signed-off-by: Alex Brett <alex.brett@citrix.com>
---
 hw/xen/xen-mapcache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
index e30c07c2ee..0a19cfdc1b 100644
--- a/hw/xen/xen-mapcache.c
+++ b/hw/xen/xen-mapcache.c
@@ -199,7 +199,7 @@ static void xen_remap_bucket(MapCache *mc,
     uint8_t *vaddr_base;
     g_autofree uint32_t *refs = NULL;
     g_autofree xen_pfn_t *pfns = NULL;
-    g_autofree int *err;
+    g_autofree int *err = NULL;
     unsigned int i;
     hwaddr nb_pfn = size >> XC_PAGE_SHIFT;
 
-- 
2.53.0


