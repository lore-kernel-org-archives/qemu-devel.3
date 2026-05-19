Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E0BCCD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 03:54:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBX1-0004iz-CU; Mon, 18 May 2026 23:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBWy-0004iI-H3
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:54:08 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBWv-00065r-9T
 for qemu-devel@nongnu.org; Mon, 18 May 2026 23:54:07 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-67c9616b4feso5329903a12.1
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 20:54:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779162844; cv=none;
 d=google.com; s=arc-20240605;
 b=M6eiMsH92BXNjcjmSF1wOTDjQheFiPxmfY3aWyfWRGA0C79cZKJm8eznwd1WEMk6jv
 KuI288vvnvGQWOoVl3btj7KZ9QUzqmEjPinYim+sBfT/0fWgrqQjsOXLJ/9eDPDgSWN0
 iyX18obiTSUMQT+Jtbi9hjws0m6IWvF3fc0U70BLktd1dOvh1MxpLw/e46tjro3KQCe2
 WJNnDPhjeau+WWD2u+N+3lqmesjfltpmw29oHXA6Uat/gGuqZL40smHFuU3GyiIO1gJh
 O12Cw0Vq+qUv+Pz+NFYdR5jakokcBiEGuNizWUv/DuPMZFtt5TfMTXhQl5dLEhb6xG2o
 fkHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=E6lS5e16FvVpL2+uhei2oOX0DZd2677DKje6A0MZ7Og=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=OsG4CqHtDp5VYLOrHyiiEqR1DSYKrcBVAIF7aJLjHQG4ayIlaszSchIVGZ87JHLYM5
 at+hQAVGMoJG3Pgx1RduhEfPJZm5EuXQGMUHBAjYST9im07HuIuib0nibucycfDeDPkI
 uVZ2jXoyZFvPfh095QmWQbSX1lAxgWEUifFG5xRWC3tY6MzRbBNZMGyTVom1elEw0XOF
 axyYvsnP0goi6xzE9xQKmQxrDY/994Aynm5tZMrw5KRNphwtkuOKXjbKabS6aphzWY05
 ibOIrJDef/VKllmMDd0kt/ThlCAs5z0t/AR8Fn/m2lVw8/PgHspjm9Q8pmclD8ZEkWPP
 vqng==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779162844; x=1779767644; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E6lS5e16FvVpL2+uhei2oOX0DZd2677DKje6A0MZ7Og=;
 b=edpuK7Pc/pIovdgA3okl553jJwVFYipBDKbAzaMaV1K8hzrWyLZvP3PTeQ3Cmng+hf
 LMJ70TyFG2dD4HolBc4toeWXbCTxZSDvajERmKtJoyJ0cWu6e2rYqAV4TY0KqTzpyKHL
 c7O/EFSfpFiQ3Ej27dinV72kwvdWz9RLTPICLosoI7B+zfa6/RU3/3rL1xzuq8f1Vd6t
 LiLPCbLcCBQMbxwAW1oal76t8ju44qwLV26RKsv9s8OyRCvQknQWtroXu0in1Yn5rvUI
 lRJYl/dOqen1yO7nCkwCH3wkreCkFDUAKG4SPk30gOgkYz17m2DTPWBcweAxpG6SYwjF
 Ro6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779162844; x=1779767644;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E6lS5e16FvVpL2+uhei2oOX0DZd2677DKje6A0MZ7Og=;
 b=Ier+M2zD98UN+iMGHvC9jGDiE944xcSplbxxwOful7tpS3sivXBQZt0S4JoMgMA525
 m/Emhf8W3XG8ANmuyGGD+0oP0lv27pWTZifNdjCkffE8BU/VSMAxo5prYsorqMjBrWYa
 oEbPctM+3tzxLYlVqPxfS5z6oowTAk/wIHYtFwk8vJQS5QGD+jU7hJ5M2heDitLrTAFb
 CFret+bv2pQUp9oDH/8igvjOpnXv8w90RQy82htLFpuuSlhv4cB8FbOCic5u3/4kkSGC
 DqfMn5nQDZS8CxAN4HZa+EKMHvCx3LDiMRoBgWcXjWxetBhxID2PTMwGKm89bwTO81dT
 j8Qg==
X-Gm-Message-State: AOJu0YwGutU6vTt0uH91+hACKWWazjYgv/79VdrXIuQ0MVCjpnxkpnh7
 rvKZbcgj+Ccc3I1cwIlygQNysEXstyFHOxbfUibOkQpBn7eNDN0niR2wVrbjPkMCWd5jaTGuanQ
 Ft7hLObdfPvrtDAM9yntMXN5mDvKAUuc=
