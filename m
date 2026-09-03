Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF848C61DD3
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 12:58:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2710-0001Rf-Qr; Thu, 03 Sep 2026 08:58:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x270z-0001RF-D2
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:58:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1x270x-0005sP-LT
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 08:58:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788440279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dFw4kmpiXgnJgYg/MdJcXbpa7WDv+OilNPqzeDo4f/c=;
 b=AaH+IgmLdgWYqBptl3CDT9Pc+ucrKSataOh02dLxKLuLOjnNPGXeM5gVKIlaLUHTekNRLQ
 7ljGfyJJ9QLOANQTUqK3qMwT12P2xQSuWk8nQrZp1rGDR/tm9fZmfOEUu0Fipw8Uqgo3Jm
 dtyszQJPtZYTvMM4caiRy+ZUgdbHrLc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-KmE4jsOCPd-RSCFmgF8iMA-1; Thu, 03 Sep 2026 08:57:57 -0400
X-MC-Unique: KmE4jsOCPd-RSCFmgF8iMA-1
X-Mimecast-MFC-AGG-ID: KmE4jsOCPd-RSCFmgF8iMA_1788440276
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso6090775e9.1
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 05:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788440276; x=1789045076; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=dFw4kmpiXgnJgYg/MdJcXbpa7WDv+OilNPqzeDo4f/c=;
 b=Yzp6gIrci4l7w6SzigkMb8uhLrTKvOjHmTG7yhHH7eCIbI71PCaXM6jIMjlNuhWdWz
 RI1Ru878tbRHisny44vwppvsu8QwkoUVCf6P0Fq0aQKtdfrYnM42XxFfbT1wmBIoq1tg
 iNZnkp0AlGdJkdEfnH6iu95pPPYrqByJwsBneObWTeiRyPHr1R8+gDsda+TdlyKHB+IC
 MzH5nO/yenOPliWbMotqTMsnhkVv1xm54pZIIBhDemsmW6UPuNcA85enAIDntnbmEFhk
 25XPIgvBp60QQqGK+vVroAEtt6SugXe3y9A0nhr3LYFGsYmIOz0cpyFq00o94kfUAfRQ
 ZW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788440276; x=1789045076;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=dFw4kmpiXgnJgYg/MdJcXbpa7WDv+OilNPqzeDo4f/c=;
 b=f+m+mAfDrwOePbEC6jCCcSRojVnlRQdFiL7Gu/NIJMzjlr3ATG9XBCnqp5kmXfuqvR
 nsG7tUwrtfAuldXsPOpAUBaPW1+8dNAThiovMspyT9Tzs+IVd6QCLdhFCRdk17bNtI7G
 CnTfnaiWPN8C5PzmI3b79k/bVZwwmiy/d6a6ltmszsl3F+paoHvoLU0Gt/5r4LzHc6h3
 Mz/XCvAysaJachNru6uFUWwMQgthf1qzEc8Z6lffgVoGaVsEHWHZl3QLSZFisZqfHxhc
 3+xZF8KL8b6El4vif6XQa3JFZXSs1DIIhqvm+i1812phtyfdgiO3CQ4dwsFLQ7BNqqHL
 c0MA==
X-Gm-Message-State: AFuF++kLsuGZ9IK3RGx5C6cIS3rCfvKb0wz5N/lb+GBU3t+GYx2IcRD7
 YGtTXUd+2lt4ZxXdtKxdhFZok6M/lM9PWwwKf9z6F6WTKcNGvXoEg0XpxEtAPcwrmMoz409B58v
 EXpXzoTFMuw7yvIIqDGgjd/blUhwYFM+15vb0TW+wGubttJd/5Xh5CQ15
