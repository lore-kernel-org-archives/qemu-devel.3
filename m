Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA89C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLl7n-00029z-Gx; Mon, 24 Jun 2024 10:56:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLl7l-00029i-H7
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:56:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLl7h-0002GV-Jh
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719241008;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=7TZKAYtp1S/uqxJsMj113wtrxgsG7yz6pgX2GrnSybs=;
 b=Q65dPWeMb5rdZhi/Ie6PNdsiocx6TFP5zpYDYPUTkIBUKxI8Z208ez0Y9SIXtlJCkOu+Q5
 6nk8Vw7YmAjYUw767jIs8WIUO7hKmkmK5FfOljuFn3sTNZAuJ8SVojt+s801L4RAM58ap/
 WjjUT7KaQMK2Y80Dk9NKuIiJ40+q3C0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-333-XXWn_hlKPGCllCQP-6K8Hg-1; Mon,
 24 Jun 2024 10:56:43 -0400
X-MC-Unique: XXWn_hlKPGCllCQP-6K8Hg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 425091955F0E; Mon, 24 Jun 2024 14:56:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 69BAC1956048; Mon, 24 Jun 2024 14:56:34 +0000 (UTC)
Date: Mon, 24 Jun 2024 15:56:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Roy Hopkins <roy.hopkins@suse.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sergio Lopez <slp@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>,
 =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.com>
