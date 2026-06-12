Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10849CD98CC
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jun 2026 03:43:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXsn4-0008GM-MO; Thu, 11 Jun 2026 23:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXsn2-0008G7-R3
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 23:42:40 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wXsn0-0004lF-Vj
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 23:42:40 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-687ed9aabb3so974965a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 20:42:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781235757; cv=none;
 d=google.com; s=arc-20240605;
 b=dcIWFs3RoRkKlPztsRMMn4XGxdXPKU/ulsP/r0JLeI2MOnqLHfO9dzXZ1ANgfEu2Xx
 dTskrM3n2L/tlMugoNvPpNeAbLL5Sukc08NOIreGD2pqyJymKcANr0tTXK3+HdTBNM5l
 8ArnuLxWPAOhzIKivxW1t9leeeKXH+09YQHsBIZcPrT1RRYPIRzy32Yi3A7AaC8EkVv+
 yjh5znG+FeFWBPQe7MBdsGDbRe4PzKJhPPF1JUzgl2BeVyr6N7qhZOzflGh5sxYXy/q5
 ostNZDXEJbr6PD+BPveXUzuABXdbiT9JzQHb10paQ8JzE0l56CkCX8tSx4xGgT3D+Lfo
 lDWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=BKXwUyc2mOYHmyhUSoE6yPyt7YlrIeEESabXVthSip8=;
 fh=261oot2FMbPVGnpcrb7kLMaV0fTVsfTOM7iBWmcFpKQ=;
 b=WM4vOgmTs9MfEu5FzpEHgC/+MZqThQV+mUnDU4+lEkt3akw20RZPIvpPnGm6zUPSgq
 /4jdQAM0rFf3ppv+bg2iE3CQwFuTF8/2Tc6xm1FXr3DTYw1yoEojqdx2A1+dKgPYPLaX
 OssYjPQK9POjk10SbWHn2ttdVon9olswr7T8SPR88MiN9JDRgQASfhM+2Umx4IRTOJtV
 GEtvG1t4o7S8H0VYfipvGaJ35a+dkMwb+zLn5P7mkS5GVaKuSvD3+gn91w6YR4E/t+E5
 72+JZrQk/BownXxiblwLCKV0B+4NyO+YHmS82BNmJpuEe25GDgET5rcZnWHKTQo6xZFI
 1hIw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781235757; x=1781840557; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BKXwUyc2mOYHmyhUSoE6yPyt7YlrIeEESabXVthSip8=;
 b=hW1t0NjuoYhd9o9CLSEK3cHqK6yCECQWlsMGHZm6p+HWE9LMICThX3ErATmNqY81gW
 SEwmq/aqEdpsF/QBkEAyTanBNfflBV49NWXRwcY4JU6k0kt33hLToPWIy8Y10BnWkiX6
 MhHzjuOwjcvGVTcasfp/+K5HnXCcNc0EHyFTanTkLg1Bme0eeXUVyNePAmOjCK0iiUyM
 gTeD74VInHCljjUNYzcUSdfBmFQ/0E0oXuvw3OZUmY9xawoQXYoylxUlG+JD+o0V4iBT
 HcTSIGAxj9FLxPsqaPXHvTpIm0pkslML0eWlfQfLgRfwgYa62QfWDIYCR560jlGZgOIR
 KOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781235757; x=1781840557;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BKXwUyc2mOYHmyhUSoE6yPyt7YlrIeEESabXVthSip8=;
 b=kSQhULdZj5U0WPKu5UbL0RMuEfOgdUjb7eIJCxsXUsgJPhXIlm4JQA2qZ7R28fo28x
 RXPvJs4kDD8MOA+9x4/h9Nac8zwjI8F+wjLfiGdZZqSG79X/ow9keL/QHXUA3G/oU1Ho
 Adbsjx9P5EwZPZvdHsDd7Vq50OYokvIGgZUYGgG4fto0qmYjYuXhnZzULW7/ZiDl9nzO
 kXjXM91pOXyrgcDILo/qSWdmIszyNQv3X1wexIHW+guvOvYNNEl4k+HtacXN44StByEP
 UzXbsaEAnEgJQXZ19c5epN5HkIrBUkpVFpOcqBOcgNB9hsf/OXFIWymCDZOlMsmJPY4o
 3leQ==
