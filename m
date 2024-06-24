Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE107C3064D
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLl5D-0000X0-FM; Mon, 24 Jun 2024 10:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLl5C-0000Wb-6V
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:54:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLl5A-0001Rg-45
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:54:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719240850;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=qT056SQZWn+vLV8Iuwkm9ZsWd5Iqr+t6O7ZQMeefHfc=;
 b=HUonz/tm/Nb+MqKeB2o5jTBzYR5lqnL/baarLiBK0SIcfIjQYj94/RjHQGi6DzIwl/dFPF
 TYTKca2OR/u9ZC71oFumbLDQr+YqCyRTKDtodDCEvDd/x4CXyozbjikOfZc7GfvA+VzCrx
 UOQppG0Xbr1zfamSq95Cycj/tbEbPVI=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-171-Q-1jcvz5P4uafOmG1hIxxw-1; Mon,
 24 Jun 2024 10:54:09 -0400
X-MC-Unique: Q-1jcvz5P4uafOmG1hIxxw-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5732119560B3; Mon, 24 Jun 2024 14:54:07 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 996441956087; Mon, 24 Jun 2024 14:54:00 +0000 (UTC)
Date: Mon, 24 Jun 2024 15:53:56 +0100
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
Subject: Re: [PATCH v3 14/15] i386/sev: Add implementation of CGS
 set_guest_policy()
Message-ID: <ZnmIhC5qF5il2NwW@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <bcf161124214aa768f05eb99e174705741dda352.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bcf161124214aa768f05eb99e174705741dda352.1718979106.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
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

