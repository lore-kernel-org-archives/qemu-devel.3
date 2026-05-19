Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A43BECD4F3C
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:00:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBdQ-0007Lq-7G; Tue, 19 May 2026 00:00:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBdC-0007Da-Ck
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:00:39 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBd8-0008Nk-Be
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:00:32 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bd8f6ef4ba6so252497766b.3
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:00:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163228; cv=none;
 d=google.com; s=arc-20240605;
 b=bQaxAUprp6aDJIXPrAB6NDlVtJYDT4+2dKmm8hqPsOLT2jfwzPVo6aTg2khCWZgw7w
 Ogy4M7atqSLP0CgIPJX38LKTMCnN2Tx25Nk8MPHQLOdMnxQXxJMwDt8VIu1bTjXTXnev
 GLQypTxSt13lC9EhCLd663pl2nHYMVrhs2eUiqecwcfGHp1ni9zXXR6GXt910cSSKjRK
 id6d5ukad958jGfS0YPXEriHU1Pp+o/lnpUZ4WEZPXrz1Yubh4oIKWUJMKh+9eQ1IcpW
 olcNj69IHGpajt6E135SMps5CF3X6ginur1SvCQ1aug1t24HBTTs7WsFSapDkUS+jCup
 33xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=R+RSarYK2lVqL/6hfrmMfZvIt+9jd7bxJR5kh8b8wiU=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=Yz/HWCG7xUUlDhIQKffZq31Adqo6alIW0vW26ZsqpoLbuCup4SckAfhoe3Hqqa6NoI
 EaHSp1WBBbYQbuuZXHAaUEmbVDdijtfzqzTzfeRT/1zoyXLYZ+ZEMOGlOoY6Bhj2+sbl
 Z/818AMnlzXcvAXYS3uScfzw+RQmYXQtaENhUYyh5emcLQfMUl4JVpN17JgqQ/xzXFXX
 GjPEfqaAv8v3Alab3tBP6kNnL6Q67vfyDCcrl9eQiX96tQU0BzmHDItLnuq49MG5aIta
 yvKjSCNTgRGGcJEIueIkGmF8DC10b61tRS5B77SxG9+1/fs+xQ4wd65KEUmCMWmChSrt
 hbYg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163228; x=1779768028; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+RSarYK2lVqL/6hfrmMfZvIt+9jd7bxJR5kh8b8wiU=;
 b=CJnbJpYrFdEjKFXbiqRs1byROL30MQP5HHQoBkz1aUujFYkhVr2NYTAdFYz7Wpxd2Y
 LyhxZab9QfI4ktKt55cyzSb/I8S/P2Mi2jNyAJm/oqUXHqWPvz0p7uc0ZoArPYv+0t3g
 ZRbY5Ak3/6Mz9zhHHaOA/9Q1RLgeJ4qDb6zfPqxYyPuIhsdxs3LHf4uiAkhw3MNSMwxj
 cNycEIt0sXm8gH7yqy0lg3c1R8pj+95K4JqFbwJms18QuPbmeF7nHauIv1LFelE59RUM
 qbims2UPqHS7Jhc1LD2LC2Dt3jMms6CG58X4e9+dujga67tKiwyyEMQpU6Jc/TsSOp4e
 2GKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163228; x=1779768028;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R+RSarYK2lVqL/6hfrmMfZvIt+9jd7bxJR5kh8b8wiU=;
 b=NfmhGKpYoBOyhXuEfIJLQUi32umP9Aps8S7E2YrmXgjaiYdFaxqnDXh4IOMjYtinYe
 nVW0m0LAl9IbIXzwnhmuUBC+FuueYSPQWCprDde+X9bdcQWMc/Tzy+byVyJXHL9naW5B
 vcMGqcyKTYmVlUxYAOHY4ZuBEmRiYODdIX4QvRr5Ty2h2ezXgW2Nl+Bj3JmmTbRv/lES
 +E6W941UYiWZxKdjYcFZwhxZIlCERef1svlDo8dJq1c4A82hiEZcjmWIs1M44H3ZGIgn
 sjsUGmLhCqzBUp1KzREFpOEaZwEyXhaJtt/593gcklSjIphzqsIMkdtGF4Y0FADOL0IP
 zdeg==
X-Gm-Message-State: AOJu0YwXlQ3Bam6aKhz7DT+El6uTVFcKLozXl0Hb8eNPgAEt07hwtgDB
 hq2S8J6TPwdgin63I9oDsHWyM/XEkdvhzlzavezp5mOivJohQKgQoikyGsXfwN4Tighev71cc9t
 Lm5QTTM7NtA34MRtouZyGmzDS4GKg6yw=
