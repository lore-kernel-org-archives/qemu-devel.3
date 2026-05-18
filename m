Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AE11CD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:37:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOlyT-0004ry-QU; Sun, 17 May 2026 20:36:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlyN-0004rY-Hz
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:36:44 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOlyK-00054o-Ai
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:36:42 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-67b32c695efso6146492a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:36:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779064597; cv=none;
 d=google.com; s=arc-20240605;
 b=RqWF6mpmXn0ZPp3YxC2cw5IlvuKz6iGCPQ+Wa+XzA+2k7atEvDCj9gL88DqFAb3erz
 v04DKtG5uh3BeTcJrMoWmjmFJLBAj2ZbS8E8SJhpPQCSuDbRe/UmkV5EyX/8BhRPRJ+0
 TL1wcR9fyEwT8hdoJUOhh3oMLOoH9sUhZZjOiB99TtEXK/8G18V+9nGt9oVuyipwgnYA
 1TftsN5W6hsAcK94iFi1yfnOsGwA5kFLNVZ4HKnFuva/Tdx6Fwtwj3fxSHN9ehOyrZ1w
 Pou/YI5rrQyHTvODD66p0dBU6QXTZgRzGNEyJDIEjyda+ieMzFmm/iPzFzXYVKR92ab5
 JpFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=+wy6pi09AVOVK1+auuwUwydD/zmdThi7Uyp9zl4TeWg=;
 fh=CKTLN//x600JF4tGkjJ6e7rHb/dyrQecKs+4icOfyIA=;
 b=WTH6Cxgp2ii6fiP+Y4ocJKdupaY5sNNCR8zxiSY6U+KPlH2GWlkYm96ZyY4+uvR7ck
 RHnhLshbMa3NaczT8HuIGkGMtX5tE+z7koQJyDOKV9XYINNiwOroc9FUJH5Lb7ZsktIs
 XQPGAwfAgLQCna1CeFy3IFaWYkjdBbsOGUXeFrCez1O0jKOnqyL7Z/KzsNwelYCzDGaO
 dkaOaihM65sIZdUjdUfT/k2nT5G/Y2Ni8sg+beUjQsCIzJwqeisDka38FyP/sNBs9Awj
 Zs+4wrXk/Pr2KCbI2Hkc1IRj7+e8FBzHR1UCxeqz55lRkY8vHKpfQRsgVphXxtS6zvxS
 5L4g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779064597; x=1779669397; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+wy6pi09AVOVK1+auuwUwydD/zmdThi7Uyp9zl4TeWg=;
 b=MpcRFoayhGAEhDwaI3A3pZWiKA53WMXiXZcZnN73iIv1qDvzG1NBQIA5kD4ShN+JRV
 b/YzTDcoVDaKLQUPuGFxT087ahSiZvklPSkDi89H82t9+mrNODBCcpEo9Hzryk4WVE7p
 jK6WRMSC4iqegnfPxxSqIle2DzI68eBTgksrvFmgNaJb+/ITL/saASa0+RoE2Etr2ugs
 jjxhlDxUVp1jhEz7i7Ufh7FvG2RiTlmFxNKfsfqZuws/95IsZe8cWHBTngsTUrLEhRFF
 33pR1LoFkd5bEWuptYg26l3qw/YxkTvji/dMEVfVmM5Exvj9sSmFdQ3v/mWBgWPMNZY6
 2fjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064597; x=1779669397;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+wy6pi09AVOVK1+auuwUwydD/zmdThi7Uyp9zl4TeWg=;
 b=EXPu+cS5qfAc7mYB9L16prkWLNlbM0Ff8mn93CyUlAt85A5eZkBJHCyt+pejjPMiTs
 PBiFEAjWq9Bzo+L3q1ogKrgMWCpz0n7KT0kym3gjCHkNhTmDKtoGSGQGLMLV+k+7IZwY
 75sL3EGDiDgsE6WnXEhKtp3BvFAr+4mYLtnITqbDi7kDJKdgf61n1EnVaOFSO3mHFj8l
 SLcsnzzFiJcqgcYK5kYosNrpXs20H8wLFbmZOnXuLdm/J3eXhYLONjNOsLWGSpqffpPY
 uCK5HMR9cn4R56v/yj++izv9+q9RFgFhAn0CYjXTVDdSPfUQkFaJ87J8tMvcB+CMYFbD
 rbGQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Mj2YnC2Ye2V9RWnOY+9ALP9LODiaWKUc9zi0fG0hz/ScN6wfxBuu5nDxpYfnTGKk7VryxwOXd/hQR@nongnu.org
