Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29439C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 00:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wdzkZ-000580-Ef; Sun, 28 Jun 2026 20:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzkX-00057q-9L
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:21:21 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wdzkV-00015W-PQ
 for qemu-devel@nongnu.org; Sun, 28 Jun 2026 20:21:21 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-697cee2eb6dso2591575a12.0
 for <qemu-devel@nongnu.org>; Sun, 28 Jun 2026 17:21:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782692478; cv=none;
 d=google.com; s=arc-20260327;
 b=fBlcypu1/1bzGdxAPHFt4Up0aocojyi8f79agaZDMgMT2M+cACjrH2NbviJw/tSvhh
 FTKQzx6hyXp3A/l10Hkuj/w4Kh+GOf9q0DkTfx1uWP+43pjY5KsGlxNwCccznT9r4Lml
 /hk3sLuCBO29BDPBW58dRo5OF9Zq9Ls5qkz1HyWatmt0mOWIjikGY5JHYRkejJafmPyI
 zlt9p3qIgkvbMVRgLxx/XvUI0i9IMCOwxeIrwbcLMOGbQ0YcVbhrQJX5qTztQXwOVZsC
 X60rgjN0DUbIYKNW9Z7bYi2U5TrarUoR2j/U2poIjVmUPxXYtW3umqDt6qrSYTjOwH/v
 juGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=qFC1ISKzTT56hm33utME5mbmIaNnqQUMoJvtsmsg8sg=;
 fh=KLHGcCjDFE8JakAsekM1idRm6q0Xvx801j4ETmug+Fk=;
 b=EUV5SuKWpfNJVTZbfkZmEtfUCtX6aPFVCyuCTE6RQBAtqUVMOmnp4aO/auoUfBcNXH
 4HzC+ow/IE4snFLBvx97bLj7cZWdtgSHg6k7/+CW3pS3L6KBYUZwJgue09NRU3NmmxqA
 Fd7aBFLmub02YwnYP8qjmi3BfKYwkOARTVwXJXDUxlu3AUsYdT6UHYWMmaiwfXKfFULd
 4477ddf92VblbmIIMoJC/tzRoADnv4xtdiTE60TWlYJwxE6HbAC8bcBwF94pzan175NS
 WN3BuWPCVCKiLpFKhVRQKFyWliB5gV304XtncsrCQJ1DsWRE8gTKXWXMG7ANvBSzaESq
 G/HA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782692478; x=1783297278; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFC1ISKzTT56hm33utME5mbmIaNnqQUMoJvtsmsg8sg=;
 b=Prujzd3ikbJT/TNUoodqc7ThrNqcpumZjb1zijaAppswVc/BllmNmgKl8QY98FGt0O
 Vi9Vy4jlNPtC4Ehf3TImwfTj875c4QdOC+xwyt+/JrvbT04FJRIBZD5BWPgVjlHR0Hwc
 dPRH1Oz/mGM7fQ4O/gCcUgt6FF5V9+CJDZSYLehP713Gr5D+KCODJubHQU/+keEwQcvj
 L2C/+tPJgNzOvrr0KnPEkjYc0wkKGde8U+R0LeLidlqsweVLIVDMoUvHqoakjKcTcgSH
 LG6iNyIeTl60vI3+hbb8LB8L/QX0lw5Rmg7pzLLXGNT9CWdJNgbGwqOKBnVeVRXvGdxN
 tkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782692478; x=1783297278;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qFC1ISKzTT56hm33utME5mbmIaNnqQUMoJvtsmsg8sg=;
 b=G6li5ZHGendHQZ0T3ceXQedypMYLlROQTHx3LvyzmyPAYKX92XaLyg2v4jG5iasU7H
 hDr/d6cyd3NKUg50TpXhoP78ms/NXud0YeKqaBeBvmQvEh4SxcJeU51lusqulvZ8quY+
 tKhzu2Dt+hW7I5IhloneN98LBWplMwNlih5SH8CrcWUnoBrbgOjtqz+7tGT4fir4KR6J
 jsZrJhCwMAVDi+OD6MOl3dqMA6t0iXnQ8JX4EsQy7z1fep7x8neWeVm+IqqbXcr7Sn0w
 e+NxDclls/zNvf/W5fLcZ+VhMYx8OfLVYgs9nXU6Sgc8xwZL9nDfBDWeNQbWYDP4/bjR
 nMIw==
