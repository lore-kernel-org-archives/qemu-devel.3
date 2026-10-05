Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C17ECA6001
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:27:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfqZ-0007fq-VI; Mon, 05 Oct 2026 06:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmQ-0002Hf-CX
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:55 -0400
Received: from mail-wr2-x0d.google.com ([2a00:1450:4864:30::d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmO-0000yx-FB
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:46 -0400
Received: by mail-wr2-x0d.google.com with SMTP id
 ffacd0b85a97d-48c58132824so416689f8f.3
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195523; x=1791800323; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tmb1LvWJuEGSfnKPDPWmN7ZvXQwtZpUegBkNdwPgjrQ=;
 b=p7tdAntrH1n2NZd2+zirTjw7CMLf4J//m/B0nz/v1cjnW0iMEmbm2c6FOp7JVIuO/F
 HnQuZxKjmqjLSwxdAoBLuqMv5cIYfL31YWShgo0nkih/7qqVldUCNor5/wmh/+4ygskS
 PTJmnCURghOU+bjD3txf6wbCNbrjaOeiKYSnsx8QXw03sNEpGurI9QYYeeSVRUYwGYIq
 5TP7Ohs3JKsc+0Jke5jYkKG5NS4RaqzkvO2QLXgWjzcRLDyutnYg6ctONL4zEOXDpVPg
 lNnHIsNGVqrO/BMsUv+JqwoR+0jHIJNIQh3kbrSguaiiGa/HIsYxhGJ46Ul2r3b7FYvI
 KaMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195523; x=1791800323;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tmb1LvWJuEGSfnKPDPWmN7ZvXQwtZpUegBkNdwPgjrQ=;
 b=qlsA44Rw7XzXRal99PMG9dpbXjXlGxo5Jg4vkx3WwSO1tIR//7HLsQp7eAQlWyssWo
 Tf5hi+dvE1010+gEGupe/wfoYRKLDY3FTADRTmLIHVX9No/vfeLI/863fHRMuo6YKr8N
 w42aC3YEad3TXuUdnZ1VlttHCF21a6HlKUiIHUTIj5RZ7jkm3bgjtoGjzeAm071pxRGU
 mSLRMADYjErhkFtJaEUzrxm2BYpKQ2xc6VP9S8zJFhg/0T1GGyRceHJQYmuI/FcDXl8K
 Hoq4eKnOvwIht0qw9zdxrxgrenUiI17vbtk1RXJSzZjhaFLihAkM7PI3CTOYKIUNxp3t
 hTuw==
X-Gm-Message-State: AFq9FYJl+blWsnuMexylR6sPaMKSvxivnzhfp0uAbXHq4SxAzsqOGxhk
 WFvAj0QBT0Ws9DO1yAPvHCqN6a3xp3S7XuODwhW8hRD2xcJHjUi63LCOw2F9tg==
X-Gm-Gg: AYBFou2nFpCotwag606FfswNIRjBx+u0QOm6GVkERJIFE+q9Et62A6sMqo05wb3vq/A
 5kIfDNPSTGdWK+rbT7azS70pVszNm2/58PqzcObUPsc/LqkuvIhoSGcCdNKSCCrL5vnM3QOJvju
 IbW8JRXvyNadsADC11yaIxJsp8QDoiQJ+5Jr9GjwYGxq+c9KvhdVpioOrWTPQt/oOB+GtBuj4M9
 mBHNf3Y8w6dkkc/M8DLIEIpizaNg+IVrgu6l9PNYFI/ZMFhVMeJwgLzTUCrQ5seG1huHL3F5JSo
 OTfXKGuY8BhBUxpvqsBMkQQimafbbOzyHQGK3Cy6S5/x2H5NIWD3CN8kVuyHS1ixXISbV9iqrJC
 DpgBxxklwGw7hcBZRK6vK8fQ21k+yZiAUK5y/FyAJ2j0leM3cq5Acq8WqH322zrnKPgNQLbtLST
 D5KP7tha1XCrY4dRnJzoOYdz8hnQ1e3MBUgp3LdXD2mc8vXOP/U0Ck4on/aMCiCjNp9cRoSdfLq
 dHcDkNEGB61S7P7pioiwuIjjBncnoatXn9nVQ==
X-Received: by 2002:a05:6000:46da:b0:487:342:d142 with SMTP id
 ffacd0b85a97d-48b1272d3d8mr13001796f8f.44.1791195523060; 
 Mon, 05 Oct 2026 03:18:43 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:42 -0700 (PDT)
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
Subject: [PATCH v3 15/31] hw/arm/fsl-imx6ul: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon,  5 Oct 2026 12:17:42 +0200
Message-ID: <20261005101800.10821-16-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:30::d;
 envelope-from=shentey@gmail.com; helo=mail-wr2-x0d.google.com
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

Reviewed-by: Bin Meng <bin.meng@processmission.com>
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx6ul.h | 5 ++---
 hw/arm/fsl-imx6ul.c         | 4 +---
 hw/arm/mcimx6ul-evk.c       | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6ul.h b/include/hw/arm/fsl-imx6ul.h
index 6205fe6b77..9ae0488990 100644
--- a/include/hw/arm/fsl-imx6ul.h
+++ b/include/hw/arm/fsl-imx6ul.h
@@ -18,6 +18,7 @@
 #define FSL_IMX6UL_H
 
 #include "hw/cpu/a15mpcore.h"
+#include "hw/core/sysbus.h"
 #include "hw/misc/imx6ul_ccm.h"
 #include "hw/misc/imx6_src.h"
 #include "hw/misc/imx7_snvs.h"
@@ -64,10 +65,8 @@ enum FslIMX6ULConfiguration {
 };
 
 struct FslIMX6ULState {
-    /*< private >*/
-    DeviceState    parent_obj;
+    SysBusDevice   parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu;
     A15MPPrivState     a7mpcore;
     IMXGPTState        gpt[FSL_IMX6UL_NUM_GPTS];
diff --git a/hw/arm/fsl-imx6ul.c b/hw/arm/fsl-imx6ul.c
index 1863558a0d..84451c9909 100644
--- a/hw/arm/fsl-imx6ul.c
+++ b/hw/arm/fsl-imx6ul.c
@@ -730,13 +730,11 @@ static void fsl_imx6ul_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6ul_properties);
     dc->realize = fsl_imx6ul_realize;
     dc->desc = "i.MX6UL SOC";
-    /* Reason: Uses serial_hds and nd_table in realize() directly */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6ul_type_info = {
     .name = TYPE_FSL_IMX6UL,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6ULState),
     .instance_init = fsl_imx6ul_init,
     .class_init = fsl_imx6ul_class_init,
diff --git a/hw/arm/mcimx6ul-evk.c b/hw/arm/mcimx6ul-evk.c
index 4964cb9345..53d221b4a9 100644
--- a/hw/arm/mcimx6ul-evk.c
+++ b/hw/arm/mcimx6ul-evk.c
@@ -44,7 +44,7 @@ static void mcimx6ul_evk_init(MachineState *machine)
     object_property_set_uint(OBJECT(s), "fec2-phy-num", 1, &error_fatal);
     object_property_set_bool(OBJECT(s), "fec1-phy-connected", false,
                              &error_fatal);
-    qdev_realize(DEVICE(s), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(s), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6UL_MMDC_ADDR,
                                 machine->ram);
-- 
2.56.0


