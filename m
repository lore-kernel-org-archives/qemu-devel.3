Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC11C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 01:23:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rbsIG-0003IW-A6; Sun, 18 Feb 2024 20:18:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIC-0003Fh-IT; Sun, 18 Feb 2024 20:18:00 -0500
Received: from mail-yw1-x112b.google.com ([2607:f8b0:4864:20::112b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <serg.oker@gmail.com>)
 id 1rbsIA-0004F2-QZ; Sun, 18 Feb 2024 20:18:00 -0500
Received: by mail-yw1-x112b.google.com with SMTP id
 00721157ae682-6083cabc2f9so2533827b3.1; 
 Sun, 18 Feb 2024 17:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708305477; x=1708910277; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gTWny3BHhQYhPthgOP80axxW+6kBcEUK8Ghc8bz95h0=;
 b=gKoOb2jYjVuYBbY0pFA12GqKV8Nq8XRy17rv+TIJM1OTLZLATf0b9xCJ8ynWJQZrtd
 RaKIrE9Q8mJRxaYHBLIQKlF7cZWH5CqWFtaD83jZIlGCvaPL27MBr2/WToAuDKjivzMD
 QCn1tX5v6GJs6eNDBbcY0xkpcuFuDSi3Q9O+R56nSb7aoK1YXBFq4a9RQMbWVVRkBvIX
 3UsiEKwYg4d+XTjDVVzhq9Pd1NQO4Oiap6cLxiAJjBWgyW9YNqBV1XuuyfSYv5pvlLD2
 5PomuozzSYSexap6yCay5BSHrMdWvIqIDYEl2hegmR9Lqbh9dp4VW5JaIb460V5bzUmr
 pT7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708305477; x=1708910277;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gTWny3BHhQYhPthgOP80axxW+6kBcEUK8Ghc8bz95h0=;
 b=hc4fPwFpxh2sEUxnWVqHzsAUv3B9OQmN7h1xwLZWtujKrBsZSAK7lemON+g9SBqFbO
 nRFSGeW0e3jvoiTsu8nseOUq0XszXbHuEFBlqYKffH7kUA1nh+F+G8z3kqEZtFIoJcKj
 mhCPhlh2fFq/1YMiEBpvwFuNbdZ7srXiKPI3N/5avgUnJDogE6t0sbGfX7UX7KbPVD5D
 smMy2983xPjaXga5cVO+Y1V5hB8Khu/aCsINc+b+v1l1ghUKIhJKyZt9NGuovFxj7bf2
 OoZNzpaf2dldQeBodxls7seeKjZWdfcHjTOE+fVeOv4a7DoqM+OqKZhLLmrRe5PIsjws
 I1eQ==
X-Gm-Message-State: AOJu0Yzgq6lp8VoWWYI/7i72ZR/+KhWlwonOY4WZiY2mL8aS7q3ScB7A
 cAZVFM6t9+gBoUnDaEMRXS7E4K8MeltQkXdeF2QWcx7+e5u397uwmkY8l5XFF3w=
X-Google-Smtp-Source: AGHT+IF2TQkHCXpGhv2E1y5DU44SZR1dHApMv5qwIICbJoYgzbhoMDqve+MqN46wWfahVYdEUy4JDA==
X-Received: by 2002:a81:4143:0:b0:5ff:bb43:2a69 with SMTP id
 f3-20020a814143000000b005ffbb432a69mr9458486ywk.40.1708305477352; 
 Sun, 18 Feb 2024 17:17:57 -0800 (PST)
Received: from localhost.localdomain ([201.203.117.224])
 by smtp.gmail.com with ESMTPSA id
 m12-20020a819e0c000000b00607ff905ed3sm1204704ywj.58.2024.02.18.17.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Feb 2024 17:17:57 -0800 (PST)
From: Sergey Kambalin <serg.oker@gmail.com>
X-Google-Original-From: Sergey Kambalin <sergey.kambalin@auriga.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org,
	Sergey Kambalin <sergey.kambalin@auriga.com>
Subject: [PATCH v5 07/41] Implement BCM2838 GPIO functionality
Date: Sun, 18 Feb 2024 19:17:05 -0600
Message-Id: <20240219011739.2316619-8-sergey.kambalin@auriga.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
References: <20240219011739.2316619-1-sergey.kambalin@auriga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112b;
 envelope-from=serg.oker@gmail.com; helo=mail-yw1-x112b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Sergey Kambalin <sergey.kambalin@auriga.com>
---
 hw/gpio/bcm2838_gpio.c | 193 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 3 deletions(-)

diff --git a/hw/gpio/bcm2838_gpio.c b/hw/gpio/bcm2838_gpio.c
index a312490bbd..69d15dbb49 100644
--- a/hw/gpio/bcm2838_gpio.c
+++ b/hw/gpio/bcm2838_gpio.c
@@ -18,6 +18,7 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "hw/gpio/bcm2838_gpio.h"
+#include "hw/irq.h"
 
 #define GPFSEL0   0x00
 #define GPFSEL1   0x04
@@ -56,14 +57,139 @@
 #define RESET_VAL_CNTRL_REG2 0x50AAA95A
 #define RESET_VAL_CNTRL_REG3 0x00055555
 
+#define NUM_FSELN_IN_GPFSELN 10
+#define NUM_BITS_FSELN       3
+#define MASK_FSELN           0x7
+
 #define BYTES_IN_WORD        4
 
+static uint32_t gpfsel_get(BCM2838GpioState *s, uint8_t reg)
+{
+    int i;
+    uint32_t value = 0;
+    for (i = 0; i < NUM_FSELN_IN_GPFSELN; i++) {
+        uint32_t index = NUM_FSELN_IN_GPFSELN * reg + i;
+        if (index < sizeof(s->fsel)) {
+            value |= (s->fsel[index] & MASK_FSELN) << (NUM_BITS_FSELN * i);
+        }
+    }
+    return value;
+}
+
+static void gpfsel_set(BCM2838GpioState *s, uint8_t reg, uint32_t value)
+{
+    int i;
+    for (i = 0; i < NUM_FSELN_IN_GPFSELN; i++) {
+        uint32_t index = NUM_FSELN_IN_GPFSELN * reg + i;
+        if (index < sizeof(s->fsel)) {
+            int fsel = (value >> (NUM_BITS_FSELN * i)) & MASK_FSELN;
+            s->fsel[index] = fsel;
+        }
+    }
+}
+
+static int gpfsel_is_out(BCM2838GpioState *s, int index)
+{
+    if (index >= 0 && index < BCM2838_GPIO_NUM) {
+        return s->fsel[index] == 1;
+    }
+    return 0;
+}
+
+static void gpset(BCM2838GpioState *s, uint32_t val, uint8_t start,
+                  uint8_t count, uint32_t *lev)
+{
+    uint32_t changes = val & ~*lev;
+    uint32_t cur = 1;
+
+    int i;
+    for (i = 0; i < count; i++) {
+        if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
+            qemu_set_irq(s->out[start + i], 1);
+        }
+        cur <<= 1;
+    }
+
+    *lev |= val;
+}
+
+static void gpclr(BCM2838GpioState *s, uint32_t val, uint8_t start,
+                  uint8_t count, uint32_t *lev)
+{
+    uint32_t changes = val & *lev;
+    uint32_t cur = 1;
+
+    int i;
+    for (i = 0; i < count; i++) {
+        if ((changes & cur) && (gpfsel_is_out(s, start + i))) {
+            qemu_set_irq(s->out[start + i], 0);
+        }
+        cur <<= 1;
+    }
+
+    *lev &= ~val;
+}
+
 static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
 {
+    BCM2838GpioState *s = (BCM2838GpioState *)opaque;
     uint64_t value = 0;
 
-    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
-                  TYPE_BCM2838_GPIO, __func__, offset);
+    switch (offset) {
+    case GPFSEL0:
+    case GPFSEL1:
+    case GPFSEL2:
+    case GPFSEL3:
+    case GPFSEL4:
+    case GPFSEL5:
+        value = gpfsel_get(s, offset / BYTES_IN_WORD);
+        break;
+    case GPSET0:
+    case GPSET1:
+    case GPCLR0:
+    case GPCLR1:
+        /* Write Only */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: Attempt reading from write only"
+                      " register. 0x%"PRIx64" will be returned."
+                      " Address 0x%"HWADDR_PRIx", size %u\n",
+                      TYPE_BCM2838_GPIO, __func__, value, offset, size);
+        break;
+    case GPLEV0:
+        value = s->lev0;
+        break;
+    case GPLEV1:
+        value = s->lev1;
+        break;
+    case GPEDS0:
+    case GPEDS1:
+    case GPREN0:
+    case GPREN1:
+    case GPFEN0:
+    case GPFEN1:
+    case GPHEN0:
+    case GPHEN1:
+    case GPLEN0:
+    case GPLEN1:
+    case GPAREN0:
+    case GPAREN1:
+    case GPAFEN0:
+    case GPAFEN1:
+        /* Not implemented */
+        qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    case GPIO_PUP_PDN_CNTRL_REG0:
+    case GPIO_PUP_PDN_CNTRL_REG1:
+    case GPIO_PUP_PDN_CNTRL_REG2:
+    case GPIO_PUP_PDN_CNTRL_REG3:
+        value = s->pup_cntrl_reg[(offset - GPIO_PUP_PDN_CNTRL_REG0)
+                                 / sizeof(s->pup_cntrl_reg[0])];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: bad offset %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    }
 
     return value;
 }