X-Gm-Message-State: AOJu0YyxiXazH2EZWNlb2obBjuX2Ulum4SkMNWHjPlREyw1KSNFkl9IE
 q9J8trm+C7QZJlJ3sPj3B4e/9wyjRfOx7sDLde5vwY5k6gwg2qT5LRzxosBdwZiAkJGVSNova1I
 JeO+Gkz31evgXijgO1p7z43RHTYGQ5PA=
X-Gm-Gg: Acq92OEfXqgQrsfE1i8NirXDE8I5wLZ52h0ImhmqYEINKp4I9D+POTrSddRztoJHdqV
 w3SDtVy4Hrn9Za/8NXEbeASmlIhYrm+aBVERBFhfBfsAadWN0YHH57NLUn3mNZYHJXKAv/DS9Ln
 xGLhta+re2RkhGd5pGDDPeORhhRqoN4dXS19ZCJfVA0ItYV9dATTmif5iTxuhCHS2ihkFijvK1u
 9xwrErNPa4jevpHRQZk0eENLxmLj3acWi8//Bwdgor1CtPE2q9HXxBAL0EHDMNfX3JqTnbnDk8P
 1mg9Eh0TABkPY6BZrgx1d4kNyv9yBvz3C5avOg==
X-Received: by 2002:a05:6402:540c:b0:66f:2ea5:c269 with SMTP id
 4fb4d7f45d1cf-69378a4d387mr337720a12.15.1781235756904; Thu, 11 Jun 2026
 20:42:36 -0700 (PDT)
MIME-Version: 1.0
References: <20260606145520.34152-1-imaginos32@gmail.com>
In-Reply-To: <20260606145520.34152-1-imaginos32@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 12 Jun 2026 13:42:10 +1000
X-Gm-Features: AVVi8CfU8fhGCf-_u7nYDSpn_yuEfplfHfZs2EPv8C3uLJpm0HxIv9HaNhWD6J4
Message-ID: <CAKmqyKMA2GfZOjoyHo_7=cgbU3k8EuiCAY2DQqaLVZxY2n7YWA@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv: enable `mnret` disassembly
To: imaginos <imaginos32@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52e.google.com
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

On Sun, Jun 7, 2026 at 1:32=E2=80=AFAM imaginos <imaginos32@gmail.com> wrot=
e:
>
> The translator has supported mnret since commit 3157a553ec6b9a
> ("target/riscv: Add Smrnmi mnret instruction"), but the
> disassembler still renders it as illegal. Add it unguarded,
> since the encoding does not overlap any other extension.
>
> Signed-off-by: imaginos <imaginos32@gmail.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d416a4d6b3..065985992b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -985,6 +985,7 @@ typedef enum {
>      rv_op_ssamoswap_d =3D 953,
>      rv_op_c_sspush =3D 954,
>      rv_op_c_sspopchk =3D 955,
> +    rv_op_mnret =3D 956,
>  } rv_op;
>
>  /* register names */
> @@ -2255,6 +2256,7 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>        rv_op_sspush, 0 },
>      { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
>        rv_op_sspopchk, 0 },
> +    { "mnret", rv_codec_none, rv_fmt_none, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -4050,6 +4052,11 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>                      case 64: op =3D rv_op_mret; break;
>                      }
>                      break;
> +                case 1792:
> +                    switch ((inst >> 15) & 0b1111111111) {
> +                    case 64: op =3D rv_op_mnret; break;
> +                    }
> +                    break;
>                  case 1952:
>                      switch ((inst >> 15) & 0b1111111111) {
>                      case 576: op =3D rv_op_dret; break;
> --
> 2.43.0
>
>

