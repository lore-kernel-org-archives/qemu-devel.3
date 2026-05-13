Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5B2CD4F24
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 10:58:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wN7Gq-0003WA-KF; Wed, 13 May 2026 06:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FX-000382-BX
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:39 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <corvin.koehne@gmail.com>)
 id 1wN7FO-0001NZ-Ih
 for qemu-devel@nongnu.org; Wed, 13 May 2026 06:55:32 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-44c350a5b87so4147854f8f.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 03:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778669723; x=1779274523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bGVucTk00lHJOoHDxhxqBmDjYYXRIxmmMPGfNidYBio=;
 b=kkSgijcYM4DiZ6FTouIJdOQbD2xU9K7AXrrIQ1hzbUJ71CABOzzA37FI4cADfYBnJK
 RhND/qweTkj+Jqmvl0m34u6PlZj7/YBu/WyR9dj98h4170fHOj65F14DFji3NPqS4qic
 g95o+jJBAg/qmxPYvJYvnSoVbvEFvGRcB8DtGDJ7H7AppJCgI7NkaHZW2yZjdGloUrIS
 ldbUhMq5VSEzKFeOrimpStBztAc/0t69SBLpNhssu9NeM5SSK56IpnuryGA166/b9+o1
 KD1GwD4Hpj7SQG1AJTcV0TrLFecwhb840/Jt9CSuwDsuVxSIW8+H0RGAw5ICUCUDiNE/
 m93g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778669723; x=1779274523;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bGVucTk00lHJOoHDxhxqBmDjYYXRIxmmMPGfNidYBio=;
 b=Gdgfm3/8qn62ALjt8vYwUQ/1nV0/tcJwzwx0bCO0sWPRpXfERK7Ycn8DSZ6M8KiETp
 +SqK5Surem8GfLZqUPrXnClFI5toYbx2ERT+SSuIim92HcXuAAQTettTXoxZnWEhPXh6
 IyX13S4zZLMsjfXGNgSvI6kp8V98CfQSnEyOjsZlYeU+MOaUq5/dx3/kYcjvjzfQMgBr
 F2k1L3POdhiIhBsjansfEpIlTcs1+c6qdltICSr+NBFdw8/NzOZzuuhTiPNMSGfftouv
 6QfWvgOhdwe3xkaVO/PC7p39ui67jxXCccDMDBaT/2lRUOw2PH1rScdl7FEo0ev/lGTA
 fy5A==
X-Gm-Message-State: AOJu0YxudAK36i0HuIU9oDA4xZTEVE7+hze7cpBCyipK9CTnOsFnC0Rs
 b6Outh2omygSUVX+ow0L5zPYt1/6mqE/XuPXVgc6XvnVAj86tg8e1aQojXKSV6zT
X-Gm-Gg: Acq92OE4SlDjdP5KjySSFF6de6gSjcsD6qNxM4+d430jlcjbozrwKGyLafGRzIoH+Ci
 MQfVztSdCD4XTWhv9353fyFKzzAIWpIOMX5xlLKKz9/nIEXAtvPlZKgpN9K/HRDEJjWKyQJom1n
 E0NVqXQD3+eqWgH+n51BTKDVx14TSM8r121A7v82slF2hTh0W6yqjbkPcZzFQ/HPLQNJPryRYrc
 DFyr3poErTc8nf6l/w2e9Vgx/veFTUQ3JgW2SJ2Uz49vOWX+X5jnZ7i75Iq/xlSqfBzmyhnmK6N
 AJBc6u7oNE5Y7hUbwiudEfplG/5F3Gx77V+RM7EgQVr623PvLzYCTyhB6lXwDGRAVNLZRYse4QL
 yHTSF9tB59bWfjAqc/PuuPF0RsIN0zr41PrYgseWZFBDIg80RuQVIMIHSfr0/ImcToX7MQz3Qe0
 HcM/9cXzr9IxsuLUONFzK2tMoOHoix0wo/56kgliCTlbmFkGYjoQsUhR8=
X-Received: by 2002:a05:600c:45cd:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-48fc9a1bacbmr39171285e9.12.1778669723059; 
 Wed, 13 May 2026 03:55:23 -0700 (PDT)
Received: from PC-DA2D10.beckhoff.com ([195.226.174.196])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410d9fsm56062295e9.6.2026.05.13.03.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 03:55:22 -0700 (PDT)
From: =?UTF-8?q?Corvin=20K=C3=B6hne?= <corvin.koehne@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?q?Corvin=20K=C3=B6hne?= <c.koehne@beckhoff.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?q?Yannick=20Vo=C3=9Fen?= <y.vossen@beckhoff.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 YannickV <Y.Vossen@beckhoff.com>,
 "Edgar E. Iglesias" <edgar.iglesias@amd.com>
Subject: [PATCH v6 03/15] hw/dma/zynq-devcfg: Handle bitstream loading via DMA
 to 0xffffffff
Date: Wed, 13 May 2026 12:55:05 +0200
Message-ID: <20260513105517.146706-4-corvin.koehne@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260513105517.146706-1-corvin.koehne@gmail.com>
References: <20260513105517.146706-1-corvin.koehne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=corvin.koehne@gmail.com; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
2.47.3