On Fri, Jun 21, 2024 at 03:29:17PM +0100, Roy Hopkins wrote:
> The new cgs_set_guest_policy() function is provided to receive the guest
> policy flags, SNP ID block and SNP ID authentication from guest
> configuration such as an IGVM file and apply it to the platform prior to
> launching the guest.
> 
> The policy is used to populate values for the existing 'policy',
> 'id_block' and 'id_auth' parameters. When provided, the guest policy is
> applied and the ID block configuration is used to verify the launch
> measurement and signatures. The guest is only successfully started if
> the expected launch measurements match the actual measurements and the
> signatures are valid.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  target/i386/sev.h | 12 +++++++
>  target/i386/sev.c | 83 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 95 insertions(+)
> 
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index 2ccd6fe1e8..7b92102bd0 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -157,6 +157,18 @@ struct QEMU_PACKED sev_es_save_area {
>      uint8_t fpreg_ymm[256];
>  };
>  
> +struct QEMU_PACKED sev_snp_id_authentication {
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
>  #ifdef CONFIG_SEV
>  bool sev_enabled(void);
>  bool sev_es_enabled(void);
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 5d9ef745bb..688b378c42 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2446,6 +2446,88 @@ static int cgs_get_mem_map_entry(int index,
>      return 0;
>  }
>  
> +static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
> +                                uint64_t policy, void *policy_data1,
> +                                uint32_t policy_data1_size, void *policy_data2,
> +                                uint32_t policy_data2_size, Error **errp)
> +{
> +    if (policy_type != GUEST_POLICY_SEV) {
> +        error_setg(errp, "%s: Invalid guest policy type provided for SEV: %d",
> +        __func__, policy_type);
> +        return -1;
> +    }
> +    /*
> +     * SEV-SNP handles policy differently. The policy flags are defined in
> +     * kvm_start_conf.policy and an ID block and ID auth can be provided.
> +     */
> +    if (sev_snp_enabled()) {
> +        SevSnpGuestState *sev_snp_guest =
> +            SEV_SNP_GUEST(MACHINE(qdev_get_machine())->cgs);
> +        struct kvm_sev_snp_launch_finish *finish =
> +            &sev_snp_guest->kvm_finish_conf;
> +
> +        /*
> +         * The policy consists of flags in 'policy' and optionally an ID block
> +         * and ID auth in policy_data1 and policy_data2 respectively. The ID
> +         * block and auth are optional so clear any previous ID block and auth
> +         * and set them if provided, but always set the policy flags.
> +         */
> +        g_free(sev_snp_guest->id_block);
> +        g_free((guchar *)finish->id_block_uaddr);
> +        g_free(sev_snp_guest->id_auth);
> +        g_free((guchar *)finish->id_auth_uaddr);
> +        sev_snp_guest->id_block = NULL;
> +        finish->id_block_uaddr = 0;
> +        sev_snp_guest->id_auth = NULL;
> +        finish->id_auth_uaddr = 0;
> +
> +        if (policy_data1_size > 0) {
> +            struct sev_snp_id_authentication *id_auth =
> +                (struct sev_snp_id_authentication *)policy_data2;
> +
> +            if (policy_data1_size != KVM_SEV_SNP_ID_BLOCK_SIZE) {
> +                error_setg(errp, "%s: Invalid SEV-SNP ID block: incorrect size",
> +                           __func__);
> +                return -1;
> +            }
> +            if (policy_data2_size != KVM_SEV_SNP_ID_AUTH_SIZE) {
> +                error_setg(errp,
> +                           "%s: Invalid SEV-SNP ID auth block: incorrect size",
> +                           __func__);
> +                return -1;
> +            }

Perhaps add

  assert(policy_data1 != NULL);
  assert(policy_data2 != NULL);


> +            finish->id_block_uaddr =
> +                (__u64)g_malloc0(KVM_SEV_SNP_ID_BLOCK_SIZE);
> +            finish->id_authu_addr = (__u64)g_malloc0(KVM_SEV_SNP_ID_AUTH_SIZE);
> +            memcpy((void *)finish->id_block_uaddr, policy_data1,
> +                   KVM_SEV_SNP_ID_BLOCK_SIZE);
> +            memcpy((void *)finish->id_auth_uaddr, policy_data2,
> +                   KVM_SEV_SNP_ID_AUTH_SIZE);

How about using g_memdup2 ?

   finish->id_block_uaddr = (__u64)g_memdup2(policy_data1, KVM_SEV_SNP_ID_BLOCK_SIZE);
   finish->id_auth_uaddr = (__u64)g_memdup2(policy_data2, KVM_SEV_SNP_ID_AUTH_SIZE);

> +
> +            /*
> +             * Check if an author key has been provided and use that to flag
> +             * whether the author key is enabled. The first of the author key
> +             * must be non-zero to indicate the key type, which will currently
> +             * always be 2.
> +             */
> +            sev_snp_guest->kvm_finish_conf.auth_key_en =
> +                id_auth->author_key[0] ? 1 : 0;
> +            finish->id_block_en = 1;
> +        }
> +        sev_snp_guest->kvm_start_conf.policy = policy;
> +    } else {
> +        SevGuestState *sev_guest = SEV_GUEST(MACHINE(qdev_get_machine())->cgs);
> +        /* Only the policy flags are supported for SEV and SEV-ES */
> +        if ((policy_data1_size > 0) || (policy_data2_size > 0) || !sev_guest) {
> +            error_setg(errp, "%s: An ID block/ID auth block has been provided "
> +                             "but SEV-SNP is not supported", __func__);

Slightly more accurate to say  s/is not supported/is not enabled/

> +            return -1;
> +        }
> +        sev_guest->policy = policy;
> +    }
> +    return 0;
> +}
> +
>  static void
>  sev_common_class_init(ObjectClass *oc, void *data)
>  {
> @@ -2484,6 +2566,7 @@ sev_common_instance_init(Object *obj)
>      cgs->check_support = cgs_check_support;
>      cgs->set_guest_state = cgs_set_guest_state;
>      cgs->get_mem_map_entry = cgs_get_mem_map_entry;
> +    cgs->set_guest_policy = cgs_set_guest_policy;
>  
>      QTAILQ_INIT(&sev_common->launch_vmsa);
>  }
> -- 
> 2.43.0
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


