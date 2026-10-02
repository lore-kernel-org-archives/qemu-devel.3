Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E51BCA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 00:55:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCRXU-00069W-RA; Thu, 01 Oct 2026 20:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCRXQ-00068y-Uh
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 20:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1xCRXO-0001B9-7g
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 20:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790902448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UIuUoxFqAzBRNm/KfmC9YauHU6KyCv+jklWR5oFxcwk=;
 b=S4XU0dzH6y2l46YDVPgFMOv7t9YAAKd8sD+dcjriVdGPPYAvF7LDQa9KzvHgCc06BiVtuN
 I1KLkSvNcBNERo4zD7fw9hvqMNG2PlBG9A+Vaf0x3JKo5p/GJq3wm+8dVknhldUzxuguaz
 TNOvi/gcM14y1z3x7Rq22zMtVClUy8w=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-U1I2V2TYMNq9U740qp0WwA-1; Thu, 01 Oct 2026 20:54:07 -0400
X-MC-Unique: U1I2V2TYMNq9U740qp0WwA-1
X-Mimecast-MFC-AGG-ID: U1I2V2TYMNq9U740qp0WwA_1790902446
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3a6d30f66c9so357399a91.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 17:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1790902446; x=1791507246; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=UIuUoxFqAzBRNm/KfmC9YauHU6KyCv+jklWR5oFxcwk=;
 b=NM50RwbptyGp7K49lqVepyTdKH3s9Kmd/uH1AnQdeZK4lf2krwBx0le15Ls3ih8i+T
 FXMrYNJiQQAzTuz3JYEli+Vi69Ip3tf3elbDn3lrP6/HAkT/Av2I+74Y4HPJnpNsX+jU
 HvlZtCnRYbNAEZB7iYa7HF1rzudKmK6bcFjj8M0O8AlJlvJchq+zLPwI4MlY1YZJodeY
 3eZ3DH+qR+w6sTMJqkq14iB4A0PR6DZs2EDZ/dsQb/CxzJij4b2k3jAmXdOzoq2rP/yf
 FU5iFfgJgDhTdA9S6Lmij6E1O4GTzQ0cDciZ1Pvbow9VuHpZYfeBmq3+qn7LtWNeXQCc
 KMXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790902446; x=1791507246;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UIuUoxFqAzBRNm/KfmC9YauHU6KyCv+jklWR5oFxcwk=;
 b=TB+1YvZpVtFKLexpHl0XYsSt4N/f+37Cz5X9fXLMfC0rJ2k79xWM32G1HAythMLZBt
 CVcVy/wXYf+5tvG01Ezog8R583WF7bKzmnYoa/FFhiTaf6CLz5gUPdPxKnGLF5ALywxM
 +mSXaMhhFztQaGJHJ2tu6OqIG9gS1gaf8RsujWSQbEFDjZWu/OppFBwDK+tBazMhQJMf
 rnFCGay2W4uTmr+9yplckLPT4e6z5mh3s8W47in+3D/le/fmh8j6uLA3TIWe/Uw9Pa2Q
 TXrmwhdpEvQeblzDWVaXW57Pfk8GAtw5x84wGtLidHFa7szKua4fMPqybeh7KicprRz+
 YB0Q==
X-Gm-Message-State: AFq9FYI+jJeIOpqVm4DsLvF+/JO8aeOAr7AP1PRwDYgnUzr3I2G2DikQ
 CtznQnz82gGZAT0Zz0KxRJ2Zpdee09ihE1aEMR3OQ+j65Fe/4p/lnmmcS0dA2gKA8rtplVlop0o
 lRFKmsU4EssU0jRge4vZ2zfDBzaWSz9Nzw1c78aXR3TV1SdJmS9m37ARD
X-Gm-Gg: AYBFou2FQSkDE6YKWDRtVjS5PfDp2ArR4URCPKSn9Bm/ZdyUwjavK2MDqjmxg0slbT2
 kMJ6Q86Zb2l5wZFzgqpEBgmdJZ4xppHCmU5E7Kw1Q7qfBeJyKw/+YHJN5kZexanFIzy78Aq4WEw
 x8a6PNFgMbbBJGngJ6whPX3uzzNTO2mINtap8+L742lTuw9t6zTfCZIpbEJpHsOftItSiNKLEH2
 bSsiwO2Z/5Rqt3eHTOVVzsn7swyDiZZTfvWlhhacz4z1MNAb70g8nwLE4v7bOp3h83HrYtyq6jv
 2ikpeMoE6WQdJ/JwtWq5mJX/bpATWLLHZvtpc1AbbXduubzr6zIDxIaLK6TSFNy08CTAu77TRfK
 UuzpmUnOKjORy6DTO5cYTRgnzU0w4s9EY47nx8iPY8w==
