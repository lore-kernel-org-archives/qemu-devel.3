Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291A5F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:28:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytZO-0006a2-L1; Sat, 07 Mar 2026 10:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytZH-0006ZA-GC
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:51 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytZF-00088L-Ox
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:27:51 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4852f8ac7e9so6740745e9.1
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772897267; x=1773502067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UpxJXWcZNG1+ebD1fEdM0IVTOlZtM+I+M3Z4j0NTFmM=;
 b=rCk8MU9XjQN7nZdvFYGENHzmW8kDxspek2xiLgQLZybN1Jmph37F5XJW0P87Hc0bMm
 doHffT6u1ITYlZwod3ZoRSJScQygqog4vfjQ75V1V7svU8TvMY7Jdk0GcZK+CieDPAfG
 tNTP8YCOT76kbjmxGw3wheMTReTCIwiMUVw+fuj0Kj0unoqPwkLr5uXX2WujScy7v7Fy
 uBNtgLriW4GPKyiAXety3gkykhBhtDyLUNgsrnSDfN99MbT0k4e90/7sEJeclc9JA1Np
 8s0Z1+rS5O//nWv0uIp4QPZW3rfebb2cFLVa+64/yIJpSiskHKP+6YGD2VZUaXjFHclR
 Et0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772897267; x=1773502067;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UpxJXWcZNG1+ebD1fEdM0IVTOlZtM+I+M3Z4j0NTFmM=;
 b=k/H/VNig/ayEHfyCmO/csm38gPvbYnGOIiO5mPbQBUkKN4kkT9wjo0cYVP2xKGlCF/
 e15pr9FDO4cF9gBsCpqM9C4sdUdoVA2ogqU5ThHwYob4cCd7MDE9z3fKfk+1HXt+CGxb
 o/gEKWrHQ1fccDHKm6JkHm9++XPym0nGFzWDbuimUMr3d0D0gUU8G2QsYA6xyrlcQL+F
 EWsZvVTPZCYWbq4SCSP0Q22ITxwb4rWXzp2o4YGFKTdRsDqYVUSyXXSwnXv7AwpP93h9
 I/j3VkfG+r+rJyGB2oHcHtrd157OETht0Ac3xObYGaPNAcSs4K75fUcbcftyD49o1yjl
 FMJg==
X-Gm-Message-State: AOJu0Yz5wbiOiNtAD0i2qjt8RTYKyROFjR3jNxHE32+QCaOzY1KSpAoN
 CpZ2kFJ8+Z2Cu6AOl+XWuk0Wb93GGeo8j6MXIjI4k0ELfjeT2R2AHPP1QHMbKFFTAqdKavSGbMn
 xQBx5JLo=
X-Gm-Gg: ATEYQzzU5A9eGdCBPmC5UoEalpiCKFOjqahNykMZwWN++kdRU3EXiPSDNzddDba61Jb
 bgaNFQn7p66gR/pGqHgNGuvBTQcvDg5mOOhipQbnwFcziKYOrQaE4QQ4F0pX8Rc2lkVnzHvHEQV
 1ZPqTB8XxHmqM9V6sKiCVsSD5bN2Bpu/8YMYuKfL6pAo8J+w054KFTlpdIFVW8MCgPKFHI5QcSf
 ZknRtSpdOf1tWZFYmXbwUD5FgC88yKGnKH0FGIER4UJLbox3e42lcYFhMZQOXaKEEy9g/6depzG
 pf+fnlJMHpY9UE8OJl0u7l01d0SX2mXuxtRK2Ae/79sLmF8UzJG1oFusUGRt/7paT8Z8fAdErUM
 n0jFT0elxs/JGSHdk0w8+Pvksesfc1xFhp9462wxcwVnyz9f9HAxEW3aNa/E6bmkcPy4/xSnnHe
 sTZ+zdzjy0/a691165CIyXV1CVECXm0Eoc0hyDrUD/aFCU1fL4rJtdJlacNJ4cmKsusfZhuLck
X-Received: by 2002:a05:600c:8b88:b0:485:30d4:6b98 with SMTP id
 5b1f17b1804b1-48530d46ef4mr24304575e9.15.1772897267454; 
 Sat, 07 Mar 2026 07:27:47 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439dad97abasm10816462f8f.10.2026.03.07.07.27.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:27:47 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yi Liu <yi.l.liu@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@bull.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Ani Sinha <anisinha@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH 10/10] hw/tpm: Remove CRBState::ppi_enabled field
Date: Sat,  7 Mar 2026 16:26:34 +0100
Message-ID: <20260307152635.83893-11-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260307152635.83893-1-philmd@linaro.org>
References: <20260307152635.83893-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

