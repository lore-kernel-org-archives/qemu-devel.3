Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBB05C982FA
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2026 11:28:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9L8w-0001Gu-Bm; Wed, 23 Sep 2026 07:28:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <magnuskulke@linux.microsoft.com>)
 id 1x9L8o-0001GV-Rr
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:27:58 -0400
Received: from linux.microsoft.com ([13.77.154.182])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <magnuskulke@linux.microsoft.com>) id 1x9L8j-0000E5-5p
 for qemu-devel@nongnu.org; Wed, 23 Sep 2026 07:27:57 -0400
Received: from example.com (unknown [167.220.208.66])
 by linux.microsoft.com (Postfix) with ESMTPSA id 67BF120B7168;
 Wed, 23 Sep 2026 04:26:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67BF120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790162820;
 bh=PMWAOuTEXXnJ0sZoYdpLHdpG3urFjnkjpUgV0G4FqAA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=m0X4/wup97EZrULoRLPBLZZfBLgxOoduW5qKXOQBDqrDI17fdXG43uJo1107twlm5
 S2NhgTMyeAAzTI/9VZ8eZ7MdzHnc0AC5FcOIEqD9Sn0NDZnNMfuC3ZRo32xIxzY3Ir
 YTSRZMwgarc46m4qYQrB/0TGUdCfuBcWR/a7p2P4=
Date: Wed, 23 Sep 2026 13:27:44 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@linux.microsoft.com>
Cc: qemu-devel@nongnu.org, Wei Liu <liuwe@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Magnus Kulke <magnuskulke@microsoft.com>,
 Doru =?iso-8859-1?Q?Bl=E2nzeanu?= <dblanzeanu@microsoft.com>
Subject: Re: [PATCH v2 4/4] accel/mshv: break the vCPU run loop on exit_request
Message-ID: <arO3sK51FSE7LyLD@example.com>
References: <20260731184643.89604-1-dblanzeanu@linux.microsoft.com>
 <20260731184643.89604-5-dblanzeanu@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731184643.89604-5-dblanzeanu@linux.microsoft.com>
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

On Fri, Jul 31, 2026 at 09:46:42PM +0300, Doru Blânzeanu wrote:
> Ignored VM exits can cause mshv_cpu_exec() to re-enter MSHV_RUN_VP
> without returning to qemu_process_cpu_events(). A busy vCPU may
> prevent pause_all_vcpus() from completing.
> 
> Check exit_request before re-entering MSHV_RUN_VP and return
> EXCP_INTERRUPT so pending stop requests can be processed.
> 
> Signed-off-by: Doru Blânzeanu <dblanzeanu@linux.microsoft.com>
> ---
>  accel/mshv/mshv-all.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/accel/mshv/mshv-all.c b/accel/mshv/mshv-all.c
> index afcb87b3b8..b7c1126fe0 100644
> --- a/accel/mshv/mshv-all.c
> +++ b/accel/mshv/mshv-all.c
> @@ -780,6 +780,16 @@ static int mshv_cpu_exec(CPUState *cpu)
>              cpu->vcpu_dirty = false;
>          }
>  
> +        /*
> +         * A kick/stop can't reliably break MSHV_RUN_VP out, so leave the run
> +         * loop here too; otherwise a busy vCPU never reaches
> +         * qemu_process_cpu_events() and pause_all_vcpus() hangs under the BQL.
> +         */
> +        if (cpu->stop || qatomic_load_acquire(&cpu->exit_request)) {
> +            ret = EXCP_INTERRUPT;
> +            break;
> +        }
> +
>          ret = mshv_run_vcpu(mshv_state->vm, cpu, &mshv_msg, &exit_reason);
>          if (ret < 0) {
>              error_report("Failed to run on vcpu %d", cpu->cpu_index);
> -- 
> 2.53.0

This is already fixed in upstream. checking the cpu->stop flag doesn't
seem to be required and other accelerators do not seem to check it
either. We agreed to drop this patch for now.

