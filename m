Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5801DC369D8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 11:36:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9MmF-0004uv-JM; Mon, 28 Apr 2025 07:36:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Mm0-0004dk-7C; Mon, 28 Apr 2025 07:35:45 -0400
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u9Mlx-0007IU-2B; Mon, 28 Apr 2025 07:35:43 -0400
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5240b014f47so1965894e0c.1; 
 Mon, 28 Apr 2025 04:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1745840139; x=1746444939; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3EsV7k/FuAOkrFGPbTAMGG3l2r0gJBfaQzva5veKlH4=;
 b=hGn73dVaYxctQ90p+5675OgG9+bwUZUvNubdNbHHAsJ/u2zV0VP/Wq1eap6awX94q3
 9Fba0LYKji3X19ABduIy/YZzuRGZb60trPAqTs30BJU7O6K/CUGBaiYObI1V17g/TuZ7
 RyO1CIMXUyWmhBYzqqzHN+IOjsf9OpaCpxACT0Ix3uRj+GgpObIy9jQ+MDIDFr6YGAu0
 DGb0n1sWgDSDenEzZea9o/nbkYw+FGfLd317xKc0lm8NZmOuq+rVy8l+QxlPlhb43qqu
 RY7+d3nMtcvS6TQPZEiYg2xiJn5IjZCAjZBPQ4caxM1CpuD2OwXGETmZ0ABCQWffJyWW
 +MxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745840139; x=1746444939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3EsV7k/FuAOkrFGPbTAMGG3l2r0gJBfaQzva5veKlH4=;
 b=QfVwHegj8C+2aGN6r8EmkAsFsptIVJl59s5I/0zYXzST46XScuCT5OAVhgAlk1szYm
 Cqbhr/yH3d4K5Z8HfTfqJDUZmBU+Uc9tuA62ohcqz/aVkbhFGW5JYT3Ry3nk6cHKQ2Yd
 lsnD8w19M1xevpP5UPe7qW0eLuivJvBCGQEwXPzsbseD+mpmJwVeanOq5r5xk9+lfNuY
 UKWKa4DmSuUzZ8ZLlho3CCY6rCDwU5wYDVnvoGDTLXnfKXrCwkRNE0bzquXwvTIaqtcN
 TRgB3sAlEuK7elaNm4O5g1UqV9n42niMg+hGE/rE4moPeFui6CJwJp5vmUGYtCzdqMRy
 H60g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHhGEMiRe7n1jf2/IEy2kic/KsywCJeYPmeaDCxCBRRLP2u1Q4rM9+TEdLZdBBh9oERbytXk8s+5Vr@nongnu.org
X-Gm-Message-State: AOJu0Yzb89GRvyhTGrFj+h1DCDFOnm4s1cXZE8Cw4Ic4UeipdAxsdCIj
 k8RjMqcgiYnswHnp1wQfpJm77hu5f1iiFCyJ+BnewTVmqPt9nQJJVv9THU/LczTGF0pMUrqRhRB
 mkv87+4BUwD9EFrNbkts0Cmlb3wQ=
X-Gm-Gg: ASbGncs8pR0s1xT2wXt5tcg86bDqK7158HPjT/4tO1DWJuasIQaXOS3+mHZ8PqWBVE/
 fGVQxnCFfGlrdAYW8VeZQsmhE8TPhnhgUaU6JXZnB1X8p/FqoTQcxc4MisRR5ssc7fRPKqWQdsk
 47+Yxllr5vYfA3dQHL1WHYoU9h9dEFDXvJzr//XVC1/1JwIZBo20Kn
X-Google-Smtp-Source: AGHT+IEfqb3rapnJLVZDVFhbb2VzUGIU/m2xTt/WPD6e0a8c4/XoKQDlLEGbCvModZSsQ4GJp3EhDFBR1ku7aBvl6cM=
X-Received: by 2002:a05:6122:1818:b0:529:2644:8c with SMTP id
 71dfb90a1353d-52a9713267emr4703890e0c.8.1745840139094; Mon, 28 Apr 2025
 04:35:39 -0700 (PDT)
MIME-Version: 1.0
References: <20250425160203.2774835-1-dbarboza@ventanamicro.com>
 <20250425160203.2774835-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250425160203.2774835-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 28 Apr 2025 21:35:12 +1000
X-Gm-Features: ATxdqUHxRc7YS4s0NgiWyQWFaDmB8A0vffoSHAhSfqwxJRn09_ei8hTtSb4PBu0
Message-ID: <CAKmqyKP_rwOskpCGuwy2AWyp+QFTemCV5-TrnyphSUuAxm_XpA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] target/riscv/kvm: fix leak in
 kvm_riscv_init_multiext_cfg()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Sat, Apr 26, 2025 at 2:06=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> 'reglist' is being g-malloc'ed but never freed.
>
> Reported-by: Andrew Jones <ajones@ventanamicro.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index accad4c28e..6ba122f360 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1119,10 +1119,10 @@ static void kvm_riscv_read_vlenb(RISCVCPU *cpu, K=
VMScratchCPU *kvmcpu,
>
>  static void kvm_riscv_init_multiext_cfg(RISCVCPU *cpu, KVMScratchCPU *kv=
mcpu)
>  {
> +    g_autofree struct kvm_reg_list *reglist =3D NULL;
>      KVMCPUConfig *multi_ext_cfg;
>      struct kvm_one_reg reg;
>      struct kvm_reg_list rl_struct;
> -    struct kvm_reg_list *reglist;
>      uint64_t val, reg_id, *reg_search;
>      int i, ret;
>
> --
> 2.49.0
>
>