@@ -71,14 +197,75 @@ static uint64_t bcm2838_gpio_read(void *opaque, hwaddr offset, unsigned size)
 static void bcm2838_gpio_write(void *opaque, hwaddr offset, uint64_t value,
                                unsigned size)
 {
-    qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+    BCM2838GpioState *s = (BCM2838GpioState *)opaque;
+
+    switch (offset) {
+    case GPFSEL0:
+    case GPFSEL1:
+    case GPFSEL2:
+    case GPFSEL3:
+    case GPFSEL4:
+    case GPFSEL5:
+        gpfsel_set(s, offset / BYTES_IN_WORD, value);
+        break;
+    case GPSET0:
+        gpset(s, value, 0, 32, &s->lev0);
+        break;
+    case GPSET1:
+        gpset(s, value, 32, 22, &s->lev1);
+        break;
+    case GPCLR0:
+        gpclr(s, value, 0, 32, &s->lev0);
+        break;
+    case GPCLR1:
+        gpclr(s, value, 32, 22, &s->lev1);
+        break;
+    case GPLEV0:
+    case GPLEV1:
+        /* Read Only */
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: Attempt writing 0x%"PRIx64""
+                      " to read only register. Ignored."
+                      " Address 0x%"HWADDR_PRIx", size %u\n",
+                      TYPE_BCM2838_GPIO, __func__, value, offset, size);
+        break;
+    case GPEDS0:
+    case GPEDS1:
+    case GPREN0:
+    case GPREN1:
+    case GPFEN0:
+    case GPFEN1:
+    case GPHEN0:
+    case GPHEN1:
+    case GPLEN0:
+    case GPLEN1:
+    case GPAREN0:
+    case GPAREN1:
+    case GPAFEN0:
+    case GPAFEN1:
+        /* Not implemented */
+        qemu_log_mask(LOG_UNIMP, "%s: %s: not implemented for %"HWADDR_PRIx"\n",
+                      TYPE_BCM2838_GPIO, __func__, offset);
+        break;
+    case GPIO_PUP_PDN_CNTRL_REG0:
+    case GPIO_PUP_PDN_CNTRL_REG1:
+    case GPIO_PUP_PDN_CNTRL_REG2:
+    case GPIO_PUP_PDN_CNTRL_REG3:
+        s->pup_cntrl_reg[(offset - GPIO_PUP_PDN_CNTRL_REG0)
+                         / sizeof(s->pup_cntrl_reg[0])] = value;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: %s: bad offset %"HWADDR_PRIx"\n",
                   TYPE_BCM2838_GPIO, __func__, offset);
+    }
+    return;
 }
 
 static void bcm2838_gpio_reset(DeviceState *dev)
 {
     BCM2838GpioState *s = BCM2838_GPIO(dev);
 
+    memset(s->fsel, 0, sizeof(s->fsel));
+
     s->lev0 = 0;
     s->lev1 = 0;
 
-- 
2.34.1


