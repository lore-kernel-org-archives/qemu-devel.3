Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C795C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:27:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiQ3-0002R8-ER; Mon, 06 Jul 2026 08:27:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1wgiQ1-0002QQ-Ly
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:27:25 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1wgiQ0-0007t2-3r
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:27:25 -0400
Received: from example.com (unknown [167.220.208.42])
 by linux.microsoft.com (Postfix) with ESMTPSA id DF6B120B716B;
 Mon,  6 Jul 2026 05:27:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF6B120B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1783340838;
 bh=0bAE7c2UQvxx+xpDxsMBlky0481qvgVvFroyD0YvywE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=P/o155POu/lW5xHvHnk+F46gd9B3Gw9IgKeuoDInbSWSopXv4i0t8c4I7SgLaPvol
 i0LiobnSb92e6Gy9RN9VGNsJmQBHvmjNtwOqHKEcfjjt5lROStYPFq8NVRY3HYVpxO
 lUf+wO6rIymOYbLMmKx02Uld5g0sQIBTWTgOceRI=
Date: Mon, 6 Jul 2026 14:27:16 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Wei Liu <wei.liu@kernel.org>,
 Anirudh Rayabharam <anirudh@anirudhrb.com>, aastharawat@microsoft.com,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Aastha Rawat <aastharawat@linux.microsoft.com>,
 magnuskulke@microsoft.com, Anirudh.Rayabharam@microsoft.com,
 liuwe@microsoft.com, doru.blanzeanu@microsoft.com
Subject: Re: [PATCH] accel/mshv: mitigate early boot vcpu exit race
Message-ID: <akufJAci7WqN4JSB@example.com>
References: <20260521133433.48463-1-magnuskulke@linux.microsoft.com>
 <26d4e782-ebbf-4a4f-a5f7-6fe107cc083f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <26d4e782-ebbf-4a4f-a5f7-6fe107cc083f@redhat.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=magnuskulke@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jun 25, 2026 at 03:15:16PM +0200, Paolo Bonzini wrote:
> 
> These two should not be needed.  The sequence of events is:
> 
> - exit from here
> 
> - "while (!cpu->unplug || cpu_can_run(cpu))" is still true
> 
> - qemu_process_cpu_events() runs:
>   - set exit_request == false
>   - cpu_thread_is_idle(cpu) is false due to cpu->stop == true
>   - qemu_process_cpu_events_common() runs:
>     - sets cpu->thread_kicked == false
>     - qemu_cpu_stop() sets cpu->stopped == true
> 
> - cpu_can_run(cpu) is now false, so mshv_cpu_exec() does not run
> 
> - ... but !cpu->unplug is true -> another run around the loop
> 
> - now cpu_thread_is_idle(cpu) is true, so the thread goes to sleep.
> 
> > +            ret = EXCP_INTERRUPT;
> > +            break;
> > +        }
> 
> 
> Also, for cleanliness I'd put the lines after the "if (cpu->accel->dirty)"
> immediately below.
> 
> 
> > +/*
> > + * mshv-custom kick implementation:
> > + *
> > + * We set cpu->exit_request before the SIG_IPI is delivered to the vcpu
> > + * thread (as part of cpus_kick_thread()). It is consumed in the
> > + * mshv_cpu_exec loop.
> > + */
> > +static void mshv_kick_vcpu_thread(CPUState *cpu)
> > +{
> > +    qatomic_set_mb(&cpu->exit_request, true);
> > +    cpus_kick_thread(cpu);
> > +}
> > +
> 
> This should not be necessary, either.  In recent versions of QEMU,
> cpu->exit_request is set appropriately by cpu_exit(); see commits
> ac6c8a390b4 and f8217ae54e4 and nearby.
> 
> Accelerators can write cpu->exit_request, but only within the accelerator
> thread if they want to kick themselves out of cpu_exec(). For example, KVM
> does this to run kvm_arch_process_async_events(); but MSHV does not have
> anything similar.
> 
> Paolo

I see, we indeed just need to honor cpu->exit_request in the loop and
break out if it is set, this only seems to be address the issue that the
patch was attempting to fix. Since we also need to it for the migration
case, I submit a revised patch as part of a migration series, so we can
abandon this one.

thanks!

magnus