X-Gm-Message-State: AOJu0YxyidNcgXFE0wQT0IHXB+wQlmKdE+jZ+xfvwxoTQBA+ALeE743g
 QlGh+leIsWPlznx4qxL5XyTnOEhDD4DfMJAU3Gmag53pBjHiRfelbdJVGVBVKqLFpmciODV4WUt
 pAeomAMY6iXqM2g2ZVVvgb1P/FbBA4Ko=
X-Gm-Gg: Acq92OHBI1TZBfpD5fKi9WV86z/KX8mTKSb/WRTv4cPO/xKBbcNEtYJnbHc/CsBCjA/
 /wtMKI7eDR/JKXeiNc/8B6KOmSUMFwRGVxHyIZNlUF2xklLJ44uXVnBried5h1+VV0sDNnblabX
 JXFk/vENIDIP2qeC7sxQkQElDdRMpcZWo6tIy6AqYBc7CkVMWNxcp3YxkJqRUNjuIHfe9ZmHYhn
 pjIDfjrUqJ8ahNaB+aZvX9uANcYskMMii2Y38XLbGqwI+NwptU/aD8Jrr2Lds16oRtvnXZSN6KC
 rWLmfs5n+2RHugbdPQb9uBngaHun3uiPReFzHCLkVcLLf59b
X-Received: by 2002:a17:907:9446:b0:bd1:77c4:acc9 with SMTP id
 a640c23a62f3a-bd4f345ff31mr812230266b.16.1779064597003; Sun, 17 May 2026
 17:36:37 -0700 (PDT)
MIME-Version: 1.0
References: <7dc52ffd-97e3-4c41-8cde-e79dd4bd2485@oss.qualcomm.com>
 <20260511102627.3120140-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511102627.3120140-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:36:10 +1000
X-Gm-Features: AVHnY4LFx-OLi2O2yVMTXTZ551Dpn0Mgq9pxwdyuZGKGNxOQB48hwHVch0o2EQM
Message-ID: <CAKmqyKOd9R+J14Kx=_nYS-XiWc4L0UGy0HfauPK4mFpRTiSX3A@mail.gmail.com>
Subject: Re: [PATCH v2] target/riscv/pmp: Fix integer overflow in TOR and NA4
 address computation
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Chao Liu <chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52a.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, May 11, 2026 at 8:27=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrote=
:
>
> According to the RISC-V Privileged Manual: "The Sv32 page-based
> virtual-memory scheme described in sv32 supports 34-bit physical
> addresses for RV32, so the PMP scheme must support addresses wider than
> XLEN for RV32."
>
> However, the current QEMU implementation uses `target_ulong` (which
> resolves to `uint32_t` on RV32) for PMP address variables.  When
> shifting these addresses left (e.g., `this_addr << 2`), an integer
> overflow occurs, truncating the high bits of the 34-bit physical
> address.
>
> Fix this issue by changing the types of PMP address variables
> (`this_addr` and `prev_addr`) to `hwaddr`.
>
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa=
-manual/pr-2472/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
> Changes in v2:
> - Changed the types of `this_addr` and `prev_addr` to `hwaddr` instead
>   of using inline casting, by Daniel's suggestion.
>
>  target/riscv/pmp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 5391caa59c7d..a71091a316e0 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -227,8 +227,8 @@ static void pmp_decode_napot(hwaddr a, hwaddr *sa, hw=
addr *ea)
>  void pmp_update_rule_addr(CPURISCVState *env, uint32_t pmp_index)
>  {
>      uint8_t this_cfg =3D env->pmp_state.pmp[pmp_index].cfg_reg;
> -    target_ulong this_addr =3D env->pmp_state.pmp[pmp_index].addr_reg;
> -    target_ulong prev_addr =3D 0u;
> +    hwaddr this_addr =3D env->pmp_state.pmp[pmp_index].addr_reg;
> +    hwaddr prev_addr =3D 0u;
>      hwaddr sa =3D 0u;
>      hwaddr ea =3D 0u;
>      int g =3D pmp_get_granularity_g(env);
> --
> 2.51.2
>
>

