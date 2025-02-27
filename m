Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCD77C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:37:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnewm-0003FT-AH; Thu, 27 Feb 2025 09:33:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <12feba5f.AXEAAGV4IjsAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd6@a3031119.bnc3.mailjet.com>)
 id 1tnewI-0001V8-Co
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:41 -0500
Received: from o40.p25.mailjet.com ([185.189.236.40])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <12feba5f.AXEAAGV4IjsAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd6@a3031119.bnc3.mailjet.com>)
 id 1tnewE-0006MI-JY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:32:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; q=dns/txt;
 d=randomman.co.uk; i=roy.hopkins@randomman.co.uk; s=mailjet; x=1740673946;
 h=message-id:mime-version:from:from:to:to:subject:subject:date:date:list-unsubscribe-post:list-unsubscribe:
 cc:feedback-id:in-reply-to:references:x-csa-complaints:x-mj-mid:x-mj-smtpguid:
 x-report-abuse-to:content-transfer-encoding;
 bh=nwE1kclYkP+QK9pDsgafUoK3A615CkGpPbibQPfdXJc=;
 b=G4KFdq9iTys61GmRQqOpr+wTRpEnCbCKMNg72gALRFtA7X7+vzPeME1Hg
 6/cWYnjyu0Pg78bdfWg8jiNM3ZmcM2OieDX/9m7TR3DHA/1L5knKZkIbYBrX
 vLThBfzr6xrkHPpF5oCsJHHy+rjwTxCAWI7tBHXZLXa7D31gG4i3NnSYMucO
 J0AGjL889gwnvDNSBakBB4RP+wUgGKEyzQSTltLqpgzMOA1p0EhFWvI9bp7z
 KmBeW+/jf8zYuaggOlzNALdVUp65UcawzPAOaudEPkp9AFG6YjiP1m1RYV/D
 UHlAhGrQz6an08Zv1fOB3GGQZ+F273tQC7Got8hWpdvtQ==
Message-Id: <12feba5f.AXEAAGV4IjsAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd6@mailjet.com>
MIME-Version: 1.0
From: Roy Hopkins <roy.hopkins@randomman.co.uk>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/16] backends/igvm: Handle policy for SEV guests
Date: Thu, 27 Feb 2025 14:29:32 +0000
List-Unsubscribe-Post: List-Unsubscribe=One-Click
Cc: Roy Hopkins <roy.hopkins@randomman.co.uk>, Paolo Bonzini
 <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Alistair Francis
 <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>, David Hildenbrand
 <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Tom Lendacky
 <thomas.lendacky@amd.com>, Michael Roth <michael.roth@amd.com>, Ani Sinha
 <anisinha@redhat.com>, Joerg Roedel <jroedel@suse.com>
Feedback-Id: 42.3031119.2785883:MJ
In-Reply-To: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
References: <cover.1740663410.git.roy.hopkins@randomman.co.uk>
X-CSA-Complaints: csa-complaints@eco.de
X-MJ-Mid: AXEAAGV4IjsAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd6jmW02K7TRA2IMvD6K1KWcgAqgls
X-MJ-SMTPGUID: 4e6e597c-6f01-4306-97d4-f37e739198da
X-REPORT-ABUSE-TO: Message sent by Mailjet please report to
 abuse@mailjet.com with a copy of the message
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=185.189.236.40;
 envelope-from=12feba5f.AXEAAGV4IjsAAAAAAAAAA9cBm3sAAYKJZwAAAAAAAC5ATwBnwHd6@a3031119.bnc3.mailjet.com;
 helo=o40.p25.mailjet.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Adds a handler for the guest policy initialization IGVM section and
builds an SEV policy based on this information and the ID block
directive if present. The policy is applied using by calling
'set_guest_policy()' on the ConfidentialGuestSupport object.

Signed-off-by: Roy Hopkins <roy.hopkins@randomman.co.uk>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Stefano Garzarella <sgarzare@redhat.com>
---
 backends/igvm.c | 138 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 138 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index cbe833db9d..7673e4a882 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -28,6 +28,33 @@ typedef struct QIgvmParameterData {
     uint32_t index;
 } QIgvmParameterData;
 
+/*
+ * Some directives are specific to particular confidential computing platforms.
+ * Define required types for each of those platforms here.
+ */
+
+/* SEV/SEV-ES/SEV-SNP */
+struct QEMU_PACKED sev_id_block {
+    uint8_t ld[48];
+    uint8_t family_id[16];
+    uint8_t image_id[16];
+    uint32_t version;
+    uint32_t guest_svn;
+    uint64_t policy;
+};
+
+struct QEMU_PACKED sev_id_authentication {
+    uint32_t id_key_alg;
+    uint32_t auth_key_algo;
+    uint8_t reserved[56];
+    uint8_t id_block_sig[512];
+    uint8_t id_key[1028];
+    uint8_t reserved2[60];
+    uint8_t id_key_sig[512];
+    uint8_t author_key[1028];
+    uint8_t reserved3[892];
+};
+
 /*
  * QIgvm contains the information required during processing
  * of a single IGVM file.
@@ -39,6 +66,17 @@ typedef struct QIgvm {
     uint32_t compatibility_mask;
     unsigned current_header_index;
     QTAILQ_HEAD(, QIgvmParameterData) parameter_data;
+    IgvmPlatformType platform_type;
+
+    /*
+     * SEV-SNP platforms can contain an ID block and authentication
+     * that should be verified by the guest.
+     */
+    struct sev_id_block *id_block;
+    struct sev_id_authentication *id_auth;
+
+    /* Define the guest policy for SEV guests */
+    uint64_t sev_policy;
 
     /* These variables keep track of contiguous page regions */
     IGVM_VHS_PAGE_DATA region_prev_page_data;
