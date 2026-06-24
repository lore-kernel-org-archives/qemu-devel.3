Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E0FCDB481
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:37:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNls-0004bs-KN; Wed, 24 Jun 2026 09:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNll-0004GO-5v; Wed, 24 Jun 2026 09:36:00 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcNlh-0000qB-Vz; Wed, 24 Jun 2026 09:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782307997; bh=rWeJQo1BZj3/v/6iAk7Qi6eblFf1sDgGtXlKWB4QA7Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=XVp1eMBxHZ9OnYCD/8H8hmnpA4MeWUrmW5kesGk5Ypp0tigjTPUBwXXsUa2tJzvKD
 IREvQKGXDOaBAW55dbEouybYMCC2Pdaz9ZUXEGJoq/+ZxjBt8ZbUhDT2T8nWeNpFIg
 R/iDcGlX6E2qJrAsItC7vIr5wIbph0jWtgxf2lc1l+R3stkIIjxx67Yk1eU9SQ3YWH
 hlQsqruVE5cT70cCAJQ8bA3ZoD9Se3QP4PRoT0X9zM5mdXBR7QNAiQn4q0f5SuNjhc
 oIstZVStWCcg6Smnlz0ZPIhQeilDxvBCoO8VEVJHlZ4Gadpv0wTVT4/pMd0Q+WAJs4
 Jo/nxIZI1miSA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3407E1BA9D0;
 Wed, 24 Jun 2026 16:33:17 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id C36CA3DEA1F;
 Wed, 24 Jun 2026 16:33:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 030/107] vfio-user: reject zero DMA page size
 capability
Date: Wed, 24 Jun 2026 16:30:35 +0300
Message-ID: <20260624133301.403266-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260624163118@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: GuoHan Zhao <zhaoguohan@kylinos.cn>

check_pgsizes() validates that no page-size bits smaller than
VFIO_USER_DEF_PGSIZE are set, but it still accepts pgsizes=0. This lets a
malformed server overwrite the default page-size mask with zero.

Later vfio_user_setup() asserts that proxy->dma_pgsizes is non-zero, so device
realization aborts instead of reporting a version capability error. Reject a
zero DMA page-size mask during version capability parsing.

Fixes: 36227628d824 (vfio-user: implement message send infrastructure)
Signed-off-by: GuoHan Zhao <zhaoguohan@kylinos.cn>
Reviewed-by: John Levon <john.levon@nutanix.com>
Link: https://lore.kernel.org/qemu-devel/20260522081306.4186242-1-zhaoguohan@kylinos.cn
Signed-off-by: Cédric Le Goater <clg@redhat.com>
(cherry picked from commit ab89d02dac6f0f53e35a689f01099602aa2de816)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/vfio-user/proxy.c b/hw/vfio-user/proxy.c
index 314dfd23d8..3fe5b0138b 100644
--- a/hw/vfio-user/proxy.c
+++ b/hw/vfio-user/proxy.c
@@ -1155,9 +1155,11 @@ static bool check_pgsizes(VFIOUserProxy *proxy, QObject *qobj, Error **errp)
         return false;
     }
 
-    /* must be larger than default */
-    if (pgsizes & (VFIO_USER_DEF_PGSIZE - 1)) {
-        error_setg(errp, "pgsize 0x%"PRIx64" too small", pgsizes);
+    /* must not be zero or smaller than default */
+    if (pgsizes < VFIO_USER_DEF_PGSIZE ||
+        (pgsizes & (VFIO_USER_DEF_PGSIZE - 1))) {
+        error_setg(errp, "%s 0x%"PRIx64" too small",
+                   VFIO_USER_CAP_PGSIZES, pgsizes);
         return false;
     }
 
-- 
2.47.3


