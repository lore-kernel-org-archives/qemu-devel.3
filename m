Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DBBCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68QE-0005k8-MJ; Tue, 07 Oct 2025 10:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QB-0005i4-KZ
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:07 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68Pv-0002AS-7r
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:06 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-46e542196c7so41118605e9.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846306; x=1760451106; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sG2PRiFptBM7KMJFXZ0+YRspn1D7fmH+23bLcEHsPso=;
 b=aoUfdFmzPVDf8o8Z2+dTTlIMv0wbPAYRha4BOdZvjb5QN7+aPh93oH0HdDazhsH40F
 8q8Udu375/iLDyhrzKTb46+5pJmuBu7Gip3E26YJsvhZWf0G85haZfhqkyM9a1NsK7vu
 BO5TlSLbBykUcNpnf8mi12Rwplk4vivDjNGbAaPt3inrj2JO/AxDr79dAxiS0U+46jjA
 sxFseISYhgruUaf4bFyWprDrzFjTpAeeucrCB5I5VJwfvX+K2Y4Hdx6g/K/KFairMCLz
 1jTWffEuWlAl3n0nE8dIgbeweRmBEcl1hmVamG0vlE9pxmeUS5vfEJq/RrICHm4T0Jfa
 B8dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846306; x=1760451106;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sG2PRiFptBM7KMJFXZ0+YRspn1D7fmH+23bLcEHsPso=;
 b=gkJiEl99DoWqXRY0RVwtgt3FXXPsTGkEQjLhqN6P0kv+oD75j964/1rcC4Ghj+7gDT
 b3sDzJpeqf9b1Hin+XFwoTnv2o9b28hVHu96vKOs82CLx1KTDpWypeuXtbyNJ77UcAo3
 vODBAoDmETWG2WozxLQHR7NHA3EjA37lgYzwrf3hPgyQs34rHMamGnIf3SC+UATZMZo4
 JEfL54iUrQIDofUs6SGjlOKtOWJRWKdcNRVp69eZUuNw1PrlLtQdvOhszEpV2t8pjDn4
 ri4+KLVkiVVrzwSql3U3RlpJLJNIs14UqXH+H4kd0mZjK8QpQQy8kLfRGnWlsRm6xPpi
 wrDw==
X-Gm-Message-State: AOJu0YwRk0qWmRZYgGG7/nw9xRDjrSEIcymceK+QJIBvPk1DwKLLj9NH
 i/oCJU3RH9wez8zLsYc1ZG5iMiid+dkpn/PsfIK+XxKzjIb+pTn5iYflxAz79bKUM7sprm9nAiL
 XewEr
X-Gm-Gg: ASbGncskMkzR7JS7gJvHKNaqbXrbLgr3hvZg8n4GCz6yl4ipKEDrYcoHOiFXcCK8/Eb
 Xj8wlyWU8ZR2vzQ4fXj+EWSiKUS68mVJLM5EVMy6nUK/PRHmu1YHX7FnLnS5F03AQPhaPqLM5g0
 d6l071Auoj9z/VHxhst2yPKHB7BSq6q3pu/waCzzboYQrgyeyd5+APJsWqBc8UWGdoFRQU8i7z2
 3XVvCybkJ/oH83/dTOJ6EsGcCGFVqX6JYHyhCrUNLH7DDK0Y6T6CxvBb34x5qhcvifbFF7ERY/r
 dmmjoZhpjhZCe8jUAw1ACm3ub1D0POw4Od96I3IlHwweWyC7Eo+cw8VNnawpRplKu1CRyf7WhTh
 Q735HhnECMDi3aPAUSJ4uCSb6iw8tX+MFyuAvRMZFRdWhNw2CNAey78eb7bHxkbtQ0VQ=
X-Google-Smtp-Source: AGHT+IGxpzAdSg/1TZuDwhpwXOG7j2ZV2VQE2VwymcWZ+ZQfA+iK+dsm5l1ytzhOptA9Z9fy+i5ROg==
X-Received: by 2002:a05:600c:6c4c:b0:46e:25f2:705c with SMTP id
 5b1f17b1804b1-46fa29f13d4mr18025725e9.13.1759846305876; 
 Tue, 07 Oct 2025 07:11:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.45
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 19/62] hw/arm/xlnx-versal: crl: refactor creation
Date: Tue,  7 Oct 2025 15:10:39 +0100
Message-ID: <20251007141123.3239867-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: Luc Michel <luc.michel@amd.com>

