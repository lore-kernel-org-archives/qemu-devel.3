Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA721CE7AB9
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 06:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smSsw-0000ok-St; Fri, 06 Sep 2024 02:55:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSsv-0000Y2-3N; Fri, 06 Sep 2024 02:55:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1smSss-0003Lk-V4; Fri, 06 Sep 2024 02:55:56 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id CE2558C247;
 Fri,  6 Sep 2024 09:53:12 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 94C8C1333FF;
 Fri,  6 Sep 2024 09:54:30 +0300 (MSK)
Received: (nullmailer pid 43441 invoked by uid 1000);
 Fri, 06 Sep 2024 06:54:29 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Frederik=20van=20H=C3=B6vell?= <frederik@fvhovell.nl>,
 Cryptjar <cryptjar@junk.studio>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.7 18/53] hw/char/bcm2835_aux: Fix assert when receive
 FIFO fills up
Date: Fri,  6 Sep 2024 09:53:48 +0300
Message-Id: <20240906065429.42415-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
References: <qemu-stable-8.2.7-20240906080902@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Frederik van Hövell <frederik@fvhovell.nl>

When a bare-metal application on the raspi3 board reads the
AUX_MU_STAT_REG MMIO register while the device's buffer is
at full receive FIFO capacity
(i.e. `s->read_count == BCM2835_AUX_RX_FIFO_LEN`) the
assertion `assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN)`
fails.

Reported-by: Cryptjar <cryptjar@junk.studio>
Suggested-by: Cryptjar <cryptjar@junk.studio>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/459
Signed-off-by: Frederik van Hövell <frederik@fvhovell.nl>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: commit message tweaks]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 546d574b11e02bfd5b15cdf1564842c14516dfab)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/char/bcm2835_aux.c b/hw/char/bcm2835_aux.c
index 96410b1ff8..0f1b28547e 100644
--- a/hw/char/bcm2835_aux.c
+++ b/hw/char/bcm2835_aux.c
@@ -138,7 +138,7 @@ static uint64_t bcm2835_aux_read(void *opaque, hwaddr offset, unsigned size)
         res = 0x30e; /* space in the output buffer, empty tx fifo, idle tx/rx */
         if (s->read_count > 0) {
             res |= 0x1; /* data in input buffer */
-            assert(s->read_count < BCM2835_AUX_RX_FIFO_LEN);
+            assert(s->read_count <= BCM2835_AUX_RX_FIFO_LEN);
             res |= ((uint32_t)s->read_count) << 16; /* rx fifo fill level */
         }
         return res;
-- 
2.39.2


