Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC7C3C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 15:37:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjIen-0000nO-Jc; Mon, 13 Jul 2026 11:33:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeS-0008Un-OW
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:33:06 -0400
Received: from mail-wm2-x0b.google.com ([2a00:1450:4864:31::b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wjIeO-0001Bb-IP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 11:32:59 -0400
Received: by mail-wm2-x0b.google.com with SMTP id
 5b1f17b1804b1-493d43b6c28so178765e9.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 08:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783956772; x=1784561572; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mmr/j5Sdb8E/oADRlX/72Tk23KUJknScj9a13d2/X5s=;
 b=usOVg4RhDC4EsmJzHPVD/RFVLrW8vstJ+BfSuMU++WB3T/BSbY/wEsdRBLLyHbUovw
 SIzaKGixAoW0hG+70dGhq7PVn2HZa5jaJuIJSVG3LuMZ/VY08ZKAe7LcwCrGXSsWo0Qa
 b7PMEk60ye3EZP8B/Y6w1VGi5rHiC4uYJ2gJ6osXLjXOvXbBufrjVBUyxIu4STH3/wuH
 foX2Gywap8bLkc7MAehhv9asBQS8wyPRFQ1lfSi6EZWAM2w9YdebPnvZMMtuaLPnSzWk
 JHVtSNYOooOIDHkgkWpGJr/4fpeZJQaMiqu9jPhZsAmweijNSKeVjf2s1P8Ae5+2EH5m
 3pVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783956772; x=1784561572;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mmr/j5Sdb8E/oADRlX/72Tk23KUJknScj9a13d2/X5s=;
 b=sDn1SgUyWZyZ21dpURdIYPC69v975wtP2AANiEAUUSgrUELtBVq3PEmwDds5Mk/xpN
 M5amX2VjbFVes7XfzDpMXQwnTNhY0rQwP8sNIIrwzNEiMZhCtDNGXGMCzM4lfFVuroU8
 Bp+95OQFkc1FMOdXejOjZmICEwZwcFv0yyfGet2NWYoEkFoLeTsYwMLGRRLQFjn3Se0d
 YRMmytCq/UQw+nGs1m+LBOLRVbEZORCfZ9PMpyc4jn74a/KqyZQjfU8ddZxQP5GzZuXo
 bceI2/cAwRsZmhBWMh7GK1fyK6ydIoa2t7hQKbKMlGaQoQtI8mTl/bCoht9n1MlXLbqd
 q1iA==
X-Gm-Message-State: AOJu0YxWXz901RlyKxbqGeiw+t1pIds8JXVl+wtsOXnhOVG90DNZc/py
 boGj/H20R9zLWYnWYJW8Jg6SuKUSyw+99ezjTeh9pLEd/POfMrj8bKBKjusxgQhjGkvW/Txq+ol
 AR/IdonoGq6OO
X-Gm-Gg: AfdE7clbXKmgWLN8n1qb7R/7YPFcOHLrIeuCi8gQDWPCRaiiKBSJC06oHkEtA+tLImD
 I3HY3yidessGg7wCNW8SGwjD7WufIW9iool3mLvf9ip5t1iSH9YSgqTiU+YRvHwxlG5mR90lGbX
 jrGMe1/WCn95GUF8CnsD+Gc7Hh8kUeWx0o/zB8GyPpvjSRM3f9C4Lxp3i5RkGj0fulDKp8H5O26
 vuZJ/CkOf+NYDSzTReb1CoD/WqjJmGYQ2OFVoJHO+n3vy7A18e6DQf5DTzog9Y0Gm6RHCwjHPcT
 C4TSNCMVZLH9sUFeDH2WwF9uqekNh76PCvCjFkGZQyeoJxupSSB0jz3Wtxkx/apDmwKIJ88fGVJ
 b1ZKJGoe1/ICLpeWtftAoWEzcjWv+WXwOvdRdsBJcQKEynR6oUyt61ZMBesXzynvun3PsjEaUkQ
 yfVzWRsE2P6XvC4UvLwqEC5vd2ge9XYYE2n2PRJpRgdkGlFrm6j9WGFWLwKVrWc0QHTAr47Vwux
 bk6c/kr60pK9mqDW0cSZw==
X-Received: by 2002:a05:600c:4e0b:b0:493:bc4a:c6b4 with SMTP id
 5b1f17b1804b1-493f8851d13mr94451805e9.38.1783956772573; 
 Mon, 13 Jul 2026 08:32:52 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49508727f7dsm3825985e9.4.2026.07.13.08.32.51
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 08:32:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/26] hw/dma: don't allow weird transfer lengths for bcm2835
Date: Mon, 13 Jul 2026 16:32:26 +0100
Message-ID: <20260713153233.3391818-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260713153233.3391818-1-peter.maydell@linaro.org>
References: <20260713153233.3391818-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::b;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm2-x0b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

From: Alex Bennée <alex.bennee@linaro.org>

The datasheet doesn't explicitly say that TXFR_LEN has to be word
aligned but the fact there is a DMA_D_WIDTH flag to select between 32
bit and 128 bit strongly implies that is how it works. The downstream
rpi kernel also goes to efforts to not write sub-4 byte lengths so
lets:

  - fail when mis-programmed and report GUEST_ERROR
  - catch setting D_WIDTH for 128 bit and report UNIMP

Yodel did some digging into the specs (see discussion link):

{A} AMBA AXI Protocol Version: 2.0 Specification
    https://documentation-service.arm.com/static/64256e84314e245d086bc88f

{B} BCM2835 ARM Peripherals
    https://datasheets.raspberrypi.com/bcm2835/bcm2835-peripherals.pdf

[1] {A} (p. 10-2)
[2] {B} (p. 51)
[3] {A} (p. 14-5)
[4] {A} (p. 4-3)
[5] {A} (p. 9-4)
[6] {B} (p. 53)

However was unable to come up with an unambiguous conclusion without
testing on the real hardware. So in the absence of certainty and for
the sake of addressing the DoS I suggest we merge as is for now.

Link: https://lore.kernel.org/all/20251111105429.3993300-1-alex.bennee@linaro.org/
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3201
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20260710131500.2323848-1-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/bcm2835_dma.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/hw/dma/bcm2835_dma.c b/hw/dma/bcm2835_dma.c
index d07459de2d0..b842aef4b74 100644
--- a/hw/dma/bcm2835_dma.c
+++ b/hw/dma/bcm2835_dma.c
@@ -86,6 +86,23 @@ static void bcm2835_dma_update(BCM2835DMAState *s, unsigned c)
         }
         xlen_td = xlen;
 
+        if (ch->ti & BCM2708_DMA_D_WIDTH) {
+            qemu_log_mask(LOG_UNIMP, "%s: 128bit transfers not yet supported", __func__);
+            ch->cs |= BCM2708_DMA_ERR;
+            break;
+        }
+
+        /*
+         * Datasheet implies 32bit or 128bit transfers only
+         *
+         * TODO: test on real HW and report back.
+         */
+        if (xlen & 0x3) {
+            qemu_log_mask(LOG_GUEST_ERROR, "%s: bad transfer size\n", __func__);
+            ch->cs |= BCM2708_DMA_ERR;
+            break;
+        }
+
         while (ylen != 0) {
             /* Normal transfer mode */
             while (xlen != 0) {
-- 
2.43.0


