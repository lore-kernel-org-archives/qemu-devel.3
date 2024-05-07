Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A83BC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 08:44:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4GQg-0006HM-Jp; Tue, 07 May 2024 04:44:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GQ6-0004Ol-Gd; Tue, 07 May 2024 04:43:33 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1s4GQ1-0003GV-26; Tue, 07 May 2024 04:43:28 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 49D0064BD0;
 Tue,  7 May 2024 11:42:49 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 39AB4C85B9;
 Tue,  7 May 2024 11:42:30 +0300 (MSK)
Received: (nullmailer pid 1026549 invoked by uid 1000);
 Tue, 07 May 2024 08:42:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jeuk Kim <jeuk20.kim@samsung.com>,
 Zheyu Ma <zheyuma97@gmail.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.4 12/16] hw/ufs: Fix buffer overflow bug
Date: Tue,  7 May 2024 11:42:11 +0300
Message-Id: <20240507084226.1026455-12-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
References: <qemu-stable-8.2.4-20240506205855@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

It fixes the buffer overflow vulnerability in the ufs device.
The bug was detected by sanitizers.

You can reproduce it by:

cat << EOF |\
qemu-system-x86_64 \
-display none -machine accel=qtest -m 512M -M q35 -nodefaults -drive \
file=null-co://,if=none,id=disk0 -device ufs,id=ufs_bus -device \
ufs-lu,drive=disk0,bus=ufs_bus -qtest stdio
outl 0xcf8 0x80000810
outl 0xcfc 0xe0000000
outl 0xcf8 0x80000804
outw 0xcfc 0x06
write 0xe0000058 0x1 0xa7
write 0xa 0x1 0x50
EOF

Resolves: #2299
Fixes: 329f16624499 ("hw/ufs: Support for Query Transfer Requests")
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Signed-off-by: Jeuk Kim <jeuk20.kim@samsung.com>
(cherry picked from commit f2c8aeb1afefcda92054c448b21fc59cdd99db30)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/ufs/ufs.c b/hw/ufs/ufs.c
index eccdb852a0..bac78a32bb 100644
--- a/hw/ufs/ufs.c
+++ b/hw/ufs/ufs.c
@@ -126,6 +126,10 @@ static MemTxResult ufs_dma_read_req_upiu(UfsRequest *req)
     copy_size = sizeof(UtpUpiuHeader) + UFS_TRANSACTION_SPECIFIC_FIELD_SIZE +
                 data_segment_length;
 
+    if (copy_size > sizeof(req->req_upiu)) {
+        copy_size = sizeof(req->req_upiu);
+    }
+
     ret = ufs_addr_read(u, req_upiu_base_addr, &req->req_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_read_req_upiu(req->slot, req_upiu_base_addr);
@@ -225,6 +229,10 @@ static MemTxResult ufs_dma_write_rsp_upiu(UfsRequest *req)
         copy_size = rsp_upiu_byte_len;
     }
 
+    if (copy_size > sizeof(req->rsp_upiu)) {
+        copy_size = sizeof(req->rsp_upiu);
+    }
+
     ret = ufs_addr_write(u, rsp_upiu_base_addr, &req->rsp_upiu, copy_size);
     if (ret) {
         trace_ufs_err_dma_write_rsp_upiu(req->slot, rsp_upiu_base_addr);
-- 
2.39.2


