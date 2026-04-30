Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4E5CCCFA13
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 14:21:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wISFw-0003su-LS; Thu, 30 Apr 2026 10:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIRfu-0006F8-AR
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:43:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIRfs-0001FB-7E
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 09:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777556606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Tnpun3S7hYr75FrrnF0LzR2AlCohcHbUd1yYrXTr5Zs=;
 b=GwWT29v3ub68TG1MDJ4sJX0bo+FjjYug4dukLpryuLqhz4+jh4Bk3jzZOL360eEyk6ONpz
 0jGx/7lU7Vmzo0/V9b0XAmEDr1g5+cvdeILcOD7TeP2CJh6j1Sf0XZehcTwrTTZfZ5QzHz
 zNs5rpOax0awJIIJklku4HwdlJ/tYc4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-561-p-UdgYsMNmS6SQTJEGwTJw-1; Thu,
 30 Apr 2026 09:43:21 -0400
X-MC-Unique: p-UdgYsMNmS6SQTJEGwTJw-1
X-Mimecast-MFC-AGG-ID: p-UdgYsMNmS6SQTJEGwTJw_1777556598
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 568E71800601; Thu, 30 Apr 2026 13:43:17 +0000 (UTC)
Received: from [10.44.50.160] (unknown [10.44.50.160])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DB58519560A6; Thu, 30 Apr 2026 13:43:13 +0000 (UTC)
Message-ID: <eb93bdfd-02db-4cf1-929d-fbb14dbb4c98@redhat.com>
Date: Thu, 30 Apr 2026 15:43:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 21/37] target: i386: HLT type that ignores EFLAGS.IF
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: Pedro Barbuda <pbarbuda@microsoft.com>, qemu-arm@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Wei Liu <wei.liu@kernel.org>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
References: <20260422214225.2242-1-mohamed@unpredictable.fr>
 <20260422214225.2242-22-mohamed@unpredictable.fr>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260422214225.2242-22-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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
> The TLFS says:
> 
>> A partition which possesses the AccessGuestIdleMsr privilege may trigger
>> entry into the virtual processor idle sleep state through a read to the
>> hypervisor-defined MSR HV_X64_MSR_GUEST_IDLE. The virtual processor will
>> be woken when an interrupt arrives, regardless of whether the interrupt
>> is enabled on the virtual processor or not.
> 
> Meanwhile, Windows 24H2+ calls this MSR anyway without the privilege being set.
> 
> Add the infrastructure to support it on the generic QEMU side.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   target/i386/cpu.c | 10 ++++++----
>   target/i386/cpu.h |  2 ++
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index a5f1a1a8fd..c9ed9b7580 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -10474,13 +10474,15 @@ int x86_cpu_pending_interrupt(CPUState *cs, int interrupt_request)
>                      (((env->hflags2 & HF2_VINTR_MASK) &&
>                        (env->hflags2 & HF2_HIF_MASK)) ||
>                       (!(env->hflags2 & HF2_VINTR_MASK) &&
> -                     (env->eflags & IF_MASK &&
> -                      !(env->hflags & HF_INHIBIT_IRQ_MASK))))) {
> +                     ((env->eflags & IF_MASK &&
> +                      !(env->hflags & HF_INHIBIT_IRQ_MASK))
> +                        || env->hflags2 & HF2_HYPERV_HLT_MASK)))) {
>               return CPU_INTERRUPT_HARD;
>           } else if (env->hflags2 & HF2_VGIF_MASK) {
>               if((interrupt_request & CPU_INTERRUPT_VIRQ) &&
> -                   (env->eflags & IF_MASK) &&
> -                   !(env->hflags & HF_INHIBIT_IRQ_MASK)) {
> +                   ((env->eflags & IF_MASK &&
> +                      !(env->hflags & HF_INHIBIT_IRQ_MASK))
> +                        || env->hflags2 & HF2_HYPERV_HLT_MASK)) {

This should be a new function, and for simplicity it can also be used in 
hvf_inject_interrupts().

I'll do this when applying.

Paolo

>                           return CPU_INTERRUPT_VIRQ;
>               }
>           }
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0b539155c4..67f508dc10 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -225,6 +225,7 @@ typedef enum X86Seg {
>   #define HF2_NPT_SHIFT            6 /* Nested Paging enabled */
>   #define HF2_IGNNE_SHIFT          7 /* Ignore CR0.NE=0 */
>   #define HF2_VGIF_SHIFT           8 /* Can take VIRQ*/
> +#define HF2_HYPERV_HLT_SHIFT     9 /* Hyper-V HV_X64_MSR_GUEST_IDLE */
>   
>   #define HF2_GIF_MASK            (1 << HF2_GIF_SHIFT)
>   #define HF2_HIF_MASK            (1 << HF2_HIF_SHIFT)
> @@ -235,6 +236,7 @@ typedef enum X86Seg {
>   #define HF2_NPT_MASK            (1 << HF2_NPT_SHIFT)
>   #define HF2_IGNNE_MASK          (1 << HF2_IGNNE_SHIFT)
>   #define HF2_VGIF_MASK           (1 << HF2_VGIF_SHIFT)
> +#define HF2_HYPERV_HLT_MASK     (1 << HF2_HYPERV_HLT_SHIFT)
>   
>   #define CR0_PE_SHIFT 0
>   #define CR0_MP_SHIFT 1


