Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA20FD39004
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 17:51:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg51C-0001qJ-Bb; Wed, 14 Jan 2026 12:50:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg517-0001pE-0d
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vg515-0008W4-09
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 12:50:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768413046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvCtcU3X4zMESaba3Y3b7w8sMF9sxZxPO6xg8lxyFYQ=;
 b=QxqBsTRmxADS1SV85dlLzYk/RbI5O+KnLol9uhcPAn7nYqxSuoFcjl+B0Y+C0wFEi476bv
 fz822JqgXv9Qe3CC6+4Zjli2P5QfyW47GsFkV7oMbrnX3QgJmS0dJ0Mi1B7EHx2KxWIkjl
 bzzALfM1D+BeTDrEduIZ6cZNko8zRBw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-564-tc7883kNPQ2uBFRJqFbSRA-1; Wed,
 14 Jan 2026 12:50:42 -0500
X-MC-Unique: tc7883kNPQ2uBFRJqFbSRA-1
X-Mimecast-MFC-AGG-ID: tc7883kNPQ2uBFRJqFbSRA_1768413041
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 429621800342; Wed, 14 Jan 2026 17:50:41 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.45.224.90])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FB4C1800665; Wed, 14 Jan 2026 17:50:35 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Joerg Roedel <joerg.roedel@amd.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Luigi Leonardi <leonardi@redhat.com>, Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH v4 4/5] igvm: Pass machine state to IGVM file processing
Date: Wed, 14 Jan 2026 18:50:06 +0100
Message-ID: <20260114175007.90845-5-osteffen@redhat.com>
In-Reply-To: <20260114175007.90845-1-osteffen@redhat.com>
References: <20260114175007.90845-1-osteffen@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Pass the full MachineState to the IGVM backend during file processing,
instead of just the ConfidentialGuestSupport struct (which is a member
of the MachineState).
This replaces the cgs parameter of qigvm_process_file() with the machine
state to make it available in the IGVM processing context.

We will use it later to generate MADT data there to pass to the guest
as IGVM parameter.

Signed-off-by: Oliver Steffen <osteffen@redhat.com>
---
 backends/igvm-cfg.c       |  2 +-
 backends/igvm.c           | 30 +++++++++++++++++-------------
 include/system/igvm-cfg.h |  3 ++-
 include/system/igvm.h     |  5 +++--
 target/i386/sev.c         |  3 +--
 5 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/backends/igvm-cfg.c b/backends/igvm-cfg.c
index c1b45401f4..1b35dc0a49 100644
--- a/backends/igvm-cfg.c
+++ b/backends/igvm-cfg.c
@@ -51,7 +51,7 @@ static void igvm_reset_hold(Object *obj, ResetType type)
 
     trace_igvm_reset_hold(type);
 
-    qigvm_process_file(igvm, ms->cgs, false, &error_fatal);
+    qigvm_process_file(igvm, ms, false, &error_fatal);
 }
 
 static void igvm_reset_exit(Object *obj, ResetType type)
diff --git a/backends/igvm.c b/backends/igvm.c
index ccb2f51cd9..cb2f997c87 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -11,6 +11,7 @@
 
 #include "qemu/osdep.h"
 
+#include "hw/boards.h"
 #include "qapi/error.h"
 #include "qemu/target-info-qapi.h"
 #include "system/igvm.h"
