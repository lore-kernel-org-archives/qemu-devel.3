Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F994C43458
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Jul 2026 04:27:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wilfa-0007uX-J5; Sun, 12 Jul 2026 00:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfH-0007kB-SM; Sun, 12 Jul 2026 00:19:42 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wilfG-0006kK-Br; Sun, 12 Jul 2026 00:19:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1783829781; bh=Tu4H6AL24DwgGEbdDrKHT1Zb5tAk0N4S6Vikx02tcNw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nPaCCDk/TXrJ6/2Qxn8nduXkCsUeW4+yJH9bPK1hH/k3/DCBIOcp65E5ZxWWSnWXb
 jFQTPghYXd43SdDu+6nUd4Jec+c2qNBMxgilR6IBzMbqu0V6c6MqqG1f/nQZfcER49
 k0TiNqLPVIHLJwExP3i2yN36T4JbOFgI1yyKnoUjSXcRD6ou+DhLiM1zQ/BJatC3D7
 e3J6kf2DZfgr2zMPC7DhXciZYYTCV5OXZkLDeVS+uxStdtlLKQMN0wG54NuJw3T1U5
 +8I4IEK9UUhQgcO3mTUY8QkkslWAvbu3ILkNJrSi07dM1NcFKFFbqDhQy0RWJ98l/R
 Mw1gOdlr6xY1Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 904DC1C0C01;
 Sun, 12 Jul 2026 07:16:21 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id C2E2F3EB961;
 Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 6DD0513405; Sun, 12 Jul 2026 07:16:31 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Feifan Qian <bea1e@proton.me>, boy juju <agx1657748706@gmail.com>,
 Klaus Jensen <k.jensen@samsung.com>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 38/75] hw/nvme: ensure sgl forward progress
Date: Sun, 12 Jul 2026 07:14:56 +0300
Message-ID: <20260712041539.108341-38-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260712071526@cover.tls.msk.ru>
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
index 559d1c5d6c7..a43407e37cd 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -1085,6 +1085,8 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
     }
 
     for (;;) {
+        size_t prev_len = len;
+
         switch (NVME_SGL_TYPE(sgld->type)) {
         case NVME_SGL_DESCR_TYPE_SEGMENT:
         case NVME_SGL_DESCR_TYPE_LAST_SEGMENT:
@@ -1165,6 +1167,17 @@ static uint16_t nvme_map_sgl(NvmeCtrl *n, NvmeSg *sg, NvmeSglDescriptor sgl,
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


