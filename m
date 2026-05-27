Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E35CD5BD0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMI4-0003U3-7N; Wed, 27 May 2026 17:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1ad1adf0d426c7d2a326954ade789298834ce6dd@kylie.crudebyte.com>)
 id 1wSMI2-0003Tc-Q3; Wed, 27 May 2026 17:59:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <1ad1adf0d426c7d2a326954ade789298834ce6dd@kylie.crudebyte.com>)
 id 1wSMI1-0004Gb-DN; Wed, 27 May 2026 17:59:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=EdZ3qDjoTlsu0Vpm6oK1beSP8+9sfvWnMcVTHk6OlsI=; b=i+D/K
 mTe+R5bznT/amaE/MBl8chawLgMUSPqrzMp3UzqLQSL4bgJV3JCiFS6yWaKH51Wg5joGZcJJjmCIX
 g7Z+32J60QEJfy0OFhRrOBkDuiirodRhPQah5bR9CnnnfwbkpUffTrO1m/bLlIPDRIbeKJkl6eiWL
 bqf1Rg0OeBp4DlCDd7UA0LHGLSIbybN5mZBJ0AC3EfipoZSVF576Bos59ZnpZ4QPPOROn48JOpBnr
 YvcpW49NWBK5qFgk5dVTyTtkF99UwHqlEtfNVzJnrOwNkcQ5vEEh9yqNvTUz1cgJztUi0kzQsbHuM
 S9MbZw+W3D2wL04p/GfmBNNpxW6Pb/IQhSHLbzZ7VEL77PaTJBnDsZZ3pfCbjDQrZC7QLbV/OFVVS
 EdA1mqNpluHQCSpR/OnfqAe+c6bE7myB5hjpbBDNIyuLkE0mKZqMy0fcOJ2G3Q4A2FuPEE7gDFu6W
 OhR9mTx615gL4XWtybpwqVzARxvrRsozPUVaVYXbCQTL1IC19NIbq4DnLymhHraFDeOE0WML2ghp8
 7dJCwel1yZAVN2yjowXqX79RcK7urTELh/fGYDIhCyM2dJ+rOzpxmNu5w9HcInwcwCVxKGRZCJb9G
 zdycVizQFjvJ9yv2McEnBXSD1YsDHqiWqRLbcdV5k5H7HPdz4UU67X05hUKtVo=;
Message-ID: <1ad1adf0d426c7d2a326954ade789298834ce6dd.1779916560.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 27 May 2026 23:15:28 +0200
Subject: [PATCH 4/8] hw/9pfs: cap negotiated msize to transport limit
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=1ad1adf0d426c7d2a326954ade789298834ce6dd@kylie.crudebyte.com;
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