The CRBState::ppi_enabled boolean was only set in the
hw_compat_3_1[] array, via the 'ppi=false' property.
We removed all machines using that array, lets remove
that property and all the code around it.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 hw/tpm/tpm_tis.h        |  1 -
 hw/acpi/tpm.c           |  4 ----
 hw/i386/acpi-build.c    |  2 +-
 hw/tpm/tpm_crb.c        | 12 +++---------
 hw/tpm/tpm_tis_common.c |  4 +---
 hw/tpm/tpm_tis_isa.c    |  7 ++-----
 6 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/hw/tpm/tpm_tis.h b/hw/tpm/tpm_tis.h
index 184632ff66b..0df45f0c716 100644
--- a/hw/tpm/tpm_tis.h
+++ b/hw/tpm/tpm_tis.h
@@ -75,7 +75,6 @@ typedef struct TPMState {
 
     size_t be_buffer_size;
 
-    bool ppi_enabled;
     TPMPPI ppi;
 } TPMState;
 
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index cdc02275365..922030a29bf 100644
--- a/hw/acpi/tpm.c
+++ b/hw/acpi/tpm.c
@@ -25,10 +25,6 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
     Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
         *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
 
-    if (!object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
-        return;
-    }
-
     zero = aml_int(0);
     one = aml_int(1);
     func_mask = aml_int(TPM_PPI_FUNC_MASK);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f622b91b76a..6b7cd00c5db 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2218,7 +2218,7 @@ void acpi_setup(void)
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog));
 
     tpm = tpm_find();
-    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort)) {
+    if (tpm) {
         tpm_config = (FwCfgTPMConfig) {
             .tpmppi_address = cpu_to_le32(TPM_PPI_ADDR_BASE),
             .tpm_version = tpm_get_version(tpm),
diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 8723536f931..40ffc7b006b 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -43,7 +43,6 @@ struct CRBState {
 
     size_t be_buffer_size;
 
-    bool ppi_enabled;
     TPMPPI ppi;
 };
 typedef struct CRBState CRBState;
@@ -228,16 +227,13 @@ static const VMStateDescription vmstate_tpm_crb = {
 
 static const Property tpm_crb_properties[] = {
     DEFINE_PROP_TPMBE("tpmdev", CRBState, tpmbe),
-    DEFINE_PROP_BOOL("ppi", CRBState, ppi_enabled, true),
 };
 
 static void tpm_crb_reset(void *dev)
 {
     CRBState *s = CRB(dev);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_reset(&s->ppi);
-    }
+    tpm_ppi_reset(&s->ppi);
     tpm_backend_reset(s->tpmbe);
 
     memset(s->regs, 0, sizeof(s->regs));
@@ -303,10 +299,8 @@ static void tpm_crb_realize(DeviceState *dev, Error **errp)
     memory_region_add_subregion(get_system_memory(),
         TPM_CRB_ADDR_BASE + sizeof(s->regs), &s->cmdmem);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, get_system_memory(),
-                     TPM_PPI_ADDR_BASE, OBJECT(s));
-    }
+    tpm_ppi_init(&s->ppi, get_system_memory(),
+                 TPM_PPI_ADDR_BASE, OBJECT(s));
 
     if (xen_enabled()) {
         tpm_crb_reset(dev);
diff --git a/hw/tpm/tpm_tis_common.c b/hw/tpm/tpm_tis_common.c
index f594b15b8ab..712d64b60f1 100644
--- a/hw/tpm/tpm_tis_common.c
+++ b/hw/tpm/tpm_tis_common.c
@@ -821,9 +821,7 @@ void tpm_tis_reset(TPMState *s)
     s->be_buffer_size = MIN(tpm_backend_get_buffer_size(s->be_driver),
                             TPM_TIS_BUFFER_MAX);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_reset(&s->ppi);
-    }
+    tpm_ppi_reset(&s->ppi);
     tpm_backend_reset(s->be_driver);
 
     s->active_locty = TPM_TIS_NO_LOCALITY;
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 61e95434f5b..aadca4ed79b 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -94,7 +94,6 @@ static void tpm_tis_isa_reset(DeviceState *dev)
 static const Property tpm_tis_isa_properties[] = {
     DEFINE_PROP_UINT32("irq", TPMStateISA, state.irq_num, TPM_TIS_IRQ),
     DEFINE_PROP_TPMBE("tpmdev", TPMStateISA, state.be_driver),
-    DEFINE_PROP_BOOL("ppi", TPMStateISA, state.ppi_enabled, true),
 };
 
 static void tpm_tis_isa_initfn(Object *obj)
@@ -132,10 +131,8 @@ static void tpm_tis_isa_realizefn(DeviceState *dev, Error **errp)
     memory_region_add_subregion(isa_address_space(ISA_DEVICE(dev)),
                                 TPM_TIS_ADDR_BASE, &s->mmio);
 
-    if (s->ppi_enabled) {
-        tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
-                     TPM_PPI_ADDR_BASE, OBJECT(dev));
-    }
+    tpm_ppi_init(&s->ppi, isa_address_space(ISA_DEVICE(dev)),
+                 TPM_PPI_ADDR_BASE, OBJECT(dev));
 }
 
 static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
-- 
2.52.0


