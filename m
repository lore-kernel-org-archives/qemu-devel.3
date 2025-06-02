Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B85B5C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 04:04:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLwOw-0001Ro-Pa; Mon, 02 Jun 2025 00:03:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLwOn-0001RB-Ma; Mon, 02 Jun 2025 00:03:46 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLwOk-0007DI-3Z; Mon, 02 Jun 2025 00:03:45 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-52e728960c3so1476870e0c.2; 
 Sun, 01 Jun 2025 21:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748837020; x=1749441820; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oR/T4sj4Sz9nH//5IYvWjlk1YKbUuAfasS2nfIXYCr4=;
 b=Dx471hIoNytFbCKckZ4SmV9Me6jsAe1mjs+GTJWoYEot7Wb/vQX+XalCmoeME2BQ9V
 7C14WMiy2P5SOUuYLsqnI3GlrIJZrXCm6fOM3UVFkx2AZG6Idd8P+D/L0mvB8M9ZAAX3
 /SGoEQnU5p4xiavHB8+UKa7EKVnPUuoCoKTtCGYSXTY61xqgrtaHPlru2z2AkNb7BNMM
 27sutU9npCY1h6ZOS/qpMjs5Ldm6kiDXK3TheSDTmNGShXFVR2ewHqx7A3omgppyA+bk
 84qS96FnK8HP33dG5HK4zlEG5Gy8wbky5cadkY8MUCvYG/utfw7fYCagSNo5xJoj8wAZ
 G5og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748837020; x=1749441820;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oR/T4sj4Sz9nH//5IYvWjlk1YKbUuAfasS2nfIXYCr4=;
 b=f8rS1/bEbOanJZfnfyHiuRlv9VXNmxPl5YMnhT9tvkmkkF9CJx6+Us6hcaCmvUlp4/
 vV/CRVBP5hHHlCKotg8DNNs+1WBgvtfwIP/f5fvCrc0E/GN2dWDz/o5c4XITf+SX7mwE
 plOj8NvhkyiSE9Z5pftO2uqA06JJh9Wb0/3EDSZnclCXNDFGvxkOQStMIy4wEAFOikZK
 kTlHPEB0b7YU7ih6bkHd7Ha5X1qYHA2oYBgI1WjBdPDJMMBKn1Tidpn0WJE3vWTvpBb/
 L5HuWYy68kfqDB4ZzFVGZmGA6tN5U6IeuQROH81w0n8pq2bWjTtBJ3N+maFLtJMxTSAB
 2AWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu/gF34/jQDHx91h9eH9+MXGY8IikO+s+zAtICtNr8/6YJAyK77Yy5PIAk7knxYu+FRzOCMeIJqyJa@nongnu.org
X-Gm-Message-State: AOJu0Yw+JHn0yei0Lg7MpnOu+08vPcacO6X+o/walKK1PKKiG5HzHZwa
 f+ZPPpSUU4VYNGAudw4mxD04Zc/IIP9z82L5MxaNE+drtnPMmrv1NwB8pHNFEdtUPVsIiXy0XK1
 azyRqyIvAA2PJ8EhhWnLexx6XqODHrVQ=
X-Gm-Gg: ASbGncuK4RUCcxuR71Pz9Y0/iYGD1qyB6+HU3EVCq+La+wANRjaKMOme2WhGzBpZgkC
 44ho7rSeN+9QwhXk8ms+KhZ5U0Hlxyr3UIOmZWnUVVB0aKT17jxn6YZejxgtGRzzWw0SkzhQ9cy
 sH/f/tapLEj2cABkTX6mlcnBB4mSk/J8K8X5PEDneB1JEgWXFi6jkUVPmrj2u2oWQ=
X-Google-Smtp-Source: AGHT+IFohOUNpKisSTnxTyGjbGw9k0gDRubq10xSFD9VbOxoN8loNk+foQiBc9cOUgpNy8dAd5KL8jMy59/HDJmkw9o=
X-Received: by 2002:a05:6122:c97:b0:530:7a17:88ca with SMTP id
 71dfb90a1353d-5309379993cmr4127019e0c.9.1748837020323; Sun, 01 Jun 2025
 21:03:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250529140012.135408-1-mengzhuo@iscas.ac.cn>
