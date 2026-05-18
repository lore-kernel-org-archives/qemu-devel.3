Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA6BCD4F3D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:40:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOm1C-0005UQ-F4; Sun, 17 May 2026 20:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOm17-0005TW-10
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:39:33 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOm15-0005uJ-B7
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:39:32 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-bd4d7f4fa02so303180766b.3
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:39:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779064770; cv=none;
 d=google.com; s=arc-20240605;
 b=Zm7qYoYTnva6ZUPUfh6KNwpyT7UHNYhi7xv/aZrm3xuLlU10l4iqIyBJDHrSzNK5pV
 HoCaiZmaHGDCLlC6DbOMJEHlAk94JOMCRVlSDgAgNdd790ry3JBMnqqrrW58hrllc1kV
 AblJedanBoMm/JY9oZQhHNaPj785flW+J3+z+/wA88ZVu4+RDFLH9NbQSoNRBmneC0VJ
 Za4A0JRFtd5h2G87CLOS57/Fu3KojRTTjfk3kW0vXPxI7+iBbzDP30DnL/CSnfOTUZqU
 xG8JjfqnL+qPm6HI9vqWHt+v08n7v9TnX3+lTPLPKBDS1ZPQGRmOsO2O9Y3ehutUySBL
 T8HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=l8oVnw5klaqTLU3jh1F2RXTQQRLgDrgmMXxM13Y03tE=;
 fh=DgBJD3BUXBGya2QE7xTXpANeSahaSqNWhBeW4p9Uucg=;
 b=F8Bq974qkElZATiP+cKWwyKprPEn+dR05alepwJ8jrICyqf9kwzMC0TrCdPJ2HBuxy
 GPqMfVVaAlEU7Nxbd/djJHiGRSM68Gy05wPNVNgmYde5WsTwqsdpzDiEuTWO464OvpoR
 CnMKoZpsU9Nrw8HUy31pE5q4Dbo8yMFeGYhCpe6O4v0vSam1g0Rb1C7BMeFz21xrT0cz
 j/svBa8iRBWrhQo+Bc47Lazx57m/SPLvtBBf919s3py2f8WJJiMZakCI6xKma1eG1zrM
 E1icbGsoYB8aP+Um6CB30Ho0ySgaSWUCCs3/kCrOBZtJarPtT1lT8Ogiz/2bcttkeEPj
 lIIg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779064770; x=1779669570; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l8oVnw5klaqTLU3jh1F2RXTQQRLgDrgmMXxM13Y03tE=;
 b=jtJpHM6iR8grUtBDctBhkMUe3HgZLzYnGIL6//xGSlXh7jQVe8S+UZWVM/HXEOLriY
 ZojS9FpFoV9dC0VekaOiry/gwz3dMpquvNK02JCLZtb/tTHWpBornrGKWABQGsycQvkv
 4aLRL8WDnTfGw+DTIGo5y2WlGTWKB7ZMqglew/hC5WUxjem9wrZxFRArUcgfX7fLJ6Wa
 ezPH1lJYcksZq4D9SkYUPC1rTQPe+74bTQ5C4pgIaljsAqdIO6TTyUIC+0Mx9WtLaiRO
 upL24jIL9N3bFlZZc5aE9mjOSe5BP1nbQ8adqLmBFVP332Y1BWl878a+0vbvKlk9vNA/
 zdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064770; x=1779669570;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=l8oVnw5klaqTLU3jh1F2RXTQQRLgDrgmMXxM13Y03tE=;
 b=SLtG0nOYxUIUSjfYW/YDRpz8RXBwYL4nVNbLH8Myk4CIOowUp8uO7kpDylXEeFCGwf
 azGo/jMpgxDRYbLEdPb7PRrxfaSb/5Yj1S8U4DcrSkgUXzHB3vhp6mBBofikGXQHzo2d
 1qb+hD/F7Hx+A90Tl5/V1WccznY2gNyNOkShkRISkv/QhRqLrnqW0hv3nNLW8cdqSS1e
 SGksoK6Y448L4VLHxJQ0hjBnm00L2rgwaIRZr7C32bVGFRhVL0EZLUbHvC9ichKdXkUs
 sz9Ov/enJhljY4Es/pojEWm6XyDMej2bO0WpE6YsulZDKdRbyA0z0a4TZmRzTD3XyNWc
 PdMA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UmzOKr7XqLTGj+OT2pOXQs0PrSMlIZf1FG3zLipYRZk5ocPWTt91kIoToJwsdPzJ4n/Q8AXK2IDDX@nongnu.org
