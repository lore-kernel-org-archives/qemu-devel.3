Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F058BFF8864
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHYqa-0006JD-4E; Mon, 27 Apr 2026 23:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYqX-0006In-Mq
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:10:50 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wHYqV-0004ZW-B4
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 23:10:49 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b9c3a9fe80fso1609176966b.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 20:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777345846; cv=none;
 d=google.com; s=arc-20240605;
 b=W114K2xGjokifZsy2BgnjC0tNPvvbJXdfOQkRrwCjciG6OuGAYAH8MLC946KSt0JHS
 GOY7k0r1+tHA8s7Bc9fW4GOv5qaEtU0N1p/sGpghcM1pQjb1Vc/PkItgG19Jj2hmDpVO
 3rIbr4gMZ6pKOsmpb9JigDcGAsMlwNe8UAfIOSad8SDLZW+NLUftYhu5FUUc+cFx0oO9
 kxEUTbbUXJ0x7XJoMsigxZzykj3HwOB9xtp165fZTBQ/ubNptm9vGl8Z/H3pcZbWcW6Z
 Hz2+66rT0QYr+30pMBmxrs4L31lDt2nWenioagl0k/zsnML6fFNJ+3u3BXJrje8OPGgW
 vx+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=LsuwDNSYdIg7ntmclbtIVgFLAoG2BfiA9avfTjKq0ZU=;
 fh=vMm9Mfk4A9zcrR91EXfXDIBkabMVGk/AmujgvqrG1P0=;
 b=YaNkKCr/Q6in4P6dBhqHb6fqgYwIN1PPKVUa/0Rb6xtNtrP011uv7KG+iKIVNq8t2P
 Voi2eVkK1VfnQMjvYuW+8bNxn79zVHERCURKjptcY8Gm9eTwOfBHPsPuO/HC8/H9gB8w
 QXu0RKZeMCWS3+O0bgtWr3HXVwuQy5chjcrsl4OUHcGAO/KdVAcY6fn0BXhN6uw+8gsC
 aWohdVyvwCTUm2VpzxffiwxqgobMmYz6zaYdBVTKXLJFrDoRrMKlIhpe4t7+tYwGps31
 2btLOm4zWX8hQXEd1OsFQ8hpgSh4RVHaK+T01D8ajC/h58mPXqGXjWMKD93CvPsQpRgO
 esgQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777345846; x=1777950646; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LsuwDNSYdIg7ntmclbtIVgFLAoG2BfiA9avfTjKq0ZU=;
 b=FHnZWmrrhGAyfC3EkwBOAZ76NI43amoHYp4CmfKTFnK4U6FUmTjoS+tmtwLHq4gwWz
 kfIZ2qwIYv6TWPTndNVd6uVGRiUJidh2txqTpbPeVJUSDu0e76/ZZ2QmB0wqkgPDt7yj
 Bd/t/lAGVO6AuPlz6m63W+u+2NJOTC2jvdq+imWNJL1R63hzjfgQI411F6EkB50Mn6ID
 HiMod7jMpKA29K+81qpc/K6BEAgyvqMmMtmhAtvLDQcu8RIy+oN9OEG/b39t3KP2kPOZ
 G3OxPK6tGSPt5+7Ac3RKFXfWGLg62PxYC4Gf9GkhGsYdsX17Nv83kslHebnhkl9hHMyu
 Gb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777345846; x=1777950646;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LsuwDNSYdIg7ntmclbtIVgFLAoG2BfiA9avfTjKq0ZU=;
 b=gsjGct/kn8BWtjPP+RXzX6jyQsWxe9gPKhx2pmKEyNfWYx/rxg2a3hqukb0BCE/w9I
 ZQgMjx7d0r0HOV0sGslD9Z32B3Mq4iRxFObUNweSJwiECH6bzK5roF68TYSsom6mPgGk
 rSv4ZF9O1GHCsdse9iDonYRBi9i3473dnR/y4Tlf3/1sRhq/wj/nC58nctPIYgs7BIUm
 8A/3G/xaq+IVB9Kzg+C8ZhKoseBg2a24dcgeQS62wH1VB8HlKiyb4FVW0vzkCe6hqi0/
 ZT4VuVEojIf0vmnhiYpRSob+LCbxCK1bZLvCC3prabRZYqXbkrpsojisb9xSpGRJl5QR
 lZDg==
X-Gm-Message-State: AOJu0YyWDM838lBHvTpgkE773B3ZIs9ieZZ4qWYGd2PpigtMboiWSr9H
 ueg9kH1c0a19Y+kJ8Xl2EfJDNi1mOUw1XNlBok6XI+eohCSEpbfv0fNf0frqIUZF5qZKL6D314f
 2hB/sRhGxPmJNTWRprL8kYx96Cr2zg2Y=
X-Gm-Gg: AeBDiet1Br2kVOOs4y+vKvHAjmBJQHlx8Q7LVaG1u/1gGCoh3GvB1FAuicL7nSep2Nw
 vF37rJx9aCYz4naa0qUCURQoaOUNqARaraP8knK6UaHifW6znePKUmrT1tWMizjkt9Y/pfll0Et
 53Vj+ObIVI1mFtG5/HNbGmMaDURHVdxQH1rrOhxuob+wjMgA2wwg45XTKNMU9wJCTXIdWbuZLVv
 OgZ85UjCE6Deejf6wNZxEemdyJuaxlbYOAwLMca3dBB2bQe8x13GosY8jwBux7cApoQGJ27lArT
 iZV//+3HPN2GdzZhIT6foyE1DV8akYgNROP9nWaJncvL7CdU
