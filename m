Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DC5C0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:25:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwox-0004MG-Aj; Tue, 28 Jan 2025 20:24:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwou-0004LK-Mm; Tue, 28 Jan 2025 20:24:44 -0500
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwot-0000nT-9o; Tue, 28 Jan 2025 20:24:44 -0500
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4b6398d477fso1869434137.0; 
 Tue, 28 Jan 2025 17:24:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738113881; x=1738718681; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8L3K9YIE3Jsq9qSbVfMRemus9lKR6FaCE1NxAPfGAO8=;
 b=cUBPsPBXCuJJldKf4flQZsVfXN9n7GuEcA7Dpohs1mO1pjAQKcSlWWSlcMleuyS4Vz
 af9ZAGfZ8fGUAg65XspTq86B8aF6GdmqlUlOrvZRugct8AOUgZ2OVTHaWD4JGZT04OiQ
 kbC7zie8kMViQS1Za5Go37vVnfP2sZdsbSTdiI+M9eug8jWTZbzCteeH3Hy27XnDORIO
 /pGXSTZCL21TLIoZfMockgO/xOtNZrvuCrAcnwpKgZBbqgqjZbcrSx7hnUav4jWz/8mb
 kAiWS4Gh6y6jWR32nV6InTk+3KIPdqXC443Pj4Z56i6oL/dl/DotwKmfsBsjFQN/qc4p
 BIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738113881; x=1738718681;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8L3K9YIE3Jsq9qSbVfMRemus9lKR6FaCE1NxAPfGAO8=;
 b=fcV4i/1WxIFAUol+UobInIDh2pOiPM9OnlPtuD0jYTJvNVNQgK1gn64i86ABEIkUgo
 lYyjYU7/Rhs4ouN/ZFHxMG8C94rwYdTeQqdIHgHOozT5sXEbNJEb/0uTTEB//gpZNVxP
 p50xZwH0cfioYvLdXx8gcAsYK+ESz+gJqMduRyt9OcZVTriHh9UmR65ep1kRANbmPIgH
 9bOGpHoRBTvPsq7+1DeHkfgBjtHfgPoQA6SAFCzSgNe78wrVCEqfn+FAIRbqe9KwpdA3
 rkzeNOb8Zf5RJFmTWGAcKkrMOCn+PUPpdqtoHLqPokITAp1pC+ncjfbemkhDAONc1XvI
 LaSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKQZoV7SvhZFrmTueoFeWOjZx7cdeAa2S+S4PPYEyPNypx0rs0L3fGARbUtBqQa/GlNLic3zUFXZrN@nongnu.org,
 AJvYcCVwZ2l5PmHp/gFdl1tUGkZFkBTboGgCA+jRsbRG+IYRzO3r+ot7/EJ2NhJZYKua8FldDngU3YmsyWmv6w==@nongnu.org
X-Gm-Message-State: AOJu0YyeHUBeiF35XU3iypj2PSUEqZVEBsFzxqm782g/96mKR/h7w1Ho
 GPCFnovDrgYQ6iVTyzkfAQsPCxDfp6AJShJC93YlAEMmMOPdXTl4AnsjezTr92hPykN9fx4fXih
 ZqhATKv/w7B37Jje2+l/PEx6kiUg=
X-Gm-Gg: ASbGncsB1E3gr8m/w4Pc+aylvguv+e3gXRq+pylV9Z5YHXdm1M+qQmKla9BIXfVeOL2
 zDcK/K/9CwvQ/mDAbIEz17swy4O+FM7bAz+D4zbOzHWRBptjZH6vVwNuEVTZSy9WYpEM1nh7M8H
 ukGC/trjNP+6hAUwuF8QX/ipgl4A==
X-Google-Smtp-Source: AGHT+IGTpO8ZHs2whCWJS6SAOXujPzEm/BpVD5CsgTVZkyqV+E5FwAHUeYgEr6sGK+FikHhKRuv9jEN98UNjjrZ5IqI=
X-Received: by 2002:a05:6102:3581:b0:4b1:1abe:6131 with SMTP id
 ada2fe7eead31-4b9a525c407mr1180890137.25.1738113880998; Tue, 28 Jan 2025
 17:24:40 -0800 (PST)
MIME-Version: 1.0
References: <20250114092012.29024-1-evgenii.prokopiev@syntacore.com>
In-Reply-To: <20250114092012.29024-1-evgenii.prokopiev@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:24:15 +1000
X-Gm-Features: AWEUYZmfuqI9VDdI9ajN7q-8zlHcoP_p11UkyDXQlhozyaEmS598DyymqMqEiYU
Message-ID: <CAKmqyKMbBF9OS36ptWAuFtkaJCsq5NTLmgrY6nmQDpv0s_AK8w@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c: Turn off mstatus.vs when misa.v is
 turned off
To: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, Jan 14, 2025 at 7:33=E2=80=AFPM Evgenii Prokopiev
<evgenii.prokopiev@syntacore.com> wrote:
>
> A behavior of misa.v must be similar as misa.f.
> So when this bit's field is turned off, mstatus.vs must be turned off
> too. It follows from the privileged manual of RISC-V, paragraph 3.1.1.
> "Machine ISA (misa) Register".
>
> Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index eab8e50012..fca2b1b40f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1537,6 +1537,10 @@ static RISCVException write_misa(CPURISCVState *en=
v, int csrno,
>          env->mstatus &=3D ~MSTATUS_FS;
>      }
>
> +    if (!(env->misa_ext & RVV)) {
> +        env->mstatus &=3D ~MSTATUS_VS;
> +    }
> +
>      /* flush translation cache */
>      tb_flush(env_cpu(env));
>      env->xl =3D riscv_cpu_mxl(env);
> --
> 2.34.1
>
>
>

