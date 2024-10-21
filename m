Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F020D3C934
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 01:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2h3o-0005Ht-RH; Sun, 20 Oct 2024 21:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h3n-0005Hg-7u; Sun, 20 Oct 2024 21:18:15 -0400
Received: from mail-vs1-xe30.google.com ([2607:f8b0:4864:20::e30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1t2h3l-00054k-Qu; Sun, 20 Oct 2024 21:18:15 -0400
Received: by mail-vs1-xe30.google.com with SMTP id
 ada2fe7eead31-4a47240d31aso918442137.3; 
 Sun, 20 Oct 2024 18:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729473492; x=1730078292; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ujWRKNiFsHe9bXMP6bid7jJhiedcxpq6ZAGBZrUbVLc=;
 b=nXOk+x6cf4JiUYXm/ogMEZ5CDfwJJpNLl32zAVu98k3ax2xhAhIkjDE9Tt+ctjKGSi
 ecna2+F9aejqN+86g6a7FBTsl+2G6iZkAqLXwRXyL364qeqWJHQc0LkWTfC/JetKHmCi
 4/LhktLftXCsHuWFfKW6xVAUdeawmlz8RpYI2Zu8NcwgptVZerF/2Gujy3YpcnJpKvSE
 CIAsiUaB5D9XWorr7ffTKS7IzE7KYDYkDlyH1b4uHpAnQChrS7+zyr4Ii15VT2wIhc7a
 cjFRlXAygsp2v/lvd3BSvo8HPG9VvzJpt/f/1M5VPMZuN0jZk+qV7lqT2cZK0Sg35UbH
 YAqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729473492; x=1730078292;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ujWRKNiFsHe9bXMP6bid7jJhiedcxpq6ZAGBZrUbVLc=;
 b=i5zkKEAYIFHcEHJbItAzCT4IfOFJl9x3R3jOu29jAJEjEvkvTzlRV40wb/bytUNCha
 DDiiL1DkoskiQ+NtOTwUiahJks2QAw+SGQWDVmQ6E405wXYgJ0sOaNg49OxqKL21fOxa
 HSReT6PREucWFC4cc6U9Z1SVob4ZergxnBMM+ftl2exHQRHZQY9SPqtxFGqAx/62DDFn
 15myUrtckauSfQe5jkFDia+3Dnjn98W58fppL8/rKlT0UwemgzF01d+jnij1PKnc54lK
 hErgG5slANCuYWB8IiXMHffh+ByGEdrHIkr7lg9OS53VlpTh/pM4srmtxlGqpAWXMXN1
 4e/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV6KLQz9IbhokxgEl8q7m5vmZy79Ax37UmyqvzM6DSEtztqT4WTFn5LgUEx+sxSM5H2yn7skumKrcy@nongnu.org
X-Gm-Message-State: AOJu0YymbK57jC9HSvDlGiBhEzCEyCkW768ZNebev5VmmHC7POOzlpxg
 D0B1HCDnOXT27YvRxWRF6DV4YhwIWLJG7ygZsAxUBUNBRwAjjnTIRt8KzCdyLCrmAw6jw/TUGD/
 iSZQrq8XB3QX8sKM71sK3nMCNpkA=
X-Google-Smtp-Source: AGHT+IGtbOQhhOc2h3UB8283Fs616HptgE+8aGzGPo8MyfGnqUp15TlFEbgPpV55adA6GL2+zOMuoVxakUeK0U42SPg=
X-Received: by 2002:a05:6102:3753:b0:4a4:8756:d8bc with SMTP id
 ada2fe7eead31-4a5d6ba8e48mr6896167137.23.1729473492510; Sun, 20 Oct 2024
 18:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20241016193140.2206352-1-richard.henderson@linaro.org>
 <20241016193140.2206352-3-richard.henderson@linaro.org>
In-Reply-To: <20241016193140.2206352-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 21 Oct 2024 11:17:46 +1000
Message-ID: <CAKmqyKNz_GAOZfRUatWMJGTVzS0tM=JX+81V4-Bhq88ipGgQLA@mail.gmail.com>
Subject: Re: [PATCH v6 02/14] disas/riscv: Fix vsetivli disassembly
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e30;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe30.google.com
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

On Thu, Oct 17, 2024 at 5:35=E2=80=AFAM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> The first immediate field is unsigned, whereas operand_vimm
> extracts a signed value.  There is no need to mask the result
> with 'u'; just print the immediate with 'i'.
>
> Fixes: 07f4964d178 ("disas/riscv.c: rvv: Add disas support for vector ins=
tructions")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  disas/riscv.h | 2 +-
>  disas/riscv.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/disas/riscv.h b/disas/riscv.h
> index 16a08e4895..0d1f89ce8a 100644
> --- a/disas/riscv.h
> +++ b/disas/riscv.h
> @@ -290,7 +290,7 @@ enum {
>  #define rv_fmt_fd_vs2                 "O\t3,F"
>  #define rv_fmt_vd_vm                  "O\tDm"
>  #define rv_fmt_vsetvli                "O\t0,1,v"
> -#define rv_fmt_vsetivli               "O\t0,u,v"
> +#define rv_fmt_vsetivli               "O\t0,i,v"
>  #define rv_fmt_rs1_rs2_zce_ldst       "O\t2,i(1)"
>  #define rv_fmt_push_rlist             "O\tx,-i"
>  #define rv_fmt_pop_rlist              "O\tx,i"
> diff --git a/disas/riscv.c b/disas/riscv.c
> index 5965574d87..fc0331b90b 100644
> --- a/disas/riscv.c
> +++ b/disas/riscv.c
> @@ -4808,7 +4808,7 @@ static void decode_inst_operands(rv_decode *dec, rv=
_isa isa)
>          break;
>      case rv_codec_vsetivli:
>          dec->rd =3D operand_rd(inst);
> -        dec->imm =3D operand_vimm(inst);
> +        dec->imm =3D extract32(inst, 15, 5);
>          dec->vzimm =3D operand_vzimm10(inst);
>          break;
>      case rv_codec_zcb_lb:
> --
> 2.43.0
>
>

