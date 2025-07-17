Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5E8C83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Jul 2025 08:03:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucJZR-0008Ep-Pb; Thu, 17 Jul 2025 04:02:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1ucJZP-0008Dm-Ny
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:02:23 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1ucJZN-0006C3-I0
 for qemu-devel@nongnu.org; Thu, 17 Jul 2025 04:02:23 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b5e6bfb427so343158f8f.2
 for <qemu-devel@nongnu.org>; Thu, 17 Jul 2025 01:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1752739339; x=1753344139; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=HOG8D/7qNCJPh9MwkO3VKDHXwHmSWp6l5mw9j64kA5A=;
 b=Hz2t723czXG6AID2Oi5OvDFzRDjUWBhF7SFZEufGpbTW7WkURgDgNdGTRbY5/91I8H
 FKFAjX67dwbB/ZhdRtHjHRUtO+SwUNucDO92GW1wBYMy88xBEIZZCIOabAjCxnGo19nX
 0AAKWiGjRRRT/nd5Lx5hYCzq2Bgf7WgjDrYisq0y/FhT0otRM3buxwdz/YTMAFA0by0T
 X5qLkY/MtyLLqXi2S8NrCNTJQb5QtRt4IljvoJw4YUX1N4EkH0u2QIAqlRuHVhehIACp
 IA6CIh1u3rZ8zrtEeAc3cMSkUMF1pyS22Xmu5d4lABWN6SILeBL8S0AdsYLy5O1tJNpr
 qjoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752739339; x=1753344139;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HOG8D/7qNCJPh9MwkO3VKDHXwHmSWp6l5mw9j64kA5A=;
 b=hUibcLPF5RS+TNlmP3Y1mZgfhG3kGiRhHw7lCCiptRwUJWHDHR4eSxgpj33SbkJZU2
 YCSVWbv1YQUp/rt5Toy0hxWUlK8Nmg6Pk7Fx2YckJbB/LytkyIP9Ue/zvgUcj5oQ+5O1
 RRnj6PYRV54uMORaLpfiY5RPSx7gATUF5daV9dyckBxKWR10ySBoHveYoUj3L3PFboGh
 xHgGs3EnkPVWWZnbP93En4MjHobZpG+fI1zhWu/YSSr4HTcjf2HMwObp4Lx2mUgVb/86
 U8rslDaTv4/NnqeOMtcOqCQ5vqBKHev+qGFixFuEEoDgwAUnZP2MkOBSDg41AutmkLv7
 Rz/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCW19BrPwUzIoVapnMbW5dTtqlgYpWCkrvsrJ+SUz0msKCKkeGiThx/ELKhIOcQjLRaqhDO8X3WfoK2E@nongnu.org
X-Gm-Message-State: AOJu0Yzvs51vwSOR/dOWMaAGlzks0ytCbuiF65X3sekTMh9Oe0hGi9BR
 efl5Z11u2iBunPYBV8X7tvT7qoFntyCmlFoxNuNHF1GSiu/2mpsTSlClIVYAX0SIDKk=
X-Gm-Gg: ASbGncv0vmbjskqNB7OQ8NUIEAezXiL422MBZ7YZVoot1y6mnJVEwwt+m9Rrwnl+WEf
 zoKI1JfU3UrCADLO5o/gkZQ4Q5DerwUeBH3zcccrqLpGvJspHbq4GFbC9CYY8AJgh4ElJUHztCc
 YlNprn7OjqblWzwtVcmBB/H1h051ogFyj+k7e7+aEVpLtrCO9AS4hHKrxY8EK+pAlVnl06sqWa1
 gpTHxf1XYeu+KBjacz6TaLwax3PrC9KukAHveTRcEN5md0LV0rvbhLUNd76ox5UJiT1xzpciN7s
 DmIzA21GC94BOewC6tCZ8YsZZkp2LhXxHncgpAbfHsTcuMM+8FNf3VP8u0PfjthQD4OvUvHYsHV
 3FY5YERVPzqju8sAH6ZImKexQfihLDIBkQESnyJVsHVVGyRAVdz4=
