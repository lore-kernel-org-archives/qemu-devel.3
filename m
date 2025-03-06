Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59859C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 05:22:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq3fj-0005qA-Q7; Thu, 06 Mar 2025 00:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq3fh-0005pb-Om; Thu, 06 Mar 2025 00:21:25 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tq3ff-00062n-S4; Thu, 06 Mar 2025 00:21:25 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-86718541914so1476900241.1; 
 Wed, 05 Mar 2025 21:21:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741238482; x=1741843282; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XwMC45l7s+mRqCpYaFcbCLnUSf4ocYw3adOBdyVO5QU=;
 b=UNZDcXg37/CQtaSYLCHcrr10xl5KCpM6F/wKbc9vrc1HE3WIT819SbWUuoioh1m4Xx
 kVbFEmbvM2BcXg3TDBAwv4FPE/torekJ2XEKAi7z9W9sHpkkaSWgHFIpmvXEwleYl4Kt
 8PlOQIbKHuKEnA3IDDGD3Fw50p2nRLEG3RFzLGEtIZ45WuIbjfoiQ2rEzXWGkmK/zppY
 7mDNF70SwMXuEogPR55tsjS9SW/pXmhptj03+hWPcSk8LBD6BFTvYOv6ZD5mZR7+RM+L
 8CeETNvSSgKdhIPXcv+dgTYMNLZFk2j+DTz4I/cshrSQwRPjGnmcwGeoC7alYW0jX8hL
 XuNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741238482; x=1741843282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XwMC45l7s+mRqCpYaFcbCLnUSf4ocYw3adOBdyVO5QU=;
 b=AJ6z0mAC7oqDT2/cIIPqv+1bXNYLoJQfPl2xTEu8V5GlUtAMBpd5ex04HdMucxK7dn
 7paeWV7DaYjBpOd7FIozMHEsUL8SUJwMvgQDIjNYSQHr0wgchJScJcb4J8+7wCO6o4cw
 tlAHSORnm6ez2TOXVX9rYUXUrfXx1l9Lze7wP2/eaPrXw84Jzw0nsmTXrOVyUiv2D3rs
 AL0JNDMqh27AmOhJL9X1Taytg/+EeKsWBMO6WmJ6JBEBd4WJ9IqIRCr0FQ4w7ApKR+Qk
 NGioETp+VTuHTLSVfAA+e/ivmEyezaN9GfEHIZF8DeuiTT+D7dmGj5+RxEGIQmL+upri
 BaBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgU1OE50cTEeK2LHNBPQt4kDQyDW3V9ATaA0fFkPMwNFHJjpRecOdkLPjEuSnQ207FPH2D2yanR4dx@nongnu.org
X-Gm-Message-State: AOJu0YxnVu+V/V7CYwReq97KVDRNSspCa+a2CGCf84HCLsQSNAy98eTl
 UgYUd6GvkouptkuAuk/X9q4Fa33icLbCMieruTaFINBCExedQOAUoqmA78lK65vJLfITbs8Yw3s
 59Ci3rxCrn0xPAa9mw2UaAKd9VHc=
X-Gm-Gg: ASbGncvGoOJplKeQF0xeJeAI9YGCmDmkIV20H6pnqP0LmGVq+/Aq+QVgKZpGHZdg3QK
 J98YcK3p94xcxyTIToMANZCU4mqxGYk42GmcS2M7mKTAczJKLp5qQ5dEKjPDI+QYjXTUyljcie5
 c0iKcf1Y6kxnYK+F+lZAPamCHAkG+5tp5ltsLiXy6XpiREhVBlRUu6XZT6
X-Google-Smtp-Source: AGHT+IHjGwxMakKF4a+1AyO0zOQuqz0oe8FI9qZdWYWoHt5QH5HGhX4OpPlHI6qHmNnEs8xVTSrcUpasVQj0WrpFzGg=
X-Received: by 2002:a05:6102:6f08:b0:4c2:fd52:c2c4 with SMTP id
 ada2fe7eead31-4c2fd52f020mr182039137.12.1741238481977; Wed, 05 Mar 2025
 21:21:21 -0800 (PST)
MIME-Version: 1.0
References: <20250218025446.2452254-1-debug@rivosinc.com>
In-Reply-To: <20250218025446.2452254-1-debug@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 6 Mar 2025 15:20:55 +1000
X-Gm-Features: AQ5f1Joj01MF5Q6-LncPeDpdfVjAnlX6b_uWZltOztvuL6yoo5euo0oLVlhcHM4
Message-ID: <CAKmqyKMrod154GEdDFajnBMh0gg2zFGWxXYA0+xF=xW42SgEjg@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/riscv: fix access permission checks for CSR_SSP
To: Deepak Gupta <debug@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 Adam Zabrocki <azabrocki@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
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

On Tue, Feb 18, 2025 at 12:56=E2=80=AFPM Deepak Gupta <debug@rivosinc.com> =
wrote:
>
> Commit:8205bc1 ("target/riscv: introduce ssp and enabling controls for
> zicfiss") introduced CSR_SSP but it mis-interpreted the spec on access
> to CSR_SSP in M-mode. Gated to CSR_SSP is not gated via `xSSE`. But
> rather rules clearly specified in section "2.2.4. Shadow Stack Pointer"

Do you mean "22.2.1. Shadow Stack Pointer (ssp) CSR access contr" in
the priv spec?

> of `zicfiss` specification. Thanks to Adam Zabrocki for bringing this
> to attention.

The thanks should probably be below the line

>
> Fixes: 8205bc127a83 ("target/riscv: introduce ssp and enabling controls
> for zicfiss"
>
> Reported-by: Adam Zabrocki <azabrocki@nvidia.com>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>

The actual change looks good:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index afb7544f07..75c661d2a1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -191,6 +191,11 @@ static RISCVException cfi_ss(CPURISCVState *env, int=
 csrno)
>          return RISCV_EXCP_ILLEGAL_INST;
>      }
>
> +    /* If ext implemented, M-mode always have access to SSP CSR */
> +    if (env->priv =3D=3D PRV_M) {
> +        return RISCV_EXCP_NONE;
> +    }
> +
>      /* if bcfi not active for current env, access to csr is illegal */
>      if (!cpu_get_bcfien(env)) {
>  #if !defined(CONFIG_USER_ONLY)
> --
> 2.34.1
>
>