X-Received: by 2002:a17:90b:1c82:b0:3a0:c85a:ee12 with SMTP id
 98e67ed59e1d1-3a6cec91c89mr805498a91.41.1790902446253; 
 Thu, 01 Oct 2026 17:54:06 -0700 (PDT)
X-Received: by 2002:a17:90b:1c82:b0:3a0:c85a:ee12 with SMTP id
 98e67ed59e1d1-3a6cec91c89mr805451a91.41.1790902444814; 
 Thu, 01 Oct 2026 17:54:04 -0700 (PDT)
Received: from [192.168.68.52] (n175-34-8-244.mrk21.qld.optusnet.com.au.
 [175.34.8.244]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4709a7csm6448906a91.8.2026.10.01.17.54.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 17:54:04 -0700 (PDT)
Message-ID: <a3a01282-bf89-46b8-b15c-9dc5f93053ee@redhat.com>
Date: Fri, 2 Oct 2026 10:53:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v4 06/24] target/arm/kvm-rme: Initialize vCPU
To: Mathieu Poirier <mathieu.poirier@linaro.org>, berrange@redhat.com,
 kchamart@redhat.com, pierrick.bouvier@oss.qualcomm.com,
 peter.maydell@linaro.org, mst@redhat.com, cohuck@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, armbru@redhat.com,
 lorenzo.pieralisi@linaro.org, enju.kohei@fujitsu.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, kvm@vger.kernel.org
References: <20260903193611.1058589-1-mathieu.poirier@linaro.org>
 <20260903193611.1058589-7-mathieu.poirier@linaro.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20260903193611.1058589-7-mathieu.poirier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.331,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 9/4/26 5:35 AM, Mathieu Poirier wrote:
> From: Jean-Philippe Brucker <jean-philippe@linaro.org>
> 
> The target code calls kvm_arm_vcpu_init() to mark the vCPU as part of a
> Realm. For a Realm vCPU, only x0-x7 can be set at runtime. Before boot,
> the PC can also be set, and is ignored at runtime. KVM also accepts a
> few system register changes during initial configuration, as returned by
> KVM_GET_REG_LIST.
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> ---
>   target/arm/cpu.h      |  3 +++
>   target/arm/kvm-rme.c  |  9 ++++++++
>   target/arm/kvm-stub.c |  5 ++++
>   target/arm/kvm.c      | 54 +++++++++++++++++++++++++++++++++++++++++--
>   target/arm/kvm_arm.h  | 10 ++++++++
>   5 files changed, 79 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index e3f931dba26b..6bbc942f9a59 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1054,6 +1054,9 @@ struct ArchCPU {
>       /* KVM steal time */
>       OnOffAuto kvm_steal_time;
>   
> +    /* Realm Management Extension */
> +    bool kvm_rme;
> +

This field seems redundant to MachineState::cgs since all vCPUs support RME
(Realm Management Extension) when MachineState::cgs points a valid instance.
So I'm wandering why we need to maintain the redundant information here?

>       /* Uniprocessor system with MP extensions */
>       bool mp_is_up;
>   
> diff --git a/target/arm/kvm-rme.c b/target/arm/kvm-rme.c
> index a4a5e195c196..f7c2cc786e2c 100644
> --- a/target/arm/kvm-rme.c
> +++ b/target/arm/kvm-rme.c
> @@ -69,6 +69,15 @@ static int kvm_arm_rme_init(ConfidentialGuestSupport *cgs, Error **errp)
>       return 0;
>   }
>   
> +void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> +{
> +    if (!rme_guest) {
> +        return;
> +    }
> +
> +    cpu->kvm_rme = true;
> +}
> +

This could be simplified to:

       cpu->kvm_rme = !!rme_guest;

