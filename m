Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2047FC52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 11:42:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbIaO-0005Zp-MJ; Tue, 06 Aug 2024 07:42:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbIaM-0005Qi-KY
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 07:42:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbIaI-0005mC-EZ
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 07:42:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722944552;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=w2Kg4xQYm99ToisfFghbwRPcpceGtA4NdcEX4tRZ88o=;
 b=MRn7fK7hv0PDmErXiBe96QlpvNaqbF/NrTE8QvnTLUCPy2/uNL4VRhNHiZDnJ1UkzlB55h
 jyCPgVhAAknEogYaTJxq3DTbTSPuxksmLp1SY6nvcMq0HH8woCnbmXqT5pwApZ9gAZgHdQ
 DIYCpNmKu/56EfBy/JhK6WUlYZgoFt0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-198-6vj_dvx6MmmNLqlJi5_VIQ-1; Tue,
 06 Aug 2024 07:42:30 -0400
X-MC-Unique: 6vj_dvx6MmmNLqlJi5_VIQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBFA91955BF2; Tue,  6 Aug 2024 11:42:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D411300019B; Tue,  6 Aug 2024 11:42:28 +0000 (UTC)
Date: Tue, 6 Aug 2024 12:42:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, aep@kraud.cloud
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 16/16] target/i386/SEV: implement mask_cpuid_features
Message-ID: <ZrIMII0SUzfwoF_P@redhat.com>
References: <20240704095806.1780273-1-pbonzini@redhat.com>
 <20240704095806.1780273-17-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240704095806.1780273-17-pbonzini@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 04, 2024 at 11:58:06AM +0200, Paolo Bonzini wrote:
> Drop features that are listed as "BitMask" in the PPR and currently
> not supported by AMD processors.  The only ones that may become useful
> in the future are TSC deadline timer and x2APIC, everything else is
> not needed for SEV-SNP guests (e.g. VIRT_SSBD) or would require
> processor support (e.g. TSC_ADJUST).
> 
> This allows running SEV-SNP guests with "-cpu host".

What CPU generation(s)/model(s)  did you test this with ?

I've been talking to a libvirt user (CC'd) who has tried host CPU
passthrough with SNP, using QEMU git master from yesterday (which
has this patch present) and they are still getting failures. 

They are using pc-q35-9.1 machine type and host CPU passthrough,
on a Milan 7003  host, and getting this validation failure

  SEV-SNP: CPUID validation failed for function 0x80000021, index: 0x0, provided: eax:0x18000245, ebx: 0x00000000, ecx: 0x00000000, edx: 0x00000000, expected: eax:0x18000045, ebx: 0x00000000, ecx: 0x00000000, edx: 0x00000000

I don't see any  0x0000_0200  bit defined for EAX with
the function 0x8000_0021 in target/i386/cpu.c, so there's
nothing we can mask out on the CLI, nor in your
sev_snp_mask_cpuid_features function. 

For that matter we've not defined the 0x1000_0000 or 0x0800_000
bits either, though SNP isn't complaining about those at least.

> diff --git a/target/i386/sev.c b/target/i386/sev.c
> index 2f3dbe289f4..2ba5f517228 100644
> --- a/target/i386/sev.c
> +++ b/target/i386/sev.c
> @@ -945,6 +945,38 @@ out:
>      return ret;
>  }
>  
> +static uint32_t
> +sev_snp_mask_cpuid_features(X86ConfidentialGuest *cg, uint32_t feature, uint32_t index,
> +                            int reg, uint32_t value)
> +{
> +    switch (feature) {
> +    case 1:
> +        if (reg == R_ECX) {
> +            return value & ~CPUID_EXT_TSC_DEADLINE_TIMER;
> +        }
> +        break;
> +    case 7:
> +        if (index == 0 && reg == R_EBX) {
> +            return value & ~CPUID_7_0_EBX_TSC_ADJUST;
> +        }
> +        if (index == 0 && reg == R_EDX) {
> +            return value & ~(CPUID_7_0_EDX_SPEC_CTRL |
> +                             CPUID_7_0_EDX_STIBP |
> +                             CPUID_7_0_EDX_FLUSH_L1D |
> +                             CPUID_7_0_EDX_ARCH_CAPABILITIES |
> +                             CPUID_7_0_EDX_CORE_CAPABILITY |
> +                             CPUID_7_0_EDX_SPEC_CTRL_SSBD);
> +        }
> +        break;
> +    case 0x80000008:
> +        if (reg == R_EBX) {
> +            return value & ~CPUID_8000_0008_EBX_VIRT_SSBD;
> +        }
> +        break;
> +    }
> +    return value;
> +}
> +
>  static int
>  sev_launch_update_data(SevCommonState *sev_common, hwaddr gpa,
>                         uint8_t *addr, size_t len)
> @@ -2315,6 +2347,7 @@ sev_snp_guest_class_init(ObjectClass *oc, void *data)
>      klass->launch_finish = sev_snp_launch_finish;
>      klass->launch_update_data = sev_snp_launch_update_data;
>      klass->kvm_init = sev_snp_kvm_init;
> +    x86_klass->mask_cpuid_features = sev_snp_mask_cpuid_features;
>      x86_klass->kvm_type = sev_snp_kvm_type;
>  
>      object_class_property_add(oc, "policy", "uint64",
> -- 
> 2.45.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