X-Gm-Gg: Acq92OFF1gp7ud5BpRJFqB+jBiEkBA2pMCtAu/ONekdW1h72LtaRe4ZBXXN/pStrJ1f
 SeE2zkOoCzovY1Z+zdg8NP9t0nTSYCO1X03XOqzGjF0caCYitKoh30dI5wS3UdLKbi9OKeCJD6S
 CPKxFWYcwjiy2OlGtMu2yT/MDw3O4/Fn7D2q3eJ/m+8d7FWQQJkWPSIoKbSSGUfcmA/a/F5eFYJ
 wXcWyQAIIKcx4FTcPmbRmK1Gs/wQsjFb+Nj2+3JiJBZ8vZ4K49mSAomI/YilV+RvSSC99eUxIj2
 TwYkfD4Lk9c7+VwbLsEjZSeOGlHwDvS84Vkhy6o7hFWPb8F2
X-Received: by 2002:a17:907:97ce:b0:bd5:5e7:ae6d with SMTP id
 a640c23a62f3a-bd5177afb10mr974000566b.3.1779162843533; Mon, 18 May 2026
 20:54:03 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-4-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-4-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 13:53:37 +1000
X-Gm-Features: AVHnY4JV2nHpGIkkNzGx0gagewYd81oYIjvTMvSI1jKMXrNS2_P3KIfXDYqlA9w
Message-ID: <CAKmqyKOY5LiXM2S=9N5T_VF3WqXMEoR+mVA455YfbbhHGzHiMw@mail.gmail.com>
Subject: Re: [PATCH v2 03/14] target/riscv: make riscv-qmp-cmds use
 isa_data_arr[]
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x529.google.com
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

