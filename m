Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF353CA5FFD
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:21:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfoz-0004SD-Ot; Mon, 05 Oct 2026 06:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmP-0002HS-5D
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:51 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmN-0000yB-GE
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:44 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48afe75f055so1309759f8f.2
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195521; x=1791800321; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c65EYXnC98C98YORs22cG94d4/d/CHn6ktuc8+e5k0U=;
 b=LftVeYLIKU2A7A8alfh30QzHJ6SRp5hMJrihghKzgs9Qv+Fa5AHgiQYFMkYRizArf6
 NsL7jpv/4FTJ+x+/Gs89onmED0l93NvE2fy1//9rOUUpVM6JeUBu4CtRW4m108J0wn3d
 KBpgqS/3WSPgmBFj5AOu+J+KBfO2OS9eHFLzhgiUuRIosmXI34ZW0FOEr4CtGIMOxAqA
 MJ8q7P8Q19bNpAUPqn7MMncbyxSYxLsYXNgL97NvctTlMPBG0pJt0O56wf6cmy+3viBA
 z2hYQ1Zc18RhiEpGcyAfnVfRNb5N94q3GCqx6t5Y+CBAc17kHSrvj6EMrPyuAzOko9lJ
 Wz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195521; x=1791800321;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c65EYXnC98C98YORs22cG94d4/d/CHn6ktuc8+e5k0U=;
 b=Q0P1jrr/6QgyilJJk+D2kWYqaqflZxAwpLo6aD7igxGFodyo69/2O2J1J/XIUivxKY
 BqrwBvxNyu8GQ2mCpXOM+JDsc6BID/lVOMday6v4sz+97CqED7kxHcuFHSLWiv/lhR9f
 mf0KaG48o4xxX+dAB9++/tnexTh2Oz23SNT/gnM9awTfQ6VAT5jRcwz2+1FKZqo12W4j
 jNEJJ97r9Kj+dj/VEynlT/jeAJslETGMy/Gx97HyEUY8VPyGksB8tjHv8N6BlN98WbtZ
 jOVjSV4OSRDhCAEtHVs2rmEzRng14bjVOaqiKyLeWa1c0pa7AXglN/XJKJivBLdI561H
 1B+A==
X-Gm-Message-State: AFq9FYLrYOjsFET+wZmqnX0+XUpPs5RW3mifLZ8jvolwJ2Q9Ok8OWLA0
 20Ow3x1qjJdZ2xc922O4xTR80HHs4Y2UhFRL6gHP1KpmZN5FEmB4dRR1M1fAow==
X-Gm-Gg: AYBFou3aLmTMhHLFvJ+zWuJrCNoXRp4TYvXEOhjgpJk8MqpGH9AbrasZc/yCm2uO0VG
 vg7bJnYXqy8GCciXspc3Gjo9s+Lmq05XFfj1uhUoP0ajBpIPZu8++lH1of1MrZs4n0lkztdQZ7V
 Tm+cZIrI0RfTRuk0gRMi4TTbD4N39LkpJhoHDntJuUYCC0M3e57qpPqFUQqsZ/D+hD/nY5s+5A+
 BG5Cmi7LhPbVTUQl3ypiEA+zPuVgEtxN7c0rQz+409YGA3MNh/R0MOQ3StDIoWFlnOGIJ2jIa/Q
 hNLh/FU0ROMxzae33gkYSos00kbXbNcFNcw/PsEVWhY3OwtK8MKptCWnVS3x9fkHENxyU1/yjoU
 yhh3MBtznogv0/zM9Y2esqu+4Br0pII1VTOe/1qIoeYP59/Onhwfsj7YnqrZwbFphGDTNp7K8FR
 /J7jUqyax2MrQQ5GGMtaHaigerBqtTvtI9ZGuWL0xV5s3EG5iByOh3kHpOI1NMeYFTvCaWWEhXw
 YhHlNijwT2UnGpUs+9DWIaVSi7E6VJOb4383w==
X-Received: by 2002:a05:6000:400f:b0:486:f3db:e0f2 with SMTP id
 ffacd0b85a97d-48c47fc5fabmr14521136f8f.14.1791195520536; 
 Mon, 05 Oct 2026 03:18:40 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:40 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair@alistair23.me>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Bin Meng <bin.meng@processmission.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Subject: [PATCH v3 13/31] hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon,  5 Oct 2026 12:17:40 +0200
Message-ID: <20261005101800.10821-14-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Deriving from TYPE_SYS_BUS_DEVICE fixes the SoC object to be reset upon
machine reset.

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx31.h | 5 ++---
 hw/arm/fsl-imx31.c         | 7 +------
 hw/arm/kzm.c               | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx31.h b/include/hw/arm/fsl-imx31.h
index 41232a2237..ea916de15a 100644
--- a/include/hw/arm/fsl-imx31.h
+++ b/include/hw/arm/fsl-imx31.h
@@ -25,6 +25,7 @@
 #include "hw/i2c/imx_i2c.h"
 #include "hw/gpio/imx_gpio.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -38,10 +39,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX31State, FSL_IMX31)
 #define FSL_IMX31_NUM_GPIOS 3
 
 struct FslIMX31State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX31CCMState  ccm;
diff --git a/hw/arm/fsl-imx31.c b/hw/arm/fsl-imx31.c
index 190f863355..dd929c1085 100644
--- a/hw/arm/fsl-imx31.c
+++ b/hw/arm/fsl-imx31.c
@@ -224,16 +224,11 @@ static void fsl_imx31_class_init(ObjectClass *oc, const void *data)
 
     dc->realize = fsl_imx31_realize;
     dc->desc = "i.MX31 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the kzm board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx31_type_info = {
     .name = TYPE_FSL_IMX31,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX31State),
     .instance_init = fsl_imx31_init,
     .class_init = fsl_imx31_class_init,
diff --git a/hw/arm/kzm.c b/hw/arm/kzm.c
index 387bf54ced..e9cc53ce01 100644
--- a/hw/arm/kzm.c
+++ b/hw/arm/kzm.c
@@ -69,7 +69,7 @@ static void kzm_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX31);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* Check the amount of memory is compatible with the SOC */
     if (machine->ram_size > (FSL_IMX31_SDRAM0_SIZE + FSL_IMX31_SDRAM1_SIZE)) {
-- 
2.56.0