@@ -68,6 +106,11 @@ static int qigvm_directive_environment_info(QIgvm *ctx,
 static int qigvm_directive_required_memory(QIgvm *ctx,
                                            const uint8_t *header_data,
                                            Error **errp);
+static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
+                                  Error **errp);
+static int qigvm_initialization_guest_policy(QIgvm *ctx,
+                                       const uint8_t *header_data,
+                                       Error **errp);
 
 struct QIGVMHandler {
     uint32_t type;
@@ -92,6 +135,10 @@ static struct QIGVMHandler handlers[] = {
       qigvm_directive_environment_info },
     { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
       qigvm_directive_required_memory },
+    { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIVE,
+      qigvm_directive_snp_id_block },
+    { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
+      qigvm_initialization_guest_policy },
 };
 
 static int qigvm_handler(QIgvm *ctx, uint32_t type, Error **errp)
@@ -633,6 +680,70 @@ static int qigvm_directive_required_memory(QIgvm *ctx,
     return 0;
 }
 
+static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
+                                  Error **errp)
+{
+    const IGVM_VHS_SNP_ID_BLOCK *igvm_id =
+        (const IGVM_VHS_SNP_ID_BLOCK *)header_data;
+
+    if (!(igvm_id->compatibility_mask & ctx->compatibility_mask)) {
+        return 0;
+    }
+
+    if (ctx->id_block) {
+        error_setg(errp, "IGVM: Multiple ID blocks encountered "
+                            "in IGVM file.");
+        return -1;
+    }
+    ctx->id_block = g_new0(struct sev_id_block, 1);
+    ctx->id_auth = g_new0(struct sev_id_authentication, 1);
+
+    memcpy(ctx->id_block->family_id, igvm_id->family_id,
+            sizeof(ctx->id_block->family_id));
+    memcpy(ctx->id_block->image_id, igvm_id->image_id,
+            sizeof(ctx->id_block->image_id));
+    ctx->id_block->guest_svn = igvm_id->guest_svn;
+    ctx->id_block->version = 1;
+    memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
+
+    ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
+    memcpy(ctx->id_auth->id_block_sig, &igvm_id->id_key_signature,
+            sizeof(igvm_id->id_key_signature));
+
+    ctx->id_auth->auth_key_algo = igvm_id->author_key_algorithm;
+    memcpy(ctx->id_auth->id_key_sig, &igvm_id->author_key_signature,
+            sizeof(igvm_id->author_key_signature));
+
+    /*
+     * SEV and IGVM public key structure population are slightly different.
+     * See SEV Secure Nested Paging Firmware ABI Specification, Chapter 10.
+     */
+    *((uint32_t *)ctx->id_auth->id_key) = igvm_id->id_public_key.curve;
+    memcpy(&ctx->id_auth->id_key[4], &igvm_id->id_public_key.qx, 72);
+    memcpy(&ctx->id_auth->id_key[76], &igvm_id->id_public_key.qy, 72);
+
+    *((uint32_t *)ctx->id_auth->author_key) =
+        igvm_id->author_public_key.curve;
+    memcpy(&ctx->id_auth->author_key[4], &igvm_id->author_public_key.qx,
+            72);
+    memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
+            72);
+
+    return 0;
+}
+
+static int qigvm_initialization_guest_policy(QIgvm *ctx,
+                                       const uint8_t *header_data, Error **errp)
+{
+    const IGVM_VHS_GUEST_POLICY *guest =
+        (const IGVM_VHS_GUEST_POLICY *)header_data;
+
+    if (guest->compatibility_mask & ctx->compatibility_mask) {
+        ctx->sev_policy = guest->policy;
+    }
+    return 0;
+}
+
 static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
 {
     int32_t header_count;
@@ -702,12 +813,16 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     /* Choose the strongest supported isolation technology */
     if (compatibility_mask_sev_snp != 0) {
         ctx->compatibility_mask = compatibility_mask_sev_snp;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV_SNP;
     } else if (compatibility_mask_sev_es != 0) {
         ctx->compatibility_mask = compatibility_mask_sev_es;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV_ES;
     } else if (compatibility_mask_sev != 0) {
         ctx->compatibility_mask = compatibility_mask_sev;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_SEV;
     } else if (compatibility_mask != 0) {
         ctx->compatibility_mask = compatibility_mask;
+        ctx->platform_type = IGVM_PLATFORM_TYPE_NATIVE;
     } else {
         error_setg(
             errp,
@@ -717,6 +832,23 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     return 0;
 }
 
+static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
+{
+    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
+        int id_block_len = 0;
+        int id_auth_len = 0;
+        if (ctx->id_block) {
+            ctx->id_block->policy = ctx->sev_policy;
+            id_block_len = sizeof(struct sev_id_block);
+            id_auth_len = sizeof(struct sev_id_authentication);
+        }
+        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
+                                          ctx->id_block, id_block_len,
+                                          ctx->id_auth, id_auth_len, errp);
+    }
+    return 0;
+}
+
 static IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
@@ -815,12 +947,18 @@ int qigvm_process_file(IgvmCfg *cfg, ConfidentialGuestSupport *cgs,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
+    if (retval == 0) {
+        retval = qigvm_handle_policy(&ctx, errp);
+    }
+
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {
         g_free(parameter->data);
         parameter->data = NULL;
     }
+    g_free(ctx.id_block);
+    g_free(ctx.id_auth);
 
 cleanup:
     igvm_free(ctx.file);
-- 
2.43.0


