Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418E9C44539
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2026 12:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmWLg-0002NG-KW; Wed, 22 Jul 2026 08:46:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLf-0002MX-CP; Wed, 22 Jul 2026 08:46:55 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wmWLd-0001b8-IK; Wed, 22 Jul 2026 08:46:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1784724390; bh=XXjD6YD6VU5Jh/JBbgBg9V+DUeEkQgb/SaF9iKdp88M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HvOT5Q3Lodmqx9HlamsHBeaNd3dlRlRXAMLPruCfqHwnQ9goB6u8CVK7c/hL1f6qH
 U6bfkj3v92dykcfnl7F7eElWxYW7KwiVqrtRm06O/fWe7A5k7CQwvgmGch/9B0pOE6
 3Ny1hhdULBUX4V6zUpdP08VhSn1imB4VqvH4sIdkiozE6//gYqdFrNf58NbCdtJ1Rj
 0EPohluwiUhaV87IVttB8wBcq56sFfGbE3i/pKjuD9yfEUyYWbIzPoBCCogVnRHKe6
 LeZk7RHCI46u9gl0KCq9QkuyvNKRhKIVr035k1cU3XRCEfBGMr4dFC0w5E4xlZsF+M
 Fmj892oEQ1ivw==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 41FA11C3AF8;
 Wed, 22 Jul 2026 15:46:30 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 870543F3752;
 Wed, 22 Jul 2026 15:46:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id 3EB0517ED9; Wed, 22 Jul 2026 15:46:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.12 v2 079/122] hw/net/vmxnet3: Correct bounds check on
 tx queue index
Date: Wed, 22 Jul 2026 15:45:28 +0300
Message-ID: <20260722124622.31034-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
References: <qemu-stable-10.0.12-20260722154425@cover.tls.msk.ru>
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
index 7abed664690..c15e179fb44 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -1092,7 +1092,7 @@ vmxnet3_io_bar0_write(void *opaque, hwaddr addr,
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


