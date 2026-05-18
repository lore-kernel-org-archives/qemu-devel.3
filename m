Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D79ACD4F48
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2026 00:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wOm4X-0006Gj-4A; Sun, 17 May 2026 20:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOm4V-0006GU-QN
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:43:03 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wOm4U-0007k4-2N
 for qemu-devel@nongnu.org; Sun, 17 May 2026 20:43:03 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-bce57c132b2so568030866b.0
 for <qemu-devel@nongnu.org>; Sun, 17 May 2026 17:43:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779064980; cv=none;
 d=google.com; s=arc-20240605;
 b=VUVD0Je6C5g92qpL2HmCtlZuhwHQya86bx+CNZ6OSqiA19SPHkngGaOSKmn12hP+YA
 EAF2cVs6oYrmCu3tr3SWKgX9W5TWteInPEwZBykBy/62xSIpqzMdYOQcbssVKB8PWrZd
 m7zhiZxmL3yu+abwMXDjITIYRUea1b7ir2sTyk4xCndxcWFbmDFqkGbNY3M/WKvz+TOZ
 urTARQNu/t+73BKC+S9Eh+jRNQOnEOrQbYfPuPSUm49Ejogg4av1k7x+YMr1Z7ukXpk/
 uhrneXBliWN+EC/QGpNF/e93ZTXT9PdBsCzZHH+sVsXVXBWUTWrG4EGr7kHjELUACW+V
 RzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KsHcGy1j/+cAPNoSOWShQ7HAibUhzjyCmTGywdziGFY=;
 fh=yGqSDP1hAJyNIs50BYM30IQ93ZCANMzcU11m43ZKzYE=;
 b=BYfcwR3wHupUPt+diPtQcHo/qt8Di2eSl6iHKqoutCV+mLBnn9z3b0UWTEieGNpHo1
 z5L+By9f1RguaDuu/PpxHb9ZVBfxSiieH4gGMDkpKCBoi2m7EaMTucbGUG2eI51/n88j
 7I7ZDx7GFrWEXbPlkMj1jv8MZKR7XVuDm5IIApHVJ5Fx3QCnzDKie1MEmvsWanhtRHBe
 5qNCIKVC1ws7JOB9kxe4CTc9IG9Q7vLw6YsAzNFuusIE/+8p+daeMBtHfUMXZ5jtNK09
 JRCIl3lVN2eEVFJktPYllyAgzOQ4iLiEBdVJY7dJLFz64S+xJQa697xRw8UoS5TBqTRF
 Ie4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779064980; x=1779669780; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KsHcGy1j/+cAPNoSOWShQ7HAibUhzjyCmTGywdziGFY=;
 b=pTx1WBDAzzmCclOyLuVwWXOCzin8RmPw0LYM1tb58TNOFwqu4PIyX3wc0yWTu/wZP3
 y7xOFVAZjnq/faTN0ycN9ROsUGbd3lkP47qZdlKjRMkrh91wzMzEdEHWbIFDhENzd1N+
 aO+ToozpuCzP3MwWXqWuMEPyeFh8Ur6MH9ETmHCrDWgEEhwF3EovmMroed2pTMnoOaPy
 UNP0hSjyFjlzKz6pyFO/BZ1SmL4wtKPmnbfdawMkd+bj8IywH7r6rO1EVn3dAX9MSbxt
 GuyozlkBAC/aYvyX9wDibfQhSl1QCVsFV3Bs2YTWfq+o31oBgMn1+TrTfwk2eIW1bLTv
 FucQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779064980; x=1779669780;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KsHcGy1j/+cAPNoSOWShQ7HAibUhzjyCmTGywdziGFY=;
 b=MPu8JgXNOYywhr00SimndlHUr0uxm9HnZTHeIRPBDitFx62razH7xRr83lmRHakxA5
 YB09BVUNVNrtWIgpDfHh+RC+jOBCGH2riMoWxPxItdvqnIoldDPUAzx/oaThlI0y9XZb
 WmIXkPrnKUoSIL8QjbhQmnxm06l5wYctEL/HbqSSliJ4hR0V5sJ9J97Fc6e9g/ikbv29
 eNKOlAZrxDSAxPIvTj1HhMwV9YnpF1GVO1dlVkwAcO47PlKSMtMWdOVKv8xEthAJP0If
 1jLqek3pV80gs9KBKRZeplzrDmEZFkqZ63qBtBdUKLWOCknLz0S7WGYu3+qcHiik2W9A
 4yfA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9xwMqmbK9jN27DNLdYpU+dIdiD3oWqWt8iOeUuxOa+ybX22IVVTo0q3Hlfz7HVjvJsCRejxAZXI681@nongnu.org
X-Gm-Message-State: AOJu0Yz7E5BsBeQH7KrNO3wjMo8DwJb1ZsPV8UcDp2slMG9z7qf0DjiA
 TMRX8jnWX+/Mr0iEnym/T/tna0P2+y+Ur67vO9/M+W6xIYf40WBK7YIs7d/bonl1Abui4rrQjwL
 wxn0OVO621swQ6l4TNeuvM8mC/qQcku8=
X-Gm-Gg: Acq92OHF/hV5jw39NEQz0QRNrhwhmzgT1gLTWyfLQ3DjwuLoJI19p4BtYkajUmDkHzF
 WchZmbhSSf2JQANFLp8NW3nNhMgtGfDxiCZjwx0llVWoM2JWURrlQGZ/TUI6SyJX108Ow9wqkGJ
 cDEWkKylU+Byqd4Izj65sYx5/MkxcoAPD2XwmT9AvHjBNqKFenDCwiDGOmtjfOkP8WI8kSJoSyB
 OLb/aA4PSGQwEflAVevr5xf20LFsNcTOQa3PA8+0DjHNWP3nEUfIjsEcqDuUI3Vpgm5ldnRYrLj
 Q6a3La27NNWS6TLIw+FNtOqP8CY6z4rqNYr+KMBE91VichgeALKhV/YtGBc=
X-Received: by 2002:a17:907:5c6:b0:bd5:a77:2898 with SMTP id
 a640c23a62f3a-bd50a772930mr603057366b.24.1779064980291; Sun, 17 May 2026
 17:43:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260511124828.3210477-1-vulab@iscas.ac.cn>
In-Reply-To: <20260511124828.3210477-1-vulab@iscas.ac.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 18 May 2026 10:42:33 +1000
X-Gm-Features: AVHnY4JgnD5PclnykP7xQ1Bb6TRjDrOrTiDO7o5Y19wwdBaRqRutFoHfAvIelEo
Message-ID: <CAKmqyKNLoqWZ0GMRwgsN16ygUX7+U7TDw6P8MEWM8Odoty35aw@mail.gmail.com>
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
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x636.google.com
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

Thanks!

Applied to riscv-to-apply.next

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