On Tue, May 12, 2026 at 1:31=E2=80=AFPM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We want to reduce the usage of the riscv_cpu_* arrays in
> target/riscv/cpu.c, centering everything in isa_edata_arr[] instead, to
> reduce data duplication and make our lives a bit easier when adding new
> extensions.
>
> To do that we'll have to make isa_edata_arr[] do what the other arrays
> are currently doing, not breaking existing semantics in the process.
> The riscv_cpu_* arrays have a few exclusive uses:
>
> - set default extensions for rv32 and rv64;
> - create user CPU properties;
> - misc uses around tcg-cpu.c and kvm-cpu.c.
>
> We'll slowly make isa_edata_arr[] supersede these arrays.  Start by
> adding a new 'prop_name' field in RISCVIsaExtData.  This field is needed
> because not all extensions have properties and not all properties match
> the riscv,isa string name.
>
> Create two additional macros and reclassify existing isa_edata_arr[]
> entries as follows:
>
> - ISA_EXT_DATA_ENTRY creates an entry where prop_name =3D=3D riscv,isa.
>   Most of our regular extensions fall into this category;
> - ISA_EXPERIMENTAL_EXT_DATA_ENTRY: same as above but add a "x-" to the
>   prop name, i.e. prop_name =3D=3D "x-" + riscv,isa;
> - ISA_INTERNAL_EXT_DATA_ENTRY: used to declared internal extensions.  By
>   'internal' we mean users/management can't set them on or off.
>
> With these new macros we can start our simplification by changing
> riscv-qmp-cmds to use isa_edata_arr[].  We'll just scroll through it
> once and gather what we need.
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c            | 60 +++++++++++++++++++++++------------
>  target/riscv/cpu.h            |  1 +
>  target/riscv/riscv-qmp-cmds.c | 30 ++++--------------
>  3 files changed, 47 insertions(+), 44 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ee8f6e5296..42555cb28f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -97,8 +97,24 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *dest, =
const RISCVCPUConfig *src)
>  #include "cpu_cfg_fields.h.inc"
>  }
>
> +/* Use this for regular user facing extensions */
>  #define ISA_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
> -    {#_name, _min_ver, CPU_CFG_OFFSET(_prop)}
> +    {#_name, #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
> +
> +/*
> + * Same as above but for experimental extensions. We'll add a
> + * "x-" right after "_name" when creating the user property.
> + */
> +#define ISA_EXPERIMENTAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
> +    {#_name, "x-" #_name, _min_ver, CPU_CFG_OFFSET(_prop)}
> +
> +/*
> + * Internal extensions are extensions we will declare in the
> + * riscv,isa DT but they don't have an user property, i.e.
> + * users/management can't enable/disable them.
> + */
> +#define ISA_INTERNAL_EXT_DATA_ENTRY(_name, _min_ver, _prop) \
> +    {#_name, NULL, _min_ver, CPU_CFG_OFFSET(_prop)}
>
>  /*
>   * Here are the ordering rules of extension naming defined by RISC-V
> @@ -121,13 +137,13 @@ static void riscv_cpu_cfg_merge(RISCVCPUConfig *des=
t, const RISCVCPUConfig *src)
>   * instead.
>   */
>  const RISCVIsaExtData isa_edata_arr[] =3D {
> -    ISA_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(zic64b, PRIV_VERSION_1_12_0, ext_zic64b)=
,
>      ISA_EXT_DATA_ENTRY(zicbom, PRIV_VERSION_1_12_0, ext_zicbom),
>      ISA_EXT_DATA_ENTRY(zicbop, PRIV_VERSION_1_12_0, ext_zicbop),
>      ISA_EXT_DATA_ENTRY(zicboz, PRIV_VERSION_1_12_0, ext_zicboz),
> -    ISA_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_1_11),
> -    ISA_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_11),
> -    ISA_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(ziccamoa, PRIV_VERSION_1_11_0, has_priv_=
1_11),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(ziccif, PRIV_VERSION_1_11_0, has_priv_1_=
11),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(zicclsm, PRIV_VERSION_1_11_0, has_priv_1=
_11),
>      ISA_EXT_DATA_ENTRY(ziccrse, PRIV_VERSION_1_11_0, ext_ziccrse),
>      ISA_EXT_DATA_ENTRY(zicfilp, PRIV_VERSION_1_12_0, ext_zicfilp),
>      ISA_EXT_DATA_ENTRY(zicfiss, PRIV_VERSION_1_13_0, ext_zicfiss),
> @@ -141,7 +157,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zilsd, PRIV_VERSION_1_12_0, ext_zilsd),
>      ISA_EXT_DATA_ENTRY(zimop, PRIV_VERSION_1_13_0, ext_zimop),
>      ISA_EXT_DATA_ENTRY(zmmul, PRIV_VERSION_1_12_0, ext_zmmul),
> -    ISA_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(za64rs, PRIV_VERSION_1_12_0, has_priv_1_=
12),
>      ISA_EXT_DATA_ENTRY(zaamo, PRIV_VERSION_1_12_0, ext_zaamo),
>      ISA_EXT_DATA_ENTRY(zabha, PRIV_VERSION_1_13_0, ext_zabha),
>      ISA_EXT_DATA_ENTRY(zacas, PRIV_VERSION_1_12_0, ext_zacas),
> @@ -211,13 +227,14 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(zhinx, PRIV_VERSION_1_12_0, ext_zhinx),
>      ISA_EXT_DATA_ENTRY(zhinxmin, PRIV_VERSION_1_12_0, ext_zhinxmin),
>      ISA_EXT_DATA_ENTRY(sdtrig, PRIV_VERSION_1_12_0, debug),
> -    ISA_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> -    ISA_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
> -    ISA_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> -    ISA_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> -    ISA_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_1_12),
> -    ISA_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> -    ISA_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(shcounterenw, PRIV_VERSION_1_12_0,
> +                                has_priv_1_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(sha, PRIV_VERSION_1_12_0, ext_sha),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(shgatpa, PRIV_VERSION_1_12_0, has_priv_1=
_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(shtvala, PRIV_VERSION_1_12_0, has_priv_1=
_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(shvsatpa, PRIV_VERSION_1_12_0, has_priv_=
1_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvala, PRIV_VERSION_1_12_0, has_priv=
_1_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(shvstvecd, PRIV_VERSION_1_12_0, has_priv=
_1_12),
>      ISA_EXT_DATA_ENTRY(smaia, PRIV_VERSION_1_12_0, ext_smaia),
>      ISA_EXT_DATA_ENTRY(smcdeleg, PRIV_VERSION_1_13_0, ext_smcdeleg),
>      ISA_EXT_DATA_ENTRY(smcntrpmf, PRIV_VERSION_1_12_0, ext_smcntrpmf),
> @@ -232,20 +249,21 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(smstateen, PRIV_VERSION_1_12_0, ext_smstateen),
>      ISA_EXT_DATA_ENTRY(ssaia, PRIV_VERSION_1_12_0, ext_ssaia),
>      ISA_EXT_DATA_ENTRY(ssccfg, PRIV_VERSION_1_13_0, ext_ssccfg),
> -    ISA_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1_11),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(ssccptr, PRIV_VERSION_1_11_0, has_priv_1=
_11),
>      ISA_EXT_DATA_ENTRY(sscofpmf, PRIV_VERSION_1_12_0, ext_sscofpmf),
> -    ISA_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0, has_priv_1_12)=
,
> +    ISA_INTERNAL_EXT_DATA_ENTRY(sscounterenw, PRIV_VERSION_1_12_0,
> +                                has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sscsrind, PRIV_VERSION_1_12_0, ext_sscsrind),
>      ISA_EXT_DATA_ENTRY(ssctr, PRIV_VERSION_1_12_0, ext_ssctr),
>      ISA_EXT_DATA_ENTRY(ssdbltrp, PRIV_VERSION_1_13_0, ext_ssdbltrp),
>      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>      ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
> -    ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
> -    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssst=
ateen),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_=
1_12),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
> -    ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
> -    ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> -    ISA_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1=
_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1=
_12),
> +    ISA_INTERNAL_EXT_DATA_ENTRY(ssu64xl, PRIV_VERSION_1_12_0, has_priv_1=
_12),
>      ISA_EXT_DATA_ENTRY(supm, PRIV_VERSION_1_13_0, ext_supm),
>      ISA_EXT_DATA_ENTRY(svade, PRIV_VERSION_1_11_0, ext_svade),
>      ISA_EXT_DATA_ENTRY(svadu, PRIV_VERSION_1_12_0, ext_svadu),
> @@ -253,7 +271,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(svnapot, PRIV_VERSION_1_12_0, ext_svnapot),
>      ISA_EXT_DATA_ENTRY(svpbmt, PRIV_VERSION_1_12_0, ext_svpbmt),
>      ISA_EXT_DATA_ENTRY(svrsw60t59b, PRIV_VERSION_1_13_0, ext_svrsw60t59b=
),
> -    ISA_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svukte),
> +    ISA_EXPERIMENTAL_EXT_DATA_ENTRY(svukte, PRIV_VERSION_1_13_0, ext_svu=
kte),
>      ISA_EXT_DATA_ENTRY(svvptc, PRIV_VERSION_1_13_0, ext_svvptc),
>      ISA_EXT_DATA_ENTRY(xlrbr, PRIV_VERSION_1_13_0, ext_xlrbr),
>      ISA_EXT_DATA_ENTRY(xmipscbop, PRIV_VERSION_1_12_0, ext_xmipscbop),
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 224c81900d..669735c5cd 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -996,6 +996,7 @@ extern const RISCVCPUMultiExtConfig riscv_cpu_named_f=
eatures[];
>
>  typedef struct isa_ext_data {
>      const char *name;
> +    const char *prop_name;
>      int min_version;
>      int ext_enable_offset;
>  } RISCVIsaExtData;
> diff --git a/target/riscv/riscv-qmp-cmds.c b/target/riscv/riscv-qmp-cmds.=
c
> index 8a1856c50e..93e6b7fa68 100644
> --- a/target/riscv/riscv-qmp-cmds.c
> +++ b/target/riscv/riscv-qmp-cmds.c
> @@ -90,27 +90,14 @@ static void riscv_obj_add_qdict_prop(Object *obj, QDi=
ct *qdict_out,
>      }
>  }
>
> -static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out,
> -                                         const RISCVCPUMultiExtConfig *a=
rr)
> +static void riscv_obj_add_multiext_props(Object *obj, QDict *qdict_out)
>  {
> -    for (int i =3D 0; arr[i].name !=3D NULL; i++) {
> -        riscv_obj_add_qdict_prop(obj, qdict_out, arr[i].name);
> -    }
> -}
> +    const RISCVIsaExtData *edata;
>
> -static void riscv_obj_add_named_feats_qdict(Object *obj, QDict *qdict_ou=
t)
> -{
> -    const RISCVCPUMultiExtConfig *named_cfg;
> -    RISCVCPU *cpu =3D RISCV_CPU(obj);
> -    QObject *value;
> -    bool flag_val;
> -
> -    for (int i =3D 0; riscv_cpu_named_features[i].name !=3D NULL; i++) {
> -        named_cfg =3D &riscv_cpu_named_features[i];
> -        flag_val =3D isa_ext_is_enabled(cpu, named_cfg->offset);
> -        value =3D QOBJECT(qbool_from_bool(flag_val));
> -
> -        qdict_put_obj(qdict_out, named_cfg->name, value);
> +    for (edata =3D isa_edata_arr; edata && edata->name; edata++) {
> +        if (edata->prop_name) {
> +            riscv_obj_add_qdict_prop(obj, qdict_out, edata->prop_name);
> +        }
>      }
>  }
>
> @@ -220,10 +207,7 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion=
(CpuModelExpansionType type,
>
>      qdict_out =3D qdict_new();
>
> -    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_extensions);
> -    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_experimental_=
exts);
> -    riscv_obj_add_multiext_props(obj, qdict_out, riscv_cpu_vendor_exts);
> -    riscv_obj_add_named_feats_qdict(obj, qdict_out);
> +    riscv_obj_add_multiext_props(obj, qdict_out);
>      riscv_obj_add_profiles_qdict(obj, qdict_out);
>
>      /* Add our CPU boolean options too */
> --
> 2.43.0
>
>

