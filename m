Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85196C0218F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 02:30:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1temCw-0008GT-2A; Sun, 02 Feb 2025 21:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temCq-0008Ff-Dc; Sun, 02 Feb 2025 21:29:00 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1temCp-0002es-0p; Sun, 02 Feb 2025 21:29:00 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-85c15e283bfso640707241.2; 
 Sun, 02 Feb 2025 18:28:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738549737; x=1739154537; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GQrs8KogOLSPUMPC2bs2fsqqPmv23pp5gJG8zczWqWM=;
 b=V6MtkX3td17LdqU4MbdY5U7ekA64a7k+3C9inNtVodoFeU5MLTIxrBU7cbsbqnwHKr
 JN/XVQcv0J1IenY55G8V9o13ajylLxYJ+YT5dv9cDz68ivzOdmgtVDMA+9Av5abSfN/d
 8qqIX+RTm2hdO0EXW04M8RAurHZM/94B9UtYmi7/xyHtckJI8IXxdQdmOHRgGQ9g7Mqv
 2r3rDzooY7uC9wDyPcm7NTJ/SksyGHDhRgBPaCt7Ig5yY0CdGsPFLeCQy1POOSwkgFN5
 /kJ3UFOuZgAAo9T11ANqASUBaNPX5vogPbU+Lmiro8EZpYXKbPg6DzBGc0Tv9bmIJKdQ
 6Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738549737; x=1739154537;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GQrs8KogOLSPUMPC2bs2fsqqPmv23pp5gJG8zczWqWM=;
 b=wz4+LV9Wdt9l594fGYSNr99u/Mii64UgKu26Iwrz9BidnCY9e0Ehflu74V9HrgrbiX
 AZ4h34Yvq5UkY1HqWO+1MFsRp/bOYy+llr5WgKRsNN0K/Y148MkY3DfoI3zY0L4JFLwC
 QEHptByFxC/HJox6lLD9KMRcG9hN615g9w+HNLXGLd4U7ltWoc6kOvJxgR9i20wf/RvE
 hXcAG3ErGygZ9FlJ7fRFZqee7cIONIxj6Q4351ARxSfbpdc1mgAUMxT7QbEkL+IvUo7+
 P6gmN1vLVLt3Lhy6yPBpyw3wHQ8Tga9xqYZLSjIdhZSqnV98d15U1NHWLIiVF4yo2qUZ
 oyww==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVb1DuGkWPH6b+a2roVi1ZSrVcqzZabTgNM6s27vfBoXNobgT/Tr53IiV3iRs4dzNq6kPAiMTNiYbh@nongnu.org
X-Gm-Message-State: AOJu0YyN6AFSHS/VXylyscADEa4rhjEvtiSOzg/f5PyvbPCPzfC333in
 n5DJxl4FL6G6P2lQfAv5Rghfi7xRwDIrejIo/OZ7i7PNCO2ch52M3/uK+Zf+jJM/XVUZDhKEgUd
 /75saqGxSZTKI+153Mp65iysh0x0=
X-Gm-Gg: ASbGncvXe65p51X6J84awV5U7mYcQeep+w0H3uZw0BBfa3IEJE14zWYYM/5RKM2i/QV
 7Wu+w8RAvThC2hEg+1fNiB5OcdtQY65IiWV6KFeYLWWEFvV/BGmlkKaEZg0+rUP7d4Ebo8SBveo
 1XnL3yaVXcQcPR0FOD3oOH2yZsFA==
X-Google-Smtp-Source: AGHT+IEubHI9wnZNHLxlNNEhb6H0yBCDnud594AOy3/UrcH+7FPhu5zCTSoEgdhYgr7Z64UHEm5tlXcC2or9oQzv1Ss=
X-Received: by 2002:a05:6102:3ece:b0:4b0:49ba:8278 with SMTP id
 ada2fe7eead31-4b9a52719damr14208694137.25.1738549737603; Sun, 02 Feb 2025
 18:28:57 -0800 (PST)
MIME-Version: 1.0
References: <173699827608.29706.6576459159016491419-0@git.sr.ht>
In-Reply-To: <173699827608.29706.6576459159016491419-0@git.sr.ht>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 3 Feb 2025 12:28:31 +1000
X-Gm-Features: AWEUYZk68EPL79M3tcSehO9naOz9y22o4txkIdMN7591KxzPJzXox-kbX6oqrdU
Message-ID: <CAKmqyKMAcurRwWmbDPD2SwqmaG9qTiZWfkbnuJnH4BBDXD8L6w@mail.gmail.com>
Subject: Re: [PATCH qemu] target/riscv: Check ext_zca for misaligned return
 address of mret/sret.
To: "~yuming" <yumin686@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Thu, Jan 16, 2025 at 1:32=E2=80=AFPM ~yuming <yuming@git.sr.ht> wrote:
>
> From: Yu-Ming Chang <yumin686@andestech.com>
>
> Only check misa.C will cause issues when ext_zca is enabled without
> misa.C being set. For example, only enable ext_zce.

Thanks for the patch!

I'm not clear what the problem is and what this commit fixes. Do you
mind updating this to clearly describe what you are fixing?

>
> Signed-off-by: Yu-Ming Chang <yumin686@andestech.com>
> ---
>  target/riscv/op_helper.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index eddedacf4b..891002f954 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -269,8 +269,10 @@ target_ulong helper_sret(CPURISCVState *env)
>      }
>
>      target_ulong retpc =3D env->sepc;
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +    if (!riscv_has_ext(env, RVC) && !env_archcpu(env)->cfg.ext_zca) {

I think you can just check ext_zca, as misa.C enables ext_zca

Alistair

> +        if ((retpc & 0x3) !=3D 0) {
> +            riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC()=
);
> +        }
>      }
>
>      if (get_field(env->mstatus, MSTATUS_TSR) && !(env->priv >=3D PRV_M))=
 {
> @@ -328,8 +330,10 @@ target_ulong helper_mret(CPURISCVState *env)
>      }
>
>      target_ulong retpc =3D env->mepc;
> -    if (!riscv_has_ext(env, RVC) && (retpc & 0x3)) {
> -        riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC());
> +    if (!riscv_has_ext(env, RVC) && !env_archcpu(env)->cfg.ext_zca) {
> +        if ((retpc & 0x3) !=3D 0) {
> +            riscv_raise_exception(env, RISCV_EXCP_INST_ADDR_MIS, GETPC()=
);
> +        }
>      }
>
>      uint64_t mstatus =3D env->mstatus;
> --
> 2.45.2
>

