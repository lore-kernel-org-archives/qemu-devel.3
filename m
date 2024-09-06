Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE1BCD5BDD
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 05:19:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smRLu-0005tA-BJ; Fri, 06 Sep 2024 01:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRL6-0003va-8W; Fri, 06 Sep 2024 01:17:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smRL3-0007l0-OS; Fri, 06 Sep 2024 01:16:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 61F638C118;
 Fri,  6 Sep 2024 08:15:16 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 1260B13335E;
 Fri,  6 Sep 2024 08:16:34 +0300 (MSK)
Received: (nullmailer pid 10396 invoked by uid 1000);
 Fri, 06 Sep 2024 05:16:33 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Zheyu Ma <zheyuma97@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-7.2.14 04/40] hw/nvme: fix memory leak in nvme_dsm
Date: Fri,  6 Sep 2024 08:15:52 +0300
Message-Id: <20240906051633.10288-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
References: <qemu-stable-7.2.14-20240906080824@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Zheyu Ma <zheyuma97@gmail.com>

The allocated memory to hold LBA ranges leaks in the nvme_dsm function. This
happens because the allocated memory for iocb->range is not freed in all
error handling paths.

Fix this by adding a free to ensure that the allocated memory is properly freed.

ASAN log:
==3075137==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 480 byte(s) in 6 object(s) allocated from:
    #0 0x55f1f8a0eddd in malloc llvm/compiler-rt/lib/asan/asan_malloc_linux.cpp:129:3
    #1 0x7f531e0f6738 in g_malloc (/lib/x86_64-linux-gnu/libglib-2.0.so.0+0x5e738)
    #2 0x55f1faf1f091 in blk_aio_get block/block-backend.c:2583:12
    #3 0x55f1f945c74b in nvme_dsm hw/nvme/ctrl.c:2609:30
    #4 0x55f1f945831b in nvme_io_cmd hw/nvme/ctrl.c:4470:16
    #5 0x55f1f94561b7 in nvme_process_sq hw/nvme/ctrl.c:7039:29

Cc: qemu-stable@nongnu.org
Fixes: d7d1474fd85d ("hw/nvme: reimplement dsm to allow cancellation")
Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit c510fe78f1b7c966524489d6ba752107423b20c8)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 027d67f10b..ed56ad40b3 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2465,6 +2465,7 @@ next:
 done:
     iocb->aiocb = NULL;
     iocb->common.cb(iocb->common.opaque, iocb->ret);
+    g_free(iocb->range);
     qemu_aio_unref(iocb);
 }
 
-- 
2.39.2


