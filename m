Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A266ECD98D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:01:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY77G-0001Al-5B; Fri, 12 Jun 2026 15:00:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2105e9a3578c6f751bb64af55c16dd953f393f20@kylie.crudebyte.com>)
 id 1wY77E-0001AT-RI; Fri, 12 Jun 2026 15:00:28 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <2105e9a3578c6f751bb64af55c16dd953f393f20@kylie.crudebyte.com>)
 id 1wY77D-0000LE-DD; Fri, 12 Jun 2026 15:00:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=EdZ3qDjoTlsu0Vpm6oK1beSP8+9sfvWnMcVTHk6OlsI=; b=WdsRK
 th2+EZcmBKwGsMSsdNz/cR7TbjWd5zMFKyTgdhp1s/Tkm2pWeTOBWHgCOrdQqhRuWAWk/v+Dxt/S5
 b1/XrOYo/AN0KrvSsjO8OEzAJFYMZf0IqX5y0VpKIu4zLxd2FDzj2lv1YHVIoFZLnhpFyEmrt0jM9
 1BNvPThKR+tTULt61IowZmWrhwNr1VlPhGla8kckppjRZp0b5iS8SmXdaSzfeBUld6Yu8cvF+hpoj
 RP2/t73OwvZkN+X0y/V74tocxMrUUlMIMHJVYuy3N9fxGxPTLJLp/tKXEwTsUcuJC9nBkovKFwIF7
 Bb9fd3L2oKblZFhNWnVg6q3eH4044wKPcDLgHCZzNEO8o2Wzhp8I/L5vkNfQ8DVWxplDGyYN5dxly
 r79YV83vgWgkbN8ZHAWIfAZZBWd0KKT3QuEM8BTNwihggHyGA3pdg47yLmRFLKzYklLEqQITTfSzK
 uROlclKQX66UxrXXnx2yDSGe7jNItiicpppF0StGM+U1zQIyqNLDFTKuAc6sJPoeeCZCHU0xELfVS
 hPQXr/+rGGcB4jjn4pQhJw2RSm+K10u5SWvcAX5iErdl/ZpGF6Q6XamTa18579o979Tln+IXAPQJH
 lrj1SfMoXP6RZ7We0L+GdhNO2qXl6SL54rMUGCrKHANmizS75jGM+ocZ1+qxLI=;
Message-ID: <2105e9a3578c6f751bb64af55c16dd953f393f20.1781287774.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781287774.git.qemu_oss@crudebyte.com>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 12 Jun 2026 20:22:52 +0200
Subject: [PATCH v2 4/8] hw/9pfs: cap negotiated msize to transport limit
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=2105e9a3578c6f751bb64af55c16dd953f393f20@kylie.crudebyte.com;
 helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index e2713b9eee..2bb42dfc2e 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1456,6 +1456,16 @@ static void coroutine_fn v9fs_version(void *opaque)
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


