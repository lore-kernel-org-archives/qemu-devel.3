Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C63A9C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:39:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weCCj-0004NM-OP; Mon, 29 Jun 2026 09:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <64c6c7e0df726055fac9ed12b30f712b115193f3@kylie.crudebyte.com>)
 id 1weCCi-0004JF-ID; Mon, 29 Jun 2026 09:39:16 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <64c6c7e0df726055fac9ed12b30f712b115193f3@kylie.crudebyte.com>)
 id 1weCCg-0004Pk-SH; Mon, 29 Jun 2026 09:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=h5MqDz5GNrcRukA+fwCV4Ptg8NEURV8By00x0yDcRIo=; b=MRr73
 IKn44QatR3fFz4Zrz7BAv9LayFuEfN/50wrryU6A/qYGo3GCTh/I3CXNl5ZCUivLnju1hlz+xG5ZB
 NjXrLfuJMjE3ZR0gSsd1T6lMdEhBJZMHzz9+MPA8awYt0eUHTcsgrUEMHels0tKBWlKxN6ABDwuIy
 xb/m4Sgi9+y40AbfI08GExWenbbWtJ7fuWou2+Kow3FaB4EKZvLxYq9Hduaf6Y7VCh/NQ3QvsVUcA
 +WHXGffx5G0lczUBdsoGDoo8TPewxSUxboYtb757YXacvoWYxxEO1VdtKcrHUsYUPD9czBCi7Kr43
 F0m0upgWZBcOndzjEiaLiUIPENWsxHH88JUTRElM3xsCgbXAzsCaI4SFXBipqoZNP+iaroLzvY26s
 V+ConF/Kni9E/XriOJKs1lYKEpHl9KjtgChGkzbPNwQGmLhrzXcPRidPOO/PfwFWYQ4DLFeXvT4SP
 RfPtFCuky+OHeQEAhDfC+YpqgDaf0nIIyivSgEAt8Yu5ZaT5zFzaqCNhyVh27/9ZrbEGsxyyu+6OO
 7VSYVzsusfb9q7eWsesLqmm2SgW6NsIMFQLE4zcsBxPPSt1uEq6oPw8kbsM9d8KIFybF06zHRIVYd
 l2bF1mUj3IvsK6fiwXZcevLhZpcb0NdwPqODYXsCxG7xGqTTPwXfw0Yd9lNIII=;
Message-ID: <64c6c7e0df726055fac9ed12b30f712b115193f3.1782739719.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1782739719.git.qemu_oss@crudebyte.com>
References: <cover.1782739719.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Mon, 29 Jun 2026 15:28:39 +0200
Subject: [PULL 08/23] hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=64c6c7e0df726055fac9ed12b30f712b115193f3@kylie.crudebyte.com;
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

Constrain max_count in v9fs_readdir() to transport's current, real
response buffer size before calling v9fs_do_readdir() to prevent
excessive host memory allocation for specific, crafted, huge
directories (large amount of entries) by bad clients.

Client may send a Treaddir request with a large 'count' parameter, and
while the negotiated 'msize' provides some limit, it accounts for guest
being somewhat faithful on the negotiated 'msize' value throughout the
session.

A bad guest client could have negotiated a large 'msize' but provide a
small reply buffer for Treaddir request, causing QEMU to allocate host
memory proportional to 'msize' before discovering the reply cannot fit.

Possible consequence was a potential DoS by a priviliged guest, causing
a disconnection of guest communication due to transport device being
marked as "broken", however QEMU process would have continued to run with
potentially giant host memory allocation, which might have negative
impact on other services running on host.

Fixes: CVE-2026-9238
Fixes: 2149675b195f ("9pfs: add new function v9fs_co_readdir_many()")
Reported-by: Feifan Qian <bea1e@proton.me>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
Link: https://lore.kernel.org/qemu-devel/f81a387a2de4f2172fd5830c5654f49d78102254.1781287774.git.qemu_oss@crudebyte.com
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 81d9bb8c6d..09454a5404 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2679,6 +2679,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     uint32_t max_count;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
+    size_t max_resp_sz;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
@@ -2687,9 +2688,28 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     }
     trace_v9fs_readdir(pdu->tag, pdu->id, fid, initial_offset, max_count);
 
+    max_resp_sz = s->msize;
+
+    /*
+     * Constrain max_count to transport's current, actual response buffer size.
+     * A bad client might provide a response buffer < msize.
+     */
+    if (s->transport->response_buffer_size) {
+        size_t buf_size = s->transport->response_buffer_size(pdu);
+        if (max_resp_sz > buf_size) {
+            max_resp_sz = buf_size;
+        }
+    }
+
     /* Enough space for a R_readdir header: size[4] Rreaddir tag[2] count[4] */
-    if (max_count > s->msize - 11) {
-        max_count = s->msize - 11;
+    if (max_resp_sz > 11) {
+        max_resp_sz -= 11;
+    } else {
+        max_resp_sz = 0;
+    }
+
+    if (max_count > max_resp_sz) {
+        max_count = max_resp_sz;
         warn_report_once(
             "9p: bad client: T_readdir with count > msize - 11"
         );
-- 
2.47.3


