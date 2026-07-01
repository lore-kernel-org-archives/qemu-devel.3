Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC28DC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 00:44:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wej3o-0003nh-FN; Tue, 30 Jun 2026 20:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wej3m-0003nM-Bd
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 20:44:14 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wej3j-0005VN-4r
 for qemu-devel@nongnu.org; Tue, 30 Jun 2026 20:44:12 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-697ce8cfe65so160240a12.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2026 17:44:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782866649; cv=none;
 d=google.com; s=arc-20260327;
 b=g02XOPDnrG09zGHb/yyx2pMK8+E16A/uDvcnU8GMwBzabr/oWP+Kgwk7jAOoM5OuyV
 9X7v3e5r5Sx/TiCzaP3DHryXTfyAM9GksVTw2xD4iwcZjmgV+el2yBts0DmQ/8lPsGC3
 TWmzm3IUychtM5q2G2yhKlVGcLkQDXeHbO27+hd3E3Kpe2oofTAZXyIg+ziA1cJcsiMh
 tbUbrOc8v33CacdS+Eedw3HRpZhv5Zb8SIljaUe81kCLD3k3nAAOVqrqRoXFsIVOgbKs
 o1/IGOpO/mwUeZi/CsOZ1xrtbYD5SsqmoCnImxHuXgUCO88MSy+CPAejoHFQsftl9OqI
 r59A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HAcuwiVLB70smj+H9Yjzxahy8QdYt7cyfakzqvYNrWo=;
 fh=JS97lGsTsLXsimIh3Iw+rRF2SeWqX5tm7TeGB0K1Zn4=;
 b=Vdoly/mfuOjzXxkGfGuPrG62TG9uqXZoplM4tJIJYEADPzO5jgveeoxCM8KcE7wIAj
 JgtbDIa2pEnpdRX11QAyq+xqPEstOfLOMV1nKWTdcXMU5xvui3ZCwVyvU3OxRA1L66Yn
 i79F2JBrBFfWdGhdvDKtX3N4PdXnoUi4fMV+0VpieHja++akhaboKOkGLr3qRcucZSPj
 W5F/KUjpzXFj/1hh2USe0FUYBpI5DhZKpqO9Uy5oaGx7xijTOX1M/EPBRqS+6pMzbUEn
 6ZZ0QIK/rPB3f28ac15SF4uLGWlACx1BXHG25WAuuwCMdHekI1WMpTpy0XaecXqSmSe8
 7CMw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782866649; x=1783471449; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HAcuwiVLB70smj+H9Yjzxahy8QdYt7cyfakzqvYNrWo=;
 b=sc+2WmBTgicZPRBlzXdj+3BCmiUhMvSMF12DajH/vB+d3zM2DYc9a2Qdaw7TGK4CMa
 qvnzcHoWta/Vb8rSlT6Jw3V8lLKdWDtAitDfD9TjYsAs7g4MAIPsLFOuzyPxzkBv0Opb
 XAq063pvc/iQfebxrAQoNCTbo7V/Db2IIRbeNkItQOvXI6glW7obMOkclwDDiU23Ep7X
 Ku1n+jH9LDtGY4HQMUtQw38yEuBParnEb1H7HutTxzR6x6GjTb9/arCqdJDHz3618g47
 l+UN2KfnBmPlhvbNZwYy+dhD4oFWKUr8EBPDZTLdntOOEu0xbSYd6PDud2OkpHGiXkBH
 ggcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782866649; x=1783471449;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HAcuwiVLB70smj+H9Yjzxahy8QdYt7cyfakzqvYNrWo=;
 b=EUtxzkVYgdxXqXnL576QjT93F3WTLUti3p+00ObTRlVjlOEUxQ2XyZOii48BKC8ejg
 tB18t/mYeL6EOEk5EGLpzmcSFiyoxnIp61px46XPAbvs1nWGFlgt5otiSR8144ke643o
 GL/Owce1mTpEqdUdHs92TaAHr5LZXnhNZZ+12zeScXnwR8/lV4Lv9U68kzg910B8LTS5
 Kq0hGnVk683oPpG9ZSpmXvyNjCQkmM0OXbYaoOzH8rU5klT5LYw5J9jlzF7rxCDyoo0G
 FFzoFWjv6Kza1lMkDMiQVrzp3uHF0/xXe/Gtm9ZBF3T2cB0qHI2bC1edlFOmVtfFgmDf
 R5TA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrn650tY7cObS8A33dptzYJ712cBzlOYh3EVSiSYrcH2pQ8IY2NT2wmuUiXJSan3ZKKAMzW+cBKrGx1@nongnu.org
