Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 812CCCA0FED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Sep 2025 16:42:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uwNtP-0001dG-Lf; Wed, 10 Sep 2025 12:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uwNtO-0001cw-GW
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:41:58 -0400
Received: from mail-io1-xd29.google.com ([2607:f8b0:4864:20::d29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1uwNtL-00018R-TB
 for qemu-devel@nongnu.org; Wed, 10 Sep 2025 12:41:58 -0400
Received: by mail-io1-xd29.google.com with SMTP id
 ca18e2360f4ac-8876462a34aso202748539f.2
 for <qemu-devel@nongnu.org>; Wed, 10 Sep 2025 09:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1757522514; x=1758127314; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=xL7JQIWeInW0ZYmfRZSfWkrWj7pxXYJHUuLb/gsAAIs=;
 b=iC+KSpNIMzqoSxn80ASDtzMGBVYQO+piiURuAPL8pTiwxYs9b2jBHk80VECYSVW8PL
 HP3ihPVpsF/MI9oC/m4sTRAQGIInOz3vwIBFW6JlhQFxAddgISGcA0ZZfz8DLMYp4JnI
 OFDM+USIujVf5PfRmH3NKrHLC5rteav5Elm4GWjVD75YXqZsM9f6aedz27rZGLNNM++u
 GPgyA8UUKZgvVm49BurZS8CuWGqAkYGzJSDFFS2/XLjxylKHody551GMg0OL/p40UpGY
 YcGhnxYZLu6+b4KI7U0F9o9RWRzry/fJWJ8xkSDBmF1wdCtTCKMxdOXMrhP7QlHFFA2y
 egLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757522514; x=1758127314;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xL7JQIWeInW0ZYmfRZSfWkrWj7pxXYJHUuLb/gsAAIs=;
 b=J2g0yIR5iD+0st2eiNrnQksWmHxn618DC8U1IrZEZ3rM5rz3LpHtrM8WxReQW2DNuc
 DF7RTEq3pg0OGZkr6QLFgfb5N9RXg1LPCJrnZrJSbw0/7jrtQIz9HW6R9JgTmwBcVziJ
 T9qV2NM+Ep8JfpFBfmJHSQguUxuUXFN4E0QaPXGlxkPTe3GeZgmXDCWNCUqW6tCVeul2
 v7PsqR52w/IelXfuIS8p1qz83DM+LYqteiC8dnsFUa4yq0/cMM/kpqi+HaqyEQmnLp3r
 p/oMrdYCBgMi14AZXLR6H+NjLxwRgJSxKLGb7BRl7Cdc8+kqmuGzYzQUYHist9SKyfSB
 4uHw==
X-Gm-Message-State: AOJu0YzcFNuwdtshqSTUqLO7OPmRpQSak90esuyPc7drbW5CV5ClVe3c
 z9MjvJzoIVPkT98HAW/3Jxe+wkO3dFfB0/l8ydBVwuaPkJz2/f0KQZD82/k7u1qOmwU=
X-Gm-Gg: ASbGnct52igJrYk5EXw8AkMnO2FcKdGGSUeG1NHQk+G8egfs78hzb6p0jS4O4UdkDZz
 fhKMJpEu9jmjpcN9w6eb7cpdF3jMx8khm0r6l/Tr47fuCHUDzmd1L1h0GlllcAJDU9SjI2U0Wbk
 7+OLNcLeqWPF1eb/JZ3KkFAKcGdKBypEVREj32J6oyUmiLzjmVv6XNqqdCvM/cLNiWim4HpzWIP
 z1cVwJ/a4FNXZ7Zz4G3fu2iZLlp+rhl26Oyof78zGO2EtW0AULReEduL5tlsUEcimoBd2IQX2Ef
 hvYIoxGH3lAO0F0Ic++5MpEZJOAvd235ZRCN8QKJeVc2H9bG9d4MEQ13jgZgo7xGQrHyD8czmey
 wYxaMDFY6bw/SAGZp88kS8nTpS/0n0NvBXPw=
X-Google-Smtp-Source: AGHT+IEkSvSwFfZNNpANLAhbTabK+ErP+BOBwvt7XlFXNALbCsEN2h3/TaIWe620QnwhkO6tMjmxCw==
X-Received: by 2002:a05:6602:36ce:b0:88d:9dce:2916 with SMTP id
 ca18e2360f4ac-88d9dce2a43mr557426039f.8.1757522513939; 
 Wed, 10 Sep 2025 09:41:53 -0700 (PDT)
Received: from localhost ([140.82.166.162]) by smtp.gmail.com with ESMTPSA id
 ca18e2360f4ac-8897613808csm406675739f.15.2025.09.10.09.41.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 09:41:53 -0700 (PDT)
Date: Wed, 10 Sep 2025 11:41:52 -0500
From: Andrew Jones <ajones@ventanamicro.com>
To: Xie Bo <xb@ultrarisc.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 anup@brainfault.org, alistair.francis@wdc.com, rkrcmar@ventanamicro.com, 
 palmer@dabbelt.com, xiamy@ultrarisc.com
Subject: Re: [PATCH v6 2/2] Fix VM resume after QEMU+KVM migration
Message-ID: <20250910-f405263ec7a71e1384c39da4@orel>
References: <20250910093529.614305-1-xb@ultrarisc.com>
 <20250910093529.614305-3-xb@ultrarisc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910093529.614305-3-xb@ultrarisc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::d29;
 envelope-from=ajones@ventanamicro.com; helo=mail-io1-xd29.google.com
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

On Wed, Sep 10, 2025 at 05:35:28PM +0800, Xie Bo wrote:
> Fix two migration issues for virtual machines in KVM mode:
> 1.It saves and restores the vCPU's privilege mode to ensure that the 
> vCPU's privilege mode is correct after migration.
> 2.It saves and restores the vCPU's mp_state (runnable or stopped) and 
> includes this state in the migration sequence, upgrading the vmstate 
> version to ensure that the vCPU's mp_state is correct after migration.
> 
> KVM_PUT_RUNTIME_STATE only synchronizes the vCPU’s runtime-modified 
> state (such as registers), whereas mp_state is related to system boot, 
> multi-core initialization, and is not modified during normal operation. 
> Therefore, mp_state is only synchronized to KVM during KVM_PUT_RESET_STATE 
> and KVM_PUT_FULL_STATE.
> 
> Signed-off-by: Xie Bo <xb@ultrarisc.com>
> ---
>  target/riscv/kvm/kvm-cpu.c   | 60 ++++++++++++++++++++++++++++--------
>  target/riscv/kvm/kvm_riscv.h |  3 +-
>  target/riscv/machine.c       |  5 +--
>  3 files changed, 52 insertions(+), 16 deletions(-)
> 
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 0f4997a918..1434dd1c51 100644
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
> @@ -1244,25 +1256,52 @@ int kvm_arch_get_registers(CPUState *cs, Error **errp)
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
> +            return ret;
> +        }
> +        env->mp_state = mp_state.mp_state;
> +    }
> +
> +    return ret;
>  }
>  
>  int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
> @@ -1289,13 +1328,8 @@ int kvm_arch_put_registers(CPUState *cs, int level, Error **errp)
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

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

