Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE643C2BA1A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2024 14:31:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKfH9-0001GJ-2s; Fri, 21 Jun 2024 10:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfH6-0001EZ-Lb
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:30:00 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <roy.hopkins@suse.com>)
 id 1sKfH4-0005iI-G6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 10:30:00 -0400
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4263D1FB81;
 Fri, 21 Jun 2024 14:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZVyb+P+ftZpEAFUBvo8284ttBOJuMpP/XlRq9AFEYs=;
 b=gdXhx1s4LxZSiQDjh9mVzek915K70041LUEW+oC799tWwXPgH3GnNWA2m/30VvL8aaKYby
 zGKmRz605xjFEnxM4pmUponOvz/x+8aRDUn3A+ebJHwGzmSeOLUpY6Gw+fC8HhOKKKJrgT
 wH/46aNkj9oXswHwCaHMGpDTibp4TSQ=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=gdXhx1s4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1718980197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bZVyb+P+ftZpEAFUBvo8284ttBOJuMpP/XlRq9AFEYs=;
 b=gdXhx1s4LxZSiQDjh9mVzek915K70041LUEW+oC799tWwXPgH3GnNWA2m/30VvL8aaKYby
 zGKmRz605xjFEnxM4pmUponOvz/x+8aRDUn3A+ebJHwGzmSeOLUpY6Gw+fC8HhOKKKJrgT
 wH/46aNkj9oXswHwCaHMGpDTibp4TSQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8029413ACD;
 Fri, 21 Jun 2024 14:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iLswHWSOdWbwKQAAD6G6ig
 (envelope-from <roy.hopkins@suse.com>); Fri, 21 Jun 2024 14:29:56 +0000
