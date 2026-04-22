Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8747CFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdmW-0004jZ-HE; Wed, 22 Apr 2026 16:02:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdle-00043E-MC
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:51 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlc-0002sX-Fc
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:50 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-483487335c2so58223355e9.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888105; x=1777492905; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XeUpuJAQM3HlSzusR90k2uWMnZf/9A9CoIWyson6H5w=;
 b=S5aRNVlD/Lm5Yl8ZY6eMj1aa+YCzf/bOse/SHftMyrmMtnkShC/+S9EN6IKwIHemxa
 PA15JmlhAvNyr6xoOTJ2wCqh5EhnpcDtLjaM5V2VumBf9Fl4scdr1bwFYysrCap1zBqz
 HM9x3HGG807DaY3PeF0mH5izwPPalHPeM4G4ZKzH2NiCpFEvKIvyY5uAMltopXdOWEJr
 QdeodnejOEa4eWtfMBK2XpiwCjuCMsxV8+1nyD8dnOsvEsqH7L7HDcQatJAPfiZXPbBx
 RxHwiQ39f9jnSMAWq+EJQzgOxPqTaiaPOguENSoJUHtoLylbLxS6ylIQmWfT5mL6IaUJ
 ea3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888105; x=1777492905;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=XeUpuJAQM3HlSzusR90k2uWMnZf/9A9CoIWyson6H5w=;
 b=s+4ikJ3iOVcAGi73+A/SBAst0VixkwqBV43DQo3YsnHwtxJBSBGIkvG1rKtY1ZFNa7
 AyDRki+VBONaotvKxlMLJYxeoE+Fqri2LMuybUoJyfR1QzcXzApJeQfr9FVTdHEXQfr1
 Vv0ia9DbvXpWCgltCayygBFH36LD4wnnTjFqohYSRWqdQvQ8QDXvW2+3BYOn6VFT371u
 Vc8P+Uifhy1kv5krHXHQIO0ih22WO0fiwqNpjBum9fV7fAySirpMG0MMPaEzDNQFAgoV
 j7VtnpQfw+vtGQaZV6wTPMPJJWtx64fpDJZDgEPjivBFb5t6mW8U/Fq1AFw+iY619g5G
 ABBA==
X-Gm-Message-State: AOJu0Yxb7mhTvnxm9J0mSefickQd6QV9nZ71hh83tjUdyiRzy/pJPKTd
 H3Xv7Fr+jZRIXr38LVUR20OHiPXdixhhOqp1Vtgeso90CTIauel3sCauHz0M6KtaDArJZ9qAH4K
 TaUdc+kk=
X-Gm-Gg: AeBDievlT3wrA+TV8thLtpVokGDSweTMJiIX3yX8BZM4HkBqp6WDHLEFupHnfPV9X9t
 lTgBOavktUQV7rjKav37XDiSc7nHq1mS9Hkygd/qkDYGfB5HVqxIpNJxoA5LKbytTmFHURdqDDi
 0GyyOofsI1Hqs5/dVEFqMEUFjonynlfxu0StLft/EWXKSihaFHYalH099GhiF1rEIMQsl8RxNqn
 cwYGI37cWhY7ZOlriSooZSwD0sO803AdKMLzG3yDkLLHdyoBjRmwbydJKGR77DGkbXOMEhdhR1x
 N6Sotfswx2ccS65U9cnH4SvUx9Uphk1+3bUlAsayqyN2EOQvQc9nqhnSkOeU46SJIY7o28Zl3DO
 zlckhlJaWVOOtznjWBKvU98i6xiviRy2ZNZZzWO9m4IrrH7xt+J6b6Hrl74h3iXU3t7uSeE0O7x
 1xYgAjsPN5+0YmRfNBznW7+rZn0k7c+wXoF4WmDF6Y0BE7NWYQiwKZn655lj6lUVGvWzJ6F+VKm
 PDUmWlg4Zw=
X-Received: by 2002:a05:600c:4f8c:b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-48a58ae9faemr109182805e9.16.1776888104803; 
 Wed, 22 Apr 2026 13:01:44 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c01cfsm487687685e9.10.2026.04.22.13.01.43
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:44 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 33/48] hw/tpm: add PPI support to tpm-tis-device for ARM64 virt
Date: Wed, 22 Apr 2026 21:57:31 +0200
Message-ID: <20260422195746.88865-34-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

