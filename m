Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BEDFCA9EDE
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 03:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHCJ3-0005Y0-BN; Wed, 14 Oct 2026 23:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCIy-0005OV-JF
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:57 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jay.chang@sifive.com>)
 id 1xHCIu-0008MK-O4
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 23:38:56 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-3ac91ac8924so465138a91.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1792035531; x=1792640331; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=CqLwa4htZQpClvaVbLFVbra2MrILPKlP1KQg3xZA7x0=;
 b=KrWqDNrYxKxjEOv+/5vXRQRKCAaupfQs6isTYkWDpliK1+2Jl1eDdnWvKp2gYWCCKo
 +o5JrXKjf76m2EaA5aAiDhTuH1w6j9JEF1+ygbfGFfUlic/H+TZrn6TU48j8bO/4cW+y
 2WC5BSESaUSEo+/kS2+xUZU6vED4DDgerWmGY8Gb29oWOrzJUT5KKuQ10VAdNEOd5pqu
 CGMOhoV46RRRuhn4JgHk5q/TGeDihm62MRM/hXcHSp1df0jFJKdZEzXkbWA7Ys8nxdlt
 ikn90tN3TCWsTNfhhjBm3lcODcH/TZA7m8Y0FtnmPHVjOJBzbDa3ftftF0WZtLvKq430
 Ro6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792035531; x=1792640331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=CqLwa4htZQpClvaVbLFVbra2MrILPKlP1KQg3xZA7x0=;
 b=TZkyPk/SB9cimNhgdOROTzY+b6B0XO/M61ngQkLiQjFtSzvpJgtvrCKcYZW+OX251a
 1vl/e8nNahSCW7snBh6dCLAkX/QUzZyR7mvG1ZmkXxUP3HIzFETgqwSydLJ1H8nv9xYj
 3CNPoangq829o+FcaP9yZ097sDJKjQHtWSMB7kuPetb3jBl59oXu9Wm5jp3VDbvUmiG2
 CaMB5RnzM3hH14UTtUWOuTXxWcWtVN/U0DKtixu+LtN4SFIkjkyKBdWDOK0soAQqj+u9
 k6ovl/YrX4ZFlK/m7UMRc6thXua29fvQ/NYQv37CkuC2EsKukAchQ5WtoBGsg42KRXVn
 Vqlw==
X-Gm-Message-State: AFq9FYIF+1qmE9IdyASJHtQedMa2c+GobT+vW7GT8zflFMseIqTBsh4l
 zg+RDads/6JnzrAZ8Y8Y50moca1zUHLSvcUAs9Qv90ZsxjRl2xfwQqXd374RtU7X5lA9hjpCCRB
 cMD/JquE6MMw/5vxmPVlH9m60TjQL6e+u3SEKd9Lvh3+T8sFvhactOnngs/y6VCwulUpDE+UgMH
 nM9GCvn8tOMA9ZpPgqtoDJT8ClnFv/sBFR5W2MKR3e5ljmsQ==
X-Gm-Gg: AYBFou1IhopLMs+o/vqbbJF9mxraBgCE8u+pr0q4O9AxII3K0u4e9Fophz7A7or7PlK
 XwBltsuAjAb2lW3djgBVGukedDIYkhVevIbztAGYcWVz89WNj/5wCD72GNiNr6eHanRAxFXG1v+
 rusOCseOFZ5RyfsE0d/6NOWImRNxF7UZFLLcuvtaDkOSLCyDdJs9+hIMd1VlRdflIwD0K2IxvKo
 f/WdFbnxNVOnkxdWMVT1/NuIIueMmnXT9mlTsyK9ZW5oXVwVSVuXM+vYllJFV1qqQJ8iBY7EX1U
 eA/WCGYqP7A4GWljs6pei3xrggYhbY66iudxObhUlivu7jsQ4biDIZMYD2RENiF8WzlLXXqm0Jz
 Oftf0v3t+1Te4JnQ9VDqHyVqHeolVMaFxNNTrx1dWRBIigk1iDFiixzPDeL8yVLCWl1nSXkLqso
 2Up3jMyXcy6JGfr5FS99IbrK5VXy6HedGSPlEX+pSlxk8q6eXnbsn8gnLxKYyXbhzugStE6vZgV
 MJ5+kbDfIjWfop1pacyVkCY525Yengo+2Eg
X-Received: by 2002:a17:90a:d2c7:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3ab3a32d9b3mr14673987a91.6.1792035531093; 
 Wed, 14 Oct 2026 20:38:51 -0700 (PDT)
Received: from jchang-1875.internal.sifive.com ([136.226.240.181])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd635c612a9sm559188a12.17.2026.10.14.20.38.48
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 14 Oct 2026 20:38:50 -0700 (PDT)
From: Jay Chang <jay.chang@sifive.com>
To: qemu-devel@nongnu.org
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org (open list:Xilinx Zynq),
 Jay Chang <jay.chang@sifive.com>, Frank Chang <frank.chang@sifive.com>,
 Jim Shu <jim.shu@sifive.com>
Subject: [PATCH 5/6] hw/dma/xilinx_axidma: Don't start transfer on TAILDESC
 write when halted
Date: Thu, 15 Oct 2026 11:37:32 +0800
Message-ID: <20261015033733.35116-6-jay.chang@sifive.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20261015033733.35116-1-jay.chang@sifive.com>
References: <20261015033733.35116-1-jay.chang@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=jay.chang@sifive.com; helo=mail-pj1-x102a.google.com
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

Spec: "If the AXI DMA Channel is halted (DMASR.Halted = 1 and
DMACR.RS = 0), a write by the CPU to the TAILDESC_PTR register has
no effect except to reposition the pause point."

Check DMASR.Halted and DMACR.RS in axidma_kick() so that a TAILDESC
write while the channel is halted only updates the pointer and does
not start a transfer.

Signed-off-by: Jay Chang <jay.chang@sifive.com>
Reviewed-by: Frank Chang <frank.chang@sifive.com>
Reviewed-by: Jim Shu <jim.shu@sifive.com>
---
 hw/dma/xilinx_axidma.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index 687b5080e0..a9c2c2a275 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -536,6 +536,10 @@ static uint64_t axidma_read(void *opaque, hwaddr addr, unsigned size)
 
 static void axidma_kick(XilinxAXIDMA *d, struct Stream *s, int sid)
 {
+    if (stream_halted(s) && !stream_running(s)) {
+        return;
+    }
+
     s->regs[R_DMASR] &= ~DMASR_IDLE;
     if (!sid) {
         stream_process_mem2s(s, d->tx_data_dev, d->tx_control_dev);
-- 
2.48.1


