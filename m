Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13C85C369DC
	for <qemu-devel@archiver.kernel.org>; Thu,  1 May 2025 00:34:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAHsF-0001va-Ez; Wed, 30 Apr 2025 20:34:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHrw-0001t5-Pd; Wed, 30 Apr 2025 20:33:41 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uAHrs-00076J-8Y; Wed, 30 Apr 2025 20:33:40 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4c301b1df82so346083137.0; 
 Wed, 30 Apr 2025 17:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746059614; x=1746664414; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jsUjrD2IMjq+CO72OoPxDEvyMQ9+4C8/FPL+jaEDXdY=;
 b=YRdPCCzl5JATRS+HW7BCV/g9rjCb86b7o11SvuCV1D14ansYe8UoC8cHbqVJgBMEP3
 SNK5cghzpb3Q8nXtXowxksw2/vahEhxsMvXhsbExVX+gmPpJk1ZYC9+gDAr2Qe38bt6a
 vzfU7QNi0gZXqkeDRy+8t2D/nL7jEca8G05W6YtHqteJ7vAvUmZm0+ors+D8OI1RFK/I
 ZY9JtB/m4FmTHz83hyzlauRzgxMi/hL8wZJuB3Tblr9s5HHDBQ2EjEwI0O3sujuibo3N
 jZAcXcPRVHvBpAimNk+ldQckuj2Tt+bXjKHXWMmHHK42ZZ7S3dwVfVrTm9lP2YwNzI0r
 Cqsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746059614; x=1746664414;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jsUjrD2IMjq+CO72OoPxDEvyMQ9+4C8/FPL+jaEDXdY=;
 b=i0G1bQu3XsWU3hLmYxUa3c07mY6/EuqI8+GMJqtrs2QBGo1amuu5DbHzNgwZBlCR+/
 fo0HxzEYP6S9notRTV5aCQjZ0mtcdtxm1qWUYwdSuCk2Ul6dNCw4gyM+VlYApbhCENDF
 4PzyhXOun9jBTvExtW/lSY7q49PoyGXc1ra96y1w3sYUGZ+R7WY95akIE7GWd8o1k1JA
 cr4Rju1nn0/q+Ma/1879oVza5SDzoP2ZqtopVWDu9Kbd888s4ctqh3c8VnU6pMQEas5v
 V8lvxznpl9KJOcr9kv/xlI46g2J7S88UhvNSoFLoi2+vm4Fp7YByMPOxaucjhcwGCkQk
 Dmgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVP4zSBnwXxc3STUy6ubXxpDQ5/lH1DAGe2lybCdbAdbuvpL2OpUZ7TVcbGSLY6IgZDeNbm9Clxvgxa@nongnu.org
X-Gm-Message-State: AOJu0Ywx+YYGC85YI+bweyBjh7bGDah56vKrGoLE9gcPSnmETpvCBj8Y
 sIj5r34qcD1AalmNwxV0Xh5D9z4mbS6OwzGsLH31SIErVNgLxTS7eIjnBhk66nK7fo9OQr9CKj1
 IRZZ0Azv1AdMosCRaABnf+kgux/Y=
X-Gm-Gg: ASbGnctPxdEKvtKSmOzRIUxlg3tKfKMba+/00fCbHQlFqK2NtDSsLpAo9mOZD+g9/IW
 CNl1m1SbTCl6NMrkWog6VhX/5zYgE+vORxV3xoSW2KbLvSqE5CwQQUjMk/y/HlFnYaQjT+/ztmh
 OD3KOAMzxpQ5IvmJEAW+sRSHHZo9WFQL9fsA2vCr0DqZaayHpaY6KT
X-Google-Smtp-Source: AGHT+IG+IRPNryZhE1KSda4EbPTbvqJ6mFJS0DV95euWqwHRNl96GJY4sdDVP5Rqauu6mZzz6xwsbEaa16cxxnIQxfg=
X-Received: by 2002:a05:6102:5093:b0:4bb:dc3c:1b47 with SMTP id
 ada2fe7eead31-4dae91a2802mr315082137.14.1746059614624; Wed, 30 Apr 2025
 17:33:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250429125811.224803-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250429125811.224803-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 1 May 2025 10:33:08 +1000
X-Gm-Features: ATxdqUEyRgXtWEHc_cTTOyrDprFKM6CstQYqX4KoLslo457KOL7uj7OszVzyRHo
Message-ID: <CAKmqyKOc+X4ZgPq3SDfUEKPGksOJaaC8UfbrnqNptFv+yv2AmA@mail.gmail.com>
Subject: Re: [PATCH v2 0/9] hw/riscv/virt.c: memmap usage cleanup
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com, 
 joel@jms.id.au
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Tue, Apr 29, 2025 at 11:00=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> In this new version a small change was made in patch 9 after
> discussions with Joel during v1 [1]. The idea is that we want to be
> consistent (as close as we can) with the idea that a
> memory address is a hwaddr type.
>
> This new version does not conflict with "hw/riscv/virt: device tree reg
> cleanups" from Joel [2].
>
> No other changes made. Patches based on alistair/riscv-to-apply.next.
>
> Changes from v2:
> - patch 9:
>   - in create_fdt_socket_memory(), change 'addr' to hwaddr and use the
>     HWADDR_PRIx fmt type
> - v1 link: https://lore.kernel.org/qemu-riscv/20250423110630.2249904-1-db=
arboza@ventanamicro.com/
>
> [1] https://lore.kernel.org/qemu-riscv/d404d535-fc04-43ac-a7a7-2f216cad99=
3c@ventanamicro.com/
> [2] https://lore.kernel.org/qemu-riscv/20250429061223.1457166-1-joel@jms.=
id.au/
>
> Daniel Henrique Barboza (9):
>   hw/riscv/virt.c: enforce s->memmap use in machine_init()
>   hw/riscv/virt.c: remove trivial virt_memmap references
>   hw/riscv/virt.c: use s->memmap in virt_machine_done()
>   hw/riscv/virt.c: add 'base' arg in create_fw_cfg()
>   hw/riscv/virt.c: use s->memmap in create_fdt() path
>   hw/riscv/virt.c: use s->memmap in create_fdt_sockets() path
>   hw/riscv/virt.c: use s->memmap in create_fdt_virtio()
>   hw/riscv/virt.c: use s->memmap in finalize_fdt() functions
>   hw/riscv/virt.c: remove 'long' casts in fmt strings

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/riscv/virt.c | 272 +++++++++++++++++++++++++-----------------------
>  1 file changed, 140 insertions(+), 132 deletions(-)
>
> --
> 2.49.0
>
>