From: Mohammadfaiz Bawa <mbawa@redhat.com>

Add PPI memory region and ACPI _STA, _DSM to tpm-tis-sysbus so
Windows 11 ARM64 guests no longer log Event ID 15 errors from
tpm.sys on every boot.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260327173209.148180-4-mbawa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/arm/virt-acpi-build.c |  9 ++++++++-
 hw/tpm/tpm_tis_sysbus.c  | 11 +++++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 591cfc993c6..5b5ac551f8c 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -240,7 +240,8 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
     Aml *dev = aml_device("TPM0");
     aml_append(dev, aml_name_decl("_HID", aml_string("MSFT0101")));
     aml_append(dev, aml_name_decl("_STR", aml_string("TPM 2.0 Device")));
-    aml_append(dev, aml_name_decl("_UID", aml_int(0)));
+    aml_append(dev, aml_name_decl("_UID", aml_int(1)));
+    aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
 
     Aml *crs = aml_resource_template();
     aml_append(crs,
@@ -248,6 +249,12 @@ static void acpi_dsdt_add_tpm(Aml *scope, VirtMachineState *vms)
                                   (uint32_t)memory_region_size(sbdev_mr),
                                   AML_READ_WRITE));
     aml_append(dev, aml_name_decl("_CRS", crs));
+
+    hwaddr ppi_base = platform_bus_get_mmio_addr(pbus, sbdev, 1);
+    if (ppi_base != -1) {
+        ppi_base += pbus_base;
+        tpm_build_ppi_acpi(TPM_IF(sbdev), dev, ppi_base);
+    }
     aml_append(scope, dev);
 }
 #endif
diff --git a/hw/tpm/tpm_tis_sysbus.c b/hw/tpm/tpm_tis_sysbus.c
index dd30344d5ac..6bec30c36fc 100644
--- a/hw/tpm/tpm_tis_sysbus.c
+++ b/hw/tpm/tpm_tis_sysbus.c
@@ -30,6 +30,7 @@
 #include "hw/core/sysbus.h"
 #include "tpm_tis.h"
 #include "qom/object.h"
+#include "qemu/memalign.h"
 
 struct TPMStateSysBus {
     /*< private >*/
@@ -99,6 +100,7 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 {
     TPMStateSysBus *sbdev = TPM_TIS_SYSBUS(obj);
     TPMState *s = &sbdev->state;
+    size_t host_page_size = qemu_real_host_page_size();
 
     memory_region_init_io(&s->mmio, obj, &tpm_tis_memory_ops,
                           s, "tpm-tis-mmio",
@@ -106,6 +108,12 @@ static void tpm_tis_sysbus_initfn(Object *obj)
 
     sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->mmio);
     sysbus_init_irq(SYS_BUS_DEVICE(obj), &s->irq);
+
+    s->ppi.buf = qemu_memalign(host_page_size,
+                                ROUND_UP(TPM_PPI_ADDR_SIZE, host_page_size));
+    memory_region_init_ram_device_ptr(&s->ppi.ram, obj, "tpm-ppi",
+                                      TPM_PPI_ADDR_SIZE, s->ppi.buf);
+    sysbus_init_mmio(SYS_BUS_DEVICE(obj), &s->ppi.ram);
 }
 
 static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
@@ -122,6 +130,8 @@ static void tpm_tis_sysbus_realizefn(DeviceState *dev, Error **errp)
         error_setg(errp, "'tpmdev' property is required");
         return;
     }
+
+    vmstate_register_ram(&s->ppi.ram, dev);
 }
 
 static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
@@ -132,6 +142,7 @@ static void tpm_tis_sysbus_class_init(ObjectClass *klass, const void *data)
     device_class_set_props(dc, tpm_tis_sysbus_properties);
     dc->vmsd  = &vmstate_tpm_tis_sysbus;
     tc->model = TPM_MODEL_TPM_TIS;
+    tc->ppi_enabled = true;
     dc->realize = tpm_tis_sysbus_realizefn;
     device_class_set_legacy_reset(dc, tpm_tis_sysbus_reset);
     tc->request_completed = tpm_tis_sysbus_request_completed;
-- 
2.53.0


