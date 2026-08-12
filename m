Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86A4CC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu8jQ-00022z-OS; Wed, 12 Aug 2026 09:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ig-0008Qp-HK; Wed, 12 Aug 2026 09:10:13 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wu8ie-0005lN-G3; Wed, 12 Aug 2026 09:10:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786539784; bh=R3z0YtGMUG3trULc8ArRP4UlHkYiIKvKW3WfaQVExEw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y9rxVi1IgeoDYnlh4Bk2m9szDzr1WafLMOLCPEP+pFnmMTS/1RGf6lis8ZZGZdacY
 NH6LyJcMAgSATStDLuyIMJpsHUL+Nivu8jS8gjTmm1VfRGmYXAONlJvf5GJDGiwc81
 Dj0YcY9BnCC/rOQxGku4tPdcpCGkh6KUV9KkPgDN/1K3SySFeNZGutpZaFxLFAObjq
 rdIq1xJghY5d2fuGyvyD7+WIVrui5bI8teIb4BWqvm4LiBwCCQvYD76xQdjEcW8Hkj
 dIHbeExadrelzjRYD7FifuLQUqMv+GAj38MK/3pyH53oPjC+ZQWTq85W6u1LT/K2BD
 kUBaw3YEGepFw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 610421CA4C7;
 Wed, 12 Aug 2026 16:03:04 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 97372409BAA;
 Wed, 12 Aug 2026 16:03:15 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 8AEAB2F924; Wed, 12 Aug 2026 16:02:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jihe Wang <wangjihe.mail@gmail.com>, boy juju <agx1657748706@gmail.com>,
 contact <contact@xchglabs.com>, david korczynski <david@adalogics.com>,
 "Brian Chastain (off_by_one / Curious-Keeper)" <brian@scalingsuccess.io>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.13 072/102] hw/nvme: fix cross-namespace copy dif buffer
 overflow
Date: Wed, 12 Aug 2026 16:01:47 +0300
Message-ID: <20260812130233.621965-72-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
References: <qemu-stable-10.0.13-20260812152851@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

The NVMe specification allows a controller with multiple namespaces to
use different LBA formats per namespace. One implication of this is that
the destination namespace may have a metadata area for PI, but the
source does not. In that case, the controller shall generate the
protection information, but the bounce buffer is erroneously allocated
without space for that, causing a buffer overflow.

Fix the allocation.

Cc: qemu-stable@nongnu.org
Fixes: d522aef88d42 ("hw/nvme: add cross namespace copy support")
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3387
Reported-by: Jihe Wang <wangjihe.mail@gmail.com>
Reported-by: boy juju <agx1657748706@gmail.com>
Reported-by: contact <contact@xchglabs.com>
Reported-by: david korczynski <david@adalogics.com>
Reported-by: Brian Chastain (off_by_one / Curious-Keeper) <brian@scalingsuccess.io>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit df67805ee9b15f4c7d54f0e6276d8f9889ec36c4)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index a43407e37cd..258ad5f38ec 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -3190,7 +3190,7 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     uint16_t prinfow = ((copy->control[2] >> 2) & 0xf);
     uint64_t slba;
     uint32_t nlb;
-    size_t len;
+    size_t len, blen;
     uint16_t status;
     uint32_t dnsid = le32_to_cpu(req->cmd.nsid);
     uint32_t snsid = dnsid;
@@ -3311,10 +3311,13 @@ static void nvme_do_copy(NvmeCopyAIOCB *iocb)
     }
 
     g_free(iocb->bounce);
-    iocb->bounce = g_malloc_n(le16_to_cpu(sns->id_ns.mssrl),
-                              sns->lbasz + sns->lbaf.ms);
+    assert(g_size_checked_mul(&blen, le16_to_cpu(sns->id_ns.mssrl),
+                              sns->lbasz + MAX(sns->lbaf.ms, dns->lbaf.ms)));
+
+    iocb->bounce = g_malloc(blen);
 
     qemu_iovec_reset(&iocb->iov);
+    assert(len <= blen);
     qemu_iovec_add(&iocb->iov, iocb->bounce, len);
 
     block_acct_start(blk_get_stats(sns->blkconf.blk), &iocb->acct.read, 0,
-- 
2.47.3


