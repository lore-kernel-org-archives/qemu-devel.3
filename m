Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A96C2BD05
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2024 11:44:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLi7O-0004AM-Cc; Mon, 24 Jun 2024 07:44:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLi7K-0004A1-Ps
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:44:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sLi7I-0001zR-75
 for qemu-devel@nongnu.org; Mon, 24 Jun 2024 07:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719229450;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cXMlOCTBH9ppGiREvrYGHGuZ92vyek5UuwObkNJ0g1I=;
 b=eeKOOHDZh07WDTcDJnjClw+8N2uncTb3omUxVKfuDez2FDFSWeGNqr06fVqTmjOsmgZjHF
 BRPgdS4u1/WOsbPKiGzAiKAfBjcL0veSTBBad6Y9u2qgH+WshTp+TkUUmSUkjYr+x+x4fC
 RA9mfWnRbMM9QtRzpbhMS6OfGq6vcnQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-cK_p3YuiMISorwLMxdqKRw-1; Mon,
 24 Jun 2024 07:44:07 -0400
X-MC-Unique: cK_p3YuiMISorwLMxdqKRw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 54B071956089; Mon, 24 Jun 2024 11:44:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.226])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8B2001954B13; Mon, 24 Jun 2024 11:44:01 +0000 (UTC)
Date: Mon, 24 Jun 2024 12:43:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, kvm@vger.kernel.org,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [PATCH] i386: revert defaults to 'legacy-vm-type=true' for
 SEV(-ES) guests
Message-ID: <Znlb_WtHpPHXa6zH@redhat.com>
References: <20240614103924.1420121-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240614103924.1420121-1-berrange@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

Ping, any comments for this ?

On Fri, Jun 14, 2024 at 11:39:24AM +0100, Daniel P. Berrangé wrote:
> The KVM_SEV_INIT2 ioctl was only introduced in Linux 6.10, which will
> only have been released for a bit over a month when QEMU 9.1 is
> released.
> 
> The SEV(-ES) support in QEMU has been present since 2.12 dating back
> to 2018. With this in mind, the overwhealming majority of users of
> SEV(-ES) are unlikely to be running Linux >= 6.10, any time in the
> forseeable future.
> 
> IOW, defaulting new QEMU to 'legacy-vm-type=false' means latest QEMU
> machine types will be broken out of the box for most SEV(-ES) users.
> Even if the kernel is new enough, it also affects the guest measurement,
> which means that their existing tools for validating measurements will
> also be broken by the new default.
> 
> This is not a sensible default choice at this point in time. Revert to
> the historical behaviour which is compatible with what most users are
> currently running.
> 
> This can be re-evaluated a few years down the line, though it is more
> likely that all attention will be on SEV-SNP by this time. Distro
> vendors may still choose to change this default downstream to align
> with their new major releases where they can guarantee the kernel
> will always provide the required functionality.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  hw/i386/pc.c      |  1 -
>  qapi/qom.json     | 12 ++++++------
>  target/i386/sev.c |  7 +++++++
>  3 files changed, 13 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 0469af00a7..b65843c559 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -82,7 +82,6 @@
>  GlobalProperty pc_compat_9_0[] = {
>      { TYPE_X86_CPU, "x-l1-cache-per-thread", "false" },
>      { TYPE_X86_CPU, "guest-phys-bits", "0" },
> -    { "sev-guest", "legacy-vm-type", "true" },
>      { TYPE_X86_CPU, "legacy-multi-node", "on" },
>  };
>  const size_t pc_compat_9_0_len = G_N_ELEMENTS(pc_compat_9_0);
> diff --git a/qapi/qom.json b/qapi/qom.json
> index 8bd299265e..714ebeec8b 100644
> --- a/qapi/qom.json
> +++ b/qapi/qom.json
> @@ -912,12 +912,12 @@
>  # @handle: SEV firmware handle (default: 0)
>  #
>  # @legacy-vm-type: Use legacy KVM_SEV_INIT KVM interface for creating the VM.
> -#                  The newer KVM_SEV_INIT2 interface syncs additional vCPU
> -#                  state when initializing the VMSA structures, which will
> -#                  result in a different guest measurement. Set this to
> -#                  maintain compatibility with older QEMU or kernel versions
> -#                  that rely on legacy KVM_SEV_INIT behavior.
> -#                  (default: false) (since 9.1)
> +#                  The newer KVM_SEV_INIT2 interface, from Linux >= 6.10, syncs
> +#                  additional vCPU state when initializing the VMSA structures,
> +#                  which will result in a different guest measurement. Toggle
> +#                  this to control compatibility with older QEMU or kernel
> +#                  versions that rely on legacy KVM_SEV_INIT behavior.
> +#                  (default: true) (since 9.1)
>  #
>  # Since: 2.12
>  ##
> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 004c667ac1..16029282b7 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -2086,6 +2086,13 @@ sev_guest_instance_init(Object *obj)
>      object_property_add_uint32_ptr(obj, "policy", &sev_guest->policy,
>                                     OBJ_PROP_FLAG_READWRITE);
>      object_apply_compat_props(obj);
> +
> +    /*
> +     * KVM_SEV_INIT2 was only introduced in Linux 6.10. Avoid
> +     * breaking existing users of SEV, since the overwhealming
> +     * majority won't have a new enough kernel for a long time
> +     */
> +    sev_guest->legacy_vm_type = true;
>  }
>  
>  /* guest info specific sev/sev-es */
> -- 
> 2.45.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