X-Gm-Message-State: AOJu0YwRQOUcrXwM/aU+SS5FwgIAXbqw+Bu7LboUBR9t4kfz0RY7O0Vv
 SRyk4B4/7/1QHt1ZPIrM7UTOL84qwJb3VzBXAqgfJfSUEnosRCvEG3ZIxo6YoqQsK3Y+X/lVqzk
 6rjq7A7/KTivfMvOlApRnq88GSb4JhC0=
X-Gm-Gg: AfdE7cmb43QzCu3t83j6H8TIglyc/L6vZ5IILo1CUt0yDxN93cD4UqWh7iUwLJvH/R8
 sV7VgSRdEWu7EF7poj485FO1SdJxKH1X8D3wHdbIWB/JAu8nbDbKCPXYJ22pN8XH0jLWNwx8mmV
 xtpfkfbp/uiFLx+xkpsGWEkgqIif0cPV10ctdgkWqUHS5ONlBogaY1OgBl6fxqjdIanOoyutrbD
 9gUQ39GKsTiz3eBxVD9UtIsfDlnVL6FGU9XjCHMHCO4jjG+eTp3Yap4ZEmNYWVsScDOuW4ESzbs
 +QuQ3hSUWzO3nPJR2vwxNy7VDTU=
X-Received: by 2002:a05:6402:3591:b0:698:4831:f9aa with SMTP id
 4fb4d7f45d1cf-6984831fc61mr2083584a12.12.1782692477779; Sun, 28 Jun 2026
 17:21:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260626170533.3562484-1-daniel.barboza@oss.qualcomm.com>
In-Reply-To: <20260626170533.3562484-1-daniel.barboza@oss.qualcomm.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Jun 2026 10:20:51 +1000
X-Gm-Features: AVVi8Cf8T5RundNRfe2uvFPbYxXYQwT1N_H_tg_bWj8ALzpV1dBf2ae1uBkodK8
Message-ID: <CAKmqyKMjCHpPgOTBekGmk3axY2ROVX6K5oam6b4EG3zvdVJjdw@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/riscv-iommu: set cmd_ill IOFENCE.C rsvp bits are
 set
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com, 
 andrew.jones@oss.qualcomm.com, Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Sat, Jun 27, 2026 at 3:06=E2=80=AFAM Daniel Henrique Barboza
<daniel.barboza@oss.qualcomm.com> wrote:
>
> We're not setting RISCV_IOMMU_CQCSR_CMD_ILL if a reserved bit happens to
> be set in an IOFENCE.C command.
>
> Fixes: 0c54acb8243d ("hw/riscv: add RISC-V IOMMU base emulation")
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3575
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/riscv-iommu-bits.h | 1 +
>  hw/riscv/riscv-iommu.c      | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-bits.h b/hw/riscv/riscv-iommu-bits.h
> index a938fd3eb4..60256ad9b8 100644
> --- a/hw/riscv/riscv-iommu-bits.h
> +++ b/hw/riscv/riscv-iommu-bits.h
> @@ -344,6 +344,7 @@ struct riscv_iommu_command {
>  #define RISCV_IOMMU_CMD_IOFENCE_OPCODE          2
>  #define RISCV_IOMMU_CMD_IOFENCE_FUNC_C          0
>  #define RISCV_IOMMU_CMD_IOFENCE_AV      BIT_ULL(10)
> +#define RISCV_IOMMU_CMD_IOFENCE_RESERVED GENMASK_ULL(31, 14)
>  #define RISCV_IOMMU_CMD_IOFENCE_DATA    GENMASK_ULL(63, 32)
>
>  #define RISCV_IOMMU_CMD_IODIR_OPCODE            3
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index c9687e01a8..d47abf9eb3 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -1876,6 +1876,10 @@ static void riscv_iommu_process_cq_tail(RISCVIOMMU=
State *s)
>          switch (cmd_opcode) {
>          case RISCV_IOMMU_CMD(RISCV_IOMMU_CMD_IOFENCE_FUNC_C,
>                               RISCV_IOMMU_CMD_IOFENCE_OPCODE):
> +            if (cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_RESERVED) {
> +                goto cmd_ill;
> +            }
> +
>              res =3D riscv_iommu_iofence(s,
>                  cmd.dword0 & RISCV_IOMMU_CMD_IOFENCE_AV, cmd.dword1 << 2=
,
>                  get_field(cmd.dword0, RISCV_IOMMU_CMD_IOFENCE_DATA));
> --
> 2.43.0
>
>

