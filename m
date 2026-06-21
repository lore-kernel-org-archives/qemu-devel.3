Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 145CBCDB466
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2026 23:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbS3w-00028z-Ev; Sun, 21 Jun 2026 19:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbS3u-00020T-QB
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 19:58:50 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wbS3t-0005DR-4W
 for qemu-devel@nongnu.org; Sun, 21 Jun 2026 19:58:50 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-6977c0814d1so2079110a12.2
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2026 16:58:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782086328; cv=none;
 d=google.com; s=arc-20240605;
 b=TpfQj4aXI4yN/GZl0/2R2WIm5WqAJSTXJ2/GriMNFEjRwNzXm/PrWbNSxOGL/W9qh6
 4z73RHuvd9qy828jcindHMBWK0J0Kzd2+EHe4lP0Vex1nr1PwTn5iLPKk5ORnatfvzAe
 5m8ftaXwjJsd/LUzVkgob6cQ3a3WKG5kEcKPJGfFZ7w2Av0P3/sBipql9TvzgGQLcF43
 eysKVRUgneu9CUVQ+yXHEYcYr5oA2ANrohkxp58tSoRu/JqiulPJBl5e+VDkW4Ca7LfG
 Gh+WI5MwQSiRrM1qKWKQFi7ZyiuSuO1YciC7gJfeGw8Yot08tWqK28mAA4VXnlOwSbA/
 DVHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=EHPFtTicEuji0gMbdV8rYpEMYYOEvStiQqxpsqp7OnM=;
 fh=Wkh/EGY2fhY8I4RJE7wtkqnlY/FHDB70ZZfYyC89E48=;
 b=l1DX7svzIuddqLBqjA3sNGfjvHpgbHGTieVoqfi2SfGDyduJxJAZqnRM5unR6mdMys
 gSWcj4Wbe8gRBspW/ruqnVtiEWHxh0SmyMo4d13cSd2tErvGxAv47fvYqpDeXRyUFfRb
 HE/dkia2dwcKuc227ssALX32bU40uwjCIxCp8eK3OhUxOVA4JPfMsaV6I3eqR07AJemU
 GBoZq0RYGnSkyj3d34ZnqqLuaEYogcQr7K1A5IKbeIArgYXiFYRSSBnQ9kU68LlrVsot
 r/aPybRpZUZZMpCmNitUOOP5Gs4O/Us6C9OXhholPKPWUlHI4k0QGHn9zaM/aNBZo/AS
 4p6Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782086327; x=1782691127; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EHPFtTicEuji0gMbdV8rYpEMYYOEvStiQqxpsqp7OnM=;
 b=LaAGizLzdayrHhGfe3mIWvjAgRNPcX7WdYDxBXW2KPmRiiu9+WvwmOOaTedpW0AF/X
 2kGdNluHez+dBSXYMT8BKW1el6gHWrViL92Q7sBxNDcNfrmtq0nk+MJNzHlHwzsbyWsL
 1W4D+uMOwDVA+DFZgXOl9y5sBjQTGutbpMOpc95CFx12dmEtyxySxNFNT3+rTTRknwm+
 VqGstFHksc6hNh9FEUiPXN+QZt9bxFFkuR4IE23aa4vWVrZ1fk7D4PCBJHQEauS/Kl6U
 rMm5OK/0t1XCjKBFA0zIoyKy4Gme8uTd4izVCOoRUu1IW7WF76CbTIWScANFmKYChvQA
 LIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782086328; x=1782691128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EHPFtTicEuji0gMbdV8rYpEMYYOEvStiQqxpsqp7OnM=;
 b=IAwMPdfpPrSDwnsD90D1nTl8gFcgNxVmU4F18geYjpKA5FprfJU9VaM4AG4eNML+wR
 B2wwQR6GAheT4vxvxcR2couYUKhcifK4pqeeU/O/o27ZoSIuOmkUdmxqXsIxcy0dk8mD
 IENBwWLoGX5M5x7j98+25HjmJ3morXXXssoaOXcz8kFc0qFmIcbBpkGnp3FRvI50uy2L
 N5uXfV69kzHQv+w97umoQJzMqae/mmt2EYkS2fhgmQqJmQvXlYwFGZ/5QxM4i/wtZBUA
 FqbhIVeiOrPz1Y+CRME2HiuVuykQy/zDD54JzO0bnb9SzvSJQ9aalZICSUas30cGBTLj
 dQZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+d3R+q0S0xQ+j/nE4AhA2kyY3HJyLmZXWhWRGBMofOohxhTVu00OjGctGnqyPoxxML+5yZWCtQgntf@nongnu.org
