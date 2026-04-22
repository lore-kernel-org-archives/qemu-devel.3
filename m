Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51A7FFA1FED
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 20:03:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFdls-0004C3-As; Wed, 22 Apr 2026 16:02:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlW-0003uq-7n
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:44 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wFdlU-0002qh-Cp
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 16:01:41 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso61243385e9.1
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 13:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776888098; x=1777492898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GIiUeR+b26DEeePibWG8P7/XRvyLYZ4UqKevgTJTWwM=;
 b=BqMc0Rvie8Hr268Y6/5/UtiSC3+00ke2UUAMG8iJcojIQ5Zfpz+mYYNWt94sJnOv8H
 kY8VZLhk8eluJQ2vlCAcUgwdjYhlf3Am5QAzUoEIqZ90JtLgNIqhMVTR4PW5uw40/EzE
 rw1ndnqmHIGmBkAsaZ7AqU0E2jTF4jfGSJO80EXWKy3neWsVDi/VjRb/BRHTZYyqQXby
 FYfdkawrW5vv/XGr46s+7xwIKB7w57qk4vIOAM0e7X0eJ9r0/BZ1fuQ4dibCj7B/ql0F
 tt7D75J/9Dcbni5rYQ1qy73Rq6v5CQzirBAhOHfRLsRlPHqTTwDtpH8RWWhMw9AUd2Hs
 OpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776888098; x=1777492898;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GIiUeR+b26DEeePibWG8P7/XRvyLYZ4UqKevgTJTWwM=;
 b=HuBoVwiughS+R4Fm42k58nqFQ49suszsY14qxvMEaIJ258wYVxA9STqO5tUqnfzAZZ
 i8a5zLNt16un+f+vXMvGUHVnPBOqiZarWEagKmXEO9pbQ8vTqi/y7pmcF5goO4WldvU8
 DdZ3cbjZH1LvtFanKUb/ecK2ruzhi3rjUX4yFGmigucXwZ3xxCZJfMsGQQa1ITJ6qcqk
 RuTGhRNWkBWqd0XjWBvWWHJ8emaCbLAz7ZQYhMaNqZm9xj6IQlH18Inq0nE6iJQ+OVnq
 A2I6NR7YUCebVR8MoT9kpx60nWYwweuLyoVlixK/jVMgqlFLEWJBP/+dyQWmcfK4vp83
 pfSQ==
X-Gm-Message-State: AOJu0YyNITjx3HLezjdssBZ2X9E01L4WL6cJCm7fBBOpc6AO9AXc/Hn+
 X/VfgP7RnPsz849zpquzb9nzRdcqRQIFJ9I062+FtZZ09WQ/IjeN2NqKj3YkgCdIW0UqDE8ergY
 2tyXWazk=
X-Gm-Gg: AeBDieuc7I1azv/+etlKkri5CZCFGBKAG7mH9tzh4F5guNezGFTH4WH5Sz7fMBx6LDJ
 Cramgy1G++F3DLMa+35gYS+xcGRjo5liyXeWo+jsozwA06m8M5NMYMsYrH0FPKec5vMg9P2MRxh
 u2jwKw1CXPs1wdsf+Zq3skg22QP0ki1c6Z8HcSAWVoDbGb1Saz60ZZTcRa1PUuFr3V0kVe3t/UQ
 0uxsI2fGpUCKeco5vIi2MCqvb6k6pl+rkabCzPM3c+A+DynRqgjpl0MDvUxBqjdrsN0RI3rLL3u
 4KNUcTqg31OYamNxXrFeCahe5vDmKKXlP8cl6bEa+kYx/C+OlsAou1nWDdx/iNv5w2e31YeHZe0
 ey3QR9MzqoI2tLbAfWt4K+FNCRa8S/l3hIDK+9VqWf9imz8A2Vq/+Ag+hcGjgl3zd77iBvN10pV
 hu6zjui+OOL+h2yyvXIgynklc0PXImctos4b0d0IKbPzIlJYwcNGL+yB0Lzdtn1pIKND6I0KGRy
 0BrPspNNak=
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48a5821692dmr89541745e9.4.1776888097930; 
 Wed, 22 Apr 2026 13:01:37 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-489fec8f7cbsm199243925e9.11.2026.04.22.13.01.36
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 22 Apr 2026 13:01:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 32/48] hw/acpi/tpm: parameterize PPI base address in
 tpm_build_ppi_acpi
