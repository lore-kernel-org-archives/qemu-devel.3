Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26BDC61CE7
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Jun 2025 00:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNgz2-0000jy-2v; Fri, 06 Jun 2025 20:00:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nunodasneves@linux.microsoft.com>)
 id 1uNg96-0000Nx-Bl
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 19:06:44 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nunodasneves@linux.microsoft.com>)
 id 1uNg94-0007ND-7B
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 19:06:44 -0400
Received: from [100.64.96.210] (unknown [52.148.138.235])
 by linux.microsoft.com (Postfix) with ESMTPSA id E92F9201FF41;
 Fri,  6 Jun 2025 16:06:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E92F9201FF41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1749251199;
 bh=HqOoge/lTNqPzjjj+Fzb0ZGUe7l8smRccNjvfGKcty4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mQZ1j8nCTPgBlpvkCARZyBN77ni9ehBLDz97C/lHY7J7KuUZEqqzx+B2X8fH5DF0R
 yLp9FdzSofy7c6U+xa6Od4blJVldgj1TNLJZAFByfTIa1RcVF5qdBUG0BJ4MS57/r4
 8KXa/gCdZUx0LNcsALi3i/TU3NT2a+pbWmGB9ak0=
Message-ID: <52ffb2a1-4b93-4048-8efa-55677898f4f0@linux.microsoft.com>
Date: Fri, 6 Jun 2025 16:06:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/25] accel/mshv: Add vCPU creation and execution loop
To: Paolo Bonzini <pbonzini@redhat.com>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>, magnuskulke@microsoft.com,
 qemu-devel@nongnu.org, liuwe@microsoft.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>, Roman Bolshakov
 <rbolshakov@ddn.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cameron Esfahani <dirty@apple.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20250520113018.49569-1-magnuskulke@linux.microsoft.com>
 <20250520113018.49569-13-magnuskulke@linux.microsoft.com>
 <8b65b12c-ca3e-4528-9544-65784c862763@redhat.com>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <8b65b12c-ca3e-4528-9544-65784c862763@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=nunodasneves@linux.microsoft.com; helo=linux.microsoft.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 06 Jun 2025 20:00:22 -0400
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 5/20/2025 6:50 AM, Paolo Bonzini wrote:
> On 5/20/25 13:30, Magnus Kulke wrote:
>> +    int ret;
>> +    hv_message exit_msg = { 0 };
> 
> You probably don't want to fill 512 bytes on every vmentry.  Maybe pass &exit_msg up from mshv_cpu_exec()?
> 
>> +        /*
>> +         * Read cpu->exit_request before KVM_RUN reads run->immediate_exit.
>> +         * Matching barrier in kvm_eat_signals.
>> +         */
>> +        smp_rmb();
> 
> The comment is obviously wrong; unfortunately, the code is wrong too:
> 
> 1) qemu_cpu_kick_self() is only needed for an old KVM API.  In that API the signal handler is blocked while QEMU runs.  In your case, qemu_cpu_kick_self() is an expensive way to do nothing.
> 
> 2) Because of this, there's a race condition between delivering the signal and entering MSHV_RUN_VP
> 

Hi Paolo,

I might be misunderstanding something here, but isn't there a race condition regardless of where this check is made?
i.e., checking a flag in userspace, like the above:

if (qatomic_read(&cpu->exit_request)) {

vs checking the flag in the kernel, are effectively doing the same thing.
The signal can still come just after the check is made (in the kernel) and the VP will dispatch.

The virtual "explicit suspend" register in the VP seems to solve this problem - it can be used for manually kicking the VP
while it is running. But, it can also be set before dispatching the VP, and the dispatch hypercall will return immediately
in that case.

Thanks
Nuno

> You need support in the hypervisor for this: KVM and HVF both have it.
> 
> There are two ways to do it, for both cases the hypervisor side for the latter can be something like this:
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 72df774e410a..627afece4046 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -530,7 +530,7 @@ static long mshv_run_vp_with_root_scheduler(
>          struct hv_output_dispatch_vp output;
> 
>          ret = mshv_pre_guest_mode_work(vp);
> -        if (ret)
> +        if (ret || vp->run.flags.immediate_exit)
>              break;
> 
>          if (vp->run.flags.intercept_suspend)
> @@ -585,6 +585,7 @@
>          }
>      } while (!vp->run.flags.intercept_suspend);
> 
> +    vp->run.flags.immediate_exit = 0;
>      return ret;
>  }
> 
> 
> Instead of calling qemu_cpu_kick_self(), your signal handler would invoke a new MSHV ioctl that sets vp->run.flags.immediate_exit = 1.
> 
> And then you also don't need the barrier, by the way, because all inter-thread communication is mediated by the signal handler.
> 
> Paolo
> 
> 
> 


