Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35FF3CAC582
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 17:03:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw1jk-0004AX-Js; Tue, 09 Sep 2025 13:02:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uw1j3-0003uP-1d
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 13:01:52 -0400
Received: from mail-oa1-x35.google.com ([2001:4860:4864:20::35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uw1iv-0008IB-Uo
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 13:01:48 -0400
Received: by mail-oa1-x35.google.com with SMTP id
 586e51a60fabf-31d75b4d485so3332270fac.0
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 10:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1757437299; x=1758042099; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FV2YqMCXo0sq4CDLz4Fuwggi1eVMUpM6gh7nIMLdZvc=;
 b=RP7ZWKRodm9CmTlqnpnp5TST+S8H4IasiaDOdgbtFLeEkoUD2KUkmxObuu6eTMX8NS
 flsC4xOmHOkF5T3mLjZevuR+eLCoK8AB6ONBvRKTPXGejfBTO8cPG4d6PF4a3bKe9532
 H+6sQUQURRzzbmAu7JvWYQa4u5lTCgHbVxfkcmWVrRY8EG8LyJFzOFPMo+txUOaTvCRm
 easWr8yaWN+3YaiGdiVrioqMdBM4ctG5sIb1BQDlz/QVyZbebhgHDa88akPA2TpXY6J8
 UBp9zKZlYH5elH8f6mGlj0Rv0kbPI9QunVzLa1E3knDBWVnT7aLoV1m99z+8bhmd9129
 aQvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757437299; x=1758042099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FV2YqMCXo0sq4CDLz4Fuwggi1eVMUpM6gh7nIMLdZvc=;
 b=v6xr4Rjvfq8BxntNVDnJ40/V7YistSFp4IlmTU9nrtCT8bp2LyGw7Nbc1XL2VrHxzl
 AxRx3RgFDj7Px339q5GKm0dNGI53CGPVDYkB+1zTxTvrO/YA2ZMzIk9Snz2HCkI7b5Kt
 QxHE7UkC/NFCuWQ5P6ho+1JCm8V6yJUi57rPcK2ogaWIX9n699JguKTDsgkDYED3ziqj
 KEsqBBodkO6qkH691Hl8Oeh7Qovcy9bXnG1nWY6IM+Rfj/AXQKiormau637kWGJ5Z28c
 T/h8PBIpaKK+PEf86m3MmW7BjqZ6qaJcdnwjFPFKMaPOsmRDO9lRuRw+sFQM0uOOeJMW
 u5kg==
X-Gm-Message-State: AOJu0YxDxHr5jflzDq+zm2eGarOiRyorabRR0fMuQjoywwUqW5RUkV+z
 NXHOgP2OpzhWwTFikHDA3cbIaZMIp/ArD43Kjquq4BOQQ2/uFzQtdsob+1LNnfWKGoQ=
X-Gm-Gg: ASbGncu3YgI//LaDuMWudPPT7OJeBVdtJXuYxH138nvr/YC6IE1XfmCP/IleaVpbN1g
 qGpgVcfF0nGl8Hf56fRadJo3qIm5w7cb/lFutLF/0BkFtwygl2SiIWh/KVBImy/tD3PZevFxte7
 +E4w/DoWYamLNt2bZl97YwUhNDYyuNSFHZzX2mvXt2gQcA2+ABjHxcZkVxRte2yoT6VpYMDIPjw
 2zf8DYGg5cbzpvHbhTpFGpOO1HPjE2MKTZwyBIMk+tJNWeo/5LMjJwhBln71c71T56uHat9Ndey
 tKHAODWwVnJT4o/ZDp4+aVt4dx5vdHRbrUNMfeWUC5IZU0CHqCJncOpbWJqDuGk79RinD+7NGrM
 7XqHhZYjHcV0pU8gL1Sb+zjM6D5VYgxveMII=
X-Google-Smtp-Source: AGHT+IF3AVw6ozOj2PvQVg5i5fhDRZJp+qi77SXD94/nVJM3GsH4rg8IfgwJucoCXZ5/4bDqevBkZA==
X-Received: by 2002:a05:6870:7025:b0:321:2680:2f77 with SMTP id
 586e51a60fabf-32264e267fdmr6312944fac.35.1757437298967; 
 Tue, 09 Sep 2025 10:01:38 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-510382d5d52sm6173396173.13.2025.09.09.10.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 10:01:38 -0700 (PDT)
Date: Tue, 9 Sep 2025 12:01:36 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Xie Bo <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 anup@brainfault.org, alistair.francis@wdc.com, rkrcmar@ventanamicro.com, 
 palmer@dabbelt.com, xiamy@ultrarisc.com
Subject: Re: [PATCH v5 for v10.0.0 2/2] =?utf-8?Q?target=2Friscv=2Fkvm?=
 =?utf-8?B?77yaRml4ZWQ=?= the issue of resume after QEMU+KVM migration
Message-ID: <20250909-db5eefe496963c6716754ed3@orel>
References: <20250818-e7e56e26bbf62a23417c2567@orel>
 <20250909090917.21301-1-xb@ultrarisc.com>
 <20250909090917.21301-3-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909090917.21301-3-xb@ultrarisc.com>
Received-SPF: pass client-ip=2001:4860:4864:20::35;
 envelope-from=ajones@ventanamicro.com; helo=mail-oa1-x35.google.com
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


sed s/Fixed the issue of/Fix/ <<<$SUBJECT

On Tue, Sep 09, 2025 at 05:09:17PM +0800, Xie Bo wrote:
> This patch fixes two migration issues for virtual machines in KVM mode:

Don't start commit messages with "This patch".

> 
> 1.It saves and restores the vCPU's privilege mode to ensure that the vCPU's privilege mode is correct after migration.
> 2.It saves and restores the vCPU's mp_state (runnable or stopped) and includes this state in the migration sequence, upgrading the vmstate version to ensure
> that the vCPU's mp_state is correct after migration.

Missing spaces after periods. Break lines around 70 chars.

> 
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  target/riscv/kvm/kvm-cpu.c   | 59 ++++++++++++++++++++++++++++--------
>  target/riscv/kvm/kvm_riscv.h |  3 +-
>  target/riscv/machine.c       |  5 +--
>  3 files changed, 51 insertions(+), 16 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 0f4997a918..1b09c505d3 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -576,6 +576,12 @@ static int kvm_riscv_get_regs_core(CPUState *cs)
>      }
>      env->pc = reg;
>  
> +    ret = kvm_get_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +    env->priv = reg;
> +
>      for (i = 1; i < 32; i++) {
>          uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
>          ret = kvm_get_one_reg(cs, id, &reg);
> @@ -601,6 +607,12 @@ static int kvm_riscv_put_regs_core(CPUState *cs)
>          return ret;
>      }
>  
> +    reg = env->priv;
> +    ret = kvm_set_one_reg(cs, RISCV_CORE_REG(env, mode), &reg);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      for (i = 1; i < 32; i++) {
>          uint64_t id = kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CORE, i);
>          reg = env->gpr[i];
> @@ -1244,25 +1256,51 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
>          return ret;
>      }
>  
> +    ret = kvm_riscv_sync_mpstate_to_qemu(cs);
> +    if (ret) {
> +        return ret;
> +    }
> +
>      return ret;
>  }
>  
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state)
> +int kvm_riscv_sync_mpstate_to_kvm(CPUState *cs)
>  {
> +    int ret = 0;
> +    CPURISCVState *env = &RISCV_CPU(cs)->env;
> +
>      if (cap_has_mp_state) {
>          struct kvm_mp_state mp_state = {
> -            .mp_state = state
> +            .mp_state = env->mp_state
>          };
>  
> -        int ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
> +        ret = kvm_vcpu_ioctl(cs, KVM_SET_MP_STATE, &mp_state);
>          if (ret) {
> -            fprintf(stderr, "%s: failed to sync MP_STATE %d/%s\n",
> +            fprintf(stderr, "%s: failed to sync MP_STATE to KVM %d/%s\n",
>                      __func__, ret, strerror(-ret));
> -            return -1;
>          }
>      }
>  
> -    return 0;
> +    return ret;
> +}
> +
> +int kvm_riscv_sync_mpstate_to_qemu(CPUState *cs)
> +{
> +    int ret = 0;
> +    CPURISCVState *env = &RISCV_CPU(cs)->env;
> +
> +    if (cap_has_mp_state) {
> +        struct kvm_mp_state mp_state;
> +
> +        ret = kvm_vcpu_ioctl(cs, KVM_GET_MP_STATE, &mp_state);
> +        if (ret) {
> +            fprintf(stderr, "%s: failed to sync MP_STATE to QEMU %d/%s\n",
> +                    __func__, ret, strerror(-ret));
> +        }
> +        env->mp_state = mp_state.mp_state;

We shouldn't still do this assignment when the ioctl fails.

> +    }
> +
> +    return ret;
>  }
>  
>  int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> @@ -1289,13 +1327,8 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
>          return ret;
>      }
>  
> -    if (KVM_PUT_RESET_STATE == level) {
> -        RISCVCPU *cpu = RISCV_CPU(cs);
> -        if (cs->cpu_index == 0) {
> -            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_RUNNABLE);
> -        } else {
> -            ret = kvm_riscv_sync_mpstate_to_kvm(cpu, KVM_MP_STATE_STOPPED);
> -        }
> +    if (level >= KVM_PUT_RESET_STATE) {

Changing this to >= makes sense, but it probably deserves a justification
in the commit message.

> +        ret = kvm_riscv_sync_mpstate_to_kvm(cs);
>          if (ret) {
>              return ret;
>          }
> diff --git a/target/riscv/kvm/kvm_riscv.h b/target/riscv/kvm/kvm_riscv.h
> index b2bcd1041f..953db94160 100644
> --- a/target/riscv/kvm/kvm_riscv.h
> +++ b/target/riscv/kvm/kvm_riscv.h
> @@ -28,7 +28,8 @@ void kvm_riscv_aia_create(MachineState *machine, uint64_t group_shift,
>                            uint64_t aplic_base, uint64_t imsic_base,
>                            uint64_t guest_num);
>  void riscv_kvm_aplic_request(void *opaque, int irq, int level);
> -int kvm_riscv_sync_mpstate_to_kvm(RISCVCPU *cpu, int state);
> +int kvm_riscv_sync_mpstate_to_kvm(CPUState *cs);
> +int kvm_riscv_sync_mpstate_to_qemu(CPUState *cs);
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  uint64_t kvm_riscv_get_timebase_frequency(RISCVCPU *cpu);
>  
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 889e2b6570..8562a0a1d6 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -401,8 +401,8 @@ static const VMStateDescription vmstate_ssp = {
>  
>  const VMStateDescription vmstate_riscv_cpu = {
>      .name = "cpu",
> -    .version_id = 10,
> -    .minimum_version_id = 10,
> +    .version_id = 11,
> +    .minimum_version_id = 11,
>      .post_load = riscv_cpu_post_load,
>      .fields = (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -422,6 +422,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>          VMSTATE_UNUSED(4),
>          VMSTATE_UINT32(env.misa_ext_mask, RISCVCPU),
>          VMSTATE_UINTTL(env.priv, RISCVCPU),
> +        VMSTATE_UINT32(env.mp_state, RISCVCPU),
>          VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
>          VMSTATE_UINT64(env.resetvec, RISCVCPU),
>          VMSTATE_UINTTL(env.mhartid, RISCVCPU),
> -- 
> 2.43.0
>

Thanks,
drew

