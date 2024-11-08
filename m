Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5873DD5C0CA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2024 13:56:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t9PSO-00076N-QE; Fri, 08 Nov 2024 08:55:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSM-00075C-JM
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:22 -0500
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t9PSJ-0005b6-Uy
 for qemu-devel@nongnu.org; Fri, 08 Nov 2024 08:55:22 -0500
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-37d47eff9acso1330959f8f.3
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2024 05:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731074118; x=1731678918; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8mUw/2j0GVZe2OEKmbmEYrGKzq5ifsNFVXkG4rgChXM=;
 b=TgtuWIfJbN6f2ho9mcUnpMm5plv0m6bT0F74KnpTvWeiByjwDO/I6hk35LE4D3gK+g
 5/1UxSC/CzSPeRdE+JIDVv1n99ldaqog8BKfYG+MmKeISWSZExtpXCrlYy091HkyMiNC
 QiuHLptPv0jn9D6zQ2nCYkOHU8acJQ6V8JK6TfBi02lxFNe6rlmrPJj9/Gy80DHaqQGx
 ljvtPBSuGBCZb6TKNyB3VREtzeZ9W52p+DpiulHiDQqLEIIQbgbHGVjRxh483/DGHz1m
 YHy3g8YbZkxOgnSZMCWnoVbcSYAYNZuZE7HYr+ul+scCh9lnUiFWrVIGL8K8WU21Os+J
 83ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731074118; x=1731678918;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8mUw/2j0GVZe2OEKmbmEYrGKzq5ifsNFVXkG4rgChXM=;
 b=UcaLsea1ry/y4BFsRtBwXeRmr/omtLcxk9MzD303ERlvb5O/ppWooHFZ7pldDFZdTO
 Md5kxO02EHP1CTa4q4E2aZRE6A/nfqJSmnD7Ek212H6FsHAmFlvQ/L+EGRkN6OTOWP1X
 KiNiv+DZTnA1NY4U+4J07RwoIVQt3CBSc+ymKVTz1T4CX/fY/c+qoWMQRn6NH1R7ampU
 R/I1hr/O4WQ7Qtw8sdgQfBFJGBwr5MyiZUN9OZHn3pb+XcaVQBIVTyxa1ohFQhjWt6uc
 WdStOVwA6eb+c5iLLa2WBNdURubL4Bhbn+4c0+Tav0w/6eorJFsVdABtSD7cfezJgzz8
 q0Rg==
X-Gm-Message-State: AOJu0YxUJXMbYv2zUWffs5Xp9Ra92163aaXwJrtM9oSJVW5heuK573Al
 Ex1HCJualA5RLj62I8SZA7hA8QfVbpgxumqCTqShGky/uHA0mLvy1SesKu7YVkbxzaZV/4ItF4q
 c
X-Google-Smtp-Source: AGHT+IH/dEDW/BnSvrqHRRh1OTyQfwW3/+O3HzMHmdTiFZBa118G1ZjiAXv/xRsJzhOXjWFvg3hHsA==
X-Received: by 2002:a5d:648f:0:b0:37d:46fa:d1d3 with SMTP id
 ffacd0b85a97d-381f186d11amr2571930f8f.34.1731074118140; 
 Fri, 08 Nov 2024 05:55:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa70a2ccsm110082855e9.31.2024.11.08.05.55.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2024 05:55:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Song Gao <gaosong@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/3] hw/intc/loongarch_extioi: Use set_bit32() and
 clear_bit32() for s->isr
Date: Fri,  8 Nov 2024 13:55:14 +0000
Message-Id: <20241108135514.4006953-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241108135514.4006953-1-peter.maydell@linaro.org>
References: <20241108135514.4006953-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

In extioi_setirq() we try to operate on a bit array stored as an
array of uint32_t using the set_bit() and clear_bit() functions
by casting the pointer to 'unsigned long *'.
This has two problems:
 * the alignment of 'uint32_t' is less than that of 'unsigned long'
   so we pass an insufficiently aligned pointer, which is
   undefined behaviour
 * on big-endian hosts the 64-bit 'unsigned long' will have
   its two halves the wrong way around, and we will produce
   incorrect results

The undefined behaviour is shown by the clang undefined-behaviour
sanitizer when running the loongarch64-virt functional test:

/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:5: runtime error: store to misaligned address 0x555559745d9c for type 'unsigned long', which requires 8 byte alignment
0x555559745d9c: note: pointer points here
  ff ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
              ^
    #0 0x555556fb81c4 in set_bit /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/include/qemu/bitops.h:41:9
    #1 0x555556fb81c4 in extioi_setirq /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_extioi.c:65:9
    #2 0x555556fb6e90 in pch_pic_irq_handler /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/intc/loongarch_pch_pic.c:75:5
    #3 0x555556710265 in serial_ioport_write /mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/clang/../../hw/char/serial.c

Fix these problems by using set_bit32() and clear_bit32(),
which work with bit arrays stored as an array of uint32_t.

Cc: qemu-stable@nongnu.org
Fixes: cbff2db1e92f8759 ("hw/intc: Add LoongArch extioi interrupt controller(EIOINTC)")
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/loongarch_extioi.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/hw/intc/loongarch_extioi.c b/hw/intc/loongarch_extioi.c
index 02dc4e6db3b..97d1af5ccc2 100644
--- a/hw/intc/loongarch_extioi.c
+++ b/hw/intc/loongarch_extioi.c
@@ -57,14 +57,9 @@ static void extioi_setirq(void *opaque, int irq, int level)
     LoongArchExtIOI *s = LOONGARCH_EXTIOI(opaque);
     trace_loongarch_extioi_setirq(irq, level);
     if (level) {
-        /*
-         * s->isr should be used in vmstate structure,
-         * but it not support 'unsigned long',
-         * so we have to switch it.
-         */
-        set_bit(irq, (unsigned long *)s->isr);
+        set_bit32(irq, s->isr);
     } else {
-        clear_bit(irq, (unsigned long *)s->isr);
+        clear_bit32(irq, s->isr);
     }
     extioi_update_irq(s, irq, level);
 }
@@ -154,7 +149,7 @@ static inline void extioi_update_sw_coremap(LoongArchExtIOI *s, int irq,
             continue;
         }
 
-        if (notify && test_bit(irq + i, (unsigned long *)s->isr)) {
+        if (notify && test_bit32(irq + i, s->isr)) {
             /*
              * lower irq at old cpu and raise irq at new cpu
              */
-- 
2.34.1


