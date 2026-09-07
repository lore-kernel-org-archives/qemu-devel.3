Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4A28C79FA1
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2026 15:57:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3bic-0006pd-5U; Mon, 07 Sep 2026 11:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3bia-0006pH-2f
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x3biX-0000uK-Th
 for qemu-devel@nongnu.org; Mon, 07 Sep 2026 11:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788796629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8EQ1Hp/5/EcMqD759ADXm85y9O+auBS8uFJpNUQOG/o=;
 b=VLIFJenqj0WSljKs8QlCauDeOeY/wALOsF1ILJktvPChoWzo8W7Qiw4WyqvrE0Fe1O4ciM
 jeu0xnhk3Tqv4BSh+3/aVXSfeNjIdhcTp06z/XJxgwqDQJIJ2Yo4uOLHAb1odOeNUQF/7y
 cgjZMdjMOkQcG4pGAT/dLLZKoPyB7To=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-q9j_E5JDPzOXGrIHelw2oQ-1; Mon, 07 Sep 2026 11:57:07 -0400
X-MC-Unique: q9j_E5JDPzOXGrIHelw2oQ-1
X-Mimecast-MFC-AGG-ID: q9j_E5JDPzOXGrIHelw2oQ_1788796627
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-485866e0066so2036940f8f.2
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788796626; x=1789401426; darn=nongnu.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8EQ1Hp/5/EcMqD759ADXm85y9O+auBS8uFJpNUQOG/o=;
 b=tAph4QU2nXAmp9gRMm5D36kp3t8xC+v/jXdR26ITXOAqXqmC3kBqjxW/PFxxH2/2O4
 LF4/a+f1l3wwdhpeLxGZJSOIMMvcDdXWv/mfI1OBYtNoHxjEn32wcNf8AL1ZwpKLHqup
 r758Mdybz4qd2fMhO0UTLHda0QCWemN9bO9kEbfTr4MDmq89vt9e967AhypFBMH08rqv
 O5G4UQI0iYOONhE+JwzQM2xQmharygc+N1m2nu/BO5kU7sYPPXhy7OZ4kU8vOMaTng2m
 c2UKMP/CirsAJjer2SrH5+AvkPxz6i1G5V5KoJVfGA/g/sO8pvGvupBTUcZ4Z9R8Eb1Z
 PYPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788796626; x=1789401426;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8EQ1Hp/5/EcMqD759ADXm85y9O+auBS8uFJpNUQOG/o=;
 b=qIpATHq3y75QP3CkbUFQYmOsXjxabEakFIwGTzeK4iKV8aOjZfVHCOU1ji8Jjvo9EI
 nKSmLDFyJM36HPk/5PGkxVVp4KuoE6PJZ5y3U9l6Q2x1tSZNuZoSRM7sek/ahvP8axwa
 J5wYgZDn7pdiVcw5DzK6YCakOjvTwdofeduJXCLrPWK/5ptIOVKJSdTVumHv+LH0ETkR
 luCRdmqszM8WRaEnHXETQKWIM8CqbI+xJvFgQoRY+CoBC1GcTDlE2N/C97BZYwN9sbTo
 pyUoI9WHOZ7wQp0Q4bhWxcJyylM7/cUkuJszerY2XL+zmxAlzomc3pCYzEYlglnjcTPr
 WvVA==
X-Gm-Message-State: AFuF++nMgIkMyCI4RN+AMXVyPtQW6CQauvZ/6ufsAAcAmYg62qxIanND
 ZdYp9ZNaqjEvcewfODL0yZJwMGcodpTistox3jiBm+WZ7dxsfmjIou2FtfvaIj5sfpK+fEA4nCo
 lpfjh8gMmvTpegDoS9Fpcrk13GidFPbFXmLMB8JyZ87sHLIqWYQzcXnrr/k8qIUFom7qfFcYOjb
 wpK1M5vgmm4jKhKS1OdfQhVdQ2JtWn+HWvfR4/W1Y2XH0=
X-Gm-Gg: AYBFou289QusdApWnwQS5TN8lrYs1JBsUijcgA53e0mMNh1LIHQaRj8KjBsOXBYBB5W
 Lte13/60B6ryzOnEVeG9YtmqZJWiyMbYz5gTPWKpwB/abWeiWakdTHgmZ8we1IQoEp3k4dTw0Ez
 QueOi8HfWH3KGGZSb0zHV6u5FpGrsB8GmfSHZMGXN5mGHjvsjx+LpTPqP7H5Z2y37GjmOj52cw3
 uphqcrNHiQAcVfkLvy38a/Q8+hmI0TqmwoGIKUvJYiS3fkUCu6ATMqYq8/NfskTdwPytGUL4bW7
 tslQfbh5ocZxK2QronyfzrqIhaKo8JqkskmMMuwTY9VapnBUBQtyWDhp/rrMH+Yfa/AN42WzzzV
 wBZgIBNuR3Hc9gPSLEK4GPpRqbfoYubBrxq9uQuKk/3R032HmHnw5fSDVjOj5iBrMW498
X-Received: by 2002:a05:600c:c162:b0:49d:16dc:e721 with SMTP id
 5b1f17b1804b1-49d16dce7aamr27511855e9.24.1788796626641; 
 Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
X-Received: by 2002:a05:600c:c162:b0:49d:16dc:e721 with SMTP id
 5b1f17b1804b1-49d16dce7aamr27511415e9.24.1788796626179; 
 Mon, 07 Sep 2026 08:57:06 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf755c22esm320477955e9.0.2026.09.07.08.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 08:57:05 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Mon, 07 Sep 2026 17:56:58 +0200
Subject: [PATCH v2 2/5] igvm: move set_id_block call into the SNP ID block
 directive handler
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-fix_igvm_policy-v2-2-c8c50f1dbfda@redhat.com>
References: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
In-Reply-To: <20260907-fix_igvm_policy-v2-0-c8c50f1dbfda@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>, kvm@vger.kernel.org, 
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
IGVM_VHT_SNP_ID_BLOCK directive. Move the call from qigvm_handle_policy
(which continues to handle the set_guest_policy call) into
qigvm_directive_snp_id_block, where the ID block and ID auth are
populated. This avoids a no-op call to set_id_block when no ID block
is present.

The ID block embeds the guest policy, so the policy must be known by the
time the directive is handled. Process the initialization section (which
carries the GUEST_POLICY header) before the directive section, and
copy ctx->sev_policy into the ID block in the directive handler.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 backends/igvm.c | 80 ++++++++++++++++++++++++++++-----------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/backends/igvm.c b/backends/igvm.c
index 99304d6467..521560822a 100644
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
 
@@ -961,24 +971,8 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
 static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
 {
     if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
-        int id_block_len = 0;
-        int id_auth_len = 0;
-        int retval;
-
-        if (ctx->id_block) {
-            ctx->id_block->policy = ctx->sev_policy;
-            id_block_len = sizeof(struct sev_id_block);
-            id_auth_len = sizeof(struct sev_id_authentication);
-        }
-
-        retval = ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
-                                             errp);
-        if (retval < 0) {
-            return retval;
-        }
-
-        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
-                                       ctx->id_auth, id_auth_len, errp);
+        return ctx->cgsc->set_guest_policy(GUEST_POLICY_SEV, ctx->sev_policy,
+                                           errp);
     }
     return 0;
 }
@@ -1040,6 +1034,34 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
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
@@ -1073,28 +1095,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
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

-- 
2.55.0