Refactor the CRL device creation using the VersalMap structure. The
connections to the RPU CPUs are temporarily removed and will be
reintroduced with next refactoring commits.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-19-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/xlnx-versal.h |  3 ---
 hw/arm/xlnx-versal.c         | 36 +++++++++++++++++++-----------------
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
index 5a685aea6d4..d3ce13e69de 100644
--- a/include/hw/arm/xlnx-versal.h
+++ b/include/hw/arm/xlnx-versal.h
@@ -17,7 +17,6 @@
 #include "hw/cpu/cluster.h"
 #include "hw/intc/arm_gicv3.h"
 #include "qom/object.h"
-#include "hw/misc/xlnx-versal-crl.h"
 #include "net/can_emu.h"
 #include "target/arm/cpu.h"
 #include "hw/arm/xlnx-versal-version.h"
@@ -71,8 +70,6 @@ struct Versal {
             CPUClusterState cluster;
             ARMCPU cpu[XLNX_VERSAL_NR_RCPUS];
         } rpu;
-
-        XlnxVersalCRL crl;
     } lpd;
 
     struct {
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
index 81adf8d35b6..f5f98a3030d 100644
--- a/hw/arm/xlnx-versal.c
+++ b/hw/arm/xlnx-versal.c
@@ -42,6 +42,7 @@
 #include "hw/misc/xlnx-versal-cfu.h"
 #include "hw/misc/xlnx-versal-cframe-reg.h"
 #include "hw/or-irq.h"
+#include "hw/misc/xlnx-versal-crl.h"
 
 #define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
 #define XLNX_VERSAL_RCPU_TYPE ARM_CPU_TYPE_NAME("cortex-r5f")
@@ -151,6 +152,8 @@ typedef struct VersalMap {
             uint32_t blktype_frames[7];
         } cframe_cfg[15];
     } cfu;
+
+    VersalSimplePeriphMap crl;
 } VersalMap;
 
 static const VersalMap VERSAL_MAP = {
@@ -215,6 +218,8 @@ static const VersalMap VERSAL_MAP = {
             { { 38498, 3841, 15361, 13, 7, 3, 1 } },
         },
     },
+
+    .crl = { 0xff5e0000, 10 },
 };
 
 static const VersalMap *VERSION_TO_MAP[] = {
@@ -1115,27 +1120,24 @@ static void versal_create_cfu(Versal *s, const struct VersalCfuMap *map)
                                 sysbus_mmio_get_region(sbd, 0));
 }
 
-static void versal_create_crl(Versal *s, qemu_irq *pic)
+static inline void versal_create_crl(Versal *s)
 {
-    SysBusDevice *sbd;
-    int i;
+    const VersalMap *map;
+    const char *crl_class;
+    DeviceState *dev;
 
-    object_initialize_child(OBJECT(s), "crl", &s->lpd.crl,
-                            TYPE_XLNX_VERSAL_CRL);
-    sbd = SYS_BUS_DEVICE(&s->lpd.crl);
+    map = versal_get_map(s);
 
-    for (i = 0; i < ARRAY_SIZE(s->lpd.rpu.cpu); i++) {
-        g_autofree gchar *name = g_strdup_printf("cpu_r5[%d]", i);
+    crl_class = TYPE_XLNX_VERSAL_CRL;
+    dev = qdev_new(crl_class);
+    object_property_add_child(OBJECT(s), "crl", OBJECT(dev));
 
-        object_property_set_link(OBJECT(&s->lpd.crl),
-                                 name, OBJECT(&s->lpd.rpu.cpu[i]),
-                                 &error_abort);
-    }
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_abort);
 
-    sysbus_realize(sbd, &error_fatal);
-    memory_region_add_subregion(&s->mr_ps, MM_CRL,
-                                sysbus_mmio_get_region(sbd, 0));
-    sysbus_connect_irq(sbd, 0, pic[VERSAL_CRL_IRQ]);
+    memory_region_add_subregion(&s->mr_ps, map->crl.addr,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0));
+
+    versal_sysbus_connect_irq(s, SYS_BUS_DEVICE(dev), 0, map->crl.irq);
 }
 
 /* This takes the board allocated linear DDR memory and creates aliases
@@ -1338,8 +1340,8 @@ static void versal_realize(DeviceState *dev, Error **errp)
     versal_create_trng(s, &map->trng);
     versal_create_rtc(s, &map->rtc);
     versal_create_cfu(s, &map->cfu);
+    versal_create_crl(s);
 
-    versal_create_crl(s, pic);
     versal_map_ddr(s);
     versal_unimp(s);
 
-- 
2.43.0


