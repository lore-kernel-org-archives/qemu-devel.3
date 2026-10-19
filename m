Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 257BACCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjPb-00049o-K9; Mon, 19 Oct 2026 05:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1xIjPW-000498-II
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:12:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vkuznets@redhat.com>)
 id 1xIjPU-0001tp-6I
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:12:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792401117;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xv1sH19LW/lyaQLSFLozDIBk8LFcI769sFQGb3jES7M=;
 b=YDztyGSC/OgWwDMELqS9lvsaszDZb533k5o7cKshJIp83B553jL0f9CB3pVxWjlI2gNW9N
 +4NpacNV/L1Rnjlqi5d1Pbcp2tK7DPWtD/TnXODIZFqC9+EcyZfXEfYLfw9O6o5z8kRD1m
 SultUdHzq2ymsiDveZcFVPVV2/EeD/U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-136-GYX8HimTN_6IFrNqRU2tkw-1; Mon, 19 Oct 2026 09:11:56 +0000
X-MC-Unique: GYX8HimTN_6IFrNqRU2tkw-1
X-Mimecast-MFC-AGG-ID: GYX8HimTN_6IFrNqRU2tkw_1792401115
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4a1cf5e7012so15272785e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792401115; x=1793005915; darn=nongnu.org;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xv1sH19LW/lyaQLSFLozDIBk8LFcI769sFQGb3jES7M=;
 b=NlRSReUPtVdtyuHYXyku4WLAwzj6r5PPhkD1uyRvDt4/jUrjB0kf3/LlVCOw9I0nap
 sasBCBIIo7hvKqZLKJHQC1y5GYUwMUwLhTLraUqdg0iRqMUkURO4cMHjp2zUgt7T08TH
 9brPQc6glmAaLe8VLMSfrsCRcWWA024/JuqXgHnAv2gcxbYQfVFb9HpN4eTIJlvV9Zmy
 Iq1qzGKWgpARIywymvJvEX7ovMCKSTQFxbdMEbRc8cgmnTmfyBO/xlFO5CjfA0v5siKe
 dcDd5c8yEuTRiL1QgRDOkyFatiXzFrCvLdSDvHOvbRyUQhMS+OeYBYEH5rmItQeMJH99
 TIlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401115; x=1793005915;
 h=content-type:mime-version:message-id:date:references:in-reply-to
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xv1sH19LW/lyaQLSFLozDIBk8LFcI769sFQGb3jES7M=;
 b=nkQ6ir/IeOZdCOu1tqtgdxndOabgbGZgH3EUKu2p5TCMgnE6lQZ3CM605lR7bnA99B
 z7e1o5KvGCPpNWnuStoVzWZgYtQ2++CvhDk+1jzQI17p7rPtkdPksJE1QiAc7hgg2bu9
 fCb4Wx2KgR1UmFb/8R0IA3yFIhF0L7fMiiXlWfKL/EY+Udmm7s1lyhGsKHculW/J6TKF
 Ez6dVHgBYGs+/ksn7wG3TDoogIQ4CLiHzgPGKNb4Pr3OxZTRzwdYalEyv30hhl0Ejbt9
 T1UBgFEWmfBXKJ3hSj6FZr2lj7ffxRc1kiAI+jA3R+VpLwZ5VM8hpxdIkcVezcepWzIW
 sQZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwftx1BR12kl0g1DKfcz5MLCmESU1AGUoqGpinI9nIwzWA37MhCoasmwOoztZEcV1Mf1+cTfU9hvKvv@nongnu.org
X-Gm-Message-State: AFq9FYJ0a1qySKCwAk5M/I9w3xFNf+BhUuPRtf3/HdWYV/hoOyCWwfaj
 2sMZz/Wq1aWEJxdQUg4wrCZ3FoF0J/iX/g1Lw/KuE7mLQ0KLzzOZ1Vmc0KkK4G9KNhNFfpSVZW1
 OzjkQyquUxbz6HSzUyqJ4IIIyf1A2JMCidxbgtnOW1z8ao2Ow8wZzGSNP
