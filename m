Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D8FD6D24E
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 00:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGSa7-0007fb-Pd; Wed, 27 Nov 2024 19:40:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSa4-0007ew-E3; Wed, 27 Nov 2024 19:40:30 -0500
Received: from mail-vk1-xa29.google.com ([2607:f8b0:4864:20::a29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tGSa1-0007sN-OS; Wed, 27 Nov 2024 19:40:27 -0500
Received: by mail-vk1-xa29.google.com with SMTP id
 71dfb90a1353d-5152a869d10so71428e0c.1; 
 Wed, 27 Nov 2024 16:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732754422; x=1733359222; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Iwt0TIftE7hHQhgSHrRx4NcDQXYm/L1bkrRSUMG1jwM=;
 b=CTb1BLhkMH9oDnQ6d8Z0uMTMf7htU478DZUpmnAtdW7abADt4kAnYZGlKmW26sMK8N
 pNZOLY6hzS8Y/YrpHWTIulWOFGKMSK7uXeu9UcG7mk0piUSm7ND07R2m+ElTHpXSoWY4
 BWv12MQM4ml4uxcf4ZUDlOH+eZnIl/eo/S5gcqhzfOoI3PY3T8LCeuir1GOM/1JpBNDN
 fmGQuAioYpREsfo/mkzLonjpHEwK3EgpHOxJDdw5WWuye70V9iYQsDw9uETnN+w2nyzW
 ZYQ1dbS2yEl9H4GvVG/o9H9r51AxWDA30u+aGRRKFJV+LfLLBXHbqZBLkHPZfhR+NbDu
 yEyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732754422; x=1733359222;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Iwt0TIftE7hHQhgSHrRx4NcDQXYm/L1bkrRSUMG1jwM=;
 b=r9cWdP+lwg277lZmnDMEJ+kGxFNUDwdSPtURf5GrhwPdUstvZXORglAnmKamg8Pfu2
 WozRaNMsWsckAamFOCVYb0bvaPlKVSg3C8S0OC764abcSmiz+DTcwGUkFKwGnuCUyuz7
 FkGiXSwHAQvRzxRKJpU2T8EEwEAWwKGDqhS0T6rYdpzU/Y7lKkFMyYylGovk3zurp2sL
 /yo1AgqbQgIJ0LQWTOVvKwFR2V9D4bXsBcE9M7eKn5DGLHMHo+8eaw0l5q2wjtbO5SbV
 +e6lfYnFPe5gmVTPWEKQgOPZTnRWopkPQZZSRCLKqqaPRR3/Ahg5NfsU3y0lNx2wxGBx
 8qAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpLDdybOIZ8vmtJrL9o5OLUfYs3T6q7tLZMpZX2ATfW6VEKz37ZsGLZVl/94vt2Zpn46BW/zjeoUah@nongnu.org
X-Gm-Message-State: AOJu0Yz9iGANbxwpyKGSMk0jGsUYZOy7JzH69L9QCEX9Q/nJ675jUx/7
 RQQ7tmI7mfAMzQCJmi+gWdCYFlQ/CP/Fy8HPqfkFR5ZfM73PnP9pjNJLOeJCq4tCZuuNJSYnZ2l
 hv7FuMgEvZQWqfSt9PKh8BAeEDBc=
X-Gm-Gg: ASbGncsk1xCJ5UI8E6QY0+thjrjRTGmlMt7eUgYD/2lfEx9gC6vZaqzuyI18kJFX5xk
 A5fj4Ao5GfnAkiSTonnZBTWa7b25+RqjgiVhpMLJWs7haIl1PuAmnn8AiaVENSw==
X-Google-Smtp-Source: AGHT+IGOi4hTeeZlj8pjoc6uosljdkvJ5ZcyvwCTlIBipfeoQ0SIoL7GsSB2NLbaR97i7nB8tKlOxWNFEkYPDq6Qv90=
X-Received: by 2002:a05:6102:c4e:b0:4af:396f:6a07 with SMTP id
 ada2fe7eead31-4af449cd734mr7110105137.27.1732754422203; Wed, 27 Nov 2024
 16:40:22 -0800 (PST)
MIME-Version: 1.0
References: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
In-Reply-To: <tencent_6FF30F7E2E640BEE260FD6523B6BA5486908@qq.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 28 Nov 2024 10:39:56 +1000
Message-ID: <CAKmqyKMP093GyTEHdAPzaV9+O_pFSv0svQRb-31QTvn9i4fxMA@mail.gmail.com>
Subject: Re: [PATCH] include virtualization mode as part of priv
To: Yanfeng <yfliu2008@qq.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a29;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa29.google.com
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

On Thu, Nov 28, 2024 at 12:09=E2=80=AFAM Yanfeng <yfliu2008@qq.com> wrote:
>
>
> When debugging hypervisor extension based programs, it is convenient to s=
ee the
> current virtualization mode from GDB debugger.
>
> This patch shares the virtualization mode as part of the existing "priv" =
virtual
> register, or more specifically via bit(8).

Interesting concept. This seems fine to me, I don't think this will
break any existing user.

Another option though is to add a "virt" virtual register, which might
be easier for people to figure out as it isn't obvious from GDB what
bit 8 means. That might be a better approach as then it's really clear
what the register means.

>
>
> >From 0d82561b11e1c2835f14ba5460cfff52f0087530 Mon Sep 17 00:00:00 2001
> From: Yanfeng Liu <yfliu2008@qq.com>
> Date: Mon, 18 Nov 2024 08:03:15 +0800
> Subject: [PATCH] riscv/gdb: share virt mode via priv register

It seems like something strange happened when you submitted the patch.
Can you fix this up?

Alistair

>
> This shares virtualization mode together with privilege mode
> via the `priv` virtual register over the debug interface.
>
> Check logs with gdb-multiarch 12.1:
>
> ```
> (gdb) info registers priv
> priv           0x101    prv:1 [Supervisor]
> (gdb) set $priv =3D 1
> (gdb) info registers priv
> priv           0x1      prv:1 [Supervisor]
> (gdb) set $priv =3D 0x101
> (gdb) info registers priv
> priv           0x101    prv:1 [Supervisor]
> (gdb)
> ```
>
> Signed-off-by: Yanfeng Liu <yfliu2008@qq.com>
> ---
>  target/riscv/cpu_bits.h |  4 ++++
>  target/riscv/gdbstub.c  | 15 +++++++++++++--
>  2 files changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index 385a2c67c2..cc6dece51a 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -623,6 +623,10 @@ typedef enum {
>  #define PRV_RESERVED 2
>  #define PRV_M 3
>
> +/* Share virtualization mode as part of priv register */
> +#define PRV_V                (1 << 8)
> +
> +
>  /* RV32 satp CSR field masks */
>  #define SATP32_MODE         0x80000000
>  #define SATP32_ASID         0x7fc00000
> diff --git a/target/riscv/gdbstub.c b/target/riscv/gdbstub.c
> index c07df972f1..d9e6ad969a 100644
> --- a/target/riscv/gdbstub.c
> +++ b/target/riscv/gdbstub.c
> @@ -212,8 +212,14 @@ static int riscv_gdb_get_virtual(CPUState *cs, GByte=
Array
> *buf, int n)
>  #else
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
> +        target_ulong ret =3D env->priv;
>
> -        return gdb_get_regl(buf, env->priv);
> +        /* include virtualization mode */
> +
> +        if (env->virt_enabled) {
> +            ret |=3D PRV_V;
> +        }
> +        return gdb_get_regl(buf, ret);
>  #endif
>      }
>      return 0;
> @@ -225,11 +231,16 @@ static int riscv_gdb_set_virtual(CPUState *cs, uint=
8_t
> *mem_buf, int n)
>  #ifndef CONFIG_USER_ONLY
>          RISCVCPU *cpu =3D RISCV_CPU(cs);
>          CPURISCVState *env =3D &cpu->env;
> +        target_ulong val =3D ldtul_p(mem_buf);
>
> -        env->priv =3D ldtul_p(mem_buf) & 0x3;
> +        env->priv =3D val & 0x3;
>          if (env->priv =3D=3D PRV_RESERVED) {
>              env->priv =3D PRV_S;
>          }
> +
> +        /* Update virtualization mode */
> +
> +        env->virt_enabled =3D (env->priv !=3D PRV_M && (val & PRV_V) !=
=3D 0);
>  #endif
>          return sizeof(target_ulong);
>      }
> --
> 2.34.1
>
>
>
>

