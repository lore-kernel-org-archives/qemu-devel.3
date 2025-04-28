Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48976C369DC
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9Mo2-00074u-Gq; Mon, 28 Apr 2025 07:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Mnp-00070l-F5; Mon, 28 Apr 2025 07:37:40 -0400
Received: from mail-ua1-x934.google.com ([2607:f8b0:4864:20::934])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Mnl-0007Vy-8v; Mon, 28 Apr 2025 07:37:36 -0400
Received: by mail-ua1-x934.google.com with SMTP id
 a1e0cc1a2514c-86d69774081so1965841241.0; 
 Mon, 28 Apr 2025 04:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745840251; x=1746445051; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XaMnPXgZvOCHElWWI4dW7rr7ASgl5wjxBGiCfDYNC5A=;
 b=Q6KFVDChxl2QiAUw4ix3+4X4sLk5A5cMg/YD1IY5aoa/HzJNWc/a+ioi+vuDYT4zyg
 fEltW8ZocKj17sWfYokCngwXlrBidZyLeNErKHiDJjqycK6rGcDf/K4J4DgoKabnVScy
 N3ChKpPze2Ax3QCDoUz/42bri3hM1p3Jdiy11YuiwisyaJfgFqETfX6P4nMlvyTn4Eet
 GXZOB34qI1vilmUB9/V18UJuVsMbXTECOck9QvwUD0lwViFr8IdNOghadaprywW5aODn
 MD9bntbNv48q+4tXyxNUxz937Lr2UtaAP4znsfwXs6ywytooNDYvoNSGVG3BYargRJJ1
 92XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745840251; x=1746445051;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XaMnPXgZvOCHElWWI4dW7rr7ASgl5wjxBGiCfDYNC5A=;
 b=R8qjSLTyGJoQ8uNqP+N/70ouxlHsN3VMD066I4Hn95ePu36utGL3QpFaGHccZOh1jE
 11eo7ELjKNVcd0v1VbYN7f9C0PcC5tB/YpjsnC+GifuwQ04cBmyW4CBD7Q46KtkfbUpW
 jEftGzwQa6kJvewYiLbe/MyKEpwuRQzSkOBa9QL9UgQd6D/lfY9dxf2wwnJY+YxImB9n
 EZUqLUGL+1RplI6oOtjxzp0870TnYE1orytIF86ZPaGkRboFTEv2paGtS/WkTYbUd7Xv
 TgpOemN7Ycp+WUVlbBgfAjDMqUsaGZpZJgUVLZ2LNtVq8z1A8ZwecZxM/bMBlWaCA9Cw
 uubw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUd0gHYslTR4rrExVc8iXlJoRgdHIQ9hT7sDxODy/MXgBnQG3KCJTdpS1PF9tmuMbKiSXBJE+PrMNDL@nongnu.org
X-Gm-Message-State: AOJu0YyBYajlD6avmJ3XqSY0l6yd+p9viKpK/P6eTLmUYk3NrnIVxTsZ
 gJ8cdE4JQeMkV8GPp5OAW2Bl2ziirRfIpa5dcrSmHfUZvMbVfVKdAGlPN/gdJnRhLkH26j+LDDr
 nbrbTI4JE5O9UFgR5WuooD57Nwu8=
X-Gm-Gg: ASbGnctETcpn02EdShWNXMqUpr6YHEWJL9P+MTui8saopvwQiS2l0QyH8RIZm3ML//T
 V8IgbpGOIVKthH35pFzcDcfmZl5FmtULEqzwXAlNetmFtNjo8p4NZ730hIZKcnunQ9z9pg8z6Mk
 53dtBJN4DtVFj7YmBu3rO5vIlmTe4dhjYDIQbOVove6+TbIm8LdptR
X-Google-Smtp-Source: AGHT+IFG94sTfMDUfjMf+obOkFI71MyAP4YJWA5NARMWNON6IoRUQlkhDDfef1kwx++bkCbQwFN2FxTSU1OT+Yv636k=
X-Received: by 2002:a05:6102:2042:b0:4c1:76a4:aee4 with SMTP id
 ada2fe7eead31-4d641f6746fmr4190380137.19.1745840251348; Mon, 28 Apr 2025
 04:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
 <20250425160203.2774835-4-dbarboza@ventanamicro.com>
