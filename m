Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08356C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:17:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvjX-0000Cg-9T; Tue, 25 Feb 2025 09:16:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1tmpZa-0007D4-MP; Tue, 25 Feb 2025 02:41:46 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kuqin12@gmail.com>)
 id 1tmpZY-0000M3-R8; Tue, 25 Feb 2025 02:41:46 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-22113560c57so21385575ad.2; 
 Mon, 24 Feb 2025 23:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740469302; x=1741074102; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Kf1MrtaHC0wZM7XLXful0rxVzkTNo8/SZGUPpzDEZh0=;
 b=jJOnGc58m976wEKYWEb78TmIOJvRiyGknWZQ+IZb/Z6GytgT9pmRkURUeHFHVpi/07
 GqBiiDW260MIraofyeqoiY061DjzLEyxLl9wddOE/gircI29lZS11MNsaZGgHT69oFZC
 4orBB0ABIl5TwGATW05x+i9JguCYHdJygForgBtQgsPpmBbPTBwnYdVLg9qDs/I5KlVu
 qulr7LdUkuJdX32F26C8RHzEdKvZSYInk6Tj0a2wyaIUUcchiJm9vxbNc0SJIwyCfqIh
 a1tV0X7SrN+H/opysPMHGa5EaC2fkoVj0z85U/X4n6lfpq6/q9Y2FmiJJtGV8rXurCnV
 RCVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740469302; x=1741074102;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kf1MrtaHC0wZM7XLXful0rxVzkTNo8/SZGUPpzDEZh0=;
 b=NzgRNSzYvt9C9gah2dAp+BZREJsfox9yYEcacvzYOvcOXfFvAfVxVRLn+xbtsEfiuE
 lyJRoP5b5G+dXSfnacLfrXnRiFZrhbR+Tls5vcMtmTpO3B6CUB3YC0d6NJ1zw0ppwcfm
 hRtLnlLrUqBWEDXU6W14+E1iO79THyAKlOixhh4tJkUIr79RKPSLsejmNbA7CKy2aKPy
 75sPimwvDI4KIhT1TTAU9RaFIPD6qEYbbpmYwE4iJaNljqwIKfV2s6dzk5r0yoDTc2qf
 Qgaqt2jcIhMERIEsCJ+ghDXi/BTTrMvzjupTcz5Sapk6s8fArvQWX7kvo94N5bLl7MAJ
 XlXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoNKgomZQKSWvpTRyMPvIoPWt0MpHt2f0rG2AC/fQ2HMjnmlQ2KHNqiTjjEsCjuk7L3HYYWqmmJg==@nongnu.org
X-Gm-Message-State: AOJu0YxcWJypm3bNs0pT12OEcqxA6MHDI2M94YbIYNnky1kdcJ7ARWYM
 vju7sqgr0mNlZITDZlZuZlmIhtUvKdoRFAWpfFKmq58TyPm9tzYnjQt/wQ==
X-Gm-Gg: ASbGncsi6YHdwgMiCKRmY517F8i85fuRxSCdLYSowT1i83cMN/9NXsEly9zmnEzmUXf
 OU8wBMDm15uisJGOvfUYZ6HjMdp5O+ce+u/DSNl1VBj9OL2wix3BGG+A4sd5KPB0uj7rUjJLCQk
 a46cURgdfxOH01eO956Nl9cwJD/GArG2NMtUJ0AQUY0zy9ywrz3H9SL0r1CsAhpz+KMmfod00pZ
 IxobDJeZPd/kGMjXbstv3P4XWHXsH0rQqvU0xnyXTlyps5RyRVVsisyHXl267TJChSgq2cxzm0w
 EuRrf+MAzpw+q+x6qlsBeXIUoS1vxnJB85flRzX5crSi3scG0zPmLdYOQ9bnpqrx
X-Google-Smtp-Source: AGHT+IHRpT5bEy2iJMCsNViGAaL8mi2mtSzGzLuRun9E5EkbS5chx8m9r5rJOumeBQfbBQd6wP3dqA==
X-Received: by 2002:a17:902:f68d:b0:216:1543:195e with SMTP id
 d9443c01a7336-221a0ec33c2mr286435205ad.5.1740469302541; 
 Mon, 24 Feb 2025 23:41:42 -0800 (PST)
Received: from MININT-QD064TT.redmond.corp.microsoft.com ([131.107.160.232])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2230a0a6041sm7856265ad.175.2025.02.24.23.41.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Feb 2025 23:41:41 -0800 (PST)
From: Kun Qin <kuqin12@gmail.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 Kun Qin <kuqin@microsoft.com>, Kun Qin <kuqin12@gmail.com>
Subject: [PATCH 1/1] hw/arm/sbsa-ref: Adding TPM support for ARM SBSA-Ref
 machine
Date: Mon, 24 Feb 2025 23:41:33 -0800
Message-ID: <20250225074133.6827-2-kuqin12@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250225074133.6827-1-kuqin12@gmail.com>
References: <20250225074133.6827-1-kuqin12@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=kuqin12@gmail.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 25 Feb 2025 09:15:58 -0500
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

From: Kun Qin <kuqin@microsoft.com>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2625

This change aims to add a TPM device for SBSA ref machine.

The implementation adds a TPM create routine during machine
initialization.

The backend can be the same as the rest of TPM support, by using swtpm.

Signed-off-by: Kun Qin <kuqin12@gmail.com>
---
 hw/arm/sbsa-ref.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index e720de306419..93eb3d1e363b 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -28,6 +28,8 @@
 #include "system/numa.h"
 #include "system/runstate.h"
 #include "system/system.h"
+#include "system/tpm.h"
+#include "system/tpm_backend.h"
 #include "exec/hwaddr.h"
 #include "kvm_arm.h"
 #include "hw/arm/boot.h"
@@ -94,6 +96,7 @@ enum {
     SBSA_SECURE_MEM,
     SBSA_AHCI,
     SBSA_XHCI,
+    SBSA_TPM,
 };
 
 struct SBSAMachineState {
@@ -132,6 +135,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
     [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
+    [SBSA_TPM] =                { 0x60120000, 0x00010000 },
     /* Space here reserved for other devices */
     [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
     /* 32-bit address PCIE MMIO space */
@@ -629,6 +633,24 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
+static void create_tpm(SBSAMachineState *sbsa, PCIBus *bus)
+{
+    Error *errp = NULL;
+    DeviceState *dev;
+
+    TPMBackend *be = qemu_find_tpm_be("tpm0");
+    if (be == NULL) {
+        error_report("Couldn't find tmp0 backend");
+        return;
+    }
+
+    dev = qdev_new(TYPE_TPM_TIS_SYSBUS);
+    object_property_set_link(OBJECT(dev), "tpmdev", OBJECT(be), &errp);
+    object_property_set_str(OBJECT(dev), "tpmdev", be->id, &errp);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, sbsa_ref_memmap[SBSA_TPM].base);
+}
+
 static void create_pcie(SBSAMachineState *sms)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
@@ -686,6 +708,8 @@ static void create_pcie(SBSAMachineState *sms)
     pci_create_simple(pci->bus, -1, "bochs-display");
 
     create_smmu(sms, pci->bus);
+
+    create_tpm(sms, pci->bus);
 }
 
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
-- 
2.43.0


