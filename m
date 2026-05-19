Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8710CD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 04:06:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPBiB-0001es-Ik; Tue, 19 May 2026 00:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBiA-0001cf-71
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:05:42 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wPBi7-0003An-PV
 for qemu-devel@nongnu.org; Tue, 19 May 2026 00:05:41 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd56d108454so642547066b.2
 for <qemu-devel@nongnu.org>; Mon, 18 May 2026 21:05:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779163538; cv=none;
 d=google.com; s=arc-20240605;
 b=D7XgrixvOgdFZP+qjF1fGqwwtW1dJkYYHOfx9XMIU/shIJmuyZXp8cTbEAjmvWS5Ed
 rHNwqHLae5F4I7jcMDYXMZH3yeYQ7B/+oTCkghPFaDYTZDve7voIaAyapKzdBcSdhhIV
 9nDpeobLt9Xg/iylDSe+T2tPgsuURzsxYmYCd4rntViYVGSXDzlIGqazbMEbNL73SBHc
 GoQv+MUZOa5QF2XB0JPZi/Idhl76ywe74JC2HKa0XR1xvbVPfWTC0C4Fry49KHijPc//
 y14DEbeCYQDSSJL+rgOZEyadIGuIdGzX6lGcoEjNy73VDOx0nDOUN+8hXUFgL4mJr18C
 I01A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=jlYFiNMyCfBiKuK10pGUOGpJXbrHTxSJQ9JlEEVqrS8=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=QeNDg9YOrooLqow8eseOVhfXSvrhv0rcyZAQovR79vuU6FYRfMn43JjQlct2Bdeymi
 ttDzF6J0scTr9bVgLsVcPs0zD0cRzSGxfvVPGJuleySXR8DxLmXUZ2e1G+TNJT07/57X
 fj/RZXymOyiCLOoB9g4zeCEDNc1HHEF8Llc94wObHWVkBkYSmxerwBSPDmu2ir2seFQP
 aTcrrDjp2JXRSHOrPgRQgJvIjtSgtMiwrdBIxmSnFYIi+Gc1nDGrixhA/vr6yUMSh4um
 B2smvHDDz7TJ2KQl0FRdlOdz0KgyHgbv072kDAOPLVvC9y7QH/oXLsiETkr3Th2dtlvd
 evLA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779163538; x=1779768338; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jlYFiNMyCfBiKuK10pGUOGpJXbrHTxSJQ9JlEEVqrS8=;
 b=VtTtpqe3RXrW+EwprNE2zNQ9NB9dmmoHj3+GlGlL0FdJL4QTI7/mn4XGzSaO+qhwei
 SltdlXxcQbnjlYTFOzEzfncdqPXqx9EmwZuYvruJZMWAq8r1db+P3g2QXJmE8VQNPg6T
 OjvsDMYg44QKZECxrGJp/DFQHy7YtKW1o/gFkh9FQvx2xzLn2T47aVq+bnM+KKa/hD4r
 3PcU3o8DuUlCncBUNDwTzgQKdJHiepdfoKxONuTc3cpQ5ytJfuwumIMRGOkIC/OisqN6
 pzEv/OdZXZDlfRcKVRnisEiKcc+7u1VvGKldGlkNFIBwVQKXej0IY55b18oBKRfrYSkq
 MpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779163538; x=1779768338;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=jlYFiNMyCfBiKuK10pGUOGpJXbrHTxSJQ9JlEEVqrS8=;
 b=hEaqzm8RZSIqZhy56oUeQBs4wZibiczns9BU4OnNa5SjW/iCLykdVM+Zht77cb9p+J
 YUIptmyUAX136Ce5aDRzR3O+QIo0JHeuw13P1kFw1o3RbQFHkkn8TOf3Oe/dwKaeJ9+j
 thAg0Ws1lK9nOTvd6N1UewSMXuL5+BcDlHj/C+IpWTT+0o5EaYwVwKzBcd+qDsczLLe7
 1X+u1AFxTjfnX7FikUmhtfIIKoMGLoMt51JWUCrcsg+9jV15UPnZG3hI6ksD6lgO+D5c
 4XS+90OerS9jUmeeejauMBKtKYq/xG1xH4uPjTI9o69PqAhGx6J8fpUmILUyOq0mp4t6
 ngjw==
X-Gm-Message-State: AOJu0YyCXFLuVmO/cgZhufS+4euN5dn2baGLFIu+h9qQ1veg/irynpOk
 iEEbeeUoK+ROPuUKXguqw+reB3hb1q7siLpW9oP8BAi7YtqoRbyu9ae6vY+pFN0t2119Pk1nl11
 5fQtJk0KtdzjxA6TOjzGx96KllMZtwXA=
X-Gm-Gg: Acq92OH0o0ZvZdCy5guYE2NOdLJNiylSUqOrBm7DrYxkUblX9VJChUb0hE6jSY/rLfl
 E7EfqSL6aHeOIX8g7SLHmlDibMHkKhNJQtDDKeAKSSCVhRprjJlq0vW+zXBZJzkFSgQdMmusjau
 rjKAAZDoTQJQJJXV5b0V7fox62PqmbblxH7vq77OCHhPEmkosvHYyDrWHAnhwfAUl7ZiC4rMKI7
 MyF/VAxvbXbO4E9+tjpRCStL8BOcJh5h5LeltVnoePDMft2rzalrt1P1dT+oJJ7HKCKkoGLzExQ
 8INb1jtdzcJwIZP1T4VLB0G4zEa1+ve+1TSvTg==
