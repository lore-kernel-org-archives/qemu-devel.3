Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2881CA101F
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNp4-0007v5-Gf; Wed, 10 Sep 2025 12:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uwNp0-0007ui-Pv
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:37:27 -0400
Received: from mail-io1-xd2d.google.com ([2607:f8b0:4864:20::d2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uwNoy-0000K7-2M
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:37:26 -0400
Received: by mail-io1-xd2d.google.com with SMTP id
 ca18e2360f4ac-88432e6700dso51146939f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1757522240; x=1758127040; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=77Sp7vE/cjj+LkmFLQCy5EPSzbhLfnme7P3vlpAn3y0=;
 b=jxe7hBmuZAsLlCshqvHH9gXJovIUQK+cP4NkzAIb0Ytf8TQ+brX2RVeJ798KyLcOVW
 Kqni55TpQ96HhHp3Dl5AHYdeg1lTT3I6VMriKTIJ1gy4b3gMqa+vIo72+0Tw+uGv3oFT
 uGANQPhVol3WWe4Z9wfN8th4ttk062ZzfcnagY6LuBaLAwV6d5nfm82Yoz15/D4D+vfC
 cDnKwMQwAC+N2meZHwmHG+ZAyXAq768060Oz5YFpsDJrlAggGMbabllrZNcpVcBVh026
 JrrLm5IWBZ9e3iciWqmWbSkcmUf6yt6mcjQD+PqRRkSKAsGTBypI7cqMhW72hyimIV3K
 sX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757522240; x=1758127040;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=77Sp7vE/cjj+LkmFLQCy5EPSzbhLfnme7P3vlpAn3y0=;
 b=edIIrxwuZWPeta9MbvpkIgGUxJs/tVOCbE39gHXk6UeoZHvqeTuAA6hNaYAMW8tz8G
 BgPNPcelYNIRcx4k2+1TncUlNm7YZMb2VvWhu92gH0D9fJBNvOdf75zNJr+mkY9PMuGT
 EhGXC5tv0a8azplU0QruSST42cmivNk694m5jwMCOQxS29VZ2PHloFsRZenFGYpvNtH/
 v/MOlHIUwk1aOEJ6Fy45dQ04StzbSnF8GHjYTyoXGM0eD5I9C9kIyRBZ/Rh1dLWOXsHU
 PMxcS5FSQv27alq44efaa6veINI4GdD1W83bPjKYOyBdw8x40pGncwZDwNLvFO87+8EF
 5h7Q==
X-Gm-Message-State: AOJu0Yw4eVRIpPHDdRa9t9Rexr8zT/jnBTR259PK3aze2vA3cfgbr/It
 2Lfgtfs/wXzIWPvddhzI5GS6D47DS8J3gpbmdG+bzPYqmbwcA5OV/E9U40DMKUeEaRs=
X-Gm-Gg: ASbGnct3XYkp9t7sPfq57bc1iwMU51iR5LT7l5B6MxkWQgMqR0YXBdH0H+nBnsHeHs4
 sMc/zxkwspQiyepSD9q7bCtKWLx6D8SPp1i6NcgyU+p9m20l0Uy3E7egjOzUhzowRuBtEJNKbTL
 3f2NCdwGIdkrGNOmfAbgKn0NTxsnoTeie5E95O2xBeQEebFBjCCxY0Ra4KV6vlHkdj54e1z0QiC
 Rj5PZUs7jG4Uwp+WZR4r4DiKEuWKX8139sBFHuRu9Npkca0bBftXxWNKk05LjTZFTcjHq7DqwqM
 A7Cj6s8xU3yK87nJxqq+CSZYSV4Ix0qP32VRtvnJdQZOvBxf0IviKR+fPng78E+u4DldLrJlx9Q
 8wwgDR54dElGDnRj+loppm9lP
X-Google-Smtp-Source: AGHT+IEj51rHSaWEmWFKrq4fsZ9TFd6EsLaWMqTM/n5mbFm9ZUpUVtMN0kilDtFpe/LMcJPFArKfEw==
X-Received: by 2002:a05:6602:2ccb:b0:887:5ebe:bb9c with SMTP id
 ca18e2360f4ac-887776bb156mr2366486539f.14.1757522239709; 
 Wed, 10 Sep 2025 09:37:19 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-88c35d4bbc5sm265997439f.27.2025.09.10.09.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:37:19 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:37:18 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Xie Bo <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 anup@brainfault.org, alistair.francis@wdc.com, rkrcmar@ventanamicro.com, 
 palmer@dabbelt.com, xiamy@ultrarisc.com
Subject: Re: [PATCH v6 1/2] Set KVM initial privilege mode and mp_state
Message-ID: <20250910-70e85bb0410ddfa6fb425b0a@orel>
References: <20250910093529.614305-1-xb@ultrarisc.com>
 <20250910093529.614305-2-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910093529.614305-2-xb@ultrarisc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d2d;
 envelope-from=ajones@ventanamicro.com; helo=mail-io1-xd2d.google.com
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

On Wed, Sep 10, 2025 at 05:35:27PM +0800, Xie Bo wrote:
> For KVM mode, the privilege mode should not include M-mode, and the 
> initial value should be set to S-mode. Additionally, a following patch 
> adds the implementation of putting the vCPU privilege mode to KVM. 
> When the vCPU runs for the first time, QEMU will first put the privilege 
> state to KVM. If the initial value is set to M-mode, KVM will encounter
> an error.
> 
> In addition, this patch introduces the 'mp_state' field to RISC-V 
> vCPUs, following the convention used by KVM on x86. The 'mp_state' 
> reflects the multiprocessor state of a vCPU, and is used to control 
> whether the vCPU is runnable by KVM. Randomly select one CPU as the 
> boot CPU.
> 
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  target/riscv/cpu.c | 17 ++++++++++++++++-
>  target/riscv/cpu.h |  2 ++
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 09ded6829a..57b8c421bd 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -38,6 +38,7 @@
>  #include "kvm/kvm_riscv.h"
>  #include "tcg/tcg-cpu.h"
>  #include "tcg/tcg.h"
> +#include "hw/boards.h"
>  
>  /* RISC-V CPU definitions */
>  static const char riscv_single_letter_exts[] = "IEMAFDQCBPVH";
> @@ -1031,18 +1032,32 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>  #ifndef CONFIG_USER_ONLY
>      uint8_t iprio;
>      int i, irq, rdzero;
> +    static int boot_cpu_index = -1;
>  #endif
>      CPUState *cs = CPU(obj);
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
>      CPURISCVState *env = &cpu->env;
> +    MachineState *ms = MACHINE(qdev_get_machine());
>  
>      if (mcc->parent_phases.hold) {
>          mcc->parent_phases.hold(obj, type);
>      }
>  #ifndef CONFIG_USER_ONLY
>      env->misa_mxl = mcc->misa_mxl_max;
> -    env->priv = PRV_M;
> +    if (kvm_enabled()) {
> +        env->priv = PRV_S;
> +    } else {
> +        env->priv = PRV_M;
> +    }
> +    if (boot_cpu_index < 0) {
> +        boot_cpu_index = g_random_int() % ms->smp.cpus;

I don't think we're obliged to use the same boot cpu on each reset
after initially randomly selecting it. We can randomly select each
time.

Also, we can use g_random_int_range() instead of the mod.

Thanks,
drew

> +    }
> +    if (cs->cpu_index == boot_cpu_index) {
> +        env->mp_state = KVM_MP_STATE_RUNNABLE;
> +    } else {
> +        env->mp_state = KVM_MP_STATE_STOPPED;
> +    }
>      env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>      if (env->misa_mxl > MXL_RV32) {
>          /*
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 51e49e03de..4b1c5bf0e4 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -256,6 +256,8 @@ struct CPUArchState {
>  #endif
>  
>      target_ulong priv;
> +    /* Current multiprocessor state of this vCPU. */
> +    uint32_t mp_state;
>      /* CSRs for execution environment configuration */
>      uint64_t menvcfg;
>      target_ulong senvcfg;
> -- 
> 2.43.0
> 

