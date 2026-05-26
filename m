Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48B2CD5BCF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2026 03:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRibi-0006pP-27; Mon, 25 May 2026 23:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRibf-0006os-Gb
 for qemu-devel@nongnu.org; Mon, 25 May 2026 23:37:27 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wRibd-0006Pw-LL
 for qemu-devel@nongnu.org; Mon, 25 May 2026 23:37:27 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-bd4f8260e4eso1819544966b.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 20:37:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779766643; cv=none;
 d=google.com; s=arc-20240605;
 b=gO29q2Qgr/h0r49TIzF3GPAbBH5VPRrsalUa8mKI/lVRQcVz0I707p+z2JTEFhzTFh
 6jQuDK7/dLfnMHr/XjCiIETRV66ptrI4OHGw2RVDk2mZ6V8YCYAZlt4flds/yX4N48av
 V7EiQB+uG65UK+mKDfa27KINdugekQJ07GzvL7X5qgjdcQqvt4MGtEZNPScdTL01d92A
 DaQjrfmQW3boOhH7U66Xr0AC9keHj4KfJiv4larPT+SaBN6C4ZO0vc1AgYucBauM6fhH
 WJl3r3cH0Tquf5+S91PBthXLifpP+w+Nk+L9wY9/nb05RC3Y1vRK5GVwTpcVeHQ5clL9
 9ACw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/bxemx9NwDuxI6koxTSmjgPBz2QXrtwm0S0FaoGe1HA=;
 fh=+dPXGxW3pQNYFrTSil53fSXYfdhGIs7bI6Dyql1Mx+Q=;
 b=V9Tzrp1urBSbFC5iDU2+BdfpfvylsngZEaN54UwbijxdKeDrY2vbmBPBf7fP9NENla
 ZFVFX+pMsLrQ5UUN2hInHul0EoNTKjha/W8g+tNDEysCqMxT68mcfaBVXEaEDNrQE/TT
 AvUFLH04tJu9f4gkoCv40LTN/2TUEYwC0rQaSDXOm8YDASFe+VtrX+u7XZJhwbambSNm
 qIq8fwRVeSN2G8FRyZMHUwJ7i6IduWwZEKTrlFhronPX4TXxW9AlhIk/2/p+BPvN0JSC
 06HTBkYFN+n9dzockLR4hGqvIkFjC8tMkqyCIemppYU7D7rOaMLNccyrSZftQHGRuC7t
 AKRg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779766643; x=1780371443; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/bxemx9NwDuxI6koxTSmjgPBz2QXrtwm0S0FaoGe1HA=;
 b=HJJWTWC6w8lCxaStdn+9RumXckVKXkLYRDcCZl5CBFgXdepXUz1IR/gMzK05UydmpO
 J1dJyejDW6NtKTBcrC1lQd5lA/547+uCmpnkVxtMxEjq1ptRKTJcLO0Gkmx4XbmGE4NT
 JEx0xo57IpCfIT2U+wOpprj1aSXh3X2hHs7sUjwXFqc+jXX6stP4HBmUcUj5kYhDJlW3
 2sJifTyZvrzit89SKqKzf6NWT1QwzvXrIwE+gSrMJD23edwziGzb4AJ0neI6rE4WDApA
 NQ7ZFVcSHmkqb56EZkP8Gp3F1Kor6uZz6LItxv7ro2kU40/BgC/Y0JZFv6kSqD8sW7Ov
 FLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779766643; x=1780371443;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/bxemx9NwDuxI6koxTSmjgPBz2QXrtwm0S0FaoGe1HA=;
 b=ENILlmiftaMZ2cpd/NLPiOQ48x3vauWMctMxESRktmOSsxE0785bxKoEwU08tL1TJ1
 0gmZGN5tDRn4zrAtLopn9r3T2ND+4c+kudvJauRkLh/h1VbyE9ACZEHCaQpfoIq6vgpF
 JjIJ66Y9vn/yAcIFf+ISSVyeAn/MJ9/1wrjpGqUEo/FRTrXdGtydyJJCqog4P5EHFz4W
 G1TfyQC0w+Q/0vNLp5vUEXeWceQEHjoYZn+g7oiGpgv6tW4mz3ClRGTYN6NcmNI2usxO
 Iziu45xlBSzl9lwaWY5EilUemRJL8LrfkHUMpqg+fVXE8t44qVz21z34zjC/2GJEChPo
 B//g==
X-Gm-Message-State: AOJu0YztCL2KhKJ23EgQOLpZOX08Q50NJ5jfwC5KD3y23HOfZyBmVwPr
 A/skzDfJFyJ3eDxgaTaEHP8PgBasjQqBX+D/ZOi4FimxxFiy0SznylCwjjRS2qX5FQPx0cNHz9a
 RLTeez5uvIKK+qwWyPj6Gz8pVL/lfVFM=