Date: Wed, 22 Apr 2026 21:57:30 +0200
Message-ID: <20260422195746.88865-33-philmd@linaro.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422195746.88865-1-philmd@linaro.org>
References: <20260422195746.88865-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

Add a ppi_base parameter to tpm_build_ppi_acpi() instead of
hardcoding TPM_PPI_ADDR_BASE. This prepares for ARM64 support where
PPI memory is dynamically allocated by the platform bus and the
address is not known at compile time.

Update the x86 callers (ISA TIS and CRB) to pass TPM_PPI_ADDR_BASE
explicitly. No behavioral change.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20260327173209.148180-3-mbawa@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/acpi/tpm.h | 3 ++-
 hw/acpi/tpm.c         | 8 ++++----
 hw/i386/acpi-build.c  | 2 +-
 hw/tpm/tpm_tis_isa.c  | 2 +-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index d2bf6637c54..2ab186a7455 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -20,6 +20,7 @@
 #include "hw/core/registerfields.h"
 #include "hw/acpi/aml-build.h"
 #include "system/tpm.h"
+#include "exec/hwaddr.h"
 
 #ifdef CONFIG_TPM
 
@@ -250,7 +251,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
  */
 #define TPM_I2C_INT_ENABLE_MASK   0x0
 
-void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev);
+void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev, hwaddr ppi_base);
 
 #endif /* CONFIG_TPM */
 
diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index 5fe95f2e3f1..e703775984a 100644
--- a/hw/acpi/tpm.c
+++ b/hw/acpi/tpm.c
@@ -20,7 +20,7 @@
 #include "qapi/error.h"
 #include "hw/acpi/tpm.h"
 
-void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
+void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev, hwaddr ppi_base)
 {
     Aml *method, *field, *ifctx, *ifctx2, *ifctx3, *func_mask,
         *not_implemented, *pak, *tpm2, *tpm3, *pprm, *pprq, *zero, *one;
@@ -40,7 +40,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
      */
     aml_append(dev,
                aml_operation_region("TPP2", AML_SYSTEM_MEMORY,
-                                    aml_int(TPM_PPI_ADDR_BASE + 0x100),
+                                    aml_int(ppi_base + 0x100),
                                     0x5A));
     field = aml_field("TPP2", AML_ANY_ACC, AML_NOLOCK, AML_PRESERVE);
     aml_append(field, aml_named_field("PPIN", 8));
@@ -56,7 +56,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
     aml_append(dev,
                aml_operation_region(
                    "TPP3", AML_SYSTEM_MEMORY,
-                   aml_int(TPM_PPI_ADDR_BASE +
+                   aml_int(ppi_base +
                            0x15a /* movv, docs/specs/tpm.rst */),
                            0x1));
     field = aml_field("TPP3", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
@@ -78,7 +78,7 @@ void tpm_build_ppi_acpi(TPMIf *tpm, Aml *dev)
 
         aml_append(method,
             aml_operation_region("TPP1", AML_SYSTEM_MEMORY,
-                aml_add(aml_int(TPM_PPI_ADDR_BASE), op, NULL), 0x1));
+                aml_add(aml_int(ppi_base), op, NULL), 0x1));
         field = aml_field("TPP1", AML_BYTE_ACC, AML_NOLOCK, AML_PRESERVE);
         aml_append(field, aml_named_field("TPPF", 8));
         aml_append(method, field);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 4f01e2c476e..0d7c83d5e96 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1219,7 +1219,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         aml_append(dev, aml_name_decl("_STA", aml_int(0xf)));
         aml_append(dev, aml_name_decl("_UID", aml_int(1)));
 
-        tpm_build_ppi_acpi(tpm, dev);
+        tpm_build_ppi_acpi(tpm, dev, TPM_PPI_ADDR_BASE);
 
         aml_append(sb_scope, dev);
     }
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 1ca403241de..2b1267133ac 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -159,7 +159,7 @@ static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
      */
     /* aml_append(crs, aml_irq_no_flags(isadev->state.irq_num)); */
     aml_append(dev, aml_name_decl("_CRS", crs));
-    tpm_build_ppi_acpi(ti, dev);
+    tpm_build_ppi_acpi(ti, dev, TPM_PPI_ADDR_BASE);
     aml_append(scope, dev);
 }
 
-- 
2.53.0


