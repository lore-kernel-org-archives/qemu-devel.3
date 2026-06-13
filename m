Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18EEECD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYV80-0006DK-14; Sat, 13 Jun 2026 16:38:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7y-0005zS-3M; Sat, 13 Jun 2026 16:38:50 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYV7w-0003uE-Ba; Sat, 13 Jun 2026 16:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382964; bh=rWeJQo1BZj3/v/6iAk7Qi6eblFf1sDgGtXlKWB4QA7Y=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=aRbG9l5p4U/g3BQs9lHK1ckadYMBha8Phtd1vBi5KxrlfZl5PBw1gQcNumOFMW6XR
 zhc9oOEPZb708bRuJnr00KDFnjmvCWHdvFDANHAHJt5p0uLWaeKoFpQA8lGPfNoDdV
 gQEY6NS+fW2xMXfuJSe/D1d2xkpcVEBAj498hSH9lGjfW087rmFN7mbJgZ2NtmVe2u
 U7w6BwPoxCOXe+Lht8mKk0q33+FxtDkCz0bvqDzHahxPU3LwDRzIbUzPAmeFk7kCAv
 eRsWCFuY1Ei9/nYhQzPlNMk2uYDv6Z5nk1K7WAXQgrVOkptGl2b9ozCM5wRPRY0sJ6
 z+Yyd/zY2xhEQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3B8A21B6EF9;
 Sat, 13 Jun 2026 23:36:04 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id A33163CE94A;
 Sat, 13 Jun 2026 23:36:22 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, GuoHan Zhao <zhaoguohan@kylinos.cn>,
 John Levon <john.levon@nutanix.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 30/72] vfio-user: reject zero DMA page size capability
Date: Sat, 13 Jun 2026 23:34:56 +0300
Message-ID: <20260613203542.1809153-30-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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


