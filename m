Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2035CC5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:07:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuAUn-00081z-FT; Wed, 12 Aug 2026 11:03:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAT8-0004lp-Ph; Wed, 12 Aug 2026 11:02:14 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wuAT6-0002Tq-JH; Wed, 12 Aug 2026 11:02:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1786546234; bh=Pbj+u/m9kWw0/z5O/bI/hIteV9qoRgCHwf99mhijLaI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=P60PmHnmAcd/nJ2scfQDLpuHAGKPpmh5Y9HO5UcVBxl1X34SdcEqLo97AVB6Ll4fe
 0TlU7VJs+PirflSEN8pTPEKxvI4rU0FmKQRdX39vaq5apz8fa+73Yo36CE6dMEp4SV
 214txzx6+QlO8f/7Txx7w4RwH3RS+cKNTkcoR7kOjiXxXZ+IXFtVogGeaZj9DPxZeB
 hnjKOhbKsW6jFpHXBYdCVwbad9C3tgE678Y7pqPIyWGfk4rHxUrWdUDcSkqV9CpU/Y
 +ltGmdR6OMKy78nbsLCNTB1L1wF3c/8h52P1VMVmWr3XBzBTiPxqyErvPtwpWH+qia
 lqoZSDNRxgxBQ==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0D2F71CA676;
 Wed, 12 Aug 2026 17:50:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 67A5E409DBB;
 Wed, 12 Aug 2026 17:50:45 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id C50D42FA47; Wed, 12 Aug 2026 17:50:20 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <foss@defmacro.it>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.4 114/120] hw/nvme: fix leak on copy ranges
Date: Wed, 12 Aug 2026 17:49:37 +0300
Message-ID: <20260812144955.649205-114-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
References: <qemu-stable-11.0.4-20260812160441@cover.tls.msk.ru>
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

From: Klaus Jensen <k.jensen@samsung.com>

The buffer holding the ranges for the copy command is not correctly
deallocated.

Fix this.

Cc: qemu-stable@nongnu.org
Link: https://gitlab.com/qemu-project/qemu/-/work_items/4072
Fixes: 796d20681d9b ("hw/nvme: reimplement the copy command to allow aio cancellation")
Reviewed-by: Jesper Wendel Devantier <foss@defmacro.it>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
(cherry picked from commit 7a34f7b8794b29cd1bd4dfa45f7d8e8daba7cff5)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index b39072673d3..5c1a6f42fa5 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -2794,6 +2794,7 @@ static void nvme_copy_done(NvmeCopyAIOCB *iocb)
 
     qemu_iovec_destroy(&iocb->iov);
     g_free(iocb->bounce);
+    g_free(iocb->ranges);
 
     if (iocb->ret < 0) {
         block_acct_failed(stats, &iocb->acct.read);
-- 
2.47.3


