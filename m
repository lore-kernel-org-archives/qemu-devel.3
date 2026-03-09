Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39C4DEA8554
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 04:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzSV3-0005wy-IP; Mon, 09 Mar 2026 00:45:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSV0-0005vr-S4
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:45:46 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vzSUz-0004je-DM
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 00:45:46 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-6611e4aefdcso7533172a12.3
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 21:45:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773031544; cv=none;
 d=google.com; s=arc-20240605;
 b=MdwYrrx7lqneBed/mIykeMY04tzJVwqgib2hHHCpABGbiq2Ajn76CFcX08OjCKe4Ma
 eDodM9iCIENsS3biEC2qJS5NZnVaoQCes6pRRWZDDSxsYD12G1nY0hO6h61+OfAQm2eY
 sjst/bvFX4M6GJ5Q4YNjmESz56s1oA1ZQkiVJ3sZRD3Ot8elMlZmq7emaAi3lSd2tlOI
 9uit9WlUN8pcqAsYUCN0t2aoM6rBmXVhDjVM0FKZJ4aEQ12Jyj820ht8349XaWsd4ISt
 unpJYcyieyXwzD7IuV2H9g2abj0KJorDV7WtZYL3qrycR/ZiHysHBjJNXRQOACZ6HViM
 gaew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9TKd4ZKjftm5dZ5gApKHuD2er8YTV/idH/pp5bhSwyI=;
 fh=qxpwc2DaGgPKaO/QSF0Ck4QddgiR8TmLs2bG4fnvclA=;
 b=E8y1DIepLq/I9MtaZgG5A7JFFSsMt12J61SdZ6r1UaALlnfJ680y/lRg2DrPBseSZh
 FqqJECadXRD/JAWuxNTAtiW2jg/l6+05opLtM64Q2WcudfwJ7flMmxbr8zJQQn8c1CZA
 h8920HLDWhyhjcY5usjnQKsJUwqku8sEszisFcSPmI9uvUBtmprRjU55CkAFFRrZ3GJ2
 NXz3bDgTRfXbnExDRZ9SiESKwnzONJ/JSfkvAJzzK0i1RsvZ8I74H6+DSax6C2aX9Pp8
 H1WKkfmBr7j4fyYLRurLmMeZpiI82eMmtV799C5z5cpPIHXOOBWuH/H5XIJn+/iFlCcS
 m2zQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773031544; x=1773636344; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9TKd4ZKjftm5dZ5gApKHuD2er8YTV/idH/pp5bhSwyI=;
 b=HXPAvXLjdNXJ34fyJhGBITry8kavfcTFqaV0icI3AffTDAFJ5Z/WoYkKj45lXYYtv6
 n7uL6J/6yNQeCI6XaYH27J2Nvndq0fkpwsF1/dlfcO30BuRzHPw7WicD5Kysib2UycRb
 v5XTOFIhBWp5tN0VNo6E/FkFviG8bA87kAgZh2+LPhaCG9NTRRgTA4PpfHbjPvZmE+fu
 0yhZEpGWDZEqjNm83UPsOSR3Eh/E8xY2PVjsedGbVruDwB8EABlZJAdD7UtbiAD9b1rg
 wpM8uh3qxOstinNts5SN7VGDpBChN9KQEQjxUJvb57vhM8OCGIvhUK89YX8uAbPFYfOo
 fwQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773031544; x=1773636344;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9TKd4ZKjftm5dZ5gApKHuD2er8YTV/idH/pp5bhSwyI=;
 b=B7vAOA1up+J9bjO8d9oK8Mq3As/zs256jjPLmmEjffuaoNFnMZiN47wt+ZczABspMw
 Ehmi3cWqZR0rZZpyux1/VjDMAZ+aLPNkYo7Mdbhcj4BSz3I+ewUodh0oeY9QUx14V13L
 /ospL72+p1L6Yo/NgvZJb+Yzv8T0RIPsfUR4F7XaZm0aqPyawb4fx1w4mdS5X6q5ovx2
 20JQ+9LYYRzsoQAoLAZfE27nk47mSdhqNxTS82lt8WaNxnMwJW5xecCEsY8pfoKxydy9
 /RwlR/hrs1psU5Zbr0LNOIl7RcE1ULdPZFXLNIDquRo+B/sXqymDhiERCUUedd4uR8b4
 DmLg==
X-Gm-Message-State: AOJu0YwlX9zh50kYBSob2G4p0egWFwbrrx6g4XrXIto7s0SX/ozR/5UV
 IylSmnLv/6bNZKeG0KUzqDW5Kuh5tbixmNf+hE0/LIcnD1COqULQN2CzJzvbUWB4Elkj4hp1b3x
 xcK4UsWNHCwnS0fI8nE4ZfKwJjtcqbOA=
X-Gm-Gg: ATEYQzx7v88/VivOZY5r0pP46+lD2e9oQ9gmn9sBvzTIPcGEkCdKDWtDiRkhg+dN3lz
 CdsyS5N3CTYah5rHJAH84LMTnijvsX3EICzpDFrxO4k1kSlm4fhZZT3JD2YXJlk1EMhnsX3hUZt
 Vq54h1pdMxQTZKb4ExVqp3v8g6pGrCTYAVTu4x4Id3kxQ9kdHbSchxIm/a3Mat+q5HqhE961IUt
 XIoP+zj27SSj1mJjUyEp9tUodIFoaUXdCU584Ce155xjGwemujNiZsOcvKyTz413spxl7B8KYMB
 c+U1zsPy+A+gEocQ39h8OVy9we49s0XZRLlwxA==
X-Received: by 2002:a05:6402:1ec8:b0:65f:9c21:e69b with SMTP id
 4fb4d7f45d1cf-6619d4c4254mr5380556a12.10.1773031543657; Sun, 08 Mar 2026
 21:45:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260306071105.3328365-1-max.chou@sifive.com>
 <20260306071105.3328365-3-max.chou@sifive.com>
In-Reply-To: <20260306071105.3328365-3-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 9 Mar 2026 14:45:16 +1000
X-Gm-Features: AaiRm50CW7AB51VIqdwiyEVfilJouyYCLS8xgLIB7YBmjEwK3Sa0n0fWoEl2ti4
Message-ID: <CAKmqyKO+irF5qSvyF_7ScFBAxSAJ-m1t-+FRkRDpaPc7exAAMQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/9] target/riscv: Add the Zvfbfa extension implied rule
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Fri, Mar 6, 2026 at 5:13=E2=80=AFPM Max Chou <max.chou@sifive.com> wrote=
:
>
> According to the Zvfbfa isa spec:
> The Zvfbfa extension requires the Zve32f and Zfbfmin extensions.
>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Signed-off-by: Max Chou <max.chou@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 2ddc26c837..376517755e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2619,6 +2619,15 @@ static RISCVCPUImpliedExtsRule SSCTR_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule ZVFBFA_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvfbfa),
> +    .implied_multi_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zfbfmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
> @@ -2632,8 +2641,8 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_ru=
les[] =3D {
>      &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
>      &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
>      &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> -    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> -    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED, &ZVE64X_IMPLIED,
> +    &ZVFBFA_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
>      &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
>      &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
>      &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED, &SSCFG_IMPLIED,
> --
> 2.52.0
>
>

