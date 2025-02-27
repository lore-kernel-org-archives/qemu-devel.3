Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F09C9C021B8
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 01:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnSaN-0005N9-UO; Wed, 26 Feb 2025 20:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSaM-0005Mw-Vs; Wed, 26 Feb 2025 20:21:11 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tnSaK-0000R4-RW; Wed, 26 Feb 2025 20:21:10 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-220e83d65e5so6140755ad.1; 
 Wed, 26 Feb 2025 17:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740619266; x=1741224066; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FcHUjHkUH76Q616JC/e15wqrTjoHvIDXG6KwBhRrFmA=;
 b=PohfFtCo33A2b/9PnbTrTStlslN27WEz76I+wMzgFiiyxteVQfYpNEvQpYi0KnlHY1
 CqdbuXswDkDQOZd+BfY/R42cRh/hOy8n7OMhrjoWDznkGZ74QeakSSTcNHvXgDUTmFml
 1N98Yqc2LXl++IgfoAiM1qYWl9fyoVOiA+hFKTobr1f1nGaZ1efGp3Xf3YZUWGUBY5j1
 rH9EvyYBbmTsfCDrnFCwibowplBsn6rGnknK5MASxBDR+MT8+HsgumvWfnuFL9Gy2t1U
 9TgK7Pan0nhswZoX69Pavr3smD/U8g1uagve3/eP8adHurGrZyJwv3+j3s0o07NW4yvc
 rBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740619266; x=1741224066;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FcHUjHkUH76Q616JC/e15wqrTjoHvIDXG6KwBhRrFmA=;
 b=OaBbhNSoRIdEFA5r0T40Zb5X45XaWx/5GD0CarNeJ+GS2BgJ3Mu4t9dSDcYlvm7qNi
 wumPPMZAOz6N18GPSYvtyba/wXNOEx+L0wFp5mLP3Y6r06hBBDHcZbYubrCtQ2uZ82AS
 aWwZx8iJ8E0RDBuzdnGONPER1RAWaHkTE2ZDCg2jgZu7ofv/YP11fVtNojRxPoc/w3DN
 72ztZtGit4J1EXtBBTjWSvXadiVTkrByl3ztRIbJIjN9buqvIZtWzvpkPsArE9qqBQ5+
 eceezhF5DhkLA6xp4SZqTlPR1wSlxsnuvmk/GtI/fwC3vtc/PhKL0sSyUKh6NNmTWDgk
 pBsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRKdLqaihrqmvpZeeFnCC/1yq9rVyoqG0U80TPHORSdMpNLJjzduuWAdBieUrgBZ1DK7b2tqjNIfo=@nongnu.org,
 AJvYcCVnJgwaggm/W1QLimechR17bft7uvLqawbbpdg1fb4Tl7x8nhGQIdxBnlgNjSeqT5bC6A17C9JgK+TN@nongnu.org
X-Gm-Message-State: AOJu0Yxs1aeCxvEJglQMsA2KYTn7zOKbUc3Yx6cjprTG0jqHkEgvsnk3
 WdXs5Yc5XTLehCTRV6Jg+ido4VJQ/aR+AK2gZ7lZPAIVwNFayShtYvbyjQ==
X-Gm-Gg: ASbGnctCCwRp8PKyBJ/cP6WVMMYH04KVEW1Llrw2B+6PbE6/2uLx7kZKUurBkGY19ve
 kdlfLMyc6A8//gH3M4a+VUBn2cC7VgeZdH9rH9KhbKhx45oOboja3EjmUWHstdtEb88hm4x1nVb
 h/qojZa2h2D2xPo0LM+ZwuXT+/p5QR85llTv6NSNGODheTLGb3/JlY3pp9v0Pm2QiUCkZ94Uk4K
 VtUgqrvooEDxeBGDs82+A0unzPbIKSDeNX0hbbLRBzKD7qiB9jfudxCyuZPDfsfuD/86JIMI06Z
 8FkKgwuKcRHbhn4QVQ==
X-Google-Smtp-Source: AGHT+IEe07o0LaDW/EAoTzlWD8DS6ndtTWdDzErtncPmzJ1FMzd2IqgK5wg7aVNUhTmz1+exxhTB9g==
X-Received: by 2002:a05:6a20:12c5:b0:1ee:7d91:59bd with SMTP id
 adf61e73a8af0-1f10ae2e106mr9242976637.31.1740619266605; 
 Wed, 26 Feb 2025 17:21:06 -0800 (PST)