X-Gm-Message-State: AOJu0YwhzAY5Muko/VMa1jJFHdZ2536oP+NjZCoqLwGyKUfuNXF1APUD
 xsx3adQ2XlvLk0C5LYe7NzmRzJTl0h/1ienyuQHig9+f3OlKOXVXSoRcLL8Iq2zzLV/jCEbPILI
 io1K+DYSIK0aQ5U3z3DW3pkzJL9n/QQA=
X-Gm-Gg: AfdE7clMScvTSUPsMI1Wljr8qtWxlDYg7vckY+yX9i0OHhjK4RUulUJdq5jjNHhnkTo
 YBED1ggJtShwh2JCYSttaj/0YPYlqailoFZgUNrjC8KooO+EfunkYlzm8zWOpc3x4F+z/+HGVqG
 SasQBcp2fIU1USEyIVvmH07/qp+K1DV2jCgRJrDHLwYaFgaKbD0saKKb6DZM4lecQOydSSVl0Ys
 1Ut596aOXRTgYoXVlohUeSGPaeew9JeNPV0nxZZCK+TTeiineBKrgvW8Sum6YI6xSzDh20X8abY
 vPRnX6ihRK+p9jd+3b2h3UdNuc+T1joFrxkNOQ==
X-Received: by 2002:a05:6402:4401:b0:698:954:484e with SMTP id
 4fb4d7f45d1cf-69887724ea8mr1402097a12.14.1782866648797; Tue, 30 Jun 2026
 17:44:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260630024952.1520546-1-joel@jms.id.au>
 <20260630024952.1520546-9-joel@jms.id.au>
In-Reply-To: <20260630024952.1520546-9-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 1 Jul 2026 10:43:40 +1000
X-Gm-Features: AVVi8Cf4P-3w2A8s5Oc2Xr0h5y5xzAhx0UEpDB6kSZnxxO1001nhHiQry2bv0OE
Message-ID: <CAKmqyKNq-9z4jpZm1cDYx9tr-2fZBM7m27=7mFy=w+PUJA+xSw@mail.gmail.com>
Subject: Re: [PATCH v10 08/12] hw/riscv/atlantis: Ensure OpenSBI has a
 non-zero next_addr
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Michael Ellerman <mpe@kernel.org>, 
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x530.google.com
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

On Tue, Jun 30, 2026 at 12:53=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrot=
e:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> When using OpenSBI fw_dynamic on the Atlantis board OpenSBI fails
> to print any output, as it hits an error early on
> in the boot process and gets stuck in `sbi_hart_hang()`.
>
> The error occurs in the `sanitize_domain()` function inside OpenSBI.
> `sanitize_domain()` is called after a M-Mode OpenSBI Firmware and a gener=
ic
> coverall S-Mode RWX memory region are created. `sanitize_domain()` is
> checking that the next address is executable.
>
> If no next address is provided (which occurs on QEMU with an empty payloa=
d),
> then `dom->next_addr` will be 0. On most RISC-V boards address 0 will fal=
l
> inside the coverall S-Mode RWX memory region and pass this check. On
> Atlantis the OpenSBI firmware is running at address 0, so this address
> falls inside the M-Mode only OpenSBI firmware region and fails the check.
>
> Once the check has failed OpenSBI aborts and the user doesn't see any
> messages. This can be fixed by either supplying a payload, or just
> manually forcing a non-zero address (actually just any address that
> isn't the OpenSBI firmware) for next_addr.
>
> This patch ensures that if no kernel is loaded we still specify a
> default kernel_entry so that OpenSBI happily boots and jumps to
> the first address in memory.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/tt_atlantis.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 1f0cd08ac959..d4fa9c251d3b 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -377,8 +377,16 @@ static void tt_atlantis_machine_done(Notifier *notif=
ier, void *data)
>      if (machine->kernel_filename) {
>          riscv_load_kernel(machine, &boot_info, kernel_start_addr,
>                            true, NULL);
> +        kernel_entry =3D boot_info.image_low_addr;
> +    } else {
> +        /* If we aren't loading a payload, OpenSBI thinks we are trying =
to boot
> +         * address 0, which fails `sbi_domain_check_addr()` as that is w=
here
> +         * OpenSBI is running. Instead point OpenSBI to the end of the r=
egion
> +         * where it was loaded, which avoids the early hang, allowing th=
e
> +         * system to proceed with the OpenSBI boot output.
> +         */
> +        kernel_entry =3D kernel_start_addr;
>      }
> -    kernel_entry =3D boot_info.image_low_addr;
>
>      fdt_load_addr =3D riscv_compute_fdt_addr(s->memmap[TT_ATL_DDR_LO].ba=
se,
>                                             s->memmap[TT_ATL_DDR_LO].size=
,
> --
> 2.47.3
>
>

