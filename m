Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F37ECCD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 11:52:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU1Bn-0003zW-VH; Mon, 01 Jun 2026 07:52:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wU1Bl-0003fT-LA
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 07:52:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wU1Bj-000653-GC
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 07:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780314729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=umZnldik/6FFLPzE92MsWIGrcabXan45d2nAH0uiu14=;
 b=DvaTQMbrKlmycVFxzMB45HEo9s99OWAbGiIdikCjG2Vk0/4TAkfsVWOgoJ4ndNhTPsvRGw
 rB28O4PGGJQWmqobjzt9ktKc4ein8NFVYRqwcfXgDScSs4tFwVuMoiQaEMOP39u22JNxNB
 nJ+uVVzF/EjlcbZBCexYAJDpYoMKdcc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-m8EGVVBIPdqGIyRYPnRPWg-1; Mon,
 01 Jun 2026 07:52:06 -0400
X-MC-Unique: m8EGVVBIPdqGIyRYPnRPWg-1
X-Mimecast-MFC-AGG-ID: m8EGVVBIPdqGIyRYPnRPWg_1780314724
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27F8A1956094; Mon,  1 Jun 2026 11:52:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 518E91956095; Mon,  1 Jun 2026 11:52:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CB9BD21E6A01; Mon, 01 Jun 2026 13:52:00 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: "Naveen N Rao (AMD)" <naveen@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,  qemu-devel
 <qemu-devel@nongnu.org>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,  Zhao Liu <zhao1.liu@intel.com>,
 Nikunj A Dadhania <nikunj@amd.com>,  Tom Lendacky
 <thomas.lendacky@amd.com>,  Michael Roth <michael.roth@amd.com>,  Roy
 Hopkins <roy.hopkins@randomman.co.uk>,  Srikanth Aithal
 <srikanth.aithal@amd.com>,  Kim Phillips <kim.phillips@amd.com>,  Joerg
 Roedel <joro@8bytes.org>
Subject: Re: [PATCH v4 6/9] target/i386: SEV: Add support for enabling
 debug-swap SEV feature
