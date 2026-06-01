Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73308CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 04:00:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTtpL-0008GB-HA; Mon, 01 Jun 2026 00:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtpE-0008FA-HE
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 00:00:30 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wTtpB-0003lY-Bl
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 00:00:28 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-68cec9f4c6cso1746328a12.0
 for <qemu-devel@nongnu.org>; Sun, 31 May 2026 21:00:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780286420; cv=none;
 d=google.com; s=arc-20240605;
 b=WWqDF/41IFlwGDjVUbckEOpxnbfZrxydpON06DLenbvFSXUhKfuti8kBOrNz78C800
 ePFkLLX4yJkhRPSWZfezU/imAyaKy5+HmkyQ9hujCrGt3HpMOcmG4sYM51rP4JDPskY1
 KfroTYJX4USPRXxx0I9IwLMg+Ffo8RNfw7R231iSm78qcfoJ2yx9seD1pQvhOeqNNB8+
 ZK1dX2Jek6CzI7WQ210tmkyFe//0E9q9udqJNE780q9Pjx5IetZugC5xl5wFjS0jagsc
 aVMeYcitMPFzC30x9I1pGAJyy5UFyghf7DbnZNsRiVk+vMRz8hfmpdYCKFx5MRgd4Uub
 zhVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=nIyi+hxkqvLTTnRYGo1qqkrTfklxpXD6EopCH7Zar5o=;
 fh=oXbwLIQ6D7eZBIAfdMwTNx3JbGXBw4Kr6QcethzQnTk=;
 b=h5Mw/lpgQvmqnbahXYOB7s32QAF4wJ7IANEcfyrITFg625rNsHtS/uYWi95wJyeeTZ
 S5Zc6/FMEub1wIO8TohnKumnZd3aDRor/N7tCWx8YwbZg5cJZ3majQWJCH27LUdaeZ7q
 NzPhf1OP1a4Sgl2krqRDlfsgWmFm9N7hswT4uj7w2JneZYy0hvSES+uhU8VJMKzFU8LT
 eT1ENMFmDn63DALky2snI7V+wHofQrkVlirSYALE/MD/vx3FX9WZHptM573+jhayOvsg
 mujYiVEQgDzh+uxzUulGX4iWeWco7phiZWwH/U+vLi9K3ZsMaona0zyUCosDqRbSMxeN
 AJyQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780286420; x=1780891220; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIyi+hxkqvLTTnRYGo1qqkrTfklxpXD6EopCH7Zar5o=;
 b=QXYMKehhs/6i12pX3jt77KEP843AXsF4SpTt8neFjd93/7aEn3Ah8fBDJVk/hbQfdM
 4TVR8DvzuRFE9+ipsbzuOQzpOl95uAZhcVOlvNUgGPHNPzzS9HtWIvkR0oVV0SSj2+gc
 LdmMFf0CJJk6K7XSxt/2WXlQxdLEJwAO1zBUrsBquFqyw1JAyTA0AjRqoaYGH/Wm152J
 4X7K13cBCX73xDi8OmRhVa4Msb6TsNz3Px2A1Ixc47BxjxhiRVGvSKxqLJfiywiMgvFm
 EoJHfFKUVckWVziqqqjmdR1LRstjRW94X3HBccreqezKS+Yic+W2olAH8hFIpvtcEscn
 z2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780286420; x=1780891220;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nIyi+hxkqvLTTnRYGo1qqkrTfklxpXD6EopCH7Zar5o=;
 b=seZKBl5uQR66ZW7CF0OP8kWNmJ8Wh9KO2VtWdH9v14MkSR2oBXEqE3cCsgiaW0gPKS
 YiHX27CDm7WDTxHBK4y21BVDKLyIWJcj3LM5BUytcfjPorZPB9JzmXiF0uW9RvyFIDe6
 45ivQzaQhiriZOtnXOLnl3BW2G0r7197QjUam87FgqEGEaJZuba1WQDNX2doaUwpsjuF
 Y3ps56HInOadm9jT72PbXjInmzPYBR171cSPf5oDPnRg5Xu8NwY1ylgnHNPMs8uobpPH
 yfGHf5Oad/NMW376s2bnx/GyjMm/2umJCFEPE0ygMqKYv8E8trQeJhaUqU6WnA6OVqmz
 UODw==
X-Gm-Message-State: AOJu0YzllGPyunVG5bFcmnp41+Ksg9NrNrukYl7f4t+G7JRYov6PV3xz
 UFWeh/QAzNbHjSJVmM2kUmx5YmTmGMpdWcDzIMidn3sfXrwMhuhSgVU+35ug3CfYFuixTd3tLJa
 6UI4peLd4K9QuVB8O+3e0bxUmVds7NN0=
X-Gm-Gg: Acq92OE9HPH5jCwpH5MU2kek6eEvrrBvhaGAXVbXHJSPwlapkHV8Ekl+u2cS0Pjj/MJ
 ezFU1cM3J/bCp2uyEevvwGbldjvn6e5I04v3xEphuWbHWyrnRz28iZpdEJ/tC7jCHinIL1QUgIK
 wxAV2sw8dAM2VXzatZOHm3pXAUSI6GLfscFANW4aKcZrWwKY62J103pyydUeLi9zjlpb8mD2nmv
 m0v+H7wkdckIPeeQDKGU3bV6AP+kUFMifDSGyEkAFp4paNU1hHthInLCA9ysG3PhfvtsofGrZts
 19hoWlkH4nHQbGQO4ubV5DfnFW9usO+hcFlVI5UKdUkezPbt
