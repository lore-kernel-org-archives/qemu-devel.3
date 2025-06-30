Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C738BC8302D
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Jun 2025 10:44:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWBz4-0002Tv-IB; Mon, 30 Jun 2025 06:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uWBz2-0002Te-Q8; Mon, 30 Jun 2025 06:43:32 -0400
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uWBz0-0004y8-W6; Mon, 30 Jun 2025 06:43:32 -0400
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-53145c74e15so1295731e0c.0; 
 Mon, 30 Jun 2025 03:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751280208; x=1751885008; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O2F+WIp/lqj1SkhO8gd3nmfbC1olhmPf7niEjFLul5E=;
 b=JLviYiMJ4fBraefTWDngSQp4aZR/3eslq7vGy9CQ78Fxwk+4S7dnsXBjPx9VGxuZN+
 1PClNzGmyeLZ0dDe8aVfQzOoEbTXGmDbArHcSMcxN2JfiP8GwEE5Z5stO3XE4qHN9DY6
 sycwL5Lc6UB45HepR7O/rb/4p8Gn0dpJlMkUBkjxu4VE8GqHed3J+ZYEwAi+nlg/BsK9
 Qm06BmwFPdu3AyRsB8XgCRv2Yg74P+t8QbBe0arMLJhb80u7uBdS36ocHCOCPSHAgs3z
 sAJbZlO6yTO3Cy9o0i1gLZ9LgpnAohdiO93mGtimE6dZVdAirMjzKnm+DNoZWgCdtbMS
 CjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751280208; x=1751885008;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=O2F+WIp/lqj1SkhO8gd3nmfbC1olhmPf7niEjFLul5E=;
 b=WLdxJcc8b5OJX26aMT74u61O0uSHDQU5AGJkqOALtRX551KEdQ773kVH4ApQcbDCZ9
 5hR+Jw3yMk+OQ5gkSqU7QB9r+KMbf8QjleE4qIoJXRmtfYpv2PlDJnto0Q358q9Q5YG9
 14wRXQf1hqOsJtGqn2PDQpCDUwNC3aNgdSE0KVo3yYC/D28Lx6JN2FlbUOYVuGaRtmMX
 5xxWEb1S+muk19doJjn5zzPry0lnj8ikTI35dXBF44WJgaZ5qCJCN0i/F6qwXAm+Mafg
 VzzywtVTEDV+t4MvgdT4DeqBjLeS4Ncr75rUzVcTMxz3gCWWWxwq6WlVssWKoyhG17vY
 jlOg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3zbiRKCejmgzynF3IMmq/Rd24JAj7xPlPGsIPxgFfegQal8UrLZFhPzLE0DEfMKjg9fV+Z/tgJM2g@nongnu.org
X-Gm-Message-State: AOJu0YyXLKXmtepUNCiMcS88fn+EyTH8BnUpmOOnkVnDQrOKZtznWuw+
 fmsrwm9J5u7UuOvpje7W6jwtFjfn9YiI8NLyk0Uuv0MppCLkaIsj6pbEeUt1ciI8V0BGSPejiwt
 NIpZ4W/jFaZ7VyBR24i1ZBYkY22PFjGI=
X-Gm-Gg: ASbGncvxXg2M7xFtYjyG7LjwtDRu0kIJ+dCNFvW9k7g3VUj3EGDmOdVKRM/1hA511Y1
 cdlw8+mgLduKyOEHkYVVooaipwDPgt/VroH23kYDhILRMmkW4zxsEaRSAPLjSPOG28s1Hw3MNxK
 Nkgg8lq9rk5/lrMf7+noK0plRavHWQ301p2RUyi+vAwxdJDJlld7Wys/XS8JZEGorCtBeBGaXJ2
 Q==
X-Google-Smtp-Source: AGHT+IFzXQ7Tpe2s/mxlu8kuqt+h2K+HPALW9SBFtEYovzPmUOzdjr32rNyMmRJHUajtS/0hvvWlniMVhrXXRLCwIyI=
X-Received: by 2002:a05:6122:62ea:b0:531:2f9f:8026 with SMTP id
 71dfb90a1353d-5330be0ce5fmr6495381e0c.1.1751280207680; Mon, 30 Jun 2025
 03:43:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250401103344.84257-1-jay.chang@sifive.com>
 <CACNNAjP_h4Z2QZZHJXryqsFNSENyLbhZ-ArLFjosChFzou3_kQ@mail.gmail.com>
