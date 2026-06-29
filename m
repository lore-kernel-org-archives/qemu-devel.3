Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B2BC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:38:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCBz-00018e-G2; Mon, 29 Jun 2026 09:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bb5ab96e35a1b13a2485d239a44ff2d040e9b337@kylie.crudebyte.com>)
 id 1weCBp-0000wD-6v; Mon, 29 Jun 2026 09:38:22 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <bb5ab96e35a1b13a2485d239a44ff2d040e9b337@kylie.crudebyte.com>)
 id 1weCBn-0003rS-LH; Mon, 29 Jun 2026 09:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=i43SCueMoWvURGj8J0iCCYrIkTESVe+MuGlxVyCSnZ0=; b=MuB7e
 IXv68qPIyKuwYx3bnBsdmJ5FVjdIJsWMzKnD2Ap5aZOjR43uneuKm2ZJzkWN6GmITLYILCQ8nGPNA
 i/cXCdk2R1P2AIJnhzaiBbLzEWjwYkKzKtWNsyDMnHdbohBMRdntO+yqCkEtyf8FnTwQeEGd275im
 lc0ZVa0Rpcj9dTS8BpK6e7TvbAT6t4dNBnPqxgJ9SEwqzNAJpLHhlDek9sR58I1xsHTcCUQoN2W/m
 CDIDsyDPgKwKE5nnK+ewkdqElYi+DRqbfjaCxd+kW/4uibw6YsUPdo9IctvzUv/iXjqk8Acd09mN9
 T8jwwvYYGxB7LKbu204TlPJhGS43/b4iYk5+i26Jc/nCTJMWuPUJPpH5nmvaho/twH8YgIsBRU7Ku
 Y0J7PvMu2tIRm9h5H2vIgUCQiVRGQUbWH/gDJWOUhoYFO6ul9O/mmHj2PjN5S1CAmqFP/bEc5Cnd6
 pNVD9fU1afjLwU2sNF7lrdjVlXTeH3pJdlTlHiT2pCdAracVlJXuUS0iKGzYGh9DIzPXXOJH6Aobi
 KPFb2f0KuatPE60Fb0s+i6lcRFZpFw82e6tWEu0CA2V8igM4PLfEv1YYv/hfQ64E2yqL3icvvGaKQ
 RcvBUw9HwChl5e//oaU5YFMyJaRd/Ecczloz2xTgODk1/oCusU+UigrxQaGr6s=;
Message-ID: <bb5ab96e35a1b13a2485d239a44ff2d040e9b337.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 04/23] hw/9pfs: cap negotiated msize to transport limit
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=bb5ab96e35a1b13a2485d239a44ff2d040e9b337@kylie.crudebyte.com;
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

Link: https://lore.kernel.org/qemu-devel/2105e9a3578c6f751bb64af55c16dd953f393f20.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index b486cce48a..81d9bb8c6d 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -1469,6 +1469,16 @@ static void coroutine_fn v9fs_version(void *opaque)
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


