Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C783CC3600C
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Apr 2025 01:02:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0VSL-0004sQ-3u; Thu, 03 Apr 2025 21:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VS4-0004pi-2U; Thu, 03 Apr 2025 21:02:35 -0400
Received: from mail-vk1-xa35.google.com ([2607:f8b0:4864:20::a35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u0VS2-0006t0-G7; Thu, 03 Apr 2025 21:02:31 -0400
Received: by mail-vk1-xa35.google.com with SMTP id
 71dfb90a1353d-523f1b31cf8so679251e0c.0; 
 Thu, 03 Apr 2025 18:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743728549; x=1744333349; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x68U34F9ehDIP4UUE4d/D7DeRlSKMpt6MLD2WuRd2aI=;
 b=axUnjZk7oUf85QPX4wkN/maop/JQYz8FD9tWmUYuQCGbZ+KmhaKazFD2rIOVScajja
 sFJ9ZzCcWrCzOcVSN7ZgFWPx7HTcWR5KCdUyE9f97m5WqWowJz5zDHh0W8t1JikRC1xn
 dfJFFcYMrO9jCt0WsUO/5x2yFe3Ivh/pQcS/eaRDBUobiaOuZk5q+wrkoGl1Iwzq8GlD
 twOO2HmDBnuV/F3DvgP9MgzBkiN9zgn0MnUi/MkKpM+xfXCHBp3K+LDM7aViIblt+Xgv
 fbvCW5AtoJXaHUbhW1I3Kdfp0Jb6RjRhRoD3Eokdmn9TJ7SqSrioSroURrArGeHTz+WR
 TBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743728549; x=1744333349;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=x68U34F9ehDIP4UUE4d/D7DeRlSKMpt6MLD2WuRd2aI=;
 b=qaRcwO+TpMTHbiHhVsIzRy+CbKPZ0QV8a69vFBHQp5W2rrTHSKXD1/oCrCxujDa+mT
 FCEzKP66nwYiJdVN9T0QeI3DQ0k/zeonV6UIBiSYFLiT3IK0n51JHA3Zj/zMfOeyXBdJ
 s+4oixAEc+tHJmUEIISR0oTAONMP5d0BHmdNXcWtn67vMgrUUMEcUtoeBcUT0Of4QK9n
 50PPRIZNiON+IKEV4tJ0ih8nfSFNqa/pHEDFvtMQkcmBK8QyHLCylDYBbE8B/1qd39bW
 5XKJ66cT5HrHH+F0MB7x/88yXQpaWtYR7iZlDON+kSDpTKw/TZmb3BHxq5BBDVwCWNnb
 mdvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVt/ZNJ8y08zb7bLzTuHrVH7C3U6NjAe7varxbTevhpcD99Lkr4/Ydr13buETErjdf0jjyVhmOIpnA1@nongnu.org
X-Gm-Message-State: AOJu0YyV4bGiVOBdeeF/f0C7gDG9WMAY+6vJOrphunoIDEZ3UikRtN1y
 G9TJzq0XTJO+zzDLaCZvTdEBe59WNdTYOuLbPtpnbUd43TJMjG8IxnMaXvSuQoNMwzmcKKL7tut
 Y7+6A72GNEk8Q9M0BJkQDqc2Un98=
X-Gm-Gg: ASbGncsJ1gP2UzZ7YGS8K2fAlwjdmQ897IqNIooOcRhO7WkEqUGbarK5vYyLVL1j6vf
 Scxyyl8gnszmyKHhGNfMzjv06Hl6kK2UkuhbZOReq9vO6LGN2l6gXpi5W7LATn4/ZAn2AbSLDYq
 w1VPFrSLpmudQwIBny8RC+Xd/+BGiKkH9B/olVA/77JdM7doJesJD3qqbo
X-Google-Smtp-Source: AGHT+IFCk6Q97G4IvBHm4aql/w9ennJFvwrb3pAEDAdIyyKgTMV3BR5Di6xTRFqfDXlVyYvY8RxT9W7JyCM6ZbpHSmQ=
X-Received: by 2002:a05:6122:6585:b0:520:51a4:b84f with SMTP id
 71dfb90a1353d-5276444fe9cmr1566088e0c.4.1743728549103; Thu, 03 Apr 2025
 18:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250313193011.720075-1-loic@rivosinc.com>
 <20250313193011.720075-3-loic@rivosinc.com>
In-Reply-To: <20250313193011.720075-3-loic@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Apr 2025 11:02:02 +1000
X-Gm-Features: ATxdqUGQ3Vntb97LMfm6TJHP-pPbgkBnEsTf09QesEfd75T0Y7K285JqbW6g35s
Message-ID: <CAKmqyKNmrdsgMgpUTknjBzN4ubisvBGF-1qATwPh_T2Z5fNu3g@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] target/riscv: pmp: move Smepmp operation
 conversion into a function
To: =?UTF-8?B?TG/Dr2MgTGVmb3J0?= <loic@rivosinc.com>
Cc: qemu-devel@nongnu.org, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Weiwei Li <liwei1518@gmail.com>, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>
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

On Fri, Mar 14, 2025 at 5:33=E2=80=AFAM Lo=C3=AFc Lefort <loic@rivosinc.com=
> wrote:
>
> Signed-off-by: Lo=C3=AFc Lefort <loic@rivosinc.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index e1e5ca589e..7d65dc24a5 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -31,6 +31,15 @@ static bool pmp_write_cfg(CPURISCVState *env, uint32_t=
 addr_index,
>                            uint8_t val);
>  static uint8_t pmp_read_cfg(CPURISCVState *env, uint32_t addr_index);
>
> +/*
> + * Convert the PMP permissions to match the truth table in the Smepmp sp=
ec.
> + */
> +static inline uint8_t pmp_get_smepmp_operation(uint8_t cfg)
> +{
> +    return ((cfg & PMP_LOCK) >> 4) | ((cfg & PMP_READ) << 2) |
> +           (cfg & PMP_WRITE) | ((cfg & PMP_EXEC) >> 2);
> +}
> +
>  /*
>   * Accessor method to extract address matching type 'a field' from cfg r=
eg
>   */
> @@ -355,16 +364,6 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr a=
ddr,
>          const uint8_t a_field =3D
>              pmp_get_a_field(env->pmp_state.pmp[i].cfg_reg);
>
> -        /*
> -         * Convert the PMP permissions to match the truth table in the
> -         * Smepmp spec.
> -         */
> -        const uint8_t smepmp_operation =3D
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_LOCK) >> 4) |
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_READ) << 2) |
> -            (env->pmp_state.pmp[i].cfg_reg & PMP_WRITE) |
> -            ((env->pmp_state.pmp[i].cfg_reg & PMP_EXEC) >> 2);
> -
>          if (((s + e) =3D=3D 2) && (PMP_AMATCH_OFF !=3D a_field)) {
>              /*
>               * If the PMP entry is not off and the address is in range,
> @@ -383,6 +382,9 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>                  /*
>                   * If mseccfg.MML Bit set, do the enhanced pmp priv chec=
k
>                   */
> +                const uint8_t smepmp_operation =3D
> +                    pmp_get_smepmp_operation(env->pmp_state.pmp[i].cfg_r=
eg);
> +
>                  if (mode =3D=3D PRV_M) {
>                      switch (smepmp_operation) {
>                      case 0:
> --
> 2.47.2
>
>

