Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0EF3C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 21:49:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8lrl-0006Gx-4I; Mon, 21 Sep 2026 17:48:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lri-0006GU-3e
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:58 -0400
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1x8lrg-0000HU-BC
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 17:47:57 -0400
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so19942775e9.3
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 14:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790027265; x=1790632065; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=99LzQYmytgoE8xznQx8kTJDCRMnF9oj748dSHGYHBq4=;
 b=ht1osHWLgcl5XxDNtx2oe1VRYu78LZPHqvJ0yGERcfo/d7IDX1tBVWEdsJ09ml+boH
 LfPZBy3e2RqP1y5J7pi1afIVkeF2jcmWj5SeF+yZmjfDSDL81MaeH23MhZeUSkySMDW1
 DcOf3bEwYHPJLjMz+8PQbI/nf4GNEM7FXCnWdKjtImK6AD1nFhvZYbhnQE/ij9ymxUSS
 qMR16Kc3ZMvYPM7skHPINV6QPQJVgyHqkqA16T/GXQDCkqTjEmpu+i4gCUyQ2FKUTgeW
 ST29oNa5nDsBHijgP7106AtR0BJxurp7aq8ahetC5wsg7Q7lW6lZYqQt4iEkZ4UeRu0E
 72mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790027265; x=1790632065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=99LzQYmytgoE8xznQx8kTJDCRMnF9oj748dSHGYHBq4=;
 b=g9Ggd1DkBydBO0JAfl9QjWRuzHbQexoNiksoiSDZK312pa4xXBK+ynJKBIeQNghPUm
 jyaBORQVA+vmvG81G1mIZicZzRos0Im2jC1rXewe0/woXuEDqgINNvrCJ0LCOtJBQKx1
 x0BgBIhMdcGr/A0cmeYz63gsA3XDUQ+JWbUrJmV9QTCGTeVtaDyzcfNv/OVRQcQZuN1O
 LNZZwxNL0JHzcpvW2cY0ky2TArrEwVcHfLPKyzxUNodJE+E7JjX2Ex/uq6kMkqFv3mdE
 FbpVCQ7EBcuNVfOpON0PQIDkAsDqORrZIbSX8RWkI/zX8bF4OTWKfICecWCDGoa9ciE6
 OCSQ==
X-Gm-Message-State: AFuF++mpIWG+MG9TPlUJZJqm+Cl5E/bMnPq1QQw7jTNVRdeiwENbcF5f
 qoxmT7p2QGgMF6J1u+nppvkLFACL68Z0EQArgNlzZEuqglZLiv1WfPCoFPSYBw==
X-Gm-Gg: AYBFou17d58/Om+9+DN+ybXbb2GYPPsBhgEvXixY4lpNVwi+2WH+TR4x+NhsoHyEsBI
 PkpS5D3dNzqgQS34GG27kCoTc/Ad5Le2J+vY2QHrkP6YO5exYtHuaYrjgO2s0FT+KtAaKWQQ1xF
 qWHa4c/m8G6657wsaUnEKCJwXL9raBnpk6hG9Gv8+iX55VpyqdPSS0hnnqZf5NGGzXUQP99GqHb
 e8/PyPr/IMvrjB8DkfWwZ0/heEUE93JzOHr1kDZ8cH/+NFCRbRcTBc4Y4v0SlJIwDV0MT4Xbmqb
 Q3BqP7osMfFleGiF/4N3kg/r+jx4ivvdsu2RgdiWSDWgkWOx0piwv5KOSLwqs3YWFFBmfLLnEII
 VyiGc3z9MC9+PlqR7iIorYAlRzxOqOXrQc56DNThYr5eeBAjUrSMHvp7TsLph4EiPpmoFcX/2IF
 ABOb+8AFOw66c8GpuBRVHuKVGR/0UfmKuVp9dQm947Ux6eVH3+X6TSA+jJ2/VicPaWJowK4eiFQ
 fs8cEQJ3ktDPppEV372s6TKLqblv2S8MJkNhkLTR29iBEQxORfZPwGlxsV/sRArvD9zcUlfMUjw
 cMVsHtvTm0bqvw==
