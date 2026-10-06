Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31C13CA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:50:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENIU-0006wP-Si; Wed, 07 Oct 2026 04:46:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJZS-0006Xk-84
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:48:10 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1xEJZN-0003L6-Q8
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 00:47:59 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-c247f6687dcso197658066b.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 21:47:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791348476; x=1791953276; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n+X9R9jlN+7vQGOVgR1i+/9dNr+MHCZvV0d0XgyV1TY=;
 b=M17rxCVGQcF5B8AVTqXq1IzXEGrcGJ0reOFKRSur9abRhVg+aTeVAOfnXN+1cmCm8t
 O0sCf2Rdi8TePur+4GRH+ugTJ6YCvBa2STA4CUfavV74QsUfJncu0gQnp3u0NRJ1Vseq
 I/cEe2uBFFqErE/9E4baHRfBO2M/dTT1piASaz3nz8H9oICfIJJ2fOnBKvk2ZEyZf+zx
 +UYKyf50hszcLG+yKMH7EgCCI6U4Gv5K2DlwKp4UVhv2icngPKn1EIeZqbrPTzNb55NA
 8+rUVmzNdJAfnVEOZ5EqJmuESOM1qKhGG2zXE/aLDy50cgUyIphjGitYpMrdsRS9Yfhp
 DJJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791348476; x=1791953276;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=n+X9R9jlN+7vQGOVgR1i+/9dNr+MHCZvV0d0XgyV1TY=;
 b=A+cqrHVVa4A0DHL77nntWKDqWHzXFjrYE5NFox3O4S55B7aULdnMeqzEyTLWeBNuJE
 L9fQpQPaQ0jIPQdd4uxUTRBOLuea+ywBlnfut3199xYKURiRpM9j19J6OCckiem+tlhj
 l2N6oUFUh4Cx35CDYo2rfUsqWhZNJCrmJNPtCfs5QlvZkEiQLRSruUkt65VXhxNB4urb
 u/YMnDUFeHkaKJEU4MRx/7+wZ0v0cRPQN7XP6fwDEyt9ujq/8ZgWWG8/s08oBuJJXcWG
 7V+dhH+QQTBmw3HtjLU0av/2T4wywkgYa03OuPLWxjKOQz7aqoIZ2WH/ZtdZdgluWSaL
 ForA==
X-Gm-Message-State: AFuF++kY2ZxHdwNLBYQOpg4NuFbGNlB2o9/5BI7Q6MZ4R3+Gl+AFSWqu
 xQc5CSkl4t0fdYnMRQxDU/op/PiW0aw+w71u4fbvzqwyJawJn8Z0pWBy01u3OA==
X-Gm-Gg: AYBFou2kfC+IHj5kg0VtrP97xu0tSlC5LdP9Wsc30vvDSPIttrVdsCZwjBTCj4zjJgB
 avqak6r7v8y88cNEyGC6I3mwhGVTOrIPZSj9VnQQsJlB3cEl3a/TNNDouWcjRIYKnwZuhibiox2
 cJ7qRLXk8gGaw20+DJ5rwrwJ11j3XLrtvB5yZIn0e0xROvzKewPybSbvQQoEpzy1l9bCki7RWrE
 Dy2fDT2to8egRu9uiDnUQ1mHGoTDrUD1WfAJOdIymkpWvTBiue8KRlu6QbHlUxEgvA5+5XMidpa
 6BkhEWMZ3zT3/jv4Q49Hx21EoywQQ5gFZaIB4rCg7lW2BQPsIXBMH8OxlDALbYbm5bCR9GjiGpX
 OP07Jilfef4OjO4f49Jj++3lkQv7YZoYE9gs+d3d1ODnyqGsRMkmh3C0XPpkPFQQSfvJ3X0NCDv
 7BGK3lTQ2yi9k5gvCoELN3aTdUek8VmwRUv+bIe8541OMwvb/ij79R/QwnO7xplLAddNVuVqlGe
 NHfGSN2WlWRfjsZkP+OyeeFxCaD1TDCOLp2nQ==
X-Received: by 2002:a05:6000:4b02:b0:48b:451:4f19 with SMTP id
 ffacd0b85a97d-48c6d1ad0a5mr1051712f8f.51.1791275735359; 
 Tue, 06 Oct 2026 01:35:35 -0700 (PDT)
Received: from archlinux (pd95eda80.dip0.t-ipconnect.de. [217.94.218.128])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c6cdb281csm1566764f8f.55.2026.10.06.01.35.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 01:35:34 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Bin Meng <bin.meng@processmission.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-arm@nongnu.org,
 Jason Wang <jasowangio@gmail.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: [PATCH v4 13/31] hw/arm/fsl-imx31: Derive from TYPE_SYS_BUS_DEVICE
Date: Tue,  6 Oct 2026 10:34:25 +0200
Message-ID: <20261006083445.30362-14-shentey@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261006083445.30362-1-shentey@gmail.com>
References: <20261006083445.30362-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=shentey@gmail.com; helo=mail-ej1-x62a.google.com
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

Reviewed-by: Bin Meng <bin.meng@processmission.com>
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


