Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 125FFC48BEB
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 09:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1raYS8-0003cT-Kh; Thu, 15 Feb 2024 04:54:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYS5-0003Pu-FA; Thu, 15 Feb 2024 04:54:45 -0500
Received: from mail-ua1-x92a.google.com ([2607:f8b0:4864:20::92a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1raYS3-0001UL-Rg; Thu, 15 Feb 2024 04:54:45 -0500
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7d2a67daa25so429289241.0; 
 Thu, 15 Feb 2024 01:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707990882; x=1708595682; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DBdT5BqffG5DnFq9lgMYbao4Njc9Ip28TVJhmpzvVto=;
 b=DLAE0LyEPDYrd+dzlQBFSy6jwaN8Zu9mRcOnVNjU2ccjMEZNoUjjJDuQUuH5uWbhkT
 ifISO4bflY3bhhvYb14TS82Hr6+YK8AsIm4hhRav3i5MOApjU8OjZvotjdRjRx0ahBfd
 gNGYcGsdtN7FDsZsH0SwwqfTxZ8tQ8cPUZjq+yGzhlmMLpj4WWIX0b/FSYbfHSuOmepR
 bnblnUmsQt7uf88SzDDXwVTONOC5tqUtHg3TOuo814My9Auwvljn3B9NTjC2A8R0zEFf
 Rv92lg6qTjsCoEpK6utevEtmFNsMoQ/qz/hPGmvyl2UInahIBEU5Jr3kNyh+6Xrb1LgJ
 CmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707990882; x=1708595682;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=DBdT5BqffG5DnFq9lgMYbao4Njc9Ip28TVJhmpzvVto=;
 b=s31TtPWyB3rcHjmOyeApw9ZLsyAbCsR3aGwHE3a7jh2qIN/Gj/TSGkEhEGa8x3LQ0+
 Ml3rfu1sI3fY7YtH+ft0/+xj8FfZrN0pzVXm+HEfy2ZIjaVOWdWxie5tvA3ZBl2DjofX
 D3QmJwwGI2CSleFD0G+0x3vXdPYPnzc41IlQyaMPkqGsFrtB4usyUr1QLRR0ZzGodfgK
 CU1Cv6aGyt8mTBr3gQM8i/EM1uLBMmyErtHcHeSfzbmeGtPmVdUJcHsyyF3dKBdEto2N
 k/kv9Kx4bOSE27X0g5IQoRwmmvj83qUzuQGjPdTl0U4ZXXdR+2UcR89/9jZ9ypqpTv4e
 nw1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfy3sg2x2WjobKuq9fzLEl/4oexLl6g5BoKbZpQvxXFxQp65TWwTC7d0mHeAC56U01l2c8DUFMw/GtfSSYcjuTBy87wvRdeZ8GGMxQr2Otn2Tz8uTKsvK7WgYuDg==
X-Gm-Message-State: AOJu0YwDJpfoXCJQbXe3+gmOybgbrpWHCQb599pGH/S4XqcXJB2TMDqD
 mWlpZrniks4ZTti7gZQ4ztwDPMkotBMU7CtuBKVnej0PlpAo1oLQLY17aubwnDjLWa8YRKqxvV8
 Q3ttt43gaLaA37ourNRlF5nWGqz4=
X-Google-Smtp-Source: AGHT+IFQ2wq9IuILews622C8SauqEd05mzZHCeHSO+oXANfNPo0OjFMRvqaOqydaXwulpgY9op85+gLkzw49d3sv0DA=
X-Received: by 2002:a1f:df04:0:b0:4c0:240b:89de with SMTP id
 w4-20020a1fdf04000000b004c0240b89demr997930vkg.7.1707990882367; Thu, 15 Feb
 2024 01:54:42 -0800 (PST)
MIME-Version: 1.0
References: <20240206154042.514698-1-alexghiti@rivosinc.com>
In-Reply-To: <20240206154042.514698-1-alexghiti@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Feb 2024 19:54:16 +1000
Message-ID: <CAKmqyKM8ycQnpqQdr5Bv5AYUvjuiynmkwD-1L0Hp0oEktbqr2A@mail.gmail.com>
Subject: Re: [PATCH v2] hw: riscv: Allow large kernels to boot by moving the
 initrd further away in RAM
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92a;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92a.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Feb 7, 2024 at 1:42=E2=80=AFAM Alexandre Ghiti <alexghiti@rivosinc.=
com> wrote:
>
> Currently, the initrd is placed at 128MB, which overlaps with the kernel
> when it is large (for example syzbot kernels are). From the kernel side,
> there is no reason we could not push the initrd further away in memory
> to accommodate large kernels, so move the initrd at 512MB when possible.
>
> The ideal solution would have been to place the initrd based on the
> kernel size but we actually can't since the bss size is not known when
> the image is loaded by load_image_targphys_as() and the initrd would
> then overlap with this section.
>
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>
> Changes in v2:
> - Fix typos in commit log (Daniel) and title
> - Added to the commit log why using the kernel size does not work
>   (Daniel)
>
>  hw/riscv/boot.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index 0ffca05189..9a367af2fa 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -188,13 +188,13 @@ static void riscv_load_initrd(MachineState *machine=
, uint64_t kernel_entry)
>       * kernel is uncompressed it will not clobber the initrd. However
>       * on boards without much RAM we must ensure that we still leave
>       * enough room for a decent sized initrd, and on boards with large
> -     * amounts of RAM we must avoid the initrd being so far up in RAM
> -     * that it is outside lowmem and inaccessible to the kernel.
> -     * So for boards with less  than 256MB of RAM we put the initrd
> -     * halfway into RAM, and for boards with 256MB of RAM or more we put
> -     * the initrd at 128MB.
> +     * amounts of RAM, we put the initrd at 512MB to allow large kernels
> +     * to boot.
> +     * So for boards with less than 1GB of RAM we put the initrd
> +     * halfway into RAM, and for boards with 1GB of RAM or more we put
> +     * the initrd at 512MB.
>       */
> -    start =3D kernel_entry + MIN(mem_size / 2, 128 * MiB);
> +    start =3D kernel_entry + MIN(mem_size / 2, 512 * MiB);
>
>      size =3D load_ramdisk(filename, start, mem_size - start);
>      if (size =3D=3D -1) {
> --
> 2.39.2
>
>

