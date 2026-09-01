Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBF6AC624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:10:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1LQy-0002Ut-AP; Tue, 01 Sep 2026 06:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LQv-0002U9-JB
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x1LQt-0000vE-8i
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 06:09:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788257374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ppz2K1vLw2zwdYGAd4h8De7d1adqi3oztEYlXl9z9H4=;
 b=Vt7aUfWTYNva/FH06MhLRmkPbIxj1dltDT1Py/xbP6ayLMNeT2WXcJEDE8wpihjQ/mvBpw
 VjIbV81EcrJukDapCiJTj42/F7h2ROtM4QlaZAYhlKXybc3QKp9/H4JHFQFWKHH29UJdsC
 gIInxEyXXmtQJvBcEPMhXQnM/WPQdG0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-163-oohbcMrUN9ejOFrdZzS7RQ-1; Tue, 01 Sept 2026 06:09:33 -0400
X-MC-Unique: oohbcMrUN9ejOFrdZzS7RQ-1
X-Mimecast-MFC-AGG-ID: oohbcMrUN9ejOFrdZzS7RQ_1788257372
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f2de3ba47so525857f8f.1
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 03:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788257372; x=1788862172; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ppz2K1vLw2zwdYGAd4h8De7d1adqi3oztEYlXl9z9H4=;
 b=ozrTvaTohAwfH+NwJkhKHI5yiHdPl1aJnO26u5GT5L15TXRgQZl4Af4o+HZ81CmB5J
 RQx9aH6G3N4KeUVixJQr646+QCVg/laleEtvzfaXHoVfmTeRpxQXgKBJuxCCALARsKDS
 vGIQATbvO3Q+j1NBJYz6zQRc0GPEVWAUbbOxZJ1ahBWn1IwNNmzH2V9J2SsYwXUw7dro
 RtOpnJVvWbetc1v1dq3Mgs0bt6Ar1ITDD2n9qmeBuULCzbIPo6Et35y1bbfTNbGU/2Y+
 MTnZwfbIMP0zoR35Rit17/P4Sr6dwNvodcOKBIcHK+m1VbBeFT3U8L85N62omraulLNI
 7yog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788257372; x=1788862172;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ppz2K1vLw2zwdYGAd4h8De7d1adqi3oztEYlXl9z9H4=;
 b=Vu4Gmede6ZILikzZBEQhqHAm1wF3vq6Qn7ArvAQEjy4uD5Mtg1jLYj3TKp54Kn6sE0
 6zFRq2wAnR8UuJLiat11PLXMOLMzYIIA3WVXAfd7ohbVNpR625NoYSJ5oq1jfDXxSDiY
 rVyU0VlMBB9pJt10lvxztijPAutCtFKdFKVi+pcslBo/1B/9Y9guFxCC0T/333E3BW6H
 SU2hg9f8MxCt2kkU52S8eU/8Fw7amEOrissOxy/XatNRpJN22/fj8L0xYnu8jDc/biV8
 GCy56lPUy1S8eJ+1fpI3vgragAk05YBbhtD4dvRIJqYPIE9xDXy1D3sJN6IwnseyRmEC
 ikhA==
X-Gm-Message-State: AFuF++nIpdLDrF77cxFx2Ww1i6uIIhp+A3yiu39wpl44AzpWynkT2/R4
 v8IWprqxo9O8C6a5ZFnYScc4Ig2j0MUQqH6nj7HmLzGsCyLJQjf9MwqGM7ab80eLWe2P/JLzSP1
 Fs1OXPbdux5AI1N18kmcNV7Qt7QWF1lKNA8caiTXKcA1NoePUNT9rIxs7
X-Gm-Gg: AYBFou1wjL6YV+rLDXtaboTpoSSZWyrCCqaukOQeKgBoEy56uM5Eqq8IX1CwRHNYjHH
 XZTslNezJZyWnBZjGM6sTiGrJAM1CCF/KBHvzjkewH5TowuVNFjwmWwecilxrJWnFzCHlBjvPtd
 9aOvtMwAO5jmqIAzZaUMn9LevAGmSPglvhIJdpUFgJqGFOXUeGf2ZOnyRxn2KLbck4B24PGPV3o
 XObacy7n4v6tf4mr3m+q8/Ps/2czK+m1tSqwCGR2WSi/hNTZozIgRj4SVWWbww6wAbf+Oqa0xiX
 rWWrNn/NPXsuJFnM5fU3bC2FCV7bnukmPcSvqWbg1jNU+3Ou0D9yQ7X3o6z0eSdSbUf95EN8mHH
 BpPsIv5eT80aEW14QR0CXXMCHC7VUyklAStiuU+8IpvKFxUfvmV1udb6ohcWuwhtRtpe8
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id
 ffacd0b85a97d-483ca4a6d9cmr36047407f8f.20.1788257371810; 
 Tue, 01 Sep 2026 03:09:31 -0700 (PDT)