X-Gm-Message-State: AOJu0YzRWdiz2gXAahHwItgan1cJyIbNlKumlltcIEsDpYFw2oXaD0Gh
 EpdsPSEANmm/AsfStZbALgcM5DTOjWVzhnXyjWQD+GL2Qom1cGfhD8+VrAO+R3OUAeQ8hRVBvq+
 hHLKnWAAGtRdHgwbERjtjTrkch3G/p8w=
X-Gm-Gg: Acq92OH5tpAmb/MNcpT4iwawqCHINSBBK8Wa7yAxaOAVc3bKGVcT0pNQ1BZLpbzKidm
 M+SBxCwIYiRh5Otxqs+0i4Q8oTSvsx2lgJVoOwMTCgor2bP0vRb1iAtLcGtP2crwNYzPDHdp+12
 FYSTmC1Sh1zN40Md3EsvRin95dVgr2BMM0qkkVgsScCXDOG1KnTKRgaZMJCgw9gmjLzTNMkcqek
 Wy4dJZ1dweINbpgN5hiase9sJd6UW/8mOSiwxay2QxLGcpqUks/JtMNSIkgkkHKSAkUPugb3JzR
 EgAp9qORUz13aQWBQZa3zVQ6cCioV9vRpNKsfQ==
X-Received: by 2002:a17:907:97d2:b0:bd4:9a24:9615 with SMTP id
 a640c23a62f3a-bd5178463fdmr625921466b.18.1779064769455; Sun, 17 May 2026
 17:39:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511124828.3210477-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:39:02 +1000
X-Gm-Features: AVHnY4I0amkEDncUhb_zYLplk0O64211fafPEgeBn6wZe9u6VAg4Ew5NFq_j_Ys
Message-ID: <CAKmqyKNyewcfYOiiMMk0jWBKWe_dCapby+ikOhd+eDaFdH=7CQ@mail.gmail.com>
Subject: Re: [PATCH v1] target/riscv: Add mseccfg to VMStateDescription
To: Zishun Yi <vulab@iscas.ac.cn>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
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

On Mon, May 11, 2026 at 10:50=E2=80=AFPM Zishun Yi <vulab@iscas.ac.cn> wrot=
e:
>
> Currently, the Machine Security Configuration Register (mseccfg) was
> missing from the live migration state. This omission causes the register
> to be reset to zero on the destination host after migration.
>
> Fixed by adding vmstate_mseccfg subsection
>
> This vulnerability was discovered and reported by SpecHunter, an
> AI-driven architecture specification analysis tool.
>
> Link: https://github.com/yizishun/rv-isa-sec/blob/a22e4459cd026ae970791df=
bd9cfe5d110fbd46b/output/riscv-isa-manual/pr-1879/qemu.txt#L121
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/machine.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 09c032a87914..6776e7bf5a11 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -423,6 +423,25 @@ static const VMStateDescription vmstate_sstc =3D {
>      }
>  };
>
> +static bool mseccfg_needed(void *opaque)
> +{
> +    RISCVCPU *cpu =3D opaque;
> +
> +    return cpu->cfg.ext_smepmp || cpu->cfg.ext_zkr
> +        || cpu->cfg.ext_smmpm || cpu->cfg.ext_zicfilp;
> +}
> +
> +static const VMStateDescription vmstate_mseccfg =3D {
> +    .name =3D "cpu/mseccfg",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .needed =3D mseccfg_needed,
> +    .fields =3D (const VMStateField[]) {
> +        VMSTATE_UINTTL(env.mseccfg, RISCVCPU),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
>  const VMStateDescription vmstate_riscv_cpu =3D {
>      .name =3D "cpu",
>      .version_id =3D 11,
> @@ -499,6 +518,7 @@ const VMStateDescription vmstate_riscv_cpu =3D {
>          &vmstate_ssp,
>          &vmstate_ctr,
>          &vmstate_sstc,
> +        &vmstate_mseccfg,
>          NULL
>      }
>  };
> --
> 2.51.2
>
>

