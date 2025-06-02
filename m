Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64FD0C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Jun 2025 06:12:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uLyOD-0007Gc-AG; Mon, 02 Jun 2025 02:11:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy5F-0002GA-97; Mon, 02 Jun 2025 01:52:07 -0400
Received: from mail-qv1-xf31.google.com ([2607:f8b0:4864:20::f31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uLy5C-00006G-6k; Mon, 02 Jun 2025 01:51:41 -0400
Received: by mail-qv1-xf31.google.com with SMTP id
 6a1803df08f44-6face367320so29315356d6.3; 
 Sun, 01 Jun 2025 22:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748843495; x=1749448295; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/PY2tyVSrVtdCJOVkgykGxb6xAi/RN7Z4HUkkStkp4w=;
 b=A/Lt/jQYUuAtUiOLnN2IPcWlmKxQ3oFUqvgYE6YzMiR/Y1iw+9arDMAhSwK84HsIDn
 ejQmTMsg4E/Mu2n/dSBgNOJ2QUQqfAY1dZboTkcaSX/phFg6hc1by7yEcBphSfSjFpVM
 JqHOsGffvhmgUds97LTE9GhofR+W8RELNuGlHpSuLH+VMQ4IPRmiv6sg7QGgrCsz/qyV
 uUmKmqgVwfIxMvkZw7p3+XXU1+OoefP5XqFnb20lDAdPPygEN3hMx0alJgUdmre7+FRr
 7ERifiqVBvgTa3TPQTAuRQZYUyPoTvEwe78WVF+7nVTdoCCv/o9EjnlhDdbavGtoLu0o
 hLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748843495; x=1749448295;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PY2tyVSrVtdCJOVkgykGxb6xAi/RN7Z4HUkkStkp4w=;
 b=ddny8X46JqCTNY8pL29tQFOw5CP4r1s2KfrxHeg0S5Fiu99cxt9t5GttsE7nziaHlr
 iTwR1/zwwmtB+eWa+dvKjGVpTRIS8ZwkSdfxlKORPdzjeXPTQz+jbHtQu+G+wXyp8JPT
 2bkbEs5voCXqUJ76b5zW8VmSWsg0xqImr24NTLBuM2NKHj/5dPeQK4s1kvjDc/+JkXfo
 v/BB1SZpfLKNUCrZ8erZ/UTZvJk9KePki+g58NjKIhUKTopXw04nVCURnY3FXz9J++qt
 1sXwqK65yekmuKGLIknp2F3LPz9A0tdqilXCQc1YnCri5r59BN8hzTlKnQwYitUotU8k
 jE1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq47h0O7iVeVrK2TThTnZqIve+A9C/P6661yosouDXZ0udsatMA03diS97cfOyypOE9VpXROoqvaf4@nongnu.org
X-Gm-Message-State: AOJu0YzULmJluvzxdNmnnMLQ0j//he2rcO0qBd5UP2G6mmZgojZhQFgv
 3p9xQ0yt0Pcd4nDYVOMnrPoi4Uyj8dkHP2ZWoTfBuRI7TMmnCLSn9hxDUGndsBnWt1UoDZJf/Ik
 mVs0nDHH8YggITEYdncLtiuyvLh/HKspwYw==
X-Gm-Gg: ASbGnctRn4iFOLnyXaD2+nBNH2y5XpO0gwEG3jU5mztJROkQbsJbtlfG2drdNjfUhW/
 kfmwnlICyJuvviRFtF9YHEaLhg5FKA7mn9H6WTYDDEDhtDReQWNID9h0x2DqHaSz21EuRltdjB0
 dgLgRxligHn5m+b8ueLnsa9iATCroSJxKmdBafQ7m92eQpT2/pzddSZO6YsXvpBRY=
X-Google-Smtp-Source: AGHT+IFh8WfbPpgZfzru18RjqPu+xNQQAVqSDc7oiPSwF+btbGEaS0qHb3dxWGvXNqIht+2MwWyYoi43/EkIlvxQLzY=
X-Received: by 2002:a05:6102:4b0a:b0:4e5:958d:4962 with SMTP id
 ada2fe7eead31-4e6ecd2e5a9mr8439215137.2.1748838700000; Sun, 01 Jun 2025
 21:31:40 -0700 (PDT)
MIME-Version: 1.0
References: <20250529202315.1684198-1-dbarboza@ventanamicro.com>
 <20250529202315.1684198-3-dbarboza@ventanamicro.com>
In-Reply-To: <20250529202315.1684198-3-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 2 Jun 2025 14:31:14 +1000
X-Gm-Features: AX0GCFuLzkNcyU3FqGbhh8GacwY72o_kiNBdoHyVq8xMelxA5syDjCLlhE8qXGA
Message-ID: <CAKmqyKPo1oH2q1vC+MQA2ce29wrMZgSo1JUEP5pzNKikLOunSg@mail.gmail.com>
Subject: Re: [qemu PATCH 2/3] target/riscv/cpu.c: add 'ssstrict' to riscv,isa
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f31;
 envelope-from=alistair23@gmail.com; helo=mail-qv1-xf31.google.com
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

On Fri, May 30, 2025 at 6:24=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> 'ssstrict' is a RVA23 profile-defined extension defined as follows:
>
> "No non-conforming extensions are present. Attempts to execute
> unimplemented opcodes or access unimplemented CSRs in the standard or
> reserved encoding spaces raises an illegal instruction exception that
> results in a contained trap to the supervisor-mode trap handler."
>
> In short, we need to throw an exception when accessing unimplemented
> CSRs or opcodes. We do that, so let's advertise it.
>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9d6fae72b2..cd0b159ed5 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -217,6 +217,7 @@ const RISCVIsaExtData isa_edata_arr[] =3D {
>      ISA_EXT_DATA_ENTRY(ssnpm, PRIV_VERSION_1_13_0, ext_ssnpm),
>      ISA_EXT_DATA_ENTRY(sspm, PRIV_VERSION_1_13_0, ext_sspm),
>      ISA_EXT_DATA_ENTRY(ssstateen, PRIV_VERSION_1_12_0, ext_ssstateen),
> +    ISA_EXT_DATA_ENTRY(ssstrict, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstc, PRIV_VERSION_1_12_0, ext_sstc),
>      ISA_EXT_DATA_ENTRY(sstvala, PRIV_VERSION_1_12_0, has_priv_1_12),
>      ISA_EXT_DATA_ENTRY(sstvecd, PRIV_VERSION_1_12_0, has_priv_1_12),
> --
> 2.49.0
>
>

