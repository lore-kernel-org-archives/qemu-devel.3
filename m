Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5EDDC5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 12:17:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wu7ti-00067j-5B; Wed, 12 Aug 2026 08:17:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tL-0005Je-CK
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:10 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wu7tI-0000AH-82
 for qemu-devel@nongnu.org; Wed, 12 Aug 2026 08:17:05 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4954df200ddso6381645e9.0
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2026 05:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786537023; x=1787141823; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3rtWh0v1RSIvMjWeHQCmuQFDZkwR3VRGBlPYdvsCgDM=;
 b=LtRzR73yH9yA/hPl4C+2sdXhqsZp40C5rLvyaork2elpGTvyIZq7o4Hq4R3FutY057
 0bblghogz9Izl+zA4Q1Vr8xEiScYTgIKuOlpjCMi26pkV/RFOj8LHexdm/oWWshWvucJ
 tfSqK7ekFzutQB1cimSchbHadr8z7FmpdYZCeSzy3fgfYQySDyMoGjvc0YGFoOU58sCB
 3/qwAUfVN/zkaSup+zJqHt43/cJSames0lB5H9++0jwbN5VxlUVfJWgpR3pthYFASpdm
 wrYOanuhnjkF0moak87OZToRbmuouUVFgxo+TU0o899nWQ382lsysxAQiBJcBneTZTBJ
 OuFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786537023; x=1787141823;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3rtWh0v1RSIvMjWeHQCmuQFDZkwR3VRGBlPYdvsCgDM=;
 b=QdLBPNiIOHTS8jDTGePgGdrru/yRBif66h6ZClhneBjXm4V3OOAabYIipZlBGWP+IN
 Uc74B0+Fo8wov6HjUFQEckMlvxD05lqPBpsOcmt//ytd/I2MAJeVsFrLE0v02DJnVkss
 PJXbMg70lcMQh9LcMUTsyA8VPlK9i3esOvqmmR6mNLBV8x1cgr8X9NEBU4G8vdY4r74U
 3wtPGguSOVkoGh6u/bkURD/sRvpNgsC8gYGjc4vlFoo7z6Gye5Wnlw8Y1QNuaE09YbGX
 OH6QuHcgAWNIoiCvgiR4plBYnCH95kwbZ6ajIR2nsJGyFXZi7TemUvhr2DhvIKPOrcZL
 nzWA==
X-Gm-Message-State: AOJu0YwuhvVG+yrh/9aiDrODbX20jaLFZlVmQMdIQlGF68nLbj8LmhoY
 NjUFmMDdB436jJ5YHo77Hl0qYKg1eJabW3ZumDiUAizOJoMdS0TmFpjGEoEVGvMY0ZNY48jx7Ay
 nY65C
X-Gm-Gg: AR+sD11JtGdeqQbRnYHUTbQfk02ECV41c0BQnLOye2Llpm+sajqxHvSk0DoNiWTArWp
 1UUkEQDsuEmqXoOJhfTXOiIUmSPbcSQaqLgwTezS6clOFR7sAFWDcRD3IZG42dpXND49cOvbbgV
 Z3ghsrMI03PD4Rr+7Exmuu2fXLL49lYroUP4mxQKW0imjKXXIK5zA++Hulwj3kfWi99EO9hOgPF
 3AMLufvj7t6tvwQ7DtqJdMh9K/quYbp/+A9OWgKjZrAf4lLeqJjYFjVzSTb21PgEhkn5rsg1rAb
 Q6Es42VGAEBxMBVpT1FTVa/nsuj/JX4zowguwCChZQP/luZFe1vfhWGx0JdsHEZyINWzcNyKl9X
 9HdYxEqlqB1gM2mv44etJJBQFzn+rKSux6qMfTqnzh2fszomL1VNfbw6ij1JzPAW7KZuOefuvOH
 6FPmZRUO7127JnMJ0VoFD2l0GT753CpKhiYC00BmJKgj5AmAO7z97O+TvUp7qlZGBEW6GJ5aUWk
 1Mvcq8K6NWuvaGO7xaYq0xYh9etNlaiFXh0gFEgPbqhhYSTbNaSENBUIcqRvTy+begHjg==
X-Received: by 2002:a05:600c:8b13:b0:496:b3a0:1cfe with SMTP id
 5b1f17b1804b1-4997c116e06mr65103975e9.12.1786537022724; 
 Wed, 12 Aug 2026 05:17:02 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997ad79e5csm36963805e9.3.2026.08.12.05.17.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 05:17:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/26] hw/i2c/bcm2835_i2c: Correct iomem size
Date: Wed, 12 Aug 2026 13:16:19 +0100
Message-ID: <20260812121622.649730-24-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812121622.649730-1-peter.maydell@linaro.org>
References: <20260812121622.649730-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x32f.google.com
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

From: botszhuang <huang.botsz@gmail.com>

The last valid register is the Clock Stretch Timeout (CLKT) at
offset 0x1c. Since it is a 32-bit register, the total memory
region size should be 0x1c + 4 = 0x20.

Update the size parameter in memory_region_init_io() from 0x24
to 0x20 to accurately reflect the hardware specification.


Suggested-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Signed-off-by: botszhuang <huang.botsz@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
Message-id: 20260804144611.31735-1-huang.botsz@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/i2c/bcm2835_i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/i2c/bcm2835_i2c.c b/hw/i2c/bcm2835_i2c.c
index 34de1f36e5..5f6093087d 100644
--- a/hw/i2c/bcm2835_i2c.c
+++ b/hw/i2c/bcm2835_i2c.c
@@ -222,7 +222,7 @@ static void bcm2835_i2c_realize(DeviceState *dev, Error **errp)
     s->bus = i2c_init_bus(dev, NULL);
 
     memory_region_init_io(&s->iomem, OBJECT(dev), &bcm2835_i2c_ops, s,
-                          TYPE_BCM2835_I2C, 0x24);
+                          TYPE_BCM2835_I2C, 0x20);
     sysbus_init_mmio(SYS_BUS_DEVICE(dev), &s->iomem);
     sysbus_init_irq(SYS_BUS_DEVICE(dev), &s->irq);
 }
-- 
2.43.0


