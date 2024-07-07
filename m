Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2C09C3DA41
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 22:39:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQaX3-0001o4-Lv; Sun, 07 Jul 2024 18:38:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQaX1-0001nq-3u
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 18:38:55 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQaWz-0005Gg-EQ
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 18:38:54 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-4f2faade55dso786071e0c.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 15:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720391931; x=1720996731; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E/lxgjKOnVZfJCmDT/xWhfIAxHIkrlzi59TPuyFKwYU=;
 b=UQBUcDWWoo8CJ8v2SUwRExmmZu0+Lv4dJfHvZjnw4ovcdenvllXAy1JrRlJd8zs5gz
 yrAwk+HI62ud1NIjUdn4xUs+SEzfXkQVxAHJuF6BAi+jA7KERfKUwhbtHZ/vUb2crs1f
 X3lkeq9BjrAdL6NIXizw9M9x6bTdbsct3wpbEkOQte181do2RGyWeptF9eJL87QiP6fy
 vbdf0iLvov7pkinYcOOhjaQTEnJZhcDySwEyF1BLFNbNrjgwVliAXCEcV5sAhj8Zlbx3
 Lio6/5cLYdsaExNR55EYfh3ZltJnQ6D4t1byRVvM11PAcUGwWf7hFeXPybPnbflWh96n
 CKJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720391931; x=1720996731;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=E/lxgjKOnVZfJCmDT/xWhfIAxHIkrlzi59TPuyFKwYU=;
 b=CEPYCi9sVQ0zqUbzs1fZwpiQIG+7ksuECge1zFmoY1D5s8dMe+OHflnUojwxDFUXLI
 YqJlEAOj0wwWtuO+OCeVIpNsDCSkW0ke+zwxCBBKQm3L+f2sTShELaymz/kp6nqbe1pn
 QLoLeqJGK5aBHzk6xMaXt4Iu3BzUOVtOzXa2iyGqhh97+2EjMSeQ4gpHTK6Remy3ZHyU
 yu8a1NETC5Mb14mBygcTFQn4PE8/wmLvbLFu2hR7dS43A1koKuTdMGDwy9R/tz3aNhhf
 wQr8Qvi2TYb291BbWui/duPesL9jVk47abayLaNuphNN8SSNSrUA+3htQxb1d2C7pPDx
 hCzw==
X-Gm-Message-State: AOJu0Yz0fRAsAgglHTPSTgSpvuMkZgajMFWmUI2rN7vuoTGv33PbtlF0
 5JGbwp23schWQZVmV2rrFqYsQhoYNacXJRNPFNKcWTKavyRLGRlhChlqx1Ry8v9Ctx1o3HiBmWa
 hLyZf7vOt/mK6aga90pL3mnPcMss=
X-Google-Smtp-Source: AGHT+IGGX4lV9yDcd7THGf5Mpof8ZwoJq3kWqzrgD/Iujkm+E2Brex8nJOsy6gGdhxqDW99Qh+i2KRBEbiyjUxNFuNw=
X-Received: by 2002:a05:6122:4884:b0:4ed:52b:dd29 with SMTP id
 71dfb90a1353d-4f2f3e437e6mr11138695e0c.3.1720391930456; Sun, 07 Jul 2024
 15:38:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240701022553.1982-1-lijiayi@eswincomputing.com>
In-Reply-To: <20240701022553.1982-1-lijiayi@eswincomputing.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 08:38:24 +1000
Message-ID: <CAKmqyKMmqPkMWVotao_PtpFtJLQSYahqvmLxdr-UZdx7o+kgJA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Validate the mode in write_vstvec
To: Jiayi Li <lijiayi@eswincomputing.com>
Cc: qemu-devel@nongnu.org, bmeng.cn@gmail.com, dbarboza@ventanamicro.com, 
 luweu1518@gmail.com, zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a35;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa35.google.com
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

On Mon, Jul 1, 2024 at 3:42=E2=80=AFPM Jiayi Li <lijiayi@eswincomputing.com=
> wrote:
>
> Base on the riscv-privileged spec, vstvec substitutes for the usual stvec=
.
> Therefore, the encoding of the MODE should also be restricted to 0 and 1.
>
> Signed-off-by: Jiayi Li <lijiayi@eswincomputing.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 432c59dc66..f9229d92ab 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3791,7 +3791,12 @@ static RISCVException read_vstvec(CPURISCVState *e=
nv, int csrno,
>  static RISCVException write_vstvec(CPURISCVState *env, int csrno,
>                                     target_ulong val)
>  {
> -    env->vstvec =3D val;
> +    /* bits [1:0] encode mode; 0 =3D direct, 1 =3D vectored, 2 >=3D rese=
rved */
> +    if ((val & 3) < 2) {
> +        env->vstvec =3D val;
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "CSR_VSTVEC: reserved mode not supporte=
d\n");
> +    }
>      return RISCV_EXCP_NONE;
>  }
>
> --
> 2.25.1
>
>

