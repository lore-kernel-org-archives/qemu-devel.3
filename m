Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B511CD128A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Apr 2024 12:36:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtoD5-0003Sy-Jt; Mon, 08 Apr 2024 08:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtoD4-0003R3-1d
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:34:50 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rtoD2-000107-4B
 for qemu-devel@nongnu.org; Mon, 08 Apr 2024 08:34:49 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a465ddc2c09so319403266b.2
 for <qemu-devel@nongnu.org>; Mon, 08 Apr 2024 05:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712579686; x=1713184486; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BzPjv6vqB+aWT+1biYRyUqqq3Ix5mQTZo8VHosWhuMU=;
 b=rohyCchvhbdWPoT5RQNI28WW4DB9sSfbXClNpRr+vIaB8pJsl1MzgZIChu21mLrEyU
 tOpkOJxH5B2ka+7PCgvvNsb0amDW1t21Y8FsqO2IG6UX+ReOuYhuFfiehtkNlxzvUwDL
 alRZU7OAU5Iwda3vfI2dtlKwKlnRWtVhSGtLoFMyo+mHOFGAQSAE/DSlDWwvMMn8hTAx
 s9nf9BJcYGfL9NvkQOYJmxCLPTkU3YqTFZxktxPV/vlSmH2Mkx1CSfH8wYS8kzWD/pAs
 PeOsxXUSzUbyn9O4tnZ7LJRJ8dDJpV3odmzrnarImKI5MKnRS3JXMXhdHgq4NPVvrK1Z
 W64w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712579686; x=1713184486;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BzPjv6vqB+aWT+1biYRyUqqq3Ix5mQTZo8VHosWhuMU=;
 b=gbLkg38CNppdMwSGFh6ouUXQok8F2WdGfLKZnqOQywAn+3bhM+yyhu+bfye5LJK4Zg
 ZVPco8zWfljKA6dIBJGL8o5j1hmuuxU9Ni0Lk/GPnowffBse+t3ruXjVerM+1Amek72J
 NWghOqFoRsY0U/shV2koBgqOYjBDFYMOz6m3UALfPb+Eoh6Iqxw42iluj8t6HcgE0gwG
 X6G+YdpHS6XKI3JBBcrWFBPDUcYDDc8lp2BAKIMkB7ewx/sl0IyBde/7FXjdDGF6/gfd
 bI72dy8ZdFXTNR/mzhHchmGxaoa+LYDgn4YSghwEqDVh5i4hYLXRbbc/s5aBvfoJNa28
 3Vmw==
X-Gm-Message-State: AOJu0YzTaKYw/nqxsHOPcSmcqBYmcJdYmCE/wNEjNDwNtJJwTstp5wHJ
 6d5OYnPVpkqqKfb+rdR4Kk3ccECQ2Q6D/Vg+eShI+VUytY4O2pvy679f83QvmGpYJvCJy0F5edx
 XjewtneuSX7EXo/NmvOpDE/VPzurd0em8b1Ueyw==
X-Google-Smtp-Source: AGHT+IHd5D7hQCyvjhX293eV5kwoJlEfjPuRvRUgJwuRTDi0Hdi0MIMCyIo12u1In1UrK407EeMzvuiNAH891d+uJdk=
X-Received: by 2002:a50:d653:0:b0:56e:2d93:3f7f with SMTP id
 c19-20020a50d653000000b0056e2d933f7fmr8387893edj.39.1712579685990; Mon, 08
 Apr 2024 05:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240404085549.16987-1-philmd@linaro.org>
In-Reply-To: <20240404085549.16987-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Apr 2024 13:34:34 +0100
Message-ID: <CAFEAcA-nrJc_WqTgw2uugqKoOdfoF8-NiKwftZczk38_XR5_CQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.0] hw/sd/sdhci: Discard excess of data written to
 Buffer Data Port register
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Bin Meng <bin.meng@windriver.com>, Mauro Matteo Cascella <mcascell@redhat.com>,
 qemu-stable@nongnu.org, 
 Alexander Bulekov <alxndr@bu.edu>, Chuhong Yuan <hslester96@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x630.google.com
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