X-Received: by 2002:a17:906:fd87:b0:bea:455f:74e2 with SMTP id
 a640c23a62f3a-beab3851b3fmr497018166b.16.1780286420497; Sun, 31 May 2026
 21:00:20 -0700 (PDT)
MIME-Version: 1.0
References: <20260527201348.29511-1-philmd@linaro.org>
 <20260527201348.29511-9-philmd@linaro.org>
In-Reply-To: <20260527201348.29511-9-philmd@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 1 Jun 2026 13:59:54 +1000
X-Gm-Features: AVHnY4LHjIE49wd1NbTGt4RwdmM2_H-PKYCeEYFoVzbeERdyoyvaCpfK3GYgOE8
Message-ID: <CAKmqyKNswZsgk2O3J_sm4wm7Q_mZrc7RkqSovhUrPoxW4gn-4w@mail.gmail.com>
Subject: Re: [PATCH v11 08/12] hw/riscv/boot: Replace cpu_to_le32() ->
 const_le32()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-riscv@nongnu.org, 
 Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 Anton Johansson <anjo@rev.ng>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>,
 Christoph Muellner <christoph.muellner@vrull.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52f.google.com
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

On Thu, May 28, 2026 at 6:16=E2=80=AFAM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Rather than adapting the array endianness when it it
> filled, directly initialize the CODE words with the
> correct endianness.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index c6ab1cc8cfb..4297949f6be 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -454,40 +454,36 @@ void riscv_setup_rom_reset_vec(MachineState *machin=
e, RISCVHartArrayState *harts
>                                 uint64_t kernel_entry,
>                                 uint64_t fdt_load_addr)
>  {
> -    int i;
>      const bool rv32 =3D riscv_is_32bit(harts);
>      uint32_t reset_vec[CODE_WORDS + DATA_WORDS];
>
> -    /* .text */
> -    reset_vec[0] =3D 0x00000297;                  /* 1:  auipc  t0, %pcr=
el_hi(fw_dyn) */
> -    reset_vec[1] =3D 0x02828613;                  /*     addi   a2, t0, =
%pcrel_lo(1b) */
> +    /* .text (RISC-V instructions are always little-endian) */
> +    reset_vec[0] =3D const_le32(0x00000297);      /* 1:  auipc  t0, %pcr=
el_hi(fw_dyn) */
> +    reset_vec[1] =3D const_le32(0x02828613);      /*     addi   a2, t0, =
%pcrel_lo(1b) */
> +    reset_vec[2] =3D const_le32(0xf1402573);      /*     csrr   a0, mhar=
tid  */
>      if (harts->harts[0].cfg.ext_zicsr) {
> -        reset_vec[2] =3D 0xf1402573;              /*     csrr   a0, mhar=
tid  */
> +        reset_vec[2] =3D const_le32(0xf1402573);  /*     csrr   a0, mhar=
tid  */
>      } else {
>          /*
>           * The Zicsr extension has been disabled, so let's ensure we don=
't
>           * run the CSR instruction. Let's fill the address with a non
>           * compressed nop.
>           */
> -        reset_vec[2] =3D 0x00000013;              /*     addi   x0, x0, =
0 */
> +        reset_vec[2] =3D const_le32(0x00000013);  /*     addi   x0, x0, =
0 */
>      }
>      if (rv32) {
> -        reset_vec[3] =3D 0x0202a583;              /*     lw     a1, 32(t=
0) */
> -        reset_vec[4] =3D 0x0182a283;              /*     lw     t0, 24(t=
0) */
> +        reset_vec[3] =3D const_le32(0x0202a583);  /*     lw     a1, 32(t=
0) */
> +        reset_vec[4] =3D const_le32(0x0182a283);  /*     lw     t0, 24(t=
0) */
>      } else {
> -        reset_vec[3] =3D 0x0202b583;              /*     ld     a1, 32(t=
0) */
> -        reset_vec[4] =3D 0x0182b283;              /*     ld     t0, 24(t=
0) */
> +        reset_vec[3] =3D const_le32(0x0202b583);  /*     ld     a1, 32(t=
0) */
> +        reset_vec[4] =3D const_le32(0x0182b283);  /*     ld     t0, 24(t=
0) */
>      }
> -    reset_vec[5] =3D 0x00028067;                  /*     jr     t0 */
> +    reset_vec[5] =3D const_le32(0x00028067);      /*     jr     t0 */
>
>      /* .data */
> -    stq_p(&reset_vec[6], start_addr);           /* start:       .dword *=
/
> -    stq_p(&reset_vec[8], fdt_load_addr);        /* fdt_laddr:   .dword *=
/
> +    stq_le_p(&reset_vec[6], start_addr);        /* start:       .dword *=
/
> +    stq_le_p(&reset_vec[8], fdt_load_addr);     /* fdt_laddr:   .dword *=
/
>
> -    /* copy in the reset vector in little_endian byte order */
> -    for (i =3D 0; i < ARRAY_SIZE(reset_vec); i++) {
> -        reset_vec[i] =3D cpu_to_le32(reset_vec[i]);
> -    }
>      rom_add_blob_fixed_as("mrom.reset", reset_vec, sizeof(reset_vec),
>                            rom_base, &address_space_memory);
>      riscv_rom_copy_firmware_info(machine, harts,
> --
> 2.53.0
>
>

