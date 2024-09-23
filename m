Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C0B0CF9C72
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2024 14:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sskTk-0008GD-Rg; Mon, 23 Sep 2024 10:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTN-0007zu-Vk
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 10:55:40 -0400
Received: from mail-ua1-x932.google.com ([2607:f8b0:4864:20::932])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sskTM-0006vv-GX
 for qemu-devel@nongnu.org; Mon, 23 Sep 2024 10:55:33 -0400
Received: by mail-ua1-x932.google.com with SMTP id
 a1e0cc1a2514c-846bc787b3dso1240476241.2
 for <qemu-devel@nongnu.org>; Mon, 23 Sep 2024 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727103330; x=1727708130; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm+KI23c86LD33sZYRxxXCIhV12T/Ywht8Xuz1hXe+0=;
 b=Eo6V+xn3CBtnG8T13n3RhuQZp57pRtt1VZZITGAmp1Q3/ELduDb30pRIVA6ott8mGm
 zvqdxTGFGTgmjEGdUCMYuKwzufYz3roP5UHZVhcDZNVY20p9cxRRk8BCrcIbe+uRKOWJ
 g3LUyCZQsmweWWxJZVGiLKJFuvTpIsW0341dzYbr1NrRnV7QFMS+mjwyQxuoanoKNfzh
 GL/97pXwRx9xvQGbu/Y1naSDkz8Sw5RapaS5gheHrZaiFatKhorQWtvIa/bcMS5n0j9u
 COLbrDc/ApKXF9jAh8TnRPt994hBJtuXQ9qfd0z2vQx204FJd0lJkg+jzEAmkX5DuIAJ
 btZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727103330; x=1727708130;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mm+KI23c86LD33sZYRxxXCIhV12T/Ywht8Xuz1hXe+0=;
 b=XtFbHEJ8oh903tOnnQilTJAGLWFH7jxzNopfBHFBYHuqQ3ASTyRi8ZlJL2j4VbkPCA
 H8xfy91E/BfwHwtLAD2Q9TNai8Y/0soR6Yc9/hxjJ1fchlsYMeYZhoM2CA57wgzNAqvb
 IH5O6kx1Mris36jBA3ovM/QaJEcK5vp0GGAKscAnCGeKm9Hj+ChirtStH02d2PSj/S/1
 +0OlKWdolkYrtn0Rawq1ObpFFXurALTS5iJYZ4/J6IvbvGwmbuoKQ189WA7vC9EhWGGi
 EvTRVh6vyWSNalQM0NxlemYspmzt+Ow8ZJaXmwMdRl70FtPh/3AgAJawKnVZH77N5KuN
 rFww==
X-Gm-Message-State: AOJu0Yy14iU01AQOvmhtD41xB3+IXgb1r1uRbyd8pLiDp9x+RVylebnj
 D6HkFvKjWGXXP0zV1QcIw6lH4HkONbHR+DIvk2wTQWtWphQkllstTDdvrlHr
X-Google-Smtp-Source: AGHT+IEa6GHCw5xlUAShPHcRXsaKLJmNVozEJN7ykRDnN4Q6tHZqrG6CPQ/VSMwl2li6QGRnqSqpWQ==
X-Received: by 2002:a05:6102:e09:b0:48f:4898:f2a9 with SMTP id
 ada2fe7eead31-49fc765b22emr8402772137.25.1727103330312; 
 Mon, 23 Sep 2024 07:55:30 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-49e6b345c6fsm3737705137.14.2024.09.23.07.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Sep 2024 07:55:29 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v2 3/4] hw/xen: xenpvh: Add pci-intx-irq-base property
Date: Mon, 23 Sep 2024 16:55:19 +0200
Message-ID: <20240923145520.1323504-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240923145520.1323504-1-edgar.iglesias@gmail.com>
References: <20240923145520.1323504-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::932;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-ua1-x932.google.com
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

From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>

Acked-by: Stefano Stabellini <sstabellini@kernel.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
---
 hw/xen/xen-pvh-common.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/hw/xen/xen-pvh-common.c b/hw/xen/xen-pvh-common.c
index 76a9b2b945..218ac851cf 100644
--- a/hw/xen/xen-pvh-common.c
+++ b/hw/xen/xen-pvh-common.c
@@ -218,6 +218,11 @@ static void xen_pvh_init(MachineState *ms)
             error_report("pci-ecam-size only supports values 0 or 0x10000000");
             exit(EXIT_FAILURE);
         }
+        if (!s->cfg.pci_intx_irq_base) {
+            error_report("PCI enabled but pci-intx-irq-base not set");
+            exit(EXIT_FAILURE);
+        }
+
         xenpvh_gpex_init(s, xpc, sysmem);
     }
 
@@ -273,6 +278,30 @@ XEN_PVH_PROP_MEMMAP(pci_ecam)
 XEN_PVH_PROP_MEMMAP(pci_mmio)
 XEN_PVH_PROP_MEMMAP(pci_mmio_high)
 
+static void xen_pvh_set_pci_intx_irq_base(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    xp->cfg.pci_intx_irq_base = value;
+}
+
+static void xen_pvh_get_pci_intx_irq_base(Object *obj, Visitor *v,
+                                          const char *name, void *opaque,
+                                          Error **errp)
+{
+    XenPVHMachineState *xp = XEN_PVH_MACHINE(obj);
+    uint32_t value = xp->cfg.pci_intx_irq_base;
+
+    visit_type_uint32(v, name, &value, errp);
+}
+
 void xen_pvh_class_setup_common_props(XenPVHMachineClass *xpc)
 {
     ObjectClass *oc = OBJECT_CLASS(xpc);
@@ -318,6 +347,13 @@ do {                                                                      \
         OC_MEMMAP_PROP(oc, "pci-ecam", pci_ecam);
         OC_MEMMAP_PROP(oc, "pci-mmio", pci_mmio);
         OC_MEMMAP_PROP(oc, "pci-mmio-high", pci_mmio_high);
+
+        object_class_property_add(oc, "pci-intx-irq-base", "uint32_t",
+                                  xen_pvh_get_pci_intx_irq_base,
+                                  xen_pvh_set_pci_intx_irq_base,
+                                  NULL, NULL);
+        object_class_property_set_description(oc, "pci-intx-irq-base",
+                                  "Set PCI INTX interrupt base line.");
     }
 
 #ifdef CONFIG_TPM
-- 
2.43.0


