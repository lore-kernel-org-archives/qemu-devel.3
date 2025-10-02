Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EF6FCAC5BB
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 01:59:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v48Yv-0002za-8c; Wed, 01 Oct 2025 21:56:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48Ys-0002yo-GW
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:56:50 -0400
Received: from mail-ej1-x634.google.com ([2a00:1450:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1v48Yf-0002xZ-Ps
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 21:56:50 -0400
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b07d4d24d09so90082466b.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 18:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759370190; x=1759974990; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0WfcskIYXC100DlN5TCaJxzRAwsvbAfdx/HtpQj2MMA=;
 b=Io0POqKMpKDffrErSFEIEZjkKwki75NXPkRw4KmUWSnoHTnsUxJ0LMtK7q1hV0fhBM
 +4zdPFXwmCZsWQqMG0a9ORUHyQqg9H8w/rinTiE/RYb0Quv9GEC/Ldw+eQpGGK1abSFH
 PK1GfR7Q8Nz3wqXmSp1l2gGRGE5JFV8Kew2opX46oFuFYOZxrSu0+Y4FJhBJDLGhXFjU
 ZScXRmlovVzCDtxHESoWcHBieWnaRCXSABStvLcSTWH7o0DUv13IoaWL5XRkgHB0DabX
 h3WzeKg6s0JGF2/P8rcQc3PO/c3CBhuUyxDNsOKGLIOrUAiYk8H4OyaOzdxLwk22piCF
 zobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759370190; x=1759974990;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0WfcskIYXC100DlN5TCaJxzRAwsvbAfdx/HtpQj2MMA=;
 b=lHnWzYj1QAJtVOgX/aMaPweM3uxCl68WpilEQFExKqQYYRODnsdJfOms8Cie+E96zW
 IryUMRAz78LaIbpEAwN4cvcqoXXqyomfTBKH8ryOQ9QZ7HyWsdyNge5V2vtZyt/9e2s5
 9xsD673ct42uneCppoidrVxA+govCrZuR5cniia6UOWRsR3eCouSl/LkvYpvVcXnrKKK
 y5QE/B7yzgXqYNBuo1pFjGnkCnSy45Lca9z5OYErwPCFDmO6JK8y6sB/vDnh/A/12T6U
 9czPOS+dghzEvnkvZOH6ivw0YT7CpEm7GgRK2YYgS95xZdcuBQgVo2dNBJaIZpER3o69
 C/zw==
X-Gm-Message-State: AOJu0YxtU3P9g0y4jUZcyOEpECN+j/Y5yDgpIiDvOWL4pkjgoLnZLpmJ
 9948HxPXIMGRyJeGv6Fmfs8nLhE0rJ/+ulGdr1x/t2lvTcFVuxi3MPNbLE99JTLRm+Iir/ZQpTp
 +hxdfNRGhyBoGFysY3GMPN0qJGuIxFpo=
X-Gm-Gg: ASbGncvgZGLONRGBb/VmI0GMoXloX2DIBg41oyPPwTcsnPdyWZjiugedFlMzV4yZl99
 +6d3gEKudTq3HYzIuBPACVo6/6t16DvxLOnq9rkEAbanh4XRAhaiNv1KCvyUYGhawRnQgfs/bwq
 +Im5b6AsKQtBmyks7XXqNO1hPTaI4rqvxKdC0BRKu1hdnbu/XiG0D35dv83x15SJvjzsBFRxmOF
 26WailnXCib4DMHw7XuFT17iTDsYfC8uQjylZjblBPYbScCCjZeBgy+3i64fA==
X-Google-Smtp-Source: AGHT+IErQ5in6roFUcyiLjL9hL37KTmTLxWHsMEoQo64EaOGa22O7JyUSqfzCYL7EgwuNNJECjjItiJcTb7YkWy0040=
X-Received: by 2002:a17:907:3cca:b0:b1d:285d:185d with SMTP id
 a640c23a62f3a-b46df914473mr634730766b.0.1759370189578; Wed, 01 Oct 2025
 18:56:29 -0700 (PDT)
MIME-Version: 1.0
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-2-anjo@rev.ng>
In-Reply-To: <20251001073306.28573-2-anjo@rev.ng>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 2 Oct 2025 11:56:03 +1000
X-Gm-Features: AS18NWAnxpsa779Yk2MQ0AkWzMoOCFGyowGb9mXAiz7g3vaJ8hh4KZVz6O6nxJc
Message-ID: <CAKmqyKPJfdN1Hj379P3VFdt-XxftnRSAqVYNS0kCaOS1=bpEHw@mail.gmail.com>
Subject: Re: [PATCH v2 01/33] target/riscv: Use 32 bits for misa extensions
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org, philmd@linaro.org, 
 richard.henderson@linaro.org, alistair.francis@wdc.com, palmer@dabbelt.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::634;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x634.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, Oct 1, 2025 at 5:33=E2=80=AFPM Anton Johansson via
<qemu-devel@nongnu.org> wrote:
>
> uint32_t is already in use in most places storing misa extensions such
> as CPUArchState::misa_exts, RISCVCPUProfile::misa_exts,
> RISCVImpliedExtsRule::implied_misa_exts.  Additionally. the field is
> already migrated as uint32_t.
>
> Signed-off-by: Anton Johansson <anjo@rev.ng>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 4a862da615..f05e06bb70 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -50,7 +50,7 @@ typedef struct CPUArchState CPURISCVState;
>   */
>  #define RISCV_UW2_ALWAYS_STORE_AMO 1
>
> -#define RV(x) ((target_ulong)1 << (x - 'A'))
> +#define RV(x) BIT(x - 'A')
>
>  /*
>   * Update misa_bits[], misa_ext_info_arr[] and misa_ext_cfgs[]
> @@ -582,7 +582,7 @@ struct RISCVCPUClass {
>      RISCVCPUDef *def;
>  };
>
> -static inline int riscv_has_ext(CPURISCVState *env, target_ulong ext)
> +static inline int riscv_has_ext(CPURISCVState *env, uint32_t ext)
>  {
>      return (env->misa_ext & ext) !=3D 0;
>  }
> --
> 2.51.0
>
>

