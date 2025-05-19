Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55AA4C3ABD8
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 01:47:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uGpaP-0003cZ-Py; Sun, 18 May 2025 21:46:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGpaO-0003cK-HK; Sun, 18 May 2025 21:46:36 -0400
Received: from mail-vs1-xe2e.google.com ([2607:f8b0:4864:20::e2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uGpaJ-0003SV-C5; Sun, 18 May 2025 21:46:36 -0400
Received: by mail-vs1-xe2e.google.com with SMTP id
 ada2fe7eead31-4e130b8b9acso935072137.3; 
 Sun, 18 May 2025 18:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747619190; x=1748223990; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uFVzWxwN85T9DJoC9jRYAblebIxFevzplunqrnWXk5s=;
 b=UUVFHecxdGK0jXLz6ZPX8PGgQHcpMTFFt3TiKtVXhNVizhHuF1sq8BJ3fIwlmJs3q4
 qmlDSE3OslT70TQeofQVL/uH0XurOyLyUjcQPgxFGQVFyc2jXbVF6F+u9oqvb76Ms+vF
 Jt6V+53W2WlXeF3YLLTxUGRNgfuk3oSJXzwEDSOHzZkasZD1SWjDKzHD6rFUvWUXRevm
 p6jGVvBM15Vb1M5NOTXJKTmdkJCryA09j8Yy3Rci5nuPElzjfCrHaw8YZHyJYZAsZzVw
 sQaQ2m1EPuvRwc6rncXGVCEwtgPXPSxz19/p41AkyZB4RWhWaY932REDgShW+EBskJUq
 tsjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747619190; x=1748223990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uFVzWxwN85T9DJoC9jRYAblebIxFevzplunqrnWXk5s=;
 b=c5pYfNWD3qOO0u/T304ZrTr5qROtPYmOgT0fbewhlVZrFNQf1FGi+oozg0ROXbRPRI
 8FK9RVtZjdgTrzktoUL0c/hGgFDvwu2huG8UjsASs4gLT7yQ+RngOYo4KFSfkoXVxZVv
 8yxVil3aU3Kc4d0aDZVZe33KdUl0lqfDONAgmIAGCMngxnEwjXiVCpfRhahwzWLd45jm
 i3r14ebEc092+jG4hLP41OdAPuNM0BxLd4pgEoChbECXHGxoEK7PtCC6tFqSPKc5jbXF
 t9+XRsFZC5oecjvJvFEFD3eirJBzy5JAHWJxXeOm3vQBVJ9IS7XGaKUc1XuOqRC6SeZm
 hNxA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXq+vhKC5UQ5VZWe5FS+Bp8DBwtX5tBoHwygp6au/S/03S7XmsLCWLqEsbEaVkhT7wuA7fkMmsyl7fu@nongnu.org
X-Gm-Message-State: AOJu0Yweh64paWE4FF6d/dTXbu0yXyNIg9z6tqlnYh6aov3gqx9umhfc
 k072fAXrCBWuNemLQE/koNrpF5BF9RaS4r+Kh5A/PkpXBwglE/jnkrCZzIk2toQBbYRME7jjD7x
 Q9C6a1M03aJgyygbIp+FUR6OFVUbrHq0=
X-Gm-Gg: ASbGncvyt9767MV8ew9NSUb1059qa8BqNV4ozRAzdUkCGXF0BuHgDXEoKto5nuSZ9v9
 MfDlLbQuof95HGBHbSc7HZpx3h8ttxILRRUa8L2wSLw9GvWvdcqP6gHV6LqHs4zfRfJS6QDMJYj
 0hYgJHL4Qy0o0MzVGU1Lks7qnutdIIc0chcEOR5nm0av2/ZFtLaaIVu2otYh27DEk=
X-Google-Smtp-Source: AGHT+IFM3ttN0/LXXJuurlWIvYhSGoeAZWC5Xk94MvYKRtEcJhVnh6HcDCDkd4+HGBrVTaYAiSHvJ4lZDF4ZKnFtG6k=
X-Received: by 2002:a05:6102:91a:b0:4c1:8928:cefb with SMTP id
 ada2fe7eead31-4dfa6b9ca16mr9734159137.12.1747619189626; Sun, 18 May 2025
 18:46:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250428085632.3102-1-mengzhuo@iscas.ac.cn>
In-Reply-To: <20250428085632.3102-1-mengzhuo@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 19 May 2025 11:46:03 +1000
X-Gm-Features: AX0GCFtGLxkgWUh4P00N2hlh-DAuWf9E_TcsrUSea39R78QvKBgADSJaxOfdyv8
Message-ID: <CAKmqyKMq49t0s0v=ng18K4Gsuz7GsDx+kODzrgFqa9+e9PkR-w@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/kvm: add satp mode for host cpu
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2e;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Mon, Apr 28, 2025 at 6:57=E2=80=AFPM Meng Zhuo <mengzhuo@iscas.ac.cn> wr=
ote:
>
> This patch adds host satp mode while kvm/host cpu satp mode is not
> set.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         |  3 +--
>  target/riscv/cpu.h         |  1 +
>  target/riscv/kvm/kvm-cpu.c | 20 +++++++++++++++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2b830b3317..98f78886e6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -434,8 +434,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit)
>      g_assert_not_reached();
>  }
>
> -static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        uint8_t satp_mode)
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode)
>  {
>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 167909c89b..44318d2e97 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -916,6 +916,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
>
>  void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  void riscv_add_satp_mode_properties(Object *obj);
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>
>  /* CSR function table */
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 5315134e08..8f465119f5 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -953,6 +953,23 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratc=
hCPU *scratch)
>      close(scratch->kvmfd);
>  }
>
> +static void kvm_riscv_init_satp_mode(RISCVCPU *cpu, KVMScratchCPU *kvmcp=
u)
> +{
> +    CPURISCVState *env =3D &cpu->env;
> +    struct kvm_one_reg reg;
> +    int ret;
> +    uint64_t val;
> +
> +    reg.id =3D RISCV_CONFIG_REG(env, satp_mode);
> +    reg.addr =3D (uint64_t)&val;
> +    ret =3D ioctl(kvmcpu->cpufd, KVM_GET_ONE_REG, &reg);
> +    if (ret !=3D 0) {
> +        error_report("Unable to retrieve satp from host, error %d", ret)=
;
> +    }
> +
> +    set_satp_mode_max_supported(cpu, val);
> +}
> +
>  static void kvm_riscv_init_machine_ids(RISCVCPU *cpu, KVMScratchCPU *kvm=
cpu)
>  {
>      CPURISCVState *env =3D &cpu->env;
> @@ -1212,6 +1229,7 @@ static void riscv_init_kvm_registers(Object *cpu_ob=
j)
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
>      kvm_riscv_init_multiext_cfg(cpu, &kvmcpu);
> +    kvm_riscv_init_satp_mode(cpu, &kvmcpu);
>
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> @@ -1891,7 +1909,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **e=
rrp)
>          }
>      }
>
> -   return true;
> +    return true;
>  }
>
>  void riscv_kvm_cpu_finalize_features(RISCVCPU *cpu, Error **errp)
> --
> 2.39.5
>
>

