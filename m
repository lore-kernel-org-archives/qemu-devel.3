Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96748C3ABB2
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2024 15:10:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqDLk-0004ub-Vj; Mon, 16 Sep 2024 11:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLi-0004qE-Ns
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:09:11 -0400
Received: from mail-io1-xd2f.google.com ([2607:f8b0:4864:20::d2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1sqDLh-00049G-AT
 for qemu-devel@nongnu.org; Mon, 16 Sep 2024 11:09:10 -0400
Received: by mail-io1-xd2f.google.com with SMTP id
 ca18e2360f4ac-82cda617e1aso337109639f.2
 for <qemu-devel@nongnu.org>; Mon, 16 Sep 2024 08:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1726499346; x=1727104146; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OyzI0RstvYLpuGfxES5qaxdspprmer1imsnsZ+RTJfc=;
 b=hPjegOjaj6g/Fpn3KqVmmC//55ZZHS8bMUAOEsbg3NilqqzJT1RTF+hgga/fxi0QSb
 bzevm1WahAXBKWjSCk1dwxzcciOVGQF4xvuJghsmA9YOpVEmprpbHRu2w/8o5QhVB9oC
 r6fCfF6cHH/W0lrfRoFwLHmwZAJeAuNli/OxC4w6DrQNeUMHmeD6Eqcbxd7kTNCdY2h2
 tF4NAq7M3sQpLyz7ZnCovryV6tPagsDGm9uXSyVx5JD38PCRBWqI+PMFn6udm9tCHDa+
 XEUNJrExi6bjrvsPu2gO7W/EHfX6QizS01UTvCwjDR+MBeL2zorVWhAw0FxKN83R5C6f
 AZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726499346; x=1727104146;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OyzI0RstvYLpuGfxES5qaxdspprmer1imsnsZ+RTJfc=;
 b=r7K1VAt3z1Z//2DWybcD17r4OpW8sjbyRQc7ijSwd6vlkdbjRnaRATqxzx5w7nS3Pz
 /Vvi8hvc/5A5UlCjT0KG7B8mxJnxP3oDMP9HWDJnzaPazImWKmnQ5Qz8Ma5rUXvFQQcU
 F070lz7aOpltsZ3ncrkT+IV0e40dAoach9fMCc/hJhemijsiJPebggFg7F4AcfKRhw4a
 XHVZlLuQTDq+DqsPLP+nJ6xjzo53uH81O6Xn5WL44f57LQqNkwepVcGSSFQEHaOLrEJm
 3q2CxTkcOlgnaKrqAOfBvNTAeD4zF/fzTmabCvW5MAziAjmb70++03XPtyvwMmTzZMkN
 bNKw==
X-Gm-Message-State: AOJu0Yw6RDMoAn/ZpmmPorO37lTLe/AqI1LuibHaZltRJpqr4iGMwyQb
 206t2sqQfeW3x59emT0DAwZFOjgt0KOSWVfj5dN/tl+4iJ2rmkEMPQJrrHQm
X-Google-Smtp-Source: AGHT+IFk3CkyeCYvrPI4xTDPi8u/IiZ0rmyEE85GTpP+WG+LffchGyM0QorbzWrvqbgokOTwFKRghA==
X-Received: by 2002:a05:6602:3420:b0:82c:f30d:fc9b with SMTP id
 ca18e2360f4ac-82d1f982f5dmr1267148039f.13.1726499345949; 
 Mon, 16 Sep 2024 08:09:05 -0700 (PDT)
Received: from gmail.com (ip190-5-140-142.intercom.com.sv. [190.5.140.142])
 by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-82d49338889sm161572039f.38.2024.09.16.08.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Sep 2024 08:09:05 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, alex.bennee@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PATCH v1 3/4] hw/xen: xenpvh: Add pci-intx-irq-base property
Date: Mon, 16 Sep 2024 17:08:51 +0200
Message-ID: <20240916150853.1216703-4-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
References: <20240916150853.1216703-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2f;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-io1-xd2f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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