X-Gm-Gg: AYBFou0eWgsMjDqbx2GEVGYyXG2qzRyMxWIE6xSWkQKyrNtZ8F77kTWb1mJmvvgndSK
 mdFitu9rCLUFT1YSnLXfTqHvuE4Zir2y0mbgbzGvqW0e+ObE5EKr06Zrsap7NCcXmY55cTY5ZNM
 cnDSze5SNSfqeEIQ28WQXTRpspVASPJnAyokznkZDUJhqT6tb30aKuEIfAPKr7HdU6lOrD1L+eH
 sAPRvpe+rCBCfLEi4tqF7qwIKiazx6yC+AtfxRw2ekngzh1+UyG8UukfCCMmvuXgkVqqBuHJRH3
 sXeOepnA1siWdM1YC5SDi8AlX18Jm2jDhoSSnEJi/3WQAcJPH4KWLox+EBPQ+KlMuu54PMo7sWw
 TL7Y03nPJHpb5mA7flNTDJo0QgDxFvhBPlYeWc4K93w==
X-Received: by 2002:a05:600c:8709:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4a1d75e6f32mr142061065e9.5.1792401114934; 
 Mon, 19 Oct 2026 02:11:54 -0700 (PDT)
X-Received: by 2002:a05:600c:8709:b0:4a1:7e77:c382 with SMTP id
 5b1f17b1804b1-4a1d75e6f32mr142060435e9.5.1792401114368; 
 Mon, 19 Oct 2026 02:11:54 -0700 (PDT)