Received: from localhost ([1.146.90.134]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-734a003dd31sm241225b3a.152.2025.02.26.17.21.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Feb 2025 17:21:06 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 27 Feb 2025 11:21:01 +1000
Message-Id: <D82U15TLWUH7.2HKA1PQKQGVMM@gmail.com>
Subject: Re: [PATCH 3/4] ppc/amigaone: Add default environment
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <cover.1740243918.git.balaton@eik.bme.hu>
 <f1b53e0822111c6c557797adcc75f8d2c7eed17f.1740243918.git.balaton@eik.bme.hu>
In-Reply-To: <f1b53e0822111c6c557797adcc75f8d2c7eed17f.1740243918.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sun Feb 23, 2025 at 3:52 AM AEST, BALATON Zoltan wrote:
> Initialise empty NVRAM with default values. This also enables IDE UDMA
> mode in AmigaOS that is faster but has to be enabled in environment
> due to problems with real hardware but that does not affect emulation
> so we can use faster defaults here.

So this overwrites a blank NVRAM file. Okay I suppose if that works.
You could have a property to supply the default environment
alternatively. Anywhere to document this behaviour for users?

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  hw/ppc/amigaone.c | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/hw/ppc/amigaone.c b/hw/ppc/amigaone.c
> index 5273543460..35e4075cc3 100644
> --- a/hw/ppc/amigaone.c
> +++ b/hw/ppc/amigaone.c
> @@ -52,6 +52,28 @@ static const char dummy_fw[] =3D {
>  #define NVRAM_ADDR 0xfd0e0000
>  #define NVRAM_SIZE (4 * KiB)
> =20
> +static char default_env[] =3D
> +    "baudrate=3D115200\0"
> +    "stdout=3Dvga\0"
> +    "stdin=3Dps2kbd\0"
> +    "bootcmd=3Dboota; menu; run menuboot_cmd\0"
> +    "boot1=3Dide\0"
> +    "boot2=3Dcdrom\0"
> +    "boota_timeout=3D3\0"
> +    "ide_doreset=3Don\0"
> +    "pci_irqa=3D9\0"
> +    "pci_irqa_select=3Dlevel\0"
> +    "pci_irqb=3D10\0"
> +    "pci_irqb_select=3Dlevel\0"
> +    "pci_irqc=3D11\0"
> +    "pci_irqc_select=3Dlevel\0"
> +    "pci_irqd=3D7\0"
> +    "pci_irqd_select=3Dlevel\0"
> +    "a1ide_irq=3D1111\0"
> +    "a1ide_xfer=3DFFFF\0";
> +#define CRC32_DEFAULT_ENV 0xb5548481
> +#define CRC32_ALL_ZEROS   0x603b0489
> +
>  #define TYPE_A1_NVRAM "a1-nvram"
>  OBJECT_DECLARE_SIMPLE_TYPE(A1NVRAMState, A1_NVRAM)
> =20
> @@ -97,7 +119,7 @@ static void nvram_realize(DeviceState *dev, Error **er=
rp)
>  {
>      A1NVRAMState *s =3D A1_NVRAM(dev);
>      void *p;
> -    uint32_t *c;
> +    uint32_t crc, *c;
> =20
>      memory_region_init_rom_device(&s->mr, NULL, &nvram_ops, s, "nvram",
>                                    NVRAM_SIZE, &error_fatal);
> @@ -116,12 +138,25 @@ static void nvram_realize(DeviceState *dev, Error *=
*errp)
>              return;
>          }
>      }
> +    crc =3D crc32(0, p + 4, NVRAM_SIZE - 4);
> +    if (crc =3D=3D CRC32_ALL_ZEROS) { /* If env is uninitialized set def=
ault */
> +        *c =3D cpu_to_be32(CRC32_DEFAULT_ENV);
> +        /* Also copies terminating \0 as env is terminated by \0\0 */
> +        memcpy(p + 4, default_env, sizeof(default_env));
> +        if (s->blk) {
> +            blk_pwrite(s->blk, 0, sizeof(crc) + sizeof(default_env), p, =
0);
> +        }
> +        return;
> +    }
>      if (*c =3D=3D 0) {
>          *c =3D cpu_to_be32(crc32(0, p + 4, NVRAM_SIZE - 4));
>          if (s->blk) {
>              blk_pwrite(s->blk, 0, 4, p, 0);
>          }
>      }
> +    if (be32_to_cpu(*c) !=3D crc) {
> +        warn_report("NVRAM checksum mismatch");
> +    }

Maybe the default environment should be set if there is no CRC? If there
is a CRC already then that seems to indicate a valid rom file was
supplied and user wanted it blank.

This can also be rewritten:

    crc =3D crc32(0, p + 4, NVRAM_SIZE - 4);
    if (crc =3D=3D CRC32_ALL_ZEROS) { /* If env is uninitialized set defaul=
t */
        /* Also copies terminating \0 as env is terminated by \0\0 */
        memcpy(p + 4, default_env, sizeof(default_env));
        crc =3D CRC32_DEFAULT_ENV;
    }
    if (*c =3D=3D 0) {
        *c =3D cpu_to_be32(crc);
        if (s->blk) {
            blk_pwrite(s->blk, 0, 4, p, 0);
        }
    } else if (be32_to_cpu(*c) !=3D crc) {
        warn_report("NVRAM checksum mismatch");
    }

Thanks,
Nick

