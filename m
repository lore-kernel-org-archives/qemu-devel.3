Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE241CDB470
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 05:13:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcFpY-000249-AJ; Wed, 24 Jun 2026 01:07:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFpT-0001sY-75; Wed, 24 Jun 2026 01:07:15 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wcFpQ-0005jr-Ub; Wed, 24 Jun 2026 01:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1782277622; bh=mDYSYrbiMkbdfeAHDtG1z9lyUtMdaun8VwLlDHOZO2c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RVY0+Ow0NbM03ZlQu3eYj+sfl8OCCHNo7qohgYRwbav+WK+OHfjvvzkv+0hBM33BW
 KHCdNqT89atdDtwZHV+qvfzFg5v58eNLotQZKD9ZdvsQP56NBcSbYcOxwo01vFmRne
 XODKaRh8XlVLb2ZfdycXIMS54TmQfhF+QLLAc4+IR3/H2Wgz+g2EDIyOUpkN7xQ7dx
 kQKd8hnn2+l0OLhRriGmdtloqp2PGLzuvYeKrIdQdIqi317CeNCbwugYqVIBV/G9Lk
 2lIWKuvm1bCIk0sgS3R6WejJNUrInHccjKeWqbwwjV9P8zDFAHWAB4KW+wS1I7bihU
 9YH43wuOUiU7w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 2ED321BA65E;
 Wed, 24 Jun 2026 08:07:02 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 150253DDAFB;
 Wed, 24 Jun 2026 08:07:07 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Yunhe Wang <yunhewwww@163.com>,
 Alejandro Jimenez <alejandro.j.jimenez@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.4 64/95] amd_iommu: restrict command buffer head/tail
 ranges to ring size
Date: Wed, 24 Jun 2026 08:04:59 +0300
Message-ID: <20260624050541.395079-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
References: <qemu-stable-10.2.4-20260624080454@cover.tls.msk.ru>
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

From: Paolo Bonzini <pbonzini@redhat.com>

The AMD IOMMU command buffer is a ring buffer of cmdbuf_len (a power
of two) entries.  Each entry is 16 bytes and the head pointer cycles
through the set:

  [0, 16, 32, ..., (cmdbuf_len - 1) * AMDVI_COMMAND_SIZE]

The tail pointer is written by the guest through the COMMAND_TAIL MMIO
register (offset 0x2008); the while loop in amdvi_cmdbuf_run() only
terminates when head == tail.  If tail is set to a value higher than
cmdbuf_len * 16, head will cycle through all the elements of the ring
buffer indefinitely, without ever matching tail.  Fix this by further
masking tail (and head, for consistency) against the size of the
ring buffer.

Reported-by: Yunhe Wang <yunhewwww@163.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260511113923.2478812-1-pbonzini@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
(cherry picked from commit 3097d54016ea9f8f0436f0b20e1b4d78a02b6aeb)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index d689a06eca..29e2014c68 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1578,7 +1578,8 @@ static inline void amdvi_handle_devtab_write(AMDVIState *s)
 static inline void amdvi_handle_cmdhead_write(AMDVIState *s)
 {
     s->cmdbuf_head = amdvi_readq(s, AMDVI_MMIO_COMMAND_HEAD)
-                     & AMDVI_MMIO_CMDBUF_HEAD_MASK;
+                     & AMDVI_MMIO_CMDBUF_HEAD_MASK
+                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
     amdvi_cmdbuf_run(s);
 }
 
@@ -1594,7 +1595,8 @@ static inline void amdvi_handle_cmdbase_write(AMDVIState *s)
 static inline void amdvi_handle_cmdtail_write(AMDVIState *s)
 {
     s->cmdbuf_tail = amdvi_readq(s, AMDVI_MMIO_COMMAND_TAIL)
-                     & AMDVI_MMIO_CMDBUF_TAIL_MASK;
+                     & AMDVI_MMIO_CMDBUF_TAIL_MASK
+                     & (s->cmdbuf_len * AMDVI_COMMAND_SIZE - 1);
     amdvi_cmdbuf_run(s);
 }
 
-- 
2.47.3


