Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E68CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 14:14:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v68Qx-00063C-Ei; Tue, 07 Oct 2025 10:12:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QV-0005ow-Hc
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:29 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v68QA-0002Ez-Qu
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 10:12:26 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-46e2826d5c6so49128015e9.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 07:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759846320; x=1760451120; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=m81jBq+TZRGnncpvfOYaW8BHhoN2W0VmjCta5UEVW9g=;
 b=lVHYY8S1zRT9oOfnNTp+goQXc6pdB94yIbv4zIVzTcDg2eGWSn02pFzL+33bh7EUcN
 zwbTCje0H0pLUm7r5TiJEDaZ+mE/ptaColX1NdLXdunDam+z8hOE87MOf67COIgM43ZY
 3WvFugMTHkewAo50Hsq18gWhtlL2Bp/y5G9r6+Hr71CYHqcJsaXO8zUJsaMm9FGMJ+09
 UXOwleohLLEdLo+Sbo+COfBX4CeejIk48kt5q2BwJW+zexWXGXtMYUzCxwTxkC/vxdQh
 DZ7RAYRxhIoU+7ZDXblWr7/TKCmAOn5wj7yutUSc6VryJABksgvltMN9zKUymoz16p41
 1U7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759846320; x=1760451120;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=m81jBq+TZRGnncpvfOYaW8BHhoN2W0VmjCta5UEVW9g=;
 b=i3qUL9zulatCD5QdQxss2rraDUggmOeQgU5Geq5IqsF3n86gJv3kYx8aKUpT2vi4qa
 yxHHdwU0tcdFvthk7sAZ88/dQ7EreVATRio7Q5yKBDfwrjEy5C/Scrqxjr7iCimOmRWd
 8J47iwbdGVByr/x2Yk+/mOQo+QygkjRuUJn6QrTeTgyKdWt4ACWRFA1ZMzML1TOM0Ac7
 rshAj1saa3FKZoOxjbezjVNwLcoEb8AOASfgvGp6kqe7Q+L2JdHX+TPhLiE0BQ5VcFbd
 0cP7jOlBwmuSQg2SICS+M4tXkGsi9tRDpMHjvmJMRJbQRK7+GnEeZD1cl/YKH82gTDbb
 qqYw==
X-Gm-Message-State: AOJu0Yzr9maUjQ0CWHZsXxRkfPPPJa2h3XMV7s8a1f8abLNTzWk8VqMY
 jFzJvJhuYA15TvpPV5Q4A/UiJCht5e2WE9LKfBtisnY1We597Jne+197F8C/oPM5KA2t7k0eNj1
 TNrLY
X-Gm-Gg: ASbGncurZxPrP7DXu46zUqDWjUB/UP6SdeTimQ1/GtjIqVv3WLHq6GQnxU12QH6GHY/
 iVKp2SEhokCN0/sFuThxB8vLCpntHv1gCHnfKzhOxRh3nRB0ntban8F89+npZLmF7N06H9EHcTh
 Oa6AmJj5BA6HqdRvNfnq53qhZbRfyqC8pDAzKx/MOkHy2AxMKFqL7xlP8GQ6TW4qBJ6NJogYqKM
 LADmZ+wBQ3/bWu4/q8kCWgU55eg++jhx9XXm6qT3loLJ5fAfEwxStBETYfBPDYr8J/zCloqSdQZ
 okCdTmpXkVhfYhiwBWuky+Tiu8Q7GafVgQ9U5sNdMH0hcU+cFElRXvljFHIdVh89NQyvs75m79k
 FNuLVZu+Sz8OrpkX7PoFhLH6YFiEE6YR+DU7s9vxBoGBhNZwDEGZvbfFzaUebFYDuGfk=
