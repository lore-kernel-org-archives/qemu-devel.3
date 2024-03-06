Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE2C6C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 04:54:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhjHs-0001jh-Qx; Tue, 05 Mar 2024 23:53:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhjHp-0001jS-MZ; Tue, 05 Mar 2024 23:53:50 -0500
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhjHo-0001dt-5p; Tue, 05 Mar 2024 23:53:49 -0500
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-7db1a2c1f96so2603579241.0; 
 Tue, 05 Mar 2024 20:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709700827; x=1710305627; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KcU6HCaWlQpWFFmsyHT+rfUwZ7Ev/Z5VjFKpsFm0RlY=;
 b=TNn8Lo2jUVBqBG2L9yZCi2+2DQvI+h92WIG2aPXE2DqOm2c8nwZs9TfKnX9nxTdzAx
 +9Omt89i0lNTbEGJ3S0HQkjhMvey64+fJbeAB3copgCiF6FtCYd7vfiUEQCSYDgHFCQG
 vdT0g/yKZ96XnglQGvPx2n1sxBILk7CwVWX/iiUdxcUwIMnfUBVDmMeanEoC/btDZ/nX
 WLkhU3ufXgb39jZr9kQr+4gGRcxxiPk4j8K2mPMXzFo2GNLu/1jUk4lEU9eRG6423kil
 jLsIhbM1FnvlwWc+Wj/Y2GVY8KctEgAEOBPieSXGYa4tf60pwK6mq9nOHLiUiG1EFNO3
 neog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709700827; x=1710305627;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KcU6HCaWlQpWFFmsyHT+rfUwZ7Ev/Z5VjFKpsFm0RlY=;
 b=bkkgCjwxS46O7Cj7cTAJ2FcQtMU2O4f3L8WFBGdQu/5hv1OjHEjOwcjIrlAtQYxcAi
 kcO4sOOjd/prQSCypwaoxf9ZxuclPn+1wjxUlAm/nCfgE4FZv2yKsfS9Tm2MuqidUz6B
 QAwUyVYxVAYnprWPd++qnYk6nOpl844v6fCffLmG3eBjynbno9dCMUHEBNFfOgkLCbHY
 TIUAtPW1V0MHoFhYZk6awdZofFbu1sYIH42ApKzBU96hIyjUDJc70zabJrr2P5Q9+1ai
 w6cOhk/wk3UmSLvEbNbiyVZCg/hJPLeafQGbsFxdW5mmILDCrq0EOsb2WQkx9aSgCiU4
 PZSw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5Yq2U67LIunox4iMW4ZP94Uu+RwqLGttcykpVtRgyRXJJFJhzyWsKIMb0kkYz3wCFsR+Nor9wXDfNvPfp1NN6uF4L8us=
X-Gm-Message-State: AOJu0YxeOD0k3ErLwoNJDKcesbQi0UXcoGX+piMPSytdl9O0yQgNcJGV
 mMvjyXjZ1vm/pkr4U5Ox+oTiWNd0wMQQhaOZh8sFJorKDMbQzd8692X8qhmk3A5/cwkAzl6TanX
 k7yM/ArFY8YdScKKgehCc4N/yaWzU2EyEUGI=
X-Google-Smtp-Source: AGHT+IFERioH7xHBrk4s4kflLEiaI0Lrc646UPSGBE9jAEJoKie4n56WQ3SabvgWllhOKMBwmeRBItnrQMtBVRRdAnY=
X-Received: by 2002:a1f:eec2:0:b0:4ca:4a07:9006 with SMTP id
 m185-20020a1feec2000000b004ca4a079006mr3339138vkh.0.1709700826762; Tue, 05
 Mar 2024 20:53:46 -0800 (PST)
MIME-Version: 1.0
References: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
In-Reply-To: <20240202113919.18236-1-vadim.shakirov@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 14:53:20 +1000
Message-ID: <CAKmqyKNTmO7v=TKErGft9nkj+EDOWuzYmxXG35hh+BQjar=c3A@mail.gmail.com>
Subject: Re: [PATCH v4] target/riscv: mcountinhibit, mcounteren, scounteren,
 hcounteren is 32-bit
