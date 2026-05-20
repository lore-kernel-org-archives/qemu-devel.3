Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58AFBCD5BAA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 19:25:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPmXF-0008Av-Om; Wed, 20 May 2026 15:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmX5-0007kc-2n
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:44 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wPmX1-0001tU-EX
 for qemu-devel@nongnu.org; Wed, 20 May 2026 15:24:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso70047715e9.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 12:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779305078; x=1779909878; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=wMLJEwyeCLqgj1Jg/Gcg3sR4YMXmetqIBMHZ1a3Cpic=;
 b=XeaDaeOvi9FLRoDDeGqQLZKJYCEcvQ6sZ7szSNKvmW2S2JHnYk7ZOylyeaY3N9toLA
 eaeeq5wGLS4H2ilf5xFTc24NA4qL/70xkODGobr87v39wTiWXqX/DMORpWSiGzssW+cK
 9kxCYMEp2+z6KkpI/MQvxqr9/3iyKsxsFMMNgm/lij6o6wDfX6EEsHy6PM3cjJu1/VAc
 FuOFSn6YDvD0Fvc3t438h/QUUaIo6ntRe59hw+7pA2kcnFV/vw7VMbgtTi6aZ4AAGAu9
 aevqTh6k13YJfSGZjRZAZSkJz7YF04D1DqWKWwmtnuGy1IeQmzoZOO9XN7ne/7uZJ7pW
 11OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779305078; x=1779909878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=wMLJEwyeCLqgj1Jg/Gcg3sR4YMXmetqIBMHZ1a3Cpic=;
 b=EbYpKXQkd4rdQjtC7XUBWwGc2We6sk042nMkA2wNFtts6BMqUJqDQtc6dl6NDBdeUE
 lM58a/aoAHABFS/ztblh3RW26TzUaqPkIAkVcSB8lrLfypiZBm/0aok6OtPjCrrIobYZ
 JI5JjFUKd1E34kbOqB7xmiElMlDfabb8bTIA0lL/w1YVXcAHjB9Va7T8736vGGolR3ZP
 OWYajMlEV9L76LSbKlew3NMaTdLl7jTzDRDJYkFFg8fVZGvPGvhQDeIXpGfZGlH6C78T
 86W9neWgLHnBeoAgizmwHvFjHLJ15yUHq965tsQWxNhCfO93jZPOX5RSF5bGj1Lu3Lig
 KqYA==
X-Gm-Message-State: AOJu0YwE1G6WEU7kOy/FXc0dtyUp31bi+QgbQ0R+34C5ddH7MUxbWpLC
 A6SMuuN52tEJIXinnDOMNGtfmv9aKQnKFzQ9IsupddydN1RAgAwF7Y/ldsSD1YKLAbZLGB7YtSl
 fBLhC8uA=
X-Gm-Gg: Acq92OEFpSvIwwbFnnt/6oZvKtaG2eARRXOvXYW7la2N7e99PCSP1Sfkd3+Iur51N9c
 N+seopenHd7SL6ZYieAFdRieTXBxYiTXaMgY6z/7li/g9I1HHxzSiUgpUMTMT/X6XBYCJ1njYYG
 Cw/GeeIqwSQHhpc1BuBWC6yawBcv8nsQH5AYAuR9tg0c5klB7LBbn0JBeuM/uEIAUrx6mYrwoZX
 +cOOudR20nxC/JFxQDTDtHpyl6jn6QgfFX3ycO1Fp/C/bGB1S1MZPfkVj824o0NGxZyKBgS8+YI
 KCXPhBtH0jyS0lnaE8fEf3Yq9yO7uSIgLZ9jbRJloKusvF2iRMIQrggjFCoWKGjYa5H6TkHwipD
 HBluNqhignC8Yl6Lp08wfF2mHNHCL+eD97aUSaSQ3XmQoZxit+Rt2Kli+IL61nXelj5FklfshjD
 HjwLXyNP86/mq4qqgeYXhcKc5p4ynB7MOntRd337lvOcvtvb7STfH4tVNkl/lxA9I/WWi4IQBB
X-Received: by 2002:a05:600c:a11c:b0:48f:e468:1761 with SMTP id
 5b1f17b1804b1-48fe60e47afmr289520305e9.2.1779305077737; 
 Wed, 20 May 2026 12:24:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6454sm57518150f8f.34.2026.05.20.12.24.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 20 May 2026 12:24:37 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 08/33] hw/intc/mips_gic: Avoid Coverity complaint in VP writes
Date: Wed, 20 May 2026 21:23:13 +0200
Message-ID: <20260520192338.40036-9-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520192338.40036-1-philmd@linaro.org>
References: <20260520192338.40036-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Peter Maydell <peter.maydell@linaro.org>

The MIPS GIC does a check for a guest error in the write path for the
SH_MAP*_VP registers which triggers a Coverity complaint because it
assigns -1 to a uint64_t. The code doesn't misbehave because the -1
case will be caught by the following OFFSET_CHECK(), but the code
could be improved:
 * there is no need to special case to avoid passing 0 to ctz64(),
   because (unlike the compiler builtins) QEMU defines that this
   has a specific behaviour, returning 64
 * the OFFSET_CHECK() macro will go to the "bad_offset" label and
   print an error implying that the guest wrote to an invalid
   register offset. This is misleading about the actual problem,
   which is that the guest wrote a bogus value to a valid register
   offset

Make the error check print a better log message, and avoid the
special casing on ctz64(); in passing, this should also make
Coverity happier.

CID: 1547545
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260512111536.3437645-1-peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/intc/mips_gic.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/intc/mips_gic.c b/hw/intc/mips_gic.c
index 23478df4b46..4777c70d6b4 100644
--- a/hw/intc/mips_gic.c
+++ b/hw/intc/mips_gic.c
@@ -317,9 +317,13 @@ static void gic_write(void *opaque, hwaddr addr, uint64_t data, unsigned size)
         /* up to 32 bytes per a pin */
         irq_src = (addr - GIC_SH_MAP0_VP_OFS) / 32;
         OFFSET_CHECK(irq_src < gic->num_irq);
-        data = data ? ctz64(data) : -1;
-        OFFSET_CHECK(data < gic->num_vps);
-        gic->irq_state[irq_src].map_vp = data;
+        if (ctz64(data) >= gic->num_vps) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Bad data value 0x%" PRIx64
+                          " at MAP VP register offset 0x%" PRIx64 "\n",
+                          data, addr);
+            break;
+        }
+        gic->irq_state[irq_src].map_vp = ctz64(data);
         break;
     case VP_LOCAL_SECTION_OFS ... (VP_LOCAL_SECTION_OFS + GIC_VL_BRK_GROUP):
         gic_write_vp(gic, vp_index, addr - VP_LOCAL_SECTION_OFS, data, size);
-- 
2.53.0


