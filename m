Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97553CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 19:58:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYUSv-00020p-K1; Sat, 13 Jun 2026 15:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSp-0001sl-Hn; Sat, 13 Jun 2026 15:56:21 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYUSn-0004vU-PO; Sat, 13 Jun 2026 15:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781380261; bh=wFgYv/PwAt0u78hux03pZXLxBHjnBUUTcA3SqqslMOQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=xMWbUbef0BZuVk7fMMSvhesrhH4pY/e8AF3CMR2fzFxSNUrN42K1t2zR7DQaT+z0W
 nr7CrcYpFbZ1060pUSS/VlcTwwH1JicPzyuYGMWz5LnhEbx8N8VqASWzizCx4stvdY
 1U+KwFF3spv0dQNlsJAB1VHJ945XOuiuLNe6n+tXYxvnIdbW0I3I8FNYV1GaC0P+IA
 z50jJwvBR4woPBKCcrSHVjD4xG+mnprnvdBj/JkFXgUSlMWqIyeWJw+Ux2Dy727xyp
 vytjxSToFUWl3ILP1TQFltFZzhSYnI/qBe6vUq9przPUUWWqa3/C3uH3t7P+ga8pnF
 t/MhqgEfzemCg==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 8FBCB1B6E44;
 Sat, 13 Jun 2026 22:51:01 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id DC3D13CE8BE;
 Sat, 13 Jun 2026 22:51:19 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.11 53/56] hw/usb/hcd-ohci: Clean up USBPacket before
 freeing ISO TD packet
Date: Sat, 13 Jun 2026 22:51:07 +0300
Message-ID: <20260613195116.1807273-53-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
References: <qemu-stable-10.0.11-20260613224446@cover.tls.msk.ru>
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

From: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>

ohci_service_iso_td() allocates a USBPacket and frees it after synchronous
completion, but it does not call usb_packet_cleanup() first.

Call usb_packet_cleanup() before g_free() so resources owned by USBPacket
are released.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3463

Signed-off-by: Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 163f9a4e0651b3b4a1438d919489a200d3646ba3)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index adf400a18a..b7296ae036 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -756,6 +756,7 @@ static int ohci_service_iso_td(OHCIState *ohci, struct ohci_ed *ed)
     } else {
         ret = pkt->status;
     }
+    usb_packet_cleanup(pkt);
     g_free(pkt);
 
     trace_usb_ohci_iso_td_so(start_offset, end_offset, start_addr, end_addr,
-- 
2.47.3


