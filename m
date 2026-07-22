Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04995C4453F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 13:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWQQ-0001Xt-7R; Wed, 22 Jul 2026 08:51:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWQ0-0001Kk-Jg; Wed, 22 Jul 2026 08:51:28 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWPy-0002Li-LB; Wed, 22 Jul 2026 08:51:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724574; bh=4Q9W3pT/DsD37qsdiI2f9edpTgJkdQaB7uPSIRUr5xY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=PfQEE8JctYwfJM/1KCg9nsn3bqQY0w84BnMpaS4dmmjZgG2jKb3VwlVv0/Tp5Nmnu
 6OrpJYXcgQtv9i/o7dNfLl7Z4j/2vzibmERUCjbYmCOULQWPVVMXo+3cDwqrbCTKyM
 Z26ghCnT9/4A6d5TLobaVUr08hfywH8abUHVeaDMtSmcdkMa3gNW50A/GWUvyrJXoy
 sxNmApIR4I2s5eqDfs5FUtfFTyauUBr1qiDajHSM0Sc6oCF24OVys0bdpkN8XD6Vlt
 14QGeZP6AdK4DKecoZYJU+QODRas60qW4j+Lcr8ahW69PAYMQcA6N/LtFh2goBFxPt
 HBxFKZmJduhMg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8A2DC1C3B31;
 Wed, 22 Jul 2026 15:49:34 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id D38BD3F3781;
 Wed, 22 Jul 2026 15:49:51 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 98F6217F37; Wed, 22 Jul 2026 15:49:42 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.3 v2 084/127] hw/net/vmxnet3: Correct bounds check on tx
 queue index
Date: Wed, 22 Jul 2026 15:48:09 +0300
Message-ID: <20260722124859.32371-3-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
References: <qemu-stable-11.0.3-20260722154646@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

In vmxnet3_io_bar0_write(), we try to bounds-check the TX queue index
provided by the guest against the total number of queues.  However,
we have an off-by-one error: the valid indexes are from 0 to
txq_num-1, so we need a "<" comparison, not "<=".

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3780
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260706175408.905362-1-peter.maydell@linaro.org
(cherry picked from commit 4571c79c57cabd5975fb9d51f78c87675989180b)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 97156dd33b9..8569484b2f2 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1079,7 +1079,7 @@ vmxnet3_io_bar0_write(void *opaque, hwaddr addr,
         int tx_queue_idx =
             VMW_MULTIREG_IDX_BY_ADDR(addr, VMXNET3_REG_TXPROD,
                                      VMXNET3_REG_ALIGN);
-        if (tx_queue_idx <= s->txq_num) {
+        if (tx_queue_idx < s->txq_num) {
             vmxnet3_process_tx_queue(s, tx_queue_idx);
         } else {
             qemu_log_mask(LOG_GUEST_ERROR, "vmxnet3: Illegal TX queue %d/%d\n",
-- 
2.47.3