On Thu, 4 Apr 2024 at 09:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> Per "SD Host Controller Standard Specification Version 3.00":
>
>   * 1.7 Buffer Control
>
>   - 1.7.1 Control of Buffer Pointer
>
>     (3) Buffer Control with Block Size
>
>     In case of write operation, the buffer accumulates the data
>     written through the Buffer Data Port register. When the buffer
>     pointer reaches the block size, Buffer Write Enable in the
>     Present State register changes 1 to 0. It means no more data
>     can be written to the buffer. Excess data of the last write is
>     ignored. For example, if just lower 2 bytes data can be written
>     to the buffer and a 32-bit (4-byte) block of data is written to
>     the Buffer Data Port register, the lower 2 bytes of data is
>     written to the buffer and the upper 2 bytes is ignored.
>
> Discard the excess of data to avoid overflow reported by fuzzer:
>
>   $ cat << EOF | qemu-system-i386 \
>                      -display none -nodefaults \
>                      -machine accel=3Dqtest -m 512M \
>                      -device sdhci-pci,sd-spec-version=3D3 \
>                      -device sd-card,drive=3Dmydrive \
>                      -drive if=3Dnone,index=3D0,file=3Dnull-co://,format=
=3Draw,id=3Dmydrive -nographic \
>                      -qtest stdio
>   outl 0xcf8 0x80001013
>   outl 0xcfc 0x91
>   outl 0xcf8 0x80001001
>   outl 0xcfc 0x06000000
>   write 0x9100002c 0x1 0x05
>   write 0x91000058 0x1 0x16
>   write 0x91000005 0x1 0x04
>   write 0x91000028 0x1 0x08
>   write 0x16 0x1 0x21
>   write 0x19 0x1 0x20
>   write 0x9100000c 0x1 0x01
>   write 0x9100000e 0x1 0x20
>   write 0x9100000f 0x1 0x00
>   write 0x9100000c 0x1 0x00
>   write 0x91000020 0x1 0x00
>   EOF

> diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
> index c5e0bc018b..2dd88fa139 100644
> --- a/hw/sd/sdhci.c
> +++ b/hw/sd/sdhci.c
> @@ -552,7 +552,7 @@ static void sdhci_write_block_to_card(SDHCIState *s)
>   * register */
>  static void sdhci_write_dataport(SDHCIState *s, uint32_t value, unsigned=
 size)
>  {
> -    unsigned i;
> +    unsigned i, available;
>
>      /* Check that there is free space left in a buffer */
>      if (!(s->prnsts & SDHC_SPACE_AVAILABLE)) {
> @@ -560,6 +560,14 @@ static void sdhci_write_dataport(SDHCIState *s, uint=
32_t value, unsigned size)
>          return;
>      }
>
> +    available =3D s->buf_maxsz - s->data_count;
> +    if (size > available) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "SDHC buffer data full (size: %"P=
RIu32")"
> +                                       " discarding %u byte%s\n",
> +                                       s->buf_maxsz, size - available,
> +                                       size - available > 1 ? "s" : "");
> +        size =3D available; /* Excess data of the last write is ignored.=
 */
> +    }
>      for (i =3D 0; i < size; i++) {
>          s->fifo_buffer[s->data_count] =3D value & 0xFF;
>          s->data_count++;

So, this will definitely avoid the buffer overrun, and the
quoted text also suggests that we should not be doing the
"if sdhci_write_block_to_card() writes the data then keep
going with the rest of the bytes in the value for the start
of the new block". (With this change we could move the
"if (s->data_count >=3D (s->blksize & BLOCK_SIZE_MASK)) ..."
out of the for() loop and down to the bottom of the function.)

But I'm not sure it fixes the underlying cause of the problem,
because the repro case isn't writing a multi-byte value, it's
only writing a single byte.

It looks from the code like if there's no space in the
buffer then SDHC_SPACE_AVAILABLE should be clear in the
present-status register, but that has somehow got out of sync.
The way the repro from the fuzzer toggles the device in and
out of DMA mode looks suspicious about how that out-of-sync
situation might have come about.

thanks
-- PMM