Received: from vkuznets-thinkpadx1carbongen12.rmtcz.csb (g3.ign.cz.
 [91.219.240.17]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm505305865e9.1.2026.10.19.02.11.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:11:53 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Andrea Oliveri <oliveriandrea@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@oss.qualcomm.com>, kvm@vger.kernel.org, Andrea Oliveri
 <oliveriandrea@gmail.com>
Subject: Re: [PATCH] i386: Hyper-V nested sleep states enlightenment
In-Reply-To: <20261016234027.1002275-1-oliveriandrea@gmail.com>
References: <20261016234027.1002275-1-oliveriandrea@gmail.com>
Date: Mon, 19 Oct 2026 11:11:53 +0200
Message-ID: <kupbj8qt5pi.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.133.124; envelope-from=vkuznets@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Andrea Oliveri <oliveriandrea@gmail.com> writes:

> Hyper-V running nested on KVM (e.g. Windows with Virtualization-Based
> Security) allows hibernation of its root partition only if the parent
> hypervisor sets bit 20 of HV_CPUID_ENLIGHTMENT_INFO.EAX. KVM never sets
> it, so such guests report "The hypervisor does not support hibernation".
>
> Add a "hv-nested-sleep" property that sets the bit. It is a hint
> only and needs no KVM support. With it, Windows 11 26H2 with VBS,
> HVCI and Credential Guard hibernates and resumes.
>
> The nested hypervisor uses the bit for one more thing, on resume:
> instead of writing IA32_TSC itself, it issues hypercall 0x103 with the
> TSC and the parent reference time saved at suspend, asking the parent
> to restore its TSC. KVM returns HV_STATUS_INVALID_HYPERCALL_CODE;
> the nested hypervisor ignores the status and already compensates the
> TSC jump in software, so the guest clock stays correct.
>
> Signed-off-by: Andrea Oliveri <oliveriandrea@gmail.com>

Please take a look at the competing proposal:

QEMU:
https://lore.kernel.org/qemu-devel/20261005194057.10910-1-hmushi@amazon.co.uk/
KVM: https://lore.kernel.org/kvm/20261005192431.87317-4-hmushi@amazon.co.uk/

> ---
>  docs/system/i386/hyperv.rst    | 10 ++++++++++
>  target/i386/cpu.c              |  1 +
>  target/i386/cpu.h              |  1 +
>  target/i386/kvm/hyperv-proto.h |  1 +
>  target/i386/kvm/kvm.c          |  5 +++++
>  5 files changed, 18 insertions(+)
>
> diff --git a/docs/system/i386/hyperv.rst b/docs/system/i386/hyperv.rst
> index e1babffb0f..4b37d5536b 100644
> --- a/docs/system/i386/hyperv.rst
> +++ b/docs/system/i386/hyperv.rst
> @@ -187,6 +187,16 @@ Existing enlightenments
>    Note: enabling this feature on old hardware (without APICv/AVIC support) may
>    have negative effect on guest's performance.
>  
> +``hv-nested-sleep``
> +  Tells a guest that runs its own Hyper-V (Windows with Virtualization-Based
> +  Security, or with the Hyper-V role) that sleep states are supported for a
> +  nested hypervisor (CPUID 0x40000004.EAX bit 20). Without it, Hyper-V running
> +  on top of KVM disables hibernation (S4) for its root partition: Windows
> +  reports "The hypervisor does not support hibernation", and an S4 attempt
> +  makes the nested hypervisor reset the machine. No KVM support is needed: the
> +  bit is a hint only. On resume the nested hypervisor issues a hypercall that
> +  KVM does not implement; the nested hypervisor ignores the failure.
> +
>  ``hv-no-nonarch-coresharing`` = on/off/auto
>    This enlightenment tells guest OS that virtual processors will never share a
>    physical core unless they are reported as sibling SMT threads. This information
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 5da80ade70..9df628ed2a 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10797,6 +10797,7 @@ static const Property x86_cpu_properties[] = {
>                        HYPERV_FEAT_TLBFLUSH_DIRECT, 0),
>      DEFINE_PROP_ON_OFF_AUTO("hv-no-nonarch-coresharing", X86CPU,
>                              hyperv_no_nonarch_cs, ON_OFF_AUTO_OFF),
> +    DEFINE_PROP_BOOL("hv-nested-sleep", X86CPU, hyperv_nested_sleep, false),
>  #ifdef CONFIG_SYNDBG
>      DEFINE_PROP_BIT64("hv-syndbg", X86CPU, hyperv_features,
>                        HYPERV_FEAT_SYNDBG, 0),
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index e7a88074c0..bff8b1d192 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -2374,6 +2374,7 @@ struct ArchCPU {
>      uint64_t hyperv_features;
>      bool hyperv_passthrough;
>      OnOffAuto hyperv_no_nonarch_cs;
> +    bool hyperv_nested_sleep;
>      uint32_t hyperv_vendor_id[3];
>      uint32_t hyperv_interface_id[4];
>      uint32_t hyperv_limits[3];
> diff --git a/target/i386/kvm/hyperv-proto.h b/target/i386/kvm/hyperv-proto.h
> index a9f056f2f3..df6ce6ae42 100644
> --- a/target/i386/kvm/hyperv-proto.h
> +++ b/target/i386/kvm/hyperv-proto.h
> @@ -81,6 +81,7 @@
>  #define HV_EX_PROCESSOR_MASKS_RECOMMENDED   (1u << 11)
>  #define HV_ENLIGHTENED_VMCS_RECOMMENDED     (1u << 14)
>  #define HV_NO_NONARCH_CORESHARING           (1u << 18)
> +#define HV_NESTED_SLEEP_SUPPORTED           (1u << 20)
>  
>  /*
>   * HV_CPUID_SYNDBG_PLATFORM_CAPABILITIES.EAX bits
> diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
> index da922f72d7..76f1a37ea5 100644
> --- a/target/i386/kvm/kvm.c
> +++ b/target/i386/kvm/kvm.c
> @@ -1630,6 +1630,11 @@ static int hyperv_fill_cpuids(CPUState *cs,
>              HV_NO_NONARCH_CORESHARING;
>      }
>  
> +    /* Only a hint for a nested Hyper-V: no KVM support is needed */
> +    if (cpu->hyperv_nested_sleep) {
> +        c->eax |= HV_NESTED_SLEEP_SUPPORTED;
> +    }
> +
>      c = &cpuid_ent[cpuid_i++];
>      c->function = HV_CPUID_IMPLEMENT_LIMITS;
>      c->eax = cpu->hv_max_vps;

-- 
Vitaly


