Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AA44CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 02:55:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfIF-0005LQ-8Q; Thu, 30 Oct 2025 22:55:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfIC-0005Kt-FF
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:55:08 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfI4-0003a5-Uw
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:55:07 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-b70406feed3so280903266b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879294; x=1762484094; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=81MwG37dBH8oA6hN8D8om5ls1FQzpNFYqW7spIHJhwk=;
 b=MaTLaZLEhzF16QvLzKXQAjdlPgUyLyxvPLrvIaxwrHtUHoL+A5bx5yUwe3rAIWqvZp
 pcYB6yJxRMQcL/QOe+cPdFTEFg84Ho0q5pwOviat/gwv+e1IGpj0IWMOgmZu/otBAD+E
 V3Sg5VfUa14Sbkmuk4LcZU+9C6Z0C6LQKDdPJjsnec0C4eZ0P7fZ3Su3PRdhXR5eiHUk
 XTJ7NQ52+dXS/8+CH4UVlSlGdxCxP+lk7viKAft2TBNmyzyIfWW7iqepQvLXwP89A88S
 u2+Kkis2UfuT05D3g2JcXWVnKfUeiExJ0E3jK2WK6loEOvdX72C/Pa26DfuiHJ7gBWzW
 Y0Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879294; x=1762484094;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=81MwG37dBH8oA6hN8D8om5ls1FQzpNFYqW7spIHJhwk=;
 b=Ric3CMFOAHaY4cTTrGiLWuZJ66xmBOneW7N2nabAhm357qCXEYKJJqZOOaszRiS1rJ
 Vj1AgRRbuQQZk6TQfCDjwo/qSO2/9h5OQKYuSg+hhylTcGWg5dTvwL/1Hcz1ACFG/YkJ
 6RjLyz385TF4wvlgCch5TjqcahCy2QJfr5usMqD569+eay+TuRKALhN5CQuR97L38ZYn
 yYA3Mzw0kXSBLzvR1xVAXMWMv8Z9FTsQWRbphFneHU3vnTvwJ0Du6ZxbrdGRQmfW6Sov
 iAjC/4XyxqFasfAiNpcg7ZL5wwvJ3mpJnN+sd3UzxNxBRD+ExEmf6pNw8V8aJHAPR6IT
 +7zw==
X-Gm-Message-State: AOJu0YzICASS35euYziOAJuASd2Xf1LtW6hMdE7r+cavkrIn9Ng0ClRd
 VAwPbWz6zUkAtMYES38Vbyr9/ZL+WSC+VBDwT1L/jd8AiOaJ7uEAeoE8KrgkK8Zxoal9kR5G4hQ
 o4XYeiMMJB1Ei7PxX9D4SBuBT59y2V1E=
X-Gm-Gg: ASbGnct2E1qETtdQijuK0Cl6WyWL0UWc20FpdoxxJ5/R2zyyBZ2lVXIk4iz9+xEfKd7
 TXMOzagTv8EbZwLKAOofdaefxSYIpH5mP6780oOMCWJdKmX+lJIYyMqu8GrcV6DUNzhbc1PuwDT
 AGepks8SIfKjxWaeypStNiYHg1ehOriA1onn5Bic1HKQ70wgyGMnxLjWrnNork9bywzpy6MZYGV
 WczAzEKlE202mv1IDGFs0aeQO2z3wbqDmAzDgLmYC0rg5Gvh73VNfXNN2fj13ymqTNK1rvyQ+Ql
 7QmgO6y2tgUx0T4=
X-Google-Smtp-Source: AGHT+IFUHEsQg6gx3mdDAfdL3FTsrtKS6Vjr7XYIWw56bWFegHeR16WQLdkFlPtyUbW45Ey1VEwHqLGRvGcHUQvVxd0=
X-Received: by 2002:a05:6402:26cf:b0:63e:914e:5159 with SMTP id
 4fb4d7f45d1cf-64076fada3bmr1404995a12.13.1761879294016; Thu, 30 Oct 2025
 19:54:54 -0700 (PDT)
MIME-Version: 1.0
References: <20251027181831.27016-1-anjo@rev.ng>
 <20251027181831.27016-29-anjo@rev.ng>
In-Reply-To: <20251027181831.27016-29-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:54:27 +1000
X-Gm-Features: AWmQ_bnc_HBX-hFfsnaS08cfXaaQ1ZTuKSw5kTsdsfuMMez166nk6KEE1UdcRAo
Message-ID: <CAKmqyKNvOzEKhiD7ayuT9Kpd1gytk90=Z3jGVdKk79B8DDMWCQ@mail.gmail.com>
Subject: Re: [PATCH v4 28/33] target/riscv: Fix size of trigger data
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x633.google.com
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

On Tue, Oct 28, 2025 at 4:27=E2=80=AFAM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> mcontext is at most 14 bits in size with the H extension, fix to 16
> bits. trigger_cur indexes into tdata*[RV_MAX_TRIGGERS] which holds 2
> elements, fix to 8 bits.
>
> This patch also adds a migration entry for mcontext which is used in
> tandem with other debug data that is already migrated.
>
> Note, the cpu/debug VMSTATE version is bumped, breaking migration from
> older versions.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h     | 10 +++++-----
>  target/riscv/machine.c | 13 +++++++------
>  2 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index ee4444f22d..153480846a 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -467,11 +467,11 @@ struct CPUArchState {
>      target_ulong mseccfg;
>
>      /* trigger module */
> -    target_ulong trigger_cur;
> -    target_ulong tdata1[RV_MAX_TRIGGERS];
> -    target_ulong tdata2[RV_MAX_TRIGGERS];
> -    target_ulong tdata3[RV_MAX_TRIGGERS];
> -    target_ulong mcontext;
> +    uint16_t mcontext;
> +    uint8_t trigger_cur;
> +    uint64_t tdata1[RV_MAX_TRIGGERS];
> +    uint64_t tdata2[RV_MAX_TRIGGERS];
> +    uint64_t tdata3[RV_MAX_TRIGGERS];
>      struct CPUBreakpoint *cpu_breakpoint[RV_MAX_TRIGGERS];
>      struct CPUWatchpoint *cpu_watchpoint[RV_MAX_TRIGGERS];
>      QEMUTimer *itrigger_timer[RV_MAX_TRIGGERS];
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 376075b2bd..c6ebb58882 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -239,15 +239,16 @@ static int debug_post_load(void *opaque, int versio=
n_id)
>
>  static const VMStateDescription vmstate_debug =3D {
>      .name =3D "cpu/debug",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .needed =3D debug_needed,
>      .post_load =3D debug_post_load,
>      .fields =3D (const VMStateField[]) {
> -        VMSTATE_UINTTL(env.trigger_cur, RISCVCPU),
> -        VMSTATE_UINTTL_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> -        VMSTATE_UINTTL_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT16(env.mcontext, RISCVCPU),
> +        VMSTATE_UINT8(env.trigger_cur, RISCVCPU),
> +        VMSTATE_UINT64_ARRAY(env.tdata1, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT64_ARRAY(env.tdata2, RISCVCPU, RV_MAX_TRIGGERS),
> +        VMSTATE_UINT64_ARRAY(env.tdata3, RISCVCPU, RV_MAX_TRIGGERS),
>          VMSTATE_END_OF_LIST()
>      }
>  };
> --
> 2.51.0
>
>

