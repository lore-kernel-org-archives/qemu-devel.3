Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4956CD4F21
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 21:15:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMuJ3-0005xc-I4; Tue, 12 May 2026 17:06:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIl-00057T-IX; Tue, 12 May 2026 17:06:05 -0400
Received: from isrv.corpit.ru ([212.248.84.144])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1wMuIj-0001IS-GB; Tue, 12 May 2026 17:06:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tls.msk.ru; s=202602;
 t=1778619300; bh=91SIo64egh5vUmwF5Fww1l02vzX7Zslxf3s2lwaqyP8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=a6SozHlTk4mxaaq1rme4kyKMiSjowiDtvMfLfYTByT86oZJfNwjllaOS2wAUIcpkz
 kCr08zLM9gFfrGuiJ44mysPX9S5YhjjOvNV1K4J7v5X99puZzivy5MChGNA7HYg/aG
 PZTopae+EgS3B2Dm7Cor4rV9IPhbYVWkrBxT0FrJFdxHWMNwey1eyqJF/3uF2ybYBL
 bMP/cayNC3XDdPqd6Km9KQCxhV21gUN3zdfhJa4akhKH0yX4s3SrZFwvyls/HDVxg6
 h5SIJYhC3Jl0qN6OCOgF/vwUgvl8OYwzvVqrbMO3y1CtcXd9i68fVXH7OHYQ++VE+a
 mqHYOW2q8N72w==
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 02F8C1AA340;
 Tue, 12 May 2026 23:55:00 +0300 (MSK)
Received: from think4mjt.tls.msk.ru (mjtthink.wg.tls.msk.ru [192.168.177.146])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0FC693ABCB1;
 Tue, 12 May 2026 23:55:04 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-10.2.3 004/117] hw/dma/pl080: Handle bogus swidth and dwidth
 in transfers
Date: Tue, 12 May 2026 23:53:06 +0300
Message-ID: <20260512205503.361097-4-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
References: <qemu-stable-10.2.3-20260512103849@cover.tls.msk.ru>
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

From: Peter Maydell <peter.maydell@linaro.org>

The PL080 TRM states that the DWidth and SWidth fields of the channel
control registers can only validly specify widths up to 32 bits (i.e.
values from 0 to 2) and all other values are reserved.

Currently we don't check this, so if the guest specifies an invalid
value we will transfer more data into our local 'buff[]' array than
it can hold.

Check the widths; since the TRM doesn't clearly specify any behaviour
for what to do on invalid values, we choose to log them and then
ignore the channel for transfers.

Cc: qemu-stable@nongnu.org
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3203
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20260306152140.2191653-1-peter.maydell@linaro.org
(cherry picked from commit 37c9f6fce5c59db216e7f7ad961395b6e702bda9)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
index 277d934322..27b819187d 100644
--- a/hw/dma/pl080.c
+++ b/hw/dma/pl080.c
@@ -164,6 +164,21 @@ again:
                destination widths are different.  */
             swidth = 1 << ((ch->ctrl >> 18) & 7);
             dwidth = 1 << ((ch->ctrl >> 21) & 7);
+
+            /* Only widths of 1, 2 or 4 are valid */
+            if (swidth > 4) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pl080: channel %d: invalid SWidth %d\n",
+                              c, extract32(ch->ctrl, 18, 3));
+                continue;
+            }
+            if (dwidth > 4) {
+                qemu_log_mask(LOG_GUEST_ERROR,
+                              "pl080: channel %d: invalid DWidth %d\n",
+                              c, extract32(ch->ctrl, 21, 3));
+                continue;
+            }
+
             for (n = 0; n < dwidth; n+= swidth) {
                 address_space_read(&s->downstream_as, ch->src,
                                    MEMTXATTRS_UNSPECIFIED, buff + n, swidth);
-- 
2.47.3