X-Received: by 2002:a05:600c:3b29:b0:49c:fc6c:bdfa with SMTP id
 5b1f17b1804b1-49fc57469bbmr168435445e9.17.1790027264898; 
 Mon, 21 Sep 2026 14:47:44 -0700 (PDT)
Received: from Provence
 (dynamic-2a02-3100-1c91-bf00-0219-99ff-feb2-2458.310.pool.telefonica.de.
 [2a02:3100:1c91:bf00:219:99ff:feb2:2458])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fda0ce29fsm4986905e9.6.2026.09.21.14.47.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 14:47:44 -0700 (PDT)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>,
 Jason Wang <jasowangio@gmail.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Bernhard Beschow <shentey@gmail.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
Subject: [PATCH 13/42] hw/arm/fsl-imx6: Derive from TYPE_SYS_BUS_DEVICE
Date: Mon, 21 Sep 2026 23:46:41 +0200
Message-ID: <20260921214710.29422-14-shentey@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921214710.29422-1-shentey@gmail.com>
References: <20260921214710.29422-1-shentey@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:31::11;
 envelope-from=shentey@gmail.com; helo=mail-wm2-x11.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
 include/hw/arm/fsl-imx6.h | 5 ++---
 hw/arm/fsl-imx6.c         | 4 +---
 hw/arm/sabrelite.c        | 2 +-
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/include/hw/arm/fsl-imx6.h b/include/hw/arm/fsl-imx6.h
index 376deea3a4..4cf26f1fbc 100644
--- a/include/hw/arm/fsl-imx6.h
+++ b/include/hw/arm/fsl-imx6.h
@@ -35,6 +35,7 @@
 #include "hw/usb/imx-usb-phy.h"
 #include "hw/pci-host/designware.h"
 #include "hw/core/or-irq.h"
+#include "hw/core/sysbus.h"
 #include "system/memory.h"
 #include "target/arm/cpu.h"
 #include "net/can_emu.h"
@@ -56,10 +57,8 @@ OBJECT_DECLARE_SIMPLE_TYPE(FslIMX6State, FSL_IMX6)
 #define FSL_IMX6_NUM_CANS 2
 
 struct FslIMX6State {
-    /*< private >*/
-    DeviceState parent_obj;
+    SysBusDevice parent_obj;
 
-    /*< public >*/
     ARMCPU             cpu[FSL_IMX6_NUM_CPUS];
     A9MPPrivState      a9mpcore;
     IMX6CCMState       ccm;
diff --git a/hw/arm/fsl-imx6.c b/hw/arm/fsl-imx6.c
index eec9673c6f..7ba9b85a2e 100644
--- a/hw/arm/fsl-imx6.c
+++ b/hw/arm/fsl-imx6.c
@@ -519,13 +519,11 @@ static void fsl_imx6_class_init(ObjectClass *oc, const void *data)
     device_class_set_props(dc, fsl_imx6_properties);
     dc->realize = fsl_imx6_realize;
     dc->desc = "i.MX6 SOC";
-    /* Reason: Uses serial_hd() in the realize() function */
-    dc->user_creatable = false;
 }
 
 static const TypeInfo fsl_imx6_type_info = {
     .name = TYPE_FSL_IMX6,
-    .parent = TYPE_DEVICE,
+    .parent = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(FslIMX6State),
     .instance_init = fsl_imx6_init,
     .class_init = fsl_imx6_class_init,
diff --git a/hw/arm/sabrelite.c b/hw/arm/sabrelite.c
index 34f302f83c..f29443948e 100644
--- a/hw/arm/sabrelite.c
+++ b/hw/arm/sabrelite.c
@@ -66,7 +66,7 @@ static void sabrelite_init(MachineState *machine)
                                  OBJECT(s->canbus[i]), &error_fatal);
     }
 
-    qdev_realize(DEVICE(&s->soc), NULL, &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(&s->soc), &error_fatal);
 
     memory_region_add_subregion(get_system_memory(), FSL_IMX6_MMDC_ADDR,
                                 machine->ram);
-- 
2.55.0


