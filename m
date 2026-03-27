Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A2610ED660
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 11:49:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w65gU-0006wQ-Tr; Fri, 27 Mar 2026 07:49:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w65gR-0006u9-1m
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:48:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w65gP-0000R2-BX
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 07:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774612136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vNfBpMAfcLKVWxGQFoc6sYSvJTCHtumHh8ghhvrEnQM=;
 b=IMbODeMzZYlkA8MKtRkfOKgC8m2DDb9l8iMSUYW8IUedB9LNLYT3NvX8RjyaF8AglCHMbd
 qapqJ6fSRx0Q6BpayAu7K/wDVwJHKUiEs5xyzBcybxnLLRMHnAEofkk3MsrXku551uiQTO
 PfvrT9S7dO6Tghr8xHxudZRYYjEf/Zs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-392-eZXR0pF_MKqnysy0nIhaYw-1; Fri,
 27 Mar 2026 07:48:53 -0400
X-MC-Unique: eZXR0pF_MKqnysy0nIhaYw-1
X-Mimecast-MFC-AGG-ID: eZXR0pF_MKqnysy0nIhaYw_1774612132
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E087E195608C; Fri, 27 Mar 2026 11:48:51 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.10])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id E6BC219560B1; Fri, 27 Mar 2026 11:48:45 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, mohamed@unpredictable.fr,
 Mohammadfaiz Bawa <mbawa@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/3] hw/acpi/tpm: parameterize PPI base address in
 tpm_build_ppi_acpi
Date: Fri, 27 Mar 2026 17:18:23 +0530
Message-ID: <20260327-tpm-tis-sysbus-ppi-v2-2-d8ec84d25dbc@redhat.com>
In-Reply-To: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
References: <20260327-tpm-tis-sysbus-ppi-v2-0-d8ec84d25dbc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Add a ppi_base parameter to tpm_build_ppi_acpi() instead of
hardcoding TPM_PPI_ADDR_BASE. This prepares for ARM64 support where
PPI memory is dynamically allocated by the platform bus and the
address is not known at compile time.

Update the x86 ISA TIS caller to pass TPM_PPI_ADDR_BASE explicitly.
No behavioral change.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/acpi/tpm.c         | 8 ++++----
 hw/tpm/tpm_tis_isa.c  | 2 +-
 include/hw/acpi/tpm.h | 3 ++-
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index cdc022753659af102e56ea4148423b94de1531f6..c4ff2f8cb836c16b00f70865bf55781d5c402aa2 100644
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
diff --git a/hw/tpm/tpm_tis_isa.c b/hw/tpm/tpm_tis_isa.c
index 61e95434f5b824fa99f0a2aff7f151e87ea631ed..e30bef49558673f4c857c02dae059ce3361a1bc7 100644
--- a/hw/tpm/tpm_tis_isa.c
+++ b/hw/tpm/tpm_tis_isa.c
@@ -162,7 +162,7 @@ static void build_tpm_tis_isa_aml(AcpiDevAmlIf *adev, Aml *scope)
      */
     /* aml_append(crs, aml_irq_no_flags(isadev->state.irq_num)); */
     aml_append(dev, aml_name_decl("_CRS", crs));
-    tpm_build_ppi_acpi(ti, dev);
+    tpm_build_ppi_acpi(ti, dev, TPM_PPI_ADDR_BASE);
     aml_append(scope, dev);
 }
 
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index d2bf6637c5424b92ad99f5baa938fd6cea3520bf..2ab186a7455593df205a7ffecbea2abdfdbd11d5 100644
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
 

-- 
2.53.0