In-Reply-To: <20250529140012.135408-1-mengzhuo@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 14:03:14 +1000
X-Gm-Features: AX0GCFtvDEdP5fYpxqd-nu71X_Av0bs9XhdtdO0CLH0l3B48Lb1GEGJQFwbIvhY
Message-ID: <CAKmqyKOjEdt_w6uv3cZHBtk2ctZiNwznp-Gv6TkX=5=Q=pfodw@mail.gmail.com>
Subject: Re: [PATCH v5] target/riscv/kvm: add satp mode for host cpu
To: Meng Zhuo <mengzhuo@iscas.ac.cn>
Cc: qemu-devel@nongnu.org, Andrew Jones <ajones@ventanamicro.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Fri, May 30, 2025 at 12:01=E2=80=AFAM Meng Zhuo <mengzhuo@iscas.ac.cn> w=
rote:
>
> This patch adds host satp mode while kvm/host cpu satp mode is not
> set.
>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2931
> Signed-off-by: Meng Zhuo <mengzhuo@iscas.ac.cn>
> ---
> This patch don't change the output of errno nor errno strings pattern.
> See [v3] for further information.
>
> Change in v5:
> - Adds R-B comment from Andrew Jones
>
> Change in v4:
> - Adds changelog in commit message
> - Link to v3: https://lists.nongnu.org/archive/html/qemu-devel/2025-05/ms=
g04629.html
>
> Change in v3:
> - Rebase on https://github.com/alistair23/qemu/tree/riscv-to-apply.next
>   as requested
> - Link to v2: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/ms=
g05203.html
>
> Changes in v2:
> - use set_satp_mode_max_supported instead of hard code
> - Link to v1: https://lists.nongnu.org/archive/html/qemu-devel/2025-04/ms=
g05094.html
> ---
>  target/riscv/cpu.c         |  3 +--
>  target/riscv/cpu.h         |  1 +
>  target/riscv/kvm/kvm-cpu.c | 20 +++++++++++++++++++-
>  3 files changed, 21 insertions(+), 3 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d92874baa0..a84edd3a3b 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -433,8 +433,7 @@ const char *satp_mode_str(uint8_t satp_mode, bool is_=
32_bit)
>      g_assert_not_reached();
>  }
>
> -static void set_satp_mode_max_supported(RISCVCPU *cpu,
> -                                        uint8_t satp_mode)
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode)
>  {

This function has been removed in the latest master branch, can you
please rebase on
https://github.com/alistair23/qemu/tree/riscv-to-apply.next

Alistair

>      bool rv32 =3D riscv_cpu_mxl(&cpu->env) =3D=3D MXL_RV32;
>      const bool *valid_vm =3D rv32 ? valid_vm_1_10_32 : valid_vm_1_10_64;
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b56d3afa69..d7136f1d72 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -915,6 +915,7 @@ char *riscv_cpu_get_name(RISCVCPU *cpu);
>
>  void riscv_cpu_finalize_features(RISCVCPU *cpu, Error **errp);
>  void riscv_add_satp_mode_properties(Object *obj);
> +void set_satp_mode_max_supported(RISCVCPU *cpu, uint8_t satp_mode);
>  bool riscv_cpu_accelerator_compatible(RISCVCPU *cpu);
>
>  /* CSR function table */
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 82f9728636..18fbca1a08 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -999,6 +999,23 @@ static void kvm_riscv_destroy_scratch_vcpu(KVMScratc=
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
>      struct kvm_one_reg reg;
> @@ -1302,6 +1319,7 @@ static void riscv_init_kvm_registers(Object *cpu_ob=
j)
>      kvm_riscv_init_machine_ids(cpu, &kvmcpu);
>      kvm_riscv_init_misa_ext_mask(cpu, &kvmcpu);
>      kvm_riscv_init_cfg(cpu, &kvmcpu);
> +    kvm_riscv_init_satp_mode(cpu, &kvmcpu);
>
>      kvm_riscv_destroy_scratch_vcpu(&kvmcpu);
>  }
> @@ -1980,7 +1998,7 @@ static bool kvm_cpu_realize(CPUState *cs, Error **e=
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

