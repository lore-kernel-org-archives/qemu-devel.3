Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FD8C021B2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmNol-0008FP-AO; Sun, 23 Feb 2025 21:03:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNoi-0008Es-9f; Sun, 23 Feb 2025 21:03:32 -0500
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmNog-0004eL-GI; Sun, 23 Feb 2025 21:03:31 -0500
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-4be75b2bbceso1351469137.1; 
 Sun, 23 Feb 2025 18:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740362608; x=1740967408; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s9B7HdyfMMODK/ppKlAemD1ZYgNOMbTMYWozAlWNKQM=;
 b=M9PJJZskjeOKVPE9G4mYWAFl8ZvwddJn6F7vG6xacEDRM6wA9pklNVIEpgZee3ByBb
 y6ZINYUD1qkKAYafTPiCO5mEwQAdqtUXbDxXqcZ0R+mvdKn0l5qNOpdc7cuTD34t/0u5
 H4C1kOWGleQdpvrQiZcF4RgzKR8YZBGoCceocewwxXNsr6h6jhhGuFy8jEi5vU29j0/s
 RGlzLcPmnq/yhdt12hW67AtbqRXL29AntjgHYJuyY1Y5r/pUDdkMWu46/Mdq5Yn4fBoA
 ltb22rcnBiQGCSrK4uyoGk+EUtPVGe37IrHFdaa+RSchjlmMDsFObjPtZ6TujToVnauD
 wKHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740362608; x=1740967408;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=s9B7HdyfMMODK/ppKlAemD1ZYgNOMbTMYWozAlWNKQM=;
 b=Q6XRjjfSIUP0Si3+37tfXU/atmwG8RnNr6mw/bMj9JmiQ7wi0gbkA8rffJIditcQn4
 8/iVX4gec3KveTwShAXSp6qlKdmujVJ3lNj9maI4q6y1bHt+/fWDq8rb8MB4tC9UVJor
 Us1B5GVZjtBG2N+irJY9CFVXOynqePMKaLZsnH1pu4B5h4GBdYU48CDgICqtHY2DhKKr
 v1Na0e/HX+CwJkaFHzvuQfiNfdP+6PssY07Y7gr98S+hBZiUj1BBgnmqvu6uo78k3UR4
 bdonG01YugIHbRZ8aXhsimKpwSXkCqEUnR0CDP4ddDzo+sVXlLUZB+OATIplhBuYUTar
 KrHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXX8pozVFAeb6iJDc/ZTvPt2IM6jFP7EYLJQwRUzgHr3rVgROC/U+wQ7ACZ9R/XrWLQz7Q0+QA4SVxX@nongnu.org
X-Gm-Message-State: AOJu0YwqB4zJv9whhkJfZQkoQZf9siSx8uW6wpCkWEtLFvPlLuMbeJq0
 Ka3xZDI5gH7XzV9QhlqRo2Vc8h5UNqF2qy2mVTGm69RBVs9UjrQdP+MWkJPlw0uymSsqXga3O44
 l0Nv94lvJSepL/LnUIjekvSHxfQA=
X-Gm-Gg: ASbGncs8aNsXkTdEfx1ftHZDDGSKoZRaikeZDas821dbCVPxFexk/DYuyBtb8gb7sRJ
 CXymQDDP4CRxhyVl7rMZsiHKHczZJih4E47yaHwhMD/FgzZgY7b7OhLcnzRttkXumgo6fFQWATS
 WHePwJlpQPPo2nRyaGwUP8bu0JmSAcTfBS1gKK
X-Google-Smtp-Source: AGHT+IEYw1YANjLoxNqnP7Z1mRT7XX5MWnkuJ0uAAmIUoMdoztZiSMwpJ0ohphM0VaQNxLXmLLkE8REtJwnAzcAQDkY=
X-Received: by 2002:a05:6102:2d0c:b0:4b2:ae3a:35d6 with SMTP id
 ada2fe7eead31-4bfc2901b25mr5944268137.19.1740362608521; Sun, 23 Feb 2025
 18:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20250220161313.127376-1-dbarboza@ventanamicro.com>
 <20250220161313.127376-2-dbarboza@ventanamicro.com>
In-Reply-To: <20250220161313.127376-2-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 12:03:02 +1000
X-Gm-Features: AWEUYZlRIu-Lm41A0t7kdQQBIQzAODrxWxYSpt9tE88MSZ674zdX7H7T2IEQzrY
Message-ID: <CAKmqyKMcF0zOkvYe5g8Eg52+jusJLi+d+3NWEM-Kut5fqZ7Rzw@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/riscv/cpu: ignore TCG init for KVM CPUs in
 reset_hold
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Fri, Feb 21, 2025 at 2:14=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> riscv_cpu_reset_hold() does a lot of TCG-related initializations that
> aren't relevant for KVM, but nevertheless are impacting the reset state
> of KVM vcpus.
>
> When running a KVM guest, kvm_riscv_reset_vcpu() is called at the end of
> reset_hold(). At that point env->mstatus is initialized to a non-zero
> value, and it will be use to write 'sstatus' in the vcpu
> (kvm_arch_put_registers() then kvm_riscv_put_regs_csr()).
>
> Do an early exit in riscv_cpu_reset_hold() if we're running KVM. All the
> KVM reset procedure will be centered in kvm_riscv_reset_vcpu().
>
> While we're at it, remove the kvm_enabled() check in
> kvm_riscv_reset_vcpu() since it's already being gated in
> riscv_cpu_reset_hold().
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 9 +++++----
>  target/riscv/kvm/kvm-cpu.c | 3 ---
>  2 files changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 522d6584e4..8e6e629ec4 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1050,6 +1050,11 @@ static void riscv_cpu_reset_hold(Object *obj, Rese=
tType type)
>          mcc->parent_phases.hold(obj, type);
>      }
>  #ifndef CONFIG_USER_ONLY
> +    if (kvm_enabled()) {
> +        kvm_riscv_reset_vcpu(cpu);
> +        return;
> +    }
> +
>      env->misa_mxl =3D mcc->misa_mxl_max;
>      env->priv =3D PRV_M;
>      env->mstatus &=3D ~(MSTATUS_MIE | MSTATUS_MPRV);
> @@ -1146,10 +1151,6 @@ static void riscv_cpu_reset_hold(Object *obj, Rese=
tType type)
>          env->rnmip =3D 0;
>          env->mnstatus =3D set_field(env->mnstatus, MNSTATUS_NMIE, false)=
;
>      }
> -
> -    if (kvm_enabled()) {
> -        kvm_riscv_reset_vcpu(cpu);
> -    }
>  #endif
>  }
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 23ce779359..484b6afe7c 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1603,9 +1603,6 @@ void kvm_riscv_reset_vcpu(RISCVCPU *cpu)
>      CPURISCVState *env =3D &cpu->env;
>      int i;
>
> -    if (!kvm_enabled()) {
> -        return;
> -    }
>      for (i =3D 0; i < 32; i++) {
>          env->gpr[i] =3D 0;
>      }
> --
> 2.48.1
>
>