X-Google-Smtp-Source: AGHT+IHW18lvoUCiObbQD7xp+GDZZd9cK6JT5FY914p71hs3Sp4rMM8sybeqGl9U7zBD+z4zfKGLZQ==
X-Received: by 2002:a05:600d:41f3:b0:46e:3e63:9a8e with SMTP id
 5b1f17b1804b1-46e7114735amr105744285e9.26.1759846319755; 
 Tue, 07 Oct 2025 07:11:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e78c5d290sm167037135e9.0.2025.10.07.07.11.58
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Oct 2025 07:11:59 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/62] hw/misc/xlnx-versal-crl: split into base/concrete classes
Date: Tue,  7 Oct 2025 15:10:52 +0100
Message-ID: <20251007141123.3239867-33-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007141123.3239867-1-peter.maydell@linaro.org>
References: <20251007141123.3239867-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x336.google.com
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

Split the TYPE_XLNX_VERSAL_CRL type into base and concrete classes. This
is in preparation for the versal2 version of the CRL.

Signed-off-by: Luc Michel <luc.michel@amd.com>
Reviewed-by: Francisco Iglesias <francisco.iglesias@amd.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-id: 20250926070806.292065-32-luc.michel@amd.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/misc/xlnx-versal-crl.h | 31 ++++++++++++++++++--
 hw/misc/xlnx-versal-crl.c         | 48 +++++++++++++++++++------------
 2 files changed, 58 insertions(+), 21 deletions(-)

diff --git a/include/hw/misc/xlnx-versal-crl.h b/include/hw/misc/xlnx-versal-crl.h
index dba6d3585d1..2b39d203a67 100644
--- a/include/hw/misc/xlnx-versal-crl.h
+++ b/include/hw/misc/xlnx-versal-crl.h
@@ -2,6 +2,7 @@
  * QEMU model of the Clock-Reset-LPD (CRL).
  *
  * Copyright (c) 2022 Xilinx Inc.
+ * Copyright (c) 2025 Advanced Micro Devices, Inc.
  * SPDX-License-Identifier: GPL-2.0-or-later
  *
  * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>
@@ -12,8 +13,13 @@
 #include "hw/sysbus.h"
 #include "hw/register.h"
 #include "target/arm/cpu-qom.h"
+#include "hw/arm/xlnx-versal-version.h"
 
+#define TYPE_XLNX_VERSAL_CRL_BASE "xlnx-versal-crl-base"
 #define TYPE_XLNX_VERSAL_CRL "xlnx-versal-crl"
+
+OBJECT_DECLARE_TYPE(XlnxVersalCRLBase, XlnxVersalCRLBaseClass,
+                    XLNX_VERSAL_CRL_BASE)
 OBJECT_DECLARE_SIMPLE_TYPE(XlnxVersalCRL, XLNX_VERSAL_CRL)
 
 REG32(ERR_CTRL, 0x0)
@@ -216,8 +222,19 @@ REG32(PSM_RST_MODE, 0x370)
 
 #define RPU_MAX_CPU 2
 
-struct XlnxVersalCRL {
+struct XlnxVersalCRLBase {
     SysBusDevice parent_obj;
+
+    RegisterInfoArray *reg_array;
+    uint32_t *regs;
+};
+
+struct XlnxVersalCRLBaseClass {
+    SysBusDeviceClass parent_class;
+};
+
+struct XlnxVersalCRL {
+    XlnxVersalCRLBase parent_obj;
     qemu_irq irq;
 
     struct {
@@ -228,8 +245,18 @@ struct XlnxVersalCRL {
         DeviceState *usb;
     } cfg;
 
-    RegisterInfoArray *reg_array;
     uint32_t regs[CRL_R_MAX];
     RegisterInfo regs_info[CRL_R_MAX];
 };
+
+static inline const char *xlnx_versal_crl_class_name(VersalVersion ver)
+{
+    switch (ver) {
+    case VERSAL_VER_VERSAL:
+        return TYPE_XLNX_VERSAL_CRL;
+    default:
+        g_assert_not_reached();
+    }
+}
+
 #endif
diff --git a/hw/misc/xlnx-versal-crl.c b/hw/misc/xlnx-versal-crl.c
index f288545967a..be89e0da40d 100644
--- a/hw/misc/xlnx-versal-crl.c
+++ b/hw/misc/xlnx-versal-crl.c
@@ -298,7 +298,7 @@ static const RegisterAccessInfo crl_regs_info[] = {
     }
 };
 
-static void crl_reset_enter(Object *obj, ResetType type)
+static void versal_crl_reset_enter(Object *obj, ResetType type)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
     unsigned int i;
@@ -308,7 +308,7 @@ static void crl_reset_enter(Object *obj, ResetType type)
     }
 }
 
