Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C539D73EB7
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 05:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlhMn-0003IK-1l; Fri, 30 Jan 2026 00:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhMl-0003HU-SL
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:48:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vlhMj-0005WV-PJ
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 00:48:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769752101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dt0BDuzVfRRSqIs7smZlzqjo43w3EakTREOmpWDmELk=;
 b=ES/nzBpg/u77R1N61/mjBKjQfr1ToKlD6+46IvbiXi2Ha8q+sT811B0CmbUCCASpVP3OTp
 5ufKKVxPWcPKe5J9S8zV8S0FFHCVsCrXbku+YXsoAskyMPMWtQ98p8Lvi6IvlMXF8godSG
 FW15vxjxwT+wXxGawTi7PrHIRMIHfyU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-331-EMEZV-J_OB6emv7PXqe8lg-1; Fri,
 30 Jan 2026 00:48:17 -0500
X-MC-Unique: EMEZV-J_OB6emv7PXqe8lg-1
X-Mimecast-MFC-AGG-ID: EMEZV-J_OB6emv7PXqe8lg_1769752096
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38BFD1954B1B; Fri, 30 Jan 2026 05:48:16 +0000 (UTC)
Received: from osteffen-thinkpadx1carbongen12.rmtde.csb (unknown
 [10.45.226.150])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F3EFA19560A2; Fri, 30 Jan 2026 05:48:10 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eduardo Habkost <eduardo@habkost.net>, Ani Sinha <anisinha@redhat.com>,
 kvm@vger.kernel.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Joerg Roedel <joerg.roedel@amd.com>, Luigi Leonardi <leonardi@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v6 9/9] igvm: Fill MADT IGVM parameter field on x86_64
Date: Fri, 30 Jan 2026 06:47:14 +0100
Message-ID: <20260130054714.715928-10-osteffen@redhat.com>
In-Reply-To: <20260130054714.715928-1-osteffen@redhat.com>
References: <20260130054714.715928-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
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

Use the new acpi_build_madt_standalone() function to fill the MADT
parameter field.

The IGVM parameter can be consumed by Coconut SVSM [1], instead of
relying on the fw_cfg interface, which has caused problems before due to
unexpected access [2,3]. Using IGVM parameters is the default way for
Coconut SVSM across hypervisors; switching over would allow removing
specialized code paths for QEMU in Coconut.

Coconut SVSM needs to know the SMP configuration, but does not look at
any other ACPI data, nor does it interact with the PCI bus settings.
Since the MADT is static and not linked with other ACPI tables, it can
be supplied stand-alone like this.

Generating the MADT twice (during ACPI table building and IGVM processing)
seems acceptable, since there is no infrastructure to obtain the MADT
out of the ACPI table memory area.

In any case OVMF, which runs after SVSM has already been initialized,
will continue reading all ACPI tables via fw_cfg and provide fixed up
ACPI data to the OS as before without any changes.

The IGVM parameter handler is implemented for the i386 machine target
and stubbed for all others.

[1] https://github.com/coconut-svsm/svsm/pull/858
[2] https://gitlab.com/qemu-project/qemu/-/issues/2882
[3] https://github.com/coconut-svsm/svsm/issues/646

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm.c                |  2 ++
 include/system/igvm-internal.h |  5 +++++
 stubs/igvm.c                   |  6 ++++++
 target/i386/igvm.c             | 32 ++++++++++++++++++++++++++++++++
 4 files changed, 45 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index 3e7c0ea41d..b01a19ba46 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -128,6 +128,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_snp_id_block },
     { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
       qigvm_initialization_guest_policy },
+    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_madt },
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
diff --git a/include/system/igvm-internal.h b/include/system/igvm-internal.h
index 1d36519ab0..38004bd908 100644
--- a/include/system/igvm-internal.h
+++ b/include/system/igvm-internal.h
@@ -74,4 +74,9 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp);
 QIgvmParameterData*
 qigvm_find_param_entry(QIgvm *igvm, uint32_t parameter_area_index);
 
+/*
+ *  IGVM parameter handlers
+ */
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp);
+
 #endif
diff --git a/stubs/igvm.c b/stubs/igvm.c
index 17cd1e903e..47d5130d9d 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -12,6 +12,7 @@
 #include "qemu/osdep.h"
 
 #include "system/igvm.h"
+#include "system/igvm-internal.h"
 
 int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,
@@ -24,3 +25,8 @@ int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
 {
     return -1;
 }
+
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
+{
+    return -1;
+}
diff --git a/target/i386/igvm.c b/target/i386/igvm.c
index 457c253b03..f41b498b89 100644
--- a/target/i386/igvm.c
+++ b/target/i386/igvm.c
@@ -13,7 +13,9 @@
 
 #include "cpu.h"
 #include "hw/i386/e820_memory_layout.h"
+#include "hw/i386/acpi-build.h"
 #include "system/igvm.h"
+#include "system/igvm-internal.h"
 
 struct IgvmNativeVpContextX64 {
     uint64_t rax;
@@ -178,3 +180,33 @@ void qigvm_x86_bsp_reset(CPUX86State *env)
 
     qigvm_x86_load_context(bsp_context, env);
 }
+
+/*
+ * Process MADT IGVM parameter
+ */
+int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+    int result = 0;
+
+    /* Find the parameter area that should hold the MADT data */
+    param_entry = qigvm_find_param_entry(ctx, param->parameter_area_index);
+    if (param_entry == NULL) {
+        return 0;
+    }
+
+    GArray *madt = acpi_build_madt_standalone(ctx->machine_state);
+
+    if (madt->len <= param_entry->size) {
+        memcpy(param_entry->data, madt->data, madt->len);
+    } else {
+        error_setg(
+            errp,
+            "IGVM: MADT size exceeds parameter area defined in IGVM file");
+        result = -1;
+    }
+
+    g_array_free(madt, true);
+    return result;
+}
-- 
2.52.0


