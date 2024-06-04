Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62D33C25B78
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 23:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEdLN-0003jn-8S; Tue, 04 Jun 2024 19:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdLM-0003jb-9I; Tue, 04 Jun 2024 19:13:28 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdLK-0004P9-Mw; Tue, 04 Jun 2024 19:13:28 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-57a7dc13aabso2008158a12.0; 
 Tue, 04 Jun 2024 16:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717542805; x=1718147605; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/N8p3tDBAyHF7S+Qw98Ks+kqfhRdG9ufBM2L+fwFsWo=;
 b=nANdZM2OoMNOb8p+l8g1PdZKzbAU8w88fb3m7hXMveyQPJamRhhpMHqJWXu22koHd4
 tJNXO+oO/BsQFqNV7YMbMpfaAUPZqSEcCN2qZKWK3vB5xQn8j84YEdX/dDjkifdKnjEM
 UXr5gEfmLc1Bao22Peyrrr9+x7Yah2gXltuCFpY7HUAzTUCnZP0yY4sHnGob98dcxMDa
 nLcG0AFCBUyG8MW93ycZ9cHdBRzdvfQen7qrxbpMYsSvej0F2FaUGOuEyDLrWLPiQ+k0
 05/OYyhPgoOiwFfCqzP0q4uhR4j9IuaWwZmFJemwsVZ8gB42jDBuz8wJZpyF/kEC01Ru
 gR6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717542805; x=1718147605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/N8p3tDBAyHF7S+Qw98Ks+kqfhRdG9ufBM2L+fwFsWo=;
 b=N9H/PyOTDovKNYNBcNcAThU0aI8pKbAtV+ueETzla1wdX4ZQGe+clHbmdI8NYt2SPN
 s9fF/tzP6daBtQidlKnmZhM7ZNkK6kmwqJdDX4+2GnfLBW5Sch6oedhyMLKC1yBYdBPU
 r5VlUrMEzCxv+W6hZvjWx1Ox7P1wxtMsFvDKU1iZbWFasAOq0HSQ9Vw2J41tJ1WGt3s/
 XqLV9R+mqK1pQd/UxI7fpxiYpXaH21TXCk9w0naxCFvcsSJv+fh8+EHSeDlXLXUJdl0z
 qGt2Gv3Yj1eS8c8+aO0b35AfjFN+gbfWjDo/puR4Ya5YY+x4QA4l7O4y3uDKvNUmc2uv
 9jTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWV4sauUohYBaetsE7JcHDYIOQmlVPDtacPFasjsmLnG/iZ1T934HRtmUoe/f6K4OyDlntAsxrOFCdCo+L4L6D9dT5cl8s=
X-Gm-Message-State: AOJu0Yz0okMDy9Eh+iCa0ynnxQcF2/sl+mzXZyj5y7duGkH8aWnhXdZ9
 DgdBiwmbC8n+sIxHgtgqo4sfv2QcFwM5pDqt93CiRoCOrD8XtH3+Dj1l5NrhTQjic0IVkf64N/u
 jCbCAz5tMnr7lu9C2Q1JZF1uQzyM=
X-Google-Smtp-Source: AGHT+IFp8At8J8ymMZbcE198sNF5VBGqzuzs2CnWU0SFMOJXzIH/pPhExJh7JOhx7rWAU7Imnj1E9QzhAgjsiTUtfk0=
X-Received: by 2002:a50:d592:0:b0:57a:48c:c0f4 with SMTP id
 4fb4d7f45d1cf-57a8b6a69efmr576436a12.17.1717542804466; Tue, 04 Jun 2024
 16:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <20240528080759.26439-1-duchao@eswincomputing.com>
 <20240528080759.26439-3-duchao@eswincomputing.com>
In-Reply-To: <20240528080759.26439-3-duchao@eswincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 09:12:57 +1000
Message-ID: <CAKmqyKMvKefTfSs3qd_7pcYo5LRBfswHQH-Lp+juNmWfD+FL-w@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 2/3] target/riscv/kvm: handle the exit with
 debug reason
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 ajones@ventanamicro.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, May 28, 2024 at 6:12=E2=80=AFPM Chao Du <duchao@eswincomputing.com>=
 wrote:
>
> If the breakpoint belongs to the userspace then set the ret value.
>
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/kvm/kvm-cpu.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/target/riscv/kvm/kvm-cpu.c b/target/riscv/kvm/kvm-cpu.c
> index c50f058aff..bbde86c3a4 100644
> --- a/target/riscv/kvm/kvm-cpu.c
> +++ b/target/riscv/kvm/kvm-cpu.c
> @@ -1555,6 +1555,21 @@ static int kvm_riscv_handle_csr(CPUState *cs, stru=
ct kvm_run *run)
>      return ret;
>  }
>
> +static bool kvm_riscv_handle_debug(CPUState *cs)
> +{
> +    RISCVCPU *cpu =3D RISCV_CPU(cs);
> +    CPURISCVState *env =3D &cpu->env;
> +
> +    /* Ensure PC is synchronised */
> +    kvm_cpu_synchronize_state(cs);
> +
> +    if (kvm_find_sw_breakpoint(cs, env->pc)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
>  {
>      int ret =3D 0;
> @@ -1565,6 +1580,11 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_=
run *run)
>      case KVM_EXIT_RISCV_CSR:
>          ret =3D kvm_riscv_handle_csr(cs, run);
>          break;
> +    case KVM_EXIT_DEBUG:
> +        if (kvm_riscv_handle_debug(cs)) {
> +            ret =3D EXCP_DEBUG;
> +        }
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: un-handled exit reason %d\n",
>                        __func__, run->exit_reason);
> --
> 2.17.1
>