X-Gm-Gg: AYBFou0rJejpqiBWz1aWgbL9gEbIGBbB6y9Evk4qxsisfPA4FnfX5i5d6DuQK691+ox
 q8YIi30BSuMTtCjL5Fv0bG1wMuyinsqiGCD9zKHQDxYd9p1nYw+ffAehIILHSMYIe7vF9jVSAv9
 E0YlOfxU7YLyEsgYYZlFhZaxebPDBmSeGM5+Jj++si/F5v7OyrtUE8Qj5yVV9Cf/MrW3xXLVy5b
 h8zkMR6Jujw2TkFg8wZ5lBTdEEwUw7NTaSXbPfOpzCFjW5Z4trLEwRn7RqjclSPA2wKpSvUxiuT
 A1fBjmLdAFq1gVApuT3FDDPwwXH46w0+vsvYe1YukDCZxleopNl08dcMxRA6ELlfJWv2ZJx/V9L
 Lh56IImNdjujrnD+TvBz+/TkK85URM7avLI7dY0YV467aeg==
X-Received: by 2002:a05:600c:46c6:b0:49c:799a:177b with SMTP id
 5b1f17b1804b1-49cf1576df1mr34980965e9.2.1788440276349; 
 Thu, 03 Sep 2026 05:57:56 -0700 (PDT)
X-Received: by 2002:a05:600c:46c6:b0:49c:799a:177b with SMTP id
 5b1f17b1804b1-49cf1576df1mr34980545e9.2.1788440275769; 
 Thu, 03 Sep 2026 05:57:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-53-30-11.retail.telecomitalia.it.
 [79.53.30.11]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce58da3acsm259684435e9.0.2026.09.03.05.57.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 05:57:55 -0700 (PDT)
Date: Thu, 3 Sep 2026 14:57:44 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Luigi Leonardi <leonardi@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Zhao Liu <zhao1.liu@intel.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org
Subject: Re: [PATCH 2/4] igvm: move set_id_block call into the SNP ID block
 directive handler
Message-ID: <aplM8ZVCrsjuELHT@sgarzare-redhat>
References: <20260901-fix_igvm_policy-v1-0-e93a6cf8c5ac@redhat.com>
 <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260901-fix_igvm_policy-v1-2-e93a6cf8c5ac@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Sep 01, 2026 at 12:09:19PM +0200, Luigi Leonardi wrote:
>set_id_block only makes sense when the IGVM file contains an
>IGVM_VHT_SNP_ID_BLOCK directive. Move the call from the removed
>qigvm_handle_policy into qigvm_directive_snp_id_block, where the ID
>block and ID auth are populated. This avoids a no-op call to
>set_id_block when no ID block is present.
>
>The ID block embeds the guest policy, so the policy must be known by the
>time the directive is handled. Process the initialization section (which
>carries the GUEST_POLICY header) before the directive section, and
>copy ctx->sev_policy into the ID block in the directive handler.
>
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> backends/igvm.c | 81 +++++++++++++++++++++++++++------------------------------
> 1 file changed, 38 insertions(+), 43 deletions(-)
>
>diff --git a/backends/igvm.c b/backends/igvm.c
>index 85de0d54ec..6545382546 100644
>--- a/backends/igvm.c
>+++ b/backends/igvm.c
>@@ -778,6 +778,8 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>     ctx->id_block->version = IGVM_SEV_ID_BLOCK_VERSION;
>     memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
>
>+    ctx->id_block->policy = ctx->sev_policy;

Is it fine to copy the sev_policy in the id_block in any case?

I mean, what happen if IGVM_VHT_GUEST_POLICY is not in the IGVM file, so 
IIUC sev_policy is 0, but the user set the policy by the CLI?

Maybe this was pre-existing and handled in the next patches.

Thanks,
Stefano

