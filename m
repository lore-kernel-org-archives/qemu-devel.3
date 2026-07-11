Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D931BC43458
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 22:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wifnR-0008R2-Pp; Sat, 11 Jul 2026 18:03:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifn6-0007dc-CA; Sat, 11 Jul 2026 18:03:22 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wifn4-0008UH-LK; Sat, 11 Jul 2026 18:03:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783807180; bh=uslL7lUFm6NS/mScZulwl1QVvrIBrXr6yCUQtg7VLUo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kLfdURWH4D6ChfvRO/OUZucBCpfMhF2N3yhYPyzYbX9P40afrK5sL6zz/JMILAX3b
 LgCC/bwM7ka70DKQrUggNZ6KRWT3STaECx0daDmptpnU4YcLZTVYPYJJyl4wFJapou
 vyZ3SKNpJ7G/gqQENgoj3rPx68FWjG4MvWQBd/Xzp8SoeWJhti4DvRX/OpN/jRtXP5
 gQqw/naTlG/OIl+u0oRVSVFlc9z4K21eUMj4vnO1+IRoJJdZX+99znlph79kJGVAH8
 yGUomiJtGWLEa4oOY9nrLKxbNaAGjt7eKG2DGSMV5GJ9TupfpHaS4nFuCWOUzLfgN5
 EStjU3e0O3Z+A==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id F38131C0AB1;
 Sun, 12 Jul 2026 00:59:40 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id AA65D3EAF3C;
 Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 919D31332F; Sun, 12 Jul 2026 00:59:50 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Feifan Qian <bea1e@proton.me>, boy juju <agx1657748706@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 38/81] hw/nvme: ensure sgl forward progress
Date: Sun, 12 Jul 2026 00:58:16 +0300
Message-ID: <20260711215904.3757-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260712005649@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=212.248.84.144; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_MSPIKE_H2=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Keith Busch <kbusch@kernel.org>

A degenerate host can create segment loops of zero-byte data descriptors
that the controller never breaks out of. While the spec allows zero
length segments, it provides no guidance on handling loops. It
makes no sense for a host to submit such a descriptor anyway since it
can and trivially should point to the next transfer segment, so don't
even try to work with such behavior. Just reject the command,
terminating the loop.

Cc: qemu-stable@nongnu.org
Reported-by: Feifan Qian <bea1e@proton.me>
Reported-by: boy juju <agx1657748706@gmail.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Klaus Jensen <k.jensen@samsung.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 034baf047fe143c2713f35fa640407d9da2f6fc3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index 28cc8d0e7dc..76d024c81e5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1088,6 +1088,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
     }
 
     for (;;) {
+        size_t prev_len = len;
+
         switch (NVME_SGL_TYPE(sgld->type)) {
         case NVME_SGL_DESCR_TYPE_SEGMENT:
         case NVME_SGL_DESCR_TYPE_LAST_SEGMENT:
@@ -1168,6 +1170,17 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
         if (status) {
             goto unmap;
         }
+
+        /*
+         * Reject if this segment made no forward progress. The host should
+         * have skipped linking an empty segment. While not strictly spec
+         * compliant, allowing this makes it easy for a pathological host to
+         * create an infinite loop.
+         */
+        if (len == prev_len) {
+            status = NVME_INVALID_SGL_SEG_DESCR | NVME_DNR;
+            goto unmap;
+        }
     }
 
 out:
-- 
2.47.3


