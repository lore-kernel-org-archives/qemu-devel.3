Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18241CCF9F0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 03:00:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEfME-0007gc-9k; Thu, 30 Oct 2025 22:59:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfM7-0007eF-VV
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:59:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vEfLv-00045z-G0
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 22:59:11 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-63e0cec110eso3129412a12.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 19:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761879536; x=1762484336; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+WPjsRmsCZH7uQtounKoJzfYvwSVlbzzbXG23VJtM7c=;
 b=RVOOrhTZ91oTB2j6aNsS8GlSsL2O6hVf/E5hGVs3f1A0N+rmWA8NpYlwCzaLav0OI4
 1WqbLRW79Zv1jlUKMhekTwYqhIFkcU9dNBKFTUn9645bgvaYNM/J576tGK8gfc4zDJjf
 uTEopL3oKZfJXELm0PRrKiiIKAqSDZP7AGmkMp3mrbnFjPQn7Ised0tmgVFa2yNETRx8
 BMKLYAqXSzr4Cv8abnbEk4hIhxUaBS2olT4/htHEgTgs24bF0eptFNV5Vu05SG5stoqG
 1qCsoghz2RbGcnu20ZkbhtMFY60W3FEvH8wdyDDaU6pSsYOXNx0dW+bRdmgst/8pRlpM
 96UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761879536; x=1762484336;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+WPjsRmsCZH7uQtounKoJzfYvwSVlbzzbXG23VJtM7c=;
 b=bc5mUN8b910wpzQdx6rA+PLRoOK/lLjGdKxzqrhhwC3FWUXVT8VRDsT9DEUordun47
 43Olz81OVkD/Aq0s72KbH1pDtJDNq9ypP195w3bZLxlTTyX3CRk7MXD8XQSPA6XBOkxU
 BCov4vEqvVZ+hbm7Kwg61eB6xhyOm6ESdiDdIvdAywhAiLqa9Dxk6fh2DF5HUTJDGMkB
 5O0WtgDGjfWoahmw7cL3GAfl3CEwRK+DMSfVoR7I/3Y6jU505PKnWpwN5VFuSoGX0u1Z
 /VopjIvQ6FiiGxOPI11pVBDvdwct3JqikGrZ24eBqcLgzWMWbpbKEinqcqtUx5nmFskO
 BzEw==
X-Gm-Message-State: AOJu0YzkGWfTVSCPURrop/aPEYDEMG+HqEJwFjHS6DqEcBW7eCYvjJfM
 M39pSKUPRek1c1Ky8lbK9nsAqzgPArpD8FGU0kulFH9l8Few41hFL4B7YVl6+i7y61UKtczaf8A
 1sdq5uHVbLXIlFfs2D/NTRoN9VcNjfzk=
X-Gm-Gg: ASbGncvPv3Q5K5K2ZCirViyIV/Ykc0SuDTDxCsq6DJzkA02pOx7YnLpz1/L11fnplWq
 oQCJCibETHPlQ6TKG2Fy42tEkEsZVbLC9mq8ga5TbjXiPxlt/ewq0BP8S0US/FWwk1vyQapDTlL
 05haXwpVV1Z3Rz0JQ51CPuN14sN32lQS4wgKv5tmq9udb9ijF6OLEeQd14WmFW1q852GjALuWT7
 809KO2hDTA70VWeC5daFt2Lu2dPG6b6xHeaxN72Kgi7IhM5dXQ2A+m4FGRxH1DHeg02FAatSFte
 VBZbKqUukAnBJQs=
X-Google-Smtp-Source: AGHT+IE5ruP1wUs9Mu+2cSoVgsDrDVWPt4Mtid+2xqvKR/5U/5QryyJdHi7u+xSIa4LG8DOZKkShDXoyNqOrsJIZeto=
X-Received: by 2002:a05:6402:146b:b0:63c:6ddd:fe59 with SMTP id
 4fb4d7f45d1cf-64076f74f94mr1497011a12.16.1761879536161; Thu, 30 Oct 2025
 19:58:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250623172119.997166-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250623172119.997166-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Oct 2025 12:58:28 +1000
X-Gm-Features: AWmQ_bntAf_A46q3xxkDBdzRDnJSe6QzDcuvEUiMIOwrREl9wlkKy2Fm5LP6X9U
Message-ID: <CAKmqyKN6vioC9Sryh5QcehX75hhzZ-B5-Xd8b6uNdpSyKRQy1Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] riscv: add all available CSRs to 'info registers'
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x536.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jun 24, 2025 at 3:22=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Hi,
>
> The output of HMP 'info registers', implemented by the cpu_dump_state
> callback, returns way less CSRs than what we have available in the
> default rv64 CPU with default options.
>
> This series changes the callback to add all available non-vector CSRs
> when issuing 'info registers'. The vector CSRs are being handled by
> another patch [1].
>
> Patches based on alistair/riscv-to-apply.next.
>
> [1] https://lore.kernel.org/qemu-riscv/20250623145306.991562-1-dbarboza@v=
entanamicro.com/
>
>
> Daniel Henrique Barboza (3):
>   target/riscv/cpu: add riscv_dump_csr() helper
>   target/riscv/cpu: print all FPU CSRs in riscv_cpu_dump_state()
>   target/riscv: print all available CSRs in riscv_cpu_dump_state()

Thanks!

Applied to riscv-to-apply.next

Alistair

>
>  target/riscv/cpu.c | 107 +++++++++++++++++----------------------------
>  target/riscv/cpu.h |   2 +
>  target/riscv/csr.c |  18 ++++++++
>  3 files changed, 61 insertions(+), 66 deletions(-)
>
> --
> 2.49.0
>
>