X-Gm-Message-State: AOJu0YzKdqwt4d9avk//bnoaRRl2RdpbFxVTd5wjvD/SHJ4XB7g5nBH2
 /5z/bxM9cIVZ0RebGkO0dpHC4fSf6gm/Ygtem6tLgjnQZcdE7eX/1gscj2v45lNZqqfSuLSvPyd
 Ef9d15JD93GaGJrTku1Y0KUBENTv8VeM=
X-Gm-Gg: AfdE7cnKEri/j/REUayyQYjO8jZbgHQULdERRSfwpC9VbCFaiLqAdU2C1cDKsiwmb4r
 z3pVfioW8cENEuaV6PzVDZ+UtxxTXwocHxbuMXLspkZlkKcRBYjOuc0BpOJ8/pT1K7WLjk0Bg0j
 NLe8wMn0h4EApYHjr4wNYVgXA0Ql/8BgFAs3lf6v7tftlqONh+cIjYI9oA0SA4TzLw2llzm6rNx
 CRSd5l7NaBf3ZLRaypxaUCKBujcvdksCANMzyoR24lRTjzZn/A6ib/7nTlo9CODDo1eLmfa4srN
 wN4mGeZrw9gsrqdphXClDSQlX54=
X-Received: by 2002:a05:6402:254c:b0:697:833b:8463 with SMTP id
 4fb4d7f45d1cf-697833b86e3mr2374559a12.2.1782086327401; Sun, 21 Jun 2026
 16:58:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260617054034.1020724-1-joel@jms.id.au>
 <20260617054034.1020724-4-joel@jms.id.au>
In-Reply-To: <20260617054034.1020724-4-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 22 Jun 2026 09:58:21 +1000
X-Gm-Features: AVVi8Cd5G5tpCXRPfl3wKhUjTuWteCkBv-QD1TjOQWiOTaIwPzTX0s2ej6cAOvU
Message-ID: <CAKmqyKOnPotfp4HPx9gFmRPRbvH=vnjvacwoaA_qOH=aUj9dSg@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/functional/riscv64: Add virt machine AIA boot
 test
To: Joel Stanley <joel@jms.id.au>
Cc: alistair.francis@wdc.com, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>, qemu-riscv@nongnu.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x535.google.com
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

On Wed, Jun 17, 2026 at 3:42=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> Add coverage of the riscv64 virt machine's Advanced Interrupt
> Architecture models. With this the APLIC and IMSIC models are used by
> Linux, catching regressions.
>
> This test requires a kernel >=3D 6.10, as AIA drivers were added to Linux
> in 6.10.
>
> Boot time is ~5s on a laptop.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  tests/functional/riscv64/test_tuxrun.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/r=
iscv64/test_tuxrun.py
> index 43d1242be52b..6203a45060ce 100755
> --- a/tests/functional/riscv64/test_tuxrun.py
> +++ b/tests/functional/riscv64/test_tuxrun.py
> @@ -41,6 +41,13 @@ def test_riscv64_maxcpu(self):
>          self.common_tuxrun(kernel_asset=3Dself.ASSET_RISCV64_KERNEL,
>                             rootfs_asset=3Dself.ASSET_RISCV64_ROOTFS)
>
> +    def test_riscv64_aia(self):
> +        self.set_machine('virt')
> +        self.vm.set_machine('virt,aia=3Daplic-imsic')
> +        self.cpu=3D'max'
> +        self.common_tuxrun(kernel_asset=3Dself.ASSET_RISCV64_KERNEL,
> +                           rootfs_asset=3Dself.ASSET_RISCV64_ROOTFS)
> +
>      def test_riscv64_rv32(self):
>          self.set_machine('virt')
>          self.cpu=3D'rv32'
> --
> 2.47.3
>
>

