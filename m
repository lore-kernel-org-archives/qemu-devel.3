Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F6B10F2861
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 17:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w6B3E-0006eL-6h; Fri, 27 Mar 2026 13:32:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6B36-0006aD-UG
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:32:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mbawa@redhat.com>) id 1w6B35-0007yt-Be
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 13:32:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774632762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1l0fA9dLaPFhQ3AtiN7mPv0FR5CxBzjNHadXvLmdK6s=;
 b=W2P1VPA1kupXqEv1oEjktLum9Lc2/Z659w7FLkp8cEesL1bdiKtxc7WAP5nQpRKY3AoIJ9
 ZExpEg7C3IfaXNMZP6DYSxZehVnsQWjeod0hArWvaj4jd6FomessbSR9CFkEgWDjt5cYcz
 jszBR3BjM0pE/SpOwW/44uML9qrYX9g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-134-OWOwgaU7MXang1WWexYB7Q-1; Fri,
 27 Mar 2026 13:32:37 -0400
X-MC-Unique: OWOwgaU7MXang1WWexYB7Q-1
X-Mimecast-MFC-AGG-ID: OWOwgaU7MXang1WWexYB7Q_1774632756
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B39F1800464; Fri, 27 Mar 2026 17:32:36 +0000 (UTC)
Received: from mbawa-thinkpadt14gen5.bengluru.csb (unknown [10.74.88.2])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7A5A830001A1; Fri, 27 Mar 2026 17:32:29 +0000 (UTC)
From: Mohammadfaiz Bawa <mbawa@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanb@linux.vnet.ibm.com, pierrick.bouvier@linaro.org,
 "Michael S . Tsirkin" <mst@redhat.com>, imammedo@redhat.com,
 anisinha@redhat.com, peter.maydell@linaro.org, shannon.zhaosl@gmail.com,
 qemu-arm@nongnu.org, mohamed@unpredictable.fr, philmd@linaro.org,
 Mohammadfaiz Bawa <mbawa@redhat.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 2/3] hw/acpi/tpm: parameterize PPI base address in
 tpm_build_ppi_acpi
Date: Fri, 27 Mar 2026 23:02:08 +0530
Message-ID: <20260327173209.148180-3-mbawa@redhat.com>
In-Reply-To: <20260327173209.148180-1-mbawa@redhat.com>
References: <20260327173209.148180-1-mbawa@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mbawa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Update the x86 callers (ISA TIS and CRB) to pass TPM_PPI_ADDR_BASE
explicitly. No behavioral change.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mohammadfaiz Bawa <mbawa@redhat.com>
---
 hw/acpi/tpm.c         | 8 ++++----
 hw/i386/acpi-build.c  | 2 +-
 hw/tpm/tpm_tis_isa.c  | 2 +-
 include/hw/acpi/tpm.h | 3 ++-
 4 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/acpi/tpm.c b/hw/acpi/tpm.c
index 5fe95f2e3f..e703775984 100644
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
index 4f01e2c476..0d7c83d5e9 100644
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
index 1ca403241d..2b1267133a 100644
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
 
diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index d2bf6637c5..2ab186a745 100644
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


