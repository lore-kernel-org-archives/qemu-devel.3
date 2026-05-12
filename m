Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C647ECD4F3D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuMA-0007Fd-8x; Tue, 12 May 2026 17:09:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLn-0004HP-9p; Tue, 12 May 2026 17:09:11 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuLl-0003Jg-Gh; Tue, 12 May 2026 17:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619301; bh=BKMSOWmf0KHPyVvGjY3UKLoevtS5Cggtbz/1YanthO0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Ja7PbFCfyezrZ8JRfvduamrhOa6/UK/2Q4cLKA8VmTVVByV4yiTjGNNdMdmmuWjjj
 qqmIhF6GuDyCQPNRDJkt5lkW9yC6P1WpoZoN+MQgH05Q6Hy/ioGIHPft58tktc6x5T
 HrzY2ldGggg1pVt0Q5ocpKUCa0AlFkaBB+HURKJlaG8c8y5kmj/VQUdlxosGlsZAwS
 BmHJDuCIbIbY3hO4uEnwbFkBFmtWdLjKW7phGwVQpAlIpgQQF5msI5I9YCBdmyr1rL
 qNL8/dr6K2X3niwUdnZbK5U4F/kqjrenvpEGDu4SMKvRGh5Z7XLF+megTGvd0oCVtK
 hjd4e+QosVqfQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E28E31AA35E;
 Tue, 12 May 2026 23:55:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id EF1783ABCCE;
 Tue, 12 May 2026 23:55:05 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Pankaj Raghav <p.raghav@samsung.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 033/117] hw/nvme: re-enable wzds bit in namespace
 dlfeat
Date: Tue, 12 May 2026 23:53:35 +0300
Message-ID: <20260512205503.361097-33-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
MIME-Version: 1.0
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

From: Pankaj Raghav <p.raghav@samsung.com>

dlfeat was changed from 0x9 to 0x1 when PI support was added.
It was removed because we can't rely on unmap and have to physically
clear it to get the checksums right but that doesnt mean that we do not
support the bit.

The spec says that if wzds is enabled, then the controller supports
deallocate (DEAC) on write zeroes. But DEAC bit in write zeroes command
is only a hint, the controller might choose to physically write zeroes in
those areas.

As we are sending write zeroes command with BDRV_REQ_MAY_UNMAP to the
underlying block device anyway (if the unmap operation is supported),
change the dlfeat value back to 0x9.

A new flag FALLOC_FL_WRITE_ZEROES has been introduced in linux for
fallocate which will use the wzds bit in dlfeat to quickly zeroout extents
using unmap operation whenever possible[1].

[1] https://lore.kernel.org/linux-fsdevel/20250619111806.3546162-1-yi.zhang@huaweicloud.com/

Fixes: 146f720c55 ("hw/block/nvme: end-to-end data protection")
Suggested-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 55720ba97d2164796215c983255f009993e24432)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 38f86a1726..b0106eaa5c 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -75,7 +75,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
     ns->csi = NVME_CSI_NVM;
     ns->status = 0x0;
 
-    ns->id_ns.dlfeat = 0x1;
+    ns->id_ns.dlfeat = 0x9;
 
     /* support DULBE and I/O optimization fields */
     id_ns->nsfeat |= (NVME_ID_NS_NSFEAT_DAE | NVME_ID_NS_NSFEAT_OPTPERF_ALL);
-- 
2.47.3