From: Roy Hopkins <roy.hopkins@suse.com>
To: qemu-devel@nongnu.org
Cc: Roy Hopkins <roy.hopkins@suse.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?q?J=C3=B6rg=20Roedel?= <jroedel@suse.com>
Subject: [PATCH v3 13/15] backends/igvm: Handle policy for SEV guests
Date: Fri, 21 Jun 2024 15:29:16 +0100
Message-ID: <96b230d5a47e3dbb357a09b27c0f5cb0ce2dec09.1718979106.git.roy.hopkins@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1718979106.git.roy.hopkins@suse.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4263D1FB81
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 DWL_DNSWL_MED(-2.00)[suse.com:dkim]; SUSPICIOUS_RECIPS(1.50)[];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWELVE(0.00)[19];
 ARC_NA(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FREEMAIL_CC(0.00)[suse.com,redhat.com,gmail.com,habkost.net,alistair23.me,amd.com];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TAGGED_RCPT(0.00)[]; DKIM_TRACE(0.00)[suse.com:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RLgjcjk3igk5en59wt86eb8xw3)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=roy.hopkins@suse.com; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
---
 backends/igvm.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/backends/igvm.c b/backends/igvm.c
index b6b7d30a3f..bb8038f9e9 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -28,6 +28,33 @@ typedef struct IgvmParameterData {
     uint32_t index;
 } IgvmParameterData;
 
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
  * QemuIgvm contains the information required during processing
  * of a single IGVM file.
@@ -39,6 +66,17 @@ typedef struct QemuIgvm {
     uint32_t compatibility_mask;
     unsigned current_header_index;
     QTAILQ_HEAD(, IgvmParameterData) parameter_data;
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
@@ -64,6 +102,11 @@ static int directive_environment_info(QemuIgvm *ctx, const uint8_t *header_data,
                                       Error **errp);
 static int directive_required_memory(QemuIgvm *ctx, const uint8_t *header_data,
                                      Error **errp);
+static int directive_snp_id_block(QemuIgvm *ctx, const uint8_t *header_data,
+                                  Error **errp);
+static int initialization_guest_policy(QemuIgvm *ctx,
+                                       const uint8_t *header_data,
+                                       Error **errp);
 
 struct IGVMHandler {
     uint32_t type;
@@ -87,6 +130,10 @@ static struct IGVMHandler handlers[] = {
       directive_environment_info },
     { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
       directive_required_memory },
+    { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIVE,
+      directive_snp_id_block },
+    { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
+      initialization_guest_policy },
 };
 
 static int handler(QemuIgvm *ctx, uint32_t type, Error **errp)
@@ -619,6 +666,68 @@ static int directive_required_memory(QemuIgvm *ctx, const uint8_t *header_data,
     return 0;
 }
 
+static int directive_snp_id_block(QemuIgvm *ctx, const uint8_t *header_data,
+                                  Error **errp)
+{
+    const IGVM_VHS_SNP_ID_BLOCK *igvm_id =
+        (const IGVM_VHS_SNP_ID_BLOCK *)header_data;
+
+    if (ctx->compatibility_mask & igvm_id->compatibility_mask) {
+        if (ctx->id_block) {
+            error_setg(errp, "IGVM: Multiple ID blocks encountered "
+                             "in IGVM file.");
+            return -1;
+        }
+        ctx->id_block = g_malloc0(sizeof(struct sev_id_block));
+        ctx->id_auth = g_malloc0(sizeof(struct sev_id_authentication));
+
+        memcpy(ctx->id_block->family_id, igvm_id->family_id,
+               sizeof(ctx->id_block->family_id));
+        memcpy(ctx->id_block->image_id, igvm_id->image_id,
+               sizeof(ctx->id_block->image_id));
+        ctx->id_block->guest_svn = igvm_id->guest_svn;
+        ctx->id_block->version = 1;
+        memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
+
+        ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
+        memcpy(ctx->id_auth->id_block_sig, &igvm_id->id_key_signature,
+               sizeof(igvm_id->id_key_signature));
+
+        ctx->id_auth->auth_key_algo = igvm_id->author_key_algorithm;
+        memcpy(ctx->id_auth->id_key_sig, &igvm_id->author_key_signature,
+               sizeof(igvm_id->author_key_signature));
+
+        /*
+         * SEV and IGVM public key structure population are slightly different.
+         * See SEV Secure Nested Paging Firmware ABI Specification, Chapter 10.
+         */
+        *((uint32_t *)ctx->id_auth->id_key) = igvm_id->id_public_key.curve;
+        memcpy(&ctx->id_auth->id_key[4], &igvm_id->id_public_key.qx, 72);
+        memcpy(&ctx->id_auth->id_key[76], &igvm_id->id_public_key.qy, 72);
+
+        *((uint32_t *)ctx->id_auth->author_key) =
+            igvm_id->author_public_key.curve;
+        memcpy(&ctx->id_auth->author_key[4], &igvm_id->author_public_key.qx,
+               72);
+        memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
+               72);
+    }
+
+    return 0;
+}
+
+static int initialization_guest_policy(QemuIgvm *ctx,
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
 static int supported_platform_compat_mask(QemuIgvm *ctx, Error **errp)
 {
     int32_t header_count;
@@ -688,12 +797,16 @@ static int supported_platform_compat_mask(QemuIgvm *ctx, Error **errp)
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
@@ -703,6 +816,23 @@ static int supported_platform_compat_mask(QemuIgvm *ctx, Error **errp)
     return 0;
 }
 
+static int handle_policy(QemuIgvm *ctx, Error **errp)
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
 static IgvmHandle igvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
@@ -801,12 +931,18 @@ int igvm_process_file(IgvmCfgState *cfg, ConfidentialGuestSupport *cgs,
      */
     retval = process_mem_page(&ctx, NULL, errp);
 
+    if (retval == 0) {
+        retval = handle_policy(&ctx, errp);
+    }
+
 cleanup:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {
         g_free(parameter->data);
         parameter->data = NULL;
     }
+    g_free(ctx.id_block);
+    g_free(ctx.id_auth);
 
     return retval;
 }
-- 
2.43.0


