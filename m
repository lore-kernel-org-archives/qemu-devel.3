Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91EECD98D2
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 19:01:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wY77A-00018v-FR; Fri, 12 Jun 2026 15:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f81a387a2de4f2172fd5830c5654f49d78102254@kylie.crudebyte.com>)
 id 1wY779-00018F-2i; Fri, 12 Jun 2026 15:00:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <f81a387a2de4f2172fd5830c5654f49d78102254@kylie.crudebyte.com>)
 id 1wY777-0000KS-Gb; Fri, 12 Jun 2026 15:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=9Ly3p2SFfCcPy7GWSz0ag36rm1I3UTgEr6JUOkLsvo0=; b=ie23g
 c5my1j2/cPK6iMLYZECRLwPkenNb6BsQZ7HYYH3GDf28pa6DB+M88MPuXNP5xYJhq08MuhskJPUlI
 y1atL5wQ/N0TL9RgiTbyFREU9OwT75YX38YB/bVnEio9nRpYZm0R8qZPWbpKfYP2PDmkswszOp5X9
 Om7AeY+lJuxQEYfumQwJMaZSAWOWhuLi3xISWgDQ0Tz3I4f1Vs0aF3hdl+4OLFbOYv3z41f2AvET5
 7mLQ2bIIxJB51RSPtVLMNNR8uraD0J3VGyw8xJmSRrGu1IFsyXCayRWUbBbbfWvFpmr8syOrHdYXa
 ly5a8Z3/BweOhUqk0BWSN6kcieebVuW+ldji67Zd2EHY2X5AVjxLDeBIcdBTiuXFJytlFpyYI5K/x
 Xrc6dUTXUm/cp7VWXX/h+qCqbFWhdJWm/w8u9TcRwCaYgNObbGdhRduON4Q8Zdsz3vMnDzq+usPOn
 JNXNtSTlOu9SwEPm3zOxPBrouK+fx6iXTM01jmIqlF5DEh44DzyRPQqvKtFz1xhvRCQPPdJyr6emd
 1tqwXulhzoiDhGIKS3IiVuN/I9OOjljL/XIKl/dfav2RSEFX28zGdsXGyBRZMqd3OqOhLtr9Apq2E
 RuVCKu/chlUpaHHV6KxrpGZJRHSeFOr4nJltiDPcpV8BMidtsHyzP/UmA16eS4=;
Message-ID: <f81a387a2de4f2172fd5830c5654f49d78102254.1781287774.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1781287774.git.qemu_oss@crudebyte.com>
References: <cover.1781287774.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 12 Jun 2026 20:22:52 +0200
Subject: [PATCH v2 8/8] hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=f81a387a2de4f2172fd5830c5654f49d78102254@kylie.crudebyte.com;
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
Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
---
 hw/9pfs/9p.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 2bb42dfc2e..c3e78779b7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2652,6 +2652,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     uint32_t max_count;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
+    size_t max_resp_sz;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
@@ -2660,9 +2661,28 @@ static void coroutine_fn v9fs_readdir(void *opaque)
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


