Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54792C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:39:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafey-0000n6-Ty; Thu, 15 Feb 2024 12:36:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeM-0007zE-GL
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:55 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafeH-0003yN-9B
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:35:54 -0500
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-33934567777so663778f8f.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708018547; x=1708623347; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zrPXjJVkURtLVPskkolIG/BC8kmZaryoEfEKDL7oHWs=;
 b=hAb6csiC/YNfrMelLXU0KsKIYvWu4YWrhyZaDu7IlaHQk3jyVGCrIqobkIGSScuoID
 4Xaiac5V5LloW32QdWsRAuxOLOeF9sDb6lDNFN7gVoMCovNuYmkkYRnbB1YBacFjf334
 BJmWIIepmdPj+6Z1n0PabByehB3XTWY8ltO/hdDwMHymLnopWCs9ONNuhTSmAq+GkONd
 Qp7Oac0q2x1sS+4J5FBTId6HZxpfWxY/H1ctU8lKZDLX9IZfkTRhFGHxbouos4KBz8XL
 DQcrwQKux2B5MEODQyNtkiW9VKX3Lagl4q4CyLVincrli2u6jXey3NeSq3/oywkm6HKq
 qWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708018547; x=1708623347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zrPXjJVkURtLVPskkolIG/BC8kmZaryoEfEKDL7oHWs=;
 b=eCkYXymX6v+ii2yLkZ9B0j3vOETZZhsSEhgQbAzm1AUN2yQkD6CGrWTwxUp5Ct8TD+
 yFiV+j9CyAmP44tJFCbDA3Gw0aRgQNJe282HmW6pXMPPi9UK8RufVyrHanoTEtYuGLY7
 +qhDZr47y2mbHT5JjBHAZBNWu5DIKS4AC3u9/XVQpSqLeKgxgB2tgKtZ43zaQ+hpcNPD
 h7OIkwBbfeXTJYOrNHc3xfXxdk4Yg22hzTZKsuFpKmCNyMJQJj3FmMjjAgbo0xr/vV5k
 ZkJZDvODIwKgRaJejI8jLKbeTAIJo+WWOwQd65ioiKQsoAkivcDAQ73DlFhZnRwb7gDH
 LwbQ==
X-Gm-Message-State: AOJu0YyWA4vRTMbUbspjUmYiXxFh9dyMQttdeMcMZyPHvcClHO+3OIZS
 EJLnfsswuvV8ksneG8BJpwuzjSLkwU6Uh6Zike1S64gbT7dZjhXvnC6FGPCk1LFeE8LWdfEobzI
 J
X-Google-Smtp-Source: AGHT+IH+4z7KfvA4+Rp8ovdIGsmL4BTmfh4RI5M+vOJUnqPXuNm1QWwIBn3Wr9AFL96uLWgUL1LHwg==
X-Received: by 2002:a5d:4fc1:0:b0:33b:d225:3640 with SMTP id
 h1-20020a5d4fc1000000b0033bd2253640mr1929210wrw.59.1708018547825; 
 Thu, 15 Feb 2024 09:35:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 q16-20020adfea10000000b0033cfa00e497sm2384129wrm.64.2024.02.15.09.35.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Feb 2024 09:35:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/35] hw/arm/stellaris: Convert ADC controller to Resettable
 interface
Date: Thu, 15 Feb 2024 17:35:22 +0000
Message-Id: <20240215173538.2430599-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240215173538.2430599-1-peter.maydell@linaro.org>
References: <20240215173538.2430599-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240213155214.13619-2-philmd@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stellaris.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/arm/stellaris.c b/hw/arm/stellaris.c
index 34c5a86ac2e..4fa857970b4 100644
--- a/hw/arm/stellaris.c
+++ b/hw/arm/stellaris.c
@@ -773,8 +773,9 @@ static void stellaris_adc_trigger(void *opaque, int irq, int level)
     }
 }
 
-static void stellaris_adc_reset(StellarisADCState *s)
+static void stellaris_adc_reset_hold(Object *obj)
 {
+    StellarisADCState *s = STELLARIS_ADC(obj);
     int n;
 
     for (n = 0; n < 4; n++) {
@@ -946,7 +947,6 @@ static void stellaris_adc_init(Object *obj)
     memory_region_init_io(&s->iomem, obj, &stellaris_adc_ops, s,
                           "adc", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    stellaris_adc_reset(s);
     qdev_init_gpio_in(dev, stellaris_adc_trigger, 1);
 }
 
@@ -1411,7 +1411,9 @@ static const TypeInfo stellaris_i2c_info = {
 static void stellaris_adc_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
+    rc->phases.hold = stellaris_adc_reset_hold;
     dc->vmsd = &vmstate_stellaris_adc;
 }
 
-- 
2.34.1


