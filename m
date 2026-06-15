Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCDEFCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ5mk-00051s-9U; Mon, 15 Jun 2026 07:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5mh-00051a-Pd
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:47:19 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wZ5mg-000609-4I
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 07:47:19 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-6912f4acca4so5536232a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2026 04:47:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781524036; cv=none;
 d=google.com; s=arc-20240605;
 b=grZzS3uBK8k84Sar3GUwTDA6FqkaN4rZPEboXvKeTvuLZfp687bTWX/D6Z7WQBD7u8
 NhvjJUuvfrvt8g9hVnHjcvmZg+Qp95hU+uELMpHIR1ccfQan5WqijoFpUy2LCnRswDvJ
 6SfVk0XRwZGei1Z56McGR30p+qe7r4t/a8x+S66KrtoET0dY1qayAZOQIbTG/d+5HBJB
 GWRgxbYm5LQiYrL9mKkLypQK/8wOcs/fctc5gwkgJC/4WQPauz6jW0wR1rVdBfwr1HHa
 6P+OKAmUtRNv/oCeoswqCeUy0J35LxgW85V/uDO3V8158q23tzlg/0Iz2OeMNfRIyBEM
 VGnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=26eSbiFwouxMDBokhhVOiZHj5ZeI/02XK83mokRODi8=;
 fh=ZriAm0S90EnyrBIRCoQydX4HIakeTKMKsmbwVxd3Fyw=;
 b=CNYrKulvjf28/dnGa95kLzCm4QoVM17agi3cXclICE+ELm1VokrrViUAh0e7J6H6jV
 Wc+J9o2WxyixpPQrZxWKcqh45tKfL4cIEiOVg/3yK+m9sAq9NKFfa2/eNA1HIAPS4bg4
 TkDRfQd9M/uHhlqJjoMr1x4ni0BAk653uCBNM9PXN16If9hKcNPCwk34MXaIwQzOR4tw
 NS7/W3Wai5GeWRu7mqDrSxRxkpl8J0/SeXvxTuudFwBgYIu0Ma6N00vIR7Gvva4PtJbc
 IJJ8jTx0b0tqRITAZADQfLjpjzzzNKkqBjvfcjXagNRLtL97OokCoVyCeuIF/d1zyoCN
 uvaA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781524036; x=1782128836; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=26eSbiFwouxMDBokhhVOiZHj5ZeI/02XK83mokRODi8=;
 b=bAT7V48bdBYEn+U7VsbWUq0IWSgSXi6h/lubH56vRg3zx69anVF+H1EB9KcXoz4HFN
 GZeoy9oaoqF/PT1iJuNDrxj29J8MJHI6L3kORgBbUKST9LR0x9XoYbGIX1lQhMw1uCC1
 wiGcQyXja3TnpMJGlmDxj1FDhbX3LsLmTarohwD4AB9YFWDAfyWWdR2I/tDqIs+usHKs
 64pUbZwsEHoS6poZR/7B57Out/p6Dgm8ZM8JWP0Eo52cF4u440cfla6cT+hLQWS+U9IE
 xZulnKPh+cIjhZeUkhxKfuu3wcimKptTqG9NZjcZmj41k8sQT2QlwdKw4VAj3W7D7AYV
 rfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781524036; x=1782128836;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=26eSbiFwouxMDBokhhVOiZHj5ZeI/02XK83mokRODi8=;
 b=M3BhkJPL3HKKJ5xXxzDPCA0Efb+NxhqXKZu5O3YNRMbk2WTZbIJekfwDzZfs77d8U6
 /1917u9DbikISPohLYmlauawOz7FzY/TgzAj65CMlchgeYcIBS1ErjRyAMW86BlznziU
 1pxjDHypf3/yrzcThT/UraEy1ruQDjlZZF9rhBh6/A9Unab2TSlVl6yVInRIWUXC2+cA
 9RjQMUG06NHmp0mt4jM/ybIxDKtxfvDGMTxzjsMWoZKoSyyLrAPDUDduPbPJTWHPjNEf
 mFwySWSEH15RY/wuxynhSaJr1Ums194Gk8Bn0FeobBB7djbUe14CuNKMEGMqwuq1sCxJ
 vaWQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ljsVcY3xKcoefJsAIVu0sCFxT5C4Niip6YWCWW/SVTPWtHSyy0HnMaqrnWYbLr1AA8XLHvBB4h7l4@nongnu.org
X-Gm-Message-State: AOJu0YwrCXXjw3uiKO9ZfFhPkhIrba71wnMwKPvRnnwakqzC9nR13jUx
 Dl3aF1bOES5kMztB9XhS5H7KAmV0MEhJU42vwijCojyzWcjJFdxsA/yZF4gR66gUiXIVyxCUA/5
 tLLnOhEfIKjxGCJTqrsLqhr4QKD7t53o=
