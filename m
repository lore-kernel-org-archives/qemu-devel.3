Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDF6FC3600B
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Mar 2025 19:54:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzL7n-00027B-IJ; Mon, 31 Mar 2025 15:48:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7j-000268-IP
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:43 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzL7h-0003K6-Qj
 for qemu-devel@nongnu.org; Mon, 31 Mar 2025 15:48:43 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3914bc3e01aso2742792f8f.2
 for <qemu-devel@nongnu.org>; Mon, 31 Mar 2025 12:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743450519; x=1744055319; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=txTiE4d1NZi9r9wcwRp40Op4LBLauweOXwjfQZIQKOA=;
 b=yoj4gDzz1Fq96zsWVZzBY5gBPgw7lLtSscE4jMT1HU7a5wc2859VqdfvKmpL4oncKO
 EkmZ1hsfYFMRMnYp4UBWjRyhigWACq7cK2iJpgMqtsArojHhg7sw3HhbrRDteX9X3Iu7
 TT2IQ4leXD9M+lM77DGOPqZ60aTI8n4Vpf3tXUv7M86Qtff9rnKoFw4Qg3KNj4z9xyeO
 2HEpR1NWhIc4MEJHUs6Wwc+7IKy9O17jjjBlOSFHrIUcEcSnGZ0AzdyHYbKhLXBp4/0E
 sVAljGNkpbiv4oT5pcnLttsLbYgtHKFcj0q9t1inTHlE20lsu5NF9hkkyNnayu7/jP2a
 Nidw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743450519; x=1744055319;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=txTiE4d1NZi9r9wcwRp40Op4LBLauweOXwjfQZIQKOA=;
 b=Y9dqVzTrkXpUEXZ8k94eFQptoyZikP7FUPTKvqNWt0NetmVpM/Vfegrmgil0b0jUor
 Vlma9tey6u6nWdkpL1u+tr5ANGhuVxglJoGDMlwJbLTJNRNvRNQd9vNf4v+PYA/TnDxg
 CY3ZLVe29lqJ8mJYubKdARF/7M/Fs5zQqQTMKQc/LLsZxvwMcq/GE27SS5r9Ot6nlTBu
 vKsdV8zm4cXeTE0LhQ0tMf3Rt9685M8PHTHkITROoE7XCkEn6blKVmlh3qGItnzehkhs
 +/AT8Z0vZShjz7JIy40+HNZnyFfvBJ/oyUSw9FP3SjNWMUJi+bAPpoxlPM6SJjeN0B13
 S52A==
X-Gm-Message-State: AOJu0YxnucULSdSWF3VMYR2UCLo45vn5qbmcTL+xLiK99J2dnR49FctN
 c8aVelt9q+LdcItsWTOL2opuVsrgi/lTRi+bcRMn2kiYYuHVYnM+1STy3IZcRjmZr6FGwM6Nr2c
 S
X-Gm-Gg: ASbGnctSEldRx0hbDyZsNdF5O/127+YzM9V0rrN4+9qQzkFX/9vz9oKWcCGYSeMj1oE
 WwPllqj+ezO/nuuDoKwPnG48Yc5UoLc2q7U6KW34pdhreadFnDINVyQzpgbaHg4bXabGHucqod/
 EeTcqbQPz64ccS7ssbZqhE1gEQpImN2CHgAVj6e9cBU7Jw43biyLRW2xl35HdMzD1ObUKdk8dIg
 9hZW2vEhA7RO0dgOt+yDW+69Al06jIKiqDHtCXsP5wm4MHHoW0U91c9t683SEaXMNExOwXJuw7Y
 D04QLSXiqOiWsAY4yAW4wE2T3AxEMr8ZP4hGaU8zDGWYe/pIkJUTIJLeJOdmq2ST/HKpigKuyX5
 BcthokNMKNtbrw1UeJTc=
