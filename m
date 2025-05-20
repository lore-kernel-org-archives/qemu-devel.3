Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF9BCC54754
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 01:11:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHBV9-0000Hh-KG; Mon, 19 May 2025 21:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHBV5-0000G2-UH; Mon, 19 May 2025 21:10:38 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uHBV3-0007d1-83; Mon, 19 May 2025 21:10:35 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-72ecc30903cso3058266a34.0; 
 Mon, 19 May 2025 18:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747703431; x=1748308231; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xuQoaZP8vmcl5+94rrQWrkGLXx0fS7PXsVxqfyIzJ70=;
 b=IttXkl+aPlbijPF6PqChfPDZDn4ToMuegzgE1+fY9hsmBYE8vO9uia6xR7BsFIqgSC
 myLOwgqjYUTRWZSiSNn4t5BfnoQlaWfkAxX+3LZDAGEQ3H6bwJGcwXcPVcQWuqF41IP6
 3J1Q6/PUTobnfrGMdDHv4W5+AxgLSNrf/it/7VxfBUO6Tg2VYOTG8KCSnujR5JNHQJxh
 tvSq+/Jc8znSOQeP3Y+W0nmK3E+mmi0wyc2VRn+64+FBRTsmZtJxEb9E5otV936+lBSy
 x6K9Dv7Q1fLnwrZ5tfGwEyvYhJ7RByBx1koHhx9X4M79OHAa+S7H1yTNDs+VTicaNvO+
 yP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747703431; x=1748308231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xuQoaZP8vmcl5+94rrQWrkGLXx0fS7PXsVxqfyIzJ70=;
 b=EFHP/ETxAymABRzHPORgV4TOd2++6eosV5mosMX8UcxqoFyFcc5CcfTyDY8US3J+0n
 YUA/AIZlFd8Gflrqrr+I+Ibf/nTX45nhbbssGP8hhnNv14yX9ujJ846K3wtcEL5PjBlw
 eEjvvBFeqZyN/D/43IYFnC1JIbyl8eK+4IETS9qD22XIRweiGKh7FMJa43myHU1mBq4q
 5IjvBSskjc6KzMfUkIcV0XxIwjXB+VHoIsA1G4TbH4DsKxUNVwzVGxtqwmlPT6ps4Shu
 nhPNsMfRVe4uvOOMb4TkX2hEU6VbMLnHyk/dgL1VTy00kEmZJs2O4h9e7v06BG/T1oOA
 0CFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUz+R+4OoAPYFiYWCPC9lDQI4TpoKn/GVHL+c9IK8PiMgBtk7YlFjaeYpNrI//tKiz6cepzouuWoQ2U@nongnu.org
X-Gm-Message-State: AOJu0YxhqdYStLiZaO9v1sdSeFrxCDjhSpI5izuAKIJ01C9jvJ1d9HcO
 vKIuMfjD3lP3S9KZ6F3sPZtHHyGoIeihMeJTizTILavNsW9yGq7gZeTjz+ufR9q/2rGk6BKDgd+
 Chc4kA+6ZozqNYbUdyAi9xvOB0+W3fYVeDQ==
X-Gm-Gg: ASbGnctL9/PbRyrjkbwRyww5PJu6YiX/CpkcXx0uY7q0VAh/pQNTXYHlwzDKFzBe8Z7
 Ch02s375g67S+D71z5sShDtK5Jxsj9BjvvYlifmR4cWRgDEUs8BQt0c6F2spYEtQ+WYbVFGlTpF
 6nEup3thtGgV0EalLF19phwmIsgHlTvo6YbnG0lBMYQuItcWDOcSqc19risofmGyc=
X-Google-Smtp-Source: AGHT+IEEkKiHTx8H7q3gj/z9tuOZD2L+gxct5gIL4E0SF8v6SVm8s28q2mX5PRRjTQr+/P02IjLYPguDBb8blwXmrcs=
X-Received: by 2002:a05:6122:46a7:b0:52a:863f:78dd with SMTP id
 71dfb90a1353d-52dba91e5a2mr14558774e0c.6.1747702636527; Mon, 19 May 2025
 17:57:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250519143518.11086-1-jim.shu@sifive.com>
In-Reply-To: <20250519143518.11086-1-jim.shu@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 20 May 2025 10:56:50 +1000
X-Gm-Features: AX0GCFskRlFZGyLXdHImqcd7hZdbj2rFA2LKqjYeldkCbuPXtVY4jSuUmGf7sGo
Message-ID: <CAKmqyKNB52uxCKhXE_k1B55z9P8iHGt5vFkFC2_Zy0j7zrmjbg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Several sstc extension fixes
To: Jim Shu <jim.shu@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::32c;
 envelope-from=alistair23@gmail.com; helo=mail-ot1-x32c.google.com
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

On Tue, May 20, 2025 at 12:36=E2=80=AFAM Jim Shu <jim.shu@sifive.com> wrote=
:
>
> This patch series contains several sstc fixes:
>
> (1) Writing to ACLINT mtime should also update the period of S/VS-mode
>     timer, just like M-mode timer.
> (2) VSTIP bit of $mip CSR should check both M-mode and H-mode STCE.
> (3) Writing to STCE bit may enable/disable sstc extension in S/VS-mode,
>     which should update the timer and IRQ pending bits.
>
> Changed in v3:
> - Rebase to riscv-to-apply.next
>
> Changed in v2:
> - Remove duplicated code in riscv_timer_stce_changed() function
> - Add sstc spec description in the commit log
>
> Jim Shu (4):
>   target/riscv: Add the checking into stimecmp write function.
>   hw/intc: riscv_aclint: Fix mtime write for sstc extension
>   target/riscv: Fix VSTIP bit in sstc extension.
>   target/riscv: Enable/Disable S/VS-mode Timer when STCE bit is changed

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  hw/intc/riscv_aclint.c     |  5 +++
>  target/riscv/csr.c         | 55 +++++++++++++++++++++++++++++++-
>  target/riscv/time_helper.c | 65 ++++++++++++++++++++++++++++++++++++--
>  target/riscv/time_helper.h |  1 +
>  4 files changed, 123 insertions(+), 3 deletions(-)
>
> --
> 2.17.1
>
>

