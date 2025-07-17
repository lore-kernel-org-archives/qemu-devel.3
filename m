Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5254C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 09:59:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucLGP-0004BZ-KE; Thu, 17 Jul 2025 05:50:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0g-0001uO-4m; Thu, 17 Jul 2025 05:34:48 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1ucL0e-0001pe-F5; Thu, 17 Jul 2025 05:34:37 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id D966A137CF1;
 Thu, 17 Jul 2025 12:34:04 +0300 (MSK)
Received: from think4mjt.origo (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id B0D892491EB;
 Thu, 17 Jul 2025 12:34:12 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anastasia Belova <nabelova31@gmail.com>,
 Ilya Maximets <i.maximets@ovn.org>, Jason Wang <jasowang@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.3 49/65] net: fix buffer overflow in af_xdp_umem_create()
Date: Thu, 17 Jul 2025 12:33:45 +0300
Message-ID: <20250717093412.728292-10-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
References: <qemu-stable-10.0.3-20250717113032@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Anastasia Belova <nabelova31@gmail.com>

s->pool has n_descs elements so maximum i should be
n_descs - 1. Fix the upper bound.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: cb039ef3d9 ("net: add initial support for AF_XDP network backend")
Cc: qemu-stable@nongnu.org
Reviewed-by: Ilya Maximets <i.maximets@ovn.org>
Signed-off-by: Anastasia Belova <nabelova31@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit 110d0fa2d4d1f754242f6775baec43776a9adb35)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/net/af-xdp.c b/net/af-xdp.c
index 01c5fb914e..d022534d76 100644
--- a/net/af-xdp.c
+++ b/net/af-xdp.c
@@ -323,7 +323,7 @@ static int af_xdp_umem_create(AFXDPState *s, int sock_fd, Error **errp)
 
     s->pool = g_new(uint64_t, n_descs);
     /* Fill the pool in the opposite order, because it's a LIFO queue. */
-    for (i = n_descs; i >= 0; i--) {
+    for (i = n_descs - 1; i >= 0; i--) {
         s->pool[i] = i * XSK_UMEM__DEFAULT_FRAME_SIZE;
     }
     s->n_pool = n_descs;
-- 
2.47.2