In-Reply-To: <20250425160203.2774835-4-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Apr 2025 21:37:04 +1000
X-Gm-Features: ATxdqUH7McXznPAvt1tVsE59baF52qIjrVSQ5nnjPQQR9iHKnyBnYEgp4rozyes
Message-ID: <CAKmqyKNg3P44zUxKpz1y0joOennykQUA7YkOO=3WfXqu7QV2vA@mail.gmail.com>
Subject: Re: [PATCH v3 3/9] target/riscv/kvm: turn u32/u64 reg functions into
 macros
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::934;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x934.google.com
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

On Sat, Apr 26, 2025 at 2:03=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> This change is motivated by a future change w.r.t CSRs management. We
> want to handle them the same way as KVM extensions, i.e. a static array
> with KVMCPUConfig objs that will be read/write during init and so on.
> But to do that properly we must be able to declare a static array that
> hold KVM regs.
>
> C does not allow to init static arrays and use functions as
> initializers, e.g. we can't do:
>
> .kvm_reg_id =3D kvm_riscv_reg_id_ulong(...)
>
> When instantiating the array. We can do that with macros though, so our
> goal is turn kvm_riscv_reg_ulong() in a macro. It is cleaner to turn
> every other reg_id_*() function in macros, and ulong will end up using
> the macros for u32 and u64, so we'll start with them.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 22 +++++++++-------------
>  1 file changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index 6ba122f360..c91ecdfe59 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -58,6 +58,12 @@ void riscv_kvm_aplic_request(void *opaque, int irq, in=
t level)
>
>  static bool cap_has_mp_state;
>
> +#define KVM_RISCV_REG_ID_U32(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U3=
2 | \
> +                                         type | idx)
> +
> +#define KVM_RISCV_REG_ID_U64(type, idx) (KVM_REG_RISCV | KVM_REG_SIZE_U6=
4 | \
> +                                         type | idx)
> +
>  static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *env, uint64_t type=
,
>                                   uint64_t idx)
>  {
> @@ -76,16 +82,6 @@ static uint64_t kvm_riscv_reg_id_ulong(CPURISCVState *=
env, uint64_t type,
>      return id;
>  }
>
> -static uint64_t kvm_riscv_reg_id_u32(uint64_t type, uint64_t idx)
> -{
> -    return KVM_REG_RISCV | KVM_REG_SIZE_U32 | type | idx;
> -}
> -
> -static uint64_t kvm_riscv_reg_id_u64(uint64_t type, uint64_t idx)
> -{
> -    return KVM_REG_RISCV | KVM_REG_SIZE_U64 | type | idx;
> -}
> -
>  static uint64_t kvm_encode_reg_size_id(uint64_t id, size_t size_b)
>  {
>      uint64_t size_ctz =3D __builtin_ctz(size_b);
> @@ -119,12 +115,12 @@ static uint64_t kvm_riscv_vector_reg_id(RISCVCPU *c=
pu,
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_CONFIG, \
>                             KVM_REG_RISCV_CONFIG_REG(name))
>
> -#define RISCV_TIMER_REG(name)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_TIMER,=
 \
> +#define RISCV_TIMER_REG(name)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_TIMER,=
 \
>                   KVM_REG_RISCV_TIMER_REG(name))
>
> -#define RISCV_FP_F_REG(idx)  kvm_riscv_reg_id_u32(KVM_REG_RISCV_FP_F, id=
x)
> +#define RISCV_FP_F_REG(idx)  KVM_RISCV_REG_ID_U32(KVM_REG_RISCV_FP_F, id=
x)
>
> -#define RISCV_FP_D_REG(idx)  kvm_riscv_reg_id_u64(KVM_REG_RISCV_FP_D, id=
x)
> +#define RISCV_FP_D_REG(idx)  KVM_RISCV_REG_ID_U64(KVM_REG_RISCV_FP_D, id=
x)
>
>  #define RISCV_VECTOR_CSR_REG(env, name) \
>      kvm_riscv_reg_id_ulong(env, KVM_REG_RISCV_VECTOR, \
> --
> 2.49.0
>
>