>+
>     ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
>     assert(sizeof(igvm_id->id_key_signature) <=
>            sizeof(ctx->id_auth->id_block_sig));
>@@ -805,6 +807,14 @@ static int qigvm_directive_snp_id_block(QIgvm *ctx, const uint8_t *header_data,
>     memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
>             72);
>
>+    if (ctx->cgsc) {
>+        return ctx->cgsc->set_id_block(ctx->id_block,
>+                                       sizeof(struct sev_id_block),
>+                                       ctx->id_auth,
>+                                       sizeof(struct sev_id_authentication),
>+                                       errp);
>+    }
>+
>     return 0;
> }
>
>@@ -958,23 +968,6 @@ static int qigvm_supported_platform_compat_mask(QIgvm *ctx, Error **errp)
>     return 0;
> }
>
>-static int qigvm_handle_policy(QIgvm *ctx, Error **errp)
>-{
>-    if (ctx->platform_type == IGVM_PLATFORM_TYPE_SEV_SNP) {
>-        int id_block_len = 0;
>-        int id_auth_len = 0;
>-        if (ctx->id_block) {
>-            ctx->id_block->policy = ctx->sev_policy;
>-            id_block_len = sizeof(struct sev_id_block);
>-            id_auth_len = sizeof(struct sev_id_authentication);
>-        }
>-
>-        return ctx->cgsc->set_id_block(ctx->id_block, id_block_len,
>-                                       ctx->id_auth, id_auth_len, errp);
>-    }
>-    return 0;
>-}
>-
> IgvmHandle qigvm_file_init(char *filename, Error **errp)
> {
>     IgvmHandle igvm;
>@@ -1032,6 +1025,34 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>         goto cleanup;
>     }
>
>+    /*
>+     * Process the initialization section first so that the guest policy is
>+     * known before the directive section is handled. The SNP ID block
>+     * directive embeds the guest policy into the ID block, so the policy from
>+     * the guest policy initialization header must be available by then.
>+     */
>+    header_count =
>+        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
>+    if (header_count < 0) {
>+        error_setg(
>+            errp,
>+            "Invalid initialization header count in IGVM file. Error code: %X",
>+            header_count);
>+        goto cleanup;
>+    }
>+
>+    for (ctx.current_header_index = 0;
>+         ctx.current_header_index < (unsigned)header_count;
>+         ctx.current_header_index++) {
>+        IgvmVariableHeaderType type =
>+            igvm_get_header_type(ctx.cfg->file,
>+                                 IGVM_HEADER_SECTION_INITIALIZATION,
>+                                 ctx.current_header_index);
>+        if (qigvm_handler(&ctx, type, errp) < 0) {
>+            goto cleanup;
>+        }
>+    }
>+
>     header_count = igvm_header_count(ctx.cfg->file,
>                                      IGVM_HEADER_SECTION_DIRECTIVE);
>     if (header_count <= 0) {
>@@ -1065,28 +1086,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>         goto cleanup_parameters;
>     }
>
>-    header_count =
>-        igvm_header_count(ctx.cfg->file, IGVM_HEADER_SECTION_INITIALIZATION);
>-    if (header_count < 0) {
>-        error_setg(
>-            errp,
>-            "Invalid initialization header count in IGVM file. Error code: %X",
>-            header_count);
>-        goto cleanup_parameters;
>-    }
>-
>-    for (ctx.current_header_index = 0;
>-         ctx.current_header_index < (unsigned)header_count;
>-         ctx.current_header_index++) {
>-        IgvmVariableHeaderType type =
>-            igvm_get_header_type(ctx.cfg->file,
>-                                 IGVM_HEADER_SECTION_INITIALIZATION,
>-                                 ctx.current_header_index);
>-        if (qigvm_handler(&ctx, type, errp) < 0) {
>-            goto cleanup_parameters;
>-        }
>-    }
>-
>     /*
>      * Contiguous pages of data with compatible flags are grouped together in
>      * order to reduce the number of memory regions we create. Make sure the
>@@ -1094,10 +1093,6 @@ int qigvm_process_file(IgvmCfg *cfg, MachineState *machine_state,
>      */
>     retval = qigvm_process_mem_page(&ctx, NULL, errp);
>
>-    if (retval == 0) {
>-        retval = qigvm_handle_policy(&ctx, errp);
>-    }
>-
> cleanup_parameters:
>     QTAILQ_FOREACH(parameter, &ctx.parameter_data, next)
>     {
>
>-- 
>2.55.0
>


