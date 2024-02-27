Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C1AC54798
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 13:34:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rexaK-0000jp-TI; Tue, 27 Feb 2024 08:33:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaG-0000i0-Lw
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:24 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rexaE-0002qt-Rk
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 08:33:24 -0500
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-412a14299a4so21618635e9.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 05:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709040801; x=1709645601; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ew4Z8LeQFT3auV97++3nsulAkoTYVN/ntWXGduMaWl4=;
 b=EH1pFjcP/9FGu+H95v3rt24m4CqE5i6kKx2EtWpmt0fWGf2FNG+6eaWMwm/oklw5OM
 LWlSLe4Lf4PRF5HIjsdGzwFmQ1osH8z9a/OvcIzs1qbgBI3cLzbkyOLGQ+BJSuptwB0B
 HVOvFHhPkhSjDOJuRQ383RPMcisGyhfa00lVD2U1+7Q9272HiPiNYs+PAkGuHBZxmzIv
 +04RbIyeJtBv4XYKjLcN2wu+Wxng/rwFHskdlr90KykydbCvYAQpfLhEn+pKbcKJp0+p
 KC4pUwZjWXdH1CdCETstVqmsBDhihulEzgKfAgE3DXww2E1S5szDIfK76/aqWRqXyOJ4
 GDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709040801; x=1709645601;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ew4Z8LeQFT3auV97++3nsulAkoTYVN/ntWXGduMaWl4=;
 b=K5ZPdwQPyJpGiIyY6asBdhawMlf0AVyj5G91/2I2QP5BNDG7JcrG9K8SN82VLbXuFy
 0f7wHhYw1LGUIv0MCYL6i7ktOqgT7sCU4F4Yl14fTc4xzWnCNKz06taGmDQOWF6IdDzU
 +SO47cbqevLCbEfvC+Ir8pSlOTqyydAJbqBPxmMBy9m2lPDig5KK9HlkoEQmuEF++HNc
 dq+FstCjprZjWEMRYl3Dg959+/C64NF8VjZQyUAS30QZzepKjXYTHxMsyoRj3Z1nFyix
 v6yJeCZ9YK+m223puYiP++bWM7fauOeD6i8WKyQPCJ8PiGaf1ID6P4EbSE03Wj7iePgb
 sCbg==
X-Gm-Message-State: AOJu0YxfX/siyOiCP0uqIposmbRrlP+MR+HYrnONXXxb56kRZcJjqpiw
 hCpzdUPhAnI2mOqH9qCT7MMHxwCppWPYMx2EI9D2bjPYW37IFy4ZaDzfTetAUl4WedCtkFXZBFy
 X
X-Google-Smtp-Source: AGHT+IFHjd9RclPt9TH8MuEB0wZSQw7rp72vUFDOX0AsB0fb2uE8aZDe1CKQv5mIGzvkCyuj/4r7fg==
X-Received: by 2002:a05:6000:71b:b0:33d:c652:7c41 with SMTP id
 bs27-20020a056000071b00b0033dc6527c41mr7279561wrb.71.1709040801284; 
 Tue, 27 Feb 2024 05:33:21 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 i13-20020adfe48d000000b0033ae7d768b2sm11319552wrm.117.2024.02.27.05.33.20
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Feb 2024 05:33:21 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 11/45] arm: xlnx-versal-virt: Add machine property ospi-flash
Date: Tue, 27 Feb 2024 13:32:40 +0000
Message-Id: <20240227133314.1721857-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240227133314.1721857-1-peter.maydell@linaro.org>
References: <20240227133314.1721857-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Sai Pavan Boddu <sai.pavan.boddu@amd.com>

This property allows users to change flash model on command line as
below.

   ex: "-M xlnx-versal-virt,ospi-flash=mt35xu02gbba"

Signed-off-by: Sai Pavan Boddu <sai.pavan.boddu@amd.com>
Message-id: 20240220091721.82954-3-sai.pavan.boddu@amd.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/xlnx-versal-virt.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
index 94942c55dff..bfaed1aebfc 100644
--- a/hw/arm/xlnx-versal-virt.c
+++ b/hw/arm/xlnx-versal-virt.c
@@ -49,6 +49,7 @@ struct VersalVirt {
     struct {
         bool secure;
     } cfg;
+    char *ospi_model;
 };
 
 static void fdt_create(VersalVirt *s)
@@ -638,6 +639,22 @@ static void sd_plugin_card(SDHCIState *sd, DriveInfo *di)
                            &error_fatal);
 }
 
+static char *versal_get_ospi_model(Object *obj, Error **errp)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    return g_strdup(s->ospi_model);
+}
+
+static void versal_set_ospi_model(Object *obj, const char *value, Error **errp)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    g_free(s->ospi_model);
+    s->ospi_model = g_strdup(value);
+}
+
+
 static void versal_virt_init(MachineState *machine)
 {
     VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(machine);
@@ -732,12 +749,25 @@ static void versal_virt_init(MachineState *machine)
     for (i = 0; i < XLNX_VERSAL_NUM_OSPI_FLASH; i++) {
         BusState *spi_bus;
         DeviceState *flash_dev;
+        ObjectClass *flash_klass;
         qemu_irq cs_line;
         DriveInfo *dinfo = drive_get(IF_MTD, 0, i);
 
         spi_bus = qdev_get_child_bus(DEVICE(&s->soc.pmc.iou.ospi), "spi0");
 
-        flash_dev = qdev_new("mt35xu01g");
+        if (s->ospi_model) {
+            flash_klass = object_class_by_name(s->ospi_model);
+            if (!flash_klass ||
+                object_class_is_abstract(flash_klass) ||
+                !object_class_dynamic_cast(flash_klass, "m25p80-generic")) {
+                error_setg(&error_fatal, "'%s' is either abstract or"
+                       " not a subtype of m25p80", s->ospi_model);
+                return;
+            }
+        }
+
+        flash_dev = qdev_new(s->ospi_model ? s->ospi_model : "mt35xu01g");
+
         if (dinfo) {
             qdev_prop_set_drive_err(flash_dev, "drive",
                                     blk_by_legacy_dinfo(dinfo), &error_fatal);
@@ -770,6 +800,13 @@ static void versal_virt_machine_instance_init(Object *obj)
                              0);
 }
 
+static void versal_virt_machine_finalize(Object *obj)
+{
+    VersalVirt *s = XLNX_VERSAL_VIRT_MACHINE(obj);
+
+    g_free(s->ospi_model);
+}
+
 static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -781,6 +818,10 @@ static void versal_virt_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpus = XLNX_VERSAL_NR_ACPUS + XLNX_VERSAL_NR_RCPUS;
     mc->no_cdrom = true;
     mc->default_ram_id = "ddr";
+    object_class_property_add_str(oc, "ospi-flash", versal_get_ospi_model,
+                                   versal_set_ospi_model);
+    object_class_property_set_description(oc, "ospi-flash",
+                                          "Change the OSPI Flash model");
 }
 
 static const TypeInfo versal_virt_machine_init_typeinfo = {
@@ -789,6 +830,7 @@ static const TypeInfo versal_virt_machine_init_typeinfo = {
     .class_init = versal_virt_machine_class_init,
     .instance_init = versal_virt_machine_instance_init,
     .instance_size = sizeof(VersalVirt),
+    .instance_finalize = versal_virt_machine_finalize,
 };
 
 static void versal_virt_machine_init_register_types(void)
-- 
2.34.1


