Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB75CD98CF
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 20:45:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYVBm-00070H-Oc; Sat, 13 Jun 2026 16:42:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVBj-0006fE-O9; Sat, 13 Jun 2026 16:42:43 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wYVBh-0005bP-2f; Sat, 13 Jun 2026 16:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1781382966; bh=jbkwDL2RSoWTXG3cX/JQP8fdtVWxdulh+xyfSz/UVgk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lDHxJ2UuttiF65KvmSRl1DEF9ld9VlrSm+rPXt998WoddMTSMgEsdwv2DIEQvtvvy
 AD4UbCmtO/deAn1JXWM4qYKtj1+F8B1DfBgQPCUEEKEXJzQIr8mFmGoRariB+WWuA2
 qzvz0phkdhGZca95vkn+D1Fq0fQ3R93en2uLgmPI3J+tEV4+kYEVIULu4hWFok/w98
 B+AL6YkBApI5jaI3nRyqCgHsytmCByk821hyHTMmGrtTmU5OrFlFC6/kX51/Mcgtpc
 y734DnaR4WRPXOtFyRB4CmHnthNZHEEQ5WjsHSryju0BefBEqusRAMKA9RJ4czh5RX
 B8gTYlWn3fw2Q==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id E992D1B6F28;
 Sat, 13 Jun 2026 23:36:06 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4EE633CE971;
 Sat, 13 Jun 2026 23:36:25 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Munkhbaatar Enkhbaatar <munkhuu0825@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-11.0.2 69/72] hw/usb/hcd-ohci: Clean up USBPacket before
 freeing ISO TD packet
Date: Sat, 13 Jun 2026 23:35:35 +0300
Message-ID: <20260613203542.1809153-69-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
References: <qemu-stable-11.0.2-20260613224644@cover.tls.msk.ru>
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
index 6ed8046fc2..37a11f0c94 100644
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


