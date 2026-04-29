Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C75FF8867
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:27:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wI40C-0008J1-Aw; Wed, 29 Apr 2026 08:26:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wI40A-0008Ia-S5
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:26:50 -0400
Received: from mail-yx1-xb131.google.com ([2607:f8b0:4864:20::b131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wI409-0003W4-3o
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 08:26:50 -0400
Received: by mail-yx1-xb131.google.com with SMTP id
 956f58d0204a3-65c0bda7cc4so73259d50.1
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 05:26:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777465607; cv=none;
 d=google.com; s=arc-20240605;
 b=CCn67COhRZ69d2rWKPG4L+1ic+rVgoBKZghMwZMjYt2F2km/FjFmIiwkpaQevKlrfO
 UE2u/UGj3GiSlns67Bx7OmNkGIutulRRuUwDsaO6TEczlKPqp5HKSwTq2Ad2I7Ne7b4W
 YXLxGn+2tsCSmjJNPM2BdtPliMITVaWr8KgLvv2IFqrq2SRM9kq2ImaWNydZu7Q6DMtM
 fdbwvwob+TRF83mBXRPRh4O2yuu2ho7SOsMZmyXKj2knhuheswJTIWpprw+Mm4bElN8/
 iSDX+FPaYT1aoOyPSANqiwEd6Ri9LqhWkb2R/as7Blw3O9x0l7YUdTvC8mc+aZvtpXGT
 hgZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EwGdksgi20BRYKCVCuNf0F+Y5NNX3iBGHIlo8Hqvv+Y=;
 fh=JBfI+04RMrp2AInPQ6otKgawYEzW5V/CT6AwJoD2GBw=;
 b=eKUw6hue5snB0rgUdgsTkPgOLS1iUF7dYRMnvFnWumj0XaAcaUqTxUx52lL3FK+cpF
 B4U0WEatvzorwsMErAcOyeB5h5YbYkYa9nGmsxXjXNv5xC8IN0IJ/CgHXE7YZbsZ+ciw
 XtXtsADSRqiNZEL7I1T5rHZ/oW9ub5E4BxO64ngz5B7C7xBRHiqia1m85QQgPUTUojt1
 X3X1QL0NBk+emgWON+OkbYfhSMY++pvesDpghBaHqiAxS4HhBWp6mQ7BP/HezbVnBqKs
 lvFBH+Huv3vZYxV1AvAg7BsZ0/afpMZkfnL3rCIz3FtJ18WNwDhegI80dFs4K+ydDxMX
 reOQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777465607; x=1778070407; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EwGdksgi20BRYKCVCuNf0F+Y5NNX3iBGHIlo8Hqvv+Y=;
 b=p1/r/kkmtqIYXxBIVAe1EwAN9wEbXNXWXKrhWQs+b1ssY1kzWnrXWVCYWr/ndo2A51
 Fja0wTtkWMbhjPhxc3dRdM8h9VlKW96mahBcG6Ix0XBvC+9705jgF37OY2XI3HFdCj0o
 C11Jx7qZtEVnKJTs0PKs54ysV1S6eVk4OBiSPDfjrZrSqYE+qn58wOn++jL2+jlnLR8i
 dSNDPSnBPbnlNDEjSMrJvZd1RmHeQ5LYsmsVymq7Fg2K0huTQtX/QtvvOHaUnGWKsKB/
 KCa3x8WJv/4SuTNDCOSHJjP+AluQ24pi+ISpK4pdX7FxmvaCVkwk0LDTU33ZrA/HlOox
 yisQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777465607; x=1778070407;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EwGdksgi20BRYKCVCuNf0F+Y5NNX3iBGHIlo8Hqvv+Y=;
 b=gjAStQipzeOgeTiwts31raSnSzcejSEP/6ncJsRCRppeYx/t3qk+DOf2LXjQHWzJzR
 ZDU3pRKb9UzwtjdJ4tqh8JP4JaPwlLrzMJk7mJO5KPs+QWFNeRiBHO9xF4Vl46O3w3HM
 bIIKFGY5zWQ8sKKThlL5KqGhlVtyb3WnyKRyBO9Jv5K9Tyz3QkmyFz/13NougGqFpoxj
 UFIppLpNj5yDQ7cW8AW71TouXePKCNhW4RpOvIt0HL4pg2cHUIycdN8m0yZfBwa1pzvA
 jZ91auW9PE9D9wKruvXhRDIjxIy9k1dTvJeGISiEDaiDM9mNyNk7TNdKOCSZM+ZP/klO
 pdZg==
X-Gm-Message-State: AOJu0YyGeHCH90vpzvhAch4oLQw0xFFF27WnM1YYWMdNxhlD+KL5r4VP
 4w5OhvnQXizAOXqzLm12xxbD+vKNom2y/mtOsIwvCaVYW1gjnSh2CKd0pP8g8U4rxWtdb/FXN68
 vhCDTP0Rnum4dNBamOhQ/i/nF1GTbG3zLLyAhpwMH1A==
X-Gm-Gg: AeBDietVno2aaU3QPr9As+xI/jkkUMomffGISZI1fjI7z1H4DcOmxd5Sw0mF801HRHb
 6G7FQgdFqiCzeU00csk4oJztwNrUqad1yrmTqrDGwouVw2PRN/3JMMg0kcQRw8pQbkaHFNHzll0
 GWjt5zMJHIQNunegM7RR6xoy0y7Hg2RSdjvKWyte1zbirHN6OS6M0rkq6gLvt9NFVTGp6+PJhuz
 JhgI24TmsY03/nnf1tw9NOI+zvTXW0tSWYEMCUL/ACObwv8CocxaEdg4RNyyPmJMBkBLnDMka/P
 O0eLBFq96Ple9O95Y9o5W4A1IqusLAOX7tI7LKrpiDG/wzFic4qljPY8iOY8nryTdIBlesw2n1H
 brw==
X-Received: by 2002:a53:e1f9:0:b0:650:88fa:f716 with SMTP id
 956f58d0204a3-65bfb893165mr2750693d50.65.1777465607457; Wed, 29 Apr 2026
 05:26:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
 <20260428093339.2087081-3-peter.maydell@linaro.org>
 <22ce7f65-39ee-45cb-a021-ac275d036f38@linaro.org>
In-Reply-To: <22ce7f65-39ee-45cb-a021-ac275d036f38@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Apr 2026 13:26:36 +0100
X-Gm-Features: AVHnY4JVCX6KjxR99iaIxZWBDvVmLgSRQLNyiwHMWrkbUUU8yGX0gEHpw0qFbTI
Message-ID: <CAFEAcA8SpD+X0kLg-6kQ+TR2VSJqhtMpzQrfsOqEZE_EzfkW3Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/npcm7xx_fiu: Specify .impl for
 npcm7xx_fiu_flash_ops
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>, 
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Wed, 29 Apr 2026 at 08:38, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> On 28/4/26 11:33, Peter Maydell wrote:
> > Currently npcm7xx_fiu_flash_ops provides no .impl substruct; this
> > means that it gets the default of "implements 1, 2 and 4 byte aligned
> > accesses".  This is more constrained than the device permits in its
> > .valid substruct, and also narrower than the functions are written to
> > handle.
> >
> > Add a .impl substruct matching the .valid substruct; this means that
> > all guest accesses are handled directly by the read and write
> > functions, and are never synthesized by the memory subsystem
> > performing multiple accesses to the device (which would not behave
> > correctly, as these read and write fucntions have side effects).
>
> Typo "functions".
>
> >
> > Based-on-a-patch-by: CJ Chen <cjchen@igel.co.jp>
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >   hw/ssi/npcm7xx_fiu.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> >
> > diff --git a/hw/ssi/npcm7xx_fiu.c b/hw/ssi/npcm7xx_fiu.c
> > index 02707de350..2d5bed005a 100644
> > --- a/hw/ssi/npcm7xx_fiu.c
> > +++ b/hw/ssi/npcm7xx_fiu.c
> > @@ -250,6 +250,11 @@ static const MemoryRegionOps npcm7xx_fiu_flash_ops=
 =3D {
> >       .read =3D npcm7xx_fiu_flash_read,
> >       .write =3D npcm7xx_fiu_flash_write,
> >       .endianness =3D DEVICE_LITTLE_ENDIAN,
> > +    .impl =3D {
> > +        .min_access_size =3D 1,
> > +        .max_access_size =3D 8,
>
> IMO this device should be adapted to have byte granularity ops handlers,
> thus .max_access_size =3D 1.

Looking at the implementation that doesn't look like it
would be possible. The implementation does operations
to start an SSI transfer, then transfers the number
of bytes written. That makes "guest does an 8 byte
write" different from "guest does 8 separate byte writes",
and so the read/write fns need to really handle all
the possible access sizes.

thanks
-- PMM

