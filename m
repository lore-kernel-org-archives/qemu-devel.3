Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56D3FCF34BE
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 18:58:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swR0o-0000mn-SH; Thu, 03 Oct 2024 14:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0k-0000lv-Hv
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:57:14 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1swR0i-0003Jk-Vd
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 14:57:14 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2faccccbca7so12976921fa.2
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 11:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1727981831; x=1728586631; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mm+KI23c86LD33sZYRxxXCIhV12T/Ywht8Xuz1hXe+0=;
 b=bsnHDj5IZoNUuYxYYDz/o1AY+xOfdfnr1cPI5E1G/h0ClY1S6Z/unmmm/EQBQQ4BXn
 XoRhlQJzKmiMCbipsXhkJTUgPZuZCNqThQCddAFPbI2snUrviEf2y/I9VWRHBQRze7pN
 //aC/4UHYf4zlcmJbKofUV6k8XYfmpqg7iHFBK43oVS3zTFZBeJdtBZYprlG5xF/jZiR
 ZX0+Jthdb9XHMaYTUmzZ9iEZ22xeLLJ+FRskfAqz0tPsZzHkGTCpojcTjxemLSb+bqUA
 J8zYOxOsO6Y92wRhy+nSdOu4RhQhsfeOyGy8IN+nwWRC65jqAIsdzeWjJUw8iTeuBF7I
 L+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727981831; x=1728586631;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Mm+KI23c86LD33sZYRxxXCIhV12T/Ywht8Xuz1hXe+0=;
 b=VVpphFv0SY+BLzV6cPcLISVoHXCcEemQ0LRhbefBWrm9cEtSYdbIM6gtVXXIMDPglk
 zGjMNzrsUNozu2PVdCPsrLFNgu5QN/8iW7IEinCiBQy+TJ+9e05CglcuQjxVtb26DFaB
 d0cZcfu+Cy7farDUOM6SyQdtmtwUC8XkReV7X/mlXlrxr+Buvs5ijCK2Ev+SxU5QhnsV
 ro9CtHH2oxwCzuaLO9nt4YYQYXal6FqtrhPrQmxe8QioVnMf/AkI4vWEwwR3yILJx++6
 JH3Sc18ivtd7h2+PM/aFEc4I3VucjvqThNX1kIcYjkKqPV07Q7ZPwwj9No8M/5GnQmvR
 ujuw==
X-Gm-Message-State: AOJu0Yw+q0p45x5nRti6PEBZ3IazdKpy7WeRi3SFO6QODAZnHTqBmYwl
 r+FvleRC1SbLiBKgavQP3MGS3WF+54fN6HWrpxE44lSlMUDspUCTP65qjHuE
X-Google-Smtp-Source: AGHT+IE/e+F5VPNpTgi+p/cRxu4+PagJbnZ/GBiwrIy/ibjkQC9qwAlDuSB/1il5roTTxnglcO+Z8Q==
X-Received: by 2002:a2e:be28:0:b0:2fa:bf53:1dad with SMTP id
 38308e7fff4ca-2faf3d9d202mr113291fa.31.1727981830633; 
 Thu, 03 Oct 2024 11:57:10 -0700 (PDT)
Received: from gmail.com (213-67-3-247-no600.tbcn.telia.com. [213.67.3.247])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-2faecbf63eesm2692971fa.27.2024.10.03.11.57.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Oct 2024 11:57:09 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Cc: sstabellini@kernel.org, anthony@xenproject.org, paul@xen.org,
 peter.maydell@linaro.org, edgar.iglesias@amd.com,
 xen-devel@lists.xenproject.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Subject: [PULL v2 4/5] hw/xen: xenpvh: Add pci-intx-irq-base property
Date: Thu,  3 Oct 2024 20:56:53 +0200
Message-ID: <20241003185655.1480819-5-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
References: <20241003185655.1480819-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x234.google.com
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


