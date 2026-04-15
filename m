Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50F2F433CC
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 23:51:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDA0Q-0006Pc-0g; Wed, 15 Apr 2026 19:50:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDA0O-0006PK-8x
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:50:48 -0400
Received: from mail-yx1-xb133.google.com ([2607:f8b0:4864:20::b133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wDA0M-0000rE-Ix
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 19:50:47 -0400
Received: by mail-yx1-xb133.google.com with SMTP id
 956f58d0204a3-651c5d525f6so4174977d50.3
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 16:50:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776297045; cv=none;
 d=google.com; s=arc-20240605;
 b=HSqWvCwkK0PVH7H0dEloGoSlia8qOY0Pd827M1aGGjhqkIzQmO+8oXCvFcdk+PJw0s
 M9HQqe0PxJ61QQxY1JfYHoi3SEGLKrFlyC/5L79g2F4GwxxAz/qTdagspCydKoFtFvxI
 FmElFTU6QMjFR02X2Kgi9mt3CaEW5TJwB2esxnJXQlEHOlJ2BVJFZ8JDxu4d9vWQeKoy
 Gr3qs9qDg5Qh4jHHrEKIQK7TBWwTA9CtFsp9NI4IkSV6v9H6Zn6zfgirSIAe9jqhKG8w
 5N/F3meANcMfKrvmWl1I9sWGqA7joPFGfq+AewCz9F5yTZObG/TjFglr/4LYqZJYDhsh
 Yrxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/B7AJ0oXGJ94EUmuCAKA9MH347wZ16W29PTMRxEV2hg=;
 fh=Y7awTd27tr334JwSiN65+A/N5KCPEXhaOH9gk8oiOGI=;
 b=JgB4ShBqV08BhQ2XLqenaIcuCZeIG2mCTJCVK46zFqILNyfJI3u9D51iU342gKbKYx
 m4iQ0wqzmWLNicaKLDbM6kcfbtcLNrzDQw26kcTECjSph0SqaR7L/BvIAuNk7gw50Dpw
 WemWCT2GtRuUWz3PD4QWxipqshU4AiwsxhFObf1uhPFOolnY+7fMZoFGxdgAMEA8uXnD
 430bZCFECBysHTJp0YNB0WldmOG5Y9gOcvWu2auaX90P3a5YnTxC65yH6CCzv4xVlQBy
 IKdCBVIy6i8RzyBv28bohtik8NORWYVRopw6KgqzN2GKMGGt9WY/3D4D5qIkmS+riz0r
 neTg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776297045; x=1776901845; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/B7AJ0oXGJ94EUmuCAKA9MH347wZ16W29PTMRxEV2hg=;
 b=L/69uU3tEsUul7hkJd9jCNYtoaxC1nI5S8y5oErt3eSeFoOT7QZMyUSs/KhBQUH8XT
 8LTpEEXe0sPGg2tVg3K10zkvcvy8XDVA8SE780mYdD3Ho39Nty8RdS5HYQEf0GzLsbrp
 i+RLJAu8b0KXQffUUDeC30vBnG5+3edioRwPtX6/hVxbxeqlYXdZIx3eh8Mkn0itdm1b
 o/SsP49DhLTAzkzqYve0vrPfoNs1BiYwdTkIEIZyTgO73Uxz3ekqyi/3G9plSNFI5Pwo
 4UWP/c8WAkpqS8vRmKSmMycdEeqL1lTBlVyeX61NJuaowumH5X9ixpG47Ug787UpQaRM
 E+Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776297045; x=1776901845;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/B7AJ0oXGJ94EUmuCAKA9MH347wZ16W29PTMRxEV2hg=;
 b=b41jeqCmEBVICO5mfGNATMmu2a2TWyb19liq0SQeb1J6T5889g9OlRFfKUi4aSFKqr
 ZS6sm2n+I6fYH2VKGurgb56JYEfna3HRIbbvDeb7V2b7nrweq1yZ5F2gwuZyXr3xS/sO
 uf8PET2uRawDINNyuprdgJoadGOsz3ZYe6Zp0VA/VIkum5lRBpSByiTVOcxznHsiVafQ
 0HqyB0hDD8tPvPeNkJvOKaBMCWPyoGnbYRQz4z81wt9Uf2OOyQLYb2G7WMoDUU2qoGhZ
 p9cC/LKKT4j9eTveWT55RxcUfFZGfo4z4y+cpEPtK9jUIObX/Pcb/VaVcT0rWjsm+W8s
 Lkhg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XU5UUAnMF1yKzh94d4ukR4i9ervfiZHJgH4cNHBJgaTCot0SvgiZpminIZ6xptdHlEB8w1cxdfVml@nongnu.org
X-Gm-Message-State: AOJu0YwlS3a8mnq+MDpQwnqeNLN42ab4vyF/WyB8OjUdYHh8XuWcc+s1
 zAuNv2HeK2LY//jxkCgng2/pABqk3g2TPYQB2zGczFg4ctUoFFw02Ugp9tuIwnKq3gMZdTak00d
 rv8tjioTfpniRAN49lJiu8/fZLAt/AHc=
X-Gm-Gg: AeBDietIf/AqqcHRPnzogbWFWQigA1jBGNcOF9igMbvir6boTsKtdv1dWs2jc+3B6TJ
 WxpKF/gnyM3VtM8kuOJSBDH4Bq89+UrZrI6xyDxUDSstJmZJoiOqWC3A5bAKv9mbrvQeVHptJZi
 b/fmAnk76wtUL4hrlx9CVyGniSDgQLbZHiPJtDqM2z/51yI3wauBQnKb/cH8pTWIzeyYLPVkHLv
 vuRgProjBpIxdemdfd2KKOAmxO9wcN4yVLHu2PP8V0/5jFb9lXzsK6t+jvFNJpUGFUb0umIIMyF
 bOxhf5tIk1gTFM65Q06AvV1uEUtdN3sknl4zQA==
X-Received: by 2002:a53:d009:0:b0:651:bcbc:6e2d with SMTP id
 956f58d0204a3-651da59aafamr9349019d50.65.1776297045081; Wed, 15 Apr 2026
 16:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260415064838.652297-1-joel@jms.id.au>
 <20260415064838.652297-4-joel@jms.id.au>
In-Reply-To: <20260415064838.652297-4-joel@jms.id.au>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 16 Apr 2026 09:50:17 +1000
X-Gm-Features: AQROBzAFJT7V62D4L9yMoyMZBcFAdbjRcRFN8pPw5QV7F8ugBQHoADrgyy_7Mu0
Message-ID: <CAKmqyKOjxs5_w5durMkGyYXu6_m4cZ8B=8K=ydSi_oy+e9aKMQ@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] hw/riscv/boot: Warn if a ELF format file is loaded
 as a binary
To: Joel Stanley <joel@jms.id.au>
Cc: Alistair Francis <alistair.francis@wdc.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 qemu-devel@nongnu.org, 
 Nicholas Piggin <npiggin@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Michael Ellerman <mpe@oss.tenstorrent.com>,
 Joel Stanley <jms@oss.tenstorrent.com>, 
 Nick Piggin <npiggin@oss.tenstorrent.com>, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b133;
 envelope-from=alistair23@gmail.com; helo=mail-yx1-xb133.google.com
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

On Wed, Apr 15, 2026 at 4:50=E2=80=AFPM Joel Stanley <joel@jms.id.au> wrote=
:
>
> From: Nicholas Piggin <npiggin@gmail.com>
>
> It is possible that an ELF file can not be loaded, in that
> case the loader falls back to loading the file as a binary
> blob. Print a warning in this case because it is likely that
> it is not intended.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/boot.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
>
> diff --git a/hw/riscv/boot.c b/hw/riscv/boot.c
> index f3857e984240..3ea95c175c14 100644
> --- a/hw/riscv/boot.c
> +++ b/hw/riscv/boot.c
> @@ -179,13 +179,27 @@ hwaddr riscv_load_firmware(MachineState *machine,
>
>      g_assert(firmware_filename !=3D NULL);
>
> -    if (load_elf_ram_sym(firmware_filename, NULL, NULL, NULL,
> -                         &firmware_entry, NULL, &firmware_end, NULL,
> -                         0, EM_RISCV, 1, 0, NULL, true, sym_cb) > 0) {
> +    firmware_size =3D load_elf_ram_sym(firmware_filename, NULL, NULL, NU=
LL,
> +                                     &firmware_entry, NULL, &firmware_en=
d,
> +                                     NULL, 0, EM_RISCV, 1, 0, NULL, fals=
e,
> +                                     sym_cb);
> +    if (firmware_size > 0) {
>          *firmware_load_addr =3D firmware_entry;
>          return firmware_end;
>      }
>
> +    if (firmware_size !=3D ELF_LOAD_NOT_ELF) {
> +        /*
> +         * If the user specified an ELF format firmware that could not b=
e
> +         * loaded as an ELF, it's possible that loading it as a binary i=
s
> +         * not what was intended.
> +         */
> +        warn_report("could not load ELF format firmware '%s' (%s). "
> +                    "Attempting to load as binary.",
> +                    firmware_filename,
> +                    load_elf_strerror(firmware_size));
> +    }
> +
>      firmware_size =3D load_image_targphys_as(firmware_filename,
>                                             *firmware_load_addr,
>                                             mem_size, NULL,
> @@ -195,7 +209,8 @@ hwaddr riscv_load_firmware(MachineState *machine,
>          return *firmware_load_addr + firmware_size;
>      }
>
> -    error_report("could not load firmware '%s'", firmware_filename);
> +    error_report("could not load firmware '%s': %s", firmware_filename,
> +                 load_elf_strerror(firmware_size));
>      exit(1);
>  }
>
> --
> 2.47.3
>
>