Subject: Re: [PATCH v3 13/15] backends/igvm: Handle policy for SEV guests
Message-ID: <ZnmJHgslZYmA12S-@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <96b230d5a47e3dbb357a09b27c0f5cb0ce2dec09.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <96b230d5a47e3dbb357a09b27c0f5cb0ce2dec09.1718979106.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jun 21, 2024 at 03:29:16PM +0100, Roy Hopkins wrote:
> Adds a handler for the guest policy initialization IGVM section and
> builds an SEV policy based on this information and the ID block
> directive if present. The policy is applied using by calling
> 'set_guest_policy()' on the ConfidentialGuestSupport object.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  backends/igvm.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 136 insertions(+)
> 
> diff --git a/backends/igvm.c b/backends/igvm.c
> index b6b7d30a3f..bb8038f9e9 100644
> --- a/backends/igvm.c
> +++ b/backends/igvm.c
> @@ -28,6 +28,33 @@ typedef struct IgvmParameterData {
>      uint32_t index;
>  } IgvmParameterData;
>  
> +/*
> + * Some directives are specific to particular confidential computing platforms.
> + * Define required types for each of those platforms here.
> + */
> +
> +/* SEV/SEV-ES/SEV-SNP */
> +struct QEMU_PACKED sev_id_block {
> +    uint8_t ld[48];
> +    uint8_t family_id[16];
> +    uint8_t image_id[16];
> +    uint32_t version;
> +    uint32_t guest_svn;
> +    uint64_t policy;
> +};
> +
> +struct QEMU_PACKED sev_id_authentication {
> +    uint32_t id_key_alg;
> +    uint32_t auth_key_algo;
> +    uint8_t reserved[56];
> +    uint8_t id_block_sig[512];
> +    uint8_t id_key[1028];
> +    uint8_t reserved2[60];
> +    uint8_t id_key_sig[512];
> +    uint8_t author_key[1028];
> +    uint8_t reserved3[892];
> +};
> +
>  /*
>   * QemuIgvm contains the information required during processing
>   * of a single IGVM file.
> @@ -39,6 +66,17 @@ typedef struct QemuIgvm {
>      uint32_t compatibility_mask;
>      unsigned current_header_index;
>      QTAILQ_HEAD(, IgvmParameterData) parameter_data;
> +    IgvmPlatformType platform_type;
> +
> +    /*
> +     * SEV-SNP platforms can contain an ID block and authentication
> +     * that should be verified by the guest.
> +     */
> +    struct sev_id_block *id_block;
> +    struct sev_id_authentication *id_auth;
> +
> +    /* Define the guest policy for SEV guests */
> +    uint64_t sev_policy;
>  
>      /* These variables keep track of contiguous page regions */
>      IGVM_VHS_PAGE_DATA region_prev_page_data;
> @@ -64,6 +102,11 @@ static int directive_environment_info(QemuIgvm *ctx, const uint8_t *header_data,
>                                        Error **errp);
>  static int directive_required_memory(QemuIgvm *ctx, const uint8_t *header_data,
>                                       Error **errp);
> +static int directive_snp_id_block(QemuIgvm *ctx, const uint8_t *header_data,
> +                                  Error **errp);
> +static int initialization_guest_policy(QemuIgvm *ctx,
> +                                       const uint8_t *header_data,
> +                                       Error **errp);
>  
>  struct IGVMHandler {
>      uint32_t type;
> @@ -87,6 +130,10 @@ static struct IGVMHandler handlers[] = {
>        directive_environment_info },
>      { IGVM_VHT_REQUIRED_MEMORY, IGVM_HEADER_SECTION_DIRECTIVE,
>        directive_required_memory },
> +    { IGVM_VHT_SNP_ID_BLOCK, IGVM_HEADER_SECTION_DIRECTIVE,
> +      directive_snp_id_block },
> +    { IGVM_VHT_GUEST_POLICY, IGVM_HEADER_SECTION_INITIALIZATION,
> +      initialization_guest_policy },
>  };
>  
>  static int handler(QemuIgvm *ctx, uint32_t type, Error **errp)
> @@ -619,6 +666,68 @@ static int directive_required_memory(QemuIgvm *ctx, const uint8_t *header_data,
>      return 0;
>  }
>  
> +static int directive_snp_id_block(QemuIgvm *ctx, const uint8_t *header_data,
> +                                  Error **errp)
> +{
> +    const IGVM_VHS_SNP_ID_BLOCK *igvm_id =
> +        (const IGVM_VHS_SNP_ID_BLOCK *)header_data;
> +
> +    if (ctx->compatibility_mask & igvm_id->compatibility_mask) {
> +        if (ctx->id_block) {
> +            error_setg(errp, "IGVM: Multiple ID blocks encountered "
> +                             "in IGVM file.");
> +            return -1;
> +        }
> +        ctx->id_block = g_malloc0(sizeof(struct sev_id_block));
> +        ctx->id_auth = g_malloc0(sizeof(struct sev_id_authentication));

QEMU has a preference for

  g_new0(struct sev_id_block, 1);
  g_new0(struct sev_id_authentication, 1);

> +
> +        memcpy(ctx->id_block->family_id, igvm_id->family_id,
> +               sizeof(ctx->id_block->family_id));
> +        memcpy(ctx->id_block->image_id, igvm_id->image_id,
> +               sizeof(ctx->id_block->image_id));
> +        ctx->id_block->guest_svn = igvm_id->guest_svn;
> +        ctx->id_block->version = 1;
> +        memcpy(ctx->id_block->ld, igvm_id->ld, sizeof(ctx->id_block->ld));
> +
> +        ctx->id_auth->id_key_alg = igvm_id->id_key_algorithm;
> +        memcpy(ctx->id_auth->id_block_sig, &igvm_id->id_key_signature,
> +               sizeof(igvm_id->id_key_signature));
> +
> +        ctx->id_auth->auth_key_algo = igvm_id->author_key_algorithm;
> +        memcpy(ctx->id_auth->id_key_sig, &igvm_id->author_key_signature,
> +               sizeof(igvm_id->author_key_signature));
> +
> +        /*
> +         * SEV and IGVM public key structure population are slightly different.
> +         * See SEV Secure Nested Paging Firmware ABI Specification, Chapter 10.
> +         */
> +        *((uint32_t *)ctx->id_auth->id_key) = igvm_id->id_public_key.curve;
> +        memcpy(&ctx->id_auth->id_key[4], &igvm_id->id_public_key.qx, 72);
> +        memcpy(&ctx->id_auth->id_key[76], &igvm_id->id_public_key.qy, 72);
> +
> +        *((uint32_t *)ctx->id_auth->author_key) =
> +            igvm_id->author_public_key.curve;
> +        memcpy(&ctx->id_auth->author_key[4], &igvm_id->author_public_key.qx,
> +               72);
> +        memcpy(&ctx->id_auth->author_key[76], &igvm_id->author_public_key.qy,
> +               72);
> +    }
> +
> +    return 0;
> +}

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