>   static void rme_guest_class_init(ObjectClass *oc, const void *data)
>   {
>       ConfidentialGuestSupportClass *klass = CONFIDENTIAL_GUEST_SUPPORT_CLASS(oc);
> diff --git a/target/arm/kvm-stub.c b/target/arm/kvm-stub.c
> index 88cbe8d85c41..5fde96f9b281 100644
> --- a/target/arm/kvm-stub.c
> +++ b/target/arm/kvm-stub.c
> @@ -119,3 +119,8 @@ char *kvm_print_register_name(uint64_t regidx)
>   {
>       g_assert_not_reached();
>   }
> +
> +void kvm_arm_rme_vcpu_init(ARMCPU *cpu)
> +{
> +    g_assert_not_reached();
> +}
> diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> index 33c3763aebfa..b4c6da1fb9f3 100644
> --- a/target/arm/kvm.c
> +++ b/target/arm/kvm.c
> @@ -2015,6 +2015,8 @@ int kvm_arch_init_vcpu(CPUState *cs)
>           cpu->kvm_init_features[0] |= 1 << KVM_ARM_VCPU_HAS_EL2;
>       }
>   
> +    kvm_arm_rme_vcpu_init(cpu);
> +
>       /* Do KVM_ARM_VCPU_INIT ioctl */
>       ret = kvm_arm_vcpu_init(cpu);
>       if (ret) {
> @@ -2169,6 +2171,29 @@ static int kvm_arch_put_sve(CPUState *cs, uint32_t vq, bool have_ffr)
>       return 0;
>   }
>   
> +static int kvm_arm_rme_put_core_regs(CPUState *cs, Error **errp)
> +{
> +    int i, ret;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    /* The RME ABI only allows us to set 8 GPRs and the PC */
> +    for (i = 0; i < 8; i++) {
> +        ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
> +                              &env->xregs[i]);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    ret = kvm_set_one_reg(cs, AARCH64_CORE_REG(regs.pc), &env->pc);
> +    if (ret) {
> +        return ret;
> +    }
> +
> +    return 0;
> +}
> +
>   static int kvm_arm_put_core_regs(CPUState *cs, Error **errp)
>   {
>       uint64_t val;
> @@ -2280,7 +2305,11 @@ int kvm_arch_put_registers(CPUState *cs, KvmPutState level, Error **errp)
>       int ret;
>       ARMCPU *cpu = ARM_CPU(cs);
>   
> -    ret = kvm_arm_put_core_regs(cs, errp);
> +    if (cpu->kvm_rme) {
> +        ret = kvm_arm_rme_put_core_regs(cs, errp);
> +    } else {
> +        ret = kvm_arm_put_core_regs(cs, errp);
> +    }
>       if (ret) {
>           return ret;
>       }
> @@ -2367,6 +2396,23 @@ static int kvm_arch_get_sve(CPUState *cs, uint32_t vq, bool have_ffr)
>       return 0;
>   }
>   
> +static int kvm_arm_rme_get_core_regs(CPUState *cs, Error **errp)
> +{
> +    int i, ret;
> +    ARMCPU *cpu = ARM_CPU(cs);
> +    CPUARMState *env = &cpu->env;
> +
> +    for (i = 0; i < 8; i++) {
> +        ret = kvm_get_one_reg(cs, AARCH64_CORE_REG(regs.regs[i]),
> +                              &env->xregs[i]);
> +        if (ret) {
> +            return ret;
> +        }
> +    }
> +
> +    return 0;
> +}
> +
>   static int kvm_arm_get_core_regs(CPUState *cs, Error **errp)
>   {
>       uint64_t val;
> @@ -2478,7 +2524,11 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>       int ret;
>       ARMCPU *cpu = ARM_CPU(cs);
>   
> -    ret = kvm_arm_get_core_regs(cs, errp);
> +    if (cpu->kvm_rme) {
> +        ret = kvm_arm_rme_get_core_regs(cs, errp);
> +    } else {
> +        ret = kvm_arm_get_core_regs(cs, errp);
> +    }
>       if (ret) {
>           return ret;
>       }
> diff --git a/target/arm/kvm_arm.h b/target/arm/kvm_arm.h
> index e7c40fb003e4..d95381c13afa 100644
> --- a/target/arm/kvm_arm.h
> +++ b/target/arm/kvm_arm.h
> @@ -240,4 +240,14 @@ void arm_gic_cap_kvm_probe(GICCapability *v2, GICCapability *v3);
>    */
>   char *kvm_print_register_name(uint64_t regidx);
>   
> +/**
> + * kvm_arm_rme_vcpu_init
> + * @cs: the CPU
> + *
> + * If the user requested a Realm, setup the given vCPU accordingly. Realm vCPUs
> + * behave a little differently, for example most of their register state is
> + * hidden from the host.
> + */
> +void kvm_arm_rme_vcpu_init(ARMCPU *cpu);
> +

The comments here look outdated. This function simply set ARMCPU::kvm_rme to indicate
RME should be supported for this given vCPU. So the comments would be something as
below.

     /*
      *
      * Mark that RME (Realm Management Extension) should be supported for the given
      * vCPU if user has requested it. Realm vCPUs behave a little differently, for
      * example most of their register states are confidential and invisible to us.
      */

>   #endif

Thanks,
Gavin


