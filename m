Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A83CCD1A5
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 20:53:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBJI3-00010T-VZ; Tue, 21 Oct 2025 16:49:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJI2-0000dp-5x
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vBJHt-0001Ci-Kl
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 16:49:01 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4711b95226dso49332715e9.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 13:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761079735; x=1761684535; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ldA81TOhO5CyCm5FfejA2XOTZsnGVZH3vj2puivaEgs=;
 b=TPk+MFFVr5jIXHrUQ0A6ttXJnjjJWThs0RrvAiPrxKeimJHa3z3zZtw03QTGDrVHCb
 ENO4fHyXGZmAuODX2uYpVtx+wgTSULqhFiuhoDmr0lbcqmrXTMZv+gvvMD+Rj/KBfDwK
 Rr8N/pLtTIZKnRTA/3B+XC9oi/qz0DbQxU/lR3/tAlCkdOy0d8grGv5YLrGGgy/l+p70
 FstGtORhxxqMDqbnuu8NmcCdN9amPOibBkuDyIwS5/uTgzcsOFMnFMMT2mWKaGy1TzsM
 VCtNSXzpHw+LOwEXGyqgyEEWIx4ZCB3XVmheNMA2JJMgImhWUE+A6ZUUKvu1MVhpNBYn
 xvwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761079735; x=1761684535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ldA81TOhO5CyCm5FfejA2XOTZsnGVZH3vj2puivaEgs=;
 b=sqzzb6PrZi0hCRgIY86Z1NNpkMnRJLJd3E827e62PerD2I2PRUajWxrinQl79lJrPx
 RLvo1eMx+jftgxAOulxS+2zDpTCmBuDEZR7ILhUIP2fMbIe3Z5f+0N4kehTALRtGvAoX
 cKDAb2I+UHXzpFBAjnLdT7yCPyvrLJJqENylndIqnoZrjc/8y8HOxHk//5T+4y1i2oQv
 FCqsbguWqlJELnX4MJ+nJ6jamdPCTDhqxYsOUnJLvXabDDiYqRxPH2PTwAbuSUrelaGR
 73IDQvPGiOXQ3jP687zbpCJp4kafIIsOXF4yG5c5QqgRiWafm8OFgDyGNxu/6PZtS8tt
 RCXw==
X-Gm-Message-State: AOJu0YwrlDrFiMrkpTI6EFc4qu8dyMflO4YYNQCSTNx0HJB7SE1hiVDQ
 KnM4Uzs3tzwFGSDiON2YDvDWJr0QdEU0rMo9Fq0p0v8ITUUYgyIbRAmiy9X9E1grgqomjjdrfRb
 Nsi//4zw=
X-Gm-Gg: ASbGncu62maidQDveyOOeRNUxs3ymsM6J9T6IjQ2X6xZMLpzYMwcvAPCNrwy9s4pjLk
 NYNIG23NzJ2G6+61wkAkYBiQxXRpU5XpW+l/IoAg8oF7W6ZEdbCM8ojEB0XRZSbb1ijQG1eBglB
 ThtJzd3xWWRrfNFJoq3/KbEzXJcCwFuPwFHxnS05IXiojbHrVdaF2lk3WAMmSbFQrUXb7mZMk7E
 0Uw8i+KAhwSZxYxQqB8qv7/OIR95tjQpHB0ovQeHRwoAno2h8FG94tdA/fRdd47DkYuPCAxjuL1
 Pj+7MWekJN5n7wvHXdE9nYAkBTg0mRnJkrgGYS25iGTyb7bvv5wXgS+HjrLDu+iiJPuYN/ET9CB
 AKYpAnP+IwzpVGFUMaQHMdZNKMMKaY3soBfYIyBfwZZPOzy02Va45hS0YT3XaeQZsaBzoROBbI3
 3Q7EbF3s2yxJvcNqY08Vpx3j7FYLl01aeCtGYKgsqMvsNeXgIO0TZEsfVSVfcd
X-Google-Smtp-Source: AGHT+IEjwL4Pt02bvRQBC/REJhqK2MnjVJeC7iXTfXnmhvQnvyk71tYbxZ0pmKAAz4HQPPvMYOyNjg==
X-Received: by 2002:a05:600c:3e86:b0:46e:36f8:1eb7 with SMTP id
 5b1f17b1804b1-471178a3a94mr131546405e9.10.1761079735065; 
 Tue, 21 Oct 2025 13:48:55 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-475c42b48c9sm10820645e9.15.2025.10.21.13.48.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 21 Oct 2025 13:48:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/45] hw/timer/i8254: Add I/O trace events
Date: Tue, 21 Oct 2025 22:46:38 +0200
Message-ID: <20251021204700.56072-25-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251021204700.56072-1-philmd@linaro.org>
References: <20251021204700.56072-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

From: Bernhard Beschow <shentey@gmail.com>

Allows to see how the guest interacts with the device.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20251019210303.104718-2-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/timer/i8254.c      | 6 ++++++
 hw/timer/trace-events | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/timer/i8254.c b/hw/timer/i8254.c
index 4b25c487f79..7033ebf50da 100644
--- a/hw/timer/i8254.c
+++ b/hw/timer/i8254.c
@@ -29,6 +29,7 @@
 #include "hw/timer/i8254.h"
 #include "hw/timer/i8254_internal.h"
 #include "qom/object.h"
+#include "trace.h"
 
 //#define DEBUG_PIT
 
@@ -130,6 +131,8 @@ static void pit_ioport_write(void *opaque, hwaddr addr,
     int channel, access;
     PITChannelState *s;
 
+    trace_pit_ioport_write(addr, val);
+
     addr &= 3;
     if (addr == 3) {
         channel = val >> 6;
@@ -248,6 +251,9 @@ static uint64_t pit_ioport_read(void *opaque, hwaddr addr,
             break;
         }
     }
+
+    trace_pit_ioport_read(addr, ret);
+
     return ret;
 }
 
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index c5b6db49f58..2bb51f95ea8 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -49,6 +49,10 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
 
+# i8254.c
+pit_ioport_read(uint8_t addr, uint32_t value) "[0x%" PRIx8 "] -> 0x%" PRIx32
+pit_ioport_write(uint8_t addr, uint32_t value) "[0x%" PRIx8 "] <- 0x%" PRIx32
+
 # imx_gpt.c
 imx_gpt_set_freq(uint32_t clksrc, uint32_t freq) "Setting clksrc %u to %u Hz"
 imx_gpt_read(const char *name, uint64_t value) "%s -> 0x%08" PRIx64
-- 
2.51.0