To: Vadim Shakirov <vadim.shakirov@syntacore.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
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

On Fri, Feb 2, 2024 at 9:42=E2=80=AFPM Vadim Shakirov
<vadim.shakirov@syntacore.com> wrote:
>
> mcountinhibit, mcounteren, scounteren and hcounteren must always be 32-bi=
t
> by privileged spec
>
> Signed-off-by: Vadim Shakirov <vadim.shakirov@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     |  8 ++++----
>  target/riscv/machine.c | 16 ++++++++--------
>  2 files changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 5138187727..cf1867a6e2 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -271,7 +271,7 @@ struct CPUArchState {
>      target_ulong hstatus;
>      target_ulong hedeleg;
>      uint64_t hideleg;
> -    target_ulong hcounteren;
> +    uint32_t hcounteren;
>      target_ulong htval;
>      target_ulong htinst;
>      target_ulong hgatp;
> @@ -334,10 +334,10 @@ struct CPUArchState {
>       */
>      bool two_stage_indirect_lookup;
>
> -    target_ulong scounteren;
> -    target_ulong mcounteren;
> +    uint32_t scounteren;
> +    uint32_t mcounteren;
>
> -    target_ulong mcountinhibit;
> +    uint32_t mcountinhibit;
>
>      /* PMU counter state */
>      PMUCTRState pmu_ctrs[RV_MAX_MHPMCOUNTERS];
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 72fe2374dc..a4d47ec17e 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -79,14 +79,14 @@ static bool hyper_needed(void *opaque)
>
>  static const VMStateDescription vmstate_hyper =3D {
>      .name =3D "cpu/hyper",
> -    .version_id =3D 3,
> -    .minimum_version_id =3D 3,
> +    .version_id =3D 4,
> +    .minimum_version_id =3D 4,
>      .needed =3D hyper_needed,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL(env.hstatus, RISCVCPU),
>          VMSTATE_UINTTL(env.hedeleg, RISCVCPU),
>          VMSTATE_UINT64(env.hideleg, RISCVCPU),
> -        VMSTATE_UINTTL(env.hcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.hcounteren, RISCVCPU),
>          VMSTATE_UINTTL(env.htval, RISCVCPU),
>          VMSTATE_UINTTL(env.htinst, RISCVCPU),
>          VMSTATE_UINTTL(env.hgatp, RISCVCPU),
> @@ -354,8 +354,8 @@ static const VMStateDescription vmstate_jvt =3D {
>
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
> -    .version_id =3D 9,
> -    .minimum_version_id =3D 9,
> +    .version_id =3D 10,
> +    .minimum_version_id =3D 10,
>      .post_load =3D riscv_cpu_post_load,
>      .fields =3D (const VMStateField[]) {
>          VMSTATE_UINTTL_ARRAY(env.gpr, RISCVCPU, 32),
> @@ -398,9 +398,9 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          VMSTATE_UINTTL(env.mtval, RISCVCPU),
>          VMSTATE_UINTTL(env.miselect, RISCVCPU),
>          VMSTATE_UINTTL(env.siselect, RISCVCPU),
> -        VMSTATE_UINTTL(env.scounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcounteren, RISCVCPU),
> -        VMSTATE_UINTTL(env.mcountinhibit, RISCVCPU),
> +        VMSTATE_UINT32(env.scounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcounteren, RISCVCPU),
> +        VMSTATE_UINT32(env.mcountinhibit, RISCVCPU),
>          VMSTATE_STRUCT_ARRAY(env.pmu_ctrs, RISCVCPU, RV_MAX_MHPMCOUNTERS=
, 0,
>                               vmstate_pmu_ctr_state, PMUCTRState),
>          VMSTATE_UINTTL_ARRAY(env.mhpmevent_val, RISCVCPU, RV_MAX_MHPMEVE=
NTS),
> --
> 2.34.1
>
>