X-Gm-Gg: Acq92OFvNdT00utEK9kQ+XxrsLljTGrvlIW1NmHPFiuB/SIbQw9xnrOMohJ9XyeYxdn
 7eA+2t5DYdNWIDUlSCVFk5i6HYi6rJ88+Oyhv6sX0Q2Rgo+T0hIEtYtG1fLisJZ07Chi1YOFmks
 89TR5uWw4hVB0C8I2u2mXus2JQQMbMoLM0NhkXQC/NZWNDohZ59zhyFKHrADk641b7xHGqHliY8
 G45r3gxN9ikEd5+F4qt+wAT7VcXqeBpSR0DBtZ/1dzf+kOpgJ5vqG/DKwpKlUze67LPNq2jKefi
 SW8gg0fSP82S/PdOk2qUqqJp43CdBVKB9kWdiJJpN8PDOvj1
X-Received: by 2002:a17:907:3890:b0:bd3:1f67:1e10 with SMTP id
 a640c23a62f3a-bd51793130dmr1048916966b.40.1779163228176; Mon, 18 May 2026
 21:00:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-8-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-8-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:00:01 +1000
X-Gm-Features: AVHnY4KOTlLInWd1KLgkEHkEwiE_P58BjRYULWrWMfyGnMxYpfrJUdI5koJQG2E
Message-ID: <CAKmqyKP5YAFr_npgJh0_018ixERYEdGMVjP8uLotc-D9F-3tBQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/14] target/riscv: remove riscv_cpu_named_features[]
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, May 12, 2026 at 1:32=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> This array has no uses left.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 26 --------------------------
>  target/riscv/cpu.h         |  1 -
>  target/riscv/tcg/tcg-cpu.c |  4 ++--
>  3 files changed, 2 insertions(+), 29 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 047f81b163..4940596ffa 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -1407,32 +1407,6 @@ const RISCVCPUMultiExtConfig riscv_cpu_experimenta=
l_exts[] =3D {
>      { },
>  };
>
> -/*
> - * 'Named features' is the name we give to extensions that we
> - * don't want to expose to users. They are either immutable
> - * (always enabled/disable) or they'll vary depending on
> - * the resulting CPU state.
> - *
> - * Some of them are always enabled depending on priv version
> - * of the CPU and are declared directly in isa_edata_arr[].
> - * The ones listed here have special checks during finalize()
> - * time and require their own flags like regular extensions.
> - * See riscv_cpu_update_named_features() for more info.
> - */
> -const RISCVCPUMultiExtConfig riscv_cpu_named_features[] =3D {
> -    MULTI_EXT_CFG_BOOL("zic64b", ext_zic64b, true),
> -    MULTI_EXT_CFG_BOOL("ssstateen", ext_ssstateen, true),
> -    MULTI_EXT_CFG_BOOL("sha", ext_sha, true),
> -
> -    /*
> -     * 'ziccrse' has its own flag because the KVM driver
> -     * wants to enable/disable it on its own accord.
> -     */
> -    MULTI_EXT_CFG_BOOL("ziccrse", ext_ziccrse, true),
> -
> -    { },
> -};
> -
>  static void cpu_set_prop_err(RISCVCPU *cpu, const char *propname,
>                               Error **errp)
>  {
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 669735c5cd..46bc29d307 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -992,7 +992,6 @@ typedef struct RISCVCPUMultiExtConfig {
>  extern const RISCVCPUMultiExtConfig riscv_cpu_extensions[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_vendor_exts[];
>  extern const RISCVCPUMultiExtConfig riscv_cpu_experimental_exts[];
> -extern const RISCVCPUMultiExtConfig riscv_cpu_named_features[];
>
>  typedef struct isa_ext_data {
>      const char *name;
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index c3e354b0ae..8dea22bae5 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -454,7 +454,7 @@ static void riscv_cpu_disable_priv_spec_isa_exts(RISC=
VCPU *cpu)
>      }
>  }
>
> -static void riscv_cpu_update_named_features(RISCVCPU *cpu)
> +static void riscv_cpu_update_cfg(RISCVCPU *cpu)
>  {
>      if (cpu->env.priv_ver >=3D PRIV_VERSION_1_11_0) {
>          cpu->cfg.has_priv_1_11 =3D true;
> @@ -1181,7 +1181,7 @@ void riscv_tcg_cpu_finalize_features(RISCVCPU *cpu,=
 Error **errp)
>          return;
>      }
>
> -    riscv_cpu_update_named_features(cpu);
> +    riscv_cpu_update_cfg(cpu);
>      riscv_cpu_validate_profiles(cpu);
>
>      if (cpu->cfg.ext_smepmp && !cpu->cfg.pmp) {
> --
> 2.43.0
>
>

