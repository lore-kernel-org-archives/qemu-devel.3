Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD6BCD6E5D
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:09:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUa73-0008Mk-5S; Tue, 02 Jun 2026 21:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa70-0008Ll-M1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:09:39 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wUa6y-0001pV-QI
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 21:09:38 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68c76fb8009so6141368a12.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 18:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780448975; cv=none;
 d=google.com; s=arc-20240605;
 b=PZOjIvzup1FDlyIKvz/A11y1i8eBC/Ow0naa86MEo2vLQQm2krCnwXL3sbat5XidpU
 3t+mG6bXPQdUK4jgMbu14+O+oJtOTs+r3n41EbLXpV8tzfqAyC7P48vQKDjckyKjjZ+3
 AnU6JcfBp1Uggb/9tyPuPjus/HNofLP5tec4yjshRZZSUH5o/zpN2an5jv9d8QODtOWT
 2GrdZf7hNKyJCvasB0yItAEpQv1jvEcz35aHFnkdRikwsPaO1fqDQeyUesXlpYWv2wUF
 tVqZgVogeU4n5Mr+WoxQIHb+og4ikyL3AqiFZ0QA8ddlIDyWbGExEUZvApKl6X6ao4z2
 XuwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=asX/jlK2MpSy5TTgDNXQTB+D6EQc+kkLKSHrwBhWD4M=;
 fh=k3Oi1QkC/LYAWO4sYyWsSJqpucM7NqN2w32n6uOa00I=;
 b=G/XLrzIElJi1pWAIsPmveqaYtF35vdqUvkYwBOWRqsG0gC/9sSsIiOSs5Kv7Bn5xAw
 yiTpnu08j4xA7whIJz6Y3OhPO0rtqYRpukkgDW+U5b4mG37H0U/+fTdYNzDGPApi78+L
 auWV3jTScdP8UulleIQtYV51U6voNqBGiBkzl79Xp6a6ND4oKDNNH6Dm8yOAJt+Hxg+J
 IWWMqU8ovp335gMZOKQ5QOB481cj71ukCW0zR2QEUNHCMXBwuS2O6XRTi7+vUaIV2bqT
 wAZ2bcFegaMytMh0qdj87bsNo+qO0DfiyEIk3qt2Ll7hGXv0yj7+a7PHymavWlnP7MMg
 eunA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780448975; x=1781053775; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=asX/jlK2MpSy5TTgDNXQTB+D6EQc+kkLKSHrwBhWD4M=;
 b=MJ1HLA0VXEa05zqWW6KRUcyY/4t3AnT+lj2SMtVEThZvVIe/NGkb/z+YO2CKpXoRmQ
 cO8H6HQogeqIfBdrFEoI07qCb8JWsYd8EDkYtgcr4JW7iFlD5VO/Ar5ReQKatr9cscEO
 XwtU+55DJszguHmNhypJNRv7QVq/dfAqucANbczNfn8Kq/aFW9K90YlTjuJNBeQiZYb+
 chWL86i5cPBLEUoSdXMJocFogG50UuL4cOrdUvaNb7E2GOkOemCSJ868ZoroMWIH/Wmr
 /Mi8m9PrJSvcmhoInU48yrONsSVfINyyxtZ4Thv6I93m+vaVBeGuBp6fHWDlfY/rCXoK
 VPKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780448975; x=1781053775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=asX/jlK2MpSy5TTgDNXQTB+D6EQc+kkLKSHrwBhWD4M=;
 b=DarFTTTHCw5lCx0FGBJJsI+PNLpMrhfmWrbcqs/wUedmOwlFFQbHsuMNH7JcFvdAwB
 E7FYNNQdlwgtG570XWU1oSTvtWjIkWfUbbMLWxVa21D3sCfaFuafKT8bZag7rSNTGlim
 SNSNkEX2kHKUgcDZREdjuTY6Zn23MVqRH/gorO2RrzRV5JB7NXjHZntAQno737tK0Icc
 iQ6nuRqtTlR5sH4tHs8sEN64Z4O3jFrryAFdtXlt/oVNvAdU60bs/XNcU3lcujqBnKHL
 +Er5ejToA9+xnM0DJOqWiKvlOqzrs64rl3jLf8nmvg0Vg9TnnY7Ax4/9C4uptGrPpdxU
 iKNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8L/5iwwONGnPURLzItB3iIBKJHHAONzYFKCAm0147Icesg+s8LG03pjni1GzX1rDU/a2B7RdFAQWJ5@nongnu.org
