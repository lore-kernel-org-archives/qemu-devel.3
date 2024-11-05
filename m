Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E883CD3E779
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:49:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMj-0000Ay-2T; Tue, 05 Nov 2024 17:49:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMd-0007ye-D4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:31 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMb-0004Pu-Qm
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:31 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-431695fa98bso47258595e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846968; x=1731451768; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=14SbIx3o26YQ4yyKbflKXIgXTVgVzW1mc5iHdybl3Tg=;
 b=DXtdmUIiC+O0+3wktHSyAFZj19s1Uw5X292qQw/4bQ094OLpnvSBEyj4ex/73TbpDE
 +A3OZhQTu8DHy3vgXbPL2rAZppxycuoiezSdEqCiybiuGJTxfsCVhiPXJtsOE50lCAEB
 uGD1Yqn+T94xI4BzIITBZLIhbZLE6VeWfAhEKBF7yRbQc3xCrLFHRuRCuKXWPXHDueQU
 LPgeuyKuclaacu3PJH35hR6xUeo9hEU0t3LGK8MPaJ6lUhZIUzpwMLrMVDOOKm04NF91
 HiwqwTPJG9HRXvKDQ0n/nDmIoYz9Hb4voWpgRkRLzjZhi6XFa8XPqAD10pMWdEWidtj9
 GCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846968; x=1731451768;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=14SbIx3o26YQ4yyKbflKXIgXTVgVzW1mc5iHdybl3Tg=;
 b=Xb1iVeW8nW5R89v7Ut5+NmtoctOcxO53fwRZA6mqZGPwuwOFB6vUk8rpLqXqzxZ2Fs
 Jt1lN6vpkzCRHYhW8fjOyCvUiPNl1M7n8FXTgqGtVDf9WUm8/2QtzLkmsXru4E0OTHb7
 C3dKrzzKaGwxyZVCY+TyU14ZwLN15mKGoWVnCrGokpG6VB7fvauRbZcHHK1+jLeV0wcv
 Kd3Z4dmWbx7cZrVoo1G4rpCx8lpni78iO0Oa6/calh292gxXB+ifzl+jHHkHHYTuD9bu
 wNNScLpbcK4wX8+M8OKxnDHRwUBCKNtlSsm2u3DzG8j0yLeAsdKiQgwRhSiS22gxXS9T
 3juw==
X-Gm-Message-State: AOJu0Yx988bzl4GGLEBKezQem7GX9mg5s5PykSjp0bT+fJIOizdaYDxj
 poidlQ7FqJ1RrPIQMQdOGwMONsX38Oo1hXnyUVOsIxVmshVwi83B5W5f1wUNYtoqdvh2QqHyNKK
 rcmiOUg==
X-Google-Smtp-Source: AGHT+IH9ulny6mFUU+mR96Tgwa3r6i5UsRpzFDx6QwS/OdH7cjueFk41++dH2s6XDT8OlaowHLmF3w==
X-Received: by 2002:a05:600c:511c:b0:42c:a580:71cf with SMTP id
 5b1f17b1804b1-4319ad24423mr331876465e9.30.1730846968140; 
 Tue, 05 Nov 2024 14:49:28 -0800 (PST)
Received: from localhost.localdomain ([154.14.63.34])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432aa6b3505sm1098555e9.15.2024.11.05.14.49.26
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:49:27 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 22/29] hw/gpio/mpc8xxx: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:20 +0000
Message-ID: <20241105224727.53059-23-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Reviewed-by: Cédric Le Goater <clg@redhat.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20241103133412.73536-18-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/gpio/mpc8xxx.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 63b7a5c881d..a3c1d2fbf4c 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -23,7 +23,6 @@
 #include "hw/irq.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
-#include "qemu/module.h"
 #include "qom/object.h"
 
 #define TYPE_MPC8XXX_GPIO "mpc8xxx_gpio"
@@ -208,17 +207,14 @@ static void mpc8xxx_gpio_class_init(ObjectClass *klass, void *data)
     device_class_set_legacy_reset(dc, mpc8xxx_gpio_reset);
 }
 
-static const TypeInfo mpc8xxx_gpio_info = {
-    .name          = TYPE_MPC8XXX_GPIO,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(MPC8XXXGPIOState),
-    .instance_init = mpc8xxx_gpio_initfn,
-    .class_init    = mpc8xxx_gpio_class_init,
+static const TypeInfo mpc8xxx_gpio_types[] = {
+    {
+        .name          = TYPE_MPC8XXX_GPIO,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(MPC8XXXGPIOState),
+        .instance_init = mpc8xxx_gpio_initfn,
+        .class_init    = mpc8xxx_gpio_class_init,
+    },
 };
 
-static void mpc8xxx_gpio_register_types(void)
-{
-    type_register_static(&mpc8xxx_gpio_info);
-}
-
-type_init(mpc8xxx_gpio_register_types)
+DEFINE_TYPES(mpc8xxx_gpio_types)
-- 
2.45.2


