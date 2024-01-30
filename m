Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2049C47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 00:42:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUcCc-0002Hp-Lr; Mon, 29 Jan 2024 19:42:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcCK-00028z-9T
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:41:58 -0500
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rUcCH-0002HJ-U7
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 19:41:55 -0500
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-46b1a355f5bso567753137.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 16:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706575312; x=1707180112; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0TUAtp/6pFPhxYLNzV+aQ6B/tr35NbfRCPtlQPD9ypI=;
 b=KW/pSfdPqfZWIkVXSiWg12Z6Qf66Sz1dXdBLQ0uh1jLE4I8RUxmCOB2bOIukuWdpPH
 hFSs6uChChfkFYyv0WIIK7A1dRK1RJutR/8GBVNhk3I+mOhRaMjFQ1emomIAfanongWK
 AZmx+rwNEAUm7qe6zEAERaUxjEk7hx5QpIJ6T+5cUvhZ24xVzGMlErmELAFULvG6gLY7
 zIYs9qWBi04tuI8M51cT999CQdwHL8hMWERbHZnisDsvzBxyJH0vlEPWBwxH8tpq85eV
 WF//vleQUMkHG1shQNKfnGLXC9GRQBgBYRteKTLVopuYJvAdc0Ysu8NxrRmfcA2Ho/db
 x7Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706575312; x=1707180112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0TUAtp/6pFPhxYLNzV+aQ6B/tr35NbfRCPtlQPD9ypI=;
 b=EDDc/50fPNhhdK4TT+BJ9cxAOvAxxe0TCxR/Gp7opA3NIZTO6e55kUSXNkKpINipzn
 H/UqQrVm6pMA/E+CGyncKeeyazTeDPxc/qvw6f/+rb83gpo4t4KS5QbZdoZOcepyaMX4
 YOanDP56YwoBzRHkSLXxP7AJAh8lxhnDSOykYEj4dQ+KDYCCK+wLW7F8vlGMR2z9nMJs
 hIKGvOLpN3nM2vCmAahs+IAhKA8Rsylo5s3dRHINu9/iQxwrFWNCNd0m+3aaXVwvJL0y
 7o6RvDLQmQ22OgOidadcddW1inG7UgESBarB/2pPhWMWCJnAgJZfSYqRsbIw662AYbma
 qhiQ==
X-Gm-Message-State: AOJu0YwnQ3NZ3V/MB1qP1nU9ldlAW+vxuOKn+piHIxQvoTL7jBfWZnNM
 5W4eplOYyCkpHCX+kVwQfnQs5nyPxl0Z3nmmr/IQzKc4f3IPruWQsk++M/94QW4UMk4cnUuzTLo
 /X5RgCXeVfaFeL8PWOU7hMufypR0=
X-Google-Smtp-Source: AGHT+IF70eFiK5QTM4T098IObavoAHSuM37g4XbINlBcFXQnsEg+pps9gORPtGKYiTXn2fr7xPJw6ojX7MXxPpb35LA=
X-Received: by 2002:a05:6102:15a7:b0:469:4e60:6fee with SMTP id
 g39-20020a05610215a700b004694e606feemr3044882vsv.13.1706575312109; Mon, 29
 Jan 2024 16:41:52 -0800 (PST)
MIME-Version: 1.0
References: <20240129233043.34558-1-richard.henderson@linaro.org>
 <20240129233043.34558-25-richard.henderson@linaro.org>
In-Reply-To: <20240129233043.34558-25-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Jan 2024 10:41:26 +1000
Message-ID: <CAKmqyKOrRqFC-5sZQxHg4cg7BFYi1VpD0eUNrc4GAc7HG88xNA@mail.gmail.com>
Subject: Re: [PATCH 24/33] target/riscv: Populate CPUClass.mmu_index
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, anjo@rev.ng
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Tue, Jan 30, 2024 at 10:03=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 8cbfc7e781..be21fa09c6 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -867,6 +867,11 @@ static bool riscv_cpu_has_work(CPUState *cs)
>  #endif
>  }
>
> +static int riscv_cpu_mmu_index(CPUState *cs, bool ifetch)
> +{
> +    return riscv_env_mmu_index(cpu_env(cs), ifetch);
> +}
> +
>  static void riscv_cpu_reset_hold(Object *obj)
>  {
>  #ifndef CONFIG_USER_ONLY
> @@ -1810,6 +1815,7 @@ static void riscv_cpu_class_init(ObjectClass *c, vo=
id *data)
>
>      cc->class_by_name =3D riscv_cpu_class_by_name;
>      cc->has_work =3D riscv_cpu_has_work;
> +    cc->mmu_index =3D riscv_cpu_mmu_index;
>      cc->dump_state =3D riscv_cpu_dump_state;
>      cc->set_pc =3D riscv_cpu_set_pc;
>      cc->get_pc =3D riscv_cpu_get_pc;
> --
> 2.34.1
>
>

