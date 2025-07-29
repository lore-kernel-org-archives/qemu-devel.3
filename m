Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5CDEC83F26
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Jul 2025 03:26:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugayc-0000Ki-6U; Mon, 28 Jul 2025 23:26:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugayZ-0000Gz-40; Mon, 28 Jul 2025 23:26:03 -0400
Received: from mail-vs1-xe2c.google.com ([2607:f8b0:4864:20::e2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1ugayX-0005yJ-Ha; Mon, 28 Jul 2025 23:26:02 -0400
Received: by mail-vs1-xe2c.google.com with SMTP id
 ada2fe7eead31-4e9a7bfb3c8so3077238137.1; 
 Mon, 28 Jul 2025 20:26:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753759560; x=1754364360; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXHklO74E3GYeHmYp02MNyfCkH8H2b70dBuW8DOkbk0=;
 b=ls2HebYvqDKg6w7ZFNPMC9+sA+LaOOndhcHlUAESJZkqyLye7FBoiV3J/4fy0rUjjl
 5j3uTH+KkePDCVVY23b5xMbrMWlodEfW/NPN7lQyKG79R9hWWr/3qU7rSg+G1yQUhCyR
 xZGLSX5qP2AUaKi2irvZCm2xOvTEV21c9Hzs1AQvuPUUf9XN7Cei28VDxutvsd0WMamd
 kYxWG/xPzVs/WGTedHO7ULT5vVdp8mx0QSmC8vHzQnXtfvVBPrfTPQdaVLzUhFDkN/jB
 uHFOdCzcjM1M5sCuSIJopL9qOIBUEAAWWpIhFtSuGBnY8UL60uePy7fVGd+sNArmYW8k
 CaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753759560; x=1754364360;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YXHklO74E3GYeHmYp02MNyfCkH8H2b70dBuW8DOkbk0=;
 b=tRmOE6ropaIW/UDrJqZfVYArbZcZSfjxiE2TWJZ7W+i3zZjZJeT6KqAuyE+r7wRwn8
 9WIZ9uicTu82y4Rhs1cDEmlqGQSPghJrHEMZjnaAAzMCAQ/wzkv+tRhdI2AHkl+d5Q5i
 kIPVTEEQ3a0qEazNQKJ3pARDAujMWjk84UQ7RolVQhEJow/PHX/rViaMVlOWKPIIiTNf
 LR+L2UXG/edeDQi7w+9MllYyBqCF7lp65Ldobz6NEzTjF9mMECK9gi0m6utRkrlXy6py
 MpqlY4l5YW+QrshKt1a/3OB2P5AVozZS0uec1u5R5WyWrf4T3T05bTtjEk4QzRfnQqbH
 h0qA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV43tD29378nTO1sWSJ/yf9nrq8lQf3y5eDkUTvQqZdaJl1+c5slJfB2JGW/2E/4ZjHatYDYAd15Xf1@nongnu.org,
 AJvYcCW5jnc+SKS5NbrgW+Vk8M0J77WUV3Vw/TiYU0vGywLMysZoKHTyndgMa7sxowtGmvdsGuDtdqeN1SlQeg==@nongnu.org
X-Gm-Message-State: AOJu0YwL762fn1UFvpv8tK+r50bfck4tPoeH4xevdevISMgL49Fa6eh7
 JmoY1A8FuA0ijnEo4Y5TFoUQsGW7wQbzNolqj4jUEcPihbJGcP7qR58VcqlamP9pGt1TrNP+H4D
 zNgqaCFa1b/2TeIokK0O0o1GkNUxxtGY=
X-Gm-Gg: ASbGncuD0ozNQanF1CdVb8Pdyh4bHC/TC7+UDH8Cf2L17HrCd4LLBbH7nftwjPC2gbh
 oldttTxJfrKebKzbeV9KImhS4Yscb6x0QsESNPTPcu0AO7Vyt0xQ7jiUtvQXwSkFOvaXW83mJAV
 tVCLVk8KdjDeY3tlwQqYkssCFqOU5dE1pt09MwwC0DOvfQyrm4GU8i/afNX2ZcAuSh2bx9ryih2
 HKWc6D+fFiflvqjiqTWmVgynMr3LX8nCDaYOQX34YBB1Rq+
X-Google-Smtp-Source: AGHT+IEyK+bZCftELpULjPAUez2tfKtIp2QDHTJh08TljdVGhTcLeWWFekWhc0OJdh0ChvgxwRCpnAcC14vJh5B7qws=
X-Received: by 2002:a05:6102:358d:b0:4df:4a04:8d5e with SMTP id
 ada2fe7eead31-4fa3fa86718mr5460834137.8.1753759559786; Mon, 28 Jul 2025
 20:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250708060720.7030-1-luxu.kernel@bytedance.com>
In-Reply-To: <20250708060720.7030-1-luxu.kernel@bytedance.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 29 Jul 2025 13:25:33 +1000
X-Gm-Features: Ac12FXzr22v-mT7fBmeXEssKB88mmObp9v4yS8ruavyyUWMIaV2n0VRcMEcplC0
Message-ID: <CAKmqyKPoBL+6MtiEMOH7CPt5hpLXiwUFqd1ZtgmboGGSHYMUww@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Fix exception type when VU accesses
 supervisor CSRs
To: Xu Lu <luxu.kernel@bytedance.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 zhiwei_liu@linux.alibaba.com, apatel@ventanamicro.com, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e2c;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe2c.google.com
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

On Wed, Jul 9, 2025 at 6:48=E2=80=AFAM Xu Lu <luxu.kernel@bytedance.com> wr=
ote:
>
> When supervisor CSRs are accessed from VU-mode, a virtual instruction
> exception should be raised instead of an illegal instruction.
>
> Fixes: c1fbcecb3a (target/riscv: Fix csr number based privilege checking)
> Signed-off-by: Xu Lu <luxu.kernel@bytedance.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 8631be97c5..9bebfae3f0 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -5577,7 +5577,7 @@ static inline RISCVException riscv_csrrw_check(CPUR=
ISCVState *env,
>
>      csr_priv =3D get_field(csrno, 0x300);
>      if (!env->debugger && (effective_priv < csr_priv)) {
> -        if (csr_priv =3D=3D (PRV_S + 1) && env->virt_enabled) {
> +        if (csr_priv <=3D (PRV_S + 1) && env->virt_enabled) {
>              return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>          }
>          return RISCV_EXCP_ILLEGAL_INST;
> --
> 2.20.1
>
>

