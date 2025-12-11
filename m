Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F89ED41C02
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Dec 2025 08:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTbrG-0001nc-80; Thu, 11 Dec 2025 03:17:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTbrE-0001nK-5G
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:17:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vTbrC-0000nt-IT
 for qemu-devel@nongnu.org; Thu, 11 Dec 2025 03:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765441022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VUw6KhdDlkAILHY2E/DfsZms1XeBroforyfbqStERgI=;
 b=eHVyqMxQMwI2RDBY4NuuBaQ/eDjHxC0vqN06jvrRewGIHubd+Iels9+xA/IkFZ+neQW8DD
 ktbOz+ZPkXbX7eSOBnDWsPQDhijUgxFxcq1LuDWSCZe7h8fT/XqMN7hSk1Iyhhjs7yAR67
 bPFzDJFSMt3I+l3EZy3xLk5lroXwegA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-HB2UMXwlPLeRFmHgfOYjcA-1; Thu,
 11 Dec 2025 03:15:43 -0500
X-MC-Unique: HB2UMXwlPLeRFmHgfOYjcA-1
X-Mimecast-MFC-AGG-ID: HB2UMXwlPLeRFmHgfOYjcA_1765440942
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3F8B31956054; Thu, 11 Dec 2025 08:15:42 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.225.89])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9310930001A2; Thu, 11 Dec 2025 08:15:36 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Joerg Roedel <joerg.roedel@amd.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH 3/3] igvm: Fill MADT IGVM parameter field
Date: Thu, 11 Dec 2025 09:15:17 +0100
Message-ID: <20251211081517.1546957-4-osteffen@redhat.com>
In-Reply-To: <20251211081517.1546957-1-osteffen@redhat.com>
References: <20251211081517.1546957-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
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

Use the new acpi_build_madt_standalone() function to fill the MADT
parameter field.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm-cfg.c       |  8 +++++++-
 backends/igvm.c           | 37 ++++++++++++++++++++++++++++++++++++-
 include/system/igvm-cfg.h |  4 ++--
 include/system/igvm.h     |  2 +-
 target/i386/sev.c         |  2 +-
 5 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index c1b45401f4..0a77f7b7a1 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -17,6 +17,7 @@
 #include "qom/object_interfaces.h"
 #include "hw/qdev-core.h"
 #include "hw/boards.h"
+#include "hw/i386/acpi-build.h"
 
 #include "trace.h"
 
@@ -48,10 +49,15 @@ static void igvm_reset_hold(Object *obj, ResetType type)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     IgvmCfg *igvm = IGVM_CFG(obj);
+    GArray *madt = NULL;
 
     trace_igvm_reset_hold(type);
 
-    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
+    madt = acpi_build_madt_standalone(ms);
+
+    qigvm_process_file(igvm, ms->cgs, false, madt, &error_fatal);
+
+    g_array_free(madt, true);
 }
 
 static void igvm_reset_exit(Object *obj, ResetType type)
diff --git a/backends/igvm.c b/backends/igvm.c
index a350c890cc..7e56b19b0a 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -93,6 +93,7 @@ typedef struct QIgvm {
     unsigned region_start_index;
     unsigned region_last_index;
     unsigned region_page_count;
+    GArray *madt;
 } QIgvm;
 
 static int qigvm_directive_page_data(QIgvm *ctx, const uint8_t *header_data,
@@ -120,6 +121,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
 static int qigvm_initialization_guest_policy(QIgvm *ctx,
                                        const uint8_t *header_data,
                                        Error **errp);
+static int qigvm_initialization_madt(QIgvm *ctx,
+                                     const uint8_t *header_data, Error **errp);
 
 struct QIGVMHandler {
     uint32_t type;
@@ -148,6 +151,8 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_snp_id_block },
     { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
       qigvm_initialization_guest_policy },
+    { IGVM_VHT_MADT, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_initialization_madt },
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
@@ -764,6 +769,34 @@ static int qigvm_initialization_guest_policy(QIgvm *ctx,
     return 0;
 }
 
+static int qigvm_initialization_madt(QIgvm *ctx,
+                                     const uint8_t *header_data, Error **errp)
+{
+    const IGVM_VHS_PARAMETER *param = (const IGVM_VHS_PARAMETER *)header_data;
+    QIgvmParameterData *param_entry;
+
+    if (ctx->madt == NULL) {
+        return 0;
+    }
+
+    /* Find the parameter area that should hold the device tree */
+    QTAILQ_FOREACH(param_entry, &ctx->parameter_data, next)
+    {
+        if (param_entry->index == param->parameter_area_index) {
+
+            if (ctx->madt->len > param_entry->size) {
+                error_setg(
+                    errp,
+                    "IGVM: MADT size exceeds parameter area defined in IGVM file");
+                return -1;
+            }
+            memcpy(param_entry->data, ctx->madt->data, ctx->madt->len);
+            break;
+        }
+    }
+    return 0;
+}
+
 static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
 {
     int32_t header_count;
@@ -892,7 +925,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
 }
 
 int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                       bool onlyVpContext, Error **errp)
+                       bool onlyVpContext, GArray *madt, Error **errp)
 {
     int32_t header_count;
     QIgvmParameterData *parameter;
@@ -915,6 +948,8 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
     ctx.cgs = cgs;
     ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
 
+    ctx.madt = madt;
+
     /*
      * Check that the IGVM file provides configuration for the current
      * platform
diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 7dc48677fd..1a04302beb 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -42,8 +42,8 @@ typedef struct IgvmCfgClass {
      *
      * Returns 0 for ok and -1 on error.
      */
-    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
-                   bool onlyVpContext, Error **errp);
+    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs, 
+                   bool onlyVpContext, GArray *madt, Error **errp);
 
 } IgvmCfgClass;
 
diff --git a/include/system/igvm.h b/include/system/igvm.h
index ec2538daa0..f2e580e4ee 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -18,7 +18,7 @@
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
 int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
-                      bool onlyVpContext, Error **errp);
+                      bool onlyVpContext, GArray *madt, Error **errp);
 
 /* x86 native */
 int qigvm_x86_get_mem_map_entry(int index,
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fd2dada013..ffeb9f52a2 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1892,7 +1892,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
          */
         if (x86machine->igvm) {
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
-                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
+                    ->process(x86machine->igvm, machine->cgs, true, NULL, errp) ==
                 -1) {
                 return -1;
             }
-- 
2.52.0


