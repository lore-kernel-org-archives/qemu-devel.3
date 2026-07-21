Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0689AC4451C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2026 08:52:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wm6Bz-0005Sv-OO; Tue, 21 Jul 2026 04:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bw-0005Re-TG
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:08 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wm6Bv-0005i6-Be
 for qemu-devel@nongnu.org; Tue, 21 Jul 2026 04:51:08 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso21967805e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2026 01:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784623865; x=1785228665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=a4MdhOXFCu6xM17u7XgcNGHi/henMeTFTDgKO2L9cts=;
 b=ehwNAegHyDWmabC20qNHTr7UmoXGF2jFf9mrZY/+TPe53NCBQjKoy/b+q90eWi2Mpf
 tIzP3AmurLFkfBucYRFfpY5ICe4fwNgDDWVdJIkA05Wf7JExlphceivCmb0a8awmsAKx
 OUIuRL81GQAgG8ltqpk4E1QQqDtx99unfQTOcwrFPAGxj5kMaIwaF6MjygChb2LyLnAo
 4Yi5MNIryuhlddaXce3w5E2aeudliOyoPVs9uR9zMVrMXUTHfWYFQ/29a9ixBaLq6wtI
 PqxrzWuZK9pEZwjukdVgxyw0ZcUmqOFbgIbviU+MzOnygr5x5LXL7G4OZxsDbjZiRAwn
 eUYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784623865; x=1785228665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=a4MdhOXFCu6xM17u7XgcNGHi/henMeTFTDgKO2L9cts=;
 b=fhJBqYBfPdTRIkeHO/23+Xql+BpsS3Ew1bVx8FhiWdSPlBhjBymFaRO65MRq/Mlwnu
 Pkt3Eepjo+muC8tRJNooauit1Yx/mIMhrraCdkBCFPUxWJzxSBtgtrj5Y2SItL5qkwQU
 GsQ4DVxmH+/6kHnyAtIXQoUy6p5pJ+vee5k0P/A4wU8SDCu/oHwgYtxjKGkpHVwFDIgG
 zFv5vn0yhKAs+HJua8fCfO9YOo0vG31DzFjSEd+6o6HhgyVEq2w06/3JpkW4+2ZdriXk
 SMxCz+9qxthqgupmNEJRSTJZvCXfYGYxGR0brTWYZeDUnQpaps2xmyer1qD/7BOyt10v
 72lA==
X-Gm-Message-State: AOJu0YxHKT0RXHyQVO65wtPCXdaPAplXRX2yLGdrbqVRhbdePyGY3SjJ
 6SOby8f0l2YUl94qsywMhP/bbebW9/dLpVjeEb3oLZK1eSUnecS3THfdcVBlSNOWuBamf+0ghSH
 mFK18BVKSgg==
X-Gm-Gg: AfdE7cl57OVbbQC2jnbIeKfY6xoYfya6QuRvp/b6MQclQ6D7ovMqGXfb8sBT8oVASH7
 xa6+5GcdAmvZ1A9qpuP/rDfD9mMQWjTpY3XXOZXjMS4YHHP8OktlesZi1/x4HvDGugyjNwcIdYi
 9Rwo41W8W/A8ddF5SrGdV7nUmikmS3OyIPeDq8vtl4QBA4hAwXi9NmYSqi26we1p/4UZb/SdD6m
 ZxiA3hbNlbZ4DDM6IbqXR2cWLfsc809ID1XC332A3uu5VukjgeGa5N6qPYAafzhNyqRQIEbJvwh
 Z7USM2UUzhhXi2N7LMOWt6VA/Chkky1NJX89UKRLUm0nnJt/72UiNMZdFQiE3+rqVpEWTFP4dfN
 napBitE+ioZg1SZIZb+NTL6OQi6qSsbYUNJFkCCPDw6HVYVk0W5MtGMe9LNsXj7Eb2OcqUjs4fm
 QYKkY7RQzVcEl81IjwdR660n7U7newD+xb2mqB9OcLd2hszhI+DSjutLADWFZWQuQFn0SAdxytR
 lU88KVkYEw=
X-Received: by 2002:a05:600c:4746:b0:495:4d07:4fcb with SMTP id
 5b1f17b1804b1-4954d0784c6mr176970345e9.36.1784623865551; 
 Tue, 21 Jul 2026 01:51:05 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956537c7desm68707245e9.7.2026.07.21.01.51.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 01:51:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/16] hw/dma/soc_dma: dma bytes is uint64_t
Date: Tue, 21 Jul 2026 09:50:45 +0100
Message-ID: <20260721085050.421257-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260721085050.421257-1-peter.maydell@linaro.org>
References: <20260721085050.421257-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

The worst case number of DMA bytes that omap_dma will ask us to
transfer is 0xffff * 0xffff * 4 == 0x3fff80004, which is slightly
larger than fits into a uint32_t.  Move the byte count to uint64_t,
and adjust code that passes it around to also use uint64_t.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Jim MacArthur <jim.macarthur@linaro.org>
Message-id: 20260710105907.2570621-6-peter.maydell@linaro.org
---
 hw/dma/soc_dma.c         | 6 +++++-
 include/hw/arm/soc_dma.h | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/dma/soc_dma.c b/hw/dma/soc_dma.c
index bbcd2bdcd56..1b93aaf5655 100644
--- a/hw/dma/soc_dma.c
+++ b/hw/dma/soc_dma.c
@@ -49,11 +49,15 @@ struct dma_s {
     struct soc_dma_ch_s ch[];
 };
 
-static void soc_dma_ch_schedule(struct soc_dma_ch_s *ch, int delay_bytes)
+static void soc_dma_ch_schedule(struct soc_dma_ch_s *ch, uint64_t delay_bytes)
 {
     int64_t now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     struct dma_s *dma = (struct dma_s *) ch->dma;
 
+    /*
+     * Worst case delay bytes is only slightly larger than fits into
+     * a 32-bit integer, so this won't overflow.
+     */
     timer_mod(ch->timer, now + delay_bytes / dma->channel_freq);
 }
 
diff --git a/include/hw/arm/soc_dma.h b/include/hw/arm/soc_dma.h
index e1d75bb3baa..b5ad9743be5 100644
--- a/include/hw/arm/soc_dma.h
+++ b/include/hw/arm/soc_dma.h
@@ -49,7 +49,7 @@ struct soc_dma_ch_s {
     int update;
 
     /* This should be set by dma->setup_fn().  */
-    int bytes;
+    uint64_t bytes;
     /* Initialised by the DMA module, call soc_dma_ch_update after writing.  */
     enum soc_dma_access_type type[2];
     hwaddr vaddr[2];    /* Updated by .transfer_fn().  */
-- 
2.43.0