X-Google-Smtp-Source: AGHT+IGrftFiGVlU9vXuB+tdE077r7cOuoYsNNGzgqsYn8mgt9BRQHGUV0E8D5YsPfrg9By2Re6uPw==
X-Received: by 2002:a05:6000:2489:b0:3b6:c88:7b74 with SMTP id
 ffacd0b85a97d-3b60dd918b1mr5023685f8f.59.1752739338953; 
 Thu, 17 Jul 2025 01:02:18 -0700 (PDT)
Received: from localhost (cst2-173-14.cust.vodafone.cz. [31.30.173.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd1647sm19923825f8f.1.2025.07.17.01.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Jul 2025 01:02:18 -0700 (PDT)
Date: Thu, 17 Jul 2025 10:02:12 +0200
From: Andrew Jones <ajones@ventanamicro.com>
To: BillXiang <xiangwencheng@lanxincomputing.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] target/riscv/kvm: Introduce simple handler for VS-file
 allocation failure
Message-ID: <20250717-f8c5ad3a56fbd7cf24224853@orel>
References: <20250716074738.1075-1-xiangwencheng@lanxincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250716074738.1075-1-xiangwencheng@lanxincomputing.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jul 16, 2025 at 03:47:37PM +0800, BillXiang wrote:
> Consider a system with 8 harts, where each hart supports 5
> Guest Interrupt Files (GIFs), yielding 40 total GIFs.
> If we launch a QEMU guest with over 5 vCPUs using
> "-M virt,aia='aplic-imsic' -accel kvm,riscv-aia=hwaccel" – which
> relies solely on VS-files (not SW-files) for higher performance – the
> guest requires more than 5 GIFs. However, the current Linux scheduler
> lacks GIF awareness, potentially scheduling >5 vCPUs to a single hart.
> This triggers VS-file allocation failure, and since no handler exists
> for this error, the QEMU guest becomes corrupted.

What do you mean by "become corrupted"? Shouldn't the VM just stop after
the vcpu dumps register state?

> 
> To address this, we introduce this simple handler by rescheduling vCPU
> to alternative harts when VS-file allocation fails on the current hart.
> 
> Signed-off-by: BillXiang <xiangwencheng@lanxincomputing.com>
> ---
>  target/riscv/kvm/kvm-cpu.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5c19062c19..7cf258604f 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1706,6 +1706,9 @@ static bool kvm_riscv_handle_debug(CPUState *cs)
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>  {
>      int ret = 0;
> +    uint64_t code;
> +    cpu_set_t set;
> +    long cpus;
>      switch (run->exit_reason) {
>      case KVM_EXIT_RISCV_SBI:
>          ret = kvm_riscv_handle_sbi(cs, run);
> @@ -1718,6 +1721,18 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>              ret = EXCP_DEBUG;
>          }
>          break;
> +    case KVM_EXIT_FAIL_ENTRY:
> +        code = run->fail_entry.hardware_entry_failure_reason;
> +        if (code == CSR_HSTATUS) {
> +            // Schedule vcpu to next hart upon VS-file 
> +            // allocation failure on current hart.
> +            cpus = sysconf(_SC_NPROCESSORS_ONLN);
> +            CPU_ZERO(&set);
> +            CPU_SET((run->fail_entry.cpu+1)%cpus, &set);
> +            ret = sched_setaffinity(0, sizeof(set), &set);

If other guests have already consumed all the VS-files on the selected
hart then this will fail again and the next hart will be tried and if all
VS-files of the system are already consumed then we'll just go around and
around.

Other than that problem, this isn't the right approach because QEMU should
not be pinning vcpus - that's a higher level virt management layer's job
since it's a policy.

A better solution to this is to teach KVM to track free VS-files and then
migrate (but not pin) vcpus to harts with free VS-files, rather than
immediately fail.

But, if all guests are configured to only use VS-files, then upper layers
of the virt stack will still need to be aware that they can never schedule
more vcpus than supported by the number of total VS-files. And, if upper
layers are already involved in the scheduling, then pinning is also an
option to avoid this problem. Indeed pinning is better for the failure
case of over scheduling, since over scheduling with the KVM vcpu migration
approach can result in a VM launched earlier to be killed, whereas with
the upper layer pinning approach, the last guest launched will fail before
it runs.

Thanks,
drew

> +            break;
> +        }
> +        /* FALLTHRU */
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                        __func__, run->exit_reason);
> -- 
> 2.46.2.windows.1
> 

