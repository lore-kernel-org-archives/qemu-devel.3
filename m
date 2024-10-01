Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1976CCEACEA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2024 16:48:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svfut-0005wk-SQ; Tue, 01 Oct 2024 12:40:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuX-0005YG-BR
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:41 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1svfuR-00064Q-Kz
 for qemu-devel@nongnu.org; Tue, 01 Oct 2024 12:39:41 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-37ccfbbd467so3442410f8f.0
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2024 09:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727800774; x=1728405574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VmeZfsuFELvPVVj+4hqVYRk10tIA4ae6uStYXL6uU4E=;
 b=hmyODMyunRJ9XHldje1e3jJeZjKQ9fdEWZYb2a2PgfAXG7/zUMe7tYsxSl8Y49uRpg
 zj4UkUIuvKHPpgH/ChTWhyo//9kk6iyNwuMEClsd2bNg5+lFlGuAUg0PEJjr5rWu4x+a
 TASPbt9kgqDjC/voYBKxeAYKX1YEdTWiaf6tZ8Ld1g5qvaU7pp75eGYz+S5fK1OWGRXS
 BzNx3n/NhrsCM+19syr/0mw0hgHP2Ki4yHiZ1ZT49GdnMbYc2urfXUCr1zjXcnRAw1no
 2OLBijWK1mzgznqRiH3gG68xrSRz6vCMcYMicVYguy9SgyiWeFCm0r4BCWVUkePEQR3L
 oFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727800774; x=1728405574;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VmeZfsuFELvPVVj+4hqVYRk10tIA4ae6uStYXL6uU4E=;
 b=AF4DHV+uDAA1S/AANCU3o6dWwwu2xz5X8wrQT3QeapEkNX5bKJv8NNUrTdtE85SlGF
 hfQuZLDzVx0CIA4SGMlSNBmYrYZv6fJB8JxyOQc0uI0RF6qtK+zXKFIGD3ErTnWLsznJ
 RWbGOVr/SYpAWz19dg3x5m25BV59zlloYyL3COFBLCnuvi76VeGjwY22SodxRl/3mg59
 HB274tlqRsn0b/XI2i8MxkgyBJPdsZcKW/8lyKhpbsrM0Ht9rrQWi8FizEHsmD9J77fD
 gHV1VtHnV55G5C45k+ThF77wmli25krk5VCXPKRI/NujCSIa2MG/OJbLWDPZ9Z7V85TF
 El4g==
X-Gm-Message-State: AOJu0YwY/U79DkvIcqDY8EhrAuKFSODCBByDeoucM/+/+QmEI/Sca4ZQ
 IaEAm3i1Qi6jGdx6sUIy9/xaaN1xu20dX+AVvONdcndGW5e/8xeKhL/3r+v4rlCHHfJnWVHOa7H
 C
X-Google-Smtp-Source: AGHT+IEEgnc3rUOGTXlCgUlOuTqo97WCrDnfmwv8aV6EpMsXWQ9VigPF3GTIlLpNBgs5OvtTo3hlYw==
X-Received: by 2002:a05:6000:1085:b0:37c:ced2:843f with SMTP id
 ffacd0b85a97d-37cfb8cb79emr163245f8f.16.1727800774215; 
 Tue, 01 Oct 2024 09:39:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd56e6547sm12243771f8f.58.2024.10.01.09.39.33
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2024 09:39:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 27/54] hw/timer: Remove pxa27x-timer
Date: Tue,  1 Oct 2024 17:38:51 +0100
Message-Id: <20241001163918.1275441-28-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241001163918.1275441-1-peter.maydell@linaro.org>
References: <20241001163918.1275441-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

The pxa27x-timer can be removed now we have removed the PXA2xx
SoC models. The pxa25x-timer device must remain as it is still
used by strongarm.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20240903160751.4100218-24-peter.maydell@linaro.org
---
 hw/timer/pxa2xx_timer.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
index d1a3ecac2b5..3234bbb1f4a 100644
--- a/hw/timer/pxa2xx_timer.c
+++ b/hw/timer/pxa2xx_timer.c
@@ -54,7 +54,6 @@
 #define OSNR	0x20
 
 #define PXA25X_FREQ	3686400	/* 3.6864 MHz */
-#define PXA27X_FREQ	3250000	/* 3.25 MHz */
 
 static int pxa2xx_timer4_freq[8] = {
     [0] = 0,
@@ -572,28 +571,6 @@ static const TypeInfo pxa25x_timer_dev_info = {
     .class_init    = pxa25x_timer_dev_class_init,
 };
 
-static Property pxa27x_timer_dev_properties[] = {
-    DEFINE_PROP_UINT32("freq", PXA2xxTimerInfo, freq, PXA27X_FREQ),
-    DEFINE_PROP_BIT("tm4", PXA2xxTimerInfo, flags,
-                    PXA2XX_TIMER_HAVE_TM4, true),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void pxa27x_timer_dev_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->desc = "PXA27x timer";
-    device_class_set_props(dc, pxa27x_timer_dev_properties);
-}
-
-static const TypeInfo pxa27x_timer_dev_info = {
-    .name          = "pxa27x-timer",
-    .parent        = TYPE_PXA2XX_TIMER,
-    .instance_size = sizeof(PXA2xxTimerInfo),
-    .class_init    = pxa27x_timer_dev_class_init,
-};
-
 static void pxa2xx_timer_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -615,7 +592,6 @@ static void pxa2xx_timer_register_types(void)
 {
     type_register_static(&pxa2xx_timer_type_info);
     type_register_static(&pxa25x_timer_dev_info);
-    type_register_static(&pxa27x_timer_dev_info);
 }
 
 type_init(pxa2xx_timer_register_types)
-- 
2.34.1


