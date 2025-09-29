Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ED03CAC5BB
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Sep 2025 01:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v32V5-0005zs-CM; Sun, 28 Sep 2025 21:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32Uw-0005zD-Ou
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:16:18 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v32Uq-0001Yg-2B
 for qemu-devel@nongnu.org; Sun, 28 Sep 2025 21:16:14 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so800009566b.2
 for <qemu-devel@nongnu.org>; Sun, 28 Sep 2025 18:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759108562; x=1759713362; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ObILjRMrsNab+xqjpMD4f9za4qa5Rz6QLtjQRJRvq6w=;
 b=ikBMa2/t4LaXgonN0bwwd8rTySWtH9XWBIsihiS7hupa+OyRA6avq8ASHQavKdumGN
 gatbXsQ+OxAkcPuLn81ArMUIB+d5hHPBIsg/pf/DU7eJ0UQv7vg0IMIxTAdzeRGh14Vt
 1G5e0dWU+8gFyKvjVh4IoUessk38Fr2BuLPJiB4+/gCx6CCWtfQ1s/LHCw1jcHB5ICvs
 1U9RMRBAD7r0DK8PZOInVNgpqYufDQ/V/rI9gnsTnDDVK8Ye6/9gR1onSef462Agytjs
 Ekuohh7ZZSkF/P1GgKHovF2i6zKWOB6glbkQHjlNuFsWELgU53eDH5OINEvAAGcjp3wL
 Y0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759108562; x=1759713362;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ObILjRMrsNab+xqjpMD4f9za4qa5Rz6QLtjQRJRvq6w=;
 b=AxjBjc3S6d8eqU52poib/XAQCXA5VcZOdHbZ5xksNnYUGlQzSYsU9BUabpgvj35oin
 g13vwcIZ7e09RGCdjgjzZTxjfXvjGj2irLyOtGcjvgQOnBT65459IuLPAYMw9UAmgW4E
 i6YBfNjmoXBJorif9Z0bRcQgLI5IDQSSqAIuohgtSzBo3nlnyRjFo6nndOdE2ymb+52i
 ItxEtNmmhnKDrnV9o/vxeN/nCrQbRbVaT3t60CsEgogMvwSwmhboycWesrXV4ssX7YMf
 Sqo/MSeo+F3MIGMmRpFZgNNa5HEi16V5AfBvmtqOJneilV+L39C4RDoeDnwb8EALwGy3
 j7EA==
X-Gm-Message-State: AOJu0YyupD3Ef7XCtI9jV4QPy5NjxuGTj4iCQOcZs9voqgAszFwRYCpB
 FlEYz/OVD2G/EX7TmPBOaO/SiuQAGgkoFWOUFf9yMtPuoOC29ir1nknVAEY0XgKlkzDJivbg+IC
 48lyB7hM3dII9QS7ExQAavf3KhY+rf4A=
X-Gm-Gg: ASbGnctcwpXShO9dtM92gnw5TjOPbB58AQXY/BbvrIupWoBzgToiVw3w0wyXFg9rQaS
 Q6eWzyb3lFhU7g0sCtZGhTVBd9tULfTCLIMT5LDTXW+5XIQEz9idaeiSYU4b8wjlpF1b/PaaVPU
 /rPaGlb4JYQSlq3a36EiFz3VgUwxsrf8TPvRGXAJgPVxqhISqhEId7kNuWnvGWp1BFGqqfyZBQS
 cBqxYgKAN1cKMKZKUq/omiR4XB6zNaoEDTWwp1fTJF7lv0h
X-Google-Smtp-Source: AGHT+IGaeWNCtVTfkkyzRllyeKtAmhaCzW7+NvkpWEO4vFSrr7DZ4sCmR7kHRoPEcLKibu4OCNYVPYpeyJTkAbh+cI8=
X-Received: by 2002:a17:907:7e84:b0:b29:e717:f0af with SMTP id
 a640c23a62f3a-b34b9f4fc52mr1731364466b.18.1759108562396; Sun, 28 Sep 2025
 18:16:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250923090729.1887406-1-max.chou@sifive.com>
In-Reply-To: <20250923090729.1887406-1-max.chou@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 29 Sep 2025 11:15:35 +1000
X-Gm-Features: AS18NWB1D_z02BlRVKfFwTSqVahBQP2wSGktfjrAsRYstezIIsj0Nw0NKXa2gUI
Message-ID: <CAKmqyKP+Cqph7ADC+EBYgGeGtHcO2hc=JLQ_zaT-E0ffa+sT7w@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] riscv: Modify minimum VLEN rule
To: Max Chou <max.chou@sifive.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 23, 2025 at 7:09=E2=80=AFPM Max Chou <max.chou@sifive.com> wrot=
e:
>
> According to the RISC-V unprivileged specification, the VLEN should be gr=
eater
> or equal to the ELEN. This patchset provides following modifications:
>
> * Replace the checkings of standard V with the checkings of Zve32x
> * Introduces a check rule for VLEN and ELEN
> * Modifies the minimum VLEN based on the vector extensions
>
> Extension     Minimum VLEN
> V                      128
> Zve64[d|f|x]            64
> Zve32[f|x]              32
>
> v1: 20250627132156.440214-1-max.chou@sifive.com
> - Rebase to riscv-to-apply.next branch
> - Add patch 1 to replace checking RVV by checking Zve32x
>
> Max Chou (2):
>   target/riscv: rvv: Replace checking V by checking Zve32x
>   target/riscv: rvv: Modify minimum VLEN according to enabled vector
>     extensions

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c            |  2 +-
>  target/riscv/csr.c            |  3 ++-
>  target/riscv/machine.c        |  3 ++-
>  target/riscv/riscv-qmp-cmds.c |  2 +-
>  target/riscv/tcg/tcg-cpu.c    | 21 ++++++++++++++++++---
>  5 files changed, 24 insertions(+), 7 deletions(-)
>
> --
> 2.43.0
>
>