X-Received: by 2002:a17:907:9348:b0:bd8:bc8e:a321 with SMTP id
 a640c23a62f3a-bd8bc9de69cmr317646666b.8.1779163537469; Mon, 18 May 2026
 21:05:37 -0700 (PDT)
MIME-Version: 1.0
References: <20260512032926.1978818-1-daniel.barboza@oss.qualcomm.com>
 <20260512032926.1978818-13-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260512032926.1978818-13-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 19 May 2026 14:05:11 +1000
X-Gm-Features: AVHnY4I98VQW8z2SOJ__fRkX5ssJJANZc0sGsA4sCahyaJFBQxhB6xnDWUaHWrg
Message-ID: <CAKmqyKPiq6_H_4STzbExqN9ZDSJsUA2Kgv6CWg9V8ZPYEgUNNA@mail.gmail.com>
Subject: Re: [PATCH v2 12/14] target/riscv: do not set defaults in cpu prop
 callback
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x62d.google.com
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
> Do not rely on riscv_cpu_* arrays to set rv32/rv64 CPU defaults - add
> them to the CPU definition like we do with all other CPUs (aside from
> 'max').
>
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c         | 40 ++++++++++++++++++++++++++++++++++++++
>  target/riscv/tcg/tcg-cpu.c | 14 -------------
>  2 files changed, 40 insertions(+), 14 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4940596ffa..6dd05597e8 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -3072,6 +3072,26 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE32, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode =3D VM_1_10_SV32,
>          .misa_mxl_max =3D MXL_RV32,
> +
> +        /*  Default extensions as of QEMU 11.1.  */
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.ext_zicbop =3D true,
> +        .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zicntr =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zihintntl =3D true,
> +        .cfg.ext_zihintpause =3D true,
> +        .cfg.ext_zihpm =3D true,
> +        .cfg.ext_zawrs =3D true,
> +        .cfg.ext_zfa =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_sstc =3D true,
> +        .cfg.ext_svadu =3D true,
> +        .cfg.ext_svvptc =3D true,
>      ),
>
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_IBEX, TYPE_RISCV_VENDOR_CPU,
> @@ -3124,6 +3144,26 @@ static const TypeInfo riscv_cpu_type_infos[] =3D {
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_BASE64, TYPE_RISCV_DYNAMIC_CPU,
>          .cfg.max_satp_mode =3D VM_1_10_SV57,
>          .misa_mxl_max =3D MXL_RV64,
> +
> +        /*  Default extensions as of QEMU 11.1.  */
> +        .cfg.ext_zicbom =3D true,
> +        .cfg.ext_zicbop =3D true,
> +        .cfg.ext_zicboz =3D true,
> +        .cfg.ext_zicntr =3D true,
> +        .cfg.ext_zicsr =3D true,
> +        .cfg.ext_zifencei =3D true,
> +        .cfg.ext_zihintntl =3D true,
> +        .cfg.ext_zihintpause =3D true,
> +        .cfg.ext_zihpm =3D true,
> +        .cfg.ext_zawrs =3D true,
> +        .cfg.ext_zfa =3D true,
> +        .cfg.ext_zba =3D true,
> +        .cfg.ext_zbb =3D true,
> +        .cfg.ext_zbc =3D true,
> +        .cfg.ext_zbs =3D true,
> +        .cfg.ext_sstc =3D true,
> +        .cfg.ext_svadu =3D true,
> +        .cfg.ext_svvptc =3D true,
>      ),
>
>      DEFINE_RISCV_CPU(TYPE_RISCV_CPU_SIFIVE_E51, TYPE_RISCV_CPU_SIFIVE_E,
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 50d9218a75..7575884d7e 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -1553,24 +1553,10 @@ static void cpu_get_multi_ext_cfg(Object *obj, Vi=
sitor *v, const char *name,
>  static void cpu_add_multi_ext_prop(Object *cpu_obj,
>                                     const RISCVCPUMultiExtConfig *multi_c=
fg)
>  {
> -    bool generic_cpu =3D riscv_cpu_is_generic(cpu_obj);
> -
>      object_property_add(cpu_obj, multi_cfg->name, "bool",
>                          cpu_get_multi_ext_cfg,
>                          cpu_set_multi_ext_cfg,
>                          NULL, (void *)&multi_cfg->offset);
> -
> -    if (!generic_cpu) {
> -        return;
> -    }
> -
> -    /*
> -     * Set def val directly instead of using
> -     * object_property_set_bool() to save the set()
> -     * callback hash for user inputs.
> -     */
> -    isa_ext_update_enabled(RISCV_CPU(cpu_obj), multi_cfg->offset,
> -                           multi_cfg->enabled);
>  }
>
>  static void riscv_cpu_add_multiext_prop_array(Object *obj,
> --
> 2.43.0
>
>

