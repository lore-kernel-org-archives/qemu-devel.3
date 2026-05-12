Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6A7CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 20:57:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMu9l-0006Et-VD; Tue, 12 May 2026 16:56:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu9e-0005xm-Kk; Tue, 12 May 2026 16:56:41 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMu9T-0003F9-HY; Tue, 12 May 2026 16:56:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619274; bh=x5d/ov7fvXOitaFw3cFSLSaJdEpXsNMjl5eajYDNe9M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gpfNUOKYKlkM1btUc1NZ/qCKQl/8Z2uzw5zNnKmgF+NoOmJra2HfWIvsS3zapfn7r
 2CdI2lSsGFbabwJhUEXQ6e8R4540VFgS7pCTpAxICdpSSh34Jf3TKQiT9P/yd80E5U
 +7QBq8Pagb1qEFzn7LqP6oQlPXoNh6J1AIrBT/SxIwu4EmEO8kTxZymazgQfAKhZ6e
 iDNNdb5IxtDmatqkSmArfRTEe6dGYb5iroP4xqf8J8D8Yow6VdMuGT8DzJkJ3JYYYV
 IBVhbsQKmLbXZtqkttqFpvr6I2c5x9DCGYqAbXlZPmS2cvNDVkcvVbxcKWzVvv8fPY
 jIbGwGE2CUCmA==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 921CD1AA2DF;
 Tue, 12 May 2026 23:54:34 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D5533ABC50;
 Tue, 12 May 2026 23:54:38 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Jenny Guanni Qu <qguanni@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.0.10 019/107] hw/usb/hcd-ohci: check for MPS=0 to avoid
 infinite loop
Date: Tue, 12 May 2026 23:53:06 +0300
Message-ID: <20260512205437.360850-19-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
References: <qemu-stable-10.0.10-20260512103844@cover.tls.msk.ru>
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

From: Jenny Guanni Qu <qguanni@gmail.com>

When a guest sets MaxPacketSize to 0 in an OHCI Endpoint Descriptor,
ohci_service_td() transfers 0 bytes per iteration. The Transfer
Descriptor never completes because CBP never advances toward BE,
causing ohci_service_ed_list() to loop indefinitely and hang QEMU.

Add a check for MPS==0 after extracting the field from ED flags.
If MPS is zero, call ohci_die() to reset the controller and return
an error, preventing the infinite loop.

Fixes: CVE-2026-3890
Reported-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20260321000444.909451-1-qguanni@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 129922c2bc398b656a9180150e667f98fdf0d402)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 71b54914d3..adf400a18a 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -956,6 +956,17 @@ static int ohci_service_td(OHCIState *ohci, struct ohci_ed *ed)
         if (len && dir != OHCI_TD_DIR_IN) {
             /* The endpoint may not allow us to transfer it all now */
             pktlen = (ed->flags & OHCI_ED_MPS_MASK) >> OHCI_ED_MPS_SHIFT;
+            /*
+             * The OHCI spec does not say what to do if the guest hands us
+             * an endpoint descriptor which specifies a MaximumPacketSize
+             * of zero, which would mean we can never actually make forward
+             * progress transferring data to it. We choose to treat it as
+             * an error.
+             */
+            if (pktlen == 0) {
+                ohci_die(ohci);
+                return 1;
+            }
             if (pktlen > len) {
                 pktlen = len;
             }
-- 
2.47.3