X-Received: by 2002:a05:6000:2510:b0:483:ca4a:6b9d with SMTP id
 ffacd0b85a97d-483ca4a6d9cmr36047329f8f.20.1788257371394; 
 Tue, 01 Sep 2026 03:09:31 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48442d7c1c0sm3941620f8f.32.2026.09.01.03.09.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 03:09:30 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 01 Sep 2026 12:09:19 +0200
Subject: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
In-Reply-To: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

set_id_block only makes sense when the IGVM file contains an
IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
block and ID auth are populated. This avoids a no-op call to
set_id_block when no ID block is present.

The ID block embeds the guest policy, so the policy must be known by the
time the directive is handled. Process the initialization section (which
carries the GUEST_POLICY header) before the directive section, and
copy ctx->sev_policy into the ID block in the directive handler.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
 1 file changed, 38 insertions(+), 43 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 85de0d54ec..6545382546 100644
--- a/backends/igvm.c
+++ b/backends/igvm.c
@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
 
+    ctx->id_block->policy = ctx->sev_policy;
+
     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
     assert(sizeof(igvm_id->id_key_signature) <=
            sizeof(ctx->id_auth->id_block_sig));
@@ -805,6 +807,14 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
     memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
             72);
 
+    if (ctx->cgsc) {
+        return ctx->cgsc->set_id_block(ctx->id_block,
+                                       sizeof(struct sev_id_block),
+                                       ctx->id_auth,
+                                       sizeof(struct sev_id_authentication),
+                                       errp);
+    }
+
     return 0;
 }
 
@@ -958,23 +968,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
     return 0;
 }
 
-static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
-{
-    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
-        int id_block_len = 0;
-        int id_auth_len = 0;
-        if (ctx->id_block) {
-            ctx->id_block->policy = ctx->sev_policy;
-            id_block_len = sizeof(struct sev_id_block);
-            id_auth_len = sizeof(struct sev_id_authentication);
-        }
-
-        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
-                                       ctx->id_auth, id_auth_len, errp);
-    }
-    return 0;
-}
-
 IgvmHandle qigvm_file_init(char *filename, Error **errp)
 {
     IgvmHandle igvm;
@@ -1032,6 +1025,34 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         goto cleanup;
     }
 
+    /*
+     * Process the initialization section first so that the guest policy is
+     * known before the directive section is handled. The SNP ID block
+     * directive embeds the guest policy into the ID block, so the policy from
+     * the guest policy initialization header must be available by then.
+     */
+    header_count =
+        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
+    if (header_count < 0) {
+        error_setg(
+            errp,
+            "Invalid initialization header count in IGVM file. Error code: %X",
+            header_count);
+        goto cleanup;
+    }
+
+    for (ctx.current_header_index = 0;
+         ctx.current_header_index < (unsigned)header_count;
+         ctx.current_header_index++) {
+        IgvmVariableHeaderType type =
+            igvm_get_header_type(ctx.cfg->file,
+                                 IGVM_HEADER_SECTION_INITIALIZATION,
+                                 ctx.current_header_index);
+        if (qigvm_handler(&ctx, type, errp) < 0) {
+            goto cleanup;
+        }
+    }
+
     header_count = igvm_header_count(ctx.cfg->file,
                                      IGVM_HEADER_SECTION_DIRECTIVE);
     if (header_count <= 0) {
@@ -1065,28 +1086,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
         goto cleanup_parameters;
     }
 
-    header_count =
-        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
-    if (header_count < 0) {
-        error_setg(
-            errp,
-            "Invalid initialization header count in IGVM file. Error code: %X",
-            header_count);
-        goto cleanup_parameters;
-    }
-
-    for (ctx.current_header_index = 0;
-         ctx.current_header_index < (unsigned)header_count;
-         ctx.current_header_index++) {
-        IgvmVariableHeaderType type =
-            igvm_get_header_type(ctx.cfg->file,
-                                 IGVM_HEADER_SECTION_INITIALIZATION,
-                                 ctx.current_header_index);
-        if (qigvm_handler(&ctx, type, errp) < 0) {
-            goto cleanup_parameters;
-        }
-    }
-
     /*
      * Contiguous pages of data with compatible flags are grouped together in
      * order to reduce the number of memory regions we create. Make sure the
@@ -1094,10 +1093,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
      */
     retval = qigvm_process_mem_page(&ctx, NULL, errp);
 
-    if (retval == 0) {
-        retval = qigvm_handle_policy(&ctx, errp);
-    }
-
 cleanup_parameters:
     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
     {

-- 
2.55.0


