Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C300FF8875
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:22:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISGL-0003yg-7w; Thu, 30 Apr 2026 10:21:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIRKs-00021n-07
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:21:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIRKp-0007nk-QK
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:21:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777555302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=QJw6N2v/JkfQVCKxICzxmYCCVk9Zx3+AhGLDJPo9hGk=;
 b=E93ehNWCu+UMJgll+LI0NN30lSmViId9Rw5qHmO1tZdER3GVevD6KsJrL35cZO9sGeogRZ
 Q6uIoMd9E0ulnGafiV8cg72Zhpq/WG56qEmO07Tvn52dhDPYV089Tg2H6Y2o591dhBr8Q5
 pkwqYGwrrm8uKToZYainZAuI3mgfo50=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-147-p4bzE12OPDSdyPZh3oPeAw-1; Thu,
 30 Apr 2026 09:21:37 -0400
X-MC-Unique: p4bzE12OPDSdyPZh3oPeAw-1
X-Mimecast-MFC-AGG-ID: p4bzE12OPDSdyPZh3oPeAw_1777555296
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3E70E1800364; Thu, 30 Apr 2026 13:21:35 +0000 (UTC)
Received: from [10.44.50.160] (unknown [10.44.50.160])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 6EE731955D84; Thu, 30 Apr 2026 13:21:30 +0000 (UTC)
Message-ID: <2faaf376-755d-447a-a10b-e9d9ed784c84@redhat.com>
Date: Thu, 30 Apr 2026 15:21:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/37] whpx: i386: add HV_X64_MSR_GUEST_IDLE when
 !kernel-irqchip
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
 <20260422214225.2242-23-mohamed@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260422214225.2242-23-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 4/22/26 23:42, Mohamed Mediouni wrote:
> Add support for an oddball HV_X64_MSR_GUEST_IDLE not-quite-an-HLT
> that wakes the vCPU even if EFLAGS.IF is set.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>

A couple changes I am making anyway when applying.

> ---
>   target/i386/whpx/whpx-all.c | 46 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 43 insertions(+), 3 deletions(-)
> 
> diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
> index cafcbf8bbb..f03f5a5115 100644
> --- a/target/i386/whpx/whpx-all.c
> +++ b/target/i386/whpx/whpx-all.c
> @@ -52,6 +52,7 @@
>   /* for kernel-irqchip=off */
>   #define HV_X64_MSR_APIC_FREQUENCY       0x40000023
>   #define HV_X64_MSR_VP_ASSIST_PAGE       0x40000073
> +#define HV_X64_MSR_GUEST_IDLE           0x400000f0
>   
>   static bool is_modern_os = true;
>   
> @@ -1628,13 +1629,16 @@ static vaddr whpx_vcpu_get_pc(CPUState *cpu, bool exit_context_valid)
>       }
>   }
>   
> -static int whpx_handle_halt(CPUState *cpu)
> +static int whpx_handle_halt_generic(CPUState *cpu)
>   {
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +
>       int ret = 0;
>   
>       bql_lock();
>       if (!(cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
> -          (cpu_env(cpu)->eflags & IF_MASK)) &&
> +          ((cpu_env(cpu)->eflags & IF_MASK) || env->hflags2 & HF2_HYPERV_HLT_MASK)) &&

This needs parentheses on the right side.

>           !cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
>           cpu->exception_index = EXCP_HLT;
>           cpu->halted = true;
> @@ -1645,6 +1649,27 @@ static int whpx_handle_halt(CPUState *cpu)
>       return ret;
>   }
>   
> +static int whpx_handle_halt(CPUState *cpu)
> +{
> +    int ret = 0;
> +
> +    ret = whpx_handle_halt_generic(cpu);
> +
> +    return ret;
> +}

This is useless.

> +
> +static int whpx_handle_hyperv_guestidle(CPUState *cpu)
> +{
> +    X86CPU *x86_cpu = X86_CPU(cpu);
> +    CPUX86State *env = &x86_cpu->env;
> +    int ret = 0;
> +
> +    env->hflags2 |= HF2_HYPERV_HLT_MASK;
> +    ret = whpx_handle_halt_generic(cpu);
> +
> +    return ret;
> +}
> +
>   static void whpx_vcpu_kick_out_of_hlt(CPUState *cpu)
>   {
>       WHV_REGISTER_VALUE reg;
> @@ -1848,9 +1873,10 @@ static void whpx_vcpu_process_async_events(CPUState *cpu)
>       }
>   
>       if ((cpu_test_interrupt(cpu, CPU_INTERRUPT_HARD) &&
> -         (env->eflags & IF_MASK)) ||
> +         ((env->eflags & IF_MASK) || env->hflags2 & HF2_HYPERV_HLT_MASK)) ||

More missing parentheses.

>           cpu_test_interrupt(cpu, CPU_INTERRUPT_NMI)) {
>           cpu->halted = false;
> +        env->hflags2 &= ~HF2_HYPERV_HLT_MASK;
>       }
>   
>       if (cpu_test_interrupt(cpu, CPU_INTERRUPT_SIPI)) {
> @@ -2120,6 +2146,20 @@ int whpx_vcpu_run(CPUState *cpu)
>                   }
>               }
>   
> +            /*
> +             * Windows and Linux both use this MSR.
> +             * Windows 11 25H2 uses it even when not advertised.
> +             */
> +            if (vcpu->exit_ctx.MsrAccess.MsrNumber == HV_X64_MSR_GUEST_IDLE
> +                && !vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite
> +                && !whpx_irqchip_in_kernel()
> +                && whpx->hyperv_enlightenments_enabled) {
> +                is_known_msr = 1;
> +                whpx_bump_rip(cpu, &vcpu->exit_ctx);
> +                ret = whpx_handle_hyperv_guestidle(cpu);
> +                break;
> +            }
> +
>               /*
>                * Linux tries to use it anyway even when not exposed.
>                * Ignore the write as the VP assist page is not used.


