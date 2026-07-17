Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C69C4451C
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2026 14:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkjnA-0005lL-RH; Fri, 17 Jul 2026 10:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dblanzeanu@linux.microsoft.com>)
 id 1wkjn9-0005lC-IG
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:43:55 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dblanzeanu@linux.microsoft.com>) id 1wkjn8-0001Ha-4v
 for qemu-devel@nongnu.org; Fri, 17 Jul 2026 10:43:55 -0400
Received: from linux.microsoft.com (unknown [86.121.140.206])
 by linux.microsoft.com (Postfix) with ESMTPSA id 904A620B7169;
 Fri, 17 Jul 2026 07:43:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 904A620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1784299421;
 bh=EiLUc2GBTkUIoaCbuVI1x8CA3a8PevF4PKzVdeXW9Qg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YqQo1j5OI6i1pX0M+wc/w9SUXb8F2yZZG8Du2iGmIN9YcG1ed8rNb+QTtqZSFH//d
 kDsTyUnvjdt91crDIOkAXRqP3iyTIREJrfA3eDTnP8c37GKvi/L7k1iDjXchPdBfq8
 exgISUQAiWg5UBecHvdpuE8vYbmgYHq78XlNegBg=
Date: Fri, 17 Jul 2026 17:43:39 +0300
From: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Magnus Kulke <magnuskulke@microsoft.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Wei Liu <wei.liu@kernel.org>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Subject: Re: [PATCH 04/12] accel/mshv: install dummy handler for SIG_IPI
Message-ID: <alo_m1CP5TKRZGBJ@linux.microsoft.com>
References: <20260710101534.664604-1-magnuskulke@linux.microsoft.com>
 <20260710101534.664604-5-magnuskulke@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260710101534.664604-5-magnuskulke@linux.microsoft.com>
Received-SPF: pass client-ip=13.77.154.182;
 envelope-from=dblanzeanu@linux.microsoft.com; helo=linux.microsoft.com
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

On Fri, Jul 10, 2026 at 12:15:26PM +0200, Magnus Kulke wrote:
> This is similar to HVF's implementation. We want to interrupt the blocking
> vcpu run. The self-kick was effectively a no-op for mshv.
> 
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index 7b3c13cf1e..f9511ca050 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -621,17 +621,13 @@ static int mshv_cpu_exec(CPUState *cpu)
>  }
>  
>  /*
> - * The signal handler is triggered when QEMU's main thread receives a SIG_IPI
> - * (SIGUSR1). This signal causes the current CPU thread to be kicked, forcing a
> - * VM exit on the CPU. The VM exit generates an exit reason that breaks the loop
> - * (see mshv_cpu_exec). If the exit is due to a Ctrl+A+x command, the system
> - * will shut down. For other cases, the system will continue running.
> + * We need a dummy handler to make SIG_IPI a deliverable signal. The kernel
> + * handler will be woken up by the caught signal and instruct the hypervisor
> + * to suspend execution (the concrete mechanism differs between schedulers)
> + * and return to userspace.
>   */
> -static void sa_ipi_handler(int sig)
> +static void dummy_handler(int sig)
>  {
> -    /* TODO: call IOCTL to set_immediate_exit, once implemented. */
> -
> -    qemu_cpu_kick_self();
>  }
>  
>  static void init_signal(CPUState *cpu)
> @@ -641,7 +637,7 @@ static void init_signal(CPUState *cpu)
>      sigset_t set;
>  
>      memset(&sigact, 0, sizeof(sigact));
> -    sigact.sa_handler = sa_ipi_handler;
> +    sigact.sa_handler = dummy_handler;
>      sigaction(SIG_IPI, &sigact, NULL);
>  
>      pthread_sigmask(SIG_BLOCK, NULL, &set);
> -- 
> 2.34.1

Reviewed-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>