X-Gm-Message-State: AOJu0YzOp5qWx2DjGp5RWK8HjFI0Ce/k4moQCHC7rvlUjju40lfwCk1m
 GhFLCVj1Xh0dAs8ptG3cqgM3BwFpyZmiVNOnic+t9givrXWWpzFIK5d1mkMaw2yOlOCxmyj91O+
 zmy4BUZ/5EfBRtckbMufOnxqSZy+GN4o=
X-Gm-Gg: Acq92OEsfZWdEetkELqBA6esnmQylIo04Z+owGlp3vb9iqvvHUiId/u1rZusXWW2rWA
 SBm4dPRRsJhR87mwuRRn8eZrmhipsfP7XaleTfmPfmYWR8tXkyFFBMcFQpiilZ620I6+rF37iVm
 6DpGbfJ4TlaIs9LLaKsC/IpcGMNig+ZWyUQkA4pDmyXI2N83OnJi82Ueb3l3D3K7iuvhYEZUo7F
 xtODIqIGLOqgk+imSzJIejo2lk9uWJuE/Im5ySBPzof5LU5mEWNitu4Drf/MmJcd7yi8F7ZDOq3
 IKq2GXkbI5N13DrMQ9ciXj37u7nzIDop/uJXff/TRMUqScxTlN7tSiIlWNM=
X-Received: by 2002:a17:907:c289:b0:bee:19d0:dba0 with SMTP id
 a640c23a62f3a-bf0af9fcd20mr34074466b.48.1780448974845; Tue, 02 Jun 2026
 18:09:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260529181848378wiq8pXCmbwAZR5_-wZFJd@zte.com.cn>
In-Reply-To: <20260529181848378wiq8pXCmbwAZR5_-wZFJd@zte.com.cn>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jun 2026 11:09:08 +1000
X-Gm-Features: AVHnY4Io5xrVgkyHpA6D0d47Ye-m3XMTu9rBJ8oZEHP6VsrR057aT7_qFOhzez4
Message-ID: <CAKmqyKPY6Q6J62jfv-CG6yPFysCHU7Ds1gYCGW0z0GUKPuJAjA@mail.gmail.com>
Subject: Re: [PATCH] hw/riscv/numa.c: Supplement cpu topology arguments
To: liu.xuemei1@zte.com.cn
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com, 
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com, 
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x533.google.com
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

On Fri, May 29, 2026 at 8:19=E2=80=AFPM <liu.xuemei1@zte.com.cn> wrote:
>
> From: Xuemei Liu <liu.xuemei1@zte.com.cn>
>
> Supplement RISC-V cpu topology arguments, including support socket
> cluster and threads per core.
>
> Signed-off-by: Xuemei Liu <liu.xuemei1@zte.com.cn>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/numa.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/hw/riscv/numa.c b/hw/riscv/numa.c
> index 24a803f7fa..8a144925c1 100644
> --- a/hw/riscv/numa.c
> +++ b/hw/riscv/numa.c
> @@ -239,8 +239,18 @@ const CPUArchIdList *riscv_numa_possible_cpu_arch_id=
s(MachineState *ms)
>      for (n =3D 0; n < ms->possible_cpus->len; n++) {
>          ms->possible_cpus->cpus[n].type =3D ms->cpu_type;
>          ms->possible_cpus->cpus[n].arch_id =3D n;
> +        ms->possible_cpus->cpus[n].props.has_socket_id =3D true;
> +        ms->possible_cpus->cpus[n].props.socket_id =3D
> +            n / (ms->smp.clusters * ms->smp.cores * ms->smp.threads);
> +        ms->possible_cpus->cpus[n].props.has_cluster_id =3D true;
> +        ms->possible_cpus->cpus[n].props.cluster_id =3D
> +            (n / (ms->smp.cores * ms->smp.threads)) % ms->smp.clusters;
>          ms->possible_cpus->cpus[n].props.has_core_id =3D true;
> -        ms->possible_cpus->cpus[n].props.core_id =3D n;
> +        ms->possible_cpus->cpus[n].props.core_id =3D
> +            (n / ms->smp.threads) % ms->smp.cores;
> +        ms->possible_cpus->cpus[n].props.has_thread_id =3D true;
> +        ms->possible_cpus->cpus[n].props.thread_id =3D
> +            n % ms->smp.threads;
>      }
>
>      return ms->possible_cpus;
> --
> 2.27.0
>

