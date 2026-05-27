Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CC9CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2026 22:01:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSMIJ-0003c3-A1; Wed, 27 May 2026 18:00:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6c22c43668b995a71b0880bd146f09ae5f8956cc@kylie.crudebyte.com>)
 id 1wSMIH-0003ah-6K; Wed, 27 May 2026 18:00:05 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <6c22c43668b995a71b0880bd146f09ae5f8956cc@kylie.crudebyte.com>)
 id 1wSMIE-0004JP-Vi; Wed, 27 May 2026 18:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Cc:To:Subject:Date:From:References:In-Reply-To:
 Message-ID:Content-Type:Content-Transfer-Encoding:MIME-Version:Content-ID:
 Content-Description; bh=bar1ZvbeEGhuOT8R2wzB63jOK0AYZp0wI2ky+M1cNd0=; b=UsAVg
 mj/2WCZk1BBTxiP90OR389LUY69ATNap812HcdvgNeAadPz7VTkdyW72T6XG/biPSlHWJDtnIYE5P
 AUL9EEmpFzem/Bf7IG7qP/MqW3ZeQ4tK/anrEohNwlZx0fhUfqp1FPt/rgIwpMx+x9tWDU2+1VCv1
 LrBXdq1SpWG+6mqI4jzCs/OqYqaStwRz2bNcRI7myc9Hjci/RIQVDnA2I/ZOXfAkfMJjkmhUAeTZy
 1ETFmYgsksgoTaTgt8Ce+FlP+OTZ2spJyhlAkf6H7QntPMFAXluuMAzmjhJt1YvanuO3Ng3By/STS
 hE2x6UmMAbkuRxBrePTNvj7GjeDUz26blIp0w9ELaGVceNhuKA8AOD87ciNpUP2R0mlW4yNzJcydd
 HbC/pc9XYPshQrnFdwsE3vb5hfW7hMrvS9pULGnOxJX7TUGFB6qwpmx4obAidpdCo4ySheeD8GqZz
 OE6f3KPG4p1MtAsu/4GZnT/s3vAr0Ifx1aI4kaR82ZnsWkN7Uz4MFebGIRkpNbK1Fd19XGi3HPc5I
 ztOpxtqJUajqPAk7B1kpSGYzce9Gt/TWBT7UWC/gxb7dot9BExZ1ZPifubWX5j4pE7usGUWb3L8/S
 +HCheTuBq9uRzApY0WisUw0wiFM+T7xzZ4yjhZwj59j732H3pelbvf3+7kaCQY=;
Message-ID: <6c22c43668b995a71b0880bd146f09ae5f8956cc.1779916560.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1779916560.git.qemu_oss@crudebyte.com>
References: <cover.1779916560.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Wed, 27 May 2026 23:15:41 +0200
Subject: [PATCH 8/8] hw/9pfs: cap Treaddir allocation (CVE-2026-9238)
To: qemu-devel@nongnu.org,
    qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=6c22c43668b995a71b0880bd146f09ae5f8956cc@kylie.crudebyte.com;
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
excessive host memory allocation by bad clients.

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
 hw/9pfs/9p.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 2bb42dfc2e..fa8c7243a7 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -2652,6 +2652,7 @@ static void coroutine_fn v9fs_readdir(void *opaque)
     uint32_t max_count;
     V9fsPDU *pdu = opaque;
     V9fsState *s = pdu->s;
+    size_t max_resp_sz;
 
     retval = pdu_unmarshal(pdu, offset, "dqd", &fid,
                            &initial_offset, &max_count);
@@ -2660,9 +2661,22 @@ static void coroutine_fn v9fs_readdir(void *opaque)
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
+    if (max_count > max_resp_sz - 11) {
+        max_count = max_resp_sz - 11;
         warn_report_once(
             "9p: bad client: T_readdir with count > msize - 11"
         );
-- 
2.47.3


