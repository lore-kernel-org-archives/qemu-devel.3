Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB6AC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 14:15:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLkTS-0006Ij-W4; Mon, 24 Jun 2024 10:15:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLkTP-0006IS-JX
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLkTJ-0001wt-3l
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 10:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719238502;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=R5FVv4v8PIbiL51n0zCNuQiW88AZK5O22G9ihp//aLc=;
 b=idVkFk+Y5dsG00Uy/f0AZ7H3iq7qo+p9ObpMdc6PKVA/Y7CZDvj3KOeadziVuM602KoMHi
 niotDQQwojjUYliykl+P0oFVS11p34GglTlC9PgkmgevgBYxo1zIJaGuI5t2Gr0gB5Sv4z
 u1tAWhL2yT64oBVtfs9fA7jBVUZpVTE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-96-MMwmqxmhOD-S4arCcmsD1A-1; Mon,
 24 Jun 2024 10:15:00 -0400
X-MC-Unique: MMwmqxmhOD-S4arCcmsD1A-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D27B019560A7; Mon, 24 Jun 2024 14:14:57 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 80A901955E82; Mon, 24 Jun 2024 14:14:50 +0000 (UTC)
Date: Mon, 24 Jun 2024 15:14:47 +0100
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
Subject: Re: [PATCH v3 15/15] sev: Provide sev_features flags from IGVM VMSA
 to KVM_SEV_INIT2
Message-ID: <Znl_VyXoV30-Cgob@redhat.com>
References: <cover.1718979106.git.roy.hopkins@suse.com>
 <8e49a1aed06d4f98c13a98fbbe3a48cdeb6e0070.1718979106.git.roy.hopkins@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e49a1aed06d4f98c13a98fbbe3a48cdeb6e0070.1718979106.git.roy.hopkins@suse.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.207,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On Fri, Jun 21, 2024 at 03:29:18PM +0100, Roy Hopkins wrote:
> IGVM files can contain an initial VMSA that should be applied to each
> vcpu as part of the initial guest state. The sev_features flags are
> provided as part of the VMSA structure. However, KVM only allows
> sev_features to be set during initialization and not as the guest is
> being prepared for launch.
> 
> This patch queries KVM for the supported set of sev_features flags and
> processes the IGVM file during kvm_init to determine any sev_features
> flags set in the IGVM file. These are then provided in the call to
> KVM_SEV_INIT2 to ensure the guest state matches that specified in the
> IGVM file.
> 
> This does cause the IGVM file to be processed twice. Firstly to extract
> the sev_features then secondly to actually configure the guest. However,
> the first pass is largely ignored meaning the overhead is minimal.
> 
> Signed-off-by: Roy Hopkins <roy.hopkins@suse.com>
> ---
>  target/i386/sev.c | 145 ++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 126 insertions(+), 19 deletions(-)
> 

>  static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>  {
>      char *devname;
> @@ -1743,6 +1783,10 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          }
>      }
>  
> +    if (sev_init_supported_features(sev_common, errp) < 0) {
> +        return -1;
> +    }
> +
>      trace_kvm_sev_init();
>      if (x86_klass->kvm_type(X86_CONFIDENTIAL_GUEST(sev_common)) == KVM_X86_DEFAULT_VM) {
>          cmd = sev_es_enabled() ? KVM_SEV_ES_INIT : KVM_SEV_INIT;
> @@ -1750,6 +1794,38 @@ static int sev_common_kvm_init(ConfidentialGuestSupport *cgs, Error **errp)
>          ret = sev_ioctl(sev_common->sev_fd, cmd, NULL, &fw_error);
>      } else {
>          struct kvm_sev_init args = { 0 };
> +        MachineState *machine = MACHINE(qdev_get_machine());
> +
> +        /*
> +         * If configuration is provided via an IGVM file then the IGVM file
> +         * might contain configuration of the initial vcpu context. For SEV
> +         * the vcpu context includes the sev_features which should be applied
> +         * to the vcpu.
> +         *
> +         * KVM does not synchronize sev_features from CPU state. Instead it
> +         * requires sev_features to be provided as part of this initialization
> +         * call which is subsequently automatically applied to the VMSA of
> +         * each vcpu.
> +         *
> +         * The IGVM file is normally processed after initialization. Therefore
> +         * we need to pre-process it here to extract sev_features in order to
> +         * provide it to KVM_SEV_INIT2. Each cgs_* function that is called by
> +         * the IGVM processor detects this pre-process by observing the state
> +         * as SEV_STATE_UNINIT.
> +         */
> +        if (machine->igvm) {
> +            if (IGVM_CFG_GET_CLASS(machine->igvm)
> +                    ->process(machine->igvm, machine->cgs, errp) == -1) {
> +                return -1;
> +            }
> +            /*
> +             * KVM maintains a bitmask of allowed sev_features. This does not
> +             * include SVM_SEV_FEAT_SNP_ACTIVE which is set accordingly by KVM
> +             * itself. Therefore we need to clear this flag.
> +             */
> +            args.vmsa_features = sev_common->sev_features &
> +                                 ~SVM_SEV_FEAT_SNP_ACTIVE;
> +        }
>  
>          ret = sev_ioctl(sev_common->sev_fd, KVM_SEV_INIT2, &args, &fw_error);
>      }

What happens if the code path takes us down the KVM_SEV_INIT
route, rather than KVM_SEV_INIT2 ?  Should we be reporting an
error indicating that IGVM usage is incompatible with the legacy
KVM_SEV_INIT path ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


