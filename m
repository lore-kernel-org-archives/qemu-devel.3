Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD7A9C7EE30
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 17:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWeSU-0005aC-NH; Tue, 01 Jul 2025 13:07:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSQ-0005W3-EM
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:46 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWeSL-0003Tz-Po
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 13:07:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a503d9ef59so2768939f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 10:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751389660; x=1751994460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QyDVgIZp4bZ0eZINB2aTxASGcxAgm9fpfWg3etKd2ss=;
 b=ino87tb3NOSjHiuWFxIZq885FKrRBFE0Op6Fv8jWujVyua//EUw0Vr4wZv9BxlWhCq
 izuQsiefZz3z3kDC2ULieg/HobvMUfypc89ZHOlBTyR9R79J3eSei4L77CJSBg9FTrNj
 ZYmk/o0wpImfzyTzLXt9qneFsVomhnadN/9ZxOdg7sIgbvMX7qYpneyFN+QS1H1t5y+N
 8sj68hQgR/Dnk8dk8Xdcbb9Ssp7xaHSdy8WUKBD69lcNRl6BpcYrDm8MeZy1/v+XSov0
 s9+R9z/tELVdbwR2COhyhWpTqujpNcWw6zqH/rpWdFtTo/+UL/gnBRLwdoDeenJlD6oW
 Z3Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751389660; x=1751994460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QyDVgIZp4bZ0eZINB2aTxASGcxAgm9fpfWg3etKd2ss=;
 b=uhulFG7/ly2hsoUuGLMzVzUvg1P29UziZiNgKU+xgQsXISznwJYGEFpnLrx015ASLY
 PAOedpXV26o/X9hJ3P4dVPuLvyUNS6oGGvOB1hKrrWFGs4YuK+eUci3mHidbQHYQfFbn
 EcrGUmmU4XvxVbjQrF1UuEQSOOELx8zXEasuDjYQmd/TmsSL9stLSapzovSguo1y+P3P
 jI0i2nTPm2Yd3IbaM0J7eymarrAVDLs4bD4HLEhXw8OAW9fdKggx/V1olPzyncp7BrWx
 NztSIVIL0Hbq//WsCAmeDNWiOrh8GN/2LaSDqAYejIo6rvq+KlAur025SwCoPKxenlgg
 E1gQ==
X-Gm-Message-State: AOJu0YyeduiLTN27FoahomE+82vUiLIMezezes6Ps1Ea1+mIWDIpjWmM
 fD21zvkbfk3N8QvDK4RwengY/O2JDDwnZUdFQPDWUdYi9g9UQV/1GDu4ItHlo3nT6m6rhU8lSuV
 GScW8
X-Gm-Gg: ASbGncvVdj1UXadnGOZR7QY7L9TIbnlV9hgAGV1ha9/hTLonSiTTKyNm9r/EIry/MJ3
 knaByu7i7kh0yywklVKEaSsvYzJk4jZVJQH5QaGU7nRimVP6uOrQ1kjKboDIy5wKYhMPSvn/wy7
 5SNzliPYFT38AeiXmY5GKtKECmZaMAhBu7AByGJEFUROPpykGDMV+17YZhs3ek7xNraVk1xvbGL
 qdQgVYnJ4vyWtMWuoMDbvmQRyKxjyYPOmjzqu0wfLHZcZAsKcuW1q/2KsuVXqNlbMOXzyyDCy5z
 LrVLb0kbRAAb/89I0TtW8tCaKfLUoG4DCB0jifHz4Ly35/L3CC/HuUZzCD295lwyP+WH
X-Google-Smtp-Source: AGHT+IHJT2e69YKelHc25ATo1Q757ULd6PG/yYY2HdgCSY7hMY98iMS2tJJeLgxt0opClMW+N9HvQA==
X-Received: by 2002:adf:b60e:0:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3a8fdeff980mr12714619f8f.31.1751389659984; 
 Tue, 01 Jul 2025 10:07:39 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c80bb28sm13475658f8f.43.2025.07.01.10.07.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 10:07:39 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 17/43] hw/arm/virt: Simplify create_its()
Date: Tue,  1 Jul 2025 18:06:53 +0100
Message-ID: <20250701170720.4072660-18-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250701170720.4072660-1-peter.maydell@linaro.org>
References: <20250701170720.4072660-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x429.google.com
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

No need to strstr() check the class name when we can use
kvm_irqchip_in_kernel() to check if the ITS from the host can be used.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Gustavo Romero <gustavo.romero@linaro.org>
Message-id: 20250628195722.977078-4-gustavo.romero@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/virt.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 6d9256a5255..ae419e86712 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -705,21 +705,18 @@ static inline DeviceState *create_acpi_ged(VirtMachineState *vms)
 
 static void create_its(VirtMachineState *vms)
 {
-    const char *itsclass = its_class_name();
     DeviceState *dev;
 
-    if (!strcmp(itsclass, "arm-gicv3-its")) {
-        if (!vms->tcg_its) {
-            itsclass = NULL;
-        }
-    }
-
-    if (!itsclass) {
-        /* Do nothing if not supported */
+    assert(vms->its);
+    if (!kvm_irqchip_in_kernel() && !vms->tcg_its) {
+        /*
+         * Do nothing if ITS is neither supported by the host nor emulated by
+         * the machine.
+         */
         return;
     }
 
-    dev = qdev_new(itsclass);
+    dev = qdev_new(its_class_name());
 
     object_property_set_link(OBJECT(dev), "parent-gicv3", OBJECT(vms->gic),
                              &error_abort);
-- 
2.43.0


