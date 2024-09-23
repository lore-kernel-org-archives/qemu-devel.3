Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00B7DCF9C6F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 09:34:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ssfPl-00034g-2R; Mon, 23 Sep 2024 05:31:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPh-0002nd-DI; Mon, 23 Sep 2024 05:31:25 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1ssfPe-0006zO-Db; Mon, 23 Sep 2024 05:31:25 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a8d2b24b7a8so940199466b.1; 
 Mon, 23 Sep 2024 02:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727083879; x=1727688679; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srRYZRMsYEk3Ixto2iPTmfOmvfPdHaxOey2BOrigk8E=;
 b=jc2YfGU0STqyciFqtbl0q31rJmkn3WpChis0gfnTMQdO4858G/Xzp2/DF3gFL576ex
 kMJCCtAne5dkEea2Wy1PLAqb81uIqWlZB6AT/2RIssmAnqC7v9E4o7b6xN9waX9q8oE4
 miffKv4eVeitBq0agMod7rywjSvn7esJDg9jZxyAmB3UYwfjwttA5c8UhKgmSemcbEI7
 Qbz8PSzJH49aUiLaPLsk+uSDNoozn4HL4S77reoRSI3ZJ81vjaPsHb4DkAHUFiMoSrVE
 xwrg0JLM4W3KWFlGLRxd0c+8mH4atMQGQQfHRoVIiIeOX0aMLDnDjUSBDDURXIZ+jJ1j
 cUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727083879; x=1727688679;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srRYZRMsYEk3Ixto2iPTmfOmvfPdHaxOey2BOrigk8E=;
 b=aBKcQL0xGmuvQ1LIUI//J2CLDd3h53nsqoReSDR4EoEEmeisgt/xqH0G6To/Z9kNxN
 0AuU9KpVhkhqUvZYGLGg0RufvC5dBv4wqp3gezpXXwqrud+tPd/UOsUDT6PUjyW37MRf
 XBT8ym5+VozBDRvmitiGeoV/1T2eHOBSAA91o6/czOLAMARZIa4ORAHM2yWKmOVnLqkI
 DsLbKb1sBEMKp5kqg9hWSBu6Xr7+Qfkz84gTSotpHZn8Uy8R0FpuSOX9A9btyfk4BzBA
 XzcP8GyusAJBkwHn15E9nzucjVy3RnnK4wrCBrdao1nhKEPuwxwTPU0uQyvW3CAapGAe
 hlXw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnfj/wZT/1+Crdtjy3oj7zmWvN2QdF9sDdo3emja5hToGN/vCMPPyLdc27lGx6nYPiJIHNtMrLjdU=@nongnu.org,
 AJvYcCXGH1kmcrkVk+eDY3SXdve7M87H4KgmkIhzaJ0VgI8r1RA4nB1WAzKqSmh8Lp3187hQfegAmMu2UEbG@nongnu.org
X-Gm-Message-State: AOJu0Yzj7+Ne/Uu5EoPLhOTljELhPM+Wg99f678/Egzvy9j8SbQpUryl
 KqmNV5picyf9LZbLBKSEc5A0L7+QiY9CSTWFU3Dgm7/ETv5hgweoQS1Ijw==
X-Google-Smtp-Source: AGHT+IGfeWFYVL1ZnurH8y2RgNyV0q51OrlWBMpDvZNfEhv7B0BE07Vg/HsuHiEsPEHr4fiPnh61GQ==
X-Received: by 2002:a17:907:7254:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a90d3644733mr1149971966b.28.1727083879191; 
 Mon, 23 Sep 2024 02:31:19 -0700 (PDT)
Received: from archlinux.. (90-181-218-29.rco.o2.cz. [90.181.218.29])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a90612b3f6fsm1188747166b.107.2024.09.23.02.31.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 02:31:17 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Hanna Reitz <hreitz@redhat.com>, qemu-ppc@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-block@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Bin Meng <bmeng.cn@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 11/23] hw/i2c/mpc_i2c: Prefer DEFINE_TYPES() macro
Date: Mon, 23 Sep 2024 11:30:04 +0200
Message-ID: <20240923093016.66437-12-shentey@gmail.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20240923093016.66437-1-shentey@gmail.com>
References: <20240923093016.66437-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x632.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 hw/i2c/mpc_i2c.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index 3d79c15653..16f4309ea9 100644
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
+static const TypeInfo types[] = {
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
+DEFINE_TYPES(types)
-- 
2.46.1


