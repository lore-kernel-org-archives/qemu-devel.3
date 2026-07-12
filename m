Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C846DC43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:17:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilcu-0002a3-65; Sun, 12 Jul 2026 00:17:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcT-0001gj-3f; Sun, 12 Jul 2026 00:16:47 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilcQ-0006G9-3R; Sun, 12 Jul 2026 00:16:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829780; bh=jQZ6mYPMk9HPQRINxHHqnJ2IAXWLkbOOp0Mtbm4nOIY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xWifgLVc6hw937ZHolMxtV0XdHw1vSJKBoWkAurcbNqWr5FWUL9hW4j4dT1KEO3g3
 tIYfKSd3h+a1l0O7LyWT3udDjCAgNEls4r+U0zB2arinfWo/shln/sLuA1+7TJjMM/
 S4L0UX5uJR32fg3EoW1JtDSlH31uY3+53fa5GOCw5sbFBsWKwWlLmmSUz2BDpKBBul
 KqtuFtIDe63h5k6et4fky9UZdU8U41Nd+nXMMhW/jQsBEWey/FmFCONJoOIOxlRNdO
 SjLzPf0E0godvM5Mh7WMvVvRKQqTEpsC+XbzSACV5tz0Aork2T9a3jgsMNFdC86OpL
 4iwUzyBOS4Sng==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C59E11C0BE3;
 Sun, 12 Jul 2026 07:16:20 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0400E3EB943;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 2760A133C9; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 08/75] hw/9pfs: cap negotiated msize to transport
 limit
Date: Sun, 12 Jul 2026 07:14:26 +0300
Message-ID: <20260712041539.108341-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Christian Schoenebeck <qemu_oss@crudebyte.com>

The 'msize' parameter negotiated during Tversion handshake can be
arbitrarily large as requested by the guest. So far 9p server accepted
any msize value suggested by guest, i.e. server did not cap it at all,
no matter how large, as in practice the upper limit of msize is a client
capability. But as subsequent's security patch shows, capping msize on
server side makes sense as additional safety-net.

Let's cap msize to transport's theoretical limit for msize, mainly to
prevent a bad client from triggering excessive host memory allocations
throughout the session.

We intentionally don't cap msize to transport's current, real response
buffer size, as the response buffer size may vary between individual
requests.

Link: https://lore.kernel.org/qemu-devel/2105e9a3578c6f751bb64af55c16dd953f393f20.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
(cherry picked from commit bb5ab96e35a1b13a2485d239a44ff2d040e9b337)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 52806670235..f0bc1d71706 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1459,6 +1459,16 @@ static void coroutine_fn v9fs_version(void *opaque)
         goto out;
     }
 
+    /* cap msize to transport's theoretical limit */
+    if (s->transport->msize_limit) {
+        size_t limit = s->transport->msize_limit(s);
+        if (s->msize > limit) {
+            s->msize = limit;
+            warn_report_once("9p: client msize capped to %zu (transport limit)",
+                             limit);
+        }
+    }
+
     /* 8192 is the default msize of Linux clients */
     if (s->msize <= 8192 && !(s->ctx.export_flags & V9FS_NO_PERF_WARN)) {
         warn_report_once(
-- 
2.47.3


