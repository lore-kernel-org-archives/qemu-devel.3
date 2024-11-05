Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BDED3E77D
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 22:54:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8SMX-0007NU-P4; Tue, 05 Nov 2024 17:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SMB-0006st-Eb
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:03 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t8SM9-0004KA-NM
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 17:49:03 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4315baec69eso53093965e9.2
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2024 14:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730846940; x=1731451740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WiFCK6mS6/8rd1MrkryQ84V1Hk6dwbxGPMWFO5fXrcw=;
 b=OhCL+EoImfbNDCjfMue4sC8gaBBfRYzi/6KCLIv2jv+VQOPfWVTj6Mjy/9z75hW5sW
 Eh9p1KIUYgoyscKt65KmjVzOFCamx9yprHm5Lx4sugs54NsNSsQ2DzEFjh+nuQC83CPR
 FluXEPbLW3eP3VxhtybS4LS4k5L1T+MSaQfoQy5Egm49RZANyrAuuqc+3CdJQ48NHtQB
 +nNhocPJ/S60tXBp/g2xJt0774CBiESTcRZ2lpt/uBoqdB+zAKp8P/yjJbN239qRrSOy
 qPnMI9CCOedGJ3dm4EexOAM3J7rezdPv/CGdu9DuscCkGtDJZCY5uEqKfHC6lvFYvDqH
 9WLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730846940; x=1731451740;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WiFCK6mS6/8rd1MrkryQ84V1Hk6dwbxGPMWFO5fXrcw=;
 b=leGxU9yYLZQgZuBLslvayQkjZo7UMZ5ZnuPcv96TiseT0GY2JGSGZ0izs/5SBU+Xl4
 mqBS7nQFOi6EV6tAW3TUJVuf4sLqWngnjUkLzlCiIdWM8ye1iVZWddJMggCqfvISOjjr
 tNW5WfjWETaDshFquTfKK2NmPOtyrue3clzAasJcimhNyw0A40EcPSZFQilgQmpWPWne
 UidseQP1G3qXYvuAXLGv9CkbLvZn7JzkBCV9bjdDL47cT2y7bfVIXQvcUM1bBElZ3udH
 9cnHLcm/oLoI/p0TZrFLpY01GviGzQlgLtFMhpTnv6KxK4xMuavjGZ5QFwUfbTTHD6Mk
 0sFA==
X-Gm-Message-State: AOJu0YxC6UHYTeuBg6BEYWheWkQoJiNwWbzxNNYmFt9gS45DUvoxFp3p
 aRjA2V890EWIzeDS+qKVALS8MX77ZyhiXVVtxZCI46mpxc46tPB8nzb+IJu9KRvo9CquDgDieRJ
 aFpYUjg==
X-Google-Smtp-Source: AGHT+IEMR6UCCaCBihJ5GbwlZbpTSMJmfUDu+znkKP5fGC6UBSrONbxQzjj5WJ/mp3QMHiisK3kmGQ==
X-Received: by 2002:a05:600c:19d3:b0:431:54d9:da57 with SMTP id
 5b1f17b1804b1-43283297d9fmr139729375e9.30.1730846939867; 
 Tue, 05 Nov 2024 14:48:59 -0800 (PST)
Received: from localhost.localdomain ([89.101.134.25])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432a267dfadsm33828605e9.0.2024.11.05.14.48.59
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 05 Nov 2024 14:48:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 17/29] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
Date: Tue,  5 Nov 2024 22:47:15 +0000
Message-ID: <20241105224727.53059-18-philmd@linaro.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241105224727.53059-1-philmd@linaro.org>
References: <20241105224727.53059-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
Acked-by: Corey Minyard <cminyard@mvista.com>
Message-ID: <20241103133412.73536-13-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/i2c/mpc_i2c.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 3d79c156531..913d044ac1b 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -20,7 +20,6 @@
 #include "qemu/osdep.h"
 #include "hw/i2c/i2c.h"
 #include "hw/irq.h"
-#include "qemu/module.h"
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "qom/object.h"
@@ -345,16 +344,13 @@ static void mpc_i2c_class_init(ObjectClass *klass, void *data)
     dc->desc = "MPC I2C Controller";
 }
 
-static const TypeInfo mpc_i2c_type_info = {
-    .name          = TYPE_MPC_I2C,
-    .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(MPCI2CState),
-    .class_init    = mpc_i2c_class_init,
+static const TypeInfo mpc_i2c_types[] = {
+    {
+        .name          = TYPE_MPC_I2C,
+        .parent        = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(MPCI2CState),
+        .class_init    = mpc_i2c_class_init,
+    },
 };
 
-static void mpc_i2c_register_types(void)
-{
-    type_register_static(&mpc_i2c_type_info);
-}
-
-type_init(mpc_i2c_register_types)
+DEFINE_TYPES(mpc_i2c_types)
-- 
2.45.2


