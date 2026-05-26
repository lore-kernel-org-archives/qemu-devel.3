Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE09CD5BB1
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 14:31:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRsmE-0008Ed-5u; Tue, 26 May 2026 10:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsmA-0008D8-1M
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:58 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wRsm8-0001CU-H4
 for qemu-devel@nongnu.org; Tue, 26 May 2026 10:28:57 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-459bf19e87bso6313709f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 May 2026 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779805735; x=1780410535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UdjTHLYBetoc9TKYb2f7ANqXYXx1r+CPBHy+H/sXTwU=;
 b=V+z7ajN1Y+vmpzG9JHEBkOuFkosSHAigufDohtOVruoss5NVymRfKV/9lS9H1A4HTP
 OFhwLg2KpJ3Ko8peBtgZu7/lkzCfcTj2nklY9Kpim9NpC7I2RY6r14SIWihzMsayt+IF
 S490VBlP3CpxAfKA/Rl8JUYxSJrg6vBgs/SyMCzWCGqrpddyKDdZmUtWBb3ywZlhwENN
 DOVmF9slbIAYN9tM2XWwMiZLg3KvWBqrK5KV6Z/6DSqlp25sucuKeybffhrBbN9JC4YF
 +JNKMjDFzp4VAWjkBF9JxvnYhVGcqQNn2ugOok+0k6hHN//4AR5ccxFdLlvGJBkoaIfm
 X0Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779805735; x=1780410535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UdjTHLYBetoc9TKYb2f7ANqXYXx1r+CPBHy+H/sXTwU=;
 b=lSchERdshCOKEnBBKAcVofScdgXCbr5vKt0axKDHP+hcb14E11OLUDaaA1uQgv3Crv
 URwP4Z54KCzuHmlW8BQAXu5Yz9pPv/y1/ibQ2qocaNQjypg80xHd5dVF7OwMDs82SOW/
 x6FOQMJzhel+gSeMLZAYZ8e3BLXzLsxLRMCSXjSYbxkCZu3YRv66/1YzKv6sdsU+5oJN
 wHL9l+iUdySINnkmwnSpFDRHUNw9uDBVvsReAcKTaynFlXelcc2r6pw3ynrkyrcSzNtq
 5ww9m1Av0X9FVTrHlV/HfLu96juBFKZ9fJhToYdpnCkmq0qk7MQo8+YGq+vE0FWbwEV4
 bPbw==
X-Gm-Message-State: AOJu0YwHiH1yE6uT69lnCbXeO/0f+0qQ8O3jeEl1vzDnOhWNjDAthrEd
 EaWftgkPDLGYDumKnOyNTvVs8E873t1jmgP9JXJ+zEjgRJkK6dpb8sEvRbIAYq/5rBEP2CnOmQr
 I3XQ7
X-Gm-Gg: Acq92OFDaMw/wx8CvfzRJgJ/qNAVkCDbP5BmTRdOC/ZAtGU51Dr6hcKO+YREebrW6zJ
 kwG3diMMoUCKBHqQajjd9CtbrAiAUeBBcEuaTy93Q7Mk2A8EO8ST6Sx/i70qHBNbQTpQts5kfjJ
 KmcS7T6/qv6JYnBtms0L8UfAtRlM8cvmeUWsS1ljSn8TByCr90O9F6jxD6wn0GjaZWbS0EbIBuR
 O9ziqlyJkG5G+45YDhMjbUbFo+d7kmJJKzflquaEzsKPrIaAFxDKdDwlZHm6vnB6gMYLCxzQib7
 pNRAGX+Gsmm237ycA2IyhHA0fyT4CMOkkEXpi+9tvUkfxnxs/tOR04WVKaSChHOB5wRFwitQbK6
 nqrAew0isJp0yYnjRXkrtymSgJQdvImAeK9qUQ4AiIQiyVdvPBsolt8o3V3X/+XcHgaj+kt1ZwX
 Le7yl8AWMXMkqiMF4nWO2ElvkuZB6R+5m+EK1tfMfXo+irN87PNoFsePuemzsS5OqLOec5hMFQE
 9zdPzHjhiQtz08jXB1Vsv9hIbOzBWo=
X-Received: by 2002:a05:6000:2384:b0:441:3144:efc5 with SMTP id
 ffacd0b85a97d-45eb38e4fd0mr32446382f8f.42.1779805734838; 
 Tue, 26 May 2026 07:28:54 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6d70c51sm38325225f8f.36.2026.05.26.07.28.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:28:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 03/54] hw/arm/omap: Remove unused omap_mpuio functions
Date: Tue, 26 May 2026 15:27:59 +0100
Message-ID: <20260526142850.2326589-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526142850.2326589-1-peter.maydell@linaro.org>
References: <20260526142850.2326589-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x430.google.com
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

The omap1.c file includes some functions which used to be used by the
other OMAP SoC variants which we removed a while ago, but which we
missed when doing that removal.  They have no callers, so we can
delete them.

This code was the last user of hw_error() in this file, so we
can also remove the hw-error.h include.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20260512203414.3633237-3-peter.maydell@linaro.org
---
 hw/arm/omap1.c        | 26 --------------------------
 include/hw/arm/omap.h |  3 ---
 2 files changed, 29 deletions(-)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index c9f9c3ef40..15087ba03e 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -25,7 +25,6 @@
 #include "target/arm/cpu.h"
 #include "system/address-spaces.h"
 #include "exec/cpu-common.h"
-#include "hw/core/hw-error.h"
 #include "hw/core/irq.h"
 #include "hw/core/qdev-properties.h"
 #include "hw/arm/boot.h"
@@ -2095,31 +2094,6 @@ static struct omap_mpuio_s *omap_mpuio_init(MemoryRegion *memory,
     return s;
 }
 
-qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s)
-{
-    return s->in;
-}
-
-void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handler)
-{
-    if (line >= 16 || line < 0)
-        hw_error("%s: No GPIO line %i\n", __func__, line);
-    s->handler[line] = handler;
-}
-
-void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down)
-{
-    if (row >= 5 || row < 0)
-        hw_error("%s: No key %i-%i\n", __func__, col, row);
-
-    if (down)
-        s->buttons[row] |= 1 << col;
-    else
-        s->buttons[row] &= ~(1 << col);
-
-    omap_mpuio_kbd_update(s);
-}
-
 /* MicroWire Interface */
 struct omap_uwire_s {
     MemoryRegion iomem;
diff --git a/include/hw/arm/omap.h b/include/hw/arm/omap.h
index 6ea47293a6..dc63323210 100644
--- a/include/hw/arm/omap.h
+++ b/include/hw/arm/omap.h
@@ -486,9 +486,6 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
 void omap_uart_reset(struct omap_uart_s *s);
 
 struct omap_mpuio_s;
-qemu_irq *omap_mpuio_in_get(struct omap_mpuio_s *s);
-void omap_mpuio_out_set(struct omap_mpuio_s *s, int line, qemu_irq handler);
-void omap_mpuio_key(struct omap_mpuio_s *s, int row, int col, int down);
 
 struct omap_uwire_s;
 
-- 
2.43.0