X-Received: by 2002:a17:907:c084:b0:ba7:500c:ea16 with SMTP id
 a640c23a62f3a-bb8017e5d8fmr70299866b.13.1777345845568; Mon, 27 Apr 2026
 20:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260421093715.2995067-1-frank.chang@sifive.com>
 <20260421093715.2995067-7-frank.chang@sifive.com>
In-Reply-To: <20260421093715.2995067-7-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 28 Apr 2026 13:10:18 +1000
X-Gm-Features: AVHnY4IXG_vcIkqirSZ0D-2u_EVqHstoI-OZxIPvRxahiKCG_wRcAPmcdsc810I
Message-ID: <CAKmqyKMrezf=9FEXLj_ik=V6Db3m4C4_VLF3=A71mo=XG7pfmw@mail.gmail.com>
Subject: Re: [PATCH v4 6/6] target/riscv: Fix pointer masking translation mode
 check bug
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
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

On Tue, Apr 21, 2026 at 7:38=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> When running with virtualization in VS/VU mode, or when executing the
> virtual-machine load/store instructions (HLV.* and HSV.*), the type of
> address that determines which pointer masking rules apply should be
> checked against vsatp rather than satp.
>
> As a result, sign extension also applies to the virtual-machine
> load/store instructions.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h         |  2 +-
>  target/riscv/cpu_helper.c  | 19 +++++++++++++++----
>  target/riscv/internals.h   |  4 +---
>  target/riscv/tcg/tcg-cpu.c |  4 ++--
>  4 files changed, 19 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 138183e017c..81c41e34296 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -888,7 +888,7 @@ static inline uint32_t vext_get_vlmax(uint32_t vlenb,=
 uint32_t vsew,
>
>  bool riscv_cpu_is_32bit(RISCVCPU *cpu);
>
> -bool riscv_cpu_virt_mem_enabled(CPURISCVState *env);
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst);
>  RISCVPmPmm riscv_pm_get_pmm(CPURISCVState *env);
>  RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *env);
>  uint32_t riscv_pm_get_pmlen(RISCVPmPmm pmm);
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index ef1ff7cb0bd..39c3486ae0f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -240,16 +240,27 @@ RISCVPmPmm riscv_pm_get_vm_ldst_pmm(CPURISCVState *=
env)
>  #endif
>  }
>
> -bool riscv_cpu_virt_mem_enabled(CPURISCVState *env)
> +bool riscv_cpu_virt_mem_enabled(CPURISCVState *env, bool is_vm_ldst)
>  {
>  #ifndef CONFIG_USER_ONLY
>      int satp_mode =3D 0;
> -    int priv_mode =3D cpu_address_mode(env);
> +    uint64_t satp;
> +    int priv_mode;
> +    bool virt =3D false;
> +
> +    if (!is_vm_ldst) {
> +        riscv_cpu_eff_priv(env, &priv_mode, &virt);
> +    } else {
> +        priv_mode =3D get_field(env->hstatus, HSTATUS_SPVP);
> +        virt =3D true;
> +    }
> +
> +    satp =3D virt ? env->vsatp : env->satp;
>
>      if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -        satp_mode =3D get_field(env->satp, SATP32_MODE);
> +        satp_mode =3D get_field(satp, SATP32_MODE);
>      } else {
> -        satp_mode =3D get_field(env->satp, SATP64_MODE);
> +        satp_mode =3D get_field(satp, SATP64_MODE);
>      }
>
>      return ((satp_mode !=3D VM_1_10_MBARE) && (priv_mode !=3D PRV_M));
> diff --git a/target/riscv/internals.h b/target/riscv/internals.h
> index 82d24f433dc..683bb3bce3e 100644
> --- a/target/riscv/internals.h
> +++ b/target/riscv/internals.h
> @@ -213,9 +213,7 @@ static inline target_ulong adjust_addr_body(CPURISCVS=
tate *env,
>          return addr;
>      }
>
> -    if (!is_virt_addr) {
> -        signext =3D riscv_cpu_virt_mem_enabled(env);
> -    }
> +    signext =3D riscv_cpu_virt_mem_enabled(env, is_virt_addr);
>      pmlen =3D riscv_pm_get_pmlen(pmm);
>      addr =3D addr << pmlen;
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index f3f78088956..02c98cc2dbb 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -105,7 +105,7 @@ static TCGTBCPUState riscv_get_tb_cpu_state(CPUState =
*cs)
>      RISCVExtStatus fs, vs;
>      uint32_t flags =3D 0;
>      uint64_t ext_flags =3D 0;
> -    bool pm_signext =3D riscv_cpu_virt_mem_enabled(env);
> +    bool pm_signext =3D riscv_cpu_virt_mem_enabled(env, false);
>
>      if (cpu->cfg.ext_zve32x) {
>          /*
> @@ -260,7 +260,7 @@ static vaddr riscv_pointer_wrap(CPUState *cs, int mmu=
_idx,
>          return result;
>      }
>
> -    pm_signext =3D riscv_cpu_virt_mem_enabled(env);
> +    pm_signext =3D riscv_cpu_virt_mem_enabled(env, false);
>      if (pm_signext) {
>          return sextract64(result, 0, 64 - pm_len);
>      }
> --
> 2.43.0
>
>