-static void crl_reset_hold(Object *obj, ResetType type)
+static void versal_crl_reset_hold(Object *obj, ResetType type)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
 
@@ -325,20 +325,22 @@ static const MemoryRegionOps crl_ops = {
     },
 };
 
-static void crl_init(Object *obj)
+static void versal_crl_init(Object *obj)
 {
     XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
+    XlnxVersalCRLBase *xvcb = XLNX_VERSAL_CRL_BASE(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     int i;
 
-    s->reg_array =
+    xvcb->reg_array =
         register_init_block32(DEVICE(obj), crl_regs_info,
                               ARRAY_SIZE(crl_regs_info),
                               s->regs_info, s->regs,
                               &crl_ops,
                               XLNX_VERSAL_CRL_ERR_DEBUG,
                               CRL_R_MAX * 4);
-    sysbus_init_mmio(sbd, &s->reg_array->mem);
+    xvcb->regs = s->regs;
+    sysbus_init_mmio(sbd, &xvcb->reg_array->mem);
     sysbus_init_irq(sbd, &s->irq);
 
     for (i = 0; i < ARRAY_SIZE(s->cfg.cpu_r5); ++i) {
@@ -377,11 +379,11 @@ static void crl_init(Object *obj)
 
 static void crl_finalize(Object *obj)
 {
-    XlnxVersalCRL *s = XLNX_VERSAL_CRL(obj);
+    XlnxVersalCRLBase *s = XLNX_VERSAL_CRL_BASE(obj);
     register_finalize_block(s->reg_array);
 }
 
-static const VMStateDescription vmstate_crl = {
+static const VMStateDescription vmstate_versal_crl = {
     .name = TYPE_XLNX_VERSAL_CRL,
     .version_id = 1,
     .minimum_version_id = 1,
@@ -391,29 +393,37 @@ static const VMStateDescription vmstate_crl = {
     }
 };
 
-static void crl_class_init(ObjectClass *klass, const void *data)
+static void versal_crl_class_init(ObjectClass *klass, const void *data)
 {
-    ResettableClass *rc = RESETTABLE_CLASS(klass);
     DeviceClass *dc = DEVICE_CLASS(klass);
+    ResettableClass *rc = RESETTABLE_CLASS(klass);
 
-    dc->vmsd = &vmstate_crl;
-
-    rc->phases.enter = crl_reset_enter;
-    rc->phases.hold = crl_reset_hold;
+    dc->vmsd = &vmstate_versal_crl;
+    rc->phases.enter = versal_crl_reset_enter;
+    rc->phases.hold = versal_crl_reset_hold;
 }
 
-static const TypeInfo crl_info = {
-    .name          = TYPE_XLNX_VERSAL_CRL,
+static const TypeInfo crl_base_info = {
+    .name          = TYPE_XLNX_VERSAL_CRL_BASE,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(XlnxVersalCRL),
-    .class_init    = crl_class_init,
-    .instance_init = crl_init,
+    .instance_size = sizeof(XlnxVersalCRLBase),
+    .class_size    = sizeof(XlnxVersalCRLBaseClass),
     .instance_finalize = crl_finalize,
+    .abstract      = true,
+};
+
+static const TypeInfo versal_crl_info = {
+    .name          = TYPE_XLNX_VERSAL_CRL,
+    .parent        = TYPE_XLNX_VERSAL_CRL_BASE,
+    .instance_size = sizeof(XlnxVersalCRL),
+    .instance_init = versal_crl_init,
+    .class_init    = versal_crl_class_init,
 };
 
 static void crl_register_types(void)
 {
-    type_register_static(&crl_info);
+    type_register_static(&crl_base_info);
+    type_register_static(&versal_crl_info);
 }
 
 type_init(crl_register_types)
-- 
2.43.0


