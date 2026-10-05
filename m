Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CDC1CA5FCE
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 10:21:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDfp7-000508-Rj; Mon, 05 Oct 2026 06:21:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmR-0002Hh-3q
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:57 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xDfmL-0000xh-IL
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 06:18:46 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-48b0ef9c76eso1388783f8f.0
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2026 03:18:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791195520; x=1791800320; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u7/qSki9UBwISWVPBPvnc5a+mrC7ZZrYMsJW9QgbcHk=;
 b=hwvZ0xrWXd4jYdZYZQmNw6sJmclToqvbFA3vTjxIpusKNOEP2Uj/msipkIoInDTJ9B
 0bl7UtM/ZeQ7Ne0sv1U8jWVeIZNhZetCGteJvhtE3HkoZfj6vhQXUKriQU2sGuR1PoLa
 8xI0J3TnRQaSbQfUdscJ+OSQpXJOHVUAcd/S6Dy+aiHePC/GFLJKq38Ewv66Tp8Hpvbm
 8B7A6NnsbfC8S1JB4w+X96bId2Ew8V+NtxbZTpf1Icttm7IPH+97ctO9R3asIBiJmXRj
 81xCYHk35zb5vDcHA/fxMtDdPzyZKNMpk4SDYAj9C2285BvmwNVFM9mUmX91oTsPgSTs
 Ss9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791195520; x=1791800320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u7/qSki9UBwISWVPBPvnc5a+mrC7ZZrYMsJW9QgbcHk=;
 b=shx6xZjRq0PZOQCtbhtwSoflCe+kOP32Y6i3su9n8aL8il3Zi58fEu9dDp9t5JcnbQ
 BOY8xSwJQgf3CYndlU/y/sMqLMpbrwB3bHbuYlItgTMss0bcI1f8SamZKwvIRLeRFgEV
 2KvnorOAMZwtBLloG05xzG/Sk0LjkC4wr6ngkhFFROc8c3JCEdll3Qv6hPqCUJFh17AG
 7OuulgmWd5AhP53R5bIklmdilC6KGLNDb7kSGGEgK6ofZhBYs69zSc/EtadpK5yfS3cA
 QILIez+oRThLScas23QDkMHX0u8YXe5JDAeUkMMcB+eHu4Uy7B1wT0++i1bo58h4VZuP
 Qedw==
X-Gm-Message-State: AFuF++m9OGds6FnZ3rB9fhFp5Iap8iLQIv0BAZ/mO6eaP5XCB4WHo0fW
 KGCl8Bxn2opikzGc3nXQSy9A1+9ZM8Rl1BS8GU5xZd0YZbvfYiU0J1WskbkH0g==
X-Gm-Gg: AYBFou26cTrPHDnd4E/DwpnI3HUliaEyMpr9ULVPwnDBsg4yqEcSGCgnTApuTj25lMi
 TEg3udMHocGNtVor4wF9XxbcntzdcRYjUhnqo07dUhDtVSoumnIsOnp3qmgka6ua5PosCjbArZA
 dOYaUID4EDAFOv5+iVhns2rN2nrywP1KCz+ic1OM01LJfbvj5g4KHY42woH8ApK84IowQLY3QNm
 RwrYPTj4xpYOZF+gNGcBDNW7GRjfop1dOhV86ugd2zi/60WkJppEgVjM1+YyJJFjVJ5bfFxYkwQ
 7JnHk8Psp54ofRc4Otp6qkUOH7/5VmBbgFX1J2hOwU/D34d9bUGzKsZhVBEBBxX6wWfbN9KUDBi
 xCADuBOvTRC2Y9Gn0YrdRSidqJF8w03tipa0TSp6zrabvSNpIRaLixm69X4voJ/nmWnulZSw9W+
 U4lM/4dhHWvqI5W/mj/YnZiglCzgr56qj91koqBR1VsUkHfeUugVNKydoVcHeRc1i5wZAELEvAN
 d2JiQuhHMJWgt4eB0nhvtAKm1uA909j+bve5Q==
X-Received: by 2002:a05:600c:6287:b0:49d:1df8:156d with SMTP id
 5b1f17b1804b1-4a1680f5050mr93311285e9.18.1791195519489; 
 Mon, 05 Oct 2026 03:18:39 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c622ab7b5sm2742111f8f.37.2026.10.05.03.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 03:18:38 -0700 (PDT)
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
Subject: [PATCH v3 12/31] hw/arm/fsl-imx25: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon,  5 Oct 2026 12:17:39 +0200
Message-ID: <20261005101800.10821-13-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261005101800.10821-1-shentey@gmail.com>
References: <20261005101800.10821-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=shentey@gmail.com; helo=mail-wr1-x434.google.com
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

Signed-off-by: Bernhard Beschow <shentey@gmail.com>
---
 include/hw/arm/fsl-imx25.h | 5 ++---
 hw/arm/fsl-imx25.c         | 7 +------
 hw/arm/imx25_pdk.c         | 2 +-
 3 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/include/hw/arm/fsl-imx25.h b/include/hw/arm/fsl-imx25.h
index b68d4334a0..4bb4d5b3e5 100644
--- a/include/hw/arm/fsl-imx25.h
+++ b/include/hw/arm/fsl-imx25.h
@@ -29,6 +29,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/usb/chipidea.h"
 #include "hw/watchdog/wdt_imx2.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "qom/object.h"
@@ -45,10 +46,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX25State, FSL_IMX25)
 #define FSL_IMX25_NUM_USBS 2
 
 struct FslIMX25State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU         cpu;
     IMXAVICState   avic;
     IMX25CCMState  ccm;
diff --git a/hw/arm/fsl-imx25.c b/hw/arm/fsl-imx25.c
index 7f65f4ca4b..efb22359c5 100644
--- a/hw/arm/fsl-imx25.c
+++ b/hw/arm/fsl-imx25.c
@@ -317,16 +317,11 @@ static void fsl_imx25_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx25_properties);
     dc->realize = fsl_imx25_realize;
     dc->desc = "i.MX25 SOC";
-    /*
-     * Reason: uses serial_hds in realize and the imx25 board does not
-     * support multiple CPUs
-     */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx25_type_info = {
     .name = TYPE_FSL_IMX25,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX25State),
     .instance_init = fsl_imx25_init,
     .class_init = fsl_imx25_class_init,
diff --git a/hw/arm/imx25_pdk.c b/hw/arm/imx25_pdk.c
index 243c30a67e..a33050788c 100644
--- a/hw/arm/imx25_pdk.c
+++ b/hw/arm/imx25_pdk.c
@@ -72,7 +72,7 @@ static void imx25_pdk_init(MachineState *machine)
 
     object_initialize_child(OBJECT(machine), "soc", &s->soc, TYPE_FSL_IMX25);
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     /* We need to initialize our memory */
     if (machine->ram_size > (FSL_IMX25_SDRAM0_SIZE + FSL_IMX25_SDRAM1_SIZE)) {
-- 
2.56.0


