Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4859ECD6E43
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 11:48:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSvgd-0001UL-BR; Fri, 29 May 2026 07:47:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvga-0001RX-3U
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:32 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wSvgX-00089W-W5
 for qemu-devel@nongnu.org; Fri, 29 May 2026 07:47:31 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-48e8132c6d0so88203935e9.1
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 04:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1780055248; x=1780660048; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Gu39tWs0RcZyH4C2B3SuMjpIx3n47+25EF5CIC4US8Y=;
 b=iyqDovozJhJeJI8Z8kyc4uyemAvvNiyX0i3+HDD9gJd/AOdIG4DZBQ2LQKc5vril+b
 F0WL4KHFUZRl5ebTba9Q30K/a802f7xdbi30QKRpoW1wNfKmV2sY9kCfSxL74Tu7ro4G
 pBhkTleeNUfyIJKUFoav2XxB2jOYeAyD+seo+zUto7bz6T8nR/qfWaCwYaiLvlaPjcGh
 5QJj+Qf8pzBSNzcwgkPf4t7Uk5u4InGXucv9l21SGK1bvK901GK6YueboONqxWV/s9sh
 w4TcXm/8+iyQDgNXYvnCVnbN1WMNYAZrvFZUoXmAg7+w4KXkB60QcNATyFqy/l+QzWI+
 Knzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780055248; x=1780660048;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Gu39tWs0RcZyH4C2B3SuMjpIx3n47+25EF5CIC4US8Y=;
 b=oxteGiJotIBWjV0q0Z4J+1GWxqDanRH1bTXSDXSgssUFlahrJdy9jvj/SG+WYW1Y3I
 VnmB5rKo7GITbB/bdsydaErHx01UHrKSeNf8L+6YeSrkLG+Zz3FthKlzTrbpDEOoCT/K
 qBz4PR47MYdwpu+pEN1lw/+p/evJLpPOnaYEZcmrIbvkE8pVdbdvlK9YfrU+BDXeL9wB
 nqGY89vhX79iEpzbFaVjMbqz9e8rWAyX1msba4M7nilZgNOpLXJHFJly0u0IvGP8BA2F
 q7peiVICcG0aWh6Bx0zjmg8CIaa1kSTgYITYqA0ulntikjmqOBLUCyAjblJ/YJK/uKl1
 hWXg==
X-Gm-Message-State: AOJu0YzC/3rG9tRLsAfyAvB3AutEPQ1AoyJyvGBolsLn0E08M/dSmMgY
 Su2gVyh7Ub9lrRrLWFuY+W8uyWRgvBFSB2mO0W+rkAbyl7BJBlvtb813f4PBD6naLTb3wXOPslS
 aKMQg
X-Gm-Gg: Acq92OG3OwzjCHsHKiSR26HQPWTrsHvaQZjaLRlJdrq52D/FGyb5nKdqPZGzywiuREt
 +N0zsGpyhRGvxgYnnCZqTToTwWFyfoEu6spXQARSLs1lbc1khf51eldO4iq48JLPgE0bksDMS7q
 drfNQUbzJbAq51wDh5x5VbBgN8c/CBiVnQLoQJDW3tpPZ0H28QCfIsdmRx6xfQ/oXXWHlMybVK0
 VEJSi7CXMcvINYUSfZJoNGZLTMR/gOBiqj39Dzz/wq8WwwoJ2kZUMuUccswjwubZrMBAowk4Ggc
 jG0eWCBg2DBN1Jcwka8Qr7zrM/3GZF5Zh2QsRmKs56I3cFbDQvRBBzCSw78YbL5lzym8/QV1jSy
 fqK+G2r/HNBxvYzd0bR/MNN4VeFqm+8oviIdQgkCmjpsXimYkDyZumr+XrriQX+UNkba20D1S7w
 a9p40EoPXgqzOqIVavNJ8s4KOJDk+NVwSAsZnSQ0SNDf/VuEtW9vCPfgJ5zBr76gDA/jnxUBjHb
 h0yryiRP/PRkp3OYlHXIafu1pLerpzukDWueBP6zQ==
X-Received: by 2002:a05:600c:4fd1:b0:48f:e230:c3fa with SMTP id
 5b1f17b1804b1-4909c0f9b76mr42357265e9.32.1780055247619; 
 Fri, 29 May 2026 04:47:27 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3563cb9sm3007358f8f.29.2026.05.29.04.47.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:47:26 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] hw/dma/zynq-devcfg: Handle bitstream loading via DMA to
 0xffffffff
Date: Fri, 29 May 2026 12:47:03 +0100
Message-ID: <20260529114723.42040-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114723.42040-1-peter.maydell@linaro.org>
References: <20260529114723.42040-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

From: YannickV <Y.Vossen@beckhoff.com>

A DMA transfer to destination address `0xffffffff` should trigger a
bitstream load via the PCAP interface. Currently, this case is not
intercepted, causing loaders to enter an infinite loop when polling
the status register.

This commit adds a check for `0xffffffff` as the destination address.
If detected, the relevant status register bits (`DMA_DONE`,
`DMA_P_DONE`, and `PCFG_DONE`) are set to indicate a successful
bitstream load. If the address is different, the DMA transfer proceeds
as usual. A successful load is indicated but nothing is actually
done. Guests relying on FPGA functions are still known to fail.

This feature is required for the integration of the Beckhoff
CX7200 model.

Signed-off-by: YannickV <Y.Vossen@beckhoff.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Message-id: 20260518073401.11279-2-corvin.koehne@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xlnx-zynq-devcfg.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/hw/dma/xlnx-zynq-devcfg.c b/hw/dma/xlnx-zynq-devcfg.c
index cf00aa863d..9708200760 100644
--- a/hw/dma/xlnx-zynq-devcfg.c
+++ b/hw/dma/xlnx-zynq-devcfg.c
@@ -247,7 +247,14 @@ static uint64_t r_lock_pre_write(RegisterInfo *reg, uint64_t val)
 static void r_dma_dst_len_post_write(RegisterInfo *reg, uint64_t val)
 {
     XlnxZynqDevcfg *s = XLNX_ZYNQ_DEVCFG(reg->opaque);
-
+    if ((s->regs[R_DMA_DST_ADDR]) == 0xffffffff) {
+        DB_PRINT("bitstream loading detected\n");
+        s->regs[R_INT_STS] |= R_INT_STS_DMA_DONE_MASK |
+                                R_INT_STS_DMA_P_DONE_MASK |
+                                R_INT_STS_PCFG_DONE_MASK;
+        xlnx_zynq_devcfg_update_ixr(s);
+        return;
+    }
     s->dma_cmd_fifo[s->dma_cmd_fifo_num] = (XlnxZynqDevcfgDMACmd) {
             .src_addr = s->regs[R_DMA_SRC_ADDR] & ~0x3UL,
             .dest_addr = s->regs[R_DMA_DST_ADDR] & ~0x3UL,
-- 
2.43.0