X-Gm-Gg: Acq92OGyBuP504uA0xihTZHrgDbErwVJSzh7VAs4yGzvUMyrp7Q/emjmKPhC5Z+PZHM
 A3n6It8QGWcrrdzpxvdiPwZiSbJGc6tzNesaHcxyZPdjOEQs/ZOTNHKRcz/0wxKSbdoJ5FtsEyx
 kI5+Bu5jYMMWSsjvI2wz4q76Bxijn2KMuYwfWK6FlThJjEP6fQjRJs9R3Do8dzNHPF/9yJ7Dz7O
 EKmG9l5w+oUInxXWpob7g8cr9Ogstb3iPIS8OVSAReJi4GnyLTAo2jqCXUk0NSEPM/mOhZy9p7u
 wCSnekBa
X-Received: by 2002:a05:6402:1ece:b0:689:92c0:22b0 with SMTP id
 4fb4d7f45d1cf-693c6a11cd5mr4438635a12.3.1781524036296; Mon, 15 Jun 2026
 04:47:16 -0700 (PDT)
MIME-Version: 1.0
References: <20260603065859.592063-1-joel@jms.id.au>
 <20260603065859.592063-9-joel@jms.id.au>
In-Reply-To: <20260603065859.592063-9-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Jun 2026 21:46:50 +1000
X-Gm-Features: AVVi8Ce-aKIyl3kUWlGp9FFmZZ_aOL8VhdTS6HfBp3s-Ayx3pNE2wELa0WiT95Q
Message-ID: <CAKmqyKPZjt8-pj8Ou8P52cAM-G4iTVujgJ=OJrZMn9u2iy6qJA@mail.gmail.com>
Subject: Re: [PATCH v8 08/12] hw/riscv/atlantis: Provide a simple halting
 payload
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Andrew Jones <andrew.jones@oss.qualcomm.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, 
 Michael Ellerman <mpe@kernel.org>, Joel Stanley <jms@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, 
 Portia Stephens <portias@oss.tenstorrent.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
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

On Wed, Jun 3, 2026 at 5:03=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> OpenSBI hangs before any console output if the domain init code sees the
> next stage is not in an executable region.
>
> If no kernel payload is provided to QEMU, the next stage address is
> NULL, and the riscv virt machine memory map ends up covering the 0
> address with the catch all S-mode RWX region and so OpenSBI prints
> console messages and does not hang until the next stage boot.
>
> The Tenstorrent Atlantis machine address map has RAM starting at 0 and
> it loads OpenSBI there, so it is M-mode and not accessible by S-mode,
> tripping the early check and hang.
>
> Add a helper to set up a simple payload that gets OpenSBI messages to
> console, until OpenSBI can be fixed.

I still don't like this. What is the status of the OpenSBI fix? Can we
link to the upstream patch? I'm worried we are going to be stuck with
this hack forever.

Alistair

>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  hw/riscv/tt_atlantis.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
>
> diff --git a/hw/riscv/tt_atlantis.c b/hw/riscv/tt_atlantis.c
> index 1ccd7d017c56..5de138578b48 100644
> --- a/hw/riscv/tt_atlantis.c
> +++ b/hw/riscv/tt_atlantis.c
> @@ -413,6 +413,30 @@ static void load_fdt(TTAtlantisState *s)
>      create_fdt_memory(s);
>  }
>
> +/*
> + * This works around a problem with OpenSBI hanging with no console outp=
ut if
> + * no payload is provided. By chance, machines with memory at 0x80000000=
 do get
> + * output, but Atlantis memory begins at 0x0 which takes a different Ope=
nSBI
> + * error path.
> + *
> + * This can be removed when OpenSBI is fixed in QEMU.
> + */
> +static void tt_atlantis_setup_halting_payload_opensbi_fixup(
> +                                        RISCVBootInfo *info, hwaddr addr=
)
> +{
> +    /* Store the payload vector in little_endian byte order */
> +    static const uint32_t payload_vec[] =3D {
> +        const_le32(0x10500073),         /* 1: wfi           */
> +        const_le32(0xffdff06f),         /* j       1b       */
> +    };
> +    rom_add_blob_fixed_as("mrom.payload", payload_vec, sizeof(payload_ve=
c),
> +                          addr, &address_space_memory);
> +
> +    info->kernel_size =3D sizeof(payload_vec);
> +    info->image_low_addr =3D addr;
> +    info->image_high_addr =3D info->image_low_addr + info->kernel_size;
> +}
> +
>  static void tt_atlantis_machine_done(Notifier *notifier, void *data)
>  {
>      TTAtlantisState *s =3D container_of(notifier, TTAtlantisState, machi=
ne_done);
> @@ -450,6 +474,9 @@ static void tt_atlantis_machine_done(Notifier *notifi=
er, void *data)
>      if (machine->kernel_filename) {
>          riscv_load_kernel(machine, &boot_info, kernel_start_addr,
>                            true, NULL);
> +    } else {
> +        tt_atlantis_setup_halting_payload_opensbi_fixup(&boot_info,
> +                                                        kernel_start_add=
r);
>      }
>      kernel_entry =3D boot_info.image_low_addr;
>
> --
> 2.47.3
>
>

