Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C61C36002
	for <qemu-devel@archiver.kernel.org>; Sun,  6 Apr 2025 23:23:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u1ZKt-0006Og-47; Sun, 06 Apr 2025 19:23:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZKr-0006Nz-HI; Sun, 06 Apr 2025 19:23:29 -0400
Received: from mail-vk1-xa2b.google.com ([2607:f8b0:4864:20::a2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1u1ZKp-0002Gd-KG; Sun, 06 Apr 2025 19:23:29 -0400
Received: by mail-vk1-xa2b.google.com with SMTP id
 71dfb90a1353d-5240a432462so3371640e0c.1; 
 Sun, 06 Apr 2025 16:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743981805; x=1744586605; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Hr9EMx8U3JNlx7/IJ5QZ/XgLO/Ufvgly9fazfM9uO3o=;
 b=G8F5PZ4HI4Nc1Vf6ZjsbLAaPhUhfQqbTIUo3nfVA3j3IUh0IY5FR3U6c+c4lOMB7KT
 TB9wlLxxODizRutFgimNGo4qR7gsCQViFO4YeCzNljnHNJVd9hZYa33qDh3NSIkE651g
 CJIQNaCMR32qxSoOiygfKgZRWLaI23XwJv9+qTUgwHoGYGkeOaNUNRMkRJAq/WwFoRLU
 Q8HWDR+0warbmIwnqswY6Zxhy66IcKCAFO3a+soW1MEn6xZrlI93clcXK4C30PuCnuXo
 FkzSlE7VVvarWOdTCr9Rik5ffXFmP9aSay8zcxkT7Y3GpSwp4+UMQQnOmau/ymv00qVA
 fswA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743981805; x=1744586605;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Hr9EMx8U3JNlx7/IJ5QZ/XgLO/Ufvgly9fazfM9uO3o=;
 b=AEkhVMbKOT1TQeawtt0Qsr5zha0YDma1Qq2lmHfXcstAsYbGA5HpPKu8gUpvYCUV7o
 9StaW7ztsSXBOCkZFkZ6HLVHQYIxp0vmg9ui7PtXaNv8L5X4kwkcJhe0LDSvZgYHPEYW
 LznJEl4ZaWd7O7JFgExAgFg08v/a9o2DyCBAA0jayju0lr0nC4aQjiQcp646A3EF3nM4
 F7X8JiXUkgjeCWXInS38ba/OUnuTMNtkYZrR3e3ubdMsKK2sPHpU/yLpTQq4Wh7zkunk
 bUjmSeqaVISo37YPS5UrNhO3OhZ3vzZInNzqPUiZu1iFkAE+DjPF07IAxDkOYWtYJADl
 4THg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsuZwKZHkp38m44j3Ov4f4cU+bWfmpJ9AY2GV+Ow+eAyOGUdQQmoEhLAb36zPFmS5ZkXtN+8BXOPP7@nongnu.org
X-Gm-Message-State: AOJu0YwACkiOneNn2ExbwVpOGhzwPq+zpLNpSpziP0h9FaJNlLSHzuJt
 g3Rlrh4kEsleJm0x7WhuAnl+9YXD054HEjCyaiZd6dd47AGpu3q/GMtC4Jy9ov4QvsNX6jo8KVQ
 XzNIV+xlbwgiFQG4A9Tbg6+v/rbc=
X-Gm-Gg: ASbGncvAxy8ewO704D4S14IjgKYX1B/u2ZAZYYtwY1FkG1DPODFSh8kLgjUf/EtgAeh
 KRPn9WBsB7MnVG65FX7NaczhEFFf1b6Vkv5RG3OTkqwRhRyaNWMm4uel5ChY93Xfzu+Lmb/qqmW
 mdRqIDqk526lUUCQwsRrVe8JzhUZsEk2oNfE1jOQJNPdYMTFX196ODvNwPDweG9spBtEE=
X-Google-Smtp-Source: AGHT+IEqS5/dJcZGOHV6XXjYU6rBjc+NuB2D4bd50NcDq/wzIoDZ49FWA/5CUbvPFMpYG69UfGFUk4abuTqI5bf0uN0=
X-Received: by 2002:a05:6122:1c87:b0:523:e4c6:dddb with SMTP id
 71dfb90a1353d-527568cf121mr11239634e0c.0.1743981804966; Sun, 06 Apr 2025
 16:23:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250404122858.241598-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250404122858.241598-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 7 Apr 2025 09:22:58 +1000
X-Gm-Features: ATxdqUGt94DOF2yYri1Pw6lKv899od1QVQ54ik3wRAyCyixDjYWcqC_FFFQ6l1E
Message-ID: <CAKmqyKOkCLLENZfdfCrNPsjrQq5WbBz6vgFs=-92zMn_du3iig@mail.gmail.com>
Subject: Re: [PATCH for-10.0] docs: deprecate RISC-V default machine option
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2b;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2b.google.com
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

On Fri, Apr 4, 2025 at 10:30=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit 5b4beba124 ("RISC-V Spike Machines") added the Spike machine and
> made it default for qemu-system-riscv32/64. It was the first RISC-V
> machine added in QEMU so setting it as default was sensible.
>
> Today we have 7 riscv64 and 6 riscv32 machines and having 'spike' as
> default machine is not intuitive. For example, [1] is a bug that was
> opened with the 'virt' board in mind, but given that the user didn't
> pass a '-machine' option, the user was using 'spike' without knowing.
>
> Being explicit in the command line is desirable when we have a handful
> of boards available, so deprecate the default machine setting from
> RISC-V.
>
> [1] https://gitlab.com/qemu-project/qemu/-/issues/2467
>
> Suggested-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  docs/about/deprecated.rst | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 76291fdfd6..0f41a99c67 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -304,6 +304,23 @@ online to check that this board did not completely b=
itrot yet). It is
>  recommended to use another MIPS machine for future MIPS code development
>  instead.
>
> +RISC-V default machine option (since 10.0)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +RISC-V defines ``spike`` as the default machine if no machine option is
> +given in the command line.  This happens because ``spike`` is the first
> +RISC-V machine implemented in QEMU and setting it as default was
> +convenient at that time.  Now we have 7 riscv64 and 6 riscv32 machines
> +and having ``spike`` as a default is no longer justified.  This default
> +will also promote situations where users think they're running ``virt``
> +(the most used RISC-V machine type in 10.0) when in fact they're
> +running ``spike``.
> +
> +Removing the default machine option forces users to always set the machi=
ne
> +they want to use and avoids confusion.  Existing users of the ``spike``
> +machine must ensure that they're setting the ``spike`` machine in the
> +command line (``-M spike``).
> +
>
>  Backend options
>  ---------------
> --
> 2.49.0
>
>