In-Reply-To: <CACNNAjP_h4Z2QZZHJXryqsFNSENyLbhZ-ArLFjosChFzou3_kQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 30 Jun 2025 20:43:01 +1000
X-Gm-Features: Ac12FXzN1xch84mN8bCuLc7vUTbrmWGwjRL-kvHqo4eM03-mH_jOssIqYmAn3PM
Message-ID: <CAKmqyKN4CDfCHTtGbs86t6UfEA_qZ=M2F+VKiC6RD2UiUbjnBQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] target/riscv: Restrict mideleg/medeleg/medelegh
 access to S-mode harts
To: Jay Chang <jay.chang@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Frank Chang <frank.chang@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Tue, Jun 24, 2025 at 1:12=E2=80=AFPM Jay Chang <jay.chang@sifive.com> wr=
ote:
>
> Hi,
>
> Gentle ping on this patch.

Sorry it slipped through. Can you include a cover letter to makes
things easier to manage [1]

1: https://www.qemu.org/docs/master/devel/submitting-a-patch.html#include-a=
-meaningful-cover-letter

Alistair

>
> Thanks,
> Jay Chang
>
> On Tue, Apr 1, 2025 at 6:34=E2=80=AFPM Jay Chang <jay.chang@sifive.com> w=
rote:
>>
>> RISC-V Privileged Spec states:
>> "In harts with S-mode, the medeleg and mideleg registers must exist, and
>> setting a bit in medeleg or mideleg will delegate the corresponding trap
>> , when occurring in S-mode or U-mode, to the S-mode trap handler. In
>> harts without S-mode, the medeleg and mideleg registers should not
>> exist."
>>
>> Add smode predicate to ensure these CSRs are only accessible when S-mode
>> is supported.
>>
>> Reviewed-by: Frank Chang <frank.chang@sifive.com>
>> Signed-off-by: Jay Chang <jay.chang@sifive.com>
>> ---
>>  target/riscv/csr.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
>> index 7948188356..975d6e307f 100644
>> --- a/target/riscv/csr.c
>> +++ b/target/riscv/csr.c
>> @@ -5783,8 +5783,8 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>>                            NULL,                read_mstatus_i128       =
    },
>>      [CSR_MISA]        =3D { "misa",       any,   read_misa,    write_mi=
sa,
>>                            NULL,                read_misa_i128          =
    },
>> -    [CSR_MIDELEG]     =3D { "mideleg",    any,   NULL, NULL,   rmw_mide=
leg   },
>> -    [CSR_MEDELEG]     =3D { "medeleg",    any,   read_medeleg, write_me=
deleg },
>> +    [CSR_MIDELEG]     =3D { "mideleg",    smode,   NULL, NULL,   rmw_mi=
deleg   },
>> +    [CSR_MEDELEG]     =3D { "medeleg",    smode,   read_medeleg, write_=
medeleg },
>>      [CSR_MIE]         =3D { "mie",        any,   NULL, NULL,   rmw_mie =
      },
>>      [CSR_MTVEC]       =3D { "mtvec",      any,   read_mtvec,   write_mt=
vec   },
>>      [CSR_MCOUNTEREN]  =3D { "mcounteren", umode, read_mcounteren,
>> @@ -5792,7 +5792,7 @@ riscv_csr_operations csr_ops[CSR_TABLE_SIZE] =3D {
>>
>>      [CSR_MSTATUSH]    =3D { "mstatush",   any32, read_mstatush,
>>                            write_mstatush                               =
    },
>> -    [CSR_MEDELEGH]    =3D { "medelegh",   any32, read_zero, write_ignor=
e,
>> +    [CSR_MEDELEGH]    =3D { "medelegh",   smode32, read_zero, write_ign=
ore,
>>                            .min_priv_ver =3D PRIV_VERSION_1_13_0        =
      },
>>      [CSR_HEDELEGH]    =3D { "hedelegh",   hmode32, read_hedelegh, write=
_hedelegh,
>>                            .min_priv_ver =3D PRIV_VERSION_1_13_0        =
      },
>> --
>> 2.48.1
>>

