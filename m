Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A70C27C50
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 23:14:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEdLw-0004Ct-A4; Tue, 04 Jun 2024 19:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdLu-0004C4-AI; Tue, 04 Jun 2024 19:14:02 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sEdLs-00050u-Ne; Tue, 04 Jun 2024 19:14:02 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2e72b8931caso67557741fa.0; 
 Tue, 04 Jun 2024 16:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717542838; x=1718147638; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VaIfSdzUQaKqeXZC9BglemWW7dzie1elBy+ThMPa+hs=;
 b=GPQSgggK8M4VqWMLjT+TV65lcWsF4miQ19ctFoVGWHJCOyM+vJ6sKUcEIpFk5/1N8V
 O7QPqcn9nJOdwhHz9wTYkPLyOiLFx/EFiZm7j4ozt6yW/9bdkyXU6Chgc2AdEngd9eAQ
 hNsCI1utbKipBzzimjU8MRk9hkVpYe+MOE9t+0pzpc1i1M2DOUn3+5r+8LnOOiC9+1l1
 XOZmTqMZsQup9Oph11ITMPjxGpowh28y7l9eFgZ6jjVwDe/8KrlzbXWclbDn20T23Ugw
 q/sTCcznq7WQNJUF3Cb7RaOJ/QSpTJBh/w21H/KcuDA5KjH77yU+kkNvKeO+F1pB/WWS
 mHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717542838; x=1718147638;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VaIfSdzUQaKqeXZC9BglemWW7dzie1elBy+ThMPa+hs=;
 b=D+i454JQ/EnsWmHSWIB7PIaNLjYDjVJZ5eO+Vmh9I1LcCz7k2nLn49mCVmpRbBdjge
 KlcRIF6W9c9f32Z/PL+iTxHfoo+oDsk202/rxuX6rx5m7BOHe3K/R8B2YUvs3X/Nj1kz
 9i8mFSDvbkQsJSVHe4K4Eu8nL9an51Y/m4qA+QY7O1YiT+EZBQmFdVpRmQf1E8SlWFsj
 zoktapezsEPBFgOTCbmi7TPz+30opyzE4TCVheei+iWux5j2RIrq7zHjWmxQmtLcjjvz
 3gjvew5AkVGbrVlnMOP+7CktoZVGAOJMb+wrEySoJPwA/3uJMI4VZrfNgT6wwqXJRR4j
 2OiQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr2yMBLT7dyf58dHKcIdlASgXsw59VbiY5YrmfEJHYoRn98etm8Hpqn/nVOtXuEzr7bGk5ak/awwHOieAehmEaShCsWt0=
X-Gm-Message-State: AOJu0YwIdJw+0mu/89L4aXaebh0+TJn0zm9j+2tQTGhk4uBIytHDp/FD
 qwwVECzkUuWprB0XEN5/Bedk3qSBZt8qDnf3A7KQadsT2DCCwKOe8wypoFInwkPKHEVyVBJc8zY
 YEX/GZLKKDI9iquVWJEpDmzI/DT8=
X-Google-Smtp-Source: AGHT+IHYwr1FyUAtRd/dTAAmrMYJHi9KffFdd7PPGjawFF+gLUXE/48G9g/8rNZn/zaLf1N/4GjpHB6rhRqYzbw1cls=
X-Received: by 2002:a2e:b895:0:b0:2ea:aca0:2769 with SMTP id
 38308e7fff4ca-2eac798e71cmr4090551fa.1.1717542838319; Tue, 04 Jun 2024
 16:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <20240528080759.26439-1-duchao@eswincomputing.com>
 <20240528080759.26439-4-duchao@eswincomputing.com>
In-Reply-To: <20240528080759.26439-4-duchao@eswincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jun 2024 09:13:31 +1000
Message-ID: <CAKmqyKOMz=PugsaP_UASDEUBvKgSgCuokoAw6PGTiAss4GDdAQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v2 3/3] target/riscv/kvm: define
 TARGET_KVM_HAVE_GUEST_DEBUG
To: Chao Du <duchao@eswincomputing.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com, 
 ajones@ventanamicro.com, bin.meng@windriver.com, liweiwei@iscas.ac.cn, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 anup@brainfault.org, duchao713@qq.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=alistair23@gmail.com; helo=mail-lj1-x234.google.com
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
> To enable the KVM GUEST DEBUG for RISC-V at QEMU side.
>
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  configs/targets/riscv64-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/targets/riscv64-softmmu.mak b/configs/targets/riscv6=
4-softmmu.mak
> index f688ffa7bc..917980e63e 100644
> --- a/configs/targets/riscv64-softmmu.mak
> +++ b/configs/targets/riscv64-softmmu.mak
> @@ -1,6 +1,7 @@
>  TARGET_ARCH=3Driscv64
>  TARGET_BASE_ARCH=3Driscv
>  TARGET_SUPPORTS_MTTCG=3Dy
> +TARGET_KVM_HAVE_GUEST_DEBUG=3Dy
>  TARGET_XML_FILES=3D gdb-xml/riscv-64bit-cpu.xml gdb-xml/riscv-32bit-fpu.=
xml gdb-xml/riscv-64bit-fpu.xml gdb-xml/riscv-64bit-virtual.xml
>  # needed by boot.c
>  TARGET_NEED_FDT=3Dy
> --
> 2.17.1
>