@@ -70,7 +71,7 @@ struct QEMU_PACKED sev_id_authentication {
  */
 typedef struct QIgvm {
     IgvmHandle file;
-    ConfidentialGuestSupport *cgs;
+    MachineState *machine_state;
     ConfidentialGuestSupportClass *cgsc;
     uint32_t compatibility_mask;
     unsigned current_header_index;
@@ -235,7 +236,8 @@ static void *qigvm_prepare_memory(QIgvm *ctx, uint64_t addr, uint64_t size,
         g_autofree char *region_name =
             g_strdup_printf("igvm.%X", region_identifier);
         igvm_pages = g_new0(MemoryRegion, 1);
-        if (ctx->cgs && ctx->cgs->require_guest_memfd) {
+        if (ctx->machine_state->cgs &&
+            ctx->machine_state->cgs->require_guest_memfd) {
             if (!memory_region_init_ram_guest_memfd(igvm_pages, NULL,
                                                     region_name, size, errp)) {
                 return NULL;
@@ -355,7 +357,7 @@ static int qigvm_process_mem_region(QIgvm *ctx, unsigned start_index,
      * If a confidential guest support object is provided then use it to set the
      * guest state.
      */
-    if (ctx->cgs) {
+    if (ctx->machine_state->cgs) {
         cgs_page_type =
             qigvm_type_to_cgs_type(page_type, flags->unmeasured, zero);
         if (cgs_page_type < 0) {
@@ -457,7 +459,7 @@ static int qigvm_directive_vp_context(QIgvm *ctx, const uint8_t *header_data,
 
     data = (uint8_t *)igvm_get_buffer(ctx->file, data_handle);
 
-    if (ctx->cgs) {
+    if (ctx->machine_state->cgs) {
         result = ctx->cgsc->set_guest_state(
             vp_context->gpa, data, igvm_get_buffer_size(ctx->file, data_handle),
             CGS_PAGE_TYPE_VMSA, vp_context->vp_index, errp);
@@ -525,7 +527,7 @@ static int qigvm_directive_parameter_insert(QIgvm *ctx,
              * If a confidential guest support object is provided then use it to
              * set the guest state.
              */
-            if (ctx->cgs) {
+            if (ctx->machine_state->cgs) {
                 result = ctx->cgsc->set_guest_state(param->gpa, region,
                                                     param_entry->size,
                                                     CGS_PAGE_TYPE_UNMEASURED, 0,
@@ -568,7 +570,7 @@ static int qigvm_directive_memory_map(QIgvm *ctx, const uint8_t *header_data,
     ConfidentialGuestMemoryMapEntry cgmm_entry;
     int retval = 0;
 
-    if (ctx->cgs && ctx->cgsc->get_mem_map_entry) {
+    if (ctx->machine_state->cgs && ctx->cgsc->get_mem_map_entry) {
         get_mem_map_entry = ctx->cgsc->get_mem_map_entry;
 
     } else if (target_arch() == SYS_EMU_TARGET_X86_64) {
@@ -690,7 +692,7 @@ static int qigvm_directive_required_memory(QIgvm *ctx,
     if (!region) {
         return -1;
     }
-    if (ctx->cgs) {
+    if (ctx->machine_state->cgs) {
         result =
             ctx->cgsc->set_guest_state(mem->gpa, region, mem->number_of_bytes,
                                        CGS_PAGE_TYPE_REQUIRED_MEMORY, 0, errp);
@@ -808,14 +810,14 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
                                                 sizeof(
                                                     IGVM_VHS_VARIABLE_HEADER));
             if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV_ES) &&
-                ctx->cgs) {
+                ctx->machine_state->cgs) {
                 if (ctx->cgsc->check_support(
                         CGS_PLATFORM_SEV_ES, platform->platform_version,
                         platform->highest_vtl, platform->shared_gpa_boundary)) {
                     compatibility_mask_sev_es = platform->compatibility_mask;
                 }
             } else if ((platform->platform_type == IGVM_PLATFORM_TYPE_SEV) &&
-                       ctx->cgs) {
+                       ctx->machine_state->cgs) {
                 if (ctx->cgsc->check_support(
                         CGS_PLATFORM_SEV, platform->platform_version,
                         platform->highest_vtl, platform->shared_gpa_boundary)) {
@@ -823,7 +825,7 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
                 }
             } else if ((platform->platform_type ==
                         IGVM_PLATFORM_TYPE_SEV_SNP) &&
-                       ctx->cgs) {
+                       ctx->machine_state->cgs) {
                 if (ctx->cgsc->check_support(
                         CGS_PLATFORM_SEV_SNP, platform->platform_version,
                         platform->highest_vtl, platform->shared_gpa_boundary)) {
@@ -896,7 +898,7 @@ IgvmHandle qigvm_file_init(char *filename, Error **errp)
     return igvm;
 }
 
-int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
+int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
                        bool onlyVpContext, Error **errp)
 {
     int32_t header_count;
@@ -917,8 +919,10 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
      * guest platform to perform extra processing, such as page measurement, on
      * IGVM directives.
      */
-    ctx.cgs = cgs;
-    ctx.cgsc = cgs ? CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(cgs) : NULL;
+    ctx.machine_state = machine_state;
+    ctx.cgsc = machine_state->cgs ?
+                   CONFIDENTIAL_GUEST_SUPPORT_GET_CLASS(machine_state->cgs) :
+                   NULL;
 
     /*
      * Check that the IGVM file provides configuration for the current
diff --git a/include/system/igvm-cfg.h b/include/system/igvm-cfg.h
index 7dc48677fd..51bf8d9844 100644
--- a/include/system/igvm-cfg.h
+++ b/include/system/igvm-cfg.h
@@ -12,6 +12,7 @@
 #ifndef QEMU_IGVM_CFG_H
 #define QEMU_IGVM_CFG_H
 
+#include "hw/boards.h"
 #include "qom/object.h"
 #include "hw/resettable.h"
 
@@ -42,7 +43,7 @@ typedef struct IgvmCfgClass {
      *
      * Returns 0 for ok and -1 on error.
      */
-    int (*process)(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
+    int (*process)(IgvmCfg *cfg, MachineState *machine_state,
                    bool onlyVpContext, Error **errp);
 
 } IgvmCfgClass;
diff --git a/include/system/igvm.h b/include/system/igvm.h
index ec2538daa0..ce023fbc9e 100644
--- a/include/system/igvm.h
+++ b/include/system/igvm.h
@@ -14,11 +14,12 @@
 
 #include "system/confidential-guest-support.h"
 #include "system/igvm-cfg.h"
+#include "hw/boards.h"
 #include "qapi/error.h"
 
 IgvmHandle qigvm_file_init(char *filename, Error **errp);
-int qigvm_process_file(IgvmCfg *igvm, ConfidentialGuestSupport *cgs,
-                      bool onlyVpContext, Error **errp);
+int qigvm_process_file(IgvmCfg *igvm, MachineState *machine_state,
+                       bool onlyVpContext, Error **errp);
 
 /* x86 native */
 int qigvm_x86_get_mem_map_entry(int index,
diff --git a/target/i386/sev.c b/target/i386/sev.c
index fd2dada013..91a55ebd81 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1892,8 +1892,7 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
          */
         if (x86machine->igvm) {
             if (IGVM_CFG_GET_CLASS(x86machine->igvm)
-                    ->process(x86machine->igvm, machine->cgs, true, errp) ==
-                -1) {
+                    ->process(x86machine->igvm, machine, true, errp) == -1) {
                 return -1;
             }
             /*
-- 
2.52.0