In-Reply-To: <416e7b156e49f95958f8c5c8549b48a88c1995fc.1779281646.git.naveen@kernel.org>
 (Naveen N. Rao's message of "Wed, 20 May 2026 18:57:59 +0530")
References: <cover.1779281646.git.naveen@kernel.org>
 <416e7b156e49f95958f8c5c8549b48a88c1995fc.1779281646.git.naveen@kernel.org>
Date: Mon, 01 Jun 2026 13:52:00 +0200
Message-ID: <87v7c27a1r.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

"Naveen N Rao (AMD)" <naveen@kernel.org> writes:

> Add support for enabling debug-swap VMSA SEV feature in SEV-ES and
> SEV-SNP guests through a new "debug-swap" boolean property on SEV guest
> objects. Though the boolean property is available for plain SEV guests,
> check_sev_features() has a check that rejects attempts to enable any SEV
> feature for a plain SEV guest.

Why does it make sense to add the property to objects where it's not
supported?

> Though this SEV feature is called "Debug virtualization" in the APM, KVM
> calls this "debug swap" so use the same name for consistency.

Thanks for explaining this.

> Sample command-line:
>   -machine q35,confidential-guest-support=sev0 \
>   -object sev-snp-guest,id=sev0,cbitpos=51,reduced-phys-bits=1,debug-swap=on
>
> Restrict debug-swap to SEV-SNP guests at this time due to a
> compatibility issue with SEV-ES pflash devices.

What are these issues?

> Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
> ---
>  target/i386/sev.h |  1 +
>  target/i386/sev.c | 26 ++++++++++++++++++++++++++
>  qapi/qom.json     |  7 ++++++-
>  3 files changed, 33 insertions(+), 1 deletion(-)
>
> diff --git a/target/i386/sev.h b/target/i386/sev.h
> index b84ca3ce0b67..d19a39669747 100644
> --- a/target/i386/sev.h
> +++ b/target/i386/sev.h
> @@ -47,6 +47,7 @@ bool sev_snp_enabled(void);
>  #define SEV_SNP_POLICY_DBG      0x80000
>  
>  #define SVM_SEV_FEAT_SNP_ACTIVE     BIT(0)
> +#define SVM_SEV_FEAT_DEBUG_SWAP     BIT(5)
>  
>  typedef struct SevKernelLoaderContext {
>      char *setup_data;
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 4553fe4d6e4a..4532b1b6a484 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -328,6 +328,11 @@ sev_set_guest_state(SevCommonState *sev_common, SevState new_state)
>      sev_common->state = new_state;
>  }
>  
> +static bool is_sev_feature_set(SevCommonState *sev_common, uint64_t feature)
> +{
> +    return !!(sev_common->sev_features & feature);
> +}
> +
>  static void sev_set_feature(SevCommonState *sev_common, uint64_t feature, bool set)
>  {
>      if (set) {
> @@ -527,6 +532,12 @@ static int check_sev_features(SevCommonState *sev_common, uint64_t sev_features,
>              __func__);
>          return -1;
>      }
> +    if (sev_features && sev_es_enabled() && !sev_snp_enabled()) {
> +        error_setg(errp,
> +                   "%s: SEV features are not supported with SEV-ES at this time",
> +                   __func__);

Once again, I'm confused about SEV.  Remind me: what kinds of SEV guests
exist?  The commit message suggests "plain", "ES", "SNP".  What do
sev_es_enabled() and sev_snp_enabled() return for each of these?

What are the "SEV features"?  Can we expect users to know?  I suspect
they need to know to fix the problem!

Are they exactly debug-swap?

__func__ in an error message meant for users is an anti-pattern.  Not an
objection to this patch; it matches existing errors around here.

> +        return -1;
> +    }
>      if (sev_features && !sev_es_enabled()) {
>          error_setg(errp,
>                     "%s: SEV features require either SEV-ES or SEV-SNP to be enabled",
> @@ -2800,6 +2811,16 @@ static int cgs_set_guest_policy(ConfidentialGuestPolicyType policy_type,
>      return 0;
>  }
>  
> +static bool sev_common_get_debug_swap(Object *obj, Error **errp)
> +{
> +    return is_sev_feature_set(SEV_COMMON(obj), SVM_SEV_FEAT_DEBUG_SWAP);
> +}
> +
> +static void sev_common_set_debug_swap(Object *obj, bool value, Error **errp)
> +{
> +    sev_set_feature(SEV_COMMON(obj), SVM_SEV_FEAT_DEBUG_SWAP, value);
> +}
> +
>  static void
>  sev_common_class_init(ObjectClass *oc, const void *data)
>  {
> @@ -2825,6 +2846,11 @@ sev_common_class_init(ObjectClass *oc, const void *data)
>                                     sev_common_set_kernel_hashes);
>      object_class_property_set_description(oc, "kernel-hashes",
>              "add kernel hashes to guest firmware for measured Linux boot");
> +    object_class_property_add_bool(oc, "debug-swap",
> +                                   sev_common_get_debug_swap,
> +                                   sev_common_set_debug_swap);
> +    object_class_property_set_description(oc, "debug-swap",
> +            "enable virtualization of debug registers");
>  }
>  
>  static void
> diff --git a/qapi/qom.json b/qapi/qom.json
> index dd45ac1087c3..e2bb716b603e 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -1017,6 +1017,10 @@
>  #     designated guest firmware page for measured boot with -kernel
>  #     (default: false) (since 6.2)
>  #
> +# @debug-swap: enable virtualization of debug registers,
> +#     only supported on SEV-ES and SEV-SNP guests
> +#     (default: false) (since 11.1)
> +#
>  # Features:
>  #
>  # @confidential-guest-reset: If present, the hypervisor supports
> @@ -1028,7 +1032,8 @@
>    'data': { '*sev-device': 'str',
>              '*cbitpos': 'uint32',
>              'reduced-phys-bits': 'uint32',
> -            '*kernel-hashes': 'bool' },
> +            '*kernel-hashes': 'bool',
> +            '*debug-swap': 'bool' },
>    'features': ['confidential-guest-reset']}
>  
>  ##

This is SevCommonProperties, the common base type of SevGuestProperties
(configuration for sev-guest QOM objects) and SevSnpGuestProperties
(sev-snp-guest objects).

So, all SEV objects have property @debug-swap.  I figure the check you
add to check_sev_features() rejects it for certain SEV objects.  I don't
quite understand for which ones.