X-Gm-Gg: Acq92OEs2VmJeI3Ztpk2pe+4stK1zmpoV0Vaq4kjfZgjt9LZ4xP0qJomLCEL+O1xgdM
 b8FP0ilFpETVOzqWvVvQC1vWV96M+3BRtjTtwLQNFnO44CrNH7eGm05fU+PF1POCUxqYecIkl0l
 gFM3pU/Jn9T191q/WDpYWfwXYKFtE1BC3i95bs30hnNJX2f/cD8YySBYU5DpITgMVdHVFcA5QJJ
 afEYb/sxcOeI7a1mUhhuu1AnbetOOUhtgkCaUdTpovO1jH8uNGScOsrkZR8nYrj2FZDO2pk0LqW
 CQhIg36aR1HSly+va1C29qLWn23Zjpl7gDiremba+EFkSQcB
X-Received: by 2002:a17:906:30ca:b0:be2:4576:ba08 with SMTP id
 a640c23a62f3a-be24576ba48mr136396166b.30.1779766643303; Mon, 25 May 2026
 20:37:23 -0700 (PDT)
MIME-Version: 1.0
References: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260519204714.1376551-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 26 May 2026 13:36:56 +1000
X-Gm-Features: AVHnY4LtQV17BC0kfK5f8jh4Fjv4CnOqagHadRsUFsWb68j1Flv3YLi2QsMSe7g
Message-ID: <CAKmqyKO5uXTBeqrpUZL6m5KtX8BhOaS=EC1cru+BgToR1iHPgQ@mail.gmail.com>
Subject: Re: [PATCH] disas/riscv.c: add 'cbo' insns to disassembler
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x632.google.com
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

On Wed, May 20, 2026 at 6:48=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We forgot to add 'cbo' insns to disas/riscv.c.  The result is that the
> disassembler recognizes all of them as 'lq', an insn that happens to
> share the same opcode space.
>
> While we're at it reorder cbo_* entries in insn32.decode using opcode
> order instead of insn name.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3480
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  disas/riscv.c              | 29 ++++++++++++++++++++++++++++-
>  target/riscv/insn32.decode |  2 +-
>  2 files changed, 29 insertions(+), 2 deletions(-)
>
> diff --git a/disas/riscv.c b/disas/riscv.c
> index d416a4d6b3..36609efdf5 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -985,6 +985,10 @@ typedef enum {
>      rv_op_ssamoswap_d =3D 953,
>      rv_op_c_sspush =3D 954,
>      rv_op_c_sspopchk =3D 955,
> +    rv_op_cbo_inval =3D 956,
> +    rv_op_cbo_clean =3D 957,
> +    rv_op_cbo_flush =3D 958,
> +    rv_op_cbo_zero =3D 959,
>  } rv_op;
>
>  /* register names */
> @@ -2255,6 +2259,10 @@ const rv_opcode_data rvi_opcode_data[] =3D {
>        rv_op_sspush, 0 },
>      { "c.sspopchk", rv_codec_cmop_ss, rv_fmt_rs1, NULL, rv_op_sspopchk,
>        rv_op_sspopchk, 0 },
> +   { "cbo.inval", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.clean", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.flush", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
> +   { "cbo.zero", rv_codec_r, rv_fmt_rs1, NULL, 0, 0, 0 },
>  };
>
>  /* CSR names */
> @@ -2876,7 +2884,26 @@ static void decode_inst_opcode(rv_decode *dec, rv_=
isa isa)
>              switch ((inst >> 12) & 0b111) {
>              case 0: op =3D rv_op_fence; break;
>              case 1: op =3D rv_op_fence_i; break;
> -            case 2: op =3D rv_op_lq; break;
> +            case 2:
> +               /*
> +                * 'lq' shares the "(...) 010 ..... 0001111" opcode space
> +                * with 'cbo' insns.  Check the next 5 bits to select
> +                * what we want:
> +                *
> +                * cbo_inval  0000000 00000 ..... 010 00000 0001111
> +                * cbo_clean  0000000 00001 ..... 010 00000 0001111
> +                * cbo_flush  0000000 00010 ..... 010 00000 0001111
> +                * cbo_zero   0000000 00100 ..... 010 00000 0001111
> +                *
> +                * Anything that doesn't match these will default to 'lq'=
.
> +                */
> +               switch ((inst >> 17) & 0b11111) {
> +               case 0: op =3D rv_op_cbo_inval; break;
> +               case 1: op =3D rv_op_cbo_clean; break;
> +               case 2: op =3D rv_op_cbo_flush; break;
> +               case 4: op =3D rv_op_cbo_zero; break;
> +               default: op =3D rv_op_lq; break;
> +               }
>              }
>              break;
>          case 4:
> diff --git a/target/riscv/insn32.decode b/target/riscv/insn32.decode
> index 6e35c4b1e6..21272fdb50 100644
> --- a/target/riscv/insn32.decode
> +++ b/target/riscv/insn32.decode
> @@ -207,9 +207,9 @@ ldu      ............   ..... 111 ..... 0000011 @i
>  {
>    [
>      # *** RV32 Zicbom Standard Extension ***
> +    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
>      cbo_clean  0000000 00001 ..... 010 00000 0001111 @sfence_vm
>      cbo_flush  0000000 00010 ..... 010 00000 0001111 @sfence_vm
> -    cbo_inval  0000000 00000 ..... 010 00000 0001111 @sfence_vm
>
>      # *** RV32 Zicboz Standard Extension ***
>      cbo_zero   0000000 00100 ..... 010 00000 0001111 @sfence_vm
> --
> 2.43.0
>
>