X-Google-Smtp-Source: AGHT+IHslVBC5LKP5M/RUIpHQXwJAiQovDPft1xjCARCwOnZRCIibW52WvqcQTfbqavuq2aeMsEdSg==
X-Received: by 2002:a05:6000:2c4:b0:391:78a:33de with SMTP id
 ffacd0b85a97d-39c120dc8e5mr8805942f8f.12.1743450518730; 
 Mon, 31 Mar 2025 12:48:38 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b658b5dsm11970208f8f.3.2025.03.31.12.48.37
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 31 Mar 2025 12:48:38 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 03/23] hw/arm/fsl-imx8mp: Derive struct FslImx8mpState from
 TYPE_SYS_BUS_DEVICE
Date: Mon, 31 Mar 2025 21:48:01 +0200
Message-ID: <20250331194822.77309-4-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250331194822.77309-1-philmd@linaro.org>
References: <20250331194822.77309-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon machine
reset. It also makes the SoC implementation not user-creatable which can trigger
the following crash:

  $ ./qemu-system-aarch64  -M virt -device fsl-imx8mp
  **
  ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread: assertion failed:
  (n < tcg_max_ctxs)
  Bail out! ERROR:../../devel/qemu/tcg/tcg.c:1006:tcg_register_thread:
  assertion failed: (n < tcg_max_ctxs)
  Aborted (core dumped)

Fixes: a4eefc69b237 "hw/arm: Add i.MX 8M Plus EVK board"
Reported-by: Thomas Huth <thuth@redhat.com>
Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Message-ID: <20250318205709.28862-3-shentey@gmail.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/arm/fsl-imx8mp.h | 3 ++-
 hw/arm/fsl-imx8mp.c         | 2 +-
 hw/arm/imx8mp-evk.c         | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/hw/arm/fsl-imx8mp.h b/include/hw/arm/fsl-imx8mp.h
index bc97fc416eb..22fdc0d67c2 100644
--- a/include/hw/arm/fsl-imx8mp.h
+++ b/include/hw/arm/fsl-imx8mp.h
@@ -26,6 +26,7 @@
 #include "hw/timer/imx_gpt.h"
 #include "hw/usb/hcd-dwc3.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/sysbus.h"
 #include "qom/object.h"
 #include "qemu/units.h"
 
@@ -49,7 +50,7 @@ enum FslImx8mpConfiguration {
 };
 
 struct FslImx8mpState {
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
     ARMCPU             cpu[FSL_IMX8MP_NUM_CPUS];
     GICv3State         gic;
diff --git a/hw/arm/fsl-imx8mp.c b/hw/arm/fsl-imx8mp.c
index c3f6da63220..82edf61082a 100644
--- a/hw/arm/fsl-imx8mp.c
+++ b/hw/arm/fsl-imx8mp.c
@@ -702,7 +702,7 @@ static void fsl_imx8mp_class_init(ObjectClass *oc, void *data)
 static const TypeInfo fsl_imx8mp_types[] = {
     {
         .name = TYPE_FSL_IMX8MP,
-        .parent = TYPE_DEVICE,
+        .parent = TYPE_SYS_BUS_DEVICE,
         .instance_size = sizeof(FslImx8mpState),
         .instance_init = fsl_imx8mp_init,
         .class_init = fsl_imx8mp_class_init,
diff --git a/hw/arm/imx8mp-evk.c b/hw/arm/imx8mp-evk.c
index e1a21e52f96..f17d5db466d 100644
--- a/hw/arm/imx8mp-evk.c
+++ b/hw/arm/imx8mp-evk.c
@@ -37,7 +37,7 @@ static void imx8mp_evk_init(MachineState *machine)
     s = FSL_IMX8MP(object_new(TYPE_FSL_IMX8MP));
     object_property_add_child(OBJECT(machine), "soc", OBJECT(s));
     object_property_set_uint(OBJECT(s), "fec1-phy-num", 1, &error_fatal);
-    qdev_realize_and_unref(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX8MP_RAM_START,
                                 machine->ram);
-- 
2.47.1


