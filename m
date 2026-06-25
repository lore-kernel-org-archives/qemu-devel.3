Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E634ACDE000
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:16:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcjvg-0002NJ-L8; Thu, 25 Jun 2026 09:15:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcjvc-0002Li-LD
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wcjva-0000SB-SW
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 09:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782393332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YNB/JJeizBNWu2ratlCr98caVDqXw0jkONCAhxSsozU=;
 b=KZtfGvPUOO9TutkPEV6ZdrgeVbkVKK6i+1ewdr4gDYLd+dfZRr9Znc+21t3gLlTtgN749Q
 zAb/h+8pyQSoxvCdso3XQMi0m/FVhtLX+ocZog0D9yRWlX3Zv9I0CIw6GyDxeYEHeTMnh+
 lHj4AIcDRdWX2x9MCsGPmoqJ3xUzwx4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-xt0WCzu8NvuFadQA0T5X-Q-1; Thu,
 25 Jun 2026 09:15:26 -0400
X-MC-Unique: xt0WCzu8NvuFadQA0T5X-Q-1
X-Mimecast-MFC-AGG-ID: xt0WCzu8NvuFadQA0T5X-Q_1782393325
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D80871873118; Thu, 25 Jun 2026 13:15:24 +0000 (UTC)
Received: from [10.44.33.146] (unknown [10.44.33.146])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5ED4518005B6; Thu, 25 Jun 2026 13:15:21 +0000 (UTC)
Message-ID: <26d4e782-ebbf-4a4f-a5f7-6fe107cc083f@redhat.com>
Date: Thu, 25 Jun 2026 15:15:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/mshv: mitigate early boot vcpu exit race
To: Magnus Kulke <magnuskulke@linux.microsoft.com>, qemu-devel@nongnu.org
Cc: Wei Liu <wei.liu@kernel.org>, Anirudh Rayabharam <anirudh@anirudhrb.com>, 
 aastharawat@microsoft.com, =?UTF-8?Q?Doru_Bl=C3=A2nzeanu?=
 <dblanzeanu@linux.microsoft.com>,
 Aastha Rawat <aastharawat@linux.microsoft.com>, magnuskulke@microsoft.com,
 Anirudh.Rayabharam@microsoft.com, liuwe@microsoft.com,
 doru.blanzeanu@microsoft.com
References: <20260521133433.48463-1-magnuskulke@linux.microsoft.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20260521133433.48463-1-magnuskulke@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On 5/21/26 15:34, Magnus Kulke wrote:
> When using the mshv accelerator, there is a high likelihood in early
> boot for a QMP execute::quit command to return w/o the QEMU process
> terminating.
> 
> The race is between SIG_IPI delivery and the vcpu thread's exec loop.
> qemu_cpu_kick() relies on SIG_IPI to make MSHV_RUN_VP return -EINTR so
> the vcpu thread can observe cpu->stop. During early boot, there are many
> PIO intercept exit produce MshvVmExitIgnore. That means the inner loop
> in mshv_cpu_exec() spins through RUN_VP ioctl -> handler -> RUN_VP
> ioctl, without being able to consult cpu->exit_request of cpu->stop.
> 
> The qemu_cpu_kick_self() in sa_ipi_handler() was practically a no-op,
> since it calls cpus_kick_thread() which itsself issues a SIG_IPI, in the
> handler for that signal. Hence it has been removed a made a practial
> noop. Once we have a facility in MSHV to signal immediate_exit to the
> kernel it should be used in this handler.
> 
> To mitigate we register a custom kick_vcpu_thread() impl for mshv, that
> will set cpu->exit_request before calling the generic kick_vcpu_thread()
> implement that will raise SIG_IPI.
> 
> We then observe cpu->exit request in the mshv_cpu_exec() inner loop and
> break with EXCP_INTERRUPT when set.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>   accel/mshv/mshv-all.c | 42 ++++++++++++++++++++++++++++++++++--------
>   1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 58af674bd9..a3593c67db 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -502,6 +502,18 @@ static int mshv_cpu_exec(CPUState *cpu)
>       cpu_exec_start(cpu);
>   
>       do {
> +        /*
> +         * We consider a pending exit_request before re-entering the guest.
> +         * This condition is set by mshv_kick_vcpu_thread(), so we unset
> +         * thread_kicked to allow future kicks to interrupt the guest.
> +         */
> +        if (qatomic_load_acquire(&cpu->exit_request)) {
> +            qatomic_set(&cpu->exit_request, false);
> +            qatomic_set_mb(&cpu->thread_kicked, false);


These two should not be needed.  The sequence of events is:

- exit from here

- "while (!cpu->unplug || cpu_can_run(cpu))" is still true

- qemu_process_cpu_events() runs:
   - set exit_request == false
   - cpu_thread_is_idle(cpu) is false due to cpu->stop == true
   - qemu_process_cpu_events_common() runs:
     - sets cpu->thread_kicked == false
     - qemu_cpu_stop() sets cpu->stopped == true

- cpu_can_run(cpu) is now false, so mshv_cpu_exec() does not run

- ... but !cpu->unplug is true -> another run around the loop

- now cpu_thread_is_idle(cpu) is true, so the thread goes to sleep.

> +            ret = EXCP_INTERRUPT;
> +            break;
> +        }


Also, for cleanliness I'd put the lines after the "if 
(cpu->accel->dirty)" immediately below.


> +/*
> + * mshv-custom kick implementation:
> + *
> + * We set cpu->exit_request before the SIG_IPI is delivered to the vcpu
> + * thread (as part of cpus_kick_thread()). It is consumed in the
> + * mshv_cpu_exec loop.
> + */
> +static void mshv_kick_vcpu_thread(CPUState *cpu)
> +{
> +    qatomic_set_mb(&cpu->exit_request, true);
> +    cpus_kick_thread(cpu);
> +}
> +

This should not be necessary, either.  In recent versions of QEMU, 
cpu->exit_request is set appropriately by cpu_exit(); see commits 
ac6c8a390b4 and f8217ae54e4 and nearby.

Accelerators can write cpu->exit_request, but only within the 
accelerator thread if they want to kick themselves out of cpu_exec(). 
For example, KVM does this to run kvm_arch_process_async_events(); but 
MSHV does not have anything similar.

Paolo


